Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D6381BA
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660866; cv=none; b=VPqkgkXt9LnfkWk/cjS8u8PAjp18tt00lRqKOPRl6Uf9DKhwIzNZz9BI5NWFxaTIwX07WxjnsqwwsxjScXR9gmfoFy8gHpKpqzsk5jTKTopnVsn6PEkCBHov5k8izQawMLgtAREhOyPScDiKq/Uf2TOm+B7gD22Jm0E4Fxj9avM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660866; c=relaxed/simple;
	bh=ig0puIqhUyt8EAH3Du+sOm4NTkYBmM5vXAU8UAkBlUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2za3Gjj7/P4wBx3jfE1wl2oZuU1LP0vCn/rSYjt3M2jKwhq/nsbPejMqxO/V6qol4P+oQkrNoUwoQnUB3FrVR2/9nUbu2wVaxnnuyl7HQT34wrvKvwYDkFq/HYeMPOLrKD0lB7j9qA4Mgvov+LdD4tugrT2zBoK7FktYxjBiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KOt57JUB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDGVjAOT; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KOt57JUB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDGVjAOT"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3677F1380114;
	Thu,  6 Jun 2024 04:01:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 04:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717660861; x=1717747261; bh=4heMV7Smaa
	0W3q+kchydLfOczwFEcAQmh0wIrzyw/R8=; b=KOt57JUBThgOwa6EZ4MAclLtlm
	0K8GdMRw43Xg5H6uE5oEbDpiLWmA30FScvayfxvJtWdJo3IQXXOZUwI0k2gjAVF+
	zpzPR/fMarNwDqx+Scor2akcSNvDdK7qNTu3SEJR8ZCc6750unmjyrQ7Lyo1irVU
	HrSMv4/QEXkDu6RelmRl5iYuMeROl8RqF/Js6c5dMEP0OhPlYZ8UZi4VjmI5JGyu
	22DnhJ8gQde425JBBUhxgQMdtXELzGfXVRC64nmZRVeN0hhBCQVr10zyoBAfTeEY
	ZQ04p8dSBNfld0zyTgr+hm5754/+7znP8/e3CPifebd8Q3BZRMAkN5pX0rJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717660861; x=1717747261; bh=4heMV7Smaa0W3q+kchydLfOczwFE
	cAQmh0wIrzyw/R8=; b=GDGVjAOTvcTs98aY31nnruqTFm0Xp8UeHP59Z1vTbNOy
	W0WMC001mSJzj0G4SfuHs21XpkAA7TZPJSShezf0HPKTwQeIBay43btxfy5xCHrq
	HQrqQond7h2YyfkLjMeO39xV3qbWuX43E9E+eJbMCMyI1L/QEoRa9vHJZJhpfhXK
	dTOUqM6UPMmzC4V+3230JmokIea+9SWCeADXnXRkecpkfQzrZhMIDW39oxNHKZTJ
	XRGenH8CRSd1HIzSAWlHDxXskzdaq+uH55GdHRaAzdvgb1UnwE7xsEfel/Wt/imz
	oVcT4zXH7J8irwuROA4aXimFiK9iyTqRkJ7kFXwZYw==
X-ME-Sender: <xms:vGxhZtjJmH8IfJPekJcxNW3XbnXvB4fxpxV4YBDzKg-OAY54VU-HQw>
    <xme:vGxhZiAdfET-KCc3L9PxT0OyXWhd8RxzJ1xL-nCr50se431dloTaKWbSzEIX8aUrb
    e5kCzDqxOl2w1vboA>
X-ME-Received: <xmr:vGxhZtF-4zsDhwNaUjmWtyHVOuuhkpSLGUqF-w8YHofmIOtmNjL3puJs0yVRZbPraFupAffcBJttdX5NS8Vg-PTaxx8YWxqc4LW55PeF_CJj-VY->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:vWxhZiQxXE92VmbVMY3zM9tTA2i1Y5fnxY4JEoK2485nJd4HaAnIAA>
    <xmx:vWxhZqwI218jdv0cgq0SiDzF5i0q_CQii5qB8-5cPWyK1__8vCJcSg>
    <xmx:vWxhZo7Vg0Exf3_pxRXxQ-cKZq-YfStQvTerbN0Ce9hI8HwFkn8chA>
    <xmx:vWxhZvwShcw60LV519ONKnYHvQCXfb5tQnbxyxJiC0vrU6OK1c2eXQ>
    <xmx:vWxhZu8e0Ehlex8k7-cMGb06u1syZK9cltOtWef4JJFwB9nUKGUfVzze>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 04:01:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4a72b63d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 08:00:28 +0000 (UTC)
Date: Thu, 6 Jun 2024 10:00:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] Documentation: improve linting for manpage existence
Message-ID: <cover.1717660597.git.ps@pks.im>
References: <cover.1717564310.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VY1qME50V0lJWPp1"
Content-Disposition: inline
In-Reply-To: <cover.1717564310.git.ps@pks.im>


--VY1qME50V0lJWPp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that improves linting for
the existence and/or absence of manpages.

Changes compared to v1:

  - Converted the extracted script to be compatible with POSIX shells.

  - Fix an empty line being printed when there are no findings.

  - Silence the patched-in Makefile recipe, which otherwise leads to one
    value existing twice in the converted output.

  - Fix `check_missing_docs()` to use `ALL_COMMANDS`, not `BUILT_INS`.

Thanks!

Patrick

Patrick Steinhardt (4):
  Makefile: extract script to lint missing/extraneous manpages
  Documentation/lint-manpages: bubble up errors
  gitlab-ci: add job to run `make check-docs`
  ci/test-documentation: work around SyntaxWarning in Python 3.12

 .gitlab-ci.yml                 |   9 +++
 Documentation/Makefile         |   4 ++
 Documentation/lint-manpages.sh | 108 +++++++++++++++++++++++++++++++++
 Makefile                       |  36 -----------
 ci/test-documentation.sh       |   1 +
 5 files changed, 122 insertions(+), 36 deletions(-)
 create mode 100755 Documentation/lint-manpages.sh

Range-diff against v1:
1:  b06088a2ff ! 1:  489a6eaf2d Makefile: extract script to lint missing/ex=
traneous manpages
    @@ Documentation/Makefile: $(LINT_DOCS_FSCK_MSGIDS): ../fsck.h fsck-msg=
ids.txt
    =20
      ## Documentation/lint-manpages.sh (new) ##
     @@
    -+#!/usr/bin/env bash
    -+
    -+cd "$(dirname "${BASH_SOURCE[0]}")"/..
    ++#!/bin/sh
     +
     +extract_variable () {
     +	(
    -+		cat Makefile
    ++		cat ../Makefile
     +		cat <<EOF
     +print_variable:
    -+	\$(foreach b,\$($1),echo XXX \$(b:\$X=3D) YYY;)
    ++	@\$(foreach b,\$($1),echo XXX \$(b:\$X=3D) YYY;)
     +EOF
     +	) |
    -+	make -f - print_variable 2>/dev/null |
    ++	make -C .. -f - print_variable 2>/dev/null |
     +	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
     +}
     +
     +check_missing_docs () {
    -+	for v in $BUILT_INS
    ++	for v in $ALL_COMMANDS
     +	do
     +		case "$v" in
     +		git-merge-octopus) continue;;
    @@ Documentation/lint-manpages.sh (new)
     +		git-?*--?* ) continue ;;
     +		esac
     +
    -+		if ! test -f "Documentation/$v.txt"
    ++		if ! test -f "$v.txt"
     +		then
     +			echo "no doc: $v"
     +		fi
     +
    -+		if ! sed -e '1,/^### command list/d' -e '/^#/d' command-list.txt |
    ++		if ! sed -e '1,/^### command list/d' -e '/^#/d' ../command-list.txt=
 |
     +			grep -q "^$v[ 	]"
     +		then
     +			case "$v" in
    @@ Documentation/lint-manpages.sh (new)
     +}
     +
     +check_extraneous_docs () {
    -+	local commands=3D"$(printf "%s\n" "$ALL_COMMANDS" "$BUILT_INS" "$EXC=
LUDED_PROGRAMS")"
    -+
    -+	while read how cmd
    -+	do
    -+		if ! [[ $commands =3D *"$cmd"* ]]
    -+		then
    -+			echo "removed but $how: $cmd"
    -+		fi
    -+	done < <(
    ++	(
     +		sed -e '1,/^### command list/d' \
     +		    -e '/^#/d' \
     +		    -e '/guide$/d' \
     +		    -e '/interfaces$/d' \
     +		    -e 's/[ 	].*//' \
    -+		    -e 's/^/listed /' command-list.txt
    -+		make -C Documentation print-man1 |
    ++		    -e 's/^/listed /' ../command-list.txt
    ++		make print-man1 |
     +		grep '\.txt$' |
     +		sed -e 's|^|documented |' \
     +		    -e 's/\.txt//'
    ++	) | (
    ++		all_commands=3D"$(printf "%s " "$ALL_COMMANDS" "$BUILT_INS" "$EXCLU=
DED_PROGRAMS" | tr '\n' ' ')"
    ++
    ++		while read how cmd
    ++		do
    ++			case " $all_commands " in
    ++			*" $cmd "*) ;;
    ++			*)
    ++				echo "removed but $how: $cmd";;
    ++			esac
    ++		done
     +	)
     +}
     +
2:  b39a780d33 ! 2:  9f21c305b9 Documentation/lint-manpages: bubble up erro=
rs
    @@ Commit message
    =20
      ## Documentation/lint-manpages.sh ##
     @@ Documentation/lint-manpages.sh: EOF
    + 	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
      }
     =20
    - check_missing_docs () {
    -+	local ret=3D0
    +-check_missing_docs () {
    ++check_missing_docs () (
    ++	ret=3D0
     +
    - 	for v in $BUILT_INS
    + 	for v in $ALL_COMMANDS
      	do
      		case "$v" in
     @@ Documentation/lint-manpages.sh: check_missing_docs () {
    - 		if ! test -f "Documentation/$v.txt"
    + 		if ! test -f "$v.txt"
      		then
      			echo "no doc: $v"
     +			ret=3D1
      		fi
     =20
    - 		if ! sed -e '1,/^### command list/d' -e '/^#/d' command-list.txt |
    + 		if ! sed -e '1,/^### command list/d' -e '/^#/d' ../command-list.txt=
 |
     @@ Documentation/lint-manpages.sh: check_missing_docs () {
      			git)
      				;;
    @@ Documentation/lint-manpages.sh: check_missing_docs () {
      			esac
      		fi
      	done
    +-}
     +
    -+	return $ret
    - }
    ++	exit $ret
    ++)
     =20
      check_extraneous_docs () {
    - 	local commands=3D"$(printf "%s\n" "$ALL_COMMANDS" "$BUILT_INS" "$EXC=
LUDED_PROGRAMS")"
    -+	local ret=3D0
    -=20
    - 	while read how cmd
    - 	do
    - 		if ! [[ $commands =3D *"$cmd"* ]]
    - 		then
    - 			echo "removed but $how: $cmd"
    -+			ret=3D1
    - 		fi
    - 	done < <(
    - 		sed -e '1,/^### command list/d' \
    + 	(
     @@ Documentation/lint-manpages.sh: check_extraneous_docs () {
    - 		sed -e 's|^|documented |' \
      		    -e 's/\.txt//'
    - 	)
    + 	) | (
    + 		all_commands=3D"$(printf "%s " "$ALL_COMMANDS" "$BUILT_INS" "$EXCLU=
DED_PROGRAMS" | tr '\n' ' ')"
    ++		ret=3D0
    +=20
    + 		while read how cmd
    + 		do
    + 			case " $all_commands " in
    + 			*" $cmd "*) ;;
    + 			*)
    +-				echo "removed but $how: $cmd";;
    ++				echo "removed but $how: $cmd"
    ++				ret=3D1;;
    + 			esac
    + 		done
     +
    -+	return $ret
    ++		exit $ret
    + 	)
      }
     =20
    - BUILT_INS=3D"$(extract_variable BUILT_INS)"
    +@@ Documentation/lint-manpages.sh: BUILT_INS=3D"$(extract_variable BUI=
LT_INS)"
      ALL_COMMANDS=3D"$(extract_variable ALL_COMMANDS)"
      EXCLUDED_PROGRAMS=3D"$(extract_variable EXCLUDED_PROGRAMS)"
     =20
    @@ Documentation/lint-manpages.sh: check_extraneous_docs () {
     +)
     +ret=3D$?
     +
    -+echo "$findings" | sort
    ++printf "%s" "$findings" | sort
     +
     +exit $ret
3:  a44d57a732 =3D 3:  d6d3628797 gitlab-ci: add job to run `make check-doc=
s`
4:  c758b45282 =3D 4:  c13fed9ebf ci/test-documentation: work around Syntax=
Warning in Python 3.12
--=20
2.45.2.409.g7b0defb391.dirty


--VY1qME50V0lJWPp1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhbLcACgkQVbJhu7ck
PpThFg//Rzz0OkgwQYqPLnsWDEJa1e5UixHK29ZJcA3n8aHSqfS+h0Ma3iIO8PIL
pghtqhwUSh1pXV2PyZj9uurwBDyKSHRNwMUFRdSpIiuwuwrdsbL8E8ioQ28rqvZG
bYgS/ciGZpsBMQyx3O4zyCTEBe8NrELgyndF2X70GGewmdVBcgZEOFvNCUEY8E3A
YzrdWmga7mlAc8aeGflZdNr8mFYkCxwxzIoT+dS061lht6QOa+0wrr5X3PR8l0tt
FauT5WHxsA6p0Lc+NoNQYLnPvkMVbdFcApQqpsxiWgk2GXutzwVcLsC/YcKz/7kO
WNqVoXE7CpshUbDRmSwT+oleotypLc0jj1Cl1iLKQu7lNbs3U5gzL2+QjA0EmRxR
wiWpaYVaskQvh9NsDn0iKns9E1puGLlHGBcyKUUFbSo4OVSZteh9ZoxZM6l3d/eu
tPrwxcLR+wS3fqwdBs9kWiqiowAJXaGSc69KMOuqYQ+ECqbFwuPGgV5UL5aiN1bS
LSGPuSv/USPxuiQlWzakW40QZ6suqTMVe41YJu/zcifXs56d+9l0VIwWLOIJmibI
03oQouAVy1hYXgbMyq/wBZ/Y+0vFUb5RdLlhlA0+NpSZvSRc/ew+k05bvU/4/hgc
2ijTgVw24buG6Fw/41RnwbQtQNw7evfBmrhkE2VIYEOicEA+lPw=
=suKa
-----END PGP SIGNATURE-----

--VY1qME50V0lJWPp1--
