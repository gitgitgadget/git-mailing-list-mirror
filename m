Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14886C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 07:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhLKHNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 02:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLKHNA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 02:13:00 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65111C061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:13:00 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id ay21so20501177uab.12
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 23:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RXSDMi6kGSi7Za30MntwnzL94Ry1qRIU/I1A8DgkKdY=;
        b=Wu8MBdgru5T/BlZF0ticMtwdMuZ7vY66jddQ2foaEKePyBRDWGBeyhlX3+qQOdlTzf
         iI2DLF07Fm38A0nh6DM9kahc21OzlImlm9Z+vn33uGLTq1CnS9OF5cSSRPX587KdRT1x
         9AMAgdlSs/tFzon8tMtIHjoEnD+glL5SeN9QNmIIYOe+FtjCucNq9PNk6yvc1ijnX6cL
         khEJH4o2aZJDawP1P3vOiI6tEmHrU18Js4pBmEsAh71bvx95YjY8JhScYc1QAVfMRZIM
         LaJ2doe5foxD9ouaVtv6UDwQOys9o7RZVV6ASSwx/ifoT3rAb5yZ0QWVPUDgHPyv+DSK
         LUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RXSDMi6kGSi7Za30MntwnzL94Ry1qRIU/I1A8DgkKdY=;
        b=QO7KYAxMzrw60Wks71mGusdh1RLNnz0LGVd23lPYqV5yG6WjfHsXXC7s3wNxJZB7FK
         kywlRDczDwIcqi5P7/EwX55M2qcIEYQmS0dB/h9vKm5j8fC1nglXo/o3KhkiIzx+aB2I
         DNSWh8//WPZ6cpgHLFB4xjPDIok8ZXW8LDFwOVFG8VSCaP1RZ1IljPel1QcK9EAiCLUC
         YWuL7GfcRZQgBsRzqrusRC1bVoUbVjScM+VhHup+8WtRSqv1d3iqloBFXQ/8veVRbnMQ
         eAHNU7swyM9TEh3v9nUDY1P9VRwVblnk8d+WH4T3fOGW1UAWjGXWLSZdHLjIc9vwUsU1
         D1rQ==
X-Gm-Message-State: AOAM530NRYNipYF1QMgkXfVko+oNgJ9T3forbDcphE+rmeBFXfOF90Kh
        CvZqyNc53+6o0U4LoeIt0bsQdmsbStQ6Y7ztX/I=
X-Google-Smtp-Source: ABdhPJyHcuX3ttThgoACNG70Gu9WBPPuK5Yr0pFaW61MBKMSiUrY2RFovJ1OXm0/mBqkJeNxEbSq6Nh8aAv1EPfNkWE=
X-Received: by 2002:a05:6102:292c:: with SMTP id cz44mr21296116vsb.9.1639206779601;
 Fri, 10 Dec 2021 23:12:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
 <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
 <7a8206d3-f06f-07b0-c60b-dea549af7731@gmail.com>
In-Reply-To: <7a8206d3-f06f-07b0-c60b-dea549af7731@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 11 Dec 2021 15:12:48 +0800
Message-ID: <CAOLTT8RG0T1o5nEoHPrm7g-+Z8yw=GSy1U+5A7nxvzk4dBQ6sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=94 19:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/12/21 13.22, ZheNing Hu via GitGitGadget wrote:
> > +-w::
> > +--to-branch::
> > +     Rather than checking out a commit to work on it, checkout out
> > +     to the unique branch on it. If there are multiple branches on
> > +     the commit, the checkout will fail.
> > +
>
> Did you mean unique branch that contains the commit?
>

I mean the unique branch which points to the commit.

> --
> An old man doll... just what I always wanted! - Clara

--
ZheNing Hu
