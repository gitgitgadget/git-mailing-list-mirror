Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B1681F406
	for <e@80x24.org>; Fri, 11 May 2018 05:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeEKFgU (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 01:36:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50358 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbeEKFgS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 01:36:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id t11-v6so821709wmt.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 22:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rVUBORWM8tzjKzojM3g1IquT9hze9rfH1ko6iAtzmGQ=;
        b=hqElSkZT28hn1FGASyU9vPjD8sqwJSsy3c1p1aHZtb3B1oeG4y7sNEtl8Xz/wQDch2
         mRkn24vejQdFjR1xiduSG9bgqG6nxDGIvDcCaXLxCm+Uc2ypnVDiZ6DEMEYDhVato7DM
         aDf7C3yMeH7e/xoeHu/wPI75oOsR02vwARooE7+nDy/LJwBHldiGS37acwCXzzwDiRzk
         jDmAFHGMrThkEHibHBUNdKdpqVaXnNLT/Ajc+IZfCJ4EN0tTnZxnXBITvQWhBFTSPq41
         16cR45ZsduAqqga1MOEuCRL85qtOb9snzyMJSNrE0zSBCJlCPNSR3igr8/BZgIeZDpWW
         2nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rVUBORWM8tzjKzojM3g1IquT9hze9rfH1ko6iAtzmGQ=;
        b=PMaTh08yWe5+L0sRBjFGk1fttZbTK4+tZjWrFFWYFuwGM422OkXxMPX9358uMgYQNE
         nAsKeHCazTLsFL4GAcCTNR8RdKjgjOU0/5HlIx+00CuKw2cojagtjZkcb/HS4bje5aDL
         GCsG1iN0OyKMLzdxHGRTidUKEwrX+SvHb/RitbsldB9slWam5NqSs2+IZ3U6+R0KbVX1
         1hCP/Gzz+I/6KIfeeFmXuwNp7Q0cH1ps4TgutVWgNfJNEWD0v2abOfV5XK43b95pVSw3
         xRlcwI5EGBhI1ao/R7hzNalnFZmvq/s0fbQLVkJVmpeOTGQZRd+PzHLri7QiYwNMrWUu
         L3vQ==
X-Gm-Message-State: ALKqPwcJWZXuttZ+ggxzu3ULPyUjINKHgUPIR4TmAW/ynFK+asqRqz0+
        rM0gHmqjW34vvyL4UikFTCY=
X-Google-Smtp-Source: AB8JxZpMXnV6V5ID0u2iJnlnVLH5Y3DIDOx7G568tJGZJT4rKIvH9stl3f+7gpCS214idImr5l/KDg==
X-Received: by 2002:a1c:8983:: with SMTP id l125-v6mr852345wmd.30.1526016977176;
        Thu, 10 May 2018 22:36:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o53-v6sm4922820wrc.96.2018.05.10.22.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 22:36:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 5/6] get_short_oid: sort ambiguous objects by type, then SHA-1
References: <20180510124303.6020-1-avarab@gmail.com>
        <20180501184016.15061-10-avarab@gmail.com>
        <20180510124303.6020-6-avarab@gmail.com>
Date:   Fri, 11 May 2018 14:36:14 +0900
In-Reply-To: <20180510124303.6020-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 10 May 2018 12:43:02 +0000")
Message-ID: <xmqq36yyhhyp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/sha1-name.c b/sha1-name.c
> index 9d7bbd3e96..46d8b1afa6 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -409,6 +437,8 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
>  	status = finish_object_disambiguation(&ds, oid);
>  
>  	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
> +		struct oid_array collect = OID_ARRAY_INIT;
> +
>  		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
>  
>  		/*
> @@ -421,7 +451,12 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
>  			ds.fn = NULL;
>  
>  		advise(_("The candidates are:"));
> -		for_each_abbrev(ds.hex_pfx, show_ambiguous_object, &ds);

So we used to let for_each_abbrev() to enumerate these object names
that share the prefix in the object name order and fed
show_ambiguous_object() to show them, which was the cause of the
output that is not grouped by type.  Now you collect them into
another oid_array and sort by type, relying on the fact to that the
for_each_abbrev() in the "collect" phase already does the de-duping.

Sounds good.

> +		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
> +		QSORT(collect.oid, collect.nr, sort_ambiguous);
> +
> +		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
> +			BUG("show_ambiguous_object shouldn't return non-zero");
> +		oid_array_clear(&collect);
>  	}


> diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
> index 711704ba5a..2701462041 100755
> --- a/t/t1512-rev-parse-disambiguation.sh
> +++ b/t/t1512-rev-parse-disambiguation.sh
> @@ -361,4 +361,25 @@ test_expect_success 'core.disambiguate does not override context' '
>  		git -c core.disambiguate=committish rev-parse $sha1^{tree}
>  '
>  
> +test_expect_success C_LOCALE_OUTPUT 'ambiguous commits are printed by type first, then hash order' '
> +	test_must_fail git rev-parse 0000 2>stderr &&
> +	grep ^hint: stderr >hints &&
> +	grep 0000 hints >objects &&
> +	cat >expected <<-\EOF &&
> +	tag
> +	commit
> +	tree
> +	blob
> +	EOF
> +	awk "{print \$3}" <objects >objects.types &&
> +	uniq <objects.types >objects.types.uniq &&

Eww, that is somewhat tricky (but correct) use of "uniq", which
POSIX not just mandates adjacent duplicates to be removed, but also
forbids from removing duplicates that are not adjacent from each
other.  So the objects in the "hints" file are not grouped by type,
we will fail to see these four lines.

> +	test_cmp expected objects.types.uniq &&
> +	for type in tag commit tree blob
> +	do
> +		grep $type objects >$type.objects &&
> +		sort $type.objects >$type.objects.sorted &&
> +		test_cmp $type.objects.sorted $type.objects

We not only want to see objects grouped by type (and types shown in
a desired order), but within the same type we want them ordered by
object name.

OK.

> +	done
> +'
> +
>  test_done
