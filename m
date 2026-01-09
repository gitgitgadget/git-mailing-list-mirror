Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76819500966
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989078; cv=none; b=SFkVt36X9pL2L9yimPSj9QkDi8h2KLA2AVweRu1ohJSVB067evw2kFqlap5CJ5bYdtg82e+Mpb4U4ibEFGAHeksEcflfyJLNG/lwPqAiqFHnFg/CoQL1+69+nCss92c2Jcy+LZCJksJNTsk0R673QCnCbaskSuaNDZpuLTvSwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989078; c=relaxed/simple;
	bh=S6DXTisEAumJxlEZdGnLX4aHBaAxPdqyNCfUWnpKNr8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hNvHa7KBaFRcNEYQ7W0xrIiCMcQkiIXRRIdIj5A4VYZLuoG3AqswVuPbDnCBI9jRaTpThxF9iSVtY29VuwqUgY9I7AvPbQFx9KgwnTICMdsHF/supokwHKuk4IANaB6VpabHvGcC1vU4lKC5dbY08o16bK5rapTBQ/Xspg9Q+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ajpTHZ4F; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ajpTHZ4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1767989074; x=1768593874;
	i=johannes.schindelin@gmx.de;
	bh=mE7z8OHsAgPGh3K/oUV9R5rZswohr23awLUEyceLp3E=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ajpTHZ4F6tj8KwIa16RFSJ3Gu6dBOGI4QNcz0hUai639JLwVbZhfV5SqbSbd2OPg
	 nqKGmmtrWztE9N1awcmzMAGcFo5JWFIc8x48e7X68n0C2nJchq+bw6lG+QmI5EYnB
	 qNkuwN6EnbQYoyiks9uiTCa2r1ob5sLWr1a5A8uIZgBVJC/s53uo0y3nShdu3Cdas
	 QtYkf/U4wuPAGbOFLueLtuVqbjUbs7SCYdCWHWHDb2gvzD8MmWeGv4gdYZPQkWf9H
	 I3y55OaTc0RAC8IvZVRFhTWKjF3pMCBKGrXieLDdvCUjaqWi+Fek5N5JMHjTOqZ6W
	 igWZ43yaaUVaePRhnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1w9nn62m02-00l8Ot; Fri, 09
 Jan 2026 21:04:34 +0100
Date: Fri, 9 Jan 2026 21:04:33 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ben Knoble <ben.knoble@gmail.com>
cc: Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH 10/18] mingw: handle symlinks to directories in
 `mingw_unlink()`
In-Reply-To: <20488887-14B7-4471-9241-9CDBC3EAB2E8@gmail.com>
Message-ID: <14388349-d1b5-fc8f-b6c7-4a7b43e64494@gmx.de>
References: <282aba42e8aeed336318614523ff8b36d3131e5f.1765980535.git.gitgitgadget@gmail.com> <20488887-14B7-4471-9241-9CDBC3EAB2E8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1227151837-1767980282=:24642"
Content-ID: <358ee381-05b4-8cbc-2312-de37d0a0203f@gitforwindows.org>
X-Provags-ID: V03:K1:k+k1dggaCHbazAV2Ml5/WqRhybqMzcHjMAceY6gy1Q3kPb/dr+r
 IwOccr9zoqj2Dz41zVbYufxtkhIHU73lmcdusMhQ68yctLryPBF14eyx/QsI8dkxdjZnYlu
 14iH1Ohs3dSPbYf51KBduCF4wju5pcqJU2a4bCFMkX2y0sje74/qY2vYmks2u3B3B+6tdnj
 bOVU9Ef2Gmlc3E2O8VE0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7OBcuCNchYM=;kK3gInV7T6h9upm64aIeyGZTFhx
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1227151837-1767980282=:24642
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <eadfc7ba-ac52-5992-8309-2ab0d559ac0a@gitforwindows.org>

Hi Ben,

On Wed, 17 Dec 2025, Ben Knoble wrote:

>=20
> > Le 17 d=C3=A9c. 2025 =C3=A0 09:17, Karsten Blees via GitGitGadget <git=
gitgadget@gmail.com> a =C3=A9crit :
> >=20
> > =EF=BB=BFFrom: Karsten Blees <blees@dcon.de>
> >=20
> > The `_wunlink()` and `DeleteFileW()` functions refuse to delete symlin=
ks
> > to directories on Windows; The error code woutl be `ERROR_ACCESS_DENIE=
D`
>=20
> Casually reading; spotted =E2=80=9Cwoutl.=E2=80=9D Presumably would?

Thank you for spotting! Fixed,
Johannes

--8323328-1227151837-1767980282=:24642--
