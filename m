Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC01420A1E
	for <e@80x24.org>; Tue, 25 Dec 2018 03:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbeLYDGc (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 22:06:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33989 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeLYDGc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 22:06:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so20138320wmd.1
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 19:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9rcUNmk1nOy63LfXv0pgXrPylC3q08sx40R1Wbh6shc=;
        b=krvudpdWBrlksL7cXacyvznh1DI3wju+tfnsLjSr54GS6xGQkVIJhL9bty7xq80hwt
         V407fRD7qy1/IroFGcZCT78mkp5Zad7gZWusFrOf5TBfRdmqNHi0SDL+kUGHCNB4jnS8
         DMl9YmffPYtzhrAtktAwh7nt4oaSwUL6gv66dZnwnjw8/psUwUVCibexwEXwnnGZ38uS
         nzynhenzvCj49GDFfCZbrdGoiymr1TreX5tSc42JaRBt/9W7V6d2Dz7H0Rmt3GzVghku
         9EWhnLfiSzic5g3JMt+tQSEZoFik7E+3iOfWwyhGKbJQTIA8NpQdpILCoU/BWOLGQjuJ
         gB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9rcUNmk1nOy63LfXv0pgXrPylC3q08sx40R1Wbh6shc=;
        b=nDSTEEylQVjAzp5psbbkAXmbI5NyUVJbcBo2NqMhhT2GHGJ0ib+p7jDScbSNYLYY2T
         cNIQYMBTb0fG0OCntPuKneXQgjYd9PJ5vfInMoff8wTWDWJUnprb7pVGHsOoeoRkuebG
         BGbrhBuqEaOFG8cpBxErL9uLkaA2AIyEhjgl028jXd4tPWhEDrQepj0+vgt3zY6w9H9F
         tHHpOM1bYp6xVum2Kc8Ol0kjzdQcsQwJmkIVuaJCDQjuXRiAPdAaSzKNQavQxJ6i3IMi
         KfB/2F/VjwelRc2zX3YfZH4s4MLALck7P0MDYvYjR/SjIAM5v6qWrz7oUWKPPQPqZp8a
         kRzA==
X-Gm-Message-State: AA+aEWblo2auJMgd10d36jdPMmYZV56JaH01v70X5N13rBI9UEo2dVl2
        hoI4YpL0UiLc1fuoo+5geZA=
X-Google-Smtp-Source: ALg8bN6P/nHq2smP9UppFg0IXVOjEBSIqm08DDb/FonKhxxgn//sGSYvLu6Ay9htsv8gbKv+trL8gg==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr14021805wmh.118.1545707190192;
        Mon, 24 Dec 2018 19:06:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o3sm13692463wrs.30.2018.12.24.19.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 19:06:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/1] abspath_part_inside_repo: respect core.fileMode
References: <pull.104.v2.git.gitgitgadget@gmail.com>
        <pull.104.v3.git.gitgitgadget@gmail.com>
        <b935e11d21fc2a34953d1fc651ea09f1a4c1a769.1545692162.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Dec 2018 12:06:28 +0900
In-Reply-To: <b935e11d21fc2a34953d1fc651ea09f1a4c1a769.1545692162.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 24 Dec 2018
        14:56:04 -0800 (PST)")
Message-ID: <xmqqftumb8zv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/setup.c b/setup.c
> index 1be5037f12..291bfb2128 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -39,7 +39,7 @@ static int abspath_part_inside_repo(char *path)
>  	off = offset_1st_component(path);
>  
>  	/* check if work tree is already the prefix */
> -	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
> +	if (wtlen <= len && !fspathncmp(path, work_tree, wtlen)) {
>  		if (path[wtlen] == '/') {
>  			memmove(path, path + wtlen + 1, len - wtlen);
>  			return 0;
> @@ -59,7 +59,7 @@ static int abspath_part_inside_repo(char *path)
>  		path++;
>  		if (*path == '/') {
>  			*path = '\0';
> -			if (strcmp(real_path(path0), work_tree) == 0) {
> +			if (fspathcmp(real_path(path0), work_tree) == 0) {
>  				memmove(path0, path + 1, len - (path - path0));
>  				return 0;
>  			}
> @@ -68,7 +68,7 @@ static int abspath_part_inside_repo(char *path)
>  	}
>  
>  	/* check whole path */
> -	if (strcmp(real_path(path0), work_tree) == 0) {
> +	if (fspathcmp(real_path(path0), work_tree) == 0) {
>  		*path0 = '\0';
>  		return 0;
>  	}

So the idea is that the path to the top level of the working tree
must be compared with fspath[n]cmp() to what was given.  After
stripping that prefix, the caller uses the result just like it uses
a non-absolute path, which is why the necessary changes are isolated
to this function.

Makes sense.

> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 37729ba258..be582a513b 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -402,4 +402,11 @@ test_expect_success 'all statuses changed in folder if . is given' '
>  	test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
>  '
>  
> +test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
> +	path="$(pwd)/BLUB" &&
> +	touch "$path" &&
> +	downcased="$(echo "$path" | tr A-Z a-z)" &&
> +	git add "$downcased"
> +'

One problem with the above test is that it leaves it unspecified if
the resulting index entry is "blub" or "BLUB".  Shouldn't we verify
that "git add" adds an expected path to the index, instead of
blindly trusting that it says "Yeah, I did as I was told" with its
exit status?  Would we be adding 'blub' as that is what we told
'git' to add, or would it be 'BLUB' as that is what exists on the
filesystem that is case insensitive but case preserving?

On a project whose participants all are on case insensitive
filesystems, the above does not matter by definition, but once a
project wants to work with their case sensitive friends, it starts
to matter.

Other than that, looks good to me.

Thanks.


> +
>  test_done
