Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76717F513
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073524; cv=none; b=Yh9kl2tDO0G++iqKSzW1l9dzVcxxbJuxBhmtA3Q/Kd68IzInX/490SBYCE6AuUoYCFwYfVs4irQfZLamiFe5s6EvlDeVbigflB3gCsyAZCAoV4PMR0xRnYswIimotHtZsEWgyYgqwlM7eCGV4oAXKNh0KbqmqntolG5zPlhIIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073524; c=relaxed/simple;
	bh=owzrmRtI4FAEbUWWuxRVTqbTMD82tVGPulTqWZofnqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTCgivW4YcqmGNRsdXFd349c8Knd/lB0tB/0EuE3hjBm/gr7e961plkGzdWCtPGra9QW8UQZg6+ytW942HiIaVYfCxIMkc6s6KSNZ70ompqKYWUnT/PgFvY+rsfK4//AMeGxN4S7u/cchcgi/DwW8EOYB/+leCw+E13u4/B8LsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DODim40J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZRvk1BE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DODim40J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZRvk1BE"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5DEA11140149;
	Thu, 30 May 2024 08:52:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 May 2024 08:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073522; x=1717159922; bh=fBU2+fZTfm
	IChu/dJedluYz1AQJhkVnk1Qff7bD/dWM=; b=DODim40JduEOmW2hVXXMs2wTXu
	KTZLDcTyjzuUXw2JX+ild1W+GBngIyrWhBHQ6jdZZs2nujQUdHalzs3eFgjQcImj
	TohzqxDM2FWmjl3M5x3heY7Tnp0K0yXaQc2n77nApKRJ733ERw7Vk7HZ3zdrAPXJ
	0FUsupwjzmq9ktz7dDIJRd50TIeFiw3reH2r62bI3TQgcYP5ps+b0BAWRclTNBJ7
	9uTPq8E6i3ovzzTY96STznBbrhCZ1RceJvzMTSxYfyDKWy2QNAw4E9ESxyvvltAY
	BZZUXTye05KPQV+1JU3dXxs91+yvWYWk4lQwfSYZXlXvXVykuMvqaEhS+maQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073522; x=1717159922; bh=fBU2+fZTfmIChu/dJedluYz1AQJh
	kVnk1Qff7bD/dWM=; b=mZRvk1BEHAL9hN/HAQTfBIcHGky4D0GDvkWBwWEhwmK1
	hoF5nOeKf+efxU8GFS9+Uo1iOC1PPXfdnfdk+81PjAuUt+ruY2BJO26cdJ+W+5/l
	UP9QBV/wNxDuVJH4u6NyN8ufK3ngL0LtR9OU6ir7eW7wWwWnJZqIe5TAM+0tGLBH
	nxOuP7HRT7Y5+hkFgGAwI886Yi0sj8AwZX7ESLa/+yIQRkxe/564QrV04Rp4iMye
	gBT3yEzYwNkqvwwyrjLltk21f7k65eH8L4W5CcKeh6tV745hdMqIKGiEjiouzbtR
	xpUtfPCh9m0gdug5yN+cX5yDSU2Z3YsFnydye1kepg==
X-ME-Sender: <xms:cnZYZuBJKU1PvB5Q9XmDiDroUU72ByzX769C3jL-o-R-AhudvneWXA>
    <xme:cnZYZojQaZW3iJkedJe9hesNxE1kA0DwRVna33GqK9RMssQropg3qXrPctGP1se-B
    7FNreDNF8jkKRirdQ>
X-ME-Received: <xmr:cnZYZhlSKNR2meC9sadLQvnUYPBALRqLPL9KA0uhll1_gW_H6_PcCjXAT-tOd7kdGSCAacAlNZZY7uqha0zfNbBJhOIqLfv6F1nInkCwr6K3TN-ggQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeeinecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:cnZYZszW3DB10N31whptV8Z6SHvDGRVAXUbFZe7xiX2CSZ0PGzWitA>
    <xmx:cnZYZjSBVl-AU4JvThzJ0FnbdSKT_o8mkxCcGLaR7czVr_gBzBBd2w>
    <xmx:cnZYZnZXwARqNHt9m-QymjudJ7NmP_OMJd2uMp02fhiocE0yrFFWFQ>
    <xmx:cnZYZsTS3jvNJn_4UFyM9njah85KMxHOkugMXS9c9rjja1toiNY1uw>
    <xmx:cnZYZtf10-ZKo6Z1bK9gxbWdElrrAJYaOf-jUDTIeN_tBVnPlbxncJB_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:52:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9101ec93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:51:44 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/19] builtin/merge: always store allocated strings in
 `pull_twohead`
Message-ID: <bf854b39794a9aa9f63471cc09c6f31685d1f0cf.1717073347.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O0sDfod/8ce52FOW"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--O0sDfod/8ce52FOW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `pull_twohead` configuration may sometimes contain an allocated
string, and sometimes it may contain a string constant. Refactor this to
instead always store an allocated string such that we can release its
resources without risk.

While at it, manage the lifetime of other config strings, as well. Note
that we explicitly don't free `cleanup_arg` here. This is because the
variable may be assigned a string constant via command line options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index daed2d4e1e..fb3eb15b89 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -611,17 +611,19 @@ static int git_merge_config(const char *k, const char=
 *v,
 		return 0;
 	}
=20
-	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
+	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat")) {
 		show_diffstat =3D git_config_bool(k, v);
-	else if (!strcmp(k, "merge.verifysignatures"))
+	} else if (!strcmp(k, "merge.verifysignatures")) {
 		verify_signatures =3D git_config_bool(k, v);
-	else if (!strcmp(k, "pull.twohead"))
+	} else if (!strcmp(k, "pull.twohead")) {
+		FREE_AND_NULL(pull_twohead);
 		return git_config_string(&pull_twohead, k, v);
-	else if (!strcmp(k, "pull.octopus"))
+	} else if (!strcmp(k, "pull.octopus")) {
+		FREE_AND_NULL(pull_octopus);
 		return git_config_string(&pull_octopus, k, v);
-	else if (!strcmp(k, "commit.cleanup"))
+	} else if (!strcmp(k, "commit.cleanup")) {
 		return git_config_string(&cleanup_arg, k, v);
-	else if (!strcmp(k, "merge.ff")) {
+	} else if (!strcmp(k, "merge.ff")) {
 		int boolval =3D git_parse_maybe_bool(v);
 		if (0 <=3D boolval) {
 			fast_forward =3D boolval ? FF_ALLOW : FF_NO;
@@ -1294,7 +1296,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	if (!pull_twohead) {
 		char *default_strategy =3D getenv("GIT_TEST_MERGE_ALGORITHM");
 		if (default_strategy && !strcmp(default_strategy, "ort"))
-			pull_twohead =3D "ort";
+			pull_twohead =3D xstrdup("ort");
 	}
=20
 	init_diff_ui_defaults();
@@ -1793,6 +1795,8 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
+	free(pull_twohead);
+	free(pull_octopus);
 	discard_index(the_repository->index);
 	return ret;
 }
--=20
2.45.1.313.g3a57aa566a.dirty


--O0sDfod/8ce52FOW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdm0ACgkQVbJhu7ck
PpSWaw//e/aVUutNpGAGFPlo64KsGnynSACYMhYxZcxjGHgyxX+cgF0ZUIPUB1up
NxQ2uUbub4BQ+kyft/mS+YDhcS5nYyqhbqz/PlUHxZ50c30WjANocJKBBN8bbqET
Neu58bC8N+JHmqmTEAkmCoQ0liNX21czbS+E7AAf9HOSlzzghECZ+s3JeKxtAeq7
5NPLz9k8faLItnFIY/nfNhNBDKndRRBzwC/GTFkTNkvKZHkA4ATS4SLm96n+PF/u
HaqFppUixzNitejTTy2DB58HXgLeSbNBrYSvD/uRq6Mp0wYoDmEpHCCGGTH2xyg9
y6ZJeMQE4dy7FpggNvcb0z8XaHA0Tq01QGgpOA54hH7icB4orEIhlEL/GWQdP4yd
GcXye8m6AqOA1dd5f+9zhGLt6VKf8DxF5TMQDEwYC/uj+4PGSBT9WvY3qq/5IQzc
LC9MPjYmPYm18f0dfM4EGEdMqhfakR9sZV8odoHFIt6gwUcCZb5nQ+49Et7+S79l
jlaBDaWETYNCYpGSAtHI9sJNcOtlTxygWam9rEk70vscPGKo0w2HHkx6YoZcE487
mHh9C9Xn9lYgAtiHRpfnfwYmzzWMon0T7Plx9B0X3DZyUjkiuSmnvEEaPkKBrVPj
OPFoUTx21mtu0+43NfVGxDcdzA4QKU8ZppIQxI5xWhXJqnoM7f4=
=4aVU
-----END PGP SIGNATURE-----

--O0sDfod/8ce52FOW--
