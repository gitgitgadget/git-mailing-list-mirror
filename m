Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0636DA04
	for <git@vger.kernel.org>; Wed, 20 May 2026 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308681; cv=none; b=CsaF7ZeelKCBJKRQXIS1z6/vx7rC//ch6LNQX03A7MGV+Eq87ZJ9XtTo57vjrqxyQ9Qvss4yNNSvgb9MbIYNYT6h4HALiu2IzwBrVLoQWFgnz7bkefJrHECoqEqt3H4Jg40E7PUaM1UspxIVzFC626UgcPySAT4cqiNcHuFIqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308681; c=relaxed/simple;
	bh=ST2LIHrx8dgJrbNtDusTgvLp6272dQ7JIDAvffGLOW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9LS5sv2iHOuu7qlt0GLKWzxVsJIaU1lvHJP7IP//MUL10pBAVbKgSzko8nrtG+pVqoLOivbIkBp2Jm0MA+5MdTzBn3M4yapBl9aj3YHVC81pbHaDU7hn2lwE9DzbfZ9PDgK9Ul5iJ4n/Cvd6hPMe8JjBX9AR1KxJBM6fMUeb8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSlquZo2; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSlquZo2"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8be236ce888so52715326d6.3
        for <git@vger.kernel.org>; Wed, 20 May 2026 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308678; x=1779913478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c8JkWrCFri83Dzmh3wTlYQGnupwXxUr/DtWQomKd9E=;
        b=QSlquZo2F3bBco3EaXv6MSKkSaQoq9FHDiKZXXC9aWCRbleLHvNIah3n9gjBLaAvIk
         Mn1TdEVjINzc6UDFkBdSDCo0Siv2Dq5FsYb4jFq7X39tdJzCmxdrdv799qEjj0pNnmsO
         zLtE6el6nD5s9mipJL7IVAzstISKySoDJLERS8QhngpIkVJVtCexSUbz7yEXO8Inm9C3
         PKrRRIHF/YVQPxNghxH68f9Yz+kh/XHKaPWVQwk4iJB8LDFzt3gjIsQp5NBS9/r3xex6
         8g0kKPZMSHastGPBT39i0NLPHemV3FLW+eO+Ic3f75fCDVdxGfl/0jLKgt6Ua/JGYqH7
         SKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308678; x=1779913478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/c8JkWrCFri83Dzmh3wTlYQGnupwXxUr/DtWQomKd9E=;
        b=HDUjB7NErMbZ+FOEZxzh1LIXhXUeykmAGGYYgG2yDm2sKT6Vpz6fdW6E1h5Uni7c0X
         MF4cPW2FUWh87y0CK/ClJ2hDUdElkcP2szMBkdEsbKEcejXm0JQRUCguyf3g4AGE7C87
         dBu2RgLNcWm93q0SGpWVKEBbemksbllwSYBhi/PrT+opDpKp/JG9SimoyRNWe15b3uW7
         wQJQ71uMidjCejkwAUtkXH3h9uFcYQsB8auRUkXwYEwHmMI7nOdVRtcrp0UjX25ag6BV
         WEvSQTNG/rRSoJQSut6O6hLKZpYrDtquLDd9z1Qqlyp77sfRN5h6pbHjY6H7Y8+ZSFjb
         IYSg==
X-Gm-Message-State: AOJu0YzJdvUKT0w38QFtv5pVRTX3LkGBfnBoa6B/lqFn02cHaOUpBXdR
	ogWFtfyOfQYF3v2yb6oyaKphrVV8AO5H/CA+8/a8qKXrmuWCG1XbBftOlPYKqRKL
X-Gm-Gg: Acq92OH5fLF74bCHcjyUUFfG/BIq8Qg+M5UYxV7LqCoNcpNuMoqacwequUpYYq30qQT
	4gS5fVxyxOT7iJcE0CrG7jzp7fXmgBLh8Uoupyhbbz01nKcYjxK8DxP/fBpJErcSstkbUCEzgzW
	NveSzCMAL1Afxi6Ib5u7vFPE5am7sOQhTtdki0brmhlQC9pXxiOnd80buP9QBi0SER9uk4Pg6eO
	cGQAOql1tLdI4YXw8xcD1JwpRcfAEGQIfyv18PVeGvk+XD7KyQscrOBpCRGHMxAMYaO3ekXQgfX
	E3kvTMfKtfAhG4DyokTDgkfqy81r4Z2NR6gYloOyBbjbi4upjPI+g3UYLfZduw801abQNJUvL3f
	gtIv7zgzaK08H9vr62v3zkhcgxB1cSzAoymsyLaH17EZiJGtfY4VJ03XEq3iwosQX2iG2h2GWCi
	E3bqYf7UDxtdCKSuQGtpN07p0Y8Q==
X-Received: by 2002:a05:6214:428f:b0:8ae:6460:c544 with SMTP id 6a1803df08f44-8ca0f6a3759mr424662506d6.41.1779308678525;
        Wed, 20 May 2026 13:24:38 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca361905d4sm129891136d6.32.2026.05.20.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:24:38 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 07/11] git-gui: try harder to find worktree from gitdir
Date: Wed, 20 May 2026 16:24:06 -0400
Message-ID: <20260520202411.108764-8-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260520202411.108764-1-mlevedahl@gmail.com>
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui, since 87cd09f43e ("git-gui: work from the .git dir",
2010-01-23), has had the intent to allow starting from inside a
repository, then switching to the parent directory if that is a valid
worktree.

This certainly hasn't worked since 2d92ab32fd ("rev-parse: make
--show-toplevel without a worktree an error", 2019-11-19) in git, but
breaking this git-gui feature was unintentional.

There are (at least) 3 cases where the gitdir can tell us where the
worktree is, and we would like all to work:

- core.worktree is set, and points to a valid worktree. This is already
  handled  by git rev-parse --show-toplevel, even when not in the worktree.
  There is nothing more to do in this case.

- the gitdir is embedded in a worktree as subdirectory .git. The parent
  is (or at least should be) a valid worktree. This worked long ago.

- the gitdir is a worktree specific directory (under
  <mainrepo>/worktrees/worktree_name), within which there is a file
  "gitdir" pointing to .git in the worktree. git gui never learned to
  handle this case.

Let's handle the latter two cases. Always check that the discovered
worktree is valid and points to the already discovered gitdir according
to git rev-parse. This avoids issues that may arise because we are
discovering from the gitdir up, rather than the worktree down, and file
system non-posix behavior or misconfiguration of git might cause
confusion.  For instance, a manually moved worktree might not be where
the gitdir points.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 8fe25fe188..aeb7ed3548 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1100,6 +1100,41 @@ unset argv0dir
 ##
 ## repository setup
 
+proc find_worktree_from_gitdir {} {
+	# Directory 'parent' of a repository named 'parent/.git' might be the worktree.
+	# Assure parent is a worktree and using the git repository already discovered.
+	# Also, handle case of being in a worktree's gitdir, where file "gitdir" points to
+	# gitlink file .git in the real worktree.
+	set worktree {}
+	if {[file tail $::_gitdir] eq {.git}} {
+		if {[catch {
+			set gitdir_parent [file dirname $::_gitdir]
+			set worktree [git -C $gitdir_parent rev-parse --show-toplevel]
+			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
+			if {$::_gitdir ne $parent_gitdir} {
+				set worktree {}
+			}
+		}]} {
+			set worktree {}
+		}
+	} elseif [file exists {gitdir}] {
+		if {[catch {
+			set fd_gitdir [open {gitdir} {r}]
+			set gitlink_parent [file dirname [read $fd_gitdir]]
+			catch {close $fd_gitdir}
+			set worktree [git -C $gitlink_parent rev-parse --show-toplevel]
+			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
+			if {$::_gitdir ne $parent_gitdir} {
+				set worktree {}
+			}
+		}]} {
+			catch {close $fd_gitdir}
+			set worktree {}
+		}
+	}
+	return $worktree
+}
+
 proc is_gitvars_error {err} {
 	set havevars 0
 	set GIT_DIR {}
@@ -1176,6 +1211,13 @@ if {[catch {
 	set _prefix {}
 }
 
+if {[is_bare]} {
+	# Maybe we are in an embedded or worktree specific gitdir
+	if {[set _gitworktree [find_worktree_from_gitdir]] ne {}} {
+		set _prefix {}
+	}
+}
+
 if {![is_bare]} {
 	if {[catch {
 		cd $_gitworktree
-- 
2.54.0.99.14

