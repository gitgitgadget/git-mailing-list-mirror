Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D129C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C068611C0
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJDH2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 03:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhJDH2G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 03:28:06 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C9C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 00:26:17 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a13so15063853qtw.10
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCviUxgXq7mp4Ue0boAEVidn06L7ldzNysJXUtkeNbY=;
        b=b7u7TmfHZviRCrmWaJOYy6Ag57u8HtkoMbjE0CxmDF1+ekLlOIJU4DcOQHL6EoIMWM
         QC/awGmSMvyKJ2jIWEZMSLIPcUTjAz31NFY3h/Hoe2QbJVWE3xv9+inDX/Y2vErwZaBF
         DE9N7LQY/Q5l3zd/EW3RTHEjHavmWlfke753D07za5vhvswuDA8uabbASFFOI/sCGyyM
         697XFpXUi1OLZoS4HJs4Hf+6aG6zmLCP78sZi4dwcLjjMBuS/IC4alDpZoTKCnsFEyab
         31nbmGUsanEMbd9NNEjmCbBkc+NcuNm++w3/89rm/GJKNw2ND1dwyMpHIhPQBQKd1J8J
         7osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCviUxgXq7mp4Ue0boAEVidn06L7ldzNysJXUtkeNbY=;
        b=6GWos0PNk4b6THoAx7Y87d+LzW/EfDn3TN2IfVTpWfgRPAG9p3eEPmXarhBxcse1GM
         j5ht9OTXNxyqp5ENhE2wazoK/nhKN0hVPsRBWFuQ53lSCys/kN6y6Lxq22sb3HHjwP+A
         APX6iRIz7JLTC36CUm1z6DjTb7SH+EZUH/ZWQBktm6kuXNOH3yp9fSKHpVvQR2mTbgGI
         9Ho3e54QTtnOQcUWwe/m+9nZu2olkfpVUlHDAj+uHX2InUvDd7HLJECTaHMzkp1rTe3V
         k5jooLJf3HOJt0QdOnsUierAafB9iettcduhy9V8a17rkzKHYZEDCLAiyBFv88UPpX0P
         Pn3g==
X-Gm-Message-State: AOAM533SdWfV/ccldO749EX/x93Z/AQoPG0yBsxlHIQ23CdU1LwCV/E9
        eD5yvWBmGCBOj8OIqNEWgbLpT8p5/Kjwkg==
X-Google-Smtp-Source: ABdhPJzRG7Vk2t0QpexBJG6qfZWxDYHS6uSmPOLYADDqjgmZltE578BOs2hYJ5/ZiPM1/GVkT12Dpg==
X-Received: by 2002:ac8:4089:: with SMTP id p9mr11485491qtl.363.1633332376751;
        Mon, 04 Oct 2021 00:26:16 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a3sm9015330qta.48.2021.10.04.00.26.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 00:26:16 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/2] editor: save and reset terminal after calling EDITOR
Date:   Mon,  4 Oct 2021 00:26:00 -0700
Message-Id: <20211004072600.74241-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20211004072600.74241-1-carenas@gmail.com>
References: <20211002153654.52443-1-carenas@gmail.com>
 <20211004072600.74241-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When EDITOR is invoked to modify a commit message, it will likely
change the terminal settings, and if it misbehaves will leave the
terminal output damaged as shown in a recent report from Windows
Terminal[1]

Instead use the functions provided by compat/terminal to save the
settings and recover safely.

[1] https://github.com/microsoft/terminal/issues/9359

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 editor.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/editor.c b/editor.c
index 6303ae0ab0..be7441e7e0 100644
--- a/editor.c
+++ b/editor.c
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "compat/terminal.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -50,6 +51,8 @@ const char *git_sequence_editor(void)
 static int launch_specified_editor(const char *editor, const char *path,
 				   struct strbuf *buffer, const char *const *env)
 {
+	int term_fail;
+
 	if (!editor)
 		return error("Terminal is dumb, but EDITOR unset");
 
@@ -83,7 +86,10 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
+		term_fail = save_term(1);
 		if (start_command(&p) < 0) {
+			if (!term_fail)
+				restore_term();
 			strbuf_release(&realpath);
 			return error("unable to start editor '%s'", editor);
 		}
@@ -91,6 +97,8 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
+		if (!term_fail)
+			restore_term();
 		strbuf_release(&realpath);
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
-- 
2.33.0.955.gee03ddbf0e

