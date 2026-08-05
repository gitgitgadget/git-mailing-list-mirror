Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B64388E64
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940176; cv=none; b=DJuwHh0Exc16MCfDuCPSG8YocyggU3hd0GDhdWqy2WlKXIX5qUvCibwJsaqle+8wEx63YI4cJYIByvfQgVAiqrSjhizQoalTU8I0jHH1gVbhXRf0QzLThOReqsn8RqKn8tEF9VL0/LrhPELVUijtEUoyoempkJO4jZi6Etp1jxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940176; c=relaxed/simple;
	bh=i9tZH3MEo0D0VUErN553tgxZjRrdpdvSpHqCCiP4fdM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c12FzqEGtHZCVvlIH9NAymfFgC3/LM4uHNG6iQNtUEIVyODTrg6KZrku+slVwWdYVP6sjfeXtytdQPsWxkz5BkQmnVrrrDhuEmMQslovBOIc8ssuY6Y5Cf4sVDQ/eRLfJp6JQ7oGEfTHeRrPnCSFaNo3EF0rSiiKHHjCwh4w414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=qdGwrCWL; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="qdGwrCWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785940167; x=1786544967;
	i=johannes.schindelin@gmx.de;
	bh=RzVoL6YTp/DhrXLpSJZO5XXM9e22mPQ1Dc+i5C5FKUU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qdGwrCWLvgmnw4HHEj7zqs7dPcnhiezK91LnTJOVO9CtCZmn08IFNeUZmCn3lxJa
	 DgA33VcMZ9K75Q/v8UJU/eN4Vq2r2kDKFMXJopd/Gz/orabd3f99BkCfCkisv1jkJ
	 N0O76faJxBXA/czhWqUaL8mMa3A2WDiRypBcupbUN24uOjagIBDomOFAmvMmSCW/r
	 MumYSGxqNyP0OWAawP4OjGuwdnTYr1tvmN85jG+YHeTiLzFGF8XS1AJGsEJo0A5GH
	 18nI7TI/Jx96PVrJC3Hcsj3UAsKhHDGsp/19wuibzfDe1t1v/RWMq3YkpW/PoJCZA
	 CfgdN+OVNKj/ZnZNRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1wudxb3vTx-0052yY; Wed, 05
 Aug 2026 16:29:26 +0200
Date: Wed, 5 Aug 2026 16:29:26 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 06/11] compat/pread: check initial lseek for errors
In-Reply-To: <alcvjynWsHZKXD84@pks.im>
Message-ID: <11e705f9-d64f-f8c8-3967-d3289e47eb91@gmx.de>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com> <b31e0326e7c4f97753c80077c8f0927504f40370.1784069325.git.gitgitgadget@gmail.com> <alcvjynWsHZKXD84@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:LxSUrPcIKd2CLIpzzvxICYNdhVTxKLGbA4ufUUTHbLzlrP0huVA
 3WpSevvxkbhoxFKZckMoW6tlavBcY3N24hDpHJqGvl2VQdXZmCw4/nwlyYs9zMI+ezhwcSG
 mNOkcK5eUufSd95kbuXOtJjsVpfhQNZ2tazlwfRTSC9ATAPBZ6b8ivLmPYTrV0cRbQnPcto
 49K9bpdaMSSgwKLuq+N3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6nlFTy9mXIA=;fui85Vl8PUh6Kfw6bVZ/aYZRde+
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 15 Jul 2026, Patrick Steinhardt wrote:

> On Tue, Jul 14, 2026 at 10:48:39PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/compat/pread.c b/compat/pread.c
> > index 484e6d4c71..ac7d058cb8 100644
> > --- a/compat/pread.c
> > +++ b/compat/pread.c
> > @@ -7,6 +7,8 @@ ssize_t git_pread(int fd, void *buf, size_t count, off=
_t offset)
> >          ssize_t rc;
> > =20
> >          current_offset =3D lseek(fd, 0, SEEK_CUR);
> > +	if (current_offset < 0)
> > +		return -1;
> > =20
> >          if (lseek(fd, offset, SEEK_SET) < 0)
> >                  return -1;
>=20
> Heh, funny. I wanted to complain about misindentation here, but your new
> code is actually indented correctly. It's everything else in this file
> that is indented with spaces.

Heh. I did notice something odd going on, thinking that Opus ignored my
clear instructions about tab-indentation once again when I replaced the
spaces by tabs...

Ciao,
Johannes
