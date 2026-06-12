Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA40397E88
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781238730; cv=none; b=jEtdxSjcdJb1Hwvez87wOK9oiG086ZB42lGcm9LvmQoiFpaawxkjKLwPNw8UtN6/iBv6NGze43/vlhRMaTEltDTRV1Y7TlTTHqL3SZpDPGQFWoM0VSiVWbKdSStc08uY51iPQEnye2tNkrDL7AG/VC4P5ysF1KyR+IW5WeshAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781238730; c=relaxed/simple;
	bh=At3YPgz8OFvYKYIF84sZ7EdSUx4VkRZS3Hua5E3aIvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=ArFzwbzz2okCBig+IwGEiCs8Tr0hJ69G3np3HYPHFsyKHFP4KU8WrR3cCzjXCXQoKqf/4a9rZiNsB9gNXS1UDf3IffZTEaIkOlu5sx9ReOC3OsLWb0+oRPy6B80cLFyKrrZWDpbrQEQeKGTW/MG0p6FKAUqO9RwY9TemzExZZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJD562bT; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJD562bT"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-48662d16d08so268749b6e.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 21:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781238727; x=1781843527; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LiyN+95SpuP8Z16Q46hib4Xp2wJ3DrgceSNG3qm5sE=;
        b=dJD562bTfzSS9ilfk9YyYUCA1UiulyKWJwCPTR6YmXSATQHQpxaf9xEyTzwvOmVz7J
         ix0HGtdBQR58O2wfM0NyYGSyK6ayeQGe8gHsory5i60noQOCgFQ14wcN5FiLSMKPJt4/
         EG5L84q2r8Fu99WokLlfzotPHMlzyHzjmdST0X4KkgU91hayXHPfLF98+A7s/WRxASbp
         WK6VMLqwsGFwBi4WWjq6KUQnnOFc54a4cYlCPlZ38ZmvUoloc+HHX690Idp5a23/vmOI
         Lym4IPf63/vDXcmb/pRUwsmLnYvulEVr9m56dtFSIKBAzqOPOdYfYZZjW26XrYQK6kAJ
         cWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781238727; x=1781843527;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7LiyN+95SpuP8Z16Q46hib4Xp2wJ3DrgceSNG3qm5sE=;
        b=Yog+6A7XiF+wBwNNdqfPYr4keUWSNs4iH8LGDMh/g9exhFpSMu0JI81MdSDmRSYFR+
         kkJZOydbdQxwNHnOJDWvO0nAtslhSFMVj39uSLoZx6WVyP7W1yuHVx3Xox8B8ORG5Ryg
         QbWZTnUvCf2rrZKzNH3r7ns4an6s1F7gdP7hR77pHm6pNyyxMQCJJdkaK91SaZ1PkgWX
         pf5Fyq4cV/INfioreL/k6tLNHKAsXR+3uJzA+t3zlp64e8sfpxo1nX2HyiRl/fpMf101
         /s/4j+5E0Tuf7YZ78M9Kn7Db7ujHcUiDbD/o4SFXRokAWsiaKF9YEYl3JlOMoh1bmCk+
         vxiA==
X-Gm-Message-State: AOJu0Yyyrs9gdmlmAY9PuCKCvWjSvfQpVJEal6/1Xz0j4ixLsC/2rtKH
	t22MAglySz1TAQcoP4D6kluEqXwxdwUdF1tzi054AQvV9V9dzEfPtbaZ
X-Gm-Gg: Acq92OGERbcB0ikH2QlSUrtrdQBnKO/h3IWQn7ofLpV/C8K4TDPxLv92uRCJb0WIl+l
	UBRSS8W5D/WQGXq6azOoEEGPtR1usq/k4cGEWuROgAREXfM/JbOq3js/I+zhaYwbDOfVAE9vHQW
	2nTo0y93zRxOZ9CnvHCdD3A9gPMWFNKzmbitCFEalrat/R4KsnGZtiXLwpFefd5lJ+M0bGUB9xZ
	XlFFY3xXV15qtkWJMHzem+QkzewNm0om7Ed6HaKASZYazMXLMAq2ZV97krmz2cIA2twEQqlue4q
	ykPzESys8g+g672nriSzVTAx0kyDiSBM2QyxXvG37Ie7fY4Uttz4R8WmhLeLlnZmR19o4YkC5pu
	iArO+NgnlALZubC4/m/qLm623tymeBMck5oGMK5jtdJEOa90wyKSczBULkFH32wELCRiu7Iwwj+
	snljnb+5f2ES3oBiun9Jd3yJNy5vg3+qfdShN7Mx+WvKduRxwd5QOjBmseNn8OeI+VEhQhIsn36
	tH/D7SDJptIlhiRRKSsUDqFrtWz9vkNCFyloI7iwsZlkBAaiMsgcbUMRKWEDSyYsxsOh0AXRdYu
	FOX0AXwfwH0mQapWDa75Z7S5DShFE7UR516dTtZiJOLSMirKKwiDLp8o+C489Yk=
X-Received: by 2002:a05:6808:171b:b0:486:3d49:cb46 with SMTP id 5614622812f47-4872f391446mr837449b6e.14.1781238727526;
        Thu, 11 Jun 2026 21:32:07 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([50.237.239.3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-487315a6eb4sm386660b6e.16.2026.06.11.21.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:32:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 11 Jun 2026 21:31:51 -0700
Subject: [PATCH v3] ls-files: filter pathspec before lstat
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-ls-files-pathspec-lstat-v3-1-f967e1a00c13@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNTQ7CIBAF4Ks0rMUApZS48h7GBaVDi+lfAImm6
 d2FuunGuHyTN99bkQdnwaNLsSIH0Xo7TymUpwLpXk0dYNumjBhhgghS48FjYwfweFGh9wvodAk
 qYCkryipVtYJzlL4XB8a+dvl2/2b/bB6gQ+Zyo7c+zO69T0eae/9XIsUUS204aeqSUC6u3ajsc
 NbziPJKZEdH/nZYckwyeMMkZwyOzrZtHxnmsIYYAQAA
X-Change-ID: 20260607-ls-files-pathspec-lstat-885125a5d644
In-Reply-To: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
To: git@vger.kernel.org
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781238722; l=5916;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=At3YPgz8OFvYKYIF84sZ7EdSUx4VkRZS3Hua5E3aIvg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCXg/QisfOzKyrFzuZuRDXtmF9dr2Rs6n0AZa182B1K7b79KaJ7CZR2Rzu6G0mdOpqB5UPCIJoR
 lv1cUG7h6DwE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

In --deleted and --modified modes, show_files() calls lstat() for each
index entry before show_ce() applies the pathspec. prune_index() avoids
most of these calls for pathspecs with a common directory prefix, but
not for a top-level name or leading wildcard.

Match before lstat() to avoid accessing the worktree for entries that
cannot be shown. Treat this as a prefilter: do not update ps_matched,
and retain the match in show_ce() so --error-unmatch is satisfied only
by entries that the selected modes actually show.

Prefilter only a single pathspec item, bounding the added work for each
index entry. Applying match_pathspec() to multiple arguments can cost
more than the lstat() calls it avoids. In a synthetic repository with
10,000 clean files, passing every path to ls-files --modified increased
runtime from 112.5 ms to 494.1 ms when the prefilter was unconditional.

With $parent and $this exported as paths to binaries built from the
parent and this commit, on a repository with 881,290 index entries:

    hyperfine --warmup 0 --runs 3 \
        --command-name parent \
        '$parent -c core.fsmonitor=false ls-files --deleted -- README.md >/dev/null' \
        --command-name this-commit \
        '$this -c core.fsmonitor=false ls-files --deleted -- README.md >/dev/null'

reported means of 65.790 seconds for the parent and 4.987 seconds for
this commit.

Link: https://lore.kernel.org/r/xmqqfr2tnfk0.fsf@gitster.g
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
A selective pathspec should let ls-files --deleted and --modified avoid
statting entries that cannot be shown. Match a single pathspec before
accessing the worktree, while preserving the existing lstat-first order
for multiple pathspecs whose matching cost grows linearly.
---
Changes in v3:
- Explain the conservative single-pathspec cutoff without referring to
  prior revisions.
- Rerun the primary benchmark with the final implementation.
- Make no code changes.
- Link to v2: https://patch.msgid.link/20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com

Changes in v2:
- Restrict early matching to one pathspec after measuring a regression
  with many pathspecs.
- Add all-matching and many-pathspec performance results.
- Drop the Assisted-by trailer.
- Link to v1: https://patch.msgid.link/20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com
---
 builtin/ls-files.c                  | 11 +++++++++++
 t/meson.build                       |  1 +
 t/perf/p3010-ls-files.sh            | 31 +++++++++++++++++++++++++++++++
 t/t3010-ls-files-killed-modified.sh | 18 ++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e1a22b41b9..8d7158652b 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -450,6 +450,17 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			continue;
 		if (ce_skip_worktree(ce))
 			continue;
+		/*
+		 * match_pathspec() is linear in pathspec.nr, so prefilter only
+		 * the single-pathspec case. Only entries shown by show_ce()
+		 * satisfy --error-unmatch.
+		 */
+		if (pathspec.nr == 1 &&
+		    !match_pathspec(repo->index, &pathspec, fullname.buf,
+				    fullname.len, max_prefix_len, NULL,
+				    S_ISDIR(ce->ce_mode) ||
+				    S_ISGITLINK(ce->ce_mode)))
+			continue;
 		stat_err = lstat(fullname.buf, &st);
 		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
 			error_errno("cannot lstat '%s'", fullname.buf);
diff --git a/t/meson.build b/t/meson.build
index 2af8d01279..ee8086e6ef 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1140,6 +1140,7 @@ benchmarks = [
   'perf/p1500-graph-walks.sh',
   'perf/p1501-rev-parse-oneline.sh',
   'perf/p2000-sparse-operations.sh',
+  'perf/p3010-ls-files.sh',
   'perf/p3400-rebase.sh',
   'perf/p3404-rebase-interactive.sh',
   'perf/p4000-diff-algorithms.sh',
diff --git a/t/perf/p3010-ls-files.sh b/t/perf/p3010-ls-files.sh
new file mode 100755
index 0000000000..ae14449432
--- /dev/null
+++ b/t/perf/p3010-ls-files.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description='Tests ls-files worktree performance'
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+test_expect_success 'select a zero-prefix pathspec' '
+	tracked_file=$(git ls-files | sed -n 1p) &&
+	test -n "$tracked_file" &&
+	pathspec="?${tracked_file#?}" &&
+	test_export pathspec
+'
+
+test_perf 'ls-files --deleted with pathspec' '
+	git -c core.fsmonitor=false ls-files --deleted \
+		-- "$pathspec" >/dev/null
+'
+
+test_perf 'ls-files --deleted with all-matching pathspec' '
+	git -c core.fsmonitor=false ls-files --deleted -- "*" >/dev/null
+'
+
+test_perf 'ls-files --modified with pathspec' '
+	git -c core.fsmonitor=false ls-files --modified \
+		-- "$pathspec" >/dev/null
+'
+
+test_done
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 7af4532cd1..6e38e10219 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -124,4 +124,22 @@ test_expect_success 'validate git ls-files -m output.' '
 	test_cmp .expected .output
 '
 
+test_expect_success 'worktree modes honor wildcard pathspecs' '
+	cat >.expected <<-\EOF &&
+	path2/file2
+	path3/file3
+	EOF
+	git ls-files --deleted -- "path?/file?" >.output &&
+	test_cmp .expected .output &&
+
+	cat >.expected <<-\EOF &&
+	path7
+	path8
+	EOF
+	git ls-files --modified --error-unmatch -- "path[78]" >.output &&
+	test_cmp .expected .output &&
+
+	test_must_fail git ls-files --modified --error-unmatch -- path10
+'
+
 test_done

---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-ls-files-pathspec-lstat-885125a5d644

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

