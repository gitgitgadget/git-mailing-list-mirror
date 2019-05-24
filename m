Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD6C1F462
	for <e@80x24.org>; Fri, 24 May 2019 00:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388561AbfEXAtp (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 20:49:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36183 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387613AbfEXAtp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 20:49:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so3426339plr.3
        for <git@vger.kernel.org>; Thu, 23 May 2019 17:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RWncO2dmUBjbLqC5c6iyC4bxGx4UCXYdkv6N4NbR5qk=;
        b=bdZhFr1Q8VUpgZQA+Lg1VvWzCmC9uGO/f3N8fBTu2w2KENaQj6Uyx9JqXYQzMgFWJT
         KOSLUHJdPBJSuFeKF7DidiMaXoH2Q+i2/bSC2bZaufx9HZa2cJDEz/jvywyi8BCTvc4o
         5UClmt0h2XCso/W1lRnuc7ftywBipjBA/S3JitFspoZq9s6ea4akDQlCxOsXWn6Y9g/M
         jKMm07kji6QZAsi6JLu3zo8es8OK1WIwzMxg8b1nReTK7T4rt0bBTEw4fNPFqDOBT/BN
         N+l4QN4yOLXGqjplVFWVnc1ni86a2BaGB6Qtht6EdvqM6TvIKN+Z1X/uUqBNNk0izcKg
         8gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RWncO2dmUBjbLqC5c6iyC4bxGx4UCXYdkv6N4NbR5qk=;
        b=R52VKdYQGoZattgWuc3gU3Bo5XUB5TkgZZtexdgXAv/QM+AihjHI/OViEax4AuLYzn
         Uy1z2v0j2/zQCoFvOzNe54mRE4izGLA1IN1iHXyq4TMMqKAH4ft+pKyVFuEqH4KDphd9
         ytiRU7gWN59F9HkxJNf/GMukOuw5ccPse1HMxYD+BTJ0moOoxIpTlC26K8NAcN2RiXnD
         qe3i6lKdxTMweb18uNBOFiiv90Wes6zuhRrUrnps4PWnfWfbA6o0G3ctFaj3MnAkwAYH
         BAjGH8xDtjR/Dw30Tf65RH+01mhNk3TeIfrvhhXSC5gqu2JjwiiOvOvO08XKMHej6kxD
         15CQ==
X-Gm-Message-State: APjAAAUxnlC/pgYlNviXaApcDooSE8pBa3NDy4zVrB4DC/QRZP5COXqA
        pDuf8sZ7f5CfwMP903gEYFjBeA==
X-Google-Smtp-Source: APXvYqyFuqR5aZ9LY+tV6cSyVguapJsF/VHMubq9IODFJWOpvCrxlrQE/dyuxPvFUTPg8HuFEM9o+g==
X-Received: by 2002:a17:902:a505:: with SMTP id s5mr12037383plq.54.1558658983925;
        Thu, 23 May 2019 17:49:43 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id k6sm627780pfi.86.2019.05.23.17.49.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 17:49:42 -0700 (PDT)
Date:   Thu, 23 May 2019 17:49:38 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, matvore@comcast.net
Subject: Re: [PATCH v1 1/5] list-objects-filter: refactor into a context
 struct
Message-ID: <20190524004938.GB46998@google.com>
References: <cover.1558484115.git.matvore@google.com>
 <341bc55d4a3f5438b1523525cf683f96d75e8c3e.1558484115.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <341bc55d4a3f5438b1523525cf683f96d75e8c3e.1558484115.git.matvore@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 05:21:50PM -0700, Matthew DeVore wrote:
> The next patch will create and manage filters in a new way, which means
> that this bundle of data will have to be managed at a new callsite. Make
> this bundle of data more manageable by putting it in a struct and
> making it part of the list-objects-filter module's API.

This commit message might read more easily on its own if you define
"this bundle of data" at least once. Since there are things being moved
from both list-objects-filter.c (filter_blobs_none_data) and
list-objects-filter.h (list_objects_filter_result and filter_free_fn)
into the new struct in list-objects-filter.h, it's not immediately clear
to me from the diff what's going on.

[snip]
> -static void *filter_blobs_none__init(
> -	struct oidset *omitted,
> +static void filter_blobs_none__init(
>  	struct list_objects_filter_options *filter_options,
> -	filter_object_fn *filter_fn,
> -	filter_free_fn *filter_free_fn)
> +	struct filter_context *ctx)
>  {
> -	struct filter_blobs_none_data *d = xcalloc(1, sizeof(*d));
> -	d->omits = omitted;
> -
> -	*filter_fn = filter_blobs_none;
> -	*filter_free_fn = free;
> -	return d;
> +	ctx->filter_fn = filter_blobs_none;

I think you want to set ctx->free_fn here too, right? It seems like
you're not setting ctx->omitted anymore because you'd be reading that
information in from ctx->omitted (so it's redundant).

>  }

[snip]
> -/*
> - * A filter for list-objects to omit large blobs.
> - * And to OPTIONALLY collect a list of the omitted OIDs.
> - */
> +/* A filter for list-objects to omit large blobs. */
>  struct filter_blobs_limit_data {
> -	struct oidset *omits;
>  	unsigned long max_bytes;

I suppose I don't have a good enough grasp of the architecture here to
follow why you want to move 'omits' but not 'max_bytes' into the new
struct. Maybe it will become clear as I look at the rest of your patches
:)

>  };

Most of this patch looks like a pretty straightforward conversion.
Thanks.

 - Emily
