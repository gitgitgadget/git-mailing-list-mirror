Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F4219E8
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715835422; cv=none; b=sU+9UjaMDz83aZGkk03asyYPbqj+PjCoshR9lUfK0RXkXO5WLa1HFBmao64ZtPR2CqBNpXuCJhr0+ZwmN8utVzV+rAmS0c1KsqtizR1+kU84McSIgZ9KJUBjiyTp3a6KfcgOmet80gP59vygvB9ngZMRgLJSfsjYYCfYKZe1p7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715835422; c=relaxed/simple;
	bh=kru9mV1hzBEGP6p8OYTxDABQC70Uwzb0jjlm6ZLCZRk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gPQdaQL5tluVJuMVgIzwUrN6D3SQrNcQLo6997yvkOI/WpwgodMQtn2JqZaWc4yzfLet6PrD+BbBokr5zcXIyENmgoMvy2X7a3yPGLPf6ybh+IfytyYj9vihZzANzgGvrGTxfLHYMKaOxyMFsHVHJZ+tW3q+zq1nl5m8WH9bI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qZl7JOMX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBqRp1wl; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qZl7JOMX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBqRp1wl"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 80BD6138101E
	for <git@vger.kernel.org>; Thu, 16 May 2024 00:56:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 May 2024 00:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1715835418; x=1715921818; bh=gJdy70YJr2XQqes6pzIsjYbU3TF6EjiY
	xDf2uCeYV6E=; b=qZl7JOMX8zKxv/wadqxK37xlIOKIeQkx2faJhFuooXaGsKcj
	FfBbMEbFVX6bllaB8/sY+e43z9DYWyCUkd401DkWx4HEs0LfKGHZFkoIgCfOakUv
	jDyIsBZLwrH2QUr1YRgSwRdJPvxFkSR6H5X/Zybn3OOAwzu/L8S68Md/J/WMA5Ci
	1s/WZgVxqct+AX+upZv9LSPs/xKsV3KG9HefKScxZP0naJFPdZBp6LZpV+F7Vub8
	Qed+f6txLlQTo0OeR0t5p+hf/WeOVBe4tNVr5RpJS5/EDGP3AtFZsaolcrvdzfIw
	T7UvuDOqWdm3rPdmpzWYvVmsKOb15TQumjs+pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715835418; x=1715921818; bh=gJdy70YJr2XQqes6pzIsjYbU3TF6EjiYxDf
	2uCeYV6E=; b=jBqRp1wlU3fqJcEOmUW6IDu86xM7cbsvXDBNamJLAbuMdi48edx
	0InDXfrN6h6zSChaV4ZwQ4G60nQotOT82DrySOcE78I7OmNqNeLevWr2/o0XeFyM
	kX+dcNFxu0qPj0yKPhrurVLcCfFNixJciuJKU04bX3Ytyk20Dobu/A0CRC3knsti
	uo4CWGDXoPGUAnf3P0WshW733Pn+Y6WaPnBOnChk4tCZNAmaxwnIKuUMf+Rk2dRO
	K4SCqF42wX3DAdkhLdxEPawHnZryMLO9FgHP0/Dj4Z6vYJZR/4QACAX/+t25NKyz
	/lVBMwjshdpFWTXnMoFfSB1JFhmfustE10A==
X-ME-Sender: <xms:GpJFZku2Nvb3liE72XhXPI0kviTYPzCrLkgMDh9Kpu1KIw05H7LOCA>
    <xme:GpJFZhccLVyQezQcJb6Xqup3tTlLB2NUj6gwkLUJ5YDnUxsdq2HJi64IySODSjZe7
    PwRKsIYYfh5M1T_iw>
X-ME-Received: <xmr:GpJFZvz3BZXIx3cgzQqRnpFvgAouPiawHbFzoia2pVI2m2f-UYQfv5G4-h-a3QZHh_Ir2IZ58valUa7tdrIOTIV_ENG-tkHdQ0Ng01nCB-b7qCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegledgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GpJFZnNqijkM9iILt3jnR8jPpY8lrsb64miswXpErt7h2TpjsU692A>
    <xmx:GpJFZk9p2vOZujZMXy1B8HtnLVLj82m3b3LLlcES1hsRgl4bv50mfw>
    <xmx:GpJFZvVsVibuCGCaafd5fKu1Mg7sRkmX31YXpKszY7Asey3Oi6RfVQ>
    <xmx:GpJFZtcTKlNvFB1lQMRWW2yqoKcnJS2JgNHfuBkqh1WzQ8V1em8x_g>
    <xmx:GpJFZikx603gxi2iEEK3JjdL8JLua8WsQc0h9m84VhQL7UA_HYpKx-7I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 00:56:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c44260a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 04:56:31 +0000 (UTC)
Date: Thu, 16 May 2024 06:56:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH] completion: adapt git-config(1) to complete subcommands
Message-ID: <e0039edb9b7dce1e33c4cb6e964c50281c815e97.1715835356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eL5K9nELM2fnd8db"
Content-Disposition: inline


--eL5K9nELM2fnd8db
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With fe3ccc7aab (Merge branch 'ps/config-subcommands', 2024-05-15),
git-config(1) has gained support for subcommands. These subcommands live
next to the old, action-based mode, so that both the old and new way
continue to work.

The manpage for this command has been updated to prominently show the
subcommands, and the action-based modes are marked as deprecated. Update
Bash completion scripts accordingly to advertise subcommands instead of
actions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

I have based this on top of 19fe900cfc (The fourth batch, 2024-05-15),
which contains the config subcommands topic by now.

 contrib/completion/git-completion.bash | 38 ++++++++++++-----
 t/t9902-completion.sh                  | 56 +++++++++++++++++++-------
 2 files changed, 69 insertions(+), 25 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index 5c0ddeb3d4..ab370f8b49 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2989,22 +2989,38 @@ __git_complete_config_variable_name_and_value ()
=20
 _git_config ()
 {
-	case "$prev" in
-	--get|--get-all|--unset|--unset-all)
-		__gitcomp_nl "$(__git_config_get_set_variables)"
+	local subcommands=3D"list get set unset rename-section remove-section edi=
t"
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
+
+	if [ -z "$subcommand" ]
+	then
+		__gitcomp "$subcommands"
 		return
-		;;
-	*.*)
-		__git_complete_config_variable_value
+	fi
+
+	case "$cur" in
+	--*)
+		__gitcomp_builtin "config_$subcommand"
 		return
 		;;
 	esac
-	case "$cur" in
-	--*)
-		__gitcomp_builtin config
+
+	case "$subcommand" in
+	get)
+		__gitcomp_nl "$(__git_config_get_set_variables)"
 		;;
-	*)
-		__git_complete_config_variable_name
+	set)
+		case "$prev" in
+		*.*)
+			__git_complete_config_variable_value
+			;;
+		*)
+			__git_complete_config_variable_name
+			;;
+		esac
+		;;
+	unset)
+		__gitcomp_nl "$(__git_config_get_set_variables)"
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 963f865f27..64c9979423 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2742,30 +2742,58 @@ do
 	'
 done
=20
-test_expect_success 'git config - section' '
-	test_completion "git config br" <<-\EOF
+test_expect_success 'git config subcommand' '
+	test_completion "git config " <<-\EOF
+	edit Z
+	get Z
+	list Z
+	remove-section Z
+	rename-section Z
+	set Z
+	unset Z
+	EOF
+'
+
+test_expect_success 'git config subcommand options' '
+	test_completion "git config get --show-" <<-\EOF
+	--show-names Z
+	--show-origin Z
+	--show-scope Z
+	EOF
+'
+
+test_expect_success 'git config get' '
+	test_when_finished "rm -f cfgfile" &&
+	git config set --file cfgfile foo.bar baz &&
+	test_completion "git config get --file cfgfile foo." <<-\EOF
+	foo.bar Z
+	EOF
+'
+
+test_expect_success 'git config set - section' '
+	test_completion "git config set br" <<-\EOF
 	branch.Z
 	browser.Z
 	EOF
 '
=20
-test_expect_success 'git config - section include, includeIf' '
-	test_completion "git config inclu" <<-\EOF
+test_expect_success 'git config set - section include, includeIf' '
+	test_completion "git config set inclu" <<-\EOF
 	include.Z
 	includeIf.Z
 	EOF
 '
=20
-test_expect_success 'git config - variable name' '
-	test_completion "git config log.d" <<-\EOF
+test_expect_success 'git config set - variable name' '
+	test_completion "git config set log.d" <<-\EOF
 	log.date Z
 	log.decorate Z
 	log.diffMerges Z
 	EOF
 '
=20
-test_expect_success 'git config - variable name include' '
-	test_completion "git config include.p" <<-\EOF
+test_expect_success 'git config set - variable name include' '
+	test_completion "git config set include.p" <<-\EOF
 	include.path Z
 	EOF
 '
@@ -2776,8 +2804,8 @@ test_expect_success 'setup for git config submodule t=
ests' '
 	git submodule add ./sub
 '
=20
-test_expect_success 'git config - variable name - submodule and __git_comp=
ute_first_level_config_vars_for_section' '
-	test_completion "git config submodule." <<-\EOF
+test_expect_success 'git config set - variable name - submodule and __git_=
compute_first_level_config_vars_for_section' '
+	test_completion "git config set submodule." <<-\EOF
 	submodule.active Z
 	submodule.alternateErrorStrategy Z
 	submodule.alternateLocation Z
@@ -2788,8 +2816,8 @@ test_expect_success 'git config - variable name - sub=
module and __git_compute_fi
 	EOF
 '
=20
-test_expect_success 'git config - variable name - __git_compute_second_lev=
el_config_vars_for_section' '
-	test_completion "git config submodule.sub." <<-\EOF
+test_expect_success 'git config set - variable name - __git_compute_second=
_level_config_vars_for_section' '
+	test_completion "git config set submodule.sub." <<-\EOF
 	submodule.sub.url Z
 	submodule.sub.update Z
 	submodule.sub.branch Z
@@ -2799,8 +2827,8 @@ test_expect_success 'git config - variable name - __g=
it_compute_second_level_con
 	EOF
 '
=20
-test_expect_success 'git config - value' '
-	test_completion "git config color.pager " <<-\EOF
+test_expect_success 'git config set - value' '
+	test_completion "git config set color.pager " <<-\EOF
 	false Z
 	true Z
 	EOF
--=20
2.45.1.190.g19fe900cfc.dirty


--eL5K9nELM2fnd8db
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFkhUACgkQVbJhu7ck
PpSlrQ/9GTFOFk3plT+PfrqyeL+uIGJgtgurY3v616aOaD2N0/PMFEL8cNIGaciz
KMDAVVfTZLrJ3xUunWK5ateO4SQRFIOGgq1etKH4pzIXfd58xMO9hSR1FNdSOhm6
jy9iMdjmi/Kod3Wp6BlK7mrG7lkkWJhywADBjyohs/KN9Ac54irB8VCo+fGxzirI
pfUXxZhfvQjwemYF2Eh+152UI98RUbCeqZ9rg7LzJh/DU2q57OQ++MUtjyn96F2V
URo7RBpSMcj5M+kldIlRGReLPaDkCsXxCLFzNvuNyA3t7+CVn1eZWjJRY7I10dmG
t83acDUyTQtNSenBX1yJ7E39bGX/5GLAjDcvE/nQ3your6jGHmGyjaXmqSV/oidi
dQNVdm9IhP/CbLyaESaqkk9bxHq5hqAqzqCB8teFwg4k1faNNDKQx8dIkRFJ/PSV
wgDprHUVBINf4qfD0j5voKuqzzkbkseaTjcewuVBFCD1HeWyO0OqnykVHIIb7bw7
qHlAnot0Z/z3cH6ug8clWpJgrSoaay8fu6KMkqLCC0UT3dHNpHXhRfREa+QDWmnK
RN06l5J42lVJUMaIspgB6FJLfc/pDsJZ8A3LzEz7SLiW/joQZCORZkYIqCeAANx2
y0uqVOw/ntkLpSuIs/C77suZClnxZbADl9wmBMdt/kSTiS39CJU=
=mscx
-----END PGP SIGNATURE-----

--eL5K9nELM2fnd8db--
