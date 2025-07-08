Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB92DAFAB
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973612; cv=none; b=pLi67xMUWLlQvwU3iaQzXCbleA5yuPGmHT+TvKrhxCtHhBNsnkvLB9/HLltPGogRhIsowfEOaoifbrtam7d93pMtPg6zxdZvQsgaliT/SS3PFTsooBGTzUGqplFafzD1oRKSrlbH6QNBTcizH5mv6xBPiLgy287wQYq2RO7iWW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973612; c=relaxed/simple;
	bh=WJFSUeFA7DPMwJDlWOPoqxbBOoZis4/fh86OdGCHS3A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bFD92gL1rQ7JOPjlw4618GMBYC4njJN/VNylx55h+K8lTwcs1mZ1PAZDMuRNWbuxU2lura4SX484wB06ZIM2SFiM1oGtqLaNvmDUheNluR+TlI73ZCasBOwtgc+Uc5ZB1Djmvv962caDdXOQ2eKBxG0kTgdG8Pe0SflnEGKEx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccaqtcnj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccaqtcnj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453749af004so20731285e9.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751973608; x=1752578408; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM1GzmX6eOAxXd7dU+WsaxDshi0YBVJ50L8rySD/Pms=;
        b=ccaqtcnjyi6jYGtoA08Yuwkqf/k2BD3iFT6jaHUDu2So+D+/DIrIo9ouR3mE06vQSx
         XJ5Js4sNYv4oB5QtqPdGwUyDNLAsdZ7zKtDwqw3rySfEQGuQBaHGUQqIJR7vC0YzlkiK
         nFarssBLZgxU2yH+Pd+Gm0FSCkp+v6EOgUPtI1Ig/H1qvf/pAYz4gwnRVmgIYoCzNMsS
         5mB+P1zDk2TxkykdOtVEt76gRrwD8vmX2A+gnqZnMYnqPrHbM/vfzJkewy5o1bBLYqX9
         KM76CUjXkNYzH06ZDg3PqlXauVQj7ercRS5s/8CNx3lQw9MVz3P21u1c/eoor5dEh7Kr
         cBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973608; x=1752578408;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM1GzmX6eOAxXd7dU+WsaxDshi0YBVJ50L8rySD/Pms=;
        b=RgM2fcRZtIjfr9CNInfFV+144CnEV9tZwrqtm0NY6C1gpuejgXbyeKIcFfUuFFo9Tm
         diGLguXJuQfmmqLkqX9IEcvQbPrK88k1Cut4g+vFqpvFkf8z3XGLBssFmMsgOVFEkFvY
         cAS73zWlX0KmG78mEnEs4BbxnOn3ucW4IqEwEGic0DI29pdvfvjJbnzyIJdkm1alB5Sf
         ltgStB0Xvc6EydXWAh7oHf8BOs0XJ7gmIG9Vr2nnctr8iC6ytAv6Byj+y7DxCVNWLuoz
         DhDyQXzNiWyBGD9IXkEUKDdHULciCrBXRnNBxyFy+gsYlB7HYS+5O4f1yLd0uPBIfyj0
         8yfw==
X-Gm-Message-State: AOJu0YxAOJlXRSoBjS7kWnsRW+C/ptaFj/LQbv7XjwZ5kproomDhccpl
	82ZaUOGwDj8H1qyidFTPGJiiKJTYrZaHrpyEYfUHb7fG6FnmBYikQzwuejYhKw==
X-Gm-Gg: ASbGncu9UhH4U1FseUdPMA89M3b+M3Q7pShVALt9XaX0AqUNKPO7YcqvTmhbMz53euH
	CZ4wnt9nTnJJC6BFIT8hOvX9T6kQy8B8fGQdZdam/XzQu/IZ8bQrqz5JnJzobV1nD7yVD99xceW
	SAERO1W3o41f8u1ijIDsTqqXhv2gq7aFN2QsVIfo3+htSMHz2G3BFqogGP486VBw4tERYnBMqAp
	B7QzZmr/ePnAecajXTlNB8ApXxctmjeUU5KQiJ6Uf1HfHX3XMAKAlMEdb8vNH6AD32nP7OR/E6O
	W32/sO2LX0QvS0p4nkhauS5fGqJzNA3TeXE3X1mv7xr3xoweFc7XSKQpapAjtaE=
X-Google-Smtp-Source: AGHT+IGEI5lNfIMFjDqaJ/ze+012IcRemGMjCl6s5/jDqlPugCBCumb4opY/GsoPrcq9WP80ND/mjA==
X-Received: by 2002:a05:600c:5250:b0:453:a95:f07d with SMTP id 5b1f17b1804b1-454cd4cbed3mr29957415e9.10.1751973608240;
        Tue, 08 Jul 2025 04:20:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd49d0e0sm19421575e9.28.2025.07.08.04.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:20:06 -0700 (PDT)
Message-Id: <80d7a7641daa7a6f0e1db73e0a433701e9f37209.1751973594.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Jul 2025 11:19:53 +0000
Subject: [PATCH 3/3] sparse-index: point users to new 'clean' action
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In my experience, the most-common reason that the sparse index must
expand to a full one is because there is some leftover file in a tracked
directory that is now outside of the sparse-checkout. The new 'git
sparse-checkout clean' command will find and delete these directories,
so point users to it when they hit the sparse index expansion advice.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index 5634abafaa07..5d14795063b5 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -32,7 +32,8 @@ int give_advice_on_expansion = 1;
 	"Your working directory likely has contents that are outside of\n"     \
 	"your sparse-checkout patterns. Use 'git sparse-checkout list' to\n"   \
 	"see your sparse-checkout definition and compare it to your working\n" \
-	"directory contents. Running 'git clean' may assist in this cleanup."
+	"directory contents. Running 'git sparse-checkout clean' may assist\n" \
+	"in this cleanup."
 
 struct modify_index_context {
 	struct index_state *write;
-- 
gitgitgadget
