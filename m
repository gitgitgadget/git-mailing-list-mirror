Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BC2192E4
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607970; cv=none; b=lpoLnlbpDm6FnRAG9u+lI46s1ic4qxU/EQpkQlQhnSdcf5AR9aSzWEk+n1oFdWMOwawnokwoD6jL1UxaYNFr5NxX116b4i611JyQbzYfs4SvXLGqict7EfMyyqo1GzIC+qOhivVxLrastnDIoGr0PttFoAMFBy68DVaWKSCOUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607970; c=relaxed/simple;
	bh=aGSeoKI6PUFh5V9Dddqf3w+YO9emN4VFj5+koMBLlfA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pqMzGVYFfKleyKYwqrWbArElyaVfGAJltCdjtuglcDoytf8OHizrVeVCvVk+c2a2/mS8R0QUfIHLtCXg8CchDY9j8To3EibcteXL5EXI7ZCUL/rbowiXs7Gfck+XRVJL3cUJAWFkpMU4dD5QQynPNTaCXKKEc1sx8Q7oHP8KiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZjUbRDE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZjUbRDE"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso2120873f8f.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745607966; x=1746212766; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0z9w5zMrDiapVfYEe6+ExlY1PKVK2bEt/6nVnmuPFU=;
        b=XZjUbRDEJg4+YXJqKvWLgo/Zt7u2F513vFj9189nR2UVSqoYglKMVufC4ZJy3dcDrX
         2WkOCDKW4b+weSFQmXRUa3YkpGFaVzs+yatbF5spdAlyixGP8I33F0twSDFK0/R5Bdty
         MxsO+vRJlPRcMPBEyRtVCQmRlprzcY/PdpJrE9qr/lQjVARDzdk7VCSx3IspfkQYoSwS
         3BNIJaA9R0huQ2ju6uVJhNscAVroPhzWrNCUgB5zT5/6pRe8VcznYtHPtSmBnl13TbXo
         tB/Ek4R9H0dPFA+m36K+bKLUQfSCcS1B5KylEENSGVkinyAC8Kt6FO6EPKpOTZ3L6OVu
         vR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745607966; x=1746212766;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0z9w5zMrDiapVfYEe6+ExlY1PKVK2bEt/6nVnmuPFU=;
        b=Ou/9QV/uS6oFwy2z0lIVXUyVvEf7uyhFZfGgRsmQuwwGhAlO9AH7929AWahPYO4pqU
         0rucv87TkOFB1Ll85fD8db4Ymbp4PG4FxYUt0EWgAZuxMACMAehwy4XhBc5vb9yhfBMY
         WdjbmJgYkz2IE+bgc9elUENRKHkRHMV4YBd1LSeEUlWMvJvW7mn6gJfFG2QaeoB1Yaj2
         T0HrEIVsUHEdR2iQUHkYuh5DVQCy6PSS9sCa7qKYkoP9ipfB5GKXnzgqZsnC/Wmz9NR6
         42kO6Q4IiDMV+ATHTrBDK4M4hkc0BiJv4q0yVh3coR6ZIsg9d+OXzI1zGCoIdjru54ii
         aVpA==
X-Gm-Message-State: AOJu0YzgvHgbpilOCgTjKw2uji2UX8acrfr2lTBskrLN7eyoSKJ48UUY
	47w8Ujy774EhiaNfGR4K0LhTKbldEadCXr0glm+vvqUsZZCnOUykXrz+0A==
X-Gm-Gg: ASbGncvGzqkGD7AR5SE7lejoUeXZknPCu+9Grwj9UORinWzafD7efBsQ8hJzikjOSzR
	bV1bGcuxnBhCLb7vmjOARpHAJZN0ZlqQ9Yy4Dh4ME2vodaOdj6UkFdrEftxczjIHx/12gwHzuJv
	C4TLPuKjGmOUNCUB0G4b8O6eEJ5Y79ZxizidhDn4pP6CsKtUUb/byhy3seeoOTH5pc5YtawaGEI
	vZOIIzIGaqNJfAZLqhwTeJWQg5EqCf8J9FYjPw1vSsLctFYzx6tkJXnE9mccAUakdSxkU02y02S
	U2oHoGOxM1lIEx4SqA+fsYT0F8+Vmz3ilBvQWn2NFA==
X-Google-Smtp-Source: AGHT+IEdbL/k66S/GGuVBdOVpaXUteuf2cVYj/zGWDF4+lYl51OtMpirAe0N63KHbejSIEkTWKW8XA==
X-Received: by 2002:a05:6000:1ac5:b0:390:f0ff:2c11 with SMTP id ffacd0b85a97d-3a074e146c6mr2549566f8f.2.1745607966183;
        Fri, 25 Apr 2025 12:06:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cc180bsm3186876f8f.53.2025.04.25.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:06:05 -0700 (PDT)
Message-Id: <pull.1897.v5.git.git.1745607965.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
References: <pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 19:06:03 +0000
Subject: [PATCH v5 0/2] bundle-uri: copy all bundle references ino the refs/bundle space
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Toon Claes <toon@iotcl.com>,
    Scott Chacon <schacon@gmail.com>

Updated commit message to remove the swearing. 😂

> bundle-uri: copy all bundle references ino the refs/bundle space
> bundle-uri: update bundle clone tests with new refspec path

Scott Chacon (2):
  bundle-uri: copy all bundle references ino the refs/bundle space
  bundle-uri: add test for bundle-uri clones with tags

 bundle-uri.c                |   2 +-
 t/t5558-clone-bundle-uri.sh | 202 +++++++++++++++++++++---------------
 2 files changed, 117 insertions(+), 87 deletions(-)


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1897%2Fschacon%2Fsc-more-bundle-refs-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1897/schacon/sc-more-bundle-refs-v5
Pull-Request: https://github.com/git/git/pull/1897

Range-diff vs v4:

 1:  6957ee2fed2 = 1:  6957ee2fed2 bundle-uri: copy all bundle references ino the refs/bundle space
 2:  d9a114915a3 ! 2:  ec5d629f32b bundle-uri: add test for bundle-uri clones with tags
     @@ Commit message
          The change to the bundle-uri unbundling refspec now includes tags, so this
          adds a very, very simple test to make sure that tags in a bundle are
          properly added to the cloned repository and will be included in ref
     -    negotiation with the subsequent fetch. ok, now it's right. christ.
     +    negotiation with the subsequent fetch.
      
          Signed-off-by: Scott Chacon <schacon@gmail.com>
      

-- 
gitgitgadget
