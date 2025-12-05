Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F82D8365
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943427; cv=none; b=AE0uJu2x/gUYWN63bgS748Q6jT3IxKfglQNod+OzdJflQc/jZN/6XQlUOm4TYC23lIT0ITL8/KiOVZ5RrAqoGaXILs6aaC/L8IzwM7ggMIrIod4jU9w4wMQZhyo4YR/ADxnbw3hD5gHph3dGSYVZLT0fBIh945I+DMOLzBH/Rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943427; c=relaxed/simple;
	bh=b7Np6fhz8VpdJkgGpyaZ3JVH3EQhw+UG1brx4KqKltM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VmtknTy1zQKWAk+ULEOJrsuBFvmRwNtQ75wJgt8avTZ884tBh0u8I5JBmYptpO3BF+Q/ZkoTw07+Awzt5NCFAMcUV+67jNJnzUFmVQd8wJQms5wA5OL1UVGlylimNVq9UN9wrD/N7nzecIn0Aiu+6GpGoIb2DzG6wW3N9lgJ0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGaUp15l; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGaUp15l"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-559966a86caso589338e0c.2
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 06:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764943424; x=1765548224; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7Np6fhz8VpdJkgGpyaZ3JVH3EQhw+UG1brx4KqKltM=;
        b=gGaUp15luA9W+y8+hR+NurYT1YpIV27o2Kw6mOAojCIb00VzT95NezcO+87uO/xgYc
         pfnqL+/G3ldvgdXi72uF2jRBgaqKMk4qC1i6fm+l6paoX7/4Q0liNYEFFuFW3kSz56+D
         DtJLPStw2pyP2UgWInJf5L0jQi0XDhK/GBE84CTT3xu3bQCIZsIhmrx9ePzA1vjet7L4
         ufhpBjMppoL2kVGlUTBnsZAzxmk+qiM/MpuTeZHxQlsXHaLeQ8Zm9TU8przFUcTlLHio
         kMwKqBx6TRPFJFGATqirr6TwmGPMyET0ulEbXMjXEPbjX8aXgQLz9aR65ks7DPj/Jl+F
         eBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764943424; x=1765548224;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7Np6fhz8VpdJkgGpyaZ3JVH3EQhw+UG1brx4KqKltM=;
        b=u3EoxHtojRJDnaEvbX35Gwe7/71NPmg+sCDSwW1wSpcmweI1vpS0/lfpmWR3UwbE80
         ZAVThaiLtA0a6OEYw8pV9VQoQd86pEmSPPI6UcG2iFQ+xROgBMyDbJaLyplnTvQSppEl
         VFYQxhSA7HwQOFLlFQN7pCgALCPvwz6yhnURs6rZokN3UVSUyv2YfvXIr7haBcyxR/Q5
         5KVsnuX5gtKB9T80ZMKzrCotGVCiZgX6I1glbTJNOZypbNNlx7V8ltzP8HnUu+XYuMSW
         HTx7bzFdlO+0brj0CGJi37ANpcdwYk7JyygyhP1vESGhtVegTCvXoudITqpEQPYRLq1d
         k/LQ==
X-Gm-Message-State: AOJu0YwCRjJur6ZXXUggFIi+JXmXl9JbpHzMTSSK/H74vIuV0SLivn2O
	0lKIpBZ3OQvgDpRq62HGbl1TiXn/XuWaDfsRy4F4Q9MUsXp3wmcsUu/g
X-Gm-Gg: ASbGnctWVb0H8PzOiCJSHdk7ZaijVheS4fYPCXrfN36L6XDDsag15O5E1wQ7IIPGhBo
	qnd8Ni1/9VUv/yClKOlvuuhAN55JLrBBBmc1JY6UcDluH3HvsUCChD3L5+glzH4JrDzOMxK2BDx
	HVGs5fImhjkLPqaTrkzii9gsOHcWXttpF4kGF4LsBu7mlboVNXL4Fg/0dauwUKLXPGkxegrwo8x
	e4RJMln2pVZItBzzJDJiz2okxyJtuNHZQlA3Dfs5XCkbSeC6fhRe/DSi6KWYPG29tHFhrqZAOhz
	g8tjCyZLaREC3HwGLVrhYXEEFao98fGGJMx03nWMzp50TX57TFHQeRuTl3P8Zqkj4mHXGHMds2s
	NLc3B/hjqmh3yc/l0pw6r8q52aukYG25XwtANtXfEkwSKaFGADYa1cRU5PR23QrccFiCs3ADd4r
	fn6Bt8tDRF35bD4PHbEFmX1CPUp20cVVMCynF3kcWiWYSyX3dv+vWoTpY5ig==
X-Google-Smtp-Source: AGHT+IEBZRjaRl37gbsAPv6QrhL1JiNYzfVa+g0dicu31PYBz2VSo+eQ1rQBpM4nem3yVeynp7ebxA==
X-Received: by 2002:a05:6122:1d0b:b0:55b:305b:4e2d with SMTP id 71dfb90a1353d-55e6a17a757mr1917815e0c.20.1764943423689;
        Fri, 05 Dec 2025 06:03:43 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:32:8e1d:fd21:485e:424:7ca9])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c58d7c5sm2220081e0c.7.2025.12.05.06.03.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Dec 2025 06:03:43 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: Introduction and early interest - Ayush Jain
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAMQGJGT+BYams0dxXYd33A91hiONCSAoUiomv-2_XqOZidYSwA@mail.gmail.com>
Date: Fri, 5 Dec 2025 11:03:29 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D32EAEFC-6821-4883-9BAB-2DDB80033E91@gmail.com>
References: <CAMQGJGT+BYams0dxXYd33A91hiONCSAoUiomv-2_XqOZidYSwA@mail.gmail.com>
To: Ayush <by.ayushjain@gmail.com>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


> Hello Git Community,

Hi Ayush!

> I am currently setting up the build environment and tests, and will =
look to submit a small cleanup patch or documentation fix soon to get =
familiar with the workflow.

If you want a suggestion, take a look at the microprojects page.=
