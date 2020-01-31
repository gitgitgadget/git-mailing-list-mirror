Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FB2C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 15:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A689820661
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 15:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRXySUY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgAaPNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:13:38 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37289 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgAaPNh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 10:13:37 -0500
Received: by mail-wr1-f44.google.com with SMTP id w15so9035096wru.4
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 07:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9SbAQwxuwdbIA8gdFpYQUo6KxdSCFpiJAi49wlHH8xg=;
        b=JRXySUY9y12Uu1Ka6Nqux/DhH/xLLb4UKG291lH0m/VX+MsJLrksmkK6pp7WaloD88
         L2yzRHuEjm2SmbtIk4QpvPniPV8uGW6mQx74fhLcD5R/BRWbO+S1lbAjEhJGk93PSbqG
         LsTDRydz7xZZPLRZCOCFdcVQ6QeaOngxVD56crjpeO8scc0uGSarJucpToFvuNeRS9H3
         VbG827CAvOCgvnRivNJiS3TjTbLhZrB0TSQP64cqoeqmdQvwvLvqLetdM3WU07G344sH
         njfvwUuHDMQQ+Zg+XnWghxCjat83xFr5X4GE5Pp6C4VCn/Et+dksFEcizFyjxnA+UKiW
         h5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9SbAQwxuwdbIA8gdFpYQUo6KxdSCFpiJAi49wlHH8xg=;
        b=lHKF4+P2kMY2lb/eef7zBQ3yC2qpyYI2bBMNY05cXAZb5mZMDWgq0/OdhcCpr4YxbF
         +0dwAmtVfO4XqcXlq/svgj04S5JamDd2Yx3xQAEkbqeKk7qfXnyxc0I4K0klBQcpuKmC
         Uu783jnebnjUOwqbyn173pk89yFUe7XrdMgbz9sKDLYWag2RpCaPAhZhpzqK0kah6p6O
         qyAXRd8OHNXreBrg9zC0vrluD/qpOoXnwUosb7eLMDf7MyarwSb0fmQicSQeynwjog19
         axEhnL1LP51C7Io/nO7trT7w1WeV7886gfGsFaH+8kHFhHqctj7P2qnAbHT4lrOpznXF
         Z8Wg==
X-Gm-Message-State: APjAAAXq3QHCNbSDutRnB4txRBGCrS55Xhhv1xYnr98O9eOZjtO3oP0y
        WUHmApKxu+85CEFIKeEo7FtGxZNLCt4N+F5xLQw=
X-Google-Smtp-Source: APXvYqweGV9Vk7VWxOKkfuoVqD3ioajmK/pMOqn9JNBt/ru5iB8rfMLSCq//uD5NvbxlfsAeABlms5+2jrOUC5GzBFI=
X-Received: by 2002:a5d:620b:: with SMTP id y11mr12509710wru.230.1580483614469;
 Fri, 31 Jan 2020 07:13:34 -0800 (PST)
MIME-Version: 1.0
References: <CADSBhNbbO=aq-Oo2MpzDMN2VAX4m6f9Jb-eCtVVX1NfWKE9zJw@mail.gmail.com>
 <ef39f8c5-ce0b-a48b-940d-821df563b292@gmail.com>
In-Reply-To: <ef39f8c5-ce0b-a48b-940d-821df563b292@gmail.com>
Reply-To: finnbryant@gmail.com
From:   Finn Bryant <finnbryant@gmail.com>
Date:   Fri, 31 Jan 2020 15:13:23 +0000
Message-ID: <CADSBhNZ7g_eqUSRczGJPkoiG57OL4DXray3_kTTtj-DF4=aM1g@mail.gmail.com>
Subject: Re: Sparse checkout inconsistency with non-folder paths between cone
 mode and full matching (2.5.0)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(resent, I forgot to reply all)

On Thu, 30 Jan 2020 at 18:52, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/30/2020 10:25 AM, Finn Bryant wrote:
> > Hi,
>
> Hello! Thanks for chiming in with feedback.
>
> > With cone mode enabled for a sparse checkout, a pattern like the
> > following is accepted:
> >
> > /*
> > !/*/
> > /a_file_or_folder/
>
> As you mention below, you say this path is a file OR a directory.
> However, the trailing slash means _only_ match directories with this
> name. This is a specific choice made in creating cone mode to restrict
> only by directories.

Right, I thought it was supposed to work that way, but the bug you've
patched left me uncertain.

> > If matching behaviour with full pattern mode is a non-goal for cone
> > mode, I'd still question the logic of this behaviour, though I suppose
> > it does have the benefit of (accidentally?) adding support for
> > excluding individual files from a sparse checkout, which I imagine
> > some could find useful. Personally I'd prefer that was instead added
> > with a more sane syntax, if needed.
>
> Cone mode is specifically designed for performance using a hashset-based
> pattern matching. This naturally restricts the possible patterns since
> we cannot match the full pattern set [1] this quickly. This means there
> are some trade-offs that are required, but they were made with some
> information of real-world repositories organized in a way that they
> could take advantage of this pattern set.

Absolutely, that makes sense to me, and I think this fits the model
I'm working with well, or will once your patch filters through.

> > $ git sparse-checkout init --cone
> > $ git read-tree -mu HEAD
> > $ ls -1
> > a_file_or_folder
> > some_file
> > $ git sparse-checkout set a_file_or_folder
> > $ git read-tree -mu HEAD
> > $ ls -1
> > some_file
> > $ cat .git/info/sparse-checkout
> > /*
> > !/*/
> > /a_file_or_folder/
>
> This is an interesting test, because I would expect the /a_file_or_folder/
> pattern to not cause the _file_ to not match. It does match the first two
> patterns, and just because it doesn't match the third pattern shouldn't
> remove it.
>
> This is actually a bug in the hashset-based pattern-matching algorithm,
> since setting core.sparseCheckoutCone=false does not have this behavior.
> I'll make a patch to fix this.

I was hoping you'd say that!

> > Right now I'm trying to integrate cone mode with my company's existing
> > manifest infrastructure, which doesn't differentiate between files and
> > folders, so this is forcing me to perform a lot of repo checks to
> > confirm we aren't accidentally excluding files we were supposed to
> > include. Just in case you needed another example of why this behaviour
> > is unhelpful.
>
> I apologize that this wrong behavior is causing you some issues. If you
> are able to identify which paths are files instead of directories, then
> you can remove the filename from the path to include its parent directory.
> This is only a workaround until the bug is fixed, but the end-result will
> be the same: you'll have all sibling files in your working directory as
> well as the files you specified.

No need for apologies, I just wanted to convey why I thought the bug
was worth attention.
I realise this is a brand new feature and appreciate the impressively
fast feedback!
I am loving the cone mode improvements by the way, I've been living
with the poor performance from full matching for a long time now, and
this is a huge improvement.

> This is important: if you have a directory with many large files, but
> intend to include only a subset of those files, then you will be
> disappointed by the size of your working directory.

Understood, this thankfully isn't a huge issue for my use-case, our
folder structures are mostly not too shallow, so there's only a few
cases where the lack of file matching hurts us, and the benefits far
outweigh the costs.

> This requirement of specifying directories instead of files is part
> of the cone mode design for two reasons: one philosophical and another
> more practical:
>
> Philisophical: Filenames change more often than directories.
>
> That is, as users are interacting with your repo, the overall directory
> structure at a high level is typically static. If new cross-component
> dependencies are introduced, then those are usually big architecture-level
> changes. However, at an individual file level dependencies change at
> a higher rate, causing users to react by changing their sparse-checkout
> definition more frequently.

It's not too much of a concern for me, but the few cases where it has
an impact for me tend to follow the pattern of:
project A needs file X, but X lives in a folder with 1000 other files
that aren't needed by project A.

> Practical: How do we specify if an input is a directory or a file?
>
> As you mentioned, if you run "git sparse-checkout set X" then you get
> a sparse-checkout file containing:
>
>         /*
>         !/*/
>         /X/
>
> But if X is actually a _file_, then we should write this pattern:
>
>         /*
>         !/*/
>         /X
>
> So the input does not provide enough information to say which pattern
> should be written.
>
> The other concern about this second set of patterns is that "/X" is
> only a _prefix_ match, not an exact path name match. That means we
> cannot use the existing hashset matching to result in the same
> pattern matching as non-cone-mode.

This is an interesting point, currently (at least in 2.25) both `/X/`
and `/X` formats are allowed, and appear to be treated the same way.

Given `/X` is only a prefix match, perhaps it should be invalid for
cone mode, and force the full matching fallback?

This wouldn't have any effect on the matching capabilities of cone
mode, I think, but it would reduce confusion and ensure cone mode and
full matching have as close to the same results as possible.
Additionally, by preventing it now, you can effectively reserve that
syntax in case it proves useful for later extensions to cone mode.

> Now, there is perhaps a way to decide between the two: inspect the
> current index or tree for whether the input corresponds to a directory
> or a file. This adds a layer of complexity that is not currently in
> the sparse-checkout builtin, but it is not insurmountable. The only
> thing to consider is what happens when the input path is not in the
> index/tree at all! It may be that we want to specify the patterns
> before moving HEAD to a commit that _does_ contain the path, and then
> we would do the wrong thing at this point.

Agreed, this is a nasty problem.

> So I'll put out a question to the community: is this practical issue
> something worth overcoming? Is my concern about a non-existent path
> a true problem, or something more?

Personally I think it's a reasonable compromise. Many will benefit
with only folder matching support, and the cases where file matching
is needed (or at least a significant benefit) are going to be quite a
bit less common.

> Thanks,
> -Stolee

Thank you for the quick response and the patch!

Finn
