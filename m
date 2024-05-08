Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3481AA2
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166223; cv=none; b=dxHGdJrP1gwH+jw0Uj7Km9XB49N80Z8cQaOUTXtXcc/58Aqu59poehhrKvZWpPbV9COOkuGQ2ZRbW5/jUNhnKROHCb2uHLcUTDReaD8i8ShbV86Tc1m1oLTyFUVoAseiLCB0NL44jd8v2ahWIy9BObj107Dwi1fLRRgSuE7VqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166223; c=relaxed/simple;
	bh=33AW0EK9oIUM5dh9yqm4nGE2wLEUs2sS9Ym0D9huheQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dm0d+A9ecDnHY9fdPI9lKgLz4XIKiuW9R4HOOLLuvKHTWV5RSMkQsPergEnM3U+b814z8MqVMv1OxNKEox/EBoHavr8CUelmPxw6u56J6HXUsRO5Xl5UAj6hj39F2spsQGkDB7EBMKtCDa++W+F6j7F3Th+b5p/P4OUGd50QSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=saSHwOSP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eiiwI1qt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="saSHwOSP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eiiwI1qt"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4258F1380E62
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:03:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 May 2024 07:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1715166219; x=1715252619; bh=OTcKTetLsiDK+gUp5L7hz0cU2wY56rpB
	w3EBvpHkIpQ=; b=saSHwOSPHYr+nJ/fLlbXjQgIjfEGOC6/gz7wvZRKWWpMHZe4
	TEb0qEFe+48lKBb4yccPBFLYc0u35ROgPF/cCSHjk3/ronAV4AbOOEVBMPXx7M2N
	B88B3cbkPTv3Ct8u1YErlImx/5GfQfdSKdPZwi92MmZrRq79XVZZM+DWqDE40CIV
	wvgWPjXiboRggrmv5vIvOrykFKoJJJIHnFi7ZvocPAz+Fwkk8Tc+FbisA2uQVl/K
	NHvSt2QBc6GAp3CJ/zmka2KMrPz7kc0pB3ZF+zSuxx1Q6sKp/vtdJynGrn7Yh/Qj
	C4K/0DI4GdQ1n9XEY5pwCrT2Z3uK6sTqv2AEzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715166219; x=1715252619; bh=OTcKTetLsiDK+gUp5L7hz0cU2wY56rpBw3E
	BvpHkIpQ=; b=eiiwI1qtSG0Bj0iNp+jj+9WIK8DtONa7lzZLb5El04UbYV0p9EN
	VijR1SQNEoIBEc/ud+Lc8aCTvskfSOurxK5oOk8eXYxjg24w04IarUDQA5dIukUR
	7TEQp4FygIhssdb2tP/TTEIJKJ4mXGeFIA9VaKlXxMrEnRB6g9Sp+614TjpuxsLd
	ZyH6uFi6wTLk+qX4a3+Hi6z5ASyCqOE0w3+ZfawJIQmYhNtgugAr6YbrJ3/Xv12I
	RhBo4giCnyLJ+9rC9PSAyhGpUJUOzZPBRi9JBN4HqQ/J3GDMmc6Q+Zp1VprFxs2L
	0yI7pSEL3ANIt0jFN0jgzg3hEK8tc0I5wYw==
X-ME-Sender: <xms:Clw7ZptyUsUXLwhZMsL-oKPpen-f-cHa5xZFqU0gicD5jj21ls5BRQ>
    <xme:Clw7Zicq7G8A-6TkrGWCmKQ3aQNDfSkB6RuDgzZlQGmvk1_RxR8TKscPm8_YDCwGb
    fMlgNAt7enkiSQT5Q>
X-ME-Received: <xmr:Clw7ZsxUwXrLVkQwE2vZdAQC7yWn1XU5rfmmVDZk-bpXW11H51mQXBzHJS_uIedJ5e2eXOaMzOxgtOP3OK7LkrzgPgPJEawkQz92nYCilnWkAGySBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:C1w7ZgPPc09XCUVLuW0kpsyp0bxt0ckKOsToKdGOcBc51Gtc1mFL5w>
    <xmx:C1w7Zp-aU406qV7dOZ76-MSQPCdOGALWvns3RCTd4f7Ma0tZ8FfQgg>
    <xmx:C1w7ZgVM_jZvoBgHv5Q-KvH2uNwQ_OWvcFnmgLpcZc9n9_9n90kLAg>
    <xmx:C1w7ZqdtzL8IxyzViH96FMoGtLu7V6wOY5TcF49ResHcmGDdNQEG-A>
    <xmx:C1w7ZrmXRg8OP9bz9VJ5I8P3APErxfyVfgFG8_6zBJZgd87RrftjEhax>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:03:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ad353b9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:03:25 +0000 (UTC)
Date: Wed, 8 May 2024 13:03:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/13] reftable: prepare for re-seekable iterators
Message-ID: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bFEahUSCdjVwHBly"
Content-Disposition: inline


--bFEahUSCdjVwHBly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the reftable library uses iterators both to iterate through a set of
records, but also to look up a single record. In past patch series, I
have focussed quite a lot to optimize the case where we iterate through
a large set of records. But looking up a records is still quite
inefficient when doing multiple lookups. This is because whenever we
want to look up a record, we need to create a new iterator, including
all of its internal data structures.

To address this inefficiency, the patch series at hand refactors the
reftable library such that creation of iterators and seeking on an
iterator are separate steps. This refactoring prepares us for reusing
iterators to perform multiple seeks, which in turn will allow us to
reuse internal data structures for subsequent seeks.

The patch series is structured as follows:

  - Patches 1 to 5 perform some general cleanups to make the reftable
    iterators easier to understand.

  - Patchges 6 to 9 refactor the iterators internally such that creation
    of the iterator and seeking on it is clearly separated.

  - Patches 10 to 13 adapt the external interfaces such that they allow
    for reuse of iterators.

Note: this series does not yet go all the way to re-seekable iterators,
and there are no users yet. The patch series is complex enough as-is
already, so I decided to defer that to the next iteration. Thus, the
whole refactoring here should essentially be a large no-op that prepares
the infrastructure for re-seekable iterators.

The series depends on pks/reftable-write-optim at fa74f32291
(reftable/block: reuse compressed array, 2024-04-08).

Thanks!

Patrick

Patrick Steinhardt (13):
  reftable/block: use `size_t` to track restart point index
  reftable/reader: avoid copying index iterator
  reftable/reader: unify indexed and linear seeking
  reftable/reader: separate concerns of table iter and reftable reader
  reftable/reader: inline `reader_seek_internal()`
  reftable/reader: set up the reader when initializing table iterator
  reftable/merged: split up initialization and seeking of records
  reftable/merged: simplify indices for subiterators
  reftable/generic: move seeking of records into the iterator
  reftable/generic: adapt interface to allow reuse of iterators
  reftable/reader: adapt interface to allow reuse of iterators
  reftable/stack: provide convenience functions to create iterators
  reftable/merged: adapt interface to allow reuse of iterators

 refs/reftable-backend.c      |  48 ++++----
 reftable/block.c             |   4 +-
 reftable/generic.c           |  94 +++++++++++----
 reftable/generic.h           |   9 +-
 reftable/iter.c              |  23 +++-
 reftable/merged.c            | 148 ++++++++----------------
 reftable/merged.h            |   6 +
 reftable/merged_test.c       |  19 ++-
 reftable/reader.c            | 218 +++++++++++++++--------------------
 reftable/readwrite_test.c    |  35 ++++--
 reftable/reftable-generic.h  |   8 +-
 reftable/reftable-iterator.h |  21 ++++
 reftable/reftable-merged.h   |  15 ---
 reftable/reftable-reader.h   |  45 ++------
 reftable/reftable-stack.h    |  18 +++
 reftable/stack.c             |  29 ++++-
 16 files changed, 378 insertions(+), 362 deletions(-)

--=20
2.45.0


--bFEahUSCdjVwHBly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XAAACgkQVbJhu7ck
PpS1zA/+PEcpqtN+iz9Ti3jt59aBHg46+ZAbRhcSMmQ3EjklelnJtiTNQJwlQmgy
5dpMzNX6YW2mJ5faBFOKP7uzTj+c8P9rJEY5Cl8juoitxvPgE1uDT4liKKt5x7lh
Xx7TVqhxl5BMz481QqaQbamM7PDmgZelKAaP9+5Psw4ILhdI6J8DQHL3c3vzyaD/
OnZFsDxBjk4Wz8ShLBeMM/J6x9ZYXKVp/krxSRzJyp8iPsSEme1OWv6KR4jwRFA4
OZRIreqFZlS2z704uwrzhztsbm5femETQPNoXGcn0L2Fubs598gu9gS2XIwATCp+
b29Eo8ZeWrgv4WRBk8E6tMSOel/gQy5sveKi71kL5l69tmpLbivchso2feumcpkj
gwC//1BsnWQMdOEH7Xv+4cZoy1Lfh22BHdufIV3CV57cZl/Kl2cj4mYhoIi/6Uga
xuaO12AwTqZCuObvB5nvbVqbuEAIH9zSX8l8J5h1vu74+uxvD7DeuWg00vhuQj9k
ONb0H0Yn1xzJ0aWCuvzzx6t1JvhHDjWVym4jQ/urUZwjml5DtLyA7uY5JvsQF9Wj
DtgUjgfI+oIw8I6HXna9gDMqAdsQ4osloiQE2MU0PsQS8jUqyLSC2ErymZlmxBNW
aIBj4tz3MSjYXco9hRUq4rQGvgablDrUdzUKfWb+us6LdL8vLDc=
=Jo1m
-----END PGP SIGNATURE-----

--bFEahUSCdjVwHBly--
