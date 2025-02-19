Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF711E7C23
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976898; cv=none; b=lNAVtjN0gVb8vcAX3mixkvqOe/sN9gilRRhAS1E09SVNFKUHNtazLYEMP2ZddV+Rmg4QL8s6Shb9NNRgS389QUhAyH0yDFfaytVYK1XfdFFie8rNG+g3by6WX/fjuMCLMp2Tv2rDdfNub3JPHb0B9stZP9RKHbrLPFd1IVlPVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976898; c=relaxed/simple;
	bh=9VBOlA0apXPyJnpHTmqPuAUpsZPCvqfbe7aO3u5P+uQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tXynpugjOea9GRzVvuxt8Vrd/KsLoXoTEufDSX2CMIxqJPdTdsf/9B9TgdY5sLVt7RWaJFSQkpm7d6Vmqkx9LYaMYkyKcK/N8Jm/zL4apzk1ATGqr+2D2AmZS2jIjlTudhIFSnAK8JdGtqAD34MvV38Hc9jG7x6ZWg0JsVW8A2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4gUPwsh; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4gUPwsh"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2aa17010cbcso5346715fac.3
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 06:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739976896; x=1740581696; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX2QBWag2vkLHboU+XHXbT3wYw8K8WjPRWRsBs/+ZLc=;
        b=H4gUPwshH9eMGsoZS9bRTM6jQ0zzEMYm97C99u59r2GUx3L4LYOaumyMImtByT3saq
         qoFxIfYU/aTKe8l82QzqrO24PuYKSxDp4bI2rraAvnIfkeMa/+xd90W9OhmDfec7MDgq
         U6X80FGk/+npW8I7gaMJ9ll0kBouG1rwX7wdC+xdK8XRhLg2a0y2Ke3EeAu16AusI1i6
         jk4L/aYlIA99LcmtcVpdkksasUTVqZweUD6dpXGLImIgzGusRri3OdkcvAbzcDaI3/OA
         2P2NiGUnTsjhHsHJTdtxO9t5AWcvDAo8sgVzR5n6URx6UFkNJpSNqBP6/+EuJ6aWrIla
         zYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976896; x=1740581696;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX2QBWag2vkLHboU+XHXbT3wYw8K8WjPRWRsBs/+ZLc=;
        b=CnZNnIz5R3SvYxhVZj7MJEjJvMkpdIhOPPdmluvvk7g+cpZyhkJ/MP8IzwPN3vRjVa
         0qGQZrO2SqvEybJz/JH0uSv/2QfS4mZXmz0qO+rR3cxDbat4zVNKe475c2MAd0S/bTud
         fVZWpBFg4HjDW2tWnVCcfRUuvUnOD6jYcCmlj0T1W5S5aveEjS+pnMvCuySxjtpQLOCQ
         KZfZpjK5pVi7X0VNi+2NHsMAnIR8zH0bCKbFb1ihsCHFgcDbnjYXITVNTVHZnS9Tsea7
         UFQ2kopM182BU5Ry87riu5CDo1+z61OH7YdZGgq9KlYMGVa2wxf4/OEZUxNwEHHdcZ3a
         AfZw==
X-Gm-Message-State: AOJu0Yy9sdxPtVks+zo+gr6Yf4+Et4pbPmIWZarHoFUux3Yy7BwZa9/X
	hrscxx3/TqK8cEXhamjPofrD1cRBJ1zxbTfM7Kr4OMaUeAhSvPFlXw0hSsnx
X-Gm-Gg: ASbGncvs9gzj2PMdbdxPdcvglcVog4eifY26DQeLNG4m4q609Dg9J1/6Eo9SszHQHX8
	YcXaMJaP8RtBv4S4bPwjoP5WZClzwDzz7P3CSfbHVxis2zTJ55HIcj1oPx6tdJBIP6alEfLLj/S
	J2oza9wJ94ROFrYpkVeqaa40lesBjCXbfsGqbpI8jBw2yP4/pgAmW/kFdRBu2BaRCHeMshP6RSJ
	wAaREfC1SZAOIqACsJh1lH3rZxkggPm3ASTUNuWybOaYX/4opYTE3Kcct52/CnMEyHj+0MgI6La
	z8lACdQGogDiEpiuXbDMTIrwrr0JHZyu5ZrqWe8=
X-Google-Smtp-Source: AGHT+IHrF7GOXc/qwlq/aRm2pB+30DGgT/t1kGO01GNSeoykgU0a7sztlDB/2PaJrHVuxIyoQlZVAw==
X-Received: by 2002:a05:6870:50a:b0:29e:2d18:2718 with SMTP id 586e51a60fabf-2bd103fcc01mr3336630fac.28.1739976895861;
        Wed, 19 Feb 2025 06:54:55 -0800 (PST)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7273439063dsm875006a34.25.2025.02.19.06.54.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2025 06:54:54 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [GSoC][RFC PATCH] git-merge.adoc: detail submodule merge
From: Lucas Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CABPp-BHvutRL80QiTYx6gJbYiATOD32DrvXgQQtEy=u5oUZ9Zg@mail.gmail.com>
Date: Wed, 19 Feb 2025 11:54:40 -0300
Cc: git@vger.kernel.org,
 Lucas Oshiro <lucasseikioshiro@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <522E8293-5248-497C-B4EB-D9C6C8251D04@gmail.com>
References: <20250217232847.8567-1-lucasseikioshiro@gmail.com>
 <CABPp-BGpOi9ZqrPFwxCiRLFjozgnYKV=zbYVAA5c9Z9yDUTBGg@mail.gmail.com>
 <EE88CF05-9120-4CAB-A097-84CC5EA2FACE@gmail.com>
 <CABPp-BHvutRL80QiTYx6gJbYiATOD32DrvXgQQtEy=u5oUZ9Zg@mail.gmail.com>
To: Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> """
> In the case where the path is a submodule, if the submodule commit used on
> one side of the merge is a descendant of the submodule commit used on the
> other side of the merge, Git...
> """

Looks good to me!

> Yes, until `recursive` is deleted anyway.  (At which point we'll just
> remap `recursive` to mean `ort` and not have to have separate
> documentation for the two.)

Ok. I'll write for both `ort` and `recursive`.

> Yeah, but we don't have a way to resolve differences for those kinds
> of changes when neither side matches the base version (unless
> something like -Xours or -Xtheirs is passed, but even then that
> belongs under the -X documentation); submodules are somewhat special
> in that regard.

Thanks again! I'll send a v2 soon.

