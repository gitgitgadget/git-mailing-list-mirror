Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD531EB5DD
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945540; cv=none; b=TTUknouxVZ7WSq9qmuvwmIYszCGey2ejHJEoUUsnTmrTpJgW/bqGF+ubWG6omlIHIpkfe9D/whKWKv3PMxK8Bw9i/IJpg4wEcmkpF0PE4xc1LDwYg9XAzLl/3KROYtB1TAaISkbEvM43ocDRGcixSAHKEQhq6p4+k8cVKkf/yQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945540; c=relaxed/simple;
	bh=beia6WAgB33vVVZmnoTF98obrdZVu6Hz2GSVzDLnato=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uVv5RNUNCkBmrgsqhrceAD9IE+Dxe1H3Lb17d3YNpqvkL4cnraGGSJWJsb1UhRkQOqPOTilbPHsJSUc9ZpFYKOBzJBqLLS4H5+DqVrQPbh6TCDX8Y5YLRqEOCcnvGfi9Pydeyjw+/AKjuI0WYPVhTwWeTi0WaLSbgPvx6VZhRMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odu42Dgy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odu42Dgy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so44673685e9.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945537; x=1743550337; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n8JRLlE/3sP02WOiOTD1GD/rQeYj+RlHtCWwaEejuw=;
        b=Odu42Dgy7is+GqX5m487gx0+xc7OetvHh2ibZNcLQFRfZcA9xYBlypqKZUJp0mDrET
         bcqTxkivxLpxnWgQ15/fxupfQ6OZV0AgV/XggU+FL3YuaSxFi+AJmxb9xgrCzJLwDTqh
         VuVAVgG5ylPiNfopvVIQZGLg1uT5FxqVPWOOp28TNTSLnSNFZhNQxgCRzHZBI+3akvNy
         OYcjgtClr9f5DeUPRAQZmC1csHTfVk20KnBHeez3fHZl6xSGYSLO67IOp/7c9xc4p0Kb
         aUANOqSRFmlLKv/+InxryuggDXPo+epnxNClr/FL57J1Gq2mMl0hL8gQNZ2bsnYlgvVP
         ciuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945537; x=1743550337;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n8JRLlE/3sP02WOiOTD1GD/rQeYj+RlHtCWwaEejuw=;
        b=R/M6KK0k5+b+KB9lPWV6OQOTRsiMYsAX7irjkIvrMTbLQ+JJ6Wc3q+suvzvwisIQLO
         w/efIv854AntQrj7nA96wSxN6UhRPpAoz8d3ybeeg+JeZSc+/nmAKSgDlrhHYpwzzgCf
         I83mtOkcbXhYxupjBs1B7GcYPJsf5fCfkp6QLl1TcrqjLD10GD+JHywy7CXAHbFseGRh
         tqMIdHRQOFLJOgV9Q1qGx6yrN4Q5hq1YJxuNubiqdjAT2xbZTDrHmfbkL9voLsHHPO4g
         5WSXbL70f6IDHqV5OxL48wF8huEfzN7JAS7lxqyIwmydjjn6edoAgXxKKbjRQpKzo95t
         T0+g==
X-Gm-Message-State: AOJu0Yz/S2WLE4jcuqAiTbDd1lIvaRBy1Ljd+0RAHjXdhaPporD+mSYb
	G2oO4L/LFU+638ue02DORvYC8GNA+AvaemE6Se5FQHZpB659PIQeLFtpcA==
X-Gm-Gg: ASbGncvAYIZgDa4KFU1fjfKNf8CwbyOeyJt5FMR+Fy+1rFvLxdDYI7mwFCHAFg3W7vU
	BxZHF6jc0tUC6Il9XE9nbrOP4lsFWKoDUx+h1sJIYDWZV0VqkHw1JdfYC7VfWkP9OEX8coGoNOA
	+hPNRPuGSVdLQrjZUkmNs/cslQIXkX4yiv1rHieeyOSqJOd9YZOOeQizuoNsJnCm5ucPxufM01v
	7MX3UdM4xP+S71r/Pg7AzwORqlfzdgkUkg+jVfHf3y7yGvzviQ4s8SvCU6Inr8UgAzATCV9ZaS4
	pihv7TwWD3BQzVqTlG6//SfRP0lytXdGREoX2sq8oI8v0w==
X-Google-Smtp-Source: AGHT+IFpRXnBN+aTrGexeHWsgPIwhXCQv95hKxzHmNMtrAJCRQUMhLqNO9iZbOMqg0oZdlymAWN/Eg==
X-Received: by 2002:a05:600c:1f8b:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-43d50a4a938mr200372445e9.30.1742945536560;
        Tue, 25 Mar 2025 16:32:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd348sm164835035e9.39.2025.03.25.16.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:16 -0700 (PDT)
Message-Id: <913c7a0d29699c2bd80fefcdc00879c400f1e7db.1742945534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:05 +0000
Subject: [PATCH v2 01/10] remote-curl: avoid using the comma operator
 unnecessarily
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. Better use a
semicolon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote-curl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1273507a96c..590b228f67f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1239,7 +1239,7 @@ static int fetch_git(struct discovery *heads,
 	packet_buf_flush(&preamble);
 
 	memset(&rpc, 0, sizeof(rpc));
-	rpc.service_name = "git-upload-pack",
+	rpc.service_name = "git-upload-pack";
 	rpc.gzip_request = 1;
 
 	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);
@@ -1401,7 +1401,7 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 	packet_buf_flush(&preamble);
 
 	memset(&rpc, 0, sizeof(rpc));
-	rpc.service_name = "git-receive-pack",
+	rpc.service_name = "git-receive-pack";
 
 	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);
 	if (rpc_result.len)
-- 
gitgitgadget

