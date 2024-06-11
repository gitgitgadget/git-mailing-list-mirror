Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0CD2628D
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130294; cv=none; b=V90UAr9jis1Wcr5CHe1toPEz5SN8cPduv5xKPJ0CKtasI7B9FlKdfXHw6li7L2w8wXB+8stryDv/464qHmyOsSgNUvPRaoiirplmdKpiRODNS54GprruqXZff/EuR/qFbrdOmjpClYlOM2JoRA8fOuyduAG2cwUORhavHIuh/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130294; c=relaxed/simple;
	bh=fBat4Yp3gYivyKXamk3+/10ToBE4v9Q8CQR4fkIkCNw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sbxuJxO++NAlWDYtcFEFZMbBDjdZ8KREqXvBEJc7Xt5bcQ0OjdgScagYTVApI/RHMiw5y4Lu0PUNPscAWiNBxbbLze7dy0muMoyLiZWJp/aZU3lAKO2iYVLbGw6IjTyuRi+4groqHSNfuLLu2e7ssBUsLW2XpKAea5o5f0Ml1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjfc7Xql; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjfc7Xql"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f23f3da44so2294761f8f.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130291; x=1718735091; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6phZVwBXrsTJRIGQvTlUYZADysZjBXsqztO7asPnDE=;
        b=bjfc7Xql3hB7VfkyaJ3hTkOA4sUP5kFvBqCMCp+lOb8rf7ICDb+ca/JMxcXuO3wJ56
         iX4h0KQcjcVoKF48kvXaTk9ywy8rvqDJblAgpPY4gfrTChLnVfVwYgQG84j+N/Nk/sR7
         NcpQaJT7NflqMS2nMJ+28AjyRdfYts2ar398usPnwP11q90aihe4uDTzZdEjSBcQKE7m
         aaL6t4uOAzgSGk+gUElkULBfHSLVGFnd6XIYkWRvK+rCxOfCzSsnQbOjKF7cOqYHeTwL
         KTBbDSnqIetPwO0Dk1DMPULbRQFYQxT2rvgCvERfV7fVAxLRRj3EW0Ay/1jxJ20jB06A
         6Ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130291; x=1718735091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6phZVwBXrsTJRIGQvTlUYZADysZjBXsqztO7asPnDE=;
        b=tIFtpE+YqYoLxDhPPoiVsahAb/Og0khYCYu2nug3fxhd0NJxwvBMNaY2GXjGI6NPG1
         MZPOaKB3G2KGDwGvmrIm0Z7800bbgq7qc07wSNJoCwgRMAMTFenjdESbdw+464BeXaAy
         Z+1Bsuowtu/lgNBgNZRm/m3/yN8pIOe8kQX7u1IOsvLfHH5EFvA6uRixwq6m7a4Ypi7A
         EB5qBsUpnIKzuob/lP6kW6d0FtCke3mWRQKJMcP1XRSqGHQdJGih/J/tKSO2kCg0JE+B
         oPPx97Sx3dV6ra7txZ/zRRaKTyZIMj/ShruPCENWK0T71GIRFwdJ94iadoiZZrcUEnSq
         zN0A==
X-Gm-Message-State: AOJu0YwxFLctBWni/nWOmqIETs//T6S/5xEEuYBC9eqpYIaTO14wqyvf
	wChLzByrfDc8MsfSj9BQLhZpM6CLDlUYujM9O8MQGYYiRlvfWxZKLi4z9Q==
X-Google-Smtp-Source: AGHT+IFw6B3BwnI9QWggsAOd03gq8cq3qNJ0SeduRlzfWoO0Dj5mIxLbAq72LqtOiytICEfYukEsWA==
X-Received: by 2002:a05:6000:1449:b0:35f:23f3:e95 with SMTP id ffacd0b85a97d-35f23f30fd6mr5582689f8f.35.1718130290780;
        Tue, 11 Jun 2024 11:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2774bb64sm4946140f8f.103.2024.06.11.11.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:50 -0700 (PDT)
Message-Id: <074dc98acc79e08d07cf4f5c8105b872ec57980c.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:33 +0000
Subject: [PATCH 01/16] mktree: use OPT_BOOL
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Replace 'OPT_SET_INT' with 'OPT_BOOL' for the options '--missing' and
'--batch'. The use of 'OPT_SET_INT' in these options is identical to
'OPT_BOOL', but 'OPT_BOOL' provides slightly simpler syntax.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 9a22d4e2773..8b19d440747 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -162,8 +162,8 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 
 	const struct option option[] = {
 		OPT_BOOL('z', NULL, &nul_term_line, N_("input is NUL terminated")),
-		OPT_SET_INT( 0 , "missing", &allow_missing, N_("allow missing objects"), 1),
-		OPT_SET_INT( 0 , "batch", &is_batch_mode, N_("allow creation of more than one tree"), 1),
+		OPT_BOOL(0, "missing", &allow_missing, N_("allow missing objects")),
+		OPT_BOOL(0, "batch", &is_batch_mode, N_("allow creation of more than one tree")),
 		OPT_END()
 	};
 
-- 
gitgitgadget

