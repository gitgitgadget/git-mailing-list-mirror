Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A7286284
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918551; cv=none; b=eyGaydYBMedqgruj+Iqm4JNJM51rTyrhSOnLLWiCe6lXMEXNecmAR50Bk+ghDAyedDwFNrRvznEdLc6AYjUGE8jUgEW8VeC4LVe3cvBwM+vC2PEnn1PUBUvH2idPcVxwAbyDOXs65IctoVHKjDyNNrjLPZIdfrscq1gSrbkFj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918551; c=relaxed/simple;
	bh=4VMHQCMth7qi2RBb1uEt9QIj3soupK6nd/TnDOkLoZ0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=e+AeQGsxmWq1kCP8hnlr3jrNHMMzs6izMp6N0X31JhG6ZDOqd5FJgdmCszFLfZWg+r/MBUx43dUBMjwnl7wtJWT/BkCcwzDtwKozZuBmySS8mud3bI3LBCdd6tjCsSm7QLBWVnYSBcwtSMxoFLMSQDfBJeXQ/kyQwhE7znesBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+WLU4tC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+WLU4tC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso17633905e9.3
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 14:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739918548; x=1740523348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf7wW2P2QKL9WUcUoODnBl91cZkDyiJ9hy68kLJUsuU=;
        b=h+WLU4tCJluiTv37d5umS1d5Bf3Z3jK12FVzx2N27hDBcJ/bR3EIQD4E4CKKlDYBV3
         u+Cxg3OTZ8FYMZZ4Na1FGrv1aEkmK/HuIgbOnG5AEFTPSFcF8WtZ15M9A8ybiJ/6ZEwR
         STp8oRtm6XCUybBJqqtrpZ9w5/KKdkYhG0c+nd1XSL5hiBra4eIkpmElfVp6nJgKiN3j
         22DT6Jv0WT2SPna1rMK3LYKXtrbBkYIc27HCv5h+9cRk0h47y+aJ1YIJTNBk3WkZGATc
         l2SfaBHucnSGiUNTmPyzDw6L/QOXM7YMIjZBXaI7S2flwIi14AtduQASS674u8A+EaXN
         nWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918548; x=1740523348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf7wW2P2QKL9WUcUoODnBl91cZkDyiJ9hy68kLJUsuU=;
        b=qN8RKBP7t7ZVPqqf4H47IvddEv/fZJQfN63KFFTRH/Urw2ovRr6MYexed7Si9WuK4m
         ZkxbVKtVLBx7NdJJFRI/d6oWnJrAn8I8bZQGAHKWaH7Nj0T8k2OJ25b60mNQ3Ei2beTX
         REWKc/ci+m7F9oq6Af8SXBBdyy7Z5VpOfL9zYqJlSLoWo1XrXJgQdVLbyV8KeC/vFFa7
         JGVoQ2/wfpQlBBQ03BENiNAdoxIWRkBIn+J7m20etRsSBmOUtIu9d/YQ4/mpbusHRYca
         ofQMEB29dP4jzZFC81rNTbPDDOGMf7yo2THroWQX3+AFNm+RK9wA7eVh8Gp+UqC4za0K
         oJ/A==
X-Gm-Message-State: AOJu0YwcOt+HyKQyvL9T5GC6KMuZoLsjGcY7KVNwDuXyssrFJKzvkevk
	Z2QLPjMO0SWY6fBM+5Aitb8JLqXtGSV5+AENafeHauOR5hDsCzf2D9vn2g==
X-Gm-Gg: ASbGncvbd0xAp+Uwi1j+Qd42JtEaLl5tioiuFBbT3ycZpstXj1B077TN8sRouzVaciU
	WS4S9SnkuhR1xVy1Upu7nXch5g+Tpv82TNXUSaFbvDRbcqWCdgLWesZi0K8EWuAWJpVE6fZIuun
	vaf+r2XA9RR++SdfPJEwOYBHKdJ0hnS2Zg91cSWcFGWIWeRF6fjXEwRHrCz3OX2NZHWOd4tW2/8
	Uv7OfiYiI4eVwstMDSCspliUK/LgJMDoCZxkwu6onaQeO98IitDRKWCfgEkE8CG1gpLoU0Y0Slr
	D7/aUW635Js/+gju
X-Google-Smtp-Source: AGHT+IFV77pa4Y5NpVdK/IXw4NCg8dg+oLRuzm5avkvQUglod1vcaPGvr7CeoobMpHg5AAZ2ITIsSw==
X-Received: by 2002:a05:6000:185:b0:38f:2193:f8c2 with SMTP id ffacd0b85a97d-38f587ac3cbmr906881f8f.31.1739918547414;
        Tue, 18 Feb 2025 14:42:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43993d297e9sm32496355e9.33.2025.02.18.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:42:27 -0800 (PST)
Message-Id: <pull.1886.git.git.1739918546.gitgitgadget@gmail.com>
From: "Kazuhiro Kato via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Feb 2025 22:42:24 +0000
Subject: [PATCH 0/2] gitk: Fixing file name encoding issues.
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
Cc: Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>

fix: file name encoding issues. fix: when resolving merge conflicts,
japanese file names become garbled.

Kazuhiro Kato (2):
  Fixing file name encoding issues.
  fix: when resolving merge conflicts, japanese file names become
    garbled.

 gitk-git/gitk | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1886%2Fkkato233%2Ffix_filename_encoding-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1886/kkato233/fix_filename_encoding-v1
Pull-Request: https://github.com/git/git/pull/1886
-- 
gitgitgadget
