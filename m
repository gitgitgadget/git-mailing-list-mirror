Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45023BBE5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508804; cv=none; b=Af/xF3gejAv6PKD49FVdBh24w04aAOdrNG4S+fgmC/Ou6k0oHrESa8Z70XiW7ceTK+nRTHjlQUhipD5pYF9XNxYvtlGDATIRfYoxx+Prlm1oY8AQvgNpV8URsHTd+45Aq6j+ZQPhhm6CqUzB1tqKwa4cBo+QzUxdcSJToB5VmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508804; c=relaxed/simple;
	bh=G72smGaZUHuObuIhNDhO1yl2uIyC6Y9HCIFe8k35nWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LODguWH4J9sYaDvjtW33MBRCUk4wH8cmkOqXQWzesuuoZRVJeaPsQ12x4cFivxX1IMu1DkaUoPUdfdzf/XLe4+H6I+JQ69frtFtqFm+6cuwY7qiOQtNaZWO2PJtt6ejC6D7BmfzIVh56FdXfXLALy1B4tU9u2g6suyyjcBz5hFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mu/luFBQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SgV59hrs; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mu/luFBQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SgV59hrs"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E7CD4114ABBD;
	Thu,  1 Aug 2024 06:40:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Aug 2024 06:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508801; x=1722595201; bh=BRK9SOLZcD
	tB9zvOF0ZAW7kVjwCVH0Ky2niexwrmjWo=; b=mu/luFBQt8JPuywt9E/gidUv90
	KR6sDPu4/7dowipx8o4L1ytEPiB8d7E9/QFq1GLY8N6LMeN2K/A4Wp8DiYJet3hs
	mhfNsrFwk4msJeR9Dwg7E/NTwb5+27D3ZFax2Oov7KZ0hfSgW/Ea+fp7QkGH8H1u
	h8uIvr61/JnNuLwI1CghWJ38Tjf9bdgk6n288TsAE49HyUaHA4ltxvE8OZFrN+Md
	KIssaPN+azkJtaJaah2d52gK2Y1NVUAb9lPM6aNreuoAS2NAHH3kBXbC+YuH65UL
	2LkQmZIsiv5GahwSYqvEzTkqgCdcovbUXf5+kAC1B55v6oIvH9nlIVdKZ8vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508801; x=1722595201; bh=BRK9SOLZcDtB9zvOF0ZAW7kVjwCV
	H0Ky2niexwrmjWo=; b=SgV59hrsoqU8wqPuc3ZLunrZ50/VPFVotvXfvolYEvkm
	jSRetQG+Kwlv+/tKHyRHNz91kfQ3E3IXmcoNKsVzk1CLKvSM9YcLPofHJtPz3tmY
	j5fKk0Um8k1+k0P8shjIA/nUwPab38Cqox/3kMEPVuLcbPf7vQD+SxDtzU6y9HGr
	lCK+mdI8UC/aZC2YqUVeqKl4uaxswktalhBr6IhihQSTQtiNKi5o9dikz2bD10Ua
	NAWzLxp8DaOm86Fk9bbQEJCNDDu4UW4qEranWmBpeiOwts7eulC8+HK9QwNd7C4D
	XXlCtSq2soXkx656JZz0pO0ndOYJlIvDtan+a7nsRg==
X-ME-Sender: <xms:AWarZuoODnXGsXGc8grqFPqYwdnk0EGOY1t29RjwgcF92PSxgjY0xQ>
    <xme:AWarZsqxEGx1NuV0RLarLajPX2ZQHYx81EijmrReVmwaruGW4Q_iD-7_3xstXm4Ui
    nImlRxQi9yNfzpQuQ>
X-ME-Received: <xmr:AWarZjOHbwzhe6P0MibGKllrINhFP7ytqA9cPyXi1eoWZ6ZNQvoqUIxSv_5WS6KYij7ZRsPVt7tJHhSEo4L9vVONzbMVX1GJDpPH5VQff5N1MZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:AWarZt7O26BahlQN5rPFKmIF9a5FjH6sooDXi5kEC4bYpFRAPrhD5w>
    <xmx:AWarZt5MXm5NMVHVjw5aW4vrDVgUiz17i0YxL4iwl5Jg_mVpgGmwgA>
    <xmx:AWarZtjKxJhGxedQ-c_5xpaal_IDcDgNRS3FyRBP9rXqiTJlSICQ0A>
    <xmx:AWarZn7_xZt7JLOu5ij7E_zXPwJ4DrUwaAECI-eN8hwEJVoD2F86oA>
    <xmx:AWarZrRpTizW7oLKM2jEJ97Z3JOnH3O3Ik_6VMr2DtIlMUWrEf88kyaM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7ba4d2c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:38:28 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:39:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 08/24] builtin/submodule--helper: fix leaking buffer in
 `is_tip_reachable`
Message-ID: <49c156cebb12e387a49a763595f0846678883b7b.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xHM2MqiZht/TnOcP"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--xHM2MqiZht/TnOcP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `rev` buffer in `is_tip_reachable()` is being populated with the
output of git-rev-list(1) -- if either the command fails or the buffer
contains any data, then the input commit is not reachable.

The buffer isn't used for anything else, but neither do we free it,
causing a memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c | 9 +++++++--
 t/t7400-submodule-basic.sh  | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 863b01627c..673810d2c0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2268,6 +2268,7 @@ static int is_tip_reachable(const char *path, const s=
truct object_id *oid)
 	struct child_process cp =3D CHILD_PROCESS_INIT;
 	struct strbuf rev =3D STRBUF_INIT;
 	char *hex =3D oid_to_hex(oid);
+	int reachable;
=20
 	cp.git_cmd =3D 1;
 	cp.dir =3D path;
@@ -2277,9 +2278,12 @@ static int is_tip_reachable(const char *path, const =
struct object_id *oid)
 	prepare_submodule_repo_env(&cp.env);
=20
 	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
-		return 0;
+		reachable =3D 0;
+	else
+		reachable =3D 1;
=20
-	return 1;
+	strbuf_release(&rev);
+	return reachable;
 }
=20
 static int fetch_in_submodule(const char *module_path, int depth, int quie=
t,
@@ -3222,6 +3226,7 @@ static int add_submodule(const struct add_data *add_d=
ata)
 			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
 	}
 	ret =3D 0;
+
 cleanup:
 	string_list_clear(&reference, 1);
 	return ret;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 981488885f..098d8833b6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -12,6 +12,7 @@ subcommands of git submodule.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup - enable local submodules' '
--=20
2.46.0.dirty


--xHM2MqiZht/TnOcP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZfwACgkQVbJhu7ck
PpTwIw//ZER4fzodQwdP0zXbjJ0tn6b6eavKxHnVB6jUxrlxUvGn7I6wWwLRt6ez
ekR6GwnI1+iqLR+AcOq4Js50r8q0lfB1WOSeUtm6n/joF9l8zHf9QL+KdKbcCC0s
paijQjC6ENx9U0B1cxLkZQaQwgayjvccHKVvEdTdlfVX7doik5qCFkGNasuc5w7i
mub1iZMY2Q12VEziVLyOfB70fjBTv9z0wsdWBr2DewM2j3sdDfTfeAuod1MV8ROL
swJTXZSzjpffkMAj+58I2heVBf1pLJjOcNN2wsHv5CVkT5oKXZ8SokG5NDE1wxLM
SQE+eDC8KM8mM/MiNb4I+KcikGP5NOL4v8HUZDAgZsnw+FaoTq6N93SkfZZCkRyx
VISF91Ko6sblkHyWle9j+m3pj/2PzsqnUkw1/JnpYqh4+yLX28lBJrsOW9PS9Qa4
wwsH/H68yQlK9m3u7GBio8OrhHx6CsOV9701nEesbm+Jn+AzrQ0MRuIaU4jRU9rz
Akg++jhYfxTij8na81O/nJY9EtHjqxwZB1CvQD/O9FZImDwZqUCmrGugtPxJ/aG6
yuk2py5aJoz+6NGZKl1JQnwiR2OXXm4P/mbmYuwBCDb1PfoA/gS9NPBBmblyyZHC
TULmookpBy3s5XUKw/OT/E0sD3/9nL3TTfegEickzQc6eA7t4cY=
=+0GD
-----END PGP SIGNATURE-----

--xHM2MqiZht/TnOcP--
