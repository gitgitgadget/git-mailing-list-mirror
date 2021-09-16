Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5765CC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0CE611CA
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345995AbhIPSsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241440AbhIPSse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 14:48:34 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046A1C10D651
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 10:24:37 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id h14-20020a62b40e0000b02903131bc4a1acso5429231pfn.4
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VXoKfmTd9qzEPpVoKtz2+2oTiD9zx54UdGNa/29Dqz8=;
        b=Ko5cSdEXxpcOkK41fwYzJrMmSwu3U1tunu3IcX6579jFUIqqTZ1tbp4SFc2Bbt8FQY
         uf2HJt/VOfDQ+dt2ACREG8XJkIq5kydrpqyAMUGc+40prtAbMG3rAUyG+/ORpgGiQ0KH
         pvZJLkdGXIuK6bCuE6LCvQbQaUM5uRlJwjwGC6KbNbMij6u9KGSeoAzjlgtbcFzPa7/J
         ojZtUHD8DJRIBFeXOdpbdLj0t5H9GJuIZwYs/o0RBUOndKeSfAWAeUC3FtHla+tE3K/o
         tcd3iBfR0DneOje7HHvI95trGnXrnl+tBBOu3+P9eQsjUcmfc3iq9toAUXU4dFCGOgi2
         kt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VXoKfmTd9qzEPpVoKtz2+2oTiD9zx54UdGNa/29Dqz8=;
        b=HpN8A4ZZmO6pJ6t2bsiqVhkDe6iPa9gLJvOPLQWILrmKipEF0buopc6L1MF2zwMoRp
         9iIPssYM96pbp5VYfZm8nOPvZFP05VYpuQg7/84YfD5ApKVAXdD+fI9whvLjXCj14Z8Z
         LtGAxLu4vGxYou/plZ1ZaJqSU1SGUMCmwsv+xyda06uPRQEpjKKlm6OhJLPGwWKGMwFh
         wScVA8nawGTn9Y/IG405iH3h7AqmYvJ6M1lqnhi5U9Et0YK9MDAQpEbH8OJr5vfCslF6
         cf2WkEnKrX3Yyqotg77o8Tz/fz/I0nIvh2hfMOOE8PkU8YKxoUR8rkvDACQLgPAV0aG8
         ifiA==
X-Gm-Message-State: AOAM532uCwZkKBh9/x0b7cF966TdgWBlnMqh0ZLPCeyPgztvrgzjrGTh
        8mWHEL94/G1QWRzuH+5FavgwIxRUHu+z9o8D8kIv
X-Google-Smtp-Source: ABdhPJz6ICyQe0CnKfJUIVjUePSslcZ9zmtj0RXWg3OOazDGarCJtLwiskID9FMDFhz6uHZtiM6yJsxULZ92JD1fL2Ln
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:184a:: with SMTP id
 10mr5919010pgy.149.1631813076469; Thu, 16 Sep 2021 10:24:36 -0700 (PDT)
Date:   Thu, 16 Sep 2021 10:24:32 -0700
In-Reply-To: <YUElL3RI0VTnjE5C@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20210916172432.1073546-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YUElL3RI0VTnjE5C@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: Re: [RFC PATCH 1/2] refs: make _advance() check struct repo, not flag
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, hanwen@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The answer to whether or not a ref store should refer to a certain
> object store seems unresolved because a ref store is trying to do two
> separate things. Perhaps it is reasonable to associate a ref database
> with an object store (so that it can validate its refs), but we would
> prefer to dissociate the physical ref storage layer from the object
> store. (I'm paraphrasing Johnathan Nieder here, this isn't an original
> thought).
> 
> Perhaps this is a question we want to resolve when considering reftable
> and other ref databases.

Either adding an explicit dependency on an object store to a ref store
or dissociating it would be an improvement over what we have now, which
is an implicit dependency on the_repository's object store. Of the two,
I also prefer dissociating it. In practice, if I remember correctly, the
part that checks object existence during ref writing is the last
dependency, so if we can eliminate that without a convoluted design, I
think it's worth dissociating.
