Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5680D20281
	for <e@80x24.org>; Tue, 26 Sep 2017 22:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031067AbdIZWbo (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 18:31:44 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:52842 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967947AbdIZWbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 18:31:43 -0400
Received: by mail-pf0-f177.google.com with SMTP id p87so6230168pfj.9
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHOfYj/fCsBWpdu4RiFoP5GKyqlkHmg3cagUOzGKjh8=;
        b=TPg/TvAh4nJEGsrwWDPEZUfoPJMVhUcuOZML+2t8HIWBSUxWKv1heyM2D+U4/QMFnZ
         DYyy61EI1ZLK7ajJdSaecTsvjSivwSvgZvxnnZ3NJ28TzmAkh6GYb05J4d+Evq9z48/l
         2u/qXyaqWsgyfEaIRGEULOXeJLgt4krOZh0BAUGrK4PmyS2gnh/dW6kAhXh6sNktpoEd
         guIkWfJ69QW7ANmmW3HGT47Zpf7ReQuMQXCofFOfLdOswkhCD4d0/YkMad5AdJ2mmKa5
         DF4ZK6FgRrwvqbdCdZmtwjexkL6BZh+mDJZUa0+DgZGLl2z4xq9JEE2Mvvaosa6OtIrD
         NqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHOfYj/fCsBWpdu4RiFoP5GKyqlkHmg3cagUOzGKjh8=;
        b=jmIx6lqEK1hdzZ/8QoWNhJj6GnFsGVsFBK+eYlvtRoE3z3T1XPk/2+WKIZufvoazva
         P4aieF+AZL89EmxzdO8rbgbi/6cdzTwPo5mtYQvtvCsHcxSo8cQwZliBZCtyEBOwBnNx
         k3VdSilVKVZIXqu4rg6ezHRie9S0dUJxXy4x5c91yg7WFS8YlmArZFvApyfcXitpwpOz
         FE341C47Mp18BboBtbXq2DI8Ibw00H9jzhA8ERJzhaxQA2jHoCGLp52xxPrgi4VsVULq
         Q8I2RyLtdAiYL8ToTAIkjTN1JD32BO+nataqeri3dcrtu0HLzqH3PHLXTDOpRMqcuG5B
         2lMw==
X-Gm-Message-State: AHPjjUjyKN7YSHtdjVT0y7I7XAfEZgogCwCsIyvRI4X1GxZo9A4mTIlv
        RgC/xn9EVRVooaWhqTffqeoBsw==
X-Google-Smtp-Source: AOwi7QAqBw9gHyoNB2um0OeXT1oxRG7l9zckrdz5p4XD4Q4VbcXpdxJyIyAoyPr0emThMAbKsnwgmA==
X-Received: by 10.98.155.139 with SMTP id e11mr12236063pfk.290.1506465102746;
        Tue, 26 Sep 2017 15:31:42 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:51cf:598a:e16a:8a0b])
        by smtp.gmail.com with ESMTPSA id j10sm16796473pfj.116.2017.09.26.15.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2017 15:31:41 -0700 (PDT)
Date:   Tue, 26 Sep 2017 15:31:41 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jeffhost@microsoft.com
Subject: Re: [PATCH 03/13] list-objects: filter objects in
 traverse_commit_list
Message-Id: <20170926153141.6a8d7e5024eeed5bbda838c8@google.com>
In-Reply-To: <20170922202632.53714-4-git@jeffhostetler.com>
References: <20170922202632.53714-1-git@jeffhostetler.com>
        <20170922202632.53714-4-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Sep 2017 20:26:22 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create traverse_commit_list_filtered() and add filtering

You mention _filtered() here, but this patch contains _worker().

>  list-objects.h | 30 ++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 16 deletions(-)
> 
> diff --git a/list-objects.c b/list-objects.c
> index b3931fa..3e86008 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -13,10 +13,13 @@ static void process_blob(struct rev_info *revs,
>  			 show_object_fn show,
>  			 struct strbuf *path,
>  			 const char *name,
> -			 void *cb_data)
> +			 void *cb_data,
> +			 filter_object_fn filter,
> +			 void *filter_data)

I had some thoughts about modifying "show" (instead of adding "filter",
as you have done in this patch) to indicate to the caller that the
corresponding object should not be marked "seen". That does have the
advantage that we don't have so many callbacks flying around, but it
also makes things more complicated, so I don't know which is better.

> +	if (filter) {
> +		r = filter(LOFT_END_TREE, obj, base->buf, &base->buf[baselen], filter_data);
> +		if (r & LOFR_MARK_SEEN)
> +			obj->flags |= SEEN;
> +		if (r & LOFR_SHOW)
> +			show(obj, base->buf, cb_data);
> +	}

This LOFT_END_TREE was added to support the code in
list-objects-filter-sparse - would it be OK to completely remove the
optimization involving the "provisional" omission of blobs? (I don't
think the exact same tree object will occur multiple times often.) If
yes, then I think this block can be removed too and will simplify the
code.

> +/* See object.h and revision.h */
> +#define FILTER_REVISIT (1<<25)

If you do add this, also update object.h. But I don't think this is the
right place to do it - it's probably better in
list-objects-filter-sparse.

> +typedef enum list_objects_filter_result list_objects_filter_result;
> +typedef enum list_objects_filter_type list_objects_filter_type;

I don't think Git style is to typedef enums.

> +void traverse_commit_list_worker(
> +	struct rev_info *,
> +	show_commit_fn, show_object_fn, void *show_data,
> +	filter_object_fn filter, void *filter_data);

Here (and throughout), as far as I can tell, the style is to indent to
the character after the opening parenthesis.
