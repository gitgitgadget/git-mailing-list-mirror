Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4513AC8
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985552; cv=none; b=sJzErl24diIhfv0FLHRSksDIfkysS4U9T4ZeIby6ZYSxqgrWqU6WUHmntconfJuKz5x/H+UDeRRR1wf2gr0j8gQIp4tHdsBHqMTh9a2bC6XlwJbFKk61MITWyxCh0rk7oTHy9Cr6520Dr0u/5fd+Z4+x5UXZcdCU4XILTl/uzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985552; c=relaxed/simple;
	bh=W7uC73kaEkFfgIiGsN8jHkxxS+YI7WFWol16vsV3VZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzYrvqk0QZnTBYeC2tbkl7O1e2E+6SRfGQ/3reiFg2HO1rar3FRg4BgWqYmRhYII4SoX8r/iQqF+/x8XPKK+qYceUvX/4W0rm7nCBamYAVLBm+6PM8iO4G5w8O/iWClU7D/UcpeeX73Uxgr29+9Xj7x1cf/NNPOkZis6fp7Xl2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wh/0yJXn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r2GpxSC5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wh/0yJXn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r2GpxSC5"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B41A711400AB;
	Thu, 15 Feb 2024 03:25:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 15 Feb 2024 03:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707985549; x=1708071949; bh=UmXHXlcwqQ
	UUgpgQc6MKKXVjhXfguoiTT0++gZT32L0=; b=Wh/0yJXnRMQwqfNFkHc7MYDa/A
	5eUZo4N3tid7O8TGqvH4rWXvQPE32cnD/XeFwfdUi4kLtKzFii7YdvRSyamLZtzi
	FLO4U3lZjKQECF2lCNatCpIZS8giPSP/uo9visFNuksKmYkNBz9hJhCKQK3o4oPZ
	BldMICmR632r4xQtD/dGo+GLhUx0bBG2FGvSkAfgrFv8ywbsAyiCRTVOOat6ybxT
	wULCZrVSY9ZSoO6h9ks4YdyImOjcdfczym4lx6VPHLPy86Q4TxUaNCsBge/rFCf8
	SY9juPuELA6iy5KnaRHBU1QePpis93ZJXGI1fmPqheM3gk/Il8Z5kLS3bOGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707985549; x=1708071949; bh=UmXHXlcwqQUUgpgQc6MKKXVjhXfg
	uoiTT0++gZT32L0=; b=r2GpxSC5bRSHeG2M17D5SYjyNGeaO0VDccDU8kpRKnh0
	6eoN6qy4r9wjaVPPuVSuNDfGh0eJOdS9fSFOoAOtVJ5UGDQai/6xfK8C3w0kC17c
	abaCFrmZeRJEwmfHK2UdkioyxYuSWy9dhzCFCmS78lIlImBblr+3tcfP2nnOFjZc
	lmzb8ytbcA+vuqBJoKfs/GByR2y+EbZlUXdJH9pa+2VWgtz4PV9H3quvrTZ9dCXQ
	k871hQnYuz8UJnv7S9JbyNZFEfb7ox8OAdycOicMXayazI7ElXrq77Yaed5x1bWO
	cGxOr0XY6roumJq+xw7JyxwjpljhmvrzVfbkjiwuhg==
X-ME-Sender: <xms:jcrNZegN9DvMWJEgFtMvGlCCpBm5xf9zBtvkmBzYVPZVc9xOB1oJfg>
    <xme:jcrNZfB3PhWrCRDgyqQ90fP_5wjWFJ4sw_32lnZaH5UI-8Fv44KZDRO1epsDUtFAf
    Cb_8jb5fttxdnydnw>
X-ME-Received: <xmr:jcrNZWEJ-9OfG4JOzZQgJnU5J5kZ5DiuWIoshgL5a-py1AQxqNLiKD2S07I_rKdzkXWHydUQCbRNaTAjHctTxstNDing86zDt_-hlz53w0L0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:jcrNZXSQn9SdJl0U8c3dzoXWiYfCa1I7FhuXQ_JWV8z0Mo7tYtoZqw>
    <xmx:jcrNZbx97OIzm3OPfDxn0MUc1Zgb5l3EYfgsmSleICDYGNIQkvhhJQ>
    <xmx:jcrNZV4N34nMQjTpeLzHE8AniY3vsOXKZByfBwleDVR9Ews6BkjqqQ>
    <xmx:jcrNZb-ATIWxPMQd4MIABBNZTLJxF1Dzz58qH-Ru0txUBqjoPnqZoQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 03:25:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 127e216f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 08:21:56 +0000 (UTC)
Date: Thu, 15 Feb 2024 09:25:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/7] t1405: remove unneeded cleanup step
Message-ID: <67d6aede63bb1088d2d2eb86d4eb13b9ea702bda.1707985173.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
 <cover.1707985173.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2G6daeMzpiSRh56u"
Content-Disposition: inline
In-Reply-To: <cover.1707985173.git.ps@pks.im>


--2G6daeMzpiSRh56u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 5e00514745 (t1405: explictly delete reflogs for reftable, 2022-01-31)
we have added a test that explicitly deletes the reflog when not using
the "files" backend. This was required because back then, the "reftable"
backend didn't yet delete reflogs when deleting their corresponding
branches, and thus subsequent tests would fail because some unexpected
reflogs still exist.

The "reftable" backend was eventually changed though so that it behaves
the same as the "files" backend and deletes reflogs when deleting refs.
This was done to make the "reftable" backend behave like the "files"
backend as closely as possible so that it can act as a drop-in
replacement.

The cleanup-style test is thus not required anymore. Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1405-main-ref-store.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 976bd71efb..1183232a72 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -33,12 +33,6 @@ test_expect_success 'delete_refs(FOO, refs/tags/new-tag)=
' '
 	test_must_fail git rev-parse refs/tags/new-tag --
 '
=20
-# In reftable, we keep the reflogs around for deleted refs.
-test_expect_success !REFFILES 'delete-reflog(FOO, refs/tags/new-tag)' '
-	$RUN delete-reflog FOO &&
-	$RUN delete-reflog refs/tags/new-tag
-'
-
 test_expect_success 'rename_refs(main, new-main)' '
 	git rev-parse main >expected &&
 	$RUN rename-ref refs/heads/main refs/heads/new-main &&
--=20
2.44.0-rc0


--2G6daeMzpiSRh56u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNyooACgkQVbJhu7ck
PpTJPA/9FbvE/QAE9A6Z9dcu/uCbjhrUpxnyp2o2yQmSDFM9l+Pw0DvV1ohLGtgB
Ocuco4xlDf5ZLoDCZHRD5L+gPKR8TlXRIBZktizENHuJYn7Oai5+aOWFYRVOI9lP
IQ/HoBrn/085TKLwAEXp3QNLjPc6D4y6nvpbU2yXHed3Sold5JweENt6oknU6UyE
1WhjMoak8ZgWziWNBm848BZ8IwCXz6ZJnkjqiqhtN/P4Z5YpqlooWz1PjIDoJ1Md
rupdH0tMall91YrlB3rVj1C2cW7y8ygoVUX/a+Fq12mT6C5qZJ40RQMelC1mS18d
uU8lqrS9E4nncM6jxgvP0bGKRFOyPUOlqxVh0a2S98cVXl6Vv+R9KKo6Zawy983B
zT1yBkbUsqnFUnS1NdKx/I9ITP+qAwFvOgjJoB1+Dv/kCJzTTgTc7e//oQYZLYvh
TUTN79DScX45r1Zj0JcgwKKD8V2l2ksZIaNhghy2sYzBiTkRsdJoAkGp5SBFxkx6
mI6Xp4KFa65evJA0ZwHH5L4hL+MwArd+wVfmHhL7wS060dHy2nGIXYF30ad31jBk
wTv2k42DboLANJip0GpoUH9hFKq2wubw/MKKkiF2pIJRUkn64OfKfy2lVyTt/SDu
SYvYS9AjpTDgATwf1kzEBrwjEiw8QTPBs1tGOfJ46jsakt6TMsM=
=rLR3
-----END PGP SIGNATURE-----

--2G6daeMzpiSRh56u--
