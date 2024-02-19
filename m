Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D213C37A
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708304512; cv=none; b=Cjmg4x55HdeCZ7uyNAv3Hwx1sY6RuXtrBsDkcl6YrhuHX7Hagm205OflV+kQ6j52F3vp9fZQyDtdXVakNXxeIWIucX3uebU5yqS+F+y7QR5aKsPp279jhYlYznkqKcwwM9zXmlUlzsfFpyr0TybCFsp8OOO/U34Fve2W1YagEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708304512; c=relaxed/simple;
	bh=1lZPpULqnAkkl1RVUxF4OR9XlNu/s6dEEUE/od0MgwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NvQMIrrSAaadkA2ip0sWGwY37ocUTt/52jOLg1NxRXz4oryXggVrprLtX7EGjBEOdCmi6TmwSqjmqEDtPaY3SA/62FLxI4A1o1e3QkMonJctzfO6EvV3P1x/1GeZhZbHkRw990cxeTyq0/zYg0y+Jyq8f7PyjEtL0UJ9/2WpsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUv+nYZi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUv+nYZi"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-296df89efd2so2018250a91.0
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 17:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708304510; x=1708909310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc7xyhF8fbB2siG5huQMcHG53qJpmZ75zI0F4zwwfoQ=;
        b=cUv+nYZiLnR82hkGmg+FIQ7VZ2bw7OH1w00TE2DjTAvPJMrOBnpl8cF1T9Yt6ldzN2
         4v7HzjWOy9h0pmowfl4ieFn7elaUtHxDrk894wfjB9O8ROXTja54gwjumU1JyYZ8WjkV
         2Nlop4/ujrMYsYJHXKoQb5sLxwhL5q3lA9ioAq5INV5yrzVcoLQQHz4g9Ua7KDDr03Uu
         wkKwI5qY6w15TeROLNri8PpnI4Gji5h2vnmdMDRzNCMVJV9Bq3hBqYB9nuUTn6NS2Nb5
         QSU8rE3uVvto+bU7vwVh0CKZ44Mt0pUsMebe7gbnjW05bgQJeStRO7dDS4pvKCe5ZXqe
         YPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708304510; x=1708909310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mc7xyhF8fbB2siG5huQMcHG53qJpmZ75zI0F4zwwfoQ=;
        b=gDktMXmZqAHKSNkXfANXoOZ0E5qAzna5XAZct2mI4IloNv7VHV0e8LU+t5stMc6YCJ
         k4AxqDlkeNIziDLkqHNmdUeKYxLFBBkihWTOzg+MpZ1s6euilA3gi7pf9biln63rfdCe
         bNR/bu0nlIFHy/yZzpM9TO4++1ZZmZ9I2malX1q2X2hgHC/Vtjdul0ZqV/6zrmX69DDs
         cLeR6Lcf+qaQcsNaddHaphv58wH8hKEneMlmGERLhGrLYocihG+GjVrdWDneaxLoJie7
         mXiZXJJEJVbZbQXhnxMWhwfA5XP6FL8u81XIk4CDaaOi6lKlbEsNqKxNZPSdC6+HyrfN
         l8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYFdYBOZvnvCf24Xyvhax/79HxudOJIY4P4HIN8xCCzZ1EXZ9D0G25+Mns9FK2PKDs83K0PSP6Qis+4FUFwwobIAUl
X-Gm-Message-State: AOJu0YwYvvxGi85XQVmRE3+bSilEVKu2aXs8WB3AqOYGDwKVd/HHrGsq
	yKsit1Z5mI1N8PHYgEP69ZQ8UnHYyaJUSd39z48fXOD8cO9lv6AP
X-Google-Smtp-Source: AGHT+IFw6mbF17RPQ4VuNtvMj0TejIkWI+ucnwNuMNcDkJ6wIozxoZ1vRfBgxa+sNaaAAJ1PWP4arQ==
X-Received: by 2002:a17:90a:9f95:b0:299:5fed:bcae with SMTP id o21-20020a17090a9f9500b002995fedbcaemr2815664pjp.5.1708304510004;
        Sun, 18 Feb 2024 17:01:50 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id sb5-20020a17090b50c500b0029724370ea9sm3858756pjb.47.2024.02.18.17.01.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Feb 2024 17:01:49 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Arkadii Yakovets <ark@cho.red>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Emir SARI <emir_sari@icloud.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jordi Mas <jmas@softcatala.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.44.0 round 3
Date: Mon, 19 Feb 2024 09:01:41 +0800
Message-Id: <20240219010141.5616-1-worldhello.net@gmail.com>
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

Please pull the following l10n updates for Git 2.44.0.

The following changes since commit 3e0d3cd5c7def4808247caf168e17f2bbf47892b:

  Merge branch 'jx/dirstat-parseopt-help' (2024-02-15 15:14:48 -0800)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.44.0-rnd3

for you to fetch changes up to 5fdd5b989cbe5096d44e89861a92b2dd47c279d9:

  l10n: zh_TW: Git 2.44 (2024-02-18 21:03:43 +0800)

----------------------------------------------------------------
l10n-2.44.0-rnd3
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmXSpeoACgkQk24VDd1F
MtX7RA/9HXk19TQPI/8YHL2Z29Yax2yPcgy+kq/UzXJ3YbNAsEBZyLwqfkv1bi6h
S67Ggc0tmQdE0BDDAwG54+kzCUnRh6WFzHXyU0Mazena+7kxRuyCdmKNj9a9W7Jn
2NLiS37a8KB83nlUn7coIrbFfs7P80J50Ax6oJFSPTEqZM8unNw/QEitufodaju2
XdAbO8wofZZDn+i+HiCQnUT3loV8XxJdCk/ZM7RMtLRLzxKx78GsazLjkbYG1ci1
4yAw3A6M+w1AvppplToZiH4JYvpMg7Box4tow0EKcYL5yOMk9tx2kVAbc26Mpm4Q
IrADtuilhyHr8UI/VrD1frkNW+BByaE3WAJ2IgSzFmOv2eqe2aVtvkmga0DG1zyl
P0ZGAKjfH0cSpEvuG16XGHYQjqp/ulWDedx9bdFJg2iFnjHj7F2DEubm08tUW7OG
cNs6uYGTyfq9VLtvc4qIHFQNtMrUtnYETNK1Sn++11CYWoYpFzdUk75oEB8SkxYq
JPn9xFbhzz5K9vKE1jAp1XIYLaKwD1up71VPCL6bhHyOwvgJ1RcWtbK+h58xqGAw
n+w5epstdOGeKkmtrpYC1R6Y/ejckdk++/K8ml5owFeQ7u1l1zNsonpf9qtjnBLI
utf3YmfkfBd767kAqfeqdcjV9+hLgpaegl8ElWChRLOushfhj18=
=ZD+B
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5610t)

Arkadii Yakovets (3):
      l10n: uk: v2.44 localization update
      l10n: uk: v2.44 update (round 2)
      l10n: uk: v2.44 update (round 3)

Bagas Sanjaya (1):
      l10n: po-id for 2.44 (round 1)

Emir SARI (1):
      l10n: tr: Update Turkish translations for 2.44

Jean-Noël Avila (1):
      l10n: fr.po: v2.44.0 round 3

Jiang Xin (12):
      Merge branch 'master' of github.com:git/git
      Merge branch 'master' of github.com:git/git
      l10n: ci: remove unused param for add-pr-comment@v2
      l10n: ci: disable cache for setup-go to suppress warnings
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'catalan-l10n' of github.com:Softcatala/git-po
      Merge branch 'fr_2.44.0' of github.com:jnavila/git
      Merge branch 'tr-l10n' of github.com:bitigchi/git-po
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch '2.44-uk-update' of github.com:arkid15r/git-ukrainian-l10n
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'master' of github.com:ralfth/git

Johannes Schindelin (1):
      l10n: bump Actions versions in l10n.yml

Jordi Mas (1):
      l10n: Update Catalan translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Ralf Thielow (1):
      l10n: Update German translation

Teng Long (1):
      l10n: zh_CN: for git 2.44 rounds

Yi-Jyun Pan (1):
      l10n: zh_TW: Git 2.44

 .github/workflows/l10n.yml |   6 +-
 po/bg.po                   | 391 +++++++++++++++++++++-----------
 po/ca.po                   | 466 ++++++++++++++++++++++++---------------
 po/de.po                   | 392 +++++++++++++++++++++------------
 po/fr.po                   | 427 +++++++++++++++++++++++++----------
 po/id.po                   | 485 ++++++++++++++++++++++++++--------------
 po/sv.po                   | 358 ++++++++++++++++++++----------
 po/tr.po                   | 380 +++++++++++++++++++++-----------
 po/uk.po                   | 429 +++++++++++++++++++++++-------------
 po/zh_CN.po                | 538 ++++++++++++++++++++++++++++-----------------
 po/zh_TW.po                | 531 ++++++++++++++++++++++++++++++--------------
 11 files changed, 2894 insertions(+), 1509 deletions(-)

--
Jiang Xin
