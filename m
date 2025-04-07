Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916E1C5F06
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054802; cv=none; b=ZjIAHgVrmdDpAQVp78szCGa9Ae1I8GFTz17gGmB54yjN1NLFydEOsf7OMdE1p8QqwOR34KVENtBVEnv4dTBiBamPC3G0IIKTQzdHGJXJeTU3+DX/ExoSkTsAerOMxKrYJRLywS/TAgfQVz98io51RsXSy15qF6VX2cC0teAiP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054802; c=relaxed/simple;
	bh=xT/mnikDy5w0tA8SyvlQVzHEwvx2sLTMjaze5YUZCWA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KVXEGvzRnI+1VqHbC/bWd5x8xRxJpBNfm+v4Aw1fXC6mYoZYGyOaXjLKf4Lc+SUZSDAC4IyB7QQUfXoq0EE4ztdUB+kfNaeK7tScR6g2AySMor0EIlskW7mb38YvHIymuhBoz2BcRte19Vxmd5XtXrhRu1JAIVS+8sGlAbGIi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlF+vgzp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlF+vgzp"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2255003f4c6so42769595ad.0
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744054799; x=1744659599; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT/mnikDy5w0tA8SyvlQVzHEwvx2sLTMjaze5YUZCWA=;
        b=DlF+vgzpWIzc2dHDgzz5mhUPj92CQEUd90sjPmE3M/0OUDEb0EIsUM9adY10CUC20s
         ksdm5x/qxE7qh8qTALtarZ/q0ShgoY3SOhke9dw20M5Nx1cinKHLAI4lsEFZyt7eKkRs
         R+ILjs9Ymq8JSHJN1H6r34ZOXNzrA+N/c4YDNnwNXKn3ZLKPXOkpqllP8pG+f0CzKXZx
         ATD6HIUlSQ9o+nLRFZWQxCc0a1BUFTpR+9uQHSVyUrp2sYQJuqCTnAmuwyyVWwwSImSx
         8VWkk0BpoQEBxKuzQSGPhYcKuO9h4hTzuHIKf3pt64e4/wrwOnamLaaK0Jj7ee+jj+Rc
         KG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744054799; x=1744659599;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT/mnikDy5w0tA8SyvlQVzHEwvx2sLTMjaze5YUZCWA=;
        b=TBs0lljNvNcziP1ad+jwmxdln/1DOjPpPUbfLhOE81S03ZQ1fEcFmETbgA6BHRYNvP
         8HBzKCkpKlljed1zzk4nK4IwnCN3SEDLx6TsoxXe6UxyVbzOFHjWllyJrQ8ibsDXi+xn
         9huRdeYink8plyYgrz5Zd4kfnnIGOZJXahErr6akVgc9parxezx1Wc2xnJ4+hi5JUr6P
         DcbALWkYOHuJP1vDFEQFECItkU30NLS166UHUyf0LsSLqbMkiziBGutsO8lVnbY4wTMz
         7YHpPIskjRr8rFSDC0q9WlnUQAIEcgRAtfzN6arNZ34bpuFr61K/wcstJXhQstbGNVBl
         p0zQ==
X-Gm-Message-State: AOJu0YwHLiA/xrmZNxennlJShsnAZVsUCSsO/B48SPowMXQYWvgJQqxT
	AozZmFSpytnjFIfH/3Sr/Io31gjmh2rB8jFBBs3K5dgWzYEcrZgNpvigSw==
X-Gm-Gg: ASbGnct8cTi8DlZ8im9BbM2Bgkk/6Bcs2DGDQnrqa52is6b/8t5eDXImQEUcqsnZ9Pr
	id1SSKYFVzF/+tf5Ml23up35UAPwFKN7suPqe28wV6jFpCLhBBAhXZ9VC4t5Susc3i1Qy6c2Kpn
	4yuwIeS7U7XTjfoOgOtrVbF1TzlKoBbURC2+nksShDP4RcemibJziJqisF+PtT8p30fQhMPyMnE
	ow8u+yFYGBWXWNReFYS6/Uk1GhcNcT/8HHqJFFzu4nqK/FVWsG+XWOsiKoD3gh5Dn1ikrNMpB2w
	BU+mhVHl2SSNEsxfJRXdou2Gt8dKy908EqzQzb+OBeqOpLl9pGak7tQqyTcAcPMMTbb7iVg9469
	F9tnC
X-Google-Smtp-Source: AGHT+IEJ4ATHn2LjZnXIQxrebgBn8U8pDHFZlTlWJijKja47Y5q0lIgKrxZTUqx0gKcukLgFmgvlSw==
X-Received: by 2002:a17:903:41c6:b0:221:78a1:27fb with SMTP id d9443c01a7336-22a8a049ee7mr140963975ad.11.1744054799614;
        Mon, 07 Apr 2025 12:39:59 -0700 (PDT)
Received: from smtpclient.apple ([2804:214:8123:72ef:4400:ca7:138e:9bd7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad8casm85146595ad.21.2025.04.07.12.39.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Apr 2025 12:39:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [GSoC v3] Project Proposal: Machine-Readable Repository
 Information Query Tool
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <2E36129F-71FC-4053-A20C-D41C4B3103A4@gmail.com>
Date: Mon, 7 Apr 2025 16:39:44 -0300
Cc: ps@pks.im,
 karthik.188@gmail.com,
 shyamthakkar001@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <4BD1FDB8-6A7F-456E-AF10-DD3AC1BB507C@gmail.com>
References: <2E36129F-71FC-4053-A20C-D41C4B3103A4@gmail.com>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)

PS:

Just a quick a recent update: the userdiff driver is now merged to
next :-)
