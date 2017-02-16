Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17A11FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 18:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbdBPSBX (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 13:01:23 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33355 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933001AbdBPSBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 13:01:21 -0500
Received: by mail-pf0-f172.google.com with SMTP id c73so7211783pfb.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iTdaNPk6d0i87IflWjkbif6bfyRGBtjhVyIlz/zdllo=;
        b=eLhcRLhtTJ6tFl6IfC/SO3hd6Kp9brJLVyzqm5WC9mhbAw+6g0oR+hnamCxug5xtPh
         jt2eW8DPxIYjnEdRIyVqkCk97Mibkp06casZczt/wvpL6ZHi9dp8diOaR+aIlHoh1L5E
         YjLj976MrWpiiUnlQL5pQQG1lo7N1yYfYRKMVp0YrM3Q/x2XH71s65L4UXtRH/U0xi5B
         Opebl2H2/SHwkL6FqhryMqMVmxhRHLc53Gq6zmlBI+FjDasNf7v4ZquOwj9umDpz13OH
         oqn/PbKbSlx4xfN4KEQFN/ked4lf1vzh5039tsm8m9iSiaWPKuzEoBaxWoU75Tj6XCJl
         K66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iTdaNPk6d0i87IflWjkbif6bfyRGBtjhVyIlz/zdllo=;
        b=echXGHJQK723eLtMc1JhK979ZN1xgU2OuWI+voaB727ZNl5cIEgiPCoTqElvfRSSZN
         rcx0Dl4kSWzTEO+EXIn7mEBSHK9JWpWYOn2N/nOVN9wMxzsOayb8TKSf/zy/xH27DaY8
         s6ImHIlZykWSjrORhcigjuocFL+nOMSKsynjaOVhkQEUX2mAoEHSiZlpGvxMpWDiYlMn
         QS+c/gIDa1vZX+yLARX4whLg2QmJV/otRbtv8G1IKa8oYKb2mnyvK7yJyr7F1Ge1ZRcs
         tSAE4m24RBebgBaK1gJTlGlRGO3VYZTvn/EZd6xWRs2VjKbdEQfMjX6p0J5t691whUVL
         Gr5A==
X-Gm-Message-State: AMke39kyneuvKbys62IEVL/dGGzZMq5r/GWUPBKdr1WwswIMoQJRNyUSwH76xYV+tIOxzpSv
X-Received: by 10.84.131.36 with SMTP id 33mr4949277pld.45.1487268075556;
        Thu, 16 Feb 2017 10:01:15 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:e041:12b6:2a42:f1dd])
        by smtp.gmail.com with ESMTPSA id m12sm14970526pgc.46.2017.02.16.10.01.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 10:01:14 -0800 (PST)
Date:   Thu, 16 Feb 2017 10:01:13 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 12/15] unpack-trees: check if we can perform the
 operation for submodules
Message-ID: <20170216180113.GA158636@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-13-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216003811.18273-13-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/15, Stefan Beller wrote:
> +static void reload_gitmodules_file(struct index_state *index,
> +				   struct checkout *state)
> +{
> +	int i;
> +	for (i = 0; i < index->cache_nr; i++) {
> +		struct cache_entry *ce = index->cache[i];
> +		if (ce->ce_flags & CE_UPDATE) {
> +
> +			int r = strcmp(ce->name, ".gitmodules");
> +			if (r < 0)
> +				continue;
> +			else if (r == 0) {
> +				checkout_entry(ce, state, NULL);
> +			} else
> +				break;
> +		}
> +	}
> +	gitmodules_config();
> +	git_config(submodule_config, NULL);
> +}

If we are reloading the gitmodules file do you think it would makes
sense to add in a call to 'submodule_free()' to clear the cache used to
store the gitmodules config?

-- 
Brandon Williams
