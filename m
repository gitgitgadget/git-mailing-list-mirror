Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DA2E1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeCPVbP (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:31:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34441 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPVbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:31:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id o8so12983300wra.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6B9tQ6DWN1/3NT14TQjs8a4TymXzAMnwww0LALKmzFU=;
        b=nWOdRTssRIYwOx8xB4dfTwcg2ISqMezv4Bwgti9lPvom/h+aihXxRC5pqTzevCcGMK
         uJuUTzlqeqL5m1csF0QyvB6r+qvofGbR5Ort5Wv4SWUBd8KYYX5q2GFNJPPnAzu9BNJK
         B3VXAChALpRqo8bLXnm4cRnCygqadz6sEtcS5GKhG+Bt9+3s7M/jjONMWqRDByRVgAdM
         PvjgmaOTGXamEIHc0ApQ49UjJE736/Tgug74FSGc7FvXRfu58yota4J8/7JK4U3dnnII
         xYUUMK6XWzUGBrrV7QMujvY5/begFhsAxZP7CVRvrAgUKIy3Ak0WAb4cExERmbqsMOjM
         Nz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6B9tQ6DWN1/3NT14TQjs8a4TymXzAMnwww0LALKmzFU=;
        b=N0NLOmhWjVNwBEJJ17MYKXfmTb5vvbjcTZWhNcXpOSucooyCgB2aXLd+3Z8PkXhbsr
         HOsjQ1u2Y/qNG/qlVDqDfh+LJoO7cv5gQML0HZsdpWwPnR13xpt0/PXl5Rh90h87nS1K
         DkhrSdtkIUKlKXwYZ99ZBFrmWdwrWM6Uhd1x+92Fmfob055uS02WODO/I+Er5hJyeILW
         Vn5MQA1aje782xnAyNhGtXqShykQhOVtV7VJ5x415gy2Uvt7jLbWQBmAuf1mxPOwplaw
         6/1WD3L8dux2wNJnpASiU9NpLFA2EBI91lGoC1/TZM7NshBigA7KiKuUxUUK0u48JZ17
         jubg==
X-Gm-Message-State: AElRT7HHaSHd4GDcbgwUibuAQ5b5domwNbfY6h1tuUFUHe1s6Z91csrm
        GEnh7f7TRNuiX9MHvURpYBI=
X-Google-Smtp-Source: AG47ELttthU9m+0266t4IF8+hRSFR9dYxZEBUq3J7dS1Pr+pQIMrwP7Mom3/rM0ehcckdEU013pQyQ==
X-Received: by 10.223.163.221 with SMTP id m29mr3070164wrb.4.1521235872721;
        Fri, 16 Mar 2018 14:31:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a131sm4089345wme.24.2018.03.16.14.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:31:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v3 1/2] stash push: avoid printing errors
References: <20180314214642.22185-1-t.gummerer@gmail.com>
        <20180316204306.862-1-t.gummerer@gmail.com>
        <20180316204306.862-2-t.gummerer@gmail.com>
Date:   Fri, 16 Mar 2018 14:31:11 -0700
In-Reply-To: <20180316204306.862-2-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Fri, 16 Mar 2018 20:43:05 +0000")
Message-ID: <xmqqtvtfzp0g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> @@ -322,9 +322,12 @@ push_stash () {
>  
>  		if test $# != 0
>  		then
> -			git add -u -- "$@" |
> -			git checkout-index -z --force --stdin

This obviously is not something this patch breaks, but I am finding
this pipeline that was already here quite puzzling.

The "add -u" is about adding the changes in paths that match the
pathspec to the index; the output from it is meant for human
consumption and certainly is not something "--stdin" should expect
to be understandable, let alone with "-z".

	... goes and digs ...

I think you mis-copied the suggestion in

    https://public-inbox.org/git/xmqqpo7byjwb.fsf@gitster.mtv.corp.google.com/

when you made bba067d2 ("stash: don't delete untracked files that
match pathspec", 2018-01-06), and nobody caught that breakage during
the review.

> -			git diff-index -p --cached --binary HEAD -- "$@" | git apply --index -R
> +			if git ls-files --error-unmatch -- "$@" >/dev/null 2>/dev/null
> +			then
> +				git add -u -- "$@" |
> +				git checkout-index -z --force --stdin

And the same breakage is inherited here; just drop "|" and
downstream "checkout-index" and you should be OK.

> +				git diff-index -p --cached --binary HEAD -- "$@" | git apply --index -R

And while at it, let's split this to two lines after "|".

> +			fi

