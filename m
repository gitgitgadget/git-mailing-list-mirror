Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08315F410
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327673; cv=none; b=iRl/QUbJokYtJzX8RP4f5Z5vn5V/D+xKAdNf3Fp/sAet4/sVQYOFWNxQMvkbKxicEuLMCjH0ZfcxRxU3iUd8nffjghGpOj7Neq3dX1zrvlyPjG23lkTysb6cA0LBexgJ6sAq6np9Jr/lFtONhzrsq8tzzxQ+ofexvHnw2QvLXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327673; c=relaxed/simple;
	bh=qPjGapnUn7jt46pEs8c7BH9OGO4qeY6FJ+oXb7rsCBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvRsTLVUtcGH8wJy62DWnh+J0be/oIfrWCIK4MAzlA2EbV0hxSE1cD+75MZcEtBE9coYek4hkg+TRFnyglFkk+5VkK7vJ6AwK6D5vfmpScfn35s2FW7sT46xEDyLCP0kvp10gOmJY7fXCZ+4QAQtCLklCcqq1TPLQT0k6rkdHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gN4Aqpoh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hCSRwBKs; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gN4Aqpoh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hCSRwBKs"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 8EA341C0010F;
	Fri, 10 May 2024 03:54:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 May 2024 03:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715327670; x=1715414070; bh=4YSX1JH1kk
	ppSYhkjeVwGyI+tS5Ugqu8eNM/lsl2UAY=; b=gN4AqpohmmUeElSESwcYMp2c6N
	xQCk2xOegWBf3z9lnLKDXV5aQLt5xNdZz46sxuN91jFZ0f04ZGLAxbwjgpGUbNuQ
	JJ36D279wrowpDlPXWGriS1jT8ZgfUoxKUgr8V9IimMMtCZcx/WboYobBsic0/Og
	xpbTZ1DSn4Wd5mOwAyaVF6jcbCNLMtcK+8wutHsMONYuNuswkrWxZ+IOVM0YrCKQ
	diE10mlvSOhG0hgNsrFhvxRQh9sIGGxPO1wblgvuRlRjrHtFhywbEHOz3lGNYni3
	Pu5EQotn7WMXWBj+iNZXrWIK/kOiXEc3gzQh8p9Noziz0HbPH47nmKlShuVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715327670; x=1715414070; bh=4YSX1JH1kkppSYhkjeVwGyI+tS5U
	gqu8eNM/lsl2UAY=; b=hCSRwBKsgESKeXE7XoKdXVMsHFsTCs1mFoNIB7PmLM6m
	qdfgXY5O4h+aun5hNJiTODCTrRKFOntXD2pQPYJacpYFkVDhe9aj8z5VnRYIV84T
	KbjvKJmjQFFJPJpxvqpg+pdSFdUS1X00BGaTjWvhy3CnYeD9awDHNLQkxihq/Q9g
	5PSQsR7lLQ2xXJg0H03KCjs/2sj69DhbcoQ0+B3Z8phTXftgdpnt7ZqCb6qBQcjY
	FA5mhboNGQMpKq6XReVc+2mICnt80jXzv1WJNotzJkbhu62CBpIcCS9b3O1w6I+b
	89Lop9x62tA2Zt+5oBCC4bDaYRfhZ9SWUvMHJLSexw==
X-ME-Sender: <xms:ttI9ZjcpLLnUsFApVapj2YSaRWevn3KUJXnGxlfU5d52TyQIDIUQ5g>
    <xme:ttI9ZpMSf30LXX8qFbkyvguQ_EdtNN6gU4ukFtNE_wfI-GJBXSYL20hWKLkwrNclA
    0ZTZ2xP2Eh1iVYG6Q>
X-ME-Received: <xmr:ttI9ZshSrypviWVjQUbDMau71UsEinkDl2KBoulKHa5BUryd5_giqrEm8d7PnvJAyAbnfGRJffBnebD2SzqE_3323raAL7KJs9uJ6zBEWghr8Z4D8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefjedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeikeejkeevfeevfeegueffheejgeefhe
    etgfevheejueetffeuleelfedtgfejteenucffohhmrghinhepphhkshdrihhmpdhkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ttI9Zk9bSbbAZ9pvho7XYpY93cOoACB9GwR4b2IaE6r_iU8OoOmfpQ>
    <xmx:ttI9ZvueXHB8aE6WbDroTxuz3QNEu0BWAUHTFAv5Qgq012eIIdzs6w>
    <xmx:ttI9ZjHPj8hxcG4dcp1YKB0S6Cfl_z_00zB6II_mBz7orijApdnG3A>
    <xmx:ttI9ZmPPKosOYlF3Wf-loxvamK4DtRgRaGbZU-aTGfhOciFP_-9KXQ>
    <xmx:ttI9Zo5wwJ7VYGpUj2nMN-xTRmc5ITVb0jE3Ru1XH0n8-GFDmu9S9wFH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 03:54:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 09f91dc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 07:54:15 +0000 (UTC)
Date: Fri, 10 May 2024 09:54:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #04; Thu, 9)
Message-ID: <Zj3SsbHLp-gH_Jey@tanuki>
References: <xmqqfruqsjb6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kTtpulRe5VfAGJDD"
Content-Disposition: inline
In-Reply-To: <xmqqfruqsjb6.fsf@gitster.g>


--kTtpulRe5VfAGJDD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 03:37:49PM -0700, Junio C Hamano wrote:
> * ps/reftable-write-options (2024-05-03) 11 commits
>  - refs/reftable: allow configuring geometric factor
>  - reftable: make the compaction factor configurable
>  - refs/reftable: allow disabling writing the object index
>  - refs/reftable: allow configuring restart interval
>  - reftable: use `uint16_t` to track restart interval
>  - refs/reftable: allow configuring block size
>  - reftable/dump: support dumping a table's block structure
>  - reftable/writer: improve error when passed an invalid block size
>  - reftable/writer: drop static variable used to initialize strbuf
>  - reftable: consistently pass write opts as value
>  - reftable: consistently refer to `reftable_write_options` as `opts`
>=20
>  The knobs to tweak how reftable files are written have been made
>  available as configuration variables.
>=20
>  Needs review.
>  source: <cover.1714630191.git.ps@pks.im>

Just in case you missed it, there was a review by Justin already [1].
It's okay if you want to wait for more reviews though.

Patrick

[1]: https://lore.kernel.org/git/2rozmhwf2jpyqmy5vtf2t664ko7ztinbzdmwirrqxs=
pjwzgj7t@jctxour2o73r/

--kTtpulRe5VfAGJDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY90rAACgkQVbJhu7ck
PpTtqQ//TzGQgBqhQLY+3Eq82rL4GkZl0aSvPcW+RM7o4jmMNxC4j0W/TxLo4PQo
M5aqjY/RGf588I4/jfEVWwusWQEMjguZDPPr/JM0OCeprWIGNjyAmJJlehWGz2ZG
DL6XaTX8oViT9TkCkHrEqN+AOCcOYgCEwG5UE1A3Q+/z/I6jpTtswmU0fRdIbHgj
NlI06ha9RpeRRHrymhXPYeiuWFdbgKB6HUU4hwsLhUxxIMnHVK4n8E2TQmgfQYBx
02fOXUkDOYiRExnY1+00AMkrd9CRYTJ1Bl4JPiGkQgo60DWXEymhTUg01f2XIeWg
3iqh0+0+x0q2Wi4lctr6S3XfY8ZXQvuP8wAOwbfSMYLpQwpcRpfGC8OYWRyrKRv4
696hSMDEyeOxT4eP9EUi9LnxO+1G/MeabPm/LlCO9P7gnndmg6PNmqYJPvD28XLL
gvTHJtypdFdHJisLymHEpx1oUXk0F1v08AqrBDyZM8x8/XfCiMX6MFoVZd2ez5Px
AzzxTJQAY5JE+/NA2H2oKgHoZFAHDFAyY+rRYhCCp8WD5ft8Hyphntbs/tHtcuGk
6A/Xsx8FIHJHSLdbfo1nRRWNYP8/W1ZAl0vGtVxiqlMEyfZsKCYoEXRWSZ8ZZyyx
g/un2SIAkzs4Ecev/sFB8KhzgGuhwFEDhM1QrdBuQ0j2tkFB0CY=
=Pnc6
-----END PGP SIGNATURE-----

--kTtpulRe5VfAGJDD--
