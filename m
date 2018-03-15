Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9131FB0E
	for <e@80x24.org>; Thu, 15 Mar 2018 17:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeCOR7D (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:59:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38914 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbeCOR7C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:59:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id u10so12026330wmu.4
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sqz9uUVOnaONTH7Nevy9g41xnV14K2PFqZgh67mJV0M=;
        b=htoAlbO+KSDIoKQy7pT5y5WS+hQJv2SjJk3MMWFNV9sbUjocYZpR5H6yIrB9jTkgPy
         8YRV6OB/kvpMfSLuty2i+peFlPgOlt+/5Gg5B9g3JWM0QWLBpGElHg8+6RixcK9SqpIO
         tbrOZx5jajOMOpDywI09bPWI4cOTNAjMWObVS2NCWb4EGtRCBkQSpOg+O4sFj3N+tUkn
         tUBjUqjvdikmtWu4HJgf8os4KoNaiu+BIckQGq4T0IV9YpNTCiK+1uWpBGfUKjGNwoiq
         jlbNfuIgCoFKzPOY8kIAup1vYTVuLbq2RJ/nLEzmxuiIdgkorB2fAbAs3dIYuzCoVcda
         LlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Sqz9uUVOnaONTH7Nevy9g41xnV14K2PFqZgh67mJV0M=;
        b=jOX/38O3vmahiYpsqH/RpDa+j4MWhAm5PGYbu0/Bms8W892yyTalRUpdhKofcd5sud
         NcSE/Np7YtN7i77Cl2GSVa+mFJ8GNcGkEgGhrj3+Yu5r1iLNoj34/oxLk92P6gQ2WtQb
         lMYiToAZXchxRyQjBYHvHb0KtvMHWb93qMTv+kL0+Nnl3KbkKJvgJGbE9dTv09gcILxd
         JcA2aU7I6lqUWdbgap+DSUEYCEgKfenaWjqiZWqBUT54+V2D0dxZmBOFXZ9gj8Ht5PPm
         NKOzjeQN12AspWprUu/kDZXR9bKZCuFQuKpGkL1d5BbYzJCefALx8aHWTpBfPL7bFkKC
         Jing==
X-Gm-Message-State: AElRT7H85yMLxi1eeaxfBcD9vw2+uqIqQzfx2atlpQ0eEB9CQN/x4lZJ
        INFmMPDiiB4LBti0JH27GLU=
X-Google-Smtp-Source: AG47ELs2y4pYfcpxz9Pmzs+WJZaUkqkIzbwcbR6e6WIip47HJdlJ42VdIHkQ4h0q6hkqGekFgTJzrQ==
X-Received: by 10.28.0.210 with SMTP id 201mr1839148wma.10.1521136740786;
        Thu, 15 Mar 2018 10:59:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v124sm3989226wme.27.2018.03.15.10.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 10:59:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michele Locati <michele@locati.it>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2] filter-branch: return 2 when nothing to rewrite
References: <20180315130359.6108-1-michele@locati.it>
        <20180315170918.1984-1-michele@locati.it>
Date:   Thu, 15 Mar 2018 10:58:59 -0700
In-Reply-To: <20180315170918.1984-1-michele@locati.it> (Michele Locati's
        message of "Thu, 15 Mar 2018 18:09:18 +0100")
Message-ID: <xmqqbmfp5ifw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michele Locati <michele@locati.it> writes:

> Using the --state-branch option allows us to perform incremental filtering.
> This may lead to having nothing to rewrite in subsequent filtering, so we need
> a way to recognize this case.
> So, let's exit with 2 instead of 1 when this "error" occurs.
>
> Signed-off-by: Michele Locati <michele@locati.it>
> ---
>  Documentation/git-filter-branch.txt | 8 ++++++++
>  git-filter-branch.sh                | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)

Thanks.  Will queue.

>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 3a52e4dce..b63404318 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -222,6 +222,14 @@ this purpose, they are instead rewritten to point at the nearest ancestor that
>  was not excluded.
>  
>  
> +EXIT STATUS
> +-----------
> +
> +On success, the exit status is `0`.  If the filter can't find any commits to
> +rewrite, the exit status is `2`.  On any other error, the exit status may be
> +any other non-zero value.
> +
> +
>  Examples
>  --------
>  
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 1b7e4b2cd..c285fdb90 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -310,7 +310,7 @@ git rev-list --reverse --topo-order --default HEAD \
>  	die "Could not get the commits"
>  commits=$(wc -l <../revs | tr -d " ")
>  
> -test $commits -eq 0 && die "Found nothing to rewrite"
> +test $commits -eq 0 && die_with_status 2 "Found nothing to rewrite"
>  
>  # Rewrite the commits
>  report_progress ()
