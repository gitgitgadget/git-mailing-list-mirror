Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F82F2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 19:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756567AbcJ1Tfj (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 15:35:39 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34687 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbcJ1Tfi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 15:35:38 -0400
Received: by mail-pf0-f171.google.com with SMTP id n85so42031394pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vrPy3MwNgtzpD+QbaWP/4dmyczs4rj13mjhRuZ7TNjo=;
        b=poxJK7ij4DIfQWvPDya6gB9KPhCMcfX6ejOQtjjVpadIAVenfvRfPxqLwjepl6/jMH
         ahHhWt7WjPdMBC4jg7GoZQAcvrafdZ9/cD2fMrcrqK5g21q4QLEPndenfSMUMLUBXVmK
         uqX9juYcSWjnJapdu6uPOVQ8tyUG6KjRGxdtne5U553Cr8VbUzHjZmnOMPjHy0lh/fNu
         zx4UYzjqdoqWr3z+cXbcBdcXr7M/3l+DkHpho7FIzJwC853EAGKSZO+NXN8AmpPb02t5
         X+z5HSrkLrUGazOtKOzGCpF0/rzX1xX1TH9Jo5FXz6MWzLwh8BIOnVlyiRWLS0N0foCm
         g2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vrPy3MwNgtzpD+QbaWP/4dmyczs4rj13mjhRuZ7TNjo=;
        b=fo3CtJMASHKNwPCwD3HKU9iB+sR0X1+FyHs2ox2ruXgPQWbYyHvEyPN7Tra1nrMkGb
         stF0MqQdg35p+K4MWt+qEGpmXhH0eZerW/mOCvKnl2PIpVih5HRqxtT2RVybZN6Sduiu
         4TUGhFOslKo6URjcquUFNMKpgAj58pl6YKO6GpZggsmTgsk8tyqeJDUsmo4LN4fdFqmU
         19IHe6peGpy5+oxX1ZuGlpQESVm/aVQcVYyRvbb8GkqZkBO/mRjrcYNlUcTA+U8Hvlib
         kLcPG4X+aJbV2bKeDphA2dmXaSA9VCZj9cfFxLWUS+D6DzNrJ0WaQ+NUWCczXxIRcGO+
         Q0Gw==
X-Gm-Message-State: ABUngvcPlEbRnFSTuURkHc7UD80l7aLAdw6SpKSnLGaK1/ReRNrKG2nrA66sS+zhH+2nj/zr
X-Received: by 10.98.138.219 with SMTP id o88mr28056240pfk.52.1477683337069;
        Fri, 28 Oct 2016 12:35:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:e47d:3374:f047:d60a])
        by smtp.gmail.com with ESMTPSA id g196sm20693338pfb.43.2016.10.28.12.35.35
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 12:35:36 -0700 (PDT)
Date:   Fri, 28 Oct 2016 12:35:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] grep: enable recurse-submodules to work on <tree>
 objects
Message-ID: <20161028193534.GA151765@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
 <20161027223834.35312-6-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161027223834.35312-6-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27, Brandon Williams wrote:
> diff --git a/tree-walk.c b/tree-walk.c
> index 828f4356b..b3f996174 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -999,10 +999,11 @@ static enum interesting do_match(const struct name_entry *entry,
>  					return entry_interesting;
>  
>  				/*
> -				 * Match all directories. We'll try to
> -				 * match files later on.
> +				 * Match all directories and gitlinks. We'll
> +				 * try to match files later on.
>  				 */
> -				if (ps->recursive && S_ISDIR(entry->mode))
> +				if (ps->recursive && (S_ISDIR(entry->mode) ||
> +						      S_ISGITLINK(entry->mode)))
>  					return entry_interesting;
>  			}
>  
> @@ -1043,13 +1044,13 @@ static enum interesting do_match(const struct name_entry *entry,
>  		strbuf_setlen(base, base_offset + baselen);
>  
>  		/*
> -		 * Match all directories. We'll try to match files
> -		 * later on.
> -		 * max_depth is ignored but we may consider support it
> -		 * in future, see
> +		 * Match all directories and gitlinks. We'll try to match files
> +		 * later on.  max_depth is ignored but we may consider support
> +		 * it in future, see
>  		 * http://thread.gmane.org/gmane.comp.version-control.git/163757/focus=163840
>  		 */
> -		if (ps->recursive && S_ISDIR(entry->mode))
> +		if (ps->recursive && (S_ISDIR(entry->mode) ||
> +				      S_ISGITLINK(entry->mode)))
>  			return entry_interesting;
>  	}
>  	return never_interesting; /* No matches */

Looks like this change actually breaks a test in t4010-diff-pathspec.sh.
I think I'll have to add a flag to optionally let through submodules as
apposed to just treating them like directories.

-- 
Brandon Williams
