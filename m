Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29FB224893
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748882448; cv=none; b=NW1PILJbyBuLRFBDnRB8KYJLI565JzmeAwxXEckex1aJdALw44WCDjH8twq6wj/vQdna5jx72OYPV7/Km5TPyUF7vofu9wYcWVXveIrhr1qsO3W0ghs2jNCDvXBD+rAfinWYim7Lo7bxDB1Xrw4z+le25KKMvPvdGWXDEMxIw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748882448; c=relaxed/simple;
	bh=FRzAyYyHxWcUJDlVoUAN7bqfNbMiit1wsKPmBwtpwUc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U352C0BKvDYjSO9atbN/lR6vHNUqW6nu3Go0alZqv7ZEXly35NSTXTr7t539mM29g7FpICPNqRMJ3KzwLbYoif1x51+YBtLGooUI+0Y/QfJ71HDtYOMR5GW4sQq8CyrkJME8aEfauPQ14VL3EX9OJrQADFVicERoelVXbJUL16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krpikBsz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krpikBsz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d54214adso14361315e9.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748882444; x=1749487244; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doaMwdS9ps9GXuXN08Qs4xiyLo/pluRDQJkZij4kstY=;
        b=krpikBszzLY2CovqhTwIdpOvgMWuNK8HCPI0bLyeamOE16SNkO5VkjTow4C7VR+3tv
         MHaUxtxLM3W4TYU4W1u70kMUpgQClYPcwRwbYr0o+f6s1PfTTp/58kfw67Nz98FcfOy8
         DuYt1qlJabXDzaFcWWjvDdV/jsb1B8owo1LwWHE8K6WDLVCMg44+6TZ3Fn4NJjjZYSJv
         vBelcg3O1BA+y9eYJRn5uuXlfr8JEpWLfl5TztpbzuJ3ns3kugNkp9qTwGqvAAqjVR9m
         BQ/xOlR2wYbamK+5Td1DHKyLxoWF2ulbxslRZWomjppyomOqTW/uxTAWxsPn1mmLDAjs
         fPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748882444; x=1749487244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doaMwdS9ps9GXuXN08Qs4xiyLo/pluRDQJkZij4kstY=;
        b=aTN9FQaEVi3aS2UwPsg77+qGlZhE+gzJ7LcLwFGWIjXJ1rRN0U2Q6Dp5QVZUB8DzxX
         xHLiM0QUPHJY/LKS99v8+dBiFnQY2jdkUs0G2abVMQ5gOPoqUdhMDWQwrlGz5M6dUp5Q
         qUErK7sn+phTofZpUB71Jc7C9oP8MN9wCWmrpPyxjJqjzZJe/LYde4uj+lKLWBI9XHkT
         DRE+46QME05cHAitSbnw4gvRQfgwVLMCJl2S01MaRK6HhimtTIbIs80L/0S+EaHSgoO9
         OR/J/CNK4BaQXM83LfMZx2+PNS8vD8tBSdgcqOKOw0efmXx/qEjdySzeyCyoOeqNH9xI
         HRRQ==
X-Gm-Message-State: AOJu0YxRIz0Xb8iFGVgZma8Cmbo4KXqIKRA+kVfIZljyfm4NFxS+ZSJG
	d83YRPdhEXfjCpOzKKBXvb/sqvrlyemmVpeijPlHpU+2/yNP4CovBK7NboriRA==
X-Gm-Gg: ASbGncuITeFq96ZH5ucM9LIU40XNL//So8tClRayckFANAs7ev6mbbEqfn1WR0HMg5J
	v4wMia/poyLWkf4s8UyLyeoJSSuiaLzUFbk8zS5KqZ70CKnxDjPDidAHyZsuyazLZwloupXlnXu
	epU2jsswhFH6D1IptAdui61IWwnFaUKmTR9JfY7dUPyZ/x8ciq4KqdEyZMeDpA4688GZt9kJ7FK
	EYTNCO4DCTVNAsF36mDWGMoPZ6PLDKwC0u60vO67wg2qAGbYCNSafhJZ6ptvNyWAxtEQW6+VXDw
	FsPynbBMn3B+c7+Aa92QbrAmoycb8WsHpxElVkJAyDQctp916CiCyuvCZGGXrLQ=
X-Google-Smtp-Source: AGHT+IH3a0PxmTGVmS/9l0hPIiOhDpz2USHVj/MDsz7kNydqEBPzL2aDIb6qqGz7y7Rn9MRhuO1L4w==
X-Received: by 2002:a5d:64ed:0:b0:3a3:652d:1638 with SMTP id ffacd0b85a97d-3a4f7aaf3b1mr10936469f8f.48.1748882443800;
        Mon, 02 Jun 2025 09:40:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74072sm15818355f8f.52.2025.06.02.09.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 09:40:43 -0700 (PDT)
Message-Id: <fe7e918ba1831fffead46791441da350223998f7.1748882439.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
References: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
From: "Patrik Weiskircher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Jun 2025 16:40:38 +0000
Subject: [PATCH 1/2] contrib/subtree: parse using --stuck-long
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: apenwarr@gmail.com,
    Junio C Hamano <gitster@pobox.com>,
    Patrik Weiskircher <patrik@pspdfkit.com>,
    Patrik Weiskircher <patrik@pspdfkit.com>

From: Patrik Weiskircher <patrik@pspdfkit.com>

-S/--gpg-sign requires an optional parameter. Optional parameter
handling only works unambiguous with git rev-parse --parseopt when using
the --stuck-long option.

Signed-off-by: Patrik Weiskircher <patrik@pspdfkit.com>
---
 contrib/subtree/git-subtree.sh | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 15ae86db1b27..60b2431b8bba 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -115,7 +115,7 @@ main () {
 	then
 		set -- -h
 	fi
-	set_args="$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
+	set_args="$(echo "$OPTS_SPEC" | git rev-parse --parseopt --stuck-long -- "$@" || echo exit $?)"
 	eval "$set_args"
 	. git-sh-setup
 	require_work_tree
@@ -131,9 +131,6 @@ main () {
 		opt="$1"
 		shift
 		case "$opt" in
-			--annotate|-b|-P|-m|--onto)
-				shift
-				;;
 			--rejoin)
 				arg_split_rejoin=1
 				;;
@@ -177,42 +174,37 @@ main () {
 		shift
 
 		case "$opt" in
-		-q)
+		--quiet)
 			arg_quiet=1
 			;;
-		-d)
+		--debug)
 			arg_debug=1
 			;;
-		--annotate)
+		--annotate=*)
 			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
-			arg_split_annotate="$1"
-			shift
+			arg_split_annotate="${opt#*=}"
 			;;
 		--no-annotate)
 			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
 			arg_split_annotate=
 			;;
-		-b)
+		--branch=*)
 			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
-			arg_split_branch="$1"
-			shift
+			arg_split_branch="${opt#*=}"
 			;;
-		-P)
-			arg_prefix="${1%/}"
-			shift
+		--prefix=*)
+			arg_prefix="${opt#*=}"
 			;;
-		-m)
+		--message=*)
 			test -n "$allow_addmerge" || die_incompatible_opt "$opt" "$arg_command"
-			arg_addmerge_message="$1"
-			shift
+			arg_addmerge_message="${opt#*=}"
 			;;
 		--no-prefix)
 			arg_prefix=
 			;;
-		--onto)
+		--onto=*)
 			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
-			arg_split_onto="$1"
-			shift
+			arg_split_onto="${opt#*=}"
 			;;
 		--no-onto)
 			test -n "$allow_split" || die_incompatible_opt "$opt" "$arg_command"
-- 
gitgitgadget

