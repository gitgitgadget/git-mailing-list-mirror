Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C054FBF0
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707627303; cv=none; b=NQEH/NriI18jYk1R2jQ9HIV5F+MaEdgsPa7iY5k9GdBozXFpUlOyo5/xZjGPPNAUGX1AuOq6fUFAznFufn9LDdfvQwvbbVb3TVF5dT5xLL2Ggd9F4lGxFPjtCa4JmtjPFqmT2JFCcDQHJjA1a1JbG08HzngsGY6HqqjPtuAn1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707627303; c=relaxed/simple;
	bh=u8GEt41C5c91zEck7+Y48nYm6JO8FICtM2Z1rxxbZZk=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=ekapSX/AwcupBps0WPTnf1s3z/QorxmfZr+ZFGrqsJhDfrsTdnpVMZUigbpoQQ615m83wY7QHLyeb2lKc/4q9Nn88Zr6EYL23grOlw2HlABSADdtjhFviVMlu78B9++AZ0z/xvRCJKq57pZjaOUJ3sC+eI+p89uO0awE2lPLwsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrjwfBS6; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrjwfBS6"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2184133da88so1314064fac.0
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 20:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707627301; x=1708232101; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u8GEt41C5c91zEck7+Y48nYm6JO8FICtM2Z1rxxbZZk=;
        b=QrjwfBS6BVM+u3p6ehXMtO+kxMIpA14eF+DxeeWExphYyivcjrUZTmhOLo3PcaTIl/
         A2SSftduE39IE4+aobfr74T0c6XChUqTlxYaywH6QYU8UoOELZWD5x0skFDBYdLYVd9v
         Na+ZqQ0a8rIbMZrocZYCFfMLerG940+R6KVSEIS4QreF/+KmMDHURR1UFmzwF6sqUE0M
         zI6QzAQagPQvCbFzDswstZhhkVsY+H14mXIMI5M5l8EJ2D5aeYXsw3pN/WkFO7V4KTkP
         KE1MzGtavZj+2H0QakMSUUKMd8KuHyhBEYgIVcuVzPYW9UGxUq8Hdf09089vwQZaelxQ
         GWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707627301; x=1708232101;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8GEt41C5c91zEck7+Y48nYm6JO8FICtM2Z1rxxbZZk=;
        b=ldZyrjCcD+xz8VQeQHlnDbjWrOGlJ6Vl28mVG5i9VbBH8ai2GLvLQk1N7XsEpYjEdp
         JMF8jR8O+M5wIyC4t5QTd5VdUPPmkeM7q/bkitGIOlcAeMQKPvs3EF75v6utajJFHcWU
         h4d5luCu4EHnxbpQNDTF45ZRsUqRiRZ81ZO1fuWHlU6vg797LqoUy7j+U5iDmaIH4imO
         iua2ctN2AyPt0LpCzwdMcyXUkM0HF6l8fhLL/O0e9hXxAEAUA859/iZaKMC8PsJzK7IV
         uonOkt1GWjZjWL3tw6whpN+gAI2+/q/Nge6cEkJw/GQw4UPVCcIMo5vHJJlkhtuN8VCl
         s+cQ==
X-Gm-Message-State: AOJu0YwsPAJuve7I9SaWKwT7LYfziV01erhzwrUfzs1t+1KluhYTeH/f
	VcDxw+/kt2G4KHdxBeIiYr3mrW6TPBikgZjcStt4u+Wb7cGjjOYm
X-Google-Smtp-Source: AGHT+IFtAvzuSWMpDfys7ssIGjc0tnnqBBR1WEsU1QKKEeufUl8iocJ8jUTShPZzTy41jNDs7knhvg==
X-Received: by 2002:a05:6871:b2b:b0:21a:13e8:2989 with SMTP id fq43-20020a0568710b2b00b0021a13e82989mr4603779oab.14.1707627301145;
        Sat, 10 Feb 2024 20:55:01 -0800 (PST)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id xl9-20020a0568709f0900b0021a04f8c541sm753266oab.40.2024.02.10.20.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 20:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <git@vger.kernel.org>
In-Reply-To: <20240210074859.552497-4-brianmlyles@gmail.com>
Cc: <newren@gmail.com>, <me@ttaylorr.com>, 
	<phillip.wood123@gmail.com>, <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] rebase: update `--empty=ask` to `--empty=drop`
Message-ID: <17b2b5fb5acd8fad.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Sun, 11 Feb 2024 04:54:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I just noticed that I incorrectly specified `--empty=3Ddrop` in the
subject of this commit. It should read "rebase: update `--empty=3Dask` to
`--empty=3Dstop`". This will need to be corrected in a v3 reroll.

--=20
Thank you,
Brian Lyles
