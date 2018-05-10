Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0021F406
	for <e@80x24.org>; Thu, 10 May 2018 17:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966683AbeEJRQV (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:16:21 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:46953 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJRQS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:16:18 -0400
Received: by mail-pg0-f53.google.com with SMTP id z4-v6so1232617pgu.13
        for <git@vger.kernel.org>; Thu, 10 May 2018 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nvr/7wzKRyu2nr4S+kuWO3xa1G/8sPQwKrRtrSgQP9k=;
        b=cpi8a4F88ecV+xZ+pcpmk7MO5iU0mkt1aM72L+9m8FZ440ud9m6PBBJDqAUL5c+MFR
         8BWXKA2LIZrzk99WpZNjBQKiPnEyStUhwfozArSwCzagg/OJ32TjlVA4oMmN0aIwsJoM
         1sqlIf1jz4OKSWYbd4cX056DJX7jRa20WzsqFJRUir+38gJ86xz3u0Y0oqgeXHwMt5kQ
         QAHK6SSfrbtAfiDVNCAZ0s2PkgmHXnQlx2hmvrP6anJOO6xql8YDdZ+tAEzV/FrznjN8
         j3RfWdTNCy8B9UicriSlYdyCJrSj/ASL1AlXjiOo1wNHt/ZWrfTKA64ZDDU2F6vsYsn4
         kJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nvr/7wzKRyu2nr4S+kuWO3xa1G/8sPQwKrRtrSgQP9k=;
        b=so4+gDd6LKjkWMGNlta6RKOoodN887Bkpeek7QD9BvdsJaS6wwwXFFllkAqzvv0xJn
         QcL92ZQbnBiAZ3RVKZKTPjkmgxlOLhrCRJVwE1uFtQSHr5+d+NdOy3OwSUKcRSBN4kvW
         YCGUEXBa0+Wawn94yYhdS8rG/+1b8DzTKvgqjazx2fLeiBBVLJfKtpGCHWy1vgGs0Fhi
         cfobu6RfEpycZyMHsAGilA3t8TMJlyAgISAMemKm8GlZZxLCATsI0dnGxG8lhNF5Ys+t
         DPIVEPlt98OVyvGQl3Z+de3Kvh0x6xd6s1mHLuhteYM0+14OWYkFWF+/5B+iTG9PhjGH
         94kw==
X-Gm-Message-State: ALKqPwdWqK6em5xBtfpBYlbmbuHEXoHsvg59l6iKnHlSHjubH5kEld62
        q7w2aN30PhoRFPWnQ8wsXEgnIEoUXZQ=
X-Google-Smtp-Source: AB8JxZpdKzdn/LSD4h668myO9LAOImHUtJXyGZKSWYTAQRPT0n5hfYqRgVIYQvKwGEOxPtzvaVxH5A==
X-Received: by 2002:a63:a41a:: with SMTP id c26-v6mr1798724pgf.311.1525972578234;
        Thu, 10 May 2018 10:16:18 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id r30-v6sm5744369pgu.89.2018.05.10.10.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 10:16:16 -0700 (PDT)
Date:   Thu, 10 May 2018 10:16:15 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        pclouds@gmail.com
Subject: Re: [PATCH v4 00/13] object store: alloc
Message-Id: <20180510101615.931eb0d219eac4c84cf8140d@google.com>
In-Reply-To: <20180510004024.93974-1-sbeller@google.com>
References: <20180508193736.14883-1-sbeller@google.com>
        <20180510004024.93974-1-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed,  9 May 2018 17:40:11 -0700
Stefan Beller <sbeller@google.com> wrote:

>  		if (obj->type == OBJ_TREE)
> -			release_tree_node((struct tree*)obj);
> +			free_tree_buffer((struct tree*)obj);
>  		else if (obj->type == OBJ_COMMIT)
> -			release_commit_node((struct commit*)obj);
> +			release_commit_memory((struct commit*)obj);
>  		else if (obj->type == OBJ_TAG)
> -			release_tag_node((struct tag*)obj);
> +			free_tag_buffer((struct tag*)obj);

This might seem a bit bikesheddy, but I wouldn't call it
free_tag_buffer(), since what's being freed is not the buffer of the
object itself, but just a string. If you want such a function, I would
just call it release_tag_memory() to match release_commit_memory().

Other than that, all the patches look fine to me.

Some optional comments (this is almost certainly bikeshedding):

 - I would call them release_commit() and release_tag(), to match
   strbuf_release().
 - It might be better to just inline the handling of releasing commit
   and tag memory. This code already knows that, for a tree, it needs to
   free its buffer and only its buffer, so it is not much of a stretch
   to think that it similarly knows the details of commit and tag
   objects too.
