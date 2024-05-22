Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4FB65E
	for <git@vger.kernel.org>; Wed, 22 May 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365181; cv=none; b=YO81udwllLeQbBjFT7y6m85sJYvPKbwLiGK8Mu0RnJaTepqNTSDXWEkI4e/K4j6nzBlukMCJ/hDq1enF0t0+nqvS4evNCbKEwONZtWGH+8fPFeeUvxPIlnwnbFP2N5B2p1VknDmkWyu/MXUoy2u3I/ZLea1Z8Y2lRMdPTsHCx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365181; c=relaxed/simple;
	bh=fZ4YAZfc8jKvHJt3ENaGMYiJF0aem12jXner21YcnQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SihlZNGFTQ0ObS1T07+c4ZBGGCodmEdZgO1hoVR/ZGAK/LqclP0316+cPPB7NqcxLxDXZq4ztbIt070JkNd3JLlC5//mhCzj4IZqcRxacAJwJJWsHwu70glqbkt/LazjSz/Ee/oVjhojZdcF55sS57KDHlPJtFKC7SDbr6/uUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CEDRE6Ww; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SgrFzEFU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CEDRE6Ww";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SgrFzEFU"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7CCF611401F2;
	Wed, 22 May 2024 04:06:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 May 2024 04:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716365178; x=1716451578; bh=3egw/eMQ3J
	BaknwvxBGjl6o1kujn7BI6l9cx3lZgU6Y=; b=CEDRE6Ww9brnezsfCNMVzmjUtw
	QjtpLS5EC+eMFIuSDenHCmMksAGZXxs1hl7TriHuv1Kot+u0ZJWH9M+bI/ZyV7YG
	lHjO0dG+g6Ucmwu7hEUvUnav3ueghDlz/WFDwjVBXGrqkSxNuAEH5c0oO+SKI4wT
	ZMuZq1UL3FzPcWJXP9XEhNtHMHNOxnRra3oRRbNuQt2qZovjeTpH7MP48DQDpXrG
	pA4zyT8cX1rWTppWZqSCzC0n1H6QAlbo1guCy+BPpkb9ZgoPsYjwPJr83BNzADpp
	0Kflt5fAFT1fG8YO0AWJPgCykVMnILPKbpWQgFG3nrVgxRj6RAmHR+cJCnzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716365178; x=1716451578; bh=3egw/eMQ3JBaknwvxBGjl6o1kujn
	7BI6l9cx3lZgU6Y=; b=SgrFzEFUOngagJWKF5atXXul3VK+XfJCxj0x9k6yu2Zu
	tDPK/BLWIFdvzVG+qWYZmQKbwgCo1XgFxPoAFXzYkcl1P/QZbYwzLe0elzbFzvzR
	6Fk+BkovMr3py9Hyj7QCi8NOVQxcmY+Z5BbT6yDAfYYwpFPDKa6gJPiGPvlEwXoN
	kdTrrDNvn4kzy1WI4BsPVxZc6tlvAWkvxJNHWsl9mUr8eFZlUh8Ic0pBb3bkkcTn
	KqTY7zUHDJHxMELD+iHmmO6eLQ86rkgGEo5n1Yb7QvmcwDll6R4SVYIh92r5DHDq
	BjZxbrXiC/aAiL36lu3ubzvwXGjsl34K7C0H0OOqbA==
X-ME-Sender: <xms:eqdNZlN6OY1qmsJXVnbMoTWZ52KOD-fjEhOYOoRWvl_iedYeQP1hJA>
    <xme:eqdNZn_D2cv0zInO7-0Xper2RUOtnTdmtWQzodf-pXNjOsdfsy8oTO1RrEoIeDauc
    zxpy0mWv8m89jHvEw>
X-ME-Received: <xmr:eqdNZkSv0MOHB7xxH3H092eeoanxZdbIWaajcheJbj4OQLQP1lY5L9NnzhTF1JV5CMMWQ5bmGe7QGTGpIMF2242KOHgpPe9gjOaCHrez9pDVE9l8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:eqdNZhsk5awsJ8c1BcW3e9gpbLFC0jhPhK0fW7ODCIGkFxkpX-a18w>
    <xmx:eqdNZtdlKGusc4I_tPfsWlZVqEx2Zq5A6pjTdkICVcpCdEaSYGDNVQ>
    <xmx:eqdNZt0izcB1sGk9DK2OkUqpZQTVmZyWcoQNVmOywT1B3th3bMtiBA>
    <xmx:eqdNZp_3A6GKBaPI81033IMOEmBI3aVkJ6C77vCVXc7qprjummHIEw>
    <xmx:eqdNZh4nsnX-lBN9NdV-lfEvluKYZ9Y4Q2hZ3XHyLKk1UYuCIfTgtTUW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 04:06:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e552d80b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 08:06:11 +0000 (UTC)
Date: Wed, 22 May 2024 10:06:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git init BUG when gitconfig has includeIf
Message-ID: <Zk2ndVx4gMTV8ZUf@tanuki>
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
 <xmqqbk4zazqd.fsf@gitster.g>
 <D1FH40J6URHF.186U29CMRJ0N3@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vpunPSfgqEidq+D"
Content-Disposition: inline
In-Reply-To: <D1FH40J6URHF.186U29CMRJ0N3@protonmail.com>


--4vpunPSfgqEidq+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 04:46:23PM +0000, Heghedus Razvan wrote:
> On Tue May 21, 2024 at 7:36 PM EEST, Junio C Hamano wrote:
> > Heghedus Razvan <heghedus.razvan@protonmail.com> writes:
> >
> > > Yesterday I stumble upon a bug when doing git init. I didn't
> > > find any references to it, so I don't know if is a known problem
> > > or not.
> > >
> > > Steps to reproduce:
> > > # git init .
> > > BUG: refs.c:2123: reference backend is unknown
> >
> > Patrick, this looks similar to an earlier one during "git clone"
> > that was discussed at
> >
> > https://lore.kernel.org/git/72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel=
-space.org/
> >
> > that was fixed with 199f44cb (builtin/clone: allow remote helpers to
> > detect repo, 2024-02-27)?  The fix was about "git clone", but the
> > crux of the fix went to setup.c:initialize_repository_version()
> > which is also called by setup.c:init_db() that is the workhorse of
> > "git init", so it may already have been fixed (I didn't try).
>=20
> I guess I forgot to mention, but I tested the current master 4365c6fcf9
> and the issue is still present.

I cannot reproduce the issue as-is, neither on Git v2.44 nor on the
current master branch. So clearly, there must be something special to
your setup. The following testcase and variants of it do not reproduce:

    test_expect_success 'init with includeIf.onbranch condition' '
        git config -f ./config foo.bar baz &&
        include=3D$(test-tool path-utils absolute_path config) &&
        test_when_finished "rm -rf repo" &&
        git -c includeIf.onbranch:main.path=3D"$(<include)" init repo
    '

Now digging into the code, the condition gets evaluated in
`include_by_branch()`. The call to `refs_resolve_ref_unsafe()` is
guarded by `the_repository->gitdir`, which is `NULL` the first time it
is called by git-init(1). It does get called a second time, but at that
point we already initialized the refdb and configured the ref storage
format as expected.

Aha! Seems like this only happens when re-initializing an already
existent repository, that's what's missing. In that case we do already
have `the_repository->gitdir` set even though we did not yet set up the
ref storage format. I'll investigate and send a patch.

Can you confirm that this is what you see, or do you also see this when
creating an entirely new repository?

> > Even if it is already fixed in the current version by the same
> > 199f44cb, we may want to follow up 0eab85b9 (t5601: exercise clones
> > with "includeIf.*.onbranch", 2024-03-12) with an additional test to
> > cover "git init".

Agreed.

Patrick

--4vpunPSfgqEidq+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNp3QACgkQVbJhu7ck
PpRFXg/9FpUst6vpkJ+FhJ3Wc8WNTSZL81FQGJ34KiwpcgW8q61BpxDcCTBSM18I
yebEnbWv5vuyikFoYgOHYUzFLBgOrsPqHnVKFo8PeptGd0CzzsR/s0Z37Jd1fa9/
527LZ+Uqwm/hjx252/CnLblvUVyacW8tEvALygGdfd60XvZQNr0ab2PtZHTu/9ke
szJm4reQCHjob3pOZX4g7JNcGDs8NlTyNdiNL7Gyxt2DFciYHUHZkGOLfUlNgCJR
RhLzsHE7p+p22vCLK94TWgcCOC67Nth55edI+tCjqdfWeU1iMuQrR75nIZ1thAtU
+NzWfahOytJ+VpLvqlDlyK7l07YwOBVIZp2Qorkf3Y9zaH2GBqYx5gWhhvTdp830
txsbnoiRwDwQc0khAZNrHMiYq0gtdWH6qi0rubXpo2KFr1qS4MbPIOPRVZ/O7dNP
A9pwZuds6jNFV33q6zycXF90NpaL7e10feLJko/e/n5T+3rfAaoOedI8LGClDcQ0
MZb/atw6h9gV01GkkWlOgFMw106NcvjPAy+q1mQf//Bd6PvEC/VsTcZQ7uZYoYmD
dVdlCMA07ddJIlqD7n3DPlxac/u674skYbfF2VmuQWQ7hh7jaq1G8sTgtHouUT0Z
hwWl8c6TlCHcNzxtnnoTNfr/i38Iq9HmeXmSOTJimB64O461srg=
=zQ+u
-----END PGP SIGNATURE-----

--4vpunPSfgqEidq+D--
