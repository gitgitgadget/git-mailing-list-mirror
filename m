Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C832F20437
	for <e@80x24.org>; Tue, 31 Oct 2017 17:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbdJaRvX (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:51:23 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:50005 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbdJaRvW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:51:22 -0400
Received: by mail-io0-f194.google.com with SMTP id n137so573993iod.6
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=74cS1QOEu89LIanPngLOCcEx9Rz5uHVwxfe5v2Nf/cE=;
        b=er6kXxrTAiU+A/8Uo9sY1rpLZDrjLr0YmARfVo+ZgcPHQ/hxu0z6QFMTGYPl65Zd06
         mDRrzz8OZ4OYPA8Co09oXRVoVfPIChy5ItA5PnDhnlqL+BlLnIpH4fc+I55DldcmV66c
         KA55KdPnA7IhSUD+daeugGn8dRlEMq5RpOWaCGz71iqUDqF8h/MDk4UYtBiIgkuWZk0f
         Y5YLW9ZiFaVINT06xVcscX9mI+fxt4o2o7pB+MSImI+w01Jc4H18CFhFooZyKK0HYxW8
         kqE3sRaDMirWdtdRcSPJ3I70TOpXEooDMYrl+Tvy/1XQcKmeNCZFS9VHSQOH2o66kCHN
         30mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=74cS1QOEu89LIanPngLOCcEx9Rz5uHVwxfe5v2Nf/cE=;
        b=AakGJNMS33PKqsqNcGQKcW+r2U2t015pgamORDinbVusXu7x2XU1jQKemLDGPImDsv
         6iIhmSFkX9z/elNsyiuR7nk3vjkBX6Ir/rA7FzeBcopVMZRQUrdey17jTpr8XggQP6H3
         f91yEEZBL37nqwrqQ9EKw1zAeEDWiFt0ebq1WO2j+eIbZQCAahQqwzMWGxUVOEXPVg5s
         6iMr0jQvBI1iaQ4B3GGKr5XSeh/8pUNV1Gz2VstFz2deB2ICAJn26FZGXFLurVWN057R
         aVK4I9JXuSpsKCY0HWKkO/wCvc6YdWyMIB48VhxhLvoEFQRCLeyiohiz0xL3g6c2H6AA
         1OTA==
X-Gm-Message-State: AMCzsaUy3nj6Lrb0ut168Eg85uQZIghXqe45OEZ2mkFV20keMLXLO44s
        hCRM+0mCrmg+AF2KUTIc3e2UMw==
X-Google-Smtp-Source: ABhQp+SG7CiR7H3qfyKW2MPLcvNITUIsFdjwMO6zJrbYBhQQ+jOXcOWstfeJWAt78HsH3Nk4Kzpq6Q==
X-Received: by 10.36.37.148 with SMTP id g142mr4212877itg.38.1509472281674;
        Tue, 31 Oct 2017 10:51:21 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:65da:c046:b1c4:7dde])
        by smtp.gmail.com with ESMTPSA id h97sm889416iod.87.2017.10.31.10.51.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 10:51:20 -0700 (PDT)
Date:   Tue, 31 Oct 2017 10:51:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 2.5/4] diff: avoid returning a struct by value from
 diff_flags_or()
Message-ID: <20171031175119.GB94048@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
 <20171030194646.27473-1-bmwill@google.com>
 <20171030194646.27473-3-bmwill@google.com>
 <xmqqo9on28mf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9on28mf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/31, Junio C Hamano wrote:
> That is more in line with the design decision made in the previous
> step to pass struct by reference.
> 
> We may want to squash this into the previous patch eventually.

Looks good to me.  I was on the fence with what to do since I was
already moving to pass by reference.  This is probably the better move
so I can squash this one into the previous.

> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * I am OK either way as long as things are consistent; as you took
>    time to change the code to pass the struct by reference, let's
>    unify the API in that direction.
> 
>  diff-lib.c |  2 +-
>  diff.h     | 12 ++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/diff-lib.c b/diff-lib.c
> index 6c1c05c5b0..ed37f24c68 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -547,7 +547,7 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
>  	DIFF_OPT_SET(&rev.diffopt, QUICK);
>  	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
>  	if (flags)
> -		rev.diffopt.flags = diff_flags_or(&rev.diffopt.flags, flags);
> +		diff_flags_or(&rev.diffopt.flags, flags);
>  	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
>  	run_diff_index(&rev, 1);
>  	object_array_clear(&rev.pending);
> diff --git a/diff.h b/diff.h
> index 47e6d43cbc..e512cf44d0 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -94,19 +94,15 @@ struct diff_flags {
>  	unsigned DEFAULT_FOLLOW_RENAMES:1;
>  };
>  
> -static inline struct diff_flags diff_flags_or(const struct diff_flags *a,
> -					      const struct diff_flags *b)
> +static inline void diff_flags_or(struct diff_flags *a,
> +				 const struct diff_flags *b)
>  {
> -	struct diff_flags out;
>  	char *tmp_a = (char *)a;
> -	char *tmp_b = (char *)b;
> -	char *tmp_out = (char *)&out;
> +	const char *tmp_b = (const char *)b;
>  	int i;
>  
>  	for (i = 0; i < sizeof(struct diff_flags); i++)
> -		tmp_out[i] = tmp_a[i] | tmp_b[i];
> -
> -	return out;
> +		tmp_a[i] |= tmp_b[i];
>  }
>  
>  #define DIFF_OPT_TST(opts, flag)	((opts)->flags.flag)
> -- 
> 2.15.0-224-g5109123e6a
> 

-- 
Brandon Williams
