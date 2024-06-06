Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DBA13C81B
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660872; cv=none; b=jsrXHULk+IOQG3E2FSte8pjpTbKDVTui57tWgSR6ZZEzSfkQO9SLhtxyJu6G0L9+zM8GMQG7Mokj57FmdBkvKdz9Bh++XGJgT4vx0S7DV5TvN3LtFtkO3GRYK4h6NNPau+E/RdASlo9F1ntJ7F8an/YcY0S6fkku7NtTYMirc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660872; c=relaxed/simple;
	bh=xHuqFSa0V+tA81ascgkGDC+L15DCOnQZ1aFwe1+yepk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3c2WvzPe00sdFL4PKb5KOITnDp70jPFdVJs63QNM8bSrdz5BhzPKw8emZzqBukhoVoxAHw1Bw5u41yvHzxxITS9nIRwascP2XSblpYalAXjHLtDiMlDzfk9n+dJVSuqtMRiYRoFSt//QPZOW38NjLx197ComkdXYYnopVJfgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G2RAGUUd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DoT86jCo; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G2RAGUUd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DoT86jCo"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id D80FA13800A2;
	Thu,  6 Jun 2024 04:01:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 04:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717660868; x=1717747268; bh=R/8jpItGen
	nXl2gpotfsuF3qYZJSZLnHZkg/ds4H13g=; b=G2RAGUUd3ZkTasL66jBkhVV6V7
	zep/HbxXubFFDFRnoLmPlQAPZUP5wjM/SCbZicmH6LWmheUAk06dlTTPojWDt3ka
	rY/WZb7S3Ou78l2x4njNHAcerh23WyO7ivJW9rtdUEs+LwQKhwU5Lct6m7qhOgHp
	CjK2S+Rs5txwAjs2Re1/Tv5Pk0I9OWiS6xgWWcs/EsWEw6/QfSfPg0rCjRURdbfJ
	sJHhtNpMyOdu90cEqSEdq5Bqv423VhtwYYjBf/vETdkZz+riZ/U8M10zR7cQYjMj
	grrOFQ7HPG5JuDs1CO+4oR/xDJYDfCFCa/VRK7QHyRT2E4jb/jGKuOxyjhng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717660868; x=1717747268; bh=R/8jpItGennXl2gpotfsuF3qYZJS
	ZLnHZkg/ds4H13g=; b=DoT86jCoEYk1l/fx0wkxgGQGc9to64zuu37sIEqmqxkT
	RLVqwwARUfsd+GxhP6RO0zRypghKIiCSM6vH4aeg2Q2b5xktIQ7NNEddeyaZamyp
	FORIm7bseON73iSVVa+MpzX7k+901LW9HPNP3vzhJvX6BVdo6NyqE4yvUQpzXh/X
	+tJTgket36zyWQgDhxgN0h1Pr5ChA6oCNDhXBxamOA71GWdKcSPfydEN5dFYOANA
	hsyAQku5yGdcHlQJwcPWmt+VRTlHyCwEb4c5e3TrKohOBM/DqXahJIwZTNAhWekC
	qvH9Fwbf7OhTu/pp6EBT9R6dILljRzddfBRE4AwWqw==
X-ME-Sender: <xms:xGxhZpISc4uLV6rO73wcpPo66G-n3shL_HqN8wKE02qJfd6kRa01YA>
    <xme:xGxhZlIwPMXqhpaKVfu9OCTnRIAT5Y8mxxPYr39DjfkUnuHP2gX3FCPKiqxa3-XjZ
    k7GtJPxl9k32ZFLNA>
X-ME-Received: <xmr:xGxhZhuXAq3a-MP1nXLmcZ5h0HupFiIWUbOBg_Z2EabVhBXCMSALvRTfdLf-8nAItnt6E4oJw3SlpDJqoa_ALOmVBm-EIGVNCR0MLewYeejj9rtr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:xGxhZqYEpPm5GTc0qKbpSk4riesrVAxJ53c1QjQRAiNMChTeS1_0tA>
    <xmx:xGxhZgbjTiChc8KfkItuhwwX2bBO5vNYy5xtUBnwrz9kHK9HxLoHxA>
    <xmx:xGxhZuCp_J_WA5Oq7kqB0xGAgBTNgEMDljVV2RDltK4_ufXQh-k_sw>
    <xmx:xGxhZuYlUWyH0lOACtvCwXjNOJsGI9BRDT9C4sPACvMw-NVXMfK06A>
    <xmx:xGxhZoFrHCCp10mqz4mkAMFCE6bGLeN6im70XFHL7eYa1BbGACX-SWbA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 04:01:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fcdfe412 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 08:00:37 +0000 (UTC)
Date: Thu, 6 Jun 2024 10:01:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] Documentation/lint-manpages: bubble up errors
Message-ID: <9f21c305b9e0e63ddf1f1b78535f09ae957812d4.1717660597.git.ps@pks.im>
References: <cover.1717564310.git.ps@pks.im>
 <cover.1717660597.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9+9tZi3t9z0d4zkX"
Content-Disposition: inline
In-Reply-To: <cover.1717660597.git.ps@pks.im>


--9+9tZi3t9z0d4zkX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "lint-manpages.sh" script does not return an error in case any of
its checks fail. While this is faithful to the implementation that we
had as part of the "check-docs" target before the preceding commit, it
makes it hard to spot any violations of the rules via the corresponding
CI job, which will of course exit successfully, too.

Adapt the script to bubble up errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/lint-manpages.sh | 41 +++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
index 0abb4e0b4c..92cfc0a15a 100755
--- a/Documentation/lint-manpages.sh
+++ b/Documentation/lint-manpages.sh
@@ -12,7 +12,9 @@ EOF
 	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
 }
=20
-check_missing_docs () {
+check_missing_docs () (
+	ret=3D0
+
 	for v in $ALL_COMMANDS
 	do
 		case "$v" in
@@ -32,6 +34,7 @@ check_missing_docs () {
 		if ! test -f "$v.txt"
 		then
 			echo "no doc: $v"
+			ret=3D1
 		fi
=20
 		if ! sed -e '1,/^### command list/d' -e '/^#/d' ../command-list.txt |
@@ -41,11 +44,15 @@ check_missing_docs () {
 			git)
 				;;
 			*)
-				echo "no link: $v";;
+				echo "no link: $v"
+				ret=3D1
+				;;
 			esac
 		fi
 	done
-}
+
+	exit $ret
+)
=20
 check_extraneous_docs () {
 	(
@@ -61,15 +68,19 @@ check_extraneous_docs () {
 		    -e 's/\.txt//'
 	) | (
 		all_commands=3D"$(printf "%s " "$ALL_COMMANDS" "$BUILT_INS" "$EXCLUDED_P=
ROGRAMS" | tr '\n' ' ')"
+		ret=3D0
=20
 		while read how cmd
 		do
 			case " $all_commands " in
 			*" $cmd "*) ;;
 			*)
-				echo "removed but $how: $cmd";;
+				echo "removed but $how: $cmd"
+				ret=3D1;;
 			esac
 		done
+
+		exit $ret
 	)
 }
=20
@@ -77,7 +88,21 @@ BUILT_INS=3D"$(extract_variable BUILT_INS)"
 ALL_COMMANDS=3D"$(extract_variable ALL_COMMANDS)"
 EXCLUDED_PROGRAMS=3D"$(extract_variable EXCLUDED_PROGRAMS)"
=20
-{
-	check_missing_docs
-	check_extraneous_docs
-} | sort
+findings=3D$(
+	if ! check_missing_docs
+	then
+		ret=3D1
+	fi
+
+	if ! check_extraneous_docs
+	then
+		ret=3D1
+	fi
+
+	exit $ret
+)
+ret=3D$?
+
+printf "%s" "$findings" | sort
+
+exit $ret
--=20
2.45.2.409.g7b0defb391.dirty


--9+9tZi3t9z0d4zkX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhbMAACgkQVbJhu7ck
PpRjOw//T6joJYflY+EwNqxuxOWjrCz+2PaJV23NaYQ33diy+SRIy6nKWgwwHrh8
4SaDP44apth+zQJyAw2d5cfAz05lQBA/rZmE+tZo5SzbeZIZZDlOW/sVc/PU9AO3
55TGc2K1pJz0skx4VSQYXdeUaC1kAPHQK8X/SX/KyD7KL7ZlwhbsQh8787EvV1Dp
LX8bPXzO0DNIpnDI1+F9kX2OHJQHIqMFAKXXKhdYPidxPVU/CzrIHyZ10PQzoQ8g
gzv178giSqvkh2SkXQQo3uaIqn9BWmpw2lw9nQp+O4r36Imr9TxqX20ZcQbACSIB
jQQVkiAjI9lK7ri1oGBh7agPwofaRpx6ysCvkU9PftAaOumZMAfg9l79QAHlbnPe
L52PUGU76nc++STP1v0uGhiMG01AMiJviYJQ5XA1eQ1gkOD2nugK89i5VFApd9pa
mB6SB+XAC8p2cfUtb/ZfT3eSoDvOiORu5pRhR61zUMP5VQPeNt8b5Y2wlF6UO94f
BNquhKGp+Q7Wc4b+fveMP2xU5BkxTa+/BMLoZ/r9yxCJBQOSulNx9W2OHnQflrXq
ALTVF7elYFoLsyLwM2Ogy2IguPZWxVBigEExG5TW63Ivdd7HQjOAIHwUklI5JPyF
GPQgMUJTE+MwQ+XocC9qK7iHuuapoX2HhTOl0+Mo33uf8jQ9HCo=
=FVJJ
-----END PGP SIGNATURE-----

--9+9tZi3t9z0d4zkX--
