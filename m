Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD7212D9E
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076390; cv=none; b=k4xKEyZOaOwWM9A3hy/ERQrZWx3Jn/wJzlzv+qRwlM0kDSIfsKfmVCZA0JiXU7wrebO5wBFzMzW5TpU8GPKiJhHvouPIihj2X/i/IOdfT7N6jzBljceiI3LVcTQPHppy/MhjTHS3Plh+m95gjyGTnthFI83Ch66mTcNsX4tZpzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076390; c=relaxed/simple;
	bh=beia6WAgB33vVVZmnoTF98obrdZVu6Hz2GSVzDLnato=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uIMLgIRyvC+nAQ2vjy5aBABoKOMMlNUrd4RwNUVElKWGRS8pYmbV/EKIIvJFwE59am5azUJVhfwhoJwWMKYSD32sSPJLja10dszUw6njY/0vlCHo2zuP6olkCRzgdbGI3gUD4p9RX9rA461NlzZrcM6eJ1lArWEi9ldodFi6PTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoZ/C2Bt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoZ/C2Bt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso6664905e9.2
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076386; x=1743681186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n8JRLlE/3sP02WOiOTD1GD/rQeYj+RlHtCWwaEejuw=;
        b=VoZ/C2BttX4WDk5hJI1P9FW6BHffPoOvcfuPbt2Afi1oiP0089IKMcj36M0hBXtldB
         RL25ndPkv3iA+jirdUSar2h5D4Gh78pD5xsNqn3+WKkT8tGU9Z130ibbliuJ0uY/6UIZ
         4KrYNmifzUTEIzmUWITix+G1bKe/NG5hiUj8iroAM1CljV2vVB6AyOXzbYF/lr9q9e2I
         T77OtK2yf9X6TuSq/csqjza9za5VzaQRDQFj2o9ngPwg95D6G5IrcOnvzcwJLZdE0y2S
         C7JYyJBgTrDNuPDgxdXEgfE7+dsZGi2qYFsVOsKTfYZtOfUepr1b7zD1ZV5hZoAZ4fZK
         4SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076386; x=1743681186;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n8JRLlE/3sP02WOiOTD1GD/rQeYj+RlHtCWwaEejuw=;
        b=bK98p1KIpkOMaLLosTlxng93LAtL9PBKDXnvD1N9ZMqDZNAc01684JFVrHdmXs9/t4
         r78Y3nxJNfx5qYrJnHvi8a+qhTVke1ZUf5oC6ZA4BJSyXRC6nDAuaAsUzjEgSxFKfCzD
         oAFNPNheKLWZED+8Tc2aN9sK4sLG6CJHSh8xL4+rRxLvbdESOUPaqXhPIIf0Hw4nVFwG
         3Pk/jGl760yQuaEmlDAhArVWPAdo3MAbo8xozzr4op1H4EpqpLBq1d1WOGzG20GlGfJ/
         tPo+MUf39CtaInk+J00RtFieVOr7SalT3oqVQRdRrMTziuaEvZXQCrGWpna2uApPJ/LM
         5LZg==
X-Gm-Message-State: AOJu0YzGBImCXVKr4IfkNILchx7rWahY4A+/ENfrfWlwXXtB3TjjkOrt
	K2z4q3HQIBZy0ML57Rk+WH7zdHfGKYAOF2Q2J0448EfI2VaXwDmNr3ZgBg==
X-Gm-Gg: ASbGncvCcmo9dHklW0+6qlMJ78m1R27BOfEVn2aSqu10gdArnXG0Vjajckhcwt+FlhX
	sJ6IpwpK07o9xqKr5Cy21Y0YVuzdNxufKe9QZJE7fJoLEGeGB2Gb4zDqKOZLx+kRWSlRmpmh4Rq
	DGDU4L5FRj3uwYdy/Lg538G91hTOElBqbUtOThjkutF/1vR/CIYU1U+BweDlmFM9ZviJpfrzkm3
	E5jU+ln8LMBbdK+c62gsUMXZgBVWmIk+VQ51VlqG6iMFmtHQ5BahHQiR4iwgff8nis+32rVczpU
	HRGoTzYZTSctOxT0wU8Z0WT5RMOwBK8Xk6YLtOKJAGLSlA==
X-Google-Smtp-Source: AGHT+IGfUG+Qgtg1SYZPBnswiB8Rh0ul9iNcERWHMY0oP4B9uzAZNbuB0JlfUE34MGqr2aI0jfgDGA==
X-Received: by 2002:a05:600c:190b:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-43d84f9a086mr29119655e9.10.1743076385615;
        Thu, 27 Mar 2025 04:53:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d830f5f22sm35005805e9.30.2025.03.27.04.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:05 -0700 (PDT)
Message-Id: <913c7a0d29699c2bd80fefcdc00879c400f1e7db.1743076383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:52:54 +0000
Subject: [PATCH v3 01/10] remote-curl: avoid using the comma operator
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
    Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Chris Torek <chris.torek@gmail.com>,
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

