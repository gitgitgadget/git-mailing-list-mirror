Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D95259498
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736236942; cv=none; b=ioJ3KCmaawtJoj9UoqojtrNn9u0DcaiBEWWV4kswJRHkEmUtX46zev/13w8A0fETVua6BFRux9WmlhNHnbMUmD15kHfz8ISUCc3uG4nGp97uGuMncRm6Ao5izdbFFn32UlOcBFSdhmJH2t08hvPyKO6a3WGCWKrdKJqYUp2hSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736236942; c=relaxed/simple;
	bh=p+Aeg5k5iGsO7g88/YcEvbNikYNe8H2XkqEu0Gmi1AI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Feymh6kv0fD9gpywgccQm7zjWdA1veAOJm8f0FJt1EKyTldOWZrQPKVgXPKl6mA9GDntEqQWN/o2258+hRG7Fa0hao4WVowgYSBN7AdqBuMGiZZuM26/m/X4pIs56KStPsyYPki+cJHfaWJtSDcdtgxLxtSiZcMhcB3BIWJqlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYMfKcIA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYMfKcIA"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21628b3fe7dso214987875ad.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 00:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736236938; x=1736841738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AsW/RpAySinzW/fZsAg7AKWj7dsB3Q1DW0hJTMfvoLU=;
        b=fYMfKcIAneKjK1USSzHLh0GUsKfubvbIRx2+PjFLBUvXsLvlMoy4plecTvIzSpDrIl
         L+IEm+LhJstkLfn6vbhnGcd7B3rwOEOmJpazQzEANehm7cGYP5TtOocnkpIubTrG3tfM
         onthyUR9eELjWFgJcRT7ZWWKUXEiGSyewueg3Nc8+qawcPCGNVO0rRo/b+Er8W28iIuJ
         1wW6YWr7qi0ynblZv4WNdAgCJgCxS9VrKDzdIV5Fr1tSQP4WdDewoQTHb1IokcTh5pWV
         AZh3B9ah2fhUUmaPrvH5MGMXJS2UDq9l10IJ8Kfp0jFd3st7qQCDvmxSjo8ATK29Qd9H
         C8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736236938; x=1736841738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsW/RpAySinzW/fZsAg7AKWj7dsB3Q1DW0hJTMfvoLU=;
        b=jTw586eZsu5RFrEh0exjO9/zybyce2wc6aj1i6411GGmmrnP0bsibfYKrezXUFjrsZ
         LxHhx7fqdJFSdhTDyHYLWCkryoeOLCb/2RXjpxZprCQ5ICSvZb8m24XTaqIHQmwBQWxU
         FcPF9IeJF6mzfGisW4N3GihpHwMnCigEiqOoZpydE7MqsjdwDQ/EWa75Cz1sAL0B6lwX
         ehEQxiG7taziE3HwTnbDm3dKhMPtRIflZN75tOigC9xDTZAbOZLONkr2yXW1fetsmNZP
         NPNaZUudJ1021UHOOsXjM1Fp8tVmqu8CUxf35FY+BQl8pTbU8aQo9az6qe9EM4Y+KP6R
         NGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHxtiVuGs20U5Mh7nl6YBgylZpuO5mRPHlcXEfItDi+2NPBd2pST0kclLb6Ye/OXn2vEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrje2bq9srLbyZ05yn7aLX6AHfmVD8p3d97MwjliHW0q3BX4fG
	lmOHMtamVMFOe5oVfQD83QXdH/albzRC4EhniAcgiA9STi7Fw6Rt
X-Gm-Gg: ASbGnctN6mIoHxt+HLM4MiDBIUgGhrZNCu0L7v0LtMDfRU43NVKbI+hcT3Xk2ZH+iSx
	hpZt3E+ClQGvnkHMTBq/3aL4oGvhBQdjQ775BYYIx50TM/TCMGnrMbslmV9WJz5n/gjDmcDzt72
	v9+rnZ43d+6MXqgj8T48D8OTyo9Mpm35iRMSKKlL9ENfKf8MpxuGja4vnaFa7Lsn7rWetMD9jBv
	iW1YiUO9qMOBprQ7GSyaxURTaqITMB34lJfa8iXGVBus30YtkbGeQzOvRkEQ+Wpj+lylRr+Ezoi
	l6m17PapaOGp+Fb34Y/5XTOwtTLMbbgBIENxtcHjXIPt15RG
X-Google-Smtp-Source: AGHT+IF8AwwuZjT793IgzJMLpCOmHwjD+WNJ3XE5P87iiKRBNhvhKBSoxPBMuIhuQ7qoq02xLugXNw==
X-Received: by 2002:a17:902:e84b:b0:216:6f1a:1c77 with SMTP id d9443c01a7336-219e6f105d3mr831482485ad.43.1736236938373;
        Tue, 07 Jan 2025 00:02:18 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdd9bsm304113465ad.132.2025.01.07.00.02.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2025 00:02:18 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Arkadii Yakovets <ark@cho.red>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Emir SARI <bitigchi@me.com>,
	Emir SARI <emir_sari@icloud.com>,
	Ethiraric <ethiraric@gmail.com>,
	Fredrik <fredrik.oljemark@helsinki.fi>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.48.0 round 1
Date: Tue,  7 Jan 2025 16:02:14 +0800
Message-Id: <20250107080214.30978-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Please pull the following l10n updates for Git 2.48.0.

The following changes since commit b74ff38af58464688b211140b90ec90598d340c6:

  Git 2.48-rc2 (2025-01-06 08:24:43 -0800)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.48.0-rnd1

for you to fetch changes up to fc613c01d45b034290e7fb69977a2cc2715b1259:

  Merge branch '2.48-uk-update' of github.com:arkid15r/git-ukrainian-l10n (2025-01-07 15:45:43 +0800)

----------------------------------------------------------------
l10n-2.48.0-rnd1
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmd83TkACgkQk24VDd1F
MtV+uQ//U8cszgueBJ7CGx97StifMEc7oJzOnxYT6X1B6zdwOXl7MOsUD5kvw2sI
lO1tIMfpZavweJl5LcN5QJBPPpuFJkqmMrrFgCbDhjOyYkEcJmLsZA+WIH34aHWu
uTJSnToxWsN/vr1eBNGQH5MxxHRMKIKQxz0+LgafGp9THlOxEsexfxPE64LnmAiQ
gjETkMkiQnMp+Wn2n8uFarfpxw2ENbs2lAaWWxLh99RyHZt8UoEDvlXS1GFmVfnw
tGRuBdjwftlieLagau2x78hrxZPO3AnbMf93FRdCB1w7E5+anoId3t9R9wuCqH6h
xVlz9jG2VG9qYhkIlUe9qXriOVpmCO8llEQYOyBM0LX5fFE4Jos0hG3DEYB+ilEB
iSoaNklQTYvn24ejxxyRKiYq85XoVw1bXskQsInQxoYOZZid/Kx4DbsWuVvYtqJG
38aKu31BgN1HuGc5NLQX9KhT9cVgUAMAHdcYnwhm3GYFNjsnEV/8hPkNzCM9U4zf
PP+Ns5snmkgXqP2baYDt/2j4CXdtwRTKgzh4BCeqsZqwliAvoYoPP3APFMzsx+uG
UV0jj3IIUizJs6XFwIBzfjhnUTmKvh0XqFr8t5/LdSLFSoCihiOOsnR37qRkPILz
vzh0/RicLxDXEsriCTcfdjaD4K5Sx9t707BjOa7pMvrMwFvxvR0=
=WD1L
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5804t)

Arkadii Yakovets (1):
      l10n: uk: v2.48 update

Bagas Sanjaya (1):
      l10n: po-id for 2.48

Emir SARI (1):
      l10n: tr: Update Turkish translations for 2.48

Ethiraric (1):
      l10n: fr.po: Minor improvements

Fredrik (1):
      l10n: sv.po, fixed swedish typos

Jean-Noël Avila (1):
      l10n: fr: v2.48.0

Jiang Xin (10):
      Merge branch 'l10n/zh-TW/2024-12-17' of github.com:l10n-tw/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'tr-l10n' of github.com:bitigchi/git-po
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'fr_v2.48.0' of github.com:jnavila/git
      Merge branch 'tl/zh_CN_2.48.0_rnd' of github.com:dyrone/git
      Merge branch 'l10n-de-2.48' of github.com:ralfth/git
      Merge branch 'vi-2.48' of github.com:Nekosha/git-po
      Merge branch '2.48-uk-update' of github.com:arkid15r/git-ukrainian-l10n

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Ralf Thielow (1):
      l10n: Update German translation

Teng Long (1):
      l10n: zh_CN: updated translation for 2.48

Vũ Tiến Hưng (1):
      l10n: vi: Updated translation for 2.48

Yi-Jyun Pan (2):
      l10n: zh_TW: Git 2.48
      l10n: zh_TW: Git 2.48 round 2

 po/bg.po    | 357 ++++++++++++++++++++-------
 po/de.po    | 304 +++++++++++++++++------
 po/fr.po    | 785 ++++++++++++++++++++++++++++--------------------------------
 po/id.po    | 338 ++++++++++++++++++++------
 po/sv.po    | 413 ++++++++++++++++++++++----------
 po/tr.po    | 293 +++++++++++++++++------
 po/uk.po    | 599 ++++++++++++++++++++++++++++++++++------------
 po/vi.po    | 336 ++++++++++++++++++--------
 po/zh_CN.po | 301 ++++++++++++++++++-----
 po/zh_TW.po | 667 +++++++++++++++++++++++++++++++++------------------
 10 files changed, 2981 insertions(+), 1412 deletions(-)

--
Jiang Xin
