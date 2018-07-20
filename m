Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1AF51F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeGTUnx (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 16:43:53 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34421 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbeGTUnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 16:43:53 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so5614599plo.1
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QaQKw8H4eqwAfEWZY6W8FeRxf323pXr1ztLakEHuPUo=;
        b=uQdhJokZXBM3nl5NYDUwmILtPa192KPHx1ZvNiDTp3x5qSgiGTK+vdBA38BCi4guJ6
         u27TRkGAtsNeCwKewdL69gigLxnOK+IJtVa7npA+XQ6jeMFkg59nDKT+ZOQdNaRp1tVD
         jejRrBgtMyWACAo7C92h+q4R9orD16CDtD2oy2o+16vVXo3rjwG/XWl2Gip+J33oPndh
         7UJv81WfQjBjjzI+dBNSH5b+Lv5kzENIOJlepgGW2+OUJPrG4kQe1eMjeNAjbPmoyU0d
         bDeHw+gHxIq3boR2zROxACZXuxUrvnnZeEaz+nKZg2ML2WvdC5RVE540yoldX7/IP4TF
         WVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QaQKw8H4eqwAfEWZY6W8FeRxf323pXr1ztLakEHuPUo=;
        b=Cdgo98Lxd1AitDvni6PocaLjfzyXolXTmu045dEioKSHwWiFOKxpsV4rQA654ZdcY/
         jM7F6yToSu29bhwcgd+3a3k8hXG4Zwi+7KAW0hzmm9LhIaiqLiCK3X1iOy9HKiQxDf4B
         09pIN4xd1UWXU4kjL9dOdVAjmBo3inGo4ygPBPwysMEtaEskj//BkfPIYks5IiwzOOlB
         lDsBwdlzz7J6CcPyZ3qBay4hw3A9aRp89eYExuETo8ii5MVD0djoE9rHPan57F75J2I6
         tL+PCXyZNWsI1U5Dl8L0vrzQSuqKeqLIQ/em9A/ncvGfsL42AEGj1oxjhCHzj7LL3S2n
         gffA==
X-Gm-Message-State: AOUpUlErVLvKGFvFWwBJNXEOtLsBgOgr2YnSvN+C56h0P5U0OY6bKnLr
        taU9P3SRpMQmIxzaYLpRjcA=
X-Google-Smtp-Source: AAOMgpd5d1LfEoK1Chx/t2CBA2Kou28yetjiimJBBveedGYBm0SGAcw9j6VgnbnB+O2A81ehTN40vA==
X-Received: by 2002:a17:902:8308:: with SMTP id bd8-v6mr3341257plb.329.1532116447500;
        Fri, 20 Jul 2018 12:54:07 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e24-v6sm3339693pfi.70.2018.07.20.12.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 12:54:06 -0700 (PDT)
Date:   Fri, 20 Jul 2018 12:54:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: send ref-prefixes when using protocol v2
Message-ID: <20180720195401.GA83654@aiede.svl.corp.google.com>
References: <20180720192749.224284-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720192749.224284-1-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
> Noticed we miss out on server side filtering of refs when cloning using
> protocol v2, this will enable that.
>
>  builtin/clone.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Nice!  The implementation looks good.

Can you add a test to ensure this filtering doesn't regress later?

[...]
> +++ b/builtin/clone.c
[...]
> @@ -1134,10 +1135,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (transport->smart_options && !deepen && !filter_options.choice)
>  		transport->smart_options->check_self_contained_and_connected = 1;
>  
> -	refs = transport_get_remote_refs(transport, NULL);
> +
> +	argv_array_push(&ref_prefixes, "HEAD");
> +	refspec_ref_prefixes(&rs, &ref_prefixes);
> +	if (option_branch) {
> +		expand_ref_prefix(&ref_prefixes, option_branch);
> +	}
> +	if (!option_no_tags) {
> +		argv_array_push(&ref_prefixes, "refs/tags/");
> +	}

nit: no need for braces around one-line "if" body

Thanks,
Jonathan
