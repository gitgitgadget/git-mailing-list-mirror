Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6E1E50E
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743857873; cv=none; b=LYwrW3qvlKlqzE5hCHbemHd/SniE5BpkretKFix0bpKODsm5vkwSfeuYbs3D6GkA4oDipbwJkMV+yL6KXyx4d8apha+2/CBvS3drJcAUhwCAc9yPQpPJat1wJJTtchUnTNUwraxdCTfsvY5cXPMubSm84SSva/6RHB9RbI3XTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743857873; c=relaxed/simple;
	bh=77VOAj+vwJnAsfmqiU3vBPUNpnSHB67F3xGxnFujbv0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=KNJm0GRpNevvlrRnJtXcY2lyzXBWm3vqFTOb/6OW6ggmrJ1sS6hfpaiRyODiNbZqZWfajXnS81AIlo94MMrv4WNsTnNg892+dAMOdCxyfnwrxvdAaI8u3IQ5OFvskvVEhtkvQeCv23i9tFch2elxZ8B9fczbUNm03bq17D/azfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTUPC6n6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTUPC6n6"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3965c995151so1632111f8f.1
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743857869; x=1744462669; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCRl+z98bIPlLyjFNmJrLRFpCxI0ZWfz21DboBTI7Dk=;
        b=QTUPC6n6hWH1T4N7BqufaO4VZjz9P6npBi7PFmD1IxI2ZRn91NYpZE3SzomvH4y1Lr
         JVnuffnjtrfV51HTHrFyfiP67WIdAcnuDLQvoesiWdddkonjx8GnnPS4pw7Q1oYDeqMi
         IMuFvuekQp6mqO5cFTPF+KbahaN6VGY/+QI75dDV9Cl1eNhglyXCmU3/wX50NfPVwKLX
         Eoe8FyF3+FGAK7N09eP3rYd5hjTmZWL2cW0bYcSlghCl62K6KgL2nXIXRK5DH4LAPNvH
         7gm+R7wYDyqiM6C2qiX5s5PhGOeFqVYCGk/GUVS4sPBFhtqvr/5q6qIjTlZjh2o8h3uV
         HYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743857869; x=1744462669;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCRl+z98bIPlLyjFNmJrLRFpCxI0ZWfz21DboBTI7Dk=;
        b=BTouws6q/MuuzPjLWU8slfeuv/5PFtPw31KFS6BTq7sPv5HQoiVohiHdkVftY4o8I8
         n+pYSYRGNHIPBeBfgMmC9uDNXzrJTwoBuqJwHskJ4JfSw6uT3WM3T8AFkP8xk6egMASA
         f7TBoU6Zg9cvE8QnsoeBD87N4rQcSmW6YMjcZPxHjBt62V1kegSQFKPlGvHbdoz5ymn4
         GYYaDH/T9ySegW0H6kSefXvn31/wCQSryHhCEK70XDFzmISMtcTi/Q5mXwZEs209fxe1
         QJY6ngNAfo1k45cm1i/hBr0wQWrBrvzdLs8zWSmiMqjlMYrpFn/kVv8Si6CIfJSuOBcq
         +yuA==
X-Gm-Message-State: AOJu0Ywcifoq59bG9jwSsCp5mMz4I4hMG8Y0c8RD9PC8r11KpEoeWued
	8GgvrCtn/qLJeDUpzv40bVuTy4O4GbpsBHw5RNR0RoYZbfuwkIpOYN84SQ==
X-Gm-Gg: ASbGncvQRYoldnmI3lx7+mLoD8SGozkxO2Kv/SnHFa4a2BDzSt7b6EGNfUh5MM4zezD
	fAYSN0MdI2i9UUritZB3O2AclgcrIVjYnzLxR+A6EEWG9lze62pRU4ol16IhRaFpT791NbVhIU5
	nRvzOHXy36cH9e/qSH/opBgg2At8+B4Uf38ehbDpNEb+cc5V8haZcxlj9UKoQUsjOBcfkg0f7XW
	y0gAVJZ6E9fYnMuFuZJfgOSdWFm9WPm+f55FLEN8AQF08FXE3nRThK5DGOK6yCb1ap4GB8j1GHA
	7zTCxIGa/jTGBS7CXVXi12wr4E4tUncLFDwbbSpJwB2KaQ==
X-Google-Smtp-Source: AGHT+IExyRpLBp9DdT3fgYK1Yr+/vSAHCydfDLoJfEaC29nosqAj78Ta1WIUsPJoulcBZ1F+QKuO0w==
X-Received: by 2002:a05:6000:2cd:b0:391:2e0f:efce with SMTP id ffacd0b85a97d-39d6fc0bfffmr2213214f8f.1.1743857868450;
        Sat, 05 Apr 2025 05:57:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30095ea8sm6775700f8f.20.2025.04.05.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 05:57:48 -0700 (PDT)
Message-Id: <pull.1940.v2.git.git.1743857867327.gitgitgadget@gmail.com>
In-Reply-To: <pull.1940.git.git.1743791986754.gitgitgadget@gmail.com>
References: <pull.1940.git.git.1743791986754.gitgitgadget@gmail.com>
From: "Christian Fredrik Johnsen via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Apr 2025 12:57:47 +0000
Subject: [PATCH v2] refs: fix duplicated word in comment
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christian Fredrik Johnsen <christian@johnsen.no>,
    Christian Fredrik Johnsen <christian@johnsen.no>

From: Christian Fredrik Johnsen <christian@johnsen.no>

Fix a typo in a comment in refs.c: "checking checking" → "checking".

Signed-off-by: Christian Fredrik Johnsen <christian@johnsen.no>
---
    refs: fix duplicated word in comment
    
    cc: Martin Ågren martin.agren@gmail.com
    
    Changes since v1:
    
     * Add a blank line in the commit message to separate commit body from
       Signed-off-by: footer
     * Moved the word common from line 2553 to 2552, to make the comment be
       similar in style to other comments in refs.c. (Usually the last
       comment line is somewhat shorter than the first ones).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1940%2FChristianFredrikJohnsen%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1940/ChristianFredrikJohnsen/master-v2
Pull-Request: https://github.com/git/git/pull/1940

Range-diff vs v1:

 1:  327563ce3fd ! 1:  029c23cf027 refs: fix duplicated word in comment
     @@ Commit message
          refs: fix duplicated word in comment
      
          Fix a typo in a comment in refs.c: "checking checking" → "checking".
     +
          Signed-off-by: Christian Fredrik Johnsen <christian@johnsen.no>
      
       ## refs.c ##
     @@ refs.c: int refs_verify_refnames_available(struct ref_store *refs,
       			/*
       			 * If we've already seen the directory we don't need to
      -			 * process it again. Skip it to avoid checking checking
     -+			 * process it again. Skip it to avoid checking
     - 			 * common prefixes like "refs/heads/" repeatedly.
     +-			 * common prefixes like "refs/heads/" repeatedly.
     ++			 * process it again. Skip it to avoid checking common
     ++			 * prefixes like "refs/heads/" repeatedly.
       			 */
       			if (!strset_add(&dirnames, dirname.buf))
     + 				continue;


 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index f0fe77bd7cf..1fb270c5782 100644
--- a/refs.c
+++ b/refs.c
@@ -2549,8 +2549,8 @@ int refs_verify_refnames_available(struct ref_store *refs,
 
 			/*
 			 * If we've already seen the directory we don't need to
-			 * process it again. Skip it to avoid checking checking
-			 * common prefixes like "refs/heads/" repeatedly.
+			 * process it again. Skip it to avoid checking common
+			 * prefixes like "refs/heads/" repeatedly.
 			 */
 			if (!strset_add(&dirnames, dirname.buf))
 				continue;

base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
-- 
gitgitgadget
