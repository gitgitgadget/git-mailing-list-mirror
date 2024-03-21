Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DB83CD3
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026607; cv=none; b=EmtDZ/R1/3Beuym09v2vcAAeRA9DZduJS6YF5S/mMEPuMxgbRzgCCmHCk4Bllhs6vez/SLOQYwdTXc/qB+9hGqj/ycpVKRLxq3kuQIGlF5ztj8R8++NczD0mIFd4LF2PHek7vSo+z342kId/DtdUY2hO9w//L05U4mvQ7aujcv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026607; c=relaxed/simple;
	bh=uRhqMUDIdpTnp3upPw9qCS+Ij8B8iWcre5cUHaEPb/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuevTU/q2B9khLOkp17tX3dqJdJmLk6sqHXtt8oJvnYREZ8gEU4KaV5SrlfeXzHTzLNWQA9lZVkEQQk1p+2JmBEGSXnUCLuqPvfCHUvc2LSDvK10pnVLM9UF+frpmzpmmu8p0F7CgRqO4P/PxgDi2eAlMZBCG0vumiugEbMBIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UlBQ+3st; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1Fp52Sm; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UlBQ+3st";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1Fp52Sm"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 21BA01C000D6;
	Thu, 21 Mar 2024 09:10:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Mar 2024 09:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711026603; x=1711113003; bh=uRhqMUDIdp
	Tnp3upPw9qCS+Ij8B8iWcre5cUHaEPb/o=; b=UlBQ+3stC8JcJvXfEv/iQdulLU
	0nl7k/iwDXQ0zKWF5VG/xGRTroJLhf5/dtQede1KKTAA/mUxoiaHAtZ5LLwN0bXQ
	D0yrrf0frL/KPnLVfy7sXhPUKi03+/9TjOc3qAvLPqz0towS0CwcqLgbAhuBJEx/
	DpdXDuXmEjLe9WID2tgj2gXWOjeE7xbPeyboSDrt39ZaU1w6Ula60WQz7zraoHBK
	3AEquM6oBEc76rpNWuivOLsxjncY6lIYCC65gi+AZB38AeswAM4+kR1LEkuVMnn9
	2jBNle6GzU83uYXv54+IlC9mXuGLwTfjRBU9MCK8b97RwyY8VYOvZjSxxHRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711026603; x=1711113003; bh=uRhqMUDIdpTnp3upPw9qCS+Ij8B8
	iWcre5cUHaEPb/o=; b=Q1Fp52SmnZfSNeCTQU/ZbpQvhNFm/oZQUp41PIkjdrv6
	UN8KlvkEWPinLoRVXyEhTuaEuS0dL7Bp3qj3eJmoCxOcLen+EX+ui0+QL/e5YdLO
	sF8/LJ8vuJIo1H97gSYiQTJfLS+EyORCTM2sSzGBcqEu05jGC5wi2L42XxcmFSNx
	Hpuo5xqQq52qGs4BJlWyQ6Q3UmelbfR0KckZAYuB284GDYLT2/F/C7R/XQ3seYph
	eRsKCplFnxRZvWs9gB50TEuWLtF+pLkUnQiTvxXZDgr04keww+1OvDgs0Wk38wKE
	8NjPhsX7SE48SV5pF13/yNP+JX06sKQuGSn2giv54A==
X-ME-Sender: <xms:qzH8ZbdzQ2E_rT4Hi0qL6ybXxUe5a2KhQwDF-v3KhRDnFm-gnQItiQ>
    <xme:qzH8ZRPLWKoGq4NaS8S11THoIp8sDs3Vd7cgFgnVS1fCnRGmyn8hu1aTWSIA1661E
    XST6joKYqfK66Kwng>
X-ME-Received: <xmr:qzH8ZUjhJfU5mfPuK8WkG7gxKN-2sLPLgzZdpvCH7KkSPZlLMUDbz7R4q9YGytYdcvHhVbviemJJW-gW6PFt7GdOnOLGwHAt21V0RapiNtj6hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:qzH8Zc8Hy8xPj0ULqtLxR-FE6luhG2cKVAUo9rrf7hkBbzx2e7-IHA>
    <xmx:qzH8ZXsRjow8anqm27KVO5KidlXQn0_yrojNid5O80nwJcSR8J04Lg>
    <xmx:qzH8ZbGPfMRRGTl__CcqkS0DX4AeB-Pi4wP7VUu_9lvjdwZRrmFg0Q>
    <xmx:qzH8ZePF6_ntRBhOMf8jWTa1UWEteBUxC1TkVq5UmETs4qBivwls3A>
    <xmx:qzH8ZXLaikp1LweLpHJN3PxIu2V0Oz7Ys5xyTFNN9dMV8fguhuqG2KQxDMU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:10:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8902a44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 13:09:58 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:10:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] reftable/record: avoid copying author info
Message-ID: <ZfwxqBTLFYHI0SGh@tanuki>
References: <cover.1709640322.git.ps@pks.im>
 <6f568e4ccb67a7af8279352153d052c5f9a88234.1709640322.git.ps@pks.im>
 <CZS7Z199NZUG.2EM4STQ664P9W@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="41J8gLcs/UaEGhNF"
Content-Disposition: inline
In-Reply-To: <CZS7Z199NZUG.2EM4STQ664P9W@jamesliu.io>


--41J8gLcs/UaEGhNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:09:23PM +1100, James Liu wrote:
> On Tue Mar 5, 2024 at 11:11 PM AEDT, Patrick Steinhardt wrote:
> > Each reflog entry contains information regarding the authorship of who
> > has made the change. This authorship information is not the same as that
> > of any of the commits that the reflog entry references, but instead
> > corresponds to the local user that has executed the command. Thus, it is
> > almost always the case that all reflog entries have the same author.
>=20
> What are your thoughts on simplifying this explanation a little bit? I
> gave it a try below:
>=20
> Each reflog entry contains authorship information indicating who has made
> the change. The author here corresponds to the local user who has executed
> the command rather than the author of the referenced commits. Thus, it is
> almost always the case that all reflog entries have the same author.

That would've been a bit shorter indeed. But the patch series has been
merged to `next` by now, so I'll leave it at that.

Thanks!

Patrick

--41J8gLcs/UaEGhNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8MacACgkQVbJhu7ck
PpRU+BAAq0a6UTMWGkiwaC0eHxRaf9q5hfQx/Df0ydhCMM5A54J50r9N7Sg6NVBW
ytrcltjQS917+27CVqoyJjysT11cvdUnsmec3X2q+xi04gX/D+K+Jebar1CxiImi
8LtbBtrfm6A8z0IgTuYUCqFAAf7uwrAOWjr+2MWWt4ScT5iXehWH+eH2MqqmvOkM
TJOROv9CPOlBtoCLoHbFiqg5twNOMN5iqLs+EofOi8lkD6x+goC/PzKLWPiQgCtJ
/38lZpXVFtwDFeuntLMS0NkPKBFK0zEFJLosWjh6NWnQQqbcLhtsOtFe0JO/T7m8
TT67+UfizVuHbSRgKJ8QOhlOj8NPk9wAvHhInrI7FD/ajWUYQHvaX92+eHvz+bc3
6kbXAsvZSnzlfTYxhLyqYe7rEJrddfcAjFhWHGZmdmtdmJTIMv9qr+uB/+i/Ivc2
YmpwBGkkk8lxUbYCRLORebm0+Y/FdkFl1AvnoU/awT11SVKoa1f3eAl0+wHoRa2g
JuQV0EgJTmTp7Gag/mGKrBoqqNi+0JRfwB/gKoqfdbQZBH/5ZLgavinaD2J3euIn
xhIbk5BpoUg4SqJc9yE7sMHUFz18TrMWVK/gC/O0dfAmiyxwN+ieDSgfb7PAEAiC
gfScjVnu3hoeU0uoHryeIEyN5awHhFaQfvmkvCwx2VCjLLTX7zk=
=nIyq
-----END PGP SIGNATURE-----

--41J8gLcs/UaEGhNF--
