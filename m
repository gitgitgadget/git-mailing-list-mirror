Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B593A961B
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769254; cv=none; b=DiLkWJ76xDdOqOvBSGkpVsSEDkmj8eisp4/5vNq5JV8Z1ApVA9KxUHWyw//ipfjszYathlOCws2M8mFErWiheqxtBTTtipUh2QNXLtMITX0iZD/I2XWyRfm40olcvt8HNr0MsH2FWRSpmU96XQ+ZLpciUVOW0hWfDRSFqYIEolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769254; c=relaxed/simple;
	bh=xS96SyIDx5+DPkP//6vAdAW1BUEACAf3SH82txf3dio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjsuYf4VKWRiuheeyY0NISbdPJGZgACZIgeIq4G4vq8Y5TuqBT1YCvNtax6haoX7zrf1/2OE6sghz6Pv/+HiAel0k+X4R8BXnA1BdUC+VpcxwtrH2k2aynkqCqjtFajx5W62YSBHwVsy0EYFYkNyUCAPYoz1XPwZrxNP5JQ1yeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hayDTN1h; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hayDTN1h"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-911449d9d03so58255685a.1
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769252; x=1779374052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0upG+myYY3ixMWMw2SzjQOIKZ5l9irEPyTcBh2aLbho=;
        b=hayDTN1h89Gnm999D9mXptnSVbUqSVDyXYsjxMhz62XKe4IWG8SbY9DmhNarfsQcXc
         T/vhRs7iesTfTrExro0rLys2Ufuu6bMrxnooqNYzcaydzIv7xUBhCQ9E98WfJp3DL6pu
         257kSDUHY64JTqlraoHXcmX5GKx8ryU8tW21Cqt73ZpUkErFxcQwbJDJn2ghT+ze7F3S
         v0kdpyqdhnPRGM9Cn+j2m/p6KnwBDTK5kt4K+AKHbMciw3UeAYI6IcJHej6dqvlKQoJ1
         eVKo54Ln81+fF3T03qRCrLB0TqEC6CklESl/yDpAqKtGBM0QODtyoLNjPsooiqXMgvE7
         xfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769252; x=1779374052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0upG+myYY3ixMWMw2SzjQOIKZ5l9irEPyTcBh2aLbho=;
        b=sQm6aM6ge2XMdILibOOg1KpUaDiVjdylPAjoWqK9Ss17V5bLYw2Efte2rC43NSravH
         ZDgylQcJAoxFVhXg857s1F0CEcXYo7w9jr0cQinYMar2xoN20iyxOmzYTwFG41wR4RiU
         DiRqdgQPSZayZCbOQlgXnPMO3NxkVZ2u6mHcgxHiz5dbKCHtlzbyaMdK27tMWX7T0gRj
         GW8eXgQztmkhg57yvT0iYHD4ktoSbmqCgxocqXTUCvgenTmAn9Wz0/uMrTnKsMSq4e3j
         32/37EwkQL0h74198lPcC9WTNyT3e0/Rl4pKcVQZbqfvaUjFDaA88aFPLQEoii2x92o2
         e42g==
X-Gm-Message-State: AOJu0YzbW8oXDK5H97LASXf2EqKknUK1+cW3FZ0Zdxj1YGqFbjEe1YHN
	y3aXfD4chtMb3V2pzcNRPf3d+PKyOt03ZP5E9LYECHoTZv4BR/xnUuLcp3q1Iro5
X-Gm-Gg: Acq92OElhdD6AIUOSVvZzeoYRtNk+WYW4IfGqD6DZqHT2WMfnh88tj2aIo8/zKeADrT
	E8GFmcvVeyzUxM1BygVPaKO+3j2jbQ2a3L25SAaA3Mk6ixETABC3f5/78N3YgpufRD5BgbuoA7M
	XMPU7T3zNKb1C9jTIhl+1ZLPbpFc/eKx74TJUNiABotBMBL2NeweDCNKk3EUsPBL2LR3X02Esdt
	SKuRzNAXRwTTOR46i43OZvRg9M1VPMM0Vm9kc2b1sYiVF4wXzPpV/WPGxtgXoHqrSPvtS/BaMfN
	QCZv3gNM6qG7DmM5nHfMpaQH4M4x9kh9GCXAq1oKd8uWwV3Syz3MjbHLr9HET4YJRHwE1GPRGZJ
	6TrgNiuuLd+8AoSjx7+C3GAPfrka9cfFP1wPraOShFJcPYtyPH7bNgZE4EWwdECk9VbGTk1P8cp
	6ZH93ifIc=
X-Received: by 2002:a05:620a:4712:b0:8fc:5ae9:7743 with SMTP id af79cd13be357-90fad964bdfmr1139604185a.43.1778769251342;
        Thu, 14 May 2026 07:34:11 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:11 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 10/11] git-gui: improve worktree discovery
Date: Thu, 14 May 2026 10:33:21 -0400
Message-ID: <20260514143322.865587-11-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git gui's worktree discovery needs update based upon prior work in this
series. In the normal case, all information we need comes directly from
git rev-parse (--show-toplevel, and --show-prefix). Should this work, we
have a valid worktree and all git gui commands can run.

If not, we need to consider:
- if GIT_DIR or GIT_WORK_TREE are in the environment, just stop as we
  the input configuration was wrong, the user must fix that.
- if we have a browser or blame subcommand, no worktree is needed so
  git-gui can run without.
- using the git repository's parent is a valid worktree (if possible),
  restoring prior behavior.

The current directory should be either the root of the worktree, if one
is found, or the top-level of the git repository.

Make it so. Also, make worktree discover directly follow repository
discovery, reducing the locations that might need error trapping to
catch configuration issues.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 56 ++++++++++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index e326401..3a83dd5 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1173,6 +1173,28 @@ if {[catch {
 	}
 }
 
+# find worktree, continue without if not required
+if {[catch {
+	set _gitworktree [git rev-parse --show-toplevel]
+	set _prefix [git rev-parse --show-prefix]
+	cd $_gitworktree
+} err]} {
+	if {[is_gitvars_error $err]} {
+		exit 1
+	}
+	set _gitworktree {}
+	set _prefix {}
+	if {[is_enabled bare]} {
+		cd $_gitdir
+	} elseif {![is_parent_worktree]} {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" $_gitdir]
+		exit 1
+	}
+}
+
+# repository and worktree config are complete, export them
+set_gitdir_vars
 
 # Use object format as hash algorithm (either "sha1" or "sha256")
 set hashalgorithm [git rev-parse --show-object-format]
@@ -1189,37 +1211,8 @@ if {$hashalgorithm eq "sha1"} {
 load_config 0
 apply_config
 
-set _gitworktree [git rev-parse --show-toplevel]
 
-if {$_prefix ne {}} {
-	if {$_gitworktree eq {}} {
-		regsub -all {[^/]+/} $_prefix ../ cdup
-	} else {
-		set cdup $_gitworktree
-	}
-	if {[catch {cd $cdup} err]} {
-		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot move to top of working directory:"] "\n\n$err"]
-		exit 1
-	}
-	set _gitworktree [pwd]
-	unset cdup
-} elseif {![is_enabled bare]} {
-	if {[is_bare]} {
-		catch {wm withdraw .}
-		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
-		exit 1
-	}
-	if {$_gitworktree eq {}} {
-		set _gitworktree [file dirname $_gitdir]
-	}
-	if {[catch {cd $_gitworktree} err]} {
-		catch {wm withdraw .}
-		error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
-		exit 1
-	}
-	set _gitworktree [pwd]
-}
+# Derive a human-readable repository name
 set _reponame [file split [file normalize $_gitdir]]
 if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end-1]
@@ -1227,9 +1220,6 @@ if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end]
 }
 
-# Export the final paths
-set_gitdir_vars
-
 ######################################################################
 ##
 ## global init
-- 
2.54.0.99.14

