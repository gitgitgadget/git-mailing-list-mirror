Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C953CC48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC197611BD
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhFUSd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhFUSd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 14:33:28 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6508EC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:31:14 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id n15-20020a65488f0000b02902221a44f1d1so5620141pgs.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zwgGKepO05GnTuSo9LMb6Xl1QtneHpqPsMw6CK7c39Y=;
        b=DKCWmBAaF791uU0T0y5gViDKI1MdoPi36c6+9MxdPCHVqSWF4HPp0w450yipr5q5cg
         W6azfwD24VbnVP657md3avoqcrElIbi1Aok2A31900G6NqBknchQ47nnb2/u9Le4ygD2
         GXQfovnTsNUARfBVTm6EJWM4peNntjdQ9Xw/5SUNiSnYeU6n9h3iBpT8srwLGl5a81oD
         0+AKkEm87EV3tj3BW4mrILyFfdNPyYsPWZQEpcoQOH3DJ5GhimyZialBhV/cT4qURmBl
         ozStHNoCFp2lAk9nVXvPIHd5KAdfLnpN1KRRsYtJ5N6ly50OB88sVid9Gh+/TURI/bBH
         EiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zwgGKepO05GnTuSo9LMb6Xl1QtneHpqPsMw6CK7c39Y=;
        b=ZXRSWvXxCnBpiid0F7H1J9xtTWumB0ibzzwOmeZMaMt1oejhPB9tlKc6ovzcFKDDEH
         PX2eBOICSeCTr/M3aCanSY9AIOs8kSoO2Mbq2ezJxDRWIoi7eNDtFvp8kArOg8hfdscx
         LlhFg0ucm0u5ofZYE4DXuJuupd4KDjBAcMtXih1qhoz2v5nyFL+I2Ru0BIWmqPRMd21q
         zlHYGi3t0AsdfWle+idN722Tz1tBVTtBR2R/kplfWmerPL9TVPC2piHonzcGCoa4r59K
         //STmtKWkWuay4MR9yqGM/phcH5N/716TA4+O+ZVttgJ69HTWNW8jSs/WTkU0ZUlQjx8
         13iQ==
X-Gm-Message-State: AOAM531U3zMW4r6JGF0vKrGp58rQSruI6YdYBtGgz01NWbIfs5Atmozc
        QLzg6PccyxOaq2CPCaX8dTb5twd/0dYA51kqxEex
X-Google-Smtp-Source: ABdhPJxput7mXI5cmAi+2taSw9GBq4WjKiIBWGZg8UhxR2JK4c7ne3m/Hbi+0o6BjsBrix9gqq0gSl5Zz1XpKD8mJQbK
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8601:b029:11c:4b4:e967 with
 SMTP id f1-20020a1709028601b029011c04b4e967mr19325708plo.75.1624300273886;
 Mon, 21 Jun 2021 11:31:13 -0700 (PDT)
Date:   Mon, 21 Jun 2021 11:31:09 -0700
In-Reply-To: <020d01d764916fb7520nexbridge.com>
Message-Id: <20210621183109.1165775-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <020d01d764916fb7520nexbridge.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: Re: RE: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     rsbecker@nexbridge.com
Cc:     jonathantanmy@google.com, emilyshaffer@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On June 18, 2021 5:59 PM, Jonathan Tan wrote:
> >> On Wed, Jun 16, 2021 at 04:31:47PM -0700, Jonathan Tan wrote:
> >> >
> >> > I have had to make several design choices (which I will discuss
> >> > later), but now with this implementation, the following workflow is possible:
> >> >
> >> >  1. The remote repo administrator creates a new branch
> >> >     "refs/heads/suggested-hooks" pointing to a commit that has all the
> >> >     hooks that the administrator wants to suggest. The hooks are
> >> >     directly referenced by the commit tree (i.e. they are in the "/"
> >> >     directory).
> >>
> >> I don't really like that this is in the same namespace as branches
> >> users could create themselves. Hm, I think for 'git maintenance'
> >> prefetching we put those refs in some special namespace, right? Can we
> >> do something similar in this case? Would that prevent us from treating
> >> that ref like a normal branch?
> >
> >Do you mean that the server should put it in a different place, the client should put it in a different place, or both?
> 
> This brings up a very awkward question: How are enterprise git servers going
> to deal with this?

What do you mean by "this"?

> I do not see the standard Pull Request mechanism available in GitHub handing
> placing hooks in different places during a merge operation. Or will this
> entire concept be omitted from PR?
> 
> It seems like changes to hooks have to be managed in a similar way to
> standard managed files rather than as exceptions.
> 
> -Randall

The plan in this RFC is to manage the changes in hooks just like any
other branch - to update a hook, you can make a PR against
refs/heads/suggested-hooks.
