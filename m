Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91171DF995
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397421; cv=none; b=ioJqEqKMG9CwpQv3iSdtNiYOAWqVNtJPnBhHIJSRfXomyCbtBzexvObX4jGVOtZwr6xp20P3FkmO+kTDnY/2S9S5a7DxUivCxm9aRH0M1HkeXlkcjREV6sKBTcjfqxofutSW4g4Htx3lnLUL4Ysydn8LTKMzsUeodzlW8b2q6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397421; c=relaxed/simple;
	bh=hM6MZ7wAHihfb+Fz7UbZDe7mirgdlqu3dAUbNjR34hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5tabzJsqsij0agZAMUjo3GrudnNl5L4/nZbJIvb6X4iy5DHlLKyjlx0NIpcX5bULhQ7y35FkMhCHS+kTVSZUgs8wnlTSbtj0yCKyVg3dlEyeesqpiFcyhKSMzCQHj3oQUhd9D5gs20g+LLriyqYEHEji8trwJI3buMerxvjE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J8EilCwn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ud1tBOQQ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J8EilCwn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ud1tBOQQ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 086901380241;
	Tue,  8 Oct 2024 10:23:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 08 Oct 2024 10:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728397419; x=1728483819; bh=sdqfuJMAKk
	KszlGZ4opIj7JQQkHo9wASO8eYIE35160=; b=J8EilCwngYz5gduHctRRpoyFNE
	PHuaP7tckM3Jd1PmL0w8NY7uAhYzAJ9s5XPdN/3VhHmj4Z202jD8hK/pCi0spUyu
	MIpXUTK6QutgkfkMLnftNoiBZTjxPQTmeTVnl5SFjjDc6yVlf9ZUaPND3sEKT/8x
	L+uHywydb8bZbS8AlhMZmcwHGlUE15LY5GX4ZrnCYlS/Vnwu6KoSVaRG3oGSD9DG
	ymQfuIRblZ8ZPWVHqYJjnVCXoeOKF1KBbqzaQXRkVlybxC63fZe4Yt1CazDbtoJD
	o81ZNF8OwcxgbMJ4/tUHqyxwtvjNjeTOckSsdLHyBwTxH9sLWTKzhBWdaaVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728397419; x=1728483819; bh=sdqfuJMAKkKszlGZ4opIj7JQQkHo
	9wASO8eYIE35160=; b=Ud1tBOQQXD1ep3aaHNX95uQSM1QQGeiUf8434w1Khaa5
	IVrpVCh8GF0lCm/XOY/oAGJSezCHDOS2ZhQ+nc3PQLmjkLpseCpaFcCkwWI/PktX
	vkkR7Z1aFaUQPsNpZGLUmpTrC63SlRwjAaw1HZfSnkFuvFtUeHBNtba70dJAoY9B
	y0eOR6orkgU8uXzl5ypQ/EmrCrwD2QslTl9OWGp31KUt+ud1VIj4xeGMmGFZMeWg
	xl59UiFwIvFbMOABr9Byf+qArTAI/oXMBsjHbObL/PHA0rkkjVs+akqk2kqWfR5J
	PdK5oqSTYxKUjIQURqbVJRht7XcbCcwiwPtY6IlL5Q==
X-ME-Sender: <xms:akAFZ7splHGTSvbMQKVkNnI9-2MWZfWqH0r8nVz3uYmlOs2gpglkxw>
    <xme:akAFZ8fi7WML2vfFnKU37VvQWAU3w0bzuL_1Gf5gAYXu28bmwXwlbJl69WNtr12Yy
    2T-mwvANRMHE54TBQ>
X-ME-Received: <xmr:akAFZ-yw3N4yfJQnnTEZQk2FOQ6FakK_Q5Rm0ztDICBbZ9EenexSMvf0SQHkRergWw0VnQJ6EhBouE6iIxMirrJNH-_k-0fOkO_L8DWkNA7BqT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:akAFZ6PIXjGbhdAWGc7iIJ9RE4GAxbdbQWZyWdbO_ReIKMMqCVzhvg>
    <xmx:akAFZ7-jJbr33uCPaznMvbVTWDn-wRRIVYjXmk1_rxofkF1rHNnUWg>
    <xmx:akAFZ6XuHirIonUB1-AuxWtOmVSPa5d4Mc6_Yfizin9wJI5hh9nxvA>
    <xmx:akAFZ8drTUJEuRiyU3dhsHc7fD_AKB2i9tsBjrKkTrOTJKA7xwA2Hw>
    <xmx:a0AFZ-ajtoJomb8jNZqcKokykMp0_EfcpHybTqx3NgzpkvbjyaamAm8G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 10:23:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 45888d79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Oct 2024 14:22:37 +0000 (UTC)
Date: Tue, 8 Oct 2024 16:23:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [RFC PATCH 20/21] t: allow overriding build dir
Message-ID: <ZwVAaZwunBCwbD0V@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <c5ae59ce905512aaf4d02d744da90eea982eb065.1727881164.git.ps@pks.im>
 <9272f2bf-cb5b-4b1b-975e-a7340dd5c48a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9272f2bf-cb5b-4b1b-975e-a7340dd5c48a@gmail.com>

On Tue, Oct 08, 2024 at 03:04:33PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 02/10/2024 16:16, Patrick Steinhardt wrote:
> > Our "test-lib.sh" assumes that our build directory is the parent
> > directory of "t/". While true when using our Makefile, it's not when
> > using build systems that support out-of-tree builds.
> > 
> > Allow such build systems to override the location of the build directory
> > with an environment variable.
> 
> ee9e66e4e76 (cmake: avoid editing t/test-lib.sh, 2022-10-18) added support
> for reading the "real" build directory from "$GIT_BUILD_DIR/GIT-BUILD-DIR".
> Using an environment variable is fine when running the tests from the build
> system but it is a pain to have to set it when running them manually.

That doesn't quite solve the problem though, because "$GIT_BUILD_DIR"
points to the _source_ directory as noted in the mentioned commit. So
the resulting build is still not fully self-contained. So I don't
currently see another way than to introduce a separate environment
variable.

Patrick
