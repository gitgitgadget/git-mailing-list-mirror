Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2626825FA0E
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828041; cv=none; b=EkYq3YtUrGNWxI96l0zi+K3xJZRvyce4sp3NsQppTCEJOYz9JzOpzuFfFeeBRBFbTYq7oD4kJ71kWMM8SVyPIRzZjxGQMIqDzFyrNvYgEXCh2LZE5QTBLr8BEhnfUmTWFlHgUAuRQ87wRLHP/R2nQLjonsCnb5TO8lbarxpunZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828041; c=relaxed/simple;
	bh=i8uMspePhL+r+p3HF9Vqv+INGVCRibuCi7ettu8b6ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzIT6S/Lr4kSpAbEAgKKkoM/OzDO5dTNIkG11XDfxcTmrOA8TathuZCChNE5mUDg5vqZ9jOk5wkD6BUQgkZZQr9zGBcm+7XWT0f3AVOex5zSPLU3WBvOkNOYNxRcrwYcj3yDWQ+1m3cOGMdogfqN815e1Nsgv3/3K6nmkgVoXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg5drLwf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg5drLwf"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso9563458a91.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742828039; x=1743432839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w25aGPzGz6J5FT3f7JxOUzTN/YExvfX6Nk5TIif1ZDc=;
        b=Vg5drLwf8cWUhdDMgIRh32QNK4q5uwn3qITVHNgQgGqZjd/rD3zZYF37bCkPbFgx3Q
         9A4HV1N1b9MAPRNnrqLp/a+jPFtyRA/+lKy3S0IFKhcHrCphYyGMnEJwIRFzylJgEw6x
         aa+PB8EYXXi6FSRyKj74VJ6OEMnNJ6p8NlsP5myo33n386F7UTa18WFz9L30BGPMbRGH
         +cQMspiHphzSKQR5obxTFqabdHOThpXrWsGKF0nfl2akNhV7vv1qAJg7ZM63F50k6klN
         W5tY0H8Np2F57ZG56KnFsEt+2budx7Dk84pZCqjyAVv2xQ+Io44oms3ipOjvo2amIzrJ
         6t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828039; x=1743432839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w25aGPzGz6J5FT3f7JxOUzTN/YExvfX6Nk5TIif1ZDc=;
        b=KpkAGerk1UIPFxDmAGEZ0guiH5v1P0W8T23t9ndqM1eq0y49Jm+SqR5DOxmKo37mI3
         hF5n/9oq+MPvXFu8FjutxCDOk2jp1TkLinHXOjIZEXIpU6QmP6Zy92rYrCwJPN8rAami
         BrQfq6ZVjtMqkGV+JWAlsG2Rm4+ZB5uAmhMak5Ecj8kyvVeE6afyR2LtHrslDgtpvezv
         m2UanlgLntUwZelyRRM5KbD6PZpze9nYrN4W9D/EhZU4tym9VTYvc6FGU3k0XRayqx7k
         /Rii9RUoYeUU1E0mvokelss5ZowdOvKnoIJT39xxZ7jwsceWvhImlD9F4vweiGgelMjm
         Yong==
X-Gm-Message-State: AOJu0YwX5SFUxYLCZ0TEiOvGsFTYercfMCUr48XC5IKgJ9P6b2fyJArM
	twviZUujFuyVNuxya6IbiPQ660saY54/CtPTJ3nhKK9OMru9I96wdcpQUUvP
X-Gm-Gg: ASbGncuZxo5ICarrl9veg0H35rPXVRI4N0KuTgx0P7Y47BMPWY6GY/W3wRf0h6Zeo29
	Vx+bCJoejH0D6xzzRygleMBvMGMm4sXWZf0zaxEhqd9NSvRBiPLXLsf3kndCEMk7gqqJ/1naCcN
	kBT3oCN7ZJ8RkbLjOFiVs6Cq89bGVYrq6RvEwQw1lHlkehjmKX8O9lKdm8ye7IbiEc/bXcH5+Ya
	H8Cg7vcqyaqlthqgBxXigncOEJs/bONceoAMVzSM3AUiFiWJRSeBVp4hJ6jIdCLxUrjz0CW0Drd
	MHl6iuCcdy+QTllYmLV8u4iTKZcT4+egCNr77MlDKaS0v1w/fsQD
X-Google-Smtp-Source: AGHT+IE/ha3FYumdDEst88DalRvqrhVLDI5+k5jDoU7iCQukB1xAdhg4CDO9vgXhrBhOCVVCoAgz/g==
X-Received: by 2002:a17:90b:2d48:b0:2fa:6793:e860 with SMTP id 98e67ed59e1d1-301d40df5b4mr28473213a91.0.1742828039222;
        Mon, 24 Mar 2025 07:53:59 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf635929sm13464061a91.40.2025.03.24.07.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:53:58 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	meetsoni3017@gmail.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v8 2/2] send-email: finer-grained SMTP error handling
Date: Mon, 24 Mar 2025 22:53:32 +0800
Message-ID: <20250324145332.571813-3-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324145332.571813-1-05ZYT30@gmail.com>
References: <20250321025128.68463-1-05ZYT30@gmail.com>
 <20250324145332.571813-1-05ZYT30@gmail.com>
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
 git-send-email.perl | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0f05f55e50..12b1a7c7de 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1454,14 +1454,42 @@ sub smtp_auth_maybe {
 			$error = $@ || 'Unknown error';
 		};
 
-		# NOTE: SMTP status code handling will be added in a subsequent commit,
-		# return 1 when failed due to non-credential reasons
-		return $error ? 1 : ($result ? 1 : 0);
+		return handle_smtp_error($error, $result);
 	});
 
 	return $auth;
 }
 
+sub handle_smtp_error {
+	my ($error, $result) = @_;
+
+	# If no error is present, return the result directly
+	return $result ? 1 : 0 unless $error;
+
+	# Check if an error was captured
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

