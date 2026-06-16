Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351C3C0628
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621297; cv=none; b=iGg31eiOhU9Z4lv1kNQWbfCVhsmF94lWjLHf5ByEoU3apQSPPfpBnV/o7VcEDwHj2HFviYHktLgCqIStcyTTUGXiZlR3ahyOKLDPYJYMkjy8FPa7FklFiANlYVxx+3kqe9ura1Nl7yD1OTHjMAlPK8H0mBbbUmNTpoK4Qdx6SwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621297; c=relaxed/simple;
	bh=tl2++vzpPcEvPYnUD80xF2UMdOKuAnExBGDwcDrcIlo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i27gCO8hONzvDXbJIpMjB6UXnyFnVrdWfyJXSno5ceCwd4vP7MC81XogxOHBJl6fqpjgP7gsdClW74JlEOprsI0JaqevNG9e0NhcU/EnTHLLFVRPAXDclkyaa58RuDaDreaWmEwI91TAkFIopmvtb99RMDEpPmCgetfAcikKGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Bobcu5vl; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Bobcu5vl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781621293; x=1782226093;
	i=johannes.schindelin@gmx.de;
	bh=3UvBl6Wn7evJ+v5RGHZB0s8XqcIGSnp2gZ7BzHZTDYo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bobcu5vlmi4tTnvyvt88BiIsUZAxpI0nNhE9BmS+kAsBgxhpG+I4GA9EXhDOQXie
	 J3YMS7E3Kl/b27H3+foG/Nyj3mVvGxZ7NkZB7um6BlzH8iJjzMRCiKBNUpZyDKluz
	 tO5uthJf8CH9b2htNGQtuxtx1tit5gACOTUQnw9My3rOeEF1+uevz49KyysKnovou
	 Bo799H6MbPuwBk3DWXROrCD0Zigc+JC+exfPJ3sAXJz4pref34jzNyWI9RVK6Dvv2
	 CgzDE4bBqPJUavBMc/LvuUWRjtTPPXg3bdW6A5ziJ4D6RmLfPplDy/vHXuZRMrcrp
	 OgDFNyvUiTOirtL2kA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1xOjxf3E78-0143h0; Tue, 16
 Jun 2026 16:48:13 +0200
Date: Tue, 16 Jun 2026 16:48:12 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 5/6] hash-object: add another >4GB/LLP64 test case
In-Reply-To: <ai-5ZvDgc4smGfGc@pks.im>
Message-ID: <7e465b04-f49f-338f-938f-7ffdd0626c86@gmx.de>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com> <f48d570bba87f7604158646873b998725a4a9db9.1780593313.git.gitgitgadget@gmail.com> <ai-5ZvDgc4smGfGc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:ffNwMhxviTN4DGw/Czn9IFgfaDVKxE0AXU5YpO1i0pBjAYfhOb+
 x4JqZFclqsSdziLr7JmtdtCNIorL0jMbrYvmQPZZSm3hkGifoL6laumdWDAgL9VPqVdAStB
 6wbuPQfQb2JN4CBqumpo2gRxnMAWrDHSkFc+4PudA6zPwJOrlwTricEsUBiuPOVgqyTJGs0
 PmFUcxub29ryN20KIwPPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4NmTZ7Qq9Xo=;dQKNdtwwmv9fCfl7fTwq6CpMO8I
 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
 GlYUtA==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 16 Jun 2026, Patrick Steinhardt wrote:

> On Thu, Jun 04, 2026 at 05:15:11PM +0000, Philip Oakley via GitGitGadget=
 wrote:
> > diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
> > index 59efee3aff..f2722380ee 100755
> > --- a/t/t1007-hash-object.sh
> > +++ b/t/t1007-hash-object.sh
> > @@ -277,4 +277,12 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LO=
NG_IS_64BIT \
> >  	test_cmp expect actual
> >  '
> > =20
> > +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> > +		'files over 4GB hash correctly' '
> > +	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
> > +	test_oid large5GB >expect &&
> > +	git hash-object -- big >actual &&
> > +	test_cmp expect actual
> > +'
>=20
> Same comment here.

[Comment was the suggestion to drop the !LONG_IS_64BIT prerequisite]

Same comment here. [My reply: Good point!]

> Nit: I feel like we could've easily introduced all of these tests in the
> first commit.

Sure, but I actually liked the structuring by Philip when I accepted the
patches into Git for Windows, and I still do: The commits all have
slightly different concerns, and I love that the cognitive load is
lightened somewhat by keeping those concerns in separate patches with
separate commit messages.

Ciao,
Johannes
