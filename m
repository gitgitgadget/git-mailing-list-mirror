Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE11E6750
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034653; cv=none; b=aIy9pWWOcnP9+IObruLxQ+XO5qgad4pKgZod7ltOO9/e4t335FJAya0ckZ/qCHnY/3vmjN7JSnHzbjSJF9ZF+r2SBlNX/jOGUklppbYscLZ2tJ/Ir45gz69nLGNp3pZRAbzT1y9ADvzuexkx3/F7Gwcy1qD+J0ok8HC7+punvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034653; c=relaxed/simple;
	bh=KxW4ti2nPZcEaNsu6/c2RUARrE+YVdoWJcdCiTpg5D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXQu0cOzHQpfRRaIOoqZxDWQSwfnxIYS4rneZ7jrC6v9ZPBO/oC/LSE5mVfRZmWGqI39ELAsk62rhtLgUcYEIO7W8vOrVKkOmiJYOWXBEuLr6xYoo0nGY4LZesglsezcjMle0rZ+uYjzWFXhqHi2zd9AjJII4/hSZf3gT+Jtzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lHT/+AO7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AdD2IDVZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lHT/+AO7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AdD2IDVZ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 482FD1150011;
	Wed,  7 Aug 2024 08:44:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 08:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723034651; x=1723121051; bh=sYU492Gyhi
	OO4cnF+eKfH2mqIsWPdr3imyaNaMMgyHk=; b=lHT/+AO7zywg22taF21HGVZrr3
	5Z/xFSkgAQO3lTgGp6FcMxKdQG0n/IVyGd02RM85Gm6VDzQlxdvKB8fS/BVfq4es
	TxOmDB8lR+Du1aTD39lWEDbYnFAuH9Y0ux6h3/4CI3k/SpjhWgFRrkNrkhiryP/A
	CoqaZ3dnBUz6di4++x9wHniqTU1h6WMttAMTGJQ5UD+KVQJFiJ8m4nC5laT1NEPv
	9cuEJZwbmBN/1m58Pk6ehfCuW3ZnqOr348p90CJlyeB+QwRck+EB6iy7bHgmXSCm
	nbxG6bmEhAnfYPtisZ2ZrHiiCSev1rvHzdrJZDetvMbo7uMuv+HBzY7fx7+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723034651; x=1723121051; bh=sYU492GyhiOO4cnF+eKfH2mqIsWP
	dr3imyaNaMMgyHk=; b=AdD2IDVZjw6sA7zoLqyxzCuzpcsyUdqIs63Z2X/Ywuds
	F4z4q6LR9YoZqO9q1DdIw4bHHmeZI051k2rdCGHfWHXyJhuNC8ucyP8jlCskumX/
	rw4AW/+ahS4ylhp+RKGOIvlZrxAbDap3PSsjJmfQJh5VW9l8R6GRt2fSVq+9Zhz3
	D+9v2Iz1Br8VndPJKrKnvG91ald7IXEWhif7ChSwfoHrfFPDiyDzn0dq3Bfxb5ET
	uIK6dZT5/lix565FVP0NDbyIsmSpytfy1EWFBz1d5mxxiYHoDlPDonw4RM76evTF
	NugfQ1f4AqpXtlnNqZdkXL0EPgODhr2ZjsbgpOtHnw==
X-ME-Sender: <xms:G2yzZhEiUgdfyOHKhPmpJwNMncZd52WXgC18SDdXXHzhbqnrfYPpkA>
    <xme:G2yzZmXjNVbW8Gkm9rAA_XCd6UnCef7_odT7zXkp_4_fcHskEp-0sG1BC2vLsxWo7
    ANlkp1tf1iCKXVbxw>
X-ME-Received: <xmr:G2yzZjLouk0KHcT2ENFyTqRoccIk_Q8DH07r5WydxlvP0m4LYbO_G-40vHyZjL8lcKo-dHFjt5dXiuZd1FWmN7pmD6Z1xP_jjKYQv0r7G98zqaL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:G2yzZnE1LbQr5u3KatyH_Zep_MQaS5VgwSYYPxBWC9PeKGsAE1CJxQ>
    <xmx:G2yzZnULs9NOLvQLFZTjQfRaJ9uBum4kMYICRi81MXC1IL-mxGXVsg>
    <xmx:G2yzZiObSYY0T7yRPJaya1RzmqpUxcYt7QaJLb7jiRxWJv6zd5z6pg>
    <xmx:G2yzZm0Rmh9FzhBuoL1VesXx6B19uxFxSvJHow5_FUk46FOvAnjY7w>
    <xmx:G2yzZiQijxWUcBZ2OoBAHNMBgVf_5CLdIRtZ9G2hklbQE6JFNWzDPTJf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 08:44:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c97814c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 12:44:04 +0000 (UTC)
Date: Wed, 7 Aug 2024 14:44:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>
Subject: [PATCH 5/6] submodule: fix leaking seen submodule names
Message-ID: <732142aaa6da70f7840eb0c4ae82ebba16f05c55.1723032100.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723032100.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8s24e6/YSp040l+X"
Content-Disposition: inline
In-Reply-To: <cover.1723032100.git.ps@pks.im>


--8s24e6/YSp040l+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We keep track of submodules we have already seen via a string map such
that we don't process the same submodule twice. We never free that map
though, causing a memory leak.

Fix this leak by clearing the map.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule.c                            | 1 +
 t/t5572-pull-submodule.sh              | 1 +
 t/t7418-submodule-sparse-gitmodules.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/submodule.c b/submodule.c
index f027a6455e..13b8f8c19c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1880,6 +1880,7 @@ int fetch_submodules(struct repository *r,
 	strvec_clear(&spf.args);
 out:
 	free_submodules_data(&spf.changed_submodule_names);
+	string_list_clear(&spf.seen_submodule_names, 0);
 	return spf.result;
 }
=20
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 51744521f7..916e58c166 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -5,6 +5,7 @@ test_description=3D'pull can handle submodules'
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=3D1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-spa=
rse-gitmodules.sh
index dde11ecce8..e1d9bf2ee3 100755
--- a/t/t7418-submodule-sparse-gitmodules.sh
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -15,6 +15,7 @@ also by committing .gitmodules and then just removing it =
=66rom the filesystem.
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=3D1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.dirty


--8s24e6/YSp040l+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazbBYACgkQVbJhu7ck
PpSs4Q/+KOGevRLqKiJTno2pJY/jjHUZ6KiGy2c9CMY6vReNHx5Q4nVObB3KVBWV
SRBV09r1wH+Y/BAIXjjSqsUQi8fcBbZzUpU0Fh29qI9KDGsLY9E8Us0gQhLaVzd9
VcNze6wFQUqIzoLxXClZRdqnRwnz8Q4LsTo7LGnE/Nm1Vu96BpZershappfU5zYw
ESvg7236HLlx+ln+sJpRukgOU62jSA4+RFCRa2TXGamI01BpPnpZ7zlSV0Iiq2zP
uQWBc0k6bTtL/17qnwMLiH+MwC52pfd15bSZFRW77vyni1s3MhoBGR1ui/lKXRl/
B9mwDjUr4lC9zR1BT9d3pptX8gmftiWdIhUVB3VDo951MyYVjsTCIpY/SSANhArP
KqwONyf6phc4hsVtDP6x02tqL/HH2CrxfWNQjJOucbU9adx4MdaLu/HfkCnX+E81
YAnyclGmzcjWK9U4fq6KyAFYt2UTDLpfimjEyyr5pJrj7jPF+HSSr28Rj7PAShrA
+MsPL42+AV6EpnPOagjaRmRj/MqBN6na/2He+S3icZITaXSQEXCKk07tJ5upnFHb
cyPv0c7CpOTQEk9e8e7+OYV93MXJerklywYbvxW3ItJXwvdApmVO9rs32Y1T3geo
WH9JZtJr1V6x3RzpsIe8SoNDuynWzkIzNFMFn5Hfs54jlnzdgJI=
=tGv8
-----END PGP SIGNATURE-----

--8s24e6/YSp040l+X--
