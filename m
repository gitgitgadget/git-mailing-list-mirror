Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707A38FB9
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564614; cv=none; b=cCv8VGdSnrmGhVQUdAI28QHwMDT2gYT6UDlnuU98ddGEeFJUemPx0P9/P2Yy+R4DyQ6ry76VSlF1dOUk9so0Xrlp8dpRh1jBh2uP0Jt/UG1sPfz0fIszZOwXIIi1Fw6rn+xk1XjJ4GhPWDSzffDPnHxEatgcbYOWMJA2Qv8mcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564614; c=relaxed/simple;
	bh=phMlx17B/ZXe96oAz0ZTN84EpbP8BhhbWwFJ1ovOUuA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roSSVOMwIstTlGCg5QEREBj3j+ZEaW496aOjwnSIfaL98VcN/VyErOeOcFbj6a/Y7CJLkupOLsQv8QwbSWZpCxZLzf7wDvVqB5FyWko+k7Lp7iO6S9ViD4X1BnlBspe/YuFIvAFVzQRiTSEHAC/sg5D02pICtqSKoPJ0aXr5OcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jeFY4rmW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f0AMXqt9; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jeFY4rmW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f0AMXqt9"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 304771C0016E
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 01:16:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 05 Jun 2024 01:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717564610; x=1717651010; bh=qwtZ48+kdg
	G+ik+Ja7v/177c2DR/CFV631Cdcd8jAFc=; b=jeFY4rmWW5mDwLV3EOoKB4vLmd
	Tx51MqFd3FzljPpX0OmR4Qt2sc8FfQX+6mk7Gh8CRYhKgwDxOOT8IqQMKfuDyVuf
	BNCDMm6XD8Dc7UHD+mQp80/j7aDIGRwDnM7mohzUz1M5FOcrAP5PI0syBzXb5VLz
	CpRTXcvr7jZa/+nxI+9U3krTT8tf0OiQE2ALprpwhJ80bLwTKCHU99xOTQWY+znu
	LxiY8hxnFlxNWnuOtXxWJz1ossQbQ0SbCW0N/hA6s/EyWDRuVp64L7XqDDE6gFEU
	0EKaWrMldN6WycUvhRAVI9wGMxhSTEoA8DdDaPlhAbNsD+M2fti1s8Vw216Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717564610; x=1717651010; bh=qwtZ48+kdgG+ik+Ja7v/177c2DR/
	CFV631Cdcd8jAFc=; b=f0AMXqt9Cf1fBwvOXHYt+klfmm4wh7z4GDcpODFX8JIE
	8DMwMRNozIIGC8y4K4HNbPrfQlO2lnAIB3HndKypC2REsD0jSMAy4FqtuKVZpNo9
	JWa2Jjn3Ixkr3uuI3mkIXBsLwGzFhQ33dJSjzv5H2/hJuntMwKDZLnEvtSNYphrV
	8skqvHXO+4e1gjbdWQugqaLlUD0knmGmmAUFK2J9ZdAMrUHJ4fibBPVQ1l86FSsQ
	DUrK44y2kuhfqYDPf1l6q4n6RfjE7bnMfkd6+Dul7hiJik6VhGCQoSxqP+bT8WD7
	w+Sm225Oojo8p/arn2N2gG+P4dGXgFwrW5mabvXiNQ==
X-ME-Sender: <xms:wvRfZpSQJvpNDRCyj4dE6BCLwn0CAcDkwt50D5i170c34qepAcFbNA>
    <xme:wvRfZiyjthD1WHC3jN1JQT8zMW7VMvb4qQb8c3iB-iLS_jz4NzAwsTJuSn4BShg8B
    M19SssncH38wqPJlw>
X-ME-Received: <xmr:wvRfZu1ZTcAmtg9PZqiiZ-DJsKEBMQVu4j8dZYvN5qehX-NJbZHuFKSPLWLd_jW8exnStw7-dZ_REiVeYDusAb31OYSr01ArCFeRWVeGyxIlWbwftHU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:wvRfZhCkGREGhDpUeypLQ-pw0VqJPGhvsmTvfahNnlRnyFdovM1J_g>
    <xmx:wvRfZij_VKz7SUburdIsTqJaKajY9TRJOg6jIy-qYAvFHXusDzQTWg>
    <xmx:wvRfZlowNScWfS7vGClNGgBWj49fa-MIT0PKZ51zDUMDANlxWCacYg>
    <xmx:wvRfZtgDrIz5jOqfPFbGU_TQ2c9zx1GAdYD2DxjNGN5kYIYliPTadA>
    <xmx:wvRfZmYh2-IFuidbGLkM9xb_yb3-H8OTXZeyQZ82vjfOn5mH3zu09CMq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 5 Jun 2024 01:16:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 13b6805c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 5 Jun 2024 05:16:21 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:16:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/4] Makefile: extract script to lint missing/extraneous
 manpages
Message-ID: <b06088a2ff65a3455f0f5db2a9b752901f2af14b.1717564310.git.ps@pks.im>
References: <cover.1717564310.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KmsZ8QPD7JvPAvhu"
Content-Disposition: inline
In-Reply-To: <cover.1717564310.git.ps@pks.im>


--KmsZ8QPD7JvPAvhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "check-docs" target of our top-level Makefile fulfills two different
roles. For one it runs the "lint-docs" target of the "Documentation/"
Makefile. And second it performs some checks of whether there are any
manpages that are missing or extraneous via some inline scripts.

The second set of checks feels quite misplaced in the top-level Makefile
as it would fit in much better with our "lint-docs" target. Back when
the checks were introduced in 8c989ec528 (Makefile: $(MAKE) check-docs,
2006-04-13), that target did not yet exist though.

Furthermore, the script makes use of several Makefile variables which
are defined in the top-level Makefile, which makes it hard to access
their contents from elsewhere. There is a trick though that we already
use in "check-builtins.sh" to gain access: we can create an ad-hoc
Makefile that has an extra target to print those variables.

Pull out the script into a separate "lint-manpages.sh" script by using
that trick. Wire up that script via the "lint-docs" target. For one,
normal shell scripts are way easier to reason about than those which are
embedded in a Makefile. Second, it allows one to easily execute the
script standalone without any of the other checks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile         |  4 ++
 Documentation/lint-manpages.sh | 82 ++++++++++++++++++++++++++++++++++
 Makefile                       | 36 ---------------
 3 files changed, 86 insertions(+), 36 deletions(-)
 create mode 100755 Documentation/lint-manpages.sh

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a04da672c6..a3868a462f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -485,12 +485,16 @@ $(LINT_DOCS_FSCK_MSGIDS): ../fsck.h fsck-msgids.txt
=20
 lint-docs-fsck-msgids: $(LINT_DOCS_FSCK_MSGIDS)
=20
+lint-docs-manpages:
+	$(QUIET_GEN)./lint-manpages.sh
+
 ## Lint: list of targets above
 .PHONY: lint-docs
 lint-docs: lint-docs-fsck-msgids
 lint-docs: lint-docs-gitlink
 lint-docs: lint-docs-man-end-blurb
 lint-docs: lint-docs-man-section-order
+lint-docs: lint-docs-manpages
=20
 ifeq ($(wildcard po/Makefile),po/Makefile)
 doc-l10n install-l10n::
diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
new file mode 100755
index 0000000000..f720a3f3d6
--- /dev/null
+++ b/Documentation/lint-manpages.sh
@@ -0,0 +1,82 @@
+#!/usr/bin/env bash
+
+cd "$(dirname "${BASH_SOURCE[0]}")"/..
+
+extract_variable () {
+	(
+		cat Makefile
+		cat <<EOF
+print_variable:
+	\$(foreach b,\$($1),echo XXX \$(b:\$X=3D) YYY;)
+EOF
+	) |
+	make -f - print_variable 2>/dev/null |
+	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
+}
+
+check_missing_docs () {
+	for v in $BUILT_INS
+	do
+		case "$v" in
+		git-merge-octopus) continue;;
+		git-merge-ours) continue;;
+		git-merge-recursive) continue;;
+		git-merge-resolve) continue;;
+		git-merge-subtree) continue;;
+		git-fsck-objects) continue;;
+		git-init-db) continue;;
+		git-remote-*) continue;;
+		git-stage) continue;;
+		git-legacy-*) continue;;
+		git-?*--?* ) continue ;;
+		esac
+
+		if ! test -f "Documentation/$v.txt"
+		then
+			echo "no doc: $v"
+		fi
+
+		if ! sed -e '1,/^### command list/d' -e '/^#/d' command-list.txt |
+			grep -q "^$v[ 	]"
+		then
+			case "$v" in
+			git)
+				;;
+			*)
+				echo "no link: $v";;
+			esac
+		fi
+	done
+}
+
+check_extraneous_docs () {
+	local commands=3D"$(printf "%s\n" "$ALL_COMMANDS" "$BUILT_INS" "$EXCLUDED=
_PROGRAMS")"
+
+	while read how cmd
+	do
+		if ! [[ $commands =3D *"$cmd"* ]]
+		then
+			echo "removed but $how: $cmd"
+		fi
+	done < <(
+		sed -e '1,/^### command list/d' \
+		    -e '/^#/d' \
+		    -e '/guide$/d' \
+		    -e '/interfaces$/d' \
+		    -e 's/[ 	].*//' \
+		    -e 's/^/listed /' command-list.txt
+		make -C Documentation print-man1 |
+		grep '\.txt$' |
+		sed -e 's|^|documented |' \
+		    -e 's/\.txt//'
+	)
+}
+
+BUILT_INS=3D"$(extract_variable BUILT_INS)"
+ALL_COMMANDS=3D"$(extract_variable ALL_COMMANDS)"
+EXCLUDED_PROGRAMS=3D"$(extract_variable EXCLUDED_PROGRAMS)"
+
+{
+	check_missing_docs
+	check_extraneous_docs
+} | sort
diff --git a/Makefile b/Makefile
index 59d98ba688..84e2aa9686 100644
--- a/Makefile
+++ b/Makefile
@@ -3757,42 +3757,6 @@ ALL_COMMANDS +=3D scalar
 .PHONY: check-docs
 check-docs::
 	$(MAKE) -C Documentation lint-docs
-	@(for v in $(patsubst %$X,%,$(ALL_COMMANDS)); \
-	do \
-		case "$$v" in \
-		git-merge-octopus | git-merge-ours | git-merge-recursive | \
-		git-merge-resolve | git-merge-subtree | \
-		git-fsck-objects | git-init-db | \
-		git-remote-* | git-stage | git-legacy-* | \
-		git-?*--?* ) continue ;; \
-		esac ; \
-		test -f "Documentation/$$v.txt" || \
-		echo "no doc: $$v"; \
-		sed -e '1,/^### command list/d' -e '/^#/d' command-list.txt | \
-		grep -q "^$$v[ 	]" || \
-		case "$$v" in \
-		git) ;; \
-		*) echo "no link: $$v";; \
-		esac ; \
-	done; \
-	( \
-		sed -e '1,/^### command list/d' \
-		    -e '/^#/d' \
-		    -e '/guide$$/d' \
-		    -e '/interfaces$$/d' \
-		    -e 's/[ 	].*//' \
-		    -e 's/^/listed /' command-list.txt; \
-		$(MAKE) -C Documentation print-man1 | \
-		grep '\.txt$$' | \
-		sed -e 's|^|documented |' \
-		    -e 's/\.txt//'; \
-	) | while read how cmd; \
-	do \
-		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS=
)) " in \
-		*" $$cmd "*)	;; \
-		*) echo "removed but $$how: $$cmd" ;; \
-		esac; \
-	done ) | sort
=20
 ### Make sure built-ins do not have dups and listed in git.c
 #
--=20
2.45.2.409.g7b0defb391.dirty


--KmsZ8QPD7JvPAvhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZf9L4ACgkQVbJhu7ck
PpT9Qw/8DGi88u/GnGd74ruW+kh2Sist5aNo87Cj6nLG3Y8lplJfqz28R5bcKAaN
AhRJ8ALSCRqxISqJlRhAiHboGBDWl6x3KThnKNDMLZlJkF+BXofeP6OgHWMMHlVp
M0XDs0u0gx6e5we3SBiMt9KsIz/LQIF7pdYYB6YDyqBhrqUvuTmKmdgqyj7kCcj5
MUohuN2VPt+qYfaUUvelELIAUJDw/smA0mj7tJgMDCLPfg4oKQTRsiTESHqnHrof
H1cgkDhUUpq/Par7+R1ZlkevZxIh6oGD1VKz/xTKtusvuOCJuh0tpyImXS01UzDh
DotySYhFqbwaMtbthAE2Jd103fRHhHvBzb58418Mrk4IXBVm6mxtUv9R5DwE67Fx
/gvrk5mrTcuZ4Wrk9fXPUq7i0ZhQSEy9KQnMIOP8jBmpcWCG4Zus3TSGZhufY/a1
zVLeBtAJisGb5f699O6ITflfO2aZjYUzhsq+32Sxfw6IPwCrHxPKx79EPaWEQH0N
PJT0kraqJVt1yZyLcY2yj/3RssznSPVIm3pHx85mcEkYM2u0g11J+QAjpX5Mc7ac
Pv+PQ1QcGyCbbaCddh8028+qKnfR+uEmeZC3MGoCpG3oyfXLO1C2WqqprhaaC+ks
/EY/c9ewR759xcD8G5WjOcTOMCLS/XBU9NIs3AF+zYNFak4J/gU=
=jeej
-----END PGP SIGNATURE-----

--KmsZ8QPD7JvPAvhu--
