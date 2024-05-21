Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7F17548
	for <git@vger.kernel.org>; Tue, 21 May 2024 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716271567; cv=none; b=Isd/vE3ZaFgCnpVyqDqgLVDX20UEhqT5P835VtRZZnC+GGP1qRrJnKAE7kuprXhnq0RbeJgDW3GTWL+BEmqQv9eWy56D8w0uapw4/XYc/Ki7XXV8SbReBFNPzL2ij3JpnDuBlK0RSErHKaibeC1dMGb6UePXhX4ANj3iB9igEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716271567; c=relaxed/simple;
	bh=BfK3I5nr6NUwOwYfojyte8ukNCAh42kmJV6bAQxMepE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjzEB+aKQHsH3RRCxtP6N5dxPbECs6WoYiHWRjy/n2owr0VVcDr5lEVwEopd1zC0FxN8EEj5Z68FHDwfJz1YmqNqBIW9b6ACL8eSE9DR3qEYPlGGDqxsfRlfNUUEvDChGcRgdKFe3KJ59S4129X+pJ6wg05lU72CdkzL7GK6HHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=leC97fCM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qpvh10jp; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="leC97fCM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qpvh10jp"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 70005114018E;
	Tue, 21 May 2024 02:06:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 21 May 2024 02:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716271564; x=1716357964; bh=ZSri9WYuRl
	wBfqVG084p5xgpAlHgb7rS4zpPMvYZQ7Y=; b=leC97fCMZ7yovoTV31TGS5oJ8J
	hKKO2OeqvgxwZSeyqUwO0aNGW1vBz9hktEguqeoQFFwsvwi9ub7n5Mme63pe1RAw
	MJraVEitOB0DKRx9xemVjhFksqBP/gzemBZzmSm6cZPs3OjFQqeiuV2gaYg/EtjG
	LxX1y/+ajSwZ8Vx+HsoEEplJ5cu4syPplx7KQ3W9OjSkuLwCZgQN2PlliCUP/ywf
	+H9Yeq2NRuv8ZueUauUfUyYc1QQ8lrmJN5veHgUkB+bEePCa3RpmniBAr40rnCff
	Kbnyi3IEv4RRG7b+LvkfdnRAQ9UonDv/PuEi8Zru6nNQ5kiK+78+pQtsvEtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716271564; x=1716357964; bh=ZSri9WYuRlwBfqVG084p5xgpAlHg
	b7rS4zpPMvYZQ7Y=; b=qpvh10jpk9eyCx+z4vgU/AmQZ0QqUpcq1cRZnVu8698j
	77fnM2O9TMvxmASoYVNrkXa7BkeFHcRfLDv1yGUSQZKZzJUvf2pL/wUbCnxgkz9R
	+HEFJ6fwE7PyOe0dO7pEJ9KPVLeVwDCMVBdhwOnlsaiCPIPnX9VRUYu4qpgmTSit
	bZ+yfTGLNyRkgffAuAIWuA9m0mDe7jOqvSb68cpzy1td2AtELQqTbs3riM6bJxYp
	AGllJdz+rFdocTaxifw+iXfjIqUqtQbTfHH5KJn1TS1jV3cpQExp5xMUg2yRQy4W
	yDT+ULaR72fAkY4aJjGqzu7b+UVWj+6vAaFfwjzxiA==
X-ME-Sender: <xms:zDlMZv5o2Og69bNGwgjRVvLytCcBTwf0LJEusDnRjT7pIVYE5GU7Kg>
    <xme:zDlMZk4El-he8atCPftUKGvYp-rsiWz0oD1cJ3jHrdS_eC1vNqhnEQHK8iUEf6BQ5
    IXcDJHnjYoLk0ps8g>
X-ME-Received: <xmr:zDlMZmdBc0m-h6GOF9xv06KfpBASKbmcWxWKS2ck66S8KgK_EVm_IBNMQpT85W189HfHrRw8V9bPMKF3_9OOHOOyMmoUFeXpupAPHf8d-17u5mdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptedthfdvfeeggedvvdevkeduvddvte
    evtdeugfevfefffeegvddvteekfeevhfdtnecuffhomhgrihhnpehpkhhsrdhimhdpugho
    fihnrdhpshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zDlMZgLPrLTQr-fRimy4MXdFPMSKEjOVyBdfOS7G_jffOkakJ-tCiA>
    <xmx:zDlMZjK0q_0JSI58dGVFmeTrhyWRC9jvq9scPFHYGHryilHsY8l_mw>
    <xmx:zDlMZpxB_0DRwXql7UWUetjq5IhZHJcvhmwLSGr0AruqjhAsDAdA4g>
    <xmx:zDlMZvKoDjjkYSodYTniiqIXEK6ypW3cCTJE2RB_NjnKgJJOQyJfnA>
    <xmx:zDlMZqVVEi7kPg1ngYuL_w9oWoIW-jbTdNqsxS_NSyqpBf2u3T-5ODWU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 02:06:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 577703ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 06:06:00 +0000 (UTC)
Date: Tue, 21 May 2024 08:06:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #08; Mon, 20)
Message-ID: <Zkw5yDAVAnmy-cg8@tanuki>
References: <xmqqwmnoca35.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EPhBgecwMkId3Q04"
Content-Disposition: inline
In-Reply-To: <xmqqwmnoca35.fsf@gitster.g>


--EPhBgecwMkId3Q04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 04:55:26PM -0700, Junio C Hamano wrote:
> * ps/refs-without-the-repository-updates (2024-05-17) 17 commits
>  - refs/packed: remove references to `the_hash_algo`
>  - refs/files: remove references to `the_hash_algo`
>  - refs/files: use correct repository
>  - refs: remove `dwim_log()`
>  - refs: drop `git_default_branch_name()`
>  - refs: pass repo when peeling objects
>  - refs: move object peeling into "object.c"
>  - refs: pass ref store when detecting dangling symrefs
>  - refs: convert iteration over replace refs to accept ref store
>  - refs: retrieve worktree ref stores via associated repository
>  - refs: refactor `resolve_gitlink_ref()` to accept a repository
>  - refs: pass repo when retrieving submodule ref store
>  - refs: track ref stores via strmap
>  - refs: implement releasing ref storages
>  - refs: rename `init_db` callback to avoid confusion
>  - refs: adjust names for `init` and `init_db` callbacks
>  - Merge branch 'ps/refs-without-the-repository' into ps/refs-without-the=
-repository-updates
>=20
>  Further clean-up the refs subsystem to stop relying on
>  the_repository, and instead use the repository associated to the
>  ref_store object.
>=20
>  Will merge to 'next'?
>  source: <cover.1715929858.git.ps@pks.im>

We've waited a couple more days now, and there was no additional
feedback so far. I'm happy for this to be merged down.

> * ps/reftable-reusable-iterator (2024-05-13) 13 commits
>  - reftable/merged: adapt interface to allow reuse of iterators
>  - reftable/stack: provide convenience functions to create iterators
>  - reftable/reader: adapt interface to allow reuse of iterators
>  - reftable/generic: adapt interface to allow reuse of iterators
>  - reftable/generic: move seeking of records into the iterator
>  - reftable/merged: simplify indices for subiterators
>  - reftable/merged: split up initialization and seeking of records
>  - reftable/reader: set up the reader when initializing table iterator
>  - reftable/reader: inline `reader_seek_internal()`
>  - reftable/reader: separate concerns of table iter and reftable reader
>  - reftable/reader: unify indexed and linear seeking
>  - reftable/reader: avoid copying index iterator
>  - reftable/block: use `size_t` to track restart point index
>=20
>  Code clean-up to make the reftable iterator closer to be reusable.
>=20
>  Comments?
>  source: <cover.1715589670.git.ps@pks.im>

There was a round of reviews by Justin on this one, which I've addressed
in v2 and which was acked by him. I'll try to rope in more reviewers
internally to get this over the finish line, but I'd also highly
appreciate any GitLab-external reviews here.

> * ps/reftable-write-options (2024-05-13) 11 commits
>  - refs/reftable: allow configuring geometric factor
>  - reftable: make the compaction factor configurable
>  - refs/reftable: allow disabling writing the object index
>  - refs/reftable: allow configuring restart interval
>  - reftable: use `uint16_t` to track restart interval
>  - refs/reftable: allow configuring block size
>  - reftable/dump: support dumping a table's block structure
>  - reftable/writer: improve error when passed an invalid block size
>  - reftable/writer: drop static variable used to initialize strbuf
>  - reftable: pass opts as constant pointer
>  - reftable: consistently refer to `reftable_write_options` as `opts`
>=20
>  The knobs to tweak how reftable files are written have been made
>  available as configuration variables.
>=20
>  Comments?
>  source: <cover.1715587849.git.ps@pks.im>

Same here, I'll try to rope in additional reviewers.

Patrick

--EPhBgecwMkId3Q04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMOccACgkQVbJhu7ck
PpTlBA/+LOx/iZnA4QgAtvJXUHDwQJQsgEYm61syAh9TRN7rTC0D+0SB/vm84hKI
a4/AtWwQsghNEijDxKzPhFSZI46yRCh2e2t6uSYQgaxzTP4CmHQWu2KbadhAoQdu
W2rWqM7kelzv3AVvOCTeu+FoZR+khrTgHbU5HEuzfMIWCEua8vq2xfXSu6RreDj4
vRsEYn8ZbADSesj/dFgsctFjzmOkgoNADUMkZCbzdMcyZXgIwzS0XnpcoRd3s1FT
DdWKRGmnZ/y29G9CgbFjaaxgTYQpvQkuC++ggUzMTjfSp4SMtiiyBrhJjW7EJYE6
g+yxrxhTTa4dt9+xMwUxgPT80jWWwpya6agf40c3aFtfNjb7F0MrkhLGAuAp0q0T
jr/IUi79lcbC0sWe+cjFvl+7JnwDMQDiBRBMzowsuemZDMprwWQWJJ5FoISdy8CX
LVnUGVaE+RSb7OjkcWGjuQq0Yg131tTBZMsB8wwum1X+RViAKKQZNPy7qO3WpuKR
Mon9Idh48hQBSKsOqgu8ocnxf6ED+4eBWi1pHYo3JkSForMEGhgNk/U2QyQY/KVm
G6KtDIeBJnSPt3G7Zcwmmc7ijtfiBFB8EGO8YA8EFY7Rnp9J4RZnj32bUX3mcRB7
tx3sL79/5aXa2VF/TCJiIsj8dhTV7Xj0Zoy1I3RIPVQJHTBfhsc=
=OEzh
-----END PGP SIGNATURE-----

--EPhBgecwMkId3Q04--
