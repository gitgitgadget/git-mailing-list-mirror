Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB02E3703
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552580; cv=none; b=SX0LxxZtA6Z6kfJjcuM9OzQTH9NO6Q8hWig7NUWEbmPJBkn0Es/MCFFtRGFBa6feYmspJpVuE1Afg/dP2+B2YFpDDbEF4cimQKFxrfw8rkLY4ASk0KcDIDaMzy0geOg4q9mEC+wysezJfdIhrTPk7+nXx9BkphjOCEDL6W/ASw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552580; c=relaxed/simple;
	bh=LKC9GsmRNl2tbQpByvdTWu1hYLcFXof4M7PgOGMUdVo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QfNSThPYAyrpVXbYKTBObujNmEV3xk9esVFh/8W7HQ+R6NqykKYtzZ2+tIfkLykq2jA+meJz5fGWox9f7d39RUOTiozd2BZnTcltJ6s6S3Zi+oLXUhJYTMIrH+3Pn5XOzMcjfPzLHZIcrq1NcqYNfjjjDj7eFRhB6Up2jXLCc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMfWnJWQ; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMfWnJWQ"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-748d982e97cso4269340b3a.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 21:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752552576; x=1753157376; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96S/wXHuBwcq6ycCoENeSF9F6lsCeBoU6seLk7oPVfQ=;
        b=fMfWnJWQEz/HDOxNfSxAUGeEeoHwROtyeLpVJeTBZrOFBg9Wutf/uG7ZdPowf0W3ny
         Mt3+Y86mLRj182pSWfh1Qj1FvxWoc9ELkVpF9yBlcMO2koZAjol9+7a+WdHDjG7sETZ6
         aI2xbaYJv7CwveP5qwE5BVEwvSoP9bDCC1nTDoQJiwtkh5bcf2ccAxXGta4/8NnCID0y
         HXwlMAYZlrtdYVzWRwc2O2jdnskpq0gSQc9PZ1ubGvb2JoqsHe4KE5FtnaPgNk1DLmrD
         YU/MSWRyoHk5T1D2047RfwjZZT5hghmk3dXE4I3aVUuDXiSLpU7aksrC6+aTqPOEnhrP
         B8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752552576; x=1753157376;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96S/wXHuBwcq6ycCoENeSF9F6lsCeBoU6seLk7oPVfQ=;
        b=ZT277439Gaxzi5GlYS8EG/DSGCpTGlhamvgfm1byS40vyfe3J2oNDLnci7oE21TAdN
         xs7xreHA7Cydv8bT53YlkOYVWx1ZScGwG0j6IUz7hij1I5BaWJcSso716VyZtGfvXZtE
         dhxhhioNKC5XUOH3glnX6cnG6140Ztsfj4B1xl5tT4QcSsoqTx9UCQokcETFlyR1zMhS
         Zl8Mo4SLVgkOs+13LmGF58NnX0eX0//fQRFReVpB1lnoQYBOyjH1/Pbuil3LkpeEq1zV
         1pxyazQCYVx062lFCpFxWzBQRrrkcavW1QdRsf7Fe4K5mso3KaTNZkLimXyT29sIVq6V
         DupA==
X-Gm-Message-State: AOJu0YwQ6kBCWADzoRZD3CwjVnkrIlpKrBoXFD1BvleiE44prq+4Yk1/
	Ux4ELGkG5Z2OT4WWtHTGP4h5DjHu345XdgYxvtTHPOtqc+Zvd4sIGIDHMJ50NoNrxjNUFw==
X-Gm-Gg: ASbGnct9zXnxxlSHsUVCpJO3ddN/kq3NP2XIHg2plN9nPOG4sU/Hbz3mvm9MQhhGxC8
	GJRRcna9bXWKpchxIkME9CL8ap00hS1i0e3CMHFCWO2g1R9v6YvjogsvMtBNNFyaoh4iQqJpxeN
	cun9QSA/YEGKpPR41Ct5WHS9n4ylLY39NBu7doQ2TTCzz7XprQ57f/VoXGKxITYpPZgk4GOjKuq
	BI7XSOfw1+0AjMyQtTuSHl2sslHis4Chp4oTQ/yKOUx/gce0dj6zMvJQitOCij6UNK52idhCIO5
	waAxkGWVKr7QPMgd6bvI+M8PbwufwgvZz+1bDzp3FwYMjyGrwgt8/KTxYQJdKnQJFEbYSOMD6f2
	GLLbLFHpV8SNQQaAwP7E8LZcIVw5oDS0rCgoF2xSayBXVDVtrqKUmgK8jQcAnAfVEINuBwGk+Cb
	dtdkAqUfm//LokUpq2KIeA3+hE
X-Google-Smtp-Source: AGHT+IFFS8F5ywTecJyG4EAs+YEsYe1DoK6pe9iFKyhp4rQcwBAgyXbK4ZqPmSn/hhCWl+V8eBZZHA==
X-Received: by 2002:a05:6a00:2e24:b0:747:aa79:e2f5 with SMTP id d2e1a72fcca58-74edd844246mr21742144b3a.0.1752552575816;
        Mon, 14 Jul 2025 21:09:35 -0700 (PDT)
Received: from smtpclient.apple (n058152022104.netvigator.com. [58.152.22.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd714bsm11043149b3a.6.2025.07.14.21.09.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jul 2025 21:09:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [BUG] git pull ignores pull.autostash=true configuration when
 used with --git-dir and --work-tree flags on a bare repository
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <010001980c1ee007-2797fc86-fdf3-46e9-bec9-f8da2c9ebb8d-000000@email.amazonses.com>
Date: Tue, 15 Jul 2025 12:09:21 +0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCD357B1-39B1-4B00-BEB2-EF2C20A0E4AF@gmail.com>
References: <010001980c1ee007-2797fc86-fdf3-46e9-bec9-f8da2c9ebb8d-000000@email.amazonses.com>
To: Bryan Lee <hi@looping.me>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Bryan Lee <hi@looping.me> wrote:
>=20
> 3. Set global Git configuration for automatic rebasing and stashing:
>   $ git config --global pull.rebase true
>   $ git config --global pull.autostash true
>=20
>   Verify the configuration is set:
>   $ git config --global pull.rebase
>   true
>   $ git config --global pull.autostash
>   true

Maybe you can try `git config rebase.autostash true` instead.

> The difference is that Git is not honoring the pull.autostash=3Dtrue
> configuration when the repository is accessed using --git-dir and
> --work-tree flags. The autostash feature is completely ignored, and
> Git behaves as if pull.autostash=3Dfalse.

I=E2=80=99m not sure why this difference happens either.

- Lidong=
