Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C146AC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 20:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0EE20737
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 20:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpnjcGEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH0UL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0ULZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 16:11:25 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2BFC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 13:11:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id t7so5514704otp.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQBjVPI/lgxx/bzHWi/ktYsZFLW20lQgL1NmVt4prhk=;
        b=cpnjcGEAu/crwpB8VNRucgoBI+jFv5Jp4Hy2MahM+RaRAHq45QFyMD6+VLtYByyKVU
         kZh5W/PAT69JGskA/BT3xnYTy9Q+NjyrJ+1hTPVMBIFyIfHeFFMZIzySksrM24IzZX/Z
         on0uMossta1k8D+rgSEHiXPeNeuVG1Dg8Rp80Rnz3UG1d+UeOqRqz8sZL2ATbbIUr/xO
         vMdFWBvZ+XdxiXIzvvA2yKMsBQG0nJBQpnFHbQbs/Je53+Kg83ILwdRRzy3an3VpUcsn
         M12TNiVXTlGMepd2pUXId8vEc9lVt+0OtI4CEjeYsvEYI0en+1u6vwszFeAPzFXQQrrv
         w3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQBjVPI/lgxx/bzHWi/ktYsZFLW20lQgL1NmVt4prhk=;
        b=jifhSWUCCbjPi/C/CrWzWflTwyzVPLCwCVtPIhcOuczDve/aEB74xt1mjeKD3kwaVM
         zQYhoWv5sF4pNtUXTUlmPRo5ZOG6QbpItSGCGqXxgkJtCKRjH8phE/OmVyBVgb0M3NGs
         NwCpV7A5SJu1WwTkjJyQGzP1ie5I8aI+4I2TNQotsivU6VCsXmq86B2B+yBC0ip4N6i7
         bEHuc9Vf5gVKZAECJEywn7QPVLP37+WLTJiXExw/jClhT5manJJ/B10ORvSsMB4zjgik
         3kXwCVNl5VjiGjGWm7aSI+rDPDc0ko7YioXjDilCbsb7tLmARF4ikgfTwpVzP+YyuOwk
         Ko5g==
X-Gm-Message-State: AOAM532NgFQJbSJSJB1JTcthiL/hC80XRrZcvz0llnT3MuygYWeJcJZu
        6yt0s2eGsj+LmW6rjCZd0u3MQPvltSXgPSd0+oE=
X-Google-Smtp-Source: ABdhPJw5zVeaVQL98V3sBPqVynO6jO+gjjFkGhOyM0j3AlYuqrtoSuvS74oM339qUKW4j1EbB663PSUncDeWBWEOi4k=
X-Received: by 2002:a9d:3d89:: with SMTP id l9mr5358965otc.316.1598559084106;
 Thu, 27 Aug 2020 13:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
 <xmqq7dtlt080.fsf@gitster.c.googlers.com> <xmqq3649szs8.fsf@gitster.c.googlers.com>
 <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com>
 <CAPx1GvfSt=s5VP9_+ZtndHWaBZ5W7nFxAf8bTF2tXnJkS95Dfg@mail.gmail.com>
 <xmqqzh6gqe7i.fsf@gitster.c.googlers.com> <CAPx1GvfXOMFDsXE74LiG_BG5Bqb+seHDWX69xGe49C240ORi6A@mail.gmail.com>
In-Reply-To: <CAPx1GvfXOMFDsXE74LiG_BG5Bqb+seHDWX69xGe49C240ORi6A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Aug 2020 13:11:12 -0700
Message-ID: <CABPp-BEEmqdt2_OuNQFxyf6pkppBWptkcvuAYhWX8r+_Wr8-2g@mail.gmail.com>
Subject: Re: post-checkout hook aborts rebase
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tom Rutherford <tmrutherford@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 12:07 PM Chris Torek <chris.torek@gmail.com> wrote:
>
> On Thu, Aug 27, 2020 at 8:51 AM Junio C Hamano <gitster@pobox.com> wrote:
> > I still suspect that the checkout run, merely as an implementation
> > detail of rebase (or any other git subcommand), should not trigger
> > any hook ...
>
> The *last* checkout from the finished rebase perhaps *should*, but
> other than that one, that seems logically correct.

What do you mean by the "last checkout"?  I believe a typical
non-interactive rebase of N patches has only one checkout, and I don't
see why running hooks for the starting point is relevant.

If hooks are wanted for rebase, I'd still want to have rebase-specific
ones, because most people who think of "checkout hooks" or "commit
hooks" probably aren't going to think of them the way rebase or
cherry-pick happen to use them.  (And that might even be more true for
--interactive and --rebase-merges cases.)

> > but before any such code change, at least let's update the
> > documentation to clarify what we mean by "the outcome".
> >
> > Hopefully something like the below may be a good starting point?
> >
> >  Documentation/githooks.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> > index 31b601e4bc..cf95d6d02b 100644
> > --- a/Documentation/githooks.txt
> > +++ b/Documentation/githooks.txt
> > @@ -193,7 +193,9 @@ worktree.  The hook is given three parameters: the ref of the previous HEAD,
> >  the ref of the new HEAD (which may or may not have changed), and a flag
> >  indicating whether the checkout was a branch checkout (changing branches,
> >  flag=1) or a file checkout (retrieving a file from the index, flag=0).
> > -This hook cannot affect the outcome of `git switch` or `git checkout`.
> > +This hook cannot affect the outcome of `git switch` or `git checkout`,
> > +other than that the hook's exit status becomes the exit status of
> > +these two commands.
> >
> >  It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
> >  used. The first parameter given to the hook is the null-ref, the second the
>
> This looks good to me, and can either be independent of, or the first part of,
> any rebase update.

Patch looks good to me too.
