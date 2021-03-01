Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE1C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD2264E40
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhCAJxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 04:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhCAJvU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 04:51:20 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8394EC0617A7
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 01:48:16 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id 18so8893613qty.3
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 01:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6AvvjUPsj8JONqgIIgqbTaMU5vSYCXbxQoeL8JH+Tb8=;
        b=lmLswQvrhR0cYb2FZYSexDjACYDZwf/iYtKON+MgeSXN2zB/UY4QMixccEWrLP8pCJ
         I1ipniFeBHLU1rQBF7PIb+236SruFcpL22Wz7EFJQokLjAzowEuz5p5lTx3bS5i+jI9M
         NAa8teLsitGaS/QEHmfTvKP+vL6AAgLsYFXRQ+Ml7fljmdIcH/0SCenFcyYZidab7+eb
         YrCKtaI4Avkn7hqK+/l8VzaQJ39eJyhSjfhyvXoVrlnVobhNdKKBJNC3AVRYp7WGc4Ne
         ONqnZod9oZe9nJGCLmmCJQeybEYim5NO8bcMEwFm7Ufi3aNf98lcFbksZhEi9w1uetLk
         sAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6AvvjUPsj8JONqgIIgqbTaMU5vSYCXbxQoeL8JH+Tb8=;
        b=FJ5Q4XNEWNeSmGXKip3M7L3kwuHi1uAV45P83BMpz3NTNOgevBj3TZKHF2zf9Jq4Y8
         CJZo8hDdh6rzjnZVLALS++hiqcI3RgRhLTzbbjpEF1UKYJE5XaQBYGVbiQN9ZDhqkerr
         gRcDTFojv636kh0qAsWFyAou26z4naIfnVEeaQL7ztKbQAf5oOcvbRd0JmrIHx7OC03h
         mU0keO+KnGLd9QMlyqf+TvBIKGdcbb1lBCVkrCmsQGNQNqm5TaKQjnL/cDZvSTMLD79Z
         ZuRuJzn7vXmsLFLVfquYfpL0V9YVxPdjIMPyjcwI+5/JTFDGMV5q2wYzV0LZZ1tg1OlJ
         NmlQ==
X-Gm-Message-State: AOAM532MT8OxrxyLgmD+5XldlzYeg7feI0143S6pAL7jerRza/vE7g55
        eFd+XiNojYry6/vUmm0KBXEobXc5uv79qL4+BoI=
X-Google-Smtp-Source: ABdhPJw38/4unaOFDaZiGRKAN18ZwUAmHJ3/4RMMWwtwvw2CUNiHyTvn8Q1x6L7Y+fayvHKs3lqO0g5sKkWUHzDMdqk=
X-Received: by 2002:a05:622a:54e:: with SMTP id m14mr12251542qtx.128.1614592095790;
 Mon, 01 Mar 2021 01:48:15 -0800 (PST)
MIME-Version: 1.0
References: <CAAdc0hwmR7BF53_66LNaceLrkFPDphU-y2sLEGB_1YoR5ErQsg@mail.gmail.com>
 <87tupy7sx6.fsf@evledraar.gmail.com> <042b01d70c5e$593f0380$0bbd0a80$@nexbridge.com>
In-Reply-To: <042b01d70c5e$593f0380$0bbd0a80$@nexbridge.com>
From:   Jean-Marie Lemetayer <jeanmarie.lemetayer@gmail.com>
Date:   Mon, 1 Mar 2021 10:48:04 +0100
Message-ID: <CAAdc0hw5O8aUQUdFnbUsiigdkhp_Sd6Djef3Hz9oA8XqN7Mhjg@mail.gmail.com>
Subject: Re: [RFC] new subcommand: git sync
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 26, 2021 at 5:42 PM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> On February 26, 2021 10:25 AM, : =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason w=
rote:
> > To: Jean-Marie Lemetayer <jeanmarie.lemetayer@gmail.com>
> > Cc: git@vger.kernel.org
> > Subject: Re: [RFC] new subcommand: git sync
> >
> > On Fri, Feb 26 2021, Jean-Marie Lemetayer wrote:
> >
> > > Hi folks,
> > >
> > > I created a new "git sync" sub-command a few months ago to deal with
> > > the pull request workflow.
> > >
> > > Its goals are to:
> > >  - keep all configured branches synchronized with the remotes
> > > (--set-upstream)
> > >  - do not touch your wip feature branches (which has diverged from
> > > upstream)
> > >  - prune the remotes
> > >
> > > As I use it on a daily basis, to synchronize the remotes and then be
> > > able to quickly rebase my pull requests. I think it's worth sharing. =
What do
> > you think?
> > >
> > > For now it is a simple shell script available here:
> > > https://github.com/jmlemetayer/one-time-setup/blob/main/git-sync
> > >
> > > If you think it's a good idea, I'll propose a series of patches with
> > > the new sub-command, the manual page and the associated tests.
> >
> > Have you seen 'git branch -v' and 'git branch -v --format=3D*'? There s=
eems to
> > be a high amount of overlap between this wrapper you've written and it.
> >
> > I suspect most of what you have here could be turned into an %(if:*)
> > directive where you emit the pull/push command as appropriate.
> >
> > If you search the internet for "git-sync" there's dozens of such comman=
d
> > (and I've personally observed at least two of them being written by co-
> > workers in real time, not sure if either of those is in the Google resu=
lts).
> >
> > So I think there's probably a worthwhile problem to be solved here that
> > could be turned into patches to git.git, something between "git [clone|=
push]
> > --mirror" and "git branch -v".
> >
> > I don't think there's any interest in getting new shellscript built-ins=
 in the
> > future. We've been actively migrating away from those.
> >
> > But most of the logic in your script is just calling the ref-filter.c A=
PI behind the
> > scenes.
> >
> > B.t.w. you can probably speed up & simplify your script a lot by making=
 use of
> > IFS=3D"" in the shell and not calling N for-each-ref commands when it s=
eems to
> > me that one invocation would do. Just dump the N fields you need split =
on
> > some token, and split on that token in your loop.
>
> Yeah, I'm one of those that has made extensive use of the name "sync" whe=
n using git to synchronize between (POSIX) OSS/USS and (Non-POSIX) NonStop/=
MVS respectively. If you're going somewhere with it, could I suggest someth=
ing like "reconcile" or of it is specific to the pull workflow, maybe "pull=
-sync"? I agree that scripts are not desirable long-term.

Thanks for the feedback !

To sum up -- if I have the time to do it -- I must do it in native C
and not use a generic name like "sync".

As it is a way to keep my branches up to date with the remotes, maybe
create an option for the "git branch" submodule instead of a new
subcommand? Maybe "git branch --synchronize" or something better ...

As using "Pull request" is not the only way to use this command and
also because there is a big trolling issue with the termes"Pull
request" and "Merge request" I don't think using "pull-sync" is a good
idea either.

I know that the first golden rule of coding is "Naming", but damn,
sometimes it's hard to find a good name.

Best regards,
Jean-Marie
