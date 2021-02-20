Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B196DC433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 14:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E39964EB3
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 14:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhBTN6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 08:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBTN6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 08:58:24 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB78C061574
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 05:57:43 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e9so4971875plh.3
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 05:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1xCZOIgk7/xuKxYy/2mtqmgAScir/dytWwPnfO2mJqg=;
        b=ikIA41kGFTDFD3/WFAlFks91F9Rq/FLhFSPqq0bJ1jXRVAmjKfDBMxwUDYhBFChtxX
         CElmT3XaCk5NG/51ENf1FneNmSrF8vPgBWvpuGcQLtM6KAhERV+HZDdwN8msr6fX5Tmv
         unkcwPU2YzzIBoqylJ0wdY94b4Xgr3WGFhy3LBsPSyJZbp0zJODDPOaishob7obm4leB
         gslYSL6+sjbxZZ3ROy03R7X8njLJR47bFcmkqKqSLvDVZSq8rEFDUuLqRwkQsmuJFLTH
         2tFBdsY/wSpciv6PeOCdO/gye9yo1RF40OcmhnVXyVH/YDr1DWDJJmF7dYOFeO4ktVHk
         ecPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1xCZOIgk7/xuKxYy/2mtqmgAScir/dytWwPnfO2mJqg=;
        b=kraOrh/PptotcZ+nJywqy/FWuGoXpr36l0xOQ7W6a/VGyzlmvGIfjVxwetEjjHixQ3
         zv0Hd/o8EEjjKBvgmzTberkHcU5evpwbJD+Fn+wruIe04m1FmvamVcIlp4OU03Br84Hq
         3xTkeOZ0f0JFqN994zOYP7J4BY0jf3FVYzX76J38PBVk6KinpKdJuC6QFdyQiIN6Food
         QJkMz8ONrp3APgRrgDZIK5Yv3uzChSIXdkrq1Gb6WMkpWqONtKcFeC920eg0NGbtJ0pB
         AdL9dLqLg4ROpm8bIlKXzp1E5IhFPkTQpqJGj8w/JOzrTpA6j5ThCsDDHFNCbpNYeG55
         9EFg==
X-Gm-Message-State: AOAM530xBrGSlyasG0e1STNYv5Vk/f/c+ViMnXqBtGI3Kh7eYnMBom9M
        95YkSB/Im22iaUOD5I6bAAg9P7R0HSX2HP7OnPLuG7xmpZXhBw==
X-Google-Smtp-Source: ABdhPJzb1FCtcY9uKYP3SXmqM5jVx70lo1FVMsTf2uEwOFhLKVCMJ6PO8go4LAeEOuEa0FJHg/2EDSlmzSmxoXeTr7c=
X-Received: by 2002:a17:902:6b45:b029:e0:7a3:a8c with SMTP id
 g5-20020a1709026b45b02900e007a30a8cmr6745234plt.1.1613829463075; Sat, 20 Feb
 2021 05:57:43 -0800 (PST)
MIME-Version: 1.0
From:   Divyansh Garg <divyansh.gargsg@gmail.com>
Date:   Sat, 20 Feb 2021 19:27:32 +0530
Message-ID: <CAB=huCZLwkBv-Fd4iUqbDwNuNfeFBfjPfKRzYUGShc727KJJzg@mail.gmail.com>
Subject: [GSOC] fatal error: curl/curl.h: No such file or directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I am trying to build the source code on my system (Ubuntu 20.04).
After cloning the repo, when I proceed with the command: make, I get
the following error.
I tried installing curl and searched the internet but couldn't get a fix.
Please advise, how can I solve this problem.

divyansh:~/gsoc/git$ make
make: curl-config: Command not found
    * new prefix flags
    CC attr.o
    CC config.o
    CC exec-cmd.o
    CC gettext.o
    AR libgit.a
    LINK git-daemon
    LINK git-http-backend
    LINK git-imap-send
    LINK git-sh-i18n--envsubst
    LINK git-shell
    CC http.o
In file included from http.c:2:
http.h:6:10: fatal error: curl/curl.h: No such file or directory
    6 | #include <curl/curl.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile:2422: http.o] Error 1



Divyansh Garg
