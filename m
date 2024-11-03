Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10499189B99
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730677360; cv=none; b=Ip8lfx91pY0je41zAbpbV6PU6Eb2DSUCG7PodfsW3fEqySNE3XPM86irVpQX0ZzHaeKtZVJKAjP20l8F29KA9iPMqBM+vGvq99yhED9Pj/0f2QRBsYAbf1oy7ERNjwm4C37fFWGF7TWJYvuGHFVlDq5SKCwfmGovwg7Z5ZhclFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730677360; c=relaxed/simple;
	bh=s5U+tADRH2czg04Hypl9Tt7xrE7u/qE9az/F76vMkIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K5mkfPbreK3SV4/SCHBtaZhalT1YAjVpja3hFux+AU43C+qnTAYugdoGZ/Y7t5bZB0A0yz6EeSc1yaiL6O6bl7JSEWvA/sL5d4i0SBna49MNGDRoH/DFAxsZhYRB12FkrfAl/nM+HGLfHszqg3WAvJHyubHePf79k1d5fZb9lAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LUCwZh7x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igeC4Ghi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LUCwZh7x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igeC4Ghi"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 08A4413801F4;
	Sun,  3 Nov 2024 18:42:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 03 Nov 2024 18:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730677357; x=1730763757; bh=zRsV+BJDlQ
	wCpGl3CJS1ZZ0eRrL/R6CMH5wPmF7dGh0=; b=LUCwZh7xp3YwxCBSZHx5ceySNL
	xsbGkEwGNd4i774Dxkm4DizHGNZjBrLZQjO32/pw++imBoxrkeCkzzx/iRvAPchV
	zyS+BhP892J1D2dkM270sYFjs65g4AIEAxFrW/UDrzGiXtJzNjOcFPOfx2HxSpOP
	z1nxkeu9Ko6+HVyhRcnuwf4FMxyoNpZdoW7UYdQUhWRaA4/IyCly9ioV7dTlGQ6P
	r3rkY+zIfBq0+mQih0uMxIPt0eJW3LS8pL6JyjTwQlmBaiSXMbwlXizygVbTfENC
	UBCG3RDn5IU9XfMDgT/B/FX9X1T9ka3GifjNAVQW4K3QWvpVdW8btERgmRDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730677357; x=1730763757; bh=zRsV+BJDlQwCpGl3CJS1ZZ0eRrL/R6CMH5w
	PmF7dGh0=; b=igeC4GhiPzxFmSkhnAe4kjAfnK1Iu2SCWDh6V9GbPBFpL1p80Cp
	Jy1k82NxSzKqTJEFDWHU1vE1xkoMGCxpw34WNoI+a8WYTvR46TpqyVIujzdD1+MA
	f+xVyeLQWkjnXtgekFwjkYwDhOPl/2amqwD8hQ0GOO2GvETS3quYlQoa9NTbkseK
	ISNSojPX0rXzEhwrCeozNh/JU09MX+fVbZYAW2RjpIivUHIRQuT50c4OdW8Z9Ha4
	4IWy8juIDlr+8bAjT8WjShiIMsY29KXhek4ToQwkDt6IUjUyDM2q3NV6pwI2JOCt
	pI0MUlhBLCiTIcsPeB8C9o98MFaIDvXqMvQ==
X-ME-Sender: <xms:bAooZwsPAtX0LirbFpTUGi7AF-CljNdBqzRfJAavp2jfdgbn1X729g>
    <xme:bAooZ9dlfjuVXsyBVDF8g5WH1r7QaskVZb6p7VZE7QA0B7qBbSdMVvGvxDQh5aKF-
    N934vRIOb5kjKASVA>
X-ME-Received: <xmr:bAooZ7ze5C9TcFK4BPa55M-9wHHb-kq5sR1aGWEd29KoRvidyDWF27iup6WfaVZyrh6d16oO7oyIBlFxe78C1P4GYYh11GDF3qo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghlghho
    nhgvlhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bAooZzMqw6YzK15weVKu1xPxXMjoc8uIZIw8R_p5GVLh940cIT-WIQ>
    <xmx:bAooZw-OSrY5XIq6l0Ns5w-TqhsM_Ji5FhKDn_FCwxDpxWmLYJ1IOQ>
    <xmx:bAooZ7WSGhK-843mEB5PootECDquwUtFmQ3t4WY6cZP482Exbcn-gQ>
    <xmx:bAooZ5emmDy8RlM0_0yNqQ8JlAbOoC5TgwJAPwZ9QRVLfejump6DPw>
    <xmx:bQooZ0bR6dAxv3Z_c_2QwtVLpN0rrnY1V4Vt9Ffs33DkWHy_lsbwlrRr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Nov 2024 18:42:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Andrew Kreimer" <algonell@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] t1016: clean up style
In-Reply-To: <66df52dd-1b7c-4ca8-9752-646b5b223feb@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sun, 03 Nov 2024 19:59:08 +0100")
References: <20241102165534.17112-1-algonell@gmail.com>
	<20241103135111.13508-1-algonell@gmail.com>
	<66df52dd-1b7c-4ca8-9752-646b5b223feb@app.fastmail.com>
Date: Sun, 03 Nov 2024 15:42:35 -0800
Message-ID: <xmqqcyjbyjdg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> +	test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
>> +		git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1
>> ${sha256_oid} >${name}_sha1 &&
>> +		test_cmp ${name}_sha1 ${name}_sha1_expected
>> +	'
>
> At this point it _looks like_ some `test_expect_success` are moved
> around.  But my diff deceives me: all of the eight `test_` are provided
> in the same order in the preimage and postimage.

Yes, the output from "git show --histogram" seems to match the
corresponding blocks in preimage and postimage better in this case.

Thanks, both.
