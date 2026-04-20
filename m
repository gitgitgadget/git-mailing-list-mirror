Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF52A1B2
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665563; cv=none; b=LCRLRzSOqXSBQUC86kUZZFkU3Ar6GDso+bHirv6gWiBiQAjl8MQvURMuu9F7v1SJZ60x/ca3svDqC067RlrzyDZykLe/0uO2UlJJ+btwh59YvY0cufXuVb1QuMEBiSjgudAeDFqmqc1tHTi/aglRbB4/27mRP6nerS5N8hXkuko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665563; c=relaxed/simple;
	bh=hDkgjaN4tmjyEe6Kf3FvhPFnSXOl84Qxo+yEYSGW+IQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hb2xRunrqa4QYrCa3AZfc9b7aALLphnpT6+ZyC8YDvmJJECmmimQnkogn4Edms8p8riL423Cyn+Yj3egK/yoSqJjm/qg4xjnIV7zmqytJ6b+0EH+qDploT4Xt7ghpPussKy9kRCvwmGWE8LK63fuFtv+HSZL3hsU+woVeV+75Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wI85Duap; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qrVrA4iY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wI85Duap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qrVrA4iY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84C9E1400062;
	Mon, 20 Apr 2026 02:12:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 20 Apr 2026 02:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776665560;
	 x=1776751960; bh=A28hQaC8rWoycibgAbbESBLhURDe69cI0kX8jR7xTZs=; b=
	wI85DuapE1zTIH3lDXAa1ETcd1ii8H10i9WV31J0V5bvkyb3UYrgnG6ZmTFm0F8k
	TFvuKijqcxXvYTfHa6e003ojAJuXmlQZx5Ay/RySkzzgRZFB2OQk0ZgKQYhw6adQ
	LdmTZr4xslEGau5vi2sWrVkDLsSgiIaWewOrjibChP5uDygc0sT4pUQbvAIDVaD7
	9pSRxmodusU/8PvH48PbE/vZpk5f8hcmxYweYFZ0t2msC46pqFZ9AQpjWFYSaZuW
	kC+wnNQFhpRGVU8t8Q48G1LqhHF93LTEqHWVRJ/ECwWzQ1gpgdRTpyo0/d17bhMp
	ZjvSUX5xaCyXgG4KvX4bpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776665560; x=
	1776751960; bh=A28hQaC8rWoycibgAbbESBLhURDe69cI0kX8jR7xTZs=; b=q
	rVrA4iYMOfTKn+zija2swFaAEuHzCt00J64ARIWEfGsCsWL/O9VgJwqD5wxHpQXS
	FBQchi4T3Tbz9SxQ+8EJ5Mutt1R+Fpqi+jxdh9uPdJzKn7YMrZkmhJmEU27GXwjM
	4Z6FZtN0SVph1hEslZT8zPoN0lX2jzWvHS3z9d/b2qTLEqHLlB9uHsYlBKTDWZY9
	iOuJ34TAB8FFdgUz8sai58QF9CAiWWOdV8Vrgo1Hqf7225Rpm3MSPj0EeAHRtfFB
	HjPQXTolstPu3n08iTzhwOgCG0y6Wlk17CHPu+IJcd3ZyETU1rkim+KSx6dU2fwA
	nq/fS5vrd+zfClVNGAH8A==
X-ME-Sender: <xms:2MPlaR4eDn5UceA9gzMiwy6jaBdzsQ8dq74vkmxaTvdlgbwm1-BrTw>
    <xme:2MPlaVyt5j1lU1wLoSviZCrnXGOj85iKg_7JF-7Z-80StaQOgz6i-gMS-NkBaOYft
    XtUAVhBgb0Nc0krQTXcTWEnH3ztQqQ97PlbZL0olsb82YpoTH5nRQ>
X-ME-Received: <xmr:2MPlaQwL29b4mlFgb8T2rPAilsiBGg3fXIKpEMuU8TysuWtlMcd8opCsXmk-MlSo1xjaMOZdWEqWwtcMhw5nZWWwn6JATgkTCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgeeghfdufeekgeeuiefgjefhjedvjeevtdehgeeuudekgfeileefueetjeei
    ueelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifoh
    hrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghshheskhgrmhgsrghnrghrih
    grrdhorhhgpdhrtghpthhtohepphgrnhelfeeguddvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2MPlaVym4WMzEbBT1mB1md0_p3ZdkDQWhVke43XKWZY9ESQjBV8LwQ>
    <xmx:2MPlaSY6cJz4ekUlM1-60-rBTkX8GSs-kWBtCVhBtSeJ7mcp3_kKDg>
    <xmx:2MPlaeU_CwMXYdk3rlJYaMi8TaVgJ30cEV0UdPxFjKoUUDAPBaMUsg>
    <xmx:2MPlaYg6hzp46N0S6VMclxcSPZfMk8q24HSxJcnmSefBXmx2dXDKsQ>
    <xmx:2MPlaSR0HYeHsHImS8I--PMtAa6ldoQiAoGMjKcyQIMKcvCvhBBcw35T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 02:12:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Alexander Shopov <ash@kambanaria.org>,
  Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL v2] l10n updates for Git 2.54.0
In-Reply-To: <20260419235723.1579499-1-worldhello.net@gmail.com> (Jiang Xin's
	message of "Mon, 20 Apr 2026 07:57:21 +0800")
References: <20260419111136.1577323-1-worldhello.net@gmail.com>
	<20260419235723.1579499-1-worldhello.net@gmail.com>
Date: Sun, 19 Apr 2026 23:12:38 -0700
Message-ID: <xmqqo6jetb1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Here are the v2 l10n updates for Git 2.54.0. Changes since v1 include updates
> to the Bulgarian (bg) and Traditional Chinese (zh_TW) translations.
>
> Changes since v1:
>
>     po/bg.po    |   62 +-
>     po/zh_TW.po | 2699 +++++++++++++++++++++++++++++++++++++++--------------------
>     2 files changed, 1822 insertions(+), 939 deletions(-)
>
> Please pull the following l10n updates for Git 2.54.0.
>
> The following changes since commit b15384c06f77bc2d34d0d3623a8a58218313a561:
>
>   A bit more post -rc1 (2026-04-08 11:00:10 -0700)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.54.0-v2
>
> for you to fetch changes up to 5f53a3662a2aaebe36f8751807be728f41f65907:

Thanks, I only pulled v2 and thought about redoing the pull by
getting v1 first and then v2, but it seems you retracted v1 tag
already?  I assume that v2 is a superset of v1, in which case we are
perfectly fine ;-)

>
>   Merge branch 'master' of github.com:alshopov/git-po (2026-04-20 07:37:21 +0800)
>
> ----------------------------------------------------------------
> l10n-2.54.0-v2
> -----BEGIN PGP SIGNATURE-----
>
> iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmnlaFEACgkQk24VDd1F
> MtUpsBAAoyMhQnxSHprl+xXd/JVOn/pswGUOvXyr8c/I/BowkG4wQfVyRwpw1uRR
> lO1jlEyyJjIAXJERnTODzuCEktBSfwedF7HgZhS68kTq7xV7hOuxJVS8GXCWI0O4
> TXQ/sNQcP93swIxqbTUhnP+sFwb3P7YoUDWIAbNJa7PLkGZbOdet4iWYSk3etcya
> JbE6MAZpTjNidleTcpjeC87Wy6X59VCSFHAr6x3AaOyaZ8W5VayiRJRb/Zy6gd2+
> ebc8qcPVXAWlwZfmPlQfCV964tbfhc8Lz/vHCmuNgA9bqqZZHPJSHE+UNhjuBOfv
> pDU8MVhKI2NTCqUdrW782fXCewL3iJ72T0AYTV6m8MhO67gi3OYk4Y0C82kH/6eg
> 9FEk5uu1HnwhdVYb0yh5mS7nEbwjJgUcfJelWggHfl/tDlumw1EOrQbF3Pe1DIIH
> K4Km7sNgAiXyJ2oePkIR9Pghh/5yJgQ39NUc7houFgaz2UfnQ3taXgaDL5cakhOV
> 42yCnLNsiTm4QmFbctMqLK7l7C2Ql0/UEm5moRosRS/KpaOMSlrmxhuE5Fad344f
> VeZsFiHJGtkB/hFb6lhfLEIryVjkb7mpt+6TMZD+P5os1dHWM4Xez09YHg+i6I1A
> lre6pVUSm59qQTmHhpPIl49Ak6A4t+OX+/3CIALotAkWucOuiCg=
> =WrJg
> -----END PGP SIGNATURE-----
>
> ----------------------------------------------------------------
> A4-Tacks (1):
>       l10n: fix 'zh_TW.po' 'Applying patch'
>
> Aindriú Mac Giolla Eoin (1):
>       l10n: ga.po: update for Git 2.54
>
> Alexander Shopov (2):
>       l10n: bg.po: Updated Bulgarian translation (6226t)
>       l10n: bg.po: Updated Bulgarian translation (6226t)
>
> Emir SARI (1):
>       l10n: tr: Update Turkish translations
>
> Jean-Noël Avila (1):
>       l10n: fr: v2.54.0
>
> Jiang Xin (17):
>       l10n: add .gitattributes to simplify location filtering
>       l10n: docs: add AGENTS.md with update POT instructions
>       l10n: docs: add update PO instructions in AGENTS.md
>       l10n: docs: add translation instructions in AGENTS.md
>       l10n: docs: add review instructions in AGENTS.md
>       l10n: document AI and PO helper in po/README
>       Merge branch 'master' of https://github.com/git/git
>       Merge branch 'master' of https://github.com/git/git
>       l10n: zh_CN: post-2.53 code review
>       l10n: zh_CN: updated translation for 2.54
>       Merge branch 'zh_CN-2.54' of github.com:jiangxin/git
>       Merge branch 'tr-l10n' of github.com:bitigchi/git-po
>       Merge branch 'apply-patch-reject' of github.com:A4-Tacks/git-po
>       Merge branch 'master' of github.com:nafmo/git-l10n-sv
>       Merge branch 'master' of github.com:alshopov/git-po
>       Merge branch 'fr_v2.54.0' of github.com:jnavila/git
>       Merge branch 'master' of github.com:alshopov/git-po
>
> Mikel Forcada (1):
>       l10n: Update Catalan Translation
>
> Peter Krefting (1):
>       l10n: sv.po: Update Swedish translation
>
> Stefan Björnelund (1):
>       l10n: sv.po: correct various translations
>
> Yi-Jyun Pan (1):
>       l10n: zh_TW: update translation for Git 2.54
>
>  po/.gitattributes |   35 +
>  po/AGENTS.md      |  877 +++++++++++
>  po/README.md      |   98 +-
>  po/bg.po          | 1630 ++++++++++++++-------
>  po/ca.po          | 4215 ++++++++++++++++++++++++++++++++++++-----------------
>  po/es.po          |   34 +-
>  po/fr.po          | 1244 +++++++++++-----
>  po/ga.po          | 1457 +++++++++++-------
>  po/ru.po          |   28 +-
>  po/sv.po          | 1351 ++++++++++++-----
>  po/tr.po          | 1368 ++++++++++++-----
>  po/zh_CN.po       | 1454 +++++++++++++-----
>  po/zh_TW.po       | 2701 ++++++++++++++++++++++------------
>  13 files changed, 11694 insertions(+), 4798 deletions(-)
>  create mode 100644 po/.gitattributes
>  create mode 100644 po/AGENTS.md
>
> --
> Jiang Xin
