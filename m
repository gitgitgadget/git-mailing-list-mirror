Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB62C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57302075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6kIYv9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgAGKF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:05:56 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:52357 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgAGKFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 05:05:55 -0500
Received: by mail-wm1-f41.google.com with SMTP id p9so18255561wmc.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 02:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uJmUDKB1iDa3R4tEQVbKd8v21RX4L7cwW5ZcO+CLFrw=;
        b=A6kIYv9D8lhYAN2seDBvlZ0ZYH9mzQU2zMYwCv9yVcfEKka4eF0ne+3/EavUTPPiTR
         ey0mu6gRs5bPukJQ7b1AXVRX/Hfuy3VXpeV0WA3WDX8BcX2zcyzd1BSjwnIBird23+fs
         EPkmHvnF/fv+mQs7X0++cofgy2jXxG/H3RPnSLHhEi0ZECYyEc8Y3BbnX5x0PsmeXzG9
         EgOnecZmc3G64T88hdBH3QaLikyxw+3rY5/2xA/NrwuGzxkDyC8JQlmYZ0xDiSX9raB9
         /yKSMwxwo15ykXur2Ty792SWTfMGf4nM7mtBYU7hDHAPjtJgE8WdIf5Kt97YnolZu7HZ
         zYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uJmUDKB1iDa3R4tEQVbKd8v21RX4L7cwW5ZcO+CLFrw=;
        b=pEyBthxmAaUQjvqvW0gFUVBJGVZPIvkhHCQTtCYgISOehIaWMdSkiccL/C0o23fxhF
         n25U3KeebXoKvbQjAMP8bVKBSovZQATkaJldV8mW4vnjCi59rVI1TFhKKWNYM908YA2n
         haKLEBtG+P4d29uiVXOo7Iiv7mUEGzZat8PJVtF4U7V4s588dA0YBKyQQ47s2r/N5P0e
         BO06oJNTT5/7vsOa6ZrZdAYR0id7vy+ucRlxp9aLB+6vxkmTyoaIrdrCdA4gkRDghTx3
         J2jxYGcLflcrCG1pJc8Flol8pORE0yvG/L/Xztf73zdPcOOtA79ibIYv+KJTGa7+EJck
         Ghdw==
X-Gm-Message-State: APjAAAVn3vLNqWDPyU9yJPiRwz9EUVTL3VSNoyUsTr8ZaB2uOej+7Ogi
        eW9MccFtYOS+r8BJ80JkQnZbLNQV
X-Google-Smtp-Source: APXvYqyQx8CC7aWlbM7n1lsZhpCZG5BQSLX3EhhW//Slkm5RNHur7EjYmboMQuTvSOfZ2326AyG6Zw==
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr38726858wmb.160.1578391553874;
        Tue, 07 Jan 2020 02:05:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm25504744wmh.11.2020.01.07.02.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:05:53 -0800 (PST)
Message-Id: <pull.515.git.1578391553.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 10:05:52 +0000
Subject: [PATCH 0/1] [Outreachy] doc: fix a typo in gitcore-tutorial.txt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a typo.

Heba Waly (1):
  doc: fix a typo in gitcore-tutorial.txt

 Documentation/gitcore-tutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-515%2FHebaWaly%2Fgitcore_tutorial_typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-515/HebaWaly/gitcore_tutorial_typo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/515
-- 
gitgitgadget
