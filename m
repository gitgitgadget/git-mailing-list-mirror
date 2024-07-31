Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB6B1AAE13
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422263; cv=none; b=lhHiZNWxpMNr9JWtfw+dmpn5ZdHWlAkHTSzkaVUOfCyTIMICFqD3AMWwgfUR4zHNk5waOqIzqTAARqna+IAg3P+2+eNzUdjrtsJIpBtzgP6diVW0wg7vY8s3OFs4Z5q3PCINlcS2ZS3FBg9wXvsNbmrPJj8/3qtA1OeABY1LfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422263; c=relaxed/simple;
	bh=bbs39iwJyG4zf6CJoMjzbPmRwTG5wUnXUlJHjRrm3ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B79SabpjSzJjAY1miLKzOD3nLaseZUrLU/HUhwZazDQsWxmXwWLcmHBR82kODjkrwAI0mSG8qAGuDekuVuDBl2UnlluiZt+yi4q2B28yx6RWfr/IyNtF380I2wWEpnuKT5uopEjSY9PUJo5K5q5HhLqBemBkrTPLxE/TfDMEpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TJgKtDAy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RDYm3BNo; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TJgKtDAy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDYm3BNo"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5B9D013822D1;
	Wed, 31 Jul 2024 06:37:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 31 Jul 2024 06:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722422260; x=1722508660; bh=YtiqbKTiES
	HhSsE2/5Pon0aaVKvZmPQUk7i+6RHN4ig=; b=TJgKtDAy4VQHPkyZluiYI5bTj/
	iJS7OFrmKuIUzsZjPnnz5p+4RuyLDrdi26omVXos5WHeg996eQ27uAjYfFANuSxE
	E+rtVC/8aGQ3vOolJa9wTpExi6PZeIdjfJmuaCRNS3EL9OEr+PNFYfU4mH/p/cj+
	O477klP8Aumwqo0lk2IRy2b7ax5HRRWJo1PrK1rEVggHjWa2ugdQJIRiLM3opE5Y
	IwVDu3mIai6DUpaMg6oxsGBYShymfIusz6UnjDttERPqweJuP5MnA04xLZEEZ+j7
	lrCUNzElu/h0D5W6fXxobGNzF8NN84zM2rDZ1yVh9XRD3cWSF1u5VOxWymrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722422260; x=1722508660; bh=YtiqbKTiESHhSsE2/5Pon0aaVKvZ
	mPQUk7i+6RHN4ig=; b=RDYm3BNobfH6pcdHEc/w6Uqq7HSLyNmvb4aaOf8OD9Gm
	uyVHiFnr3qjFMQXcbHUNrnJ68gRrBUZO43WaKG6hI4Zi6HSBvqw4x+RYGxKfKbqY
	eSEwo5dwHaenb60YCOyJFwnIQ+VGLjdSPm+vDGMtaPBB2Lg4K+B3Ur4c+ltUdAkH
	v2BI+a/YGUzq6OhvVsXBeacI7jmOx6LFSFamHEjVCtKyigiF0u3TUz4TBo1CVval
	g12liIwsbhBBdNZDUj168ws39n+3qWsNc8rR53B5DbkFMEnmejRU9HBmRdW66kxp
	jvSUJij5VLK6Yi0kVwq7PGqydjuwKRhHXZOgg8ZKbg==
X-ME-Sender: <xms:9BOqZoOOPZ4Uc0gJ7exRJU7OsgMclwHKyZPtxCp-6YS-E26nuTZSMQ>
    <xme:9BOqZu97-fD8Arjy2BVgKP1gZ2x6B4mBM1I1XrJ8hxHKtj-OsOKbk2YK9jEEnUr9e
    jWLmgUUtThIYaO2Tw>
X-ME-Received: <xmr:9BOqZvTWRjnr8D0DCqmGBugkPTGfHdoTEcyKk8s6xnkajnAGLKJQA604f52JPnkLTFjoT8tvSp7h10GEacaRQHh1KYVyGyzXzHA6v_YemAbr1BJf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:9BOqZgsqHA5FkDV329R3wKZH_CWzbELCqmHE1pIB-E_6DV9HugAkNQ>
    <xmx:9BOqZgeNK9jtY9jdr4vG5HcA-qvBdRU4tXpFavgGAZOvsE4kMrv0Sg>
    <xmx:9BOqZk3ymcAsJ6FTUJCFi--hKGCMQAUD7i7jFLMetDdUzuCnDhd2qQ>
    <xmx:9BOqZk_q1ujNA4VKjG_3rOYqKInfRFkIixlyZrOx3eG93PltBPRDKQ>
    <xmx:9BOqZv7Tl8KTZZvodY-F-kX34TSzb1069jZyJ19fUjkQzbPgEh5ah0RY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 06:37:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7c4e4abe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 10:36:08 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:37:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] Improvements for Perforce tests
Message-ID: <cover.1722421911.git.ps@pks.im>
References: <cover.1721740612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="15FmN4+BtrI9z4xb"
Content-Disposition: inline
In-Reply-To: <cover.1721740612.git.ps@pks.im>


--15FmN4+BtrI9z4xb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that improves Perforce
tests a bit. As with the first version, the main intent is to mark all
tests as leak free. The other two patches polish the Perforce tests such
that they work on my machine, which has a more recent version of
Perforce than what we have been testing with in CI.

As discussed, despite these patches I consider Perforce to be basically
unmaintained, and my patches do not change that. But given that I don't
think we can rip out git-p4(1) just so without any kind of announcement
up front, I still think that these patches are worth it to help my own
cause, namely plugging all memory leaks hit by tests in Git.

Changes compared to v1:

  - Fix some typos.

  - Add in-code comments explaining what the compatibility case
    statements are about.

Thanks!

Patrick

Patrick Steinhardt (3):
  t98xx: fix Perforce tests with p4d r23 and newer
  ci: update Perforce version to r23.2
  t98xx: mark Perforce tests as memory-leak free

 ci/install-dependencies.sh                  |  2 +-
 t/t9800-git-p4-basic.sh                     | 17 +++++++++++++--
 t/t9801-git-p4-branch.sh                    |  1 +
 t/t9802-git-p4-filetype.sh                  | 19 ++++++++++++++---
 t/t9803-git-p4-shell-metachars.sh           |  1 +
 t/t9804-git-p4-label.sh                     |  1 +
 t/t9805-git-p4-skip-submit-edit.sh          |  1 +
 t/t9806-git-p4-options.sh                   |  1 +
 t/t9808-git-p4-chdir.sh                     |  1 +
 t/t9809-git-p4-client-view.sh               |  1 +
 t/t9810-git-p4-rcs.sh                       |  1 +
 t/t9811-git-p4-label-import.sh              |  1 +
 t/t9812-git-p4-wildcards.sh                 |  1 +
 t/t9813-git-p4-preserve-users.sh            |  1 +
 t/t9814-git-p4-rename.sh                    |  1 +
 t/t9815-git-p4-submit-fail.sh               |  1 +
 t/t9816-git-p4-locked.sh                    |  1 +
 t/t9817-git-p4-exclude.sh                   |  1 +
 t/t9818-git-p4-block.sh                     |  1 +
 t/t9819-git-p4-case-folding.sh              |  1 +
 t/t9820-git-p4-editor-handling.sh           |  1 +
 t/t9821-git-p4-path-variations.sh           |  1 +
 t/t9822-git-p4-path-encoding.sh             |  1 +
 t/t9823-git-p4-mock-lfs.sh                  |  1 +
 t/t9825-git-p4-handle-utf16-without-bom.sh  | 23 ++++++++++++++++++---
 t/t9826-git-p4-keep-empty-commits.sh        |  1 +
 t/t9827-git-p4-change-filetype.sh           |  1 +
 t/t9828-git-p4-map-user.sh                  |  1 +
 t/t9829-git-p4-jobs.sh                      |  1 +
 t/t9830-git-p4-symlink-dir.sh               |  1 +
 t/t9831-git-p4-triggers.sh                  |  1 +
 t/t9832-unshelve.sh                         |  1 +
 t/t9833-errors.sh                           |  1 +
 t/t9834-git-p4-file-dir-bug.sh              |  1 +
 t/t9835-git-p4-metadata-encoding-python2.sh |  1 +
 t/t9836-git-p4-metadata-encoding-python3.sh |  1 +
 36 files changed, 84 insertions(+), 9 deletions(-)

Range-diff against v1:
1:  f40f62f257 ! 1:  7f06de7e6b t98xx: fix Perforce tests with p4d r23 and =
newer
    @@ Commit message
         Naturally, modifying the depot on disk directly is quite intimate =
with
         the tool and thus prone to breakage when Perforce updates the way =
that
         data is stored. And indeed, those tests are broken nowadays with r=
23 of
    -    Perforce. While a file revision was previously stored as plain file
    +    Perforce. While a file revision was previously stored as a plain f=
ile
         "depot/file,v", it is now stored in a directory "depot/file,d" with
         compression.
    =20
    @@ t/t9800-git-p4-basic.sh: test_expect_success 'exit when p4 fails to =
produce mars
      test_expect_success 'exit gracefully for p4 server errors' '
     -	test_when_finished "mv \"$db\"/depot/file1,v,hidden \"$db\"/depot/fi=
le1,v" &&
     -	mv "$db"/depot/file1,v "$db"/depot/file1,v,hidden &&
    ++	# Note that newer Perforce versions started to store files
    ++	# compressed in directories. The case statement handles both
    ++	# old and new layout.
     +	case "$(echo "$db"/depot/file1*)" in
     +	*,v)
     +		test_when_finished "mv \"$db\"/depot/file1,v,hidden \"$db\"/depot/f=
ile1,v" &&
    @@ t/t9800-git-p4-basic.sh: test_expect_success 'exit when p4 fails to =
produce mars
    =20
      ## t/t9802-git-p4-filetype.sh ##
     @@ t/t9802-git-p4-filetype.sh: test_expect_success SYMLINKS 'empty sym=
link target' '
    + 		#     text
      		#     @@
      		#
    ++		# Note that newer Perforce versions started to store files
    ++		# compressed in directories. The case statement handles both
    ++		# old and new layout.
      		cd "$db/depot" &&
     -		sed "/@target1/{; s/target1/@/; n; d; }" \
     -		    empty-symlink,v >empty-symlink,v.tmp &&
    @@ t/t9825-git-p4-handle-utf16-without-bom.sh: test_expect_success 'ini=
t depot with
     -		sed -e "\$d" depot/file1,v >depot/file1,v.new &&
     -		mv depot/file1,v.new depot/file1,v &&
     -		printf "@$UTF16@" >>depot/file1,v &&
    ++		#
    ++		# Note that newer Perforce versions started to store files
    ++		# compressed in directories. The case statement handles both
    ++		# old and new layout.
     +		case "$(echo depot/file1*)" in
     +		depot/file1,v)
     +			sed -e "\$d" depot/file1,v >depot/file1,v.new &&
2:  ee5d836b77 ! 2:  f41473d991 ci: update Perforce version to r23.2
    @@ Commit message
         Update our Perforce version from r21.2 to r23.2. Note that the upd=
ated
         version is not the newest version. Instead, it is the last version=
 where
         the way that Perforce is being distributed remains the same as in =
r21.2.
    -    Newer releases stopped distributing p4 and p4d executablesas well =
as the
    -    macOS archives directly and would thus require more work.
    +    Newer releases stopped distributing p4 and p4d executables as well=
 as
    +    the macOS archives directly and would thus require more work.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
3:  d0a80ba403 =3D 3:  bf03405db9 t98xx: mark Perforce tests as memory-leak=
 free

base-commit: d19b6cd2dd72dc811f19df4b32c7ed223256c3ee
--=20
2.46.0.dirty


--15FmN4+BtrI9z4xb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqE+4ACgkQVbJhu7ck
PpSdHw/+PCjbHVs/w4uKjr6MN7tsASVZnrXh55/jCelvbaYvQN7iy7aI8jgx8adI
CGUzbrICtVVrH+vAQVJ5OStDCxxX8vjqZ7GGG5wf6IT8hoMMKShpD5PdXHlLSS0D
A+q74nAZGs0IlJicU1mqOMnUN6C6KWYc6EGWBm+QNtgoVCLGboHvNS0pYVZmlz+j
k1uFC/3UjU6ojnWRGrxvsXj41xoQ5VNqgjnwAH9MC4Moz4Aw1mpO8Yb0umxqFn+X
3iE3HOQLh9vwDoP94s+FCvkSG8dNJol6bXFwCqLLn/S5SfIU5CRQYjpSp+4GJIGy
NLJhz4n4JjoTDYzlWP+bCZtTiPvnRdcP9GmQeODXH9zWNJKugHVhe2hZL1u4lvPu
Cr+KgeGR3R1yoVv0gLK5/h7c1xxDkHxtK9WePpd8B4gzZT7rChmHmtbK1ND8jTTy
exAEQeUM3FMIAULj5UzX6S7BIhMZ95kZIFDpBuxhWwGp6nJALjj4mjC7bz+FhSro
YCA9FIlmbnYKDii1Jvj4PSbjUOqt8C4MUiA1gMU2ICWkn4TY1NqgNrw3XCR2fCDN
UZZvlXyKymbKJv7J0k1cxw1TTNIJVw9rmoi5FFm1dHmoX5b1yFwQ4VVRBYcYoXB9
d/HD5m7DjGCjtSLI4DSllcg4Tu2b3+GyAa7wQ9PRBzETuQjpVDo=
=J1/g
-----END PGP SIGNATURE-----

--15FmN4+BtrI9z4xb--
