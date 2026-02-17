Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62537419C
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354566; cv=none; b=pH04TnAq/wek50a1QMV5nmzDzSBQWkdF4JgTH7ab1MF3zesj36RC5CwMgdmmVwL1fwjfut7UN0Yd/5vDoGMUj3ZTYloOvsZAQxxtuUAmgRn763a5QEqlHD0IWah3GW/tEQcBtAuAC7e6V2PkGuBKleA6YKo6H9vdB11Xvt9mHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354566; c=relaxed/simple;
	bh=XMq25Tsiej9w18Fm6y201aWNfSVK6xrJU2vRCqSt8qA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EKYxSepaWs4DOf4/JyWwTfvZPFEwofV5ydPBuAdo6JwD4qaFgw50/gJmqzwtPlFKVj3xRAfpNxCujxT2NwJQp7dzhbs9D1i94/OdahjxuEzFEz2VOpqlYKirJi3KoAYO/xhAMRFCI2LHHcqI9cLdYqXxcdKh4U12uFqR0R5BikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FDnVOENw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TycDrUVB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FDnVOENw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TycDrUVB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B8431D00162;
	Tue, 17 Feb 2026 13:56:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 13:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771354563;
	 x=1771440963; bh=ekAvh2tFqIOt1yxOagjscQdNnRNKEIXR6s9FFiqzD+c=; b=
	FDnVOENwVbZ4RiKIOUKLGaL9Vu2lOp9K3QQ5L6NftZLwo6JWYkA8zW0OXOp3s9hP
	e0P9jfWzmZunEkuT+0Oifc6KW1YfRcBl0DeuszNfQGYkk+h6wrWSgC/PZfgmYSB+
	RXeP8cclYUOBLNoAGyc1OFePTv5GPQLNavZWG23BlBQTyV6bzcMjTS5+RyBKxEkG
	vDmk+koaC7ElUuX5OI7EMhW6IxnOa3NrBTSPd2Sgyul/OxcYKs0kAJRawZaNoM2Y
	VXmOMylQ5VaVkzN2WDtn/6JExvaDI0almFIVTkR3Rs0yyuZov2gpG6YE2MCm1CWv
	HEONiufR+sAGdDXuYMy55Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771354563; x=
	1771440963; bh=ekAvh2tFqIOt1yxOagjscQdNnRNKEIXR6s9FFiqzD+c=; b=T
	ycDrUVB2y9/aeRbOutJHOt80yGE1HzJLWyJdjyf95eGZ3zOyXxqaIpNSmQxSxFQM
	mP5MWXrUPa4VMEbbWs9tXx15LSZYQNnhXBvF1o3oC6DWfOpaf2ne/ZikR89IZfTb
	aqaVn2mwPjBjTN0h5VsdJOnyZPes+iHTCUZ41Ue2/xfGjamL1y5M/EsQa54Mr2Yc
	mBr9v3hK1nv7KzVUpKiiPXfVYCLnVzaX27kbZIH5UO2UohcVoSN+hfd/+dzPbrIW
	FFxl0Xtx6b5yKKpH0bdE42ldyNgzFWAx5iMw5lQObcR4dQguwdA9sCZ0oQnChIAy
	7DvlbQw/zOuhb0DfHsbxQ==
X-ME-Sender: <xms:w7mUaWrDPyGf_LZSpaYVll7RyaTPCKHAYrS6jcIssbYgcoDB603hoA>
    <xme:w7mUabhWnJ7GNpPbgac2J3fGgAi9SBkqvzMuZXHSYPHhU-9lkSJEuohta_U6PrumC
    doKIYKOoeZf5V0e9aNE1plEFo9zC92kPlYb2Uljf5NmyCOOaoERpw>
X-ME-Received: <xmr:w7mUaTjPLCPisi8PQJSBBnO9Zu2TH8J86xt3t6a44Mgnnx9EZUBY8MWWJWr9MSpQc_fEpcCWS9wczWX_5Ye0A3WwnkbFkds7tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilh
    drtghomhdprhgtphhtthhopeiiiigrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghlfhdrthhhih
    gvlhhofiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:w7mUaRi1gVkUOzC9pAywm8LbEkxm4Y9dtNWjxqJSTL9VuAoYOqICJw>
    <xmx:w7mUaTJoI5xoZP3oiAuE_NRIiIkmE_5UoPtoycexWXYLcmVrjov5Dw>
    <xmx:w7mUaQGjxLi4FJzp8GmQ39QvNU2EGoNu_ErSDFdR1tTyKdvIpCqsJw>
    <xmx:w7mUaXSVUc_49_WzYfW1wNkEumT5j0tKSJl2Pu379f82jNsRZ2vxpA>
    <xmx:w7mUaexRVBAtpZwwewdDjdkUlhqtFo5baL5N22MVJxg3TDrrRWpX9W5f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 13:56:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Matthias Schwarzott <zzam@gentoo.org>, git@vger.kernel.org,  Ralf
 Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH resent] l10n: de.po: Fix spelling of suggested
 color-moved-ws mode allow-indentation-change
In-Reply-To: <20260215102154.21582-1-zzam@gentoo.org> (Matthias Schwarzott's
	message of "Sun, 15 Feb 2026 11:21:54 +0100")
References: <20260215102154.21582-1-zzam@gentoo.org>
Date: Tue, 17 Feb 2026 10:56:02 -0800
Message-ID: <xmqqv7fvb3nh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Forwarding to our i18n coordinator.

$ b4 am -o- 20260215102154.21582-1-zzam@gentoo.org

if you are "b4" user.

Matthias Schwarzott <zzam@gentoo.org> writes:

> Copy and paste of the suggested mode makes git fail again and display the same
> suggestion again:
>
> Fehler: Unbekannter color-moved-ws Modus 'allow-identation-change', mögliche Werte sind 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-identation-change'
> Fehler: ungültiger Modus 'allow-identation-change' in --color-moved-ws
>
> Signed-off-by: Matthias Schwarzott <zzam@gentoo.org>
> ---
>  po/de.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/de.po b/po/de.po
> index 6b65bb618076..16871c9a839f 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -16564,7 +16564,7 @@ msgid ""
>  "'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"
>  msgstr ""
>  "Unbekannter color-moved-ws Modus '%s', mögliche Werte sind 'ignore-space-"
> -"change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-identation-change'"
> +"change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"
>  
>  msgid ""
>  "color-moved-ws: allow-indentation-change cannot be combined with other "

Thanks.
