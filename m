Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C815AADA
	for <git@vger.kernel.org>; Wed, 15 May 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800874; cv=none; b=MMI/T4RLbADiUKlpBbQ5hqy+sylbVJ+7UXq0WaMwmutwuslMzY5ZiFOSl7BwldCQqjAFxNyGE7fbsliiu4+xt0201XrABTTCXDhWv7Wu/OW2bWdzw/KZMk9oQWcqO698TpZ6PU633cQpFesweOE0VxhDuJzcUxSFig734liK3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800874; c=relaxed/simple;
	bh=NLZDEdYRTIsfIaj9qn3M/gm9DIKDUJpzybWJZW7XR6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rmM9LDIfmg89uOuOKwbJMpAdQ6B0xlK02JyKeEVlT2B2iW5E7B0Lhf751GchP7miC6Yadg0M5cJB4rwy1GefbVDcaDxWFtGdGlkQh/dhwifKBQS/p5Xi9M9VHrLbXgf5kMipQkFAuvQxn61ezqnItp7o9hNCnkPeiuICguzl2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh6A7xFO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh6A7xFO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41ff5e3dc3bso41601795e9.1
        for <git@vger.kernel.org>; Wed, 15 May 2024 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715800871; x=1716405671; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50goC9gnpuzkLL78yJlIkLlyG0W48ZtTMHzuj9pOAHg=;
        b=Mh6A7xFO6AHThsJ+KvoIosFwjshGzKN6w8W7DlbOFFzUUY+M0IoGDGyxmE4wm8H6uy
         8ngmUpXgtjFDHRZ1aJQLEtlxF81jIy/BkNgN1upx5Y2BhYBaxwFe3b+QXzGlCUl02EMC
         HN/YkURst6lu4lmZ5tR3U9cRBkWrRYJPkG0Q6e6e7UdQ/pd9KD2GYFp44PkSAG1ve/rL
         kwv5tfe1N6jTQqQoQEUyVt+qLnLUPq6lCSrDbFgWflVVGPfjTH226UENOkyA1xkfnmCI
         FcMHylyV0qwE2So+jD7v8qPmBy+fvETA5JeCi7i9EWyV/NgIQT6r8RCuHw70kbaDl3Mw
         L0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715800871; x=1716405671;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50goC9gnpuzkLL78yJlIkLlyG0W48ZtTMHzuj9pOAHg=;
        b=Ppxjbi0ei0kkCKH+uo13NGHHa8/oiLq/X5uAI5cKaNaKroGBMo4WC1sAXCPeIK7min
         IrPsjBAVTQhzzFthrXYGn+mmQubafXyPJULBdlrqGaehCj74fN0ONrkfaTX56lYfYH7V
         W1QrxofIzmayeJMcYmLUSIMFVitcqeWqpeuf8TwbYeR7ECgJD28hGTbS+26ESjad220o
         WkuaBY66O1MZ5KHwQWZp64elgPOaKHJLR26ty/b2KVz5FFpJulNUPoZhssvaZjftu0zf
         oafZ0SZIfdCqcaVzgIPWkQDL7Po3A8EkQCEn9he08pVAq9ZWE4xh8AZ7BG3AHKXLjI/e
         aEQA==
X-Gm-Message-State: AOJu0YzYMz2xB6TYI3aBGMeXdt3Sq12FdtHmzIGwY1YCQB0spResejaA
	om8NKxHMl9XeRgkUNNips8gouTl6Bi8Q9ARNpd86CpFUVIIEM5U3678TAg==
X-Google-Smtp-Source: AGHT+IFlggI36hxn/E8DAvRV5cxw+3uhU63t0ClWxkOoJ4X5N5GuZM09HpEw5RVm3PrxNVBIIjg93A==
X-Received: by 2002:a05:6000:1010:b0:351:d383:631e with SMTP id ffacd0b85a97d-351d3836377mr596176f8f.24.1715800870712;
        Wed, 15 May 2024 12:21:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a788fsm17062165f8f.55.2024.05.15.12.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 12:21:10 -0700 (PDT)
Message-Id: <3341346c5e6caaad3f222380a82425e1f14b97fa.1715800868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1729.v3.git.1715800868.gitgitgadget@gmail.com>
References: <pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
	<pull.1729.v3.git.1715800868.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 May 2024 19:21:06 +0000
Subject: [PATCH v3 1/2] osxkeychain: exclusive lock to serialize execution of
 operations
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
Cc: Bo Anderson <mail@boanderson.me>,
    Jeff King <peff@peff.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Junio C Hamano <gitster@pobox.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

git passes a credential that has been used successfully to the helpers
to record. If "git-credential-osxkeychain store" commands run in
parallel (with fetch.parallel configuration and/or by running multiple
git commands simultaneously), some of them may exit with the error
"failed to store: -25299". This is because SecItemUpdate() in
add_internet_password() may return errSecDuplicateItem (-25299) in this
situation. Apple's documentation [1] also states as below:

  In macOS, some of the functions of this API block while waiting for
  input from the user (for example, when the user is asked to unlock a
  keychain or give permission to change trust settings). In general, it
  is safe to use this API in threads other than your main thread, but
  avoid calling the functions from multiple operations, work queues, or
  threads concurrently. Instead, serialize function calls or confine
  them to a single thread.

The error has not been noticed before, because the former implementation
ignored the error.

Introduce an exclusive lock to serialize execution of operations.

[1] https://developer.apple.com/documentation/security/certificate_key_and_trust_services/working_with_concurrency

Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 6a40917b1ef..0884db48d0a 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -414,6 +414,9 @@ int main(int argc, const char **argv)
 	if (!argv[1])
 		die("%s", usage);
 
+	if (open(argv[0], O_RDONLY | O_EXLOCK) == -1)
+		die("failed to lock %s", argv[0]);
+
 	read_credential();
 
 	if (!strcmp(argv[1], "get"))
-- 
gitgitgadget

