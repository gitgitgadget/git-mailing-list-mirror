Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50553CD98C7
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 05:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbjJKFsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 01:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjJKFsU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 01:48:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7428E
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 22:48:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9bca1d96cso10303365ad.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 22:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697003299; x=1697608099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfElPHObmvaPYLYiUowpw02kqOBUeyyLxlVuwIjMFSk=;
        b=CYy4OgHKT3je7DgAZRQi0n7hYQsZZu9p67wGrvd+xhgi0AKvGtm1bZUnych5Fpe6uo
         ROfPI8deATE+vZjKb3p6NWEF7Bf7rA0r1dYO+1YdWQy+5RjiAy5ndIHyMD0p3cOb3KSR
         ikeDJfOu/TY2yUSBOJN63/J5B7U0Hpl6PCCUaqQIRJ7N52ju0prAvOSA8eSJPzfmUHRP
         Zolnk6WCfHXMNqzx5+DJModl2b4WfoZ23JS7gzAmIhWN6Yvb929NsUNdYggbJjJflWml
         RVWn18IpcPtmXoeJ5Or/N5RlOkcQ8IWN+9ChAHnKlmNaYNhkH9kyuCfGnF27TAqFa0Gl
         fp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003299; x=1697608099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfElPHObmvaPYLYiUowpw02kqOBUeyyLxlVuwIjMFSk=;
        b=qHgE+yxSKNstn5DUepYnZbt1AsdPMWH7QMqwZwekTczDMxJatnh4FvfVhmT8hjwf3A
         F8YwEcuj39Kkm4WgkcNHzKsLrpYgVGKWP8P4U5bE7C5QcRwXWRoSDFFzOQQ7ZOIaV3ga
         AgchDCdw5P15eFJsEzUC3ngYO0mRG68sEA733ScOy9LSaYPoxIb3QEvDsk93sf1lpQlR
         2vj9JxmIXsawS8cZhcoRdoAUBE4ZmlFD4ZbzlRmCBKHqSgt6pYTA1JM4XZxFqGgViBbP
         onay+sER/wD7f7fVLFSg7p0L+Hhlzt/9pyyZGZGnqnvXJy31tmOyS6u2CfM6OvSq8OYq
         OB5A==
X-Gm-Message-State: AOJu0YwN/3ljN7t/YcxJch8ZndTKugZaflnVXUvsI7fofXXfVMIPyCpI
        mwtDN4Melzc8hUmQsFrZ93CDzhz/X51GXe4NQbw=
X-Google-Smtp-Source: AGHT+IH86uKqhrSOfPbqxA1g8bOte4XyBWfM1tYiaPwQXJe+FmJeV3oQChv3BaNcKTp+tpaQDfHdQ3RbO02XCPynBrk=
X-Received: by 2002:a17:90b:1112:b0:273:f51f:1626 with SMTP id
 gi18-20020a17090b111200b00273f51f1626mr15268395pjb.35.1697003299150; Tue, 10
 Oct 2023 22:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHH8bHBA4emP2DkDEzcXncT4K5zEN-pCS+7jjer4R1_kkCkFA@mail.gmail.com>
 <CAP8UFD0mMi2JkvqMdf2mfUw2gA0Sog42ks3umMgsG5k_+W75xg@mail.gmail.com>
 <CAJHH8bE4QWR1gCgH5mG8qaa5Dq19L25y3VyRxAc3+PQn93oEbA@mail.gmail.com>
 <CAP8UFD3WzgADiy07uLGpj23r3jrUnYh_Wdsc1N8ZoaAHQPDZag@mail.gmail.com>
 <CAJHH8bEa=xE_xNdbW4rDJQQ9dacAuFQseajdtBmGnZ1bDxZsxQ@mail.gmail.com> <CAP8UFD3RV-70RG6H86+7E-ZKrqhfgFRfRQdMc6DLGMXPAEf31Q@mail.gmail.com>
In-Reply-To: <CAP8UFD3RV-70RG6H86+7E-ZKrqhfgFRfRQdMc6DLGMXPAEf31Q@mail.gmail.com>
From:   Isoken Ibizugbe <isokenjune@gmail.com>
Date:   Wed, 11 Oct 2023 06:46:52 +0100
Message-ID: <CAJHH8bFLqs7B5UaCFZv+P8yS2zeXLoKoV6YTUB_xFcG8ZLn_WA@mail.gmail.com>
Subject: Re: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

I hope you're doing well. I did some research, but unfortunately, I
couldn't find any clear documentation stating that setup tests should
be renamed. However, I did find another issue that I think I could
work on - 'Amend error messages and prompts of various (sub)commands
#635'. Should I go on with it?
Thank you for your help and your guidance, I appreciate it.

On Mon, Oct 9, 2023 at 2:38=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Oct 9, 2023 at 3:33=E2=80=AFPM Isoken Ibizugbe <isokenjune@gmail.=
com> wrote:
> >
> > Thank you Christian for the help, I have another idea for a micro
> > project "modernizing a test script". I have found test scripts that
> > needs modernizing , which is to rename the setup test 'prepare
> > reference tree' to 'setup'. Is it appropriate for a micro project and
> > should I go ahead with it.
>
> I am not sure these kinds of renames are worth doing, but if you find
> some clear doc or Junio saying that setup tests should be named
> "setup", then that might be worth a try.
