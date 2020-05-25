Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE97C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50C62073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfZ2IMbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbgEYTQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 15:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389460AbgEYTQW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 15:16:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01883C061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 12:16:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h9so4228821qtj.7
        for <git@vger.kernel.org>; Mon, 25 May 2020 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xciOG4zrUq7MgcCGK0yAI780GaKMktaUEL1qMknn/Og=;
        b=NfZ2IMbtun16A2XhELqRY6UgjZMDPZkJC21DshxVtHUI6STFGV/RtAx4P1dznbQ+jz
         IosBhy8sZU0C3DYxTjRH6vCDDVIOVuHVVWYJxgxtymxJNKp6AkEQh3g8RUaVwlTUbp64
         S/8XsiPPjf5zoivBx7UsmDOWKC4VGErW3MPTgpWnypkWbTOMAT3wHxt3F1dDDYFewfzt
         7jwZlL5vayIvyiE0FD7ehysZL9ekY0MsosorY98Ry+8ho18LLkDHiQae3gh0PCEWZgeU
         ba8F+3rjdH/8i3178lLKJNwpaEIoR5K3COu/6a2aj/rrpLWztweHCEO96YbWC7ASCqKl
         gfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xciOG4zrUq7MgcCGK0yAI780GaKMktaUEL1qMknn/Og=;
        b=LaCwTwIoF0gwBzHt+o+tDMsCNAVZmozuBR3CUvxft3+O+MFM6fjTCxSS0fYlZROKhW
         cNSRF4qMvc1UJ91gXJnxNJmED2pblt9aSOeex8AxTpwA41fVzQ/8i95T1XtYDh9m/56x
         srE6yWrPmrACuokmKTtq5NCJ+DrQSkl4oAu6aBZo4kByMYPkviy8KkRU40d/NrcgeGRS
         61D0anYoF55KbYEi4w4fw/wFnf1754k4ybHxCopLhAO5V8wlEfHP1axeSpMVkDGTtwVr
         t+pBDKnqkngCX3OLKqkPduXJcriLPE4WVOASlhTZmMF1yV7hRE4Sp673yUUOBKzWaTuH
         Pm6g==
X-Gm-Message-State: AOAM532G/4FP/i8I/XgGo1fPz+1uggKfc5xiVbCRG+pc7MmU+41AmXJN
        ciX9ZsWvIvM4MBantlGoC+vqq5OOon+fhl6EX+Q=
X-Google-Smtp-Source: ABdhPJyFhVZWWfkg/U22v5/udn91z8xf2VPuo0WCm7IfP0aKOsCsdSdcOtCjwsKQH79rGJTZhr0xpfxnYPWTBlqldLU=
X-Received: by 2002:ac8:2bc4:: with SMTP id n4mr10225776qtn.222.1590434181131;
 Mon, 25 May 2020 12:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <fa1b8032906c6042a0e5851f803ec0427922a1a5.1589302255.git.gitgitgadget@gmail.com>
 <xmqq3684c096.fsf@gitster.c.googlers.com> <CAKiG+9VXk1vdMM1amQK6pnHcn9H_93-3fkqgK4nwKf=GtrDGyg@mail.gmail.com>
In-Reply-To: <CAKiG+9VXk1vdMM1amQK6pnHcn9H_93-3fkqgK4nwKf=GtrDGyg@mail.gmail.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Tue, 26 May 2020 00:46:10 +0530
Message-ID: <CAKiG+9Uz4YG=Hq9PRN8EhFF_agXNUPRnYjetY=ZNVRE6_VDAew@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] ci: modification of main.yml to use cmake for
 vs-build job
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I have finished the changes you have asked for.
1) Relocating the CMake script to contrib/buildsystems from patch 01/xx.
2) Parse the Makefile for sources from patch 01/xx.
3) Reworded the commit messages you pointed out.
4) Rebased the ST_BLOCKS_IN_STRUCT_STAT and ICONV_OMITS_BOM to patch
01/xx to make the review process easier.

No new features will be introduced in the script, to make the review
process easier.

I have looked at the GIT-VERSION-GEN script and the logic it uses to
determine the version of git.
The logic is a bit complicated to be implemented in a  CMake script,
so I am skipping it for now.

Any other changes I should make before I submit PATCH v3?

Thank You,
Sibi Siddharthan
