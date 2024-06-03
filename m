Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B3811E0
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408092; cv=none; b=H7L4xWx0HsTBA+8OwwHAgZ/r5wVuHIvw3N2DqxdbIB+gUadmSkSh+9VoBgVbXripjbLXdnP67IO4v423f0GAUbV0YhcbawhXpLe6FpmVKDKveUbKj711DNJkLa6WH7qcQJjKGh77Hh5tU5S8oWQsM6sLM1L4yPkYKq0ZsT6a19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408092; c=relaxed/simple;
	bh=USL6xVaqS2LHdvSSrHCOJ/JeylagGaWSayy/2MYtafI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO5q4aB4+7OEMCD6t+azZMxC9L8Zp03kr+r4QBT4W+RWIZx3QpjdUagaxglE9aTaBaaReSwRNX2z3r8jCneMabrT3IgK/y8FKiAxT4QcZiixPkLQy1CK3D+OS8TI62Y3vjoeE89h9croXAJJGabV2WjhQOvcIWPe/GAhLK2pU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MoKkITz+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=omMOB4jS; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MoKkITz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="omMOB4jS"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 28FB41C0012B
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:48:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408088; x=1717494488; bh=JrwigFGeCl
	RMHfi0yaqnGXaKMlp4brz8dFo+6LRSQpI=; b=MoKkITz+8XwVPCB2IKZyND66zS
	N0IWm+EE6yHJWCZLZWZ99Q0GSx7gCyW6Mxn6Z/wfayhJmoi+4UZBZkqcVIdJ2Cue
	TbHWezctXEsfCEwE/Yp5V138dBQwjcE+WqcCFb6iXB38s5t6yRbRY3Z+nzSwjEfK
	/Ih5oVDCF9SSL6sQ94nZcGV7h09bhKxz0vU7Ya+u4dvUrrDuTWs5h1xqtjjb1i5B
	Ms4kJPT9+SDVH+BzDMB4Jm3NNicphtZSMzUpVGUrGI5hTSvx/kmXmS6t472roprx
	5xoRVVEjRDoQstAOAzUgQpSbWZ0Xt40U2Tzal6ewrnOXevGhkMzFik5B98Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408088; x=1717494488; bh=JrwigFGeClRMHfi0yaqnGXaKMlp4
	brz8dFo+6LRSQpI=; b=omMOB4jSZoE4kWTJlAmWcckyGUq4EOKWElPzEJI77jas
	vZ59YvKxP2FPSPTuG/EJsWVUrKed0B+1Le/5Lp3Gl/XasfPDvGZLCgJHLudjlF1x
	lrKjICsjDWHl96f6SwNkOzjpQ4c8DZS5IcZ5EEvy6V9x/MqgG8X33mEmCrf4MJox
	TiK/tRfZlRljRmUgN7cvGcWES5P0b0wJPi5DJTBiu1H2FRenkf6So2Wihy59NjZa
	WDU6cvLy1j5yIpQuTP+T/ta6KC9Pj5KrZ4clzzP+G99f+Aq3OqKPrCedgzaDObFu
	HXHT6F60LT06P+OPIxYxjY3tY6rkbq7I+cp37r5zpg==
X-ME-Sender: <xms:WJFdZtBfEeWd3SmAPAftbdZXK-Kty4ZzyBlQYQueFcBLp4tSyOEXOw>
    <xme:WJFdZrjHMCAHIm_UX9Zdw18q0e8KmfvCGa_BcF3Ois84817RZ5Ii3ownX-uwHWdw4
    m_ERyF-uxd3c8ESow>
X-ME-Received: <xmr:WJFdZomxNC1CzM3niGFtAwmacFAOHwHbODm2DSu-DzVRfyMztZQVoEgNV-L35_k3QWG6L4xAmL1XLavbDesk0TgJmI-SHIdFSsXl-fo9xGSSNygF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:WJFdZnwZIFSPeZ9F0OMUnxO2wPvWsgQRVzLCbv5-G6CzUB-DQjmWtA>
    <xmx:WJFdZiQGJOvKmzV8jwoLSqcA9dG9XbWGhku2i4n-vuECOld_XnaKCg>
    <xmx:WJFdZqaR8d0mC6kdYlq-sMlTEeV33GjAar5Xl1V0uUCf-Kfiizc4yg>
    <xmx:WJFdZjS5WzQfFYK44bse2v8XIxpP2sRTcWWAN7eWXccw6TDJyH5wFQ>
    <xmx:WJFdZlJYOpa2on2IE2BBVH-sdHQCyaSdefgv3SJBRkmrJ5LM_flzH0aj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:48:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e6df2f1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:43 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:48:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 21/29] apply: fix leaking string in `match_fragment()`
Message-ID: <ebed18717f0f026d5f9bebb63d6edc40bd03cadb.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8gZfwjBL1GLvpmjl"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--8gZfwjBL1GLvpmjl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before calling `update_pre_post_images()`, we call `strbuf_detach()` to
put its buffer into a new string variable that we then pass to that
function. Besides being rather pointless, it also causes us to leak
memory of that variable because we never free it.

Get rid of the variable altogether and instead reach into the `strbuf`
directly. While at it, refactor the code to have a common exit path and
mark string that do not contain allocated memory as constant.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                          | 87 ++++++++++++++++++++------------
 t/t3417-rebase-whitespace-fix.sh |  1 +
 2 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/apply.c b/apply.c
index d8d26a48f1..fd7e3d649f 100644
--- a/apply.c
+++ b/apply.c
@@ -2494,18 +2494,21 @@ static int match_fragment(struct apply_state *state,
 			  int match_beginning, int match_end)
 {
 	int i;
-	char *fixed_buf, *buf, *orig, *target;
-	struct strbuf fixed;
-	size_t fixed_len, postlen;
+	const char *orig, *target;
+	struct strbuf fixed =3D STRBUF_INIT;
+	size_t postlen;
 	int preimage_limit;
+	int ret;
=20
 	if (preimage->nr + current_lno <=3D img->nr) {
 		/*
 		 * The hunk falls within the boundaries of img.
 		 */
 		preimage_limit =3D preimage->nr;
-		if (match_end && (preimage->nr + current_lno !=3D img->nr))
-			return 0;
+		if (match_end && (preimage->nr + current_lno !=3D img->nr)) {
+			ret =3D 0;
+			goto out;
+		}
 	} else if (state->ws_error_action =3D=3D correct_ws_error &&
 		   (ws_rule & WS_BLANK_AT_EOF)) {
 		/*
@@ -2522,17 +2525,23 @@ static int match_fragment(struct apply_state *state,
 		 * we are not removing blanks at the end, so we
 		 * should reject the hunk at this position.
 		 */
-		return 0;
+		ret =3D 0;
+		goto out;
 	}
=20
-	if (match_beginning && current_lno)
-		return 0;
+	if (match_beginning && current_lno) {
+		ret =3D 0;
+		goto out;
+	}
=20
 	/* Quick hash check */
-	for (i =3D 0; i < preimage_limit; i++)
+	for (i =3D 0; i < preimage_limit; i++) {
 		if ((img->line[current_lno + i].flag & LINE_PATCHED) ||
-		    (preimage->line[i].hash !=3D img->line[current_lno + i].hash))
-			return 0;
+		    (preimage->line[i].hash !=3D img->line[current_lno + i].hash)) {
+			ret =3D 0;
+			goto out;
+		}
+	}
=20
 	if (preimage_limit =3D=3D preimage->nr) {
 		/*
@@ -2545,8 +2554,10 @@ static int match_fragment(struct apply_state *state,
 		if ((match_end
 		     ? (current + preimage->len =3D=3D img->len)
 		     : (current + preimage->len <=3D img->len)) &&
-		    !memcmp(img->buf + current, preimage->buf, preimage->len))
-			return 1;
+		    !memcmp(img->buf + current, preimage->buf, preimage->len)) {
+			ret =3D 1;
+			goto out;
+		}
 	} else {
 		/*
 		 * The preimage extends beyond the end of img, so
@@ -2555,7 +2566,7 @@ static int match_fragment(struct apply_state *state,
 		 * There must be one non-blank context line that match
 		 * a line before the end of img.
 		 */
-		char *buf_end;
+		const char *buf, *buf_end;
=20
 		buf =3D preimage->buf;
 		buf_end =3D buf;
@@ -2565,8 +2576,10 @@ static int match_fragment(struct apply_state *state,
 		for ( ; buf < buf_end; buf++)
 			if (!isspace(*buf))
 				break;
-		if (buf =3D=3D buf_end)
-			return 0;
+		if (buf =3D=3D buf_end) {
+			ret =3D 0;
+			goto out;
+		}
 	}
=20
 	/*
@@ -2574,12 +2587,16 @@ static int match_fragment(struct apply_state *state,
 	 * fuzzy matching. We collect all the line length information because
 	 * we need it to adjust whitespace if we match.
 	 */
-	if (state->ws_ignore_action =3D=3D ignore_ws_change)
-		return line_by_line_fuzzy_match(img, preimage, postimage,
-						current, current_lno, preimage_limit);
+	if (state->ws_ignore_action =3D=3D ignore_ws_change) {
+		ret =3D line_by_line_fuzzy_match(img, preimage, postimage,
+					       current, current_lno, preimage_limit);
+		goto out;
+	}
=20
-	if (state->ws_error_action !=3D correct_ws_error)
-		return 0;
+	if (state->ws_error_action !=3D correct_ws_error) {
+		ret =3D 0;
+		goto out;
+	}
=20
 	/*
 	 * The hunk does not apply byte-by-byte, but the hash says
@@ -2608,7 +2625,7 @@ static int match_fragment(struct apply_state *state,
 	 * but in this loop we will only handle the part of the
 	 * preimage that falls within the file.
 	 */
-	strbuf_init(&fixed, preimage->len + 1);
+	strbuf_grow(&fixed, preimage->len + 1);
 	orig =3D preimage->buf;
 	target =3D img->buf + current;
 	for (i =3D 0; i < preimage_limit; i++) {
@@ -2644,8 +2661,10 @@ static int match_fragment(struct apply_state *state,
 			postlen +=3D tgtfix.len;
=20
 		strbuf_release(&tgtfix);
-		if (!match)
-			goto unmatch_exit;
+		if (!match) {
+			ret =3D 0;
+			goto out;
+		}
=20
 		orig +=3D oldlen;
 		target +=3D tgtlen;
@@ -2666,9 +2685,13 @@ static int match_fragment(struct apply_state *state,
 		/* Try fixing the line in the preimage */
 		ws_fix_copy(&fixed, orig, oldlen, ws_rule, NULL);
=20
-		for (j =3D fixstart; j < fixed.len; j++)
-			if (!isspace(fixed.buf[j]))
-				goto unmatch_exit;
+		for (j =3D fixstart; j < fixed.len; j++) {
+			if (!isspace(fixed.buf[j])) {
+				ret =3D 0;
+				goto out;
+			}
+		}
+
=20
 		orig +=3D oldlen;
 	}
@@ -2678,16 +2701,16 @@ static int match_fragment(struct apply_state *state,
 	 * has whitespace breakages unfixed, and fixing them makes the
 	 * hunk match.  Update the context lines in the postimage.
 	 */
-	fixed_buf =3D strbuf_detach(&fixed, &fixed_len);
 	if (postlen < postimage->len)
 		postlen =3D 0;
 	update_pre_post_images(preimage, postimage,
-			       fixed_buf, fixed_len, postlen);
-	return 1;
+			       fixed.buf, fixed.len, postlen);
=20
- unmatch_exit:
+	ret =3D 1;
+
+out:
 	strbuf_release(&fixed);
-	return 0;
+	return ret;
 }
=20
 static int find_pos(struct apply_state *state,
diff --git a/t/t3417-rebase-whitespace-fix.sh b/t/t3417-rebase-whitespace-f=
ix.sh
index 96f2cf22fa..22ee3a2045 100755
--- a/t/t3417-rebase-whitespace-fix.sh
+++ b/t/t3417-rebase-whitespace-fix.sh
@@ -5,6 +5,7 @@ test_description=3D'git rebase --whitespace=3Dfix
 This test runs git rebase --whitespace=3Dfix and make sure that it works.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # prepare initial revision of "file" with a blank line at the end
--=20
2.45.1.410.g58bac47f8e.dirty


--8gZfwjBL1GLvpmjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkVQACgkQVbJhu7ck
PpTTQA//W33BRheQnNlhagdCqL7q6jbwSg44OirFn93EdThN3ozxaCuRB8J5H9au
sPh/pyw3stX5mpnN3144lG3wzMMC0BwHswGvygWrhc8xR63xcwIbKY/N5RqgXswJ
hK6nowBF3LcrURPBLOU/KyOC4DOntVCaKOvbI9jVF3dO6gda5nmoOKfs9DtYpewP
BhZvMYUzLRBkni7wvXT3X7sGN95Sa+1Kc9dvvm0Wl6K0n76V7ChbORhBEpF1S1oW
R+qI2S64LAUJesqTIWbf8BgRKyhPTTkZ/EfqHPhdUHZ791z0Z214iN5vCgJmgAWz
4i9s2U8cYTIoLFbr0GbAyOubhO6nzlWLuRbcMia3xjKGda3uMmsR2qaJGyZkBjfa
tNmBgIg+YActcca8Gjub9CE3PofdOjZdbcIkxnPt85LW2VOPb2uZNnS4oFprFcuK
z5R/8EuEWwWqRlSo0fVFt22g8pRW/5sP3QoYCJGvejaj44qwk4H61X5DBVIAh78R
olTvWpTiSxh8RX2bNb/IH5bsWlFMaG6O8MbEeJDUAg2Hh/lV7IVECBmEHStf5EpK
S46pztv2X9Npg4GndXxG8swfORTArtt8r7ZDyL89fjlvO5rmJD7ezYPOGd6vV4TS
dOyyjROKFtZdQvPJQL/vtmtZpxMLHYOvbzuP8Smhwq2vLEDj7HA=
=l2FQ
-----END PGP SIGNATURE-----

--8gZfwjBL1GLvpmjl--
