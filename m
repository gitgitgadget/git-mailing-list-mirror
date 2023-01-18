Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FAEC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 15:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjARPad (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 10:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjARP3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 10:29:45 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD6E3EC53
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 07:29:27 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4bf16baa865so471722757b3.13
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 07:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5kVEj+PJtT8F3ACtxHvWtOIA9uWjgr8h7yM+4lEgy4=;
        b=AlYnI3pLO18LqORmnbFD05rD9OkpQJ/DZ9mKOnXPHB9c5qFYk2xktTtgP5m3buih5k
         j5XDYF5DjAzeFLFjzLGtO3aNX0U1IP/876zy7hbhwDVEjcqrhb1nXrDKCYxmWzHgkSGV
         oa+LI5KEkAo5CsRAcSLumUmAyhTPlZs3ut2ixW/egiKUhlEy9WGmUAJV15kP5M/wWHfH
         QHKD7kRw/fHeOBveXxYz2X8AICywQCA1WLA6oqxZEwJse8fMRHXAnOs078MoCqIbtPDT
         AEC/lFBUHW8DzbTyIFEN/Epvh12xoXUixF+3Ix+LOne/7cDuPQXzAduFdd0znLd2Qwss
         oVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5kVEj+PJtT8F3ACtxHvWtOIA9uWjgr8h7yM+4lEgy4=;
        b=IGiMBJ6k/MFtU+biOKdMzjfH0oTdp2Kp5v1rmpdSfbuRYMlj5wecWfL6Ef6OE6PJXq
         vCmTh71r9xti00HbZxHt1GRq0C92fDmzIVPDtUKHEMbV5fwuaqmKib6m9vtqSHK+O7ll
         Z1FyveoYfHF0wdgB7GwR5hvZZIg7QIDsp3xnrMTmOzc8i0o9//+3nMROov7KgFAewQmj
         m4FCpvhy/vwhHeL3LoeL+900XXh9sxhIIn/vQkwnj2MJu2T1eKPFJ/tQKJ8R+WeoOeeJ
         eODDX7K/QBNjrwE4CjoWpGqKnpDF2DZLseztO9zjmwl/j68dSJYOo2zOCPSc/EcB16mT
         JPbg==
X-Gm-Message-State: AFqh2kqgdM/PMhbevtqNWcaD3OK86/msjbli8X4TFov7C+dWUDx/SEY0
        GxIwpYUe66bdRTjeOY+MNVQiFOUYBjCzGDI2IJ8=
X-Google-Smtp-Source: AMrXdXt3rUQabpPSMcn9eDaWqAccFFacKx/zhjJDepgVo/ny7DLJMD6XQdOU54hFKxxTmpIqoad5la6LGOF698xtucc=
X-Received: by 2002:a81:6805:0:b0:468:d879:43f4 with SMTP id
 d5-20020a816805000000b00468d87943f4mr952502ywc.404.1674055766440; Wed, 18 Jan
 2023 07:29:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
 <abec912c-065d-2098-962e-41f9646dd046@dunelm.org.uk> <8025d5c7-ab55-c533-1997-05b4c7339d61@dunelm.org.uk>
In-Reply-To: <8025d5c7-ab55-c533-1997-05b4c7339d61@dunelm.org.uk>
From:   Adam Szkoda <adaszko@gmail.com>
Date:   Wed, 18 Jan 2023 16:28:50 +0100
Message-ID: <CAEroKagqxC86X0SD8=tK0w+yXL7QecZ+z_7sja-K6ajs0=Z=BQ@mail.gmail.com>
Subject: Re: [PATCH] ssh signing: better error message when key not in agent
To:     phillip.wood@dunelm.org.uk
Cc:     Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Good point!  My first thought is to try doing a stat() syscall on the
path from 'user.signingKey' to see if it exists and if not, treat it
as a public key (and pass the -U option).  If that sounds reasonable,
I can update the patch.

Best
=E2=80=94 Adam


On Wed, Jan 18, 2023 at 3:34 PM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>
> On 18/01/2023 11:10, Phillip Wood wrote:
> >> the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. All
> >> that
> >> needs to be done is to pass an additional backward-compatible option
> >> -U to
> >> 'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interprets
> >> the file
> >> as public key and expects to find the private key in the agent.
> >
> > The documentation for user.signingKey says
> >
> >   If gpg.format is set to ssh this can contain the path to either your
> > private ssh key or the public key when ssh-agent is used.
> >
> > If I've understood correctly passing -U will prevent users from setting
> > this to a private key.
>
> If there is an easy way to tell if the user has given us a public key
> then we could pass "-U" in that case.
>
> Best Wishes
>
> Phillip
