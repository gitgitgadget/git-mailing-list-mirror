Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB03A27B
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685705; cv=none; b=S5+lmsu0huNaO6zlx6GlylpgdwkG9b7nftfQ6bfL0HDLcJELEWka0Wj3JG8J4iCw5mgRYrFsemqbeWJVkncvLkP/yYKOg25MNmjBg/cHVk5Gvlpw7fQmf1dWljPi3NqqG2J29m3noW/OVbDC9zUfb3bZVpbD3ws1TeiH94w6ENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685705; c=relaxed/simple;
	bh=dMDNCrj34W5kK4XtcMwpdJ3yeGAl2qMd1yeHmBwPZbw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Md0AZ6F8cglNgZYIDe+gDew/iMcdAGSMyBtVT5uLI/w1uVAEeLxUhylM1FJjMh/ha+SyEVEEB+uN5hQSU0ZSFgVSkDKYYWJEyeSavJbmSjeq1r4cdp4V3vYsnXoAc+SXXjLwUaM/YI7+iVjIHQs/z3EhBpXdBxYZFMRqDitzpZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWYSZK3Y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWYSZK3Y"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-415482307b0so9682685e9.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711685702; x=1712290502; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=510KJwx0+xhh+zA0Y6JHX2AIvAT7sUNCB/7laBzA3c4=;
        b=dWYSZK3YGezi2jvLt4iASQKR3Wrwy14fFrXCh2i5MqQdxoQX8s5vSMAthSQh6HaHCu
         NdAC0n28kaR2SlBBieIzfYFdsfpDRlmIeo3sAsDfOF5Yvfhxaa9CcJ2JkdkMvE4bn6kD
         67hgTcQywI2YCiCJJUmk7Dr92kGMFi+4DkfoJk0z1N0hUagL/id1y30cx8aclZYCcByC
         DBbu2phpiB+Wc/ARIJv8d2dBv91ywM2zsWruYdQqQcQE3VMBTTdyNkuiWWrvqgt1KBU3
         Kj7OAq6raSfrrxsM4mxsvVeujHLZm97G83AeJpNEHMOgoQS7H6Wf3EdOFS2ei5iPEI9C
         NfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685702; x=1712290502;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=510KJwx0+xhh+zA0Y6JHX2AIvAT7sUNCB/7laBzA3c4=;
        b=jcO5GQS0CaoEFYrhBABHRTEkhCnNryaU4tRPvAs2I4gDqXlozbLRzb/CwH3t1QhE9n
         yRRQfUyMipicFckaSzGSvsl8cerzrfCtl5wqHioAurTlb34Mgkkcqpbd51Bnn6qqAgvu
         fa266h7NNVnFwaOiogmJ83GkTzVPhUb9X2rgSNF+c5VNhq5JbUADK56PbXIK2NtKOd2P
         v+OOJoYB9j8vxPF7Zy70mlh/bM5dAV/QuYVppjwUOLu5rLwrDvgpWeiTYd6WhJI7A2Zp
         ZlG5hQS8k0wy7yYNeyxm7GxfUlaGXcJWLqRl5MdzZMd0OsTgn5CIRorKrYF63X2vECQ2
         zLuA==
X-Gm-Message-State: AOJu0Yyi/zFLpvOaWcfdABQtIi9DRkdi0WlJKMC8RUN7IEcZIM/b8jeM
	1IK7FiF3MJXNMD7Cfgi+noNZ1F4qHbl7Ytdqla5RXY37/O6ycCs++Du6t8pt
X-Google-Smtp-Source: AGHT+IF9zgDCvPuDIUzH8pcmjUOaNd9/Cpn9BJUOhCr+GMTXAH6qxra4Oqf/eaf5fBPMIKvrRrq6DA==
X-Received: by 2002:a05:600c:3b0f:b0:413:f4d1:199e with SMTP id m15-20020a05600c3b0f00b00413f4d1199emr996636wms.31.1711685702333;
        Thu, 28 Mar 2024 21:15:02 -0700 (PDT)
Received: from gmail.com (220.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.220])
        by smtp.gmail.com with ESMTPSA id bi25-20020a05600c3d9900b00415481edde3sm3206236wmb.9.2024.03.28.21.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 21:15:02 -0700 (PDT)
Message-ID: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
Date: Fri, 29 Mar 2024 05:14:53 +0100
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
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] add: use advise_if_enabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series is a simple change, in builtin/add.c, from:

	if (advice_enabled(XXX))
		advise(MMM)

to the newer:

	advise_if_enabled(XXX, MMM)


Rubén Justo (3):
  add: use advise_if_enabled for ADVICE_ADD_IGNORED_FILE
  add: use advise_if_enabled for ADVICE_ADD_EMPTY_PATHSPEC
  add: use advise_if_enabled for ADVICE_ADD_EMBEDDED_REPO

 builtin/add.c              | 18 ++++++---------
 t/t3700-add.sh             | 45 ++++++++++++++++++++++++++++++++++++--
 t/t7400-submodule-basic.sh |  3 +--
 3 files changed, 51 insertions(+), 15 deletions(-)

-- 
2.44.0.371.gf9813d4ed5
