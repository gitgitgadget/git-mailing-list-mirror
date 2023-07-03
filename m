Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6B0C001DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGCSqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGCSqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7C210D8
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso41200695e9.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409971; x=1691001971;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lG/oM6RF8tUaMRTSvL9IPLqSI9sC3DV6HbxUPjojG0=;
        b=jGT9CaP2kJesmSGjmoFD+ozjE+sNFcop3jVjWtuagLXb2AeQhJ0BzeFmVy2AXmhNHo
         t40rNd+swE2miE/UE5SvSb//mMQILKpUx6maK8PcGrWyLfsI1DVQ+Cti54ka+dfXa9la
         z+HNeOCkvp/Pu4NMHM6GXMxyLGph0n+FsZ9dQOu3YlxHowlD17KBgtl7SSssbVDPLOLb
         O8FRxZpb6KieEDIeEzdgOD1909G3O1kpPzDUdf0c/ehx0dITv3/4u0cFsMwpfUvUtX5U
         14dAQP3IU7+aRmEHUPg793WCt4Q+LlAgTvuIwhjh/KSX1U3pYer8vIJU/d4ULxG0jqI4
         m0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409971; x=1691001971;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lG/oM6RF8tUaMRTSvL9IPLqSI9sC3DV6HbxUPjojG0=;
        b=iFDLLBwhY6KqY3oY0fUXTj0dhaSQKahcZQbcpsq6u5biXPSdt4wM4VEiah5uAW99Km
         7VZS+0zMLUHZRURIx670Tuequ5I/GO5U9aJxM0tZsY0L/eQtP3apC0vekwigWOdKIHaP
         CzW+4vx4WrwDtgixWNQYB4Nq3T2QZnzKAoIP0+ctdMgF9QpitBlq8H7ceHXbM4V/T7Cw
         T1KyFzSyRmj2M68b8Mw8lUIhV6tn1OmcuYm9ZD2/9a/gBGKwUJxaR+6V7AEdb2iiqY9c
         UbFhE/udhpsry6FZ2j/jPCVu+XbrAG9e+JmuM+DgmEjptWE0edpS5D11pugm0UfuUFtR
         y9Dw==
X-Gm-Message-State: AC+VfDwaTXZwMaTT9yptMYKwyEXRUwqHTxibetlZQHMXkvUooPtYvi6o
        PBr3WBGAHtqjfh9WAevXRd90uhnx884=
X-Google-Smtp-Source: ACHHUZ4Jr7UW1zi1N68mlfSTxDj5mQ0QOszmDmL3+kqPNL5BPztLzyKIuVB4JY13zKuhJB3ZWfCeTw==
X-Received: by 2002:a05:600c:3b09:b0:3fb:b075:8239 with SMTP id m9-20020a05600c3b0900b003fbb0758239mr14466054wms.4.1688409971015;
        Mon, 03 Jul 2023 11:46:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003fbc2c0addbsm11005744wmg.42.2023.07.03.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:10 -0700 (PDT)
Message-Id: <bd498f5b3267a1c61e436447a1d81f693c9abc9d.1688409958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
        <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:56 +0000
Subject: [PATCH v2 08/10] gitk: add keyboard bind for create branch command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jens Lidestrom <jens@lidestrom.se>,
        Jens Lidestrom <jens@lidestrom.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jens Lidestrom <jens@lidestrom.se>

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 351b88f10c0..f559e279b7a 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9582,13 +9582,13 @@ proc wrcomcan {} {
     unset wrcomtop
 }
 
-proc mkbranch {} {
-    global NS rowmenuid
+proc mkbranch {id} {
+    global NS
 
     set top .branchdialog
 
     set val(name) ""
-    set val(id) $rowmenuid
+    set val(id) $id
     set val(command) [list mkbrgo $top]
 
     set ui(title) [mc "Create branch"]
-- 
gitgitgadget

