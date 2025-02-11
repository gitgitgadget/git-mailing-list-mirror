Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005741EF085
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264152; cv=none; b=Znjj7p6d7zmfhJbJU7ljSUSiXA7fMexiNN2b+w+RVMGijKDjo4fJvNiDcazcoBCuE/5dCdPopfI8QNZ+G3wQ+BzHb8HVtIr4FwOOcvA8nSbHJTTXnQQvzbrlTcI7kT6bOpVd62ucO+QKZdJeiu/6hoEtqt5HiJ/vSWSArjmoDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264152; c=relaxed/simple;
	bh=baYn8zL6Q9WM/V5M4zASW8KE8Vn62cXIA4DezhdgYos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hloyQ2tPoe/y9ViVGloUM7fO8GQ2tRN0pmGIwbGbwghvFDj59/WgHydNURYTYXjz/3tXkEEiYLoQsrj02qOadJeVnqcTJkzZeLfO0UJ5zcuSrk8KERemOoCq5r6mHCm+Dk8DnglJL5jFMvROBTKM84xfbw0nzif2lDUcshMStPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=YDLIkhx4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="YDLIkhx4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739264145; x=1739868945; i=ps.report@gmx.net;
	bh=w8FgCvq7opdCLlixJEzHH+wDLAMeB4VGLgqbxHekvp4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YDLIkhx4O0dxZLCnkwWaPt5GudKOhP3AeJKfwONXQGPKy+sBOzfwnxnDYDwhuowv
	 qHAIAhjDm9O71/Nl61l7rI8McKP5kA1F4Mn4GhRmYB3/r/0ywGCvZmCLInd+a29uP
	 LqxA3APZPUOsxp/s8LOAcs4YKjGahSxQ6oCMKV5M2sBFlg5pO+5xE4ZQMC5YDIDcf
	 oqfHPyg6uCvasdb7iC7o+iagmSwyZYcYCYOR8Dx0L3/txsumD3/yjeyfpCnHhG3Gj
	 vPOPKCebCZAQo857zn2E8pPL4AeReCnPRnug8RVecE1c3d48wJvwFhN4MyQMxIUB7
	 yfsWYEybF8eVMVzeLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.30]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpex-1sy2WM1gP1-00cCVH; Tue, 11
 Feb 2025 09:55:45 +0100
Date: Tue, 11 Feb 2025 09:55:44 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: Meson build leaks host 'sh' path to target build when
 cross-compiled
Message-ID: <20250211095544.66226abc@gmx.net>
In-Reply-To: <xmqqpljpa83y.fsf@gitster.g>
References: <20250209133027.64a865aa@gmx.net>
	<Z6mtnmvKMsIOEVz5@pks.im>
	<xmqqlduddb8b.fsf@gitster.g>
	<20250210174335.6d6d2af2@gmx.net>
	<xmqqpljpa83y.fsf@gitster.g>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cGuXqOIgbvTbrEPXG0e4nAQr+BJ1WSJMu8ILNdYoGPeHLujqTD6
 EfexiXK7ByUVHyi2SlZFMjIjt3re7ptfF1uvz5XZyUpgwsGjGFN5oFkN7DfND0zFmT8bZA4
 usjONqrPGhxYHZYQsn7ZKH1YszWy0SWbliIKhBWzim2sAWRz37gxC1DcmRNtidI4lwZCXZh
 S6ZJ5cKJ2EzH1E41DoR0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sHRuRzTWHpg=;r9AJb6rQfb+6qRwioJ9j7yftIu+
 Es+esBrzEVjgVDpcskn3kLhpzLLaxunUxrSKKlJz39UNhi/7rctU1YzmBqdd2uVbUSgM6XrJ9
 LO01dYszNgvIjD9w9TAZ51YHjvjeqM6AaOECTV1NhZpY2x03Cs9t4qvmx98wYprBvCk3fYxA+
 BB4fPMJKwLITFvdx5gYWa2GkSczloL08rrQm44nsIJzKJ8t3wANb8nRUAiDVEso0eRfVjP271
 N5inLQ9qy7jb0crWhl6BhBQpGfa6WglfKcPrlUuowEUahbB5kBNKEVsQyUZ9t4jYUa+wj6BiF
 He7uPEZmEpt/lNw+ZD2hF5xWjruJT00dn6gpBhbRry+uPzP6NTEdbOxRURnbWbbfbtS10QgSL
 udnh6cDtNO0tidsKpPLHk8LjDAPzy4gwoAtuDJLYbMAHKp7pEG1WNwrm+zhp2pYStxdUUZlOH
 eUsJ+LbH17koicED2dbHbJmFabXDjMkD/bTt/w0nqAq0Rkob/y9sRaEJoBQ+k+6OLGSAFc1DV
 z+vTAgXqzgmJtGvbjqLK6f/F44+Khdk0MmbWlsrvZtXOPW2Lanf+nipHjuvgeozy+GfrBHyhX
 ZQ7FUwD4rwLbY7Hy4rrrtxVXCYDTUtn6d5tVzXRPKNIWP+ZxU98whH74spQCsC8o84fSCue1N
 GLjQTZyxoK1bZmUbMHLN73I3DGD1FT7ygr5yC0sAIE5b/s6wgoTnqPjqRQBC0olxHfP5D4bf+
 C40ltCIYL2wDHqGBIOVxdLXAYahV5+9iIdQtbH2YISW6I0X3xewrdPp13kjzKW6/eyGuyIWzC
 X+JJUufUPb+mwLPjbUQkg6pxqeCUIDjFq3/cqS0sq0w+iLAyS8uN3xZsaPtv4c6b0DlnM2q63
 kG51VxDijEYpPz8EPIl5BDt4GzoJaEonKIF90mTweA6pUm/2lhWdQvUlJ3q2123dpeazEKu+D
 wFw1eTwRDC/AYET1194YrY6mACuoO+5Fd/SRj5lxpZTSM2ynf3ht7oBb8ZmKJnkArFUdRX5LC
 RPMxpzlmr2JU6ohzurVAGEjzb5ogTIFNSrW8eqRVFuKmzgVOqJ55QLE10j2Yw5DPYKWtMTUN7
 WoKU0z7ei/PlxUO09PCcH3sXmZf/tijlVbhQ3jhk8IXsJluPLpH8t4E6xgEY0/mtHhfQEEn7B
 uYOtUaFYg8gR+PMXezXMS/XZ3bTnhLLMjh0ZvWRZ2DLCsyopfKgg9mk37VObv7sotm/QJu4rS
 So1YIl2EFvuWuQ1PN/nqYT1gNyiFOFOW6LVRE5txwUNc/KHa9Y87Cf8dC9eutwR0A65aVdhxe
 4z3JhymPbuUWbYuY/X+qigq+yT9kNjPdUNo5SVOcV5o8/LNmWeh2/COiWlq0L+AulfjoT949n
 mC+kN1Wd4oEDFMaWNKZIsegGfUcMqgpGnDmcn1kKKlCaCEsHYUStXggxeJ

Hello Junio,

On Mon, 10 Feb 2025 11:54:25 -0800, Junio C Hamano <gitster@pobox.com> wro=
te:

> Peter Seiderer <ps.report@gmx.net> writes:
>
> > Maybe all doing (autoconf) cross builds where happy with the defaults
> > from the Makefile (SHELL_PATH =3D /bin/sh, PERL_PATH =3D /usr/bin/perl=
)
> > on host and target (as the buildroot autoconf package since 2013) and
> > only users doing native builds fiddled around with non-default values?
>
> I somehow doubt it.
>
> The problem I see is that there is no distinction between "this is
> the path for the shell on the target system" vs "this is the shell
> we run on the host while building the package" in the Makefile.  Use
> of autoconf would not magically change it; the Makefile that
> includes the config.mak.autogen needs to be aware of the
> distinction.

Found no problem/special-handling in buildroot ([1]) or yocto ([2]) for
SHELL_PATH, but you are right regarding the PERL_PATH in yocto using

  38 EXTRA_OECONF =3D "--with-perl=3D${STAGING_BINDIR_NATIVE}/perl-native/=
perl \

and

  49 EXTRA_OEMAKE +=3D "'PERL_PATH=3D/usr/bin/env perl'"

and a fixup for the resulting files

  76 perl_native_fixup () {
  77 	sed -i -e 's#${STAGING_BINDIR_NATIVE}/perl-native/#${bindir}/#' \
  78 	       -e 's#${libdir}/perl-native/#${libdir}/#' \
  79 	    ${@d.getVar("PERLTOOLS").replace(' /',d.getVar('D') + '/')}

Yes, doing a distinct handling for host/target path for sh/perl for
meson/autoconf is for sure the right thing ;-)

Regards,
Peter

[1] https://gitlab.com/buildroot.org/buildroot/-/blob/master/package/git/g=
it.mk
[2] https://git.yoctoproject.org/poky/tree/meta/recipes-devtools/git/git_2=
.48.1.bb
