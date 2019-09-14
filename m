Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1311F463
	for <e@80x24.org>; Sat, 14 Sep 2019 16:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfINQHN (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 12:07:13 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:45149 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfINQHM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 12:07:12 -0400
Received: by mail-vs1-f47.google.com with SMTP id s3so20605895vsi.12
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmidt-cisternas-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=+b7kgTxaar3EPDzljCi3MNizv4V6jyzAlfogiAvqsDg=;
        b=FDrLSx0D859BgBmINS/6rtK1EObMbBUiy2jr36Hrf/A6Tf7f+H5u2AYG2fvPqfJ1sh
         QeryMWWll20Oa9FcBy1qnyEO1PTHrZV4gElC1vNfEX6zb++jEAoSD0VLzMypf0OsWTeb
         Bk/iqtLMuFrF75MllCpAgmktwQXa6ZNby0yD4+afk1WTScMh6ZgzN3f7HlS1i8qFruQt
         AAvruCZ1TvGFDy+89QflRtXwb/8gdZOgfbw1QW4QMatv1wYveSEbKWjGIz8N80hSYhuH
         s4JUpa+ArG4ZoRwEbd0jLs9V0Ebgo43veSJ+bFd8mVdaUWhjHeLL5ayM199+tEI8GKwK
         SMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+b7kgTxaar3EPDzljCi3MNizv4V6jyzAlfogiAvqsDg=;
        b=R168vwImO9MvV8ZR1fllWdkdp5WwOC5eNkqChcXXVtweUgVx1gz6SWGYZESavQCq9M
         N3XWuJf5b4dPLPR+DDIyayYNudLLAv11zrGzB2zcKFgxhlVByDScHy6zAEmXoZNvnVZr
         1DwIbXI1oAte8bl4SMuoRMmE1U3MfXlPgCuAvlClL5EBrJL1DXfgE+0QkKGZOw2eDVE5
         uWMKscZk3/soxJoCFgDlY1gDsXAujVn09UcGNTf//4v460BrDgjkAqmKERSGK2fO10XV
         FSaJnFpqwIm5R10xM7NJG0v8UCXLw5CvFtxHP2L1+9ljgimIoJLbl3UMaTPzK1ivt/jH
         ozXA==
X-Gm-Message-State: APjAAAU+45edzS/oR2inRp0EVjv0bG5N5/ri437x+oHZf3koH5azL90p
        Fw8SJI99zTEqvRJjFNlla3IDT+oIQ8vdGqZfX49R457QXvE=
X-Google-Smtp-Source: APXvYqyMT1RP/1MZLcfiXn9SSHSr+/VMnqLfoQYXLeAJymLSLatot8whvDe0NGAofJ3ifweWUQX+8Sf9DJKaX0/mxig=
X-Received: by 2002:a67:fc42:: with SMTP id p2mr84602vsq.34.1568477230090;
 Sat, 14 Sep 2019 09:07:10 -0700 (PDT)
MIME-Version: 1.0
From:   Robert Schmidt-Cisternas <robert@schmidt-cisternas.net>
Date:   Sat, 14 Sep 2019 18:07:00 +0200
Message-ID: <CAEq5TVWLxpc2a4fCch=DZfOgDWjKiu6gv0cfVHC3Wdy9581aSg@mail.gmail.com>
Subject: GIT_OBJECT_DIRECTORY ignored when cloning submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In the pursuit of optimizing meta-repo workflows, I wanted to use
GIT_OBJECT_DIRECTORY to specify a single objects directory used by all
repos and submodules on a workstation.

The idea being that many metarepos will contain similar sets of
submodules, and objects can be reused, thus potentially saving massive
amounts of disk space and network traffic.

However, when cloning a repo with submodules, the variable is cleared
when the submodules are cloned recursively.

Is this a bug, or intentional?

Thanks,
Robert Schmidt
