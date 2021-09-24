Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744D0C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A59660F24
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbhIXSaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345018AbhIXSaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:30:13 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F3C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 11:28:40 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n15-20020a170902e54f00b0013b7a095210so3693526plf.15
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UUpEPuwLssKhWPCEkfQGGlORuIKqVUWEfAD2xsNXYKY=;
        b=mX3JqfrfL85eJereOaoUHGucQCBxJoIAVZfd7acofGpsAG604eES2hR1T3qj8PSwEp
         UQ7z1sq6NOuObg0kl6y6pQJEd67ddxItaNoSem7kNE3VbG3/JYthqVwbHN5CHc0Cx2Bm
         tOAerz9mqcxR4UqoKNFR5oXHhYnuTcekWz5k0vwHlm6ejE2n0ceo4VexZIe5jkaFNGh/
         FnXDKxkXQJC9EcIOn+xN/zbD/eMDdEA2NzwOqXgGU7v65obRpE2YYnyKUtwE/URXjZpF
         57Tl4+8N+CWw8aWq8EE4KwnvqphQ7cdWweD3x5Pl1LVXYOrmGrOeo7YXG4gwpE1R50sO
         7cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UUpEPuwLssKhWPCEkfQGGlORuIKqVUWEfAD2xsNXYKY=;
        b=hk28CDWhpOO0zmwvd/azU2mwww4NhbZYnWOP3GKENwiesLNerm4XxxLBN1LnzbwHv/
         Tw6HjzszxoKnaJoR4RQsA4BIaZvGvgw6raJSPQ+rsI9tqARfOvlQyOUShhU2mO6dbZPr
         P6tjdOCTxNl4GJazf6VRVlKPI9vua+Pxwv9LGfNKo2tuWSNrqc+ZC4ocXXpGKGD649yA
         r46JZT3Fb0X0iahdBYiVqRGYLAZFM16EgRMMcQaETWptO0JolBWUfRIuArl29CFYj4xa
         eXv19leMG3qnsPEXpvh2OynyZ+wYD+25TxIhDg7w/hj9JIdmnkpUNX7kcRTBQk++Ib0U
         EA+A==
X-Gm-Message-State: AOAM531EM4WF3l06rq2EVMX7CRiBiCmVau+yJwTa+I6H2WJu7RVdw3Uu
        uIWQweuHSVpTx5/liUoEQx3v0roWAv63084GPchp
X-Google-Smtp-Source: ABdhPJwy5lbSQuq3qXVs79D3US9iEB02gN128ShoUs2eZ3ENJpV/9oza+m0Zd2vzXrwLIbiDwd2aNfYaTZJoQ4HLk3e8
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d902:b0:13d:9b9d:a5f0 with
 SMTP id c2-20020a170902d90200b0013d9b9da5f0mr10341602plz.25.1632508120041;
 Fri, 24 Sep 2021 11:28:40 -0700 (PDT)
Date:   Fri, 24 Sep 2021 11:28:37 -0700
In-Reply-To: <YU4VUF17tyG2AZi3@coredump.intra.peff.net>
Message-Id: <20210924182837.2923447-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YU4VUF17tyG2AZi3@coredump.intra.peff.net>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: Re: [PATCH 1/9] refs: make _advance() check struct repo, not flag
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think your goal here of passing around a repository object is good.
> But rolling the meaning of DO_FOR_EACH_INCLUDE_BROKEN into an implicit
> "do we have a non-NULL repository" makes things awkward, I think.
> 
> As you noticed, we can't get rid of the flags parameter entirely. We
> still have DO_FOR_EACH_PER_WORKTREE_ONLY. But I also have a series which
> adds another flag which pairs with INCLUDE_BROKEN. Having half of the
> logic implicit in the repository pointer and half in a flag would be
> weird.
> 
> I'll post that series in a moment, but what I'm wondering here is: would
> it be that big a deal to just pass the repository object around, and it
> is simply not used if INCLUDE_BROKEN is passed?

Quoting my response to Junio (sent a few minutes ago, so you might have
not seen it) [1]:

 so that callers that don't
 want to access the ODB (all the callers that currently use
 DO_FOR_EACH_INCLUDE_BROKEN) can be assured that the iterator won't do
 that. If we had a non-NULL "struct repository *repository" parameter, a
 future code change might inadvertently use it, thus causing a bug.

I'll take a look at your series when it comes out, but from what you
say, it looks like we should pass a non-nullable repository and keep the
DO_FOR_EACH_INCLUDE_BROKEN flag. I'll update this patch set to do that.

[1] https://lore.kernel.org/git/20210924175651.2918488-1-jonathantanmy@google.com/
