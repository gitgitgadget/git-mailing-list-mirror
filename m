Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838C71F453
	for <e@80x24.org>; Thu, 31 Jan 2019 05:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfAaF33 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 00:29:29 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35119 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfAaF33 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 00:29:29 -0500
Received: by mail-io1-f66.google.com with SMTP id f4so1620068ion.2
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 21:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RYV/Yo3yo039pSnC4gODk1wyUDYiKVHSTTMRiG28ofM=;
        b=lrxzDHrOjBEScIVpaKMdhdsPmcoTxFQlNbnV7qYm4hYHP51wDwrRKEdYQysFnq7o6W
         J7nNI9gk5Gwq6mwkBUglhYygkrCub6zOVtROo0QE88Y2iM1n/ZYdFXCmKQ2URJ+d3BfF
         m/AcFciToTZUhu2cAz8gqtMFu21GWBsTYhbaBlc/ybwx4Cn/Awy4Pl0CAYnwOyIYVRuL
         4LgaQxcaxP0UO6h8um6rpGZQgaS8A9V2DuNwvaVKRXhVbFvGHzzWrf7SHa62evpShPsS
         1TAW5QaJUdDGzx+gbLVForvGESw43p8rrcc6zbe3oEvDEOaKMXUYQVJqPNjx9TctgihX
         IBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RYV/Yo3yo039pSnC4gODk1wyUDYiKVHSTTMRiG28ofM=;
        b=fYcm/T1+pZstMJdw/3h/VAw3n9+z//6CqOW6lNqgeYbBvYlQ7vG6geTiGopO/NqhEp
         zZm5GCNfKMznjzrO4k8FcnFDAbGpotJoqwzjMbKFe3fLukNzG4CLOA8Tl3VVL2G+9PY3
         bcOz+cqPXyDub47OcvGI3w66bBtLMjtoUm2JUWmf3qsJYv2/9n4YRGJBzUdeoLycEFWN
         nN/oHNxqJgHbHqG8LoNleCgvCv3gRHXTgLRScJfhjhBu+WTiNMV0Xonbb0vJ3rSJnqBc
         2pX8ECbBX4eZ7oE77xiiqN4j6LcRK7cbnqUlI7Dnoh8laRxOJhR9V+lWJDLTd2b8U8+r
         Js/Q==
X-Gm-Message-State: AHQUAuYaHBn2o7ikse1A3ThdPotIm+r1ZO4GNtxhhLw5UlKpLpS8WdqW
        ys7N1jBqM8Ozbp7ewdmYBZwF8lwt7GRojNB8/STQkS5U
X-Google-Smtp-Source: AHgI3IYHKpJbAA73xhMFPLVDsR5YEedQgqWlZgq12TPu5NtTbyX3ySKUbTbMXXmLKSJXg/3/ay8T+OaEfylUwhACtL8=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr12350194iof.118.1548912567679;
 Wed, 30 Jan 2019 21:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-9-pclouds@gmail.com>
 <CAPig+cQ3L4NcMojWYV3spazJNzEa6yhBJQ0wwbwcLSzG3Vmzjw@mail.gmail.com>
In-Reply-To: <CAPig+cQ3L4NcMojWYV3spazJNzEa6yhBJQ0wwbwcLSzG3Vmzjw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 31 Jan 2019 12:29:01 +0700
Message-ID: <CACsJy8BKxf6Q1Q-u92enPgw6a18XhAOvYSewZs-G+tB+-MSkNw@mail.gmail.com>
Subject: Re: [PATCH 08/19] checkout: split part of it to new command switch
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 7:50 AM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Wed, Jan 30, 2019 at 4:49 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> > "git checkout" doing too many things is a source of confusion for many
> > users (and it even bites old timers sometimes). To remedy that, the
> > command will be split into two new ones: switch and
> > something-to-checkout-paths. The good old "git checkout" command is
> > still here and will be until all (or most of users) are sick of it.
> > [...]
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> > diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.tx=
t
> > @@ -0,0 +1,236 @@
> > +SYNOPSIS
> > +'git switch' [<options>] [--guess] <branch>
> > +'git switch' [<options>] --detach [<start_point>>]
> > +'git switch' [<options>] [[-c|-C|--orphan] <new_branch>] [<start_point=
>]
>
> What does the third form mean when all optional arguments (that is,
> _all_ arguments) are omitted?

"git switch" is smart (or too dumb to be clever):

$ git switch
fatal: nothing to do

> Nit: I realize you inherited this from git-checkout documentation, but
> can you use '-' rather than '_', as in <start-point>, <new-branch>, to
> be consistent with other documentation, such as git-branch.

A quick grep shows <some-thing> seems to win over <some_thing>. Yeah.

> > +EXAMPLES
> > +To check out commit "HEAD~3" for temporary inspection or experiment
> > +without creating a new branch:
> > +
> > +------------
> > +$ git switch --detach HEAD~3
> > +HEAD is now at 9fc9555312 Merge branch 'cc/shared-index-permbits'
> > +------------
> > +
> > +If it turns out whatever you have done is worth keeping, you can
> > +always create a new name for it (without switching away):
> > +
> > +------------
> > +$ git switch -c good-surprises
> > +------------
>
> I had to go re-read git-branch documentation to understand why you
> recommended "git switch -c <new-branch>" (or even why this mode
> exists) over plain "git branch <new-branch>". I wonder if the
> difference between the two deserves a bit more discussion here and
> above in the description of the -c/-C options.

There is this bit in git-branch, will that help?

-- 8< --
NOTES
-----

If you are creating a branch that you want to checkout immediately, it is
easier to use the "git switch" command with its `-c` option to create
a branch and check it out with a single command.
-- 8< --

Otherwise any suggestions are welcome, I guess I could rephrase it a bit li=
ke

-c <new_branch>::
--create <new_branch>::
        Create a new branch named <new_branch> starting at
        <start_point> before switching to the branch. This is similar
        to creating a new branch with linkgit:git-branch[1] except
        that `git branch` does not switch branches.
--=20
Duy
