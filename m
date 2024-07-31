Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878C1AAE13
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422267; cv=none; b=CDMTLyi/apMgCWbUA/Zt9QqQCntGqYSFLQ6ujX4Z8mYXFOVnoralTytmgtaMwrTYOWywsEGBQJwyXzMWflzPGydvg8eGKhZ9i5PnypQwv7Uev3qmMcYKLBcjPHpf8Gv3QoUQl7ZrXnFBqYrkfMKPFuYKVJn65BZBjXvOSYyAlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422267; c=relaxed/simple;
	bh=OKlWrxFgrpfB+l+rxM9WLtu7m7UGeuG/XUxXEAlDvUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wfm5H5QWtMObm8jJH0ktLZH2inauaWoNcPIZ8ndGEdzUOZp7Gxjj1pcRkBciB7wNjXp9jS7Wvi1pqUpK5bxMh2X10B7gxlfzErnipaxa+bEE/Gdfk9ltQDQb8gHvq0wwN1SM4B2LjfpuoP+qd6RnNZF9yYxKC6ND64zpAWtZ8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vvhpf926; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PWTwpMb6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vvhpf926";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PWTwpMb6"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 856DE13822D1;
	Wed, 31 Jul 2024 06:37:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 31 Jul 2024 06:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722422264; x=1722508664; bh=IqaHsJitOE
	4WIqwZeFbyMjn1Cjma+jUUhOhGZwWjgHc=; b=Vvhpf926m9bsaluvWn3uKgrtMV
	spAqfDJ4eWeC6jSBdbktkGVXoZ3cu1J5kGuGMHK9MV3qkNHbX6rGEV3XAc2DfuXB
	HjaBBqFleDBERL0+NaDyX0+r4cLcnadbUuqOxWQeysXD9TC9I5IBC12fSTK9RoKR
	dLsr3aS5mr9kDs5giqT3g43cnamvk8GxO2lzvwgB8oBpkbe4fUoT90tiC9by2aXG
	6R5hZ08nKdYkytAwdewqcK+LlN81VLero+Ul9vJIUe9K5YHrjjF2q9XlYJMkb0VO
	50irfRvrSYiQ85VrtOSETOH6Zy3vaV6hC0tkZpjxRgURyroJSFmcPt6DxxSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722422264; x=1722508664; bh=IqaHsJitOE4WIqwZeFbyMjn1Cjma
	+jUUhOhGZwWjgHc=; b=PWTwpMb6gSEn4BcpuWoF2DNX7mBgzYCSmhVnvo5joQZY
	l64rFbMJQn4Z4cE5g1gFSDJ0FSzkTy6QeFXeUaXZqsmqBvn0g3Jpodib7mqIi1Ya
	Mjf/7bYMcfxirCxwuOB9rbEIHTvHPi+eHP8m8t3XQFyBgAUYA4oraJBdWV936hjs
	2vZrg4qMaZzytZi1GaZsQZQJbwKyvpMVgk+siXKo2yof+LVskjFCcDVg+hl0MAo4
	aw3zRRFSHrZi385zH09aNvZXrn+oIv8z2g5isghiscMtHSAevg7yGmAgaSnVQEuN
	Klx8oFb4nmNn34Q31ZH4q8NekawV6g3Yyd2wDRhYow==
X-ME-Sender: <xms:-BOqZtMklHBPZ6C_g9Nn411fVhLncN4ryB00wZyLxi_rXaX0EP9o6Q>
    <xme:-BOqZv9bozwkMKesBnsRChlBkY5IBcMiOby6mpLaPezy7-5qMCLIRkslzogYtvrKt
    adRgvI-DiRhcnafJg>
X-ME-Received: <xmr:-BOqZsSdqX4XDLXHVuufxfww3hD5_RUIDyFPCIwened6Dxchb_e5nkPBhJF77IpX535tyz9jZ_koAzmB7pNE1LRbFiEuAhBNdW62dYmoj3YVcG7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:-BOqZpuwif81-QGwrI1fPO9OVc_-kb_iKflZx6k3m9KVQcayAckmbg>
    <xmx:-BOqZlc4c_fdnhFBn2jKYVigCVKEk6riak0VmIHvsb8yXPVp4V4Sxg>
    <xmx:-BOqZl3Dx8Opwyuz67Y-YmhNI18PeDfbs9e54-wfG2ojNXbjal02qg>
    <xmx:-BOqZh9O7Qfa2u-HPbC1aWqAVxQxz7F3_V0BfxvWdAB2qptMU4fAcw>
    <xmx:-BOqZs7hiEmRV8_uYa-bVtjFWN0CkMArPOhi3RevzQxOIpfGogZnKqDZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 06:37:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5f9a57e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 10:36:13 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:37:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] t98xx: fix Perforce tests with p4d r23 and newer
Message-ID: <7f06de7e6b4c1bb8073f02f948674b36022e0a0f.1722421911.git.ps@pks.im>
References: <cover.1721740612.git.ps@pks.im>
 <cover.1722421911.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Oiv61zzAY3kMli2V"
Content-Disposition: inline
In-Reply-To: <cover.1722421911.git.ps@pks.im>


--Oiv61zzAY3kMli2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the tests in t98xx modify the Perforce depot in ways that the
tool wouldn't normally allow. This is done to test behaviour of git-p4
in certain edge cases that we have observed in the wild, but which
should in theory not be possible.

Naturally, modifying the depot on disk directly is quite intimate with
the tool and thus prone to breakage when Perforce updates the way that
data is stored. And indeed, those tests are broken nowadays with r23 of
Perforce. While a file revision was previously stored as a plain file
"depot/file,v", it is now stored in a directory "depot/file,d" with
compression.

Adapt those tests to handle both old- and new-style depot layouts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9800-git-p4-basic.sh                    | 16 ++++++++++++++--
 t/t9802-git-p4-filetype.sh                 | 18 +++++++++++++++---
 t/t9825-git-p4-handle-utf16-without-bom.sh | 22 +++++++++++++++++++---
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 53af8e34ac..0816763e46 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -297,8 +297,20 @@ test_expect_success 'exit when p4 fails to produce mar=
shaled output' '
 # p4 changes, files, or describe; just in p4 print.  If P4CLIENT is unset,=
 the
 # message will include "Librarian checkout".
 test_expect_success 'exit gracefully for p4 server errors' '
-	test_when_finished "mv \"$db\"/depot/file1,v,hidden \"$db\"/depot/file1,v=
" &&
-	mv "$db"/depot/file1,v "$db"/depot/file1,v,hidden &&
+	# Note that newer Perforce versions started to store files
+	# compressed in directories. The case statement handles both
+	# old and new layout.
+	case "$(echo "$db"/depot/file1*)" in
+	*,v)
+		test_when_finished "mv \"$db\"/depot/file1,v,hidden \"$db\"/depot/file1,=
v" &&
+		mv "$db"/depot/file1,v "$db"/depot/file1,v,hidden;;
+	*,d)
+		path=3D"$(echo "$db"/depot/file1,d/*.gz)" &&
+		test_when_finished "mv \"$path\",hidden \"$path\"" &&
+		mv "$path" "$path",hidden;;
+	*)
+		BUG "unhandled p4d layout";;
+	esac &&
 	test_when_finished cleanup_git &&
 	test_expect_code 1 git p4 clone --dest=3D"$git" //depot@1 >out 2>err &&
 	test_grep "Error from p4 print" err
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index bb236cd2b5..df01a5d338 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -300,10 +300,22 @@ test_expect_success SYMLINKS 'empty symlink target' '
 		#     text
 		#     @@
 		#
+		# Note that newer Perforce versions started to store files
+		# compressed in directories. The case statement handles both
+		# old and new layout.
 		cd "$db/depot" &&
-		sed "/@target1/{; s/target1/@/; n; d; }" \
-		    empty-symlink,v >empty-symlink,v.tmp &&
-		mv empty-symlink,v.tmp empty-symlink,v
+		case "$(echo empty-symlink*)" in
+		empty-symlink,v)
+			sed "/@target1/{; s/target1/@/; n; d; }" \
+			    empty-symlink,v >empty-symlink,v.tmp &&
+			mv empty-symlink,v.tmp empty-symlink,v;;
+		empty-symlink,d)
+			path=3D"empty-symlink,d/$(ls empty-symlink,d/ | tail -n1)" &&
+			rm "$path" &&
+			gzip </dev/null >"$path";;
+		*)
+			BUG "unhandled p4d layout";;
+		esac
 	) &&
 	(
 		# Make sure symlink really is empty.  Asking
diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git-p4-ha=
ndle-utf16-without-bom.sh
index f049ff8229..6a60b32349 100755
--- a/t/t9825-git-p4-handle-utf16-without-bom.sh
+++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
@@ -22,9 +22,25 @@ test_expect_success 'init depot with UTF-16 encoded file=
 and artificially remove
 		cd db &&
 		p4d -jc &&
 		# P4D automatically adds a BOM. Remove it here to make the file invalid.
-		sed -e "\$d" depot/file1,v >depot/file1,v.new &&
-		mv depot/file1,v.new depot/file1,v &&
-		printf "@$UTF16@" >>depot/file1,v &&
+		#
+		# Note that newer Perforce versions started to store files
+		# compressed in directories. The case statement handles both
+		# old and new layout.
+		case "$(echo depot/file1*)" in
+		depot/file1,v)
+			sed -e "\$d" depot/file1,v >depot/file1,v.new &&
+			mv depot/file1,v.new depot/file1,v &&
+			printf "@$UTF16@" >>depot/file1,v;;
+		depot/file1,d)
+			path=3D"$(echo depot/file1,d/*.gz)" &&
+			gunzip -c "$path" >"$path.unzipped" &&
+			sed -e "\$d" "$path.unzipped" >"$path.new" &&
+			printf "$UTF16" >>"$path.new" &&
+			gzip -c "$path.new" >"$path" &&
+			rm "$path.unzipped" "$path.new";;
+		*)
+			BUG "unhandled p4d layout";;
+		esac &&
 		p4d -jrF checkpoint.1
 	)
 '
--=20
2.46.0.dirty


--Oiv61zzAY3kMli2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqE/MACgkQVbJhu7ck
PpQ2DQ//TT6zHoOy7OyvBW57yeESWvRsBxePJJ4VB/PSVuGlCR6upXZp3CxsHsMh
jFtpuVkywgvh9so0tRkHEjHBw3Gie89bJKdOloXYMQL/F9kQMxZqYA0u2b9veRha
wgd0lOvugdmglAiit85RmhmnKckPrBZh2Mftvxx+FxyUAies9LQUbRgWzRxY5UXX
VH+GAnRcnXNvsBJGRZOmRl5OnyqAqZYQkyIfywCkzUn6BHGzNZK8nK9a8LVNxycG
SRIV89tPMa80cymLKtv1tnf7N1eIZhFdARPG20CX/E8d5o5Q+CtRLHyb2w4ZyNJP
TPgloiIHLBkxzbuMRP5yPa34XnABDBEF9B1C2W3zZ7X82+U8H+myXNzsREgIDbg5
wiu2Kv8+bWYJeDOvgo2pNDhEqZeSn1pAzb29dm3QIBdM/IYtoLcWgNrbiogR3mLD
RlXKMauYIP6AcUix+w3iUyyvxGlGiVDJfv27iJBeMflb6/nNP2h+NmhQoqbutHfl
Dhve4QvDJysOQwxXwuL07jFUhkgzDleL2nkIaFpCFxC0ROPrPTA+u8Th7T3A4BQz
L337b6sPBaO7WrPH9sPau5qFU3iYerfshbaF6cSRPSQnD+DBvkvoQRzIjdPO2fS+
KgPv0sWqknNYCKejEqQg8qCf9Eu0+ALzYm+fFUiYdUP5jKKWmPo=
=Lng7
-----END PGP SIGNATURE-----

--Oiv61zzAY3kMli2V--
