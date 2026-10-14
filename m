Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CB372ED5
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974127; cv=none; b=cOahR9WNMJjh1ZYjEA4R3kk6rGvs/6pG3cOsfz4H5bksRKhTDUlSO5EVeikEvPHxJOwmGMkY+yqcD4HFp4peDWMES2wvG9zeIHP6mdsF90+HYjzfQu8/rHT3L4u5sbwGIjS6wCd2ke8lTYslJWbYvQhOHE6q0u6ntsR3BWfCadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974127; c=relaxed/simple;
	bh=OXlLLl7JNMUVgl9rp7s3V/asOw+iLRCovzC2PjG9bKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPJ0lVq86+bu7OuIJeEdEVD25wu5r0+IhfUbt6FOcPFAG4mKvQSyArGfrqIPMiYKNzyk67lBLTkH26MX9LHPcukOOAmIkJTU0q8obVWOTn3Cet6ceE5FqkrDxM7ZZfGO36+DysuqO+BwHQwMNjjHu/c7xDbr2FiuUqA2WdkEV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com; spf=pass smtp.mailfrom=gitlab.com; dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b=VF5lEeY4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b="VF5lEeY4"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48afbd2c386so2306805f8f.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google; t=1791974124; x=1792578924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6txDFyST2NhfxZs9jBGSUgWxXHVvBsFGhLy951kNvNA=;
        b=VF5lEeY4SwdPCWXWg2rh4lX1rRqBBTTOsoCb2IUyTJa66/9mJss/yc8RZOfqirJxUO
         uvBu0ianPnHcZhE1gcGbfROKM90jQSPt+XAVywimesPKllePt7pfBfifAHwjeKTSu3IU
         1k+NDbWWKAZq1Q1/ZA0Iu+X2EuM5HQ6KCFpFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791974124; x=1792578924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6txDFyST2NhfxZs9jBGSUgWxXHVvBsFGhLy951kNvNA=;
        b=kQo3H0MboF6bQDQjyCrOAbcQzdYkgLryojlJNU5zT+S/jBqMWB2U2y5m7HGv54qrZD
         mCUmpKhsYlnOz2B5kPEUlkoQoLr2IPKzpcV4me8KEHqR7+STbhhIg2BPwualaRbJoyVp
         tKx7TrlRJg1YK00g5j2GxFDSbZxrRzi3pNOaxftfa4QI0LNPaEolyu4LM6n6qC7MUYZq
         COmw+qmnOeBdQVBPStF6WzPBR/dHC59GhiQyAa0q01Sy9ayoeT4UVGOTSC6ukx4ue5CS
         O0+bouqh5I1mJjndqSbj0bYCDA4d2l8hMUu0qDX1bkUe72+PSDvpJCK6ljulugdPvcK/
         +2qg==
X-Gm-Message-State: AFq9FYIb8yO8SaGk/+EsH6cQI4Bm0rsdE8yCDcbdPueNiC+rw8oxnB+n
	dcfDj9pywXtcQarS41QvGVUxUp9F/3tZTfcRgSw+g3lqzBczod4b9rsXGlVPghv9vh6zfcyy6T7
	COYzJmKA=
X-Gm-Gg: AYBFou0cZw0UcOoHvlF6Bvt4gMiYUX/7NvKfDrgrGNYSV8wWN3ni7v6k1toPTadxLvx
	6O9p7xpP+9utrx0wDDvodFbvXj7DKC+KqFz++Pr31Q+txf8g3WpnMl5WsDeOs5aEmNXrb8CzOfj
	ZZY7z9Lv52WzNz38kfPddFms/FxNsMbqxa248LS9RRAyeVQ3UBAeDtqBrv3WUkHlsGndI2p1w++
	35I6Nh3w4bUJpnMrmBnCIOn5zqCRvHrwBBxjbRsligJHc0I5kvn2P+bz43fv86GR2ljLydnJJAt
	oLwllJzLJH3W11KxugXx87GLxUx61Dh1Aqnc2hpNNblTgZfJkOR01cmU4YqFG4Bov1zjlJE9qSp
	V4ZOFRb4UbXC0Tc+Y3WA0NZX/gee10JeYWorxnhZQScJryti4J36qZ/1o7/pE1bgqkVwFW17WDO
	Whmw+36191vYBkWmrmVLJ4d9qC9SEfZB9zbZyIDLUeyrmHgz90fcNkbrp3vAl9K6VlSNWZ/5dz2
	rh984kbYgL3ynunG7Lpmflsj+WD9QCWpSnobQ==
X-Received: by 2002:a05:6000:490a:b0:48c:490a:336b with SMTP id ffacd0b85a97d-48dba7bea0bmr28710229f8f.5.1791974123788;
        Wed, 14 Oct 2026 03:35:23 -0700 (PDT)
Received: from iwiedler--20220823-X3P9M ([2001:9e8:a86:1382:f12e:5410:6774:61fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967bf5sm10613331f8f.5.2026.10.14.03.35.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 03:35:22 -0700 (PDT)
From: Igor Wiedler <iwiedler@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Igor Wiedler <iwiedler@gitlab.com>
Subject: [PATCH] connected: do not walk alternate refs in deepening fetches
Date: Wed, 14 Oct 2026 12:35:07 +0200
Message-ID: <20261014103507.35317-1-iwiedler@gitlab.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The connectivity check spawned by check_connected() uses

  git rev-list --objects --stdin --not --all --quiet --alternate-refs

where 39b44ba771 (check_everything_connected: assume alternate ref
tips are valid, 2019-07-01) added "--alternate-refs" so that the walk
from the fetched tips stops at the refs of any alternate object store,
on the assumption that the alternate is already fully connected.

That only works because "--alternate-refs" comes after "--not".
cf1e7c0770 (fetch-pack: write shallow, then check connectivity,
2018-07-02) drops "--not --all" for deepening fetches, since those
need to verify the whole chain up to the new shallow boundary rather
than stopping at refs we already had. For such fetches we therefore
run

  git --shallow-file ... rev-list --objects --stdin --quiet --alternate-refs

with the alternate's refs as positive revisions, and rev-list
enumerates every object reachable from them. Unless one of those refs
happens to lie inside the newly fetched shallow range, where the
grafts cut the walk short, that is the alternate's entire history.

This is slow for setups that attach a large alternate to a fresh
repository and then do a shallow fetch of a ref that is a few commits
ahead of the alternate, which is how CI runners share a clone of a
big repository between jobs. With a 7M-object alternate (a bare clone
of gitlab-org/gitlab), "git fetch --depth 1" transfers an empty pack
in under a second and the connectivity check then takes 227s. Without
the walk over the alternate's history the same rev-list finishes in
0.0s.

Move "--alternate-refs" into the non-deepening branch next to "--not
--all", so that a deepening fetch walks the fetched tips down to the
new shallow boundary without looking at the alternate's refs at all.
Negating them instead would stop the walk at the alternate's tips,
but the reasoning of cf1e7c0770 applies to them as well: an alternate
that is itself shallow, or a partial clone, has refs without the
history behind them. fetch-pack sends the alternate's refs as "have"s
in that case too, so the server omits everything behind them, and a
check that stops at those refs does not notice that the objects
between the alternate's boundary and the new one are missing. The walk
down to the boundary is bounded by the depth, so this does not bring
back the full history walk, and objects that exist only in the
alternate are still found through the object store.

Add tests to t5618 that check the arguments of the rev-list child via
GIT_TRACE2_EVENT for a regular and for a deepening fetch. The result
of the check is the same either way for a complete alternate, so
there is no behavioural difference to assert on. The difference is
only in which objects are walked.

Signed-off-by: Igor Wiedler <iwiedler@gitlab.com>
---
 connected.c               |  2 +-
 t/t5618-alternate-refs.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/connected.c b/connected.c
index 929b9bd28d..d8bfb3dbf2 100644
--- a/connected.c
+++ b/connected.c
@@ -127,9 +127,9 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 			strvec_pushf(&rev_list.args, "--exclude-hidden=%s",
 				     opt->exclude_hidden_refs_section);
 		strvec_push(&rev_list.args, "--all");
+		strvec_push(&rev_list.args, "--alternate-refs");
 	}
 	strvec_push(&rev_list.args, "--quiet");
-	strvec_push(&rev_list.args, "--alternate-refs");
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=%s",
 			     _("Checking connectivity"));
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 2fb6d549d3..237eaba85c 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -58,4 +58,17 @@ test_expect_success 'log --source shows .alternate marker' '
 	test_cmp expect actual
 '
 
+test_expect_success 'connectivity check of a fetch excludes alternate refs' '
+	GIT_TRACE2_EVENT="$PWD/fetch.trace" git fetch origin &&
+	test_subcommand_flex git rev-list --objects --stdin --not --all \
+		--alternate-refs --quiet <fetch.trace
+'
+
+test_expect_success 'connectivity check of a deepening fetch ignores alternate refs' '
+	GIT_TRACE2_EVENT="$PWD/deepen.trace" git fetch --depth=1 origin one &&
+	test_subcommand_flex git rev-list --objects --stdin --quiet <deepen.trace &&
+	test_subcommand_flex ! git rev-list --objects --stdin --alternate-refs \
+		<deepen.trace
+'
+
 test_done

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.56.0

