Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EAA3EB801
	for <git@vger.kernel.org>; Thu, 21 May 2026 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385943; cv=none; b=Y8QJEcrN2Bp5W3RMvOZhm8g5qeJRSEtcAJSZuHozPhNQ3tsKueVikvadaBZq70fJRB7K+FJ/r4VoC+13xyuELk4fWSWfVHmcHCkTP6Ey1Va0mqWVw8MaKNJ5CUBz8KNzBVQ6P8bkEH4v43WMoBT205P4W7BmGD21QstyHp8udMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385943; c=relaxed/simple;
	bh=+wsjApOO88+D76WSb56bl4ZINo+AHG/yQxV9DJhoXns=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CvRmsHRTA4kjLuFQYJE3mU3ONjKakXKohKdNlh7XqPE7a4YyTJYzgPGj+e78/WsWvFtlyRb++kTTOFCgmJjTfZJyielD5uhRJtsb20MxYyWgyr/lEKzZ0+JVAZ28Q4o2sS9CM9Z+3Qf6/oj+oKGtxzSp+Iv13LbOD8w7m5DAk74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HlBLit64; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGucBr4e; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HlBLit64";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGucBr4e"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 85DCC1D0008E;
	Thu, 21 May 2026 13:52:21 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 13:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779385941;
	 x=1779472341; bh=UF8TCQq6YVX3kjQYX4J1o6p4W5AxS7fvKvCc663pllk=; b=
	HlBLit64RmSY1LhyHbeD/jeW0Uh+ju1qzm8uIbge6U31TSmofNMxz9UJgYCOA/nc
	qUV+4iPYslkaPj84roWC0R5Ubn6chUQm4tmgUEpsLdMWne+U+80YOfIBzhRS2pbA
	c1VhkYuvmLyv5tqcMkpFLjXRkH1G5Sv6vgCsDZQplgHyklvU691E8Dwnslr9275c
	ydf02A4jPuBEYZvt+wvedgk3FLa+mb9mSGgAtOO8HBw7JGyoumlHXLhpU8oNKIsA
	s9D4L37XnTVRMCZ9o3noNL0+FqEgObwSwcgnMa48o8D06UkTqj/VHc/VaiZ8cIEC
	/6BxS/bG4g5vhDwXdL9yNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779385941; x=1779472341; bh=U
	F8TCQq6YVX3kjQYX4J1o6p4W5AxS7fvKvCc663pllk=; b=cGucBr4ebAAAXk9a7
	Ek2KzJ+HiOFVetU0Me6ZcWlSzK/CXMBaC1W6MPJLtqvYt9vSb4O97G/X4/lIemdI
	CeawtvMK36XvN/6MlxyOWhABVk1cXwPD3q3NZUtPu6RAeqFsRd4AgmOFX3wF9R9k
	1tqHB3IvwiDs5l7pdHRRtwZOt1+fgFshvPubkcmVKD3eXAK5+6nAMhwK+7KGj8vO
	R4cOHwFdrEWq+noGrrRn1rlfn8YX+o/8KSATD/fFNOCqDnQxWhYPRAW/bwg/UyMF
	b2IusEAPkhV6Lromuvw4EOuo5ANBtxELsDLKx+asj9Y79NbIOsZ6lNgRya/gsfuG
	GnFPQ==
X-ME-Sender: <xms:VUYPah9HUDwzKDfyM2t07y9AUSAMgpXKTISQkDIK791sG63-8RvS31g>
    <xme:VUYPagj2Nhz-NzhcszdDn9_eOTHfW8KmKgsgdYAfFRdFGWMvOrv3TePoni0lAM0Tb
    6tTqPuvhEFELYwRs6oDye2NGL8tV6d73AerCUuIDmiBowuBz_bcjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VUYPagq0RsYJ8hNSknsA0BcC7uP4VhbApMeHI9gE3FrY95UC5ZRtmg>
    <xmx:VUYPaknt7b5KGiC6r1x0orkHmePxT8kVZNqIFAiQBaB3E1xbdVowwg>
    <xmx:VUYPaswbkAV0SoRok7yxdPlzaXqoJtRDYrsEx2D9RHWpOSW1kYILcg>
    <xmx:VUYPakkJ_fz8nHYJaKo1f3-JTcznPBJTSTXc3QAUAiGrbol_UZwngg>
    <xmx:VUYPauT9N9iIHr7YEWU21MZwHh9CHTvVA4wpTfchWHPt8kTnwhFBX1MI>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 43F953020086; Thu, 21 May 2026 13:52:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKLsyOUqBm4J
Date: Thu, 21 May 2026 19:51:59 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <741c2a26-7380-4d8e-aa91-fb237e9f10dc@app.fastmail.com>
In-Reply-To: 
 <20260521-b4-pks-setup-centralize-odb-creation-v1-1-f130d2a7e8ae@pks.im>
References: 
 <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
 <20260521-b4-pks-setup-centralize-odb-creation-v1-1-f130d2a7e8ae@pks.im>
Subject: Re: [PATCH 1/8] t0001: plug test gaps for git-init(1) with
 GIT_OBJECT_DIRECTORY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026, at 09:42, Patrick Steinhardt wrote:
> In subsequent commits we'll rework how we set up the repository. This =
is
> a somewhat intricate and thus fragile sequence, there's many things th=
at

Should this be s/, there/; there/ ? Depends on if this is a list of
three items or if =E2=80=9CThis is=E2=80=9D is a subclause that is suppo=
sed to point at
=E2=80=9Cthere's many=E2=80=9D.

> can go subtly wrong, and there are lots of interesting interactions th=
at
> one can discover.
>
> One such discovered edge case was the interaction between git-init(1)
> and the "GIT_OBJECT_DIRECTORY" enviroment variable. When set, the
> behaviour is that the object directory should be created at the path
> that the variable points to. This behaviour is documented as such in
> its man page:
>
>   If the object storage directory is specified via the
>   GIT_OBJECT_DIRECTORY environment variable then the sha1 directories
>   are created underneath; otherwise, the default $GIT_DIR/objects
>   directory is used.
>
> Curiously enough though we don't seem to have any tests that exercise
> this directly, and thus a subsequent commit inadvertently broke this
> expectation.

Isn=E2=80=99t it more that =E2=80=9Cthe upcoming changes *would have* br=
oken=E2=80=9D them if
not for this change? This seems to refer to a an alternative commit
history where this change does not exist?

>
> Plug this test gap.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>[snip]
