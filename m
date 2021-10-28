Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D3C4332F
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9B760234
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhJ1SuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhJ1SuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:50:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BD7C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:47:49 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t7so7285312pgl.9
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e9vGluZgxZ4S7q2C3qa2o24/l/hy7fei4xYct5WKJQc=;
        b=OmV/ajtz7JPbLBi1jFL9+G7xSQkhx+4jGk/wxA2PCnsg6v45amYHG19ylI7SKhOIwg
         XeXz2f2QElHL3Jcazj67h4dWSeb0N54vM0MMePs8/FVa6pHJuLGXvVHZDINkq6rctxD3
         bnF4AXlbljreWyrLtKcu1yqTR3gtBXjbzoORJzRnW38r0efgCe8MdKTeSi1m2rG3Pv7A
         QT/w72bRvRuIhgN2xWbmDG1kjs9pgR3jp8/e3q5tLpKb76tGzr3c9BOzOcuCJE1/U72x
         bc4AkSpKaff4I0y63TDbH6aPhyFNgn+EJTUHFV9oQBj5DHqtuYfDznY0CFatn4AODUhf
         lIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e9vGluZgxZ4S7q2C3qa2o24/l/hy7fei4xYct5WKJQc=;
        b=3YkX+IpJYzQBj0qUDiQ0ruxgOhQflDbWFlkFEnljbNow4jK0g0V2Tw1jiGoVFGB83m
         DRZO2k4ihP+Y7TmnttmQM+BFIZitmxzfNmor0sn4X49MEiCR9ZIqH0NZCEq5AvQ4uGyZ
         agB9Dd9WZ6qlWIf6CGCMcdm4o3wptQmN64Gl7RRk+kmwaTchwFQ6dzWANwc2RQ5ZPIol
         q1LnpMyNyvFvA69FNLsZXYA8NSnh7fBLT1JJfyUUhSV64Z55UjTJQQA6ijJrww1QYWr3
         635Cw013p7zLN4BwB9X6H7Zpa/Yc0upxg7fB98x7ig+edVOvPDcjCTgpHdF/x+zLaeq4
         3R+A==
X-Gm-Message-State: AOAM531UUqRlLG/vTAiFkknmC2pYELyrhRLpm1LBY7QwEDrKtSuM/Vwq
        bfL5IYVy7U2GAemralYkhamssltE4aMJDMEVS/sxTMYWcsc=
X-Google-Smtp-Source: ABdhPJxeE2HMD/FL8YEoXaPdI2LW1SM8DF44V3fdUSR9Reh1GRzuXBuk7TqBdl4+h83cP5Hfwz7QV1sT08DjJSAq1l4=
X-Received: by 2002:a05:6a00:13a3:b0:47c:126:3596 with SMTP id
 t35-20020a056a0013a300b0047c01263596mr5992214pfg.5.1635446869462; Thu, 28 Oct
 2021 11:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <CAN0heSpRZy3+jyc09NEj4NJk4zN4X_RyVk33F5c6tyUE2qMGzQ@mail.gmail.com> <819ab0ed-8a99-2987-79c9-88cd1118b51b@free.fr>
In-Reply-To: <819ab0ed-8a99-2987-79c9-88cd1118b51b@free.fr>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 28 Oct 2021 20:47:37 +0200
Message-ID: <CAN0heSpQpW8HN9FW9ZyuyU33Mn6WoMhL49knWsdKijH-n6erhg@mail.gmail.com>
Subject: Re: [PATCH] doc: fix grammar rules in commands'syntax
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Cc:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Oct 2021 at 11:32, Jean-No=C3=ABl Avila <jn.avila@free.fr> wrote=
:
>
> Le 27/10/2021 =C3=A0 20:56, Martin =C3=85gren a =C3=A9crit :
> > On Tue, 26 Oct 2021 at 21:35, Jean-No=C3=ABl Avila via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:

> >> -'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
> >> +'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <cvsroot>]
> >
> >> -<CVS_module>::
> >> +<CVS-module>::
> >>         The CVS module you want to import. Relative to <CVSROOT>.
> >
> > Here's another "<CVSROOT>".
>
> Is this an environment variable or a placeholder?

I don't know. I see that you've dropped this from v2. Makes sense.


Martin
