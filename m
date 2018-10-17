Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC75D1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 21:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJRFYC (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 01:24:02 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49032 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeJRFYC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 01:24:02 -0400
Received: by mail-pf1-f201.google.com with SMTP id b27-v6so28137971pfm.15
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ocFrbvjzE1punsx4qNbJ1xDOSE2GZon1uPt9/fIxDBY=;
        b=ZRChDnQdcl4672Bvqn9uesHejA6upwUBIE9CAkh6YSMK9d41YMXWls/9/6lX18LzKL
         gpYdk88ibeC+x8+wd/TtV0lAZ8fOGPJU58ll2+FgFDKBUejqEkD8M+gz7Oqol/N8hLxw
         ALt+ljlAGZ062wlUJsmbVZgRzcZu1TMLzAhIplJFwThMAT4DaluzrS2zSmVd19WLbJjt
         6ZP7G0+/p/bpArYYfxivpPQ+H7tusjti+cfmPZ+/bHi9DFa3N4BE6owFy+YfYJ4Y7Pib
         JAshl5GrJX4ulpoNBBbe6Q/p1syFOCqqmYgcsBBZ1MEJxjaXylzFnJ1tlMQc/BHswTUF
         8XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ocFrbvjzE1punsx4qNbJ1xDOSE2GZon1uPt9/fIxDBY=;
        b=bh9F9EMOUC3EbnWjUYNkZCMhTFlZnF8+QGw56EzlHBEBnPBlv+TJDF44pL8VXmDJqr
         hEuZlEff0MceUkVEpKb9j42j29DFGT6quzQHbOOxZqTRl5AdhC1Sg/ZrSNeMwjhsHBAU
         xKy3U2Wig5gvtqIz6NOmmiqEBjE5r9YX4f1psrE9StxJAZi4Jt07GIR1PEiWg6wwhcTy
         nPYTSROSrS0U6ulAcJpwaNsJQBPMlMpWHF3iJnyXdf+F3Dw2zCypm4Gb0NPkl/ytiFoJ
         67PaiAatgWhLhoWXPQuAY4Xve6jKLxt1xMOhyVxZFvmmEfgXXFkS+fkJ6gIrUC58QhHW
         9S3w==
X-Gm-Message-State: ABuFfojE5cXy0yr7VIm8BBVOGQ2KcPefMXmDIwS0+zWXv+1IKakwcvuB
        h8GJ+15CdLZtyqQ1tC572grbdxIXcBeIIq50qOqq
X-Google-Smtp-Source: ACcGV60Q6x52kShw64V13h2lGDaDFreE+rJN8QaW4mEYScGSbsojdvnBHmnRlasnT2BVv38u9R1VZJsdIZ+Hi7CFf5uL
X-Received: by 2002:a63:2941:: with SMTP id p62-v6mr13478027pgp.23.1539811587787;
 Wed, 17 Oct 2018 14:26:27 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:26:24 -0700
In-Reply-To: <20181016181327.107186-5-sbeller@google.com>
Message-Id: <20181017212624.196598-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-5-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 4/9] submodule.c: move global changed_submodule_names into
 fetch submodule struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The `changed_submodule_names` are only used for fetching, so let's make it
> part of the struct that is passed around for fetching submodules.

Keep the titles of commit messages to 50 characters or under.

> +static void calculate_changed_submodule_paths(
> +	struct submodule_parallel_fetch *spf)

Instead of taking the entire struct, could this just take the list of
changed submodule names instead?
