Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD71B283C9D
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767287225; cv=none; b=J+7hAsGy4dvXOJ0EEUiOozT1PQicnzZA0q0gA6wbhxjrkDcoCgTk+wOzTXZ/Ga6x7GxZkQoVH1Ua+Q4Svv9KJXV+f9NJqVaxUHZcvlnLWsOHxLWpbcCIOzDtJY4T0bsJ6uIrEBVoe9d8/2UdvkW4Wi2ml9n1uqe5HaJJZb/JJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767287225; c=relaxed/simple;
	bh=k/hHmEYkYqrQp2d/iGb+NxXx19zYQD8PmBbCN7YsFtE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=STgFINL7Sga8f6/4vWUUbtK8xE++kfLMZfCTNk6k6OqfeMnlYqOOMwqchrUMUFpBYwpb8X1iXGIY7+xpNohMqHhZdvLTeb9TCBNLraAe+2JwAOp/9rTjxHsZte9MGdwl/vTSz4Nbl91sLxLbKLpuouRbIeldp37A70I4qPvqxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGzRmLZ+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGzRmLZ+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8010b8f078so1678200866b.0
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 09:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767287221; x=1767892021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VltV98jGoKgsc9+jrDl5rlBIyTJC2ZiQcjmbpronJ/g=;
        b=nGzRmLZ+rjaSMNn9+XxOvPMfwGlBjUQEMgJJlhBTDvVZYzSqFGP8C0FEgq+ufVJty6
         Af8svg+SQUfkSMEJRVKISbBbgTEYg8lEhjIdu2BGAmBWm90XODwRE2PtInxLJfFp/j3z
         DfKzqP15y5V6RkgWuQo0W/T6sGMWtuVdvxUyEU8/rcFos9qCFidLuglRAsqA/DxFo7uv
         2v74K2eHLpH5bNDkwP/Nd34A4d2n27w3QygGmoblhSWt+5uYBss1uBcI8JWu38F62g+E
         Ihi04ETKQiruPUR0e72LdTQFB9nKDiMAZzFa+EAn/o6r1j4JGqSrb0Rt3TAYU/Ifg8bQ
         sqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767287221; x=1767892021;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VltV98jGoKgsc9+jrDl5rlBIyTJC2ZiQcjmbpronJ/g=;
        b=mgxzl/JzHtHuX6zgkKqvXGVAquj8Pa0tPa2X5CiTyH/UjBLOp/+MD/fnStGMX6FWG7
         qGNEGggWgla8kL2lsjSu5P19eQpZTFzkfAJQVwqqyHG+Lc75tLDVWb/vQ/RWI47Ancyg
         XN6FjfqleOLTIxl2herJ23KgbKc9MT/6vtBtC755MLvKa+r3XpC/JKXKt/wWdu3reQVQ
         mHOm72ZB/WJObPSL7F5UD9NNn0WigkWdpsS3UXeN+Ue05t2SXSLjgeKYKrEQFdQyVPI2
         rgEhzE9ECn5i6sdNjc8nQjAGHRf42EK3gdTcG9uuYJEs6BCz0eeWQ1w5NHjSh9dpdZqn
         idiw==
X-Gm-Message-State: AOJu0YxJd9ViaIvhVPTB+zt3RK+x629InaVyS7p3Af69swtE2fFgxNAs
	GJ5dcUsBCvGD7sjc7226Ynr74mJ+uwDrh+LMjEPrF8A9VOm4RNq6p875cHfIKqb2JQI7ZSaMRAz
	pkPolhAN6aKVntbVjVSDRfXe6NHYD22th7YOg
X-Gm-Gg: AY/fxX6PoQ9Ydx/gNMt+VCkp1T3d5WFuNdWcR0zseKsPFHpR++qc2admar2or3iLhuc
	i5xqS9hMPcds9MKJNyMt/Wj5MRIhFxz2MG3mzdwPwrufZ4/bwisrHTfyRaNK74hES8zoG6b7T+T
	VqkuarHox2Fw8J9jUzTcEaAHAfbQWTC9FnVMJT+7Jzo/UbhKOuG4icOr8VtEdgPxuNMddEIsySY
	OGuDus5WoTO4YTBZEyiTZitKAZtZsecTJvz3ZQdLAK8TuBI61G1nT6rVCVnm8So2nXRidLubD8v
	oUdu8naEH8h6x4quD3qGYKZaE5OJbnk8xeLrA/nudPEIINGOvVMHo7VURbTYF0U1qBaljO/MVqG
	jvnuxw+PfePDq
X-Google-Smtp-Source: AGHT+IHMwErLjptypFg8J69juRRKS23ZRPCuW56nxyR9Yz1r0UTMz9C2EvrTZVmAte+5iILQpn5iywQsdETJI/aOCG8=
X-Received: by 2002:a17:906:4fd0:b0:b73:7715:ac83 with SMTP id
 a640c23a62f3a-b80371d345bmr3926219766b.44.1767287221215; Thu, 01 Jan 2026
 09:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 1 Jan 2026 18:06:49 +0100
X-Gm-Features: AQt7F2ob-kPAPb_UpfBVOYGg-tlXYk8EpSdgpsgE2ST8yAZdjTLhzbwAl2v-xFA
Message-ID: <CAP8UFD0SRPXC5iJzd-n8JMNaBmMLHVuz+9z4ronz9A51oQc5pA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 130
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, David Bohman <debohman@gmail.com>, lwn@lwn.net, 
	David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

The 130th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/12/31/edition-130/

Thanks a lot to Lucas Seiki Oshiro and David Aguilar who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/817
