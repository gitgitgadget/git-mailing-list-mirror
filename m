Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073153EC69A
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984810; cv=none; b=Pqe6s8Y9AQ7ueekqHyDlUVBZLx5Lc2GqPJZRrkAzPdNjLLxY7+nM6wbBiEP6O9RdwE7JCAmHoQYPWa06x81ttl6teerTl/vdUlmk+lUmzm3hKgveKeNfgz2Nvqd1viKU+SKyhOKQxy8cnmv7eVrkNcsnHVj72GE+JCf+w6n+lYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984810; c=relaxed/simple;
	bh=FOPL863nPZ0ex8TP1J922ucRR7ybGUJtpqGp5TM2IPM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nIY0QVkGL55RUavxUkz1eYMGwpIoNcVVQAaCMjz4FCjGkPYxeR0M3PJZ50OOUEhsvW00Fzw1/EsjSYGG++os0HTKJswRSzme3i9N19awOLjzWWaKpM5ZCe8Cmf1MFHh0LQ5iJr4UFEd1/2OYb2KaFr0O3n5IY7DFczeB02yGQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Xi/WoMBe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Xi/WoMBe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788984805; x=1789589605;
	i=johannes.schindelin@gmx.de;
	bh=FOPL863nPZ0ex8TP1J922ucRR7ybGUJtpqGp5TM2IPM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Xi/WoMBe4WIYtt0LMDEFajAiBFeKyJylkUUo19hU9bOYYaBfcHVrA02HEZDliQIM
	 SgwrGAkYVmvDfreSMeqWp3cFUomno3OU94/MPjHeCELEjyfyiO47Wf6UAZjMwZf6f
	 WPF+0KTFMAB8rb+zTBjqccoZ1iYweLPpa9P+xdRqD5sOg6wzAlU05ES37JePs7Oma
	 eXE33BEGcWkTT0zlZouQ0Mhj0dc/g6rloMJ7udnLLLDTXu7v41M/cbog8agiJehPM
	 rmTALLgEwdZDvaNAo5TW3iSfHiZN4VbwyHUMMyVPXmQv2nfrVbZ8dSNyxXUD2gGdU
	 sQe28TdoT/828TaY8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1wtIoH2hse-014Ktc; Wed, 09
 Sep 2026 22:13:25 +0200
Date: Wed, 9 Sep 2026 22:13:25 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
cc: git@vger.kernel.org, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    Junio Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
In-Reply-To: <9f078382-411f-4865-9f01-4fe0b1ee118f@kdbg.org>
Message-ID: <7ac8168d-5b5f-fec2-ec91-ff72f7b6f1fa@gmx.de>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com> <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com> <4cc14553dcddbd7fb1a49864ae988bad19626391.1788981436.git.gitgitgadget@gmail.com> <9f078382-411f-4865-9f01-4fe0b1ee118f@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:IlFqfxcLsrKNZzhcCuxIAin+lJNnPrYac1lsyllyyGmxE5uA3Hq
 DjF6qHrTFgl7GmJjjb9ITMeEA8prYrHFYU+g1QoURePsF6h+Q2f+5k20a4d7/6vf2TF7Y2z
 1IWddJckwlxlgaLUL1TypVEYp5fD398tkswJtp4nerhQl+JfJbkeAXo002EpTL5AEADNVZB
 /L5uq9qqgUugnuuVGYCzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4JVmd3wKTB4=;hGCyISmIA/uC8hl7kp2lN3xHJPW
 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
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Wed, 9 Sep 2026, Johannes Sixt wrote:

> Am 09.09.26 um 21:17 schrieb Johannes Schindelin via GitGitGadget:
> > [...]
> >=20
> > Note: This keeps the same, hard-coded MSYSTEM platform support for CMa=
ke
> > as before, but drops it for Meson (because it is unclear how Meson cou=
ld
> > do this in a more flexible manner).
>=20
> I think this paragraph is now stale and should be removed from this
> commit message. I don't know if it makes sense to insert in 12/12, thoug=
h.

D'oh, of course! It _was_ unclear to me how Meson could do this, but I
obviously found a way to support this _somewhat_.

> >=20
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> Except for this, this is looking good now.

Yes, this should also have a `Helped-by: Johannes Sixt <j6t@kdbg.org>`.

Junio, can you squash those changes before merging to `next`, or do you
want me to send another iteration before I go to bed?

Ciao,
Johannes

>=20
> -- Hannes
>=20
>=20
