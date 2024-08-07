Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D211E6733
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034644; cv=none; b=OhE3NXrxiOV0Z0ILeBzwTOcTFS7PY0u8CsLW9aKgfSUn9LyG7UonkOm9TdHZ+ko/mgaeApREVzuVzzXsn6TZJuEQmsWHkE3Rc3JK61PtLgse2HdlqyPD5kNg+FZEO8KspgjBCLIuXOwHc1wgaChJdAudVFSZCCKuosUc08NxfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034644; c=relaxed/simple;
	bh=quIH67V2kLMxx/cRqh/5P7CROVHKf4oYvsqDtc0iVqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePwdAzI/KhtYCt3Hf3gjBmZbkP323RDi7Q7Aiz3FtFZi++omAs2UKVejvAbLM7H7wVtBcSdm4eJULiYUoCb7GoBSsioKwJW3yEUvXrvW1mGc/3ogUtrnQoSTLHqIex/fgGokiqIcbKLOzBqnuYAHH2zS1oNEKNpgKlnRBl9lqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bpvzBM4v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kzmkh/rC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bpvzBM4v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kzmkh/rC"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 07ED011509B2;
	Wed,  7 Aug 2024 08:44:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 08:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723034642; x=1723121042; bh=vaMQfGSUuy
	2czQjfk6+UAcxU12brGGmWkqv1dWJ9IVw=; b=bpvzBM4vvoG0Bn7NlUQHOIyS13
	uv9FZcdr/nriYscmcOFWeQ9kYKa5C96tP0Pghlxa7a0dQKr22/+LSGSFfg0oPSwq
	9OLy6xBrX4v76GBj8w/ZzvR6SOrsNXKA+WneP5kdOUrkTr0C3EusDSWrds/2Mrt0
	EYtG8j4RQjz6UVaGO6kMtSWLR5679bx2ztkiu5DiwzwNqRziuc4fOpQtEbexkKtQ
	kys2DwZm1tBql18Gvq0dS44c8xu5Vm3We0AA+VbjuI+B2EAdfJFu9HvFXsp+KaVJ
	MqElmjOp2rEgbAysOC7EtxMU+bTEd6IhUVnfgouK6+SuN5heE9kVQBUWgi2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723034642; x=1723121042; bh=vaMQfGSUuy2czQjfk6+UAcxU12br
	GGmWkqv1dWJ9IVw=; b=Kzmkh/rCv9dIURD0QGJblv6afdV/ULZHeHTHEtA5Ghx8
	gCYHFillxoP1EkB2mzN02QF68SpdQJwnYXmIXGNqdxUx3KAluVyFqNHotuVwIt46
	SRqvSMKZw8UDbzXNq4pMMGGBbQsr8iiCxQPANJcuRK+w10PINQ6gxpqM0owDUFtF
	XcDEZO4eGiB3xWFD7eKKUuih3NDWxj8vH1zJIKGUABlX9dgkLBwiiX7zJxiPFIS4
	ayR521+0FtfI+BfdBHnyj7o1uWcO062sCAhFYNXNUEGk9WhRo058a1VKYqKLgskh
	N2tzW3WHwLvB8Zx04A/9RSOGjV/qdn1LoChOx0ioLQ==
X-ME-Sender: <xms:EWyzZvNqpt7pmIxQT74eSky6aDPOgLhi7nqecDlFcEQORXwk0Bo_aw>
    <xme:EWyzZp_36-qvwuG88CyASwaqEH1JfBqYWyBiXmXBw3LxccXLa8APkHMawa1HrHkpv
    7M7MMkxuZjmonXc5Q>
X-ME-Received: <xmr:EWyzZuSg5SYrQmF2m6CONuQ-PefooFRiCOwBOu9u4glk01ejTqDa5ur_UsP2O0LtxEfixy3VHBQqPKKCtJ1W_fn_I7A98U4lGlh4V25gcyvsQ0Au>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:EWyzZjvFZS0GrrL-x3Ua00BFBLkcoXLYRly-fzaLhUl3BX6CHmjKHg>
    <xmx:EWyzZnfAL_zX_cOf6Sauyf1sjiwG2jWv2B2L4y_VYK7n5F2BcAG1Jw>
    <xmx:EWyzZv142mf-VbajNqKAN9rC29iA6G-NQpG2VlrA00b8PuJo1RP2bw>
    <xmx:EWyzZj9jkuJj20TnVebULIDloVpwDOBneNNZ3XRNPsY-vK0bmS2giA>
    <xmx:EWyzZj4hiJlsqKeGzUwE2qfCInEagJUzjKCwwYm4MlEIyChumMYh_z0y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 08:44:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6746a51d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 12:43:55 +0000 (UTC)
Date: Wed, 7 Aug 2024 14:43:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>
Subject: [PATCH 3/6] refs: fix ref storage format for submodule ref stores
Message-ID: <aaff9134ed849bcad08382168424d4aa92b153c8.1723032100.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723032100.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hT9PCcCZIIlUU6Za"
Content-Disposition: inline
In-Reply-To: <cover.1723032100.git.ps@pks.im>


--hT9PCcCZIIlUU6Za
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When opening a submodule ref storage we accidentally use the ref storage
format of the owning repository, not of the submodule repository. As
submodules may have a different storage format than their parent repo
this can lead to bugs when trying to access the submodule ref storage
=66rom the parent repository.

One such bug was reported when performing a recursive pull with mixed
ref stores, which fails with:

    $ git pull --recursive
    fatal: Unable to find current revision in submodule path 'path/to/sub'

Fix the bug by using the submodule repository's ref storage format
instead.

Note that only the second added test fails without this fix. The other
one is included regardless as it exercises other parts where we might
end up accessing submodule ref stores.

Reported-by: Jeppe =C3=98land <joland@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                                 |  2 +-
 t/t7424-submodule-mixed-ref-formats.sh | 57 +++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 915aeb4d1d..e4b1f4f8b1 100644
--- a/refs.c
+++ b/refs.c
@@ -2011,7 +2011,7 @@ struct ref_store *repo_get_submodule_ref_store(struct=
 repository *repo,
 		free(subrepo);
 		goto done;
 	}
-	refs =3D ref_store_init(subrepo, the_repository->ref_storage_format,
+	refs =3D ref_store_init(subrepo, subrepo->ref_storage_format,
 			      submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&repo->submodule_ref_stores, "submodule",
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mix=
ed-ref-formats.sh
index 4e4991d04c..998a5d82e9 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -18,7 +18,10 @@ do
 	fi
=20
 test_expect_success 'setup' '
-	git config set --global protocol.file.allow always
+	git config set --global protocol.file.allow always &&
+	# Some tests migrate the ref storage format, which does not work with
+	# reflogs at the time of writing these tests.
+	git config set --global core.logAllRefUpdates false
 '
=20
 test_expect_success 'recursive clone propagates ref storage format' '
@@ -59,6 +62,58 @@ test_expect_success 'clone submodules with different ref=
 storage format' '
 	test_ref_format downstream/submodule "$OTHER_FORMAT"
 '
=20
+test_expect_success 'status with mixed submodule ref storages' '
+	test_when_finished "rm -rf submodule main" &&
+
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init main &&
+	git -C main submodule add "file://$(pwd)/submodule" &&
+	git -C main commit -m "add submodule" &&
+	git -C main/submodule refs migrate --ref-format=3D$OTHER_FORMAT &&
+
+	# The main repository should use the default ref format now, whereas
+	# the submodule should use the other format.
+	test_ref_format main "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format main/submodule "$OTHER_FORMAT" &&
+
+	cat >expect <<-EOF &&
+	 $(git -C main/submodule rev-parse HEAD) submodule (submodule-initial)
+	EOF
+	git -C main submodule status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'recursive pull with mixed formats' '
+	test_when_finished "rm -rf submodule upstream downstream" &&
+
+	# Set up the initial structure with an upstream repository that has a
+	# submodule, as well as a downstream clone of the upstream repository.
+	git init submodule &&
+	test_commit -C submodule submodule-initial &&
+	git init upstream &&
+	git -C upstream submodule add "file://$(pwd)/submodule" &&
+	git -C upstream commit -m "upstream submodule" &&
+
+	# Clone the upstream repository such that the main repo and its
+	# submodules have different formats.
+	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
+	git -C downstream submodule update --init --ref-format=3D$OTHER_FORMAT &&
+	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format downstream/submodule "$OTHER_FORMAT" &&
+
+	# Update the upstream submodule as well as the owning repository such
+	# that we can do a recursive pull.
+	test_commit -C submodule submodule-update &&
+	git -C upstream/submodule pull &&
+	git -C upstream commit -am "update the submodule" &&
+
+	git -C downstream pull --recurse-submodules &&
+	git -C upstream/submodule rev-parse HEAD >expect &&
+	git -C downstream/submodule rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
 done
=20
 test_done
--=20
2.46.0.dirty


--hT9PCcCZIIlUU6Za
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazbA0ACgkQVbJhu7ck
PpSsVxAAq2HoliAL76gwkSrGgeLdVq03WHDktssanQyJETZHVRbVGhdNJ+jbFRaC
8tTCxemtSTTQQOAVVR4FlhI31GcqwrP61Kmhld/SuPqHRVpzq4Xmi5j2E/Wd/kDI
u5ihew1PESm/lQwZ9ASy5aR+2JrN0EQYgdgW5cw+b7pdKNO0KEFdQQOLo6hN7lLv
iZ8WDCyogHBm03CUJaaBD0qy0Yd3IhEPS/dbzkODq5LdOvtNCO6sVjnD8/JAwpie
Emoy6KCNe0YwdvjPuSEPMzeCFs9K5UiQAc56fcZvpi7xgXlWZHcFDusvcQXiqe+b
WijZ6iM+k977HsJ979Hc3HLw4RjxJ3oCukGwGlcNE8jr8ImBCN8ip99jT7/gR/sy
m5FxJLTDlZ9YhUhjjozNS4etFjjqjMND2B2EbGEQxCQQdMZUxv3pMTCYpDV9J2iC
Nn18TaHPaOWqAb032+oej5kCU9fF+wyuZUinZdoXiEHiDA//SWUHUL6Zl2iFP/tS
GQgg/nvsXapLhovopDjxumOF7N7OQvWr4iDnQoxMc8jDktIL47hvmyvsv4P8shcr
CMsdsQWGulgEVhLj1gbR9oAX0tUZTGY1MnS535Tzz/09ehj3mM0a7QLRsuYjTTtj
z1l7/eucPqAsZpTHYLZ1l9QZqdhNtD7/5Ld7BUUd+kf/CkMKrnE=
=WzCp
-----END PGP SIGNATURE-----

--hT9PCcCZIIlUU6Za--
