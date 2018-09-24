Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07201F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeIYDTj (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:19:39 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:34757 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYDTj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:19:39 -0400
Received: by mail-pf1-f177.google.com with SMTP id k19-v6so9660630pfi.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IC7q8eJ4t48uNedGBKRM4AzRdpMO77T2UGyKNw1x6m4=;
        b=F3WpHZrqu/7q5PF7GCI8nz1i4r7ohIPdX3Ai8sfUGlJe9iB6i2KeJE9VU00b8a+D0W
         w0Fvsx4gMD32/fbltkdYLNb+WolZGafEw3wszpVTS4rYiazxpxAl8elgF//vwTMpqJO7
         OqnOhDbVlKaB+n6kcnKT7Rgokio/Zi02SxiSy/lEYVg1v+XlMvMsX3sSWkU6cQ9d04OL
         k84MF1kku5QaRli22vlx0tzW1XcbzwLXMmh94QEOz/j+4oUWkazzvkBHPKDvxIsbhdXc
         Kgs4ON/GZMPyvmLSMm6YL0hn76Y44T2UOmQZEVSpjMdiAirV03IzsoAnza7ko5J6VrWJ
         p9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IC7q8eJ4t48uNedGBKRM4AzRdpMO77T2UGyKNw1x6m4=;
        b=ofZGO11wYjmLdhnL5WWHgM8aC3scz2CpcU20xkkf63lIFORWdg+R2tWiSiTz582LTb
         PBGvEwHVm6G2AGeJMe/7uEn085c7yPdO1pHqNfE9ipqzhhR1gVkvixoQScG17On6D83o
         3txQUpUZcuGJsJZFm5gldMfSLeVUejLfNDezTxM5P44U9ZrccAwezhdIUvVsdnVgBJZF
         2fP8M+y4XrbMGA1uIfz+rz/me5eRINyfPQzvlT79++3JHlxZ8sqLBsgpEpL1AoxqUTzy
         27Qs8L5pp8mbVJ30K1vznSxWX6FcWNMk/EPqtBQKPuXHtbnNSZ2K3kDeEOhBwxtXojXE
         Mu9w==
X-Gm-Message-State: ABuFfojZJe2lCPsnWdewF+d2jFd/11+GpNLxNVojfWoMWWbC9rnU2MeL
        dT3u86UmQYk0rL1a9HMnhq+ibv23
X-Google-Smtp-Source: ACcGV632M23iDdJzNQS9BJbD5r5SWZY+BvT8xOC2eG/wFROVVgz62Wq6UCLYopyLw7H5FW7xcG4J0g==
X-Received: by 2002:a62:1a16:: with SMTP id a22-v6mr493831pfa.237.1537823730163;
        Mon, 24 Sep 2018 14:15:30 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y128-v6sm319504pfb.56.2018.09.24.14.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:15:29 -0700 (PDT)
Date:   Mon, 24 Sep 2018 14:15:29 -0700 (PDT)
X-Google-Original-Date: Mon, 24 Sep 2018 21:15:26 GMT
Message-Id: <pull.41.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] read-cache: update index format default to v4
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peartben@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After discussing this with several people off-list, I thought I would open
the question up to the list:

Should we update the default index version to v4?

The .git/index file stores the list of every path tracked by Git in the
working directory, including merge information, staged paths, and
information about the file system contents (based on modified time). The
only major update in v4 is that the paths are prefix-compressed. This
compression works best in repos with a lot of paths, especially deep paths.
For this reason, we set the index to v4 in VFS for Git.

Among VFS for Git contributors, we were talking about how the v4 format is
not covered by the test suite by default. We are working to increase the
number of CI builds that set extra GIT_TEST_* variables that we need.
However, I thought it worth having a discussion of whether this is a good
thing to recommend for all users of Git.

Personally, I'm not an expert here, but I am happy to start the
conversation.

Thanks, -Stolee

Derrick Stolee (1):
  read-cache: update index format default to v4

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 53f9a3e157dbbc901a02ac2c73346d375e24978c
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-41%2Fderrickstolee%2Findex-v4-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-41/derrickstolee/index-v4-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/41
-- 
gitgitgadget
