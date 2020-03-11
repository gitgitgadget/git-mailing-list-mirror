Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73808C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6008620663
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1Kb9B/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbgCKTYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:24:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34314 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbgCKTYl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 15:24:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so4174605wrl.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6vTi6LjwsEFavrFuE2agIPI4DaZQagBm+xpVBuZOoSM=;
        b=S1Kb9B/2N/gx/G0jYgaPs9Mv8E6Gh3OBPtmB4jTmI3wTjcQNGAGYWzSa41tbeMZ9fW
         k8py1rz8PXfZSJJj9foDsBvcWSrFSeO9a3p6+ke4Nvjcq1KNHCpSWqfRT8K0eJ31s948
         f9DpUCUsala19/tVhFlWqB3lrNoLMHwnSfBnAk4yLwM4MCIcTRGUCPVc2GlyxOxJ4MO/
         NSl5UUtItgWfhllxRS0hMZ32p/X4Fc8Q/Xy2z1v5zCoBCHXR5v26b90NjHoLFL+kRrv7
         o532U45sUEF087Kyqxiy2wj1c5i4/bFmFcNhCRR1Nkh5W0RpVhpkSe5oIMYxmcHot71H
         VOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6vTi6LjwsEFavrFuE2agIPI4DaZQagBm+xpVBuZOoSM=;
        b=Ai6DdMMW1JkS49x3W2W6QAp+W72+Wt456kui/chlNg8EbmSVIIOGeaZh7lQxZTyFue
         j6MxEzvNqA9KBpNGkcqaA9xYJxw8BoZRdl0W9Cp6TIZFx/vG9tFol0wVmMSpiPTnOGyx
         1pJMXx+xrlMRDBt1LCXKUGXFMmDEgVJ+I2ZMSjJMjCalQHUuG8sYmlwd7AIsCPBDnQpm
         udVLQ5fs09td0VJR7NIVfLeVf9j1VJrd0akIWkozOI4fklwSSxqgBBY4jJQNIqn4TG2F
         9E7J44EvGlXiubfeQbRZUihwpYniJZ+WUqgYg5U9P0S1l3yNpVPoWyKQf37qLWgavtSz
         x2kw==
X-Gm-Message-State: ANhLgQ0hQKttUM4lh1ltv9bJNWV8KEZswVUohKI1RRzxtqBPGLsR/boz
        VMxRup3MdmbosMbzJlBGmoEsKJ2Q
X-Google-Smtp-Source: ADFU+vulMntMX5gDMCc0T0tqTAWl/F2tPvw+zD8reDSeAzHySCI/vt2y+NVjjvbbx/haL1+j3ohjAQ==
X-Received: by 2002:adf:ed04:: with SMTP id a4mr5837760wro.76.1583954677719;
        Wed, 11 Mar 2020 12:24:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l64sm9640336wmf.30.2020.03.11.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:24:37 -0700 (PDT)
Message-Id: <pull.578.git.1583954676691.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Mar 2020 19:24:36 +0000
Subject: [PATCH] git-gui--askpass: coerce answers to UTF-8 on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Luke Bonanomi <lbonanomi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Bonanomi <lbonanomi@gmail.com>

This addresses the issue where Git for Windows asks the user for a
password, no credential helper is available, and then Git fails to pick
up non-ASCII characters from the Git GUI helper.

This can be verified e.g. via

	echo host=http://abc.com |
	git -c credential.helper= credential fill

and then pasting some umlauts.

The underlying reason is that Git for Windows tries to communicate using
the UTF-8 encoding no matter what the actual current code page is. So
let's indulge Git for Windows and do use that encoding.

This fixes https://github.com/git-for-windows/git/issues/2215

Signed-off-by: Luke Bonanomi <lbonanomi@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix git-gui--askpass on Windows
    
    Windows has this odd thing where there is an active code page (somewhat
    like LC_CTYPE) and there is no real UTF-8 code page. So we need to help 
    git-gui--askpass along a bit to be of use when asking for credentials.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-578%2Fdscho%2Fgit-gui--askpass-utf-8-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-578/dscho/git-gui--askpass-utf-8-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/578

 git-gui--askpass | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-gui--askpass b/git-gui--askpass
index 4277f30c411..b0704e6d91e 100755
--- a/git-gui--askpass
+++ b/git-gui--askpass
@@ -56,6 +56,11 @@ proc finish {} {
 		}
 	}
 
+	# On Windows, force the encoding to UTF-8: it is what `git.exe` expects
+		if {$::tcl_platform(platform) eq {windows}} {
+		set ::answer [encoding convertto utf-8 $::answer]
+	}
+
 	puts $::answer
 	set ::rc 0
 }

base-commit: 63a58457e094c9c9bbf562b872009d32f1f88133
-- 
gitgitgadget
