Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F675176ACD
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097600; cv=none; b=dOwzDgM+Kf8reuld49KWtrYVH5UR9rlcg/w60EL2GHss6PTIb5nKfb6P/f3lWvMK7lY/70+AQVkp+7rT5hVoHTmwWnydSPYie5+K3Msn5ieFB72U0IUEBy9xSSd7bNQ7ic7Oi2Ms/BuxCoqDLtVACNTDxP3nKJmErPjbdy0Qe6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097600; c=relaxed/simple;
	bh=3Wyf6BVAIShwj8VumuXsHV9vZ+deMiv6EOXAXvCh458=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUteydz38Y5VpxJTyxz2B85o9KpqRI/CH44h4HFFjqrEN4nkIEAai79MiHSq5zw/nmcGBfO3AroUQcLnE+XVaehBWu2DsczImamBFWkA8/q9Lqx9l60lsWQDQNyumLcpZ86D+/ROYWozD2zjGu6T29wzABaaynShdfFxcgFjQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IBOfsC2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gc8Q5JNm; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IBOfsC2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gc8Q5JNm"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 645F718000B8;
	Tue, 11 Jun 2024 05:19:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 05:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097598; x=1718183998; bh=zKRYuRzUiD
	8lYhvWetc4j1I6v9+4Mhnpj2+matE8m3w=; b=IBOfsC2Tej0/QBSKA4zAZ/9OSw
	3a6HRnx/wCit3OyB53Z8pds6hxzggnx/7Fb/zJUBLpOMs1CFVkgFGjmtIVcTGj5a
	E0gAqH47YJI8frg71VaGPNEaSBXun2c0gV1QYwBGI6iQGTvA9RCZ5jwtrGGDVqjH
	736J5Aj6OOeNtNZy6NLhyG9rCpLvhKt6hG1k1nsfhq01dfjqSzCl3fsXDJGRVYxa
	8jYykY2oGKJ/kCi2WfrvwhNkUnyKyNhtiXCWr0J1S0zc3LKMAGlNPtZxAOcExp4c
	IdU+1CiEL/RyU+mtUZKqcEEMC9aZJe0+m9pPfuzixLCbV4lbyS88bb43S4dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097598; x=1718183998; bh=zKRYuRzUiD8lYhvWetc4j1I6v9+4
	Mhnpj2+matE8m3w=; b=Gc8Q5JNm1hVBX63WaA2J6WRbtpx0BzTC1n2C7ae5jZbs
	wwxRfLtsG8B0leHJqb+ouoMZR4TXgzWTgB8wEv8KU6UJZQ74CHVKmCD12APTztnO
	U6jLU9aYYr0SJEpZmdfhKne+1PgEqXod5NYFjsoTzknm0jJPmZJ5uSrP3tKqXj00
	ISKd7srHKh3IMKD3pfItaV/CmM6eOyc/MYsFJujn4Pvr5FLKseO8X+VcHoGHwM4H
	1F26NGIVNWM06eiYofqHiJMlWvfHtbpdl+jM/7AHHbfMgfzT7oVAl2TcMBKtUEUi
	HdBHutChSmT3wBsoMReR/VQKGFdNrXaozOlZaZmvqA==
X-ME-Sender: <xms:vRZoZglxTwcjd4la2ff190lFamfe9HiHGgllMkIqXlb3SQKmL6HKog>
    <xme:vRZoZv1So8ZYJ1Mwtt0Qmjt1MIvSZaovA2jsfgF1gxns2nhzIR1QmHydj2_q5wjvl
    LFNvu2ALu9AVTAnlA>
X-ME-Received: <xmr:vRZoZur7tS7LH9ZgQdOEkuwIwitxKe_A6dq8oOTVQSLoZ6OCGmR3-Ybk8Kjqo3Wa39CwLMxY0v0rdtJIeFHD_60BR-iGJ8ZtWSdUMayYjw0CLVCJ_7Cs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:vRZoZsnqa9BSBb9AS2R8ToIu3k9Ao5BxNl1zcdLkwdW0sip7Rw1lsA>
    <xmx:vRZoZu1Rc65gi5afHOb4DZIeg4uze5Z-d4odczzPrF9UE38I6InlpQ>
    <xmx:vRZoZjtsF3CstQvjOzFvJmCmdHHTSobsdUIsF1HBd6fegRkBiDAG_A>
    <xmx:vRZoZqWoNyivbc_kJGO6vdH7qKk0vw5IJg7TSLF3Xsy1V-eX4O-8xQ>
    <xmx:vhZoZjz-bC7DPtWg6kw-byUPNP9gmoB114dzAx4OsveMPnXaNtZ7TIrK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:19:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cdd4b98c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:48 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 09/29] builtin/rev-list: fix leaking bitmap index when
 calculating disk usage
Message-ID: <a0242359b70d60fb0236353b7bf1183f46d846a3.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C+xyHTc+kEVTfDk+"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--C+xyHTc+kEVTfDk+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

git-rev-list(1) can speed up its object size calculations for reachable
objects via a bitmap walk, if there is any bitmap. This is done in
`try_bitmap_disk_usage()`, which tries to optimistically load the bitmap
and then use it, if available. It never frees it though, leading to a
memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-list.c     | 2 ++
 t/t6115-rev-list-du.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 77803727e0..97d077a994 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -508,6 +508,8 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
=20
 	size_from_bitmap =3D get_disk_usage_from_bitmap(bitmap_git, revs);
 	print_disk_usage(size_from_bitmap);
+
+	free_bitmap_index(bitmap_git);
 	return 0;
 }
=20
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index c0cfda62fa..21c4a211b1 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'basic tests of rev-list --disk-usage'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # we want a mix of reachable and unreachable, as well as
--=20
2.45.2.436.gcd77e87115.dirty


--C+xyHTc+kEVTfDk+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFroACgkQVbJhu7ck
PpQklBAAo5HIlBqRNLo9JxeLVHhyt/pXS4EPHhfMuTmsXQutc4Ov1ZmyBFT4obTE
H929FJAsktplcy6Y3I2UNlEgsaCdLcQOZOMLxFwPbQbdCbrSQVFHDYMmZX+9lkE6
bBFKxCQdX0v2TVq04eZziyHfxwpZJmdZwCichWKIhYw60wQP72C264seVwPh/GYQ
O64KTYfj/FX/NXEXoZ30eKH5eMnERB9o5pv22uYxXd5zf0tpP/InAHZ4d3gGh6fr
nJvWX4hWjNs8BbI6EdTu591EkLaeHPrnmyT1zl/OT9HPRb+09dRYn7JacjrCQRVh
GUbpKtHma0sPTdfQUqmVOHnPy3B9ala2tUL2JoCMYt0hjFno1oWPFLooN9gfbLPm
cDxoI1+VXvDFszojplCHBgm3jk8jfkDFW4jKLUV8TPaa3551e01QvHAY5rRtWbHt
kq3T2dOUWTvFz8DRrHk4c05MvKK8RGxhuuqsaKCb7zrJWF3SFo1kUP/OmZLQnEdc
YaH01l47yt3WMVEpfzkJH4aTb5NVywfSpT02M37r/5+l35GzQ0TBM4L+K+2QCIIu
XM0Zyh/SULEcFQb7jtuho3Gd5vWd87VHPLqofH3TzSX4a037lfJEmXWu5zqx9t9g
XB3bUkuNfCDIK/YqzwsqWQQe2DzIDHByIc9dEvgzNoAxul5p9fU=
=ZXiI
-----END PGP SIGNATURE-----

--C+xyHTc+kEVTfDk+--
