Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6D9346E71
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332217; cv=none; b=qm7bZBTvo5T7jYtOCfLMScn1iNfAYkBe3PYD2nc1N7UvLOTpe+QKGgZK6QLj76+JbdkJNaJbNl5TfB6cdnO4cZgTGY7lwTV4EBNKVrSusZFT2rvTorrNCvcfUPfuSpY0nSu7UHAPj+PmlqteGAkqX+13zY1vNlXhiYDEzaexM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332217; c=relaxed/simple;
	bh=qcnyIHU7P1yEe/l74/uSE8tKgb+YfzU6iGAgFVl168c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UJICQ08dQ5lU1wZgP9+16SBheG9WE8qomu+50dWsJNwGG6W7IbaUEy7pegqmr/CrHf62t7uw3FI9pS4zG1X/pYz22mVBBoovluI++v/+xzsrzZ0iw3/iDPaHp9jYBmyb/ceHzKWUuq3W3cRFUUiXh3INVRGGh7+w6iWtM/kqKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFkfnFOI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFkfnFOI"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfc5941028so500174285a.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332214; x=1775937014; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoUOOPcjUlOza1IAtYajWPS969AxmLafRaDyxBj/6Qo=;
        b=eFkfnFOIhEAJuGWwHscAZpIEhGW9U6pGinhtxOMTMeCUQanNnjVRWH9UA9CN6irtxf
         drIYjdCtFkfJ1KHpHaTiY73rrb+X9iHuLoELgEbnlNheavXBImr4xzFKTBYKkjT9hy0S
         06azbt0cPFC1+5N3ADfFq8IX333+bzCZtfIBbZIBhPGBMZ0/wLYzt300M0D68hbUk17z
         3z9rpFbhc7Spju/WlScGUjuhYbWDPx4UfC6AqVVxU3MhrdjEaL64fmeZXVFIoZgTfZ8k
         dB/JRYuuSFo61hJwzO/eM132xCSKWadcxZcx1JKT9VWxERcHW1furXFObtTzCAqCAEdp
         mWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332214; x=1775937014;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UoUOOPcjUlOza1IAtYajWPS969AxmLafRaDyxBj/6Qo=;
        b=FeMAp2doI3wD4NEisud/W3WxvufAwt6FP7CnY3+QHIkTVXYv1960IdGfmQQL3MWZRu
         M6/lsAnfOwPNWulVMO4ADT0dgsA+TPJsAlrkVKJ5H4BsV1qRoKrtMJiX1HS4sNQTHFna
         ZonF79spnDGuvpuc/cesDO0kcqoJAuGru94tmojuE0d5sEbPde7b85GDnd1n27IvbVvR
         ozvtDdoJLEHwGxal9aOFX2zh99mlPDhdq5ZLIbmiRr1PejQHKd6zkBJOGBVqO21TE+HF
         5/hS8BCURbMwnPMl8+ugIRw0yXj+co5Nid37AuTz0jgv3qh0T8un70sE3bfL/tfCP/3j
         h08Q==
X-Gm-Message-State: AOJu0YwT+TnhRHySFLU2uCB9TymzNiiEY7Al1jLHbwAp3KIYnMiGb8zQ
	38HV6A+L7jETphdu8dQw36reNbEEyU5Nu+sEzvhFv0KlbByHs0BzMdYZOz5UXURF
X-Gm-Gg: AeBDiesXxPJKnGJdn7YxVL+XRXDQxWCM4G/Ub8ZSvM9OUyxactCz1Wpq/3OJwHqUaX5
	9Z7uil9JlR8w5RsQxg901Xot9EQ1c62GKDiSPo0UKKgPnmZRlD9PPziENDW83O7bAm6viu0Q/gq
	hYpzm6on0Ra6RB3Jy/YJtronbAvpTZnxT3+3l448KCtzEJ78C9wzV8BDSs0sy5NTMTFvNvRH2IM
	xLs6ahP4RZc5DIyew6qzhufk0As7OUeefyvLExj7W3hYw3HxxGFjmwB3oLxddCOgAA+V/MzsAhT
	PgDYjbxTCOP88jOgq6ZFubTzdgO1uFVlRDLh2TNFMPywRKvvjh0YfRLU2Jr0KssziGPaGjJGAZp
	gCubuxxlPOTUCaDvx9fUpCjyaGFx3Dkbvag/F+s/5QzJQEFJJXKRLkdL30osZNhvbxMgypp79O2
	NETWQtpGUtbN1qb0zubFDxAky3q24=
X-Received: by 2002:a05:620a:6ccc:b0:8cf:de1c:edec with SMTP id af79cd13be357-8d41c1c1352mr1110601385a.66.1775332213924;
        Sat, 04 Apr 2026 12:50:13 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5d5a096sm715717685a.19.2026.04.04.12.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:13 -0700 (PDT)
Message-Id: <f09a96e55ddcc95229efe37d2ec495ee40b4110e.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:53 +0000
Subject: [PATCH v2 13/17] t5619: wrap `test_commit_bulk` in `GIT_DIR` subshell
 for bare repo
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To prepare for `safe.bareRepository` defaulting to `explicit` (see
8d1a7448206e), wrap the `test_commit_bulk` call in `(GIT_DIR="$REPO" &&
export GIT_DIR && test_commit_bulk ...)` because `test_commit_bulk -C`
relies on implicit discovery which would fail once the default changes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5619-clone-local-ambiguous-transport.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5619-clone-local-ambiguous-transport.sh b/t/t5619-clone-local-ambiguous-transport.sh
index cce62bf78d..3e9aac9015 100755
--- a/t/t5619-clone-local-ambiguous-transport.sh
+++ b/t/t5619-clone-local-ambiguous-transport.sh
@@ -21,7 +21,7 @@ test_expect_success 'setup' '
 	echo "secret" >sensitive/secret &&
 
 	git init --bare "$REPO" &&
-	test_commit_bulk -C "$REPO" --ref=main 1 &&
+	(GIT_DIR="$REPO" && export GIT_DIR && test_commit_bulk --ref=main 1) &&
 
 	git -C "$REPO" update-ref HEAD main &&
 	git -C "$REPO" update-server-info &&
-- 
gitgitgadget

