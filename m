Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5F430318
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104105; cv=none; b=DB4ypUQFsCtzU6hqgGWvRUfUH8eiQnUR6KydGYpUXqakEhnPy2h01yNlkqmVEFJBi1JFwzC0YQRuMHxcXv8j8vH0OMHh98V9NbiAOar9ku6UlLisvGqdX9aS960s8DjPmtxkjsUA8Wk9blCJ+BPdCPIX66HntPrNzUdNksBC/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104105; c=relaxed/simple;
	bh=TX7+h9xetZhEBlPHcmIqoV0VW8ryY7P645PXYoBJIV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXc+O/e3vokllxX5chPOuJK+PzsrHKEiuPyf+XnISOBRF9x7opM+lsqlmvCx9MaoXb+jd3gLgqVOJAyCL47v01O6HNFAma3jMgFQtKsaE/i58DT3F0odQTxoYr1sEOtqwPPI171+zmCk+SAqoiUHL0sMDkRdZj81GKKrQ0hcVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLzYYptX; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLzYYptX"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6688a2dceb8so2134928d50.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786104086; x=1786708886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZrQ+n7JrPkU5JYblJHRulmP3XJ2hupxX8zIR0aIWEw=;
        b=OLzYYptX4Lwnl8z5Gq/bbYoZEJGVq/7si//+ZTel8vL5BqKlv1jCsUwFsT2CoTtCaP
         0Kt2qxVbkZN/+yIitx60w1lmB2BO9mOnAPn+g8G+MszRyTM7kO5qnyeSdQALgPl14qZz
         DAj4VB03mTeDSzjk2/4ibMwBeMheoO3MYuvEkVI3xQk8RtbQ71nN051XnJmQeBgCz0q2
         cE6tmqBdbEqATGlXuGgCl7JgLvpL0YOSVpwTjwgfdP3uqozAHA8EoICl8LsVx9VbQxJX
         jsrduUz+vjs0D/3xP/V7mpIgkaJZt5Q6I7/JGPJXb4O8EfiwIwtsfTIAqXlTu5+GOWZN
         cf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104086; x=1786708886;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZrQ+n7JrPkU5JYblJHRulmP3XJ2hupxX8zIR0aIWEw=;
        b=Y7X+3K3O+eRUZFKEeqDIm8JYIQVhSy6DvKtsgWCuzUgvERTaAko2tw7uKoiTVsJLCh
         AuXRStcr475HR01BIt98RHVZzjuu50Iq0mzYuJ6YMPBAzK9e5AO8WXxIAWarkr6ToYKP
         YCebNTvfZ+q+oTO1q/oDQLqTPGQDksu27GxnqiMbpdWPjaKXcN/FDbUz2jcJAymfveoe
         xrGD+So8Y+8rxxn/K8LcgAFBjVMQRIfEi9Idg4aA6l64uolsPnzZKkXL8REExnmxHR7J
         VHbuztC5+UmoCt+GGgmuKpnFRmlNzRwUO88flScPw2fauw51lcsoxJGRB4XYiuX8JKon
         yuaQ==
X-Gm-Message-State: AOJu0Yy4bUmrCahfdRXQmuicr16oZOS5m/uMBBlDscE6iMV7F/yMuHCP
	CyUlQT/Ka6DdjliJOwhGKHgUEJqEbyoMrZE2W0LhoWaVBhxMfvg6MXDGvNEA7qKn1KQ=
X-Gm-Gg: AR+sD12PU0DCERyE1waV+sxWEC17v0dgmMetnil9C96fclhKEs6u0DglT/tBsU2lonY
	ul+R4uocgPvRqZtzkiB0TT4BRTqGVRK950qwtQE5GfGTmPG8schfN9ckaepkiJwF5VO7orWTdkC
	V1cMI2cG7d8zOCjRwFjGqInfmIGVlVJnEIsL0TXr4Gq/cjdEeBs/qt2kGVQXQAn9x/MjUUOFQ7X
	l2c06Urjy9/uTQ91dAmTLbb+KOlmykHGPV6bzdYdw3MchPqWsfToy25CWwVOtyyQCWSd8hpTbCj
	obFBjw+jd0hQ3JkDwpApkXAEKU58B7DcvovuiULuIPuerzZpD4++TSRQ0BNXxsGQMh+J12e7H62
	VU9lnu5ms/b5sEtBkjNItOiFQRT4SzJdhkz23pqPKJyaqM53yHuNum4+S65LLU1qK9VQM1i2YyT
	YFjXJ6WameiQPskz4Iqg/3HQYFfAwDGBVvvcmFNDtOlkMIppMCq+JVsH2Czpx5Ulwi+sRZjIlA5
	z+B517x1G+unn4wjLm7pBj2CSBqUT2S2okCab208S6NFgwin3gCzSPOXk+RaBfV1dbfGuOBq1ci
	QIQdddRaJXA=
X-Received: by 2002:a05:690e:439b:b0:667:b08e:2a2 with SMTP id 956f58d0204a3-66acd2f213amr818310d50.27.1786104086066;
        Fri, 07 Aug 2026 05:01:26 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acae63149sm1048042d50.11.2026.08.07.05.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:01:25 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Tian Yuchen <cat@malon.dev>,
	Todd Zullinger <tmz@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Fri,  7 Aug 2026 07:56:26 -0400
Message-ID: <dbbd96d50811e4c2decb6f754b56dc1f7ee0944a.1786103607.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.340.g8e2bf96aa5.dirty
In-Reply-To: <cover.1786103607.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Racy Git problems persist today, manifesting themselves in the
performance of commands like "git diff" in new worktrees [1]. We have
long had a build knob "USE_NSEC" to tell Git to use in-core nanosecond
precision when available, which mitigates most if not all racy issues,
but most builds we know about it don't use it. In part, that's because
someone distributing Git can't safely enable it at compile-time if they
don't know exactly what platforms their distribution will be used on.

[1]: https://lore.kernel.org/git/CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com

These days, most platforms are likely to be safe for the USE_NSEC code.
Regardless, we want to give users the ability to benefit from it. This
requires exposing the compile-time gated code as a runtime option.

In addition, update the Racy Git documentation and other mentions of
USE_NSEC in the code.

Best-viewed-with: --ignore-space-change
Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---

Notes (benknoble/commits):
    Repeating the benchmark from my original mail [1] shows an improvement
    
    # git worktree add -d ../perf-test HEAD
    # hyperfine -N --warmup=10 './build/bin-wrappers/git diff'
    Benchmark 1: ./build/bin-wrappers/git diff
      Time (mean ± σ):       3.8 ms ±   0.4 ms    [User: 4.7 ms, System: 4.4 ms]
      Range (min … max):     3.2 ms …   5.6 ms    780 runs
    # (pushd ../perf-test && hyperfine -N --warmup=10 $OLDPWD/'./build/bin-wrappers/git diff')
    Benchmark 1: /home/benknoble/code/git/./build/bin-wrappers/git diff
      Time (mean ± σ):     217.5 ms ±   2.9 ms    [User: 202.1 ms, System: 23.4 ms]
      Range (min … max):   213.9 ms … 223.3 ms    13 runs
    # (pushd ../perf-test && hyperfine -N --warmup=10 $OLDPWD/'./build/bin-wrappers/git -c core.useNanosec=true diff')
    Benchmark 1: /home/benknoble/code/git/./build/bin-wrappers/git -c core.useNanosec=true diff
      Time (mean ± σ):       3.8 ms ±   0.4 ms    [User: 5.3 ms, System: 4.2 ms]
      Range (min … max):     3.2 ms …   6.9 ms    541 runs
    
    [1]: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
    
    Passing CI: https://github.com/benknoble/git/actions/runs/31104581195

 Documentation/config/core.adoc        |  6 ++++++
 Documentation/technical/racy-git.adoc | 11 ++++++-----
 Makefile                              | 12 +-----------
 builtin/update-index.c                |  2 +-
 compat/posix.h                        |  1 -
 configure.ac                          |  6 ------
 environment.c                         |  6 ++++++
 environment.h                         |  1 +
 read-cache.c                          | 17 +++++++++--------
 statinfo.c                            | 14 +++++++-------
 10 files changed, 37 insertions(+), 39 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 340329edc3..33104444ab 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -118,6 +118,12 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.useNanosec::
+	If true, use nanosecond precision for ctime and mtime
+	comparisions between the index and the working tree (if Git
+	was compiled to store it).
+	See link:technical/racy-git.html[Racy Git]. False by default.
+
 core.splitIndex::
 	If true, the split-index feature of the index will be used.
 	See linkgit:git-update-index[1]. False by default.
diff --git a/Documentation/technical/racy-git.adoc b/Documentation/technical/racy-git.adoc
index 59bea66c0f..499231585b 100644
--- a/Documentation/technical/racy-git.adoc
+++ b/Documentation/technical/racy-git.adoc
@@ -39,8 +39,8 @@ files) from `st_mode` member, `st_mtime` and `st_ctime`
 timestamps, `st_uid`, `st_gid`, `st_ino`, and `st_size` members.
 With a `USE_STDEV` compile-time option, `st_dev` is also
 compared, but this is not enabled by default because this member
-is not stable on network filesystems.  With `USE_NSEC`
-compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
+is not stable on network filesystems.  With 'core.useNanosec'
+config setting, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
 members are also compared. On Linux, this is not enabled by default
 because in-core timestamps can have finer granularity than
 on-disk timestamps, resulting in meaningless changes when an
@@ -49,9 +49,10 @@ of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
 ([PATCH] Sync in core time granularity with filesystems,
 2005-01-04). This patch is included in kernel 2.6.11 and newer, but
 only fixes the issue for file systems with exactly 1 ns or 1 s
-resolution. Other file systems are still broken in current Linux
-kernels (e.g. CEPH, CIFS, NTFS, UDF), see
-https://lore.kernel.org/lkml/5577240D.7020309@gmail.com/
+resolution.  As of kernel 4.3, other file systems (CEPH, CIFS, NTFS, UFS, FUSE)
+were fixed; see https://public-inbox.org/git/5605D88A.20104%40gmail.com/.  FAT
+has been fixed since 2015.  The usual suspects (ext2, ext4, XFS) are known to
+work, too.
 
 Racy Git
 --------
diff --git a/Makefile b/Makefile
index fac3e8879c..b4ebcb9e83 100644
--- a/Makefile
+++ b/Makefile
@@ -197,18 +197,11 @@ include shared.mak
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
 # as the compiler can crash (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
 #
-# Define USE_NSEC below if you want git to care about sub-second file mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for this. On
-# Linux, kernel 2.6.11 or newer is required for reliable sub-second file times
-# on file systems with exactly 1 ns or 1 s resolution. If you intend to use Git
-# on other file systems (e.g. CEPH, CIFS, NTFS, UDF), don't enable USE_NSEC. See
-# Documentation/technical/racy-git.adoc for details.
-#
 # Define USE_ST_TIMESPEC if your "struct stat" uses "st_ctimespec" instead of
 # "st_ctim"
 #
 # Define NO_NSEC if your "struct stat" does not have "st_ctim.tv_nsec"
-# available.  This automatically turns USE_NSEC off.
+# available.
 #
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-index perspective.
@@ -1935,9 +1928,6 @@ endif
 ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
 	BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STRUCT_STAT
 endif
-ifdef USE_NSEC
-	BASIC_CFLAGS += -DUSE_NSEC
-endif
 ifdef USE_ST_TIMESPEC
 	BASIC_CFLAGS += -DUSE_ST_TIMESPEC
 endif
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 241abd4332..8e0c25655f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -130,7 +130,7 @@ static void xrmdir(const char *path)
 static void avoid_racy(void)
 {
 	/*
-	 * not use if we could usleep(10) if USE_NSEC is defined. The
+	 * not use if we could usleep(10) if core.useNanosec is defined. The
 	 * field nsec could be there, but the OS could choose to
 	 * ignore it?
 	 */
diff --git a/compat/posix.h b/compat/posix.h
index e2e794cad7..51ee03233b 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -487,7 +487,6 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 } while (0)
 
 #ifdef NO_NSEC
-#undef USE_NSEC
 #define ST_CTIME_NSEC(st) 0
 #define ST_MTIME_NSEC(st) 0
 #else
diff --git a/configure.ac b/configure.ac
index cfb50112bf..fc956776ab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -351,12 +351,6 @@ GIT_PARSE_WITH(iconv))
 
 ## --enable-FEATURE[=ARG] and --disable-FEATURE
 #
-# Define USE_NSEC below if you want git to care about sub-second file mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
-# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
-# randomly break unless your underlying filesystem supports those sub-second
-# times (my ext3 doesn't).
-#
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-index perspective.
 
diff --git a/environment.c b/environment.c
index 6676e6f5ae..e6a50060e8 100644
--- a/environment.c
+++ b/environment.c
@@ -571,6 +571,11 @@ int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "core.usenanosec")) {
+		cfg->use_nanosec = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return platform_core_config(var, value, ctx, cb);
 }
@@ -769,6 +774,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->ignore_case = 0;
 	cfg->trust_executable_bit = 1;
 	cfg->has_symlinks = platform_has_symlinks();
+	cfg->use_nanosec = 0;
 
 	/* section "sparse" config values */
 	cfg->sparse_expect_files_outside_of_patterns = 0;
diff --git a/environment.h b/environment.h
index e7ec5b0437..a35534afe5 100644
--- a/environment.h
+++ b/environment.h
@@ -139,6 +139,7 @@ struct repo_config_values {
 	int ignore_case;
 	int trust_executable_bit;
 	int has_symlinks;
+	int use_nanosec;
 
 	/* section "sparse" config values */
 	int sparse_expect_files_outside_of_patterns;
diff --git a/read-cache.c b/read-cache.c
index 6c449f393d..297646c357 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -353,15 +353,16 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 static int is_racy_stat(const struct index_state *istate,
 			const struct stat_data *sd)
 {
+	int use_nsec = 0;
+	repo_config_get_bool(the_repository, "core.useNanosec", &use_nsec);
+
 	return (istate->timestamp.sec &&
-#ifdef USE_NSEC
-		 /* nanosecond timestamped files can also be racy! */
-		(istate->timestamp.sec < sd->sd_mtime.sec ||
-		 (istate->timestamp.sec == sd->sd_mtime.sec &&
-		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
-#else
-		istate->timestamp.sec <= sd->sd_mtime.sec
-#endif
+		/* nanosecond timestamped files can also be racy! */
+		use_nsec
+		? (istate->timestamp.sec < sd->sd_mtime.sec ||
+		   (istate->timestamp.sec == sd->sd_mtime.sec &&
+		    istate->timestamp.nsec <= sd->sd_mtime.nsec))
+		: istate->timestamp.sec <= sd->sd_mtime.sec
 		);
 }
 
diff --git a/statinfo.c b/statinfo.c
index 5e00af127d..d9ddcf9382 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -72,13 +72,13 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
-#ifdef USE_NSEC
-	if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
-		changed |= MTIME_CHANGED;
-	if (cfg->trust_ctime && cfg->check_stat &&
-	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
-		changed |= CTIME_CHANGED;
-#endif
+	if (cfg->use_nanosec) {
+		if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
+			changed |= MTIME_CHANGED;
+		if (cfg->trust_ctime && cfg->check_stat &&
+		    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
+			changed |= CTIME_CHANGED;
+	}
 
 	if (cfg->check_stat) {
 		if (sd->sd_uid != (unsigned int) st->st_uid ||
-- 
2.55.0.340.g8e2bf96aa5.dirty

