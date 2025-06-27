Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA32BAF9
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051123; cv=none; b=HCZ6XMpHL4dtTSM51y0u8XyHC+noc70dWhEhhDovjp/8jKWx9dA83d4D05Vr0DTQoW5DCxV+PWAOQYGInE+ppr5cu41Ldd4+M1KpzDOyV43Z8uN4bhGsFYCao786oxAJ2v+NIYgnKHYqNrIO/MaHsI+8/iLMpTYvmqk15z1xeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051123; c=relaxed/simple;
	bh=9EC/E6cNIakpo/rWn9mnWeiJqv4qBElfO0bvbqNyIuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLvvRavSOj+HH99UvOkM1uoEteKO5Ril4tWLg76eiRIoKXrSMrHz6vRmYwodEXk6SSH1dwSWOmpKFvSnGqETk3n/+WOj9+HMNhFgaxH8yKgpgoqRzHk+OlthVJe3iHcnho5M2svzhvyjXdVZKub67YbaZk5tS77GfpWUgwWMouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd60shdD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd60shdD"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c7a52e97so3042024b3a.3
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751051118; x=1751655918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BkxWKKQcQoMebINeq96rDAn+5dh2Wpo8Ri0RXQai8MM=;
        b=Yd60shdDDB0v5avk1GOOfLQQnTkVW29jvGzLyyawIpug/GdS+4igVsdC39inJXurMV
         3CykAoOH9Oyhup0GwF5vnIjpw1kbNVZ0qXoShUpZq4oJGdhlMNfMlKDYijtAmBGZS2gS
         tpS4MjMAqAapDuFsvSv/FF+arRLZ2GnV1hiZ1CL5ENc3PF9sidks3RAg5mQuDiIVpnDz
         QPxXO5NP5IKSw6FfwGN5GMBWDhSab2l+Zk0sy1YtXxr9dcDgdzROVIL9pucaDTOCUCR7
         s8Aw42ZdUrNVb/KvrbfPt2ykFk94iukXkaQuy5CqzFIEJEqzrk1eKdKcDlq8pe/fA7oO
         D3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751051118; x=1751655918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkxWKKQcQoMebINeq96rDAn+5dh2Wpo8Ri0RXQai8MM=;
        b=GKTBadrQ/rs3whYjxEFGxFS13M/kle6oqKvPev2CjuU77rdqUP8jFpJbPaclei47bo
         DwXNH1vVo5M+jGPiPJATqr2FQ5WBrBR037UNXM4B7+/Hil3SZ//NuvLK8UsABVqeizuQ
         64LFWkRRGcgVavWPRl7Ea+9Uh+nbE4tiKZJjIYxOVBa78rM7ZnAL3UoXnrfsHDoTbnal
         VdbSFLeTDbAZAVId8hlpM23NvLfJmuPxK/n4XGM4xvgV6CoQsbeZq3N0SIoBk+Qv6qt9
         EoiABY3rQr95Ms6oBClFmTOCPMog0nty+xSmmYDSQuREvnca+WEigzIWMmJb8b+wefld
         /w2w==
X-Gm-Message-State: AOJu0YyeS0b9NE+XHQZFB7P+v2y9lScodiZZsKmCcyDPWsUxIR7L/JhJ
	IULi5j8u2O3L5kBxvejxZQF+aaQV7+DVgfftkqU/MjOzccFbgXETJ82jbrBvFA==
X-Gm-Gg: ASbGncu0y9wdmLs5LipT4fTNWoztuVe8cI4UPoXUrPuH1Oy4Z9mEMsEFwG2JJtDug6k
	Be/Jd7Q1DhoTW3ajLS94Jo0sZZUO0dbtMt05TYuT8QrQjaIBLcLOnfMLBgGEgIihRJ+lyvB9iLg
	SGJL26TZy9rB7db9v8NmzF4VOzlqQSJie7bzisaw1j+xzWqf8DcOPE6QQz57Ymc3+Q4GFJKOYaS
	csD18aNhDNL6MIr3LAJ+AsYm4ULp5bYv8xGeRMZ3Qz7R8qjGgXaLCXeY3bIF6RTcLsV/vX2+wik
	o4l1+ELK+jhN/acq0du0H9EdwgeeN/TIm/rD5snIauEulIPZYBNoZeJZg8yl/k9HJxFhiZZ07nq
	K7umEAEM+Kid4lBhn+awbFyDINZSlSBSYtQ==
X-Google-Smtp-Source: AGHT+IEJ3a7WMM0nYqhvyRm0Js28nai6JI+o/kbzfGazpgPTsLiqIIpIM4T1J1n9WCtHAbRYYlzHuQ==
X-Received: by 2002:a05:6a00:1992:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-74af6f2e8c1mr6310863b3a.18.1751051117841;
        Fri, 27 Jun 2025 12:05:17 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:fdae:9b06:496e:5a9c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56ce594sm2927523b3a.129.2025.06.27.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 12:05:17 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:05:15 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org, 
	kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v2] daemon: correctly handle soft accept() errors in
 service_loop
Message-ID: <u4scxaxivz62fsljo7okkfdvcle3zdby6h2sdzd6ed5n6wi5xb@5ekxdycixwxe>
References: <20250626161038.85966-1-carenas@gmail.com>
 <20250626172159.87204-1-carenas@gmail.com>
 <08804dbe-56dd-4c0e-b36b-a82768b0aa29@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08804dbe-56dd-4c0e-b36b-a82768b0aa29@gmail.com>

On Fri, Jun 27, 2025 at 09:38:47AM -0800, Phillip Wood wrote:
> 
> On 26/06/2025 18:21, Carlo Marcelo Arenas Belón wrote:
> > 
> > diff --git a/daemon.c b/daemon.c
> > index d1be61fd57..f113839781 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -1145,6 +1145,7 @@ static int service_loop(struct socketlist *socklist)
> >   		for (size_t i = 0; i < socklist->nr; i++) {
> >   			if (pfd[i].revents & POLLIN) {
> > +				int incoming;
> >   				union {
> >   					struct sockaddr sa;
> >   					struct sockaddr_in sai;
> > @@ -1153,11 +1154,19 @@ static int service_loop(struct socketlist *socklist)
> >   #endif
> >   				} ss;
> >   				socklen_t sslen = sizeof(ss);
> > -				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
> 
> Why is the declaration of incoming moved but retry is declared here?

Separating the declaration and assignment for incoming is needed so we can
insert a label for goto; moving it up just removes distractions so the rest
of the logic is clearly in view.

Obviously that includes the definition and assignment for retry.

How would you suggest to arrange this better?

Carlo
