Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362325228D
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677790; cv=none; b=XGBlRAV2U094z/viPv2AfQOSbSqHMUY7sf6GUTcbL+smNJJmFkNtLzOXU5umpYEfnl6nuo+rpyidNOB8RyTRNLlViQARDzBxgGuX/bkcnppJDCCjIN2Wwhb+KiQrx1VKGDXPK9jKEGBzkG1JXn5SJyvFTuthFC4Q09/6FAyRy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677790; c=relaxed/simple;
	bh=eMzrPhMaT1x0XjuCZl+EPfRGsihioVbm65GhzCDMmWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fcHfn2fnGrIPCPit5tIElBYbdjtOs7/1AL+1fWb4Bcx5c8bNeqLBZ3v6IebGnqfXHmHKC3J81SYAxle9vsuSVsuXf/kip5B9RVy1f4BTSKjz46MIkgGPDQ5kr2WnO6RY2RNOp+sGEytBFaUObW8nW3MGmcq67eA7GvsYK/61ZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek5oqI8Z; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek5oqI8Z"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91574384cc2so250140785a.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780677788; x=1781282588; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rHxpXEMHHAsxOzNWt5fiOwrLwc3Ump9C2V82RQPaW8=;
        b=Ek5oqI8ZuO6VNeFMrs8nWdYKpuv8yyJl6ka1H81ltLyO8rsjefGZ+An772DZVE4UEm
         RzhPPRZ8yEOUTuJNI8BgeM0ZwbchKvLsSQabv/62qQTfYQddQqzJDNaY8la/neiDlM5C
         J1paiG86vcqTtESmGEaTEJdFy4xZOUHd+YjczwMZrMIRUIv+xn8oLbznT371/eR+19AP
         IXochidfcuYDJmUR6QS50vFaq6FfshKudU9UnBQsrTfgVsgTCZNfWEoitZGJi2HKRRZJ
         bMWAHI3vlz9cRBRx+hlbbPQZImfuBYA1jhh/NSHyZ5zGSXh33cXWCXGCSNsEtx2405Yh
         AJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677788; x=1781282588;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rHxpXEMHHAsxOzNWt5fiOwrLwc3Ump9C2V82RQPaW8=;
        b=gRBEaa3b99lbW3fgi0x9hSVFbqtchdgMg3Ycjc8OnebH9AyRkrM+ycOE/6XaAvi95N
         otKYRcc/kjuW/40QdWftVhUl7vT0Dh0JFMk9gRQPcy+t0x6EoGjjAS3t5oQzzkcUq2nr
         8Wy3DWeB0jMbMUHKogo7VbxrvPlO+qWvpPXs6F5lqrJJEmw22bDCbK32KXVfMuQadDKI
         qf771JbdSkyGVBZGWfrTWU11fv6e7D6Klep99kwIE52I5tAi4F9QU9qII9yNU1m/vQ+T
         M4eTN1XI8D3NFpCig/Mp2pjtnwAWTaxEAC5KRiRMP8PzK/4lwYTFtIReYpB9BgUDeWKt
         fEyQ==
X-Gm-Message-State: AOJu0YylRstgOnjhkozwkp4bzAWLQX6fkF+xhsfWe1MTy5/M6jR+QYt8
	2hxXPGy5booR6dLWiZfHs1ULWjSV4o9yMiyocWwtSKsobCimhgpdXhX1
X-Gm-Gg: Acq92OGoQLEtMyPfHrVl8+VX+zFHxHblqL6/2GjQpR/199Vp+lF1LZSSGM2sZG/CDHU
	b+0UJEYkUwZBBuYA+CzLyWiGeFM04UENEb3LABs38QeX1w79RYy1ViNuIA5SJm3hhfHD+L32ytD
	ZTI9mK3o39VDfp0x00yMD36d3BNRJWEYFK2GkYacGLOwpQXQ1Rm3hDICHUm2/+tU5GErDuJW1OI
	+JD9PZc5DQIEwogw6WbXHZqrliijbS77YxlwbAa1hyy6EheHRTxFXHSy3qD9edhRoOowrIAY46c
	78Xyx9Fyjp09GahIRd2widutkpfe4uLHzzk3lOYEbiL02DJmtZ1RysyG16iaXIbFqQ9Eh3IFyOU
	NquuxisYDEMN0d42OEH8E4Fj9oGjL/ZFuACnJ0PubY1LOWy0hh+7JD3um/xjaIesW1V/lEXDZYd
	VQCnpolzg2L5HWASEBhu7DGjhzpENNfSFucAUrJlrVMffETkIjKQA8YFp70h0Mtmbgip+IUppxq
	ncnZCB6Tp9V1Fm96CyUl29qMdCjOGw2pIa3RY0eoynVOkd0z3LG2yZbEw1vfuSaGISp9NPOxyp2
	AsVpIBsOUQvFHNz/jxVsWZcZALPqHIdnclsD/69YSF0fh9dYuPuNopBHGCv3LvV6oZEZKzQCT5z
	P
X-Received: by 2002:a05:620a:1d01:b0:90f:b39e:ec8 with SMTP id af79cd13be357-915a9ca31fbmr812910085a.17.1780677787521;
        Fri, 05 Jun 2026 09:43:07 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:c5c7:c399:d6f1:93e4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3b637esm916596185a.32.2026.06.05.09.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:43:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 05 Jun 2026 12:43:03 -0400
Subject: [PATCH] ref-filter: restore prefix-scoped iteration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-fix-git-branch-regression-v1-1-02f40ad40929@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBAFf4Xs2U3aio34K8YD1EdZD9XsojEh/
 LsFj5PMzEIGFRhdmoUUHzF5lgr+0FCa+pLBcq9MwYXoojvxKF/OMvOgfUkTK7LCtoo7tOEYR39
 2nafavxRV3t/X25/tPTyQ5m1I6/oDD2e6dn0AAAA=
X-Change-ID: 20260605-fix-git-branch-regression-9e4236f18091
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 ZheNing Hu <adlternative@gmail.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1780677786; l=6428;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=eMzrPhMaT1x0XjuCZl+EPfRGsihioVbm65GhzCDMmWc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOzjGQSVkTuapyErrZsct6eJFMjV5YIl25/PTGUZ7VWMszNtCuUGNOAJ0hFyaINPgWms48Bnr0x
 tbNTluEjQYQ0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Commit dabecb9db2 (for-each-ref: introduce a '--start-after' option,
2025-07-15) changed single-kind branch, remote-tracking branch, and tag
enumeration in do_filter_refs() from constructing an iterator with the
namespace prefix to constructing an unscoped iterator and applying the
prefix with ref_iterator_seek().

Before that change, refs_for_each_fullref_in() passed the namespace
prefix during iterator construction. That helper has since been
replaced by refs_for_each_ref_ext().

The files backend primes its loose-ref cache for the construction
prefix before it opens packed refs. An empty construction prefix
therefore reads every loose ref, and a later seek cannot undo that I/O.
Consequently, git branch, git branch --remotes, and git tag scale with
unrelated loose refs.

Patrick Steinhardt observed during review that iterator construction
and seeking accepted similar strings but assigned them different state
semantics. Junio C Hamano then pointed out that no current command can
combine start_after with this single-kind path, but future branch or
tag support would need to keep the namespace while moving the cursor.

Keep the existing start_after path unchanged. The iterator API cannot
currently seek to one string while retaining another as its prefix:
an unflagged seek clears the prefix, while REF_ITERATOR_SEEK_SET_PREFIX
replaces it with the seek string.

For the commands affected by this regression, which do not set
start_after, pass the namespace prefix during iterator construction so
that loose refs are scoped before the packed-refs snapshot is opened.
This fixes the current regression without deleting the ref-filter state
discussed during review or changing its dormant behavior.

Add REFFILES-gated performance cases with one branch, one
remote-tracking branch, one tag, and 10,000 unrelated loose refs. The
benchmarks were run with:

    GIT_PERF_REPEAT_COUNT=5 GIT_PERF_MAKE_OPTS=-j8 \
        t/perf/run a89346e34a . -- p6300-for-each-ref.sh

The following are the best of five runs, with each run invoking the
command ten times. Times are elapsed seconds with user and system CPU
seconds in parentheses:

                                  a89346e34a       this commit
  branch                       2.74(0.13+2.56)   0.11(0.04+0.04)
  branch --remotes             2.81(0.13+2.62)   0.12(0.04+0.04)
  tag                          3.01(0.14+2.82)   0.11(0.04+0.04)

Both revisions used the default -O2 build flags and a config.mak
containing only "NO_REGEX = NeedsStartEnd". They were built with Apple
clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6)
with a 16-core Apple M4 Max (12 performance and four efficiency cores)
and 128 GB RAM.

Link: https://lore.kernel.org/git/aGZidwwlToWThkn8@pks.im/
Link: https://lore.kernel.org/git/xmqqikjq7s16.fsf@gitster.g/
Fixes: dabecb9db2b2 ("for-each-ref: introduce a '--start-after' option")
Assisted-by: Codex gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
The series is based on a89346e34a (maint) because the regression has
been present in released versions since Git 2.51.0.
---
 ref-filter.c                 | 30 +++++++++++++++++++++---------
 t/perf/p6300-for-each-ref.sh | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1da4c0e60d..2388a57b39 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3315,19 +3315,31 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, refs_for
 		prefix = "refs/tags/";
 
 	if (prefix) {
-		struct ref_iterator *iter;
+		if (filter->start_after) {
+			struct ref_iterator *iter;
 
-		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
-					       "", NULL, 0, 0);
+			iter = refs_ref_iterator_begin(
+				get_main_ref_store(the_repository), "", NULL, 0,
+				0);
 
-		if (filter->start_after)
 			ret = start_ref_iterator_after(iter, filter->start_after);
-		else
-			ret = ref_iterator_seek(iter, prefix,
-						REF_ITERATOR_SEEK_SET_PREFIX);
+			if (!ret)
+				ret = do_for_each_ref_iterator(iter, fn,
+							       cb_data);
+		} else {
+			/*
+			 * Pass the prefix during construction because the files
+			 * backend primes loose refs before a later seek can
+			 * narrow the iterator.
+			 */
+			struct refs_for_each_ref_options opts = {
+				.prefix = prefix,
+			};
 
-		if (!ret)
-			ret = do_for_each_ref_iterator(iter, fn, cb_data);
+			ret = refs_for_each_ref_ext(
+				get_main_ref_store(the_repository), fn, cb_data,
+				&opts);
+		}
 	} else if (filter->kind & FILTER_REFS_REGULAR) {
 		ret = for_each_fullref_in_pattern(filter, fn, cb_data);
 	}
diff --git a/t/perf/p6300-for-each-ref.sh b/t/perf/p6300-for-each-ref.sh
index fa7289c752..ed9c1c6a19 100755
--- a/t/perf/p6300-for-each-ref.sh
+++ b/t/perf/p6300-for-each-ref.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='performance of for-each-ref'
+test_description='performance of ref-filter users'
 . ./perf-lib.sh
 
 test_perf_fresh_repo
@@ -84,4 +84,41 @@ test_expect_success 'pack refs' '
 '
 run_tests "packed"
 
+test_expect_success REFFILES 'setup many unrelated loose refs' '
+	git init scoped &&
+	test_commit -C scoped --no-tag base &&
+	test_seq $ref_count_per_type |
+		sed "s,.*,update refs/custom/unrelated_& HEAD," |
+		git -C scoped update-ref --stdin &&
+	git -C scoped update-ref refs/remotes/origin/main HEAD &&
+	git -C scoped update-ref refs/tags/only HEAD
+'
+
+test_perf "branch (many unrelated loose refs)" --prereq REFFILES "
+	(
+		cd scoped &&
+		for i in \$(test_seq $test_iteration_count); do
+			git branch --format='%(refname)' >/dev/null
+		done
+	)
+"
+
+test_perf "branch --remotes (many unrelated loose refs)" --prereq REFFILES "
+	(
+		cd scoped &&
+		for i in \$(test_seq $test_iteration_count); do
+			git branch --remotes --format='%(refname)' >/dev/null
+		done
+	)
+"
+
+test_perf "tag (many unrelated loose refs)" --prereq REFFILES "
+	(
+		cd scoped &&
+		for i in \$(test_seq $test_iteration_count); do
+			git tag --format='%(refname)' >/dev/null
+		done
+	)
+"
+
 test_done

---
base-commit: a89346e34a937f001e5d397ee62224e3e9852040
change-id: 20260605-fix-git-branch-regression-9e4236f18091

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

