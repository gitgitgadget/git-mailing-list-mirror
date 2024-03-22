Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517694A02
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072894; cv=none; b=tVGX2P+uS33NPKpTI4oiSv44qRi4YQjZbbv5y2yvnSRJHXpkaC80jS7X94I0fXsXIDYq4HAoZzgPOMNecb65zBSYAS4qSucOQPSx7EVAvOHZ3dq2lvsBsnRg1EBFF2R74QyY16I1v7TvkJ6FWFwK2YJjqDKW1CkraLJwHihmbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072894; c=relaxed/simple;
	bh=yfGM2Wbj30MVQW5FCvCb0x76PMby87jl9LO//t7Tcck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyZdSCCpXYo3fjMBJOnOFAV76eX0R4UdHIYa1hC50ZrX3rslhAWtsN/jKCGxjeBJJs9ZKEd5vg9cey5k5kYqGqbf7Qxpb4M6Zs6qs3CJCs/DrqeV9b4KDetmg89wED6XCZaqJGiH2ffnO43tZH9Jn3F3zr1cNZ3I1GtNbBuERxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bcjBPqtc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fwPHj00S; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bcjBPqtc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwPHj00S"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 234935C0072;
	Thu, 21 Mar 2024 22:01:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Mar 2024 22:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711072891; x=1711159291; bh=3Za35tixiS
	B2t5XvXzNktr9VeMSmS1IuJ7ra3T+rKOw=; b=bcjBPqtcjKzm2bMmBuC9XFYlnd
	u/40pAJ85pwmAz1Vj5BqC3XvghCnkgtSnxBVbQeTaGCzg4fZ8qdPwcBdt0Xwt07m
	8OfNBVS+Z2DwLehaUFVZ4XGiKs+/4lHrXmkC2RAenwCeaXm2pBhzgBQz0u7GYYmU
	tOjyP8Ir8OFYpeWdIZoR3cmrHs+Qu+sFS1iA2f6tsAbPsT1FFS/MIwA/7p0lXWMQ
	jkzf7nln5Z0KR6sOY1Oiy7tXwqOebO7mSI+PM5syFMI5OXMC3hUSkfmvT3ZrY83s
	DtERKKf7j4D1SbafICitpIOUYtlTwWGzG+/aGsVXdEhlcpJbJwSJiblm4owQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711072891; x=1711159291; bh=3Za35tixiSB2t5XvXzNktr9VeMSm
	S1IuJ7ra3T+rKOw=; b=fwPHj00S/djxx/Nl/qaolBSRDZWW06IOu6BiMvWHMzDR
	9R4CUNO11jlbmB5zL9mrr700HBupWOFJT2ide+tGJ2U+NdhbCA8Eio6haFFoc2yl
	HogIaiI1IfBqSjn9l76K7mDjsJ6BodJnBS7reoIfAD0/8Bj1hdFKR0V6KTMkKTcY
	pWn+5DnIlPl6ku3dyzvotUOnK/LnVZ+u2fu2wxY8IzXUcTig0TeWBC5W0nKHDIFv
	Io+ylqWs5XuGz2pkJiEZkLrY1r6mOVc2/9FVdp652NYpdfkWrVsMJLBJ3ar6hhV4
	hy+rdXi7IqN+H5XWIH2IVUjexKY4PignoA+fmt6qeA==
X-ME-Sender: <xms:eub8ZS5EHymNAvH-2Mue1Ucb5Z8zBlbvL2mjcy3W_bL0hpNRrYXMvg>
    <xme:eub8Zb53759XYbwYySaFxCqlooEsRdtsobkxAa8xPyA99FfvCe38hxk1KFljGkGDg
    BJjKXnGU_XSR3YKlA>
X-ME-Received: <xmr:eub8ZRcIE10bGzqlSYavleOHj8JD_kAcm73rcd76z7PR0KTwNDI8VxB2jBrUU405GpJHeHn4UDMXWK-fuz045riPw1EXORxpKD_cRnsPA_FiHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:eub8ZfKHdmY4PMQ6a_wankBjaR7dxuZhVKXjMBs-6gYO8kpMtnEvOA>
    <xmx:eub8ZWIS94ns72uBR0jDwDIuFYXOHo7d4qr1C9ToSjqZJByHJDhSVA>
    <xmx:eub8ZQx89Scu96XWXV1jo0yTP5swQI4NboY6ZKEXFAtepBAEPJXbcQ>
    <xmx:eub8ZaIqpsagB8StYrbRlM2QAshIrKB111cL2tEYfRBDOFNhSEckfg>
    <xmx:e-b8ZYgWrJEebFz1rx9EBG4HHiaFopWc4UHYK6WZjhDB1vn0J0sEIQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 22:01:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8455c119 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 02:01:22 +0000 (UTC)
Date: Fri, 22 Mar 2024 03:01:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	rsbecker@nexbridge.com, Angelo Dureghello <angelo@kernel-space.org>
Subject: Re: [PATCH] t5601: exercise clones with "includeIf.*.onbranch"
Message-ID: <ZfzmdcBT5MUqoxrk@tanuki>
References: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>
 <0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.im>
 <xmqqo7bjjid9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4CIHP67jwIi1op9"
Content-Disposition: inline
In-Reply-To: <xmqqo7bjjid9.fsf@gitster.g>


--p4CIHP67jwIi1op9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 01:38:26PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +test_expect_success 'clone with includeIf' '
> > +	test_when_finished "rm -rf repo \"$HTTPD_DOCUMENT_ROOT_PATH/repo.git\=
"" &&
> > +	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" =
&&
> > +
> > +	test_when_finished "rm \"$HOME\"/.gitconfig" &&
> > +	cat >"$HOME"/.gitconfig <<-EOF &&
> > +	[includeIf "onbranch:something"]
> > +		path =3D /does/not/exist.inc
> > +	EOF
> > +	git clone $HTTPD_URL/smart/repo.git repo
> > +'
>=20
> Hmph, isn't the end-user expectation more like if you clone with
> "git clone -b something" then the configuration stored in the named
> file to take effect, while "git clone" that would never place you on
> that something branch would ignore that missing file?  Is this only
> the latter half of the pair?

It probably is, but I'm not really sure to be honest. That's why I
punted on it and just assert that it doesn't die.

In any case I would claim that the current behaviour is really quite
broken in Git v2.43:

```
$ cat >$HOME/.gitconfig <<EOF
[includeIf "onbranch:master"]
    path =3D $HOME/include
EOF

$ cat >$HOME/include <<EOF
garbage
EOF

# Init source with a different branch name than our condition.
$ git init source --initial-branch=3Dmain
$ git -C source commit --allow-empty -m initial

$ git clone source target
Cloning into 'target'...
error: key does not contain a section: garbage
error: key does not contain a section: garbage
error: key does not contain a section: garbage
error: key does not contain a section: garbage
remote: Enumerating objects: 2, done.
remote: Counting objects: 100% (2/2), done.
remote: Total 2 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (2/2), done.
error: key does not contain a section: garbage

$ git clone -b main source target
Cloning into 'target'...
error: key does not contain a section: garbage
error: key does not contain a section: garbage
error: key does not contain a section: garbage
error: key does not contain a section: garbage
remote: Enumerating objects: 2, done.
remote: Counting objects: 100% (2/2), done.
remote: Total 2 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (2/2), done.
error: key does not contain a section: garbage

$ git clone -b other source target
Cloning into 'target'...
error: key does not contain a section: garbage
error: key does not contain a section: garbage
error: key does not contain a section: garbage
error: key does not contain a section: garbage
remote: Enumerating objects: 2, done.
remote: Counting objects: 100% (2/2), done.
remote: Total 2 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (2/2), done.
error: key does not contain a section: garbage

$ cat >$HOME/.gitconfig <<EOF
[includeIf "onbranch:other"]
    path =3D $HOME/include
EOF
$ git -C source branch other

$ git clone -b other source target
Cloning into 'target'...
remote: Enumerating objects: 2, done.
remote: Counting objects: 100% (2/2), done.
remote: Total 2 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (2/2), done.
error: key does not contain a section: garbage
```

So the behaviour is inconsistent already and does not make a lot of
sense. Part of the problem is likely that we pre-initialize "HEAD" to
"refs/heads/master", which is why you can see some of the includes being
triggered.

With Git v2.44 this behaviour did indeed change, and arguably for the
better. This is because we now pre-init "HEAD" to "refs/heads/.invalid"
instead of using the default branch name. Thus, we do not match "master"
anymore, which is likely the correct thing to do.

```
$ cat >$HOME/.gitconfig <<EOF
[includeIf "onbranch:other"]
    path =3D $HOME/include
EOF

$ git clone -b main source target
Cloning into 'target'...
remote: Enumerating objects: 2, done.
remote: Counting objects: 100% (2/2), done.
remote: Total 2 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (2/2), done.

$ git clone -b other source target
Cloning into 'target'...
remote: Enumerating objects: 2, done.
remote: Counting objects: 100% (2/2), done.
remote: Total 2 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (2/2), done.
error: key does not contain a section: garbage
```

So arguably, the ".invalid" hack actually fixed this case somewhat and
made it behave saner. But I'm just not sure whether I feel comfortable
enough with all of this incidental behaviour to actually put it into a
test and cast it into stone.

Thus the current version of my test that simply asserts that this does
something successfully instead of crashing. In my opinion, we need to
put more thought into how this is supposed to work before adding more
tests.

Patrick

--p4CIHP67jwIi1op9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX85nQACgkQVbJhu7ck
PpTr9Q/+N//VzVsghAsdLWehk9zOXt49M0XHG96LTdEGexRw3QU0UZonibL9jiwm
ZObyAzYEG6kzX/f/ST7tdaGO8iYc6fl8ksGNuuN2wzrgys68/8GEQuU0CWLLNw3g
yHWK/J5q4L6g7NzL7lrr7GzNMpUccoYx9jzqG4+loLNJhXT1AK2cvbW3CsPZQZw8
ORPJX+HjlFnDHU2rEPCfN99rDd54NevBhhYb1FmKCSKHZQ1KB+gtHVxpAnRTIecd
LQfFJj165Ke3hBf2MFh8XvB3MXU/bOFzDiYg5+gjOsk7mlpJg2IBD2/sb5xlPqEL
8gAoVH07gMmbEm8XpzC5MkOuCcCStWkyWK9h7yrWG/FYPLyW3G5dYTwmYFNf+clc
frJOVc2Y9vV5XVZFwPu15qb1PMYidXD1LrIjEUVTmN2Jk4tJYXKjFWc6jLnwoCFz
/Ypv3ClREGHeXN9iHcUPfiWkxiXnKT3+8agbwaSxOTYowvPdxfVRS8E7QAT8mc8N
R56PXIfADwB8dLtdk1mupf0uJVoTBrwvaiD3dJB+XPu5yRXulB1YlUtA1/wIEUVH
jAn0QhvEZMcSo+IqqR+KB99elFQMoAXDxRsLFpxNxRHqzKCq+Qk3QTAQVUBVA+SC
B/tiCxmvPJ6Hwceb/7AzUE9B+BBq2aG7rtTBWFFNnlCWneCtYl8=
=fn1d
-----END PGP SIGNATURE-----

--p4CIHP67jwIi1op9--
