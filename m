Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B214A4F0
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 02:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972504; cv=none; b=fposJNkaSsbT2EVSwE6oQ80TaUgAXN9yQSlmf9/Rk5vGuhe0WDO94XWBUMQEyG6gVBwoEc3O0oVMM2iULqz6VWQKH3rL2usrQqFKMDYYPtH3Ens2PyPNxK/JlDwfJBEpj3Uy91f5YH/Ig6Rmk2UMYUJEZhTfqY9jh3AsW+RedQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972504; c=relaxed/simple;
	bh=1dw5myZgtVsC4+IhzoxDnxhbbrWSiQn1gkScsnOhpZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aYejSlU5LuSkKalp3+T06xc709ZhaJQz2LXUPbAKeUI0zSndj1T2ahTX0UY85tiXhaRhF+SkrCPKNw8kmu74XHX9JpP/ey9b6kUCQ8cMDW7i3qMToz5arBOaaKLr5ePRFUDuuIBUAzS8iGbmJCp8cOHjpo157qxQ42HhbJ9h5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYHcv6yL; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYHcv6yL"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-915b5ce94c7so358034685a.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 19:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780972502; x=1781577302; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga1gS/NrU3FShmraikP8Pq3BJgM6411O5rTNKDW+rXo=;
        b=fYHcv6yLlVTsKnLLBFqOTC1+MspvVNIfRgzesdhr67gLjIIQr3zfi1c38T4ANL4kep
         Yed+GHQr7U6q5WlDToSegw7mBcDnJ/karbSnseIe5jlV6/6DtCTQrTn/bW5oAiMul70H
         djWDdcETj4Yjv/hxqPxqQgNcCr5Vq4pXH2xhwKQYTF0XA87Pf5kip4vhJ90Ex76HZM+G
         J+ccv9JDDl7GJwOF9Wd5FDiBCKtY+wgdam33Qp5Eaz0OMZd+K9A02ISQEFWbWFP5kmNt
         XHMnU/m+uvQjpO+2fH0rxG6LA9Zj4nwQLI/zY5BugZ2FYIRTrZ0IkOe6YKVhv4r3wW5K
         P2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780972502; x=1781577302;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ga1gS/NrU3FShmraikP8Pq3BJgM6411O5rTNKDW+rXo=;
        b=sKBLPNJNdzzbRGEKyo+qOElYZnrH2apt+m5lEK6EcOx2a+cu+IzMpEPFN+vMr8fNli
         PgkibMjkLwaqQVziWFC10ZX5UBnQYT8joVurE9709OwcSinUrYzfpXnPeTugZIVZMzEe
         0eUGmk3sVFAOEF7ehrBH00gMA979nhNxUYDTP0x8ZQh0arbymyBK9j7f7J3/qTCQx+KN
         Y6wo2KG1rQE7kd3P0e+SlBA2LyZfTTe5XbI3WF3qZzhfpaI7n9SRV81lKamGROuX/E+2
         u1yJTTx1KvskYKD2k7GURvHLxlOERuXW7ca6Tl6vMXbn3U/BTr0fRq/PFpQ2WZWFgafR
         ZZXA==
X-Gm-Message-State: AOJu0YzE16VZC1LRyGnDpcA7904rpxvAQHppogIvKjBhU0+Ddr1AJcHf
	L7hUdM0thnDnPf92ChiNBk2dX+TIpwTy8UM1m8shNh4Y++7DhT9AlMTV
X-Gm-Gg: Acq92OFVW9pwHJJA2ZKFY5VEGoxRsFs5V+mP2BM1ZgkD+J4uwbor9x3+eWDU4VO6WfL
	+BCKGNLe9WuAuXQT5BXamNjefGn4ZtzPD2TkAMasyJpA/LoFBzFLW5+dwwMrDICKGf1LwkIjdJF
	0bM5mWn9SdcL16v/tDZScXNah1jPxqb3nNy3iXgvku+9dbLPrq2IgoFTXhdVRSIzd0fZFNewRx5
	OmlBWa5RcabATB5mQc//GZVIYR/gjOOXH5MJmqiJQtULffZuapRYea/lohkCKYdc2hI6ZiqDuC7
	TgEUc6rqUfFVLTMh9DDexf6ru0DEMnpD6xPGcfmWFCNLS4scsB5zMT5UThsZj8klfSq8DXkyDes
	Gu1f9AxKsuxTyF/Ay7PBQeYQVQXZuAPZL96L+ArBMbUEH81AG498j1ediYy6GswUcJjNi/dZbEu
	XBMximNroLjp5ttvBI8MLhDBGPyM2bLGEgu2JNveag0HMTFqdpFcXf0KTTyj7cNTD7RVJ0diBV+
	H2VaJmheN/SMMjbe8OzHhzeD1B1TYB6G4d1tCZOPZaTbF4mN1xLhT61S/OASmU9BjWqTBLKwCM6
	02mdfZHmYqPBIUPltRcoGqzEj0+TcY1gQO//h14+FWVI9TBSZyBVxPV0+WEgd7Ht+w==
X-Received: by 2002:a05:620a:298c:b0:915:c76f:26e0 with SMTP id af79cd13be357-915c76f2789mr1528724685a.18.1780972501414;
        Mon, 08 Jun 2026 19:35:01 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a402ff9sm1972931885a.45.2026.06.08.19.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:35:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 08 Jun 2026 19:34:57 -0700
Subject: [PATCH v2] ref-filter: restore prefix-scoped iteration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-fix-git-branch-regression-v2-1-fd82075a8520@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dsy0IrGuvIdhUcpQxiiYKRIN4
 e62eAGXL3n//UVFEqaozsWihGaOPA4JzK5QvndDIOA2sTJoKqzwCB2/IfAEjbjB9yAUhGJegaX
 SHKpOn9BqlfZPoSRv7Wv94/hqbuSnHMxGz3Ea5bOdzzp7//zMGjSg6Up0bYnW2Et4OL7v/fhQ9
 bquX9Qq6cDUAAAA
X-Change-ID: 20260605-fix-git-branch-regression-9e4236f18091
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 ZheNing Hu <adlternative@gmail.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1780972499; l=6570;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=1dw5myZgtVsC4+IhzoxDnxhbbrWSiQn1gkScsnOhpZ4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLF/edtdbiO7XCIv5mzuUppRJQ2wqjlV/NMKB8WRfIJUuco5q7mUsuQzNIXWe8eKOzNbweJVEbG
 jDRPCx96yEA8=
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
Changes in v2:
- Extract local variable `store`.
- Link to v1: https://patch.msgid.link/20260605-fix-git-branch-regression-v1-1-02f40ad40929@gmail.com
---
 ref-filter.c                 | 28 +++++++++++++++++++---------
 t/perf/p6300-for-each-ref.sh | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1da4c0e60d..5cbc007d64 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3315,19 +3315,29 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, refs_for
 		prefix = "refs/tags/";
 
 	if (prefix) {
-		struct ref_iterator *iter;
+		struct ref_store *store = get_main_ref_store(the_repository);
 
-		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
-					       "", NULL, 0, 0);
+		if (filter->start_after) {
+			struct ref_iterator *iter;
+
+			iter = refs_ref_iterator_begin(store, "", NULL, 0, 0);
 
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
+			ret = refs_for_each_ref_ext(store, fn, cb_data, &opts);
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

