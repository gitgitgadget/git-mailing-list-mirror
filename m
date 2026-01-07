Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354626ED41
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821354; cv=none; b=HMkK82KDnWqmTaBaJPFCUnrmz3c+nKZjI8XiBz7yK74zw3FpOcf6v4yM5otG1Vd8myK8W8mGMPnXvC/KsKSCTu529IOeAAQjubjFCb6/ZG72q2bZamn34zdA1AqUX5h3GfXeSRyTnIBJQuzIReEN7qiLDqpBVfVHKRE8AjujPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821354; c=relaxed/simple;
	bh=uy1qs4LCdCgaqKps3msKDVbEQnZAJ+VPgAQ4JFvZibU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Cw5tCdeJ+koK7D13lmwF85HiA+cgUYpv5UBPGeP7603WMjZW0VHF0rL1d80Rs30sR4t+yOVRn815nBd5yUNam8Z+Tg/xOiEpPDsL7rMwfUCPK1HNeAVCS0Cpk8b8eepPCcHQP9xOKk7oiXmXiHStx7tcodZxsKQK+rp5PMf4Z8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkHWihya; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkHWihya"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-121b14d0089so2326856c88.0
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 13:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767821352; x=1768426152; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0VL2G8ahfATHXL6tByJgl8pYKQbHyZx1TuLquZ1j1s=;
        b=CkHWihyacv7pgadXszme4tstQMetpQPfp/Y6jOaaclsvEq2RGb545M4noC7xre7Im1
         mAA1Em88NCC5Rq94pX/WOh0Ws4/xfUAU5qItGKNKxmSrW4tbuWIMSaNSrak9zjt7+YK8
         F11tmBhSHdHvfzEVBWPOu2u+tDOz3zYgMHOHDKJiwet56Ei8G2sQWE/Eso10WclcWT9q
         1Ep6I83dHUFUfG6yP6F0y/H5CoXNmHNd9eNQpUVpoblHdsGqUhBvLdDvKVGg41Rq/wRg
         0Bjk+f48Yl8S8/WPnWvzbgWaTO117Ysbjtt6ddc0bWjhUloq40KR1PGvng/r8Kq/ZaP2
         cUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767821352; x=1768426152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0VL2G8ahfATHXL6tByJgl8pYKQbHyZx1TuLquZ1j1s=;
        b=YQ0Z1xMa04UXr0rFVhdaFwSH3Pwx5Q7ktNTUeltu44jHdDS1LDNybQfDcyEhNnon2u
         R1nf5qiphJRDn1LqxuaV1X0BaBBsyYQXcx846PRPMRr3e6Ur9r8vypcsZF2jETHF2/RQ
         xDEX7vldidOlLpO4N85spOLZ6HA/i0hmCGnVR390tWzsLy5aGK6cvnpXotcoTzePJnO+
         emO933I5b5onZzoXg+jtnKYgEbVYZq3XKTAXj35442jgF37hMe3N+HMyteEG7zAotw6b
         BjRdzsxPP0gxiTD5jHPlmraxTUyY9gmeeNQDNOrbrdZWMCqHpbIp+9LeWNePcQPv8vUD
         mKcw==
X-Gm-Message-State: AOJu0Yzxg/08SJ5YZw3wB1OuQZojtL5m9CYAYCn48Lz9yueurnECnwyd
	6iSTuONm5c2GkezqdcwJIlAjTPPJwuzqFtDjx4VUYtloTSCRfrer1xXYWEipJg==
X-Gm-Gg: AY/fxX6gehNu2mfhYvAz+CF0Thxe2Naj6i+YYhpCtInRUQDNayy60ZGtHGgdgVfLymd
	lUFs2pV1meKdOJKOhzaHoct+c2/gYvtQx7+6KlF12M8hvR4KUiID46efvyWnLbuoD0w1aL0eRIW
	bPZpF3mkiNMN9P1z2CfQ2UkcUoPhqUPpteAZt0L/C+pXoaI6rXee35U1F6dt0DfWL3Ky1iF0rhC
	BH/UdPvtKvsnIUh1ovx6Stzp3soi9eQS3x00hmr6nJjwqLbWE63WMmR8njj9wGFwkpkdMEY8dlO
	bkXGZDuWW4cc1z/kobh+pTb8brdQkfHiq0JwvrEOHf54z9CvsvGsE0TBGFXW+prQ+OAPw0ZDeih
	ZwbFY4x7S5gQ+hQgsCjYGrGD24E+6V/Rbk9uyVxG2j+HXZEmDYUDAyScqMSTgUTTVG9w6xJsBGB
	nbUTFA6DTDlbqT/T8Q79AoWObyuTGZwssovKT/WHA68K4aTEwexg==
X-Google-Smtp-Source: AGHT+IHc4rrBlwa2MqeVqs9PPrYgn80We2UX/eC2euGBRS1k7i81Q+iMcE8Z/x0MBYenX+O0eppvLw==
X-Received: by 2002:a05:7022:493:b0:11b:998d:bded with SMTP id a92af1059eb24-121f8b791demr2765421c88.28.1767821351656;
        Wed, 07 Jan 2026 13:29:11 -0800 (PST)
Received: from smtpclient.apple ([2804:7f0:b77d:586:d825:26d7:b82d:b2c3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c16fsm11651278c88.10.2026.01.07.13.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 13:29:11 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v2 1/2] repo: add a default output format to enum
 output_format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aVvIQYdsrB8vAJ_R@pks.im>
Date: Wed, 7 Jan 2026 18:28:59 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6D2CDFA6-FB52-4BFD-B800-B01B5E484038@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-2-lucasseikioshiro@gmail.com> <aVvIQYdsrB8vAJ_R@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> This is missing a test.

Indeed, I'll add a test for `--format=default`.

> It would for example be nice to verify that
> "--format=nul --format=default" does the expected thing.

Would it be necessary? We already have a test asserting that the
last "--format" wins:

test_expect_success 'git repo info uses the last requested format' '
	echo "layout.bare=false" >expected &&
	git repo info --format=nul -z --format=keyvalue layout.bare >actual &&
	test_cmp expected actual
'

> Also, I didn't see `git repo structure` being updated. Should we do that
> so that both subcommands know to handle the "default" format?

Sure! I'll do that!
