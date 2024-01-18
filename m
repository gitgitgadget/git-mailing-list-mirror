Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892F2907
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542926; cv=none; b=KLRIfAn6NPSvChKt8OEDa2Ha4aPSsn2otzhpMGsSK9sMWZu8SyWvH5C4AM6ejyN9wNCKlg2ehKRmpD381+4XITDyo1wS0X/uhLciRCVknd0etr88NSiANztV0FCB9Ok7dIr4db+R43js8+tHRo19hQnCXON5yJxlaU4poMHCF1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542926; c=relaxed/simple;
	bh=3NNrQZpl/NffJJraBIZAsKYiBiMV6KKZNyx3HcAHqrk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=vGQTPKtpxyRwt6elr5cCjCURBbY1X8pMgc/rO89zCiTaT/rXWk+pTR+rSiCAx5w5Sp0K75L6F2/nVReSp/nt9GWmMeaLCO2U/TeLONWZ8lhpiOsa+fJuCD6b2gre7eBSPI2A/rIaj6gd7q+ujO//zigfhVt9b1xwAtswDZDIXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipoF3ypQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipoF3ypQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-337bea8682dso1729376f8f.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 17:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542923; x=1706147723; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxW2/4NI8M1WRQA7E9YTtofRKir2GzW3+QI5y4KHHBs=;
        b=ipoF3ypQvJ3oPXrs4XbAs/2V7jyLe4yAylLxAkvPq2aqCbZSdfiUzGfrxJWh+rt09i
         VX9tAxMvbsxo2XZ1Tw834vXPNP+KiUBqMBYG7Ti+nje41KGg8NdLR4xxaBeYWzk2WlYr
         l/vKqeFnmdctj5EPuhxqBDA7M4A3NBAFBvK/Snzv+c/hKdkOtR9OSW9f57uFr8cd33Dt
         O/RgqXZyV4Y7Z+FihPq4vETaJwrtRWdJgI2F2bWYo2nDPxdQfz4Co4YZ2L3DO/mF7qCA
         ZBIbpHLlDPH5YvXlqH0rDsEr0sidzUX+aVwYZ1gKpOSHOOrO61f9NAkhSolI+QgLqIMK
         a0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542923; x=1706147723;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxW2/4NI8M1WRQA7E9YTtofRKir2GzW3+QI5y4KHHBs=;
        b=DHVzO2MFbXjKH4xfFuSmQd/MXI6msh02iKXEmC32tNyFL5HZHUw5LDGl7qzr3DzYbi
         5Z0SEYaUMs1IatsRgZiICrdSDVgvdyHW8i/FqocuZ0xkSAM7jfc5/NbITsJyz1vHxO3j
         AEwtbPBF+GZoF7cG8qgc1Iy0h9uKbcfj8fFpX+Ghw1JbtUv6plBGdNpbo21Wv/uyXUxp
         m3MWhRTImpZarQWZ4U09cbRQ/JPwugQNYcA/7kVlx0AhajdREcil8Ehe9sBsnf/OvIuj
         hx0xQ0oDJam8xxm/w2mFcya7E60OMiZq4hr4lwWMU9kZcLIQHZXFdTSt6zVXCdZHi/+j
         b5Mg==
X-Gm-Message-State: AOJu0YwYyRApzNLeVnDG/yWDFjb4nVxR1XyKj1cEuxjZywcfeJM/PxZa
	M5D6QpmZBLvTbdRCJkYaxEuOdGF3aoiAIV54KErXzVljlr7zhIV/55DU6FwT
X-Google-Smtp-Source: AGHT+IE2BOYBTJmsWCU7nzxhsylmFthElVy+XRrgpJtbk/l9ijZf1osEqDz/kGI4WNQ5q/SlmVXnbQ==
X-Received: by 2002:adf:e946:0:b0:337:bcdf:2dd5 with SMTP id m6-20020adfe946000000b00337bcdf2dd5mr61918wrn.16.1705542923066;
        Wed, 17 Jan 2024 17:55:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12-20020adfe88c000000b00337be3b02aasm2818016wrm.100.2024.01.17.17.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:55:22 -0800 (PST)
Message-ID: <b79b1a7178076be1d1a80212dfabd3c37587d443.1705542918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 01:55:18 +0000
Subject: [PATCH v2 4/4] submodule-config.c: strengthen URL fsck check
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Update the validation of "curl URL" submodule URLs (i.e. those that specify
an "http[s]" or "ftp[s]" protocol) in 'check_submodule_url()' to catch more
invalid URLs. The existing validation using 'credential_from_url_gently()'
parses certain URLs incorrectly, leading to invalid submodule URLs passing
'git fsck' checks. Conversely, 'url_normalize()' - used to validate remote
URLs in 'remote_get()' - correctly identifies the invalid URLs missed by
'credential_from_url_gently()'.

To catch more invalid cases, replace 'credential_from_url_gently()' with
'url_normalize()' followed by a 'url_decode()' and a check for newlines
(mirroring 'check_url_component()' in the 'credential_from_url_gently()'
validation).

Signed-off-by: Victoria Dye <vdye@github.com>
---
 submodule-config.c          | 16 +++++++++++-----
 t/t7450-bad-git-dotfiles.sh | 11 +----------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 3b295e9f89c..54130f6a385 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -15,7 +15,7 @@
 #include "thread-utils.h"
 #include "tree-walk.h"
 #include "url.h"
-#include "credential.h"
+#include "urlmatch.h"
 
 /*
  * submodule cache lookup structure
@@ -350,12 +350,18 @@ int check_submodule_url(const char *url)
 	}
 
 	else if (url_to_curl_url(url, &curl_url)) {
-		struct credential c = CREDENTIAL_INIT;
 		int ret = 0;
-		if (credential_from_url_gently(&c, curl_url, 1) ||
-		    !*c.host)
+		char *normalized = url_normalize(curl_url, NULL);
+		if (normalized) {
+			char *decoded = url_decode(normalized);
+			if (strchr(decoded, '\n'))
+				ret = -1;
+			free(normalized);
+			free(decoded);
+		} else {
 			ret = -1;
-		credential_clear(&c);
+		}
+
 		return ret;
 	}
 
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index c73b1c92ecc..46d4fb0354b 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -63,6 +63,7 @@ test_expect_success 'check urls' '
 	./%0ahost=example.com/foo.git
 	https://one.example.com/evil?%0ahost=two.example.com
 	https:///example.com/foo.git
+	http://example.com:test/foo.git
 	https::example.com/foo.git
 	http:::example.com/foo.git
 	EOF
@@ -70,16 +71,6 @@ test_expect_success 'check urls' '
 	test_cmp expect actual
 '
 
-# NEEDSWORK: the URL checked here is not valid (and will not work as a remote if
-# a user attempts to clone it), but the fsck check passes.
-test_expect_failure 'url check misses invalid cases' '
-	test-tool submodule check-url >actual <<-\EOF &&
-	http://example.com:test/foo.git
-	EOF
-
-	test_must_be_empty actual
-'
-
 test_expect_success 'create innocent subrepo' '
 	git init innocent &&
 	git -C innocent commit --allow-empty -m foo
-- 
gitgitgadget
