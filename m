Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72573B1BC
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214575; cv=none; b=IdcUBggBVpjE9y72Lr3wyWz08SqYiE+sx6hTNSfLOXsXdA/aI/pZi0vkI93FdzMXyT3ulqWcz2EolepshV92sD2U3YhJr66YLv2LKTBsHH8xyR4F8xkDK2Wv4xB2NTPp8Qp7x8tiJ3jFrwiaY6N0Qttc8apkDsErWe3fm9nfljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214575; c=relaxed/simple;
	bh=PR3G2yJIdNtPJId15zxHrpqv0kNb+9Y7CaRtpu7Rvn4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fXnjxH7jIB15Sxn4n1Ip2hHtZzDTnVAfTsm+7oXHz2kNBH17l3oZfrgMAxRounXcm+L5U4XDwmVafoYlHELAbAzigOx+yvi1ZYIS1u/ayYpmSKwSYhH3xURwaTy6og2N+CxI3r7FFoPgizFk+7+j/Vq8/DPlXEXQ08oh3vd0DoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=mGvOObZE; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="mGvOObZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719214558; x=1719819358;
	i=johannes.schindelin@gmx.de;
	bh=PR3G2yJIdNtPJId15zxHrpqv0kNb+9Y7CaRtpu7Rvn4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mGvOObZEuIL0BcGjJ3L6qgVsA26QPC2jvfvpUgKZ0NWOAiNK6I2Is1OaXQyZXuYj
	 lsa5sBGso+9xuOYruu1Sx1Z/Ym4S9HLrQWalLh0flOPZGhsu5IMtOwtD5OP26D7ZA
	 NGruPWGEziHn7I/FXFAGRacD/BCn0hsB6XarsQ7Mv8nkLJoSrpPFRvXCOHDyKmydl
	 EJ4Ta6/aAhWRZOgy7bH8txUpDHn2C0Cu1P4gxrk0jMe5hmAnfjoX7xWj56Mvqq+Qf
	 voreXWrXPOIDbmlE5rUEySjzdaLWLJN5o8VgAV1MZn5eQX9AiAnXehbrP7W6KBsTP
	 Cj6Dz1rIYUi8v/9d9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.26]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Daq-1sF4f02CKW-00AcPL; Mon, 24
 Jun 2024 09:35:58 +0200
Date: Mon, 24 Jun 2024 09:35:58 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
cc: Junio C Hamano <gitster@pobox.com>, 
    =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
    Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] pager: die when paging to non-existing command
In-Reply-To: <ba5965c2-9f1c-4dd2-a2c5-e1bde832766c@kdbg.org>
Message-ID: <ecf29882-c192-e6f5-64f9-ac4cedb5d85d@gmx.de>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com> <xmqqsex7tp0c.fsf@gitster.g> <ba5965c2-9f1c-4dd2-a2c5-e1bde832766c@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Q2WyB3CxhKixeKH8HRHBXvUIhIs/9afd7K876sZ5BBKJ2ZjSlX3
 +vlrR7+0Q0Sg02SGc3qB3DZzCcdbhl7FdhY8G3MlTH3nc4TpNfrT5jnqUi2LDOdupPB5jLP
 TJvUEb5Mo82yCJkOTVMV+nnDsPfHiWPgUm8aFDsNdqKz1E2bVyxewwNKINHFRsFICstJmwe
 1zEdE5/CvAMkZiosq/1cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/2pVPTvYB3A=;Qssf6duwhlkGUF1pyGorMP4w68Y
 YMxiYiehrVujKfubCNDTkcMTCBEWaz5KAvzQtorBep7c6Coe6rUkTCvL1olRdc1XYdxabkQ2a
 owSTJ8gWggpCSbuwv/5rK59HnKNEN3cw32TtPpkzCGsneIppDGjHvpZzKPqFTS73DPPJzN939
 tz3SXhHlpGi8i/o+nB8IWV7vO0CoP42nUG1p7OE1PP9W7VOxY79szj7VyldKASg9d5cfJR3Ha
 IfsUJlhcBUoJg1SQ4Z+LG9DaeRCfB2JOZ/t5BhqDZppEopMP2wrPZnI4WZcLtwvY/kRGW3TEd
 weRtQg4FkyKyAQRy3dPmV8Yvne+plCm+p+DqgBraGjNOJ6PjoB6CuG9DYgcwU79/K3BtBMKh8
 MQuKi08CK0ekMdn3i00HGJaIixVgVkXiAKQF/jrvW3JYi1FfD4HF8/FIR/y4KpUEt6+QPiqRR
 Hyo1fZaRFb5yi5jUCiVtOVn6wb2bCRHTtxcmIvCq1AKdMFOw4d2gIVMR2abWytCQffetbTp14
 jdO+hHA5fmlOqmaktj/qCdiiCpuiemtKESkpQ7qoMztVNOS1gawsQ9Ip4LsZbK1dGQiHKwq8F
 bgd+E6cOufWpp1LOH7t46sLMm68T5W+2xJFihuGJCPV1h1HvstWeLY6LO04He7xLwgHA2fsAu
 jNw1j0lXtbH0tHwoK2yHYeAQrG8OApvKf02WXGqPI3YxIVHT3vvVcjc3vFxNxjeNM0lBdnnOq
 e8EuuPWYogYrVVTAfCH6wYvomJi5LE59gjvjhdDgqjSU/2wk0zLUNKcT64V2JHrr+wHP4nXTH
 +eS49nrzVv04/18UTomdihBDQDTJtaSrpb6+6D45Az8/I=
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Fri, 21 Jun 2024, Johannes Sixt wrote:

> Am 20.06.24 um 21:04 schrieb Junio C Hamano:
> > Just in case there is a reason why we should instead silently return
> > on MinGW, I'll Cc the author of bfdd9ffd, though.
>
> I don't think there is a reason. IIRC, originally on Windows, failing to
> start a pager would still let Git operate normally, just without paged
> output. I might have regarded this as better than to fail the operation.

I recall regarding this a much better idea back then, too, because it
was quite finicky to convince the MinGW variant of Git to play nice with
the MSys variant of the pager.

In the meantime, things have become a lot more robust and consider it a
net improvement to the change the behavior to _not_ silently continue if
the pager failed to start.

Ciao,
Johannes
