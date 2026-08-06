Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9547D95F
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030898; cv=none; b=KYWkT+BAUMhzIuniDXD3Ij5uXNbBe32WfXb4EQhbH5XG8NBPNuuAkOeGBG4xGSnMRBXHT8Yobcc8ryGmkhaDeOrgtHecYQ4t74sZCB9RLU74nNOKQh4m3Asi6Opw/UNyIY00xghol9xhe9rYy1mFbFVju6hpOMfwNoivVOeUSFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030898; c=relaxed/simple;
	bh=Su/9nvzS83QoF4nJ1pv9rO2EfMlgtj2esmEFbRx7ROk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=dpwi29YzLKxRPoCm1j/1Sz/p3hdVHR2cV4Hv8rg1uV1CoE2z/TyNWAszkHJGqe6iNTrrihnLYYhjImGn5ydCAC4Q8VQcgRKHIsKDGUAkZtYQ7x9jRvK0BrhySnk0nSa7ZgTpfCwgw+flwK07dNHJwz0oBWM9wgCslRg0bMOcvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu1wdB1F; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu1wdB1F"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso21199545e9.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786030891; x=1786635691; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9RO8pKphPzcbYBGiCfPBt5BZJz/SlvkRY83vXBq4TI=;
        b=Pu1wdB1F0gIM4FtiGaK9ZxDkFiJdmMNxPxdOWKIMEWjPTobcnqEpzQDN31d5UoIhNV
         BSOcEawCEbwwlugsTZCbiJy3E2AT1WbBgl8nOgrx2AXhhZOF/zsEcEobPapzJRbVITll
         ueMI2xOFbjc4KDAa0QaBTMQ1zy49CTqbXmM5b770T28TxgV2tlD+nB0om+74hm8y5ZSy
         J7p/f2Zz7Vp1JvSx2+M5OXHXtlEYpC3qOGSzsoIoTWYZeBX024HX3aTfLWeRu/rjzP9O
         iK2ivdOsh4PnG/W1YD7A1c9Uz5JMdXjg4tRqdZcNVxLJ/cDWM4DtbBfAXtvLIFbU9qdB
         bFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030891; x=1786635691;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H9RO8pKphPzcbYBGiCfPBt5BZJz/SlvkRY83vXBq4TI=;
        b=caH0h9Kropl0iTTzdp9bdUC9W5/RJOszeFVZdzNjfoZ3F8SEGKt32Ab/wjS69so2w0
         PMnJ9lR6sIn2CHrNbNkbv27vfby3t+sRy+667NqlV7SkII/asz+xqHF5OnUcewQWaE2y
         1oMrdWLJnLRycKmeYI+hNAvR1IDxPXoUJOyp05d/PFiY/FUF4tKdlE4WG06ocBBN9xGy
         js6yAlJS7xaFAXQpNyCnFnpXJPn9FGgqHTQwUV8lrWJCbt7KVkx2SGB4a3uuptlqQibM
         Tb8uV+d8Ouo75iM607l/YrewfGXb/foB4aVIipiC493s9j/WJ+678ORzXAMr+gREE367
         9U/w==
X-Forwarded-Encrypted: i=1; AHgh+RowjYbq1ngQdnO15BawsF/ZO60FlxSFvgQcVZbOqiG7YHmEPGOPLCbhYCdLZmgb6Hp3cmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgGpBWMIiUH3LTPw9c9l3ruQpOalgk9hCokXvSxlq9Xp2eE+2
	QgYnLopjukr+oE9xFBNE2PJDzGhZeZqOcOQxQ5zn4VORK17mUfRJKUrOJB0cbi4n
X-Gm-Gg: AR+sD10VkIvnBm2EveisM0DPqRt1mu8fllxase2tHQoIkBuQ/lmmhiJ8U2FZMHAoEss
	Xxpte/4nz00yuBotdWmDuYtdkwZrZD2T5fVCbJ/ZSozRZBWkohDA7kHwJex9KMkoDe1VCGaf3j5
	J+qmK0KBTVIB4P4ZvOqonj3katvgoG88sePBfiBVR9g2ySF0FKpBISBQyNnhPr8T5GhVhGi2v4P
	eCCQ8lPafOk9MKH0k2zNg/4qlmthR+T+QpoWnOm7yrj6mXSLxZbgiD6c9PaTvQoitFcrdThOMim
	Ic2evKT418DkI+DfwN9nAEqdKgsS2sURJSCtb6Yyqs2DYI1bgM9aIND1UUVkkvOLt+b+M+X9FQs
	2gytRoDe+uByWoWpzdl907YkuNon53fNJMCwHbwj4FtscLqrLvTb/VBXexA0N3he+iExwoihc0f
	dWUGg6xT+q7a96KiE/BrIkhhL6QCPGxvsizutILkQBUlvOOGQCLaWPZ2l1YA/F6+2vlYkvz1eeD
	eQ3b8MLNG7EXWhEly2d/OQVMi2EnQIcad/XPdVeTSmRdmGfN0R4Fm6msIW1IJIAZS0MAA9XZ/OL
	fTo8n2XvOf+X2VkoUpkdQ8oHkkY+d+zLOd8hk4HqG3Dse4pyJ8x5wRnTI3CnqEGybOg/fSWRgvo
	=
X-Received: by 2002:a05:600c:a21b:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-4994e7c5e49mr165678605e9.15.1786030891149;
        Thu, 06 Aug 2026 08:41:31 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b250e5sm7268223f8f.27.2026.08.06.08.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 08:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 17:41:29 +0200
Message-Id: <DKHZ3ZMG23JK.369PS06XOZPU6@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2026, #02)
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <xmqq8q6knpyv.fsf@gitster.g>
In-Reply-To: <xmqq8q6knpyv.fsf@gitster.g>

On Thu Aug 6, 2026 at 12:48 AM CEST, Junio C Hamano wrote:
>
> * ps/cat-file-remote-object-info-type (2026-08-04) 10 commits
>  - cat-file: unify default format
>  - serve: advertise type capability
>  - fetch-object-info: parse type from server response
>  - protocol-caps: add type support to object-info
>  - fetch-object-info: die() on the remaining error path
>  - fetch-object-info: use dedicated struct for the results
>  - fetch-object-info: pass arguments directly instead of a struct
>  - fetch-object-info: detect malformed server responses
>  - t5701: use test_file_size() to get the size of a file
>  - Merge branch 'ps/cat-file-remote-object-info' into ps/cat-file-remote-=
object-info-type
>
>  The 'remote-object-info' command for 'git cat-file --batch-command'
>  has been extended to support the '%(objecttype)' placeholder.
>
>  Needs review.
>  cf. <xmqqpkzxtyac.fsf@gitster.g>
>  cf. <xmqqldalty3i.fsf@gitster.g>
>  source: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
>

Hi,

The topic ps/cat-file-remote-object-info graduated to 'master' last
What's cooking [1], so ps/cat-file-remote-object-info-type can go on top
of 'master' as is and the merge requirement can be dropped.

[1]: https://lore.kernel.org/git/xmqqldanxbq9.fsf@gitster.g/T/#t

Thanks,
Pablo

