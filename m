Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36D1A704B
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776597104; cv=none; b=odzWA9wu7Kdjgw6NAZktfQHwLTQVi9kPZHlHnlKfeAleIg4KsB13Q/2HQYjuqKeuSPMBZjhWOSdIXQgyWXkEtHs8flSUGq9NKfK8aY3kJ1ahvrNqGmevct6xDQKLHFLEZKWDmi1VqKCgEKcopgGkJ9utn8xGKHE6s21NFN0hK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776597104; c=relaxed/simple;
	bh=6tLkElWvjhwMrQ+nuChnFz4zUaLpVElFwAS8wGrZxoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ja1JuzWPvC9inq8Roal2bWY/eVtxzrAk97mQtSNnxz8Q9qsx609nIGB1zaqffXD2GiLjsp9i07lXXp4ryYaQu/PnHkLyh9agFt6czTW14Zf9IqmUxLWFsfsJpv6Cv36zAGeOJ7Z8rdDlMbGhSROXeoKt77t84nfex0v8UIpXztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rzd/o0O6; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rzd/o0O6"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7b186dfc1d0so28050717b3.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776597102; x=1777201902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLVtIrPPq/Eheno5G4KRPXLjIrhN+EaiWSNT0o8WVTs=;
        b=Rzd/o0O6QMw2UBCnfmhwV6DNw916tHFkR66X4pXH+P9v9QY8aNBakET15CVOhPC8t8
         M9/P6IVYi10NeirhhUth4MafHVKsOgjyemEkAkZ2CQN2R8/YG1mQ0n2jFhp1cKROMhtw
         r9zsUZvOs73OhCRqlYGDpfvokRcWiX6c3lsIvHCKGNcuFpA3+RzKE9G7vaMmvcO2YAmk
         4ZqZrgxr8DxfSkdYtof4IQFwzf9T7A67ErQAUoEWYQAMA+7KYp+6XxqriYCHslVxHhlB
         ew8yzzKen1spu+/c84EiIoMStZucb2oO+xM/hhPQS4ZmueN62QOVCMGWJt5YJ4vVRA0b
         N61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776597102; x=1777201902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLVtIrPPq/Eheno5G4KRPXLjIrhN+EaiWSNT0o8WVTs=;
        b=A0x2lba2+cvnoyEmHqVZtqnI71o9stwjk+H5yjr9Ydw+uyb+/Uy2QDeplQtRm9D3eQ
         h2y3HbFoPJKN8YwZ9iAl/dfteDqiRqTC0AXfIg2iPGxkFNv18PYeBoA5fmIIpXrpyf3C
         xvsdWqbRRPQrcsy86ODTzQQ8erHc3uuVAqM04eTEiIPRLCMnkj64OH4LdIw+F4cFQE7J
         CXO01Op86XUVfZ7dNwvhNSsmafPwqhx0pSZdZgVQG+8cZyXKGLEP6L6ZIMjaTq61pn6P
         DB9lcEtQIzgWqfzDIvK7jmFPYZbFOMmqPHXKft43mu593Hko+knTcu/zLkhA/BJYRNa1
         noqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+q+VkBJddaZ85wOBbNsR1TCKB2xEr2f9/syuFUqa/2QW+ifDO+vIJWZsg9i+MzbFd+zpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUgwMbH6pWrXppDJ7dQyCUNlx454dooeb0t/O6Cufe5LHPwIZ
	vDHhTno9B/lecmRI7eg67HDvHUMtwkH6M891TtMKFQD4J/KgwJSow6bb
X-Gm-Gg: AeBDiesMaAG0sMOmI2mMkPAtPYw8NPBZ+rW0BIGIo+aRiIG867ubvxmoeTnrSLaik3X
	Lk/iyjDLcWRP1raNa6xCM46d3cJPyHDzVrB2BbGMB51uWTRatQv0Oc0NNXxo3kCWsWRZno/QpGj
	WRjmwjKDrcdaJikhgeO7fGZoqGFzuXTzEvf69E+uiILyesHwqzNBkpgyLtCU/wmSho83IkdaWqS
	+aw7V8WPwjO1tLtU8Iw94S5UcpJELJqXZ/gYgaFTTSls0mYHne+AHV2rpWzPcuiUxvApIWNibzm
	DFyTv7PLhgaqRewy4A4XfedvvqAK82sF5dm3qj9F2g+eNCEbaM5XRPmEyRrhlbANt4DhUO4uWqc
	M8cfvxITIDm7N1NpVMmtxPSyKlZwkqjs2fp3bCIflBillGREeNBdcO4+iQIgC5zl1GVYKr/0E2V
	ewDdd6fnIK2XYxqxONwYpn+F4X4gZx+LDigzk9Hnct+VR7vgUYztm+AGLwlMn3FVao5Qqtm8g8e
	sV8eV8cKLZpMUpqcfKumH56maWNJhx2TwZHAvRz06rEBecq0HICvR3EOR+u7cxJFIXKGvtMMGO3
	LdHyRWrVdgNJRlJ+JwsH4g==
X-Received: by 2002:a05:690c:3181:b0:7b4:ad41:482d with SMTP id 00721157ae682-7b9ed276d75mr69823897b3.3.1776597101818;
        Sun, 19 Apr 2026 04:11:41 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9ce50fsm29868697b3.47.2026.04.19.04.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 04:11:40 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	A4-Tacks <wdsjxhno1001@163.com>,
	=?UTF-8?q?Aindri=C3=BA=20Mac=20Giolla=20Eoin?= <aindriu80@gmail.com>,
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
	=?UTF-8?q?Stefan=20Bj=C3=B6rnelund?= <stefan.bjornelund.gnome@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for Git 2.54.0
Date: Sun, 19 Apr 2026 19:11:31 +0800
Message-ID: <20260419111136.1577323-1-worldhello.net@gmail.com>
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

Please pull the following l10n updates for Git 2.54.0.

The following changes since commit b15384c06f77bc2d34d0d3623a8a58218313a561:

  A bit more post -rc1 (2026-04-08 11:00:10 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.54.0-v1

for you to fetch changes up to d0ab4e83765b7c68a88c1d2e8acb58dac392cf99:

  Merge branch 'fr_v2.54.0' of github.com:jnavila/git (2026-04-19 18:41:17 +0800)

----------------------------------------------------------------
l10n-2.54.0-v1
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmnkthEACgkQk24VDd1F
MtX14Q//S1lIO8jrnvQEmmdq4GKMIl9pkUX/lLwxSNhVNyUGvpV3xLghDWfjo8hg
yTVTDzeh5lOyq8ZA3VdUgzCTXBzt09j/IooOrtxQptZyfKAM8aYaE7GIWG/hCAGn
cC/aTtc/eajKur/16z2Ku64IOiWbO3B/lAUfcvg6EqqvBXxW0NYADfGrmZIXZI4b
dLkdVg1bGwoD2xIPAR7HUDR3mYbzcjHK78pAF562KGBJn4/4wHQ28ZMpiYZ2F94R
IQVm1UnOf7JGVxjVHx7SobeV1CApfL5DHIZafyt2QI+7f2FwKGfAD53NnjmzzDKR
2DVZTzD06CBpOIJ/deSkYQ8d4WrCVFaYI1MZ9n8dhYIZTvjXI8Y6XYJxomFX/K3U
meTQPbXZfdiPWVL+H64jYmwcIVQphSpM1S2I5qLpjgYVLRkZItvPoflwjrBuvhkg
SGDn9sURnEhvKtTul9PseArRt8VK+NKiFT/6stvMY6FFFF/jRg+/jISKz3YznPX+
Up8mv78mfxtOENZ3G2xOsU3C+IdnkagZA8dpOJGDKHpRKxGtbqKEkV+YMH7czLK+
mEyJ8uEbcFdS8h/VpeEZV6xOAYLCWDI1APRGD/+2sjJpFpPs1vMOVbCHWqnnYHwX
yW5ATIf1p/YrGRs3YSQbOX7QwZWZnoqd0B465Dsi/Jqlc2LPQGg=
=i2Wh
-----END PGP SIGNATURE-----

----------------------------------------------------------------
A4-Tacks (1):
      l10n: fix 'zh_TW.po' 'Applying patch'

Aindriú Mac Giolla Eoin (1):
      l10n: ga.po: update for Git 2.54

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (6226t)

Emir SARI (1):
      l10n: tr: Update Turkish translations

Jean-Noël Avila (1):
      l10n: fr: v2.54.0

Jiang Xin (16):
      l10n: add .gitattributes to simplify location filtering
      l10n: docs: add AGENTS.md with update POT instructions
      l10n: docs: add update PO instructions in AGENTS.md
      l10n: docs: add translation instructions in AGENTS.md
      l10n: docs: add review instructions in AGENTS.md
      l10n: document AI and PO helper in po/README
      Merge branch 'master' of https://github.com/git/git
      Merge branch 'master' of https://github.com/git/git
      l10n: zh_CN: post-2.53 code review
      l10n: zh_CN: updated translation for 2.54
      Merge branch 'zh_CN-2.54' of github.com:jiangxin/git
      Merge branch 'tr-l10n' of github.com:bitigchi/git-po
      Merge branch 'apply-patch-reject' of github.com:A4-Tacks/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'fr_v2.54.0' of github.com:jnavila/git

Mikel Forcada (1):
      l10n: Update Catalan Translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Stefan Björnelund (1):
      l10n: sv.po: correct various translations

 po/.gitattributes |   35 +
 po/AGENTS.md      |  877 +++++++++++
 po/README.md      |   98 +-
 po/bg.po          | 1606 +++++++++++++-------
 po/ca.po          | 4215 ++++++++++++++++++++++++++++++++++++-----------------
 po/es.po          |   34 +-
 po/fr.po          | 1244 +++++++++++-----
 po/ga.po          | 1457 +++++++++++-------
 po/ru.po          |   28 +-
 po/sv.po          | 1351 ++++++++++++-----
 po/tr.po          | 1368 ++++++++++++-----
 po/zh_CN.po       | 1454 +++++++++++++-----
 po/zh_TW.po       |    2 +-
 13 files changed, 9891 insertions(+), 3878 deletions(-)
 create mode 100644 po/.gitattributes
 create mode 100644 po/AGENTS.md

--
Jiang Xin
