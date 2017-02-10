Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC371FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 22:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdBJWwA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 17:52:00 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35931 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdBJWv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 17:51:59 -0500
Received: by mail-pf0-f180.google.com with SMTP id 189so12363224pfu.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 14:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eudguDeB9QGWoYpU0I9dJzbVn090eV34DJIBi1Rf/8U=;
        b=Wial0kp9T9HIu2umPDbI2PUFTwKsVzKUBS3/pvcXiW+g6m8BdooTzM7fBvu5Ifhwbm
         dq3BAz6EWtqYh20OUiV1CyOIzirs0+2Bxhwze0FGM+IOoZ671ZSJHCkZTgto2MT+ro72
         Zmk/5BosWvhfMBhW2M2YXw4Ch/Ve/Dk368sFmZ3iSNolIkzYgbMr/2p/h2QHw6Bw3YJ4
         doC3ikEgYw9PElr2HLDsiljIeiLKSheF+UPJHZNc3DJHVeDcncTy+rWi1DejFWHNU/9D
         jwwJ5bYBsaZVLQDQ6P2J7LAgXYtQMkdrgC2yatbH76X5Bh9WuDZfyE0ouVJnG456iZTF
         XAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eudguDeB9QGWoYpU0I9dJzbVn090eV34DJIBi1Rf/8U=;
        b=uRFfXCcGSPbGK3a5VGOmko6S1rOJ2dgfJroYdFgRPGxv7QB2lV96h75JKxJIFKJl2R
         1b67YC9qerTalXGAgdevo9CPBFSgQYYlURkPEOJzKtoTGURWBWdIndtQXvk0VZTAIhon
         fyGsTzZusT/cueiFzyWFxbzovxDt7gr3WSi/Mou64Esb6bAC+JUN6ChHZWj+Kk0xsFGp
         9dZueKN6W2cg8ON6Nr4ptVYAZSGoQBo0z+ifYXuUk2JzsvrVKY85C/vnxcwRtwvdnHRg
         ZdV3Fysk+MnVEa/7zMf5Fp2IS5BQ7GfOpwbqDdxC/EX/BiZglkH3Xpy/fYJFrc63RgVN
         h0bQ==
X-Gm-Message-State: AMke39l6G5Gd4bJMbeg3UasQcwrCRSKl9tu50iFpRbkbCP45i4yG+nPf+/XztUkQbLEp1aWR
X-Received: by 10.99.56.94 with SMTP id h30mr13551672pgn.23.1486767118690;
        Fri, 10 Feb 2017 14:51:58 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:516e:fea7:5b33:d93c])
        by smtp.gmail.com with ESMTPSA id m6sm1199693pgn.58.2017.02.10.14.51.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 14:51:57 -0800 (PST)
Date:   Fri, 10 Feb 2017 14:51:56 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ls-files: move only kept cache entries in
 prune_cache()
Message-ID: <20170210225156.GA128190@google.com>
References: <f480bd26-f74e-9088-844d-26cde0843baa@web.de>
 <de84d0f4-cfce-1e73-6d5d-ad18df507d32@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de84d0f4-cfce-1e73-6d5d-ad18df507d32@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10, René Scharfe wrote:
> prune_cache() first identifies those entries at the start of the sorted
> array that can be discarded.  Then it moves the rest of the entries up.
> Last it identifies the unwanted trailing entries among the moved ones
> and cuts them off.
> 
> Change the order: Identify both start *and* end of the range to keep
> first and then move only those entries to the top.  The resulting code
> is slightly shorter and a bit more efficient.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> The performance impact is probably only measurable with a *really* big
> index.

Well there's been a lot of talk recently about *really* big indexes, so
I'm sure someone out there will be happy :)

> 
>  builtin/ls-files.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 18105ec7ea..1c0f057d02 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -379,10 +379,7 @@ static void prune_cache(const char *prefix, size_t prefixlen)
>  	pos = cache_name_pos(prefix, prefixlen);
>  	if (pos < 0)
>  		pos = -pos-1;
> -	memmove(active_cache, active_cache + pos,
> -		(active_nr - pos) * sizeof(struct cache_entry *));
> -	active_nr -= pos;
> -	first = 0;
> +	first = pos;
>  	last = active_nr;
>  	while (last > first) {
>  		int next = (last + first) >> 1;
> @@ -393,7 +390,9 @@ static void prune_cache(const char *prefix, size_t prefixlen)
>  		}
>  		last = next;
>  	}
> -	active_nr = last;
> +	memmove(active_cache, active_cache + pos,
> +		(last - pos) * sizeof(struct cache_entry *));
> +	active_nr = last - pos;
>  }
>  
>  /*
> -- 
> 2.11.1
> 

Both these patches look good to me.

-- 
Brandon Williams
