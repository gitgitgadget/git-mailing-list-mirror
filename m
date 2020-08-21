Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0FDC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677BF2063A
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 15:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0JmuEWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHUPkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgHUPky (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 11:40:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BD2C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 08:40:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o23so2826424ejr.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=40//1uRhY8Ih/xYTje3yGd1eA2Nnm1MJPVcncfHYFs4=;
        b=J0JmuEWWfSQDN67BdOGADTpbxS7Y78tiQS0hqKFJ33WvJu1YCvCPAnIqws3r4jZVBL
         2JcM9zj1QtrwJyGrh4sRjxTKu4WD8Gxd5l7nkVesgQXWe0u6IDa7MiCfNIexXP87ctyg
         Jz59vmrvQ3eK7G02Coir33RNuADLNtgIaMpEuzT6KPSRZwUjZN/m/42ZfW3k026Kjyb/
         bBuAtYz9utVrvjjCr43b2RZQHlShmheBIwkALRL7LUukb35LH3X93KbSgsVKqGTb7eUQ
         dHI5OqlsHyGa9dnbEhuxfolQu45qnJgMgi2h3Jhrb/EQ1ukYJawm1+/dIK8PVuyGSDQJ
         9jqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=40//1uRhY8Ih/xYTje3yGd1eA2Nnm1MJPVcncfHYFs4=;
        b=Yrv3Nbk9BYxS2UcT36HJj16Hr+3NRMMNIgw23+kUJDDlo7VXNOYywZGWIADEHTYUFE
         JyRyq4Ai1hyO7EnLh76sR5d6qlQI3rWbh2KqUA0aVf+NYBU4I3GS0sXkKiugU57ReuFa
         7JGBqRwPTJ7mbyOTE4ztFVb9ggAvhkk8XJ7ekYWP54lKicuHZmXcZFrpTH23K31JsquU
         Ix1L7bSZF0dVyeSL8iy/4ZspQHS+iOqm8ATjcPc0wK76cNRgS6yG8qKc/HrS/BQyplN9
         LJJO2ZX2VefVj5z8BoNalUq+JAXxR+c8TCKtY+5QhVcyHeWnk5kywNItS7OuxCQQh1wi
         +ruw==
X-Gm-Message-State: AOAM530BlxAJbuCoCrBx3IXCttdI9f/eNZQuVo6epO1uZSupjhbEawWU
        oWB9VTyphfvQ7UGbmZnwklCTUswZlKJd0hg6g5HRhV0eja0=
X-Google-Smtp-Source: ABdhPJw7FIvysJJa1HU6ZrB8jdf1BPhxIG50Ax60DVjOSR2uCPGkQIHHdayf66HwxFHCOYkR9cvD3Go2KlIeeJaG4ns=
X-Received: by 2002:a17:907:2078:: with SMTP id qp24mr3450488ejb.286.1598024449961;
 Fri, 21 Aug 2020 08:40:49 -0700 (PDT)
MIME-Version: 1.0
From:   Yohan de Oliveira <yohan.deoliveira@gmail.com>
Date:   Fri, 21 Aug 2020 17:40:37 +0200
Message-ID: <CADZrCYDayJ+kN08BQZ6DZXRc5hpZDr9mVFOWQPCawqfg_8Xzog@mail.gmail.com>
Subject: credentialHelperSelector keep poping in 2.28 using windows identity story
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have some trouble when migrating from 2.27 to 2.28. here is my bugreport :

What did you do before the bug happened? (Steps to reproduce your issue)
I migrated from 2.27.0 to 2.28.0

What did you expect to happen? (Expected behavior)
I connect to a https bitbucket server (ssl is blocked). For This, I
stock my login/token in the windows identity store. Here, I have my
server address as :
https://bitbucket.server
login: User
password: token
So I use credential.helper manager. To trust the certificate, I need
to set the http.sslBackend = schannel, or I face the error "SSL
certificate problem: unable to get local issuer certificate".
When I do a "git pull" I'm supposed to have a line :
$ git pull
Already up to date.

In the windows identity store a new entry is created with server address :
https://User@bitbucket.server
login:User
passwod: ?? (maybe my token)

What happened instead? (Actual behavior)
Instead, I have a strange behaviour where the
"credentialHelperSelector" keep poping 2 times with the line :
$ git pull
error: key does not contain a section: -
error: key does not contain a section: -
Already up to date.

Everytime I do a git pull or anything that needs to ask the server, I
have these 2 popups again and again and the error.


What's different between what you expected and what actually happened?
Normally, I used to set the credentialHelperSelector to manager once
for all and never ask again for it. I did this in version 2.20 a long
time ago and did not have this popup for a long time since now.
I don't see the error key does not contain a section: -

Anything else you want to add:
Yes, by removing the new created entry in the windows identity store
(https://User@bitbucket.server), there is still the 2 popups but no
more error 'key does not contain a section: -'

For the same .gitconfig file, it doesn't give the same result between
version 2.27 and 2.28.
Returning back to 2.27, no more popups, everything works fine.

Here is a part of my .gitconfig
[color]
    ui = auto

[core]
    autocrlf = input
    eol = lf
    longpaths = true

[http]
    sslBackend = schannel
    postBuffer = 4096000

[credential]
    helper = manager


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.
[System Info]
git version:
git version 2.28.0.windows.1
cpu: x86_64
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
compiler info: gnuc: 10.2
libc info: no libc information available
[Enabled Hooks]

Best regards,

Yohan de Oliveira
