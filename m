Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A0139CFC
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660870; cv=none; b=JePgKLxDb3dnHbPeyfp9n1T2VNc/BOQA1uDYz9zMFSWFPFOGqqrixUMSFsVZkkpjvKWH+w/mqcVg+8Cosw62UCTQTKXDO8DUrU/VxohJzTasOroZ3kfAvrUtfLVRN/QUL8/6rHCeVvVzV9qyFN74s+Zvy+zyCJDni4AgTLaJXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660870; c=relaxed/simple;
	bh=mUfPl3YcMykXzbX2soTdejmGsZ0omHFjmL8POun+V1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX/PApCUQTAB3f5uTh8Ie+CfmMZCD/uXhdqxqYkq8yNB8pMbDHgG/dZdfJBiffSILSNLByBhKbLZSfESACXAXfuvbguoFI/IJ4qQViiW1aabSVwuEjNThdsbWCwFpvwBI5a4Sk9cm5Ly6invUetJE9CtvMjiObYWRYC/9r/Y+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iH0ruZf5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lrgmWWQR; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iH0ruZf5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lrgmWWQR"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A805B114009E;
	Thu,  6 Jun 2024 04:01:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 04:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717660864; x=1717747264; bh=lcZK6CPYQ9
	VbS/o2CjKBWhVgTJCqi1SHzR/MW4gt2m0=; b=iH0ruZf5o9GDE53L01QKyHaJ3j
	n5pmh/D3I5Rn17qnisr68OHNf9hq97P9G+REsJTPJerbGJ/DZBHkULyAhJwj5wCD
	3hPW7b7BIQvdriyKRrS0OVVZc8Kp+zyXhc1sY4Eb7gxq5vkYpLfW0m3AGWVciHbY
	siGj2JNh+GysM3RRmf8scQcq/TLgCAv7s6d0UV45zTZRrJjhG/At0XOmJWBdGBVg
	Rwvhulx1zNO7BeT12ESAK2mi78aqh1ksLTP02T/9iRpOT30Z1FJDpb/B5TEfLwg4
	7rf3CDFMHs3Lrgm6ys2XgrsudcWN+07wGaL+D9weuM8DcB46s9n5bRNOWchg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717660864; x=1717747264; bh=lcZK6CPYQ9VbS/o2CjKBWhVgTJCq
	i1SHzR/MW4gt2m0=; b=lrgmWWQRKpoYNQAoMpBJviMO376qLPtk8XVFMg2VnknG
	ZEp2AuF2zY8Aztz3u5/658pUnQksG3banmiwHVjoHCpbw7R57JNu3Pqcrm5cL3QG
	ohVoki2x9fAep1GgdrGK3khkHyRRlvEFXuHML+RgTShQZdERaXwswoPiIEn2fbfv
	CpjfLab9CDx+ZIGyZE3CAdC55vKGx1RISZlQ7YntVVdBxbwNcz7o5pDmF2oI3arF
	dom6/GTVyM2W02Hk7YNKecbq29LDbqEjc6VMCZmJZO3JtAIccoBjolDbGrKaLtcm
	i/rdu3J0ZQwEx/A9d8lSjpYiOzxDDZvUk5o9VAbIGw==
X-ME-Sender: <xms:wGxhZri07w6DyIQiXUBFDYtY51hMZQTNJEoknImm38FDQMdn9naMhg>
    <xme:wGxhZoBeAyqbGwpdxQ8nHQ1QtazevyJuTJGNQS26SCwBel4J1v-5sayysWANmaBy3
    u6Sgcef0sgUBGtVJg>
X-ME-Received: <xmr:wGxhZrGUtv8uJnAMRJ8AhE_91n3W9S8NtPaTt2Czf67pr3ABoQhsAwhoD92h0eopi42hquWObbcJL76KwxiFEWJXCwpC6NAU731x-aLPF8nCmAkR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:wGxhZoTBY8CNocwNvTdJzcELCp1VOeS58ypgwuLg_pKG9zsrEd29wA>
    <xmx:wGxhZozBSaS04kVWRALNB2ydja28WT0WbHXczaSPcnCKBASUY6eb5w>
    <xmx:wGxhZu7MQY0BvVmIxhfivz-8_4kd2DqmFnW2YYR2d4Nv3-tD95Tsow>
    <xmx:wGxhZtymJwVks1-FfzdP8dN-OEJl-YE0U29cAQJK6Xc_A3oQYHQ88Q>
    <xmx:wGxhZk-i0WnlZYK36wcnAgmvoJ9AaPhIXoYgOidbH-vWbKeTovlY0xs_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 04:01:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2969fea1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 08:00:33 +0000 (UTC)
Date: Thu, 6 Jun 2024 10:01:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] Makefile: extract script to lint missing/extraneous
 manpages
Message-ID: <489a6eaf2d328044307f38ff23dd35ecc5a4c515.1717660597.git.ps@pks.im>
References: <cover.1717564310.git.ps@pks.im>
 <cover.1717660597.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yfPG0unCLfTA4VX6"
Content-Disposition: inline
In-Reply-To: <cover.1717660597.git.ps@pks.im>


--yfPG0unCLfTA4VX6
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
 Documentation/lint-manpages.sh | 83 ++++++++++++++++++++++++++++++++++
 Makefile                       | 36 ---------------
 3 files changed, 87 insertions(+), 36 deletions(-)
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
index 0000000000..0abb4e0b4c
--- /dev/null
+++ b/Documentation/lint-manpages.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+extract_variable () {
+	(
+		cat ../Makefile
+		cat <<EOF
+print_variable:
+	@\$(foreach b,\$($1),echo XXX \$(b:\$X=3D) YYY;)
+EOF
+	) |
+	make -C .. -f - print_variable 2>/dev/null |
+	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
+}
+
+check_missing_docs () {
+	for v in $ALL_COMMANDS
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
+		if ! test -f "$v.txt"
+		then
+			echo "no doc: $v"
+		fi
+
+		if ! sed -e '1,/^### command list/d' -e '/^#/d' ../command-list.txt |
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
+	(
+		sed -e '1,/^### command list/d' \
+		    -e '/^#/d' \
+		    -e '/guide$/d' \
+		    -e '/interfaces$/d' \
+		    -e 's/[ 	].*//' \
+		    -e 's/^/listed /' ../command-list.txt
+		make print-man1 |
+		grep '\.txt$' |
+		sed -e 's|^|documented |' \
+		    -e 's/\.txt//'
+	) | (
+		all_commands=3D"$(printf "%s " "$ALL_COMMANDS" "$BUILT_INS" "$EXCLUDED_P=
ROGRAMS" | tr '\n' ' ')"
+
+		while read how cmd
+		do
+			case " $all_commands " in
+			*" $cmd "*) ;;
+			*)
+				echo "removed but $how: $cmd";;
+			esac
+		done
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


--yfPG0unCLfTA4VX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhbLsACgkQVbJhu7ck
PpSJdA/8DBRbFXnZ/i0yaJu7GozWKPfAuW8wk8sW+cRf8F9flljEiaGuD+tyzg0w
5gFS+A7CLaa1UOkgfk1NbB/SNb1oW266UmBnU2FyF18TT23KJsWN8EJrdlwTu0Ob
04YKFnZR9oG9jIHeyHBxgtFTSvW8VIAHk4nz0nuPPKDRL8CMISF7o9SVnDzpqjyc
N8rAHlYmjd8ULxDkECLeBsKSrIfiC6AiqxRuj/NXGCrDgQRnjYMpl/yPzh3Jprz8
1eWKepT7+5MyacAhuA3Q6xOK6tCujGgbRatT4m9xUpwPtSiokC8y8MMPhH10eBaO
PO8QQLdVPZTfmgUUX980VaT28OpNEa10QyQPMOH+fh3tC1xINZpRryN+ggbUKH53
mKwxjzt7UoQYo2wbahT0dusk3Vac/j2fFafuIpBH7Sh/hqPH5avU4UZdYlJL0vDi
5HCvgALMIfjHqbcDnJPvEV1laqWqHug01x7vOWC9OisF0sdV+BWnQbvvwM955dRJ
sfg9+FISxPTzBjOuFVP+uPWIXy5ET9Dgme2gcM35R4g9XPyLCQABxTHIyPnWPn99
ZILrF2cUb6VDnlADLyMCCSJwNNrkZc/kWe49ztTHmXFWN6iKma5eL5xr4XzWaVKi
vq8rHoO5WBuSUQVs/MtCyFj1JwA/X0dPc4vbH0WfSKP1egz6YRo=
=HkaQ
-----END PGP SIGNATURE-----

--yfPG0unCLfTA4VX6--
