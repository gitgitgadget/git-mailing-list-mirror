Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073AE406823
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094603; cv=none; b=gXjQOEc3aZEmVF078ww/8B8pPdaU1dBajiYrUkXeR65X7uypqbwhh/KZekpa+SxOqShWFVBxrXtftNBPykfrzSi46t4ToUHT71iuB1Y3aET0fZPRqIEQDnuv+8iCEI4dqlDcOIsW6oZmM5RT+o6Nqw7Qt/503q2zfjBpbgU0WaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094603; c=relaxed/simple;
	bh=L9Hij3xY8lbJFOZ/NqRlap6wCVTZKtXGulmSAPbtooc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=lUvDranlmp/xG4Yq+ddg/fIQSts9MDGX6PEUc+cbOCv6kc5ukqakYI39YSgl7Ta2Pe55XaNlGFoMXj5PlSmzKjcxoYqpPtOb/l8WrxZAIu0mKLO228sMa9qAPobTCE4OLGupJAqZaPSlIN4ujYX/OJtUjmHwvT5IfdqT7F4fc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qB8Y814+; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qB8Y814+"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1370417c01cso8762714c88.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 05:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781094601; x=1781699401; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4f/bngPTNIeps+1TjQvGBJc3xKhAUD5/7A7R+8HLlss=;
        b=qB8Y814+NPuAQzMmJTPOfPOneNrzf2TGkLqn9ASQ3bchXVMVGG8yduGWVeV5bTYipG
         a31dLyYbN03H1k7bWI04QGzAfxAT4zF21XKdnFV5zz9BFkja34Csd5nBLvwdG/qi0fq/
         TMkkH421nE98q3jm1+hWD1Wd0NRe8XOQZvtCforycWsZP3fGfEuW7HZ3rjJ4FQj0Lp3g
         FFdYFISdWrRyxeWGRsTYNEwnu05T7BHzZrpZgiPIriMRg0nNx5dKjQa7IPEEumgsg2Ib
         ABHpUe/M4auxVdMXCfoqDrGGLa4ClDaMYOtINq+DYiBl6get9lC3Jgo8I8HlwWKeYqbw
         DpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781094601; x=1781699401;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4f/bngPTNIeps+1TjQvGBJc3xKhAUD5/7A7R+8HLlss=;
        b=kZXgoPBAD3cHBFqyqv9W9U3ZQmsphKqAQHZ3PSJLMSBT55vsPl96wcC/uOlPRZWVWH
         G/24ZKElHHNG3yxA6A4j8Xh95RHqUgieKoF5Vhaln4y8t/b0sbCdB8i9OK1zbHKo0TOx
         hnhVcxuL3n4hwEn3gZ2Ih3mXCzEOqYSiXpMW+Pi5DIusmZsLkJjsuczFnSYeotoEh3ao
         ZFDpdO9HTOCSeHcgUm/v1eQwQY9J1TL6zmH48HU+yD6y/7zvv3Oz/pS8SidemTGXHUW4
         R/uI+8RDZhaYknxorDPgfmhjmHMKYMJOjXvGE6WmpTFR+Wd/RNXq4QPG756L5M+lIgRD
         i3MQ==
X-Gm-Message-State: AOJu0Yz2z050FBitUwLHfqnZKoy2oiCgLjL0Yuy0wuozJREeMVkc8l4I
	AV/k5nx7Vyv9xZLQSA7Iwuj+NIL5mURROtkcqLy8gSVPLm7ljDUfXvgYiiqeuGaf
X-Gm-Gg: Acq92OE1URrQp5r3729CApV8GPLIiL56NFlcB+5Zs3XJMhb2iJGIDP+HHGONP0HvE0p
	qJikFr6Sv7mMn9PpRvOh7CJMvGBlYWUDQi0eN/wwWboWQh4SElddDTkUde8U+ZMVupV4BESxqVp
	Mi4RMOlONG/8NqXrNfve7FsOkggPaib1a3VtJdjP5D/W8Dldazjw+q7Z2BK3w70q8GbAwGBWggQ
	uqk2g66V/Oiv8sgQr9YjEQuhcOmIdHyL3YHc6P0v5n/LRv8UqIGzyNECxMqTvj3eFAf43lKewpc
	duAiOkrSfUU8LUnq8inVF1fIQyj9wIT1GW0q0kj6cpsZGMn7e4X+ApwPFstBEiMuQTTvEiApzMm
	6huCykt3LQrB4PxqgUcxdERXrKF0fyvxwPujGWiMYoEzUG/KMVPXKaMXTSdwF6ciO6MnM17I82g
	3NgsDCtTe4k+FrMM5XRyMUXRiJgaaIGQkwa8t/Ir/e8U44YffhsEg9GTm7EFw6I0iFcGOKQSk19
	fSl9KFVijHG4wl0vEJXe/mS6BxEb9cxmasKEaG6vYRxo0IboTrs+PPyIf3oZKNFt68zF1WuCxuK
	vmemeAw6oYKQrRE=
X-Received: by 2002:a05:701b:270e:b0:138:6ef:45c6 with SMTP id a92af1059eb24-13806ef469amr9828576c88.11.1781094600884;
        Wed, 10 Jun 2026 05:30:00 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([12.6.219.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm18972422c88.14.2026.06.10.05.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:30:00 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 10 Jun 2026 05:29:49 -0700
Subject: [PATCH v3] ref-filter: restore prefix-scoped iteration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-fix-git-branch-regression-v3-1-6fd48fad7a53@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Nyw6CMBBFf4V0bc10eEhd+R/GRYEpjFEwLRIN4
 d9tccPKuDzJuefOwpNj8uKYzMLRxJ6HPkC6S0Tdmb4lyU1ggYAFFJBLyy/Z8igrZ/q6k45aRz6
 upKYM08KqErQSYf9wFOS1fb582T+rK9VjDEajYz8O7r2eTyp6//xMSioJaDMwTQYa9am9G77t6
 +Eu4s+E21L5q4ShZJsS4ZCbMkfYlpZl+QCdOHP/HgEAAA==
X-Change-ID: 20260605-fix-git-branch-regression-9e4236f18091
In-Reply-To: <20260608-fix-git-branch-regression-v2-1-fd82075a8520@gmail.com>
References: <20260608-fix-git-branch-regression-v2-1-fd82075a8520@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 ZheNing Hu <adlternative@gmail.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781094599; l=4832;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=L9Hij3xY8lbJFOZ/NqRlap6wCVTZKtXGulmSAPbtooc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGB8MHIDOlANfgtpIFR03n3KAVz+xhl0ScKkNsYLx8Wf0XvfEoirMmqDjMXZOAshIcin5HRXn5Z
 L20vGivyLMAY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

dabecb9db2 (for-each-ref: introduce a '--start-after' option,
2025-07-15) changed branch, remote-tracking branch, and tag enumeration
from constructing an iterator with the namespace prefix to constructing
an unscoped iterator and seeking to the prefix.

The files backend constructs its loose-ref iterator with cache priming
enabled. cache_ref_iterator_begin() immediately applies the construction
prefix through cache_ref_iterator_set_prefix(), reading loose refs
beneath it before packed refs are opened. An empty prefix therefore
reads every loose ref, and a later seek cannot undo that I/O.

For these single-kind filters, construct the iterator with the namespace
prefix when start_after is not set. Keep the existing unscoped
construction for start_after, whose seek position may differ from the
namespace prefix.

With 10,000 unrelated loose refs, the p6300 tests improve as follows:

                         before   after
  branch                  2.74 s   0.11 s
  branch --remotes        2.81 s   0.12 s
  tag                     3.01 s   0.11 s

Link: https://lore.kernel.org/git/aGZidwwlToWThkn8@pks.im/
Link: https://lore.kernel.org/git/xmqqikjq7s16.fsf@gitster.g/
Link: https://lore.kernel.org/r/CAOLa=ZRHKNNymXGk31YgECjUmF9nZ8GsPUdQb7aKBH5DKMz7=w@mail.gmail.com
Fixes: dabecb9db2b2 ("for-each-ref: introduce a '--start-after' option")
Suggested-by: Karthik Nayak <karthik.188@gmail.com>
Assisted-by: Codex gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
The series is based on a89346e34a (maint) because the regression has
been present in released versions since Git 2.51.0.
---
Changes in v3:
- Construct the iterator directly with the namespace prefix.
- Explain when the files backend primes its loose-ref cache.
- Condense the commit message and performance results.
- Link to v2: https://patch.msgid.link/20260608-fix-git-branch-regression-v2-1-fd82075a8520@gmail.com

Changes in v2:
- Extract local variable `store`.
- Link to v1: https://patch.msgid.link/20260605-fix-git-branch-regression-v1-1-02f40ad40929@gmail.com
---
 ref-filter.c                 | 13 ++++++-------
 t/perf/p6300-for-each-ref.sh | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1da4c0e60d..9b04e3af85 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3316,15 +3316,14 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, refs_for
 
 	if (prefix) {
 		struct ref_iterator *iter;
+		struct ref_store *store = get_main_ref_store(the_repository);
 
-		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
-					       "", NULL, 0, 0);
-
-		if (filter->start_after)
+		if (filter->start_after) {
+			iter = refs_ref_iterator_begin(store, "", NULL, 0, 0);
 			ret = start_ref_iterator_after(iter, filter->start_after);
-		else
-			ret = ref_iterator_seek(iter, prefix,
-						REF_ITERATOR_SEEK_SET_PREFIX);
+		} else {
+			iter = refs_ref_iterator_begin(store, prefix, NULL, 0, 0);
+		}
 
 		if (!ret)
 			ret = do_for_each_ref_iterator(iter, fn, cb_data);
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

