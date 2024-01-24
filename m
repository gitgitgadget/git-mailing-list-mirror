Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1B710795
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706077986; cv=none; b=MG5CkZwNVYsK87PfphVGHapgTRsWf+ShwWKm103rHq5myKqCk/LR0N7edDon/3iQqvmxhjVDIKbzlUDGXycWcDsTw+hygjYY2/UaAiCwAwhx36wT8D07RJ2Ys50p6YyvOiuhknUrzqg8SaZZRBUlXnpNxbcPWss40m5EuxCZC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706077986; c=relaxed/simple;
	bh=QyBVBpGqzEkdyBD+m60M6mCx/+Hijtz0b0aUjkTX6vg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ee4AmopuSnhnQWdUhNkGsA3HrLN/8ZvPoQYDasQTv7OkrDq6ucCc57s4MGQHBaMPKTR2iIOwQzk4ovlwNfgolMITahALu6/XgBRkrqwjy5ZlYuJGA7686p1Ad0uieL/2znTqlP6dKfrCPrhlTPHdVm2A3dJ6S9Y0kL/AJOkPCFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY78U6VM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY78U6VM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eb95bd2c6so18845065e9.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 22:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706077982; x=1706682782; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFUuDRMK6lRJgQHWjMHJxA9NKvU8uge5I2xEFNb+Ub8=;
        b=AY78U6VMUFQLp1+q6ok/rbcX411x1T1IvLUL2amecBr0BWutoTqMgh0JX47Gsblmif
         0sj/2Mkqy8yRDQ7LBM9XNSyDUp7aF/WKXM806mj8QTC0LMClz84AcZbSva6seR0LsU0j
         dj+X5bC1LbmvRdAzW5JR9E5SeKhY2oM2LBih+FmKXN8FJWGqJyLiU7YEBQbrlcnHMes+
         V8pVDdDtMr7vrNPZRahGpgAi7F99jXU/zPIaW5piKihQQrmchAc+f4xEacm/itthXnpr
         0wJqRcBGLPuA/IkVWd1g+A6hw1qEK9YvdTEiKmSpsS/0cWIf4cef8D4Y02czEzD47WQO
         u/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706077982; x=1706682782;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFUuDRMK6lRJgQHWjMHJxA9NKvU8uge5I2xEFNb+Ub8=;
        b=k0r1Rqm5GhzN1WiM/K9YwS2zlf4gqYuXI7lReDjPwakJz/pDmBAhMcYcD72emI8b1x
         0AGy68RcYmlWCszIM3XyaPJG/MECNIN7uyPxoFfi7UDBUy1EXxV16Y0W1niHuS1ImNPV
         fkzy9GGt5Df0aADh++WvPjdBUR3kl6ksBO5SXXLR78SZVJnfnB8y274Vn9vmAn9lGKnV
         DIgV9NfpxrTuDx3QM8SSAi9dOfb2qSSoU2PvNqqTo1WVpOJNdWfetEjPVM7G8rnjRuBp
         Ts8ijKUPXVZGAlSMVijxJf/Ub63brWs8STn8RCjagWRZqm5ni4QVjF2hLTqyf2uURSR4
         XLZQ==
X-Gm-Message-State: AOJu0YxrWqKIpSdFv912th7IwMV0r52zQG1Q89wbEu06oLGu/ZreOBte
	LBnsmrGisFeilI7A206RXFDd93Wlt2/tbdyQK2MU6ZA3aMvP0VKSMmgZuxzL
X-Google-Smtp-Source: AGHT+IEMgCiC1uAUJu4w291h6STgQ9GYxmIldjKwwmrdkJs6W4uQ/MFqo3Ex5183HMqz4NXp3j8jPw==
X-Received: by 2002:a05:600c:4f96:b0:40e:a2e8:4a15 with SMTP id n22-20020a05600c4f9600b0040ea2e84a15mr827636wmq.6.1706077980247;
        Tue, 23 Jan 2024 22:33:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b0040e9f7dadc6sm16898788wms.25.2024.01.23.22.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:32:59 -0800 (PST)
Message-ID: <f3a03d68211bc79b41562762c8ca63889b9218b2.1706077977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v2.git.1706077977.gitgitgadget@gmail.com>
References: <pull.1646.git.1705913519.gitgitgadget@gmail.com>
	<pull.1646.v2.git.1706077977.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 06:32:57 +0000
Subject: [PATCH v2 2/2] patch-id: replace `atoi()` with `strtol_i_updated()`
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
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe23@gmail.com>

From: Mohit Marathe <mohitmarathe23@gmail.com>

The change is made to improve the error-handling capabilities
during the conversion of string representations to integers.
The `strtol_i_updated(` function offers a more robust mechanism for
converting strings to integers by providing enhanced error
detection. Unlike `atoi(`, `strtol_i_updated(` allows the code to
differentiate between a valid conversion and an invalid one,
offering better resilience against potential issues such as
reading hunk header of a corrupted patch.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 builtin/patch-id.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3894d2b9706..e513b6aed3f 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
@@ -29,13 +30,15 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 {
 	static const char digits[] = "0123456789";
 	const char *q, *r;
+	char *endp;
 	int n;
 
 	q = p + 4;
 	n = strspn(q, digits);
 	if (q[n] == ',') {
 		q += n + 1;
-		*p_before = atoi(q);
+		if (strtol_i_updated(q, 10, p_before, &endp) != 0)
+			return 0;
 		n = strspn(q, digits);
 	} else {
 		*p_before = 1;
@@ -48,7 +51,8 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	n = strspn(r, digits);
 	if (r[n] == ',') {
 		r += n + 1;
-		*p_after = atoi(r);
+		if (strtol_i_updated(r, 10, p_after, &endp) != 0)
+			return 0;
 		n = strspn(r, digits);
 	} else {
 		*p_after = 1;
-- 
gitgitgadget
