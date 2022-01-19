Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01961C433FE
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 09:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353155AbiASJpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 04:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353145AbiASJpB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 04:45:01 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA70C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 01:45:01 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id r5so2068672pfl.2
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 01:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mg0CWwkGTJFR5t8HpIjhDTADVKsXSSOk+6I5dnm0Pc8=;
        b=IQrD11MCUlGpsUczBZhmCh//Plya/6g/ZTGwYvCaXz0fmJZQq9IPvQdnVhaA3cAdtP
         EhnvbvV/weMo2wQkXR9Jnh9RmMWYyvQb5PlHZNnC6p4BkSWbSH1dgITWIJiqRG8ta48r
         y0hMgcZeV93VDQK3IxJlb7mTAypjEPSTuoKJOQRtb7GcHkXoTyUd+pxss5DtQylUISsl
         fG3OcVrfYzEHZqEB47KXGX7+/v3RsdqgOFWDxmrXnj3LP9RzUKa5pyndVrf7yaS3rROS
         QcWSNw9GCvuJgd1goIFWXjHEsUwuuPNPDkoqk20NGD/c4vztFRM6+yQrBFgiyb4Po66W
         KhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mg0CWwkGTJFR5t8HpIjhDTADVKsXSSOk+6I5dnm0Pc8=;
        b=2oMUIjqkSKfc2t7CvGVy/YBOv/wOwQ7gFEKmzJ5khy6rdah5dXVTIjSwifaxylY//M
         WdL59sfQ6qe9NpbwoASu1XvvFN/H1afYCbkodhxeN83qsgioTf/7qC9Q81Zeyds6lS56
         0EdEdgJNQxX9XIF0QMl9eECGV+O8RcI2LAUZzW0wW2MXvTZ/R+pbwK4gdlW32rGqoBT7
         h5t4Me33x9qGuECp4CsFUkeioffqFIwoG/RsMM9ErW4hKb+FCDj7g3cQ8BBdc4NfeMTk
         5c/33YHr85QIYx+d2pVdjkRsl2YHOVhkWnpdiqqr2GyGFQE8pZHTgy6eA8BOa6+mJZom
         B8Mg==
X-Gm-Message-State: AOAM533/xyuBj/GGGfEEB6+M3dC5XIE1dDicixNndjKXQFvstFKbEHX8
        l49S7iOVpM4Q8ZdrcNvXTbyYxfV+G50=
X-Google-Smtp-Source: ABdhPJwUANb8KBX1Lilt6GnKevwhpYThh4tA4wB8O13SB692tpPYg8DEeELWNtcpSl/VdTS7RfFoCw==
X-Received: by 2002:aa7:904d:0:b0:4bc:a970:be1 with SMTP id n13-20020aa7904d000000b004bca9700be1mr30167154pfo.65.1642585500804;
        Wed, 19 Jan 2022 01:45:00 -0800 (PST)
Received: from ubuntu.mate (subs09a-223-255-225-71.three.co.id. [223.255.225.71])
        by smtp.gmail.com with ESMTPSA id b9sm17035350pgb.17.2022.01.19.01.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 01:45:00 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/2] sequencer: factor GIT_AUTHOR_* from message strings
Date:   Wed, 19 Jan 2022 16:44:44 +0700
Message-Id: <20220119094445.15542-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119094445.15542-1-bagasdotme@gmail.com>
References: <20220119094445.15542-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor messages containing GIT_AUTHOR_* variable.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 sequencer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6abd72160c..472feb053c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -848,17 +848,17 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 	for (i = 0; i < kv.nr; i++) {
 		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
 			if (name_i != -2)
-				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
+				name_i = error(_("'%s' already given"), "GIT_AUTHOR_NAME");
 			else
 				name_i = i;
 		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
 			if (email_i != -2)
-				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
+				email_i = error(_("'%s' already given"), "GIT_AUTHOR_EMAIL");
 			else
 				email_i = i;
 		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
 			if (date_i != -2)
-				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
+				date_i = error(_("'%s' already given"), "GIT_AUTHOR_DATE");
 			else
 				date_i = i;
 		} else {
@@ -867,11 +867,11 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		}
 	}
 	if (name_i == -2)
-		error(_("missing 'GIT_AUTHOR_NAME'"));
+		error(_("missing '%s'"), "GIT_AUTHOR_NAME");
 	if (email_i == -2)
-		error(_("missing 'GIT_AUTHOR_EMAIL'"));
+		error(_("missing '%s'"), "GIT_AUTHOR_EMAIL");
 	if (date_i == -2)
-		error(_("missing 'GIT_AUTHOR_DATE'"));
+		error(_("missing '%s'"), "GIT_AUTHOR_DATE");
 	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
 	*name = kv.items[name_i].util;
-- 
An old man doll... just what I always wanted! - Clara

