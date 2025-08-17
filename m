Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034D291C20
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755438865; cv=none; b=ihzdYvYvwXlQVIZ1fQRsTjRX9gIfCQdXys6UcaqxYJxuhmu53Yh8T/D+1rz5nWJ3X20W41BcOQVz315J3l3eqAd3nSsuktXZJhhfEn2WBvMg47N6n7o3R4Ds4kQNxS24DeNy7sx/5rJ+CDyTSEWcvg8HURvxfTg1B3y8/+0MPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755438865; c=relaxed/simple;
	bh=00+YjW4/K0gpKjGr+kE3McBTvXoTZBgOG1fqhWnodJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TEy7dwhsgKOp+Ue/NdYHrXG1epoeL4T7gvM90FSsEXuzxOGN5rpJyDminulAIEBibcFeLDSOOaa2rUgdNHxyfQp0LFHo410PQUGkV25wua+AU7wuNErJJ75uEHI+cdQJgVCP33Vjbpt0Qrkl6ymGuufsCm1dtKdddKlAGl0+rK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNPOAMUf; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNPOAMUf"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603f13abso29036097b3.0
        for <git@vger.kernel.org>; Sun, 17 Aug 2025 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755438863; x=1756043663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Em4C1llYk57wWRLab71BiYMAt5jMl+DfOrVb0atH3JQ=;
        b=kNPOAMUfzd+fWNXJO/VQ7aTCzBCqYN/8wdHBHCQYLoy/hdfkyXjQXHyu+Vtn5yl/Ih
         uLDVuQO3hFx56rkevd9dXV1e4JzcR9waEsR0zKvbDR9X6IFl3xK4DvKo4TCvEvJLd0BS
         9+BeAAD8of3JRh8pLcYDG80fOeNTOhMUNT5wVLFVBrCXW6+D71cq7/A2lTj3XHjxfd3d
         0uUg7SYrQT2zAvmC+wYF1SuilICtZlyc97isR6SBn4ft+qRy19pn6e/cnKnHbVsZv8BP
         apT/gbR3Fm6/vTbqOtLFUq8LE9Yk+vlOp42E6N+Gp/aZ5Yi6gNpi+mOayVBEphbEp6Q8
         Rnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755438863; x=1756043663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Em4C1llYk57wWRLab71BiYMAt5jMl+DfOrVb0atH3JQ=;
        b=veO6eZ3k0N2fUc6jqDeyXOy3bcsIlCeWbtIHjqWzFCl/qLdQOuMSCWu6dsu0Pcj+TO
         PQABIdkrlSPTCpRPBqHWqCzFEjhsodCXbtSlqd+XWgxjDPO8tPyc7Z4bLC+VDX2PAUUz
         LikLCcWhEC6CDO/faK5MhvZANsOs1DrFb2u7fdSxqVZzODQqzkKmfLlqjOwrLXWYYJ3b
         ljdBuMafEvyXEQzuh2eE++IIlZZwpMKjop1LngeuXGwDOlXspUCHu54Ybvxl9PTSAbs9
         PfEc9aFXEd7KbxXKzEntb0rdTlB3nmY6yVekvQuCK+a+HtvLMr06LqBeuc4Xsh1URb4x
         VP9A==
X-Forwarded-Encrypted: i=1; AJvYcCXpr7UVKem3SZPzaohbHunEYHHcfLFrhXth+qMKZzjaHQLeO5cLWoa2dvkcjcdC+B8IXYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzip0s4UEbvTl3DqOUHDTn+dWgEmOjv2YBvO96UJwb4CDf//nV7
	RGa4MdsTcoWcQfklpLt6GHVQuzNJhmxxj2R5jKKsYS7hFxDs11J5Ljjr
X-Gm-Gg: ASbGncuVMdR6kLPxEp2vXbqP01Ut//GDXnflIusveROUQW1ehmM6SbKlAZ2LvYwiauz
	ImljTBpZSOO8nqG0lnNWJGaOI08uq/UXvsN2sEIfuCJrpCBGkRKT2HUFiiKfzR4bPbLRlvjJzLN
	c97e6Nv67wiFPpWqBiBAYtv6dg6PAaxXy5pY+ETts7rso0oJW7F/OD2utfVC2brPgg6Jm6VzAyH
	oUH+dqnIagqr0e+SN4BgwhrIb609IBgsiM0iQ9zOq46sbGvCO24XIHAtXu+7kw9VbVG81lrezUR
	ILE2FPAd7HoJDkRFQCph4TT/sPdBXOh643RRRL8A/sxIFrmMGTOO6L2JY67pupk+41lNxWpcdY6
	qpDIiik3TL4IqjtnrwrLL4YVJYTJHUwZUQEVW+jrCihceDJ/fpXHnVa3kTJhlrrqrlJTjOVtRb2
	6a0ixlxbDj7dficiYjftc=
X-Google-Smtp-Source: AGHT+IHHSrxz+1QQEVtRW8nQYdI/tEx+I6DqUdOxmrBtuDkvsy/kpvEskQ9AuQHNQtaDVysSZ+GwTQ==
X-Received: by 2002:a05:690c:3388:b0:71a:2d5f:49bd with SMTP id 00721157ae682-71e6ddeaf10mr114996347b3.22.1755438862594;
        Sun, 17 Aug 2025 06:54:22 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0a9a26sm16216097b3.55.2025.08.17.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 06:54:22 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Emir SARI <emir_sari@icloud.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.51.0
Date: Sun, 17 Aug 2025 09:54:10 -0400
Message-ID: <20250817135414.431459-1-worldhello.net@gmail.com>
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

Please pull the following l10n updates for Git 2.51.0.

The following changes since commit 724518f3884d8707c5f51428ba98c115818229b8:

  Git 2.51-rc2 (2025-08-13 07:57:49 -0700)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.51.0-2

for you to fetch changes up to 79ee0dce2a61b7552f9b5c73f0cf2d974a20a029:

  l10n: Update Catalan Translation for Git 2.51-rc2 (2025-08-17 09:25:36 -0400)

----------------------------------------------------------------
l10n-2.51.0-2

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5856t)

Arkadii Yakovets (1):
      l10n: uk: add 2.51 translation

Bagas Sanjaya (1):
      l10n: po-id for 2.51

Emir SARI (1):
      l10n: tr: Update Turkish translations for 2.51.0

Jean-Noël Avila (1):
      l10n: fr translation update for v2.51.0

Jiang Xin (9):
      Merge branch 'vi-2.51' of github.com:Nekosha/git-po
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'l10n/zh-TW/2025-08-08' of github.com:l10n-tw/git-po
      Merge branch 'tr-l10n' of github.com:bitigchi/git-po
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'fr_v2.51.0' of github.com:jnavila/git
      Merge branch '2.51-uk-update' of github.com:arkid15r/git-ukrainian-l10n
      Merge branch 'jx/zh_CN-2.51' of github.com:jiangxin/git

Mikel Forcada (1):
      l10n: Update Catalan Translation for Git 2.51-rc2

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Teng Long (1):
      l10n: zh_CN: updated translation for 2.51

Vũ Tiến Hưng (1):
      l10n: Updated translation for vi-2.51

Yi-Jyun Pan (1):
      l10n: zh_TW: Git 2.51

 po/bg.po    |  597 +++++++-----
 po/ca.po    | 3036 +++++++++++++++++++++++++++++++++++++----------------------
 po/fr.po    |  808 +++++++---------
 po/id.po    |  666 ++++++++-----
 po/sv.po    | 1114 +++++++++++-----------
 po/tr.po    |  505 ++++++----
 po/uk.po    |  528 +++++++----
 po/vi.po    | 1592 +++++++++++++++++++------------
 po/zh_CN.po |  692 +++++++++-----
 po/zh_TW.po | 1010 ++++++++++++--------
 10 files changed, 6371 insertions(+), 4177 deletions(-)

--
Jiang Xin
