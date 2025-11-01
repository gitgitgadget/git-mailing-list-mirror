Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E5199939
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762010199; cv=none; b=piRsjCQnULm4DnNwviDCkS3mqGhtQ+ocHQchEDiB7VW8nvvKFwdpj3RfRiytys+PcTsUcZ70+62h5Ep/Gcw4zumINWF25moNC59OXGtNs4Ad2oY+PC41C4o1I6YMOvgKSoE9bsqFfXrAfYMXEwGqQPxJWDVgjRrgWzStcsIiUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762010199; c=relaxed/simple;
	bh=n74+Q8lNeBC/Cp27XpX+RycKWhegnV+urvP3STv7zEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCBwqprRXktwMFrHxN48STBfJpadFFZuPO1fACbq8OwMIMOh+XxFGiooN/r1OKXgulv9NIIDFiEBcAFauaaS3o7s4z/gOs8LKLQSZNgPZG38/1R5Xw8clnIxKVDTwO/VU7Lthi8Xpg1BLyAyLsgpLGs/l8DdG753d1ER1dL8kpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWHW5MAz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWHW5MAz"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso843781366b.0
        for <git@vger.kernel.org>; Sat, 01 Nov 2025 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762010196; x=1762614996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jDX8GsnSh83mszYDnp87zyJQslztXFURp/PIJE1zbU=;
        b=aWHW5MAzakaVYFJ15AODy96yWPE1/z5ZLgu7q3Y/O1S7qr79L5kVk8sYkK2MwFRh63
         V0PYJotzSlCsMfDncGCTjDpG3VK+z1x9ItiDWCVX3NlpR4KfKkMWw0io3gOU542aB2RK
         m7vgNYnvc/JOIAIoYStAv7+WfkCAMHsW9cOXrPTeS/wmJthiwDoef2eaSswpCW12wCaf
         /Y8uSSHW3b3F4yjhc9a7MX6TO4MEKw+nX7GdV+nzw0Pc9QJb/yEE/VGUg+cyB/MaQuqr
         M6/IZ/jRBGjht646Bp1SoKStJHECHhM1FB8kAmFkZn4n20nbvDuH/jh7AboS1n9MJVFh
         VFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762010196; x=1762614996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jDX8GsnSh83mszYDnp87zyJQslztXFURp/PIJE1zbU=;
        b=e/RsCo/0BMA2tEAVOn+5c/uzGLuqGlbY+hbhnromMGbB9j8HgXnZmtGYm/KW7KB38+
         WuN3uXkxpM9o1+PU/N88JO7Yeip8N7DQBEUYj3OSu5DVK5AFoIdPU8YuMHsclKTIv8/k
         gqWs4i7/Cn2dmP4J2AyL27qV9rzy0TtkqcYS/kPSAEi9jYl9xKejZCbvsBKnvfw0y5JF
         x8XMeofANCQBQP2h/IjmJIt3R97hIPoXEGXIVrqdqrlTx00JksBfyHLZRENNeetDVdMO
         rDOHCwFvVr64DJJJd6DwAB2/McOz5PeaQTD0MfPeMmrQUxaFG1mdMY2Tsb0LiovSl/cO
         L3Kw==
X-Gm-Message-State: AOJu0YzwAX6JOhEJaTzecvQWaLbEbbrgGIRJlQGFoQqcbsDZePVUiAg8
	sf67iaYBhX5q0KzeitO1UqQC7TqwP1tzphxgZ6YicVwuIezLd11CjtLP1MYDQ0prOYRwAKtnO8i
	u20JV++15CenDpJgD8UbSNmDSzepgdGE=
X-Gm-Gg: ASbGncuE/yw6o6kTH6w5QbMYk86OJ2/O6vMhi5EeJeRn69nTpl9m7PlE5x5x3q0hA8W
	7cZHRTdKVIGR6Czck9vG97UBYzhM4MumDS2R/midDtgv7twD6MeAD7cgDyE5y0dsAIFXcRlETf7
	VljZpp+UV/I0TlOWupPDyVmOQzxBv/WIvHViNhFKCpyhQnN4vs1JVMU85+1O6wW1ZAQARRqdzSm
	exGZFaKj/7rqX9nqbFW6t6Yzm5IfR1eH6DKzrAhnztuov6DCthJCbRCJW1jfnOhbVGHwkE=
X-Google-Smtp-Source: AGHT+IHu/aQsmKVraxOxqkgShvUV6XhMSGCx02ZcVU8f6b5Bmv2MwaRmB4WeRNHQnQQlb5855/wDSSn8YomRlsCqcW0=
X-Received: by 2002:a17:907:1b24:b0:b6d:3e23:b68f with SMTP id
 a640c23a62f3a-b706e07b096mr928823166b.0.1762010196004; Sat, 01 Nov 2025
 08:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028081232.3068147-1-christian.couder@gmail.com>
 <20251030123332.3337684-1-christian.couder@gmail.com> <CABPp-BG_PhbFOS-Tre249nzMyc5YGK1yHMVgo8XGMq7Y4LewWw@mail.gmail.com>
In-Reply-To: <CABPp-BG_PhbFOS-Tre249nzMyc5YGK1yHMVgo8XGMq7Y4LewWw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 1 Nov 2025 16:16:24 +0100
X-Gm-Features: AWmQ_bkLYEF6O2859LQvF-yjqFcLqelel9I42DqT-WCPAk9XUJGtxzdtyBeLExM
Message-ID: <CAP8UFD0ZV56pRtOBUT-d7=n_Eyu0Pbzy3+i7v_p=OrqRMB6zYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] fast-export/import: cleanups and translation
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:37=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:

> These all look like simple sensible fixes to me.  The only problem I
> found looking over the patch is that you undersell the benefits of one
> of the changes in the commit message, but that's not even really a
> problem.
>
> Series looks good to me.

Thanks for your review!
