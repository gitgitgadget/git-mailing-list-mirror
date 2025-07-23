Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6151534EC
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285794; cv=none; b=FPj3a/3zyxi1ybZ+qfwssXmPHFUlAC/Ln9iiMUXTVuKb0w5Fac0bqRV6hApkkmF5fu56HwMz69gEnqOM6rDyntQxmdUVYWFaCyX1uJyz3V6+8YTMxzgoXqlMtAmzwZfMld5rpMTlpGZeOpUc/vkhjpgEbesJMKf9VnwZ4kwIlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285794; c=relaxed/simple;
	bh=2OnqoqUQ7aJMZ2xVuS4w8ad2EYas3lDoAbrGhIhZL6M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hlfRY2XRXg42ul0BuTInSYe2oh0Xj4cfBV2bc+/QYbz21maeDV1twtxihcXHMXrkMgOv9l0Z2r2kluF+5y46aCCHYBuHvcBFBrpTIvchjjbCjZpiEcgEsyGNjGuVeNbNPnCssAb4P7mGrOEw7H8g7iW47bpFi+Ok56kXLTI+S4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYPnNLV/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYPnNLV/"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748e63d4b05so69321b3a.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753285793; x=1753890593; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OnqoqUQ7aJMZ2xVuS4w8ad2EYas3lDoAbrGhIhZL6M=;
        b=GYPnNLV/RPy22NwILv+CTgyCkrHszThMnyeLjsELFsmaQW8dmlJ1P7OgGA1DrYFj2M
         z1GDND5OOUOPELJrCod4EK41Mr05XFqknYdHOll3je6GGaIEiT2h+bHc1n7zZKjuH/SI
         iRrf/szlK4DxzHXj25l4Qg0YFf+d7x/bMgEdzla0oNiY26tLL8styQY1guy2h13ynsS1
         hrZZaeL+9FrUkUTdgTHjlIg1zgnbA76pg91iBGdFdduXY6bbzi1SlhL63ugVQ8k9xgIx
         PjLEauokj0/7E6w5C9yv/u5MaEZuh2dAunKC7nIbOwZXY+KjFrFCKwUfLEBANUG4Yqts
         hdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753285793; x=1753890593;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OnqoqUQ7aJMZ2xVuS4w8ad2EYas3lDoAbrGhIhZL6M=;
        b=fwBXhJEVkNxoQbCq7BGJP/b/JaxUYzizlOGdApehtklKhDTVa1k57iSnIqRygipNx6
         JCQfySIEaB7Zr+RUNWZowla0FRqjG2w9ewpCUH7iXmhggXsnLdMXDYdVSEW9bzPCmhCk
         IfoX0vjYROwKkHQwSwtTKPpMc4sm/iVjg1QW+8re9Y+tEJsNdbNBgIC2kpXLQBbbTXbk
         mhr+6xssDsebDATLsZOsIj+oY72O0Y2xigkc2sBnjBi5L1okfYXC9jNscuDYVlCXgk0g
         CCMQ2wmpphJqqEklpuiBNHASnZksWGJQ/HM1ENAKb0FtTyptbk69kR1iP7nhd/i9Zkzm
         pQeg==
X-Gm-Message-State: AOJu0YxYpwJQCJr+2ipFk4ao8IdwzhvwEuJ+wnBcmfB7qyUE0bG6Tt+u
	W5x9B4RXBVTsmQHb0b/yH98CEOox/Qp4QxwTU0rdpNLjWldISUc+LYPMrdq3e2LA
X-Gm-Gg: ASbGncs/eFmMw8nLbLl8hwhcr4qbglMf6f3Sc21smDbcVqeiuH+lFEmPplh4I4WGO94
	Ox5aiBf9FcbjF/FnkzCYMg0S0ww6tTQChYnq0OG5KGw3ir63YHutUM19pQxsGwQ+53ZkRBPfs31
	qzRhzfKXMtGMCTADSRbjxZnNLFCJoeDIYpdyk/9j8QzwXWm75q8iJd2B/TCwv4QA+XjkR3D5JA0
	d6AItQSZSqR2xasuWD08pTe+GL+EQLW4uAbwzazkBxfakv23HZg8deXzqoQViWh1ffB24F0FVii
	KiEr4RZ5qobwXLH/sDzxjuM28TqllxWQhLM7VNZ5pXpItmZ5guMGRUmTiCCKipGj5W/6X9X6TbH
	/CO17VTeQEJm8g1o1RY4rUkZ0qAO9tZaRJti5TuJ2xhY4Ei7mHFcjj3i9
X-Google-Smtp-Source: AGHT+IGOx7qEWCnMBoUF8OjzZh+8e8Rv26UiRjikmSQOLGdWihRjZ+xfUFe2XtSsg/DWU2gDIzq4TA==
X-Received: by 2002:a05:6a00:1909:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-760353d5d08mr4954450b3a.16.1753285792715;
        Wed, 23 Jul 2025 08:49:52 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2150sm9986447b3a.13.2025.07.23.08.49.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 08:49:52 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
Date: Wed, 23 Jul 2025 12:49:38 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <999D2330-D15E-4137-B9CD-8FF9880DCAB6@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-2-lucasseikioshiro@gmail.com>
 <CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Doesn't the latter sentence only apply to 'git repo info'?

Yes. I'll fix this commit message.

