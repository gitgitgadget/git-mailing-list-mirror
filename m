Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EF29CE1
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763287337; cv=none; b=BlxmOONBOyrgKjB+KhiCH9MEILloy0qcrV93sVtezhaISQNXgXjYqSVH5Y339baJ1Ul0jT6KxG7coJNyZPAGv6jEl/GJyEGS20/ZDzBaQdU8O4Yax+Cx4cTbMK67J72aiqL0BAK2XR7sGVNlujXNTFOnOZ8L9yW+Qzq5532XBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763287337; c=relaxed/simple;
	bh=22Obtn2R9PguflClGLmHnRMogMBNygMUbqdrlq8qG7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eOdbyz5Nlg0gKhEge/w8AZLWmMu588ITfhWynrMMMpMJLJ6pVQ58Xe6jqJXWx/LYQZYzS4GyI1mUdxltPYNwoTkUKBhbx4z4MRoL6NEFw8xKXB6bEZnc8UuGs2k1LzUWsOSJAOxsZOcBiS3Qb7GMzHAn/DLHTUlR+8Zljo2W0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqxDmPNz; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqxDmPNz"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640d8b78608so2402677d50.1
        for <git@vger.kernel.org>; Sun, 16 Nov 2025 02:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763287335; x=1763892135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1buxgO5bKizRBxXCNUlntwvOiduy7xTVTReY0BAQsRE=;
        b=mqxDmPNz5OzxTY7f/T33FhS7lQl9zQV1AVeMnZaeilFp8M86w4GUPpN8/vzI109tj2
         pdRjsAFoy4daf2Ry1xEPWNxqqPfvMLP78drgb5x3bYl1FG9v1quYHnfXcJyfcGiOIUH6
         Jv4ilndf1Ny1a4S90nMWz7qKPP+q2t6OVUBjI+p7OjlST8/CJW/wIbLqjD+9581YNHzu
         HBJddErB6iaxDR6iOhmJQnZAGoiCcmS+Hf2C3OnBSVEgGwqwyfW4dfM8gcV8/z829aRH
         WAA3FkicbrePWKJqUcKps8HX2zCdlNj7fZxcq0/v3BzIRuI7QGwqaavMRUdQg/SreEyq
         0pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763287335; x=1763892135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1buxgO5bKizRBxXCNUlntwvOiduy7xTVTReY0BAQsRE=;
        b=oTnM7n46UdOT1KKYw2+HsGMqzdNCAt2a0OPdJFGAWaLZr2TD0Y7XkK/YZeE3rANFyd
         QYV2BFTpJ/IJlI8tWUJ11zPgyNC387sCtsZlppfHygE2tzeWYVhugk+wsQLI1XjLQHmZ
         t+dUMfsCrGVeI/73G5wLJDg5nD+n3S/r8wrUmeoeJtpzO4NKRa/WlOh9K3NoC2d7u99k
         MhDyHybjStDtrrp0GC2J+smAJnB9BAMYjR3uWoiehZOf2SyGbcMlOOoxDCn26Yg6rW9E
         PG4wMPLlpXfe6kHaLleHWQ2kjf9OmZumyGBQbjNoxPwvDFKr852I1EunKBWbNL3VO6dc
         cN7w==
X-Forwarded-Encrypted: i=1; AJvYcCVxcVrfSF0W27V00lMtgdzzRQGo7WK8pEzD5U0ePTTuucD4Xb2cSm2up/86HIdhGBWHDWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIRrkdzMlVgipTZW1fkVo0MzIwdRSNc3Mv34suEqXSBA8/p14
	3OnS+lEGaGY5Of59pRv7XfpvTd9g4WTPDSJH6vX1IlwIJwG+XC3yoRqE
X-Gm-Gg: ASbGncuTfpNM2AQXKkOdlsb9GReh0GTNOKqfhwyeIdc5Svt6xbycPTlUqKdrBZp2ilv
	aexEpLu0S436n3Ed/LE18CnrWFkTvIM8OXMYqllx6Q9vRFujuCcdHP5qBS3OWm5b/Qul8vsbYwM
	jtg0sIPGRWlRoM7XNvqCqszrzKlabbIOt+5EmesV3lQsTGvgYBAYK8E8vxG5/W7ANSqP6brScAo
	St0O6Zhk8hXzbXKDYSGTK9OE8atSxxHbyOr4xpfa8K8NIDaIPpj+hAIOTXMr2SI6C6TKML0b2WW
	FVyiUqysJcJeBtabBRp+DOJwcoCAN8Q29wWKIF8wY0IycWqqF5bUUcwXkVCrcAcg0HWfW3KD+gp
	/Xc5gNe4QwZ33FEsqGy5XgyI4+4Bpq1uXM1Ua5dwUTOmTXGo8ohgmPFZHQ2hb+i/De8jziof/BJ
	dIdWOFzpif7q8IFSAIpxKoZLTB+GYToEFDIHxts02RSalK3vJfOh2hkXDHWSgpH/Sndg3o0wlW
X-Google-Smtp-Source: AGHT+IEoHd2YqFBKjc6LTd+iddFCR23y/rYnUBFFTv3thxRLPLXrqk6LwnQ3BqTlyLH/wcKCZlAoQg==
X-Received: by 2002:a05:690e:d41:b0:641:f5bc:6943 with SMTP id 956f58d0204a3-641f5bc6ec5mr3801549d50.71.1763287334597;
        Sun, 16 Nov 2025 02:02:14 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410eabb558sm3571829d50.15.2025.11.16.02.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 02:02:14 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
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
Subject: [GIT PULL] l10n updates for 2.52.0
Date: Sun, 16 Nov 2025 05:02:06 -0500
Message-ID: <20251116100210.844040-1-worldhello.net@gmail.com>
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

Please pull the following l10n updates for Git 2.52.0.

The following changes since commit fd372d9b1a69a01a676398882bbe3840bf51fe72:

  RelNotes: fix typo in release notes for 2.52.0 (2025-11-13 09:34:53 -0800)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.52.0-v1

for you to fetch changes up to ad892a61d6dd73211aafbc72e177ffa31e4cbec3:

  l10n: zh_CN: updated translation for 2.52 (2025-11-16 17:27:10 +0800)

----------------------------------------------------------------
l10n-2.52.0-v1
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmkZmdgACgkQk24VDd1F
MtUSmQ/8DB8gG0gNDhqI3C824auF3Wa6fJFl8UBiM9uJ2QwphKtkJHSeekBnQ4FW
18UmN7VkuRPMcMKXYRUS6SSzHebT9Atxmmsm2NuUb8fqq5Oe3v87Shv07On3+b7l
GtSG9pkbjQeiR14Us+9G3pFm9IJ5Uh8gojZiXwZNKEzBCiae4sgxJ0YGKKpKDYao
lGb1T/gibYA16uVMXceKEH009RN0CKL64LyY9wmNtIoVzSjOFCOiisSyD5gbG/NB
pDZzZg7eODHSNseNaLO25tlAqKiFkNvjVOfwBNVm1ubV1zNQR0zonWKm6I3f3dyE
lCw7swVWBoME0U4EsQdePuhccRyFNYG0RjPk/KNsygLYgLXhAIvXRRY+B/AHbyjj
gDaFCQLywHpq/cL007fYaCaEWNPiLgb+w7/kHu/qf5cEV7kucT7BQ07X8AsnGXlk
T5fjw/ZP7JpP6CCsL4xUfx+W8zM0+V0Yp/GdyblIxePhhDEYD8X28WRADRKuae/r
dWgASTDOuojsJ8F2pmKUVfaXKT8aenBSsSaS9wxAeYZ8qmAA9BBwmhSXqBfm2VgZ
xWEtbG5i4r6PiXy8uqpLBnl7nUie5EuDblv7Fs3WCLj0tLF7DWw9SNkmm3oipDXq
iNChQeDFYX9rT0a0lLDJoWmhk8+TGdUdOfF7OgQAv47q0skP+Hg=
=xW7s
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aindriú Mac Giolla Eoin (1):
      l10n: ga.po: Update Irish translation for Git 2.52

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (6065t)

Arkadii Yakovets (1):
      l10n: uk: add 2.52 translation

Bagas Sanjaya (1):
      l10n: po-id for 2.52

Emir SARI (1):
      l10n: tr: Update Turkish translations

Jean-Noël Avila (1):
      l10n: fr: version 2.52

Jiang Xin (8):
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'l10n-ga-2.52' of github.com:aindriu80/git-po
      Merge branch 'fr_v2.52' of github.com:jnavila/git
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'l10n/zh-TW/git-2-52' of github.com:l10n-tw/git-po
      Merge branch 'vi-2.52' of github.com:Nekosha/git-po
      Merge branch '2.52-uk' of github.com:arkid15r/git-ukrainian-l10n

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Teng Long (1):
      l10n: zh_CN: updated translation for 2.52

Vũ Tiến Hưng (1):
      l10n: Updated translation for vi-2.52

Yi-Jyun Pan (1):
      l10n: zh_TW.po: update Git 2.52 translation

 po/bg.po    | 1419 ++++++++--
 po/fr.po    | 1446 ++++++++--
 po/ga.po    | 8803 ++++++++++++++---------------------------------------------
 po/id.po    | 1709 ++++++++++--
 po/sv.po    | 1418 ++++++++--
 po/tr.po    | 1400 ++++++++--
 po/uk.po    | 1424 ++++++++--
 po/vi.po    | 1384 ++++++++--
 po/zh_CN.po | 1728 +++++++++---
 po/zh_TW.po | 1987 +++++++++++---
 10 files changed, 13521 insertions(+), 9197 deletions(-)

--
Jiang Xin
