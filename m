Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5051C322
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985536; cv=none; b=MnYvn0f+Ta2Flat23s5QZNDISyJ+YL0dKssqV+aQFdd6uKNC9ok2HMLZuIv29Su6yCPVqoE8MhUnoAwUqz9YOT7eExok3G3388spqhAMFeXhoU+3n1ZvICfKipaaSDvxbFsEbSk7F62PKf6cfFtoB05tOD6r9Ul4yWRS8FcW8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985536; c=relaxed/simple;
	bh=0dzU+mb7g1i2cgAC+8O9NviYQ3hRExxF6n84vCa3Koc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tby0y7gXpwP4bvzQWJWTniuUbH2ApZ/a90LV12JUZIGyFZjSNB0LghU4kWYLWSUPf/hsqGEFJpU46UOYQ9Tz4w2OUbAspDBNNE1PamGc1BXXoiX+wvIxWIjrn2WNMq4QaYmRlOol8vbcPT2Hq09v3F5Ps5gmngYuGnOVuvtdkJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMJU9wnG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMJU9wnG"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48c45111bebso2539273f8f.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791985533; x=1792590333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jEQ9yRnlCtcahXqvJtdpM0NFjMP8mp8Ed5zgtVcIH5M=;
        b=bMJU9wnGxUriZtvbE6RBituwpyvMFbDyM6wbsDaHBvu4WjCwunDL1DPlV9wsKuD5na
         EK9Smj3Q53ewWcKXNCDr2yKy1Rxfb68tqkw3P4ELs45yjWpOVST18rR2kwqc4U8XrKZb
         VyxIttIcWzSu+ORDDUjOXjlAV8t5eQhQwCAhzUyHjA5TDs8GPDkOPUhRfRtB3tF6yXwS
         7jhUTcNicKsjhLjUlH6OrnzG/FojSaD2Br7fSiWCn85ze1imevkiGafjXiNHUvPBlbay
         /vKzOaPMWib5wrF1i6eHC4e69i/1bz6qnfdV9ZX8b8WD17GRsVZwKEIQxGqbxHKwZ5lo
         Jqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985533; x=1792590333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jEQ9yRnlCtcahXqvJtdpM0NFjMP8mp8Ed5zgtVcIH5M=;
        b=DOZrZky5KLiEHyYgHPwANihGjDS/ingcb8MFHJyADAww1Or+2pbqNlqRMFMDwcsSed
         guOjk0JIFajj6KK0f7AfhzZ3UwjZafiDMF4KY2FNl40C7yJC0tCwoj0eNlrAjsJWOD0w
         nZkyy2j6cPW5Z5VwDMQvlTyRLfEFOhkalF449KADUx3ls646+w8UMYJdWhM/1TUNkrzo
         LLAIVWN8Ju4LH8QrTl9ITwZ0lD2aueVn/qZMhFeMvDuX7U++6p0JPbRe+gphVzuXI8n7
         PypbvFIvnqCMhl3fY3BEv3R459Qm1EUoTSzDTSzY3hbIDv1LK6a2UDeKSmnsugFw0KVt
         Y29w==
X-Gm-Message-State: AFq9FYJQuUzQ0uq24OjgcQGX2PuPJ7O3doIKwjy7g43HOhduZlJnYpce
	Q3XP/41XHpYhtPUXI5zEdNttfI/iMTbCI6qV4alMTADogv+Gi5cgobWk2dexPg==
X-Gm-Gg: AYBFou2x6s6QTWuMqvu398RmdumIQ+QhuCeDjPoaF/npcm3k5uAI7vsZ47EkcCDt0gj
	C+JS3YZBeZQXw1XX2+WHP9COKWLEeNoM5mSwNeKVM4L0Mtd7KnG2Hl6GClkjTcSg51fi+ZkvlTt
	kkPvWaiaif1HiHmODniLz3xV7Gf3uhfnUZx/nkEz8QjIa8CGRBxeZQ1g/n/8O9UoEnqQTDjrHbX
	xHilQ8bEVFhPMLzgPqg+Aj1vRqgyR2s6PnahXDzl1lt8o5DKRNRJ4csfiXjZat0Ai88XgCW1beB
	RSpZIDv+ZGFrgEQ9TbxmIJKqiOJO32V+toz8Ot5bi3Ef2q16ZZPY4NfUrdyYfyrUYQQyCj4tSk4
	SWTN5G9IUDse3G6CBUGZc25CSt/5miRof7yiQ7T9P/WiIxJd1CO4tPN0scJVSlYQqNLD8gEvAaR
	OC9o2ULTdV+vU3Vmjxhp0QEgy67tee15NFed5FMxuo6lZdAJXpGF+DL4r/loxoIA+X/Cmq+VVqR
	Ql4D+w4XOiaL5hGAgMmbnoXB1cQcPrzmMMKe2GvdUDk
X-Received: by 2002:a05:6000:184e:b0:48b:10af:f85c with SMTP id ffacd0b85a97d-48dbaceba34mr28618418f8f.37.1791985532909;
        Wed, 14 Oct 2026 06:45:32 -0700 (PDT)
Received: from Stealth.zuku.co.ke ([197.237.143.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7003982sm9334303f8f.8.2026.10.14.06.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:45:32 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: git@vger.kernel.org
Cc: kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com,
	Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: [Outreachy PATCH 2/2] t0410: keep git's exit code in test_grep calls
Date: Wed, 14 Oct 2026 16:45:04 +0300
Message-Id: <20261014134504.1152225-3-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
References: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'rev-list stops traversal at missing and promised tree' test passes
"$(git -C repo rev-parse ...)" directly to test_grep. t/README says
not to use command substitution in a way that discards git's exit
code: the && chain only sees test_grep's exit code, so a failure in
git is not caught there.

Assign the rev-parse output to variables first and pass those to
test_grep instead.

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
 t/t0410-partial-clone.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a24b663f73..57da830105 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -413,9 +413,13 @@ test_expect_success 'rev-list stops traversal at missing and promised tree' '
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
-	test_grep $(git -C repo rev-parse foo) out &&
+
+	FOO=$(git -C repo rev-parse foo) &&
+	HEAD_OID=$(git -C repo rev-parse HEAD) &&
+
+	test_grep "$FOO" out &&
 	test_grep ! $TREE out &&
-	test_grep $(git -C repo rev-parse HEAD) out &&
+	test_grep "$HEAD_OID" out &&
 	test_grep ! $TREE2 out
 '
 
-- 
2.34.1

