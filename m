Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E0142E67
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975585; cv=none; b=Sfp8uBDMhbPOIHqWHTRwKfpqPYFgPxslQcc+LrXN5mHH+LAeQsfmSgz3brTI0EEp//9yl0uH6mxAlsI71orXjaWdW8uJj2WptfBScGwttxlU6xwUSAwM6IKCD51rQks+1X6dw/S50g1N/ZSIeV2nvADextifiZJv4IesX9dMwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975585; c=relaxed/simple;
	bh=pPuCoTh1maA66SqBcknIxvM8xSu7C8lQs4uM6+ls/I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfFQMZ77RzM+jQOPBlPlE4U9tUv1F7xFYfkrs8SdXESS1z5ugsQ7WmT3zZK1MdkAR1YRu5q0eHwpEnmLZyXj4tnF2B/74EBfZv0Q/Y8aneDDF1qtU3K5vPKp6AkQrz3+pOCDjc6aM+fxmQA7N4CS13zf+Hy5NXRVBp2wqwzrs8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irqMnd0L; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irqMnd0L"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22401f4d35aso136190715ad.2
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742975583; x=1743580383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5ZzQOES3UJvR1aR/Z9WiJTUtP/Sd+SFLiPDFbiYmF0=;
        b=irqMnd0L/D844npaGcuxVB3uBaJ2747vdaDq26g09TVZ6tERcQPv419aQ87S9lLexK
         vwwRZnBXd00+cI1uXCww49J8HcL83Jn7bFzzB0+SdEtSpikYs8w/rMSVIYGWU/ttVBqQ
         biDmjc8vqC9byj/Gm0cst1EAHFBFTk29hN8cMvAbx6f7rxR5PthocLpFXMyRGuSNaKWi
         DKPMPOyppcaCgevAovRlfS5Dvt8Hces+OJgl2XjQ4OBDfIqCImg6AYGO51mB4mHKx/wi
         Env73pefhg0O3+gLAylmVN4wUAN46g1U0nAncBYOfIZytS5IvPW7qBlPy3Nv9LK/qELt
         MtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742975583; x=1743580383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5ZzQOES3UJvR1aR/Z9WiJTUtP/Sd+SFLiPDFbiYmF0=;
        b=rxLO5Fi3gk9ZPdGnVlhJPrhaJkjXQxUN4frEZ1Ade2cb1XwunTnFLAbmcJMKbkgfHT
         NQK086OeVeDqzeJolZ/cTkWf0fyEtzWmkW3jtXFea1eAXw7IGa1daDJedC/d5U0POl0C
         fxx6HbL/xUwXO+UJLfL4khE+RRqXfJet5IiQG3mXgzAB3CqbXFi100lXCayVGRv10bSD
         ovImBI43dwEV+fKaMtbMdZxxa80eqK0iMskd9n4ox9tNmYI23Jlh9j9KRhygFCWpQYlY
         pB5+KlOwf5U4n8LPpQQxbY1FObCmOPrUSX7/p8cqajITTxhrnynYYl+7fb43dxPleP3A
         JE+Q==
X-Gm-Message-State: AOJu0YzaUOBmL9CcKDAa3vEY322hTR+dkB+PYdctUUSlz3+Y4G904pDT
	QYwOGBDi8zFsBmgEKO9dqYKEgEuHcQRzTvWLDyNMFzaMnvmSbNzq
X-Gm-Gg: ASbGncvP6xbVWLQp5dbXSfHIPY3aYfF5EWxlR9W5MnytF45O+GGWRVac9sCcQJGMGS6
	u7TZzUkQ9XqyNbXUB2RmTSUUrri1BAcsFbcaAFcnCM9kus/bx1yPCthb+zSfEcgXtu9wD8W1AJG
	qyHrUxPzLTZfYsGacIPgtIMrof0kT2lWh6JA5D2JUrabtMJWvshcjPXeh6Vue/iLRrVjHwKGdEX
	h46dhpzLRdhIHS/wa2/bURGR/SdIbP/z5ol1Y3m6Yg/FtFb39oUsrC8/03E4WKU27zsg/eHLf1a
	M/ZdpHCWad2Mf0c6Tbm+RW/mNRitPq7S9qY8V6tR1HfxMOEmBwY=
X-Google-Smtp-Source: AGHT+IFFd8fJHi2YMcOd2s5rPkFV1/oGsasHUqhf8cDRJbreGcmL5xMicSKs5sENjT74jLRxUg0sqg==
X-Received: by 2002:a05:6a20:2587:b0:1ee:e46d:58a2 with SMTP id adf61e73a8af0-1fe42f25e5bmr30322276637.3.1742975583297;
        Wed, 26 Mar 2025 00:53:03 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2803d8csm10330068a12.26.2025.03.26.00.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 00:53:02 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	meetsoni3017@gmail.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v9 0/2] send-email: improve error capture and status code handling
Date: Wed, 26 Mar 2025 15:52:44 +0800
Message-ID: <20250326075246.2612627-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324145332.571813-1-05ZYT30@gmail.com>
References: <20250324145332.571813-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves SMTP authentication error handling.

Auth relied solely on return values without capturing exceptions,
misjudging non-credential errors as authentication failures.

Patch v9 1/2 wraps the auth process in an eval {} block to catch all
exceptions, adds var error for future handling, and var result to return
auth state.

Patch v9 2/2 introduces finer-grained SMTP error handling by extracting
status codes per RFC 5321. For 4yz (transient) errors, return 1 and allow
retries; for 5yz (permanent) errors, return 0. Unrecognized or uncaught
status codes are treated as transient errors (return 1). If no error is
present and no result is defined, return 1 as a transient error; otherwise,
return the authentication result.


 Zheng Yuting (2):
  send-email: capture errors in an eval {} block
  send-email: finer-grained SMTP error handling

 git-send-email.perl | 69 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 15 deletions(-)

--
2.49.0
