Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E041624F0
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850694; cv=none; b=dooNHJhVZTepJyx3US3qSgEN1TJwQIyNuGcOyHTW2VtPLATYLhqVzaxAFLYLIEkQzZ+fDU5cCIo/XBBkP9DR8rz+5AfX4IwyxlrhDOQqonztZJ/3agRRBzbA28yBi85/i4fsaJH2fckE0r167FzrjbzfDb2g663GRTIIwJtNMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850694; c=relaxed/simple;
	bh=yUhfq/hfkIsDhvJGOnzXPWMrx7oo24B/N11hQgcPolA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ldD2UpObxeOoevHyXp7oC/SH1LnvI2wtyAFLkLZOIOp08iAhgtn3RcFFo6ZMH/kvu+bD7Bp9jMg9On5Wr7oxaFB5/Tbi5r1rmUW5jtBXrH5how+s0uMMoKsN/VzUmz0CnvObi2w4cjXDFT6o/w0M7E2t0LF0OxIZEQGtolMHYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ttKRjiDM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MvTDW9Ht; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ttKRjiDM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MvTDW9Ht"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD85C25400EC;
	Thu,  6 Feb 2025 09:04:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 06 Feb 2025 09:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738850690; x=1738937090; bh=JkU0lPdcac
	9XMwHBqegxh7JWU8+GZhaCShik7iHJDRs=; b=ttKRjiDM03hxc+GwZTffMUodYY
	pxquCuVb0/oR9jvAqL/WzymlZa8M+eJfujbqLReOz1uY23cbLUwF3+lOyB/jAPdY
	Uo8mTV1BGyJioRVwxrf5W6U3gTghgD1YwwvCHxG5Vyd06btzCgQh+PQ2MsysSq0c
	k3kr0R8UNanKUnnVcJBH04FDfpD7ienGQov7yNCkML6eDNfV+2WcM4HpFWrdixBw
	CmzsBZxtMeXb2MV0C9tHYKrqHz1laSRI/DIptpbFBgXuj5B8vYFZMBXZ6FWuoF4m
	ZXGJowQyY75JE4ASPIw4XOxlUWx4eHfbC31dld8PjIrD5+uDHi/uwGpk2WDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738850690; x=1738937090; bh=JkU0lPdcac9XMwHBqegxh7JWU8+GZhaCShi
	k7iHJDRs=; b=MvTDW9Hta/pPNdnZnZFCiCUtnyOl30o1cYNNWs11Bv5lor042ff
	S1YMv5jvLtr/Boo1VtOwFAiENGhxVpaKGxsEjnHbiPPLljMYkKanqkXyLqcgX/k6
	5I4y3ecV4k5H40dGXOldsmDHqRQPHJip0Y7dR8TcUnNhuvSIKETfVu11PeVF7DXm
	9Ml+Am5uSanPeWI0Oa1VftslIS3eifodXKJiSYFO6U/v2KL1JC6zp1pwBCj+2+zA
	49qH6JxrwuECqkFj3SwIDwoTQ4y4yeqi0HmAzlugtOPBxVbXq1ZZs3IKp5/Gevz5
	HFTkNUJ29hPI9wbA9caWor+8wO0jfu8F8Xw==
X-ME-Sender: <xms:gcGkZ2C_j3-iZhoTrpA73jP3GfsPzJj78wvmmkUE4n6EIz5Yictjfw>
    <xme:gcGkZwjYmmq9v6o_e1mQf7dajLk72RQQZeR9Wo8IUi-HXMNRermBnW28KtpdazJhN
    DpRdy1quqMJuVEabw>
X-ME-Received: <xmr:gcGkZ5mDxZDts8YvCCn6D2X4RCD3_lAoI8eSsnGk4wa_VFRvhVYCXZ28MfXi5By9wBWHDtS3pdh1n2YO6M1Gr3LfNQ_ZVTaXqsXq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeefgeduiedvueehtedvjeelhfekheej
    keevieegkeehvdfhvdehueelfeffueenucffohhmrghinhephhhtthhpshhprhhothhotg
    holhhsrdhithdptghonhhfihhguhhrrghtihhonhhvrghrihgrsghlvghsshhomhgvhhho
    fihtohguohgtuhhmvghnthgrthhiohhntghonhhfihhgrdguihhrvggtthhorhihnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeiihhhihi
    houhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehpihhothhrrdhsiihlrgiirghksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gcGkZ0zqQ1yXesDgzG9zrjW8mFlNe0O8njqcCPvnkBWrb0Wceo6aFQ>
    <xmx:gcGkZ7TOvm-YR4Pof7Q4jvk08z-hREbrNSA5Gsgn43ydmmN7fXjW8g>
    <xmx:gcGkZ_ZWyijhPcvs0rtiPug8KNm_1yiL6gNKTAMUphqiyOzTpil-kg>
    <xmx:gcGkZ0ScrRmmb2t74Ix_vB8AbQ2uVL_Zz4eJIqVtMZTPbXzRCn3qGA>
    <xmx:gsGkZ0R0Ch0l6pYYYhlepftxyYYO8t4Kbi7UPX_keIbzXY4J2PNDhoLn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 09:04:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jiang Xin <zhiyou.jx@alibaba-inc.com>,  Jeff King
 <peff@peff.net>,  Piotr Szlazak <piotr.szlazak@gmail.com>
Subject: Re: [PATCH] doc: documentation for http.uploadarchive config option
In-Reply-To: <pull.1885.git.git.1738790425046.gitgitgadget@gmail.com> (Piotr
	Szlazak via GitGitGadget's message of "Wed, 05 Feb 2025 21:20:24
	+0000")
References: <pull.1885.git.git.1738790425046.gitgitgadget@gmail.com>
Date: Thu, 06 Feb 2025 06:04:47 -0800
Message-ID: <xmqqseorjhj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Piotr Szlazak <piotr.szlazak@gmail.com>
>
> In Git v2.44.0 support for 'git archive' over HTTP protocol
> was added, but it was nowhere documented how it should be
> enabled in git-http-backend.

Good eyes

> This commit adds needed information.

It is more customary to say something like:

    Add missing documentation.

around here.

> diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
> index f37ddaded82..1dea4268520 100644
> --- a/Documentation/git-http-backend.txt
> +++ b/Documentation/git-http-backend.txt
> @@ -56,6 +56,10 @@ http.receivepack::
>  	disabled by setting this item to `false`, or enabled for all
>  	users, including anonymous users, by setting it to `true`.
>  
> +http.uploadarchive::
> +	This serves 'git archive' clients for remote archive over HTTP/HTTPS
> +	protocols. It is disabled by default. It only works in protocol v2.

The description looks good, from the correctness point-of-view,
and its style is in line with other entries before it.

We may want to later consider moving these four http.* configuration
variables somehow to Documentation/config/. directory so that it is
shared across git-http-backend.1 and git-config.1 pages, but that is
something we should leave outside the current effort.

Thanks.
