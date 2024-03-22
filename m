Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5340BFD
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110157; cv=none; b=Np3lZubm7y5ED+FyrYDpu+zNSOQ/ENeQTkIF7WzSLCzPsM0sknsyc3cmsl37hllqOxeMfD3FWwtPi0zlYOtYTg7UrfLJMv1pKZh02plb/Jaft0csZySYzXm8aqm8fmXdz/iGYhheHYJ5FTNoHYvjTdROgs3PdN9sSQCQuqPF7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110157; c=relaxed/simple;
	bh=f3htPB8Qb2F8fa0m66naWS88CwtHGH4EE52aY5I/nGk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ejLOTwntGUOdD91GJkT7nUQ03TUBk7FsaVU1hcfztxazI2GTO3IL/c9YA20K5YrzZBUfeDceC0iZ5Z1x5voSO6knTUfM6kgq3hwp1ix8e1h9by0uvT1D8g3ryGsyf/FM0beMbtFCJ6N3iqUYVj/yBWJhvXsq5jb7Wf5yScRofkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gEWUei6H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y+UeBKD8; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gEWUei6H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+UeBKD8"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 3BBE15C0090
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 22 Mar 2024 08:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1711110153; x=1711196553; bh=TODwVmF5xBLnoYkVCrBSO9i5nP2JEl34
	eg/3nfzWUfE=; b=gEWUei6Ha9Tkrj+VqsiUvxY+PjD3ujDQYcobUtX19TKFCzJO
	PCghJ1CHXSpHG1djVtD8uoFH3yp8e1HrCZfIIXa28As4x9OFr7Ch+4Pwku8ZkOK1
	jPU4iP5QUCrdAINk696xawhteCuLyl9x0SVbPQsOUobEMGjoxmaMgBwc7Uz34lme
	+Pn73Ec/SvlOpKHt7rZsG9nDDSoSJuqitlRu1zgDPcWWqDuEHX5FZxQS61kxD+if
	bgHjw1wwhYVM8ajcooIUla20fD7jppA8WyLeO+QyU4PkaztlkyKkF6NlPk1tnjYy
	ylKRHxrXsiAxzZlqgICSyA0frVQkvniOirIlGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1711110153; x=1711196553; bh=TODwVmF5xBLnoYkVCrBSO9i5nP2JEl34eg/
	3nfzWUfE=; b=Y+UeBKD8+7xCdLzlL3XAnAWCyKrlDV1kUERN3VvA7Nlk7KUxKNS
	XqlJWnqusvdfXCRFi6mYcxuDqpG+XSKqjQpZizQI2woIVTqW2rj6inUbtpNVS5cS
	tpqwc/MfemcJCKRB/VZkJPrYJFkn9kdtLQ/Cw3Fe2cIYEXVPpt5RcT1qX0oxCcvs
	xURhgCAHk4sVM/Kg0ppNiVp7DwH6qDfRukyHiLAwt78xS2W+KEJXGzRQEqBQ3keM
	qbXQv9vtHifqC6AP2cPMfkI4NRMG/4imSdB1sSRmPEOWnKegHte9W3kDFn1Otz5C
	nPXjiF8Sg/NOrgPOOzNZSAoiCpIinoCH4Uw==
X-ME-Sender: <xms:CHj9ZRUKUidS2w60FRVDc0rkKzQ1h3p3I_c_WenoOn9GNeoeZXzOoA>
    <xme:CHj9ZRlFTzxyBtXhG7iZ07QxRmYU-VCj-SF2MZ-Wq9liRVNksYY3kFfg35-Su3Lwn
    l3nTITc6gnc0BRK-g>
X-ME-Received: <xmr:CHj9ZdY5QT4PDnalZCT_zbjLJah26hYTraI9XRnkJEnhyDEuIB1Xw-6Q1Md4y6hf9XPvXGZ3qSI7SGRl5VJJ2HH-ClB2zQxyBOYU7fkRD5-c1yGzeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CXj9ZUVQ50X4CDRg-Zt6rTN1_TY7wk5UzAsw8P8tHtfQnGbK8SQ7hg>
    <xmx:CXj9Zbnveqf3efgbtqxaOuA7Ve_DHVuIB8UEfx2x4pORfg41Kt6lug>
    <xmx:CXj9ZRfkKrCS4YQMrlHF_QqUxDUa7MSoSzG6vqArkkcwspjMMpaPpA>
    <xmx:CXj9ZVFZATVqdGnp4TEm1oLEbUUwZlyjgI6-6E_KndTkpsjOjbYqOA>
    <xmx:CXj9ZTs__D2Xz2kaSSdql2NlmwjC9JRKFAw8bWPDTDORfIKgs62wow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6854e0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 22 Mar 2024 12:22:23 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:22:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/7] reftable: improvements for the `binsearch()` mechanism
Message-ID: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fDmc9+pJoLpdjLtn"
Content-Disposition: inline


--fDmc9+pJoLpdjLtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series contains various improvements for the `binsearch()`
mechanism used by the reftable library:

  - Callsites are refactored to make it more obvious what exactly they
    are doing. This mostly involves improved names for callback
    functions.

  - Error handling is improved such that binsearch() knows to abort when
    the callback returns a negative value.

  - Error handling for binary searching over restart counters is fixed
    so that we check for errors at the correct point in time.

  - Decoding of record keys is refactored when searching over restart
    counters to not require allocations anymore.

Thanks!

Patrick

Patrick Steinhardt (7):
  reftable/basics: fix return type of `binsearch()` to be `size_t`
  reftable/basics: improve `binsearch()` test
  reftable/refname: refactor binary search over refnames
  reftable/block: refactor binary search over restart points
  reftable/block: fix error handling when searching restart points
  reftable/record: extract function to decode key lengths
  reftable/block: avoid decoding keys when searching restart points

 reftable/basics.c      |   7 ++-
 reftable/basics.h      |   7 +--
 reftable/basics_test.c |  55 +++++++++++---------
 reftable/block.c       | 114 ++++++++++++++++++++++++++++++-----------
 reftable/record.c      |  34 ++++++++----
 reftable/record.h      |   6 +++
 reftable/refname.c     |  53 +++++++++----------
 7 files changed, 179 insertions(+), 97 deletions(-)

--=20
2.44.0


--fDmc9+pJoLpdjLtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX9d/0ACgkQVbJhu7ck
PpRYWhAAmgcWptAOlkkkTQ2VrAEKdcPA8S0AFzJB48I6e3nhBVwU9uOsb1Bde1Ud
HEo94QQMychnBd8UT3blbKCNa0N8xY3pIv/PDViMvg6DbskKzHBeDjhvGui7sunx
NrQc+HJNuGug5Af/suAnEl8oqHUd21rlaE5I41pGHhAO7AF0K0Dsx4gUxL1f30Bp
3RFhdSEEKT+ZbcvKjLpk4QQsuZFq5rnri+uXoXdUZH5TJM+dt5zMDR19JoqfxAjT
uftN2Ng4IOLxlBoLqSxYZRknLsKrxBnBD5jOuahT3zDeMRJ4lA4D4/wQuSesmvAP
zGEZu6EXRsr3f9N4qI3uVXxuB6m5wI1QFBy7E8iRjshZr/jrgs0uTfKsilSI5bzA
Jb+cHaodIpAHeMQxOWFCE3fyJbXW9WgbvPmJZ1yJwU6lxRdYwNLKNvBuBOSt0WH2
BD3rLiRpkDRQHV0RqKqawHBEkVv/FFo2gDM0iLVoag8b003WDwbqeWNNrQH6J3PP
YavdiNOfiUyvhiOp6ujUg+gbXD1D2xEEXPVMpOsQE8/7m+ceDZL+D/aHgwQQSxrZ
X8YxiR9dt6xPUtltAA0jNXRJmFIaBZMkS5pKbyQR9sdakro17tOdyoY8kC0CpC6E
jU4aeIMRCeQJqcD5b+gpqU63zwJSI5PQY5OcZlLH2odp29oqZHE=
=4bul
-----END PGP SIGNATURE-----

--fDmc9+pJoLpdjLtn--
