Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388F194096
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735816762; cv=none; b=s5wuQVF+/5qKybmQcQW6qldLbUfXOev/VYdUPkAmMPNMms64FR/MgnLiFXHRzX/YvjrGwiK1UEXxHoJDTvj6jdSSNpwfOkkcsaVYdn+LLBQ2ASFCw8XTYRYTpRkGu9l6di24Xwh75JO8oKsZK9WrbUiqgOREDiEdYbuMITrw348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735816762; c=relaxed/simple;
	bh=sJViIcv2T9+g/RxriahLieAmyDZgC5n6qkdqPnPEPO0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=elsO4Qaj9Dy2ofvDLv3dDCB6ASGQWT/x+dujrq7Vh2JYuFiqKLyOt/MA+pvVSmAJCvTiSOqP9Eo18tFpyhAJEYnLkUpEyhjnJtRM12AdJNKdVyL81rXLW1yrtpCgwaK+LiOvdLMERMKgOKVW60qDzwHOVlPYNFvOwOr+33u/VCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUj6oT6h; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUj6oT6h"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aabfb33aff8so1970100266b.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 03:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735816758; x=1736421558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aOHVhB4iYeHuqoOtzEXvWpuDABu2kyRzTcm0CRe3qSk=;
        b=OUj6oT6hul5sgrIuyEOgaVL64uvYaD2xmT5i2dtAH+2SKQ0twc/xmRqMJf4qNjwYQn
         pM66++RCFBpULBpawp0Za9wmwQ92WDVCWTBu+XTeuDrJ1hI1/xwCfo6r1rwgf5EESD1m
         Mb5/tologg580aqbFhooidArbzKsOTxE0yLoF1Spx/vFblHpuHkNogSMEbqzPNJzkASd
         8idXx3O9LcVagei8MT7CQj/vK9STF0/e7SEasOdLYAdJnh8lpLJM72+9POpA3gn8pN/u
         P6UP5zuLyIlyOKaCA3Qipv+adl+u8xmYwvNFTCMLVuFd4/ub7lrFs2AvwZhAKurY2y5c
         zidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735816758; x=1736421558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOHVhB4iYeHuqoOtzEXvWpuDABu2kyRzTcm0CRe3qSk=;
        b=qLouLopV6qtmhRbQ2OIYysrLMYWwb9zlbnYUoLUKWaZCjgh3B5dL+3VcKfem46ddwv
         KXi5GexiX6Tw0+lj/pAXI6cGHdp+et4kd4ENOs8mT6fJ74l8ZqoiylKFol1V1FhY1qoA
         n25YNds6qZ5DbuVVMtWc5OkK6zFC029kisQ+6yNdYvBLYRCSUJF9Djt21+q3p4uL+6NN
         OQTgXkpo14GKJ/nhY4A8vKU+d673mCcw4/5iSrqsc20I8Hq0VwXPjLp8z5kFog4PKAWp
         PIglTAMXLkaNv7M1mlJUyr1aLhoCbmPBvbSt9RiKAS1LQ0cjj3sL9aahNfUWizwNQ7JQ
         zbkw==
X-Gm-Message-State: AOJu0Yw3L4/LvTH+L4l9UzJWwg12ODAZA3zRMBbj8cEnfCoY1UaqCF0P
	a4nXFZitUE/cT+DI0LbHXV3OmICTvhA4y+mRoQswd4nXoH9VHE770cEz0GdpJuyUZWBMJ8ne8dY
	hfQnw5jlsI8gBOMBgMkvxLU6etO+cvFFJ
X-Gm-Gg: ASbGncvziX03r5KNvG1eVKUEy5Jh5wlspKiafyHMMPxZ9Iq54qpwYDwglTCeYfSqXf/
	6Kod0UjAqX4n3pxgLpT83Uan93Vg5ByVhcXMnS4jD
X-Google-Smtp-Source: AGHT+IF2AzJFW8wQdR/GuT0LTCSw7XlzFA3unPJzY4uOA2izoX8rMfniozzG7RXQHcQ9Q2DfdmOS51itTet0I51f888=
X-Received: by 2002:a17:907:6e88:b0:aa6:9540:5714 with SMTP id
 a640c23a62f3a-aac0826ec8fmr4145917966b.25.1735816758219; Thu, 02 Jan 2025
 03:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Jan 2025 12:19:05 +0100
X-Gm-Features: AbW1kvbIe4bB1HQhs2vHMOYL38Gfe-wyWB3lXrfADDbgoU9rlJUL8aky-GHDQ6A
Message-ID: <CAP8UFD1p4YZ0GB-6ffF5YwMM-_MSusHdKd4LxFP5O9dFJrwqiA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 118
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, David Aguilar <davvid@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Eli Schwartz <eschwartz@gentoo.org>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Henrik Holst <henrik.holst@outlook.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Paul Smith <paul@mad-scientist.net>, 
	Emily Shaffer <nasamuffin@google.com>, Kyle Lippincott <spectral@google.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 118th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/12/31/edition-118/

Thanks a lot to =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/743
