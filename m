Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137915383C
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743551; cv=none; b=uQEuZQ9pK0btvl4lW05xCblB1KhZ1wNemqHRQcXwbVka+0ArVd2/2dn3i48LL38yeDR2LrMtFTqQwnlXsrU9u8zlprAUE7XWnDtY14rvoxkWQ4w5vu1z5UopIBbU+bPUOaj2y+StoPTECbJUVnIFdaqCoY35/IaflC8axAKl1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743551; c=relaxed/simple;
	bh=36QV/VtoDpFeez34g3nsvYdIehfzG+/E/ND0e0Nl6S0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIwjT5MaSJ/eqkefDQohmWMzzMyImwDhrei8kadr4ea/TYSBuxXPU5ZS5zCpongV6+bomJH/6+s8+kzHHoohBdEICgZK5DIZWrbnTVg+tonzqUf18sQmYm/NlPHbv475+scrYKrWCkwj+WAlXDGqgy6ORwhf+0G/rLKfdm2UAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RX2g/7MH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BFdQOxbQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RX2g/7MH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BFdQOxbQ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7A5D41380213
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 10:05:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Jul 2024 10:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721743548; x=1721829948; bh=K8zP+RBsj+
	C2ztpkfKhU4As2Ms+ofs9d4cDVRnJYn9Y=; b=RX2g/7MHIQi3hwmCUDl1CbOmLn
	t3WhZGr6abr763UTb2yPX7XH19TcoRPbW7RMBV54vQ+AXeuUdf+OKTOdz9u4PXEm
	YbsatNBoeNy1y/z/DN+PX48QksIqKPm1WGAUOZBQgyeTCqppsQ2hQdWKpYoBTnYO
	pi7iG3MfgpAM0jJVRMryEiexPZd3ex+zfW5bQLMVMo15GJ2LJaKFS482ka+u9m8k
	N0p0VgvvcN8F5li6YRM05zL4xQKhlL4mQZKJCgm0WJr5eJy+7tN2kik0p7rhlIUK
	GCNkv7qGbrmAPteKOKFY+ItSUzF7CYb1Vnq4tWVzQcN9qrkCFDbT7/4k5caA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721743548; x=1721829948; bh=K8zP+RBsj+C2ztpkfKhU4As2Ms+o
	fs9d4cDVRnJYn9Y=; b=BFdQOxbQP82+ryCuTGDAR+3DrPH0eoIMWc77uAUWBDmW
	cdyJqzUyL2GPFAl3ezEuGmVK/0oSF3FYpyWdHnSvsuPiZGHiVtYGbtgd1uZI+tBL
	2d8p8RWc1Znc36Vc5+NXJoijH9hm7SNm5c4v8sP8cR2kZah3j/tbUBk/XBt1xkk7
	e+7wvSeMbm/fcskjYqIx/+ZGORh7ju6a2LfwUQQamAC582SFl2qffa005iilUPR6
	xvmFfjKkP229gj8Rx13lYa5mVI9Uy+iJNPTxxW9u9MoUyLYvXeBolN0kMwbNA4Km
	3tIk+PAAEaKInr4RdWwWm5WfZMQ2GWHfdd6Ov18wJQ==
X-ME-Sender: <xms:vLifZtG8s8voQy1WVA56EOKcL9Wd8iDQznVyoC_5lI69WDgJrz0zQA>
    <xme:vLifZiVHzc0AsSGesgUJ8Xu3yVCwC9j8GZoSh_2k8d67LYw3Ats_t1FsUifYsFuR5
    GcVEOfdoWou5jhhDA>
X-ME-Received: <xmr:vLifZvLgzrE4C-53NktHe_1y_Gd54ZDMrjTnG_7HZSp5qQmAp2_9FzrWlOYBwFTFWsSsNbvZ9mFw5xg6nbdeW_UPiaiwJqmpb6ViFC7sbiZG34Vo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:vLifZjGfKhMYlRYwZdjQb31SU_5FdhICGNkoxQP3w-QaXKUQ9kSVHw>
    <xmx:vLifZjWSm-9K90jZNWFXf_riqgqWfCIu_yqswbMXNh0CUqGtoCEQtA>
    <xmx:vLifZuN6WwqFr7HjP4yoDBlDySpw7HV8v2G9wWyZbwRrUrcysBgiCg>
    <xmx:vLifZi3WPC-jV9HOHFScCuMPG0HhI6-Z2VTK7pcG4pK2ReVxkggb6g>
    <xmx:vLifZqf_yX3G0SP1Q7EeKuk2P9UYihH_vA4z12F-JPzfJKrfIXCmAune>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 23 Jul 2024 10:05:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 18b2bc47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 23 Jul 2024 14:04:25 +0000 (UTC)
Date: Tue, 23 Jul 2024 16:05:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/3] t98xx: fix Perforce tests with p4d r23 and newer
Message-ID: <f40f62f257de38c3a38e942eb9ca1d2109c2b059.1721740612.git.ps@pks.im>
References: <cover.1721740612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w+DKSTaeLoGF4JNB"
Content-Disposition: inline
In-Reply-To: <cover.1721740612.git.ps@pks.im>


--w+DKSTaeLoGF4JNB
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
Perforce. While a file revision was previously stored as plain file
"depot/file,v", it is now stored in a directory "depot/file,d" with
compression.

Adapt those tests to handle both old- and new-style depot layouts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9800-git-p4-basic.sh                    | 13 +++++++++++--
 t/t9802-git-p4-filetype.sh                 | 15 ++++++++++++---
 t/t9825-git-p4-handle-utf16-without-bom.sh | 18 +++++++++++++++---
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 53af8e34ac..4e95622670 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -297,8 +297,17 @@ test_expect_success 'exit when p4 fails to produce mar=
shaled output' '
 # p4 changes, files, or describe; just in p4 print.  If P4CLIENT is unset,=
 the
 # message will include "Librarian checkout".
 test_expect_success 'exit gracefully for p4 server errors' '
-	test_when_finished "mv \"$db\"/depot/file1,v,hidden \"$db\"/depot/file1,v=
" &&
-	mv "$db"/depot/file1,v "$db"/depot/file1,v,hidden &&
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
index bb236cd2b5..557e11b16c 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -301,9 +301,18 @@ test_expect_success SYMLINKS 'empty symlink target' '
 		#     @@
 		#
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
index f049ff8229..8e34f72198 100755
--- a/t/t9825-git-p4-handle-utf16-without-bom.sh
+++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
@@ -22,9 +22,21 @@ test_expect_success 'init depot with UTF-16 encoded file=
 and artificially remove
 		cd db &&
 		p4d -jc &&
 		# P4D automatically adds a BOM. Remove it here to make the file invalid.
-		sed -e "\$d" depot/file1,v >depot/file1,v.new &&
-		mv depot/file1,v.new depot/file1,v &&
-		printf "@$UTF16@" >>depot/file1,v &&
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
2.46.0.rc1.dirty


--w+DKSTaeLoGF4JNB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmafuLAACgkQVbJhu7ck
PpTwmxAAjYB9O3KZwkhGZqD8zFMo1aYNcGfZ16ZEIxijNYYBJC0DaoHG95tpvCsP
Wr3TgikSlMG/YfpgT6ksaUuXFnKlndsJvMf10WgLiPwD20tOwZpCDpRcsP3d0sTN
WMoXhCzFI4K9IuUDm9RawkfnWbY23DvU6BfAABpsl62kOwmd/966pp3Rhi3+aeGV
HzjmkJpzSgWFmU5oX6zUBLuaiUxv3SBBxSBHHYU/1tB9N+NHb/4XzNuE7dZ2mzv+
PZ2GDjEXL1M0v18/HHEuahzEV5QfHuH08Lwqt/nBY4LDH6ZxCva/cClj6TyYAl/d
SJ7/UM74D0hgYWbKkj9/dRQQHBRKcR9meieqr3k3ZrZt1VGtxKy+AKWEtWDJAQqQ
dNjWet/9QdryiYvy/uwHdkeDTPzRv26jSY3SjPgJCyP7e90D/U4HS9o34cFPHceJ
Rhy/MQmg3kwF1TwddWzAazY1e0QEt+ueWo1blmtDLKCb5YhvBW4Rig/SzafNBtY0
g92DLs1UKoJ2LOurc5qrrDmO7zXegXdx2ytQLXB5nI4BtOuPNbt+c3mxvX/zoqvt
yuUgtY6UmZ10ejHopzvkBtzd7UrJ+PNen7SOi859XoDvOYv4fji6ViE8friqaMme
Pwa2M+1XmZktjc6HeCy+I7c6MhM5AorHQaWw3IO4E640BjEZid8=
=rfJw
-----END PGP SIGNATURE-----

--w+DKSTaeLoGF4JNB--
