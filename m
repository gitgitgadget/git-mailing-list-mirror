Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250C176FB6
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097658; cv=none; b=FMgp/Jbe+8bQuZdd0n4xscuoLJ1l6TP1r8w8B8RN5WNpWaLlhtUc7MhpkKdmJLFAhxic8KWFZh4IS1J/sF4hOYo6sL63XlLuSnRVytb4BsufnPe5ZfkwHqHL+kdoYBWlU9n+9BJkon3xOiVZNlh+lsW1QTJKWZdTW/h6NJRvggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097658; c=relaxed/simple;
	bh=JfwPmBQ4C9eiybS97SLKo/o77NKTghV8xiVRpPrF/+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0+45h+tOAdyFsQ6rvSo7HENoc0WLqr+FwQb4YlKJmCmj2YvVyMb8bD9k9sacLMtUUbkTLpXMK6ImLaufKrSR97a2hWtXlL+v6EljP9I+3t/C+baFuFsq9+tf4dOYKgGBHqZic/oGQzuOMU1usvtfrbixwbslkRAClUilaS4mFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P0v7kl+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qBPSKiBr; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P0v7kl+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qBPSKiBr"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 644EF1C0010B;
	Tue, 11 Jun 2024 05:20:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 11 Jun 2024 05:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097656; x=1718184056; bh=oMX9upXI6R
	tFBjXEvLKFdhGawBVG48TNBRB5KVcTt1Y=; b=P0v7kl+YecMXXL9zTpHnUvYFvA
	YXnexhk6Qu1Gh+fUh8K+STBLuUaB2IN0Ukb1yQeVWSKbnuF0Rcd1IIWnKojxemZW
	K7Qwy//CJxZAbQHf4S1V11ABRENejFCupBS0YhPWrNXaggNENT3QGQH72ArRFPO8
	I8ct/WDAISF3D17RXYyZ3GoZsOdUstwRCNZL8SkhGd+KViaLmB6BI8To+wiyiMFc
	MlLOvNA8NzVHm4VpmZkzQc2R5MGnKW+AEmhaI+bAIpO0+9EXvDnuVUifT1AhdYGl
	Fdd4tFzCxxR8NDJkinLPWL1C/agPFFssy/fAW1qD8wxckiwYy1iAPK6/jSGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097656; x=1718184056; bh=oMX9upXI6RtFBjXEvLKFdhGawBVG
	48TNBRB5KVcTt1Y=; b=qBPSKiBrRcC34AEJ9Ol0gIYHjD/f4Q89Hhg0CsZuYvwp
	rXrC8iqfB4cvRXiykCk8ZFSP6f+Ym8N9/LT53vSM+T3mCv9LH5XDhTkFTOZug0rR
	X4M7SGVPWzfBJeXZ+HhE1b5ZuFS4WcS+BfbDWCfaVpQRFCbUOHwmnnMJ8WrUwf/2
	XWQcqhu30cH+/KrabvEQM2g/FmaQHJNxg7egSOwgp+bqvGDBcqYUoLO2Sq1bvNIi
	tVR97o9NECpBsMngNfnmudGKraY5ZkBhdNj9jP6ysIyhorcQ8+oh4h2C7JW+nGAO
	UntBjd2zjRD9iwuK8kpOTULUxMwUqZNvCjURJvgqdg==
X-ME-Sender: <xms:9xZoZnCZPqcAb4_bOjNdxJpUu381vttKEwKmi4HjNB9zYNJTgyXTxA>
    <xme:9xZoZtgQuE7P1UR4VrzEn7gNIju0n_aM7Tlm_S8lwsyDh-e92vfWjGeUflQsE7jzS
    SllEaEk3gsrpkJihg>
X-ME-Received: <xmr:9xZoZimUAbIkj1qDI-A3rHlJDM1aMFQovbbsyaDzmv_jXSH_guCzESDF9ZN6sJHlalfgKB3pqI4g8uLKjCKzdQpESVcY8MT_4GPbJs72_oU2on99wLO_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9xZoZpxXeJ4NcJKgGZ2nnMyviteLnT_Xt55smuJjKTtORJxNHO0AMg>
    <xmx:9xZoZsQ5B-DPEh0zOdxEIs7-AZ0e6RBO7nntozFNTPN1DvMahAshOA>
    <xmx:9xZoZsZMkJr1I1exbaygj5mV0CCnigH1Q9StnsAXwafWIjfL7yqvJw>
    <xmx:9xZoZtQlkGGceA6bBQPa57cz_LfjQCCP25zeJDG7irkDyxbmEGrFNg>
    <xmx:-BZoZidFj4T8Vo6PFocmDz6SM6tR6H1KVvSs1TEqYHQ1RqLLW40nYWjM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c500de65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:45 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 21/29] apply: fix leaking string in `match_fragment()`
Message-ID: <8e1cf8a18b9926db801d9a44afe8d4edeb2401a0.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yNdvES+OrPLfoPpw"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--yNdvES+OrPLfoPpw
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
2.45.2.436.gcd77e87115.dirty


--yNdvES+OrPLfoPpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFvMACgkQVbJhu7ck
PpSboRAArP2oKckovOXv0/KvgiuY8VgGdbg1ctGBnuACi9ht2uamYfOrca2Uw26O
hpFyghTsgaxxyVcxKAUElic9eRwG/bjHNXU4uf7u9hPW0T8rRkUJR54Wh40rrW5g
mP5w62FR0kph3Wy7KL1Y95/tYaMxmMplZrAdnv3Iutqc5JqwBzzm4CFaztYUm5c8
iaff7s+Py1mbOf8cm2iKvpf9sUZB0EDQm+IrGoyjkXpS0tkrhGlXCoQBkbvdyB2m
QchqSPuNbZO9CJuGLMgJj5gdYtN+826kaT+txJKCvE36zyZ84kCvVLFnwfXCAgwG
c3WoUSyza7Jbf+KjowxK6WUHc9UoQPGyEjHzL2uHFfjTsPWI+eJkhT25IaTOTn3v
ZokQ5pwE4mWGLreqpAfZ5W7w6MVPk54YBdjl+ULz5In7yZZgZ/TkPKK1SuOdnxAv
+nzFms5p15pOMWdDk655U5rPLd/nJ7Q+azJrlKUqV6ufO57kYHHBDHovulNOFN5d
j7G/k9UU1mBeEQcNqQma1QQBMUHUv1XLtf+LNOxmgqOo4KFx0lGegaz/kzBJ2PZy
5VI8fkzTJP2Ce1QBbNngFynBvqM6vBhg7PhC/j0wQk4kjsEldScUCRLyJ9Zcgr+l
sDNQiUTZ/Ey3l1g07Zbo/64nIPg5aDA90FL+mg7a8lbEmj7k2WE=
=F9sR
-----END PGP SIGNATURE-----

--yNdvES+OrPLfoPpw--
