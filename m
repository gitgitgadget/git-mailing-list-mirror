Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16E2421D
	for <git@vger.kernel.org>; Thu,  2 May 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636049; cv=none; b=ss8gItSMOm31w/Gn+HLLg65UlyeKkAOiYvGHbJP9OcOdB6PXgDIhC4u9Qownun1d+Z3z6cp/diNwQTq6kZc9MEognOLK/TA2UROkaDx7069KVriMLpHXDMCb35jfzfjO4sxRq1dn8lpngzifLq6k69GZnUZ1WADf1KqZBUN6f/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636049; c=relaxed/simple;
	bh=iLCM+DgwnUKrIRQxj1ldM3RRrEqrwgHvCN2FBVcbesM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGgzBr8kV91OST2L0am1+9rLSrCbhVgaa4yB9tWWUIEQS4bWLl9CXUMxysXSPbcRKegiTAa9pI6LKy7zSqKzh1Cczt9OWfrZmyaeDGcWPT0DiDOpsWPW8tlRyzpaMn3egD2N4Uz8/NbpHooZ6JxytjlYr2T6aiflzSPIEFf5RH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D7RDB8sn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2x6oxcj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D7RDB8sn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2x6oxcj"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5BE491380F7A;
	Thu,  2 May 2024 03:47:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 May 2024 03:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714636046; x=1714722446; bh=OrF+wttejH
	NNlV+HlSfKAxO+8TBExmeYsQ2Hwfdp+PY=; b=D7RDB8snw6JFYlFZQf31O6sfbs
	DA8CgN+TzgcZDX0ft0dhrPRtLtj3z+bCLEwuGktY5ypmhCOwB8Cy9d/G7B7+AACx
	JY8G0nswUlCD0fb50+9xuIDJjq6mvTSxDNUpf6ivh5UsyBKfN+ghneXgGInhNDYh
	fkeMlj+zZ+rNoG1hmRSclme7I+zZpnxR1giEphppQfd6YPA6PuwiYkK56CbL3Irk
	Z3jNRz3zbvOvoKICkAqW94JtDQLSj1oXZAWf1o9sSQKtJ5ot4OK4cjn6Ww0gxQIB
	kffb93H177sz60HfB1hHUDrE3DzcJXP3rKrEpNmYWY6ofEof0tAPE8TI2kmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714636046; x=1714722446; bh=OrF+wttejHNNlV+HlSfKAxO+8TBE
	xmeYsQ2Hwfdp+PY=; b=E2x6oxcjb9LqvA3Qq+xh4tGYPZ3FD+CHH45EzAoBvBTw
	2i5Xu9NeB9ScFHoEunfCdu1FESj2BmI2hRJvFW193CpfiBzT8CDag51tCp2O8IEw
	VQ7IPubJFmVQPcPcmESrSODQBkfNKBiHrSmgAtewrQ/gNVaamajDeCVu+aAlsrD4
	TP7tn0AIU2gsiAgJtl+P5VBBSY22H7kVIhYamk74twqTzR+3uwGtvHg9PcTCVBDv
	a8CAKZ3mXiwxH1iCXJWv0XcAdgQZ2CY+otZqcQOEGee3L1SmHvOAHdaYT41UqJRc
	QIDQliAcOTkvYnG0PPah2J6W6dw251tufc3n5gIo6w==
X-ME-Sender: <xms:DkUzZkFhh8ZnUn4BFHry77hc73NaaEUdg7LaKFl5eTb0DggcilxQrg>
    <xme:DkUzZtXq5nbWsRQ41c_cG31koIgnjeZUc85BwTMNrqKhtmFCidl3rztz2FT8LHKzK
    ruVGr_E59rkUHLY2A>
X-ME-Received: <xmr:DkUzZuKyCUFjlQYqoYKGaV0QExmWYYx91i7UsEDj4AbFky2x0itYYWbvO8Jv0rPe_WZdTW2fPFGYfSx4EKZQRb7nHnNLcB2ZWLHi4-GDzvfWwC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:DkUzZmGiE5EU2DC9862tvNUGTCPrd7KLrG3MxesLgOkTmQ3ZZ9tdMQ>
    <xmx:DkUzZqUN73Q8nJQvHU1A4f4KjAHNK8XKRXYuiRyDNpKdNd1tvCEhzg>
    <xmx:DkUzZpOpDbsnkujBaV4D_JtvaZrxIfPx4CkKldnkHHd6oZNNY_ko3A>
    <xmx:DkUzZh3XTCv6wP6hKE15SZhreUfBevYzsE40G3pn96AB71eiYsulPQ>
    <xmx:DkUzZoxMpb06686GhWVIisL6IcTk-i73PMgfPA98SUHgQzTOcscrIrFJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 03:47:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f8f3e6a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 07:47:00 +0000 (UTC)
Date: Thu, 2 May 2024 09:47:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v5 4/7] refs: add support for transactional symref updates
Message-ID: <ZjNFC6A5j5hMQ5VA@tanuki>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
 <20240501202229.2695774-5-knayak@gitlab.com>
 <xmqqbk5pgke0.fsf@gitster.g>
 <CAOLa=ZQkTM26wmGgj3=Pz9p7-nFAWQdxCA=RjaJVSm2m8zn7jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ODlUtpLYcxI/wnu1"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQkTM26wmGgj3=Pz9p7-nFAWQdxCA=RjaJVSm2m8zn7jQ@mail.gmail.com>


--ODlUtpLYcxI/wnu1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 05:50:47AM +0000, Karthik Nayak wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Karthik Nayak <karthik.188@gmail.com> writes:
> >> From: Karthik Nayak <karthik.188@gmail.com>
> >> We do not add reflog for dangling symref updates, because currently
> >> 'git-symbolic-ref' doesn't add reflog for dangling symref updates and =
it
> >> would be best to keep this behavior consistent as we would move it to
> >> start using transaction based updates in the following commit.
> >
> > If we are not changing the behaviour, does it deserve a four-line
> > paragraph?  It is not like we describe every no changes (i.e. "we
> > could break the behaviour by introducing this and that bugs, but we
> > did not" is not something we usually say in proposed log messages).
> >
> > At most, if you want to highlight that behaviour, I would expect a
> > brief mention like:
> >
> >     Note that a dangling symref update does not record a new reflog
> >     entry, which is unchanged before and after this commit.
> >
> > As a reflog entry records name of the object that is pointed by the
> > ref (either directly or indirectly) before and after an operation,
> > an operation that involve a dangling reflog that does not point at
> > any object cannot be expressed in a reflog, no?  It is way too late
> > to change this, but it would have been interesting if the design of
> > reflog had a room to log the change of symbolic ref target as well
> > as object names.  It would have allowed us to say "HEAD at time T
> > pointed at refs/heads/main (which did not exist)", "HEAD at time T+1
> > directly pointed at commit X (detached)", "HEAD at time T+2 pointed
> > at refs/heads/next", etc. and allowed us to much more cleanly
> > support "previous branch".
> >
>=20
> While I agree that four lines may seem excessive, I think it is indeed
> an important point to note. Mostly because this shows that when doing
> dangling symref updates, there is no record of this update. The best
> situation would be like you mentioned, to record the symref target
> changes. But even with the current design, it would have been nice to at
> least acknowledge that there was some update done to the symref. By
> having zero-oid for the new and old value in the reflog. But seems like
> we can't do that either.

I wouldn't say we can't do that. We already do log when symrefs become
dangling when updating references via HEAD by logging a zero OID as new
OID. That is, if we have "HEAD -> refs/heads/foo" and you delete the
latter, then we create a new reflog message for "HEAD" with zero OID as
new OID.

I would claim that the current behaviour where we don't create a reflog
entry when updating a ref to become dangling is a mere bug. I think it's
fair to declare this a #leftoverbit and handle it in a follow-up patch
series. But it would be nice to say so in an in-code comment.

Patrick

--ODlUtpLYcxI/wnu1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzRQoACgkQVbJhu7ck
PpQLiw/8CUH2QtEz2rqWRQygVNEl1LQLBe9HmgxcyteiRvE3UtgFjRaoVX0iop/x
DRW+FoTSB/N+ZKrravGhZu/UEoJYQmnKcMjgPcv6IXbVHcSpLCMX6q5ss4rHTlhE
jHUO+1fR3DYO7vP4seZxzgGlrwtE5a/Re7NjXMT+F8l4mTYlWOmIi498BO+UfGiR
jnOfV11IxWfqMKqSESjW3E9042GFDHtAsv0t1UiWpRg/e/3lVzKHUSqp3BA5RyuJ
zZn8p0w+yLn9oLKuBCESgF7xh+DsLSdWSPHZ0hucopdw5twjPde0ODwNlRIH4LC4
oYjduPILj+jQGFvWEX7efTwp0fOUW6xV1II4gxpERbD4f4SlzfUsjGU3KPw5OmDd
qLq0Ra/mJurqLN5o4CcpvwCtAxAwJMNiQZ8UFPwlYbpIT6ceciRbUzJItbx3sntY
1B31ESen02e8O9HXGbGxyJoFGozoe/7yv/eNIHEWFHFHNGyeLs/zE2rf1Vl3DUz6
S6lCMlHD+I5IbRkdzdRoKrcp53PriZMDNV38FwM93ecu6rLD4Xk8G3aBppXyClzL
HnwrzDsKazo2MX4ixnyBEqhcaR4pTqcwqJv0ILPogUfEchgYHXrV6KzTfDzlq2DI
M/dA4iNNggiwzkPjPR3uWCh18PBo1fSlskewvVe6N/2xg+NjXL8=
=iI0n
-----END PGP SIGNATURE-----

--ODlUtpLYcxI/wnu1--
