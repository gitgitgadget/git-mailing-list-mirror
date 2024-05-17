Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44C14F61
	for <git@vger.kernel.org>; Fri, 17 May 2024 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715926424; cv=none; b=hvFBG0fy9fNONGMa+/9sViVMxQkXdtqvXtOdHGE9ou88yoICk4EF1940AtxDVdUjSnAhTB42ozOEM9PRvpPyQhxh42ldIHAkrlUHHZBod37f/kiqa2xDn+YmjL/3BygVDrEYUiHlI0LpB42m5Uv1r1fvyfvC/l/eDgG6Jc9hWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715926424; c=relaxed/simple;
	bh=SEBA4o86meakfgt35vMUbSA4tl8KFopU1M4cVbVxTM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS/Tb43hjLM/vh47FzuL2tu9tl3UVav74oAjknZe3y4CZs0TIhstqN0L3lGjzcdlHniyaDP2fJy5kkJj4e0kpFqR+e3mh3l7QTrolTmU49JbbrQaItr9jDomWsNYzRWuhaf6ZCbRz4nrfZaq/t7utHabYIIrsFpxCu9HxxlbrvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MXvdb0LM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WtnPtl5E; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MXvdb0LM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WtnPtl5E"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 755AA180016F;
	Fri, 17 May 2024 02:13:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 17 May 2024 02:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715926421; x=1716012821; bh=HmMiOVO5Y7
	gmuZbH3gCFlfmTuwBXEm2Y1Z7koMJatAQ=; b=MXvdb0LMMOrHHnesTrMH4CLbgX
	Bd5i//d2ZFCKKuMxrftO6I3nnbiGj0anjU3zpJcX6ZR3p92A8MpZ9k0I4q7oErYA
	s+TscsOyaRB45QcIt0gtK8vbTnuw/F8RfA5ISxaH1Ppc5Lsc9puPdhoyaxzw7CaG
	UPdWgKvprY2uZxT7V81kCbHCIbS6uiZqBJQuMY5AKNlaWnJGrKIcKHbttjeDqZDH
	YDYRkxdhYc7O7Ub7hCAuN+QvvDzb19BgTFUqN6zKM0r1f3nEFASlQ+8suZGXP/+S
	hQiX6zNjaQlbaEx5p6MVSfifVqXB5zg8SPXVjr3Z2rYIpMRWgmOz0jp98GoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715926421; x=1716012821; bh=HmMiOVO5Y7gmuZbH3gCFlfmTuwBX
	Em2Y1Z7koMJatAQ=; b=WtnPtl5E7UB80dNTVUNqqNl6VWmxGqWsvK9LWDUlHtml
	2Yg3yT4KQAolyZMXc0iUTd8D5rvBba+uXQ8GpkchS0ssgeWPwV9kb+sEjrW+VSKh
	+DFlai65MEoxFdnVpuR7Qjwn7JvBgnAGj2txeh1Y3RlHew6ZjRpEzf9hZjk4P5WC
	S/sLFRH7Ml1ZLCDMYrrcKWzVIomr3+XG8Fqm8yFpJmIyxNNIbBazrJmoiLNz68Sh
	n2hi++E5GaahFBcP4h2IFE0V86bUiYaqMAJL2fT6OwoZWRQfNs9Z9IqN9GOSobwe
	vYByCSW4CIDKsnxGV1AZ+4iEPxCA62j2R60eDMenhA==
X-ME-Sender: <xms:lPVGZnu5Sm030rk3UI14NHHuI6U8SVu2i6pQUz-bbpSq-oReLF5biQ>
    <xme:lPVGZoeXz5qYq4EZHUMoj-PXx6woR0VIWZEr4ppp-ENsbnbpfW9bv5TdO5PiVlqdN
    Y3500Qp3XgVCAUHtQ>
X-ME-Received: <xmr:lPVGZqwmWyZUk7c-_wqLbcCIOtZY3J5jTScWG3xPPMoHAyMo5bvjBqmvAcROA2uJb1sjCiE5jidLfRrCvfnMDEL7KlWBkWR_MiS0YZvyTjJZk-dCwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lPVGZmNrAU0L9alVtAT1m_94DjQTnLWPZUDPbykJv-KxAi3MLIOYJQ>
    <xmx:lPVGZn9vnSWY5bcuNgTnenWe8xVC8bvYJJkbxVIpy4BEJ2QHcRnYrg>
    <xmx:lPVGZmUvL-IDeOeanLWKVAEFrQj6qqn-csK_YJ62AnmcyUOss_8CMA>
    <xmx:lPVGZod9ZWwedsLjJBc9xcol79Yf2ZSlJ1O3Quwd0hZuvujCDZJw_w>
    <xmx:lfVGZpJNsVxsUDrDR9qduyqPOWDFTMVVFrWO9CgLjFHlWqNfnevPjnL8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 02:13:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 38551ac3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 06:13:12 +0000 (UTC)
Date: Fri, 17 May 2024 08:13:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] completion: adapt git-config(1) to complete subcommands
Message-ID: <8d43dee33289969a5afbbf7635ac40b7312d8e19.1715926344.git.ps@pks.im>
References: <e0039edb9b7dce1e33c4cb6e964c50281c815e97.1715835356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4cubYuORRxgIhzGZ"
Content-Disposition: inline
In-Reply-To: <e0039edb9b7dce1e33c4cb6e964c50281c815e97.1715835356.git.ps@pks.im>


--4cubYuORRxgIhzGZ
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
Range-diff against v1:
1:  e0039edb9b ! 1:  8d43dee332 completion: adapt git-config(1) to complete=
 subcommands
    @@ contrib/completion/git-completion.bash: __git_complete_config_variab=
le_name_and_
     -	case "$prev" in
     -	--get|--get-all|--unset|--unset-all)
     -		__gitcomp_nl "$(__git_config_get_set_variables)"
    -+	local subcommands=3D"list get set unset rename-section remove-sectio=
n edit"
    -+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
    ++	local subcommands subcommand
    ++
    ++	__git_resolve_builtins "config"
    ++
    ++	subcommands=3D"$___git_resolved_builtins"
    ++	subcommand=3D"$(__git_find_subcommand "$subcommands")"
     +
     +	if [ -z "$subcommand" ]
     +	then

 contrib/completion/git-completion.bash | 42 ++++++++++++++-----
 t/t9902-completion.sh                  | 56 +++++++++++++++++++-------
 2 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index 5c0ddeb3d4..60a22d619a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2989,22 +2989,42 @@ __git_complete_config_variable_name_and_value ()
=20
 _git_config ()
 {
-	case "$prev" in
-	--get|--get-all|--unset|--unset-all)
-		__gitcomp_nl "$(__git_config_get_set_variables)"
+	local subcommands subcommand
+
+	__git_resolve_builtins "config"
+
+	subcommands=3D"$___git_resolved_builtins"
+	subcommand=3D"$(__git_find_subcommand "$subcommands")"
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

base-commit: 19fe900cfce8096b7645ec9611a0b981f6bbd154
--=20
2.45.1.190.g19fe900cfc.dirty


--4cubYuORRxgIhzGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZG9Y8ACgkQVbJhu7ck
PpSc0g//cC8eB+vM0R5Sj/6DU4+YL5sRXzInCBo1p4dU3wJntGpeD+ApAe1rtQBh
2yI1Yr/KZsL6jVKEjadQHbzle0p7V4cjuqapvhQEAH2kon8RpVx/b2u7bWf4z9GY
8h0koUaGj6CLZBIk0XPOjttzheMZqNrjhskmJVlmlfPCeabbG1SdAiTy+Q+/qim6
iTj5GYWaKE+l+PadaWUf1paBL1E5DpJHfoResGsMeZxZKd62/5K8kzHQICoYL76h
/KUayZDoW/yYOZnXIvXbxwUMYYI1dEC831bmV8Vsj/F8OXIIp5Rt44ya31G2liQW
5HCP/gd9An1vp23roZObgX7P0+lcf6nIV67J+QSAWREdL757wK35pNR3WeUzltDe
cpjj80lqaPb8H9ZQG1KmVQD9fl1vBHZ96Qrlqg/GTrzm5VSrYktwXT9BG8wWcTCi
Xw2Uz2TFjyXFrnZEPAGSh8kLtspBKRqfJTpZs4sRNfb5fKfBgdF/tRn3fQjH4wUm
Lxs8q6tIYwgon9V2EZc2ucCPKbU/f8IhXFrKad2FJOOxm4O/Gir6JSO8gEwiTMxz
iNNo6XgmPyo4cdQzP3FvTVEzTBqF10fdGCrbMUh1jeiTy2nY+6jXoUzDu/Z9OogA
Zwx2C+XEIaDwyHSnbRIqIeueoTTA2I731YELkh7zEOVi3qDo1OE=
=v4W4
-----END PGP SIGNATURE-----

--4cubYuORRxgIhzGZ--
