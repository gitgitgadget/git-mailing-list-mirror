Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A18C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbjAJNQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjAJNPa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F5A574ED
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:28 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so9881037wms.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JosiX1xP/mchjg1cQDmwxKPcSqzEfpT1h8/Zc0H1rWg=;
        b=a3imvD8PRJBoMCOIRKVMKg8JqaPXSYajk57M+ek/gB9Z/T7dR13N2YU0PnzCgIgNXl
         uTGyV75P2S3wl8t1Z3ZtHHZLFQLk1Q6gm58UUtP7mkBTpIQpebUDAe0/IBbqmrtQKrvU
         mO5GFMstE78XJQ0APOI+dwUHR3ILfxWNgiHt/hcIykH7UCrbsjzql/QW3ngc6facK8lE
         MVRt6bnHgbbq1O+50KKxVOo8cTZJ+JA8Vs+FGNxlmXkJw9H1+KJPG9wIG75Ypg7j3gOV
         PYIcjIeggiGOrvcOey4QRhmYvTgFiQb9ihF1VnzNqIILuTSA3vNRshb19Z/XPZnzwaS4
         WV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JosiX1xP/mchjg1cQDmwxKPcSqzEfpT1h8/Zc0H1rWg=;
        b=ZAbYi7DLFLLqBfXlXEsDZ/eZNJ0QdF0rsFD81UrZ5fjKZRY8efTTPMQ5igjvW6+8gW
         WrKCnczTw6kCQT+ZVVMj7EcVqt3TDi2nu8HHFugzg3QDznAcN1IHC9oipsRhXgS7JWZL
         ayCf6mLtfqbMA/iPYHAe6jAIM0wohNSwj6Fm93q8Wi2zN4PxyQKVR25QRS5LoyTzOXAN
         2TLIbUsi3Jouz/9YmBCOCHxeQLkwrnr27JwK87yUM5OdQ7tKgVape6rSGdmTaC5AnEIn
         II6hstMWefgm4QqafXFj4DOVLCFAeqlhNJf3d9kgZICso5apO6zRdqNIHtJmcTYKJn1V
         OlTQ==
X-Gm-Message-State: AFqh2koe/mN2WLzy3tYlWqjwEgq9ly45rGp+9IiwzwG3ucwIhQJncXhW
        4ZEgrwzUrWtunsxfEmw3jBUA/XzV5Yc=
X-Google-Smtp-Source: AMrXdXu18TLaq05b4HGPjTcwemaAg3nWOsjWfLcAuZYhgZ3MxCNHzL1tUI612oSRvvPY5WvSuQ/kYw==
X-Received: by 2002:a7b:c8ca:0:b0:3cf:728e:c224 with SMTP id f10-20020a7bc8ca000000b003cf728ec224mr49854612wml.6.1673356526598;
        Tue, 10 Jan 2023 05:15:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003d9780466b0sm16574861wmq.31.2023.01.10.05.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:15:26 -0800 (PST)
Message-Id: <302b789a4869c2aa8a0de2f71a2725c6c567685f.1673356522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
        <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Jan 2023 13:15:20 +0000
Subject: [PATCH v2 4/5] revisions.txt: be explicit about commands writing
 'ORIG_HEAD'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

When mentioning 'ORIG_HEAD', be explicit about which command write that
pseudo-ref, namely 'git am', 'git merge', 'git rebase' and 'git reset'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/revisions.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 0d2e55d7819..9aa58052bc7 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -49,7 +49,8 @@ characters and to avoid word splitting.
 `FETCH_HEAD` records the branch which you fetched from a remote repository
 with your last `git fetch` invocation.
 `ORIG_HEAD` is created by commands that move your `HEAD` in a drastic
-way, to record the position of the `HEAD` before their operation, so that
+way (`git am`, `git merge`, `git rebase`, `git reset`),
+to record the position of the `HEAD` before their operation, so that
 you can easily change the tip of the branch back to the state before you ran
 them.
 `MERGE_HEAD` records the commit(s) which you are merging into your branch
-- 
gitgitgadget

