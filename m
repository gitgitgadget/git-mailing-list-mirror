Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA35BC35666
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 18:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19F6206ED
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 18:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADAGZUh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgBWS5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 13:57:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41559 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWS5P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 13:57:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so9302267eds.8
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 10:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9vcvACtESSI0at8vQhtic3fX/w7zVQNgQce3yCWhKpo=;
        b=ADAGZUh/kp7CDBJz4htaqPDUZOvV/xBMpJF4CvGgGkOSt/B9Dbe5pNnBgLj8UFMy7h
         GUgyPhtRlGwedjPDZvfp5/hElQ5B6m/ciyxXxZvjEaVLt586f730varl5gIC5pEPDDsL
         /cYBrfqJWiSv4GPLpl41RYZ0oY5PRI6LoAKp+clEiWwsglbELA5wXD2pOXLUOhqxGXAj
         k/SwxdvEXWheMQeXJLNCp7rMTMko4LpTMs1+4TI6GeiQDZ+gYsaj79jwqwGwvTqoz2rB
         +tVysHf3N8EV+WeVziXNitECn6kFDss7AVIOI1GvctK/6UiF6hP8tqht9SyFmL1aNFoP
         fSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9vcvACtESSI0at8vQhtic3fX/w7zVQNgQce3yCWhKpo=;
        b=myaCQ/Kk1LDOZKlFqKrp8i/BKB0+fTvFIJ2gc2ERhjw/3NCD1Ke/uvlgmWWFIkvZmp
         iU37G4JA71aaIoKhWL/k+06GGOJaX+etUVbHum4q6Yc1WE1thzzAaxwjxqrs/92xeJHD
         Ivb37zkRnHCV5g5wGf5xUyQLVsliGaQmEseMOxQz2UhpzKqjJRLDhMvgw5YiW9R06tug
         GSLrWL+VMmVVwYsKOD6Ac1c9Z8vaAsMhDlLMCZYmEDyVRpXNSKFAfQr0FVNab+htyfom
         QgSbqfPmql4cKWdxhAO0uperPr/fiZATGCk9dgxBN6XLXkl25MOC8D+CRAr/pBSMYmrq
         gsyw==
X-Gm-Message-State: APjAAAXCTx8Okd/hYWXCEQCvlcALfHMgLtwf9lciur1Q9vgkGZaBaWbV
        rQ6j5vC17LWyqQa0V/8EwxFZiSp0
X-Google-Smtp-Source: APXvYqwpRljEPMSZJIBC/2vwSBONfpAgpO/9M0Hxd0JH4LUPcEL3AvWS0DVSIhZZBEtWpMtsiSP5Iw==
X-Received: by 2002:aa7:cd42:: with SMTP id v2mr43611421edw.345.1582484233280;
        Sun, 23 Feb 2020 10:57:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id qt20sm699774ejb.65.2020.02.23.10.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 10:57:12 -0800 (PST)
Message-Id: <8718facbc951614f19407afa6ca8d6110507483d.1582484231.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.535.v3.git.1582484231.gitgitgadget@gmail.com>
References: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
        <pull.535.v3.git.1582484231.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 23 Feb 2020 18:57:08 +0000
Subject: [PATCH v3 1/3] get_main_worktree(): allow it to be called in the Git
 directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

When called in the Git directory of a non-bare repository, this function
would not return the directory of the main worktree, but of the Git
directory instead.

The reason: when the Git directory is the current working directory, the
absolute path of the common directory will be reported with a trailing
`/.git/.`, which the code of `get_main_worktree()` does not handle
correctly.

Let's fix this.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 worktree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/worktree.c b/worktree.c
index 5b4793caa34..7c8cd213171 100644
--- a/worktree.c
+++ b/worktree.c
@@ -51,6 +51,7 @@ static struct worktree *get_main_worktree(void)
 	struct strbuf worktree_path = STRBUF_INIT;
 
 	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
+	strbuf_strip_suffix(&worktree_path, "/.");
 	if (!strbuf_strip_suffix(&worktree_path, "/.git"))
 		strbuf_strip_suffix(&worktree_path, "/.");
 
-- 
gitgitgadget

