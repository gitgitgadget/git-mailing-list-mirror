Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B273C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE6F619CB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 21:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhC3VUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 17:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhC3VTr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 17:19:47 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3803BC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 14:19:47 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so4103941oot.4
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuupLpM6+YOf5sIjP1PpVqbT2LgdliRBLVmwoAm6o8Q=;
        b=E80qd+NKrMWrWKKqriZZmbOwILoXqDOqtP5+eMP+HZYhe/x06puhbESHvKbdjW4D73
         +G1NCKJlZchIbQK1DerQSwsN1hDrr6tP4GqBfEMiUKRDk4aYr5rIGBHodkwMuHyn5h+z
         RSf05mA55k3XBrZYcpjAGEB8Z7ECmR+N0g1S9VcfvYVwyYaD5wbflzwVRzBUzMWMk66i
         wKRNrWElboe4OTrVYHWbwfeWCjcx6W4gvcK2fIs4PPGPphuRfQg0eaxOEyW7EqPbnRYT
         NAh1w0+o/omI/7ld6lZCuSyHKyxAoTKrFHFMzpP9UEMlOA+B6HIh57xgK4EJaNqyWA5P
         XP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuupLpM6+YOf5sIjP1PpVqbT2LgdliRBLVmwoAm6o8Q=;
        b=jsUd7rATLjlVLddywjcKWrEzZskbq9ilOVXts3KF2P3gISPivjOiLY5igK3dvm4p1F
         QCPJhBtCYBQiPWRcfei5ZsPV0ezA0EkpxZ/CqSasFe4odDTSbn0LeOib2Xf0mYH66b6F
         ptqOXU7SIBE3fTLb9ddViUVjbswnekIIB39bFZlF1mQahEteJSJTQdaPzxCON4SNzxyy
         /utX+mRdQDyOqA8qcu35lVqH2HrmtgoTaG8aPn3UlnVY6CJyCtiGsI52Kagwwl3YCIDO
         keOhDTPztVGBr3Opaa1a5sFgDCJojYk6yAAsXQRHI1nrNyxu0m0CAdTygj/XVub2r0D8
         KGvQ==
X-Gm-Message-State: AOAM533IJxDUAj54Sgqb6S9ifqG1dNvBPdPhE2NZ/igeBzoKsQclQvJP
        lPk9/WAfJ19qa0qpcFbxrsIvBRs7lX4X+KpUYUw=
X-Google-Smtp-Source: ABdhPJwdZQe2GVFHFvNQceE+I1rOpwTDA0EPYVCWaCzfuk+rQnCdOxcWnqgezvZn35phtkjvOgzw0OUYaa1YDtqe3f4=
X-Received: by 2002:a4a:df08:: with SMTP id i8mr41109oou.32.1617139186547;
 Tue, 30 Mar 2021 14:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEAbN05+hCtK=xhGg5uZFqbUvH9hMcCNMcBWp5JWLqzPw@mail.gmail.com>
 <YGLNBFJv8NKmrbvz@coredump.intra.peff.net> <xmqq35wceae6.fsf@gitster.g>
In-Reply-To: <xmqq35wceae6.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Mar 2021 14:19:35 -0700
Message-ID: <CABPp-BEE0eksCJSAviDh5GyqsOu=i_mW3VY6SEULa4kx0NsUMg@mail.gmail.com>
Subject: Re: Bug report: git branch behaves as if --no-replace-objects is passed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 11:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > ... though if we go that route, I suspect we ought to be adding both the
> > original _and_ the replacement.
>
> So "branch --contains X" would ask "which of these branches reach X
> or its replacement?" and "branch --no-contains X" would ask "which
> of these do not reach X nor its replacement?" --- I guess the result
> is still internally consistent (meaning: any and all branches fall
> into either "--contains X" or "--no-contains X" camp).

I'm not so sure about this interpretation.  Based on the documentation
in git-replace(1):

       Replacement references will be used by default by all Git commands
       except those doing reachability traversal (prune, pack transfer and
       fsck).

I would have thought that

* "branch --contains X" would ask "which of these branches reach X's
replacement?"
* "git --no-replace-objects branch --contains X" would ask "which of
these branches reach X?"

and if folks really wanted to check whether either X or its
replacement were reachable then they'd need to run both commands.

The only place outside of reachability traversal where I think it
makes sense for a command to distinguish between X being a replace ref
for Y and Y itself is in `git log` where it can show the "replaced"
moniker.

> > I'm not entirely sure this is a good direction, though.
> >
> >> and possibly worse, if I create a new branch based on it and use it:
> >>
> >>     $ git branch foobar deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
> >>     $ git checkout foobar
> >>     $ echo stuff >empty
> >>     $ git add empty
> >>     $ git commit -m more
> >>
> >> then it's clear that branch created foobar pointing to the replaced
> >> object rather than the replacement object -- despite the fact that the
> >> replaced object doesn't even exist within this repo:
> >>
> >>     $ git cat-file -p HEAD
> >>     tree 18108bae26dc91af2055bc66cc9fea278012dbd3
> >>     parent deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
> >>     author Elijah Newren <newren@gmail.com> 1617083739 -0700
> >>     committer Elijah Newren <newren@gmail.com> 1617083739 -0700
> >>
> >>     more
> >
> > Yeah, that's pretty horrible.
>
> I am not sure.  As you analize below, the replace mechanism is about
> telling Git: when anybody refers to deadbeef, use its replacement if
> defined instead.
>
> And one of the points in the mechanism is to allow to do so even
> retroactively, so the HEAD object there may be referring to deadbeef
> that may not exist does not matter, as long as the object that is to
> replace deadbeef is available.  If not, that is a repository
> corruption.  After all, the commit object you cat-file'ed may have
> been created by somebody else in a separate repository that had
> deadbeef before they were told by Elijah that the object is obsolete
> and to be replaced by something else (Git supports distributed
> development) and then pulled into Elijah's repository, and we should
> be prepared to seeing "parent deadbeef" in such a commit.  As long as
> replacement happens when accessing the contents, that would be OK.
>
> So, I do not see it as "pretty horrible", but I may be missing
> something.

I think you're focusing on git commit, or perhaps on git checkout.
I'm focusing on git branch; what it did does not seem fine to me.
Using your own words:

"the replace mechanism is about telling Git: when anybody refers to
deadbeef, use its replacement if defined instead."

git branch didn't do that; it put deadbeef into refs/heads/foobar.
