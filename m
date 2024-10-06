Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF154F95
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728218035; cv=none; b=aeKkQ3yYRQ4Iw1jmjlnJ044tSftZaKPp/1wJH5oIAOY4SIV6I9mWIlXunbneinXBIA24cr863af6LFgITYMkd2s/Ma34U7W7PDdcmzEVw5HFs6/fHSnKS8fA3UbhCplxqQur4nLoggCa0wv3vuYuHlAdbyZjZnSG9meiLPM+4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728218035; c=relaxed/simple;
	bh=1wkX9A9AxuAiCtJEZ6c9XTaKbRJgvlQpWC3FppKxyaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UlzFO/JKEKptgZYg/qKPzf3LcnfQ8R52lfLYsj6CIWmzNKCR07+KJQXpyKaiBV8xGQWnRuH14/9/sEDxSv45XYRNJr2y3GpnFwajvdLZeeTN/zsTG9irzW9kPQ9eFCSwStxlU1M+EJPosHSfn/O4RP7OY1XbE3U6wuQW1TiGfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvGtbnN1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvGtbnN1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e0d9b70455so2831565a91.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728218033; x=1728822833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOV5fv8unjdW7pCybMAsd6MEVNWnXYceghhtGDUucSY=;
        b=NvGtbnN1ZDGOJGfQppasUj+9qvLHb8OWFNjIKaTZsNrY08Y4cKtcbjz4J605TJKnve
         55pbX5czaTSjrQf8AnfRTXtIcxFfdFeq7HbAlBYTN1vsAZ4HY/xxFSfXQ/tY2+yjiNGX
         b2bONksGhF/TuPPtDTl0EhN7VTunt0ulNYOs5VZ4EGstuW1g6NiByHlOgxrUfRtLxz21
         7QeiZjAubjTMoMj19yHEa1gFTqmPn9BC/R8OPOJhJ5cpmz1TIMaQeRaLhsO4V1MdCWr8
         CgsjXF3b22Pgg2HpTAZZ7Tuq+mnNHQgfB8laf/ESIvFcDUVtBLMUTv87dOVBPzZF6ocs
         kikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728218033; x=1728822833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOV5fv8unjdW7pCybMAsd6MEVNWnXYceghhtGDUucSY=;
        b=cetxnyjS228bi5B9H3KZmwpSObiPObOEUYk/Rex1LV4fRbmY3lzTkDqa+3xpewW6G0
         mbHY2SRzD/U3MBpVCsjh63USljGU8L/zESH60iXbIZuG9hkckfqCYjS8GzPFDTjg/RuH
         5P7vCD2IsqVnc85OZRIVunAZzUjzylMC89GAbZC2PwLJXV5aeaK3k2xWElMXIT8lKPL6
         X1d2cymz+qv60G2+29SQvhQot8/JCJO9fAGoNTn2u4CIug4lp490xeluQ/tI3fhOIVqC
         05rsvh+884kjEjb820lsHrLANpSOeIToPW9OBY47cHBBVVPbm8q5Xwv34VN+VTtrP2uF
         19Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXdF9ulb2Bfd1T7ufXf2oWXzT2gQlJDOH9xTGD6iw8t5TlB/DtKHu09spExYSp6YSszMp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2Ctq8pp/cioimpi/5SdCmXOkyiUoJHEEMaBqAKyIEyRgu9b2
	79Q4KpjisqyQyyW6eN+Nlm3drQp5FKvUfsbReJ4NHA+4o5eBv9FX
X-Google-Smtp-Source: AGHT+IH6GRtgiKD/TqGI6305EZn/JfIiDQQG4EtielWl7BzLHBM3WXCMi2I//pqJOHPzFP+6RPUzoA==
X-Received: by 2002:a17:90b:1642:b0:2e0:8028:3f37 with SMTP id 98e67ed59e1d1-2e1e621e682mr9703155a91.11.1728218032939;
        Sun, 06 Oct 2024 05:33:52 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1396df62sm24862535ad.233.2024.10.06.05.33.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2024 05:33:52 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Arkadii Yakovets <ark@cho.red>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Emir SARI <bitigchi@me.com>,
	Emir SARI <emir_sari@icloud.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Jordi Mas <jmas@softcatala.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.47.0 round 2
Date: Sun,  6 Oct 2024 20:33:46 +0800
Message-Id: <20241006123346.16248-1-worldhello.net@gmail.com>
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

Please pull the following l10n updates for Git 2.47.0.

The following changes since commit 111e864d69c84284441b083966c2065c2e9a4e78:

  Git 2.47-rc1 (2024-10-02 07:46:27 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.47.0-rnd2

for you to fetch changes up to 81e7bd61517f449e6ec27a67917eceda83bcfcbf:

  Merge branch 'l10n-de-2.47' of github.com:ralfth/git (2024-10-06 12:06:21 +0800)

----------------------------------------------------------------
l10n-2.47.0-rnd2
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmcCD90ACgkQk24VDd1F
MtVEzw//Q5cfCdENqI3+sgkY6vYmpaO4xhGsjDPXz9BB7w/gAhQ63s4ZcppL38bG
MOsHfRRpyh2wNoMN+apwAqv6huYIhQdrfaI7HjSRiA6RiQXxEFhNdIr4dqF+RlV5
wwfQ3ePFtHmQg+Ys6KkZOBVDgWjoX8IbRmsZJGIdA/30z9jeQtgwm76vlIA/M0ll
UbJz+L2TRjngei6IiHKb8k+3N6ERrsh9yELsVVDeBks6XjCZ4acLqEgcCzIWMXDS
dLse7is2J4momeBpCr4maHVZyoFBFbNHfqoxqEgwIq80TZSltPo/KUW/jX3Vfq+0
2pBH8CWsetwA0dT7wfLFDY01IAgs6nvFsI/Ahe1vk0H4Nne0/PM9OTOj8+EiTKtr
biWx968Xy/7szZT8v1iZuhA9Ku1DdUiIpH1ybqNMVzzMCBG8UzZaGS90bCuZEg4A
GOGPH5KtutAyK/FdRGqVVkLBT2KBQvmDXbdWCDR9Ct82mXRaDQJ7QW+6ucbH7OJB
X9YgiakCmNaoWMaLl4BhOHoX2UESk+FzLudbltU4QmFwHPr7tV9jKEz3H8QWaMLQ
lB3mACJ1ks0CZmq/kTwrV3s0rOT22YiNLktpYjVN0Id7vEFLWc0nBq4DjqX4VI67
l6s25Ugj893/9K93XRFtYLlow4jdRCof6UE+lqtXXAwSR6YpBUQ=
=LYel
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5772t)

Bagas Sanjaya (1):
      l10n: po-id for 2.47

Emir SARI (1):
      l10n: tr: Update Turkish translations for 2.47.0

Jean-Noël Avila (1):
      l10n: fr.po: 2.47.0

Jiang Xin (10):
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'vi-2.47' of github.com:Nekosha/git-po
      Merge branch 'fr_2.47.0_rnd1' of github.com:jnavila/git
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'tl/zh_CN_2.47.0_rnd' of github.com:dyrone/git
      Merge branch 'l10n/zh-TW/2024-10-05' of github.com:l10n-tw/git-po
      Merge branch 'new-catalan-maintainer' of github.com:Softcatala/git-po
      Merge branch 'catalan-247' of github.com:Softcatala/git-po
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'l10n-de-2.47' of github.com:ralfth/git

Jordi Mas (2):
      l10n: Update Catalan translation
      l10n: new lead for Catalan translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Ralf Thielow (1):
      l10n: Update German translation

Teng Long (1):
      l10n: zh_CN: updated translation for 2.47

Vũ Tiến Hưng (1):
      l10n: vi: Updated translation for 2.47

Yi-Jyun Pan (1):
      l10n: zh_TW: Git 2.47

 po/TEAMS    |    4 +-
 po/bg.po    |  265 +-
 po/ca.po    | 7973 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 po/de.po    |  233 +-
 po/fr.po    |  254 +-
 po/id.po    |  323 ++-
 po/sv.po    |  227 +-
 po/tr.po    |  245 +-
 po/vi.po    |  281 ++-
 po/zh_CN.po |  312 ++-
 po/zh_TW.po |  324 ++-
 11 files changed, 9208 insertions(+), 1233 deletions(-)

--
Jiang Xin
