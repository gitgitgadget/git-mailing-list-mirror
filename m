Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF84C001B0
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 20:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGQU0k convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 17 Jul 2023 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGQU0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 16:26:39 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D889186
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 13:26:38 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6b9cf7e6ab2so1540890a34.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 13:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625597; x=1692217597;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhSR8hMV6CLTLR49XvbYovt25lwArCa6UjB58hJqIHM=;
        b=FBrsIUpY5TCAlWLUIMuRH0eSOeRDpTXypIEkHeuMWrX6WyZ22GrCRhjl3Rb+htXItz
         uPtDItTo22KWw1D2BMQE0zB36MsW+oU99hSyaIFZ8cXARXrZs5Gdx1/jpsvTSqEHgoKe
         koK7OZNtiqmA+GCIYZPXbi1hT7L1IRTw0Ei0HspZZ4HA0cAmu3ki2OpP2cIJ4be3G7DB
         RnHcUgROwzF3yD7lBj5hrkcYGZ5LTZJqMMwf3kjcyCXXa5syvflOfeKEawViOodM/m3H
         zSjUKUjYaE6YrLmWVaB2u40U/DrtAI5mA+F+COoJekztripTfhgK173q1doG7stnLgnG
         O4mA==
X-Gm-Message-State: ABy/qLa6MKU8+6yGF6apo79c3hebFLOUHrO07KgRBSWyIyG/2BP6rIlw
        C4yP4OfFsX+Nav2rOQsn0w+xXS+ksBNW4I7DDr/detVsSwENcF7hKFZMYg==
X-Google-Smtp-Source: APBJJlFex8I6tp5yv5aaXq+3jMPCjDZvtTdGSfU4lXhHcpUvLd77us6kJBLv7E8l6EeUjilgauMAObZy9Kc4kSEcUV4=
X-Received: by 2002:a05:6870:f58d:b0:1b7:8b42:f17 with SMTP id
 eh13-20020a056870f58d00b001b78b420f17mr378682oab.59.1689625597129; Mon, 17
 Jul 2023 13:26:37 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Adam_=22Sinus=22_Skawi=C5=84ski?= 
        <adam.skawinski@sinpi.net>
Date:   Mon, 17 Jul 2023 22:26:26 +0200
Message-ID: <CAGE71k3Ccm3hBrfNgXFqO9Zk0V9FkoskgD1ViJ6eSakxdBuqQQ@mail.gmail.com>
Subject: receive.denyCurrentBranch=updateInstead won't update the repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using Git to push-to-checkout a website.

The receive.denyCurrentBranch=updateInstead option (set on the server
repo), according to the docs, should allow the push and do a checkout
on the worktree if it's clean, or just refuse the push if the worktree
isn't clean. Instead, for me it allows the push, but doesn't update
the worktree - I have to `git checkout -f` on the remote shell after
each push, even though the worktree is clean.

Note: The `push-to-checkout` hook doesn't seem to run, either, even
though it's in the .git/hooks/push-to-checkout file, with +x rights as
needed. I made it output some lines and exit with code 1, so it should
abort after producing the output - and yet the pushes come through.
Other hooks, like `update`, work fine and can abort if they exit 1.

Setup:

My client is 2.31.0.windows.1 (TortoiseGit)
Server’s git is 2.39.1.
My remote is set as ssh://user@hostname.com/path.

Please advise what I can do to investigate further.

-- 
Adam "Sinus" Skawiński
