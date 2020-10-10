Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F88C43457
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA1D2075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shF4/gVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390141AbgJJW4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731348AbgJJTxq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:53:46 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA21C0613B7
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 04:49:05 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id q21so11409768ota.8
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1hSW7AiyQ2JDahKRBI2w5QkipknnBVmpWA3+eq6FVHI=;
        b=shF4/gVAwSvFB6c7YXRPoTo5peLz8YB5jucQcu9K0TA5ZzVAOgP8u3+umRTjfSIdlN
         LgqKb3YWk+9Pn1tsQduvlogeJR+zwAUVHZLYnnC8aaY0xy03VA+X3FOt/Zf8URHO+Z97
         GicsMhCkfGAuxbWwVOZhoZGX+xhXnITC3f7AOvaN0HtHOPlFP5WLw/ybDS30Dk7zsv9j
         tvUL1O5YBPncmtfWFHZnxjedR9jYIE6w6rXWea6KQLe/4lgvDj9+QOvUAVJiyFmebfhf
         MyP7Kdy7VF17GPLOD8vkT+ctUYhN73GpAFcdY5Jg/Rs8XbRrqlEN5AXcPXV0vedNjV05
         k+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1hSW7AiyQ2JDahKRBI2w5QkipknnBVmpWA3+eq6FVHI=;
        b=ZoNDhtM3wn2zG/1G0dN0PfDIF0l2vWiStXEukBBFTPiwa13LkXIhBq7NwlZ/ruZLv3
         WUOwG+7a+ncNK2Mu/4AY7U0uaShowZj8Wy/ZOrJborNfRMmPLVIOiRwibKDjYYCG8Eni
         Q7xBu9rWSEatQ9IxEKeshhpCVCPS/6cbjbkJfiWfrzxF4frLX6qokqEdoxUPtJofm02D
         4BaWdBPms9V+lyMq+Chqk/p4DVZiBC7MvWxVmiRYyunaPsCFDHlpcHJVZ+8lHNr5Skh7
         ndt5bz4QQ4fc2vpWIC1oau8CL328NKb6H0iVxVVc0ovjhoz4yoauCd3mhZ0z4CJRI0MQ
         dIKg==
X-Gm-Message-State: AOAM5323PR+enOH1nUkvcdepeFjg62Vvthhni6sPytrwsO0HZJaiyFTj
        JAwTOot9X5bTmzWW5eSXhXg2RU5bcWetZWC4SolLEgSzWOefvA==
X-Google-Smtp-Source: ABdhPJz61419DokKy6iZyj8nHo59Q2/rHJ3MtE/5qd3Rcfn1GE8/9h17TrJaiZjPfOdeHMNAwaij4g3HvrIXNXQx4FU=
X-Received: by 2002:a9d:22a3:: with SMTP id y32mr7754462ota.210.1602330544100;
 Sat, 10 Oct 2020 04:49:04 -0700 (PDT)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 10 Oct 2020 17:18:53 +0530
Message-ID: <CAPSFM5eK1RFTbdTbF8dHMzcRh1SnSfzqh_5re22qS=KFoVRNJg@mail.gmail.com>
Subject: [Outreachy] Introduction
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone !

I am Charvi Mendiratta, one of the outreachy applicant. I would like
to work on the project "Improve droping and rewording commits in Git
interactive rebase".

Till now I have installed and built the project and going through the
guidelines of patch submission and project details .

Also, getting on micro projects
https://git.github.io/Outreachy-21-Microprojects/
Firstly to get familiar and hands on with the patch based submission I
am looking to start with one of the micro projects that is "Modernize
a test script".
These are test scripts  t7001,t7101,t7102 ,t7201 that require the same
changes of styling . I would like to once confirm if anyone else is
not working on the same ?

Looking for more guidance to contribute in this project .

Thanks and regards,
Charvi
