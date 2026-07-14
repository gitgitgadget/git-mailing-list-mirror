Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF8B32B12A
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015787; cv=none; b=BQSTFMLLW/evBzFypA5v3jWwovi7D5pmMQ8CUWL3QyqsS/eDb6YKa3wYqEA7117gZq71hYn51ZkdwhgwmqgZFY3pJKc7qKJtXz984nmuF6IAvhwbX38wDdQOHCgYoLp5Vsv1z0I/aKB1kC8x2qS5yuPgpYjrpRNowuJ4k9RF3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015787; c=relaxed/simple;
	bh=HlcNZacqHSf2gZZU6da3FGbe4/TRhlLyvDQMyK7qvjw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CcIGyqMkpysFWuYIEpOkyJMLnqYUIchvHYOx/+S/NLIwzSU/QFNj75CbGCWJb2xVv849kZ/zyEbXEf+jvJtVSPMWZ+3Ryhd+GhmIcb3/JQZ3InHdwPyc7td3G6bUD/6kbM5shNphmSOUnVDwEKEY+m+MmvtfJqUJEsMupR56yCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mNDB2c8s; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="mNDB2c8s"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so34675585e9.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784015783; x=1784620583; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4f/H4h6x7i59ZwBdYNdylRnT2vh+xtmbhHpHJ3cGC8=;
        b=mNDB2c8saRjK3gz0ef24LQjQ9yQlz5mkzKCVCH73zkq6zKhK/duyiIxRNZopghdJ4k
         qzVpQXziqnTPxx3yu04VpL6Z61op6lBPIzUqNya7iNQutURvHm1E5EUd1fOuIU9uKP5C
         J0MCvW6nTlLcHtqWuv6SRAsJ/+Fi2Pp2coCVrk2B1Y/Z6bCxxpL0EA6z38HfoUdQN5gC
         zSXOba6CMfUZyELGNyzqZwmSfqwHPPdqv/dxadg2dhn+wzq1rGR73nSiVN4LOBp2nEEL
         23/hqke3zD3cEUWtWZtCgK1KNDODwqcxfq6CdvOvDgXP5jyrJbB9dsgjjWRp7wpLjqOD
         3ktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784015783; x=1784620583;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4f/H4h6x7i59ZwBdYNdylRnT2vh+xtmbhHpHJ3cGC8=;
        b=osHnMJYBUWWJ2UzTHn7Y9eChgdYz7FdgTjMBMDLZrOLEKMjUeru+mUsPegHtVK0OGG
         T0I/qFztQd+Vh0WqPKshKMDlqNiTgVBO3o8kGH3o2aHYktuwI/6kfUIW9pRKTSgq1Mp9
         RlHIElHHbNQ5d0x579cI8D5m11145fS9ggcdUl7kHtKcP5OnWJs+Aj+2GQJVyFlT/Fo1
         tSIe+6uso0BPoFDd8Dxuh6K3DT80mZM7D9r8nkAnGizNxwu0EcqgHOjwCSz1xdRBHZrQ
         m2uHgNEIspUq36LlacHbxK0KUHVjaSdHisIhTUYdbgp7gfBf31/JLtFa2mzA8xzWUkC4
         hwcA==
X-Gm-Message-State: AOJu0YxSE5Ci6f7zKAXZ3606GcsFf2DpZYQyxIp3yg2gQq9Wfzrk3T4w
	IExjNYs1xnvjmlcpTm3mYNEdGZ4bYqCUuiBOQ9fgM32GlWjvyl1dXLsPoBDpHlur9yxq/mU3SM6
	vR+zq
X-Gm-Gg: AfdE7ckfSdCSzroeG+D3ROIl29ecNmDkyid+vI06o6GhiOZ2dc5ur9G+N95Wuq0AjVw
	2w9M1PeA24DAGmNR8Xr0LhFv3xkd0tpN4vyB9t4FeqmE5mshZdpp0a/YnHOrOI0wWtylkOVhg2h
	l3i13K3XklampvG3hnhSMg7mnRrsNcsjE+qmKSkcbcDoNKqMpXZZ0Xx155p33r4bhIZQAxRZhTC
	ry1PUurrfqqFqDMLE0WXMsXEqqTJbEjL3Dxv/uEsvEC1mY13OxlG+0TizrAyLcL35AHk/98t4/W
	dc+8WYq57sEi1J8pJYDCzDqsklSuNJ0WDAu5piB1eBOhTo+UweqoJQ2r4lmWy+s3t5uUSdlhaaP
	qmU7Zxopr+FC/1XKQ+NIw1W5kD473bqb4MA1zpx/6UKlUCj8NFSdwPzCet7I3C+1RE+eT3qTNO2
	GWdVdqp+oXp2043eYg2tM+F47bAD85hkPyMlLWo7Tw+ylalATU+JiMOHZYhfjUxGcgM2q+AQqjf
	kk3
X-Received: by 2002:a05:600c:628f:b0:493:d1e0:a4f1 with SMTP id 5b1f17b1804b1-49538ff8272mr9698715e9.0.1784015782628;
        Tue, 14 Jul 2026 00:56:22 -0700 (PDT)
Received: from localhost (p200300f65f47db04b44a80421173aa03.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b44a:8042:1173:aa03])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4950a2ed840sm54728615e9.10.2026.07.14.00.56.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:56:21 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:56:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: git@vger.kernel.org
Subject: bug in `git log --cherry-mark`
Message-ID: <alXmoXCs1VtE-KVr@monoceros>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="akj5aumjn6bzlxmm"
Content-Disposition: inline


--akj5aumjn6bzlxmm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: bug in `git log --cherry-mark`
MIME-Version: 1.0

Hello,

in a linux tree I have a bunch of commits that I sent out for
application to the mainline. A part of that looks as follows:

	$ git version # that's 2.55.0 + Phillip Wood's series addressing my previous bug report
	git version 2.55.0.11.g153666a7d9bb

	$ git log --pretty=oneline --abbrev-commit --decorate --boundary --graph --cherry-mark --right-only next/master...a54cadc575df
	*   a54cadc575df merge mod_devicetable.h cleanups
	|\
	| * fc69191474ff virtio-pci: Drop inclusion of <linux/mod_devicetable.h>
	| * 80964227feed greybus: Drop #include of <linux/mod_devicetable.h>
	| * ede7ce64f20e Documentation: Update after split of <linux/mod_devicetable.h>
	| * c8efa35aeff7 HID: wacom: #include <linux/device-id/hid.h> instead of <linux/mod_devicetable.h>
	| * baead64db0b9 checkpatch: Adapt comment to mod_devicetable.h split
	| * ca270a534d0f net: phy: Drop #inclusion of <linux/mod_devicetable.h> from <linux/mdio.h>
	* | 9874577217c5 WIP: Don't build XFS on m68k due to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=122438
	* | 554e345d3223 s390: export memory encryption helper functions
	* | 41d6dc9f88ec Add defconfigs for x86 and arm64 to yield stable builds
	* | 9a6220166a5e drm/vmwgfx: Don't use UTS_RELEASE directly
	o | 49362394dad7 (tag: next-20260713, next/master, next/HEAD) Add linux-next specific files for 20260713
	 /
	o 8cdeaa50eae8 (tag: v7.2-rc2) Linux 7.2-rc2

So this suggests that all the commits are not yet in next. But if I look
at the right branch only, one actually is:

	$ git log --pretty=oneline --abbrev-commit --decorate --boundary --graph --cherry-mark --right-only next/master...a54cadc575df^2
	* fc69191474ff virtio-pci: Drop inclusion of <linux/mod_devicetable.h>
	* 80964227feed greybus: Drop #include of <linux/mod_devicetable.h>
	* ede7ce64f20e Documentation: Update after split of <linux/mod_devicetable.h>
	* c8efa35aeff7 HID: wacom: #include <linux/device-id/hid.h> instead of <linux/mod_devicetable.h>
	* baead64db0b9 checkpatch: Adapt comment to mod_devicetable.h split
	= ca270a534d0f net: phy: Drop #inclusion of <linux/mod_devicetable.h> from <linux/mdio.h>
	o 8cdeaa50eae8 (tag: v7.2-rc2) Linux 7.2-rc2

I would have expected that ca270a534d0f is marked with = already in the
upper dump. Is my expectation wrong here, or is that a bug?

If you want to look at it, I can provide the relevant commits in a
bundle via private mail.

Best regards
Uwe

--akj5aumjn6bzlxmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpV66IACgkQj4D7WH0S
/k7Zawf+JwGvIR2ZkFxQQSjp/2YB18SGSdfFWge/Kk8ZYGjZfSH2+e7OSN0OC3CP
eg+atgDp6bVt4DWKcN+EgJk+gOnrgGLzMOoCivC3jlHTtE0YiC3lZc0SDconuJeP
cIUfbcnTE7RiKzJwzTbiKra/BlhVl3z1VvjjP/yyWJs04Am8W1FGvrbGdpoQa9fz
svuPxpfK54J2iuKwJgnK+UyQVhMnroyvXdpR3U4PUAcPpro0OYzOlJ/YPYqpSUQv
LocV3l69YNX/PwQrLztj0mguhBeU8qNivF4t6hWmY7Q+nQykVMYEDFr4jMLKWXr/
XDU9gtElzPcJIogiic7VFc5uxyXzPg==
=30+K
-----END PGP SIGNATURE-----

--akj5aumjn6bzlxmm--
