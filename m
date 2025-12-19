Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51082E717B
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134224; cv=none; b=TMzt1qrXnUo+vHGZXc9mYs7KfK4BZf0NzN5BXA8/NkijJezQ2Xeu3E2p2zCgQK4LkhZiRPGEmWvwYCLVBPKu1+v80Qs/hsS8vv//ONew9qER8QR8qLWRk1UHErSGjPli6WyRPIyFoC6Y1VeXQTF3KXpk9ALYjZ+3X7rGAF+87ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134224; c=relaxed/simple;
	bh=Mub94D3mHiqf5T3JpuKeoW3eKCmrxSC5m5mb/t0o/h8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Odl6eMYd1QyzQ9FgcpfNRVj5/NwfPeNVdjXsMO70HT8hzSsemMYlMzRVDjofXjTcO3tqdMEm4/7YNM5WeOX0Jo1r6iEMJsZv1Wsbc4tH+Ttey9OTWPSC68/CySezfrEABeKCi/TCOuADgy+jflb9+BsMBbrLOgqWVzi70/VMf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=nbeBlg76; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="nbeBlg76"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766134216; x=1766739016;
	i=johannes.schindelin@gmx.de;
	bh=LQ9x0fST4G1y00TpJCzXOmaPJ1HSFTRyDa/rjLdqkgk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nbeBlg76WkGoIuKJZBzByCO31c/bJkbuuM7FizQwbvMyL/bHI5eevHTy7STJBwke
	 ubyUOAcfQjowtrK81tnHkpyyvxpmDp9rYObwhVujAX3wFT6kEJkfprYCDe3/VDKel
	 76ix2Jii8+lsM9tFZ06ce32HTuE9RLWweu4qSNXdr5f7KJg5IrElAaEIOp1dZVLlH
	 Xnvy8qvjvtUpdvqoTSxhPVV0aJfMdRlG+UNAMbJp+TBOOrhv3nAQWOqAwRsW2WDgt
	 +EucG/qf+O6f2c5K77kJo+Z0vgq77RLwm3QibcqWApp989oR/WdyR/TD/DVNrOjUK
	 S7NaWs/S4fSC5BRwVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsjH-1vFpBN399J-00NFzA; Fri, 19
 Dec 2025 09:50:16 +0100
Date: Fri, 19 Dec 2025 09:50:15 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 4/5] strbuf_readlink(): support link targets that exceed
 PATH_MAX
In-Reply-To: <aULB3wCFGsbZbuSw@pks.im>
Message-ID: <5778a03b-2e33-9224-e051-664c2d530fc3@gmx.de>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com> <db1feb2293d20532f9468ab63ede43d4fc620203.1765899229.git.gitgitgadget@gmail.com> <aULB3wCFGsbZbuSw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:me3Dzs93Lkglpx0wLQmAMkmSxPxST49pr/Gy96MInXO/5yD7lfZ
 m9TNii6RUPSxLO2CHIwztpQIjqxR7Be/85CwoCDJiYGmP2hm5HXf680UvbqJcmxuv4tqH0o
 WQ8lj/KaeINf+3nxL4ksqFbrwfXIFaVLvFiiphX38mN9QFbNUloCs1i7kfk2kd4GGN5n1Hx
 kO4xAlgePboHHrn+GO9ug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pMLmV3DiC/g=;bZGqDVWHkorB9JS5GAJExE4dW9R
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 17 Dec 2025, Patrick Steinhardt wrote:

> On Tue, Dec 16, 2025 at 03:33:48PM +0000, Karsten Blees via GitGitGadget=
 wrote:
> > diff --git a/strbuf.c b/strbuf.c
> > index 44a8f6a554..fa4e30f112 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -566,8 +566,6 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
> >  	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
> >  }
> > =20
> > -#define STRBUF_MAXLINK (2*PATH_MAX)
> > -
> >  int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
> >  {
> >  	size_t oldalloc =3D sb->alloc;
> > @@ -575,7 +573,7 @@ int strbuf_readlink(struct strbuf *sb, const char =
*path, size_t hint)
> >  	if (hint < 32)
> >  		hint =3D 32;
> > =20
> > -	while (hint < STRBUF_MAXLINK) {
> > +	for (;;) {
> >  		ssize_t len;
> > =20
> >  		strbuf_grow(sb, hint + 1);
>=20
> This makes me wonder whether we have a better way to figure out the
> actual size of the buffer that we ultimately need to allocate. But
> reading through readlink(3p) doesn't indicate anything, and I'm not sure
> whether we can always rely on lstat(3p) to return the correct size for
> symlink contents on all platforms.
>=20
> One thing that _is_ noted though is that calling the function with a
> buffer size larger than SSIZE_MAX is implementation-defined. It does
> make me a bit uneasy in that light to grow indefinitely.
>=20
> Which makes me wonder whether Windows has a limit for the symlink
> contents that we could enforce in theory so that we can reasonably turn
> this into a bounded loop again?

https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-l=
imitation
suggests that the maximum permissible target path should be 32,768. But
that's not _quite_ correct, as
`../t/../Documentation/RelNotes/../../README.md` is a perfectly valid (if
awkward) symlink target.

Still, I would say that 32,768 would make for a fine (still insanely high,
but not so high as to allow malicious symlinks to cause memory problems)
limit.

Sound good?
Johannes
