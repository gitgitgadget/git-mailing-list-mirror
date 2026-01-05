Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F19260569
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621460; cv=none; b=f0tr6S9SQAjHZTV01DinDHH4Kz0cEO9vxc3sK/8ytfaKG8FDb67VtErsM6TuPnQBL7utRuT7HVcrG8DoOXtIuBSYANAccz8AadER4VvAZoqT5rRIzF/nORszW6PNXJQyap3KxlcbrYxHRqY0hzj5GnBriPehJTzBwtYhvcPSZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621460; c=relaxed/simple;
	bh=AwS0+rWIM8o2HeQDfOQeSziYisQU8qexUOVOTijJQcA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EsRjFKw7bM80ZKn3LwLDG1r5sa37nd9PvIVPas9/0iP7JtKr7uC0rvAx6uxlJg3JKo+x1+zmm0oLsM6CIswZSrprhLI7dlr2SSd14CGOjcju/RBWSXz05clggaViqyfHPcxtlVBxy5nAxqLmosTxDBXb6IfAlXyxZCNQlbfEr/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ1vrIJX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ1vrIJX"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b98983bae80so12479976a12.0
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 05:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767621458; x=1768226258; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwS0+rWIM8o2HeQDfOQeSziYisQU8qexUOVOTijJQcA=;
        b=nJ1vrIJX97ZcAjKYU9HZCvkcxBcwRILLyqn2dA39JBu5BkJW1LdrGVqmIod51nh3CH
         I1Hf8lBtYgxCUCgAPU5SYF/rQp4Ey+3lBXw/3c0Zbd3ofwMZ8gyJ1n2LTlefq+ZgvAbZ
         cR7T1YoxxoRi9EOeAXTN3WFFSiNqWA5uBlkfVgUNQokkfyDlFB94QdPHggvhoK7lTWSR
         XghsOB6DU8ky+QuD09UIvLvWy2csuRbGZSVDXX2D38rErB9T1t057g/gA6JCJBoxKGrC
         bTtf1gADgfrv+ki5Y0VkCQV7UHkg2bO5ha5RxW+iN5cTqipTzlp3kHJFkDdk46U/beLJ
         wEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767621458; x=1768226258;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwS0+rWIM8o2HeQDfOQeSziYisQU8qexUOVOTijJQcA=;
        b=bs1daQMjwXJ9oneKH13XXn0y46r1joHtv3thXsi9YeKV9DmwrJaWAx4jPJjht+uJe+
         aEmqJMc8G/b0061yl7i5ttDk+LsyNSPCB8uxJjd5y5EDvQkBDOw7t9F5Jbume9N/yN40
         L7bTrv1tM2mcry+TdtMu28bZzJjLAxhHOJ72M+vQiHuw9SbErjasjop0XjjC81/GFSLM
         vOaTOTjkumpWx6C3nsR2MVO66M2S9DRJjvRuKjLfMlq+tvidyZ0HhzF8Ii160Jyw9AxU
         uiCUnk3IKsaB97nubFsgq1B3rU9xFDDSMhBdsAYgasx0EuxGuq2fVFTOsfOVssNjymCT
         4c0w==
X-Gm-Message-State: AOJu0YzzRSbH+5JXC0MtThEK2nbmbqglRkjDq/naRaSBanoK9UD+Lsld
	rD4MYjugtUm+6voZiJL3eBkgveFxIAdiHK7iu9DYCsjYnc14pLR1EnlIXT4Ftg==
X-Gm-Gg: AY/fxX4mHta3fqNR3kfB9tM7cvZtp3QXcGmwydYuSijTYAX3/3ePwCKvNm+q6Rgbvho
	CvUPqpKQMdS6jfGK54CukvMsBjpeixFtkznlgP4CSUCUUTJVty192QO0c1kaScrQ9eZzFvO8FQG
	JNSQxqcc1GLOtxC11oXbwiyAl+B6a5us6xGtGFJhlA7x+gT3j19EGkP/K/8GUfV2zlQ6GOpyFTV
	8kLITjubcjcfU6HFizFTEJYoMV54BECRBOU3FvBZWURwtf9El6DlKqsqLgTk+H9WS98pehM7wr1
	Up4n2cssgBMKamd2NfeaJBTRXJu16icZKzLKb9O2v6txfmIZIovTeSnXe3pRnDG4MKvgdZjQB82
	bYRt5V8jcPAgE85aCbs7+BQ/xpEG0JeSrFcSvBSvVvX6iIfLgasVBlTyQ+jN8uv/vGilid+sg6f
	niy7Or2ROzDfGX/inoOw8W+p5ThLAyvpUL4/7aBuxL
X-Google-Smtp-Source: AGHT+IHAtF3n2tM7iHen3ikqrqhMo4W0PKweJlxNGK9+JGhCfdYUEevs2/6GSEs3OEl/X4liNx2viw==
X-Received: by 2002:a05:7301:3f99:b0:2ab:ecd0:5221 with SMTP id 5a478bee46e88-2b05ecb3c0emr39328863eec.42.1767621457737;
        Mon, 05 Jan 2026 05:57:37 -0800 (PST)
Received: from smtpclient.apple ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e8bsm12132774eec.26.2026.01.05.05.57.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 05:57:37 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2 0/2] repo: add new flag --keys to git-repo-info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20251209194616.61620-1-lucasseikioshiro@gmail.com>
Date: Mon, 5 Jan 2026 10:57:23 -0300
Cc: ps@pks.im,
 Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 7bit
Message-Id: <568D8DB5-AED5-4A6E-88D8-890F9E11A00B@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-1-lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Hello, everyone, and happy new year!

Sorry to bother you with this, but do you have any comments about this
patch?

Thanks!
