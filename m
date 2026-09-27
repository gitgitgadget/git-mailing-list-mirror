Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009039FCCA
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790514113; cv=none; b=j0Y5EpjoPjZmulEl9/+J5iUZkNIn/ofusj0okSKWmU+P3QBAgoBSPB4DBUaTeAFuvNXIcqhVPljsK2V17QKabVJeGBBk5WEru0VkOW0mp0AT2eJRpeakQydeC9sVigLFx49SaMQZ78UFxKrJBodPAp3i09zUtJzP7GA8bG76PoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790514113; c=relaxed/simple;
	bh=2EGzjheQgxuMFJ60mVJsBmqHIjsWwGYMQJibbEsHo+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I3okxRYLXYjpieYBoLgxpug+rKF008/863gvMXc/VWr0CHeC8wU7oYGvZj6cEZeWGdz/dQP0nyIuzDG7I29JCjWV2N9nVbv8LVth9wPManBJCDJcZMkv7Go72NxSpHp0Z5JXNpu51fVAhCsbTuyN+8lBvtksjjJ9FoAd4OqTqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imtpnXp8; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imtpnXp8"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d5303884so1391678eec.3
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 06:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790514111; x=1791118911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AQXoW0lBLbtEjX0FVJhb5lRkyZriWMJ4HMWUFuwKl0w=;
        b=imtpnXp8umEq+KKoDCd1SGQ00KCGlkAPlTgjjKIrT+DVwtZLiXGO/zcNMNnd0qVfSb
         4QKhxcJ3duR7nZ0X6y8TOCP5JCGtlFvyCPtFW8GkBIB7XgUuTrSI8bnQ84xDo8ZGm1T1
         UeqlgQFXugTX3ud1WVZvcdhgc13LO/L+ca0zVF+5Ka/NKSIkkdmTmszHHr8qC5A4pPgi
         Fj/uWAcD7027G/d209GgcAu09njLGiH8TSLUttyapc7oWe7DGNeXF34LzXVdOTmb9/+k
         sU89qy5rF0vB5ydKNHG8BZ8vN6W0JxIQShAqPVyZmTTHf5Vlk0atf0PyPbYC/NnDm9GG
         BKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790514111; x=1791118911;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AQXoW0lBLbtEjX0FVJhb5lRkyZriWMJ4HMWUFuwKl0w=;
        b=Bvz9Nl3Q3GRsL+2rjH89wMNPxwuf+SKT17uWZ/I2IV0fQKkiiaFD4NwfOSQqaGDHIh
         QSIFusYRcla7qGD3jIN9ImXf5AugWXoxLOjDtLJn9Gcn2SKqEqRapuONb+qzwnpSeP54
         1uX+0qxVoyO0KO5j8ilulte/M2OUauCuNI5F+pLNeFO7u7r66VrN2qxM0Kb3JQQAZZCP
         f6aB7JX47ykQJKD42tm0DMehL9hb0JY4vE4xTqTbzJ248bC/8nUdkxQA6qLNhW9xTGvs
         mqS+I+W5f8D5Es8c8NgxPePwCQYS9jUvxuN0oiyLupbNk/FuvYcTQ9q5Y7jLJxtsR3gC
         fbew==
X-Forwarded-Encrypted: i=1; AKwUvBzpuIVwhrrBotSaI5mWDaAJQz/fSCI371/f9ZCGufp8UAJJn0fU2M48tzCIjMeuboZOgmY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/53p3BWZYbT1jhPoey6aj3geYq3DpBBtaIL2eiLeGjJtvJX4K
	kcP5r1TnPo3qVsCFj7SW9OtdzTBVyVDyUwV0tyMDfS5WaH/UaO0Ohy9X
X-Gm-Gg: AYBFou3oaI3oeA5XGLsarjR7cFPg16mO8MG+rR+XI64ea/HgCILDbdWAL66UyOkR2PN
	iuK+2zTuGwqx4FWV+LE0nd+0F+uvPcacAglVEYcQsd/lOaTQ7VAVO8agR7rWvjRtjSl0vzTVLAf
	pmtUIBuO/BzcCJ8frA1pwAMdPV56aAxotWGkXlQlg/7TJuSbfg1VlnXGl+WVL5r/g7RFBQamIGq
	DglmZg4rW7bVuKoI0P7VMQmUTCtTqlYOQqYbDuNGxaKH+URcGQFWSN6nOtk/Cd78l8Qgw+hUo/9
	xp0XZ2SiPJD4a6rySNiK3jJG8diw0ebn4a8oM7/AHXq+SpgSQXZijY5y5st7mQBzV4O9Jkeokf9
	bLqXz8yoSfYTpscDg62Z3iRyRD7uOMBzLNBfacUR6UO1P4NxhbcLpT9EBdqoilhgHapa9XC/HyK
	IPLF3Q033k+GECYDxu8tVmqoyV93dke7z9dLQUXoROh0UUxBT0HylQ8TxTNvwxrDShTNz14Qk8O
	6Myr+NZjg8ciTgXNiqXG0vtao7CMd8A6kYz/kpyAsTTGdZOW8sVXltNRMiyO5kDprbJIC6oPXkv
	9ikBeL3+edx1/DuqjxBr4doQxjOr7C7Ifv18oJYDShg5UXNaKe+XYmazsA==
X-Received: by 2002:a05:7301:687:b0:33e:64bb:e5d1 with SMTP id 5a478bee46e88-3427265e212mr9612479eec.34.1790514110774;
        Sun, 27 Sep 2026 06:01:50 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341460f5166sm22687306eec.29.2026.09.27.06.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 06:01:49 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?St=C3=A9fan=20Driaan=20Turvey?= <stefanturvey1912@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	=?UTF-8?q?Aindri=C3=BA=20Mac=20Giolla=20Eoin?= <aindriu80@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Daniel Pereira <danielmaraboo@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	=?UTF-8?q?=E4=BE=9D=E4=BA=91?= <lilydjwg@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: [GIT PULL] l10n updates for Git 2.56.0
Date: Sun, 27 Sep 2026 21:01:41 +0800
Message-ID: <20260927130147.45096-1-worldhello.net@gmail.com>
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

Please pull the following l10n updates for Git 2.56.0.

This round adds two new languages: Afrikaans (af) and Portuguese -
Brazil (pt_BR). It also updates Catalan, French, Irish, Indonesian,
Swedish, Turkish, Ukrainian, and Simplified Chinese, restores two
translations reintroduced by the upstream revert of
en/no-amend-during-conflicts, and refreshes po/AGENTS.md for the
localization workflow.

The following changes since commit 0f8e75abebff0877cae681a3d5ff31ac47f54220:

  Revert "Merge branch 'en/no-amend-during-conflicts'" (2026-09-23 11:18:51 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.56.0-v1

for you to fetch changes up to 14a748f8522dd86bb0d42f435bab8fd665bb864b:

  l10n: af: fix review comments (2026-09-27 20:41:50 +0800)

----------------------------------------------------------------
l10n-2.56.0-v1
-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmq5EJkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMCwzAAoJEJNuFQ3dRTLVNygQAKBKbnyl5/UZGGhbkWTU
p86/q4gBVmI+icmE8Zx4RfP3KTjTNP5ajPVgF92MUt1WjK4r6lmNQT9GbQa/BfP0
L2ZX5z2irN1GwnrUuWTD4/gSlO3vj2B3yFZPjMg4EYK9ba0PwSew5X5lbyYM67O5
r4roOLO3NkLY/nrLMfxMqrWJGfRt+XP7yqvLwdpc6Nft/SrhM4WerTxXKkW0nqcx
0EHqgx5a201UX434qGKKCUOpH+oYZoZ6IldstzDsd46GaWEKoIAiUy52A/UWF+wN
+rWNBB9VDspb4rwVeJlY4mNbHChfkycWFXt+XTjU/+f7zAMCsEHK64AR/yWBjq7/
6NbHZnOI1jh0sARewzJT7EVEzhk+yC1qTnqllkSp3vijemVJ2KU8VmBJPnk8lIPQ
rHCbmuAdkBxtDXNogSN9WimTF0V9tXcEf7VG6n2T0xFqM71mvTQmZ+MghD0Vre+L
MQotkqmpxk+hkTi395M/08tOTR0aNbrMzKFe6hvxd1WL4BM8FUwDQSd2nY20udlY
nZlIuxrGfgKvdxI+/GtZekzwOiKVk0MfB3MJfrfLtd0MHGo0eGh4PaawH/oR+1ak
u2abcrut88q29xi8nu0Fq0e8zJojUoZKRO/AWhDXoIVNM2yK7vHNJbfxZGeT6IZ6
wAsUsuLZBgL9mXvsXDl5F25e
=rheU
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aindriú Mac Giolla Eoin (1):
      l10n: ga.po: update for Git 2.56

Arkadii Yakovets (1):
      l10n: uk: add 2.56 translation

Bagas Sanjaya (1):
      l10n: po-id for 2.56

Daniel Pereira (1):
      l10n: pt_BR: add Brazilian Portuguese translation

Emir SARI (1):
      l10n: tr: Update Turkish translations

Jean-Noël Avila (1):
      l10n: fr: update translation for git 2.56.0

Jiang Xin (6):
      l10n: AGENTS.md: fix counter fallbacks
      l10n: AGENTS.md: require git-po-helper >= 0.9.1
      l10n: AGENTS.md: count PO entries with git-po-helper stat -c
      l10n: AGENTS.md: use JSON intermediates in workflow
      l10n: AGENTS.md: zsh-safe review result cleanup
      l10n: restore translations after upstream revert

Mikel Forcada (1):
      l10n: Update Catalan Translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Stéfan Driaan Turvey (2):
      l10n: af: add Afrikaans translation
      l10n: af: fix review comments

lilydjwg (2):
      l10n: zh_CN: updated translation for 2.56
      l10n: zh_CN: adopt review suggestions

 po/AGENTS.md |   214 +-
 po/TEAMS     |    10 +-
 po/af.po     | 26353 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/ca.po     |  2497 ++++--
 po/fr.po     |  1436 +++-
 po/ga.po     |  1125 ++-
 po/id.po     |  1374 ++-
 po/pt_BR.po  | 26593 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/sv.po     |  1101 ++-
 po/tr.po     |  1200 ++-
 po/uk.po     |  1097 ++-
 po/zh_CN.po  |  1317 ++-
 12 files changed, 61417 insertions(+), 2900 deletions(-)
 create mode 100644 po/af.po
 create mode 100644 po/pt_BR.po

--
Jiang Xin
