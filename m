Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2978FCE7AF3
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 20:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjI2UdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjI2UdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 16:33:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F7D1AB
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 13:33:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40566f8a093so114588615e9.3
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696019583; x=1696624383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pys9+tEDxwEjgme2QQ0WrgcfztLuUcj+ia8Vlxq0hWc=;
        b=Euzpj1hCjc6MomPCumAcSK3z0YdQfns0T8Mx3hEw3oTtaJbpR8Tb/4KNr0T+3DWnId
         ZnSPJNhPbOBjzH1wAwgOhWoztOD0+gHIpjss626IkslSoaFx+awtIx0QstXct4YzXq4F
         L49rY8GMrn+l+nL5R6MlD3RA6nJrouDyqtACtLMtelfsc9AgVcto0j8XPfPLilm5enST
         /nesvkDbg+65a0ThPfWEWvRQdbSveq5IYzIzWEMNpo0dveiVgph8JYXOzPZUmniLWdGw
         m7b5sg3my7whYxwAkUmp851nPFhiCsGGl53NfXLzPWkWNNT6a3NnwhCwwBh3RmHiFvhL
         EKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696019583; x=1696624383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pys9+tEDxwEjgme2QQ0WrgcfztLuUcj+ia8Vlxq0hWc=;
        b=mHvnAT0VeKr5ctQ/wKzhscHzj7Am/K4FKZSGxA5t32zfFSisC1YjUGXb+gIqKht2gL
         ZIsh7jGiZFaWV7Y3wcyOC2jibAuXPbVqUxTJFPkZEcFJbWQngXfKWalUH7Hwd0OP8zrF
         kL5T7axbzDFzuMOlQvxlfNHfKV8BiZovKMNdhOvJaRVJIV7KirZUWbJ2FMs6Tb+fHCxd
         b0LQYsvybjH7W+hGLif6apIaUfZ/QNmNoy2LwPbhtD3vMl+qTxLuvThIyRH0wgJCmr/F
         YKYw8RAbjuwoDhBB8gk4U1p0s7BljvaH4gs8PSHbRf1D0dFQLovIfQ2BFULn9NlZxJp2
         kELw==
X-Gm-Message-State: AOJu0Yy+TluemR7H5K8NP9uAZ0WGKuQPS0HidRagiyff5QCVvukJVzgJ
        zdiiKhlLMTrvpU0wHGav278vtz2mKLs=
X-Google-Smtp-Source: AGHT+IHp4hbiCcuAtkxD4OW/jaL/p00iPb/TNKCChCuyLzs8sRJz0Mryv9keU2H3C7ZZWP+gDF/i+Q==
X-Received: by 2002:a1c:f709:0:b0:3fe:1cac:37d5 with SMTP id v9-20020a1cf709000000b003fe1cac37d5mr4750092wmh.4.1696019583205;
        Fri, 29 Sep 2023 13:33:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c2a5000b003fe23b10fdfsm2124206wme.36.2023.09.29.13.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:33:02 -0700 (PDT)
Message-ID: <d6811daf7cf7f1460877307575e4cbc363ae851a.1696019580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
References: <pull.1587.v2.git.1695399920.gitgitgadget@gmail.com>
        <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
From:   "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Sep 2023 20:32:59 +0000
Subject: [PATCH v3 2/3] subtree: changing location of commit ignore processing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Zach FettersMoore <zach.fetters@apollographql.com>,
        Zach FettersMoore <zach.fetters@apollographql.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Zach FettersMoore <zach.fetters@apollographql.com>

Based on feedback from original commit:

-Updated the location of check whether a commit should
be ignored during split processing

-Updated code to better fit coding guidelines

Signed-off-by: Zach FettersMoore <zach.fetters@apollographql.com>
---
 contrib/subtree/git-subtree.sh | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index e9250dfb019..e69991a9d80 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -778,11 +778,13 @@ ensure_valid_ref_format () {
 		die "fatal: '$1' does not look like a ref"
 }
 
-# Usage: check if a commit from another subtree should be ignored from processing for splits
-should_ignore_subtree_commit () {
-  if [ "$(git log -1 --grep="git-subtree-dir:" $1)" ]
+# Usage: check if a commit from another subtree should be
+# ignored from processing for splits
+should_ignore_subtree_split_commit () {
+  if test -n "$(git log -1 --grep="git-subtree-dir:" $1)"
   then
-    if [[ -z "$(git log -1 --grep="git-subtree-mainline:" $1)" && -z "$(git log -1 --grep="git-subtree-dir: $dir$" $1)" ]]
+    if test -z "$(git log -1 --grep="git-subtree-mainline:" $1)" &&
+			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" $1)"
     then
       return 0
     fi
@@ -796,11 +798,6 @@ process_split_commit () {
 	local rev="$1"
 	local parents="$2"
 
-    if should_ignore_subtree_commit $rev
-    then
-	    return
-    fi
-
 	if test $indent -eq 0
 	then
 		revcount=$(($revcount + 1))
@@ -980,7 +977,20 @@ cmd_split () {
 	eval "$grl" |
 	while read rev parents
 	do
-		process_split_commit "$rev" "$parents"
+		if should_ignore_subtree_split_commit "$rev"
+		then
+			continue
+		fi
+		parsedParents=''
+		for parent in $parents
+		do
+			should_ignore_subtree_split_commit "$parent"
+			if test $? -eq 1
+			then
+				parsedParents+="$parent "
+			fi
+		done
+		process_split_commit "$rev" "$parsedParents"
 	done || exit $?
 
 	latest_new=$(cache_get latest_new) || exit $?
-- 
gitgitgadget

