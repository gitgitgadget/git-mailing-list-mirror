Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC072C08BD
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979192; cv=none; b=ob0jZZt+sOWH4twpZqWtNDoniY5slzpTXo9LGRU3sugjaI27H9UsA8DVuNw1j/5Z+PJMvRM2hTyl6e2dZ9IqrMw0gWDZjl0wqMoBIfCWIW3cdEwDVaYlAzNkZw3GTgiBF2wUSaih0W7zb1WYSDs/iSPrT+ePMunJ78M4Wl2dTFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979192; c=relaxed/simple;
	bh=RkDQuxfy4ssIwPHo7gxQeToPDQmtTBRhdhZPIRLPIM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bx/oUTvJvcJd3yuP+7X58xNb8YZB3bXvhO6aPLC0RY44Oo7OaqJyVl/h5PmIEiPPNaq2bAUcoQBLy6nXNzAsw+V0RGqgSHNCzPzlpLAY2s45xyQWGNrd0xpNf3cSpxNLkAH8caHKQUBI6jB2s7SNnW1O1EIRCnEtq0Pi2ONl2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OixxusxB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=awf/hPzV; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OixxusxB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="awf/hPzV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 712C91D00135;
	Wed, 12 Nov 2025 15:26:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 15:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762979188; x=1763065588; bh=m9TEGeuycu
	A+cXzKABBe/v1UGtfUk/J4zcH6mUNL+48=; b=OixxusxB+mF7geTx2lW/mM3pmX
	O8p1AsdthtAwqIaeMqMn58/Sjr61XTGm3Dk16oy1JnEf83/Pftl0rPBVA61377Gd
	vgaal4+wRdFQMLR2Ql4ZDJ28UlGPfPyilDyp0/imASTGdSvMFaZVPRaKJ8QgNxrX
	QhR0/88qC0sYmfb0kwlV/i7RlQUrDTRQ4c9qNOa3TPZY4O2NX+SPCmko+5Eir8J6
	2N3YzOnrvmKrQQ7vUWTqBGueCrZJG6HWAtQVB+VRuxH++7AQiXu3LXVsVWIO4vt3
	IS4Sw5TXb3wDKZWU7e7S+tvCyw7T3FkiEKoszLaIEF6fTnATg1Is+fJZ8OgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762979188; x=1763065588; bh=m9TEGeuycuA+cXzKABBe/v1UGtfUk/J4zcH
	6mUNL+48=; b=awf/hPzVqM5yoycYRnk83CAzv/0eev1x60QRoPn4byl72ABTS4c
	6IIKd7+1yJV80V7NYT5EAFldR0+HQq3YDNWF4xDWTkoAo3g1HZ89njmtHx6iDClk
	MGoR8k09KtXxiniGNMxOM3/PsmzhlvlIGE9zbgfU7eYRo319eKDvZou0inNsa/En
	QkMAY+26wDPspWjjMsWUi4xGK/z1xzhGdPHOplPNRSlMjT9QA+mLfIAPhvizVWrz
	i/Sl2QbCKLE8DoIxJEDFxsMKq6Fl1hglNYnvRBi4vgqAJRicXu9b89T5kFijWMgP
	DO9ObhZ6Ekob9qyBMNKpOYkZ8tDkigvcBJQ==
X-ME-Sender: <xms:dO0UaVj56kh2ypmj56czWvd0kZNnGNICJosrewnpU8OztD_yo3g2LA>
    <xme:dO0UacQ-_1PJK2YlXWGQ1PwnzX7lJhf6VauW3-7hXSXFNm8sZAU1Mc-6m2epbvPT2
    pu5HSSgVxDZa4GAnNbRJd_8Y3DwFD1IFssXhFri8abFKg3D9T0SBA>
X-ME-Received: <xmr:dO0UaXWtBdb2XBFXWEw478_1gD-FNmfYGFl8NGiD-IQU2t_e1J-5sSzoN66YFZWSl-BIeIohUVWLdybbBEQ40a8tvMf9SuhKnxxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dO0UaQRnzSZIjV2hCnbQIpQYi1QkLJVvoed33vCLGX9m2cUnkP8VTQ>
    <xmx:dO0UaRlJZ8fEBuWsDeOKcqHri6ZHYWRaULzSo9EVeUDu2FPg0Jd37A>
    <xmx:dO0UaW71_xXDIChXTkZz60tn-Pgf_lz7UhVwcgE8158F-b09lST3KQ>
    <xmx:dO0UaXivvm2XMmVnhTAlGvFwXjSdEGytVizqU2H2OzqEtC7W0hxr3w>
    <xmx:dO0UaeAUKHgQy6s0-nsCucbD9NVVWuU1qwlWXl4Jmf71wTvzxA4VLGbL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 15:26:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v7] doc: add an explanation of Git's data model
In-Reply-To: <pull.1981.v7.git.1762977200244.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Wed, 12 Nov 2025 19:53:20 +0000")
References: <pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com>
	<pull.1981.v7.git.1762977200244.gitgitgadget@gmail.com>
Date: Wed, 12 Nov 2025 12:26:26 -0800
Message-ID: <xmqqy0obov4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +2. The *file type*, which must be one of these five types:
> +  - *regular file*
> +  - *executable file*
> +  - *symbolic link*
> +  - *directory*
> +  - *gitlink* (for use with submodules)
> +3. The <<object-id,*object ID*>> with the contents of the file, directory,
> +   or gitlink.
> ++
> +For example, this is how a tree containing one directory (`src`) and one file
> +(`README.md`) is stored:
> ++
> +----
> +100644 blob 8728a858d9d21a8c78488c8b4e70e531b659141f README.md
> +040000 tree 89b1d2e0495f66d6929f4ff76ff1bb07fc41947d src
> +----
> +
> +NOTE: In the output above, Git displays the file type of each tree entry
> +using a format that's loosely modelled on Unix file modes (`100644` is
> +"regular file", `100755` is "executable file", `120000` is "symbolic
> +link", `040000` is "directory", and `160000` is "gitlink"). It also
> +displays the object's type: `blob` for files and symlinks, `tree` for
> +directories, and `commit` for gitlinks.

As a description of the data model, moving the exact bit assignment
to a side note like the above hunk (relative to the previous
iteration) does make the body text less cluttered, which I think is
a welcome change.
