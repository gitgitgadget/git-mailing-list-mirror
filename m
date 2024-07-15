Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF7282FD
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074863; cv=none; b=L0znRYD6M61NZNQG12NnMh7XxM4vivT78lLaNuTVmm/iaqmaJYta+NLcXwxtnr3K75xDawdly5LI+0Mf9ktKvKXVYxVyl45MqRW+C/ngbKtVs1QnV91g4Ud5kGNYVMzr3mnYpsvfBzbKTxHpJ9Y/n40832Sk8e8ZXqyVWiIHghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074863; c=relaxed/simple;
	bh=gAgdXh/gkFK7hVREhySVsjCZFaZgrSOv80xc1Ytvgi4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YCR+a6Vr32iZudGwVYq6ezo9mxqIBTpoV6a/AT6i7Cc5BmJFrPR/6MCKE1Auq88nUKj5HdEBIvVOJEaRFmsfZoDnUScWAMrN6MrhfSUx4uwYvBCVGjcNyk0MicfvffHsFHRPv5mY2fmbMxIpeIisXAYIl8XOS8ZGAZTDNdQk7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsEbZ2C6; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsEbZ2C6"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7611b6a617cso2902231a12.3
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721074861; x=1721679661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5mL8r9nAHoACS7bCrLv1OQbKk0PuFB71iOuVFQjke1s=;
        b=UsEbZ2C69tZd9APX8+RtegZdjwhTYZlRBe6Itocm4YdtEFcSug9Eu5neHVpvNhallH
         XVJh6a7obFaUd7W6u97rapc99OhOpRQyDOQL4JXbKUvIE8Ju1lwwpy7Q/AqwKTXCAf+Z
         GXct/Z8KrFW7tfqKNjI9e/qhIYoKLY9lQ3A4tDJASUzFvBhsSRhYNaSh6gWPo3YDJIDd
         Oy1hsGdueCOhCBFzOXQPGCilk2VjAaC5Nx4d6GCkH827myLejdxsQDjXsGMiuWaITqId
         o9OaTGLODwjLQLeFtMKFtLNVartaAcLjmm50+0MHFIUEpYsc1WCHWA60sqewm8w+qSai
         vl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074861; x=1721679661;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mL8r9nAHoACS7bCrLv1OQbKk0PuFB71iOuVFQjke1s=;
        b=s/PsL/YrVTyl39Xf8yubmCkx4KWje8PRSCDBeDk8atHU/p9ehQobqE5GRfgHPhQtuJ
         tVFwJsOa7ZvdMrtj9YgJEmfFZxXDk3m1xmhImevaXX5XJc4B1S4FDr2L12M/oKUHn2/L
         bIqVsTVHD3aMYLRdp75aixFpBozzW/svCHArzumTxLwQfPASud+/FXsBDAI0KbyMOtuf
         fJ3BlfHbpdUnlyWrttTtlL9gDqG7hVT3k+zd5LWpoTy5JrC5OlTvxIr2T3C3VO45umYa
         QqY6zZhhFWLtk7nDzstYlLpCeIXamtKlhnuKfoxawWjH9LdQ4knphtouRHWOz7kUnkiL
         YXyQ==
X-Gm-Message-State: AOJu0YxGJ8Iyfer+QhW/axrNSwEfysIOcoM2IGZnOcoXFouNlRZUvAiI
	dJtn3mX2FVetR9JVmkq7snUH3uq2DrvhsTdnGmyMKRgb/tm69rJMnA+8FA==
X-Google-Smtp-Source: AGHT+IFT4MBvKlThp7dEqeCRmp8eiK70wqmGa70nQnzPSoQahUZtr9dMPVO7GXEJxnj7jSGjAMTAwQ==
X-Received: by 2002:a05:6a20:748a:b0:1be:c71c:ff26 with SMTP id adf61e73a8af0-1c3f1275fefmr22903637.40.1721074861431;
        Mon, 15 Jul 2024 13:21:01 -0700 (PDT)
Received: from gmail.com (p4453252-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.169.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca75a6sm4782735b3a.164.2024.07.15.13.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:21:00 -0700 (PDT)
Message-ID: <6b21ace7-2abe-4ec0-9a34-09ec45599575@gmail.com>
Date: Tue, 16 Jul 2024 05:20:58 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 1/4] add-patch: test for 'p' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>
Content-Language: en-US
In-Reply-To: <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test for the 'p' command, which was introduced in 66c14ab592
(add-patch: introduce 'p' in interactive-patch, 2024-03-29).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3701-add-interactive.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5d78868ac1..6daf3a6be0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -575,6 +575,22 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'print again the hunk' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	 10
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	EOF
+	test_write_lines s y g 1 p | git add -p >actual &&
+	tail -n 7 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.46.0.rc0.4.g229d67bbd7
