Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA881B0F19
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772666; cv=none; b=CbyCa/H8OBv1/C1q9fO/FnoERvmv8bScyajD3cs/u0XJwPIN+dac1t/WkLbarYLlBa2WAG8tq/sm972wJcH8oZRD2ZyG8ibf1bxmiXK5u8git4dwIIDwk2c+iAWbL7IyX+UN5Esd9FQXRTaevlUhzBbFChOoonjatbRQm7KmSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772666; c=relaxed/simple;
	bh=/S5M2yIEmh1q4pX+9XZdRPPpF/HXoAaf8/1B57w3QH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j80VM2yH5yfCCL7DwRBciHGKRz4+U1cE2LTDZb6C87ELDuAWG4h2SC4DMgeELY87lhz0MnwHzVtmfOL8/mOTa2dOfjUngMQVqRDIlVyUdzP2Ignos041r39HhrSjDVq2ew54i0B5ETfOB9w2TuhrBPdHiMep7FJPF9Mb+rxK0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdDX8CJo; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdDX8CJo"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e767ce72eso14680137b3.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749772664; x=1750377464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQJNZjzTh7IlVWjQ5ca/BVfRPD3NZDb9iJuWeSXPa8g=;
        b=NdDX8CJoPZYJV+i4qLH/eslbIyCpEy0UNIavcFGth+DF3o6FQ5nrxrdMxi5MuYLNsk
         xHtOZ5uBCQAysiV1A6nLmwp9VpQQXbvxFyhB4p+nZKPw688fg/m31uktjY7m9/ZOeVFX
         EWT3pg1BnQrhblO/eIrIt+Dk8K6ifbt9GmQVKR7UexOkFRlINLoIMEUuekEXJ0R8fYNK
         qGn2C53Gy3DqS2vDOgekGDZRnnBa8j2FauPZ7VcAC80Ixwt1h9gSwsB3t430ORmc83zU
         we049YrydXv5dkJZdua8zUF2rb/Zt3NJ0lgYZ5JFrnBKEBaoucX0fVNlSlXHZGl2Eujg
         DmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749772664; x=1750377464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQJNZjzTh7IlVWjQ5ca/BVfRPD3NZDb9iJuWeSXPa8g=;
        b=FAooISsKYuSXMqJCAGJO24OxuuxzV8NK6cpOUvv4gJkrQPiQUGMMkmcQqJNK0h6rBU
         W8biQ7cyeASFW5CNEmdxS2k7HqvJhEY5VThqsIVrfwXkq3ZWz7GEt/1GyPfy3hqHo843
         Zjj9f76A3vkqpvbM2LjLgqH0qs57bqrtccsU5Dncr/Ghu0XQHy/B2SUCNsPhwuVDHeE1
         ygfUIJzzX7GlIRE+wPSIHA3G4LYX6SRH4nfj9p8jpxWqaTGgvztR2Ofgec6RYsUP0jxg
         gsf/S0MMGiUAsB8OUBMxXT56Bna7DCkmyVLHr70EEfvtgcU4yZjHGYRdOA5q2SVBTqUd
         bTxg==
X-Forwarded-Encrypted: i=1; AJvYcCUGP/ZM8/DA0Fpavj8dQAaS/u5Apz/bKFlrp9X9Utf6CYgXm+u/NPb9kil2rUINDWj1eCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgUK5yaG1eVPTy2mYdoLiryMvjTjWb3ZA6yLTwrSsXKxHnrd/3
	fz78AXWKD3wqsaDRA36S1G/LRR/9fVxN3OvV65XnPnyQFRwJjbXd4Q646x/3gA==
X-Gm-Gg: ASbGnctBSt7wLI9tXjAVb5dZQ0joW2mCM0/xjFYC176xjakOdD/vRc3m5LhAWcOO4vJ
	5Y6Ql1wfsQjNLyvevFFLgcAZZyF69R4RxMPCGqSw5pXAtXhODHwO5mbGA6dxuozEwNa1LOKO7Ry
	CxxRj/+vs/S2wAR8f5CktWfYePWvRkLCA3mzt1XBgUUmFmC/t7K9Te8yCd0GTJytQF+eXCjAfh6
	gq3OSWz2Z5CgqyVYfFk6dBcWeWvsB4Uox7NywqR0QdZe0+xGdvIqxL4ZOACbbP2HXzm26GeZ3CN
	0jtd0H2h4VCujjvADEoor43kYiWvuL4QrXrUeQGlkF0VJ1TJVUEM9izexxZ8GDR3VdiMZvEhm/Y
	6JHai5wVLa/4yPEKLJB8I5hFE3PqKRau1BdOFsQZYE+Dsyd3Yz2TMUK6V13Q=
X-Google-Smtp-Source: AGHT+IH0rIZqmxtlpvF9AlA+6QZrKveAosiC+JjZZsUZT5h25jnHGtyfOOrne4z1xd5iFp+wVZhpsQ==
X-Received: by 2002:a05:690c:dd5:b0:710:ed16:267a with SMTP id 00721157ae682-711637c273cmr21173267b3.30.1749772663717;
        Thu, 12 Jun 2025 16:57:43 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7115208aaa4sm4572017b3.32.2025.06.12.16.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 16:57:43 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: [GIT PULL v2] l10n updates for 2.50.0
Date: Thu, 12 Jun 2025 19:57:00 -0400
Message-ID: <20250612235739.165187-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250612140159.164902-1-worldhello.net@gmail.com>
References: <20250612140159.164902-1-worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Please pull the v2 version of the l10n updates which includes
Yi-Jyun Pan's contribution for Traditional Chinese.

    Yi-Jyun Pan (1):
         l10n: zh_TW: update translation for Git 2.50

    po/zh_TW.po | 1191 +++++++++++++++++++++++++++++++++--------------------------
    1 file changed, 659 insertions(+), 532 deletions(-)

The following changes since commit 4c0e625c091d4c648cec7319bafaed3cc81658e5:

  Git 2.50-rc2 (2025-06-09 07:18:49 -0700)

are available in the Git repository at:

  https://github.com/git-l10n/git-po.git tags/l10n-2.50.0-v2

for you to fetch changes up to cbf346a9968b41ea8a7edd79985aa5ef8a48ff97:

  l10n: zh_TW: update translation for Git 2.50 (2025-06-12 22:29:32 +0800)

----------------------------------------------------------------
l10n-2.50.0-v2
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmhLZYwACgkQk24VDd1F
MtUa3xAAuet6WgbUVN16q49Bd+WcK6uWooHlcpUMXANkJGqrjMquGfOCTc6bYXYi
9JE87YUKxz5gIVP3YgEkJyLRiXuV0uUEfoGuXharQNDzMRfTNuhDmzV5drg7wWSJ
CM0ErbD1jyHoPcuiusdhBCGAivV1k4WqofZ4OfhCUdapfpD1BnVXzNb6G6g6TemN
WR5fiiQ2Ks0b8ZdfuXyBddqC44FOHwp4G1qgXBLoOq15matrNntb8y1ihualzTvp
3M1LHNvh6HHwiD8lGcQiv/9Fjqbx6ypkUuxERiG90a53InKb5iYXA84MeYNbWm92
rSpEpQOn3pq5ooweBLQWQUFOf/QFzFck6BtwHBdpH74FAkjXvjYs9aBPpH3PNUGW
aXCTWZsvt2hEaYLMu3w54nrapnKUJMJrDRZn51+s88bk7s2fqY8yhfPduHh+fwu/
4eVPQ9QgXiMS3sOTkU0tbV5qjw6LZFj9eb3Hg4MPQkwTQfe9x5mOOJC8IUOhwkuI
bpb/V+PVYOcE4yv67qI51LeFkHt1ozWtxvXNJk3vEjcLSLDm3eBQTHo5t9wlpzsX
pI3A985Fvzm7CQSr/0XPPGBLR1qnGjWXmOGe4v+N4VETnlPgqlv4nGEiLCFf+c8h
4zwb/QaoTf7FLVKycEkBuiDohzGkuMUU1CICTTcPOJ7blwbGHjM=
=2qMi
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

Yi-Jyun Pan (1):
      l10n: zh_TW: update translation for Git 2.50

 po/TEAMS    |     4 +
 po/bg.po    |  1314 ++-
 po/de.po    |   685 +-
 po/fr.po    |   916 +-
 po/ga.po    | 29758 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 po/id.po    |   837 +-
 po/tr.po    |   724 +-
 po/uk.po    |   649 +-
 po/zh_CN.po |   825 +-
 po/zh_TW.po |  1191 +--
 10 files changed, 33060 insertions(+), 3843 deletions(-)
 create mode 100644 po/ga.po

--
Jiang Xin
