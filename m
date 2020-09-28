Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBF6C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 20:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0DE206E5
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 20:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPvFA1N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgI1UUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 16:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1UUj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 16:20:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171DEC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 13:20:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d6so2165681pfn.9
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EsxjRr+dWOem31qVgb1vesQytA67iO7T4hUe+yNVS34=;
        b=mPvFA1N7FTQKfGI+JxvOURLvuX9NEwV7tDYtPc0I5wHmrFoYn44KlTPg3TgsLCsMFJ
         cHg5aQiXJbYvUolETWFV+I5Pjy/h7njqcvlGyS9gmpx6erjimIUBTRNUp3rrgLKUPzVR
         jPO4TV1FGmV4Lz0ahbxv+EZa3UonNYZPP6dWt2VbsHdIYvb3206Y7Nxt+J0ceS/OpCCW
         nZV0J2CgEJQ7rRkK2DCbxDtH/XcdWt8ohmFyA2e4dvQ6B7984j5uqpYYNw3GntG0eVMg
         KVvfm7shbVtxa69Bw1gk5yroMW39m3eRNvVkDi/v2gUujFSoHGCfC/ixK4iTzm/rG+Qw
         o33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsxjRr+dWOem31qVgb1vesQytA67iO7T4hUe+yNVS34=;
        b=F4UuQCCCYxtanZGZ+cbgya07ON1y9sOQtZrjFUZZDa9K1XKRu8pkdMQJgfxwxIigkL
         92FW0KSdGEX7cGyJQUUGG7UpbGFwwtWo6w16OSAoACvx7F8+N/Yh05tR+nPTjCk6dd4b
         NXL1AUEId6fJ23Us3l41DD4V7WQ02XWmPXVkSvYVJZHKB/dSWm2PfI84dJV+CCgsZ/lF
         qSAHZNHQmvQdh+1JPnzftwsPuyYJo5KzEL/mbPyia/7pUrK77mpdSXDMXx3ri2o48Itq
         /kKTVVRgXWYb4aMg+RcQo0PLacevjocFgb0AryBOWHreSQiWccS3nctwYov4zywdplKA
         bvAg==
X-Gm-Message-State: AOAM5336f33IE+pH3++gGIbktd9mRseJuqobzDKWjCf00oaxVGAldarM
        lQC/o+TxKqjI/PXG8V3hcF36BFA3riwkJQ==
X-Google-Smtp-Source: ABdhPJzarX00Go+bNgTwqwvEDad4GQJqwZl0y+vCsDIhfACYttdPibCpuxJh3l3WIJ424bA7BqYOYw==
X-Received: by 2002:a63:5c66:: with SMTP id n38mr565123pgm.217.1601324437072;
        Mon, 28 Sep 2020 13:20:37 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-93-247-186.natsow.res.rr.com. [70.93.247.186])
        by smtp.gmail.com with ESMTPSA id u138sm2659465pfc.218.2020.09.28.13.20.35
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 13:20:36 -0700 (PDT)
From:   Evan Gates <evan.gates@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] Doc: specify exact scissors line
Date:   Mon, 28 Sep 2020 13:20:35 -0700
Message-Id: <20200928202035.24218-1-evan.gates@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925191659.31375-1-evan.gates@gmail.com>
References: <20200925191659.31375-1-evan.gates@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing wording covers most of the requirements of a scissors
line, but there is no mention of the minimum size requirement that led
to a six character line ("-->8--") not counting as a scissors line.
Specify the exact line to use ("-- >8 --") instead of trying to document
all the details.

Signed-off-by: Evan Gates <evan.gates@gmail.com>
---
Changes in v2:
- Specify exact line instead of adding text about 8 character minimum

 Documentation/git-mailinfo.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 3bbc731f67..fbb7d2813f 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -72,10 +72,9 @@ conversion, even with this flag.
 	is useful in order to associate commits with mailing list discussions.
 
 --scissors::
-	Remove everything in body before a scissors line.  A line that
-	mainly consists of scissors (either ">8" or "8<") and perforation
-	(dash "-") marks is called a scissors line, and is used to request
-	the reader to cut the message at that line.  If such a line
+	Remove everything in body before a scissors line ("-- >8 --").
+	The line represents scissors and perforation marks, and is used to
+	request the reader to cut the message at that line.  If that line
 	appears in the body of the message before the patch, everything
 	before it (including the scissors line itself) is ignored when
 	this option is used.
-- 
2.28.0

