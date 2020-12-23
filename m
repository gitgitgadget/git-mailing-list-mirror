Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA6BC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D02223E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLWXJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 18:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgLWXJu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 18:09:50 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEA0C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 15:09:10 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id c7so865784qke.1
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 15:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hKxPrQNnDCDAtXfHpa4dwlblCBp7Nw5tDOPFdxeDXkY=;
        b=sJ39uVMxolztcQQjGhupD9LNG2HNFZu+3rb9t6O3uUIs62yzoFyDUeZng/ewdBrcWo
         1+35iZBrqHCSgTWLWyD1h5Z7MSm0z0pTH81xzCqEjVGljUUaUB04eJTAPuRnEQbwmbkT
         NOc/Z85l+BgP45NST81imjFN2Bb8M7m25uNbuQMfBn4o0RLcrc3yUJZtCIFrlShnwPkx
         xVINXm8FXHo10geGHMs222ZRHCWJ3kEpTAdh9cYkDwZSr08OubVdShdyqa9puPAA5NOt
         dgRujqNM9TOkriOS1DckUJIaWadCGU7cyt7aCDsVzgi9lWu07/z4YfoWTAMg6w3Z89xI
         WjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hKxPrQNnDCDAtXfHpa4dwlblCBp7Nw5tDOPFdxeDXkY=;
        b=XK2ie5TfDfkugqSADByODI2ljouU0zIHvHi3dlF5Bs5hR+BepuxOgQYRTY2JcV8ZZt
         IEaO/BeM9cC5B0uoJrgYW3CW/dk8jKmlXb71K2OjRL7PVPhjSKB3T74Unp2L1aWpgSdC
         JiP1ehpydAVpy3oCfcnMBZDkwlbR+z+2btLkzRfEimNdU8Cpks2WmT3STLPPjAEMWQa0
         9LnGITcMunRpdioK+cp1tfIbdMCsO8ABsezdFLDBwKmP7uATAjG2yQ5Z0coH2qzH7wmi
         OTnQDAV9cVjAwqW07ST0YRTSw8tJ07AA51Qm0wdKLP5w8HzNlCtLNQGjFdLxBuM2XuAd
         OBGg==
X-Gm-Message-State: AOAM533bCPzgxHuFAMxQSuhUhwFjZi7W6etev8ZSL9O44BCGOSAOfPm7
        8NCe2DgGcwj4Zj/72dw0aYwlOlENUqafFrdl4CjuY1QD
X-Google-Smtp-Source: ABdhPJx2LvcwfsJAiaAVRFoJ7PXmTq4COz+NNnlUvYU/r94lc8+RKkvk7ljnOiRCPLn1d19bj3PXfcK3ZXlngjeNFqM=
X-Received: by 2002:a37:4fc4:: with SMTP id d187mr29587653qkb.200.1608764949410;
 Wed, 23 Dec 2020 15:09:09 -0800 (PST)
MIME-Version: 1.0
References: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com>
In-Reply-To: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com>
From:   Mike McLean <stixmclean@googlemail.com>
Date:   Wed, 23 Dec 2020 23:08:58 +0000
Message-ID: <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com>
Subject: Git Feature Request (Fixdown in interactive rebase)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I initially raised this as a FR with my git UI of choice, and was told
that it was actually something that git itself would need to do ...
and that the standard way to raise Feature Requests was to email this
list.

Apologies if that's not actually what I should be doing - please let
me know if this is not an intended use.

=-=-=-=-=-=-=-=

During an interactive rebase, the text file defining the operations
has a command option for "fixup".
This will squash the target commit into the previous commit (listed
above it in the file), and automatically use the commit message of the
previous commit (thus bypassing the "choose the commit message"
dialog/file).

Can we have a similar convenience-command that squashes, and retains
the second commit's message? Purpose is the same as the fixup command
- saving a bit of time and unnecessary typing during a common
operation.

Am happy to suggest names and/or shorthand keys for it, if the idea is
acceptable.

Yours,
Brondahl
