Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423AE2C08CF
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250891; cv=none; b=bn6A8SfYGdARBL6s9NUygLKWbLuWQZnZctshzyxJeeDn4tC0VOdyfgXcBIBCaXU1zdSiV9Tz+39xa6mYm3kf5BC0zM9uH2ynMcZs5RvKIDz5mb6O+8TRe0PolOhRdP0t/WFvpzpPpDjnFoauds9m85VEt7VX05t/tSKPwKe1j6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250891; c=relaxed/simple;
	bh=Ew/6BfEg8Y2KTim0iL+rQVPwJ8xATrTq16B/NBwdpvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7XQxv9jvZVZT9BW27zdEeTscte/i4St7eTyOTWI8SfufXotK0HvGLqdJsAYIl3Q1QWCLUGqD01lDsf8FNUYn17Cm7DKni+ixMCz8ybM8X3PhpDfHdJU/c+NtxDgHOE3NZb5pQ/Vc4TgzdG4eTr/Hfqgw3S84pR82cmL8HmFu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFMzZXvR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFMzZXvR"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8298fad2063so88574b3a.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773250890; x=1773855690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvFuMrE7ZIn6u3So/eXVuT/SVWTFfYkdy3x9N1adiX4=;
        b=SFMzZXvRJmjzHxSskCuR8bHWg8o25bUaobGiIpNVdgDCiGXI+Lfs6FyuGDfjcUm66f
         iydVKw8+lI4M3HjGHxOhiAvje3T9VgOdaq1nCovHgSEtdDHlLFpXI2JVaqb3xos0SO+w
         WbUjmpDi+PCk0jEkdL0ZQSJMVOom7dXfZ2wT0CXzvYWj+Fg2Rt0Iw3Ka8LjWeDgk03vX
         XPgFbtVJowp6OihFLnV80rZpd/TkAQIjOTgWAmR93jmhQWXnssANcBqw1hgdLCu+j/Fu
         MjJC7ZQuZ21cI+vobx3p12P17mwYye/AqhTWSBhxqElXVOyFe4hQJHSOITxFPpt/ZOeo
         0nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250890; x=1773855690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zvFuMrE7ZIn6u3So/eXVuT/SVWTFfYkdy3x9N1adiX4=;
        b=YcVSwKuQNu/DDMeZWrIMe1UaSvJ8VacoOGdn4fmJ+Uapfp0lKoQDmgedNFzhCX5U3t
         9tMqKjs0NV307FBoFisRyyYo35JaQ/ZWwXVGrge1F1E+YMmdxOvuIDoLuuYitqXgaGna
         YWZJN7nAT9CvIjUZnGu+3nfX1yjMeLy/ClGyaZYUpKSWyBcUOfFN89bOWAYOs/bRGKgE
         loQNkF8xQKfzRddWz62OwcYQTN5p0wWq0sM7a9f2poh34PFiJT0xFBjWA947SamhRzQN
         go/v4t2aXIGd1Ek5xbLnH8wsT3wKQUH5kmF/uI1dUoLsd0eauG1+wMa7GGD3sPTP2+Tw
         MtaQ==
X-Gm-Message-State: AOJu0YxOXjpdMEvEIV9hvc2EG1iggh4zG8C3iqvCDJm0qTsky96xPik4
	1jqlavCSznHxT64PgyaiBaCYYIUAZUKDH+Px2NhClOVTYjfH+5L8zyBU3YahQNZ0kk8=
X-Gm-Gg: ATEYQzwn8lAMXqpx4JQ/Y7CiaMzkyjOB2fqAWEIPyP/h29s64O2vxc4TEPWG9OgJdiB
	mha7n/yLZdeN2/Ylp8RtKHqCd4w1tHOkRKog85LbzDIRpQpik7spXVnX/ILSPf3onde0+Kf6IkV
	zwXxgWT+XCosIeuhRPz+IcVocU3xPimm0/hgcE7qCuQZhNggWaUhWOH7LfibBt75x4OVbpgMmse
	aTQam0kC66e3HJx03fu3m2CYeNoAvkH7koZSF7YvVhz2KCtCi6F30wYZdN5lpn8JTKVX8bGgWWh
	qeONQHx/5CCPfSpBlS7S5tV7Cmk1Nlb8+1xROe856cBwjMfGkylFMMLc4jGz1Eu78vMaWAtZRgD
	xWmwgTwKzJQEI76SL81z+0WsqccautWJXHEdY/NU9Nvnlc7atnS2kT116KCIwgqQqfwTZ5dTsaK
	eLpqTL+LOaO4xrnLY1752HiuaS6EcwwBMgXcAqhczbd+2ebb0J+aw58hyOFVBpzOuFjOfYE8r7N
	Q==
X-Received: by 2002:a05:6a00:4c0c:b0:7ff:97b3:59bb with SMTP id d2e1a72fcca58-829f6eada71mr3050394b3a.16.1773250889383;
        Wed, 11 Mar 2026 10:41:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:c0d0:e2d9:a48c:9160:564c:f9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07244ab3sm303702b3a.7.2026.03.11.10.41.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 10:41:29 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Subject: [PATCH v2] t3200: replace hardcoded null OID with $ZERO_OID
Date: Wed, 11 Mar 2026 23:11:20 +0530
Message-ID: <20260311174120.76871-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <abFP9vZOVHGI536G@pks.im>
References: <abFP9vZOVHGI536G@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support the SHA-256 transition, replace the hardcoded 40-zero string
in 'git branch --merged' with '$ZERO_OID'. The current 40-character
string causes the test to fail prematurely in SHA-256 environments
because Git identifies a "malformed object name" (due to the 40 vs 64
character mismatch) before it even validates the object type.

By using '$ZERO_OID', we ensure the hash length is always correct for
the active algorithm. Additionally, use 'test_grep' to verify the
"must point to a commit" error message, ensuring the test validates
the object type logic rather than just string syntax.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Changes in V2:
- Updated the test to capture stderr and use 'test_grep' to verify the 
  error message. This ensures the failure is due to the object type 
  check ("must point to a commit") rather than a hash length mismatch.
- Improved the commit message to add detail to the 40 vs 64 character
  mismatch and the "premature failure" in SHA-256.

 t/t3200-branch.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c58e505c43..e7829c2c4b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1494,7 +1494,8 @@ test_expect_success 'refuse --edit-description on unborn branch for now' '
 '
 
 test_expect_success '--merged catches invalid object names' '
-	test_must_fail git branch --merged 0000000000000000000000000000000000000000
+	test_must_fail git branch --merged $ZERO_OID 2>err &&
+	test_grep "must point to a commit" err
 '
 
 test_expect_success '--list during rebase' '
-- 
2.51.2

