Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BAB3009E2
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268587; cv=none; b=JhkL2X7Ahy5t5aOvFm6fq3Fw16HHfD7jLg/ruIElgqd3TSrhnjtHdADnhCVRiVtUNCW1YrIovh7zug3lCypI6DQgcerkaxXNm/pDqCFqoiMDzRG00kMjJLpCvH2eTqhl8HnVIwlgzvG4wbvdtoPFHtGLw7h/pGln1y5tdjb/X4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268587; c=relaxed/simple;
	bh=w9EAEGjmeSW09/QDdfZ/OZ+rVrW64P7/zVU8jfSHkLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+7jSoxvF6Xg+udHy4NkROwFuyPVueVWz/HmimpB8x+X2ORypwvBDvpIWkERn340l0Eo526Ywby8+HAoY/zFcgyIycq/bt4kw33UIrY1BnnyHvR4rVJ1cWKTPrZC0JDGDPXL2QpzB7geTV/KWxpqK6s6XET1Rug4uG0WVQMQ34A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+AgstnD; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+AgstnD"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ccf7b7d188so16442446d6.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268585; x=1780873385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMZHpf5Qty8J8cEwAeyWEVCzT8qGpLFf7NpC0c52sxA=;
        b=e+AgstnDkeJUTDIuXY8C40SFfxtrTb5cqu6tAMf6prj5V980Jo6r3KaSidzroL1Oib
         fqqpjSAn9OcT1tZQVMX0NaOoxO55V4xQwCtAalxSn93MBHVS5r8oydGacbrY+O4l1bA8
         I8Wt+c09MRaUjct/KeA/nai0+237BpbruD+0dIYYZMt3AyYKu6k5N+F/Y6EDedg/EQN9
         yHYazyRaTfQpp8gxlbYkGh3c7E/Xryp8yUOwjFmALP9udGdrangBZ5x7/kdb0gsKnyYY
         rky/LENGsImzFiuanEl8LejWnE2ReH1QsSG4ygZwtD8CnFjbm+PfqkwQ++trlvVi5BTc
         6OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268585; x=1780873385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMZHpf5Qty8J8cEwAeyWEVCzT8qGpLFf7NpC0c52sxA=;
        b=Fme5eYPzb4YfSit0yCLfXn0rU/YNj757I59m9Hx2/7NN1h8I6h7yAYTlUtJYNXJgpx
         awG/mMOYyYYjr6PMUQeITcwqawuPJxQsvP3YOe0e0Pyr/TnPWX42IYBS6eGkrj1zacsg
         yCCirCJvIm8U6UV+7GuGiUTHMaZW2l3jxY5tZaPCMLMvcXQmUFoFnNNXg2SlwwCjG9Ng
         dqvY6XKXNN0G0m8eYIaniIJOq0eYHNKWL5ohZ60oTcAfYJT9NLXCsGfZ1l4IVNwUAcnC
         M68/eAPviEo3yy4CpO5IaF7w5ADm5TM55IVsFQXrPf+BhD3IuozTjaiiXIcueQtOqVRn
         AUTQ==
X-Gm-Message-State: AOJu0YyYA2G8apQFbkM2y1ViNb6bNfvMCROMdN4l7m+KjzKg2GlvSgym
	MGtH2+pEBOhNUtwesuRoxgdAkflUgb452T7FTcHyu/7zqAoP419JFqCIiRBoBImW
X-Gm-Gg: Acq92OGDqTv22Ko90no+w9j3OAV+1F+IitxHD6Jt2giOfNKNYx8ZQ9a82oukm3KipBA
	y10s99N6pOM6SqRYwvSu/LwzGEjb5H1acx4RkEg38hT5oEN+3SRS9vhOX99TG+YBMDfxEx209Kp
	YnFPaPTjyhTFQD62jJeGV+zsw1qtikP9IeH161hi8CX/un/saIxzBkZWw0w3u1FsjFHQftQg/9g
	dpvgSiexGyb578tlFO6RINbkWlAFsany6FZTg6SnsiJnUgUaKdh4r6yAnXW0Ch3iQg6Cf+M+Xzk
	vOYTvHb+/wETdzDax9s/FJt2p84Gnle5LWE0mGrB6sE5u5FjTR489eXXxd2vn5ak/5VLlS57t36
	AdHgTWq/FdO6kAkh3zmUQcJTCsNU/owyI9SQZu4ultdE+2mmCmkTZLDSz+UUv2jyWQMizCDcC2n
	mq8yIZLGdlPzCP8gNps2RKko0PEt8vPCuT7QgQ
X-Received: by 2002:a05:6214:4499:b0:89f:2fa:a9bb with SMTP id 6a1803df08f44-8ccefb1e6e3mr158836056d6.9.1780268584950;
        Sun, 31 May 2026 16:03:04 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:04 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 06/12] git-gui: use rev-parse exclusively to find a repository
Date: Sun, 31 May 2026 19:02:19 -0400
Message-ID: <20260531230225.126817-7-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260531230225.126817-1-mlevedahl@gmail.com>
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui attempts to use env(GIT_DIR) directly as the git repository,
accepting GIT_DIR if it is a directory. Only if that fails is git
rev-parse used to discover the repository.  But, this avoids all of
git-core's validity checking on a repository, thus possibly deferring an
error to a later step, possibly unexpected. Repository validation should
be part of initial setup so that later processing does not need error
trapping for configuration errors.

Let's just invoke rev-parse so all error checking is done.

While here, let's cleanup the error handling.

Stop if an error occurs and the user set GIT_DIR or GIT_WORK_TREE.
Use of either or both of those variables is supported by git, but their
use also means the user has taken responsibility that they are correct,
so a failure is something the user must address.

Otherwise on error, continue the existing behavior and show the
repository picker. But, let's move the possible invocation of
repository_chooser::pick to a separate code block. This permits adding
separate conditions on using pick independent of repository discovery, and
will be exploited later in the series.  Note that the picker always
returns with the current directory in the root of a worktree with the
git repository is in the .git subdirectory.  The variable "picked" is
used by git-gui to automatically execute the "Explore Working Copy" menu
item after the repository picker is run.  This is controlled by config
variable gui.autoexplore, and happens after all discovery is complete.

Remove a later check on whether _gitdir is a directory: that code
cannot be reached without rev-parse already validating the repository.

_prefix is set as part of worktree discovery, but must be {} if not
running with a worktree. Initialze this as {} along with other global
variables, this is the correct value is no worktree is found.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 49 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8a5f0bd938..aed3bc7200 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -374,6 +374,7 @@ set _gitdir {}
 set _gitworktree {}
 set _isbare {}
 set _githtmldir {}
+set _prefix {}
 set _reponame {}
 set _shellpath {@@SHELL_PATH@@}
 
@@ -1125,6 +1126,24 @@ unset argv0dir
 ##
 ## repository setup
 
+proc is_gitvars_error {err} {
+	set havevars 0
+	set GIT_DIR {}
+	set GIT_WORK_TREE {}
+	catch {set GIT_DIR $::env(GIT_DIR); set havevars 1}
+	catch {set GIT_WORK_TREE $::env(GIT_WORK_TREE); set havevars 1}
+
+	if {$havevars} {
+		catch {wm withdraw .}
+		error_popup [strcat [mc "Invalid configuration:"] \
+		   "\n" "GIT_DIR: " $GIT_DIR \
+		   "\n" "GIT_WORK_TREE: " $GIT_WORK_TREE \
+			"\n\n$err"]
+		return 1
+	}
+	return 0
+}
+
 proc set_gitdir_vars {} {
 	global _gitdir _gitworktree env
 	set env(GIT_DIR) $_gitdir
@@ -1139,16 +1158,22 @@ proc unset_gitdir_vars {} {
 	catch {unset env(GIT_WORK_TREE)}
 }
 
+# find repository
+set _gitdir {}
+if {$_gitdir eq {}} {
+	if {[catch {
+			set _gitdir [git rev-parse --absolute-git-dir]
+		} err]} {
+		if {[is_gitvars_error $err]} {
+			exit 1
+		}
+		set _gitdir {}
+	}
+}
+
 set picked 0
-if {[catch {
-		set _gitdir $env(GIT_DIR)
-		set _prefix {}
-		}]
-	&& [catch {
-		# beware that from the .git dir this sets _prefix to the empty string
-		set _gitdir [git rev-parse --absolute-git-dir]
-		set _prefix [git rev-parse --show-prefix]
-	} err]} {
+if {$_gitdir eq {}} {
+	unset_gitdir_vars
 	load_config 1
 	apply_config
 	choose_repository::pick
@@ -1159,7 +1184,6 @@ if {[catch {
 		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] \n\n$err"]
 		exit 1
 	}
-	set _prefix {}
 	set picked 1
 }
 
@@ -1174,11 +1198,6 @@ if {$hashalgorithm eq "sha1"} {
 	exit 1
 }
 
-if {![file isdirectory $_gitdir]} {
-	catch {wm withdraw .}
-	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
-	exit 1
-}
 # _gitdir exists, so try loading the config
 load_config 0
 apply_config
-- 
2.54.0.99.14

