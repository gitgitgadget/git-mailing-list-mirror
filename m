Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE871F461
	for <e@80x24.org>; Wed,  4 Sep 2019 22:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfIDWfd (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 18:35:33 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54512 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDWfd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 18:35:33 -0400
Received: by mail-pg1-f201.google.com with SMTP id m17so55973pgh.21
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2W1UNpE5moMMU2p4ISunGo0f0ZBX60NROWvQ7AMbGng=;
        b=jDt6s7n/PY1F7O9e5+CP4COlXvHszNUhyUOBmbK5HAXSo+47Lq7ZSErFJ6u1dbEnwS
         aPmZ0ImCy0RvBmIzjCiBtWS7kAEpy74IU2FnrtEca7D8Da9RX10lsAfNNGNaPqiMb5ml
         l75T8t6IVe0O2ZMPuMHCJjPOL/Q0V/1aKN6hq8muT7v7qXfVJylicCcbWMGHfs3gyPfG
         N7TZyxohLEdFfzWFVkhD8P6JAOCejSr6QORD/d/xdocMYLEtfNIrIXiTinUDsKKZIZFt
         sXgsdDRFIwWa3us2zLhEcS4JChaud7EnPEWoIOO7+4jFFVpHVo28mJ1lQxA5k7aEN8Pv
         uk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2W1UNpE5moMMU2p4ISunGo0f0ZBX60NROWvQ7AMbGng=;
        b=dj5Hp1VwTUzPLszQJmDkTlJQCBtVr1VjZdyQYd+ByeKvr0533htTfxQl7QaAWOX0Ga
         4NYmgm9KYWs5m6EVZIJSHK4g4IpU/ngtyWlnvsGSoLjze4IvFhMqX0yX3UutPnhpMvj/
         V1hCC0c7TJC9Yi5qkG8n1v/4kvLkL+joGu1oaXriXmxc5oXLok0c9qMgd2KxLcLjYkFs
         SLD6y832lO6XGwMb1fZV9h9lKobjHWprFB4yRp72vsGTAPW0A6EhPvuwRQ0qtdUJjlVw
         gFb5FQ7sU+OICOPmwQK7o215rwEvUxAXvoyMPITc6GGtYp2ig+2YPah5989+w4QYEC3r
         BmLQ==
X-Gm-Message-State: APjAAAURv1QQd2pcmrl/lilA2bAjo+p8k6bdWdpNre9qRL/Al80+UbjF
        rhh0e5wNvJIHKeBb7oO3/1uE1drKIGKVvQ636drm
X-Google-Smtp-Source: APXvYqz32MQ/uKmRKugbd1+mjOOYr+bZkso08flY7Vrx83P5oUyBPr+7dRQGoobd7M/rieiP5VsvfKROCIuKEIkja6Mh
X-Received: by 2002:a65:448a:: with SMTP id l10mr363355pgq.327.1567636532385;
 Wed, 04 Sep 2019 15:35:32 -0700 (PDT)
Date:   Wed,  4 Sep 2019 15:35:29 -0700
In-Reply-To: <69f2b069-3e11-4a2e-9b81-bde18c463d8c@gmail.com>
Message-Id: <20190904223529.135623-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <69f2b069-3e11-4a2e-9b81-bde18c463d8c@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: Re: [PATCH] cache-tree: do not lazy-fetch merge tree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 9/3/2019 3:42 PM, Jonathan Tan wrote:
> > When cherry-picking (for example), new trees may be constructed. During
> > this process, Git checks whether these trees exist. However, in a
> > partial clone, this causes a lazy fetch to occur, which is both
> > unnecessary (because Git has already constructed this tree as part of
> > the cherry-picking process) and likely to fail (because the remote
> > probably doesn't have this tree).
> 
> If we have constructed the object already, then why do we not see it
> and avoid fetching it? This must be a slightly strange timing issue
> with objects being flushed to disk or added to the object cache.

Thanks for taking a look at this! The answer is that I wasn't precise
when I said "already constructed" - I meant that it is in a struct
strbuf. It hasn't been written to disk yet, so has_object_file() does
not see it.

> One approach is to find all of these has_object_file() calls that should
> really be one with OBJECT_INFO_SKIP_FETCH_OBJECT. Another would be to
> find out why has_object_file() isn't seeing the object we constructed.

By the former, do you mean that we should look at the other
has_object_file() calls? I looked at the others in cache-tree.c and I
think the one in this patch is the only one that is called on an OID
generated from hash_object_file(). (And I answered the latter in the
above paragraph.)

To avoid confusion, maybe this commit message is better:

When cherry-picking (for example), new trees may be constructed. During
this process, Git constructs the new tree in a struct strbuf, computes
the OID of the new tree, and checks if the new OID already exists on
disk. However, in a partial clone, the disk check causes a lazy fetch to
occur, which is both unnecessary (because we have the tree in the struct
strbuf) and likely to fail (because the remote probably doesn't have
this tree).
