Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EBBA1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 22:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeDHWQv (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 18:16:51 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:39686 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeDHWQu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 18:16:50 -0400
Received: by mail-wr0-f179.google.com with SMTP id c24so6896315wrc.6
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 15:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q76mxxekbGNCrU2JQmfYy44XPVq0RkTMp80qSd8zfo4=;
        b=WMvo/Lm582g83Gfz+Dr75/lhinDnFzyenksBjmEpFB7SB3JJer1ehi0hqM3ZhRV4Kk
         6cZxIMIWB3q+qvr/Co1fDdj34tA6A61h4A7wOvpkj0y7LLUZVNUK/SoD90MQJ3NE6mMN
         SseR3X4VeWqGmites7pHbZk3bjSfIuTy8s/I7sxBX+k8t4/xT+NTvmpQr7cUxxZxCMpT
         XqbU+velwGbTLyazJ+vl//Hdql9Fmep6Cl+WY1NM7NUdkrs4EmnDdEx6M07qYYbcer01
         k8bsaxRXSHIQEK1KXt+n0d/LKQO/0PvOHaFbpyFc9HNJ0SiGGNh2cGx6NN6rjIM0dn+t
         zS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q76mxxekbGNCrU2JQmfYy44XPVq0RkTMp80qSd8zfo4=;
        b=gDIDUlflbilZWXaNmvWbAOTQ8aJKjJo/D/YlNr9nBS9q/s0jHfxqNeruUdT2lXcC9O
         PVTzoO+TrAgbcSdiXp9HZv7hEZoPZ+Swq2ews3/PclF1VMIr2VCSCjaeSIxS7eU4YbaR
         kUntLpS94vh44mLEujbF7FzMZml74R1tCSThIB/smg7H33fm9QHPfChXkT/OIC2LI+QR
         hrj7xeY902YY3UeAwft/AXABVwGeZvyDK+EGuzMxlGPurrMCEiG2VblfUM+dreIryjZn
         C0cc6kA0m4Cnu6p6yI7geWyGdufaV+mnsvD3wCdfEm4il4OsD0x4vrqA1TaeVxAKILBs
         3taw==
X-Gm-Message-State: AElRT7FvrPXhidms7FmD8/ZLGxNqRknDGCDWdYJKoaq/IfcP4qmOzW2P
        pik5kq0ul7Cuk6/tFAVj90m19Wgx
X-Google-Smtp-Source: AIpwx48fW+51KHD9855HbL2FK1ThvaMS6uyj5k+RzLmkNH7hPdPjim+GAelx3ycBWgTwInv/cl1wbg==
X-Received: by 10.223.171.213 with SMTP id s79mr22829877wrc.52.1523225809206;
        Sun, 08 Apr 2018 15:16:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o23sm26260374wrf.93.2018.04.08.15.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 15:16:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: Re: [PATCH v12 4/4] ls-remote: create '--sort' option
References: <20180408122832.65414-1-haraldnordgren@gmail.com>
        <20180402005248.52418-1-haraldnordgren@gmail.com>
        <20180408122832.65414-4-haraldnordgren@gmail.com>
Date:   Mon, 09 Apr 2018 07:16:47 +0900
In-Reply-To: <20180408122832.65414-4-haraldnordgren@gmail.com> (Harald
        Nordgren's message of "Sun, 8 Apr 2018 14:28:32 +0200")
Message-ID: <xmqq7eph9wds.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Harald Nordgren <haraldnordgren@gmail.com> writes:

> +--sort=<key>::
> +	Sort based on the key given. Prefix `-` to sort in descending order
> +	of the value. Supports "version:refname" or "v:refname" (tag names
> +	are treated as versions). The "version:refname" sort order can also
> +	be affected by the "versionsort.suffix" configuration variable.
> +	See linkgit:git-for-each-ref[1] for more sort options, but be aware
> +	that because `ls-remote` deals only with remotes, any key like
> +	`committerdate` that requires access to the object itself will
> +	cause a failure.

I can connect "because it deals only with remotes" and "access to
the object may fail", but I wonder if we can clarify the former a
bit better to make it easier to understand for those who are not yet
familiar with Git.  

    Keys like `committerdate` that require access to the object will
    not work [***HOW??? Do we get a segfault or something???***] for
    refs whose objects have not yet been fetched from the remote.

I added "for refs whose objects have not yet been fetched", whose
explicit-ness made "will not work" to be an OK expression, but
without it I would have suggested to rephrase it to "may not work".

This is a tangent but I suspect that the description of --sort in
git-for-each-ref documentation is wrong on the use of multiple
options, or I am misreading parse_opt_ref_sorting(), which I think
appends later keys to the end of the list, and compare_refs() which
I think yields results when an earlier key in the last decides two
are not equal and ignores the later keys.  The commit that added the
description was c0f6dc9b ("git-for-each-ref.txt: minor
improvements", 2008-06-05), and I think even back then the code in
builtin-for-each-ref.c appended later keys at the end, and it seems
nobody complained, so it is possible I am not reading the code right
before fully adjusting to timezone change ;-)

> +	for (i = 0; i < ref_array.nr; i++) {
> +		const struct ref_array_item *ref = ref_array.items[i];
>  		if (show_symref_target && ref->symref)
> -			printf("ref: %s\t%s\n", ref->symref, ref->name);
> -		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
> +			printf("ref: %s\t%s\n", ref->symref, ref->refname);
> +		printf("%s\t%s\n", oid_to_hex(&ref->objectname), ref->refname);
>  		status = 0; /* we found something */
>  	}
> +
> +	UNLEAK(sorting);
> +	UNLEAK(ref_array);
>  	return status;
>  }

It is not too big a deal, but I find that liberal sprinkling of
UNLEAK() is somewhat unsightly.  From the code we leave with this
change, it is clear what we'd need to do when we make the code fully
leak-proof (i.e. we'd have a several lines to free resources held by
these two variables here, and then UNLEAK() that appear earlier in
the function will become a "goto cleanup;" after setting appropriate
value to "status"), so let's not worry about it.

> +test_expect_success 'ls-remote --sort="version:refname" --tags self' '
> +	cat >expect <<-\EOF &&
> +	'$(git rev-parse mark)'	refs/tags/mark
> +	'$(git rev-parse mark1.1)'	refs/tags/mark1.1
> +	'$(git rev-parse mark1.2)'	refs/tags/mark1.2
> +	'$(git rev-parse mark1.10)'	refs/tags/mark1.10
> +	EOF

Please do *NOT* step outside the pair of single quotes that protects
the body of the test scriptlet and execute commands like "git
rev-parse".  These execute in order to prepare the command line
argument strings BEFORE test_expect_success can run (or the test
framework decides if the test will be skipped via GIT_TEST_SKIP).

Instead do it like so:

	cat >expect <<-EOF &&
	$(git rev-parse mark)	refs/tags/mark
	$(git rev-parse mark1.1)	refs/tags/mark1.1
	$(git rev-parse mark1.2)	refs/tags/mark1.2
	$(git rev-parse mark1.10)	refs/tags/mark1.10
	EOF

I.e. the end token for << that is not quoted allows $var and $(cmd)
to be substituted.

Same comment applies throughout the remainder of this file.

Other than that, this patch was a very pleasant read.  Thanks.


