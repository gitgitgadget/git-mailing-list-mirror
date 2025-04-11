Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8F18C011
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398502; cv=none; b=E2iqjRFevs1nXFFMqYzlASso9HSJlWy8L20q6ZkSpzYMvrlwYjfj48OHPejaALK0VFAgbeWvtqozSZSGMK4tZLU6AR3Fch8Vf90txJVGSc9mLv5+jH3R6OqNO72ySH3G7LRJAHpRZa3W4a75Sq+HmU2oFBob8kyz4YMZVMzq+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398502; c=relaxed/simple;
	bh=P0YKwAxII2ay6CuD65/MsmTyEJpNzgCnarYwPuxJuGo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=o4TDowRSi+bZDMsRz6nrPNWknhkMotDTAkaxOrc/jHLyWRq/caiRKFbcUFs2r+qObCB9Wk12tfABrwPCmQmglGZbcMbGjhmjfy2lfhZyrYhwUs5I5kGueldS7yzmPxYEKXx9P3EdMDJ2Mvk5802dwwskx8u/JqW/T1X0Womc9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzNx0K5O; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzNx0K5O"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af519c159a8so2230282a12.3
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744398500; x=1745003300; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P0YKwAxII2ay6CuD65/MsmTyEJpNzgCnarYwPuxJuGo=;
        b=lzNx0K5O/mul+REc0F0hD6CydJoH8UBi9z0/NxcmaXagNORekvEDwWalnVQpUU3of+
         7UkTi3NNyoi/pctp3DQeBp+nCnrftXjbXQX08J1h27BAmIyKc8BNypQiYpLFd3RWyhrB
         1y8Z5TF7zSL8sxPFIJ+9aQGUSSvSszZhi4H9NV4Hyno/g8wll9CFQ6Fnz9OrpilrpZIU
         nO4M86oBjCZvNRiHZtgmk3hDaWqrx/WUDvdVVGHES8bvitU+2quDGzB9AMY23IISI/uF
         /4BQm4RmihmhF2vDPBLfCGu9XlBySURhLF391Ax1YBqmsLm5JQa6ir/besmDVwQjHgKa
         6mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744398500; x=1745003300;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0YKwAxII2ay6CuD65/MsmTyEJpNzgCnarYwPuxJuGo=;
        b=hExzDc5LCmyGSHYQGbmtLbaLT6sqih78hHE9TgcDnIzRd/CynkJZnIkgj5h3Wv6OcJ
         7VzC+H3rj3s4RWHAFguZ+PoKgfkDuWnIkWlL/KINfwKKt9aFk80uPCtos8zCXuxHlAJz
         Q18e7bYhlrMx013VPbtEF02rYfgF3B/8vVWmb/YJMiHXWCkxGF4kQIR6f4SBtgbaeNTz
         aYdbZklCc9hzgJjiNA+IXmCe1bBMNtWgrIv+6iFYJ2jL2lu7fmY1d3tIE6wqrg50U//k
         0aAvAPxmEuJdCKBy3Qw/ljU00nyxDP9kFCLEJhHKC2U1Lsc4u4VfMwu6ldXjgJMiJPMJ
         1b+g==
X-Gm-Message-State: AOJu0Yz/HT++yIHA6bBu8MKXhz4yij6kday8eNoI2yAVkzx8mhd9LOYx
	Lx/mfHfa+y80/MwU4wlYImQ4m6nDshSdF3ebuQ6k6o8SZGo/owEotyCwcpZpI7KZQiW6UtVVrLE
	lKujK92lrwE0mZc3+OoR63yZt1iUtHX93
X-Gm-Gg: ASbGncvKMmVFOxcy9l2DxNQ2LZl1HMDseCaxCGMamIJs8eh5jKbxzuqgw2uQWbKc+8L
	v2kiVE8VGOlUxefqp+a4TbBG1nboi6rLVlLGJ1YoqFLxF6gGeO+SaMl/52QBLMF5e6qOmEqMTYv
	XoYEmIo4PlwNIKge/62rEjHEc=
X-Google-Smtp-Source: AGHT+IFzcbl10sKI7XjfzLC4iY6kBjByD3an2k0x5b3V/NMlJ49bGNAGL8HFbHPUR+GYwD9mDfogp+x4sVzo2sJGGCg=
X-Received: by 2002:a17:90b:4d0c:b0:2fe:6942:3710 with SMTP id
 98e67ed59e1d1-30823629179mr4822423a91.3.1744398500593; Fri, 11 Apr 2025
 12:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Piotr Siupa <piotrsiupa@gmail.com>
Date: Fri, 11 Apr 2025 21:08:03 +0200
X-Gm-Features: ATxdqUECCOwvYP6yX7FKC1qcVyKQqODTpu1H7JcjZ4geL2N_t3L7bjoHLzfyC1E
Message-ID: <CAPM0=yBnaXojeC9WkHg08deR-VpjaVQwyrqt8mk+54qLXqSaAQ@mail.gmail.com>
Subject: Bug: Git sometimes disregards wildcards in pathspecs if a file name
 matches exactly
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi! I think I've found a bug in the command "git add".
It can be reproduced in a fresh repository by running:

git init
touch 'foo' 'f*'
git add 'f*'

The last command should add both files "f*" and "foo" to the index but
it adds only "f*".
Running it the second time works as expected. (It adds "foo" on the
second attempt.)

I'm using Git 2.43.2. The current "next" (2.49.0.805.g082f7c87e0)
seems to have the same behavior if I'm testing it correctly.
