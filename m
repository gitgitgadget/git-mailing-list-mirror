Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A33F20248
	for <e@80x24.org>; Mon, 25 Feb 2019 17:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfBYR7X (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 12:59:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfBYR7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 12:59:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so10933772wrn.12
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 09:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IdA4KDsRgmQLrDgtLegJud+PK3M28HJsTDeC6Xd3Fmg=;
        b=mv1dAf4cmaHoNmARu417ifxSosRa/7D3AUHWmu3nAKJLgXSRwLABiI4SHV1qH2BxBf
         p/+Cpigddsxi+u0rm0WEkaD4Aah8zNZLJWBHV1jUY5Up4Z+JxziHjFwBjJAQYVhjRJvl
         6Z+tPShs8/+ejllZcXpYeX6Z8G5qRwLrc4uOQxqRV1Qt59l4E6jwBDJhrCVkiFwTew8X
         fmyCGJCAljknruJJx1LrQMr1a1x2RgQmx+5epGsIOxQQ3UG9yczn7HV9kmXMvzSEk2NZ
         PLFrNV8vdZtep9xefMxyODC5/8oS34JhfM0wMs+3IVSe+bonsPuNR4Dx1dAMY0nIBKfM
         DdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IdA4KDsRgmQLrDgtLegJud+PK3M28HJsTDeC6Xd3Fmg=;
        b=nU0W+wgmZokerq5vyp6EQ8mkLQBrfqdKjumnhgsNjTkreUz9buXOPyY2uKgEhhzDjg
         E+FEJICngUSyKiiNGyMR9lQPvnAWIPCH/HuNibfexnVMBI0cv9D3g8XC99RyQ+bRrJST
         2TYOm5XM8H1ysQVx3jrzUx5rMMW0bmL2Xf8lN9mrlh7VYVvwLjZT58VHjJMlZIyIj7hn
         xxr+8l42xFElyO+Rc4AQQypAxUu1zopgIHDKq57DwzeWme69/t1wNwsYnbOd6B+kBPOC
         iZPzuvEOAE8eM9+JePAMTZhlKNMU0BApdtOY9EPZFwMJmYnS1fJsFyhJP2oi0vZcEG3j
         yxuw==
X-Gm-Message-State: AHQUAuZJB0UlbMr4UUtddv+XJNfF+RNiqn1aS7tddeLiCrn9aNw7B2JI
        uaU0gRtBnstbk/hz3fdWzBN8sixI
X-Google-Smtp-Source: AHgI3IYgjcTP+4OMoeQ6Iv/yemvVvtlcqnVOipxxkRg1fx5EtqFQqarTyFOYH4xU9himsM06qFaxpQ==
X-Received: by 2002:adf:c593:: with SMTP id m19mr13285550wrg.124.1551117561635;
        Mon, 25 Feb 2019 09:59:21 -0800 (PST)
Received: from szeder.dev (x4d0c69db.dyn.telefonica.de. [77.12.105.219])
        by smtp.gmail.com with ESMTPSA id d2sm10450957wrq.94.2019.02.25.09.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 09:59:20 -0800 (PST)
Date:   Mon, 25 Feb 2019 18:59:18 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthew Booth <mbooth@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] line-log: suppress diff output with "-s"
Message-ID: <20190225175918.GV1622@szeder.dev>
References: <CAEkQehdFu5zM4AY3ihN0pn1aCNEomY0WV07pryfAB45JN-tDDA@mail.gmail.com>
 <20190225171817.GA17524@sigill.intra.peff.net>
 <20190225173248.GB17524@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225173248.GB17524@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 12:32:49PM -0500, Jeff King wrote:
> diff --git a/line-log.c b/line-log.c
> index 24e21731c4..863f5cbe0f 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1106,7 +1106,8 @@ int line_log_print(struct rev_info *rev, struct commit *commit)
>  	struct line_log_data *range = lookup_line_range(rev, commit);

Note that the result of this lookup_line_range() call is only used
when we do show the diff below; if we don't, there is no use calling
it.

>  	show_log(rev);
> -	dump_diff_hacky(rev, range);
> +	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT))
> +		dump_diff_hacky(rev, range);
>  	return 1;
>  }
>  
