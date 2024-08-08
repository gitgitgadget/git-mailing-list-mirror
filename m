Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2028188CB8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102548; cv=none; b=Yg27qxjHEuiX4HbwpKVERO7ZPHw4xDzxSxlnGb/JlHn8/kVYTc2JYPv2TbaLt6gRPCtoYvUnT8NtlvGsEc3ZUjnvzwIMg+Gk78Xk1rx6UOf/l91SsqXA68LSjkbuc+1R6k9gqkl41ee21XDRmjOHAW4m2HMIflMs/OtzfGcNAek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102548; c=relaxed/simple;
	bh=rC3LhTJTmHX8qHAt3yx7I6mADhSYGOKRR71UscxdRC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sktQhp2Zbsc/dJdH8Tk+ScbscbUrpTBqiObqUyzuo+PrAvwtlK58u/aA1cTTdKGStXc+yIitRY/RLtAe4TG1W++3mwJu6MHi4Vy3Q3K6XBr1GhTKTvInBvtjzwhbK1LI+j7XQjRHlZTa52nB1iZ11HThw6dLfaMGwYF00ok7Gmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JCSKnUUR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n5tCBR8F; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JCSKnUUR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n5tCBR8F"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 12C9B138FD86;
	Thu,  8 Aug 2024 03:35:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 08 Aug 2024 03:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723102546; x=1723188946; bh=R7v3Vm+YWm
	xNLP0sku5H6xKucmhttEmV4oF6cpxssfI=; b=JCSKnUURcnM2nYdhoYc8YYtJSJ
	rTaXpWSYpJ/jPLExnIwWDtP6f/o8RAxBPGexygwjTR2nnS+Fh5ZjMwsBq/atox8s
	aYp5wvQrGqvT/WlnQTOvOU+U42h/bDrRIkPMYird4uYa+oWeaDrPW2i+Hl5BKzKr
	frIy0sZNAXIV4QIhXN7XDpaiqf6ghKYwkOL3yr/0m1abe3XVAXUAoImYUQzP4BW7
	iVnu6T+5d7U+/WuZt7DiXvA09LQ50Gu2O3yMX8QNdubJnF9YloDl/2NtkgTT14AY
	I5E+BlyLvxL5+zm34JHlf8ymQOW7L93jlmku7f0TXHNJJJ3hcBjy3gPnOPjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723102546; x=1723188946; bh=R7v3Vm+YWmxNLP0sku5H6xKucmht
	tEmV4oF6cpxssfI=; b=n5tCBR8FEVihQwPtMyR2E7UJ2UdmEfvEBxFFBu4uFzB5
	S/9q5oeSh0Pr0x6hTcI60h//cKzocXsG+pU3a7lsvis0B+diKsh2OCzv0a/TXAwu
	asAqrttutPvV1YRl8pBCj6Wfm37ozJ7LO5pwkHxgK5T+2Ajxy/CLu8MJ0Y7aB5G6
	3vZPs9DqDbKb+KnMtdq9+Y7d8sCsBnJ/vPk6BvSpMRukzqmM3eIlGOui5Z+iZ6gB
	hGiIvRjY964MmrJsjzbgb0G5dDPUiIcuxFgpUA6jp00B64graja2ORmcKnWjPccn
	lfqf2wo2ZGdBZFkFKzefsaMV9xIDlS/Epcm+gkMHFg==
X-ME-Sender: <xms:UXW0ZpO7BjF5Qu5Orx7mqr4QyxxKuVVqzk1P9oRrkd_e5Wq7bvBd4Q>
    <xme:UXW0Zr8L3pkkzm_upO4fiSgIX6aMJoB-SXp0oSlZgcwVizMlpfIG-ZJtms8tn_QCV
    Oa8Yjpny0zCJC7CSQ>
X-ME-Received: <xmr:UXW0ZoTyjG8LFmUpVOX8_nAbf_Uw4dM0Ni_0D0IBBQHoK-el24R16HxSBANkrjwsDjrBxQ4ISkar2yLnTLa8gv0dftivLWRdQReig_42lNFINh3O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveej
    jedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhholhgrnhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhh
    ihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:UXW0ZltGeW9rdpjZXHv_1IFbwhfpJGV56k3n9Yf4Nxdq9m3PRE6fgw>
    <xmx:UXW0Zhd7AG4KFApIjeyFOVb_ESV2_mxbGv1zMeNGg9mka2qtVFdbfw>
    <xmx:UXW0Zh2v5TBSka7yop_Zj20rtyHzl0Lwu93tkvlGlFxjshLoWOO_nA>
    <xmx:UXW0Zt8ueTRzUb3Xd9UwztgwuimWR3I-OaoXL-gLz8Xf3YI4LvJIUw>
    <xmx:UnW0Zo4a6KMQ4U0gF4BqM9sBU6uKu3LbgGTKoAFf_ynXzoFCHFQ6YniB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:35:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a21b1fa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:35:37 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:35:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/8] refs: fix ref storage format for submodule ref stores
Message-ID: <f13356581ef984fa986f704343c895c4a57a0e4b.1723102259.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723102259.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jm+RumnNHjkeeaWi"
Content-Disposition: inline
In-Reply-To: <cover.1723102259.git.ps@pks.im>


--jm+RumnNHjkeeaWi
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

The same issue occurs when adding a repository contained in the working
tree with a different ref storage format via `git submodule add`.

Fix the bug by using the submodule repository's ref storage format
instead and add some tests. Note that the test for `git submodule
status` was included as a precaution, only. The command worked alright
even without the bugfix.

Reported-by: Jeppe =C3=98land <joland@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                                 |  2 +-
 t/t7424-submodule-mixed-ref-formats.sh | 70 +++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 2 deletions(-)

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
index 4e4991d04c..d4e184970a 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -18,7 +18,23 @@ do
 	fi
=20
 test_expect_success 'setup' '
-	git config set --global protocol.file.allow always
+	git config set --global protocol.file.allow always &&
+	# Some tests migrate the ref storage format, which does not work with
+	# reflogs at the time of writing these tests.
+	git config set --global core.logAllRefUpdates false
+'
+
+test_expect_success 'add existing repository with different ref storage fo=
rmat' '
+	test_when_finished "rm -rf parent" &&
+
+	git init parent &&
+	(
+		cd parent &&
+		test_commit parent &&
+		git init --ref-format=3D$OTHER_FORMAT submodule &&
+		test_commit -C submodule submodule &&
+		git submodule add ./submodule
+	)
 '
=20
 test_expect_success 'recursive clone propagates ref storage format' '
@@ -59,6 +75,58 @@ test_expect_success 'clone submodules with different ref=
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
2.46.0.46.g406f326d27.dirty


--jm+RumnNHjkeeaWi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0dU0ACgkQVbJhu7ck
PpTIDhAAmov8hv26AEbVPecGsVv2w7peaWppPFMs56vCf1xuSA4EPlo3ZylJqiOx
/PirtLkAl1+buciOqkkS285gQA7PYfCQj8saM0aWvtIcT1CILeXFOl3AvNjjmXsi
3+rgYjdgsddVRSoG5T7ygE5OnGKqGERhgOnJGIQDebDhjYurCsdTvSEA4KQcNfF5
lDA2AqvZYFDJDM3BSInf+23Wy5ntQ2MWL/niKCxjJPbqdxZAWrTF4nHM+mKpmeFn
uXwSYvIZ0BbAra9dJzEH8uCBHHPgwJdTIylk/ofzLrV4RSsirKGcFMMwfT4RPlm7
6w9rXGLUG0EcCCDY2J7rTJJF6hg3uWiRfUThNHa0ke8RAJsKeecU3Rd2+qFbTH4x
9NrB8dT8NF1IokN7ZIcTxGE5TuHsJC8orQVZZgJkHcu/k3C3u9FHa/JV9SC85Mli
Xqa6dIP9s2nqdsGowXHBgdmt9uIrQgVJlNrUkzu50ErG0hq5bwyVCSGb97EUzU1C
a3hsL/Otm8OtYT4mrFntaT+osHiDFylKjldJNRmvkehsaiBbyhfDRRzpjy/Cksel
fky8VsBFONoK0WXn/8RV0iiqwqmgczQhrJVbG2BmgzC3/A3WnvvT/IzDvIwwdMS5
2ws1t273bpW43g82dTKoHhjJ7CcN2M4dmE899tA0TvMgQUDnkWA=
=Wiqj
-----END PGP SIGNATURE-----

--jm+RumnNHjkeeaWi--
