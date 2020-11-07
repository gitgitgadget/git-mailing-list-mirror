Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA914C388F9
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 22:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8340F20719
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 22:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R236dbJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgKGWUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 17:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKGWUm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 17:20:42 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297EEC0613CF
        for <git@vger.kernel.org>; Sat,  7 Nov 2020 14:20:42 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id o25so4879111oie.5
        for <git@vger.kernel.org>; Sat, 07 Nov 2020 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyuBEk1d4B2B3OWgRcmz9Hy5mYgPL/B10IflmgFQn5M=;
        b=R236dbJdbJfpoeRpSUp1cbbyy9K6y2sLDcJnIO5Se+H643ORxRwZ4R3vcx4bjge8jG
         +MfifBimTxyX0CBzwfWHwXpupAuUeMoIKNrZy5IIRpFhBMGTy8weXRkX/61YnBNKkyWd
         q/6jvoG8myHWmvxBnS6M75noaW8cugz6kS4iLaXP0WcZesc8NuH4eTh4A7n23OYt6l7i
         0TD8vRBBt9adJdwTI0sDxEc0VxG7S5qbuuOhiooD9I7U4B0J9nBIDhnE4I5hDoGjZ1VE
         fy8H67OM6HKSmkl1Oz46wHNsk7OjfwBDIDtB1fQZQW10cA5Y4kUvtj/PmYPZhNXf7Sjw
         O07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XyuBEk1d4B2B3OWgRcmz9Hy5mYgPL/B10IflmgFQn5M=;
        b=gf1VtCvvpRdk4VuRalN74Hb4/t+YIwmYvgfy7AzrR059YwJGQeN45WhhyaHOqtJUpL
         xEcfPn0i2SenWyGIBZmW7anRiBR1EB9M21ddHzoLCFCOVSwxV3EzRJco+D34C9aBIqQQ
         hxyAeSTqJmKiS28gDoBHUF5+Moh+OIF2zc0e1n21u5Y2I1VfVV2bDZqD81hgYMWPZicW
         zwOr+GZpxiULiNLnNgCaHn7BMLJIkNnF/qcQ7TBxc3JLGltrKG7P/uzzFwGzpj77fVj0
         CpEPox3STPJHabZNVL2aiTLW7N74KkbCK8x/QMZsn6IZV8Nc4aizXWWFBEl/kaTEAagy
         rXCA==
X-Gm-Message-State: AOAM5306gCmo9J3Em+8dcuNX48oOG3g4kvgvt9z5xF2edUkuji6BmwKd
        vVxewaY5VrdwBgoQ20bz5MuOAIQhwRk=
X-Google-Smtp-Source: ABdhPJy0T8RVi/5ZBpWhRP1uSKHaY83xG5rL/GGPh5E8w9bjn+W6v7KcAKaUcuknD3/qjzGu8A0Lbw==
X-Received: by 2002:aca:4a0d:: with SMTP id x13mr5287355oia.155.1604787641576;
        Sat, 07 Nov 2020 14:20:41 -0800 (PST)
Received: from David-Aguilar--sarawiggum.attlocal.net (99-121-213-74.lightspeed.irvnca.sbcglobal.net. [99.121.213.74])
        by smtp.gmail.com with ESMTPSA id m17sm1342246otq.57.2020.11.07.14.20.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 14:20:40 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Miguel Boekhold <miguel.boekhold@osudio.com>,
        Efimov Vasily <laer.18@gmail.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] git-gui: ssh-askpass: add a checkbox to show the input text
Date:   Sat,  7 Nov 2020 14:20:39 -0800
Message-Id: <20201107222039.13900-1-davvid@gmail.com>
X-Mailer: git-send-email 2.29.2.154.g7f7ebe054a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hide the input text by default since the field is
commonly used for sensative informations such as passwords.

Add a "Show input" checkbox to conditionally show the input.

Helped-by: Miguel Boekhold <miguel.boekhold@osudio.com>
Signed-off-by: Efimov Vasily <laer.18@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-gui--askpass | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

This patch gathers the submissions from the following sources:

https://github.com/patthoyts/git-gui/issues/22
https://github.com/prati0100/git-gui/pull/38
https://github.com/git-cola/git-cola/issues/1004
https://github.com/git-cola/git-cola/pull/1069

diff --git a/git-gui--askpass b/git-gui--askpass
index 1c99ee8..71a536d 100755
--- a/git-gui--askpass
+++ b/git-gui--askpass
@@ -26,8 +26,21 @@ pack .m -side top -fill x -padx 20 -pady 20 -expand 1
 entry .e -textvariable answer -width 50
 pack .e -side top -fill x -padx 10 -pady 10
 
+proc on_show_input_changed {args} {
+	global show_input
+	if {$show_input} {
+		.e configure -show ""
+	} else {
+		.e configure -show "*"
+	}
+}
+trace add variable show_input write "on_show_input_changed"
+
+set show_input 0
+
 if {!$yesno} {
-	.e configure -show "*"
+	checkbutton .cb_show -text "Show input" -variable show_input
+	pack .cb_show -side top -anchor nw
 }
 
 frame .b
-- 
2.29.2.154.g7f7ebe054a

