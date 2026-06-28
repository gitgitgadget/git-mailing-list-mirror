Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834A532E757
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646552; cv=none; b=sTjDxNRmqIixvPzxKIvrIg6HCAwd3qAxbKR5nVWPKceiv7fz3aND9Loh5+vtQHgPvdtGG83UCdS0e686DUYViIcKqiu/2gFCvrJ6mh7kVI2DhRRrvzX6L3Jl4hoQr9VmYqIh/hB3Y4vaJcvYUqSaICfx6srDa+Q1S4GSzcjtxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646552; c=relaxed/simple;
	bh=YdGbkwDB7qH+6dwaTUgMS4UInPcJAUhgsbzTLJuHr44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dg6g3m90tsXMEWRE5mQQZWDcfNoyB0GCcL58/HfKFOzM48vxDTm4ovI6g7F4RSG7767jQ2IAUYCkF209ELWu8GnLVSafCn0BTvVQHRr+3ksLy9H4nS+OIMS9LMl/Tmzz87+t/28mOCuVNXxYqAgC/ZpyGHx7BLUzc0XwQpKSsvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+L4rVGd; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+L4rVGd"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-804e46366d7so20807487b3.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782646550; x=1783251350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yKacdEJwC9vt8u/BkgcANkMehTSQZ32J6TMo2U3MJk=;
        b=E+L4rVGds1Zjy61BlFWEO7MeueVJ96SuGwKDEp9T0c/Y+D3C+xh79NWcLQz7qC74Fw
         epa/z+evIv8zXuS97VMa+lBHjuL6dBlTYdWeMd4lmVXcP9tqmGAdt3bCRIsWnw5tdNAQ
         wgDg0hw3p733GVmd8gfNZt7t0D+kxZvn8eap7sl5xoaWKtgJ3BIkSTxrRGwS2YRi+NqC
         8TY0VnI7u+/P6KT0uH25aGx/AMZThYHpr+IuiYPBZ+EzcgN8BTEz1wYUsP8tN2xy0PEL
         uP+tGPia84mW8T211bgemWxfgo1oPNlf+upVd4dSnIrt9ufEXG7XX2Q+kM1CCECH3Jpc
         zvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782646550; x=1783251350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yKacdEJwC9vt8u/BkgcANkMehTSQZ32J6TMo2U3MJk=;
        b=Q9Z84vHtAcb8bfOSW2OWg3QKrcoD+PRgwO5asDBQ0ykk0CgMIztgQOOH5KGA1+1Ers
         NAhhygsOD2SYNsQQ2IXWjtqf6vp5rCjW9jw/5ggE3ocKtuY77P8jPTQtkazFX5dVpwn6
         5+z/LMgIuoZungZDwA6uqEIpuw/iZ5wazZsdElqN1i1kXVZDijA3DgvWTd9AceFCl/o9
         YbsJkHEwmW0fZpYAgY1rSKKGKFQy+0sKgWXJysW9c+B3oNGvuzXLsrNZPXM9UFTxR51g
         XUDtxfA3oco7lbHefdTT6JfYCMtQldkFwXxXttyMosIALZWwEPwRuZ6YMqCd7EA/jdz8
         6xYQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1SgK18rSapvvMOW8nb8aNjXTR2dlmCnC4rKkgycUlVK/FH8tAXk4CZOk82ROAgtNlsZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMi/Y3Li9Z50q9WuuEzP3u1If4MK3sz9vYnqOAFOrK7WF+GpGP
	Wd2AGy/Wj/F2aqgqJ/+8/+fZq3XDKMshZdwM29dPpyyyuTRqq5BULNud
X-Gm-Gg: AfdE7cmH2KZN8ZrdVNsIAlD7cRkz45Jla5pbDtfkRci7/B6aGZv/38Ndnfsii1LqfzH
	BlEE5OISW4wNDZMpgyIlffRH9xTLS8DQmxpj1+W4wjm8LyjQGAJNgLn/aO2y2KOrJKItYHyboSF
	JBWoxLAyPN4plFCfnmd0ZKDCKyFwKCSaDar+zEf2il9bbwJLjUccBZ58z7iboz9FC8XjVHxGLE5
	lmRynrU0cp0dIds/KflHJc6aNh3pLqGBXEUiRYt8P5Uwh3KzxVlU3HmB7EHufEFij/Rig5k8FOp
	2reYEUVsxUhgc8g/ueSA+/VkgU326c6L4qHjaHtN6aLZxpa6SxNTxdNd2iAPKj3yY/P5FQwYh6p
	TIQNHBt7BoyQdKg2eKqnnJGLtIqZxFBwZ+iI5g9Sh4WY780I9u6UUnNEWzSSvBh9eqEjk5NZbQG
	uFo7nV9zSlnIYRR0xbeOXnUBhkvd9g7FUcwCdLNQSCH0/47Lvf6P9OWg8QVYPve5M1nWyCnSOPR
	85Jo34jL/yIS7tDKoZS6uNITr3epYZM3lQ592Pxr6nS5fg7BnX3oUHg0WmXFm4VJDPmGVTVOY5H
	dL3lGEVXjH8=
X-Received: by 2002:a05:690c:c508:b0:80c:39:1d7d with SMTP id 00721157ae682-80c00391ecamr76125047b3.5.1782646550382;
        Sun, 28 Jun 2026 04:35:50 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80aa19a0516sm39082907b3.19.2026.06.28.04.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 04:35:49 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?q?Aindri=C3=BA=20Mac=20Giolla=20Eoin?= <aindriu80@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Arkadii Yakovets <ark@cho.red>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Emir SARI <bitigchi@me.com>,
	Emir SARI <emir_sari@icloud.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	lilydjwg <lilydjwg@gmail.com>,
	Lumynous <lumynou5.tw@gmail.com>,
	Matteo Beniamino <beniamino@beniamino.eu>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Mikel Forcada <mlf@prompsit.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for Git 2.55.0
Date: Sun, 28 Jun 2026 19:35:42 +0800
Message-ID: <20260628113545.1822426-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Please pull the following l10n updates for Git 2.55.0.

The following changes since commit 6c3d7b73556db708feb3b16232fab1efc4353428:

  Merge branch 'ps/t4216-tap-fix' (2026-06-25 19:49:01 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.55.0-v1

for you to fetch changes up to 08621c32d5536babd139ab1a9086349b3672edd6:

  Merge branch '2.55-uk-pr' of github.com:arkid15r/git-ukrainian-l10n (2026-06-28 19:25:08 +0800)

----------------------------------------------------------------
l10n-2.55.0-v1
-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmpBBXgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMCwzAAoJEJNuFQ3dRTLVKN8QAJfOm5oM21vsH6ONo4QO
u89j0ynacQI0rvQNLa9yGrR7vZumPQQKETwBulWTZLpQ0BrWev69LwpTZFVjQBp0
JxXvUW5FiHKQx+tSPT2SeNkMR3eHWxEFcyCP3QMnAbV5GFRRTnOr9ajRVI/b3Fi3
5xP2dgQW0F8oiuMAX/6osqwjjqO8qAAxtnX/+ecw2KPQ8ddgJsWPdAkWnAG7Ctnu
ff5jxOJ4ECAvsV5eywr2Ea1MOT032nsRX6Yaf6JIfdpU2oZzhCaVXgJwVkjKn/8c
mdEvaEZGSXPn969PEV3bsUEUEV7kgBt5wdWHRX5bGjwfXv/MKVnXZz/OQjlIa/pP
Pzpbi8jRSVCNXBi1kOpqVIOP3yndrYPh103juue5LEwyxsctmmvOtvB2t8Q3pY6G
/baSLDKp8GGi8x0h61D+lGAToK05YWafx95pZlxuwdd27ShJWaE6cknMkirJl9yD
IkihgCWxrCZmRX32YstZsV3FrvsT1GUwLEXm31IHfFRLp+76oVympgQh1r2qttCo
zMRPdo8ECZ9jwZ7OeCjshmAzgGzhuiwURZnYaPG/BC9wKqPDRmaUp8oKSjYreNgy
IuBUt/bOJO/y8ut6KZvMhpbJnOlULrOnHWDWqm2IfY+7+PLSD6uoodtbWf7ISUeP
k4eqg5pJX/q0t+uo8I0Z9Xqb
=M5pa
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aindriú Mac Giolla Eoin (1):
      l10n: ga.po: update for Git 2.55

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (6322t)

Arkadii Yakovets (1):
      l10n: uk: add 2.55 translation

Bagas Sanjaya (1):
      l10n: po-id for 2.55

Emir SARI (1):
      l10n: tr: Update Turkish translations

Jean-Noël Avila (2):
      l10n: fr: version 2.55
      l10n: fr: mass fix of typos

Jiang Xin (12):
      l10n: AGENTS.md: add quotation mark preservation guidelines
      Merge branch 'master' of github.com:mbeniamino/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'fr_v2.55' of github.com:jnavila/git
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'tr-l10n' of github.com:bitigchi/git-po
      Merge branch 'zh_CN-2.55' of github.com:lilydjwg/git-po
      Merge branch 'ca-20260624-b' of github.com:Softcatala/git-po
      Merge branch 'l10n/zh-TW/2026-06-26' of github.com:l10n-tw/git-po
      Merge branch 'l10n-ga-2.55' of github.com:aindriu80/git-po
      Merge branch '2.55-uk-pr' of github.com:arkid15r/git-ukrainian-l10n

Lumynous (1):
      l10n: zh-TW.po: Update Chinese (Traditional) translation

Matteo Beniamino (1):
      l10n: it: fix italian usage messages alignment

Mikel Forcada (1):
      l10n: ca.po: update Catalan translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

lilydjwg (2):
      l10n: TEAMS: change Simplified Chinese team leader
      l10n: zh_CN: updated translation for 2.55

 po/AGENTS.md |   51 +-
 po/TEAMS     |    6 +-
 po/bg.po     |  796 ++++++++++++++++----
 po/ca.po     | 1421 +++++++++++++++++++++++-----------
 po/fr.po     |  836 ++++++++++++++------
 po/ga.po     |  864 ++++++++++++++++-----
 po/id.po     | 2322 ++++++++++++++++++++++++++++++++++++++++++--------------
 po/it.po     |    2 +-
 po/sv.po     |  784 ++++++++++++++-----
 po/tr.po     |  752 +++++++++++++-----
 po/uk.po     | 2384 +++++++++++++++++++++++++++++++++++++++++++---------------
 po/zh_CN.po  | 1034 ++++++++++++++++++-------
 po/zh_TW.po  | 2261 +++++++++++++++++++++++++++++++------------------------
 13 files changed, 9725 insertions(+), 3788 deletions(-)

--
Jiang Xin
