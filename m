Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213933EE
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793714; cv=none; b=VDAr5aDxj3FtTcwGDXqe9yjMYbVNh6I0g4Wi4vsLorKfkNE5RdnXFnhzHRKKkYVVtwbbPGicHM7I56/duPe8eDnXCbINIvHI8S1SczhvhBYhYf79k7p+HQjCO6+oZ5BNgWn0V+oAOg0cY1VzLC1D0NWVcaZRx9mfUN5mubuUeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793714; c=relaxed/simple;
	bh=UgZAfMtrAuosg6GsrtWpTnZgLRUZeIh5/hvG340ERYs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NL9bNfVSDHtBUcfcAf2IrAHD4H7qEcMBnku56JPleY4R1N+BhnK900qSkj8jVrxuUmt6BSbilofLg95BpwekRlyL2Qe4Q9zYC4nUwG1p0e0KRfGksk7xbB1xuIcCUjS+tTd2oXMvaQwrCgzRYeNTF1Qu1DPZDMiUj3m8DpWSWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQVUNPfm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQVUNPfm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42121d27861so24161445e9.0
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717793712; x=1718398512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+SbaQH3WA6SYsViwrCSRGhUIQmk+Ul5uRLrUfni+8i4=;
        b=MQVUNPfm7hptlmDxLZMqG8x/Zc2fKuUNo8NXJ9kzjFgI1aKygnQo/E37mDSU2JT4AJ
         HU1MTGkBjiAsu58bwQveVXme0eG4Cd6q8KYLEDrZUeBOeAuq/nnSGgzwA0NjdVJitLJi
         k+rddBMYh1dSYVCs0wRQ0wgDhkKSNf0N5ZYUbJbbvJMB1B0sSCinAs82fiDAadKYpU2z
         G03hr1Uci5owxOh89a09kUiQxn/MEVXeBP+OXUu3djMZ6EFL1Ida9AJcjP8fU3L7AQ9l
         GY7Xo1APTGn1am8zaNkkQEmUd57h0fq7gGz05afTGPSEGqzT4fqy8DRoM7ZwsVGQcuZW
         5mRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793712; x=1718398512;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SbaQH3WA6SYsViwrCSRGhUIQmk+Ul5uRLrUfni+8i4=;
        b=rfLPBy2lOu+gQl7yFne75VQLnNEdbTTHOdwbpqp3EUcOPyUg5diPZpK44WKTijYNKN
         YKNSrrofd73+yjoDkXQy3PWE0Jm9EeVtK4yrG3KyNgSSAjiODjfjAL2XSGIbQGiBpLD4
         ES058Y7He0UmaOxxthGzeD3+9WQCG6mURXnFcNCQmMmx1nvq8jYoEGqYOGDhypWC6sku
         tA6k0rA+uwKVs4N4ERSoO8U7LENJJyQKtQdvgSmGoj+4HLKpm//QGj583SClWuHy3V4K
         O3Wrz6LeLHNkFuIlng6WVGtMzIwrqKj20A0rMa57JA6w9Oo8ragoxw71uitT9ZAEqYvm
         avQA==
X-Gm-Message-State: AOJu0YxrB0TUvJPdWkW2uJ3KoSdywddKteEGL3sgQSwyYCK74qQEGSH6
	c7eAnnd1m4+sTMro3QUsyB2WntNLngvGMRNPeeZ+ZAD7QlXCuU0Z9DRGEQ==
X-Google-Smtp-Source: AGHT+IEmtUEbpZ2E41zszxtvUqcRsPnrti1uR2jVuWw+bM9cTE9ems//TA023aU+OWbu6+Wrs4fRsw==
X-Received: by 2002:a05:600c:19d3:b0:421:2a3d:d8b6 with SMTP id 5b1f17b1804b1-42164a0ea75mr29218385e9.24.1717793711489;
        Fri, 07 Jun 2024 13:55:11 -0700 (PDT)
Received: from gmail.com (218.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2cd247sm64722515e9.40.2024.06.07.13.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:55:11 -0700 (PDT)
Message-ID: <07323810-69b0-4171-b775-77a97d29cc35@gmail.com>
Date: Fri, 7 Jun 2024 22:55:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 1/2] t4014: cleanups in a few tests
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
 <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
 <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
 <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
 <91014071-13f2-46d3-aae7-75c8ea036786@gmail.com>
Content-Language: en-US
In-Reply-To: <91014071-13f2-46d3-aae7-75c8ea036786@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Arrange things we are going to create to be removed at end, and then
start creating them.  That way, we will clean them up even if we fail
after creating some but before the end of the command.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t4014-format-patch.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index e37a1411ee..a252c8fbf1 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -820,8 +820,8 @@ test_expect_success 'format-patch --notes --signoff' '
 '
 
 test_expect_success 'format-patch notes output control' '
+	test_when_finished "git notes remove HEAD || :" &&
 	git notes add -m "notes config message" HEAD &&
-	test_when_finished git notes remove HEAD &&
 
 	git format-patch -1 --stdout >out &&
 	! grep "notes config message" out &&
@@ -848,10 +848,10 @@ test_expect_success 'format-patch notes output control' '
 '
 
 test_expect_success 'format-patch with multiple notes refs' '
+	test_when_finished "git notes --ref note1 remove HEAD;
+			    git notes --ref note2 remove HEAD || :" &&
 	git notes --ref note1 add -m "this is note 1" HEAD &&
-	test_when_finished git notes --ref note1 remove HEAD &&
 	git notes --ref note2 add -m "this is note 2" HEAD &&
-	test_when_finished git notes --ref note2 remove HEAD &&
 
 	git format-patch -1 --stdout >out &&
 	! grep "this is note 1" out &&
@@ -892,10 +892,10 @@ test_expect_success 'format-patch with multiple notes refs' '
 test_expect_success 'format-patch with multiple notes refs in config' '
 	test_when_finished "test_unconfig format.notes" &&
 
+	test_when_finished "git notes --ref note1 remove HEAD;
+			    git notes --ref note2 remove HEAD || :" &&
 	git notes --ref note1 add -m "this is note 1" HEAD &&
-	test_when_finished git notes --ref note1 remove HEAD &&
 	git notes --ref note2 add -m "this is note 2" HEAD &&
-	test_when_finished git notes --ref note2 remove HEAD &&
 
 	git config format.notes note1 &&
 	git format-patch -1 --stdout >out &&
-- 
2.45.2.23.gd1e9f8561b
