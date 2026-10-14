Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C324F0539
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978781; cv=none; b=O6J+3mxySX7dySIlalmiAlJ/f158d650MAo/olMseZ46QAl6/diSP9ghpMKGmmDSnjz8Ic495rcSsI/s55YyReBIwrzN2hDCVYqj5LvMCgB7OEQPYNFa1OxLmU3f0YcXwwql/dKyOAuCIos4YYl4smKT9uULwQUaNcSghaQCTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978781; c=relaxed/simple;
	bh=gtm3Il+GxuGzqaS5DaZwhJGsDOVObtf0CA25/XR7/aE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=h3PIafjsPZp9Ew2MNLoXQP2v5D5d0QWLdYoURS1kJDERd0rdqhRyQTLHqAA253Nybij3L9oh2S07D0GYWeIwt0/3fBPxMXWoaPoJ36Hrnj0EqyygtAXsaLoGF3IINUuRz36ty7wvp0sUw2WAL4zbRDOQFGIevu2qneWrf50fV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6BH8KF3; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6BH8KF3"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6df1eeb43feso1693611eaf.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791978771; x=1792583571; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QtZRTxmJueNVzY+VlFaTRvlHY0Z/ZHbvXl3G0h2wBQM=;
        b=m6BH8KF3L/4kzRwmAtt6slSbZfKV+D7TdFeZZkE0CwWu0bNgbnA0/qdHhmwyKkWbi7
         Y8m3xOSeboEcpqZFrsPllQBxSARefk2utzXA944h+KY7RzHfGmdAdQokMEHRMwC4JVdv
         KV1+cEGX3ahPZW0kiw4U1pbBIq6nWYFNv1WGuOCoTTi0429MaW9KyNJYZHt5miOg9J1r
         A1LaPWc96u83Rong3o8HRc4PySVcQ089v5GDOWGKRelMHv7mPEYAO4GjDg65Cip9gNhT
         /CG7zsINz+zi/QICHAiw4akDL6DvobtN9BL3vNu3iAJPRRTlqd4Dnp7jrhyJxUQhjmgb
         2hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791978771; x=1792583571;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QtZRTxmJueNVzY+VlFaTRvlHY0Z/ZHbvXl3G0h2wBQM=;
        b=NqiCWqro0PjPZMywGZcHKyT8bKZLmSmRCjskqVxlF2wDHQUsppxnlNssNEoKGX1k6z
         UmmnvuwAZ5B+QNUBDMi8a5wWex5eqmr5U0lJC6YcwnlrMha+LJkbhgwAM4vSoQEoCtNP
         /CNXXkR3UB4v5cLBwv5wFpSS998QgDkI0ZO2Q0b94MiXwnDQBKuzGFd8JvK1vV8413wG
         kQDuDkzIVq0dXSASEJmwoDNICEux7dqDVFS0KM+OdZIpm++EwBEc/2j1YwaC4Ck4o1UR
         +3KnXWznP7LzdCbbyMu+zUx0PHfjboUUpNN/mbbz2WL9WD65UBT4BWNdioA+2Oztv6U/
         0RXw==
X-Gm-Message-State: AFq9FYLC7ahxKn5ofiVOLARiNajqJ/+r7nH1OZDY1FFwupSOmTnoALSI
	C7ZIUFjStKiRstfgjyL0sbGA/EYHKX2Ga8UAQz5RXsz9Q6N4A63t9i0gFD/jqQ==
X-Gm-Gg: AYBFou1ojZH/9rFBegB3N4/o2HTi4e+x+nlc33ldTPP8lEzR5wKKZgrCSgdvlent4Vf
	ADowlaSqmoCwpQuRG92tpxApqtr8Zea0nRcpxU0Eas1eX8dKBnpb8mVL185x/ecP7clHLmRwzSn
	xJJAVXLcfEnkgYYUx+jtlhMFuWELkJ88Tw/o9PVCC+lC0kqOy3LXWbXlRChl7rqY+ISV08Zx4Ig
	AYvYa8k2yVgRZcS63iXL7yOC6CSXICeH+phPRPn23DQgpR9lR3cNPMo9oa8myQkFzeSXTihVxkV
	+xPrsNQACywqDJQ4ok1kot/4bjVbtHRU5QaO3PYiYrzvlE9X8ZsHPxJWekDyiB3YMZS7VFaOPtz
	OxckypSWhmQ9Lr2afOZC6nczSIdmrL2YDIFBt+wx+O1IynFW44LP72tWkupDda+rM4ZdZCk1BPC
	le26A7paXtUB3WAaVhwVEAlBdlqDPRPQYWo+0XNPxDwlumLjdjvMqh4tgQD5DG9f9kpgIjWp6VR
	Z31
X-Received: by 2002:a05:6820:4d09:b0:6c0:7620:fccf with SMTP id 006d021491bc7-6ef0f3ada9cmr10367474eaf.57.1791978771332;
        Wed, 14 Oct 2026 04:52:51 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.22])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6fa292f6ad6sm3344821eaf.9.2026.10.14.04.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:52:49 -0700 (PDT)
Message-Id: <pull.2256.git.1791978767497.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 11:52:47 +0000
Subject: [PATCH] t2030: modernize test path checks
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
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith Poojary <poojarysrujith@gmail.com>

From: Srujith Poojary <poojarysrujith@gmail.com>

Replace old-style file checks with test_path_is_file and the helper
test_path_is_missing for clearer failure diagnostics in test output.

Search with: git grep "test -[efd]" t/

Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
---
    t2030: modernize test path checks

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2256%2Fpoojarysrujith%2Fmicroproject-modernize-path-check-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2256/poojarysrujith/microproject-modernize-path-check-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2256

 t/t2030-unresolve-info.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 9af24b1204..56a7f849d6 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -170,7 +170,7 @@ test_expect_success 'rerere and rerere forget' '
 	git rerere &&
 	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
 	rerere_id=${rerere_id%/postimage} &&
-	test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_file .git/rr-cache/$rerere_id/postimage &&
 	git checkout -m fi/le &&
 	echo resurrect the conflict &&
 	test_grep "^=======" fi/le &&
@@ -182,7 +182,7 @@ test_expect_success 'rerere and rerere forget' '
 	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
 	test -z "$(git ls-files -u)" &&
 	git rerere forget fi/le &&
-	! test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_missing .git/rr-cache/$rerere_id/postimage &&
 	tr "\0" "\n" <.git/MERGE_RR >actual &&
 	echo "$rerere_id	fi/le" >expect &&
 	test_cmp expect actual

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
