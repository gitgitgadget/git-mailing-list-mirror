Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F02FFFBE
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140147; cv=none; b=Ce9HS9tYZ5HVveSJjHtNykV13UHiE3jqOlMeYOFTEO+DHimmXTKz7FQf4jnEik8hMRltt57q8y7NOpWB0qo0RDGTY7DrSn75O/1wgoDo0+Rd3fML4XiDU4UEwz4R49woGzgohGnuBas/qxRBMmChGkacQaMVNQW0VC2uzmV9BPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140147; c=relaxed/simple;
	bh=ldiEMndXDbw2nJk6ERUFpTHNq7w2iT4i2FPomEL9JJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=opfxJveChFoGbuI5GPGkEWPzoB1bwzjKQxJkK3BpMojE7ifvHKhKRyxKsXoophuW44qyvRGhqbxI6jht95QtEMRuBvwsMq1QtIZgz70Qa9DMTCC4dRZh8S4uKtKhgT1GA3hTclS55xHBegDXiMmSt4iX28zswMD0GsA8rl2pGtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m+19PkdS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DWfHSwbG; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m+19PkdS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DWfHSwbG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB2D2140016A;
	Mon, 27 Jul 2026 04:15:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jul 2026 04:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785140143; x=1785226543; bh=KXfoe2U09+
	ExehSE5gKyXuAOzwEllx58Qvg3m0wSgoc=; b=m+19PkdSSwH3z+bBHa/QZ9KEeE
	ImWxgTd6B3q34xEWBYgCmGiy05eaPcN3kOtabOOnsCmX7pfHAIKkkWqd8pGcT11X
	+Q9BgnRErWR1zIRtWOfVbWjRRsRZqJ4VBQthwymGlI+KjzXcvd6XbrdmVCLWVTZf
	l0TXMIFm+pAIY0X+vC2ZzNYuJ6zjkAvsNNWz3dEXKy3mtEOQ/s5RwS3u7a2JAz0x
	uqZUzaa4/TUKpgliAy6acJr0LyYd7M1UR+oZaMi0rijZVdSQpXFkHYo+Ujmfsgyw
	l9PS5VBREB2Wq0TaKlL8Elc3P41o1F6Ki0thuptEQmhTqBDxXIO37h+MrT9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785140143; x=1785226543; bh=KXfoe2U09+ExehSE5gKyXuAOzwEllx58Qvg
	3m0wSgoc=; b=DWfHSwbGcqgQSSCtM+VVCsoSjNdPriy2ESflAZt1/VMXhTub3sJ
	ksVmHT7MtIEheHNFP2YLk8NoeSFvPotXvLtRF9p0LyUrad+2ay2j42l6KLlpyh3p
	kqhAoqRPArbKSL+PwDkBAcahkoqxH2F//lI2oK4C2JYhpgPNhWY2PV88uAoB96pd
	VzGBukUS1S1NJGabvNchC18VVPVWUAOnp1QrHKh0TWv6F4f1LK5dqo6yq5mNV4wX
	sz0vozVfryOOdQYP0ucmGlTT9W/4jy0FDJhEKoBBEuX4CU2fOUezt6mNtr9VPN5R
	1BEdl6/QPK1vciYn8hzhR3Io9kEX/KDG4mQ==
X-ME-Sender: <xms:rxNnauh0BJmQnqPJwXXBWrmxNsdZDf1e0zrSkQlqVDk2xNkI5it98w>
    <xme:rxNnamcuoM9u2lF9yVNzo5PBeQPKT0VhOZM37KOjhlu_iO0VO-czu1aBrVe6HUMq9
    vAHGssKswa-tGQ-FmGpGJOlVRozVnMnUOeVA020M4bmftWMnloi5g>
X-ME-Received: <xmr:rxNnajdUVp6glM2b9x6alhzY4a31yFLk_qVit8DDYd4R-FkU_btriL46GwbFYMuJ2HyX80wSl6e6jB1Kl0f63Fve8o4W6Hn5bg>
X-ME-Proxy-Cause: dmFkZTEsLmvTZHjLxK1Jwg7dnIjgLVzIPSNK4bVaRD2KNDLrqTIMmE/bDb1pezIMjzfi7j
    9WIshifQG70ejwGP4JskSYFwtXhT2WFmugUiUldr+KlccAKXjF2tWdyXodkHSjHlL+i8Wx
    /62bPx2k7KcVtvIhY3702Ujq6orCxeHrhM//OhN29SKuDhxW5PTGQHh4ydxqMDzS7IarQn
    /HqiWXJ5gYAZu3sFy4qsHu52WcAkhz20qwE3xnygn7EMOvrpfiaeuCXjCJKmfb3dOdc9+C
    q9RXY/dRJrfBFrIb59pJFGK+kECuMGau20PgsAEwi5HhH99FW0eARNWRk3UgKyf7/Wa/VE
    1Tv2M1LyDEL5NmjN2+aou0vQ5X9PlVGmhc1y/keRka7E9vuOljiW/Z/enji/GlNBkyehPX
    JJb0GWn6iNNacJbpYyViGKjDMJY3Bfp6XjTAneL/Jmdlel+3GwfDP4HvqjMk3d1DzlZ+Mc
    t/WNv5Op87Rha3cq/cnGSKEBqfjlCi5O6vxNdZKvaHORWpFx6Pzt0fh/PbAMP2Zj7s4gEV
    vRBT95wyHlv8FF/VsjaOHGQ/A02uH+5v1pdV8V34AWLgXCI1RYSuVSo/QvhTM268wNrzmb
    KYgmN9rkS/MXNaawgQ2iyYzjkWvrIk5LnZfKahIW62AdkwBugFAhcNJPhY0w
X-ME-Proxy: <xmx:rxNnag_J6TffkMTKPMHvS0H91NlruXOAmoTo15EvIoowDmmIz-UC_g>
    <xmx:rxNnavmQY5933tLCYJdTdSaut3b6FXvYaf6s-igxPzeweCC2rZzmUQ>
    <xmx:rxNnai_xwe_pywVmudKKLzLSWtZP_7WTaS1BMA94NDTZInbQnt8pvA>
    <xmx:rxNnatn0atuSqJWbR_aqTBfoIex8uQtPvFIs36XQzq9NIqXyVhGN_g>
    <xmx:rxNnamc_qr1je9hxOcqwUVyFOjqbImAz4RyxQbuwdyb-RzMSiD9QZVQM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 04:15:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] t: add and use a commit_body test helper
In-Reply-To: <20260726224803.45131-1-diy2903@gmail.com> (Shlok Kulshreshtha's
	message of "Mon, 27 Jul 2026 04:18:01 +0530")
References: <20260726224803.45131-1-diy2903@gmail.com>
Date: Mon, 27 Jul 2026 01:15:41 -0700
Message-ID: <xmqqldawq24y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shlok Kulshreshtha <diy2903@gmail.com> writes:

>  t/README                                  | 11 ++++
>  t/t3405-rebase-malformed.sh               |  8 +--
>  t/t3408-rebase-multi-line.sh              |  4 +-
>  t/t3434-rebase-i18n.sh                    |  3 +-
>  t/t3900-i18n-commit.sh                    |  4 +-
>  t/t4150-am.sh                             |  8 +--
>  t/t7500-commit-template-squash-signoff.sh |  4 +-
>  t/t7501-commit-basic-functionality.sh     | 21 +++----
>  t/t7502-commit-porcelain.sh               | 77 ++++++++---------------
>  t/t7600-merge.sh                          | 14 ++---
>  t/t7604-merge-custom-message.sh           | 18 ++----
>  t/t7614-merge-signoff.sh                  |  9 +--
>  t/test-lib-functions.sh                   |  8 +++
>  13 files changed, 81 insertions(+), 108 deletions(-)

Doesn't 'message_body' t7509 has follow the same pattern to hide
exit code from 'git cat-file commit'?

Thanks.


