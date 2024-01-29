Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CA15956A
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562522; cv=none; b=ewdNpHHKRQDqW/Mc7HLNtvmc2q9VpsNYA56PU3FehNtXdo1Wej0J5Vj6ZPJll/J3Wu9KJ3dTKUWlAnILFcDyB8slmN1YLKbgb1aspo1Sl1+GE7BOBBaCZaQI107kDKu1VtXAEiGPHrhFoJhDOe6fSF01MntF/m6RztXhsg97mmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562522; c=relaxed/simple;
	bh=flYupNXkICOTCaWjBpW7TFVL+ypPOSdE66aB1he64c4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=oxfw0GxSFsZC6O7zDJD/fkqkGYQGulYeF2pie+QlboBMr2ziXiSsBwOh4bR4kndE3/X7A5XU7EvXPac3TExoITBuAYxF1Z4KCfJllx/MKdNU3c510+wPS8oDwX28x++XX2K7wr/PSZk7GLh4RVqj2T+c8WRLeEOYK6VSMombwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLLEMUz4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLLEMUz4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ef6f10b56so10434265e9.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706562519; x=1707167319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGapvugrdFC3AYkG1KKrI/EoxGDcMBO6mIPlTKZykxI=;
        b=LLLEMUz4StVpFcYGzY3IgQ3eCxXabdoiN7Y6RZl4GvvVh6eY4Cmwd8tjTfcmUeJN1k
         SwM/mESNHMhdzU740ix+XOeEnIgKoytKpmlYP22ctH9todz5MOKHOXTKYgX/bssIhc+J
         HezQGMGR9Ihc4IoO/YoWlbJfLQxhVZsS1ENhOb0DenCWRXAuOfrT8aOncwfOLvBG5Gf9
         KehSNTrMBXFqPQtuwl9uouDqKaIJ0CdMigvwlRWOdfQePl40+a7Kuv1QxwoQIi0b+Thh
         WxzfpcVAkvRNxc2ToYjwVFlCRKzxJPrQEWN+7ybBJY4/z5lQcLMQybPTlZufMPEpMmzV
         WOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562519; x=1707167319;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGapvugrdFC3AYkG1KKrI/EoxGDcMBO6mIPlTKZykxI=;
        b=SfwNaRIeJ43nmt1VLErYleJITPR4aliR973oiKaB3nMm6YGsRz0HX/qZIuXlNsDLp2
         WbsKcjPZUlNiTCMpkqWFmJQjCtWY5F7itm3a0XOG/xoVNl6fSfjjePXbV9DbwxAls5YQ
         +gjTfD1oBSz5XGXiEj9vwJzmQAICGQSa7DSAjlCZZQxxAtnNlPmG8MGGLa1hStJNOfnA
         6m+5PUSWslszlHXi2ZbD3J9kLlJf3ACXNaZsnPD1hIRJdrbAwGkFMwM48tyzsprKscQh
         YnWDd7hXBCNzIZzoTlsSOd9egdpqLkQO8Qk98t+CxEw6b6riZmPYi/nvs4+WtlnzCFbL
         ybRw==
X-Gm-Message-State: AOJu0Yw/Qf4cxXVwELWFS7r3rHMkh25D3JeT4DBxTcQqXw0Db64Qf2qM
	qVxGnFzVLyT5Y8CAQc6PbIxg4MYHQWJ7xKsZiVzbo6kr6MG4kq2pTIo7kwf3
X-Google-Smtp-Source: AGHT+IEb4jTQeRDzJo0J2kEeS45IbSk77IbZd7vTTJQr0FXR3JDwvb2LhoyKqBQfkdAKhQITwNYKFA==
X-Received: by 2002:a05:600c:1c26:b0:40e:6d00:375 with SMTP id j38-20020a05600c1c2600b0040e6d000375mr5562914wms.0.1706562519090;
        Mon, 29 Jan 2024 13:08:39 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id p37-20020a05600c1da500b0040eee4931c9sm7928192wms.48.2024.01.29.13.08.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 13:08:38 -0800 (PST)
Message-ID: <6447b11b-f916-4079-8936-8d4f6c480f57@gmail.com>
Date: Mon, 29 Jan 2024 22:08:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] test-lib: check for TEST_PASSES_SANITIZE_LEAK
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
In-Reply-To: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TEST_PASSES_SANITIZE_LEAK must be set before sourcing test-lib.sh, as we
say in t/README:

   GIT_TEST_PASSING_SANITIZE_LEAK=true skips those tests that haven't
   declared themselves as leak-free by setting
   "TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
   test mode is used by the "linux-leaks" CI target.

   GIT_TEST_PASSING_SANITIZE_LEAK=check checks that our
   "TEST_PASSES_SANITIZE_LEAK=true" markings are current. Rather than
   skipping those tests that haven't set "TEST_PASSES_SANITIZE_LEAK=true"
   before sourcing "test-lib.sh" this mode runs them with
   "--invert-exit-code". This is used to check that there's a one-to-one
   mapping between "TEST_PASSES_SANITIZE_LEAK=true" and those tests that
   pass under "SANITIZE=leak". This is especially useful when testing a
   series that fixes various memory leaks with "git rebase -x".

In a recent commit we fixed a test where it was set after sourcing
test-lib.sh, leading to confusing results.

To prevent future oversights, let's add a simple check to ensure the
value for TEST_PASSES_SANITIZE_LEAK remains unchanged at test_done().

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/test-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index fc93aa57e6..042f557a6f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1297,6 +1297,11 @@ test_done () {
 		EOF
 	fi
 
+	if test -z "$passes_sanitize_leak" && test_bool_env TEST_PASSES_SANITIZE_LEAK false
+	then
+		BAIL_OUT "Please, set TEST_PASSES_SANITIZE_LEAK before sourcing test-lib.sh"
+	fi
+
 	if test "$test_fixed" != 0
 	then
 		say_color error "# $test_fixed known breakage(s) vanished; please update test(s)"
-- 
2.43.0
