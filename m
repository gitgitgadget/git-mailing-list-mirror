Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D77D16D9BA
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862728; cv=none; b=Y8kUE/Y1qI1+7evvfq1tPJHAyLTipCTpcVgh+FlZhPVyJRQYwXRMQ5aFNuEkI/6RybZk4bA3Dz6QVPq/N5gBFXXmyi/kfh8RaK0ab2gMqBPrF+Sr2ab3FB3MDgr0Mgn5hzsQ/pVBYMAswNKiONf9YjUJR852V9o+MCrtJ51E82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862728; c=relaxed/simple;
	bh=gS2iJ+MW26N/Fgiw8DgP6LbPy3jJkM6DLLw9MwS/F6Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RI+zzoYMlyb4eKhpR7pgAfi5+wyf/8qCAKTvDPmk98Z1nLyv8qXhAIcGlSmb5qDezVn6BwMMtPlBqrI9Wct5pH6DZ/zPYzlGdNErdd+NhReAsZktjcODAMUu81jYzgXvMXdabOB5QSNoNt2JAYZYYMi+MiNzDNG0umMHNMrn458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdLOaMzX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdLOaMzX"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36532d177a0so2013495f8f.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719862725; x=1720467525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDyGmul1hMYaUkXhN53QwBKHR/8ZBjTWaR9/QWcYn/k=;
        b=CdLOaMzXzNkx7z4hrLFtuVitp1WUuyoyQOsHmdV2bM+5Ygl3iDUTuhlNY01CR3LhMO
         OJkFslxe1JAJmRkAsnqKT2UdmbWPO8UxPY/aAFuANLz1eC4BzKH3MQQOj6VMqn5gNN/F
         rMK4F/SuADv+pSXCLPCdFHFpVOxGkrRh8lw7IPGZCPcAKwufIERLOsxeOAw4/TNJx0+h
         DJnyUIcqMNQ3BdB5Xej+nWjGIu/cQvzatzlhH3AdPPjtKmaulOxfVbwopYYopM8Qu2Mp
         rb254RTCZXzkZw6OYMuCYN5g5TNfbzEmfDwrzI5HMRktqs+Q2WYa6ckR5rXAEjtpR/ah
         Llfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862725; x=1720467525;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDyGmul1hMYaUkXhN53QwBKHR/8ZBjTWaR9/QWcYn/k=;
        b=hMIAQ985vo4Teo3svKd6T2EVrEv0cayE8x2EArU0mMTVeq//ZeUM0quuTkchaNKNI2
         a87DlIvPn+l+/CDv1tdL8yptYdDZWutqO1EnAhVPJfoTqOdU51k3Ae837DnooOtMU+Ud
         9+eyAVGWfxXKzUuWx6iwiCGH0SamDSd7SxP9LC9p3+Vz6rc7wBbib6NcsRsjEHIBLqWX
         a+jy4lCa7lvMO9mzIsNfI8840YjHG1li67KNI08Q7x0+CoF6OamnKn/FHXUaGgp8OyCx
         XAEYLFHlS8RcMAwu29+uD8X5Szrs0cBKNIbI72q4Xfd/309+QMhqyJCpXNpEoOE9D0TC
         EDlA==
X-Gm-Message-State: AOJu0YzfzLh/UCGOTSm+vU8m/pZ+YM1sK8o0hOcjENg2jRJ57V0uqC+A
	EFXSZhTibkMsl/c9GdM+hqRvJX95GQrM0gX1ESQSlgPKuOo6Gteh
X-Google-Smtp-Source: AGHT+IFGasgNIpAZ0UCGQ571k6gOsoU9NGNtmtMj5b+nxfLAV5yuKv2OlI/m+fstzNcLE6tkGdzZlg==
X-Received: by 2002:a5d:6a02:0:b0:35f:1d10:18f0 with SMTP id ffacd0b85a97d-367757285admr3316090f8f.64.1719862724817;
        Mon, 01 Jul 2024 12:38:44 -0700 (PDT)
Received: from gmail.com (82.red-88-14-59.dynamicip.rima-tde.net. [88.14.59.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a102fd4sm10863209f8f.90.2024.07.01.12.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 12:38:44 -0700 (PDT)
Message-ID: <d244fb44-0bd2-4416-b24c-0a93835b75a4@gmail.com>
Date: Mon, 1 Jul 2024 21:38:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: t0612: mark as leak-free
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
 <20240701035759.GF610406@coredump.intra.peff.net>
 <7ef69875-b18f-4ccb-be83-e994315636bd@gmail.com>
In-Reply-To: <7ef69875-b18f-4ccb-be83-e994315636bd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A quick test tell us that t0612 does not trigger any leak:

    $ make SANITIZE=leak test GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true GIT_TEST_OPTS=-i T=t0612-reftable-jgit-compatibility.sh
    [...]
    *** t0612-reftable-jgit-compatibility.sh ***
    in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true
    ok 1 - CGit repository can be read by JGit
    ok 2 - JGit repository can be read by CGit
    ok 3 - mixed writes from JGit and CGit
    ok 4 - JGit can read multi-level index
    # passed all 4 test(s)
    1..4
    # faking up non-zero exit with --invert-exit-code
    make[2]: *** [Makefile:75: t0612-reftable-jgit-compatibility.sh] Error 1

Let's mark it as leak-free to silence the machinery activated by
`GIT_TEST_PASSING_SANITIZE_LEAK=check`.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t0612-reftable-jgit-compatibility.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit-compatibility.sh
index d0d7e80b49..84922153ab 100755
--- a/t/t0612-reftable-jgit-compatibility.sh
+++ b/t/t0612-reftable-jgit-compatibility.sh
@@ -11,6 +11,7 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 GIT_TEST_SPLIT_INDEX=0
 export GIT_TEST_SPLIT_INDEX
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq JGIT
-- 
2.45.1
