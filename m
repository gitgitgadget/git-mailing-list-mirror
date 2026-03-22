Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0218FDBE
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774183596; cv=none; b=CfpueOdbOjiafkDxS8/WwnozQEMsvD6B+eXJexCgtLxz98yzAt93RAzlasOlHZgLcb32qhGnJYvfzrprkLqRLPjxMyivYQM4XrDOlr6gJWUX+Ae+VLWExLbFzkiX0EOgcJ+EmEs43WbrsjZxt2VM+kRt9l5EMrdrk28G3edWjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774183596; c=relaxed/simple;
	bh=F6xwBCK9bsSWVFEboSV+jthhWmF1yykc20u0lHoDrzc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yl89RtNJZCt4NdsOWJqv9GBHf6Y34+WTsvVxi4qNC0w0mYoKFwWO7RpdyZ2nGMUU7XUCoSXkaRl4DSCpRcTx/aI8O9R9oO0B/bOjiaNxkSB6CwWpmuEj4spCN/cDIFXAzVTu8iLpdlOj7IzSlWpGw/rjRtyHs0dSVrRDFMN3Ri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/rzBlgI; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/rzBlgI"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1273349c56bso2691285c88.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774183594; x=1774788394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOfCSs2ap0hdtXWmX6n520tPjYpHs2ppZ+kBfqoYyTs=;
        b=C/rzBlgIT8dNfjHRl6LoO/miicgVBQV983sPgOragaM9y3dhpYQl/dp7GjRrB/ak5g
         QteVXuEbIcil2VFeNa5rKeSctkpPADPVNNoAAGxhlsGJMWDgUJDPBqmrIZcAYNAjLAM0
         j4bf/NPe4qUZrJcUoDW7cNw7zSoIlAS1bDYOL/3L0sgh5k/4MHXg4+ehRym4KzyFp2jL
         /vqQ/pXDN0YoYsw5HJ8RNLVCzbnLBirnboY+FMTfTymCcq5TWIOTtzj6ORLLQuVcvp3t
         8I2tqi5MadN8ZAyvd6GbTa9jBxrL1sINxzj5yDbUJgwAVy+fqMdUMr15PqeQrBIAMnb2
         66+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774183594; x=1774788394;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yOfCSs2ap0hdtXWmX6n520tPjYpHs2ppZ+kBfqoYyTs=;
        b=Agyo3iq8y+L4YnYB4aFETcecQiuwuUSQrqqTuyt/xGwylh9CxO5oPvOplOwUS3D51s
         /b2I5HkPp12Nj5hsQVOnBGcs/CEd0/KpIn+8x9ZCSUdQK+PwkNZsp3wmXd091Pgl97HP
         vbhcxaPg2HFfA9hhh1MEjA7/Myu7JKZKkn+2/hxEEf7bgXF9QZbY6E30aamTHXlW11IS
         llZ00od4SN3rtSKF0+Lh2Pj6RHX+LEeKuVaYw+OgEp0B6dCrIG2CHh7v0gxcuP03IbF5
         TWM4jaCcraJ26HKLB5Qh4x2ITU+8uKGumwSkqMxTi35H20DEuir6aSbNsfvueKtnoOXw
         fezQ==
X-Gm-Message-State: AOJu0Ywh/MMPKfw7s4ckcM9V4uSbj/2yF3Xb485foBpOqlzpvtQWJCt4
	96NOuiAl+0JNUOypBysjtcHQZvPy24JFzj3HkMVEsWDZZKdYg5NmcjuGqlpHww==
X-Gm-Gg: ATEYQzwYZFX3kc7AngdXReSoktobOKFU9dcOJ2WuKNYQgrk5/DTHebUXS1YsAuYw8qZ
	jzMr4c+iErPC5OWVJ35xxA4fhygk5eauia9izYPr99VRlF/fEfwk7vb9XKPA15V0TKE4jZOW0Qf
	09Q67J2+d4krsutJltEtrJvMSYJ5k8fDL+Xh4dCtAXrJnnTAI1GEpD0IE6o0/YqFgntz5rPJhb2
	+ZiXrO8m9dbapPYQfPPVF7rwPgk1bWdDQC6JUzIc2vXo9zOZbWwh8Wihaovd7z1U8UeNpX73Qsh
	iWqfmtpxz2/kxhwt6ItCUJB6GbtBoC7hi/D4Pd5FeLuwiP5Q6ubsHfiKtGEC+FLRMSOLRd/m7Cu
	KM4zloxXEDZCGY25Zw6XVTvc5TyMLKFCuX1fkdXD2inu+LoUMDZ8iZLIsogJ6DTA6evn1YQuXht
	0fO/OxxahqHPQHWl0CsxoGc6eOoMw=
X-Received: by 2002:a05:7022:4582:b0:12a:6c84:6039 with SMTP id a92af1059eb24-12a726dd70amr3688811c88.41.1774183594235;
        Sun, 22 Mar 2026 05:46:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a734bbb57sm7289024c88.10.2026.03.22.05.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 05:46:32 -0700 (PDT)
Message-Id: <6f71fb3e9a39d8cec62bbbc83e53543be40feef1.1774183586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2247.git.git.1774183586.gitgitgadget@gmail.com>
References: <pull.2247.git.git.1774183586.gitgitgadget@gmail.com>
From: "jayesh0104 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Mar 2026 12:46:26 +0000
Subject: [PATCH 2/2] t/pack-refs-tests: drop '-f' from test_path_is_missing
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
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    jayesh0104 <jayeshdaga99@gmail.com>

From: jayesh0104 <jayeshdaga99@gmail.com>

test_path_is_missing expects exactly one argument: the path to
check for absence. Passing '-f' is incorrect and results in
"bug in the test script: 1 param" during test execution.

The '-f' flag appears to have been carried over from the
equivalent 'test -f' usage, but test_path_is_missing does not
accept such flags.

Remove the extraneous '-f' to use the helper correctly and
restore proper test behavior.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
 t/pack-refs-tests.sh | 6 ------
 1 file changed, 6 deletions(-)
 mode change 100755 => 100644 t/pack-refs-tests.sh

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
old mode 100755
new mode 100644
index 8a0c955647..4a85d96c6b
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -1,9 +1,3 @@
-#!/bin/sh
-
-test_description='test pack-refs'
-
-. ./test-lib.sh
-
 pack_refs=${pack_refs:-pack-refs}
 
 test_expect_success 'enable reflogs' '
-- 
gitgitgadget
