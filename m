Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D17E95A8E
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344505AbjJHGpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344481AbjJHGph (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D37D8
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4065f29e933so34265555e9.1
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747532; x=1697352332; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhZ9V0ojpHYmoSq8GtMKo4qCvtCyx4U8KZj5Tk1DOc0=;
        b=O4/LhSLf45LQEHt45Z9uOuOQHZha+giqrxPi3bvU4XEoNUAoqN+wymi7wdh3dbroRX
         8NLsuKPD4KqecEdN015L/pB7bRQ0BfiUzfYKTEmA+spZ1FhHG+BpnXozh2nL3o7ZcHWa
         IqORI/qxncNmnhGsN/izc3bLAN2NkMHm4mvWNICYwgSFcT5YrBuDJgOTBFrv6yUgfbsg
         uLQut7PP+uRuqP/tceHgRMWyTf5QFT+qa2V4yheCkNE00AgweuIvUuiDCxftC2stzhUZ
         bR5pvS4MTVViOooFIojeNAy+ODt/eYEqQSljCN1mU0i6LO/9KX3TqM6f1Mkdy+dvmMr6
         wqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747532; x=1697352332;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhZ9V0ojpHYmoSq8GtMKo4qCvtCyx4U8KZj5Tk1DOc0=;
        b=uP+3QFYNhVc6vOn0VjbU23f4Zex54m6Syw2VEVRgcmrtYi2PnVv/sX6sz6JWFZ/fr5
         c+8lTd51ShUiU5XDyxNrqbKwHB0aJ5zH8pQ6I9JX7vOH1TCDGvqhh+RlwR9VGHf0UyDo
         ne0kj9zLDUE/JEwEGqnZtcdHy3Gu368isaUUxQnTiUoId9vko/MXNqs7vZ1wscddIQaZ
         zfsGdHe61htNu/wEdUL+yIlHW6X3gJMRva0ykK2tSO4dFrtnAYArJV3iBq2v/UQrVeIG
         Ocn7WywCxYeY59jsEfCoZNqIL2lhZG8OZuCthntGyxlGno8kdOUTIB4gzWSyNYPK2jU1
         InrA==
X-Gm-Message-State: AOJu0YwWzE6RoKpkJvMrXaj72hhQfKvN3FgwB35wjbmyleWtFoNc25vH
        kIyWJrKF5vz1HbkXX9dawwg2gqQcIuk=
X-Google-Smtp-Source: AGHT+IHRTGyvXKHq+uedwdD0gvrlCB5IqTz7R0znlivGZVGF4FKsmMyeK4RHtKl9ziWcR/GIdRSNBg==
X-Received: by 2002:a7b:c3d2:0:b0:405:514d:eb13 with SMTP id t18-20020a7bc3d2000000b00405514deb13mr11079965wmj.24.1696747532199;
        Sat, 07 Oct 2023 23:45:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b004064cd71aa8sm7765936wmj.34.2023.10.07.23.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:32 -0700 (PDT)
Message-ID: <4ab68e372343721c4b68fb33b64ef44c56d1447a.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:04 +0000
Subject: [PATCH 02/25] documentation: fix small error
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
 Documentation/config/fsck.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.txt
index fec3eefb5b8..9b167575530 100644
--- a/Documentation/config/fsck.txt
+++ b/Documentation/config/fsck.txt
@@ -11,7 +11,7 @@ to clone or fetch it set `fetch.fsck.<msg-id>`.
 +
 The rest of the documentation discusses `fsck.*` for brevity, but the
 same applies for the corresponding `receive.fsck.*` and
-`fetch.<msg-id>.*`. variables.
+`fetch.fsck.*`. variables.
 +
 Unlike variables like `color.ui` and `core.editor` the
 `receive.fsck.<msg-id>` and `fetch.fsck.<msg-id>` variables will not
-- 
gitgitgadget

