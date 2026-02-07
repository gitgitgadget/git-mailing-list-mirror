Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD125CC74
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770499703; cv=none; b=lPho+I8+RaRCXXvlbcNmGcAuE5r1STfWe9nlI47u6wfSpeyAq4nPus0NxGVCs3alBCM5ECY16Mh0G8ijrtjsdB3Vf+Nh5o6FCp2nQsuHfvdK64/zjXwPQrQgXdB9RAivQgdJAC0+CGsF+LM04jQoERnMzUpbi3xAqWSYYOVjzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770499703; c=relaxed/simple;
	bh=V8QuhXKh1n1eJC/NO2QGhvUAi3NNOM7Huj8dvJfOmfY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oRTUTapVfrt+6vhcYPszlntvj+hOwaF/LPbiDrM3ZBKl2XAjuYVyPLeoFOgEoHTn6KK3MUTKXCC/SB8XzunKSLqGRBzcEBWfadA90F8aemB8H9WwhSWqM6sm/upTGtxtOy1w3Fc3ZC+O7sLdpztWyIXT0eQjQSY6srJiLuoQiEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=CWFqI3Xf; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="CWFqI3Xf"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f7kb12Vvvz9tH7;
	Sat,  7 Feb 2026 22:28:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1770499693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQTXchJ4LFJIY+xogCQYjuUrTMflTT5XZwExLvsLb1g=;
	b=CWFqI3XfRNsl3HNOCo+ZbGoq5PMmYEw5pf9qPA+n5SAGO5tmjRaVewT4hqee3r42KgDa/Q
	Dqg3G340WjY/xjeNmdK5wG4jPuBdMYABNHRJibIDySuB3bJf8QCFGwW91aMyo8TKKLjLT3
	uNIneRbR7MM7satrgrvcAF5xJytlm6dKToYl2BnIUuY+M7Ksjn+jVdxWrQeVsaVapsCDcr
	w69UBENSyvzE0PHlqpqHE2tTD51ncaLH44vyJ4TqNx8yoI6KoSjuFVovHSIPnYO/YYuCKp
	cMI9y3KgX52BAWVNL70yfPEtkbs2rTArGSvq25318AknEHF/paEwwV6hB/6bmg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@ytausch.de designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=dev@ytausch.de
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2] merge-file: honor merge.conflictStyle outside of a
 repository
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <xmqqqzqxczeb.fsf@gitster.g>
Date: Sat, 7 Feb 2026 22:28:00 +0100
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org,
 Manuel Lerchner <manuel.lerchner@quantco.com>,
 Yannik Tausch <yannik.tausch@quantco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <75AA7DD7-F8D8-48DC-ADA0-74E56CFF351D@ytausch.de>
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
 <xmqq4invm2dk.fsf@gitster.g>
 <3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
 <fa7fc215-03eb-492d-9af4-457482c56a48@app.fastmail.com>
 <D514F3BA-36DD-4DAD-BF73-609730390A27@ytausch.de>
 <xmqqqzqxczeb.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Rspamd-Queue-Id: 4f7kb12Vvvz9tH7

> Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Please do not send patches this way.  Giving responses to review
> comments is very good and strongly encouraged, but stop the response
> message with "a new version of the patch coming!" and have a separate
> message for the patch itself.
>=20
> It sometimes is done to interject a sample patch in the middle of a
> discussion, but then the convention is
>=20
> ... continuation of an existing discussion ...
>=20
> So, how about doing things this way?
>=20
> --- >8 ---
> Subject: the title of the patch
>=20
> The proposed log message for the commit comes here
>=20
> Signed-off-by: you
> ---
>=20
> ... notes, diffstat, diff ...
>=20
> i.e., use a scissors line to tell the receiving end that the rest of
> the message is a patch message, and override the Subject: with an
> in-body header.  Omit the (=46rom <object-name> Mon Sep 17 2001)
> "magic" line, "From:" and "Date:".  The last two can be taken from
> the e-mail message anyway.

Thanks for your feedback on the patch submission format. Resending v2 as =
a separate message.=
