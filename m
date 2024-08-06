Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123B1BF329
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934782; cv=none; b=Bgkr3mZ5CbUP+tGusEDXZB+ApmUeXbuvB2iU/lXX8dxUV8XEvO1ZZn/7OmzqrkvV+XAEuSBwkJWeF4MDGnjdBAcS0wugNCyYQ46dD3LXJcTeLvucqOkJkKESJtf/uGmRcHnhspYh0YqN2R3q85IiW5JsTV+jYKBbcxyEV5MzuR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934782; c=relaxed/simple;
	bh=naIFcnC3+pjdnXxowjpdQ2CDohadq0vhycJQxO5EnAk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFuGWaXS+1vPzgbbARXqQWNgejyWCKFZTPsPsnC3VwFi6vvDy6OlwtOBBHsLKE/sIEYpUw58tYwfgaUOlr93XsmX6Pf4MSBVjrF2pZw38QNjX7sAZ94LGRhps0l6c/pMIo2tPGxfRueQ8IMBqJqDL8i0Fj5nTcDeHiSgdgsTMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QlAaE5Df; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBOCTjFS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QlAaE5Df";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBOCTjFS"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 41DF9138FC93
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 04:59:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 06 Aug 2024 04:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934780; x=1723021180; bh=GLYSI9/9kn
	NsdzTwXIoh00+VYFUlWuDRBUhHDuCRvbg=; b=QlAaE5DfKsp90yWrx/4PnJGYeY
	gzoM+eCqFKLcQKy3BfhyhIzakVrk96B46Y29+aSSIE1rX3Kx6/tzz2opnGPqHkeG
	blHit2PlLZcR9GtZEzDFS38XhzO3NZZ7KN+TjujJAnZZRF3DIXPql2Gm8AisVI/N
	p4a/QUeUSeqtZLia4DEm6RSDFpjJwfly/4SHzmEB2Nff5eAXJt/XrTutLPZSsKvI
	eSFKlGNEyYboAVPqILYGEH/ZHT6NARjdByHc0LHE2ja1CK+uETUVvyMnMoCHUUdu
	lDC5tWYCohbO3oMkuqFv0GOs/cs52iXiuYyB/9fTUzXqIzpIi+85eWs6IIEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934780; x=1723021180; bh=GLYSI9/9knNsdzTwXIoh00+VYFUl
	WuDRBUhHDuCRvbg=; b=jBOCTjFS3/1SfrpwmbAgY9Vizv0/gu41ZpTceBOZY6rE
	6Pk+KwZC4ftkQrEOrEVuH8MqMhRJ8cIUo0uhBtChpHbmHS1fYZ3jC9GssHndGAu5
	sGsMo0O+RmYnI6xYisWx6F3Sip7ry+G2FXNVnFOrcN0bj3L0XMAq/Lt9WzLxmt6p
	Dqm80yjODT+OUV3rQhp1RwTrR5pqxp+alih5MpLbNlqjqp/Rjd1rJPHjx0jO0Yy3
	s1w+uqgLVhZs6z2uZSQJMDwmyx74Rer/ZKrCMA9adBf078xHxfbcn3x6NH6Noopx
	xfDTasA6KtE0Sy+1GOoDsdbxUw1v2aP7nNv7lqm/yQ==
X-ME-Sender: <xms:_OWxZhkaYvt1LpJ8bR_Lgr6sNbalWh0l60o_h3qQ3ABaVvlFeIc98A>
    <xme:_OWxZs2uOTGAjmQub4-k2yDEGGhUFgkR_Fj4SPwTisIyHbNUkKm3lUlx4VqBCFQf3
    8HCTarniK7ejQHA4w>
X-ME-Received: <xmr:_OWxZnrz96rzEj7EIuD8jq4V_rU0enRO4JbB5HWBKqs5QDlDGY6rASrFXXSFNwQBQIYikap6rRwfwHZSVloxFCzi42RZDu09ZF5EeRQyYGJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:_OWxZhmzrRWsxaa1WwFF8F3bfr15w0eK9Dp2s69L2HT91DpYRXoMfQ>
    <xmx:_OWxZv17LU9zkVOrH1oqFHJOnPwj71Lu_0AQ2V10A1EUX16E6oBLZQ>
    <xmx:_OWxZgu15ccJliT2BwxCF1ahi_6fm203bW07cySSbqhKb8IsieKEjA>
    <xmx:_OWxZjWJN2B-xZ37hz2GX3K9A36VkD0Q81qITDACpp0k9SA0b8RhdA>
    <xmx:_OWxZo-olDJmOPZYLrUB2v8Il36sIPu092KCzWu3dEglm9jTmT66VhmT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 04:59:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d82ed45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 08:59:37 +0000 (UTC)
Date: Tue, 6 Aug 2024 10:59:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/22] remote: plug memory leak when aliasing URLs
Message-ID: <6e2fcd85c7032a8f6ee0969ee230f3e319872e09.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="joK2SKttrmJKe6Sx"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--joK2SKttrmJKe6Sx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When we have a `url.*.insteadOf` configuration, then we end up aliasing
URLs when populating remotes. One place where this happens is in
`alias_all_urls()`, where we loop through all remotes and then alias
each of their URLs. The actual aliasing logic is then contained in
`alias_url()`, which returns an allocated string that contains the new
URL. This URL replaces the old URL that we have in the strvec that
contanis all remote URLs.

We replace the remote URLs via `strvec_replace()`, which does not hand
over ownership of the new string to the vector. Still, we didn't free
the aliased URL and thus have a memory leak here. Fix it by freeing the
aliased string.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c                 | 2 ++
 t/t0210-trace2-normal.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index f43cf5e7a4..3b898edd23 100644
--- a/remote.c
+++ b/remote.c
@@ -499,6 +499,7 @@ static void alias_all_urls(struct remote_state *remote_=
state)
 			if (alias)
 				strvec_replace(&remote_state->remotes[i]->pushurl,
 					       j, alias);
+			free(alias);
 		}
 		add_pushurl_aliases =3D remote_state->remotes[i]->pushurl.nr =3D=3D 0;
 		for (j =3D 0; j < remote_state->remotes[i]->url.nr; j++) {
@@ -512,6 +513,7 @@ static void alias_all_urls(struct remote_state *remote_=
state)
 			if (alias)
 				strvec_replace(&remote_state->remotes[i]->url,
 					       j, alias);
+			free(alias);
 		}
 	}
 }
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index c312657a12..b9adc94aab 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -2,7 +2,7 @@
=20
 test_description=3D'test trace2 facility (normal target)'
=20
-TEST_PASSES_SANITIZE_LEAK=3Dfalse
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Turn off any inherited trace2 settings for this test.
--=20
2.46.0.dirty


--joK2SKttrmJKe6Sx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5fgACgkQVbJhu7ck
PpQGkxAAq/lfr4Hixn6YW7TrravVIr3IPoLtcDoYMMEAkM+mXnnzSkeMsEbZ9ejb
74NjQxxHZKEoVmJRmOle1GSCGtOXquYwywhIpENxOOTSg5m+e9a9+x2LuZuJi8r2
HpPj7piYraOZYDuYOh0XVgLBEMuzv+XLKJBfe8jiaB0rjofq49eEsehfQTx9fhW0
G1sX0orSYLTmppabcuA0Wer+T8w5aClaVVXjm1ynbEAUSaQ8XeGNjP868f8kqjIV
DHoKwsY6B1/5/YX2lWz9NvLSJNx5gD4RNt2XbydlkRj36c5mWXleVvE0tgncWBGW
WOlmB0dsQkocGQo0z5uNqtYtHio/MFuwFrxcsk/Ak5Pz8pIJPnGqwfX++inLlpyv
9r0fTw1DX5vVDX7BVJdMikr8ZfaiaM6UmGVi/LKAJMIr5YnU918xrtcFkFN7YDVD
9D37bJtUoggXtVABXUpYJVcnO4ouHXR4SmlHaFMOA1zAlsZ+Na5qNtmmbSvMWlfR
Ghv6NHBwQ2BwuVtivf/BjUlsnsYdVQqJlpmWDZ92z2FLB1m0c2FVj7KnHbqlV9PM
ERg9os5HPRIIJ6HqT7tT4Utop4cYehJ7pWhMBUXQ4txTLl+BvRgHUmh/9daud230
izdf4WGZxL0AJ7ZP/ktQW/cuFwyjS7hWmUDW+dfjneLtevsEuy8=
=ByGk
-----END PGP SIGNATURE-----

--joK2SKttrmJKe6Sx--
