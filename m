Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F23F1F462
	for <e@80x24.org>; Fri, 24 May 2019 17:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbfEXR1O (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 13:27:14 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:44629 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEXR1O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 13:27:14 -0400
Received: by mail-io1-f50.google.com with SMTP id f22so8347850iol.11
        for <git@vger.kernel.org>; Fri, 24 May 2019 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iYPWpWS9Enkdo/GiBWlJnFn1z5xG8JUF5ULojkvi9rA=;
        b=juTd0QBw9h7/dzB+GJFh+afMyW0wfaNDgic3F+4Z8Ec0zyXob53r5SKnq8Of1Fl6ZR
         oTWFt0lhWrmeHHKibcyH1KlcCRPzEtt+MchriZfnCh73NBKg1Lr4E1qZPo7N9a/xG8hs
         1l1AlPkOCgnI78ecYZy7Khgt/LToMT+9fiEBTRPqf6YQZc6wMy2SnbswNTiXe4SrMpCS
         Sxri9X2VU3+dQe0aqwoJ+6ynKbCZxA0qyd+U9W4R4MN9TbwLlJnr3RNMSlvOyqu54lg3
         HbMM7aBnZLjm8Mlpaj8NKctnFJJ0rbNMTbs8KxbBPpOwtwXYN1PQ9C6pY5OCkecBy7mL
         x7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iYPWpWS9Enkdo/GiBWlJnFn1z5xG8JUF5ULojkvi9rA=;
        b=o54uvYXuebeR/IHzpoW4tz/4Fm8++SsA/I6f2kApCirUvgxorqXTc4mtSJSHsSr0f4
         EHpV/hXFE/BhasmwopFSTVy4x8g3yoJdcMtswOgM+/pZz/hjglhxzwgN2kc7CcMliAKs
         LIh820G0sSYs7hBSlW/RwIFKukeYD++Skfblam4AW4lnA/yFSDQzYwrJRqB64o0d8bnC
         vz2zsVUePoMMycqlmxpFQmkcTXBcYpn7ns7owU/5h5d7CF3+a0YKejWa+wNHcZM3V2lZ
         JV2MVvNAM3CiFqrDSHA1bbAZA8yrcOqNEj+lGNhv1kl8CpQKNIXaV7pNE60xdtwbPOzl
         AH3Q==
X-Gm-Message-State: APjAAAWYBEhcerk0zpYS26/eQkPEBx01KC33YIRzBy3cE7yrYFDF6oY3
        QiQv5G4zHaXiiZ6lkC/2uNfieUI94F/s9APRwSdGawL7
X-Google-Smtp-Source: APXvYqzCy+gBW4iNHjp3FwScgyVP92CpgSHESUrZJHNTsxsdI819ihJpAUvK2I8cLWgAahwL858oIN8IbGj++cqHPkE=
X-Received: by 2002:a5d:84ce:: with SMTP id z14mr6921180ior.107.1558718833377;
 Fri, 24 May 2019 10:27:13 -0700 (PDT)
MIME-Version: 1.0
From:   Brendan Boerner <bboerner.biz@gmail.com>
Date:   Fri, 24 May 2019 12:27:02 -0500
Message-ID: <CAKkfZL2p8yFr3ecsQ63HzeZ+u-Jukf7YcYHk_8iBaKcA4WbEfg@mail.gmail.com>
Subject: 'git stash list' => Segmentation fault
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ubuntu 14.04

I was using some prior v2.x using linuxbrew, everything was fine, took
an update, this started happening.

I verified also happens using the 2.21.0 from the Ubuntu 14.04 PPA
(this reproduction was using that build, not linuxbrew build).

bboerner@myhost:~/funproject/Src/bash$ git --version
git version 2.21.0

bboerner@myhost:~/funproject/Src/bash$ git stash list
Segmentation fault (core dumped)
Segmentation fault (core dumped)
Segmentation fault (core dumped)
stash@{0}: On devel: NYFL optimization
stash@{1}: On GL285: gl285

Regards,
Brendan
