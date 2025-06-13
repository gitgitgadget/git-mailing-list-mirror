Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA72DA779
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749802227; cv=none; b=Mw5/L10hNcxEFJuPqT7zPhWSEsZeXWpn6r09TPrn3nr48Dp4wbp+2OCUsowo74L+iVeqmpzWQSNQi+qxa9PPKkpfdmGQLnOtzPBfw9tawMJ++Fz0dRZNe4MGiBWRPp8OOL1KWT5sLCEcP8YtJzpn3Synawo1XHQkYznGI8oyEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749802227; c=relaxed/simple;
	bh=WbXjCpPzVlMg/veWMid7cyAOfkl9HaPq/7fAtHB+nrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kK8K19QXBvVfHbWzW4ApiuzXUDDzXQO8s6pWWe4+zvLS4OsR4hpmmjriVHd2Lc7zureYXezHXMI0UY1K8Y9EnXnVidSaOuAak39gCNvF3WE4aPgw4sYj/qNgWBo2YFzyOR4nnhqOfdtl2KyFPbKO1DQMYlUDMTvjzQ2zUxMI5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjobAWnD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjobAWnD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso1153149f8f.0
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749802224; x=1750407024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABqrWlWo5IkJnKbUky5FOgl3RMkGIX7rQBbYykTVxlU=;
        b=HjobAWnDkjsYoH4G375JbeC26CHriWScXLG9TkGy1jryWWb8FCOxECADGcYfe3HnLd
         HL4bg0BgdG8iXwMk4z95JDNdbfeg6Mx85D9ZQ+UFoP6DVWyLoHYwJMJOn/1ZDY5KoRif
         sKBvOMSbc4e2LuIzSPxbdIKeDW+6zg1v7OlwX15iLtIvo5dcgOOYhAkXQvSadM/eWpXT
         9lld2INucEFqL/IlnYsLUCmO7K/61GSCdNmB2UVcKuDAtvgUT2bSPSaiA1frTHz61n66
         ISBoq2w4z2TigrSdPv90LM+wfx14yhyy4DFDzewIOlaApuAA+CdJdgHKJW5UAn2RIcYK
         0Mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749802224; x=1750407024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABqrWlWo5IkJnKbUky5FOgl3RMkGIX7rQBbYykTVxlU=;
        b=jvi2nVI5sBlmVPnyOG4GBzkB0Pq9gj/PrsH4V5gIq3YWHUquKjfleO/9C0XkQFCZA5
         D92WgcztqnOzleGpMQProi4cREBv4vsnGvD58oa8D6OY2nBJxzQOo2/fwyNv6r+ZFBCt
         9jvm6EfDB6TBFugpB0AfwsKCqSNYTUz622g8s7rERGtwFAP7fyln3EYgj+xTwyF3cvPV
         6Bp1H1JeKHB9oFgr/ynMnhldXE1hzbFrJrub7SsE6h8t67YXUaPoqs5k2+iPxDtkBHpT
         7nuISIdG6iduomp8HkVYiCMDCHMLx8DSUh8mgueptMQuTVb/XLJqvdLud4NWouB3wJh0
         OYVQ==
X-Gm-Message-State: AOJu0YwAk0PYjfreG6EjLwY8EX+5OsU8ZHrC++zuUU0CX4zNGxeqm4ku
	NuFniGGy4HFA4QfXs0Okq+EIY1WEs3L2Y6ZmO3pAHe+xjFl3wI7hRzwP
X-Gm-Gg: ASbGncvfSnedudqlvbk8iCJFlCuInXo+mFw7ItEJxcicKoQrkRnc8+/906pOU87Vg+S
	Setv3VorzmnxRDBhrBMmVjaDWF+9wsXz+puT4NodZZP91WHZJQnaps6NFNkx8TbRYc/f5TynDIS
	FfPjk6t9nL8gIlrqYR/s0Z+REbT5SESudp1A4+oGrdvIMx4TrpH9M/t3JCZMYJkrzdlPbu8LNR9
	RCUSgxcB56o9G/CyUZHPwU3mQLDjfS+7Tz4aQpHcMCob9rxSGPSP4poEXp3XCxsfw4yX1fkKaGs
	IZeU4gxDREKHIRbj7QVHO4yru4KRUyREZT+DEys1+KgBXuecSLL3/s32
X-Google-Smtp-Source: AGHT+IGFCc3hNvbIbrvG4P0rH6VhjtwB7U7WIf7dyJOzAEL/cbONCLMt9cEqWSOEhRjBJnMC1EnQrA==
X-Received: by 2002:a05:6000:402a:b0:3a5:2cf3:d6af with SMTP id ffacd0b85a97d-3a56871766dmr1592727f8f.45.1749802224242;
        Fri, 13 Jun 2025 01:10:24 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9a6e:abf0:b0ed:9106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54a63sm1615191f8f.11.2025.06.13.01.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 01:10:23 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 13 Jun 2025 10:10:17 +0200
Subject: [PATCH v4 1/2] refs/files: skip updates with errors in batched
 updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-1-ebf53edb9795@gmail.com>
References: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com>
In-Reply-To: <20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3525; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WbXjCpPzVlMg/veWMid7cyAOfkl9HaPq/7fAtHB+nrQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhL3O6q8kfEdIldw07dZHBpE3hp1L33zblTv
 9VMThGSZwlbdIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoS9zuAAoJED7VnySO
 Rox/DdUL/RQA0LtFnUWIC519geLz39KAMcCCrA2vFTijAiSIQ5EcJuet3+mYkum9kfo2hIMAHEU
 xiCrFTX9eO/tS2Qm9CIqcHmFW/gHkskYR0kT+QFbMYbedNif5EffjSySwB+pBGlxs1OAkXDqCwC
 /+fDlA29OjcdGXQLcTorEZnQ3QdJJM9+yJRO20HzxviFYXcyff5R5+I4GIlxeXd4C4zJYyOPXrK
 vT1qtIJYHA9eX5CtEtdAEwJ/6n1uEYQZu1TUdn+zqGRSGDOma0Dt0o6auJ70oPn7Pjk4mbVaYX5
 fW5tU/t8NsKB8STx1T6LsC5wZzPx0nWBJo72exM0d2ODoOlA99GbtHPUT0pQlAMCuZH/Q9wx29k
 Mxl1DH9uedZXXaIUp63+E62QqGIq+sNUw2zNUzTzSp1+4Z75foo5uvGd30cJ+iuQuL6t7YOfapo
 FszYEtNfjoAwxj3HlL6FllSFZODzIfRkzjZ0KHPa5M3juK8agrHE0wTFBtG6Bl2NiRaTf6AeHp7
 O4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit 23fc8e4f61 (refs: implement batch reference update support,
2025-04-08) introduced support for batched reference updates. This
allows users to batch updates together, while allowing some of the
updates to fail.

Under the hood, batched updates use the reference transaction mechanism.
Each update which fails is marked as such. Any failed updates must be
skipped over in the rest of the code, as they wouldn't apply any more.
In two of the loops within 'files_transaction_finish()' of the files
backend, the failed updates aren't skipped over. This can cause a
SEGFAULT otherwise. Add the missing skips and a test to validate the
same.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c  |  7 +++++++
 t/t1400-update-ref.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4d1f65a57a..c4a0f29072 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3208,6 +3208,10 @@ static int files_transaction_finish(struct ref_store *ref_store,
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+
+		if (update->rejection_err)
+			continue;
+
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
 		    !(update->flags & REF_IS_PRUNING)) {
@@ -3239,6 +3243,9 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 		struct ref_lock *lock = update->backend_data;
 
+		if (update->rejection_err)
+			continue;
+
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY)) {
 			update->flags |= REF_DELETED_RMDIR;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d29d23cb89..ca7eee7de2 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2299,6 +2299,51 @@ do
 			test_grep -q "refname conflict" stdout
 		)
 	'
+
+	test_expect_success "stdin $type batch-updates delete incorrect symbolic ref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit c1 &&
+			head=$(git rev-parse HEAD) &&
+			git symbolic-ref refs/heads/symbolic refs/heads/non-existent &&
+
+			format_command $type "delete refs/heads/symbolic" "$head" >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			test_grep "reference does not exist" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates delete with incorrect old_oid" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit c1 &&
+			git branch new-branch &&
+			test_commit c2 &&
+			head=$(git rev-parse HEAD) &&
+
+			format_command $type "delete refs/heads/new-branch" "$head" >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			test_grep "incorrect old value provided" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates delete non-existent ref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit commit &&
+			head=$(git rev-parse HEAD) &&
+
+			format_command $type "delete refs/heads/non-existent" "$head" >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			test_grep "reference does not exist" stdout
+		)
+	'
 done
 
 test_expect_success 'update-ref should also create reflog for HEAD' '

-- 
2.49.0

