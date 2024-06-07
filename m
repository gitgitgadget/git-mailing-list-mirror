Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067E15278F
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742288; cv=none; b=bM4e6oUUeMkySj+vlA3lYlNEduMI8JZBxcQxWfBlWLWDeRLS5/sd+EJG56jtgvVGP4y15Sxs9mdJcomJN5nHL/oaaRYrjToAgiPkke0VXWfpx/fTYPTTVzt+DVejm3bYn/DHSTqTyIw3bcDG9Sf/szk7/xyBNmrjp6/DsY59NUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742288; c=relaxed/simple;
	bh=LY/Cku7dssE/IE+meZ9hb3y5DBCJWQ5leIjyNXj1vbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGvYD/DYK7xkmZLTTZbqKu84y++JeSUQSCJKqyTnRpjOJVHXiBX/m3n4LBoVXWKRs5pGPQfm05T9LzEU0yDIgH3e/T0L28NM6o70tACkIDRs6jOdpKpzOKFezO68bht43v4bGhJF3F87Z5IHGH9XV2XFk4yLV33lsxmlIMZjNcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MPxK0bTK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c/mRwVB8; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MPxK0bTK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c/mRwVB8"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3EEAB13801DD;
	Fri,  7 Jun 2024 02:38:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 07 Jun 2024 02:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742286; x=1717828686; bh=mZVJqAcVHD
	d6bzxXQWJI/yAT2oPHxjSHybWr0Gq06uI=; b=MPxK0bTK2yhs2IxNrJVStDbZWz
	x/2aQs+DfE6fCzSVG2VHooglp28xhXbraeWSLe7KLQvecA6ho1Fbv3MoW9P/oCcW
	k08fgeNFXJhGkH/Kkx43L2tLC61EzgiG36jml8e/HD6yEk+opYO9B8hBVmH/nsfl
	dmzbxVCfPc1vr6aG8jCpzZ4daXNbb+4kR4nCpw95xqCMaJ2VLAjLCxokQyxEeCga
	GYxW8TD3VLT5zPJSvQyhn8X14+qIB2jzOIhybK23/6AHyIZyby4o7eXTPSCPniCz
	wRxTYkBTIty1/azxhh6opsro834fVtqzqUyI4gT9SHd+ZN60WlzWC6kyL8gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742286; x=1717828686; bh=mZVJqAcVHDd6bzxXQWJI/yAT2oPH
	xjSHybWr0Gq06uI=; b=c/mRwVB82qJ7+bhg0m6HtGQPFdOnTZtAnHX0JGThq05h
	grzpI7Gxn2wf3NXtRyWZLh+EWfmwa1twlMuD4gewNRzmHxvpnIh/RxDFo1eRMmFe
	wBGAN9vBhcxlX0k+XmwdBaN+RAi5wr+YDhDd3AO8ZotRROz5JHGLv4ofy7T/ercT
	5SmUkHNZr+RQqi8AHaU3gFCPSM18eoCsnfdNYvYNjIkzfDT5uAa6yl1i+fzPFwUF
	ru9qnGMTij3QhXBTLYww82stgBGCzaYKIyMeDYdy2JLYGOp3t1XAoF1G/HR6eJHH
	D+mmF4OWVDvm68B8wVzrGJBaZ68WpW5REXv9GagjKA==
X-ME-Sender: <xms:zqpiZiFtDct45rw1lJkHOUiRNNTHMb1emRhR1hdnvsj8LbwsmxVUuw>
    <xme:zqpiZjU5JQX3FiGrLV90nbeKPCzQeebLsEsZ-sAlyu-6P9Zjj9VQY1EGzTEIXVgi4
    uRQ3etLfhhxpEInHg>
X-ME-Received: <xmr:zqpiZsJRe0xvPL0pZT_tOZFAJYRwvSi3_Ceb019PnelndUBC7QQSy9MJ3Vo3caJGCICW48Afpf6GGgnvpteKNCwN168B4hcsLJLrQQ0_edAqAu0K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:zqpiZsGHsTuVinJl9ovH-3FZ5hVgczN1Hn3DdgwBaxlRz50dP47eQw>
    <xmx:zqpiZoX3vapxiGO8Wl-GmpBcqQ5pbbl8rJF-ah5oi9gzE3lH6MuVfg>
    <xmx:zqpiZvN9xmTVuZav7REw26UfkOofCkyeq8xCJeugiKgrLYiiZDroUA>
    <xmx:zqpiZv2DTYYJHrCL_kLrSx-5_bkkmyhLUjIBByYonPgj7xqGFAxCEg>
    <xmx:zqpiZmy1egDVQpV8yk4bTqmuGhJ3xm9dKpvo9RTFP5RayWCIBv21Itdy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id df60407a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:03 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 06/27] builtin/remote: cast away constness in
 `get_head_names()`
Message-ID: <e9b8f9eaef74769c7c6addcecb7c79c1530c31ff.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zdge71xWkrRQ6d2a"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--Zdge71xWkrRQ6d2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `get_head_names()`, we assign the "refs/heads/*" string constant to
`struct refspec_item::{src,dst}`, which are both non-constant pointers.
Ideally, we'd refactor the code such that both of these fields were
constant. But `struct refspec_item` is used for two different usecases
with conflicting requirements:

  - To query for a source or destination based on the given refspec. The
    caller either sets `src` or `dst` as the branch that we want to
    search for, and the respective other field gets populated. The
    fields should be constant when being used as a query parameter,
    which is owned by the caller, and non-constant when being used as an
    out parameter, which is owned by the refspec item. This is is
    contradictory in itself already.

  - To store refspec items with their respective source and destination
    branches, in which case both fields should be owned by the struct.

Ideally, we'd split up this interface to clearly separate between
querying and storing, which would enable us to clarify lifetimes of the
strings. This would be a much bigger undertaking though.

Instead, accept the status quo for now and cast away the constness of
the source and destination patterns. We know that those are not being
written to or freed, so while this is ugly it certainly is fine for now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d52b1c0e10..b44f580b8c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -493,12 +493,13 @@ static int get_head_names(const struct ref *remote_re=
fs, struct ref_states *stat
 {
 	struct ref *ref, *matches;
 	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
-	struct refspec_item refspec;
+	struct refspec_item refspec =3D {
+		.force =3D 0,
+		.pattern =3D 1,
+		.src =3D (char *) "refs/heads/*",
+		.dst =3D (char *) "refs/heads/*",
+	};
=20
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.force =3D 0;
-	refspec.pattern =3D 1;
-	refspec.src =3D refspec.dst =3D "refs/heads/*";
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
@@ -507,7 +508,6 @@ static int get_head_names(const struct ref *remote_refs=
, struct ref_states *stat
=20
 	free_refs(fetch_map);
 	free_refs(matches);
-
 	return 0;
 }
=20
--=20
2.45.2.436.gcd77e87115.dirty


--Zdge71xWkrRQ6d2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqskACgkQVbJhu7ck
PpSrkg//ZvvRdoILuMDk9x6v7UcjNbXnTDnRsBbNhAta5rrpOyRWniDrnt9OJ4Xj
Ysj2hVOc7fDfp7Gct38yqY8vaLDXVxFsl6SyIVkGUr31GKhqW5TLlCak36vCyY7Y
1PWTlbJbBM8TJdo5/VGSlZ358XXBp7HUEoOgMs9b8MwA20DkyETQig2hlf8HJTU2
pAlS4P5pvdHEneA+WijnajukKZQRfIl/HgMhaP8UGxmwmxq0Ra8KAklowAh2NGCp
wTrY6GJriN84YrX8DJdlcu23mOBQ1SsMkXoKWy0EbVMZ3FrW3MoD7VjjyLjhjAGi
WmhaGtoI8Pt+FmfrYn8/hnhm22uYcvAbmGCoDF+ikP3BoSVAahD80FvnKqOqBpJL
bObnYPVmRI3pUW8VOpVkZ2ZVmitXiYhiKAQLFWZ7xx6gFMAPnUJTHQjR74a3T4Ji
ICEt4eg1vUzpD4E2uFq4bYXOrnQxf5iIiTXqNTgEq7BiD/Nn/5xmy0++FJmdN7c6
qdYzylsFZpQ0aBEP8kXINhrIOoRZkQvrHX69MTH7FiHkjD3x46oqQXGwfpgrYkxg
pMFG/dtGCnYyGePlYCKEL3zTPKFv6o/eyWvkakXkY0RpYNQ4n87OkLyqr8vOmtxV
7bkqLSqAV2rGo8fWB3bAZQcRmDqvnmHgSa+lK56WK/JjNiWGvqw=
=zur6
-----END PGP SIGNATURE-----

--Zdge71xWkrRQ6d2a--
