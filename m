Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EC178372
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767540869; cv=none; b=hCH88OuAYqm9tvukuhiZBqLxFpe9WwFsrkg+Y263BL+J7xJtgjU1WpkxfxCFmfEG3aea5ijFD0KpOo6aIoOLNl6vTasuntnD6WKx2/JJZ4eedy+I8q6VrWezc6pQunlxa5FbKJBTFXXt1x0XEs4g97BU9Ab2nsZLp0qKtiH/Yo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767540869; c=relaxed/simple;
	bh=QnBlSu6CQWcLqmsziItGdlEsP1SKs4Ny1XUz+j7nSQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XztdQnMQ5iVbobhb1AEji4c3nNzZHBeO1OjmAeVIj6fewEr7ccHLrP/AmYAGxXqTojzyWrHvSXvV0CNbN2VInpPpG6qS33GVDllLuG/zb9uEl54HlUYy64rRK2OrvavyxHbZWkpngdyeu2zj/LmP741dvdIr+rvSyCibuYBlsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx0L8T9j; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx0L8T9j"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so144276235e9.2
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 07:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767540866; x=1768145666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QnBlSu6CQWcLqmsziItGdlEsP1SKs4Ny1XUz+j7nSQA=;
        b=Wx0L8T9jPVozYv8il6KATD4AAok82y97RwlYSaNRhR2+en1Nkgg7zCmN9tb0K/7B5C
         NKZbli0B8fVgxkxEdih8FGoCTgeRSUSUeTTmtd34paqxc2YEqER7pUEkaBsVSGCltuc+
         6lwzdkhFgBOwgDti0jjcvxKOfXGuPG0bQYOv02dKAVgWU5vED/pUlLSxURlEQd6YwrzO
         nZAZksv6YSznB2O6ZQxJorFmzqsqv4f7ja49IoWPktpaLR0Cwa0LPG6OOf9JuJd1OknC
         bwpKf/teikG8g4w0GozIzUcrFI829bjwSMcazXl7IrIGA6SSMjawlpYIf6CTU/MIls3f
         Zx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767540866; x=1768145666;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnBlSu6CQWcLqmsziItGdlEsP1SKs4Ny1XUz+j7nSQA=;
        b=seR+E6eTJu3pGTOqfDjl5+J7BTlh482UvhYTf1P6T6vSBYYobclaoN8K6423HALFTw
         iwqG11iDNDmX8Mx4WG7xiH4lcqLi0Sb5A6zrrrTxbDVdHDb+HBxEOfQsmyqqdQluoHgB
         wfaROadvKNdEBtTsF2L1bXYh1JJmBcdzu1nN0vSAZdKJEYxldGonHsxJoJXdsEcay8/j
         d/hAb58xFNGjBfNIWX16M+8qQH2fLXxvGVy2+dtaUlbI8JQdhK1d5QZxglx7WRs8oFDl
         fUd2fvw8OxLCNdDrSS911AD0NhLCPYecUhbIGlmkuTSbtA0zllyWk8k4w4r2nzcCEIsF
         loZQ==
X-Gm-Message-State: AOJu0YzKgbZA8aUTHF7uJrjQUrIHOCWp8mXbdZ7Hyeup1HzGTJSyNb3P
	HTXZEHl8Hqt2BBDu07NM4IGYFEH+XvS8ARiSX06JxZX0iRFeDPFBwNKlmwQde0JZ
X-Gm-Gg: AY/fxX5K+M/Ak6s4UGxlIoodauoHjKqlfiZJf9qPfxuTy7MXuULA5hP3ki1910ZLJiA
	L3ds79/IbFksLTZrofTlD2n2wIaFOOfrmSDP657ejiKkwq40dq9ZaxxBk6MWAoRwzBAlN5TlqUm
	CaUjR0z/A1JF4con7YL7xCjvmZCkiwtm1aCjNi8ml5FsBrqz4uSSLdrVS7nJi4Yk5IXd8jTE6T2
	BvjApxIr14IAqn2CboSPn09qKPyRPDRcsWM49fmo3VyO0jBsUeFTiMFZQDiZkapOOyguQ3VIfhY
	XHikyrsafO3WSfdewq+sJ6rOpWJajxIFcSpLp113z1i3zjuhXR6kU0O2TM7EOU1BiglghG+CK6c
	5x2AlZXM36fg8eKFrd0Lys9M+ZDQ5hzzcN/j9wGtXE9yrLme9rQiwV5xK2r8Rd/BVjFFHAp6g19
	krCcOtNwr1pLBcIIE=
X-Google-Smtp-Source: AGHT+IHfrjzo49H/0+Q4q8WlR6K2WsLGV9lGN1a5hM1Qnklnu5m/qeEsexdY+pzfLoewKqV1PsY3tQ==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr513204305e9.5.1767540866000;
        Sun, 04 Jan 2026 07:34:26 -0800 (PST)
Received: from localhost ([102.88.77.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6ba3af58sm40880235e9.2.2026.01.04.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 07:34:25 -0800 (PST)
Date: Sun, 4 Jan 2026 16:34:36 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] t1300: use test helpers instead of test builtins
Message-ID: <aVqIjHIi6aKvFYXg@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104124255.15609-1-pushkarkumarsingh1970@gmail.com>

>This version updates the commit message to avoid calling `test` a shell
>primitive, as suggested.

>Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
>---

Hello Pushkar,

I think the right approach to send an updated version after modifying your commit
message is to modify your commit message to INCLUDE the recommendation, not change
the commit message to the recommendation alone.
Then under these three dashes after the 'Signed-off-by:', (---), which is here,
where I am currently replying to you, you state what you changed in the new version
compared to the previous version.

e.g

Changes in v3:
- Modified commit message to ...
- Modified subject to use builtin instead of primitive


Thanks
Abraham.
