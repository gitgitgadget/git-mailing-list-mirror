Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E313AC8
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985548; cv=none; b=WoFD4H9tvbas9NnTubFBDUoXruakvwkmabANFEDr6KZLU04FrHo9Ir+6lO9bUD6pmMe/6DgEDTBJB1rSV+YhpGmjm0AzfI1p3JBzsuFa6bpi382LF3WEpS5hThEIfHgXasah7NBwcdPQgVv5uoRJ+4rY5ot2NRFvyp7IMBdByc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985548; c=relaxed/simple;
	bh=G5L1wuwLq5fKmEYAyNx4ennCK7vR0hj+u2G7Iwz1NPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewYVKGFFbGeKFDxb8CizV3FRWXDoSXwh3Mhj8dzByk/u1IXnJOr60B5FfUD1xanwXednnTaef+KBoHHS9gVtVYHtiZii42PuDGRyFQKZ5IYBry/D6Np/66Mk0sj0pdCNgQPpZl0toU/DJEsYisFAdgH+wa9kIVeCQwA2+x4S898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bjwpguUk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WhW8m6gt; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bjwpguUk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WhW8m6gt"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 9FFC45C0004;
	Thu, 15 Feb 2024 03:25:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 15 Feb 2024 03:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707985545; x=1708071945; bh=bS4mabOu4s
	agSw7vttX41o6TLulkVtfFfpRgYsKMV/I=; b=bjwpguUksXg4aWb2AEai+3v8dj
	mFmQjKvEd8Gnyj2opYfrnMk3sMzMmRmck1GaAf0SB8eBsAiRtytORVRJibm+BVNS
	NEds+QPNYIWmMc2eNJqC5PRGgK4E5N8yz5e1aAHJKkIarI14bm0OuyK51rWbZT1W
	bQILfLCzb+MeHO8GbFYP2zHgtq0qVeXpVExuYKnxVEv6E8f/Bv29IUzTyYX9ebnW
	GH6KkqBkCTTOPKvyAQmt7uqWbtPV3zs1VWkyG1pyIB5eGuZuEXN1EzHOYiB0HH+u
	peWNLITt94oqprj4tzamDo18Uk1DZpZ+57pOAtvfL/CQ4c6iZqk3zrARMv0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707985545; x=1708071945; bh=bS4mabOu4sagSw7vttX41o6TLulk
	VtfFfpRgYsKMV/I=; b=WhW8m6gt9f+GjdydRPoKa4SoqkPKUvoYSzbMy+92IrvJ
	6vhwi1b82DOCPL1w8WP1aMrKFCz3A0/06aR5/V1ycn95dHzmZG45OSpcKOZ6QJe3
	5A9CUmsqlLUdxTjmOvoiR9/QRhcEG0x6fYZtezckHh70cbkppwlg/pOR8UwVLJcp
	ioZcylxt00ALz6oHt58XBCMnpGjdd/TpAaJ1bt3uJYV6qjJ+X7f0LUOtsZLkIknD
	lsEus+qHnu+AQ+AkaXdf6A9zekVWo1NfZ1lcMKjeDcpI+sG8hCjY7wXN4DCGZQB6
	LoZ53Pb4SlbsSWletcxNu2PLGyi+Tj9rVT7aUYrm3w==
X-ME-Sender: <xms:icrNZTMeyXVfI0yWOPgB-89YvY86NzLg1FbjQ0e2RNj2bYAwAj4BRg>
    <xme:icrNZd_JvTALjXK9BmXXp9bnHE11X7ohmGDFBSXZLTWoD1RHF3kvWa508e05MGKtu
    Kc-domoMW_d1Q0W5g>
X-ME-Received: <xmr:icrNZSSmIbdxoO6SOiq96Y7mV4C1xwkJs9mYTJMJdw6mSenoqm2WCeYCR80-n5JBV4jCc_C7-AqrTLXGhj8mjcRk9U9mWuFTeOFR35boaWpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:icrNZXuBq9q-xEwBxKRtQ7dsF0FwBJnTb6eSjQNLlmkx5KXJ1O47Jg>
    <xmx:icrNZbdnAnUXz7gPDwvicpaOGqEIbEc9o6TGsXAONqt44NHmMq2Kyg>
    <xmx:icrNZT0vz8oN25GJxZ30MFHKi8WTKA1JYoMZSaRjvX6vaO4gSiBQiA>
    <xmx:icrNZcoU-Pa6XothgyuWieOEbZlvKWR4rFrg4QqhaHu6npqc1MLKww>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 03:25:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07fe5bce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 08:21:52 +0000 (UTC)
Date: Thu, 15 Feb 2024 09:25:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] t1404: make D/F conflict tests compatible with
 reftable backend
Message-ID: <212949689fb89397c909cf83cfb8670da6d7ca3a.1707985173.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
 <cover.1707985173.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kfZxRXvqFKKbBMyc"
Content-Disposition: inline
In-Reply-To: <cover.1707985173.git.ps@pks.im>


--kfZxRXvqFKKbBMyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the tests in t1404 exercise whether Git correctly aborts
transactions when there is a directory/file conflict with ref names.
While these tests are all marked to require the "files" backend, they do
in fact apply to the "reftable" backend as well.

This may not make much sense on the surface: D/F conflicts only exist
because the "files" backend uses the filesystem to store loose refs, and
thus the restriction theoretically shouldn't apply to the "reftable"
backend. But for now, the "reftable" backend artificially restricts the
creation of such conflicting refs so that it is a drop-in replacement
for the "files" backend. This also ensures that the "reftable" backend
can easily be used on the server side without causing issues for clients
which only know to use the "files" backend.

The only difference between the "files" and "reftable" backends is a
slightly different error message. Adapt the tests to accomodate for this
difference and remove the REFFILES prerequisite so that we start testing
with both backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1404-update-ref-errors.sh | 37 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 00b7013705..98e9158bd2 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -92,9 +92,6 @@ df_test() {
 	else
 		delname=3D"$delref"
 	fi &&
-	cat >expected-err <<-EOF &&
-	fatal: cannot lock ref $SQ$addname$SQ: $SQ$delref$SQ exists; cannot creat=
e $SQ$addref$SQ
-	EOF
 	$pack &&
 	if $add_del
 	then
@@ -103,7 +100,7 @@ df_test() {
 		printf "%s\n" "delete $delname" "create $addname $D"
 	fi >commands &&
 	test_must_fail git update-ref --stdin <commands 2>output.err &&
-	test_cmp expected-err output.err &&
+	grep "fatal:\( cannot lock ref $SQ$addname$SQ:\)\? $SQ$delref$SQ exists; =
cannot create $SQ$addref$SQ" output.err &&
 	printf "%s\n" "$C $delref" >expected-refs &&
 	git for-each-ref --format=3D"%(objectname) %(refname)" $prefix/r >actual-=
refs &&
 	test_cmp expected-refs actual-refs
@@ -191,69 +188,69 @@ test_expect_success 'one new ref is a simple prefix o=
f another' '
=20
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents add long + delete shor=
t' '
+test_expect_success 'D/F conflict prevents add long + delete short' '
 	df_test refs/df-al-ds --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents add short + delete lon=
g' '
+test_expect_success 'D/F conflict prevents add short + delete long' '
 	df_test refs/df-as-dl --add-del foo foo/bar
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents delete long + add shor=
t' '
+test_expect_success 'D/F conflict prevents delete long + add short' '
 	df_test refs/df-dl-as --del-add foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents delete short + add lon=
g' '
+test_expect_success 'D/F conflict prevents delete short + add long' '
 	df_test refs/df-ds-al --del-add foo foo/bar
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents add long + delete shor=
t packed' '
+test_expect_success 'D/F conflict prevents add long + delete short packed'=
 '
 	df_test refs/df-al-dsp --pack --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents add short + delete lon=
g packed' '
+test_expect_success 'D/F conflict prevents add short + delete long packed'=
 '
 	df_test refs/df-as-dlp --pack --add-del foo foo/bar
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents delete long packed + a=
dd short' '
+test_expect_success 'D/F conflict prevents delete long packed + add short'=
 '
 	df_test refs/df-dlp-as --pack --del-add foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents delete short packed + =
add long' '
+test_expect_success 'D/F conflict prevents delete short packed + add long'=
 '
 	df_test refs/df-dsp-al --pack --del-add foo foo/bar
 '
=20
 # Try some combinations involving symbolic refs...
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + de=
lete short' '
+test_expect_success 'D/F conflict prevents indirect add long + delete shor=
t' '
 	df_test refs/df-ial-ds --sym-add --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + in=
direct delete short' '
+test_expect_success 'D/F conflict prevents indirect add long + indirect de=
lete short' '
 	df_test refs/df-ial-ids --sym-add --sym-del --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect add short + i=
ndirect delete long' '
+test_expect_success 'D/F conflict prevents indirect add short + indirect d=
elete long' '
 	df_test refs/df-ias-idl --sym-add --sym-del --add-del foo foo/bar
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect delete long +=
 indirect add short' '
+test_expect_success 'D/F conflict prevents indirect delete long + indirect=
 add short' '
 	df_test refs/df-idl-ias --sym-add --sym-del --del-add foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + de=
lete short packed' '
+test_expect_success 'D/F conflict prevents indirect add long + delete shor=
t packed' '
 	df_test refs/df-ial-dsp --sym-add --pack --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect add long + in=
direct delete short packed' '
+test_expect_success 'D/F conflict prevents indirect add long + indirect de=
lete short packed' '
 	df_test refs/df-ial-idsp --sym-add --sym-del --pack --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents add long + indirect de=
lete short packed' '
+test_expect_success 'D/F conflict prevents add long + indirect delete shor=
t packed' '
 	df_test refs/df-al-idsp --sym-del --pack --add-del foo/bar foo
 '
=20
-test_expect_success REFFILES 'D/F conflict prevents indirect delete long p=
acked + indirect add short' '
+test_expect_success 'D/F conflict prevents indirect delete long packed + i=
ndirect add short' '
 	df_test refs/df-idlp-ias --sym-add --sym-del --pack --del-add foo/bar foo
 '
=20
--=20
2.44.0-rc0


--kfZxRXvqFKKbBMyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNyoYACgkQVbJhu7ck
PpR74A/+P6LCUzlir5hvqSjQy7kcC5a5cmiv0jLGSofXhyM6xkl3meBDFFYlbuE/
JFjmcEas9xBIPFo1T3O/8F3IZ69g+KRpV43zUWMqjIxOEqceH0i/Z35W87s9IUso
tvU0aBYw0gw+DpePTP3gbAQTIGkEbPWp5Z1iKgjHsFTEjzlDRZ0OWMRJ3Z/nyXS2
IWsSMMNkcIBRTYOPIq697ZH/BxMTmkaMZf5pzQXzskwwZxqBtGZ+GW/hSRqmzScO
TzeIJ7lXff5Q6/tlN/mFujarepafqs4HZLZ3hpEJVfRXVcwwIRC8xYxUqHGpi81O
uCLYLrYODNbp06/rTUegUeWhQREHwe2+rZWizeIYNwaBA6sYBQcWvJAgkd16hSDG
OycDyfrSf5o8jQ/jnZTMNZIyJQZA0NacxQoX+5dqOwVzjo1zlfEJJbYiOTjg95V+
p/H/w840Gdos2gPVE4xSgb9Mmj39zbuVnMAt41B2svpgr70vS/DEJt2HS7s2+R/z
+KY55Tl+JI/P25Ws0jFwUowL8GiCC4hw/5zdeI7O5FdBQJbyso8ZoItzoQYBfbeB
fW1tnTlg9pjtyF4i+YXqvCmibmwCG+E3O9ji24Q1t72qwIzRkgumh2JocUmQZIAk
S20gQbFKpLDA0OMLEcwKPo07sJrh4Ti8ZPTfrXKBMvLjqdYvQ/w=
=l8W5
-----END PGP SIGNATURE-----

--kfZxRXvqFKKbBMyc--
