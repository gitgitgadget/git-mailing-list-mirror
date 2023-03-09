Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47804C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 10:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCIKTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 05:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjCIKSw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 05:18:52 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DCEA277
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 02:18:03 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536c02c9dfbso25504107b3.11
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678357082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBiAMEitKUalNPEcmeYOQgLw1WqT0NyR0s0dZ75QF+Y=;
        b=VSkiaRsOPBLe2lPnh2+8R/dMkQRfyntHEWalIVhXCyWhcfe3VlGyI0vmtQtB/GXRh3
         YNq3xzGCkSYbrh5sy3/dqXpB2GjmT3WMG9wRgy1/Bgjjo+ZukURixCJlgQivTr4qpCGx
         nqL6XEJaOudMUor36VnNhOjD5ADZlhOj3/DgQncQdP093A2C+EJWymIHLFZS0hbSI7Wt
         jtw8gSzPMhsMhHBw9jo5945Pg3vR+GzmZ4SIgjWojAhC0I+YUEn/waQkS3N43CoLu44N
         ZSAN4W8dKEk0zyb66wMGr0I0/CL/WvxDWr/zwCHu4RZ6VQoxC6EAX2AejhXXocVtLtHF
         Vsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBiAMEitKUalNPEcmeYOQgLw1WqT0NyR0s0dZ75QF+Y=;
        b=xOKvc513EyRODzKnzawqvb2QprgsMchuqy6Z86ENHUdgQT58qHB23Y+oP9w+uHkr6B
         NsihLSMoeK9SCcXL2GH8uv/pGKtOdKvB540LZGEi92eT0/cfOJyjiJjpPT3uzuIqa3oG
         6yom/hiKIuSIa4oAFI4Mhop2YeUTJ5q+Uf7bl2TiCg2qAiftxHacDSrzOcYu+5usTAKx
         BUbwVsyimtgTLx6hLpxTgMLDj4yU+EBaKOAyF0Zmfv3zXc7l6Ejhwv88FOUNjHeEOjCw
         168hBQwbv/8oXO3bpelFFhPbWiXWqx0toqAsnPEdzXuxT6q8xepAnqhWpRvUGYZtaqTZ
         KK+Q==
X-Gm-Message-State: AO0yUKXPW/vxUd4fNmkzYP8P6u48cg3pXCZS9mnIiYUP4lRQuZOjnSDd
        q5LR350SUVsIF8lSuloZ85OOVxClw7GcNnQk0ix09Au8fEI=
X-Google-Smtp-Source: AK7set9P+EgzKfJNAzAbwiObjZhDHxF9DCG9nO3ZwbSPEP+kN0L3uBxPNy/YKDzQDKE+qiL2rv2B4ReB2LSK+weSxg8=
X-Received: by 2002:a81:4521:0:b0:53c:70a4:bca2 with SMTP id
 s33-20020a814521000000b0053c70a4bca2mr14071243ywa.6.1678357082231; Thu, 09
 Mar 2023 02:18:02 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
In-Reply-To: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Mar 2023 11:17:51 +0100
Message-ID: <CAP8UFD20=SScM3XA4mjiNs=rHJY3i_9MOcL8uxsFT-mn1-JH1A@mail.gmail.com>
Subject: Re: GSoC 2023
To:     git <git@vger.kernel.org>
Cc:     Victoria Dye <vdye@github.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

On Tue, Jan 17, 2023 at 10:34=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:

> GSoC Org Applications open next week on Monday, January 23rd at 1800
> UTC and close on Tuesday, February 7th at 1800 UTC.

So Git has been accepted to participate in GSoC 2023.

I have recently received emails with "GSoC 2023: Be sure to add Org
Admins ASAP (and Mentors too!)" as a subject. Unfortunately despite
trying several times I haven't been able to do that. There have been
emails saying that a bug was fixed, but it seems to me that there are
several bugs left preventing us to do what we are asked to.

On Firefox I cannot even log into the website. On Chromium the "Add
member" drop down list doesn't show any member that I can add despite
the fact that many people are shows in
https://summerofcode.withgoogle.com/organizations/git/members

Today is supposed to be the deadline for each project to have at least
2 Org Admins for GSoC 2023, but it looks like I am the only one and
cannot add a second one because of the bugs.

I have emailed gsoc-support@google.com to get support and will see what hap=
pens.

Let me know if you have ideas about this.

> The GSoC contributor application deadline is April 4 - 18:00 UTC, so
> (co-)mentors and org admins are already welcome to volunteer. We also
> need project ideas to refresh our idea page from last year
> (https://git.github.io/SoC-2022-Ideas/).

We still have time to add project ideas to
https://git.github.io/SoC-2023-Ideas/ and it's still possible for
(co-)mentors to volunteer. For example perhaps someone could co-mentor
the "More Sparse Index Integrations" project along with Victoria.

A project idea that was discussed in the past was about improving the
git-scm website and perhaps removing the Heroku dependency.

Best,
Christian.
