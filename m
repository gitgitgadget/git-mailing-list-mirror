Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364343ADE
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777822; cv=none; b=o3TtAzEri9/eKQMOiS+z0ldfMg5NyO0fDOmd7lO2SwDPXRgGu+rn9xCuEJyhbcqoJVpv4W7MKuNl3tOW2p4n3FmNS02NaW1OkTmPmXFZW19il7nFBAADt1cmxzRkwG6VLKLuQr1CY0qOXdTD2UDXaThYoCUg5si/z39zHP5McCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777822; c=relaxed/simple;
	bh=q+S9eVicHl33BaFc+gGKoQVO0m5AdBp0C1abu8oYs1M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TWaa62oAvKtYkp1MtVMXfjcYZTalSyzegS45UDNE5BYqVGpVX1zaDXzLFN1LHENSq+GZjRqqDEhlSNBMHlq2e3DRN4CLNZ3+YnvWrHP9OEiEzHIayNDkCq5XfO3rzRj8CKue6bAWNK1WKuDbyf/gVjKOJydPc7Xos6UEuwTwFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMtTum2r; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMtTum2r"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35ef3a037a0so1369383f8f.0
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717777819; x=1718382619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iTDhSvnkX0upqRdGVxDCCUvuBwLmhZJTWh96jCDT6Ew=;
        b=AMtTum2rdrQLiu/BDSU9vDdpvlwpX+/EhZkhs5Z82LfmDhyuyTgndVn617yr/V4Wcd
         WAGC+FA0NtEYho6cIOn3b88lpfAj+FAs9rUf+Vo45565y7mb+kWykzUP9vsd4cVzCdhA
         zlr+zSyMIFFjIasLmeKNejgoeRcY7/zCihtrWHL/IK8kpafW5JWPROPHFSm/awSQeQ+O
         /2q1fvV8z0Yv3gNdwwfWVbU4gad+Pte0e1J8p+F4wNOqFLHZCdgpfcHqjCEbj6XL9s4m
         dn/uYAt+WqjHUXaL5DAVRTqaGIzzo2pNM3ewU6Nsx3bf01AwMnllkbWBxoZQ4c6Q4/Cy
         NJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717777819; x=1718382619;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTDhSvnkX0upqRdGVxDCCUvuBwLmhZJTWh96jCDT6Ew=;
        b=HVVK0NgIgBGIoKLHRE+z0Cya4HoOWAj2zIFBQtMY9dtEMtwoa6XT9mjIEMIKBviZlq
         fLlyGEiMuKQK4Ds9ldjUE9Bc7b41hKgVA+Efj5jo2FhdM3P2JCz4URZe0YfZSWSjS6an
         hpVYnzN28Klqx2vwUg5U6WGrrGzlWHwjyxEx4G6PH9eR+flgORrYuIWgHN8sbnJpmLA4
         1V349aVi1u+62ShV4h6naNIjvmLKOrE1f8zFoShi5udS2Qw//i7laezxooyFoFktGzgU
         xa8wESH9LO8t5ey0WDkaxLgZr7gDRsmKD3XtDWDMUkprbMEKKVihlfBQYAicAjMLkXi1
         kekw==
X-Gm-Message-State: AOJu0YwdqO5UTU1ICdUhsrozElNmEW35zhaHGGwnHWIB1lcPtj3rVPJG
	mzmM6hhjuxYpZx36jhg3e91QpZyKK60TnYNy2+nyNplQOk1oJhbRsSmqUw==
X-Google-Smtp-Source: AGHT+IF+rl447YstyxXzA1TNHXd9smcfC08OKiX6UEUfkjmGcS3VmGIJPS6zpB5Qo54fYzVMMQmuhQ==
X-Received: by 2002:a5d:6d8f:0:b0:34c:7ed4:55a with SMTP id ffacd0b85a97d-35ef0ddb092mr7294938f8f.33.1717777818599;
        Fri, 07 Jun 2024 09:30:18 -0700 (PDT)
Received: from gmail.com (200.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm962970f8f.80.2024.06.07.09.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 09:30:18 -0700 (PDT)
Message-ID: <20b95372-12cf-49bd-b1b7-dc069e7c86dd@gmail.com>
Date: Fri, 7 Jun 2024 18:30:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 1/2] t4014: cleanups in a few tests
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
 <14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
 <cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
 <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
Content-Language: en-US
In-Reply-To: <9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
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
index e37a1411ee..5fb5250df4 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -820,8 +820,8 @@ test_expect_success 'format-patch --notes --signoff' '
 '
 
 test_expect_success 'format-patch notes output control' '
+	test_when_finished "git notes remove HEAD" &&
 	git notes add -m "notes config message" HEAD &&
-	test_when_finished git notes remove HEAD &&
 
 	git format-patch -1 --stdout >out &&
 	! grep "notes config message" out &&
@@ -848,10 +848,10 @@ test_expect_success 'format-patch notes output control' '
 '
 
 test_expect_success 'format-patch with multiple notes refs' '
+	test_when_finished "git notes --ref note1 remove HEAD;
+			    git notes --ref note2 remove HEAD" &&
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
+			    git notes --ref note2 remove HEAD" &&
 	git notes --ref note1 add -m "this is note 1" HEAD &&
-	test_when_finished git notes --ref note1 remove HEAD &&
 	git notes --ref note2 add -m "this is note 2" HEAD &&
-	test_when_finished git notes --ref note2 remove HEAD &&
 
 	git config format.notes note1 &&
 	git format-patch -1 --stdout >out &&
-- 
2.45.2.23.gd1e9f8561b
