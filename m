Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1911FC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9D3224B1
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgLWX3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 18:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLWX3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 18:29:39 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAD3C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 15:28:59 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id b9so539039qtr.2
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 15:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=K1HV2HlHAxfELj0bvFIG+ruSRug3ilAMiRbO78z4hLg=;
        b=SwDs6IEMyIxdTj4Y9+hNOjF2+noS4VWiZRHCCvR104jtDuC6F85pzXah6Y6xfMHIy0
         MFtn0SeOojcU5a4XpCwYRduEjOKlF5U/rqmd4xNI9RChserVNZaSZVGrTQQfuOwlA4mI
         bknTr4uVL/GlRwgA+9c5hrxhOCm8hDaSm6CPNOLTMiZ63gSwGImqHwQTmZTMkU/atwFc
         30TRtuuQuD+uSxnubpCnu+tdgbqeCyouso023IRLQYfN4Jc1rigE+k1ikB7X2MWU7G6k
         /Zv1xr9KapalcZJTwIfJAMoL+JrsppNM1e8YRnhQimLi/HTtlKmwzMZN7/ttd84QGyP0
         xsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=K1HV2HlHAxfELj0bvFIG+ruSRug3ilAMiRbO78z4hLg=;
        b=I0rA0gtBOmFdIm+X8Ic5tnAKjqbMpvp/KbWZSWi4T/7uS2mZjicuPhtT9Qo113nkDl
         TX+ZBLPysd3aNsAsb7Sombxof2KpYNddMRRb+DsoV2S2YfUwR5N2XobQDHIUE+EEICDE
         IZmT2p5821RBJ2lPAUDU/g2QW2JP1kGlzMOOItqZcVdkaTzevI5EsvC7lgRMR202Bmc7
         wvHxsATi9llbgCD06HYqkY0p5l4baB4d0LNwVX5lCN2oyB6qVpp6H/X3bMZDp28FQrdO
         2jsKmNAljCX7p2Zvv/lmij2g15bnK/Ys+2iC+aY/7+2/kBCXMskbfs1xs6QulLMgJNlM
         yjjw==
X-Gm-Message-State: AOAM5316zAdJf0fD5Ldc/o3MpskKMlBq7MNr3LDAr4+GzaPa6pBmDxhP
        0qDsHPiuOJwgkvTJjHZebWa/Bd7KG/wq8IIbyHY=
X-Google-Smtp-Source: ABdhPJxgnVdzPs2Et6R9Y1mZ89VtLfer7evahyWst9xVOBUfCZVgyduUNV6xGxTv1kvsrEIRppifoRi78N+McGFS5pA=
X-Received: by 2002:ac8:690f:: with SMTP id e15mr27307781qtr.100.1608766138599;
 Wed, 23 Dec 2020 15:28:58 -0800 (PST)
MIME-Version: 1.0
References: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com>
 <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com> <X+PR6yms1G9zVcML@camp.crustytoothpaste.net>
In-Reply-To: <X+PR6yms1G9zVcML@camp.crustytoothpaste.net>
From:   Mike McLean <stixmclean@googlemail.com>
Date:   Wed, 23 Dec 2020 23:28:47 +0000
Message-ID: <CAM0jFOddeArOtbrKVGP0r3Nh=GHPoKqyZ7v6==iFTMpTus4-Fw@mail.gmail.com>
Subject: Re: Git Feature Request (Fixdown in interactive rebase)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mike McLean <stixmclean@googlemail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I was unclear  :)
I mean that the new command would take *only* the 2nd commit message.
(By analogy to `fixup` which takes *only* the 1st commit message)

I agree that `squash` currently gives you the concatenation of both
commits ("all", if squashing >2 commits)

On Wed, Dec 23, 2020 at 11:25 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-12-23 at 23:08:58, Mike McLean wrote:
> > I initially raised this as a FR with my git UI of choice, and was told
> > that it was actually something that git itself would need to do ...
> > and that the standard way to raise Feature Requests was to email this
> > list.
>
> This is absolutely the right place.
>
> > During an interactive rebase, the text file defining the operations
> > has a command option for "fixup".
> > This will squash the target commit into the previous commit (listed
> > above it in the file), and automatically use the commit message of the
> > previous commit (thus bypassing the "choose the commit message"
> > dialog/file).
> >
> > Can we have a similar convenience-command that squashes, and retains
> > the second commit's message? Purpose is the same as the fixup command
> > - saving a bit of time and unnecessary typing during a common
> > operation.
>
> Maybe I'm misunderstanding what you want, but I think the "squash"
> command does what you want.  It does invoke the editor to edit it, which
> tends to be useful when working on projects that use a sign-off, since
> otherwise your second commit message would be tacked on after the
> sign-off and other trailers.
>
> If you really want to avoid the editor prompt, you can run your rebase
> like so:
>
>   GIT_SEQUENCE_EDITOR="$(git var GIT_EDITOR)" GIT_EDITOR=true git rebase -i
>
> which will avoid spawning an editor except for the todo list and will
> implicitly concatenate the two messages.  That will also make any
> "reword" options a no-op, though.
>
> If you were looking for an editor command that just concatenates the two
> messages without an editor prompt, then no, we don't have that, and that
> would be a new feature.  I wouldn't use it because most of my projects
> use sign-offs, but I'll let other folks weigh in if that's a feature
> they'd like to see.
> --
> brian m. carlson (he/him or they/them)
> Houston, Texas, US
