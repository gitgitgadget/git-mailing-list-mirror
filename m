Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318632D94BA
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479019; cv=none; b=k2ZMuAgwXDr7ifq34L2tZZSLFP4asb92mTsH8F+PvSyYm+hfWpdVXRBEhUjzgQ3TGPp/8Hs3CE0lL26g/I8TqysEE5666V/rmjJkE3SXlC3eM7Lxsb6mtSwZH5SwXu2lEseXTcLl6ctYqw+sygxSZ6cT7b8FsDKtvA38YBXym0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479019; c=relaxed/simple;
	bh=WcYOAWLimTch2o+iKy1LWDp/wbmQCi2rISSk+1RIIrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h627Gmey8vSTdap/nJokncOvVtlOnkg+RgaCphra19hzis8tmAn/rKq5MFcG5Gs6nabbuyzkImRn8ba6Pz4ddIH68jS3bRqE4to1Yn+IwOg53XKY2OWNeA2RuLzTpmQ0PdwV7X/I+d1sRMG+1lXPOeXeWg1NAFMMsT6Lrjh9KDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRE89vXA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRE89vXA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81f46b5e2ccso483907b3a.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768479017; x=1769083817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3/EKVJaBy+LnEyJGxuAv62Qdll9yu5f0Pj8i1GNmOg=;
        b=QRE89vXA1fEOCYj/xOEIFSpWTkfpwq74FobkuuBs4HljR0vFO9ZGjlAzTVfywS0N5R
         OC3wpWmRacPXI/EGoNyWXtscPEAzJOmd3AL2VG9jbaeNx5BnS9azwee9dWG0JyoHxu6R
         PvP/uUtMUAe7BVm2hC+wBc+sOEp+mjNNVICPBcprVxIkWNKK0oh2MZGy7QBYnqJXllt3
         BPwkM3sZkg0HeYFQxUzfCnlULIje6N1TEkV9DZr0dkO/4MSZKVPq/HSV4qrvttuG9xv1
         H9p7cOJ603oyJRJ8Y/FJs4MtTg9VoihWsHrEod7DR1CWTmLCVP8OtoYtbHKsioqyYPqH
         8+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479017; x=1769083817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3/EKVJaBy+LnEyJGxuAv62Qdll9yu5f0Pj8i1GNmOg=;
        b=HVhoUJreq8yCW8tGdYTEc7eJIzQnPfP7D9hVOIGoFW9pls5eUiSxOXM2ZQXJNsGZLS
         VojkjxSzedz5Xtog287sr8DuNxPo9YjChGOZ/naHmNl16GYn1d9xRsnKzzUyEB0whzDb
         FqwJlzI1K30bAmHuX/j/xxRHEAwhqzKZYKcpFbZSfa2skBiZwHz0s74MwDDz7kkKbcuU
         p48fqsx/KVhUasSRwadMDT1aK7JOOtvOrVbFwxQSqwedacQptYmK/LlVowWKTJ+vQAo2
         V0VIjpvsDNJP9+bl75K2Ny1Dvb+PM2dKMHAwfm8x2R6YkZeqnO07m5DSAvzLoD6mhbIq
         GHtw==
X-Gm-Message-State: AOJu0Yw67HpYYMBxZQ0GZSbfUV2EHBd+2XPz0H60rU3EJiO8ufvIaB8/
	uDUmDSdu/pm+E5XGM6OkPFrAXXbjAedmDjoNnRYNg0vE3kphBb0DMYP2abdnrw==
X-Gm-Gg: AY/fxX7pCxk7n+Bp1q/noT8BX/qPOLG6MTdgTlEfwr3h5m++whf1cwYBrfG8hlS97gg
	bHdUZvn+jAWMUugne0tRMBKjSZdIe+rMP3gcjZsNFfiJnN3EB+HJ7CIRuwXICdkd21YCqcPKpwR
	YF9798jYmxj8npkZ4TMXq7D+VzcVOxNxU10in/6RbUMU6dK+QamFP1VRVT3Gjis4S/h81GxajUT
	ntuQjQyIrb8e/bFHL1sHYA2Cai0m7wCRbV90cZRWZ4WR47ZGAMarfzNIdzw3cltseSFqeA6lFWU
	H11FZ0MudJhRYCg/E2vO3S/y7cuciom25bRXvNR3Zdm2JFEDVXpMJFFt8gXeZobDfxhylYCsxFy
	HxE3w681EeBsFm887jOfTar8DYv7i96j75pweI+/2zxFpHk3oL50NmTXRRTZGTXjd3J3/7zSYTv
	AU+EvNzpQQuP6e7VUa12z8vmN5CzdIGk30
X-Received: by 2002:a05:6a21:3397:b0:38d:f8e6:fc9c with SMTP id adf61e73a8af0-38df8e71f84mr625900637.69.1768479017209;
        Thu, 15 Jan 2026 04:10:17 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm24832551a12.32.2026.01.15.04.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:10:16 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] subtree: validate --prefix against commit in split
Date: Thu, 15 Jan 2026 12:09:36 +0000
Message-ID: <20260115120936.18491-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 contrib/subtree/git-subtree.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 17106d1a72..a1b60eac8b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -257,6 +257,9 @@ main () {
 		test -e "$arg_prefix" &&
 			die "fatal: prefix '$arg_prefix' already exists."
 		;;
+	split)
+        # checked later against the commit, not the working tree
+        ;;
 	*)
 		test -e "$arg_prefix" ||
 			die "fatal: '$arg_prefix' does not exist; use 'git subtree add'"
@@ -958,13 +961,19 @@ cmd_add_commit () {
 cmd_split () {
 	if test $# -eq 0
 	then
-		rev=$(git rev-parse HEAD)
+			rev=$(git rev-parse HEAD)
 	elif test $# -eq 1 || test $# -eq 2
 	then
-		rev=$(git rev-parse -q --verify "$1^{commit}") ||
-			die "fatal: '$1' does not refer to a commit"
+			rev=$(git rev-parse -q --verify "$1^{commit}") ||
+					die "fatal: '$1' does not refer to a commit"
 	else
-		die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"
+			die "fatal: you must provide exactly one revision, and optionally a repository.  Got: '$*'"
+	fi
+
+	# Now validate prefix against the commit, not the working tree
+	if ! git ls-tree -d "$rev" -- "$dir" >/dev/null
+	then
+			die "fatal: '$dir' does not exist in commit $rev"
 	fi
 	repository=""
 	if test "$#" = 2
-- 
2.43.0

