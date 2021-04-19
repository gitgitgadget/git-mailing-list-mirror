Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72531C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 06:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4119D6113C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 06:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhDSGEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 02:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDSGEu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 02:04:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7FFC06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 23:04:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x19so23678214lfa.2
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 23:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kV7vx9xs2h+dcOU+ysqmKxrw04D1bNTFXfhtWMmj6c=;
        b=e6cdSQTKMXDJhnjrUrrJKv/LQuPFMT7UVuyT2QxcWr5quW6zJjBEbWTzgBMiaq/I3C
         6Su6YLqn6fdmZC6FQt8P9MfqU97hG9rqrbNZRQRWOOOCHVJTQ0oyQwoHjk1/fAAqsdeg
         tbHTLa0Kh8+YRcLHUpXvpkEusiZ6mkivyoYrUV53fX4PCHqow+eTRzYkTXrh0HRbAyhx
         4JISR7ZSo3SwP0EVqV0t/NBmTa61jHz0KUTyebeCFwbjhnzpWRb2w+D4Hy+Mpu2EQ7+n
         Rytxi+HoVB3d8rNbkoox40pf/qQs84lqJBPovZrBNcDfvG8AmnihdkWwpCA1zHD9XUJJ
         NRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kV7vx9xs2h+dcOU+ysqmKxrw04D1bNTFXfhtWMmj6c=;
        b=NWFXNqOWywbeRofHRixrlmSJfegEeH3dueOKe0TGNVuWyMDuo3CidFIPNuGAYE/qbU
         ga2ztdog5l/iJuLCJ9gl4JFvwtdUOhe92MVIQbZ/AvVtsGEhKqKiEbOdmSX5YDhYA1L0
         cOCgUcsCLZ6S41ft+W4TDqnUlx0uW2D44wViiSB28SR9+ST+2jZJ9KEQcvEsSm/4BENb
         qZ9RJv7LVJJTkvNHOsYcMhfAki/QNYsAQbwmX25PvLUGBl/lHBczUFpBeFmIImOe4tzv
         DEmkDCaatWKrm4mwk+cYIjc3eGz3iD/c3dKW8VnvBmiJz1OcX0TxcTMWS5SRjh8G8vh9
         f6Pw==
X-Gm-Message-State: AOAM5314/MiWAXn5IStb+TgR7z2btCkOZaygdgnBZ0yL7IAtZJr9oEzW
        87eWKVAGkWpnmzufQu0SHgw+laWYJ/rGUiO3rQdcZ1P41QJkgw==
X-Google-Smtp-Source: ABdhPJzeBFXBMCoMDQMNeGCP/RGH5CPeP2BAlwJ7inoh1q7da6sx1ugBBcJtCMt5vwwtCFeD5P3h8uRIfFdt0yoc4Bw=
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr10590864lfa.461.1618812259358;
 Sun, 18 Apr 2021 23:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <YHaIBvl6Mf7ztJB3@google.com> <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com> <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
In-Reply-To: <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Mon, 19 Apr 2021 08:04:07 +0200
Message-ID: <CAHGBnuOtJ-oHGe+jb5L-qPQQ6v-fQ-1xHC0BPrR4eDeym3coCw@mail.gmail.com>
Subject: Re: Pain points in Git's patch flow
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, patchwork@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 7:54 AM Sebastian Schuberth
<sschuberth@gmail.com> wrote:

> While these concerns could probably be addressed somewhat e.g. by
> multiple independently operated Gerrit servers that are kept in sync,
> I was curious and quickly search for more fitting "truly
> decentralized" solutions, and came across radicle [1]. Just FYI.

Forgot to add the link:

[1] https://radicle.xyz/

-- 
Sebastian Schuberth
