Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30615C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E9260ED4
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhGWI4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhGWI4n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:56:43 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D9C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:37:16 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l126so1705888ioa.12
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W7vM7eDzYWpGraNK7E7s345Y3oi6FaWVUmWFbgxCeX8=;
        b=fTa3UPooJqvdu8THuHg0nOLYxdlg4DV5bUDUg6ExMX5JcX2SBs5J6LBCBZ3B/aPFkZ
         bvRM5SpwwIFtYjaSe6F467v2sfpDf8Ejmny3aynpvzG/gb/Bbtdk9RGD46B5GnNpdSU0
         3lWugntOQ5zimFd9FPCA+oNaM82pHQCS7epYDIUUW6SRocXbxSKMlDwp+H62+kHVUofh
         2PMWAlLTTWt4oWnhWoMWLMUMZ/wEzBgb/VMVstnttl0BAb8TY4JaCXmo5rcbXKzE6FHy
         fqiVWHjgUCgez5J5MmawENdWvuC3Y+8Q3MknzNlbtMjE4qPfAXR7q/EjiHKcaGc18s/l
         nV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W7vM7eDzYWpGraNK7E7s345Y3oi6FaWVUmWFbgxCeX8=;
        b=Mwz2gA9CyMcxsn1IyQtoR9x1J5uZLyOITAN46g0ZSWTa2/JKUPWAC5LHWg1LaBfvlC
         ctgSETIzVMdHlMxGIRZOknDQ+5BmYXGMoUewH18WUIezoywMPniViSYaU1pEwywIMr6n
         90+CgH0wQqzeYlrFBklchpj8aW2F6xcUa3q3YWUAHj0WuZE0RUQAk+f4U6xgKV1tBNTs
         IhAgIrcQd+A5UXBknnL3sNQaBF2p4Ju+SQkgtT6dfyUGJWX3EXC2hh023KWz6fUWowwe
         svNrBxsfSq3tHolohCLxbUCJI17bGwBiy6bYISgzAoNODEPrbLBVBI3k+gmp8wQPRCop
         hN+Q==
X-Gm-Message-State: AOAM530esKkSbnMP56h8JhrTnKHUVXefePcO5CefacKGs1Qzhp7ruvFF
        H+Z1iEZkG8MMrYOl55M4mS24XSL9I6THuJ2Rn4o=
X-Google-Smtp-Source: ABdhPJx5vxUNxc/liyaItv6sBxH/5m2wtSO6f4VTd6LEoF/wiwAXXKkDDg2uPqoBeqr/rG2V3rNfQUfZVmJyJBvfOnY=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr3227597ion.203.1627033036409;
 Fri, 23 Jul 2021 02:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com> <xmqqo8au82i0.fsf@gitster.g>
In-Reply-To: <xmqqo8au82i0.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 23 Jul 2021 17:37:42 +0800
Message-ID: <CAOLTT8Ty47fyY7T3d68CYPKh9k+HAHsnCLJ=F0KaLm+0gp3+EQ@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=885:25=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > If we set the value of the environment variable GIT_CHERRY_PICK_HELP
> > when using `git cherry-pick`, CHERRY_PICK_HEAD will be deleted, then
> > we will get an error when we try to use `git cherry-pick --continue`
> > or other cherr-pick command.
>
> I think that the GIT_CHERRY_PICK_HELP is an implemention detail for
> various forms of rebase to use cherry-pick as a backend and not for
> use by end users.
>

But someone complain to me that the cherry-pick advice is not good enough.
Think about a git newbie is cherry-picking a patch series containing
several commits,
E.g.

git cherry-pick dev~3..dev

And then he (she) will see these advice info:
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

After he resolving git conflict, execute 'git commit' according to the
prompt, A terrible thing happened: CHERRY_PICK_HEAD is deleted
by git and no errors are output. But in fact .git/sequencer still exists,
Wait until he uses the cherry-pick command next time, the error appears:

error: cherry-pick is already in progress
hint: try "git cherry-pick (--continue | --abort | --quit)"
fatal: cherry-pick failed

So we should not encourage users to use git commit when git cherry-pick.
It would be great if it could provide advice similar to rebase, like this:

Once you are satisfied with your changes, run

  git cherry-pick --continue

> I strongly suspect that the right solution for the breakage is to
> unsetenv(GIT_CHERRY_PICK_HELP) in cmd_cherry_pick() without touching
> sequencer.c at all.
>
> It _is_ ugly that a helper that is responsible for emitting an
> advise message also makes a decision whether the pseudo-ref gets
> deleted or not, but a fix to that problem should be done byy making
> the logic for the decision less complex, not more.
>

May be you are right :)

> So, I am not enthused to see this change.

Thanks.
--
ZheNing Hu
