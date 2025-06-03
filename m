Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0A2C3253
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990766; cv=none; b=Z2mKiM3gNdAjiX9Yl0qhgibW/uE9iaTmHKLdJ60c9aYEL33lZd2Nm4C+4x31gZ6BpsSiEhtnQpVOCRcWsRCyccgOHgj52ILsv3AYXIJ/KzkJcSIoFbKycEhAxr22NNmhoFmfX5fHpMt0KwopaoZAOijurExpcGMrNI+TZ4nhEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990766; c=relaxed/simple;
	bh=O5efQ/w0SizGTJfIRRnPJvVBwgdEeFsqntJwUEtek7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjWnesQ/4KG9+STQybTEtAgM3nibEWN6LqyyrBwnF1YmzaWtlPcb9mlDcNdmwyQXCn0ULA03EeUrS7RUOvBZxa56L6gtjDGUzYBD1enfDV8FNfDYzp8ttaDAnq3vMpjJtIEXahIuFed8tZ8RpJq1ABQZ7v4pVBOcNm3f8p3FoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPbqxEBk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPbqxEBk"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311ef4fb549so5403889a91.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748990764; x=1749595564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m+phm3fUfMaRy7SBoeKymLZW1e+tZOzRVMx+WOvm0c=;
        b=SPbqxEBkRhdyK4Tev2PCqiAcz9/oUs8VXmPDmYj4A3Og1qaUB6EkPIDke8rQU3fKCv
         uJO1vL0SjLFdZIZJgNJQdb2/fYM/+RNfC/XJJdAg1hrPSgNKOGOnXM8s6fwo8mc9UQub
         DLw1yC8i2F/QkKhHZCjGpTH+K9Z4ap0T2/YmXMSh1a1+E8J369jRe4NWm9r6DG3Gksxu
         oLp3DOxsBPPVPY10TVf/rZkWbBQ4cu0dF80BAinT3NiBZ/d/38oXDezdIQZydm8uPJ8c
         gavDpvUAGmE0HS/HwMBiAJih+bqvU2ky1qqEtW+GCiC1xfsdUAXOAFslM19rez4HuIKB
         V6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748990764; x=1749595564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2m+phm3fUfMaRy7SBoeKymLZW1e+tZOzRVMx+WOvm0c=;
        b=ujb8s0AGkR7JYLncQGoSXezOsL56OkhVD1HouL9+2FJT3VxvfTctYwsGncaeWIENJW
         9iDGFavOVln6WPu2ZoQqLbd0Wgh9ErwNItnAX79FEB5XT38S+WU+/ule11PYUya7lpi0
         z3cfOW+rZT7n8X+uI1exnELoDdMAlOo6zWLPNDIN96u9MKPwi1PLNoDCbmgcX5zbsUum
         scLaGV6hfu6w4I/VKnkwsXYsk5Yp92i9JE/vl5+ovly733kBfL+vSNjUh8wueTEZrdnW
         2Vnimt7ss6Zx+uGOJlnjKllyFpCXaji/xVh9Qm/WDyI7T0RT9IRj0TVT8YPhSgPqimi9
         DQ0w==
X-Gm-Message-State: AOJu0YxR+xxdWUAo1f5MIGkng6fTvZLeFrswjRHdlql4uvvQLg/Ay9vM
	Z15/GChx6+EN6DeIllZiDDeVSKgwEwuprJrnE9wnqNHY78wQOZrhUt4Rz5ziaA==
X-Gm-Gg: ASbGncvWcKED7giUtIGpdzxQ/Gi0PzZLj/OR2y07kcuxVRdZuXVVzxxy4uUvR5hPmhL
	4vUiYPcWd1BKqn6RjNOeEXY0gIa5AFfmhQ8PQ0I2R1GNE+BumVLZI10UQnCnf+s3MualANznr+z
	kG9qTzkx+2KQKSJkfGbLYDSOVAV2IyCK9qd4B2DZkVDXKugvSC5tZfvhKX9YBeLjoJmtoYn1s27
	BLwI++UUCv7KaLWw5qU5e5hod5R5Ys6xYw9XbUw5ueNqYZeMkPm9SV+AZ2RcTAF2HuhlgrMXrD6
	CxvCN/8Qi8j6dA2m72/LupTBVRAKfKgzwwQ8gSeeQS1a
X-Google-Smtp-Source: AGHT+IF4DpjG1a09YeF5qRcGkPLxIe1Momswtdmygd6pbSIuVk+enhvIkZ4JHIsfTBKmsrO5p+amCg==
X-Received: by 2002:a17:90b:3809:b0:313:b1a:3939 with SMTP id 98e67ed59e1d1-313110246c3mr178769a91.15.1748990764381;
        Tue, 03 Jun 2025 15:46:04 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf471asm92308445ad.164.2025.06.03.15.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:46:04 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Collin Funk <collin.funk1@gmail.com>
Subject: [PATCH v2] CodingGuidelines: document formatting of similar config variables.
Date: Tue,  3 Jun 2025 15:45:39 -0700
Message-ID: <802402a288f0976765f1ba1c82d14c2289c8cf72.1748990700.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <45c586122afab8ae3624be6963d64e770b7396b2.1748911713.git.collin.funk1@gmail.com>
References: <45c586122afab8ae3624be6963d64e770b7396b2.1748911713.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that related `git config` variables should be placed
one-per-line instead of separated by commas.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 Documentation/CodingGuidelines | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c1046abfb7..3dd339f802 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -877,6 +877,17 @@ Characters are also surrounded by underscores:
 As a side effect, backquoted placeholders are correctly typeset, but
 this style is not recommended.
 
+ When documenting multiple related `git config` variables, place them on
+ a separate line instead of separating them by commas.  For example, do
+ not write this:
+   `core.var1`, `core.var2`::
+  	Description common to `core.var1` and `core.var2`.
+
+Instead write this:
+   `core.var1`::
+   `core.var2`::
+  	Description common to `core.var1` and `core.var2`.
+
 Synopsis Syntax
 
  The synopsis (a paragraph with [synopsis] attribute) is automatically
-- 
2.49.0

