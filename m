Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA633397E81
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980983; cv=none; b=LkMntb1TwEIZGMM80kIIY2fB2Da9TiM666pRkC9OtDM8krJaDlNTnIcYfNPXotLXqvXXxzZptoBu9srZDcW5oE4QGoifw6v30IHN+DBM8/gr1FoNjzu+FsCNqNa+gjvOrugNFwOUuJJA8KI6S1xNZAyt49Z4+WuK2O8+xtbFa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980983; c=relaxed/simple;
	bh=6abCopjcFaeW88PuX7YUKu4vX0LEZq+Mj6TdUgIzDM0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=exqr6ChDzgZ0Rjsqt0zn+sx8Jpel4S6q3mNnGg+gVzqFwRQxiwBYnDTaopkFE2Bq1AVylbou8GdYauElZmyps2IXaJ/2xe9iVy0aqGPrRlKkfsh/oQv4ojXQhsJz0PboyFyEjUCDJD5Sh94bikNRiADzYgndiDK+fsQF+c/lBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=lAO+jwuc; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="lAO+jwuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788980978; x=1789585778;
	i=johannes.schindelin@gmx.de;
	bh=SEZKzMcLOfomB3wChtRdu3vIcrQLrv7NS5rNrgQ7UFY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lAO+jwucLNjZ9sntbyZmK3jrQv9SN1AhykdFL+yGOVujRvgg8xw0bdg22WIKHR+W
	 Pilr6fpWS/kpCpP0sOh2G8kCtBp/fCh0N/0MykAyvofGETK2ZkviivrnyMwJl8r02
	 1Vob+dqJHoennkGd6j0VZAeawHkpMu5lZWSD+nLj7Sdup230YsnyYC07ihOYFsiqi
	 jEYeaMzu5GriFNTEUKevmNeEe08wwSAbL2foivVw9QXzQGPBiRRe7KgvMCz/u61St
	 OPTEZRBhVufDhrm5+s6yptfo/uNUci60A+e0OrA0f3wk/rdtK4kYTytlOr+cWZSi9
	 cxbqJ5MwEG4wJoAFVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1wz6k90MFr-00Ar7S; Wed, 09
 Sep 2026 21:09:38 +0200
Date: Wed, 9 Sep 2026 21:09:38 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH v2 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
In-Reply-To: <a5ffcb9c-b223-af4b-7aa7-1a3db31a5f59@gmx.de>
Message-ID: <3b6d1078-202b-d779-355a-df376c139249@gmx.de>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com> <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com> <9de4ea7fc1d250e8e9dfae386424451242cb3daa.1786521173.git.gitgitgadget@gmail.com> <4f4129df-681f-4e99-8b1f-8bb96e206a2d@kdbg.org>
 <a5ffcb9c-b223-af4b-7aa7-1a3db31a5f59@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:VRpnesYqqTL9U4mKc/iLj3jKWoiO3jpSvVc6UPVrbHWuqbpZnFR
 0KVbaGnARz6lBc2YQLHiLUrDOvno5HG4Lnkpkp+yF4eiaKtGHZXkByHDsJNH3lb+dAqN9L8
 JWvzll8Ec9m8QGANY6BEJ/nK+ONkVVcQjH0RI6Pyy/nQPKxQBW8krZ5faYiUSlc8KJEcfDx
 81AGZPwM63Gb91l4P975A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QzJXYaO7GFU=;7X4KX0lKkPKdgmohk+UNdLOCQUg
 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
 ZcJ7fzfK6sYnNucEq6txkp
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Wed, 9 Sep 2026, Johannes Schindelin wrote:

> On Sat, 15 Aug 2026, Johannes Sixt wrote:
>=20
> > Am 12.08.26 um 09:52 schrieb Johannes Schindelin via GitGitGadget:
> > > @@ -755,6 +749,10 @@ ifeq ($(uname_S),MINGW)
> > >  		BASIC_LDFLAGS +=3D -Wl,--dynamicbase
> > >          endif
> > >          ifneq (,$(MSYSTEM))
> > > +                ifeq ($(MINGW_PREFIX),$(filter-out /%,$(MINGW_PREFI=
X)))
> > > +			# Override if empty or does not start with a slash
> > > +			MINGW_PREFIX :=3D /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
> > > +                endif
> > >  		prefix =3D $(MINGW_PREFIX)
> > >  		HOST_CPU =3D $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
> > >  		BASIC_LDFLAGS +=3D -Wl,--pic-executable
> >=20
> > At this point, MINGW_PREFIX is only used to set prefix.
> >=20
> > Only in 12/12 is the variable (and ENSURE_MSYSTEM_IS_SET) used to driv=
e
> > C code. Therefore, it seems that the following hunks concerning the
> > CMake and meson build systems do not belong in this patch, yet, but on=
ly
> > in 12/12.
>=20
> Ah, right, the following hunks do touch the ENSURE_MSYSTEM_IS_SET stuff.
> But they _also_ add the `MINGW_PREFIX` stuff.

Gah. My assessment is incorrect. At this point in the patch series, the
`MINGW_PREFIX` constant isn't used anywhere in the C code. So you were
absolutely right, those hunks do need to move to 12/12 wholesale.

Sorry about the slalom,
Johannes
