Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85A193071
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431832; cv=none; b=EWLv8A50DIpZ+J+EvxBf6lMlrChM/8P1snWire4i0bLOOR4MuO70U/LvXraNMBoA3whIepFkNQGlz5UPRxdoFLBMhzbS3BvnYN+DKw9JlmC1ZTehbvEvmB1CmytqDmDP3kKDOtQ0eMKIKNwjFI/Wr1l7E13z7zndnnb8hvWKRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431832; c=relaxed/simple;
	bh=Hgdwg9jq32bfGDCTN7TaLlMjwbDlvAru9J485X6AxK4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rRe2k0mwGhkOL+sY+KgY9SogZJuG2NtKnF+qoVsPlG5qNG8hyDFLMQkWW1CvlQKfeZ+/aiCMg29ttHUeVZGtoSbIg3fSvEr8FnSdwEW+d1Rk1O+fWwRQo5xhHRACNYz0krb1dfZc4reiCJ8n3gfo1Ko+Npp+xZIWW0O9Ze47kD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMUx/YWz; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMUx/YWz"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so4618167a12.1
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431829; x=1730036629; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJg6mhjuCNCDeffaaLX2yUFzmFvXL8ZcLQC5hTzIT2w=;
        b=SMUx/YWz+ykRjklMYkOqFHQGmTjoC+XdbNh+u/5XrrBUdQH5ZLcRxapIUUbMxzcEZ6
         t7eo/MJYavu/oqh75ze1EkY73UysRcWizUcOc2+25W5fcKSzMNdKGW/FrBsDS6+g1Y3L
         egQo25VQPWK1w80w5mnej1ZK6ETzLOy2I/3kZEFngyLO35LWF8hc2HAx/yAOdXy9DNTB
         khTy1gKVtf/WTlic9KTxjwp3SryF7wcMgt6aehVc5toJbybHUbYsIVeLdumB/f4MrNxv
         ccHQkQ1GmjjHKwW3ZVtStcx3+e7hYiB3CbzFBLjVuTLWLjp4WmedtOh0X3KAHZSDlrIk
         P5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431829; x=1730036629;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJg6mhjuCNCDeffaaLX2yUFzmFvXL8ZcLQC5hTzIT2w=;
        b=OWgPKX8llMp7Ulag2begLGKlX6hIn4wEDtn4iGT3JaDl5gV+PUAxkbh4KUyeJui7X3
         mXHsLnDeiwELDYQK+VDEqpkUlDwIqwqfeBKGC4VRoM8RsY7c7zvJJ6UDxXna/4GIWrmG
         6uIxe6MUrFMtSpdWmmMONSLwsXZICtBRN8qleUW67e1MEoaiZOiVo6rqK6fHfoi88Rm7
         Z65V8L629Ss58m9q0yrr7OtPins1O+ZlUcNNoNLe9u0Eiv7sO1tf/pX9Je3ORh1B2Mmf
         eZgDyryh1dN5uoYDA3hoaTyncVmNdLQtaRovQvdU195Jngm3m9jrp22gXhCKFWxOhvK3
         tipw==
X-Gm-Message-State: AOJu0Yzhx2VqA2jvBvRAqF21ni37fqiJ89sAq8QfQuSEkFBKTve4Ti6k
	EE+4FxRhjBfuQIQ6rGLKKS3ZU2FdG/yveOWl/V2ptoDQDbKK+iL5wgYp3g==
X-Google-Smtp-Source: AGHT+IHPYhsrwpTxFOcBKPFbwf+R3Uimmwsc6w0Tql7PWdhigxRk8r6eT5LC9w2WSBbsrGQkZPKxgA==
X-Received: by 2002:a17:907:5011:b0:a9a:3da9:6a02 with SMTP id a640c23a62f3a-a9a69ca3722mr621470166b.60.1729431828509;
        Sun, 20 Oct 2024 06:43:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d62efsm91739466b.44.2024.10.20.06.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:48 -0700 (PDT)
Message-Id: <0f3040b4b90916610af518ef724256cff537a648.1729431811.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:28 +0000
Subject: [PATCH v2 15/17] scalar: enable path-walk during push via config
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Repositories registered with Scalar are expected to be client-only
repositories that are rather large. This means that they are more likely to
be good candidates for using the --path-walk option when running 'git
pack-objects', especially under the hood of 'git push'. Enable this config
in Scalar repositories.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scalar.c b/scalar.c
index 73b79a5d4c9..daec7a4d08e 100644
--- a/scalar.c
+++ b/scalar.c
@@ -170,6 +170,7 @@ static int set_recommended_config(int reconfigure)
 		{ "core.autoCRLF", "false" },
 		{ "core.safeCRLF", "false" },
 		{ "fetch.showForcedUpdates", "false" },
+		{ "pack.usePathWalk", "true" },
 		{ NULL, NULL },
 	};
 	int i;
-- 
gitgitgadget

