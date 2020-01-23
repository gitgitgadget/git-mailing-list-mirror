Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2412C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 20:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0C422522
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 20:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qx3yVCMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAWUS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:18:26 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33534 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWUSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 15:18:25 -0500
Received: by mail-ot1-f44.google.com with SMTP id b18so4069790otp.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 12:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVeO4YGbcFCXDodp/VvIUue7EwyHBdRBZnF5Puem/Yw=;
        b=qx3yVCMUTrZwlOhrPEcsP0kXE/1NVH16l5GKi+xEmfL0PMUKqJWx2xWokg+r69zEz4
         jojNXWLUtGxPovpfuEKIwtIzoau/UVM6KrHarss8luTvD6PGJ9uKnjR97Oa9Ef4+qp86
         lba2ZLqZ6KivFGF8uTuzQVXx+SFtkvN/jTixhmoUHKce2sKJUE/WMzO8y8AgDYHBW6/O
         T0DQgfFFkR+/Hk6dpmZKHZJ2mjTZrLP26EhViq5uHnboOeNhYgeJrgCq97pogJXSwawu
         qKz/MEhZxS2/4MRWWlf5wF0n4EXhtUDdR97IhsYnor+h25etSqWek10U9erPolve/X16
         DbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVeO4YGbcFCXDodp/VvIUue7EwyHBdRBZnF5Puem/Yw=;
        b=cylQIzhpvO/WE3D4+w1seuTgL/lVSRCX91QlEuBUVwJCun6c115VA4Z6T/nTakzXwO
         xXpAKGWrGd94EFbYO2viPqdg2wzVVGPaihw0/ByjQeNg+Xz1xoi6Qvmu3eznBQ0gD71b
         86qwiU5hwuBqkII7mtvlihNv6e7mzlLksMC2xYXpHzxFPmyCOfv1qO9/AOnIW7H3Sx9J
         KjbYXB3xJ41DOADUnqsoy4WGl4YzHMyNalXeo2Lxx6Y6QhIPzfWBBGVQyjwtcYrjGJ+V
         scwFOje3CrmVzwYDcO1v6dZKaFduZ6ZR4vCy1Yzw/JY5gyI9MP6qB1q/guQVYzQOG99I
         TagQ==
X-Gm-Message-State: APjAAAXdTNfJz3Hb5Ma+NM905IfvgjOJbXNUuiLYBR/pJ8tZojuXDAaC
        kSyNU/H4ifmG02rlrxMAfVPsooapQSkaOzehyyc=
X-Google-Smtp-Source: APXvYqxwkSEPyR9W/8k/yIffRMA5pj8W0lDht2CCtez405zkOdgb4C06S6zPVxkuGFi7fCH9PFTPEp+IbjMsMG/HncE=
X-Received: by 2002:a05:6830:1257:: with SMTP id s23mr74745otp.241.1579810704731;
 Thu, 23 Jan 2020 12:18:24 -0800 (PST)
MIME-Version: 1.0
References: <CA+CkUQ-72jKTMUQuGvYg+o5bp3DoKxX5bFCUrWyGLf_tzVydsw@mail.gmail.com>
 <CAP8UFD20Jh4HRBUTUfy6t72r_wyX3F2RWoyRVwBx4dY2VfhrbA@mail.gmail.com>
In-Reply-To: <CAP8UFD20Jh4HRBUTUfy6t72r_wyX3F2RWoyRVwBx4dY2VfhrbA@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 24 Jan 2020 01:48:13 +0530
Message-ID: <CA+CkUQ8vDG6HHyzX=bEEmzsZX0uCm4cpRD5zev5tY18ZFueuPw@mail.gmail.com>
Subject: Re: [GSOC] Introduction
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Thu, Jan 23, 2020 at 4:46 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> It is not clear looking only at the links if the issues you solved
> have resulted in some patches posted to the Git mailing list or just
> fixes in Git for Windows. Could you give us more details about that?
> For example if you sent emails to the mailing list could you send
> links to those emails?

My apologies, here are the links to the patches[1][2].

> If you have already sent patches to the mailing list and they have
> been accepted, you don't need to work on a microproject.

Both have been accepted and merged successfully. Those are just minor
issues, so I don't they can be qualify as microproject. Although I
forgot to tag [GSoC] with the patches.

Few Doubts:
1. Do I need to tag [GSoC] with every patch I will send before GSoC or
just only with a microproject?
2. Can I use GitGitGadget throughout the GSoC period and for my
microproject? (I'm quite liking this tool)

Regards,
Hariom

[1]: https://public-inbox.org/git/3b4b8e0353d705ea649c9fb608c021b35e6d8f5b.1571250635.git.gitgitgadget@gmail.com/
[2]: https://public-inbox.org/git/177deddcf83c2550c0db536a7a6942ba69a92fa5.1574600963.git.gitgitgadget@gmail.com/
