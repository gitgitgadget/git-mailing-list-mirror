Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B877FC433E9
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 11:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACF864ED5
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 11:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBSLKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 06:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhBSLKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 06:10:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71939C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 03:09:42 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w1so12071091ejf.11
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 03:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GzKhrKkZEzxNxPZV8EtqMfs7c5rJSszgdv0HI5r2ITI=;
        b=rhoXFDiijffWMygkPqUWJSw3xPVy8AEj63lyj30FPh3VPFz7OnEEUBBysOB5xp2OVz
         Bt1Su0vVFkFXyG02su3zQuz/FXYVh3cA9unH9as/bLNLvy+k7uvEAta4TATj64mdgJ4v
         UyPhbgfedQCQGwsWOiNSoUpkMIBAUe1BuSWo434P0E5oxSbVXPnQC+SAovPFbc9i7QiH
         uKwLWFjadBiHYorekTg1R9UUWkrdJmFTEai9+XvC4J7cls5SChLrBkh0WSkec+ipov20
         R0+8Hdrf+hz7UUfvH9LHbId/525NSmw8/E4Y1wSLVVDLooixTpX1XWc7Ks8g9BzRi3tP
         PnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzKhrKkZEzxNxPZV8EtqMfs7c5rJSszgdv0HI5r2ITI=;
        b=IL7w0yiQMeeNs6VopzEYAUG9952SYSLv2umgBbzp9j170thQxGTDUUXItSrw72ekzX
         R96t+4vVBXRxRRL+A1luwehswEhmUGScOr0CCW/uFQ+7srrfTwCTDnSe/b+hYCgtc/XT
         jAFU14HMpFeZ9tBKIbPXGUymeGcqCgd1KEhkmQK6odrs4H4DP+OHMYWtRIpjyfNzeaTH
         B+6KzwS9hUM7CWENixkNRaC/DDE/EFc94hEmJih7RohgVCsAkBNgtO7OF/2r9nv8Jiwh
         2fHxUuvvbCS5nKSmqhYHTqsuqqYJN6VFEatwP5jdJvDQbMCSsbP4ypddPcrE/kUJzYP6
         SNkQ==
X-Gm-Message-State: AOAM5337ViCu2/Q2xqcaihMK4zUeJSgPdOmlZUyoj/aoMIpLNv1IV6X2
        eSxj+j0I4fXOF9S37+7ZEYjrGuNEnu98ZT/71R+I9ppT+dfm+A==
X-Google-Smtp-Source: ABdhPJwKyHmvab8NPsy7ekx+rSUiGcxpwZXXgscPG8OZJQjmCy6yDUSP1yDI3kjmbN5wiyosoGSX43g/USOCq/0vCuE=
X-Received: by 2002:a17:907:98d7:: with SMTP id kd23mr8241301ejc.283.1613732981188;
 Fri, 19 Feb 2021 03:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
 <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com>
 <CA+CkUQ97+Afr9TUtKnb4LE1tK8z=UfSkJY2JYb5RJKTMJXQ-Bg@mail.gmail.com>
 <CAP8UFD3ivxTzrUxCARopyFBsarvxTSdTeQpdQahDDtsELjy1AA@mail.gmail.com> <CA+CkUQ-nu2K-7WTpm8mhr4gA2bateYAMp+qpxHk5=shnO2iFSQ@mail.gmail.com>
In-Reply-To: <CA+CkUQ-nu2K-7WTpm8mhr4gA2bateYAMp+qpxHk5=shnO2iFSQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Feb 2021 12:09:29 +0100
Message-ID: <CAP8UFD2E0uJxk7YmVr1V_c12YoD=Zk-6TrJnMCaEowBpv8uE0A@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Hariom verma <hariom18599@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 19, 2021 at 11:20 AM Hariom verma <hariom18599@gmail.com> wrote:

> I noticed some text is missing in the project description in
> SOC-2021-ideas page. I guess it's due to the angle brackets.
> I created a [PR](https://github.com/git/git.github.io/pull/478) for
> that. Please take a look.

Yeah, right, I just merged your PR. Thanks!
