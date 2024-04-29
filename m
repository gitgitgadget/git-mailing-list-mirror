Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2B14A83
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376519; cv=none; b=ehIrTLI36izH3We5zGcav5sRO7rlUtGTTy56yeH0edqXXN2LNN69up2RHvjqLqZpi6ctV7lhdDjCFgaqNSm+WldERR6zQVbwef5hTHTHdghyWGwMl1JlRdFfrH++6fBwyxlOebjUxXhbqaXb2iC6tlI8GbWGx12WKpKclnY0XgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376519; c=relaxed/simple;
	bh=Z+VmS8cgr0XXX5a0IAMj8BHPhsxVy9VF9+SBLXl3X48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=J4MzSh6DvaVzxe+TjM9iuhGBAoA3Zx+h54ymGcovpk3CYRGGtAxublYwJCVxCHGWR7g0sDaopedqQAbD4Z1nTmDigXN154lWi+PrimPbsOJ3mvNn0mDKuVvQGmG86jYPhcN2GoStK5IQa2smCjKcL7vAZBljWso/fuW5zrPTNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlXHlHvl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlXHlHvl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e8f68f8e0dso29187645ad.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714376517; x=1714981317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrguJpFnpgOE3RONQhPW5M8eeNwKr+m3jNLvVVsLDsw=;
        b=dlXHlHvlVewZaQyRWZ3xTLewvGrYqu2MBqWKUTwErxMuSIhwGgZPC7WrS/w0WEJV1s
         ZQFpw1UrrAjaC1+1XKHuxdMybp71vz2HVAfYW6KP4OUliWmIdU1pi/3QmhVcjznqSCIU
         ysAfrfS6Z71RS3K64W6f113COlsWBnKkoTDx3Ml8gG/MDQGtDLhlk3ZkDUUm+M/84sub
         RhLx1dTcovnzMy05UxNQ2dYH7cr465RWruqm0lnwVWK+iYV+p0PJg9RNZTcXQ4UGQfUd
         58gSgRe/gNdr3yNLwJWzAlJOlnr56DnsRYHsbmuY7DQA5p61OdpSTuqlzcJ8BsKSdx5Z
         L0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714376517; x=1714981317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrguJpFnpgOE3RONQhPW5M8eeNwKr+m3jNLvVVsLDsw=;
        b=TUDNnmyjXes65HgHEyCJ8h/ybgWMKlJYtwRU7c2y2bQBvKkKBCViIZj1RQHWg4nBU8
         jSVmT9ONnkhN+y6LtIDnykEnHaQbdzlWwNGEbZcPIz/wqiB9Z+6MZzU0MO979J+tBQ0B
         YqOWRw6by68psK6r1d5Zg99P4uNxRUmns9rQyT/3zbuS4mlVFCH0M+Z1vUe53HJS7ul6
         k3IyQMBbfRfHgZb6674d4huWxKK+aJmciBiiARrclZMyBnXSDTmMISDjIHaQtJAJdH/R
         QlshhqAHlYCIzZ95WKaRDQ5VD5zlRFfXf/7bHjCP+Dy9cv2kftmdbvCCAmcAnwYshdeF
         9Cjg==
X-Forwarded-Encrypted: i=1; AJvYcCX1aAD5o7N5ta/OgmJbFm6Kai4g7LLVxjh4GPEfURrv3KTtrg15lfW9n2Z3tLq9BOg2fA3SYmhXVnN1+MT+LtL8kDGC
X-Gm-Message-State: AOJu0YxJR+EEP/qsnDCBds+c8pWqI22wyYBIgqEP4QmM5whmnyN1TRcj
	/epvXAXKqf/JjpZAa1c3ZHkKtlJhXx1sZFgi4a6oic2gSkfvuUqN
X-Google-Smtp-Source: AGHT+IG0rf6O3WduBmmqB0kEDEiZ2VheCCqna9BKWAIQhXfFXY/6YPy0+BjuXtj7IFdqc+s3ZCSA+Q==
X-Received: by 2002:a17:902:eb8a:b0:1eb:86d:70cb with SMTP id q10-20020a170902eb8a00b001eb086d70cbmr8015135plg.45.1714376516918;
        Mon, 29 Apr 2024 00:41:56 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001dd2bacf30asm19754778plg.162.2024.04.29.00.41.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2024 00:41:56 -0700 (PDT)
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
	Jordi Mas <jmas@softcatala.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.45.0
Date: Mon, 29 Apr 2024 15:41:51 +0800
Message-Id: <20240429074151.17385-1-worldhello.net@gmail.com>
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

Please pull the following l10n updates for Git 2.45.0.

The following changes since commit e326e520101dcf43a0499c3adc2df7eca30add2d:

  Merge branch 'rj/add-i-leak-fix' (2024-04-25 10:34:24 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.45.0-rnd1

for you to fetch changes up to 2cf631412d8c0213151c38c15e2e7e46fb881bdd:

  Merge branch 'master' of github.com:alshopov/git-po (2024-04-29 14:50:23 +0800)

----------------------------------------------------------------
l10n-2.45.0-rnd1
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmYvSbkACgkQk24VDd1F
MtUkgg/+ONzez0C+y1+xddvhkBtTYmcLDtB4mXNnt65RSNIXWJRhgDb9KFSfl3ki
9FxaHtFiRyNAfLTuv5EwfV9B+t4Prdh6tuz7dCcz7jy0HEIpwStH5fA+x12GEU2+
C/QexPQQ1tZFPFAlfrexhT4hBKQ/irbZLLb7dl8hp3NtjdCkwMllH4N9lrHGfUKi
w0AKr+9Bj73AOWhQqxeh0KlyVk5y8+DOgHvN/Dp46igN3+rZfhGDq7D7CNQBGncx
iJsiyXTUEdHGqvCgJCB290cz1kmNnt5v2n4Zmr6HsagzRrT6M7KeUrfmO+S+jAy/
gmiF2qyW6+u3yVIeE+WqDIWqbkgrVWiGcfqlj+IxCFYY6ZoQy+5HjnOb8JMtXe0A
C/Y1yn/pGaDXAx4dncKMIdXnXtpzQJM6107nr5NqtQ/U2OqFYM5PPxMYxtWNDlMn
Hxp1nkYPbdd5nOUj+Xh+i8uOpA0D/FG2pBLHXVABjtf409shQ1ykkLHcmnX6Cv6p
gI8J/TIxwJAzKl+CHusDhStWutnsKajAapE1va/YaNyeysD63a6gySOAac+ovgir
+LSVuAA/o/uSv28btHO9aKNO54tKVvzro0zspWyaeT2lzaolZXfi+iHzDlfiWgOj
TG9fjXfMPOrAL2HOYLw8wmJhBdeGemSRdwl5uWimBAeQiMj1lAw=
=0564
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5652t)

Arkadii Yakovets (1):
      l10n: uk: v2.45 update

Bagas Sanjaya (1):
      l10n: po-id for 2.45

Emir SARI (1):
      l10n: tr: Update Turkish translations

Jean-Noël Avila (1):
      l10n: fr: v2.45.0

Jiang Xin (9):
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'l10n-de-2.45' of github.com:ralfth/git
      Merge branch 'l10n/uk/2.45-uk-update'
      l10n: TEAMS: retire l10n teams no update in 1 year
      Merge branch 'update-teams' of https://github.com/Nekosha/git-po
      Merge branch 'tl/zh_CN_2.45.0_rnd' of github.com:dyrone/git
      Merge branch 'l10n/zh-TW/240428' of github.com:l10n-tw/git-po
      Merge branch 'fr_v2.45.0' of github.com:jnavila/git
      Merge branch 'master' of github.com:alshopov/git-po

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Ralf Thielow (1):
      l10n: Update German translation

Teng Long (1):
      l10n: zh_CN: for git 2.45 rounds

Vũ Tiến Hưng (2):
      l10n: Update Vietnamese team contact
      l10n: vi: Updated translation for 2.45

Yi-Jyun Pan (1):
      l10n: zh-TW: Git 2.45

 po/TEAMS    |   23 +-
 po/bg.po    |  731 +++--
 po/de.po    |  670 ++--
 po/fr.po    |  681 ++--
 po/id.po    |  812 +++--
 po/sv.po    |  941 +++---
 po/tr.po    |  661 ++--
 po/uk.po    |  663 ++--
 po/vi.po    | 9973 ++++++++++++++++++++++++++++++++---------------------------
 po/zh_CN.po |  798 +++--
 po/zh_TW.po |  910 ++++--
 11 files changed, 9642 insertions(+), 7221 deletions(-)

--
Jiang Xin
