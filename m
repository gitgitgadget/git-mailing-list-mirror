Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C4204089
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286912; cv=none; b=Y6JDmsjMmeWTVIBg3RF5EWXXom6asp4FVQRRFCRkIAGQ1YXuQRPN4z9OizNs38AxWttd+EX2hjjJ2G2PFbqINJPRP1WrjeDOBtGbrwgo1PGPLBdKo9aP5EvSeQt/pUab5JK7cxwREYdnlLq6BNbrEbx5z2ik2p+/N4WZ7dksFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286912; c=relaxed/simple;
	bh=76Bkqhka5Qmm9hxvHTH2K7AQwnyd6Ln2wG9ghTAYMn8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ouEiRf3TtdNoBTugDj9vzyIgyBuD+dLJewJNynTy9dm2CADBFSFdcC+Y1oDw7IvgMitdJhszNqPFrpmcJJyqxM8WtDkyRO7m2owAMai5sUNiL+g27feMqiWVsWcTXKk1pvAgMmOTvhTdaz16wnVDEmBaFhLOq0lxFM+vb7KlOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rebS5zR4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sg00sUlZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rebS5zR4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sg00sUlZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 510E611400FD;
	Fri, 18 Oct 2024 17:28:29 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 18 Oct 2024 17:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729286909;
	 x=1729373309; bh=cSwXPTz4Yqu9NtovPN07i2cp8i5i6038ML1ZOlUiCXM=; b=
	rebS5zR4fU6w7L6uPGp4uZ5/whz1oIjVcGklwNaZ899a7BluPqP9OLJou6QHhnHy
	aZF2Cem3zvLNwtEwy8Zsuqnlx8m1dvEhEcxYS48ImcKZ2f+MH7a4KpD5iH5CS6ba
	u/eN9w50l/ykXjughSMs9cAzf9qxQErEKOsxMu48SC1JstxSWPPkBQYzJnZ762Ru
	tYPJGrGOOqppg+qZvEg5wTpZ6AyJBycQlQQ0jKn/dQVa4Zo8eVcSIShoAvPyhoTT
	oIJ6R3ynTkm44l2etw8TToP4as37o9FTpQ0zWUd8vlZB/WNb6tPJN0eZt5QK0O9y
	gbsqn3t5S2TkYrRoQOh63A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729286909; x=
	1729373309; bh=cSwXPTz4Yqu9NtovPN07i2cp8i5i6038ML1ZOlUiCXM=; b=S
	g00sUlZqsxnGHjoP2ifGUf8USauhs4h6UeN9yFJGg14K8qr1k+aSsJU7mZ9aIte+
	384RNKABLXsVx6mlZvHcRew5JEzkbcbVX7Gi/SJjQxxszR/y7ls0kJl8ySejEhNT
	9swnB2ghWNcEc2R9JmKA6gTx05Uz47xIDGS0vQoUdWVeqixaAHzkCR65+B7B4hFs
	Kr6cJlqJUJUQfDNJqXDPh0dljMaQYFaVekcxVcTFYbzs8nEEQxZl14SXWxJHdAXe
	6pHyBdbgWBm/C+j/zvyGbr1I0uod3EntYTCoSAXKmdWLdGN3lZTtfzXT98WBfCT+
	7Wk4AOZdaZM6tm8J7U+xA==
X-ME-Sender: <xms:_NISZxmMJTxMmpN0LeEFx26Obu3N3uuKmifHCCgmVcY5tcu9lBMZudw>
    <xme:_NISZ8043XTt_wmK2aOsSarhpAODp35Bjr21whfo6GuhuHeQqi1JEm17JkmrDq8Dq
    mTMszoe0BwqWBJ3vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggurghm
    seguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghm
    shgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_NISZ3q1lZ2WA5EyW3X60P26qxERBXGl_r3F1IqhBgKLfafVK6lEGQ>
    <xmx:_NISZxlNJfd1-K0loOO-THxFW1dObWJWwdAV959a5fMREfgrcV4ECA>
    <xmx:_NISZ_0Ndrtw9nUgy28QJg4tjJlET-BER6fOfVdWZBJLB9_YmEK5XA>
    <xmx:_NISZwvf961yoKM8B6bTRSKEYd_gCbQGrJoFgqCQGfJCD_2osKN4tQ>
    <xmx:_dISZ_-C1-vOIQQ_wVveQ_qf2WVBm3wq4Mca2mnQo52dJoxOGqLc88JZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 41AB4780068; Fri, 18 Oct 2024 17:28:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Oct 2024 23:27:50 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Adam Dinwoodie" <adam@dinwoodie.org>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <71e8e44e-dbf9-482e-a351-3a82aa1ca5dd@app.fastmail.com>
In-Reply-To: <20241018052952.GE2408674@coredump.intra.peff.net>
References: 
 <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
 <20241018052952.GE2408674@coredump.intra.peff.net>
Subject: Re: [PATCH] credential-cache: treat ECONNABORTED like ECONNRESET
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024, at 07:29, Jeff King wrote:
> [jk: commit message]
>
> Signed-off-by: Jeff King <peff@peff.net>

Just curious.  Why this bracket comment (non-trailer line or whatever it
is called) and not a regular trailer?  All the bracket comments that
I=E2=80=99ve seen give some comment, often about tweaking the patch or t=
he
commit message.  In this case though the whole commit message is written
by one person.

--=20
Kristoffer Haugsbakk

