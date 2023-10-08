Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16383E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbjJHGrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344561AbjJHGqo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:46:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCAB116
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4065f29e933so34266565e9.1
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747547; x=1697352347; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLNsmeUzW4nNMYOFGNn1oHjaUTq6w7ZXTG+46QuVghk=;
        b=MObTnyvW6ei5Izx7Wl7CtjramKq/HhZ81z/RfI5UJclVep3EZ60F31uLx1pBbuJLaF
         O0k4LmAow02Uv94IuCioo+1+BBI1TJW2NFgFSKfSAs1d/DRUKSklqUjQynaVttYbcBQZ
         x1G72Ajk5yhDq233bgC+FsdRXKtzZjSxftQB6gq8OsNXyGhqSl+ZWjw8y5ijICKCHO8h
         Oa35Vc6UZuEyDhHkUUu6v6RhF61mpwhLzP/RV4WMwq54Oh6ZtgxCRLFjEFuAxMlHLO4U
         ABct/5EUkpP/bhPFMZYFjRbheI5dBv/go2FDWsSET/wtLkzuP1BFtwDIHaDb8aHCDVGJ
         SRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747547; x=1697352347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLNsmeUzW4nNMYOFGNn1oHjaUTq6w7ZXTG+46QuVghk=;
        b=p+BqbGs4hDK/SX58XEn8lNLK+Y6CL3Z0YnqktbjPBGc1lTQLWv35XtOS7kTrcuVmSt
         fRfs/VJ5ILrgDKXkeM08ha08CburO8Jzx+LRYT2/kqTVctdCL7/5d7uPXdiGzvZ69fr5
         XyLmur5otlPpvKg3h+UIYr4mQjqD8Z4QJXpMtOGh0piM/0skHsND4B9xPprG7ShWXK41
         G1dkLdf21I+4SJqpqK/T2QagktX0K8i2Bgv+M6bNrwooJOVpXsLe5yUothAowuCYJuk5
         kfWEyvVdWBem2M6TWSiu+CTHfKu+qCyOcc1aTXuqJ3biS3pQ/GgwvUE4++vmAfDM/JIZ
         0ihA==
X-Gm-Message-State: AOJu0Yy1FIlHzvTBTUQ5XNNrSn47xR8+JFN/RjjqwPd/0NANiyQzdshd
        tH+HEyoxYaSeXWw/TaZDf62drLCjN40=
X-Google-Smtp-Source: AGHT+IEg/aqSnz5vuS2ky9E/tfYIt4zIkthG9SX7l6eK+0/4fm6Gwa1AJOUK2CvuDEvjCsgj9kNTUA==
X-Received: by 2002:a7b:c5c9:0:b0:405:40ab:7693 with SMTP id n9-20020a7bc5c9000000b0040540ab7693mr10224417wmk.31.1696747547272;
        Sat, 07 Oct 2023 23:45:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003fe61c33df5sm10066235wmi.3.2023.10.07.23.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:46 -0700 (PDT)
Message-ID: <d0192cc5a3dbe120437867666febfa37c908b7b0.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:27 +0000
Subject: [PATCH 25/25] documentation: add missing parenthesis
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-remote-fd.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 94700b89be9..1dd2648a790 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -19,7 +19,7 @@ If only <infd> is given, it is assumed to be a bidirectional socket connected
 to a remote Git server (git-upload-pack, git-receive-pack, or
 git-upload-archive). If both <infd> and <outfd> are given, they are assumed
 to be pipes connected to a remote Git server (<infd> being the inbound pipe
-and <outfd> being the outbound pipe.
+and <outfd> being the outbound pipe).
 
 It is assumed that any handshaking procedures have already been completed
 (such as sending service request for git://) before this helper is started.
-- 
gitgitgadget
