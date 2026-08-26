Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A247142B
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763132; cv=none; b=AvP5PZTqTEnoRnDMxcjgygaT+IH9UPtzCyqmOhJ/rePkEqUiTGYSduV4DAcoH9eps6J3gIIRh9Ok0vNJOMPJmSKsJAhBh/wctkp2b+Zu42pk1pYUKGloHyo9iDmB4oRfxVJZdYtqCblgdVI/EEfrvSnCbGswKIiJzWkS6dFVmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763132; c=relaxed/simple;
	bh=2wfSY2s34DTQhFR296lkGLLKF2LkhpedRnWo4324/HY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SVYb27H7tQ/E+Yf0TS+gxvChFm1UC4lpbKtNeThcoQKTmJC9Mabwo4WFA4uNyRWM5/sHVvEYGkMhVRt5x2hYu6k6kLbVl01z7YZhZ8RiZlwJ/pO670huxmu91pMTWxvVEnYdTxZBMqI1st0/YNSpG5s6NRJm+pgrIDd737hta1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR3Ix3GY; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR3Ix3GY"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-908a2ca5becso11072086d6.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787763110; x=1788367910; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8pGmMeQll06Mr0AxNSuXztNTnWSvb5TURu+6u7f+n7k=;
        b=dR3Ix3GYCPEeMUC3xqiYhz8yDy4NDm0KYsPIc/qKrH3bYl3lL7B/Fl/TYC6/+KgZKv
         y9RepAxIyO/fOnl7p+jhj8jm7JwRgmYY+iA+Oeb3lWVsWfxK7RoHs/VTjGBMj9I4t8yS
         rSQFbysNSyl2oWoBxFYiiYv1rVZkDNsTe+z2CyvW31hJqG2yKVDl/oKttCgy5qarcnIN
         /c3mHPW2bfJa7UrRbVG6n19zLX3CVnbgNS/poOoODNKNzDKyv7kPME43sgD5Do7u9KBG
         a54/hyFTzPaGywUVy2XA0ap1gg6w64lQoztLjdzvnbJcD4WvwhJq/e2ubxODWXwtYIPM
         jv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787763110; x=1788367910;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8pGmMeQll06Mr0AxNSuXztNTnWSvb5TURu+6u7f+n7k=;
        b=LVTj2WNdskDHDfdDjvIT46meVHStEhq6tjm8mjnJgj0r/I8uUp1OT+qkTnryf1ehe5
         X3pTweE289tfRK5LFsP6Bipbnl7Oo1k6Awire8TMBrk5Cajfm8SO4UA9x4/D6ywZ71+t
         MmgwKWX8+L9A7qiUrvWWI8WcFNh8pSj7x4jVCjn1czRnLSMSV2X4QMPc8tott/1yapMD
         bVxQUl374SJYo2bn9XRFhNYmwLapGexyk5Yyad4XgBPhWwQHHyJduJttKS2Ai/XeriaB
         ve5ITlU03MQRJIuR+PjtGhAW69zZQJeHnXTXnxBMa9n6PM5FfYOVQDqrqyuipsS9ZciE
         dhPg==
X-Gm-Message-State: AFuF++kyH4rlg2Kbc97PZ8F2GvV4ikv3mhMZ9lpomua5+bYmhgYNl08W
	haHfrF6+g5E1Oik++cHNf7Rf0IqH0emerM/LpL+IgeFovMxqDS3L0XdN5H1xhw==
X-Gm-Gg: AR+sD13OZ/k5MWCCb5EjmKcLLvHP2oF4rRrulVHq7RCOpnfHyp1La1g5L/U8rVvYtvq
	5PTJoV+t2Y1hibZDv4RlXeqGS0UEbscLDXFNhHEQwQt2TJfSOip3h7GXaqjpWQgJWW4Mhg/h+fx
	wVmCE352E68rGpqooZs3ZVXmN9+NtUCcJMd4erJYd0Tof1DTAKulRLlpkaG2ViZOLS9BiuRfLKH
	R2/jaxBFJuf+SGyDqFqje4OgLZTOUwYpqOgQd7LwE7F+CHLinFl5fNqQ60IbGd1z8WHPdOnMEe1
	QyKrVW0io4Vh6fuBxaODXPDlFLQRk2U2/ccSedolDzv4LK6VtzmujhiIzA7eE9Yxt8mCwYhT/zC
	Yj6lIjg75YQ5P3VtVqwbIW+39N45+6b0MTDboxEHtIAmjV78Lpi5jxFx8X4z66uvqE9yYtFGC1n
	Blg+dV5oLBA+g3thlJuNDll9N9eEtTdCzwlHaYQVMzdLsclHcYxFC8vqSnE5wvxHA=
X-Received: by 2002:a05:6214:1244:b0:8f0:a849:f392 with SMTP id 6a1803df08f44-90cc7958d25mr89348416d6.14.1787763108687;
        Wed, 26 Aug 2026 09:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.191.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc63e3108sm30087186d6.11.2026.08.26.09.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 09:51:48 -0700 (PDT)
Message-Id: <pull.2204.v3.git.1787763107646.gitgitgadget@gmail.com>
In-Reply-To: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>
References: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>
From: "Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 16:51:47 +0000
Subject: [PATCH v3] t1401: check symbolic-ref failure and --quiet silence on a
 non-symbolic ref
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Nikolaus Schuetz <nikolauspschuetz@gmail.com>,
    Nikolaus Schuetz <nikolauspschuetz@gmail.com>

From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>

git-symbolic-ref(1) documents that reading a name that is not a
symbolic ref fails, and that --quiet does so silently.  Tests such as
t2020 and t5621 already rely on "symbolic-ref -q HEAD" failing on a
detached HEAD, but none checks that the plain form reports the error
or that --quiet stays silent.

Assert that a non-symbolic ref fails with the "is not a symbolic ref"
message, and that --quiet fails with no output.  Use test_must_fail
rather than pinning the exact exit codes, which are documented but not
worth freezing in the test.

Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
---
    t1401: test symbolic-ref exit codes on a non-symbolic ref
    
    git-symbolic-ref(1) documents that reading a name that is not a symbolic
    ref exits with a non-zero status, and that --quiet does so silently
    rather than printing a diagnostic. This exit-code contract was untested.
    
    This adds two tests: querying a non-symbolic ref exits 128 with the
    usual "is not a symbolic ref" message, and --quiet instead exits 1 with
    no output.
    
    Test-only; documents existing behaviour, in the spirit of 919eb8ace
    (t1402: check for refs ending with a dot).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2204%2Fnikolauspschuetz%2Fns%2Ft1401-symbolic-ref-quiet-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2204/nikolauspschuetz/ns/t1401-symbolic-ref-quiet-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2204

Range-diff vs v2:

 1:  22694da869 ! 1:  0391dcceef t1401: check symbolic-ref exit codes and --quiet silence
     @@ Metadata
      Author: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
      
       ## Commit message ##
     -    t1401: check symbolic-ref exit codes and --quiet silence
     +    t1401: check symbolic-ref failure and --quiet silence on a non-symbolic ref
      
          git-symbolic-ref(1) documents that reading a name that is not a
     -    symbolic ref exits non-zero, and that --quiet does so silently.
     -    Tests such as t2020 and t5621 already rely on "symbolic-ref -q HEAD"
     -    failing on a detached HEAD, but none pins the exact exit codes or
     -    checks that --quiet actually suppresses the diagnostic.
     +    symbolic ref fails, and that --quiet does so silently.  Tests such as
     +    t2020 and t5621 already rely on "symbolic-ref -q HEAD" failing on a
     +    detached HEAD, but none checks that the plain form reports the error
     +    or that --quiet stays silent.
      
     -    Assert that a non-symbolic ref exits 128 with the "is not a symbolic
     -    ref" message, and that --quiet instead exits 1 with no output.
     +    Assert that a non-symbolic ref fails with the "is not a symbolic ref"
     +    message, and that --quiet fails with no output.  Use test_must_fail
     +    rather than pinning the exact exit codes, which are documented but not
     +    worth freezing in the test.
      
          Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
      
     @@ t/t1401-symbolic-ref.sh: test_expect_success 'symbolic-ref refuses bare sha1' '
       
       reset_to_sane
       
     -+test_expect_success 'symbolic-ref reports a non-symbolic ref with exit code 128' '
     -+	test_expect_code 128 git symbolic-ref refs/heads/foo >out 2>err &&
     ++test_expect_success 'symbolic-ref reports a non-symbolic ref' '
     ++	test_must_fail git symbolic-ref refs/heads/foo >out 2>err &&
      +	test_must_be_empty out &&
      +	test_grep "is not a symbolic ref" err
      +'
      +
     -+test_expect_success 'symbolic-ref -q is silent and exits 1 on a non-symbolic ref' '
     -+	test_expect_code 1 git symbolic-ref -q refs/heads/foo >out 2>err &&
     ++test_expect_success 'symbolic-ref -q is silent on a non-symbolic ref' '
     ++	test_must_fail git symbolic-ref -q refs/heads/foo >out 2>err &&
      +	test_must_be_empty out &&
      +	test_must_be_empty err
      +'


 t/t1401-symbolic-ref.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index a2a7e94716..fd3aa89a91 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -38,6 +38,18 @@ test_expect_success 'symbolic-ref refuses bare sha1' '
 
 reset_to_sane
 
+test_expect_success 'symbolic-ref reports a non-symbolic ref' '
+	test_must_fail git symbolic-ref refs/heads/foo >out 2>err &&
+	test_must_be_empty out &&
+	test_grep "is not a symbolic ref" err
+'
+
+test_expect_success 'symbolic-ref -q is silent on a non-symbolic ref' '
+	test_must_fail git symbolic-ref -q refs/heads/foo >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err
+'
+
 test_expect_success 'HEAD cannot be removed' '
 	test_must_fail git symbolic-ref -d HEAD
 '

base-commit: 745601a9a94110d74769ab605ccd4f61339758d2
-- 
gitgitgadget
