Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4D29B8D0
	for <git@vger.kernel.org>; Mon, 11 May 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513896; cv=none; b=J02udJ4GUumvS1kBs+s+m4m+QKptgz5kC38dWnzT9hjifkqNLq4mZKpPq1XRnhESzwrWj5mNDe+8TQW1j4jf57bhsEnxAg9Irbix7RSukRKe91IHqATZ2k5ncu3000z8NgkW8nvgVc2PkuDz+Snn2lqxr3NwCoYscm1RgPWSjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513896; c=relaxed/simple;
	bh=yYnHWsPsFp2JG7dX2LQgGPretmooKYLtUlE48ShqISU=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 MIME-Version:Content-Type; b=aCe81nBi3Sx9zYzHGCFzD772fHxJgPErFRyBdGqRHKZXeBrlsiAFLOeo1AJg9aY2Q3Lfm7DBPKTbtUV9MYkwzcMU4iVEGHbQySf17WDEtzVsDzp7dAfwjonNOVPQIpMMlWyknzF8Z0y4wR/IqocPCnnaB1XDRFuqusjHeIOB9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=devthusiastcraft.com; spf=pass smtp.mailfrom=devthusiastcraft.com; dkim=pass (2048-bit key) header.d=devthusiastcraft.com header.i=@devthusiastcraft.com header.b=DAtPySHh; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=devthusiastcraft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devthusiastcraft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devthusiastcraft.com header.i=@devthusiastcraft.com header.b="DAtPySHh"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb5c9ba82bso651790485a.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devthusiastcraft.com; s=google; t=1778513894; x=1779118694; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:subject:to:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYnHWsPsFp2JG7dX2LQgGPretmooKYLtUlE48ShqISU=;
        b=DAtPySHhdBKm5AEU4u4OlirEg0AElPSAWdQ5BM51/C0eSWMljse2EMHLkFCGkb7uDn
         5diIeCJNYtQD2LSXuuEv6jz1b/S2gDK0L7eQmnr5YhEin0Fc7JnpW5hBz5+nf5ZiB1hS
         wdjMSQFTZf0hE3QRu1Rvc3hw65naOScGYJoZ71DTrRn+veHt5/Yy95r0cgO4ZF1Z2SuQ
         E4CjIC/Klh2xFHOhnKeSwbNAJTgufc2L1/IvjDVk1PXZY6/9QuCgO/iZna2CuoN82xaY
         KrVecr7bmlmglVRjXB96FeOXNuwDUcEJlweFxgTSUn7Va4Vj7Fn+gAwoZXMmwRHuuiTL
         0CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513894; x=1779118694;
        h=mime-version:date:content-transfer-encoding:subject:to:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYnHWsPsFp2JG7dX2LQgGPretmooKYLtUlE48ShqISU=;
        b=c4Y/1L2GzX7I2h0Cn+8WMvyKkAnDRqZZvEYv05o8WlZVJcTtwECwej/7zLtgPjq3NX
         twQ4AFsB2TjAOobL0omy+3zpv9jBZICxYGx4VgbskRwzj0PApWlP8iQ2ElNj0HUiGh7F
         kw7GU7UaKu0yaKZSamqbObLwwEjh9FqNi7l8WbwJSlH2bmqzplDcbrMZrQAiDn2CmDct
         6r8HdWWAxvxmyErgTf8opoYCUnHYOiozzm1WuDCeOXwgc1IBQtOV5n+lLXBEa5eFsKqA
         RkBi7pF3Aey4mQHSmRwAw3ZDbGMsev2LUPp5NGm0WgEJmnmB3Gm+vKbsCQfWaFHs0lgM
         TggA==
X-Gm-Message-State: AOJu0YwmKX6VG7lq32lIL/nfdG8AR7NO1Eo2aCY+ojh2r7Ye0ZQVLH+K
	8NwztAazvuxg5f4TXmwZQsBclSEk19pVFUtGkXMnWuNK9KHt3I9nAuyK0BkeBOTGRZtzKU9zsB4
	2cmHvJQ==
X-Gm-Gg: Acq92OGDCt5Jk25WuIuBL3EkIewykRbuwJNkas/fkot3V/6N2lAHToXuqiTh1fL0jTn
	fCF60R8Gt+lKLQcNKdtP0guCJzg/YRpkLLfqzWWuJmgSiwg7i1InFlr9Tvi9iIMwLTJp2HzT7zU
	68rMkCn8pnkUJz1wHuHuZAfi9+lli68+h/nweIsd5ZemJwbTbjzeIjGgCsBh63F+Fs6k4xEMRo4
	r5iY3gsTYx9QKcImBRrp7VPVwlUslpCVZ8bXoaeKX/QvRDC+Qwkv6aYdLVD5FjwlAiZRT041OLs
	zxcrnQXGY9QOTzApkxILgYtrwwXZb7FrnAnDgHPm1OPt9xR/aSlT9qhnYqdYXU6W5K+F4u6QwJ9
	+4xxVa20g8ZD0Ks1+5+E3IxeKTBif+POdCAsyJ7saT+Z/If1Q52/E1k/rgAEaAops8Yhy/gQwYw
	DA4mZkQoWbbdiTTWnxvkTR8vfwx3baivQU2UtbYcyFjmiqO4kPhEvqGEXY8hGZG2Kl2pb4B9x3p
	j6fe3DzVDVuCN6O/5MsSsbT/vzh3K/klsH8UC+Dqyuv1jIXqfVXW1p7
X-Received: by 2002:a05:620a:17a1:b0:909:43e6:5cf4 with SMTP id af79cd13be357-90943e65d55mr1432429985a.43.1778513894001;
        Mon, 11 May 2026 08:38:14 -0700 (PDT)
Received: from 019e17ab-b10a-76b6-94c9-c5f0241eb112.local (ec2-100-53-208-62.compute-1.amazonaws.com. [100.53.208.62])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm3383473285a.36.2026.05.11.08.38.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:38:13 -0700 (PDT)
Message-ID: <019e17ab-b10a-76b6-94c9-c5f0241eb112@devthusiastcraft.com>
In-Reply-To: <019e0d05-2060-7b52-8a61-cce41dbc2e52@devthusiastcraft.com>
References: <019e0d05-2060-7b52-8a61-cce41dbc2e52@devthusiastcraft.com>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/019e17ab-b10a-76b6-94c9-c5f0241eb112
From: Sarah J <sarah.j@devthusiastcraft.com>
To: git@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_No=C3=B4men=3A_Gifted_Invite_Enclo?=
 =?UTF-8?Q?sed_=28Github_Community_Partnership=29?=
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 15:38:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

No=C3=B4men, just checking if you saw my previous email.

Your GitHub profile was selected for a free lifetime membership to =
Devthusiast (normally $1,800/year).

If you want to join the newsletter, =
just reply =E2=80=9Cyes.=E2=80=9D

Otherwise we=E2=80=99ll pass the spot to=
 another engineer in 7 days.

All the best,
Team @ Devthusiast

On Sat, May 9, 2026 1:55 PM, Sarah J <sarah.j@devthusiastcraft.com>
[sarah.j@devthusiastcraft.com]> wrote:

> Hey No=C3=B4men
>=20
> Annually, we pick engineers from Github, and your GitHub profile =
https://github.com/bnhassin was selected this year.
>=20
> You're officially invited to a lifetime membership to devthusiast, our =
email newsletter for tech founders that love to tinker. And because we =
selected your profile, it's completely free for you.
>=20
> Some of what you can expect to find in our daily newsletter:
>=20
> - Latest in AI: Latest AI news from our inside sources at OpenAI, =
Anthropic and Google
> - VC Radar: The latest tech funding news, before =
they come out on Tech Crunch
> - AI Wars, Model Power Rankings: =
Today=E2=80=99s leaderboard of the top AI models
> - Tinker of the Week: =
One useful open-source tool that is flying under the radar
>=20
> Please respond with =E2=80=9Cyes=E2=80=9D to acknowledge receipt of this =
message, or we will have to choose a different profile. Once confirmed you =
will get your first newsletter edition!
>=20
> Welcome,
> Team @ Devthusiast
>
