Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B9D1F16B
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736927; cv=none; b=rp6woLQoDv0MwOmpzizBV19MeQaeWFsiMWhfgrPKaPq5bQ8hNxpaVCjiKOysu13dCA26MJmvXwWall09VAhUSdy8m7LVrwyoGhw81dEiBTKW3dEPba6vqq3RnQe3Xoq8ZK6vKSGNlpg0OAcgTLP7lLC3MQ81fhRH8/QFqwb2g6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736927; c=relaxed/simple;
	bh=bRVVYLCcmWlWDm/o9mNqegbTM/hxh51zDemdjwx9uqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HCkaYrL7BL+JfgiHLmwdjBWEEkjhXRVbm4vM5feSfhmUGJUTBNKvb7EErN85uuGuQiSzjyi9AkINWn0zvJxpRkKTJgF3EDnqITB+JlvnlhWf5zLg6UZ8fZcZ6F95gc8NUUvmfsPrQO3LEJBC+s7ebbofq4IGzw7ssRTZKrhSSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsB2ScTC; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsB2ScTC"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70f147b5a52so6857187b3.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749736925; x=1750341725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/qO0FE9G2Ckdn6H8fIjH86IVXCVeuVUPk2BR0qa5EY=;
        b=gsB2ScTC9E3+ijeJklfaWFdM37spx1TqNCnDw5kqiP6pwCMWqsY/gEJR3/IBBK+/Wj
         rImAPS0AEnxAG7Hir4MaGtP7Lm3NYUBHGNQ0omLSDvs0v4TY1xRHz419kFuH3WBmBUn3
         K0wFa1HPU4h+Li2VzkF8Aa7BNprsWpUxY9JuvLqWpPvLDWMolcJwVHdAGffxu48/6Hfd
         1C6EYXuQ9Sq0WYz1sgPaj7fISrIUwglR0HU8Zh65xwutcqi7YP6mTSacU7MikCsc4YUc
         BlV1cpjscUUmlrGdrrfLR1/ti6qQQ+D6lWW1jAMVlAqiXzyDJTngEOtA56YEpToqvvNm
         RHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749736925; x=1750341725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/qO0FE9G2Ckdn6H8fIjH86IVXCVeuVUPk2BR0qa5EY=;
        b=p7RkZq/D4jfmGWtikV0CIHcuBusHqdrYts1NZvCK/80uIlY+R6UZQeKtXJPXgDle7i
         2bDb4HOv2+c6UP0b8nqEEtIhERjjNNq210cP7VGhZZX8wRn9X20csw8/hFtVae0bAF65
         OOFkSdwQYFmcR2MWuS1LrY/O3b6Adf0gsZap/Vth94iFCS+UdFTRuy55xn2wSGhVWnVP
         5JBmavpzgXYR/7HfAntPZTUnFVr2t0kmlPsQ7+Ng4QTSmjrxP+0mJRLtEhdo7+FOmB9S
         646kZ+oqSMr/6yibLlpLX/WeDS50VIqQJkxm0QPWs16LKp0k7VPBe+D9Gn8J4Zy7xOED
         W+3w==
X-Forwarded-Encrypted: i=1; AJvYcCVkIdht/4jNquAJvekdNvBPxR40v9MyvfOEkgQvGS/fnJGfufD/amKLc2z/YZQUm5orQrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrlMUAJlDjGSBFsJZGQdiL0jqQ1f9nXBullCfq+tLxlXtYDvw
	PsypGkj69UBzNpihPDGgOrMrVkSILg9clPlobJ1Lpere5LAjeJQRgf+n
X-Gm-Gg: ASbGncu0pJvpqX68AH45S4AdpY9jvCGKaqLmHt10xqK5kK+J3gis4pAEBA+XMcRvze0
	z/yr+PyN4CUge13hZSE1Co1ouAXcdRfHXywgRAlDepvVsVaglyhnVwGDZJEtrbOFKDQs7cSofg7
	utoNN2GZhLctu6HEN9sRFfuYIabUD79NoqajyychJVuyGQYBsrmTysX+uZmyQj8WqNAsnXT+gH3
	/DvC29x8JwpBJO5grtNXaC7ld7kgzuBJqTxUXtnbvoPyVWTotQd7NFfiZaCyiLQRY7UcxBJaL3C
	ghv+IjNdKlgpvAtGYmFNAg0+4cR14nIVpQ/Xj5An6xnh+DHIdziI24LcDJu9a7EgKX98Fn0WqMa
	zo7lWa8VwoGdVm3fj5Qkg6/Vr2z1Tahc7YJLRK+xjNttpow7c
X-Google-Smtp-Source: AGHT+IFDFga7ohOpVwAgd5Xcdw6XpAywQSftIIZxZDWF6fD8q++IIkVouPz3t21/qK3wSzf7Iv+QbA==
X-Received: by 2002:a05:690c:620e:b0:710:a3d4:ed39 with SMTP id 00721157ae682-7114edcb68cmr56571937b3.35.1749736924607;
        Thu, 12 Jun 2025 07:02:04 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-711520919adsm2778687b3.26.2025.06.12.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 07:02:04 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: [GIT PULL] l10n updates for 2.50.0 round 1
Date: Thu, 12 Jun 2025 10:01:57 -0400
Message-ID: <20250612140159.164902-1-worldhello.net@gmail.com>
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

Please pull the following l10n updates for Git 2.50.0.

The following changes since commit 4c0e625c091d4c648cec7319bafaed3cc81658e5:

  Git 2.50-rc2 (2025-06-09 07:18:49 -0700)

are available in the Git repository at:

  https://github.com/git-l10n/git-po.git tags/l10n-2.50.0-rnd1

for you to fetch changes up to 925035958b366eacad03dd6abc399af7ab5db810:

  l10n: zh_CN: updated translation for 2.50 (2025-06-12 21:47:46 +0800)

----------------------------------------------------------------
l10n-2.50.0-rnd1
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmhK28EACgkQk24VDd1F
MtU1GA/8CmvPedvJVqnaikUJTKRxrlyiqKkI8fAKqvqulubD36yI7QjDP4PhDKHA
hK0uvJ16n4v4xp2aIATnD4E3AH3ocrjU5xzK1pqd26cYWdObKZeDpio/FQrEcJI2
uPp+BHRnOVwg32gMHOEhry8rGtFlsZyCtoRSLPVPAN6Oy+NI4MfqJcN+FCtyWg5p
oSTSwwbCXwUiuFXBjFgsCzq8Of/WRYr5cSfq/XCjz+0Gk57aLaVjnsVExxO6VwwB
F5cdqbwuwbR7eGr3WJSGerNTfs4qKbVqbsxNDMLllI5OW/Kzm07nOdxNe4daoSbj
9+DsNuOAe5mOdi09wx09B3QAMFiHOD8gJcTT4RbRXV+Fi3OZg782jIEzGKFmqccF
7g7m74qsjk5GlswSXI8/l1l1mSPhBk4s6fcUkgF4aqO3F2QMIlCorEz5KE1J9H9R
Xu+sMm46jLdCeVuz5obirE9XKOpdTlH1FQk02guskJgvCrXrmtzIBX6eYIUxewCO
jyE4MYrVeY0PnIIMHMDJ1L+mg0hs6zyPjXiU7BQWHyYgLOQTp7q71slIYarpkj9o
Md23cJwBhJV/lUqwuLCu6SwMBZlinYEN6QunRDbzl2oMBJjwz9VmrXbLzfqXujz4
+ycA+efgGCN3JBU7qrvBME+jkT8dxn+4zoPFzwjfaXK2W9xXwbM=
=O2DU
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aindriú Mac Giolla Eoin (1):
      l10n: Add full Irish translation (ga.po)

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5819t)

Arkadii Yakovets (1):
      l10n: uk: add 2.50 translation

Bagas Sanjaya (1):
      l10n: po-id for 2.50

Emir SARI (1):
      l10n: tr: Update Turkish translations for 2.50

Jean-Noël Avila (1):
      l10n: fr: v2.50 round 1

Jiang Xin (7):
      Merge branch 'master' of github.com:aindriu80/git-po
      Merge branch 'tr-l10n' of github.com:bitigchi/git-po
      Merge branch 'l10n_fr_v2.50' of github.com:jnavila/git
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'l10n-de-2.50' of https://github.com/ralfth/git
      Merge branch '2.50-uk-update' of https://github.com/arkid15r/git-ukrainian-l10n

Ralf Thielow (1):
      l10n: Update German translation

Teng Long (1):
      l10n: zh_CN: updated translation for 2.50

 po/TEAMS    |     4 +
 po/bg.po    |  1314 ++-
 po/de.po    |   685 +-
 po/fr.po    |   916 +-
 po/ga.po    | 29758 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/id.po    |   837 +-
 po/tr.po    |   724 +-
 po/uk.po    |   649 +-
 po/zh_CN.po |   825 +-
 9 files changed, 32401 insertions(+), 3311 deletions(-)
 create mode 100644 po/ga.po

--
Jiang Xin
