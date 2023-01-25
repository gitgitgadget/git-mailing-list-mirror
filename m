Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC38C61D9D
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjAYEEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYEED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A444858F
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t18so2959803wro.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwJKX1pubUfbYKbW0d6FbVwdVDuuAaPOALhhWeWyCOg=;
        b=SZBqRrPs1Mz5fkrLIdQeVk9QEmTJvCX1cOFVTy4dQLdIQ1VUf2F8mzTwnpWSL93ppS
         I9XbsufSb2PVu4sGmx/rz0at8HCRuiw91eWcWW0CgJ/2xIsdBxcd2dqCnzaM4z8kP8lI
         +ADDC/4gQuYHZ55m0/OVq6tgHHAUpTiO4naUhk1QaJ+RhUzjC895+hhh8fA1o27XykOk
         jPLxugVhupFbdP040VpQRKqPMzlIINu3htxr1dFuBT0IpFpw+D5tBLk7IhxcdUBVfDuc
         ioo9+by6qVjxyLbM9/8UZ/esKNWIOl/lIv55kzkQY7UuNisoLuG3Pvc7u3CdOurJNB9N
         cahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwJKX1pubUfbYKbW0d6FbVwdVDuuAaPOALhhWeWyCOg=;
        b=RuvouCYbWeMfhXuqO8xq8nl7rzUOMIFcfsB5ypPSh8s0Eru9CvXdXwVSGmQKVuW7+9
         BwWkRMIbpzJfTuGExKZ5Frf1FWS2718ZpF9Gh960GxstyJH87m1JF2Qe9d9wsTTkLJXu
         2a+EN7ndoUVaSAwz+DLezL3sfQcAJvgcK7dbV8mwePzu0sgLge1P8hKPvGGQn4IrI9nR
         NZBrcrz3Cl0ZDI4nvRIoTd+/VbolZKRuaPYf437Klmp4tlJe7KtNfxDSXiuY/+p5zV3Y
         xAUzQ4tfotlMEHFdD8gHqieDBXW/Yis9QWTLiy5eBfqTP8BhcJfCS9o0YzxNOKECecT0
         oDEw==
X-Gm-Message-State: AFqh2kq/N+RK4RIqHv64p379NIMIGipcFwc/xABaResF0CL+8DjpB0mD
        02OufKGLhgJ9LuE/KvOAoO6d0GuZH60=
X-Google-Smtp-Source: AMrXdXsT+p/su97gGyGTh0N86L33ZN4nuAcT+WXpyxUdOUUEYZUbpf/UZbscxatt6cuaDPFIxwQDtg==
X-Received: by 2002:a5d:660b:0:b0:25d:4dfb:790c with SMTP id n11-20020a5d660b000000b0025d4dfb790cmr26036075wru.13.1674619439745;
        Tue, 24 Jan 2023 20:03:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1-20020a5d5741000000b0029a06f11022sm3172712wrw.112.2023.01.24.20.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:03:59 -0800 (PST)
Message-Id: <9464bbbe9ba60927a3c36ac9685545447744819c.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:47 +0000
Subject: [PATCH v5 03/10] rebase: remove --allow-empty-message from
 incompatible opts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--allow-empty-message was turned into a no-op and even documented
as such; the flag is simply ignored.  Since the flag is ignored, it
shouldn't be documented as being incompatible with other flags.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6490bc96a15..7d01d1412d1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -647,7 +647,6 @@ are incompatible with the following options:
  * --merge
  * --strategy
  * --strategy-option
- * --allow-empty-message
  * --[no-]autosquash
  * --rebase-merges
  * --interactive
-- 
gitgitgadget

