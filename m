Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25F28ECEF
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046603; cv=none; b=bIq9CjL0EdtrLJhJ+Sclr7YdBkkdu1fvcqn4DOYMUmFEy0YBzB4Dpi15ySnq3Hm7igU/n+AHcuMmFKM72VmnRNbLYRv1WzHK4WCInnXcFwD3t02cuy8013y3pdjTcRPAa3QcU/ijxgioGAaTfsTBfFU7OnuWYa8rPBI5YUhbb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046603; c=relaxed/simple;
	bh=UXZ211eheO+OU9BCBHBZu0XXqeJ7JVstxhAGzQCqRjE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=paOUzcampynDLHnCWk6Y400t7D8rUv0LSegvG/RIEC2OZ7+T1cPZ2gVPw5S0u7q50oUWG98XgQkaDo0OifaFX/C2UhqH6kcGo87UdJNmkWp1LIIeQy6ySARY2lcyaYxlaqrfE1uO4/LvwAM/ijA5mHSrXM5U1iYZaeD6ujVXj7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt9qFosE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt9qFosE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450caff6336so42958235e9.3
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749046600; x=1749651400; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iud66qTqLBLoEK7R9QnmAgADbsnjm4G3vTYz/z/Rdg8=;
        b=Kt9qFosEtftysUv8ZcUVBpND/T61WFtakOBR9sVzeVkrWh9SbOOfmzR/P1gjvmIOiz
         TKsjuhx2VxhiqT5nIOEZQ3GlbBhoE86zPQZ6Vd1URj/reYrzTJRutqZnqJ42gAhGC0X8
         VlR3l+i366Q2ZWpUmxSeBM+G7gOLmurzV8skoYIBEoSwpWXw7c6A5vfzBS2SzIwbM0jq
         wsuEHhlr/k2Qxc7R09tJZXsqojTLyijj8qFX4txEB7pripLTdLl9SjKetUUK+kNaCRtZ
         D3auaYPJzA3HNGp/b4QTKQIyE0wAuwa8jICJfv/ZbJ4qkdHWvkGqqSXbFiC1PgUWcNJT
         6a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749046600; x=1749651400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iud66qTqLBLoEK7R9QnmAgADbsnjm4G3vTYz/z/Rdg8=;
        b=OJtJCFtstt9cTB1KDhyoncThpS4rdS9au93mZo4AEZ0zWGmO8rBUWQrz5uF9OZSA48
         kCh/WJJfrf0pJKzPPF5Eyy55hzoWWA1AfiZbp8qGfajOQVZeFP6AfVbuNZUD7oCv5b1y
         yi5IfmqR9IE4AvvLyNj1/0m9gjr4sAZpRkDoQNCeSTcCRRExrTA4AO4RXAd+DEokwkAc
         +S1MszlpXCKzoQYS3zTWX1h65XrXY2K7zzxvES7tchRV/F36Z9CDpgJZdq3X3R8G2+ck
         YD1FyimBskI20F/zBoDe7aOKf3ghGpg+EkQoZawhboRWMKJ56yBaYOQMplbiawI7BxqA
         RjwQ==
X-Gm-Message-State: AOJu0Yz4t52u5HzmOqGXMxXS7bJgk64nyKv+SAdgsu+QqFlLLWZDmLHT
	iMr5Yx2WbLJ6cQIdrP/H652DlKRqiZi98sFQt8ibY+6QnPqEXPZQ1jUCOeGRTA==
X-Gm-Gg: ASbGnctO5ddunHkCu/xE2Nv4apcjf8Yjzv+y3ZbGyM6Qp+wxRsFxPUincX6YhZ67yNb
	x0WZvnJ7af2NqaBbUxx1od6mr5lkIsrKZdq0cuenOCmWjvdBUgmxC7LmNcugb9d6rKZDSRaa/Zt
	wC5iD45gOnX+egULNiOFS6UTGiXcGHp4MY/bPnPzdlYQyHRWdL2HY6Y5Cgun/eHwUrSJ5go23Rw
	DEhDIE0VrVsUf2fnvCU+3cXHaHAtSZOFNcSjvyGNOotNG61EtSk8mzWaTj4rSs3fkbWoTXHcqyZ
	PsqQWU6hcFuizOYQQHBCzSJ0YpH1vNULdreY7qGPd/J3NxrmpxKidsoLQpo5IjU=
X-Google-Smtp-Source: AGHT+IH66hQ+VK4U6psI/fuaYAMPBHtF1kJmBgG6yzXm+XlKq2jHT+9NNRUoRn7x9zGTGOsyPF7Tdg==
X-Received: by 2002:a05:6000:250f:b0:3a4:eed9:754d with SMTP id ffacd0b85a97d-3a51d8f6aadmr2558291f8f.6.1749046599340;
        Wed, 04 Jun 2025 07:16:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b8b3sm21868308f8f.20.2025.06.04.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 07:16:39 -0700 (PDT)
Message-Id: <5bbdbf01636058b945ec7f40df6f2a8cb4cdc966.1749046597.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1928.v2.git.1749046597.gitgitgadget@gmail.com>
References: <pull.1928.git.1748882439.gitgitgadget@gmail.com>
	<pull.1928.v2.git.1749046597.gitgitgadget@gmail.com>
From: "Patrik Weiskircher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 14:16:36 +0000
Subject: [PATCH v2 1/2] contrib/subtree: parse using --stuck-long
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrik Weiskircher <patrik.weiskircher@nutrient.io>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrik Weiskircher <patrik@pspdfkit.com>,
    Patrik Weiskircher <patrik@pspdfkit.com>

From: Patrik Weiskircher <patrik@pspdfkit.com>

Optional parameter handling only works unambiguous with git rev-parse
--parseopt when using the --stuck-long option. To prepare for future commits
which add flags with optional parameters, parse with --stuck-long.

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

