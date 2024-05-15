Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164415AAB6
	for <git@vger.kernel.org>; Wed, 15 May 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800873; cv=none; b=kOVegEvz/5Af3qP49aD9sPKixCL32msLM0Z7hxjUq3nlI28ANlc7XBX10bMU82NNkkrMD+ZV3Dw1QTjalRgbXt9fad1B4CDeiU8xlxhlkmPzognNWoF5oMkBK7A22CLGRIBDPeueL9fM009I5g+fRDpvqdzQOscrM81fO9PQ5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800873; c=relaxed/simple;
	bh=KSMGDWSmhzy1TBVjKXTIKI2+xt/DLnfiZaxXwaKWo5E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hM9EN+H36dvmEcQzT++lZrDkRuWLhBbskL+ZrY2smFkw1ygqzYPaHSFCDmx3YllrXvOG40Ycy4aFwrfCwXy7EzyVx4I3zqOFEL/LvieC5Xcbnr6f4BDBWFA1elY0vABljH1Pn34vvRf2yTBiol5bdabD1G31hy0Ub8i3KEGrAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXnhMXlw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXnhMXlw"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34db6a299b8so5383676f8f.3
        for <git@vger.kernel.org>; Wed, 15 May 2024 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715800870; x=1716405670; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp36UvWuLTZmtfFKoVRWMOLajVHC98uhfAcqr9sn7YE=;
        b=WXnhMXlwx/oN5m1lihHCglbUhXjn8sbjtVgX+7ZOMc+3hIlCpZcTMsKj7TwujP+Bcg
         np6voB1YsuHRBAT1OqT5bhNYiBjFPLWeojMs7bm7KNIcPf3HnuGSR2ARKOe22cQ8C/Gf
         8f5BBxMtkREKHgjAyU2Acqdq8AbY5YyGHOwTOcK/GjD0YeRRP8dYzu0LFcMOTgUxp3j1
         sTrCfbWWQ8U66LBeE6FNSVvZkli/PNLTBRZypBSGHP63QxUhUNSv3gAUqK82cz2rvTw0
         POBLselDia5gmFT+Zpemq+tuf671lwzA6WTiYWWBg5f3OwjAHFkdXuBKN4cdVsGOlPuk
         tzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715800870; x=1716405670;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp36UvWuLTZmtfFKoVRWMOLajVHC98uhfAcqr9sn7YE=;
        b=rhkqOOQZRerlr/R0AHpd5E11BIT8NvtiSQki2hulPAjz5EeHsWeB6RW9r9Q4SOltTi
         7nPrbTK+R1DPHSB3LM4fYlEynHuJJHbjlOTwbL+TUJNJnfct0G+6vRQ3qFecFhYCG2Vx
         yCpIWrtcuNcQAS2+Ae13jYt+ADiupOnnNYj9fSS1jVBsbl5hM34+mujo+N8s+g7UL9p9
         E9DFyBqCC+AyvKjJbrBT7EpmbNhMvCWp1Dv1WWLlEi4fgX3ShZTTcX39TGCVo38UyPkO
         JtWT/Xxh1kW28bR9hXsJCK5xWxYCcJwJrFCYW05LeDqiT9EH6nNsBxmUmuBykaBpUxg2
         fL3A==
X-Gm-Message-State: AOJu0YwRhZJ0ldG43qqchZrSUXbpJ2xMXd9hUEqMlmrsySX+1TZwOkUi
	xuYA2xdcJaTuM1dEMG9LAhUcvloWwyQEFOcH3a8nyWXQdjLdrRRXD9/tUA==
X-Google-Smtp-Source: AGHT+IFbyPGfOAXynKrbQcs/kbDWKNKwJ/hC/fYdbeGANvc0nNm9hHQbJDaoW0eXDHRtwAjW4t/QQA==
X-Received: by 2002:a05:6000:c51:b0:34a:e73a:51be with SMTP id ffacd0b85a97d-3504a7389a1mr10328768f8f.31.1715800870016;
        Wed, 15 May 2024 12:21:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a78e8sm17312131f8f.61.2024.05.15.12.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 12:21:08 -0700 (PDT)
Message-Id: <pull.1729.v3.git.1715800868.gitgitgadget@gmail.com>
In-Reply-To: <pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
References: <pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 May 2024 19:21:05 +0000
Subject: [PATCH v3 0/2] osxkeychain: lock for exclusive execution
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
    Koji Nakamaru <koji.nakamaru@gree.net>

Koji Nakamaru (2):
  osxkeychain: exclusive lock to serialize execution of operations
  osxkeychain: state to skip unnecessary store operations

 .../osxkeychain/git-credential-osxkeychain.c       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)


base-commit: 83f1add914c6b4682de1e944ec0d1ac043d53d78
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1729%2FKojiNakamaru%2Ffeature%2Fosxkeychian_exlock-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1729/KojiNakamaru/feature/osxkeychian_exlock-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1729

Range-diff vs v2:

 1:  309c17c78f3 ! 1:  3341346c5e6 osxkeychain: lock for exclusive execution
     @@ Metadata
      Author: Koji Nakamaru <koji.nakamaru@gree.net>
      
       ## Commit message ##
     -    osxkeychain: lock for exclusive execution
     +    osxkeychain: exclusive lock to serialize execution of operations
      
     -    Resolves "failed to store: -25299" when "fetch.parallel 0" is configured
     -    and there are many submodules.
     +    git passes a credential that has been used successfully to the helpers
     +    to record. If "git-credential-osxkeychain store" commands run in
     +    parallel (with fetch.parallel configuration and/or by running multiple
     +    git commands simultaneously), some of them may exit with the error
     +    "failed to store: -25299". This is because SecItemUpdate() in
     +    add_internet_password() may return errSecDuplicateItem (-25299) in this
     +    situation. Apple's documentation [1] also states as below:
      
     -    The error code -25299 (errSecDuplicateItem) may be returned by
     -    SecItemUpdate() in add_internet_password() if multiple instances of
     -    git-credential-osxkeychain run in parallel. This patch introduces an
     -    exclusive lock to serialize execution for avoiding this and other
     -    potential issues.
     +      In macOS, some of the functions of this API block while waiting for
     +      input from the user (for example, when the user is asked to unlock a
     +      keychain or give permission to change trust settings). In general, it
     +      is safe to use this API in threads other than your main thread, but
     +      avoid calling the functions from multiple operations, work queues, or
     +      threads concurrently. Instead, serialize function calls or confine
     +      them to a single thread.
     +
     +    The error has not been noticed before, because the former implementation
     +    ignored the error.
     +
     +    Introduce an exclusive lock to serialize execution of operations.
     +
     +    [1] https://developer.apple.com/documentation/security/certificate_key_and_trust_services/working_with_concurrency
      
          Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
      
 2:  1f57718abff ! 2:  146b0ae9146 osxkeychain: state[] seen=1 to skip unnecessary store operations
     @@ Metadata
      Author: Koji Nakamaru <koji.nakamaru@gree.net>
      
       ## Commit message ##
     -    osxkeychain: state[] seen=1 to skip unnecessary store operations
     +    osxkeychain: state to skip unnecessary store operations
      
     -    Records whether credentials come from get operations and skips
     -    unnecessary store operations by utilizing the state[] feature, as
     -    suggested by brian m. carlson.
     +    git passes a credential that has been used successfully to the helpers
     +    to record. If a credential is already stored,
     +    "git-credential-osxkeychain store" just records the credential returned
     +    by "git-credential-osxkeychain get", and unnecessary (sometimes
     +    problematic) SecItemAdd() and/or SecItemUpdate() are performed.
      
     +    We can skip such unnecessary operations by marking a credential returned
     +    by "git-credential-osxkeychain get". This marking can be done by
     +    utilizing the "state[]" feature:
     +
     +    - The "get" command sets the field "state[]=osxkeychain:seen=1".
     +
     +    - The "store" command skips its actual operation if the field
     +      "state[]=osxkeychain:seen=1" exists.
     +
     +    Introduce a new state "state[]=osxkeychain:seen=1".
     +
     +    Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
          Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
      
       ## contrib/credential/osxkeychain/git-credential-osxkeychain.c ##

-- 
gitgitgadget
