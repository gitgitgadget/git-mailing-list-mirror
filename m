Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD641A0BCA
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975591; cv=none; b=SNhc/iOg0a/ZEndnNDj3S9Kyhkgw4aBe3JlQjzkYOZRMIr7fvUw9tYkxfZT0D5AAUE5CGA9B5O+I8bBUjrUtoUMcHsMLbvFiUfJoI0Irf8ZhznfK1TkpQjcAgyxvg/BByWJoVwA1sSt9bIoGRAxzwPFiZeGl/hVyMtrb4obopAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975591; c=relaxed/simple;
	bh=rAUyWFAd154EEFQ3pZQypo4MT4VB+q13R/BI1+Mmg54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/wCTzRhDn3sUN15pkrwfH1/orweXKihLTI7/scPz4gjPCPnxitgOrt9MQ/ObWAhUjhiOhTD+wI5/Ltnfv/DYQc/eH7z4YrmRw2FWWn+ph7RVAOuYnUsm9rDxgowN6DqVMJRvyPjcaLcJJgpqdv6FK1Y0XJwhxKha/WOlgmgsuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn+8TDSJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn+8TDSJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22438c356c8so133406135ad.1
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742975589; x=1743580389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYQaKZoroxbkbWtjzsa/2SpdrEy2vPY4Z/Or6Qd973Q=;
        b=nn+8TDSJuBBBflR18RxRMdgGsGjrZ/olzhG2xGxqOvuzKEfXBZ4YR5ZTduZvrzErdF
         jzIJqaDotIKAgZa6czFNBWQkp8FjDzrJxgLWjjnc3Rb8mKJZSDF+8VDoOmzTVl98kGsV
         2fJgcMwcdzbx8tftdaAr8Wx9b6s0APfTLKPerWy/mVxzsTbTqCBOgpJGIeRyJ5tCWrKa
         d2J3pCGMsshgd2/RVEDpSmZVDWQclfKuTvx6OU2ihc2u6oiPkCgKVFNuO8DoG4g6aj+P
         3FnXU+suaze5+RhjfEFuc5OZAHn1LO7NWp770nDYqlZXLn52j9+M6ytX/6Q4zDbdpmcA
         Egyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742975589; x=1743580389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYQaKZoroxbkbWtjzsa/2SpdrEy2vPY4Z/Or6Qd973Q=;
        b=wUajUhRrTkiC7Bs6nGOIVgbXKOxDip0B98EGJRrEk1ZKRXD4PZbqVzrhZbbVEb6Utc
         fI34vJRGb3vs8UUKmoM/+temSmzM6QFvLycTu4dH2TYtYSSnDJBdVBi1ceJ6ll4m2eux
         ePzZpGC0Qgg8/Cs9MNDn14CQp/HTLgrd2qbAkTi8R84tS/EMTiGX2JUnYmdTGQ3UXV+u
         EraQUANmZPpfHbyEYFLGg/YuQ0qRmgcLwoRisIdwHf4rM3qFGPZl3/YK2j/GFj8feU6N
         CJPdUlEV/WuMJcHyEOzo2u7Fxp+l7iKcgnO7711Npip5XzZaNWsKlTck9xK2voT/jbFm
         WDUg==
X-Gm-Message-State: AOJu0YxEWqI8Vjprk9PcCQn2hNmQyYP9aTX/bLok5OtyRfvBMyoKv5FV
	3XHpk3VKtWqe7ckjkOTEkiiBAGNjme8ICCmIIcKKgxNFxKbhW8/VOPLN7MAG
X-Gm-Gg: ASbGnct+asFiDlwp+APJ65TAO//TGmu3ooNfJbrDJY6gbYztdJQ5FE0YoEUYgznquuf
	7reDvTqxBy75QynU3S7m7Ylx8Qi0jvAXc8OW7mVyTZjFUNLKXT06ipNBitpDr/+ikaNKd4BlvFc
	iqMYSO58h0/QMdJb2BRBGKCc6oyyAvDq7Z15ijKRllj+CnGOdeFcaHyt0A+IZMCUEljBq95JN60
	HLQ7a3wXpTZIb8/l4/mdDgxlMkD85+6vKBj300iD7W2xzkCcvR3CU/8TMrjDkbKQoGbrtT5mOgG
	fS+r4rDyjMC/P1EKQ9i2jKehKdk5jp+NXH7L+YYFc1QbEz7S/jLBgJl4VsfLmQ==
X-Google-Smtp-Source: AGHT+IEXdJDsIzdMfEwA2ydcutOaSnRyaClgG7uKme2FKPlYjTA0NjeOzPChl5rTkBwlXkUbEfuFag==
X-Received: by 2002:a05:6a00:189f:b0:736:3d7c:2368 with SMTP id d2e1a72fcca58-7390597fef9mr28757976b3a.7.1742975589240;
        Wed, 26 Mar 2025 00:53:09 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2803d8csm10330068a12.26.2025.03.26.00.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 00:53:08 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	meetsoni3017@gmail.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v9 2/2] send-email: finer-grained SMTP error handling
Date: Wed, 26 Mar 2025 15:52:46 +0800
Message-ID: <20250326075246.2612627-3-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326075246.2612627-1-05ZYT30@gmail.com>
References: <20250324145332.571813-1-05ZYT30@gmail.com>
 <20250326075246.2612627-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Code captured errors but did not process them further.
This treated all failures the same without distinguishing SMTP status.

Add handle-smtp_error to extract SMTP status codes using a regex (as
defined in RFC 5321) and handle errors as follows:

- No error present:
	- If a result is provided, return 1 to indicate success.
	- Otherwise, return 0 to indicate failure.

- Error present with a captured three-digit status code:
	- For 4yz (transient errors), return 1 and allow retries.
	- For 5yz (permanent errors), return 0 to indicate failure.
	- For any other recognized status code, return 1, treating it as
	a transient error.

- Error present but no status code found:
	- Return 1 as a transient error.

Signed-off-by: Zheng Yuting <05ZYT30@gmail.com>
---
 git-send-email.perl | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0f05f55e50..1f613fa979 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1454,14 +1454,40 @@ sub smtp_auth_maybe {
 			$error = $@ || 'Unknown error';
 		};
 
-		# NOTE: SMTP status code handling will be added in a subsequent commit,
-		# return 1 when failed due to non-credential reasons
-		return $error ? 1 : ($result ? 1 : 0);
+		return ($error
+			? handle_smtp_error($error)
+			: ($result ? 1 : 0));
 	});
 
 	return $auth;
 }
 
+sub handle_smtp_error {
+	my ($error) = @_;
+
+	# Parse SMTP status code from error message in:
+	# https://www.rfc-editor.org/rfc/rfc5321.html
+	if ($error =~ /\b(\d{3})\b/) {
+		my $status_code = $1;
+		if ($status_code =~ /^4/) {
+			# 4yz: Transient Negative Completion reply
+			warn "SMTP transient error (status code $status_code): $error";
+			return 1;
+		} elsif ($status_code =~ /^5/) {
+			# 5yz: Permanent Negative Completion reply
+			warn "SMTP permanent error (status code $status_code): $error";
+			return 0;
+		}
+		# If no recognized status code is found, treat as transient error
+		warn "SMTP unknown error: $error. Treating as transient failure.";
+		return 1;
+	}
+
+	# If no status code is found, treat as transient error
+	warn "SMTP generic error: $error";
+	return 1;
+}
+
 sub ssl_verify_params {
 	eval {
 		require IO::Socket::SSL;
-- 
2.49.0

