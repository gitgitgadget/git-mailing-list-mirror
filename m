Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BA0C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 23:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJJXMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJJXLf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 19:11:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C280B4362A
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 16:10:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g28so11961173pfk.8
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=phusion.nl; s=google;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x6PSgl9SaLsxNMd9rvRQBz9HLflN16Jvdf7RjunVRQ8=;
        b=hK4bIG8o3v6Rl/fzF5dwFov294Qi/iD8962+nzGbLQ9YokEfSncTDWpwYNLdDoNQtz
         Y28hCB1qRA/OUwakpBgellsYkqsJH6pzZm2d7De0PLE/C2azHIKihaz+lIAxvjsbaNpk
         yxUp/EXpeNir5R6vPIt1UeCinc+gkyiNju0Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6PSgl9SaLsxNMd9rvRQBz9HLflN16Jvdf7RjunVRQ8=;
        b=hKpMQHFSLkSqSecqZFMUVIFTC4U5RZPtd4sdQ36Rs8qvgaaGcGa6751TfFSxn8rNJx
         E4OBie9XuAaNKtAmNqzhHScT5E4zfgQkj1uon9J81LZeNvFK+EQsJcKSvTO5PzwImUy+
         +sWX2ZyCoqYdBDBBOXs39pnZH8ak83euc2M1PhyGkOkTS6eqWAWjc1SVA8T/eWRcMj89
         AWrdBGKg8CbfCfUOGyvr4FL1MLdA4gxszxuVRn1CjprPVelOwWUMa0EkpOZt1D2pydrf
         T6QGDjeD7jZ4jyv7DDziSP2+nZ2bAXsLAYOAp12eRhLrxKf5LJ+wS1kXR2EOoVCLVd45
         Gtfg==
X-Gm-Message-State: ACrzQf2QghHt3jgrW6qEdj0St15vta1OxjpYi2UmCQMkfrQuIpEhb/Gd
        jMc+Pp7/7cXPb5ueZwGWZK9JCeQwQeZpTQ==
X-Google-Smtp-Source: AMsMyM4i5WmusKBZ+0ZeBGzI8I9NrCYoQ2ps1npvHqcc+5uKFGjXo97HAR4EY63bwi7A1jzYGrT/Pw==
X-Received: by 2002:a62:5252:0:b0:562:eef6:402f with SMTP id g79-20020a625252000000b00562eef6402fmr15072966pfb.79.1665443380157;
        Mon, 10 Oct 2022 16:09:40 -0700 (PDT)
Received: from smtpclient.apple (node-1w7jra24832z1e321nmelzhxs.ipv6.telus.net. [2001:56a:f4e2:cf01:dc91:df7b:1244:9290])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b00176dd41320dsm7206587plh.119.2022.10.10.16.09.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Oct 2022 16:09:39 -0700 (PDT)
From:   Camden Narzt <camden@phusion.nl>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Git bug report
Message-Id: <7E47933A-00E7-4FD0-9A4E-4AE4EC0D34C9@phusion.nl>
Date:   Mon, 10 Oct 2022 17:09:38 -0600
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

Enabled core.fsmonitor in ~/.gitconfig

What did you expect to happen? (Expected behavior)

Faster git status, or at the very least not slower.

What happened instead? (Actual behavior)

Significantly slower git status.

What's different between what you expected and what actually happened?

With the fsmonitor git status takes like 2-8s when normally it's under =
1s, I expected it to be faster than normal.

Anything else you want to add:

I've tried apple's git (used to generate this report) and the one from =
homebrew (2.38.0). The repo doesn=E2=80=99t seem to matter much, some =
are a bit faster than others, but they=E2=80=99re all really slow.

I tried to track down the slowness using trace2.perfTarget and from that =
it seemed to spend a lot of time doing fsync.




[System Info]
git version:
git version 2.37.0 (Apple Git-136)
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Aug 22 20:17:10 =
PDT 2022; root:xnu-8020.140.49~2/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.201)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


[Enabled Hooks]=
