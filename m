Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2FAC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005442068F
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrHf+i/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKVUJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:09:00 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:35389 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKVUJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 15:09:00 -0500
Received: by mail-oi1-f169.google.com with SMTP id a69so399876oib.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 12:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hktNhp6X2D0/XKuIrLuiypdld6lITi1JjvxcFdzJ3LY=;
        b=VrHf+i/wrZk7Z6jEOHI8U66CSMR98XySJuSxjxFlzypuPfuGwE0kJTl3Mlba/SuOwP
         CbMgpw60xhhyT6NpwXtUw6AG90c2zdSkzDpQHIZvQ/HcvEyBwEgBi4+4jhytX9mKNeAX
         6ZW0H3HlC0Qh3TyV4/GLDLqtTGHoq52TVNDoAb/HrZFq1OvWxPXrL1zNNxK/2lA/lozt
         AsDcSxC3pT/iZ5LXtZIeVShaUfHUOqKctu7zbsGfK5hR5dxmryesjudw7j+QtoS/hONI
         +NML8ETMl+2+EGC79Gi0RZZ6fvZKpAXVhJIVIP4P/dpDDmDF+mLUuiQ4TqFQRvx/ZxBA
         jMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hktNhp6X2D0/XKuIrLuiypdld6lITi1JjvxcFdzJ3LY=;
        b=n+Ganu5Q9nxQST75ma9dtU8Gp9NpM2f159nxeHfQ8Q9hZRoDwKVuG29d9UlMnLJO9l
         873LfurQreC+uz3WnI1XQRct9UhXGbslEijmzJVJW2WshjAXgge/OyuHbKj24/LhuvqR
         RrNv3I+/ykry1tEYRkPjkROwxBVqUdBnZxcTA0eH1rJVba7PxL8IaI/ZP1MTeFEX9E7x
         LUWAxN6FeVi58NdhJ4CQ3wELeqxONGP0UHbyb1Ds8w9x7eGtRNHsaFse47wglnJK1BGH
         Rc7jpZmwMH2OrAQlubjSO1jSmdnK1vzN3p7p5wA5gryXKjmmqgBChdsitTnorQBqRgSX
         sPEw==
X-Gm-Message-State: APjAAAV/MiDhPvgsy9QyWHZRyo1UMbxLJz5Sv9lENKDk4eCv9odGDwdE
        JO9cyRrUawqiMt3hWMYtDEzg87LDCUGPP6ylvO0=
X-Google-Smtp-Source: APXvYqwtRSm9BQie0XXi7Jyk5eAr+Hv25AM7yAwX01BAadTLInm78/jOKQ21IXeD0zsI6srqiKFqe9ewJSjHiCIbgNA=
X-Received: by 2002:aca:1715:: with SMTP id j21mr13058952oii.6.1574453339219;
 Fri, 22 Nov 2019 12:08:59 -0800 (PST)
MIME-Version: 1.0
References: <CAOAGZwFScnS=FSfe9WiJ2h5W1-NCtxU4HM4FUH9LwtcCRuimcg@mail.gmail.com>
In-Reply-To: <CAOAGZwFScnS=FSfe9WiJ2h5W1-NCtxU4HM4FUH9LwtcCRuimcg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 Nov 2019 12:08:47 -0800
Message-ID: <CABPp-BHb7z4PnyWu9YOiJv8jLEQnvmAHQmFq2=d=m1njtdDwug@mail.gmail.com>
Subject: Re: [Bug] git diff assumes executable permissions change is always 0755
To:     Wes Hurd <13hurdw@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 11:50 AM Wes Hurd <13hurdw@gmail.com> wrote:
>
> git 2.24.0
> macOS 10.14.6
>
> To reproduce:
>  - Start a file, commit in git
>  - chmod 0744 file.txt
>  - git diff
>  - ls -l file.txt
>
> git diff reports :
> old mode 100644
> new mode 100755
>
> expected:
> git lists actual permissions of file
> new mode 100744
> File's permissions are 0744 (-rwxr--r--)

Thanks for the report, but this isn't a bug.  See the final paragraph
of https://git-scm.com/docs/user-manual#tree-object.  (Said another
way, git doesn't track full permisions of files nor ACLs nor
creation/modification/access times, or other filesystem-specific data.
It's reporting to you the data as recorded in git which for normal
files will be either 100644 or 100755.)
