Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02A61F597
	for <e@80x24.org>; Fri, 27 Jul 2018 21:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389459AbeG0WcU (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 18:32:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55003 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389211AbeG0WcU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 18:32:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so6582568wmb.4
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 14:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=G6FhFNM/IDqd1EYCj2b9dmee1OX66p8edPG/az/NGEk=;
        b=EUc3wwVhxROu6UeenSAKfa2IgJRYvGCT6JJ+gvF3j1Gtimatc3fr0XvkU1j3oG/LOq
         hF9VW9DoVu0HgRQIc8ivqOfFJBFatewq5x2RY/UWqYkyB21iKX9HPGKD1+81oYuwhjo/
         Ncy4RIKFIpV3Ib5OWwn8InOVYlEmB102tK6CT4XsenMDwSQYm1bud6z9D+XQOy5LjUj7
         gXybHsc08mEFaOVco1ATdK+o93LruKxiSGj/RxFrKASMBiUwpwY+DnSRB5jJOiNJpCVH
         GF8a0dd7ujPaFvy3fT4vzSYRJL5+Qx/ixkrur4n0CvoMGJgn5Au6seTVPXVqWUPkwuNO
         8eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=G6FhFNM/IDqd1EYCj2b9dmee1OX66p8edPG/az/NGEk=;
        b=XgcL+YvB9fKZQBvi8kSjDkovT9yyzvdQh2W/+mzhd8UzyK3ymYqTLaSKnCXFiqo4+K
         HXokA1WeZhkhI49HO6VouQ5Dw5A41cZ9B2B4R5rDN9zLrkMOBwuhDt08mLKTPxkJwjPw
         Pej43sDXExN0n0rty20loqua5oFC8eJ+d+dY5MFwqtOdJ1yplFoot4WCUxa5biltJN77
         2D5G7PJNvszGIG+WaFEg/BeffWyP0W+dCXx2HuN1JigmnHjfYj/o19VFYDTLKBSlFOV1
         UYjeQJTpJfJNvQoGnzfwfLJp4NbllPkXqaj7bqLlLFkGzI6IMQPn3Glg5G1THvoKeaTA
         TR7w==
X-Gm-Message-State: AOUpUlEKnrVtCXL7XlHEotb4RQ2U5f281sHsbVZ2KG+tAoh+cVbIbOa/
        pUn51mVMBQt3ysLk2YtMSFA=
X-Google-Smtp-Source: AAOMgpePIbP9evy8IHfAA0ZA09xOOyzW7vLqHlaF4Oto2wmaw4m6xp7FHPFEjnjj3ohYonIcp7pe9A==
X-Received: by 2002:a1c:700a:: with SMTP id l10-v6mr5747164wmc.90.1532725718598;
        Fri, 27 Jul 2018 14:08:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w62-v6sm5904442wmg.46.2018.07.27.14.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 14:08:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 07/10] fetch: implement fetch.fsck.*
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180727143720.14948-8-avarab@gmail.com>
Date:   Fri, 27 Jul 2018 14:08:37 -0700
In-Reply-To: <20180727143720.14948-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 27 Jul 2018 14:37:17 +0000")
Message-ID: <xmqqva90l73e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> -			argv_array_push(&cmd.args, "--strict");
> +			argv_array_pushf(&cmd.args, "--strict%s",
> +					 fsck_msg_types.buf);
> ...
> +		if (git_config_pathname(&path, var, value))
> +			return 1;
> +		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
> +			fsck_msg_types.len ? ',' : '=', path);
> ...
> +		if (is_valid_msg_type(var, value))
> +			strbuf_addf(&fsck_msg_types, "%c%s=%s",
> +				fsck_msg_types.len ? ',' : '=', var, value);
> +		else
> +			warning("Skipping unknown msg id '%s'", var);

This follows quite familiar pattern found in receive_pack_config();
looking good.

> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
> index 57ff78c201..004bfebe98 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -145,6 +145,20 @@ test_expect_success 'push with receive.fsck.skipList' '
>  	git push --porcelain dst bogus
>  '
>  
> +test_expect_success 'fetch with fetch.fsck.skipList' '
> +	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
> +	refspec=refs/heads/bogus:refs/heads/bogus &&
> +	git push . $commit:refs/heads/bogus &&

I see this used in the previous test for receive.fsck.skipList, but
it is an interesting implementation of "git update-ref" that could
be affected by potential fsck error in push-to-receive-pack transport.
As we are interested in transport into "dst" and we want this creation
of our 'bogus' branch to succeed no matter what, it probably is not
a good idea to use "git push ." like this in the context of this test.

Perhaps leave a 'leftoverbits' comment to force us remember to update
all these uses of local push from the script in the future?

> +	rm -rf dst &&
> +	git init dst &&
> +	git --git-dir=dst/.git config fetch.fsckObjects true &&
> +	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&

We see that by default fetch.fsckObjects errors out when it notices
the bogus commit object.

> +	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/SKIP &&
> +	echo $commit >dst/.git/SKIP &&

And then we set up a skip to see ...

> +	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec

... if that is ignored.  Looks great.

Would this second attempt succeed _without_ the SKIP list, I wonder,
though?  

After the initial attempt that transferred the object, inspected it
and then aborted before pointing a ref to make the object reachable,
wouldn't it be possible for the quickfetch codepath to say "ah, we
locally have that object, so let's see it is a descendant of the tip
of one of our refs *and* all the objects it points at (recursively)
are all available in this repository", as we do not quarantine on
the fetch side?
