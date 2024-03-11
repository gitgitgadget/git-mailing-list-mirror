Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55D58AB2
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199553; cv=none; b=DdxsYdICSGGnWLb3Nh0xcxTLK4zYRiguVfCxOYnWPswu+F+O4O7kSM2Qno7l9e0YjVjxsv3OSd6YsGi14OYnAEx+oA+d6NogVExmNhLol3ZH4n9dUiuwBsG1k5bO9VJxZYWQO4pA4DufIoqR4XhuRXG/LxDtxVhRe6Y2fHKaPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199553; c=relaxed/simple;
	bh=NXEIr+W9WlMeu1axiUs+kFzFaYIDa3Rq7Eg1iBUi6Xw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGjigSdtLDB3p7LS3wwTyndIPr6WUZj3vvzHpMpw99GETZhw778APohRf8vQdNNqMtl6G9eGO6/ybtMTMbrgW6uho2o0pHos/liYXFegUVvdzRWCtkqXd9hxR3Qz4v4XTr9GAAHl6P5nJ/WG/YrSapvkRASdrRSLmVY7UT7r4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kgsqrS3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qFQfYasD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kgsqrS3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qFQfYasD"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 97146138012A;
	Mon, 11 Mar 2024 19:25:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Mar 2024 19:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199550; x=1710285950; bh=MGtbztzlfs
	biqTfjES9ti2m+fnRaTMuqE7sHw+YxZ0I=; b=kgsqrS3/M41mqW0P/VpdUmaijw
	wP9drFtj7Akz1mtVkDzlyliiVs9KyT0Nc3mwTX/znDuVhFuactekM+vzN0mVk6cN
	g1rqCUXLSR3xa2Z0CJOqN2b6vLfz0ig3WrCVEA9rN7GCMXBuQltBFLzWo5ICGero
	nFyz5r4Dqd0zC0XZ0JlJygGZY+N7ldRaQHDiJIEzoLvGYX9yLMOwuWnxEZgPeoui
	NvH6TyUthm+p90vc2//4gA+pjFWx/Zi1ZrWlfPNSri+wgNEMr43FlV5Cu1OPZnAX
	NSXJnMZOXVr/xU+ZqhhsvHBIk1Mg/0GAjhNn+Q1Isspu+x2MhnCRJvv9MgqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199550; x=1710285950; bh=MGtbztzlfsbiqTfjES9ti2m+fnRa
	TMuqE7sHw+YxZ0I=; b=qFQfYasDM7KGFPH53huupCzSuiBk4O0NnxSin3m1bJ2a
	FquHa/5b55YpolFyKK5pONyJwIvIcuoRIKDEKKhUz+rV83xx4Icvdz/R3r7tb+6f
	SdWDaL+HsFtzQESC8HRqI4YWI0HTZMik4p1zFDw9d/2GEt0uMlT9Y66lqHCrvN7I
	HmNcUPGk3gfMCVbvPu+QTKQp1PjxwRJUcwN33RgXweTCaDTweg5VKwoUYDVf8e0V
	R1HyfDMG7iDhCrF2o0QZ1kTPz3yI8SZy6NvewUrcUKa6Ov4KwpcuQ4Mzs3112eCC
	MFJ4BU5yvcFYjgqihnzRT5KiMEP2dWCd2WsyI/D28w==
X-ME-Sender: <xms:_pLvZbDUnSGJkM94g3gJFVQ62qxXHrtAGHTyxVu7Z4N9k1IWcRl72w>
    <xme:_pLvZRjLfxdnJqSuPJ4MxNFhJdligViWb7e9_RqTQtmgThm-TwXgCpWo2svbWGZpA
    vZk7h8J3kBMFu0cyw>
X-ME-Received: <xmr:_pLvZWlhYdPgBrulxtqirm-3faj70g-P08hWAZvjh_4xXiPPJWPUcD1rKfGIR7Lz3OZ6TDtRm2DJhPMeiWKazErHQ9NKCroY4IHYgCVd1BN1Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:_pLvZdw7qp2fTu9rplIEyWSbNVI7TzNivngj6HiNyYab2sKT2v9-hQ>
    <xmx:_pLvZQTpVkazZQy6g74xvk1GeaIg48XwKkDGeCvFeyvC0ryMmT5sAw>
    <xmx:_pLvZQZr8dDlNMt7RbY_b83CmOHtr-_TKorx84U8UiRJ8jjsew0WKw>
    <xmx:_pLvZbeSTPIuOGu_6G9-iVRS9sZ9kwHgavFHQLuTfZSfprjh04xsKw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:25:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3c8f4312 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:21:10 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:25:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/7] reftable: memory optimizations for reflog iteration
Message-ID: <Ze-S99lx6GWXe210@tanuki>
References: <cover.1709640322.git.ps@pks.im>
 <Ze9eX-aaWoVaqsPP@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lGeVEnVZS+06Q825"
Content-Disposition: inline
In-Reply-To: <Ze9eX-aaWoVaqsPP@google.com>


--lGeVEnVZS+06Q825
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 12:41:19PM -0700, Josh Steadmon wrote:
> On 2024.03.05 13:10, Patrick Steinhardt wrote:
> > Hi,
> >=20
> > this patch series does the same as all the preceding patch series that
> > optimized how the reftable library iterates through refs, but for
> > reflogs instead.
> >=20
> > The goal of this patch series is to arrive at a constant number of
> > allocations when iterating refs. This is achieved in mostly the same way
> > we did it for ref iteration, namely by reusing already-allocated memory.
> > Overall, this brings us down from 8 allocations per reflog record to
> > essentially 0 allocations per reflog. Iterating through 1 million
> > reflogs with `git reflog list` thus goes down from 8.068m allocations to
> > only around 68.5k.
> >=20
> > This series is built on top of "master" at b387623c12 (The third batch,
> > 2024-03-01) with Junio's "ps/reftable-iteration-perf-part2" at
> > 43f70eaea0 (refs/reftable: precompute prefix length, 2024-03-04) merged
> > into it.
> >=20
> > Patrick
> >=20
> > Patrick Steinhardt (7):
> >   refs/reftable: reload correct stack when creating reflog iter
> >   reftable/record: convert old and new object IDs to arrays
> >   reftable/record: avoid copying author info
> >   reftable/record: reuse refnames when decoding log records
> >   reftable/record: reuse message when decoding log records
> >   reftable/record: use scratch buffer when decoding records
> >   refs/reftable: track last log record name via strbuf
> >=20
> >  refs/reftable-backend.c    |  52 +++++----------
> >  reftable/block.c           |   4 +-
> >  reftable/block.h           |   2 +
> >  reftable/merged_test.c     |  11 ++--
> >  reftable/readwrite_test.c  |  62 +++++++-----------
> >  reftable/record.c          | 129 ++++++++++++++-----------------------
> >  reftable/record.h          |   5 +-
> >  reftable/record_test.c     |  68 ++++++++++---------
> >  reftable/reftable-record.h |   6 +-
> >  reftable/stack_test.c      |  26 ++++----
> >  10 files changed, 154 insertions(+), 211 deletions(-)
> >=20
> > --=20
> > 2.44.0
> >=20
>=20
> This series looks good to me (with one request that we add a test for
> patch #1 if possible).
>=20
> Reviewed-by: Josh Steadmon <steadmon@google.com>

Thanks for your review!

Patrick

--lGeVEnVZS+06Q825
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkvYACgkQVbJhu7ck
PpQyJg//RM1iNRzD1XNHYtGDVAfoEpUAKK5visErRgQpEPFnSPcsZriGmpCRx+Bv
tNuD4AYkZR1AaVjSupREdh79cvaQdIsiY/q/B8c1qBsbsjN+gFri3U93jLcT98JB
xk/rGzk/+XQhTx8V4FJpMqVY3c8jnwilnZLcP543D15f+3izxbGHMLk+MHgALtzy
QJARPMhyw3SwOTimUQK6nywm+U/dvcPfw/moef7/x6ZX3FdaKj9+ZhUqd9RQW0S/
+MxV+go4h5UwW/rVzzaDXJFvO6JXAK5wPrRsATNoa6zR9HnOeSMYyWMKTEh1Mwb2
HuzotBWp6Tyegr8fIvwc2y21HY/YFNjdZFCeQdzQDo4nprniDQ2DmNaSmKReJgae
TjT2rVB+fUWUKIZXsOJKEPLEneOHDDeSbD70Pe3nCwZdJ5iC/Sf07DaqfSdop1jy
YPKqPqN5Yrbk2GUOqW9CkgebxdySRZLMN4+PZXHZcK0AiXrFLeao6sE/ZGuU7uRR
WYuU+JlUjZXJbb21CWi414GfdulCT2tNKPe1/0HIiYPW38lKB7x9d99X0iPJHUjZ
lQ3UiUNhclpO5iUuWwyeQA08xgBADqzjh/tkQRcfkrcTJnAX0bcZTXKv1gqtDGBG
+iDb6vOjn4qQHxuupqAC+HAUdafz18lSi37vab29oelKpKxdZX8=
=BIsS
-----END PGP SIGNATURE-----

--lGeVEnVZS+06Q825--
