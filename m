Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040DD2DC32A
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393288; cv=none; b=pvsrKsgkz7rJPoEyhh7BnzwZtTYdT7JNuhCO/EzWLnnxiDklnWTZQ4XMQSZWzEzsO6LRDLR7RBSl9XXGNcDD5VzLwApamJ7inCS72gFzGR4OysbcnUdl4kB68ZUkV1KzdsHiaKxzRM1RAAI8YN4258zzqMOCbe93DT9kcVe+zys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393288; c=relaxed/simple;
	bh=/pWxhWoua5OxCLKlpc/s0g/ZuV1NfckuiWj5w04PdYk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=RjwN8jCz/BJOf/oLw/hpk20hxbEmYHvgjuO/MfYZtBBC96pSMjnRXZ+kVubGW44JNbQMdPKFtxCclPie9PBQruwFLveycPEjUcvEZFWpj3wy7VoNHBbqVOuPFx4C4vBfbuE+SmxOQHOevksglCm+ifYlcyPAuwrSxJGbvSvgle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wy4G+DTO; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy4G+DTO"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7947cf097c1so8603037b3.2
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 07:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770393287; x=1770998087; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pWxhWoua5OxCLKlpc/s0g/ZuV1NfckuiWj5w04PdYk=;
        b=Wy4G+DTOmoLK6DSwdAezeUTY4Ckxdl88VlbBtYQRiMQKfBC+JCTqVEhV+hEN6OzEFl
         n8/lnTwxaF4ksgvQI4gMehlptHnxq/+mpg/6vnZd2b9VXxaNK9q1zFd0ZZKPLwB2zdFW
         YCl5xpmGpHF8i/o0Nog0urePbd+d9x2lIMZDJsWKu0ETuWYjT8m9oeFeNmM6LArcc89c
         7PHAkvQqPCL3YHyU5lMh/xq1TzjuTMyhM2vpHrY4FqFUlVRXjkEjTStLSJijO2+5PJJq
         1CigfMetwgPB3cI7yBRxShLZ6swM+SaYidteQpOPKCS1rzpnmmBQIVhrJrFq22/3UA+F
         BmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393287; x=1770998087;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/pWxhWoua5OxCLKlpc/s0g/ZuV1NfckuiWj5w04PdYk=;
        b=H+eb0od+Ub+4tp89EkhFXyP4a7jqz4BKPPBzxdYPtloz7ncJT8adGmxMrdsHmk6fD7
         hwU8WKLT71R+NoAhZz5ZrR3m7XkmREP6K9Km4T1WlkGu7FXzSfXgdT5/lhXB63QM1n6e
         rzbhv6B8sMSrMXZgH6xWmK67VMUBXssO2NUgbaNLFkAEeDgT8I4o2MnPUzk+A+Q7mukp
         djvZ7MAwRmxlOUqOSCa3Z60zMl5b8D2uzmEDHzhIa1aIdRb+fs9lOuV/ANon8pPbHoE/
         qOGl5a+9NesIBCvyoxKVFUNOoSN8BOLuOJxm1fa4HewUYEwqdlsZc1PxJy3OcRG6Ci3m
         8mgA==
X-Gm-Message-State: AOJu0Yzk/+bi8FL+xMrnMOfRQiT1Kfor+iQnz4PUSvQQoYDZGOQOSAM+
	+Khfc3Pq9G+REt2cIOv7ey6WiRtcg5LhJSB17fwYhIeKjQp7Mf4l/l+rN39eaA==
X-Gm-Gg: AZuq6aJiAY/Ijvb5PI0f4NQ/4/+SYJX1HgkBi8DqQSoyIj1VPZKrUpXjJgJUM0T+PUB
	3jMRdIlHsfK75GZwIpBO9BMb2JPNIjNm2zaM2Vh5H6o64KAoTWfCabsNqDLRBCiiru/2hEM2HYQ
	5YApMZzJkvBg3H59QWS4sxAmu+UQBaIIY5jRY6LiUwreWUSHI0+SNxcBc1f1a6sb1aijULDxDwX
	XU741cOi7VpMdo9YfVMnCyb8hL8/ZvDlX9VJinJEdZXD+GSKNFBD5mIysn2GjKyC0V86oEKZ6ql
	VQO/GvDsnHKI1LpBn7Mq+ftIKJCj3u9i1DX01LUVYd4PR5Y6IHMDL+UpGY5AuHIPS5FCr6uG5WA
	NZQL/IFDrePHCjveG8wGIeoXvTpr0uLEAtMWKzaj89TcFdHld/CDZTDNX5jWjybuIAjHjebXDdx
	xfU06PkaYkgOp5o7Jk1CZ4jVLv9GTGvInibZjjtF3BlurFgZobKio/iYw0ZbUk9hVRsCiODHGyZ
	ab2TO7YoDnr4Bu9n1/88uqSi9OtzA5ZPhA3GJ2GhbM0/tm0zUHp21Lq+x5C5NqjylwI
X-Received: by 2002:a05:690c:9b01:b0:794:c6fa:156e with SMTP id 00721157ae682-7952ab4fb4bmr27534487b3.56.1770393286559;
        Fri, 06 Feb 2026 07:54:46 -0800 (PST)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a28a62bsm24088827b3.51.2026.02.06.07.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:54:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] global: constify some pointers that are not written to
Date: Fri, 6 Feb 2026 10:54:35 -0500
Message-Id: <BC960E5D-2958-4680-A003-21BC24B8C5E1@gmail.com>
References: <a53fd33b5696487f941faace90f51153555ce8f4.1770342268.git.collin.funk1@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <a53fd33b5696487f941faace90f51153555ce8f4.1770342268.git.collin.funk1@gmail.com>
To: Collin Funk <collin.funk1@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 5 f=C3=A9vr. 2026 =C3=A0 20:50, Collin Funk <collin.funk1@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFThis v2 just moves the unrelated change mentioned in review to a
> separate patch.
>=20
> -- 8< --
>=20
> The recent glibc 2.43 release had the following change listed in its
> NEWS file:

[snip]

You can also put notes after the (first) triple-dash in the patch itself :)=
