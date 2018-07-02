Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CAC11F516
	for <e@80x24.org>; Mon,  2 Jul 2018 17:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeGBRgS (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 13:36:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42278 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752646AbeGBRgR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 13:36:17 -0400
Received: by mail-pl0-f67.google.com with SMTP id y15-v6so6400141pll.9
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZBpBrgbaL35wU2oDvvw4YuAuySpp0+nAUWAHzmAGseI=;
        b=Ns0ejf7Il4TCzMUvWJ9DcqaH8DWTh3ncP7chFBh+3mCKGlBz99ZGPa3qnlRZiHC78t
         We3GjLV1BesOcIh3bVgzmlY5K0p/SFjT15U+6Grab3nSjV3iNe8k77RpA8RgWAVcJLpp
         u50xm0sBhywsR+vz94Ydsh94V6FlZLnZbQ9j4mUNBq21lRyl8iH19cZDfkSoedCy7RV3
         jkg2E8jrC0I4sZJcJc9RgoGvcEUzvoiRok154tchl8m7PuI0Feh5T2m+7r4eSKEMgqf1
         wj8juPUtqoPAQp2EjLoFE1X+u5UUqaGt/YYb5f8175z7bJDF9U7S6gKvcYx0c4XrlI4r
         tRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZBpBrgbaL35wU2oDvvw4YuAuySpp0+nAUWAHzmAGseI=;
        b=amx7MdC6L5kzLRRYa5i3K/JV7fU2aAYtuORpHdQXhuBeKoOiTivUv9RRhO8wlZT49S
         Y2CTRZfcsib9eon4BGenWiFLe8SmSAqg9s3/L4ylNcgPpA11WjafiOpB+Y2y4ml2J0I1
         l47m8SLr4XqV36fQOW+MDVkzlz82MI6D109JJatEJ8l5fQKih1p2d9rKWEzHls9wXn+d
         2B+ZMk9xa0CeLX5PDBqK7EJwcNS1Av68pa947X7BJX8/ztN30btoEuROoNmpUG19R7lP
         CEkiVsV9zjEE3MYKkPNfxnJr9+Uf7UIG8WxCY30sG5PJf0uqrHi2opIs9xq/GXiNqO0P
         72fQ==
X-Gm-Message-State: APt69E1VXcExAF6JycotLJI00kEQV06jXiqULMFT6iUZ2qYCQ8z1Xw+Y
        QDJ07BhOC3oaa8X7rUtebdtnOA==
X-Google-Smtp-Source: ADUXVKLwl2zRPkV5pAA26Ac5jcbq9UH70QG4UfiG7pdaf4ItpwcwVayYDdWgaJwsmeFYNhdn6DCa6g==
X-Received: by 2002:a17:902:b48f:: with SMTP id y15-v6mr26972095plr.261.1530552976395;
        Mon, 02 Jul 2018 10:36:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id l28-v6sm14680501pfi.4.2018.07.02.10.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 10:36:15 -0700 (PDT)
Date:   Mon, 2 Jul 2018 10:36:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 9/9] diff.c: add white space mode to move detection
 that allows indent changes
Message-ID: <20180702173614.GD246956@google.com>
References: <20180622015725.219575-1-sbeller@google.com>
 <20180629001958.85143-1-sbeller@google.com>
 <20180629001958.85143-10-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629001958.85143-10-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/28, Stefan Beller wrote:
> The option of --color-moved has proven to be useful as observed on the
> mailing list. However when refactoring sometimes the indentation changes,
> for example when partitioning a functions into smaller helper functions
> the code usually mostly moved around except for a decrease in indentation.
> 
> To just review the moved code ignoring the change in indentation, a mode
> to ignore spaces in the move detection as implemented in a previous patch
> would be enough.  However the whole move coloring as motivated in commit
> 2e2d5ac (diff.c: color moved lines differently, 2017-06-30), brought
> up the notion of the reviewer being able to trust the move of a "block".
> 
> As there are languages such as python, which depend on proper relative
> indentation for the control flow of the program, ignoring any white space
> change in a block would not uphold the promises of 2e2d5ac that allows
> reviewers to pay less attention to the inside of a block, as inside
> the reviewer wants to assume the same program flow.
> 
> This new mode of white space ignorance will take this into account and will
> only allow the same white space changes per line in each block. This patch
> even allows only for the same change at the beginning of the lines.
> 
> As this is a white space mode, it is made exclusive to other white space
> modes in the move detection.
> 
> This patch brings some challenges, related to the detection of blocks.
> We need a white net the catch the possible moved lines, but then need to

s/white/wide/

> +
> +/**
> + * The struct ws_delta holds white space differences between moved lines, i.e.
> + * between '+' and '-' lines that have been detected to be a move.
> + * The string contains the difference in leading white spaces, before the
> + * rest of the line is compared using the white space config for move
> + * coloring. The current_longer indicates if the first string in the
> + * comparision is longer than the second.
> + */
> +struct ws_delta {
> +	char *string;
> +	unsigned int current_longer : 1;
>  };
> +#define WS_DELTA_INIT { NULL, 0 }
> +
> +static int compute_ws_delta(const struct emitted_diff_symbol *a,
> +			     const struct emitted_diff_symbol *b,
> +			     struct ws_delta *out)
> +{
> +	const struct emitted_diff_symbol *longer =  a->len > b->len ? a : b;
> +	const struct emitted_diff_symbol *shorter = a->len > b->len ? b : a;
> +	int d = longer->len - shorter->len;
> +
> +	out->string = xmemdupz(longer->line, d);
> +	out->current_longer = (a == longer);
> +
> +	return !strncmp(longer->line + d, shorter->line, shorter->len);
> +}

I'm having a harder time understanding this block.  This is used to fill
a ws_delta struct by calculating the whitespace delta between two lines.
If that is the case then why doesn't this function verify that the first
'd' characters in the longer line are indeed whitespace?  Also, maybe
this is just because I'm not as familiar with the move detection code,
but how would the whitespace detection handle a line being moved from
being indented with tabs to spaces or vice versa?  Is this something
already handled and not an issue?

-- 
Brandon Williams
