Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01ABEC875E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbjIGWU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbjIGWUW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C231BC9
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso15935035e9.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125215; x=1694730015; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khwfBRi3Dsan8ZlxMTVmXTmzM2RY6h9G9wQX3EGM/So=;
        b=AGjxM5Ti4R0w2BnIGM8haEkYDhI/5myzcnq477aVSxcqiDV+Xc6gN22gsvI4qVmCwh
         GFfksiugAaIlCg+NrFsWBuwnVHzCSMfty4GKfnIe4Oq8vG+XUYro9szQoMMK0M2t/kwn
         UIKiA0T13IJh81fQWt02AIgZr7iT2v8aqEPbMI6k5AYFnL61TAsiskucVy3IhvsR+vV2
         GsgDuZk+cMNquLERNqBBtybz1Sw3CZ4pVPVYqpaRX5lsbHn4W9lL8Md9FIkKWnH2qKpH
         ozKoSd9K1xMr2feMtaPP0x54h/BonK0rPMSX7O9I419JnTRu7+/SWuZkyTw6sCny8TDu
         bNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125215; x=1694730015;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khwfBRi3Dsan8ZlxMTVmXTmzM2RY6h9G9wQX3EGM/So=;
        b=cd5k2FHRunPK0HI5POuMUl1Au6eXJ6TrUVRgb09DT3y9kzdyTdh4tu+t9quamTUYDO
         hk0Hia7w3qzsZI7cTf2QV8RigJVwxYEIovSnNZjnpU2l3/BuT2YuzD9qIoacZyaMz/FB
         ueuB7X6O2h9ZCdJV2OE1G+NREASAXMHKZZMtfirZgFRlKQjYcb7u9SppluUls4ayKXB9
         1TiUgcOp3sC7l/qnQ/B6gE4RHIFEShX1fx0yBtnTFK+Ik0u9hDDF5afpz9NTyhfqsVaB
         Fr1U7EuTM+yjdEPaGIFPtwF0IVCpnvx2arUuq4fr/jty/X3dyfv+GTbD0SaYp77JFo/F
         9USg==
X-Gm-Message-State: AOJu0YyXQwvK9y51DaZQ+JH7iMVpZuEY+Byqs2Qxw+CBf4fmgUCMS+Xo
        pbqa38dITHg/VyGND/i0ovB1VlJFMZw=
X-Google-Smtp-Source: AGHT+IGZn3gLFbgjsUF/W+2jire0U+ZOEub5pKoHC/+ld9Baz6It3IiQj85CKYH+muyZrgLp4wPUpQ==
X-Received: by 2002:a7b:c7cb:0:b0:3fb:a506:5656 with SMTP id z11-20020a7bc7cb000000b003fba5065656mr648309wmk.32.1694125215359;
        Thu, 07 Sep 2023 15:20:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b003fefcbe7fa8sm374424wmi.28.2023.09.07.15.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:14 -0700 (PDT)
Message-ID: <040766861e21afe5f686299560677e429be11844.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:20:01 +0000
Subject: [PATCH v3 05/13] trailer: trailer location is a place, not an action
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Fix the help text to say "placement" instead of "action" because the
values are placements, not actions.

While we're at it, tweak the documentation to say "placements" instead
of "values", similar to how the existing language for "--if-exists" uses
the word "action" to describe both the syntax (with the phrase
"--if-exists <action>") and the possible values (with the phrase
"possible actions").

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 builtin/interpret-trailers.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 72f5bdb652f..b5284c3d33f 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -117,7 +117,7 @@ OPTIONS
 	and applies to all '--trailer' options until the next occurrence of
 	'--where' or '--no-where'. Upon encountering '--no-where', clear the
 	effect of any previous use of '--where', such that the relevant configuration
-	variables are no longer overridden. Possible values are `after`,
+	variables are no longer overridden. Possible placements are `after`,
 	`before`, `end` or `start`.
 
 --if-exists <action>::
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index c5e83452654..cf4f703c4e2 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -97,7 +97,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
 
-		OPT_CALLBACK(0, "where", NULL, N_("action"),
+		OPT_CALLBACK(0, "where", NULL, N_("placement"),
 			     N_("where to place the new trailer"), option_parse_where),
 		OPT_CALLBACK(0, "if-exists", NULL, N_("action"),
 			     N_("action if trailer already exists"), option_parse_if_exists),
-- 
gitgitgadget

