Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F34346799
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770070600; cv=none; b=Hpqnyuwe80wVNkbdQOA9/YPtfM1PXXl4RvSRbBQRkaJ3ifsXJ3YHsXoMGYb6yQNnyUsYOdsS1tO/x/e5QuFsuz2p2ocXyAwF96BGTSIn3TG7rR/RouEkydURB9yQIaLytw5NeGJ01C7vIyVjHMG1Mp/HJCSf3URusTgAIfb4OG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770070600; c=relaxed/simple;
	bh=KXJQHcMFOl2DhycAD+RVHCNC+YVhAdMErxzs0/0L33g=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Fq0WN2uCqupXwAkaMYfgP84t8OThUlaDsASHV9yJkXVQyLVRwi7LPcnv02+V/+O/pdSm56hvGMsY1Y+bnKQwgqtrCsozT+zR8OzFARS0g9Pfwk5a2oIL+eRn6gWYxBbBdjKennfEoYzvFiI8zCcj6LfbAfbkMhnJlBRcOB0eJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUYfgo3z; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUYfgo3z"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78fc4425b6bso43865017b3.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770070598; x=1770675398; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykPYhmKzmlkqgC7FTuKYa3wzcpsOoCJKPBw8l/25NLY=;
        b=bUYfgo3zKLz1m3jikJadeoM/baKoloYiZV8Axe5rNfFVB9ViSBkLqDLYnHbhyVOQj5
         VGLl+NCiQTrZWmz+oGlidIY+5bfL+TwCoLQHasDj+e02bQnHtFjYzyqDx0+9Ya1U2Hye
         ETnqNwEl6XJCoueH4Ci3J8d2KNiE8TzfJnCQL5FHrUNwBLFJu6SB1OyU/HIR4swKiV3O
         usb9Wij2/Rsanl8eO+h6NnbJHwQdG8f86N4N0R+4W1U2l8zRfHr+96xnhl0sa4XC8gog
         pMJ9y2E+TTfMFchFqQe2EWW4Fykxumxbn/rY0/ZNBQ1frBLph/bRdvbkmBbluhzFW6yP
         FcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770070598; x=1770675398;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ykPYhmKzmlkqgC7FTuKYa3wzcpsOoCJKPBw8l/25NLY=;
        b=ixskkgLNgVtUxskz7dn41ZKgUN3x86Kzs4la8/BYnVTTuek/V2B0daMGqW6LbwIbZT
         ogbFHMW18+O5wx7n/eNSgpSjuH4SxOl0Fw0ZuPa9eWuFKuNbSZKB3/Y+o6woh1GBRq69
         pvleolZJ3cwX14udpvMpbWDNF7xq4bS34ALPsVgFRIwtIInYN5V+3nQb2WTL3q7ipFri
         sbjO2iXXW+4721rTTkwZjmMNXpALmMIWp2bh2KFuJSLjQ/SNNJ1BbYThYDFlkvS1eAwj
         7PG4zELbfGWP1i2BZK+6/XH/sZyxhdo/qYHGMcX2mJq7ly/QZj2sGnidrAKqdCLEeoeX
         4rQg==
X-Forwarded-Encrypted: i=1; AJvYcCVrO0VMz5o9kPioVZQGtLMTps8mOO5ZdWyyVbu18pJ6P7dffDPTWmvyxoH4TB+sTtKtCM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwFTBu6Z0i+Csgwm79jKJ+M2HGpSRYV7bS7YGQYjpTX4tfCHs
	dxiAg1DCYmTCXX7tbkrIohHS3TMmaaOSd1mdQa6nl+SaMAdhWjn9lM8U
X-Gm-Gg: AZuq6aK6gxnOvQA6jafJvyYGsaz29/Mg7YjOAKIvQGn//ADZCB4GGvbswQ3CcnE1PTQ
	vwBOWNwsXU/CgkVd0quFd54yJCq7i/eU9varHIsJzr2vefOhDReku1s8eMX5tjuSeqvthmwo/dE
	04ft14oPEL098UsAx2Jex268zJPXCl7msmtKMWr8K/Bn7xqkZXm4G3QYfixnuwAlK2KpichUF82
	7rrrHfRsGU3LOrnU8jAAc4KUXkMVVEunoCRTbWupW2p6vrwRkcbdeGWoMPyIDord5AaY67S64yH
	SWkxgXuLLYDdLHBP63MmaiOzQEKuj3Ela3a38vkRK3MglsesuwQ61CyiTkvrcbcxAWrRG0ZHdng
	9TtUsI4LQ2h1zsmQQeB6946OqggcEdJOLwqEK/wH9d5FXeiZJcpBGS1uBlWeGzFp2yBBKC+VV0L
	vVA7lLXLlTAAF5m76PqijUky/Xn7QbYU5VlwxUmL5Z4KkxYmUD02Prpx0bIBog8DQwI/9dbpWFa
	VPUjfdRemk1GCIp3hi/kXbQo+je
X-Received: by 2002:a05:690c:630e:b0:794:baaa:cca3 with SMTP id 00721157ae682-794baaad0dbmr67700577b3.16.1770070597997;
        Mon, 02 Feb 2026 14:16:37 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:c4d5:7951:15da:10b5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794cd7241c0sm42567867b3.24.2026.02.02.14.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 14:16:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Mon, 2 Feb 2026 17:16:26 -0500
Message-Id: <4EAD764C-5FCD-4934-BC39-5BF66C723C32@gmail.com>
References: <xmqqa4xqygns.fsf@gitster.g>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood123@gmail.com,
 git@vger.kernel.org, gitgitgadget@gmail.com, phillip.wood@dunelm.org.uk
In-Reply-To: <xmqqa4xqygns.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 2 f=C3=A9vr. 2026 =C3=A0 16:33, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble@gmail.com> writes:
>=20
>> If you don't need to be on a branch, then "git switch -d origin" (or
>> upstream, or whatever your remote is) should work just fine.
>>=20
>> That just makes discovering the name of the remote the "interesting" part=
=E2=80=A6
>=20
> The only thing that is different is if you need to _name_ a branch,
> or the commit pointed at is sufficient.  In order to run something
> like "git shortlog origin..", "git shortlog @{default}.." is not
> needed.
>=20
> Of course, checking out and to be on the branch requires you to name
> a branch (otherwise when two branches point at the same commit, you
> cannot tell which one you want to check out)

I oversimplified; thanks.=
