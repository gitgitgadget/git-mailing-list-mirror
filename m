Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15F139F
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719730005; cv=none; b=gwiFSNdVyE6JPuvMNl5Qi2qwJkuVESLrtpYqHVx+lRhI70Zowf6weNe6zUZ+/l6iQSpNvz7Bmw+l1x3Rmm+6EOC+N1yLwbQLKpSgTUuySH51jr7swNnxF0OKkajveHnxk8kgyQU0Y3S12ZlqXLdCqYB1YIOzFPIhZYh6T0tQomg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719730005; c=relaxed/simple;
	bh=0C6sViryx9NRZt4y6Fe7uXpk0sDC3zzfyJXJgeYmi9A=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ZHVh2h3zxQnaMa/C3VJ81vXHilcMaejaBL5t/0uwIWzqBoOX5JDiqGdylRkvIyuVmIN/xuv1wsSPeJ6Kp/BwiM6UyJEhyBxJ3yfDqGgAWFhdqT1fDMWYdE0951Vj/3QJ/h+6DOlpvf4QhRK1mXRSviZfrPFmscGrQPpXYsLw6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8CC6fh1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8CC6fh1"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ce674da85so2135700e87.2
        for <git@vger.kernel.org>; Sat, 29 Jun 2024 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719730001; x=1720334801; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qneql8RHIG0c8Vq23lXDgpb/7zYGTofMKHd7Gn7PCE=;
        b=k8CC6fh1vfBVAJCvxxlsbsqoBYR1QOwoZhGGPkNqSm62UZXYTOaO+elSF3g0M5XQln
         M1UKVGSVkL1rAY7gvaslZNUmrU6QjNeAwq1lmGaYwZAA1mMt1kl1Jxbx/KzrH1Q3AG5C
         c0zTpy31AHGiHKDV6m1fyOIAbni5QiSA7HbOmHYACmhbXJBIOzuQiofaN89GF0dvdqr9
         +4GETzVqv6cqjBRGjimTe1dVyov9ZMfesRPk4ezWRYbIAMTgVIqP/COi07LGmdcgU+pD
         bfUCda2OKbPS3c24m1bT3p2DtXQynBdNYnAxPkXHoXeQpGqd44FT7kYazVdcSMFlfNkn
         5P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719730001; x=1720334801;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7qneql8RHIG0c8Vq23lXDgpb/7zYGTofMKHd7Gn7PCE=;
        b=qGy2zvCS7jF5pkkBQoq9kFqwAWqo8UxeT339xV7bjFI1PxgoVwVHLbDPhfUVJjlvJT
         y5XzBjnHdmiN1vFJBJoYInTPrzi4vOsEHUdmAaIMWvqj1kXduhsmJ06pmQ+TI+tQ1Wii
         khnVHDKLo/CQE2w8GYM3RTZFtSaNXjliDb5hWkZ/5anHyL8ry3d392Wra833rpkvZtX8
         pI+pMArR3xsYG3qPTMlNh88hjrYZ1uniDlMluK/sNIH6whOBLre9tf52LaFzoCosThXX
         K+jt/ZU7uu7CyF7oYJnbkfDUugBRkLPu5f1dHQvttdhCfTeEybRVQfISuYRnSXtNQ1zx
         7how==
X-Gm-Message-State: AOJu0Yy9eaU974e0e0e7diLrm6O3JOKDCrwgxlFvGN1osf+Tqwro03EJ
	qnHVbB4A8Q/B9KrO6n/DBQ/j8gnxJkPqLyzFQxXC/qhvkL4wJI7Fx8BQww==
X-Google-Smtp-Source: AGHT+IG7QjDzrGczw66Z7zJ1XlI9C/kIUAQsb+ZEqCaPkIlgxbzrRYNOYicxxbohzHogaVxDSwNH2g==
X-Received: by 2002:a05:6512:ea8:b0:52c:8e00:486a with SMTP id 2adb3069b0e04-52e82708fc9mr2077461e87.55.1719729999811;
        Sat, 29 Jun 2024 23:46:39 -0700 (PDT)
Received: from gmail.com (123.red-88-14-208.dynamicip.rima-tde.net. [88.14.208.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3912asm103890785e9.10.2024.06.29.23.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 23:46:39 -0700 (PDT)
Message-ID: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
Date: Sun, 30 Jun 2024 08:46:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] t0613: mark as leak-free
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We can mark t0613 as leak-free:

    $ make test SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true T=t0613-reftable-write-options.sh
    [...]
    *** t0613-reftable-write-options.sh ***
    in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true
    ok 1 - default write options
    ok 2 - disabled reflog writes no log blocks
    ok 3 - many refs results in multiple blocks
    ok 4 - tiny block size leads to error
    ok 5 - small block size leads to multiple ref blocks
    ok 6 - small block size fails with large reflog message
    ok 7 - block size exceeding maximum supported size
    ok 8 - restart interval at every single record
    ok 9 - restart interval exceeding maximum supported interval
    ok 10 - object index gets written by default with ref index
    ok 11 - object index can be disabled
    # passed all 11 test(s)
    1..11
    # faking up non-zero exit with --invert-exit-code
    make[2]: *** [Makefile:75: t0613-reftable-write-options.sh] Error 1

Do it.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

I'm not sure why this simple change has fallen through the cracks.
Therefore, it's possible that I'm missing something.

I'd appreciate if someone could double-check.

Thanks.

 t/t0613-reftable-write-options.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index e2708e11d5..b1c6c97524 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -16,6 +16,7 @@ export GIT_TEST_DEFAULT_HASH
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'default write options' '
-- 
2.45.1
