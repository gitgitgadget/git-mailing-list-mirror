Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D022E3366
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828033; cv=none; b=XR2dwzl9Kp8sW3/qzTAZjD8T34vulDSkjncuQcjiALhwlUMhW1E9mHIBFpbqA1/UPfulVs6ZnwCixuHDFadAVr8Wn77OFuINQkeqmZMZMQ6mWgJUO/ehaDkxHejzjvtAI88KDKmayL8hsQ/830LXlBvFjbuctvQRVNwPtrfkMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828033; c=relaxed/simple;
	bh=qKMEL4l2h25lb5vEnCFWKcHcpTg8xGFPyYc0OYw5Dpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2fHv0HwAFGCDXkiCevm7fy+vmErLI1u916Lni6GnwRJPcE35JmtFVax0oVDtXxau21MX5+tvEmqSgwFzY1oHZQzQ2mthW2SGp0552HEIrP6RXOnFUwkOTD+e3S1L4ReFtoD1yXQY95AQqh06zycUUQ0/00n7A0tyOeQT+DYBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsWDXtUA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsWDXtUA"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3035858c687so1029241a91.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742828031; x=1743432831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRIA8D8fd/LDPq+98hhLUwNlp1t//5KozxKt/oMMeLc=;
        b=OsWDXtUAf2/iDU+LY3BjqIOIRyGXU60HHUgjrBchhWZkfutpRV82zt2999yFMiyb4P
         shmLcjQAzb/NV7Fkb1ZeB/CZazHRMrLmfnrfFGVYbBoqIBRyOm8FVUHOiAstfXrLvCog
         9AKw7Mlm0u9ZHMolUD9JN+gtXKepnwKEeSC4IhBpnOd9/T4PO1NsCZ0dMQsn9l8fc+A8
         2XHNalsfNtgRWzWRxbGnrEFS6UyZv4+JXBH/ycWmlf9wfXl2R2XgjlvGhk9UbyEZF1Jc
         PV2k1mdHHf4G5OFFcFENEuYuawRxAPqTPNfOKkc6CGgIVrlkbCA3LEA0z9VUvnHSd+Z1
         Fq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828031; x=1743432831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRIA8D8fd/LDPq+98hhLUwNlp1t//5KozxKt/oMMeLc=;
        b=FOvL2asNvHDdwE0WnI6bTMnN7w6PovGtiBBm61RSai+YBfIbQf/ll0Alpg0Ju4xH42
         rvDDRSX9YfzKNgaMKeI21XrtyceLSU63YIMfMxVG68fcAHYQwHX0AjQ+AmXt0++2GXyW
         7Dy9OXr0RgyyEN0ekzTLqRxYfUzEnQOiBmzMgFGWel+tWiS639gDWwgw8TeO+mcL1h5O
         XsOP4vzf+qwx4hcpvTXPCtV1rGt5oPcrgFn5bYesfRXa1p3hsYw9THqJ1YalxKZEJuE9
         3uPNHYqNkWr7mFcYP/XutcPWcErL0Yxa1suqizcoCnqkBpOH0pZbTZCgVynky/7YvcJ/
         F38Q==
X-Gm-Message-State: AOJu0Yz8tM2UUN3U4iceqEu8atzAekIUpM8ff2K842ty1TyzXApx63UL
	aszhFRX2++BKDgREtBf6MLb+UHMUyaqpBf7pmurU29lNqjDSKS2r4CtRyHa8
X-Gm-Gg: ASbGncsu3tv53QF9TPTKZCFOii5A5qPj8kDEH2rh0PjrlUqoPAhTHeLw52zkZW5TtSc
	pY41BCGoBeanBBtl0Cq32RChagwPVFheA4AP6v5eF77jJRS9mG+djW5z7ashNLK9D9glGkv4TS2
	IEY9JhJISsek5rbYWAVrFo/me7+9KPaGYgthq+CVuplGNuxM+11hESMl8HO4qVxYJ6jNzTpr53m
	R/MEG3Ezr8beR5OmRq3GsXn8OzvGkhm/uabt66vl4MoHp/GGYoVNnt0MHNjQyBpy99lTqz+SNJO
	QrmRVRvw/rUm1Itu70wa9bOujFNvBhUb8n/kt3S/FQuv3GQdIZXH
X-Google-Smtp-Source: AGHT+IFENH2DIPLkfpUUpiDdmcUzKHMXxXjptezSWOjrbwmiksje7XQCUi1+s+QOJvcKbM5ZBLwhYw==
X-Received: by 2002:a17:90b:384c:b0:2fe:7fea:ca34 with SMTP id 98e67ed59e1d1-3030fefe329mr19005776a91.32.1742828031228;
        Mon, 24 Mar 2025 07:53:51 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf635929sm13464061a91.40.2025.03.24.07.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:53:50 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	meetsoni3017@gmail.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v8 0/2] send-email: improve error capture and status code handling
Date: Mon, 24 Mar 2025 22:53:30 +0800
Message-ID: <20250324145332.571813-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321025128.68463-1-05ZYT30@gmail.com>
References: <20250321025128.68463-1-05ZYT30@gmail.com>
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

Patch v8 1/2 wraps the auth process in an eval {} block to catch all
exceptions, adds var error for future handling, and var result to return
auth state.

Patch v8 2/2 introduces finer-grained SMTP error handling by extracting
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
