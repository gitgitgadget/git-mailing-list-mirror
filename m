Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312819ADB0
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875293; cv=none; b=E5O0Ww6uKLM7Sga+I93cqK8bBApo51KFXK75b0I2FKtnrmRwdGLTapWR0mBivZLnzpK0afrxHiH/ByI6qcLcZr43uY4NUyn1ViK2UDNAs29/GJIAA+vnEIonVMMKhWvujmy+kVCjZ3BL29ro/DSx9OcR0aDHF1qkhE33JCC70qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875293; c=relaxed/simple;
	bh=Hp087nA2cM3jYVcb0Ecp7XVlk+9iw/yCwFhi1hK60ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J44l1tw/SEyph0TMK5EAzO12n/b373BKM9vMvilXeplmiD5f2KLlfBWqGooYjWFC5Z4GEF1S8dvOuoeRM1EW9Kd5Hy7Nntoph2gJ7yUdCbIhQr8WIhQxPqAmzCm4jMjzoBUEx3WfSqUNblFD36Thk/M28m/VCvryiFBVsE9ghII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNEFlWqu; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNEFlWqu"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6febbd3b75cso9587517b3.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741875291; x=1742480091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vL+GURfGtboUzPFci6ycV7H2denH/WgGWoiV6iKVK34=;
        b=cNEFlWquLyHlayZHOjXAnqRun3xAM2ks+pU3pysRJhVMV+5FRjs+zyTzKll59BSMq0
         Ooux3OurOtZVxyWOuogVCwxkT3ErHYjAw5dg4CW4TbByx9QyqDShWJ+z0/5P9/83KcSW
         ipqt9N4KtnyV/bB40EhbPO6iPVjyoZzaL+Nq90n3Px9+b3vAG/5UTUpblKzLzmHMeuhj
         YzOS59WbepUdtQqE/8egB7ECCYWTAV2dyYe8hy+qfv6PBwtrtqhyigRnFEiBoNhUgkLU
         vvv3bqU7s2swL/hkPEh9CW5FU4of0o8jLcjdeLMKEspcZUutRcVjj89RZJGchEGCQxMX
         LDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741875291; x=1742480091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vL+GURfGtboUzPFci6ycV7H2denH/WgGWoiV6iKVK34=;
        b=NjvNpNZrywo1hb7Z8Z/Q+l60P85lLPrx0DIrB7gXI0V/HMO2u599MYC17VsRlKQ6yy
         czIGXQXB2blZsE75At+OrbkekIw2xvyzW00LxfSBge4ShiTVdXwsq9PnDXAAYu9VsT+I
         GVgzrHDQaSRujQLXCuZuHDFd9zPJndCTEFU4Qar9/EdciYSgP3bWthoWklfDjV5+6o1w
         ntY45Vgzq/0/9uK1TbrDs+ljooxxPEQyppn0ZrbBBvflw+n+3QGvahAIwadTNi0azvvE
         JYTcVIwE0ukmp/1fxGKEOlOblo3Q1Q9UxYJEbj3NsLY7Q0l6bPq9qnPwS14BeRptPToE
         Xn9w==
X-Forwarded-Encrypted: i=1; AJvYcCWPcCvjZrHxO/8dXLRljgVN2tzFIq8/D0DTuM2v3VPUkLgZ8yETswctiJje77XPuKJSCCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuRkcYEVBaoL56S9nefNjvIQQiLTVrHn2KPqQWEGAyBCBgLkQ
	WDjRKHE14LvdheLwtUTc2xIulovCkq41CaB8Od3YXBK1Y9//bIhx
X-Gm-Gg: ASbGnctfWPwg97uybw8m5JBqje4NxyGtSShe/m+X6tVE/au5miTfafyMRk/y7zjky45
	ukK4CNSEooYEyz4pzLp+0mhg70oaHnoVKnS0IlMCHyoIq0C73L/BrIIQLfhebCaytW1seWqTTWT
	TvsxNKYiNuay4wKysgl+Jwfm5bDpt03oUlzxzhHx+Xc/rrUv6hBAGSUqf82e3jhofe+xWFMvoqc
	nSeOB7nvhEq503swdCD3Awo8eFjtIEoAV5DU5Wi4EV3e6LsVZ/PaeI2eqC9TzrJQXruGqIv12k3
	CYBEYmtTC0/RQjvt/3VJHj38GUwZJfWkPK05s0cqJk0F9IWmAb5j276qNhoap0W/bkOvXmACNr2
	gzrR/sNLoK8cs8Rxcdzd1yFmFpgwEY0c=
X-Google-Smtp-Source: AGHT+IEx1B/E0qUAbAuUCcyiqiiO/ZmJmlB79wDyWnte+jOd0fvWQ4R2CVIuDRq6QGe8aTSRx2RNWw==
X-Received: by 2002:a05:690c:45c1:b0:6ef:4a1f:36aa with SMTP id 00721157ae682-6febf30c94fmr359917107b3.20.1741875290705;
        Thu, 13 Mar 2025 07:14:50 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb5966sm3438257b3.106.2025.03.13.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:14:50 -0700 (PDT)
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
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Ruggero Turra <ruggero.turra@cern.ch>,
	Teng Long <dyroneteng@gmail.com>,
	Tuomas Ahola <taahol@utu.fi>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>,
	seoyeon-kwon <seoyeon.kwon@navercorp.com>
Subject: [GIT PULL] l10n updates for 2.49.0 round 1
Date: Thu, 13 Mar 2025 10:14:41 -0400
Message-ID: <20250313141445.110468-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Please pull the following l10n updates for Git 2.49.0.

The following changes since commit 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3:

  Git 2.49-rc2 (2025-03-10 08:47:08 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.49.0-rnd1

for you to fetch changes up to ab7cb7e2634bc84e87074cff1035efcc1a5ed27d:

  Merge branch 'l10n/zh-TW/2025-03-09' of github.com:l10n-tw/git-po (2025-03-13 21:57:56 +0800)

----------------------------------------------------------------
l10n-2.49.0-rnd1
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmfS5hkACgkQk24VDd1F
MtWFFA//YocbgRwqWIIBvRX1GC+8qRxoAGEsANWFThJoIy9Lr1EOPuzaxDI9t8As
1sSSUJk7HFQJ5Sh9pohf5Ej5iZbZVRdxjyRS9tdmf87wpkInMfntYHg1yw78XkoO
6g2n/lXCdDvezYNE0nWyUE8wJwNax9NFo+7DRLVrnpS09d/KwDKc4IXW1ikHZbb1
KCjUcVk1w8YZpSKsE9s2i61A7k5LGW8uH5dW0S6vwhBCyZbPGFuD3vYnr9g119de
KkjRf5VIItcUpKeRdAvaj4FvXO7101xqmsUOCkKZVSh6iw7HHwDHii8L3VOANWul
ROH6nc/YZGYDHCmwSg2WWLPzv7IwuAqbgD5LN3j18p+ur2JfTVcTGYHHQfxUlWq1
5VLatGp8Bte3rIJyCJRu+1r3dm4PLOGU6dlH3J7pNDqB0lgwgV55Mu+FC3+rDIyg
osKQTYiMXGFAIqRT9ZN641wy5hx8mgJtOu7POIGCr5gdEZQsoYu1aNtfIOKjTBoI
TSd8GQRN6NhC6KqYHjTcFSllm1EdrSjdaqzyWIj52uCuYEvi74pd8x6LR+h7fUKN
dNctoxED99wv7mrhjoG4nwb8+LL90rHPzWMGT1xBY7B5sRzeStoSXfMzvMEL0LAV
iDO3uj19ShyQlsXWGsNtfYe52oeU6HQtkyhpiMYcqRRRCbn6AN0=
=uSnf
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5836t)

Arkadii Yakovets (1):
      l10n: uk: add 2.49 translation

Bagas Sanjaya (1):
      l10n: po-id for 2.49

Emir SARI (1):
      l10n: tr: Update Turkish translations for 2.49.0

Jean-Noël Avila (1):
      l10n: fr: 2.49 round 2

Jiang Xin (8):
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'fr_v2.49' of github.com:jnavila/git
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'vi-2.49' of github.com:Nekosha/git-po
      Merge branch '2.49-uk-update' of github.com:arkid15r
      Merge branch 'tl/zh_CN_2.49.0_rnd' of github.com:dyrone/git
      Merge branch 'l10n-de-2.49' of github.com:ralfth/git
      Merge branch 'l10n/zh-TW/2025-03-09' of github.com:l10n-tw/git-po

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Ralf Thielow (1):
      l10n: update German translation

Ruggero Turra (1):
      l10n: it: fix spelling of "sorgente" (Italian for "source")

Teng Long (1):
      l10n: zh_CN: updated translation for 2.49

Tuomas Ahola (1):
      l10n: sv.po: Fix Swedish typos

Vũ Tiến Hưng (1):
      l10n: Updated translation for vi-2.49

Yi-Jyun Pan (1):
      l10n: zh_TW: Git 2.49.0 round 1

seoyeon-kwon (1):
      l10n: ko: fix minor typo in Korean translation

 po/bg.po    | 446 +++++++++++++++++++++++++++++++---------------
 po/de.po    | 447 +++++++++++++++++++++++++++++++---------------
 po/fr.po    | 452 +++++++++++++++++++++++++++++++++--------------
 po/id.po    | 520 +++++++++++++++++++++++++++++++++++++-----------------
 po/it.po    |   2 +-
 po/ko.po    |   3 +-
 po/sv.po    | 539 +++++++++++++++++++++++++++++++++++++-------------------
 po/tr.po    | 436 +++++++++++++++++++++++++++++++--------------
 po/uk.po    | 469 +++++++++++++++++++++++++++++++++----------------
 po/vi.po    | 533 +++++++++++++++++++++++++++++++++++++------------------
 po/zh_CN.po | 540 ++++++++++++++++++++++++++++++++++++++------------------
 po/zh_TW.po | 574 ++++++++++++++++++++++++++++++++++++++++++------------------
 12 files changed, 3412 insertions(+), 1549 deletions(-)

--
Jiang Xin
