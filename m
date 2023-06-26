Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B92EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFZQxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFZQxK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:53:10 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019FC18E
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:53:08 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-763cb17f208so339464185a.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687798388; x=1690390388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1n404nJ89+I1vaFYRyRx2046owf9mRYSjau3u9bc+A=;
        b=o9020nd5g03l0qQxEiJWwDZDLYN9qq512afpp2tVpLBB6sST6pnwFmczg/R/mPR3p1
         0rgTjaDbITl1WNv5+qkBvoANWZ6bLisHJKp6nPrgfPoTf7L6HhxNEuvEZwDgZNK2OX2T
         ctz5Mk0Iec+gAjF+JakxAVKeQ+7LDqiLnzXfdP0ZRCXZ1Q3FFQkXq/W9MNVrYHYf4lMW
         SRQZS3enfnCaJ4yNPFviRLZ4oSlYur7n3KBJ5zOU760En7/E+s5fSRrBqFQQ+44kEDHj
         d+sdHOVRz9q46/IoB0yTCGdbyJkksERGt59a+kesXH9b/+h21fW/MqeGPUvLLM78+8HC
         SjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798388; x=1690390388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1n404nJ89+I1vaFYRyRx2046owf9mRYSjau3u9bc+A=;
        b=CNtAn79yynTNSoLr7E23kDlb4ODO6lRdHkT/9F2ljzgP+WgUcJDM/xhT8gSIj6wfMw
         tLHllYxp7S9T2edAdUz3lpAF6MFUYDbg933uKtBC/dS+gGqgfcGIohjdNpvPAYI+4uhy
         ywu6n6HDEZqIlhqclY1SWF10T5I9c9ThxwAZOYFSeV/qkpcls6di118qoA2NBs05dwF5
         r3fAlOT8bbRtbRsC4ANxvA8fptzFSkFPEXirD59ePIY+aqRFlNstuUEAUEfAsU5jn3hy
         MAnYGSI5Q7pVup9p8GK2sD/xmiMusrDFaqsD+4xHFlEJjRMrN9dhmegsy98Vuwjc0Rwb
         0QBA==
X-Gm-Message-State: AC+VfDz3ddBR5qHhZZSKd7oQyIU76/+G6UVPxTgBmyAGD1afQZjXhkne
        4/1RkiU9yyfTXax41kgCoAo=
X-Google-Smtp-Source: ACHHUZ4S/eqS/Rsn3/rKOMhFOQVnKXddL4RaNWhZB6o25855SvUQmgBd64S7zKeFrcPwf3HqgOfLJg==
X-Received: by 2002:a05:620a:298c:b0:765:5ed4:5170 with SMTP id r12-20020a05620a298c00b007655ed45170mr9305206qkp.39.1687798388094;
        Mon, 26 Jun 2023 09:53:08 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id p5-20020a05620a112500b00765acdc4f56sm922819qkk.60.2023.06.26.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:53:07 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     mdl123@verizon.net, git@vger.kernel.org
Cc:     adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, gitster@pobox.com,
        sunshine@sunshineco.com, Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 1/4] git gui Makefile - remove Cygwin modifications
Date:   Mon, 26 Jun 2023 12:53:02 -0400
Message-ID: <20230626165305.37488-2-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <20230626165305.37488-1-mlevedahl@gmail.com>
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <20230626165305.37488-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-gui's Makefile hardcodes the absolute Windows path of git-gui's libraries
into git-gui, destroying the ability to package git-gui on one machine and
distribute to others. The intent is to do this only if a non-Cygwin Tcl/Tk is
installed, but the test for this is wrong with the unix/X11 Tcl/Tk shipped
since 2012. Also, Cygwin does not support a non-Cygwin Tcl/Tk.

The Cygwin git maintainer disables this code, so this code is definitely
not in use in the Cygwin distribution.

The simplest fix is to just delete the Cygwin specific code,
allowing the Makefile to work out of the box on Cygwin. Do so.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Makefile | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index a0d5a4b..3f80435 100644
--- a/Makefile
+++ b/Makefile
@@ -138,25 +138,10 @@ GITGUI_SCRIPT   := $$0
 GITGUI_RELATIVE :=
 GITGUI_MACOSXAPP :=
 
-ifeq ($(uname_O),Cygwin)
-	GITGUI_SCRIPT := `cygpath --windows --absolute "$(GITGUI_SCRIPT)"`
-
-	# Is this a Cygwin Tcl/Tk binary?  If so it knows how to do
-	# POSIX path translation just like cygpath does and we must
-	# keep libdir in POSIX format so Cygwin packages of git-gui
-	# work no matter where the user installs them.
-	#
-	ifeq ($(shell echo 'puts [file normalize /]' | '$(TCL_PATH_SQ)'),$(shell cygpath --mixed --absolute /))
-		gg_libdir_sed_in := $(gg_libdir)
-	else
-		gg_libdir_sed_in := $(shell cygpath --windows --absolute "$(gg_libdir)")
-	endif
-else
-	ifeq ($(exedir),$(gg_libdir))
-		GITGUI_RELATIVE := 1
-	endif
-	gg_libdir_sed_in := $(gg_libdir)
+ifeq ($(exedir),$(gg_libdir))
+	GITGUI_RELATIVE := 1
 endif
+gg_libdir_sed_in := $(gg_libdir)
 ifeq ($(uname_S),Darwin)
 	ifeq ($(shell test -d $(TKFRAMEWORK) && echo y),y)
 		GITGUI_MACOSXAPP := YesPlease
-- 
2.41.0.99.19

