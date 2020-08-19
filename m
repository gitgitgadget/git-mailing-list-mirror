Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BAEC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 00:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708D02075E
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 00:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dnr+jZO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgHSAAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgHSAAT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 20:00:19 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A5C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 17:00:19 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id c3so13086589pgq.9
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Xh5cz9zd5/HOkeeX9R9Epx8lgT7GpM/J6XZAD/hLpfo=;
        b=dnr+jZO5r+s5HFhc60HkXUnCIFJlISZVKcaR6yS9gRBk8IuRTKddy0eaYmgWlx18JK
         ftBzDE1WbfIOWGKCwx8/rO53HCdrwA/B+9vQ/YiDIDKquOg+HoiQEWNMaPjVJCinpe2B
         sxfdh5kjvxKVCxGNXDr3z+zffamxbByHCpr8rbSquRBZWefqvNM5HJMETFoIarF8oo+k
         cxZePcv5ET/7SQUl7C1SQ1CUiVXvBvpoE2OqNULoViqLjxfQ7SOz51Ph+9fLquuhBOds
         uRs3WpvDeGIuNHdObOLmuuVqg5K11C+arFAPP1fL1bveXMiC6agfrMFiuzyZlqpiL1G5
         fMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xh5cz9zd5/HOkeeX9R9Epx8lgT7GpM/J6XZAD/hLpfo=;
        b=iADy+UmFFbFptbfCHPBsJ18BhswisbLDvZ9bOxagE8EiUStmLM/ro9y6C7Fh1QHv2u
         i28WnPnk7ld4IeNTCDvoI3iG66Q4/nH77NgY8bhv9jLzD/Lx8/WqXRcapxH38rBBG+92
         d3Ch7u4+CB8MbWB43+u2rYaGHaLjVUHkoyGIPXNHxtrw6fjbD71qmhJw7WEwm5IVuVT7
         hk3DmnLyn6uPOh2y9aduubSvw0HdxGTBumTCN0I2E4ZtInRaZE5hnydfewD/IOmw67ya
         sMHni3p+ytNVoPI7SXnI0zOpVQH6HMLvYEqh0CLjpZugZyphkUUgn10seierVlgtf0Er
         TPhQ==
X-Gm-Message-State: AOAM530Qv170UYPj97KE/04x9JLltMeXyiYbiJO86EvNNZZ0dEge4SU+
        aXklxE5DlD5r3LB+oAagA4dID62yw48RM6pu1jzJ
X-Google-Smtp-Source: ABdhPJw9mqyqgpsICE4c+FmNCLXs4ydYebYjm6TwzSJkVaJQ0fRF+pxfJFcZxKZW7Wdv9igy77CYH8xkxyF46NB1J4ds
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:bd82:: with SMTP id
 z2mr423149pjr.1.1597795217844; Tue, 18 Aug 2020 17:00:17 -0700 (PDT)
Date:   Tue, 18 Aug 2020 17:00:15 -0700
In-Reply-To: <85268bd53ef7f4e7b3d97a8ae091290e8e74441d.1597760589.git.gitgitgadget@gmail.com>
Message-Id: <20200819000015.2838345-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <85268bd53ef7f4e7b3d97a8ae091290e8e74441d.1597760589.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: Re: [PATCH v2 06/11] maintenance: add --task option
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -66,6 +68,10 @@ OPTIONS
>  --quiet::
>  	Do not report progress or other information over `stderr`.
>  
> +--task=<task>::
> +	If this option is specified one or more times, then only run the
> +	specified tasks in the specified order.

We should list the accepted tasks somewhere but maybe this can wait
until after part 2.

> @@ -791,7 +791,9 @@ typedef int maintenance_task_fn(struct maintenance_opts *opts);
>  struct maintenance_task {
>  	const char *name;
>  	maintenance_task_fn *fn;
> -	unsigned enabled:1;
> +	unsigned enabled:1,
> +		 selected:1;
> +	int selected_order;
>  };

"selected" and "selected_order" are redundant in some cases - I think
this would be better if selected_order is negative if this task is not
selected, and non-negative otherwise.

Apart from that, maybe this should be documented. It is unusual (to me)
that a selection can override something being enabled, but that is the
case here.
