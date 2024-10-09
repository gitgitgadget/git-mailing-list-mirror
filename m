Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1526552F9E
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498970; cv=none; b=fUSUqHhc5ljDfvVo84DRIR6N/c5fuHF/ciKRREA/ohMjrmRHRr9ErHdqyvzCwwgXBxtoaGkXcDHlzaAn6UQr7bX8HW+X1z1KudUKx0GDTPAOEOOHs4GrkHd52VDcvsPbt1KgIlyAWG5DRpAGu7JN1SW8LUvCPOXJrsyRhvQptm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498970; c=relaxed/simple;
	bh=18TI0MxIKX37mNqt3vx77m7qhIkyzGVC2+qciEZ+aus=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mt41oNa8oMKLezj+2UwjdT7o66XpCbfx2G2OwWQ+2w738gZr8lQ8aOprRLoogV4FNcPJEBPTnPa25grjwsJ34CmaZKZQTQscm/CyzE3ZDqR4UG5Vvasnzfn+epdvtnERDIP40ytEzq4TVH/lTd8zB2oSlUUKm507nih/OJDyP20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8ey4QxJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8ey4QxJ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45fb0ebb1d0so38261cf.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728498968; x=1729103768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=18TI0MxIKX37mNqt3vx77m7qhIkyzGVC2+qciEZ+aus=;
        b=k8ey4QxJU3zW3hLiPU+acaHXFkequDr4HiDxp1T1cb3ww+xkijUwNf++mriFhl5+qb
         ScXSmFkY7DHa8/DWTpY/34oeik60yoICWG8EkQ9AYLksVc2V9jLL9H2EGBzYTAMqDYdW
         DyDhCOn2MY82EhMsa1SGRewbhTSV48fEoo6CBmqj8gfXj5EMUn87Woj0E8W63M9b2Ub5
         bMBgdOiQQGpFn40nu+ueie/+VEDWnnVuFXfiFrOwkt/RmwCjPuUet3Oswkcwnn0NnItA
         EPiSzUY3yTxO6ZFT4f/T40FIXQZyYUgyIAtaar8mpO1rNV+OvXcGVqtBaCUBf33VxCGA
         eGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728498968; x=1729103768;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18TI0MxIKX37mNqt3vx77m7qhIkyzGVC2+qciEZ+aus=;
        b=H15vdMSqFDKi/MB844DRMwcILzNqVAo1duZmuo0Czcji/gAVT3Bf4j5T00P2RBw9Fe
         ZKZXIE7YUiy3mCSDJzZNnv7CdC0OSH16vXrW4tmu3P5Fn4FDOrDe2XPna+ztugOi5RAB
         YYn4SauMihuuX6uuxqcIQJSKgNv1W3n8sxhMiKnN9E+zAW4XdHge31aPOkzFyvyjxvXt
         5tcKuMx+4yq9+03QUhIKUMbgRGmLA1axI4vQlCzg6S6SJdPYb9sDCBkwIBxCUbpSBMC5
         yl0ZkQijIIf3S9KCDlysD/wedpJ3lzhGDqiQ4SQremq7zgKEijLi84txIOQDZI2h2sdF
         6EOg==
X-Gm-Message-State: AOJu0YwPObVNhBIHfKsRv0lF3z7kbgLcfjWuXKLz6xj2alehuqBwreo3
	L5l/9rIElx2Hx/sfHKZKvgNE/WFaErZQdODle5oO6egGCT1tauhn7bBlc5WHQBD4O18vY4X9lVy
	dvf8+Svk8xKpOkKmL/36AVGterfonsF3iLZbGLvhzEI78g2HWNT1jwXg=
X-Google-Smtp-Source: AGHT+IG1EWTQXirLAxnQEC5bQzqaBZj2HpbweqKdIa9RgwWKtjxHdFNS8qAM1AE7v6hHpJHJRVInUQbFF4u/eoOXzaY=
X-Received: by 2002:a05:622a:2d11:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-46040440c57mr373451cf.26.1728498967553; Wed, 09 Oct 2024
 11:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emily Shaffer <nasamuffin@google.com>
Date: Wed, 9 Oct 2024 11:35:53 -0700
Message-ID: <CAJoAoZnovapqMcu72DGR40jRRqRn57uJVTJg82kZ_rohtGDSfQ@mail.gmail.com>
Subject: nasamuffin unavailable 2024-10-28 - 2024-12-23
To: Git List <git@vger.kernel.org>
Cc: Josh Steadmon <steadmon@google.com>, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

Heads up that I will be taking a personal leave beginning October 28th
of this year, returning December 23rd. During this time, I will not be
working, and don't expect to be monitoring the mailing list,
participating in reviews or discussions, looking at the Discord, or
writing patches. If I do participate, it will be in a personal
capacity and not related to any of my work at Google, but I think that
is quite unlikely.

Lately I don't write many patches, because I spend most of my time
facilitating Josh Steadmon's and Calvin Wan's work as their technical
lead at Google. During my absence, Josh and Calvin will spend more of
their time covering for some of that work, which means their
participation upstream may be slower or more sporadic than usual.
We're hoping to be transparent about availability and response times
over these two months, but in general, please be understanding of any
higher latency.

I'm looking forward to returning at the end of the year with fresh
energy and ideas for how to move forward the libification effort and
keep the Git community healthy and efficient.

Thanks,
 - Emily
