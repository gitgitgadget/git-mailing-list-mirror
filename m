Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D89FC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 03:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71AC2084D
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 03:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=twitter.com header.i=@twitter.com header.b="TCB/rjao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAPDaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:30:23 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37907 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAPDaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 22:30:22 -0500
Received: by mail-ot1-f42.google.com with SMTP id z9so15990565oth.5
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 19:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tlpThzuWEvUO4zSn6qvg201LgQK4mUy8ePDBjjx9Fs=;
        b=TCB/rjaoQOr/pJLGMarEH+R+pHamiwvDVoSpp6qV0hOhfPas89+gyKOUqLFyACoCm9
         FJ5/Prp6TSsbE86kdRAeuEbB3t+XlzNHtB8EKpKfDHVj3lsif2FELlmqEifbtPLS4HfP
         eTLVsjfI8icVOwGwCUTkhwB4Zy8btqy4Rtzrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tlpThzuWEvUO4zSn6qvg201LgQK4mUy8ePDBjjx9Fs=;
        b=FzRF7UrBY9Xkl/W7VuyT+8/RfEy5rxtp4Ceqi/DHzZtCj5B/CkYB/LhtLixwvTK2Wk
         HZp0xJ/sw6uu+ECdh1/OEY4CadM+2sOAD/fhZe7S9d9cr6hLG6vLrvHY6tg7wY1r9011
         ffDUOTx0EAgXiZYkGOrEKl7Y7MlXad4AVrBvPk/pykpSuocayYBHBY6/ApCUH1cBEKoo
         TaObcXsKEbDOeMaslTdcHRLmFuJiNWSGgBaBqoHfGvBQdPDctyO+StIZxRkc3z126KD7
         jo67xWu/89wbejQVRHclfX2PbF/YgdMTIqZgDTJoVS7y6t3M6byTv+MR0aqL49BflK2x
         lXZA==
X-Gm-Message-State: APjAAAWfp51lYkt4fXI6egfK6XWtUatP+CTOtTsxG/m2zsO/Hcfpa00V
        VugNej901qsXAwKweI2u5q2DxspWu5FV9qHmKa22
X-Google-Smtp-Source: APXvYqxh70jsF8WQS1+qNPepaavysG8KgXEkcaXg7b/qn9A1zGPTjZR1EIOn+44uAX1cV4zrD53mK5JJ2uKyLQ71PPU=
X-Received: by 2002:a9d:4692:: with SMTP id z18mr402512ote.163.1579145422002;
 Wed, 15 Jan 2020 19:30:22 -0800 (PST)
MIME-Version: 1.0
References: <CAN_uzpK1m42J19Xi8oc3Dwmhk9qF1n4hFrBVqD+0RHZuZ_15Jw@mail.gmail.com>
 <CABPp-BGy3qu_Rd4epore0wLyoh1fg0UH5EAV27shKJ=kLWX4FA@mail.gmail.com>
In-Reply-To: <CABPp-BGy3qu_Rd4epore0wLyoh1fg0UH5EAV27shKJ=kLWX4FA@mail.gmail.com>
From:   Kaushik Srenevasan <kaushik@twitter.com>
Date:   Wed, 15 Jan 2020 19:30:10 -0800
Message-ID: <CAN_uzp+NrFZivfFgAgHf0Phpgax3jLwfdP4fLhTODM4By5OZTQ@mail.gmail.com>
Subject: Re: [RFC] Extending git-replace
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, Jan 13, 2020 at 10:55 PM Elijah Newren <newren@gmail.com> wrote:
> 1) You can rewrite history, and then use replace references to map old
> commit IDs to new commit IDs.  This allows anyone to continue using
> old commit IDs (which aren't even part of the new repository anymore)
> in git commands and git automatically uses and shows the new commit
> IDs.  No problems with fsck or prune or fetch either.  Creating these
> replace refs is fairly simple if your repository rewriting program
> (e.g. git-filter-repo or BFG Repo Cleaner) provides a mapping of old
> IDs to new IDs, and if you are using git-filter-repo it even creates
> the replace refs for you.  (The one downside is that you can't use
> abbreviated refs to refer to replace refs, thus you can't use
> abbreviated old commit IDs in this scheme.)
>

This is the path we're considering taking unless something easier
comes out of this (or other) proposal(s). We're working on determining
compatibility with tools. Thanks for the pointer to git-filter-repo.
It looks great!

> Instead of inventing yet another partial-clone-like thing, it'd be
> nice if your new mechanism could just be implemented in terms of
> partial clones, extending them as you need.  I don't like the idea of
> supporting multiple competing implementations of partial clones
> withing git.git, but if it's just some extensions of the existing
> capability then it sounds great.  But you may want to talk with
> Jonathan Tan if you want to go this route (cc'd), since he's the
> partial clone expert.

I agree that it isn't worth inventing another partial clone like
feature. It sounds however, like something based on partial clone will
not solve the problem on the "server"? or perhaps I'm missing
something (as I've not had a chance to check out the implementation
yet). While I'm not at all insisting that `git-blacklist` be the way
to achieve it, we'd (Twitter) like to be able to permanently get rid
of the objects in question while retaining the ability to run GC and
FSCK on all copies of the repository, preferably without having to
rewrite history.

Even merely making `--no-replace-objects` be FALSE by default for GC
and FSCK (and printing a warning instead), while retaining existing
behavior when it is explicitly requested, would significantly improve
`git-replace`'s usability (for this purpose). The bits related to ref
transfer in my proposal are optional. Git users can either be required
to explicitly fetch the refs/replacement namespace (as they do today),
or we could print a message (at the end of clone), letting the user
know that there are replacements available on the server. I'd only
proposed a new command as changing `git-reaplce` thus, would break
backward compatibility.

                                -- Kaushik
