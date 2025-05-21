Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421120E33D
	for <git@vger.kernel.org>; Wed, 21 May 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839492; cv=none; b=DjQHK2f0ootNuz39VlR6VIW8Sff+wMiAg8axSczG6BeAq7gfkKCpMxgourD1laemnJxqrn/t9G8nJC/QQGDCpBdPU8U27R4hAlsOJH0E18jCXFXnKoobIcZAdcJ3Do8Edcx3ExW6EFJ/wj3tiPNPRmBnNaMUOXs4YaMDLz11rqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839492; c=relaxed/simple;
	bh=pbI8pv966yi9HrbbK7IHJ2Bhq1fxwkks3Ivm5Ua+ps8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kkwDXJ8NzdYX3d4koctVyQsxg4mq/Ea6mgtvMU+yLho5DZZ91RGcOMfQA9ypGlX2b8ek8UTLtcY6sV24d4wT4Z0fPDSjSiBI24j290YcXw7wGWDUUvg0KpGvktmi3drjsbelzHaOvzzuemI73CLrwhfDhrEe3ob4vt10ZAlmwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j61qG3df; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GvnPBoSY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j61qG3df";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GvnPBoSY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id ACE341140137;
	Wed, 21 May 2025 10:58:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 21 May 2025 10:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747839489;
	 x=1747925889; bh=rcWC5Vfug/3/x2rpZu3TiQFZIUapmRf1ok0WvC2jtuA=; b=
	j61qG3dfSn6Od3NaSmeeuK1xlP6N27dxty+tN4HhJl/C9XFTPc/WtN1paD8kLP5m
	/snKunMy5xyzrSH8UoV7AAICctnraNNZyXYQdz3Mo2kbk9rt9gICxFPrMGF3vp2Q
	raRmhKSnv0R/SrzAlQzFmT8y0RvOSwYjmhpBSwWPAt44xiPpqFUsEjrSJEsWHViU
	tCyXi226K1KAj1MDDv4mHlZqD9Q2xURxa7btHWPhTu4G/2ltRpiCRbkRU3YdbyeM
	sJsT6c+UjQasv621Z8KwpYl43tYmn5ApfxPXSAvSnmuapLT0JgBaDEY9gVZq14Zm
	JN5CimKESFo/y8Gk2EVmyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747839489; x=
	1747925889; bh=rcWC5Vfug/3/x2rpZu3TiQFZIUapmRf1ok0WvC2jtuA=; b=G
	vnPBoSYntqivdlwosPVlEIB1NIzuymtQslBdjnQBrKMR0d1aKxJfTZL4iGN6/00w
	BdsFdhvWXWfc9A7Jzd2kNX/YAWHd8uCEA78YEthFFSMTP09Q7+caf7Re13422Y8O
	/ok7hCa0sV2ir4KZYLBFtxu7tY9QbfvIzUKFO/zp3At/3Pph3otNSGQ74r2x46YH
	Ihsc0A6EUukQB6OkZbdRLKD1zzyoKP+06p1ZVpY3Y4HBVl0DE9DRdfO6YFuASa2Y
	fOc+z8vUX1Fowr8yhjRz1ICsOskWEqQ+LUJocoUWAmexHKstmbhGHGwlDKSgamPh
	sgSZo5QZgbJ4EllozER8Q==
X-ME-Sender: <xms:AeotaKTHuDWlhYRFXHWc4QreglIuQwsZSbDd4eFnqnaA_8lw9mF-UQ>
    <xme:AeotaPx0MG4i_2Rs9E2PyTAR8Xh2EmEqSBir0FAYXmpIU6at2ZNSAJ_vkR8b0Hz01
    WdyRVN1B6DN_UpMwg>
X-ME-Received: <xmr:AeotaH2PbMvlXrlUZMB1cAnfvxUfOamtgE67yHgs-NXMEpfUdQFWwhyKrz9ulY5keLRnV9ywT-X4vBabTy3KdlQseDlsdfz9T-nXIhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeekucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteeg
    vddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhpohhhohhrvghlse
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AeotaGDSQhjrjVoUR15ZagCUSp6FW6DABWcM5713G1daxKm0B1aOqA>
    <xmx:AeotaDiXOcrlYcVSQQm0xQCSURauMJSCfZFIomrKibCgN29U95FPCQ>
    <xmx:AeotaCpP6FBc1aUnstoBK_D6fbzXiqBqaU4MOvU8bIwGMbday_dZcA>
    <xmx:AeotaGgCXwO58PCPPTbEf04UVzHCHvBU1MgEecacxWfCVutvnYUMOA>
    <xmx:AeotaPkRrDpQEnEKYRewZptfqNNiHUtGgU7LEF8yqZLP47b8O_HsW3yF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 10:58:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 <opohorel@redhat.com>
Subject: Re: [PATCH] cvsserver: avoid precedence problem between ! and %s
In-Reply-To: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Ond=C5=99ej=09Poho=C5=99elsk=C3=BD?= via GitGitGadget"'s
 message of "Wed, 21 May 2025 07:45:02
	+0000")
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 07:58:07 -0700
Message-ID: <xmqqplg2c8ow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Ondřej Pohořelský via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index a4e1bad33ca..076c10cb2c2 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -5009,7 +5009,7 @@ sub escapeRefName
>      #   = "_-xx-" Where "xx" is the hexadecimal representation of the
>      #     desired ASCII character byte. (for anything else)
>  
> -    if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
> +    if(! ($refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/))

Interesting.  Shouldn't it be using !~ instead if it wants to assert
that the refname does not match the pattern?



>      {
>          $refName=~s/_-/_-u--/g;
>          $refName=~s/\./_-p-/g;
>
> base-commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
