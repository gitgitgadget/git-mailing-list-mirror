Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A428EC433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED3D6120A
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhKEV70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhKEV7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 17:59:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0610C061570
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 14:56:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d5so15897248wrc.1
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zax8OmvdfoHLqwvXAXnFDBiRPtXzNwixobyyQerpoIY=;
        b=IoV/OXYoGcG+31f40Q/US1FXOgcjbWLirtG4t66N4yM3nSf6sjpQqh40fljTCUjOLX
         MyXdQeZQXBHhrmuumkkCUySBr9WAqdOwG6q8plDrsnuEDfIEtSkTSXR2BYkXbyRTNrj2
         +T7Eq2V3sXLhBC1oSv0Q/7kr7Y1HESeO0EGgv2LX74j6qTNO9PqT6YGfMEC+YJ8/J2uR
         e2bVZTg9QwIcU5u/6NepdhwZaJ+ojyGaDu5Dfe8ms7qDPBqkoXa1gZdxsRFsGrhKxxgg
         D3rMaNfNsNxGlTv/Ru+Gy0QC2EtkSm9QD22chzgDKWnE2Q8pbtf/0NoMKel38bQYs84c
         Hp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zax8OmvdfoHLqwvXAXnFDBiRPtXzNwixobyyQerpoIY=;
        b=GZ7AMHn54ay6eNO8/2gQFbS1Tw00DbhcfXWzDgkOhV9wZIh4e6M7RkIl10taEGuB93
         3xx+Wbgp0xDkaSorSnEkptbPNs6r00jhaGFkg5KI3+IWbeqSXd+WWI/RlC1BTRwpHJPA
         kcjlhfhFoAB3fFsDTX3cp72vX9s8iIh3kWgRVhRYp85W0+t0p+z5YUZWQyLuoFgVOIhv
         3pbS+oXtlJg5It2mXOMkROozD6uzYHBS0BKNgT7DXb7POB2MD1cHN/REjv65qKTHxRXj
         CB/4PIbNQ+Y6mSs4LDaTnvSV8CvycY3bOb0EMKx89yV1mHJMYCfX53/xbJWCnZoXkr85
         AMbw==
X-Gm-Message-State: AOAM533LqvaHsx2EVUVvk9W10UFlK58xhWY/OPv2qicIaWrAdP85Hssv
        S4Rfr0Wzbbc7h0Q1TsUXMjdHUM1oNqo=
X-Google-Smtp-Source: ABdhPJxcOZxoC9RjdHB27ZBc/r0Rz8uthPAxJWuFIHn3OjGuZmUFpqfEPtgfExz07No1D/rhAgho7A==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr55917719wrw.170.1636149403257;
        Fri, 05 Nov 2021 14:56:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm8679976wrt.64.2021.11.05.14.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:56:42 -0700 (PDT)
Message-Id: <18d6c2819ade2e514a408e4173c6a5048e3f2cd1.1636149400.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1124.git.git.1636149400.gitgitgadget@gmail.com>
References: <pull.1124.git.git.1636149400.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Nov 2021 21:56:40 +0000
Subject: [PATCH 2/2] docs: update behavior of git-cat-file --buffer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

When an empty string is entered into stdin, git-cat-file --buffer will
flush stdout immediately. This commit updates the man page accordingly.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-cat-file.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 27b27e2b300..c98e8dc3669 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -104,7 +104,8 @@ OPTIONS
 	that a process can interactively read and write from
 	`cat-file`. With this option, the output uses normal stdio
 	buffering; this is much more efficient when invoking
-	`--batch-check` on a large number of objects.
+	`--batch-check` on a large number of objects. An empty string will
+	force a flush of stdout.
 
 --unordered::
 	When `--batch-all-objects` is in use, visit objects in an
-- 
gitgitgadget
