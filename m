Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816238FB9
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564618; cv=none; b=dYP+kFtICFqZFo0luTR8w55P0UEuhyv/Bj2o/WdA5F80AYS7DQchoVaaq/loWza4npjFEDxUZbtyWcIvexM5gEbOROJGKeITrLAX/04P+69vV4GxscyGZl+C9EMFWFoWH80SSaVy03PBbJg8OSM+YwhAi/ze3L0eHxayZg5oU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564618; c=relaxed/simple;
	bh=2XotbK05F7RrzfIxF9zLmhFF4NhswpD0cNycJoxJpf8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3HPyjgtrAmMHuNIr0+BC0tGi40SHPtfC3XO8CkWJOF5G4p8tsG7xge+mjlgsrHBGti0MzFsIIxGIjDxBR0rLKGg90AqmrQOV0Nrk4pcKwWp3BiQEz5CAD1lDeQIohglBsbPOuJC0xyUMuPzdpkOjGEDQtMmgRwnAcsYnHk1HfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NqtZdmG4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h6PJh/FT; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NqtZdmG4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6PJh/FT"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 9FAE31C0016E
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 01:16:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 05 Jun 2024 01:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717564615; x=1717651015; bh=p66hhxpA8q
	L2wnLJTKooBS0mrv/6yiO344wLPKNN36E=; b=NqtZdmG4BGFwI0qnOzWwwYW60e
	ZAeNtqnUCPvwIpfhLO+DX3+GzH8KU8MfzikWLf5413YjI/VGBt9ossS78kk+aG62
	fIyIhWpyf4WrqP7s+OQP46k0/NVL8HmY/LvJtdsE1CQBdsQM58tpAqnF+womJnyy
	9wgBDE0JXWJ2g99H07uPUG5sbRZa3y1BLBjtCflPqUAH931xcwzpZlkp956dXrqP
	LFeCBQE1IUIgYD/WTFBw18s34I0jmHN5ZHiUXze8CTPIa7h5uxC3tZW3LIjQkCCu
	dLAprCwxnUt6n9E+pEtQzCuYqTnPHaJelssYNrn/Gzfmi0MKtU7FASuVpoxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717564615; x=1717651015; bh=p66hhxpA8qL2wnLJTKooBS0mrv/6
	yiO344wLPKNN36E=; b=h6PJh/FTZ4YaodLCnNEhwvDl9rlaoZrF25F66MkjCh8r
	NaYLnYLF3FcHfBOkn8REjl+5oj8GqY0PDCbxIaCxlOkQDIPaOJ32cLFE2S/DAmTC
	b0+MSyuxzGSb0c1gtVuN5rVXSR3OqitnyeBFhVwYaPHMHrOlTHqlK75Czea8rrTe
	rjaHvguN4NP8rnhxK5xbqDAHNd+KiCR19aQvlqv+fIUFH05NOMI5aSuncKkd4/C9
	WBjDVsMFNEMbL5fMTLOMpmKVj2f+ab+agl2c/sJCo/wTV+Tyuaf78XPHf9whLrfX
	5hw1Zum0rtWeGfSd5ztMYbHE3ZYTBWUHQKdPrNI19w==
X-ME-Sender: <xms:x_RfZiMz9RZJQgWVzne2R2TAw5aEU_VGsZwrCh5g7tMKTgicfkIU4Q>
    <xme:x_RfZg9Uktjb7xzAcW8O94rtcQVVD_Mz4xdapUDzrgVDx6LvY4bsiu3tR_hzaAQJh
    YziEl3kN6x4xebMKA>
X-ME-Received: <xmr:x_RfZpScByVDEnZ765Yrgu4pTq6EMQI51-I3ZARVl2RW3WEOtGf7oOwHPDJxNBbTfDkG7t4VTJFk_Q2ozorRDcA65ONgvkuyxL-XsuB-2uGXyh_Kmew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:x_RfZisPPpADilU-Zc4qPuTbX7wVOGpC1lQCQPL3c9Sk1ZMFHr9ITw>
    <xmx:x_RfZqfb9K23fw9EcNBzVuZhZ2GHoKsGmWsKc-RUJ_rKOMlpx1lTIA>
    <xmx:x_RfZm0sdN95PJ93oRgtj7FEbuf-CqMkE5taSA5sMCslV_awgOIkBg>
    <xmx:x_RfZu9penFXWHZ_zhd0qsBk6gmOMIQzHj8ywIjtb3hFsjv3i38gJg>
    <xmx:x_RfZuG0-STfNnUPYEdBbM9YqeYxjhOgRLGBYEM68PAAdRQ44QK0Ms1P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 5 Jun 2024 01:16:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 39b1207d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 5 Jun 2024 05:16:26 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:16:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/4] Documentation/lint-manpages: bubble up errors
Message-ID: <b39a780d33e9ff00bc44886ed7e10904470c75e6.1717564310.git.ps@pks.im>
References: <cover.1717564310.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vI9PTvQDojmQmaRj"
Content-Disposition: inline
In-Reply-To: <cover.1717564310.git.ps@pks.im>


--vI9PTvQDojmQmaRj
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
 Documentation/lint-manpages.sh | 35 +++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
index f720a3f3d6..c7ae8ee17a 100755
--- a/Documentation/lint-manpages.sh
+++ b/Documentation/lint-manpages.sh
@@ -15,6 +15,8 @@ EOF
 }
=20
 check_missing_docs () {
+	local ret=3D0
+
 	for v in $BUILT_INS
 	do
 		case "$v" in
@@ -34,6 +36,7 @@ check_missing_docs () {
 		if ! test -f "Documentation/$v.txt"
 		then
 			echo "no doc: $v"
+			ret=3D1
 		fi
=20
 		if ! sed -e '1,/^### command list/d' -e '/^#/d' command-list.txt |
@@ -43,20 +46,26 @@ check_missing_docs () {
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
+
+	return $ret
 }
=20
 check_extraneous_docs () {
 	local commands=3D"$(printf "%s\n" "$ALL_COMMANDS" "$BUILT_INS" "$EXCLUDED=
_PROGRAMS")"
+	local ret=3D0
=20
 	while read how cmd
 	do
 		if ! [[ $commands =3D *"$cmd"* ]]
 		then
 			echo "removed but $how: $cmd"
+			ret=3D1
 		fi
 	done < <(
 		sed -e '1,/^### command list/d' \
@@ -70,13 +79,29 @@ check_extraneous_docs () {
 		sed -e 's|^|documented |' \
 		    -e 's/\.txt//'
 	)
+
+	return $ret
 }
=20
 BUILT_INS=3D"$(extract_variable BUILT_INS)"
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
+echo "$findings" | sort
+
+exit $ret
--=20
2.45.2.409.g7b0defb391.dirty


--vI9PTvQDojmQmaRj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZf9MIACgkQVbJhu7ck
PpQ1PA/6AvDhzXd03jYE7vIFv/kjnFqHyXREAIPITHoqnCeh3GU9VEiS8Ea1Sex9
e+ETaOK4lxEz+L0mmSGj+0rVCxpJklOGe6JfqDrU7u49fpzxEoiEXuSp+vbIpsHP
wlJyMs99d2/HtWfD+ILtfwtuIVEIJUmaFP5hlPbpB5Or6hVcax6MwvR1u57DXbgi
7qO9nHUC2QHSB+YRaxKk4LlEzsZcmBv46d9v4pQ6Z3U0WNytQOlp1YYNUoieAaAP
2Tka1meH7kKGYNlM9yBFZeW+xZ1rEp+WVwMCdtsLmuuZDTnZwTQznL8JcWNZWNdM
DBHepFCYDaLvMQyzn+zJTIiD0EtlLT+7ng80JLt13SzCnK0yqt6ZTUWuGHnX66JY
a9wnq3o8FHgZG1Rlvzc6PdNmruGck2Wx9ePO61WzpNpVGYpNK1gzShwZJnyrJsKV
ZJle3l+TAjLXYqi2KDxaJboPBsoVpa+0RnSLuol1uMPscgp0w5TQ5OA7eRzuD7qv
towwiQSmtVQpuqtXzgEsZ73kJZkjuPhp6ESOefl+2IvQQdZk8FOYaY6tsYaDQN3R
IfYl3Yj9V2+zwYxyYTDD3KGOjDa/N3qRGPFOHWJs5ORtOdG9WIdEGMElo44pgzte
tlJta7FmmiGhVhooFJzjnsnwvy7n4vLtssslV50nrnjhEjnucmg=
=RJ2n
-----END PGP SIGNATURE-----

--vI9PTvQDojmQmaRj--
