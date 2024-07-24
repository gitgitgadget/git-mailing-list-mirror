Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009313A24D
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859451; cv=none; b=M5z9AQ3/IBYjNxOAMmK4J2Y5zaPGprVnwZUfYgQ2J/xXPR+WRXVO0CpOaxd3/Wv9SSr9PpPfACHr4ek4bJlYWSWjCfDYvJoQw7EMWSAcPeYNLlj+/UewFzwPBRB6wdxgKrVaq39XeAVjMO/WHQEXKgCCayD74erA3eV0LlPDBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859451; c=relaxed/simple;
	bh=d/fTRKQOjW1GVOqVKyEImrJc4RX55PKQ58Hwf3CBka8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AbiBYLN1vtBsVbJ9U2dDhIusDmnIU3rKB4LpdFAPNYGOzfTu5czZCVGACvAo3PjjnHpW/GZz0QRCbv7+GcOn1TttJBGnNBW8cNinQfuW5UcrbVqCD2YfCVCv+ik11KNN5H+qOq4350wMyz6YXzMD/2SEvSVEOA37tgnF6qvFIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=byCop/DP; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="byCop/DP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721859429; x=1722464229;
	i=johannes.schindelin@gmx.de;
	bh=NpTbP+1Kc9QqYX/fSxB6Niis2Gtx63CAKnx2nlfSyIg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=byCop/DPdlrObKasomuFLDF6N4SvV5IvlJBw+cQceFt8ISzrJPOQI0j1mNshZd0f
	 64EBaHAZl+KhCKTzdysnh8cMAs4v53SMuMOBwvQXcgV+T5F3FDdmkZjyiIe546LVb
	 EwPBbth5TGUGontj9vUKDKo8JMB1kTYAwAK+M4t8pLA2O5X8953peX99hmRb9Svxm
	 ggmwWLGTPqatJD/lXYuHmaSdQapZ4WXbNbgC3az+efJRaul9QXXh95zzrLrvDR4rQ
	 1sGdkcvgzNBH0h67QZS4OdI25viqQ/2pEqadiSYOE9XtXNRgIKmYzPltdjqBPT7p2
	 wS2RZCWmZXhn5AUqBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.218]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDywo-1sP0W90Rym-00GLqd; Thu, 25
 Jul 2024 00:17:09 +0200
Date: Thu, 25 Jul 2024 00:17:08 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: Junio C Hamano <gitster@pobox.com>, 
    "Randall S. Becker" <the.n.e.key@gmail.com>, git@vger.kernel.org, 
    "Randall S. Becker" <randall.becker@nexbridge.ca>, 
    "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
In-Reply-To: <20240724205541.GA557365@coredump.intra.peff.net>
Message-ID: <8ef819f0-e80a-74ec-274d-fe10991fe992@gmx.de>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca> <20240621180947.64419-2-randall.becker@nexbridge.ca> <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de> <xmqqed8me36c.fsf@gitster.g> <20240624235557.GA2727@coredump.intra.peff.net>
 <402c12c2-7ada-4d9e-c3da-1a78827e7496@gmx.de> <20240724205541.GA557365@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0baq5l4Lh8He0kfFeGpo/JrtsVi4qNT0yewdVAYMz6LSiub/t2p
 mxrq2cPYQiFtNSMeDddrZ0hIwKDY8MrznmW+DzHRTH1gCRwMWIW9t8sbjo+aO61QA68xAQL
 4+T25lpcqgGAiiHTAR4dF/zUzHAe8m0szr+1lU8H1S0gvsqWcaovaBrsaFRNxpNmO5NGhED
 1R3Tm44y/mFcUb4U/e9jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZKIy0bPbuic=;IwrXZuwtHYVKjr75RB9JCmaYUgB
 AjvrlNHF1Dfp9htdJd9s3eCo+o+lTj9qlWhUL/4QVVNb71PHN3vppI5/TJD/K6aFBVecPBt3i
 oabyJ/yN2upQ+HhQ1I+5dAtLEo3YRard1Vd2g6BDCHwoyLord4UbmQjPNtgqxZ4C+FACjXUnN
 9wignwAIEoDFT7JW1d0F2YIRHV0zcbnBWDaaevIt0wRaT8ltjG0LTWnWVaPMMd9syvLL8Rvjw
 rx+Oao7nLPsrR/EvPXH+2i55szJaHkceNaxXIVSyABo38zXG1SsaKqS36re7Pqx7fOa6hLoWQ
 zFQbFl2mikl84NOfk5ZyQBufwmCke4CAE58OsjUavmQJKzLw7TnBEqJNy7pisS5+x6M1wY8+C
 Q9qWtZeD3LzQ2+7NiITuyHo87hePu9VkgNBtJ9Kpa8KLycrRPKU5zcnTh55tbJbjt0OINUy0e
 itoJcxenZmoKKmahz+DSoVSCyM/Eu0Bj+cIFSQdiNZpxYWtwo7ooxsntAQMcbwvf16qnCN5WC
 vAUwResqnhI2zeeuYmKIjtmAVdxfvMadjP95yw4TN1BJ+Eg3bmuXEzTIY0+nnTbVf06xYhBjS
 n3RIwRbMy3eW7ufh+85cao58fSNgkYdA8cOvnAxzvS3Uh0Z1i0CTRXxaWH0hbpNF6L5VMMgiB
 jYuhvWEPGMGgiNqEp0aHfA0EzQ7G2ONDOS1x6O+N8HAfjNoNYjVZYOD+ATLId4gTva4TWH4H+
 +JOblAmqQjlo9ZrViHXCgcFff1+St6fI97xaM2B8LGLQM3j04U1C3t0CSpuzZA/sUn6DocySo
 l3PHEOkyl7nV2wRBqkvHZlEZzW01zwA6S2QYHRUmd+qWE=
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Wed, 24 Jul 2024, Jeff King wrote:

> On Wed, Jul 24, 2024 at 12:48:20PM +0200, Johannes Schindelin wrote:
>
> > > But we could also have "git version --build-options" call "remote-ht=
tps
> > > --build-options" automatically, and just let it dump to the shared
> > > stdout stream.
> >
> > Teaching `git version` to show the cURL version may not be the best id=
ea,
> > especially when it comes to the version used at runtime and using the
> > command-line option `--build-options` (with the option being specifica=
lly
> > about the build, not the runtime, version that was used).
> >
> > Wouldn't it be better to go with Emily's approach to surface this
> > information via `git bugreport` instead of `git version`, potentially
> > enhanced to show both build-time and runtime version of libcurl?
>
> I don't have a strong preference either way. I naturally turned towards
> "git version" because that's what this thread was about, and also
> because it predates git-bugreport.

All true, but the name `git version` also sets some expectations. Users
who run `<command> version` will expect to see the version of the command
they are actually using currently.

For example, `curl -V` will list something like:

	curl 7.81.0 (x86_64-pc-linux-gnu) libcurl/7.81.0 OpenSSL/3.0.2
	zlib/1.2.11 brotli/1.0.9 zstd/1.4.8 libidn2/2.3.2 libpsl/0.21.0
	(+libidn2/2.3.2) libssh/0.9.6/openssl/zlib nghttp2/1.43.0
	librtmp/2.3 OpenLDAP/2.5.18

Those are the versions of the components that are actually used when
invoking `curl` commands, not versions that were present on the machine
that built the `curl` package.

Compare that to what we're experiencing with Git for Windows v2.46.0-rc2:
`git version --build-options` lists `libcurl: 8.8.0`. But running `git
fetch` will actually use libcurl v8.9.0, not v8.8.0. And the output does
not mention that this is the compile-time version. It lists only one
version, as if it was the one that the Git executable were using.

I suspect that this behavior will confuse users, and that this kind of
user experience will come back to haunt the Git project.

> It feels like there may be some duplication / overlap between what those
> two things inspect, and we should perhaps unify them. One thing I
> notice about bugreport is that it doesn't have a way to just dump
> information without trying to start a bugreport. I'd be very unlikely to
> use it myself for reporting a bug, but I may want to dump information
> about git while debugging.
>
> So whether that is in the form of "git bugreport --dump", or if all of
> the collection is moved to "git version --build-info" and then bugreport
> uses that to fill out its template, I don't care.

I feel that we may need a different command for that than `bugreport
=2D-dump`, something that reflects that the user wants to gather data to
investigate an issue, but not necessarily report a bug to the Git project,
and that we should guide users to use that command instead of `git
version` when investigating such issues.

A command with a name along the lines of `git diagnose`, I'd say.

Ciao,
Johannes
