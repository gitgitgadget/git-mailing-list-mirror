Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0791FC433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 03:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF23611C9
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 03:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhDXDpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 23:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhDXDpS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 23:45:18 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D3C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 20:44:39 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v6so23346998oiv.3
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 20:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=Z///F4iLRkeuoOAQheoVTPrzAbF3rMOoQixvyNwFd8I=;
        b=S3ClyHC1CwkNcbVX6PR+I9n3l/yVmd2BSO9RDykNngMDVX9qxJQP9kzeSMcqftqv29
         To8crQKyJUDiBBNqyxcE3Y17d4XBpgaRkuzM9sRiXs+UHCHw0P829pbLC3p9g9gK+3DW
         LwQLf72R+k4fmrslo9Daa9JWsskqtcnkHQFksEWofqiQqqZhs/Y9GESQyyWvnZC3ztS4
         ml4gfGmCQLZqH/c0E4BW8TaZYEGI/vHlCjb53+95BapJYNnjhdQyFFO7FewyjZeZhIYD
         qEMX8AcQEcdy0BjIqH1Rmxrjwwt/bBQbmYarY5khU45wiIVfeICGIqWWzaXdIZ+sCvD7
         EojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=Z///F4iLRkeuoOAQheoVTPrzAbF3rMOoQixvyNwFd8I=;
        b=iJB9BWDaHHmReTJ1TqjtzO68RIlVnhrJo6KZlqjn4jwOkzRCuKWq7pVitjptIadIXA
         ACN5mB6OWjZ8momcE5cExRISLegD+nvti9WJqNEVoXp4y0MCasGepnz19ZRxMutI4VLh
         CMJETVMmYGsvS8Ql+PisTAkJNrsmo191K/98mhNW4V7KAkgDDO5zmTjveo3NJuNxECZU
         5G37NXUgQOrkvFi/aPuslsoGh5PVSoXSIVZvrs+3bgd1kkjZCfn7hfP+9WW7Yg2V2WKL
         caZP6ndQhwjA/g1X8XWKI9vgLvQ5R4rboa9hkHyLWgN5gwRDO8dHZJkV9rg+nQY5DkNg
         x6/Q==
X-Gm-Message-State: AOAM530nf/d9R01de/vbefAUJhIA/ahZheGRc+0+wOa9aZsZsBNswZk9
        UiMa1AKg+FPTP5ln8hCDiZg=
X-Google-Smtp-Source: ABdhPJwTUAnvMGd42iuFCzF8uOQ3oIjoRU4ViGI7Wz5XUcLzJvU006zQ54kB/EuYkTayZPH545C1PA==
X-Received: by 2002:a05:6808:ab6:: with SMTP id r22mr6304073oij.139.1619235878964;
        Fri, 23 Apr 2021 20:44:38 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t19sm1840913otm.40.2021.04.23.20.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 20:44:38 -0700 (PDT)
Date:   Fri, 23 Apr 2021 22:44:34 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?QW50b2luZSBCZWF1cHLDqQ==?= <anarcat@debian.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60839422353fc_10cb9208c7@natae.notmuch>
In-Reply-To: <87k0osfpt8.fsf@angela.anarc.at>
References: <87mttofs5t.fsf@angela.anarc.at>
 <60836fa129078_ff602089c@natae.notmuch>
 <87k0osfpt8.fsf@angela.anarc.at>
Subject: RE: how to rename remote branches, the long way
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antoine Beaupr=C3=A9 wrote:
> On 2021-04-23 20:08:49, Felipe Contreras wrote:
> > Antoine Beaupr=C3=A9 wrote:
> >> Before people start throwing things (like `git push origin oldref:ne=
wref
> >> :oldref`) at me, consider that I've been beating my head against thi=
s
> >> for a while, and everywhere I look basically suggests this:
> >> =

> >>     git branch -m to_branch
> >>     git push origin from_branch:to_branch :from_branch
> >
> > Better:
> >
> >   git push origin from_branch:to_branch :from_branch &&
> >   git branch -m from_branch to_branch
> =

> How so?

If the remote branch can't be renamed, then the local branch isn't
renamed either.

> >> I wrote this primarily with the "master to main" migration, because =
a
> >> bunch of projects (including mine) are suddenly, actually migrating
> >> their main branch from master to main. Personnally, it's because I'm=

> >> tired of being yelled "master" from my shell prompt all the time, bu=
t
> >> naturally, I guess opinions on the matter vary.
> >
> > Just tell git to stop bothering you:
> >
> >   git config --global init.defaultbranch master
> =

> I think you misunderstood me; I am tired of seeing the name "master"
> everywhere.

I see.

That makes me think we might want a converter that translates
(local)main -> (remote)master, and (remote)master -> (local)mail
everywhere, so if your eyes have trouble seeing one, you can configure
git to simply see the other... Without bothering the rest of the word.

I'll give that idea a try.

Cheers.

-- =

Felipe Contreras=
