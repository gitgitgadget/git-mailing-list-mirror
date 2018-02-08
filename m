Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7EC1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 18:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBHSUw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 13:20:52 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44126 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHSUv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 13:20:51 -0500
Received: by mail-wr0-f196.google.com with SMTP id v31so5693373wrc.11
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 10:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wwAhH7EjfTCyKSTfTNXslrZcr17VMih757B+sHPJhOI=;
        b=BYFrVUZM3fbsfS54eyT43adCdUbMosSTRdcHSSAgk+9rvHP5ilLoC+Y1WUyZD9pDf0
         qSTLjnuszwlvrmlQ/H8Nt6KiqWUsn6g6uBtXJV2zQ78+mvRdHGCozMZxRXoOL+NkbQcd
         ufPUa0IuN5sFfxFTNPtTi7wJhbsaIpPlFnIS976zacVk/hhIjk8/e6htIDmv+Uj0JDKo
         2W/NTdoPkHUFiH0WQsCFslSxGwHUyChWsoSsNvjpTkZqg30+aWWQfO7NGoiI9RBa22iF
         WgVKr3bpU+znOjnKo59cj4AnPNIdNxpSVYrW5FNicXCtivbNjbpZX9cIJxWzDdKq4P5H
         o18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wwAhH7EjfTCyKSTfTNXslrZcr17VMih757B+sHPJhOI=;
        b=N4xN59PgBHVO/sDQBS5WkqJyAZdUFxYYYasG2rbzhsez9T58c2SAlID7i5YjuJb4AP
         ws+OY5EWST2MMCV/zzbpdETHqZbvbFZHEDJmsKEoGHz30NcrHa/F5jR/d61ZDUqUtTa4
         fTM6G7ZqUyiIiSfRhENJQEHYGv2mpiunvej/vwmCkBpdWMZYcTFaTfNeikO+Xv6g10Y1
         OYbVAiZSxzIR/h7tS1VNuto5WQ7mhCGgk4fznPagNY674k2syGKzeUFJEMxsJXHY+tHZ
         MpU2gmEJpVSZSeDbUgjN8TIuuGkDad4drf+ZyKHfzJ0maj7WI8tqrsbm1zGHRLUmAIjN
         AM9Q==
X-Gm-Message-State: APf1xPC6FZRVyGLBFn2xAmWsnb4SCIX1aPrvSg96f+v5EX94d/QQAb+U
        L3G7lA7qTZZy9fdwfqJCadk=
X-Google-Smtp-Source: AH8x226R4aFQT2C1722MFsOKRrGs+C/5RL5A+VsPB/dD4om3eFmIwKRzZOv28FR1SC1yMt90huLeaA==
X-Received: by 10.223.151.158 with SMTP id s30mr93396wrb.70.1518114049370;
        Thu, 08 Feb 2018 10:20:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q12sm645730wrg.37.2018.02.08.10.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 10:20:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, prohaska@zib.de, tboegi@web.de,
        sunshine@sunshineco.com, novalis@novalis.org
Subject: Re: [PATCH v1] name-hash: properly fold directory names in adjust_dirname_case()
References: <20180208004156.36224-1-benpeart@microsoft.com>
Date:   Thu, 08 Feb 2018 10:20:47 -0800
In-Reply-To: <20180208004156.36224-1-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 7 Feb 2018 19:41:56 -0500")
Message-ID: <xmqqlgg35on4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> Correct the pointer arithmetic in adjust_dirname_case() so that it calls
> find_dir_entry() with the correct string length.  Previously passing in
> "dir1/foo" would pass a length of 6 instead of the correct 4.  This resulted in
> find_dir_entry() never finding the entry and so the subsequent memcpy that would
> fold the name to the version with the correct case never executed.
>
> Add a test to validate the corrected behavior with name folding of directories.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---

Thanks.

It appears that this codepath has been miscounting ever since it was
introduced in 41284eb0 ("name-hash: don't reuse cache_entry in
dir_entry", 2015-10-21).

> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index b29d749bb7..219c96594c 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -80,7 +80,17 @@ test_expect_success 'merge (case change)' '
> ...
> +test_expect_success CASE_INSENSITIVE_FS 'add directory (with different case)' '
> +	git reset --hard initial &&
> +	mkdir -p dir1 &&
> +	mkdir -p dir1/dir2 &&

A single "mkdir -p dir1/dir2" should be sufficient, thanks to "-p" ;-)

> +	touch dir1/dir2/a &&
> +	touch dir1/dir2/b &&

Hmph.
