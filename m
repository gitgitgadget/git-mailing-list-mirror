Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C2D3126C1
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763938; cv=none; b=IhUILfF0hc8B9x8SZrveAchcsW+jbgfHAeGevd/wPArkreYmmmy8cK9bLpgJJ/ADpufk7tuQR9NuIwkg2n3zg3o/ZmYn41EmGB36XZH540728ENKppayegDTr/ZzPCMAB34pSt5a4BXPW7f7/GVueuBUcIC8OP3/Ih5+D0VCKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763938; c=relaxed/simple;
	bh=32LZzzFus/mvtM8Tzwy5uqCO7l8qb9D4mSZxrwiw61A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEuHHpradIL/1wTX5XwiOGey63KzFgsgWoiPWGuLd9+odP2WyxbF8zeV3PVBWYQ831VEJTZRlfTDjcKiLdNl0jrBPljVU1NThqmtzRmJPOKLANxAEQ5J/JzlUntpXKKZxNL1LgJXoNOAmdnVYPo/Wd2JUefDdFEiCoAo+I7cB88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlyfUWxV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlyfUWxV"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35305538592so1642875a91.0
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 01:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769763937; x=1770368737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26Z3u1BhtIWx/Z8xll91PiS3et4GyRwZCmG2vm2RCCc=;
        b=BlyfUWxVBaHMo5v28UCQc+cnnUP0fcKoauGNNJwPMbg5g4oXrnanAMBis8K2DXw/Uu
         P4xpOCYAdIGBZjd4D/NkhJgn2c3NTqFGPimU0nOkRntO9JdIC2tBhcbj+NCUVOZ7axXj
         mjVMSwzpesZPsG5iyMMuxg1pBJiLFBhs2ekbhRe81qICILmSBnLMAoTNMR3G3xXd0xyM
         mN2wxg+zB8VX8GnN+XU7y+4aDYEKEQqOHX8CWFM8ntNlJuEXqnDftU10g1UDZEV8RLMG
         BRoXvGhZo+XbWv7ijYhKPQ4yqD2D1/Isirh7/jG4srrKh3eHJSLZVukXFU/D99mX5g5R
         G+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769763937; x=1770368737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26Z3u1BhtIWx/Z8xll91PiS3et4GyRwZCmG2vm2RCCc=;
        b=mV/0mdrC52K8UG/vgJrw8ESUvCuIra+MbW9WEROKgImjmZZC8CjuI1fk2rlYCN7xms
         aKwu+K2e85rovUFg1lVI8fomF6eu878W0nwxZy0SXJbuDExRUM2MH9WabSxjUJHIA+zz
         7XxMIlVHC++BVLcyMvS0yQvJWZLyGJfKKR4sf6xon6dVT4n3yfk3RjkhfnsKQlk/ONdx
         dnuTqyYnEObs4WNsMGdpVL1n2a16DF4jARvspLFZeSHf0u0MBn2Q5CPMm1Y1SfQqUEpg
         YpZMZfjLEj4bGHLxxRwIACCYVP934Wwu36d+EOR8Y/mxyTsr8KyotiK0K7bb2eNQ6geD
         3Ptg==
X-Gm-Message-State: AOJu0YwjWH6AAk2L5h/NTNHrQyG0owE+z8gnJrjmTsWAMtDafNVpL9US
	pUedaKnesIGqThEYqgkb86CJQDgjuEYSHIuQDo7AWAFlverb453q2Sy8fCuhjg==
X-Gm-Gg: AZuq6aL0xgdHFfjVMmB12SM/9fXZ+mhLfaw/NHTVv27biNrAq0sVIIv1bsJojRomgHx
	tx+jJguF2GufFYNUvLB7MYIrcrrNGvUyi+w8LfkbJ82jdGjO/bjWVZcPPXBDJ8Q/9rq3K6G/a5g
	X2ryqCph3oIOaxaX222wUzq0itlYYIYsUHmXwFoae8dTsYlNItDI9Kg9VJCOuRBY8YYXe8g8nbx
	OkiWcoUYlIJjFuUfdCawiCIMm2PvjL7p3V1TymEQ2dWnO1Mc0Tz6OwRN7HUmJLvTpO2/aBG42At
	TsIzawBTe7tA6IvfCrpj/8S+9W/f3vBImKYphF5i801durhDO0NkYzcaDTqal7fbgEiGxjDNN1r
	T2OykNcXb1GGWwnd2r8EN9a34jwOdxIirwxZ2kiPIXXqp4rHL7PnvFIP7IWf5Fzsez0N8j0IDh8
	KMU5j7ym26OTODaRlwBhTAOYALO0rTIw8uh+Gf16dS0I+WqA==
X-Received: by 2002:a17:90b:4a4e:b0:34a:b1ea:6648 with SMTP id 98e67ed59e1d1-3543b2df76emr2182266a91.2.1769763936662;
        Fri, 30 Jan 2026 01:05:36 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:3c46:c24b:c90e:ca5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6230d5dsm10646759a91.17.2026.01.30.01.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 01:05:36 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH] show-index: warn when falling back to SHA-1 outside a repository
Date: Fri, 30 Jan 2026 14:34:53 +0530
Message-ID: <20260130090525.254665-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aXvpSPpfvulKu57P@fruit.crustytoothpaste.net>
References: <aXvpSPpfvulKu57P@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> On 2026-01-29 at 15:36:55, Shreyansh Paliwal wrote:
> >	/*
> >	 * Fallback to SHA1 if we are running outside of a repository.
> >	 *
> > -	 * TODO: Figure out and implement a way to detect the hash algorithm in use by the
> > -	 *       the index file passed in and use that instead.
> > +	 * TODO: If a future implementation of index file version encodes the hash
> > +	 *       algorithm in its header, enable show-index to infer it from the
> > +	 *       header rather than relying on repository context or a default fallback.
> >	 */
> > -	if (!the_hash_algo)
> > +	if (!the_hash_algo) {
> > +		warning(_("assuming SHA-1; use --object-format to override"));
> >		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
> 
> If we're going to start producing a warning, can we also learn a
> `--quiet` option to silence it?

Hi,

That is a good point.
However, the warning is only shown for a particular usecase: when 
'git show-index' is run outside of a repository and --object-format
is not specified. Given that narrow scope, I’m wondering whether
adding a dedicated --quiet option for only this warning would be worthwhile.

Let me know what you think :)

Best,
Shreyansh
