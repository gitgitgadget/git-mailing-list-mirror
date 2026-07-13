Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0D35AC03
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981072; cv=none; b=tn7t/Iyr2PqtHHcSUPMvNNKyzwpihTP8UACTTpeUTtP3ix8h/qgiT2ZlM9iEgNLRwGuKREC+qQuPMMtMqmqaXL1PKaUyzXUSFJJSuPL+XdomxoNRBWgHo5YRVAUSwa9nOE+/vZ8qq1Syx8er4pi/m7EXqtZCtYSpddJr9x7kKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981072; c=relaxed/simple;
	bh=gh/+L6PchYJ7xMsy+bVDXeLeFIlWDaNeI/y8jP9ed2A=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=gaudqpPKMUAwJcvBszq9mzhiMwsRxaBAC3kQ01OPXEJhx1DHEhnna5jeEqhGLiBT7DaDScO806zvx3QbLtkggsR9QOkFPSfREsJGc11/kGL6EVp+Ebe3/HyWLq+XBjHjmUL9CLERTUSrlbue9Dte9Wr1pcgDdsprmXUKm2BVXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZGqNGqz; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZGqNGqz"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dbcb505578so3942707b3.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783981070; x=1784585870; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gh/+L6PchYJ7xMsy+bVDXeLeFIlWDaNeI/y8jP9ed2A=;
        b=DZGqNGqzFfac3kPMIqzON33PrJ60U5X93KtyIlhBpx9CTXwyBYR43WUmSLJ5yVjUcO
         gEgdhFUgt9rsuJkwGWffcivun0roXckAZKho4WL5ab9/N+vmhtWdmDoym2/TlhUDRutw
         XPNcjwYajKTIO9CR4iwa3rKT1gYBpkAhzlMwzER8qjP6jPudI2pv9oMp/WNkwsWBoy+G
         TWihz1QLk9SZl9GYTfjVBZ3T8ZIuVdJ3dIfely0vKzb/SYuq1Ky6jzYW77Oujt5s9LSJ
         A8hD36iVuGWhIC1fEW4mfCV4HG11EnHhhz04Z92OrpK9SPgbwNqPNiV6j3E2eCvW5J1/
         Vn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783981070; x=1784585870;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gh/+L6PchYJ7xMsy+bVDXeLeFIlWDaNeI/y8jP9ed2A=;
        b=n4LX5EBjqDqfCB6BYJYg4mBwwgLBv0XQdcihOsypH+yJAbp5Bpia6ASP2/+4Y1IYHr
         QZR2oSpCo/+f75qBVcowXcu8vFQeout8bzDDkQOtYMAP9PuOtWGkIbSr8HAumLGcVxTg
         omJzDKqdjUYyeAbMyMmuiGoiFzORjJ0BSDy7YkxMyrkFVkfKG2bo27Xg0xu/vHr14pfC
         pSd0rOF2TgL4ADjGFLN7CqduTpCqG4JBL5x/pl8gK66d5uqPXDu1eTuuaGRRlbasQWQf
         X0kj+MW3V8BVSPtV9Ixei1YPqFsKZPLiQrKwbUYUqk3JPsB8L5UfXoHnf24kEnaGszCt
         zWAg==
X-Forwarded-Encrypted: i=1; AHgh+RqyF9DmFh/sHHkEh2APWfUNMSyS+g86FFBdMH2ZDqD7ukwkB/RAFccpq5Z6ZGCtWO5RJI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh47YydA91r2WZX3k6JWgbSf9aSK0Z2snf25jwz7zXYL6mm0wx
	nFAr85GvuxBB/e0Y6xBNpj70dMzBGKM31CrBpGeZ4JKJiTApyFeC+fMN
X-Gm-Gg: AfdE7cmXyzQs/kjNC8U4U4Hhp75cBOV6ySZECk5qpuWMRBiwHqQw/adMEokQ22J3JaB
	s0NosomnJGM3T5uPvt5BQgAIPlmYQsgg9OiKJ88VLvJVrWQfTynHXPZ+a7Cln/C3828S5x5LC5P
	N4dgWm3NRISmYqGFjBPy8kwTY5wAf0BK80rtty14cAVLUVRcVELuoqAHE+jIh9PyCQzDqNIZsfa
	3zPGlotB+4nKnQEYJBtgMaJE73S/3L+n/vm4MVK1MIRC1EBmaNLLFOdr7XGGZvK5yBVomwUKUrN
	mWqkMVyzMa7GrRBpOKvz8BLb6LzKpc6cVSkaApxM9W4NM3Hd+uCERSc3ib8pFTZ9BZKTExL/BIZ
	qmf5OWjl/dKlHFQXWJd+ss/Vaqb5UdnR+V3p/7KL4praI1ChV+ovkG5sCH5i+D5F1at/TGBB356
	nOLlqCWZv0mcyefw6Lr3KVf1LAgiqZKRLnyOBKDor8+vYO1goHeqp5iFXwY0OnG6pfQryfL+/0u
	/3n0M7Xc70SVfKJF2fsGYNF2SqQhWSNvmd8xRFNcl8tEAN4+rXL2gk35ZF3s4lTIQ==
X-Received: by 2002:a05:690c:e152:10b0:81e:bba7:30f6 with SMTP id 00721157ae682-81ebba73673mr6194627b3.64.1783981070308;
        Mon, 13 Jul 2026 15:17:50 -0700 (PDT)
Received: from smtpclient.apple ([2601:740:8400:2ae8:c430:b8cd:4a51:dc5c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ebe67d857sm2032387b3.28.2026.07.13.15.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:17:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Date: Mon, 13 Jul 2026 18:17:39 -0400
Message-Id: <45F2C180-1DE1-4371-869B-BF605B64E01A@gmail.com>
References: <xmqqa4rx9mb5.fsf@gitster.g>
Cc: Patrick Steinhardt <ps@pks.im>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>, Jeff King <peff@peff.net>,
 git@vger.kernel.org, brian m carlson <sandals@crustytoothpaste.net>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqa4rx9mb5.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 11 juil. 2026 =C3=A0 18:46, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFPatrick Steinhardt <ps@pks.im> writes:
>=20
>> I don't think we'd necessarily need a way to detect this. Our current
>> build default is to have this disabled, so I'd keep it this way, but
>> automatically compile nsec-support into Git if available. And then we
>> provide a way for users to opt-in to the new behaviour via the config.
>>=20
>> An automated test would of course be nice to have so that we know to
>> enable this in cases where we can determine that it works. But with the
>> above we'd already make the feature more accessible than it currently
>> is, because I'd expect that most distros simply don't enable the build
>> toggle at all.
>=20
> In any case, the discussion tells me that if we were to pursue this
> topic further, it would not primarily be about adding the build knob
> to meson.build file, but rather a bit more involved to affect the
> product for everybody regardless of the build framework used.
>=20
> So I think it is safe for me discard this topic from my tree for
> now, with an invitation to resurrect it as a topic with shifted
> focus.
>=20
> Thanks.

Yep, I=E2=80=99d been meaning to send a =C2=AB please discard =C2=BB message=
 per the new guidelines ;) been on vacation.=20=
