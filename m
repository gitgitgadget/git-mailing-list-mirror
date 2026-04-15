Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537213CAE95
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275433; cv=none; b=WGXZJsb45I1nuHr+N2O88fB4fZnCaqUpHc5EGifdggI1v3yrvqKGJh4b2OeEbDV5ZH/M/yGqcZG6iNSIVctOBMpiRjbpKpbi5zFEzxapSBQ4Uuw93WVjnMvL+vMDaaDw0adridy68eZNrChILcOJ2JDrmWH1tGpWrJKeVZOgbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275433; c=relaxed/simple;
	bh=TwR+Cd0168n2BDdXkaygseJMrmbQeShTYPdC7eM370M=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=aUCY9ynrFnzOg3/gGb+UyEcuqpVWWmkKYbzGnRqZ9G62vgfFqgsH7ERJSn2m7NO/1RK6Z28tmxaaZX9grSSiEgVhgywhjFtzSHCDFA2qj/4L5hK7U57VWyH+bYOq7IrYzLLzHlqnoYiIjvwk5ZHoep4TKddHyG+xfD0Js4VJefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXpOorZN; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXpOorZN"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-651bc8f864fso2907628d50.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776275431; x=1776880231; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwR+Cd0168n2BDdXkaygseJMrmbQeShTYPdC7eM370M=;
        b=NXpOorZNZ/Ycm3+BmQaKlfLvhQTnJ6fQqDYUxlMnvmEO+qqRT6bNW7hbG23IGcywqw
         c1/I7Gsipv6B+atncFb6tO7ieABf/jysCULAQ9CMX+zfTUW/4cWbhCPZhPhA7W3w128z
         CWvoCnulyUUKN4cTKBEIGUkoMv1V3hvHLHvWUWWfBbNHNLQwdiHACTDkJR+vOBcFwGGL
         vo1c2myreVtVedlsgcf5RA9nJSyisa/l6JLcuna+0WTMgOgS69gQG5UONZUGBzkTIfmL
         JqFPCkjlEPGxFwnlF0HUEAJBjX2pPmPDX/B2O134JknupLf7LK9tdN3bcl2IKAa2XKJQ
         FFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776275431; x=1776880231;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TwR+Cd0168n2BDdXkaygseJMrmbQeShTYPdC7eM370M=;
        b=hiJBW0v5Te6PSInx+yg7KwF13W9um83byyscQ+9rCAo7IdJuQPXu3O6g6hJl7AOdcY
         iecDAJJ/7COXxGp2n0p6rsaacKkJyzAPParEGZJrIFYlKTxTLJVB8qHkrUkAgK0YzICa
         WNDh4MVWHn/sJTWsvM6+QPr0koSSDiIPTvEOhTfm8rOJG+KMsx0Zi02gRCfGDMkEIjZT
         S+k39oej/aP7hxnWTv1ua20m7c/vYR4qP1qSFeTA73ve5/M8U5i4LoEsZWCVCbJ5twlv
         KvxR3WhDbLi35Ic+1ta1ISAky8QUpN2w2X5PEuev90C8JWn2C3RAKRbA7XLeCdgI2LTZ
         k9AA==
X-Gm-Message-State: AOJu0YyWv/DVoRIHenBxwZRf6s66lOu2+rB3EGyxk27PFvqGw4ypdsdi
	SZ8CB0nEcRMjzDWZo55cVQvkby/do3fT8MAD743uHe5CqsKtUMuHUb44
X-Gm-Gg: AeBDiet7ycp7f774Gut88GgPiGzTSeA9O2WMFd1rHkELI8CWLjCde0o15kxki4UJ3Rm
	q7r4cxou9PwgIlEMGxmD3htQhAtfx0xNO+JJTQJK0eUiqgq/kkbSbrNUcxZfhs5aFrlF1Yp0y1s
	RfwrWwW2cybj0++U1f7BwHzZpjBAzYRU0nagi36ymJJunlBHa5g4YShUOPUz9qIeh1P3JsCjJ3b
	w8XkNcd5+KAbKZSmEMFe1YOBGY6N21ZDjNHZItly8Y26wFIhXPlIliLwlkaOm7QQY6Ts32RMCS1
	yyLWrUyr1U+r/xnEMmDGjb1sPaS5EfmN81CjFc9i/qu/3fAdRAxtDaS4pu1UWg8Hz2PB7XQzLWK
	xm6p9EWkOLq0GCOq8/olR+sucjQ8SC7UktJfU1jfMhUspc19Eva9Xz+Y1X1JAyOtgugNoytlKQs
	C/Oa6LJ4Fx4s/ktNKFhw+s6TYmfdEefSt4QphOS2OSW6oIWE4hIb2xzrj7UUxL0bRgOFoSIGK1S
	v4BXfLelNmwJn794Da4NxMFmAhBBJ4/qGEhjb+B/T7Twh4XCPi677Lz2/SipzpO
X-Received: by 2002:a53:edc4:0:b0:650:17fe:1a9c with SMTP id 956f58d0204a3-65198b73110mr16492666d50.33.1776275431319;
        Wed, 15 Apr 2026 10:50:31 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:97:2f3d:46f9:d043])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-652e47d3c41sm1032113d50.19.2026.04.15.10.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:50:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v15 00/13] fsmonitor: implement filesystem change listener for Linux
Date: Wed, 15 Apr 2026 13:50:19 -0400
Message-Id: <487628C4-596C-4870-A652-E1670C700AD7@gmail.com>
References: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Paul Tarjan <paul@paultarjan.com>,
 =?utf-8?Q?G=C3=A1bor_SZEDER?= <szeder.dev@gmail.com>,
 Jeff King <peff@peff.net>, Paul Tarjan <github@paulisageek.com>,
 Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 15 avr. 2026 =C3=A0 09:27, Paul Tarjan via GitGitGadget <gitgitgadget@g=
mail.com> a =C3=A9crit :
>=20
> =EF=BB=BFThis series implements the built-in fsmonitor daemon for Linux us=
ing the
> inotify API, bringing it to feature parity with the existing Windows and
> macOS implementations. It also fixes two memory leaks in the
> platform-independent daemon code and deduplicates the IPC and settings log=
ic
> that is now shared between macOS and Linux.

Troubleshooting a Gentoo build failure of next has me pretty convinced this t=
opic is in there already. Junio should probably check my math, but I think t=
hat means we want to see fixes on top of that base now (unless we are revert=
ing this topic from next and queuing a new version?).

(The failure is a Gentoo-ism; we carry a patch that stops applying with this=
 series. Not anything this project needs to worry about.)=
