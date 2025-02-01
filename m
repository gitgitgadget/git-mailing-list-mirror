Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A762F852
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738446494; cv=none; b=mpGuPD6s7L278RaH/NcZ5o4N+4V18PAR0X6I5r87yiWtYeEJSFx41cTfFoY5z7BjoZgmL6vIUlbLy6GnkEt+6X/Vd/KC336mnnTNQw/OgYUHVVl1r1ZEeDXHrnT3N0cnh97zkioILMBWgC1DP3qBNtHo9MTadk6OY7Duu4JNfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738446494; c=relaxed/simple;
	bh=FjRXBUDNuVuYlgOSTzlBCvyPk+IdhnpevZJG2lSirxs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iMJqHWqPQPc3uDvHKvM1s9Sun5myEyE6/FFCZy3xoXHd1xUEFAJ2Tc/L3MfeAXq6NlXUQrhC/QJ51azrb8g2wTC/NvwkJnh7rBKsAqkoyMQDMR4hpp9dnjdlrDFmsZdQ2LmonpaDAeLnWmT84l/MCDoQUXPxMm4ncDjGFfbr0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjRF/+oV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjRF/+oV"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso6183776a12.0
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738446489; x=1739051289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7KX2YhXSfOy0eTmdENVCFw4oq0/qZ8gKaa079M0KT90=;
        b=MjRF/+oV88q8u54jUki3GX0zP2ttk3Ql5iDNEsCtq7zyoBUtKOJkmgOPm0mYJL85kj
         UGUudEH4rz4lKAFIhcc8tiHx0Kgxip5qAdirgBIZttg5oUx7zmWbmexTMSLdbxpsw9bA
         22zcxoiXs5pX60ukAzkVscuy2Y2xDcZLCRV2WJPemy8hCDLfa1l3m7r+pqLVvS2y3vyt
         5MOoyYW5RPm52m3LAzhi8N12Yqyrk9AE4S63W8h1ZeMkprbw3kdBa7JR77Kw6Z93HXIZ
         AaIodXg/djYzbDmfHiQnJhgI4YXgaGfZqHEQlEFCu5cdJmgyJJ+N811DVic8Fi7IjSl9
         S7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738446489; x=1739051289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KX2YhXSfOy0eTmdENVCFw4oq0/qZ8gKaa079M0KT90=;
        b=BdET2s44PJYbz3wvvTQUSsG1dMfEysWMqnUi42kH/cjjwszzUQEKA2luw6DLP18Lng
         gK/Tmlm8cmQCeNq/fOD3t2R49uQNyuJpfclC0TKmN3nxe3n+eosaTu2wMVtWM1uZb0LP
         kcs7Bk3F+AfgZLTmZ6YycqrFklO8l5WJfsi3fIQSPytyXEkIRnkcSOTNu8yrddSiVkrM
         iZvHJW+QlwO+bQX9Ml9ZDRH1DqcgCUQxUVq69qsGDG/1FFJN8vTwwS7Pt/nfMpwbeMy/
         PmRfL2R4+jq7jYy1/9Ay377UfedsVlCcr+D+G13aX8FAz9gUx5+po9qczy85+i6B82tn
         0N9A==
X-Gm-Message-State: AOJu0YyUOGK5HUIf2KjNPs4nzp1pHd4JtZ0ztbYAExaz6BIxm+ORRF5+
	yytomTlFDVNqvw22fbuPxJabH7FOZ6y8+hIf23D0/0+u8YVmiVOatgJvuZi2xnl0OLApXaU9HPe
	QWyfJLt70341mN03YzjlRX31/FWZL6LlI
X-Gm-Gg: ASbGncugPOZhHpEK+4dIoGp7q4Kej5ul9dxNwX39wt6m1VGQISBkYUWlrm3KQ8MMF09
	sGf1DTDKvs+q6d89oQE6lLy9Tsb3Lv4AsKvo3BTgxIVSltPG+miQsGTCb3ullsTFCewi5MWDS
X-Google-Smtp-Source: AGHT+IFHVX8+vWVU9gKyMe4dpS6aawba1pq5huR4UEYdJu5NywEJkmhK9X0ao3OGpr5BvN/DoObatxGW3LyFa4IY52E=
X-Received: by 2002:a05:6402:5110:b0:5dc:51bd:4419 with SMTP id
 4fb4d7f45d1cf-5dc5efcaafamr19273365a12.16.1738446488841; Sat, 01 Feb 2025
 13:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 1 Feb 2025 22:47:56 +0100
X-Gm-Features: AWEUYZkkNNuIqAdMz1S-6lk0IG6H3FJ77gPvHdzNyPPEawqhZNPZW_hFhvNKFlo
Message-ID: <CAP8UFD0SbD8LW_mbmO0RFQepMwYt0np1PkY2P5ki7qkwfmpCEg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 119
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	"Peter B." <pb@das-werkstatt.com>, Justin Tobler <jltobler@gmail.com>, 
	Brandon Pugh <bp@brandonpugh.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, Adam Johnson <me@adamj.eu>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 119th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/01/31/edition-119/

Thanks a lot to Justin Tobler, D. Ben Knoble, Brandon Pugh, =C5=A0t=C4=9Bp=
=C3=A1n
N=C4=9Bmec and Adam Johnson who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/747
