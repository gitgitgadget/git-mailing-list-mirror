Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE62F3C37
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664870; cv=none; b=qB2iV7kHfXrqPl2Q9I5qEmcuUumpbBO3GdsclBWcGfH20rRCrBespqPD1WTNmrcwisCsjyrisxye+Xl20qgWDxaS+UwwxRB0EhD37e3YQgYw1j9JUV2V28qaDWAAoHHJVn1be7K2W+4fsDhnFnUv/088ULxAcAWHs+Q5S6at3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664870; c=relaxed/simple;
	bh=DFAJKpQwyVzqouTR4/ZsDeCw5R5mjxmFdUhItdP5hYY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qdo0ZMjVpFmw1arIRRntYX5JS7armh9DnlOXO8elCFZJauxc/s8WB+GCZWYj/0yX91AREbAvLJdmCp6lNgrTzRtQeda2T4rrGV05WidVXwLtsVmLZ+AgjtbZoOnfVFaU0Vqditxjnt/+E79WcnJyhhvkOAUu5Iq0UtZspAtaIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQAR2qs8; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQAR2qs8"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-73972a54919so5881500b3a.3
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752664868; x=1753269668; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc7loYjLScgOIrc5rBxdiwiU3nWIXJnylDp/rYs0sBk=;
        b=RQAR2qs8gKCkil+huWtoe+/i7DV7FHEuem03LlFZ8gq93/BlJk0wXMT6cWGjzh7mJO
         8m2Z2piStZrHcUkiczxXameKtJ8u/fbBF6ODMrsLyqGyB3uy8IGxzAzbFKHXMzbrf3Iv
         TFJBmbOYHPRdHPPPDE3GvPk44yvN0/u7wfiJQl7j8d42/eHzanayPQYYmpPfK51Sv3R3
         ugXZR95Kmui0mpgVPsXyUjjZ2qY6AgLQwDXoICCzfz6z4HMUmoMNUs3L/Iv/SVfn7O8E
         mR8qxb6XqOm6sEPOXEIsVJnjMWv5hg9CtS8QNad2UzpabQC/M71Ywd6fbVVT9IZ9eqdX
         4iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664868; x=1753269668;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc7loYjLScgOIrc5rBxdiwiU3nWIXJnylDp/rYs0sBk=;
        b=myfXK09/7Gdneo/aY9GhF7uMDw2BJ/wrcXhFpKLQc8ebTCoGu6rt353T+gjZKF74i7
         lDaXA1g0fGGN9vXPIz4908oae3t+6cMN2OFh/xLu1jWsAlFrNujm8Vr3hzA6KJHLM0RI
         y0cfYATcAihsCe8wdJ3mZ7vsuYxep6kjZ/7//TLhp2yTo/dwxHTq8PhIWI9nhbhP/VMQ
         cMN9zh0XEWw05QCQ6mHFUASm7z66jByGsQ//gWwwezMmFrADNXYrK/f2zzbonWA1J6v7
         xiPwUP64eMVTAnnrq5yqcCC0VLan0eipCT+hMymNIs7Fg+dtvJ3+N7zQ386z24XcHLOe
         OL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLnB4iKdQhUeRF+oePHPCbwdLdQpyFQY48LfxvhWyPs+TQy8b6fRiRFxpVv1FYLU+pesI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6eUDIDQUPwnkfKl2oKbCHXdxqQBUO6C24yUre9wSxSdfsOgSF
	AILLk56Nc96BuzaG/0CGNR9OzGOhrkR3gBn8Z4KBQcIhQcInXUn/hJVxnk85KfAkhto=
X-Gm-Gg: ASbGncvnVO2VTwTB48QyFFZFd2bKI2/TYwJmSJjGPWiLWBIM+Usi4oP/L7O4PQKahBo
	V8gHlAQyLCaLkTGJjr5MfaKQ4HNz3WOoNWvPkcxcga56Zv3O1Fmt3ae4rbi9CpynyGhLQ84F9xS
	D9E5JwMa6stdThmFeoo6Sxu4bCilZA4uchgvhIImbAtjiLykjiw2iKCsKKOBT4j0U3+Ye12vOKg
	N7AbX/CqOLz8eGflfl4qlF+n82p6qJQerBueqoGzvOOUuYikCVMxTKwmkAe+pE9XwLYxGhuojmr
	vEMhGecdhaXHPXwPqt1Jz4FGxp+/e5+BbvTVukUikvKpS6C6UYKiqdPuvUDAusvqhYcFPCTO7LO
	eW5pnkoNB195/PRfGPt6vqDCzBKGKfB4oJciQb9HMdmk=
X-Google-Smtp-Source: AGHT+IGriBuDRpWHy0sFrOpNKDiZUhzBzhEiuJdpERXAfEQoEpcpvRZdYc2+89EWL1bF9U42iM/++A==
X-Received: by 2002:a05:6a00:2da4:b0:748:ff4d:b585 with SMTP id d2e1a72fcca58-75724c8c841mr3190553b3a.19.1752664867596;
        Wed, 16 Jul 2025 04:21:07 -0700 (PDT)
Received: from smtpclient.apple ([188.253.126.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd7134sm14625275b3a.19.2025.07.16.04.21.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jul 2025 04:21:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [BUG] git pull ignores pull.autostash=true configuration when
 used with --git-dir and --work-tree flags on a bare repository
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <26cef1b9-1f17-447e-b647-3d32a3984997@kdbg.org>
Date: Wed, 16 Jul 2025 19:20:53 +0800
Cc: Bryan Lee <hi@looping.me>,
 git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 7bit
Message-Id: <ECF947E6-06DE-425D-B1FE-A4DA67F60834@gmail.com>
References: <010001980c90be66-2401a0b0-5c86-4135-90e2-c325852ef168-000000@email.amazonses.com>
 <1AD9A170-8E17-411D-A13B-EA7780CF4D39@gmail.com> <xmqqa555gp1i.fsf@gitster.g>
 <6AEC3113-D687-42E0-B6D0-DF62FA1A9A8B@gmail.com>
 <26cef1b9-1f17-447e-b647-3d32a3984997@kdbg.org>
To: Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Johannes Sixt <j6t@kdbg.org> write:
> 
> Instead of this complexity, it is most likely a lot easier to fix the
> origin of the misconception that `pull.autostash` is the correct
> configuration. After all, it isn't even mentioned in the git-config nor
> the git-pull man page.

Yes, update the document is the more important thing.

- Lidong
