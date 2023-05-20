Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA54C77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjETQOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjETQOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6DC125
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso4283131f8f.0
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599245; x=1687191245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp2FfDi4NI533e1tiQOcF3r2CbgruwrIgxMPr/37MLw=;
        b=BNoAlcTHP0lkcmua1wKu/czFO0NnJvVXw3FBrbFb99XL2Tqoj/ZLbb5fVJib8pMlub
         bQyI+EptJEiD9eZmdiuuz1rwqnRcuYKhyo20AWkPHtSSSBreJYqTllE5hHr7alVyh8/3
         7tU9F9XNRi9VOKDwf8o4+iXySf55PNDMUk6fJytH8gAnyWnvf+kurHJ6hUmdKnER2H5+
         JrXcmtU+YwmfAWONKgAUYGf1DdJmRXY92ktJ2lzGIkwddVVEPUfnHay4iUS4vcGo4+9h
         sM2RopsGQZUTmb8utDRauQ68ebKISXcKRyTuN4pMo1GK8emViR1hNrjLWHdbDwAWCzOL
         0qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599245; x=1687191245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp2FfDi4NI533e1tiQOcF3r2CbgruwrIgxMPr/37MLw=;
        b=mE3sP7/NKogWWMJa8Vi1wfHhScxfkiD3byexFk+YXBNF8J5Jxvr4ecQIxihSfhqVGN
         eap3g/WA86yIamynaxLBoWCq2fO0xbmAvCM338hHSByfHWmoza+dY+GslFfv7O3uFAW/
         LHdJkC/xGufpk+/PvHMsgayrMx8vy1xnSAivoNR12/AEYsDhnjIjupltusxrQrtMofRD
         mSrQQAvLDybHsj36cAtpsHXYxd9SLWIVwYW/OeTwxGfMEdXLA5fem6vJW633FoEUg99R
         IWUxtYxp7Ri6q1NnYgCWmprtCWOiudsIJg104JtsegZH0GnFlfo0qXS87hrKbNpnLF9G
         /S1Q==
X-Gm-Message-State: AC+VfDxo7XozEt6KFO2PdCzv+FsPMhPhwgemyQizKyhOeBAN4h95sjQH
        keWPq90zCbdIKgSoJpgieDrTS1ZGa18=
X-Google-Smtp-Source: ACHHUZ4aLfniEy0RD64OSLveXYjC/vXcHpgRgtxlONzFLsOAofMiKZ35Ek8UclYrsIhVOx1UKY0iTw==
X-Received: by 2002:adf:fe89:0:b0:309:45cc:577a with SMTP id l9-20020adffe89000000b0030945cc577amr4221572wrr.13.1684599245640;
        Sat, 20 May 2023 09:14:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d25-20020a1c7319000000b003f4ddde398csm2709477wmb.21.2023.05.20.09.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:14:05 -0700 (PDT)
Message-Id: <5a767913a569ade7b2596e89cae887c878447a72.1684599239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
References: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:56 +0000
Subject: [PATCH 08/10] t9104-git-svn-follow-parent: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t9104-git-svn-follow-parent.sh | 62 ++++++++++++++++----------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 85d735861fc..b5845e28fee 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -41,51 +41,51 @@ test_expect_success 'init and fetch a moved directory' '
 	'
 
 test_expect_success 'init and fetch from one svn-remote' '
-        git config svn-remote.svn.url "$svnrepo" &&
-        git config --add svn-remote.svn.fetch \
-          trunk:refs/remotes/svn/trunk &&
-        git config --add svn-remote.svn.fetch \
-          thunk:refs/remotes/svn/thunk &&
-        git svn fetch -i svn/thunk &&
+	git config svn-remote.svn.url "$svnrepo" &&
+	git config --add svn-remote.svn.fetch \
+		trunk:refs/remotes/svn/trunk &&
+	git config --add svn-remote.svn.fetch \
+		thunk:refs/remotes/svn/thunk &&
+	git svn fetch -i svn/thunk &&
 	test "$(git rev-parse --verify refs/remotes/svn/trunk)" \
-	   = "$(git rev-parse --verify refs/remotes/svn/thunk~1)" &&
+		= "$(git rev-parse --verify refs/remotes/svn/thunk~1)" &&
 	git cat-file blob refs/remotes/svn/thunk:readme >actual &&
 	test "$(sed -n -e "3p" actual)" = goodbye
-        '
+'
 
 test_expect_success 'follow deleted parent' '
-        (svn_cmd cp -m "resurrecting trunk as junk" \
-               "$svnrepo"/trunk@2 "$svnrepo"/junk ||
-         svn cp -m "resurrecting trunk as junk" \
-               -r2 "$svnrepo"/trunk "$svnrepo"/junk) &&
-        git config --add svn-remote.svn.fetch \
-          junk:refs/remotes/svn/junk &&
-        git svn fetch -i svn/thunk &&
-        git svn fetch -i svn/junk &&
+	(svn_cmd cp -m "resurrecting trunk as junk" \
+		"$svnrepo"/trunk@2 "$svnrepo"/junk ||
+	 svn cp -m "resurrecting trunk as junk" \
+		-r2 "$svnrepo"/trunk "$svnrepo"/junk) &&
+	git config --add svn-remote.svn.fetch \
+		junk:refs/remotes/svn/junk &&
+	git svn fetch -i svn/thunk &&
+	git svn fetch -i svn/junk &&
 	test -z "$(git diff svn/junk svn/trunk)" &&
 	test "$(git merge-base svn/junk svn/trunk)" \
-	   = "$(git rev-parse svn/trunk)"
-        '
+		= "$(git rev-parse svn/trunk)"
+'
 
 test_expect_success 'follow larger parent' '
-        mkdir -p import/trunk/thunk/bump/thud &&
-        echo hi > import/trunk/thunk/bump/thud/file &&
-        svn import -m "import a larger parent" import "$svnrepo"/larger-parent &&
-        svn cp -m "hi" "$svnrepo"/larger-parent "$svnrepo"/another-larger &&
-        git svn init --minimize-url -i larger \
-	  "$svnrepo"/larger-parent/trunk/thunk/bump/thud &&
-        git svn fetch -i larger &&
+	mkdir -p import/trunk/thunk/bump/thud &&
+	echo hi > import/trunk/thunk/bump/thud/file &&
+	svn import -m "import a larger parent" import "$svnrepo"/larger-parent &&
+	svn cp -m "hi" "$svnrepo"/larger-parent "$svnrepo"/another-larger &&
+	git svn init --minimize-url -i larger \
+		"$svnrepo"/larger-parent/trunk/thunk/bump/thud &&
+	git svn fetch -i larger &&
 	git svn init --minimize-url -i larger-parent \
-	  "$svnrepo"/another-larger/trunk/thunk/bump/thud &&
+		"$svnrepo"/another-larger/trunk/thunk/bump/thud &&
 	git svn fetch -i larger-parent &&
-        git rev-parse --verify refs/remotes/larger &&
-        git rev-parse --verify \
-	   refs/remotes/larger-parent &&
+	git rev-parse --verify refs/remotes/larger &&
+	git rev-parse --verify \
+		refs/remotes/larger-parent &&
 	test "$(git merge-base \
 		 refs/remotes/larger-parent \
 		 refs/remotes/larger)" = \
-	     "$(git rev-parse refs/remotes/larger)"
-        '
+		"$(git rev-parse refs/remotes/larger)"
+'
 
 test_expect_success 'follow higher-level parent' '
 	svn mkdir -m "follow higher-level parent" "$svnrepo"/blob &&
-- 
gitgitgadget

