Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15E36E497
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239892; cv=none; b=KQfuIwO5pdHF02mclagouJaCJSvTXJIXiA9w31RmtBgYzeplTmm+Y/t/O9AYUuqYtCREo3NIDJ93UM+PwgRmowh+1/rYkl67yT2aXz7S4yYQgydEcXiEPajK9Yb9Tb/MPK4e4JtA0he4o/YQd+DPm6IlQtU5OwPaMAx52ytVKlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239892; c=relaxed/simple;
	bh=wx+JlE70rOi4SBqFn/h6xoYD2eFQoDfjUZ1gsKGOsrE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nHJDC355Q6ZQ4O+uDz4IlxgKEdqS0Qmz5tXv62+A1/CygfaVV4JLaKwMltYv5ySb18evQAhAvnuOLFf4IPDEOcUi44VEbz25xph10OaWXSJune8cyFG2SPhAXuPbXmL2BEUUMD8R/qUiSNVBBvF6yD7uf5+TtRR6myAkh2H78gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b52hQ9Rq; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b52hQ9Rq"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c5382806fso9474261cf.2
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239890; x=1783844690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pISzHfMRvyruBo9Uw4e7eHU1iaUtDDgFkmtFTz5JzN8=;
        b=b52hQ9Rqp8FL69U73fnqxa6nwBDtEa7TSJTRMzPH0NO4i+nrKENYh0mvbliF7NDMQ2
         16K9SNsGmqn2yKqd7kRwSLmTk9PdKRdXMoUbtUuDL/iYQj4kbOncoNg+qgoDlxVXqYDN
         PAJM/YTuxE1XA9FdCueInwObnyuLhAfv3cn7w6cRfc4vFzy4BZ2WvQkyBCQEvcfGTuoC
         sQMcmCmZvV5HYAfaRZ0Q079yFdF6dvXpwxffq1EEYjUjBRBWzKMlUwnacxUqPvSTyXf2
         U41m3gZy4QN3iMPqlJsnBu+NkD7ut9b3GhMF3/Pn+RGgam2YK9vve5RPRnFsLLBawPo3
         vHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239890; x=1783844690;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pISzHfMRvyruBo9Uw4e7eHU1iaUtDDgFkmtFTz5JzN8=;
        b=Pl/2bbzZKNRN8dKgTH1+8ArWhhl77jybCbalVKIv1CY+2m1SKCysJQJdwjCadglCX9
         F+sJaOqqQdRe/JrrcFOQKkqUmm3rdzBTSYTfdHSafAYNSUD4XAE8ub+evqT4S0NK28Yh
         hsEsONbM4QrBrk0nMACxIXwZyVSPLqf2Dpwv3hdjkT1NNwcPJeaRyQmFPsCcf263MREI
         7NB7g7/cJo5mW6k4Myb9xs12Y8+RHLf2gaWbTXP8Fpkq4M9J8bqx7L96UrrsaeMlZn01
         +JRAg1e+RUBq6QtmBjdOn1QHUjEvHdlte/RnAGpAJDyceYs6EJrZmMc90oecNtTLGsKJ
         4HxA==
X-Gm-Message-State: AOJu0YwZRYNGViQehFWLaJLAOdLgnpYL78R66F9dl01TWgfJ2fSYfV3D
	mLbBPqqmyU/2BCOSTGrmzZllUkePPwHXNY0J3kNSomD9/g9rda5/zhmvcOPSow==
X-Gm-Gg: AfdE7cknheHqZ/h9mSrzquEl/Pt1gA/GP1ouPPMnMLq0ZN7sQMLMvlGv8L9+LLp7EG3
	i2njojqb1FVoByOy7jWbHQCcaV/utPC2u6G8gf4rGq/yJ/76jpDE6sobOO6DqIqiscZcqTZNlK7
	aHozLewCR8F5uhwpvf52ZHPAMhmpxiPFSevf+tpuZpE8kNNm1Vcu5t582NwoyV/HCyztiP6Tgey
	koLA64XfLDlU7Ry+DjDSsnrY/GdeuJvKuJ+EEpkWW+LrOrv+0Myl9TCJZguvOQPKkzyF4SmHit9
	tW6QIrvKBU5ej0BBLgV331Z53fZNvhyd1vCsw+dD27rL7UOLjfadNVNXjJ/sW7YKUVEdIpzJIvm
	/qH2zPInZTL7wgKNvBCkjH2UFGMmq2nU08lt6KRcPUTdplcUfPNhB6alhNQoERGoUnGgIqBsroq
	86KISWeauWf5IxnSxG6g==
X-Received: by 2002:a05:620a:4403:b0:92e:72a4:f28a with SMTP id af79cd13be357-92e9a418bc4mr833247385a.44.1783239890402;
        Sun, 05 Jul 2026 01:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ca004fsm629531185a.28.2026.07.05.01.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:49 -0700 (PDT)
Message-Id: <4048a225a5c3c0b698a2dbc58c756d217f851a72.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:26 +0000
Subject: [PATCH v2 09/12] imap-send: avoid leaking the IMAP upload buffer
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When uploading messages via libcurl, `curl_append_msgs_to_imap()`
accumulates each one in a strbuf that grows across loop iterations but
is never released before the function returns.

Release it alongside the existing libcurl cleanup.

Reported by Coverity as CID 1671507 ("Resource leak").

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 imap-send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index cfd6a5120c..0d16d02029 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1750,6 +1750,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	curl_easy_cleanup(curl);
 	curl_global_cleanup();
+	strbuf_release(&msgbuf.buf);
 
 	if (cred.username) {
 		if (res == CURLE_OK)
-- 
gitgitgadget

