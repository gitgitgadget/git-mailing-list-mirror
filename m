Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255B11F453
	for <e@80x24.org>; Sun, 28 Apr 2019 23:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfD1X42 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Apr 2019 19:56:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43608 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfD1X41 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Apr 2019 19:56:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so4199439plp.10
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y3f3n77XZ2qAXmH5I0FOByKWmvKwms/mjNOxf4rF/F0=;
        b=uo8F6We3tb2B+EnvGHkUoCKihnq7fz3Mte6/mVxNbJYvnufHRjj8XDVB4t3jgocncT
         4d65dhMgTJ9hbIo5L79gqdTOahE3Mid9UHy+orU9slzGMg6/vUfD/6K9avzbc2n9UxPv
         ftVEDxzqv94OAeAJLXAiPOpMmaO98qOnrcFOAJXt+twf9x7DB/VotPbGLkDTDxTNZ2S4
         gEvmftiIXTYuWQUlhhjTCPM1JpCKEwdUWZlkqsiYfljkybeJbGpzNx37hIhvocy+ayTb
         5FGb2T1Q1IZt17dS0eMRwdnRLddEsHnB6JmofD8/NIT6pxwTweoydzCHVOTUR6EItmX2
         9mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y3f3n77XZ2qAXmH5I0FOByKWmvKwms/mjNOxf4rF/F0=;
        b=PmWSIoVweYF9rpmzZ9fxOsFJRFoan6k1k7gFyhXkBH7p2IeL3BhfFfSqBqVrIfXaAQ
         dEonxl0pFNyV8YSnT5nA0wL85z/EVfd9hs1hFCeTS2fdFBFsTRWP8iJerMsOrOUQzu7z
         DglUaOotz0BhhZM6TAfEzJ70QGJALJlsCrK2ckNx80oc07cK6Wggnvp8sRrcl3VbYXdY
         TEJxUwDVoTZ+M4Xmr8xeBvUsSzURvxqsOGqNf9/8IJClEW97V53GNMo6e3qZkJ/i4+aF
         z04kMkB5xltPasilTiYUq4nTuUZlfLZmv5/xcknVMimVldDFUA+EJ0cpJ3utvoVhrtyw
         hmsg==
X-Gm-Message-State: APjAAAWvB9SeO70edKlDpIvj+Nr63PblJ5VA4Bu9HmFJH6oKIuzBRi7h
        d/Trm+zzi0u/pGH2fFVDwTNhpeljiXc=
X-Google-Smtp-Source: APXvYqyd2ymB+mf17IZP7el1Z8P4ebKn42IOPlJT/bew2C+D4kHXdbAE9qz9HzgwPPe0Rw9zYkuisA==
X-Received: by 2002:a17:902:b40a:: with SMTP id x10mr58854922plr.231.1556495787250;
        Sun, 28 Apr 2019 16:56:27 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id q80sm58012657pfa.66.2019.04.28.16.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 16:56:26 -0700 (PDT)
Date:   Sun, 28 Apr 2019 16:56:24 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] mergetool: fallback to tool when guitool
 unavailable
Message-ID: <20190428235624.GA5304@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
 <c799e871e2a6a6a7fcca45aad71f5a0c406ba3d7.1556185345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c799e871e2a6a6a7fcca45aad71f5a0c406ba3d7.1556185345.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 02:54:41AM -0700, Denton Liu wrote:
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 68ff26a0f7..c4b16c5e59 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -350,20 +350,34 @@ guess_merge_tool () {
>  }
>  
>  get_configured_merge_tool () {
> -	# If first argument is true, find the guitool instead
> -	if test "$1" = true
> +	is_gui="$1"
> +	sections="merge"
> +	keys="tool"
> +
> +	if diff_mode
>  	then
> -		gui_prefix=gui
> +		sections="diff $sections"
>  	fi
>  
> -	# Diff mode first tries diff.(gui)tool and falls back to merge.(gui)tool.
> -	# Merge mode only checks merge.(gui)tool
> -	if diff_mode
> +	if "$is_gui" = true

This line looks suspect.  How about,

	if test "$is_gui" = true

instead?  This expression could also be lifted out to an "is_gui"
helper function.


>  	then
> -		merge_tool=$(git config diff.${gui_prefix}tool || git config merge.${gui_prefix}tool)
> -	else
> -		merge_tool=$(git config merge.${gui_prefix}tool)
> +		keys="guitool $keys"
>  	fi
> +
> +	merge_tool=$(
> +		IFS=' '
> +		for key in $keys
> +		do
> +			for section in $sections
> +			do
> +				if selected=$(git config $section.$key)

Would it be simpler to split this conditional into two lines?

	selected=$(git config ...)
	if test -n "$selected"
	then
		...
	fi

Yes, it stops looking at the exit code, but it instead focuses on the
result, which is slightly more bulletproof against a funky user
configuration.


Regarding the two loops above, what would it look like if we
unrolled the logic and just spelled out the keys up front that it's a
little easier to follow?

I agree it is nicer from an implementation sense to use loops,
but we really shouldn't be planning to extend to more permutations in
the future beyond the diff/merge duality, so being explicit and spelling
out each config lookup permutation is simpler to understand since we
only have 4 states.  We should be discouraged from adding any more ;-)

Something like,

	keys=
	if merge_mode
	then
		if gui_mode  # probably worth adding this function
		then
			keys="merge.guitool merge.tool"
		else
			keys="merge.tool"
		fi
	else
		if gui_mode
		then
			keys="diff.guitool merge.guitool diff.tool merge.tool"
		else
			keys="diff.tool merge.tool"
		fi
	fi

.. and then just have a single loop over $keys.
-- 
David
