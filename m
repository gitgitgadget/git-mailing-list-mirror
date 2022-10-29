Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C7EFA3741
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 01:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ2BxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 21:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ2BxW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 21:53:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1F815B135
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 18:53:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d3so10456670ljl.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 18:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ow4nK+MNMYFLOxDh8sm4eBDhGCg1z+Gy8tyRcu76a0=;
        b=AIk883ofq9EKjrBQSp48S68029cjEaOjlokBoxjwhYWgqZHa1iKMDqnm2yIBoSMxHj
         Q6uRYaDxirZiZ4H+6mWVJZhTNfYmE68O+DWY/dAUNwT+RhYYADXzPQv1MpjRZFa5qS7f
         TkVK77yuXKA1uowO4zKuk+Clkuw265t5PVFm6ZWyoKjBKTyL22eRa+DxZICPO+xkcuLS
         l6pT4UCY4IXyL4Xmc5zvXUqBRWtJGQjS5pxnyyGwGRvNGcVkwTaWE+lQ/kdACfI8bU4S
         +tk/kWQHPo/ZGmgpq/5dKHatt+Ljgs/DwSUt4xe1eSQGhxjrCeN+8APlYAGkeP82j/vV
         k5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ow4nK+MNMYFLOxDh8sm4eBDhGCg1z+Gy8tyRcu76a0=;
        b=tvnNL4vcFcJao3rbDenAxVjfV4rgUvfXmuGe6qPXx+9kPhBdjunn/e3U1MPyjFCQu3
         QvOCBTgVTRnZpGS9qgBIF0MG6+Prej7APR5Rj7f5Qbp/rElIzsxtiq3DZqHYAKEjUZW+
         U+GIOc+zZvHFOTjylib5Zw2r29r0eGsk649VPyVmRbkx+6Ut7Suki36sgwwCrGvjKsxp
         SKeCg6UnqAG+LaKeKkoLHkFrukKXQK2Gs4YXL0Xw3MX8ru8q5kZTi8JmRr8k417enma9
         dDY3VAeF4VAYCZ077tVDX5ZzbLsy3C3Qvuk2JYEgS5XjBSr8aN9j3QqRec2+VeOtd0WP
         Cq0A==
X-Gm-Message-State: ACrzQf0B/eGSbEGkBOwkAWmyJSx3tEK/sIyE7sj62s9Tv14fM9J+fFUB
        6sFK/JeWRTju/USyjadOKITCRvbMkbVrAvQEe8Y=
X-Google-Smtp-Source: AMsMyM40XmDkBydqyLxcNg+vRnzEx9teXZNGjOhKJzqq5WYWWdpU7veboz6aKvF76M6M1UjjBGsz+pcoo45YIUBYZYc=
X-Received: by 2002:a05:651c:54b:b0:277:2f02:8da8 with SMTP id
 q11-20020a05651c054b00b002772f028da8mr904708ljp.73.1667008399534; Fri, 28 Oct
 2022 18:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1397.git.1666872761355.gitgitgadget@gmail.com>
 <xmqqczadm93w.fsf@gitster.g> <CABPp-BHceBeo6Y8s00gET=4yqCMf3qqsiNMhqJ34HVf8r=bhnw@mail.gmail.com>
 <xmqqfsf8j5p5.fsf@gitster.g>
In-Reply-To: <xmqqfsf8j5p5.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Oct 2022 18:52:00 -0700
Message-ID: <CABPp-BGXM=iRAgjNbZ0o3FSjj583GpkuFB6emUYwWjdFWb9-jQ@mail.gmail.com>
Subject: Re: [PATCH] merge-tree.c: add --merge-base=<commit> option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kyle Zhao <kylezhao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2022 at 9:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> > Yeah, I don't think that'd be too hard...if we could rule out ever
> > supporting octopus merges in merge-tree (which I'm not so sure is a
> > good assumption).  Otherwise, we might need to figure out the
> > appropriate backward-compatible input parsing (and output format
> > changes?)
>
> I'd prefer an approach to tackle one thing at a time while making
> sure we leave the door open for the future ones.  I think the
> backend interface from "merge" to external strategies use a
> separator to signal the boundary between the heads being merged
> (i.e. branchN above) and the bases being used, which is easy to
> parse and support multiple bases and octopus at the same time.

Ooh, the separator idea sounds like a good solution.

> As to making it easy to implement "cherry-pick", I do not think you
> should dogmatically forbid it on the basis for merge-tree from the
> command line is inherently one mergy operation per invocation.  You
> will have the --stdin interface, and a way forward may be a notation
> to refer to previous results in the --stdin input stream.  That way,
> a single invocation of merge-tree "server" can be fed a sequence of
> 3-way merges that are actually steps of multi-commit cherry-pick,
> that merge the differences of multiple commits on top of the
> previous result, one step at a time.
>
> IOW, as long as you make sure --stdin interface is rich enough to
> allow you do what people would do a sequence of "git merge-tree"
> single shot invocations (perhaps even driven by a script), you would
> be OK, I would think.

I agree that this kind of functionality probably makes sense for
inclusion from a completeness perspective, but I still maintain that
if its sole purpose is implementing a cherry-pick command then it's at
best an ill-advised or interim hack and we should instead do something
better.  While combining this patch with --stdin does solve the
"single operation per invocation" issue, that's only one of six issues
I listed in my email to Kyle about why this is the wrong base for
building a cherry-pick alternative.
