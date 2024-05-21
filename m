Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCF58AC1
	for <git@vger.kernel.org>; Tue, 21 May 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332241; cv=none; b=AFcGqLGJJ43oMQm3gSq2UzCGoNTnoM2kmYx2vi9WalKueAt6xh81zb1J0Z4CAcq3xF8rY/wSVDJqWcJMMBo9ZJaSi5gUR1wnKS8B/lNq4gOzwZfgJLpA0PnZNo75x5Vf10Z9zhmOkGXsuKnPN6jjg41nvgMN1Uw0623WoGsWDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332241; c=relaxed/simple;
	bh=39jiz0CZ8mkmem2HRflY1ghYEFM5EdoCM3X2qhP1SHY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y8BihfI6e0LUDJAy4ZYg+Gm7nx9leqinfkEjdtNM0+Z/biMQuSYEaoKapfBHEhPMp8CHWbZaQk+G+45OTI+ffGVDuW2fCvYN6g0vbyO/OeIdauUK2kjmeeLEYhV7Ct4Zpq4yvWd3WOH8AEFUyEa7T6ba/agUAGYy5/xfFJBJ25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=oHvABc5h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NBn6R5r4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="oHvABc5h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NBn6R5r4"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 665771140149;
	Tue, 21 May 2024 18:57:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 21 May 2024 18:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1716332237; x=1716418637; bh=gyHZQC9YA1FhDWpOka8Arn581N8XEQyt
	uO1GYDd0V70=; b=oHvABc5hhlfQ/0eA4ckNboW2fcj1JCR0i9wFj0Ju+3p7MK/F
	jbmRouuh9gRYRx0hL9cofbQ4Jp/shPnQvA5e6ENwF+eHlqoRadjhSvyME74qRqfp
	9JVjBZHebF+o/YsE2DB9iPZYray1R0pY5wtypI1NnTC+xgAV0qvA7i+uRmlAx6dK
	2atHfSJj1Hnc3BumZlyq14tqTehOqdkfVw+sMxg0IwxC41zROFcmgwC31ko7tB3Z
	1D22ueaDK2QU2bpy+aESwPASKZUTB55SMuq9A5Wp8Ww1Pz6yCTMjgD6/1AKpv+MA
	xxEiRweUbfBxALV75m14oq9k3GX7L/PlyZlmxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716332237; x=
	1716418637; bh=gyHZQC9YA1FhDWpOka8Arn581N8XEQytuO1GYDd0V70=; b=N
	Bn6R5r4NojIp+oPU60Vmg4t4sa/eP0ITnNBDma6xNQXfAZftRtAKhxUaoVehG8d6
	kgjX5u2aofGy6HbdgIB3X0xtBJCQgpr5Xlc8ncof+AJYI7/Hc7IDBYBzfUyYwfBZ
	bHLoSia7G+/9e7yf2Fq48aJ6jAO/Ery8b3MukUl+aSsPHirW2N3+g2u/f8MJ7HjM
	d0Ec/oTSFu3LIwSqc4M42vwVdPBfUoZJcdLHwfDl1mXNJdXJs+rBy264vw0dfIYy
	7CnKaqXl9tr8XZBf0o6FRU4y2u/BJbOy/T5HwxCAuSeIHt75wN4Pv9twXOZY6z1L
	ClNxKJ37R7SpIfg5ne/Zw==
X-ME-Sender: <xms:zSZNZksYGwmmTiE1UGvoMQDpM6IjaZ4vTIAzBScFP64UXOhwkvunEw>
    <xme:zSZNZhfWdu9tkirLx_RYN_gTaKHDMdu2bUvEB9PccR1MJt16gsHpxR-w1HbMD_9Ww
    bgiefjuNKx9csjo>
X-ME-Received: <xmr:zSZNZvwphgBFcqsTj8hb5bCB_s8XI-wlQ7MG4sqg8jCi8V-5MMgaoyzQ8mKpj7Od9WDX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeeurhho
    ohhkvgcumfhuhhhlmhgrnhhnuceosghrohhokhgvsegrlhgthhgvmhhishhtshdrihhoqe
    enucggtffrrghtthgvrhhnpeegheelffevjeehheekffekheevieffieeghffhgffhkeej
    keekkeehtdduudevvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghrohhokhgvsegrlhgt
    hhgvmhhishhtshdrihho
X-ME-Proxy: <xmx:zSZNZnO0C0TUigSp__l2BKA3E-ng1PZPi9QLum5o3MpSRbCQTdGWrA>
    <xmx:zSZNZk_rYs3-gJ05BVjKU3-o8cBesM_sdXCY3VqrCv3w4dpNFcA_Ag>
    <xmx:zSZNZvXGQULvBYm42pok9yJu1EDemK-SUKy8PxqQ6QCbIfnwJuvZNA>
    <xmx:zSZNZtdlO6HESbhTNf1Fc6teXkvq_ux5NXJFYNE4HQZ7P3KeCqdOsg>
    <xmx:zSZNZjY2HjcejvePb57EbAdHPyFbRx6Io2k3YDHV23wkINCOouR1Dh8K>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 18:57:16 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 09/12] tests: verify that `clone -c
 core.hooksPath=/dev/null` works again
From: Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <20240521195659.870714-10-gitster@pobox.com>
Date: Tue, 21 May 2024 16:57:05 -0600
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9933EA45-85FE-4372-8177-E0D47A596C72@alchemists.io>
References: <20240521195659.870714-1-gitster@pobox.com>
 <20240521195659.870714-10-gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3774.600.62)

Thanks, Junio and Johannes. Looking forward to making use of this again!

> On May 21, 2024, at 1:56=E2=80=AFPM, Junio C Hamano =
<gitster@pobox.com> wrote:
>=20
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> As part of the protections added in Git v2.45.1 and friends,
> repository-local `core.hooksPath` settings are no longer allowed, as a
> defense-in-depth mechanism to prevent future Git vulnerabilities to
> raise to critical level if those vulnerabilities inadvertently allow =
the
> repository-local config to be written.
>=20
> What the added protection did not anticipate is that such a
> repository-local `core.hooksPath` can not only be used to point to
> maliciously-placed scripts in the current worktree, but also to
> _prevent_ hooks from being called altogether.
>=20
> We just reverted the `core.hooksPath` protections, based on the Git
> maintainer's recommendation in
> https://lore.kernel.org/git/xmqq4jaxvm8z.fsf@gitster.g/ to address =
this
> concern as well as related ones. Let's make sure that we won't regress
> while trying to protect the clone operation further.
>=20
> Reported-by: Brooke Kuhlmann <brooke@alchemists.io>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> t/t1350-config-hooks-path.sh | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/t/t1350-config-hooks-path.sh =
b/t/t1350-config-hooks-path.sh
> index f6dc83e2aa..45a0492917 100755
> --- a/t/t1350-config-hooks-path.sh
> +++ b/t/t1350-config-hooks-path.sh
> @@ -41,4 +41,11 @@ test_expect_success 'git rev-parse --git-path =
hooks' '
> 	test .git/custom-hooks/abc =3D "$(cat actual)"
> '
>=20
> +test_expect_success 'core.hooksPath=3D/dev/null' '
> +	git clone -c core.hooksPath=3D/dev/null . no-templates &&
> +	value=3D"$(git -C no-templates config --local core.hooksPath)" =
&&
> +	# The Bash used by Git for Windows rewrites `/dev/null` to `nul`
> +	{ test /dev/null =3D "$value" || test nul =3D "$value"; }
> +'
> +
> test_done
> --=20
> 2.45.1-216-g4365c6fcf9
>=20

