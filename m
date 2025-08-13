Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A502EAD00
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078051; cv=none; b=Y4HlQ5J2xZxRhuQO930j5LOAtpiPE0TyNrSjUF/dRfwg6g6wVilWIRZ1Ro68dWbYoSOqKrPGgBZ9aVXrkRIjON1RTb7IeTZycC3Ha1cCJbois+95ivnfgq1nC5S/aIJl4rQoGMtXr+I+8rNuEWxc1pSvuB6cJWYErtSdXCJSsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078051; c=relaxed/simple;
	bh=Lx1/iYkEkPOaKAlYfmu6rJU2j9B8k59/XdUXSJfg+yQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=E8b9OAJ7RLtBSwFsIfdNtmwdfo+wv4FtoAevf+cOyhT/oe+HNX9W8WHUq6+L0yqIQkc8OQZ2YrFyzEmKH/6VNNsPzQDl21B36uqDAml0dvr9K8z70Wqpx0x7LcfOnNHDl3M7GiU+Pc+747s0TkKXeN7F4+oinfpFIz2nGOsQWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmAkhIGD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmAkhIGD"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-458b49c98a7so41411915e9.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755078047; x=1755682847; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VJjiogjn++gmu1LVt0NCoX87NFmD7Gdgu7T73pvozwE=;
        b=MmAkhIGDiKWqQPB4wIceVV6ibwKlUIDZxVs98Hdqy4YCgv32zc7+qENQRTSETrkHGo
         /+sWLHNHExDX/Tgw81QrpoYwrzxJ/aFcghXpKyGOpcMnqAasPr2Ke4GmfnXxZ6OuEN2v
         ds5QgBdikwp2uXeHIcm7xF3A3k2OPAjC14mIFLP+0EPtQRpYsO5uHCA9FgP6cLNk+Flp
         kiMM34UVZzBHmLjSRe/Xtoqyj+RSBkWPDMIi8Y1JNb6llP1XF7BHqITYo9KIl4u++ReO
         RNzjA5UlvUrf9zfY5UTQZGOeiM22TVruyVjBElTjoypvaFbHZ4hom0HDki4Y+UC0RlD6
         DOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755078047; x=1755682847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJjiogjn++gmu1LVt0NCoX87NFmD7Gdgu7T73pvozwE=;
        b=OvvmqGCVyiZ0CZfBfwhSZmz+zy4yh9F+uNAlTkP6wXtzwmdLEmMec/bWgF91Hi1Kwi
         Zfkahff4fkTQGfr9TpxNX5bQQL1zkm0WrGfOsIi/Fnw/4EgffsaHXBPx2PB/CO/syJeA
         zcT6xq5vwksQvuazhgQm8g9yVNn/jJbGz96a8CP0Veczao2u7vMk6DxcQR+MetmNvVdH
         KiTgKGj5hLI2Qs5EZGz08LEYzW3FenDn2MWmiNLZMaQU17k5qkGsw7cCfw8JGm8sJQwy
         tw/0O77DZZBMi2CoQ5RuKsougNppHIvdGa79Qz1BxInXtN8a73A73ODYZurK35/J9IiN
         Vwqw==
X-Gm-Message-State: AOJu0YwiHmJxnjMuGEKhKMnJwjLXvgRHS4rbJJGzpkXm/2qkN3lX8c51
	0kv+aeGXeeAWS88xv6ee0/PvJ2Cm0Gu+ih/7jcuwpwFks9qKS5Ws8Tz7Oms0Uw==
X-Gm-Gg: ASbGnctYNfkHS2gm5aIcoz2oyGoCNg3fuEHNcWhZb/VAys3sYaWSMfwdIwTt6DOyhph
	azWnIIGQCTlmO5yyjIY1TamQ1PgZyyTTs8h5a0FaHYD7jsQ3x3uX8aSeaQCCViy9WRDrPqrcowd
	EiopmTgVelvKvX0zfK8ZuV84+HnZKrqokZpkanNa3UZU3eRtAbOZExDwxgAju2xQSPhs0I9JCBh
	8h1mxnvljBDTIWM/nT/KBalsQF7Uf2d1eApfPgJyuO5rIUuVcxFWmir0y3Dl0nMfF13WW3Nvn0m
	ol55w6d6KaKdAt0d7izPAKISbE/ehBbubJadoXbCuZmE4ISTZYgSNdw3NhuA6V3u4gAxi4tIrkG
	e23My+ZHEVIp2y9yUxiyRGmp4b8NNBNyR/A==
X-Google-Smtp-Source: AGHT+IHaH0J8HHhrWMq2SnSMSi1D3JHWo23mXD5rfJUkObnCloxGzPdF7Vzi+/rzVX+YC4+QwvFAfQ==
X-Received: by 2002:a05:600c:138f:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-45a165e2f3dmr19064125e9.19.1755078046947;
        Wed, 13 Aug 2025 02:40:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16dcb89bsm23185675e9.6.2025.08.13.02.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 02:40:46 -0700 (PDT)
Message-Id: <pull.2031.git.git.1755078045397.gitgitgadget@gmail.com>
From: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Aug 2025 09:40:45 +0000
Subject: [PATCH] Document count-objects pack
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
Cc: Daniele Sassoli <danielesassoli@gmail.com>,
    Daniele Sassoli <danielesassoli@gmail.com>

From: Daniele Sassoli <danielesassoli@gmail.com>

Juno added the printing of "packs" with ae72f685418b.
When 0bdaa1216 refactored the docs for the -v option, this was missed.

Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
---
    Document count-objects -v - packs output
    
    Juno added the printing of "packs" with ae72f68541
    [https://github.com/DanieleSassoli/git/commit/ae72f685418b79bbd67e1017c5b1ac7d731c042e].
    When 0bdaa1216
    [https://github.com/DanieleSassoli/git/commit/0bdaa12169bca5d69f2c58f96cc92d51280e9e26]refactored
    the docs for the -v option, this was missed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2031%2FDanieleSassoli%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2031/DanieleSassoli/master-v1
Pull-Request: https://github.com/git/git/pull/2031

 Documentation/git-count-objects.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-count-objects.adoc b/Documentation/git-count-objects.adoc
index 97f9f126101..eeee6b9f7f4 100644
--- a/Documentation/git-count-objects.adoc
+++ b/Documentation/git-count-objects.adoc
@@ -28,6 +28,8 @@ size: disk space consumed by loose objects, in KiB (unless -H is specified)
 +
 in-pack: the number of in-pack objects
 +
+packs: the number of pack files
++
 size-pack: disk space consumed by the packs, in KiB (unless -H is specified)
 +
 prune-packable: the number of loose objects that are also present in

base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
-- 
gitgitgadget
