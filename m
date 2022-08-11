Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5AFC19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 17:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiHKRwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKRwI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 13:52:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A780BA0624
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 10:52:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso6095512pjb.2
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :subject:cc:to:from:date:from:to:cc;
        bh=qbS5G/PRBOnuLSpk5zzcj8e/VZNnqoYWUnrXvKpHs3s=;
        b=D5wyUrhZsLu+E2bJ8ImdFUZv95PpRPXD7LUvshvsO1uzFrpf0qhKKelDgIrkab/zEF
         eIs4RAMrEsdFdTFgtuuglAAOo0hnf51ZQ9GIXq9sFSSoI6Co58Q9Bn9lNj3OyBbGQ4LY
         R8VIWJ1R55Jv22x7WF8YXGEcQE5KptBiYu0nE10bbecMnMYNxdCAMHza/akopdLL7Kop
         AYDJESjAXpJqFkjFGUDp2Hj45vGAvnl54WqqlvACmxPqnea00sD9ecI2z0gfKPr3+yrp
         ou33vuqi5bGfsrJxt0wdHNJDti6RDziWw3SHcxQiIdZ9+xSKeVZjlupjrOD6Yz/+8b9Q
         smWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qbS5G/PRBOnuLSpk5zzcj8e/VZNnqoYWUnrXvKpHs3s=;
        b=FtgsZIMoQ10lT8+fuJJOZAXSbw4P86PwwlkDNlGnv/I9hBbEMYUpAjETZgpfN8BTpf
         MMqDoYHt/ckYVW/YP5f7Y+vMs0T5HWPp45c9OXT9bhQtYGoPzm+7ZpZdL6yig2Vk+DO/
         ftweBIPVwNWznrSFv75PofS14fASnHegfzcAnKGX/JDMCAAm7r8sfnvJPGcZi4muwpNN
         SiJtRsjVo49a/WT+kWdCxIW7EN3/EhUEosbfKAwKbZ2IzXGnCidt4fcYhzkHf6i9Z6wE
         Mk9yZ/2SkoUB5mUwuJ7PRCFXoRS9tVQFnrOqRHDfoOLbsw2f45BpS3t7+X+O1CuoC1aL
         mE+g==
X-Gm-Message-State: ACgBeo1pSmi0qVc5rrUYYSlBd5LIzFUbiiRe9Ic3SiYZsYsxwG/fjYH/
        Y/UGnueV7+cxhyCdPh8TbPutoeLCEgtbeA==
X-Google-Smtp-Source: AA6agR4MT2I1RZQViwv6KAMU35SJF4BHNZNs7AyKE6kqgDK9YhEdcihHgjqg20HntKQGDQyHOwAhJg==
X-Received: by 2002:a17:902:c7c4:b0:16e:d968:6343 with SMTP id r4-20020a170902c7c400b0016ed9686343mr250142pla.133.1660240326687;
        Thu, 11 Aug 2022 10:52:06 -0700 (PDT)
Received: from [127.0.0.1] ([106.208.38.243])
        by smtp.gmail.com with ESMTPSA id z125-20020a623383000000b0052d2cd99490sm4370014pfz.5.2022.08.11.10.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 10:52:06 -0700 (PDT)
Date:   Thu, 11 Aug 2022 23:22:03 +0530
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
CC:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Hariom verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Better advertise Git for GSoC ?
User-Agent: K-9 Mail for Android
Message-ID: <ED5A2C3F-8F96-425B-AEFF-179824438CF6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

So far we've had the fortune of working with many good contributors over t=
hese years via GSoC=2E Some have even turned out to be regular contributors=
 to the project post GSoC=2E To gather GSoC contributors, we don't usually =
rely much on explicit advertising of the Git project's participation in GSo=
C (AFAIK) and this hasn't usually been a point of concern for us=2E

Regardless, Google is now considering providing some options to expend our=
 possibility of gathering candidates who are not yet aware of the Git proje=
ct=2E I thought of bringing this to the notice of the community and hearing=
 your thoughts about it=2E The options are:

  1=2E Community discussions
  2=2E Org highlight video

## Community discussions

Google is planning to conduct virtual meetups where attendees can share th=
eir GSoC and open source journey with a 10-15 minute pre-recorded talk duri=
ng each session=2E This video would live in the Google Open Source YouTube =
channel=2E

This is more of an individual thing=2E Some details and interest could be =
specified through the following link: https://forms=2Egle/cbGNSNTaLewT34TY7


## Org highlight video

The highlight video would be a short 2-3 minutes video about the organizat=
ion=2E This could include some quick highlights of projects that contributo=
rs have completed over the years, what contributors could learn by contribu=
ting to Git=2E

Videos will be featured on the Google Open Source YouTube channel and will=
 be available for the GSoC contributors to know more about the Git project=
=2E

I wanted to hear the thoughts of others in making a highlight video for th=
e Git project=2E This might be a bit of a big undertaking that involves pla=
nning=2E It might be worth the effort, though=2E

The immediate milestone for now is to mention our interest before 14Aug202=
2 to Google=2E So, do share your thoughts about whether it would be worthwh=
ile to make an Org highlight video for Git [note 1]=2E


[[ Footnotes ]]

[note 1]: I personally feel it would be a worthwhile one to do=2E

--=20
Sivaraam
