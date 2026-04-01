Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33776299923
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070041; cv=none; b=Ddwf56Hafn56tO1eG+yOia5bSRSfxplZE8IOtdl2ERlHl24rGp4wK3GKQbgEdmy5v1eorWw7RT90GKTHxATXoOx+WnV4v0KPZr0kBVLgFtTy7XJk1tcAaEOUc9T4Heak3PanvTY5OfT+CQX0rBdiR7p1HlanSoiDPh3BI2BmNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070041; c=relaxed/simple;
	bh=fAqaxBks7ukLtFnG84kNNRvAS6ua6/KvR8apCcbcZO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7v2bwyve04AYljDgZus/8QlACIzwNvTHJlJ52+N0obsykaKYLwRPAH/+Fw52nduX3rHZSLtzlQj7fdbbku3//T62ZU0I/MvbQgNV5KoKzWB5+vuTzf4Oxsbo7wpPw88tDrrdS+E8OWjDbHIO1IWplKz6Xzorlub/D/LHzq6g5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clbGup5I; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clbGup5I"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46704fbf62dso51002b6e.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775070038; x=1775674838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap4J4QJOTClpRGQYFQqhAQDLKBqJORZISrOm49L/ooA=;
        b=clbGup5IXCzH1b1rvy4uYTanvFPaOUd0jGbYsawXr0f7b1tiVtykyEC8MJ949dXBYU
         UiorLoLnFz4XwlH5uhOAsQMN4GrONeMUMCj7IEsfxDy991uJOZw9Us7hfvdXmZW+i5EN
         9lK5A+HJingo8o4oiFjY/JAsyo1WdxobCICTm3UapFZNFPLMuoUK6pn7xyziyNRTxSMj
         b1SM3w2GEhHYuf7T5ZmXgXsLZH+ABkHzjPbBdyyPalkjApnn1N4LGnaUpy89u97Ti/j9
         LWIVWCfNCoHumR/Qt4JxUOGajVJXoIQdhsr3Iw6Su1i16uL+DFnjvWW+BXbPGqL1j3eG
         wrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775070038; x=1775674838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ap4J4QJOTClpRGQYFQqhAQDLKBqJORZISrOm49L/ooA=;
        b=Oz9EUroP2GywTpefF0MqK5bVtMcp/G2t7Ny5hnx9CHwR/TYaNIra2F3g5EV0RuSczY
         Q0CSl58jOtlD7EyleqE5F7t8zQBDsGPpIrXiqglHHfUm2I6vgGtkUXFxtK7WVTGfL4oh
         MdX5l2Mu5t8mbmjwJqmLQEnip4lIvxDD/gQnc7mVutBfzLT3qlCmCivsd/WM7SE+hx2p
         kgIQnd5GG+xLrZ0s20wFxFVZS2C8MCkYdiYPB9J2XnaHZibpzlbLmVwzKV8zUkoX7oia
         Qzu3YnSxHB99/rrRH+2LeeW3u4Awcw7zWxIPb5q2YVKKOMJcTzgtSwTxXiTJUb2mIqXM
         oPMg==
X-Gm-Message-State: AOJu0YyRZAyqhBLFfbUJMh1rnYFLcRP0D2dCcq9OTMbf8VvD+PQrT30+
	/J1IMqYWtLAx1RnBfB3rTJ6vcNyCP2VChQl6VtQoWSroHd24juqNn4MdXQXzlm+Q
X-Gm-Gg: ATEYQzwoouUvgN16CI5YVXY1Wfp952DZ6oKV2qXdrE9ZGU/P+KLb0RIRGd9k58xXQIW
	BF/Vd8u7/LXGcOu8ffuLDxTVPMeNHPqtCzogc0JxSuAZ4W+f3/WTVrGfQMh9cKf8afWoYm3wA4a
	w3vdSDDdV3m07LgGJpw994AJLu2tnwPxxvbgnDLcaFvCBBY+TB6M61RUyVqg2/pc5L6hvPEnEhP
	FCmjTCLJEb9MXfEgAKG0iTVPAgzOujnx0RdWKI8tuODL/YllM+AwOPeJz1iES6dXqm8Fl8HJTok
	Zz5sblEtjDURqfdphl6dgZBqlMIZZ62i91/itMZST2zJ3+dnEChgGpgpv1R7OQca69qcZ3Quh0W
	/TrBIe/zVyS3fiRdV3V9oK++7MADBotD/r1t94pVauTKy1aJHCfiHVmm7Md3dFZ29YH8m+bqbYO
	Z0A9uDgCHjvakiZZQDpNXO3mQv/b+7h3DpCDcxHzviGCCBRxJV5DQYXllPEAI=
X-Received: by 2002:a05:6808:14d3:b0:467:26e4:728e with SMTP id 5614622812f47-46ae01f57bdmr2780447b6e.49.1775070038471;
        Wed, 01 Apr 2026 12:00:38 -0700 (PDT)
Received: from Mac.attlocal.net.net ([2600:1702:74a1:4770:a4f1:5ce8:780f:fe5c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d8d109b69sm263217b6e.0.2026.04.01.12.00.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 12:00:37 -0700 (PDT)
From: Nick Golden <blindmansion@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Nick Golden <blindmansion@gmail.com>
Subject: [PATCH v2] read-cache: disable renames in add_files_to_cache
Date: Wed,  1 Apr 2026 15:00:33 -0400
Message-ID: <20260401190033.11325-1-blindmansion@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAF6hZH5TyFBm5H_fcVyaf1aw-mPsVbAmNvkUGCMoQYYCX1+HRQ@mail.gmail.com>
References: <CAF6hZH5TyFBm5H_fcVyaf1aw-mPsVbAmNvkUGCMoQYYCX1+HRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_files_to_cache() refreshes the index from worktree changes and does
not need rename detection. When unmerged entries and a deleted stage-0
path are present together, rename detection can pair them and rewrite an
unmerged diff pair to point at the deleted path.

That later makes "git commit -a" and "git add -u" try to stat the
deleted path and die with "unable to stat". Disable rename detection in
this callback-driven staging path and add a regression test covering the
crash.

Signed-off-by: Nick Golden <blindmansion@gmail.com>
---
Changes since v1:
- use sed instead of perl in the regression test
- shorten the sample line content
- stop asserting that stderr is empty
- simplify the final ls-files check
- use real name and add Signed-off-by

 read-cache.c          |  1 +
 t/t2200-add-update.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 5049f9b..d938abc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4049,6 +4049,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
 	rev.diffopt.flags.override_submodule_config = 1;
+	rev.diffopt.detect_rename = 0; /* staging worktree changes does not need renames */
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 
 	/*
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 06e83d3..0a96655 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -200,6 +200,44 @@ test_expect_success 'add -u resolves unmerged paths' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -u avoids rename pairing on unmerged paths' '
+	test_create_repo rename-crash &&
+	(
+		cd rename-crash &&
+		test_seq 1 100 |
+		sed "s/.*/line &: same text/" >conflict.txt &&
+		cp conflict.txt bystander.txt &&
+		git add conflict.txt bystander.txt &&
+		git commit -m "initial: two files with identical content" &&
+		main_branch=$(git symbolic-ref --short HEAD) &&
+		git checkout -b feature &&
+		sed "s/^line 50:.*/line 50: FEATURE/" \
+			conflict.txt >conflict.txt.tmp &&
+		mv conflict.txt.tmp conflict.txt &&
+		git add conflict.txt &&
+		git commit -m "feature: modify line 50" &&
+		git checkout "$main_branch" &&
+		sed "s/^line 50:.*/line 50: MAIN/" \
+			conflict.txt >conflict.txt.tmp &&
+		mv conflict.txt.tmp conflict.txt &&
+		git add conflict.txt &&
+		git commit -m "main: modify line 50 differently" &&
+		test_must_fail git merge feature &&
+		rm bystander.txt &&
+		git add -u >out &&
+		test_must_be_empty out &&
+		git ls-files -u >actual &&
+		test_must_be_empty actual &&
+		git ls-files bystander.txt conflict.txt >actual &&
+		cat >expect <<-\EOF &&
+		conflict.txt
+		EOF
+		test_cmp expect actual &&
+		git diff-files --name-only >actual &&
+		test_must_be_empty actual
+	)
+'
+
 test_expect_success '"add -u non-existent" should fail' '
 	test_must_fail git add -u non-existent &&
 	git ls-files >actual &&
-- 
2.53.0

