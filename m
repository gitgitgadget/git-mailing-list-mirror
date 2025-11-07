Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74928A3EF
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550638; cv=none; b=phQ4hTaGvBX2If/Y1UecHPZyg+/xgE+EbURPXd6N9GDzGZ1r6ny7VqDCLA3htrmLOjb+b0c7Pg+25W9MDTzcP013JUqqyIK6A8SPHldWR9PhSCiSntIj3p6EclfzM2vp90N7qxxp6Xm3U7+Jkpep450TV7beNXQxCNJeMA/DBN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550638; c=relaxed/simple;
	bh=f2laNYYJRreCCwrRxmYbS0SdqJMtt7J7SXstlHiWRRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKiGdu33JkHhs4W78tHrvIJVGtAAQE+OAnTFuK5Js6IFWnmKYcQEUjSzJipqTQBfsjCTvoNg1GSGmea3ANxBrJMmBkhgkYFEmd931CFqch24rIT0K2K6qxVyi5DEn2WwASJxPAAtzFxXP9UujGcKF3D7bEnSu8oUvV54VzkKM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kg+SpTV0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TmWAm/aF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kg+SpTV0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TmWAm/aF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 006F8EC02A0;
	Fri,  7 Nov 2025 16:23:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 16:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762550635; x=1762637035; bh=D6kfUPucH9
	oOS/lDQX1ftIKnAoCtTpnIJTJSlUc6L/E=; b=kg+SpTV0VgPWWJ+XfvGrhgB3+5
	j981G0HfDRMJuJ+c8xz1RgzVuzAThwaUSuCM0uyexkAokOdK4ApPkzQeaVRxK0Nh
	2vZ3m7AqbSqSxwJWj4GP3quNcMprO325QmO1SFI2/RtEuNhAL7d45t2SWrMZDm7K
	d3g8Q1ZkWtb88TcOk2AHt/vtbbyv34U2jajuRjFaBQ4sGAIbH8qAarQyvM/InK5r
	mekFyNwosMr9EmmLsqtNEUEVV0Aeuwng6zwW1x0t/P53aVAmd3kAx0LaUFCEt5pK
	j+TVGiCgRKkZn/CSRvY/JKcPK4G7ku95MgmoJKKW8uyZ3/evGs85uJBb3weQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762550635; x=1762637035; bh=D6kfUPucH9oOS/lDQX1ftIKnAoCtTpnIJTJ
	SlUc6L/E=; b=TmWAm/aFPO4kn4j2ZEWRrDM/RfWbNDIWkvV7JDDaHzuBiD+aqVE
	Nm7DrocEoads1IbYLc9YzgLAIVJ/mR3SnEdvPRsTQEQhOo+yynXTwLJu6sAt/v10
	VEUnXvuNK/l7wbIMJOtRpl/OJIyOLsyUmg1SNw343ErYhHj+zbVW7LQ0pnH4ZBZV
	/Fl3CtN8fxNAK1r76zaF8zW65ehQjikGX4Epxtf57VofsrKa/g22jHY6i9qdYibq
	pw/t4gdvt1MZlclhsN2pFp+CeyDASFIV89N+Gep3RbKDxZBUYS+j3QZC+FwXxFOy
	r8FIU0Vtfn3LrinrQZGfKi/s4MLdJNQsMnA==
X-ME-Sender: <xms:a2MOaSO2w5kvdHetdt7GKwhMREQ38aOFWtDt5ysm7FXZ6PFUx-pLIA>
    <xme:a2MOaTMDCo8EjncLTBJ9f4IyliqCv8NVOr9RWxwcDrDvL1enhMWXdIDVQFNy27s3d
    -4XcE1UkTKwpHjQsr6FxRjFvewIqVyETSbAN-KYDd8TJJ8c6J3J0Rg>
X-ME-Received: <xmr:a2MOabgKa_4AQ9y75q_0BuVhp01Jb3FE66nwaXGrbozKCAfFzbPaigwMd7yYQZ6_uKEbG9rSJ8WHv3NPw8NPyo3rbW1w8ILvl9TO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfetjeegudevueetieduhffhgedutdejhfejvdffleetlefhtdevjeeuhedu
    ffeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:a2MOaYtOhH_h_ol8NvOsI8B0ktzFBFl4ukGGbiytFoMO6nwTbUiDeg>
    <xmx:a2MOaZQnv2NUNTvggF8VCDzFZuiFO7n9D5MIUghSiW-znyCwhjDm_g>
    <xmx:a2MOac0xsFx3ziexOEkJHZ867yJ5iPOBDpzrfpSpxaiuYGVdp-Ot6A>
    <xmx:a2MOaeu9meY1btj02H3I4I66AffioiJTLYuzlDkEIjBX33NhlHR-mw>
    <xmx:a2MOaVBIkVg3MRfjUC1YDXxlZewpnG3q-sxemnyn5-cL9GbUbKH2Abs3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 16:23:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
In-Reply-To: <pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Fri, 07 Nov 2025 19:52:57 +0000")
References: <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
	<pull.1981.v6.git.1762545177204.gitgitgadget@gmail.com>
Date: Fri, 07 Nov 2025 13:23:53 -0800
Message-ID: <xmqqseepedue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     changes in v6:
>     
>      * Make punctuation more consistent (from Patrick's review)

Good.

>      * Explain more about when exactly amended commits will get deleted
>        (when their reflog entry expires), from Junio's review

Looked good.

>      * Be more explicit that there are only 5 file modes in Git (from
>        Junio's review)

I find "These are all of the file modes in Git" hard to read and
understand, and more importantly, does not imply that we won't be
adding any others strongly enough, than something like "Git uses
only the following modes to represent the objects it stores".

>      * Make tag object description clearer (from Junio's review)

OK.

>      * We had a long discussion about the phrasing of "A branch refers to a
>        commit ID" but I didn't come up with any ideas for how to improve the
>        phrasing so I left it as is.

I gave you something that is clearly an improvement there, though.
Just like a tag object records "the ID of the object it references",
a branch records "the ID of the commit it references".

Another thing we discussed and a better alternative offered during
the last round was "base directory", to which Patrick mentioned 
"we rather consistently use 'root tree'"

 cf. https://lore.kernel.org/git/aQhcbHJjiI5GtV6Y@pks.im/

Other than a few minor points I pointed out above, and the broken
xml id/idref that does not validate, this round looks good to me.

Thanks.


