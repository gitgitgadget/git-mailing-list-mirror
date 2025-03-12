Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469E1F1522
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821525; cv=none; b=E6iE8Jdsv8K1yqUm1X0dq3ujznWEj9yQqV8WLFLYAqR3CHCXtcSD1EDuPSDBfdtcXpS+hKogzCge1uGV/9zO1p8b1p8LxA5IFl3Ru1HVvsQdukudvBmZm5dkNc4CWKkYYxqQy1kAp8enM7qabOjYeVYhk8UInoeG8R6AaLo7rhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821525; c=relaxed/simple;
	bh=DQuc4r4IHRq7b8lrbvquIbn6/+It1GqEATWEs7Z1YXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=if4m2tzWlo8+gIjrRspb2bcgcIzds1K/qFx2lW9HiwIcM6UBgAuRpRCYd0G6/0U9wKdpPF7BYF43e295YW+P0MsHgDcyLiGeGrLNFVjjwPL//5LfLU3HN+cTi188PsyMEpIPYJ3HInTKFHoDbCrrpXndbG9Hewnup5VxMn3Qtsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VOJP212H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sxvYD+J0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VOJP212H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sxvYD+J0"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 059221382D42;
	Wed, 12 Mar 2025 19:18:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 12 Mar 2025 19:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741821522; x=1741907922; bh=g2X/M8LV36
	haFc6MU5uUMeZBtPrcAkl8r+81WV8Uc0M=; b=VOJP212Hko9yCWQRgOabGAcSX3
	YMpit1H8kVY1IvlAua03FF8CjgOwVZgXg9o0GCppr2gYXP3W68U8oj1flEM4alWb
	/ozs+xW7CBGGYe4YnPe1dlpnQC3DlT/jzi5KimoHuL4vWVuAJyYHK/iVMxU4gmj0
	eN0e5WliyAlc6uBdqvYxr35cKr4OycGCFs/5TSpOr80ADVW/lDE39rmFrXxmWk+2
	Zrvlt4oMYxTTQ8d2ygYFBHtHz8tIyPn+0HmR7WDGA1AeawAsQqGvVWaaDJR83QBC
	Rtibzbo1sWvhHe//SNo5uJt1aQBV6BxtYSw11LwgH4gCexG4TMcB2muYN0HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741821522; x=1741907922; bh=g2X/M8LV36haFc6MU5uUMeZBtPrcAkl8r+8
	1WV8Uc0M=; b=sxvYD+J0gKlHxa8s8AIuKrH/Kq78tl/4JF36CHnnVaSAGWGQSlS
	fhcEeB9ddvF1KpOoyhVAuaBBvY1uH3+6kPJyCQy5Rtf9a8pFVzxv/+V78scuT03M
	2xkTy6SakWKd5ZZKM7aR4HkW6lY8Y2WC+wfD5lWAwx0vWfNoUDFQ8ZXOX9Wzr8H3
	N4u70Npze8Pz1EAfcplj8sYmfeMCx5yAEi1t5yIp6KLI2UsLunjh5bh8NGt4Sey2
	8I1t9d3sfbSep+1lNqKetbGI4yO7RBx1qfKEU1nqfHf2Swot7cdzSqNAA8c5j8L1
	kv1gmO6cGMdFJ2cFfeJcnqVTmr58LJzM/ww==
X-ME-Sender: <xms:URbSZ6UCq6L-YEeVp_elJyM8GWtm6l-xlm4aq-LUF0f8zIivY4RrJw>
    <xme:URbSZ2l6QrUW19QAmHeWDsyRYqt7AURD3sA9lISO2nxIK4erqjykMose2i9-Dff7Z
    hUezty7Xs5DJknsRg>
X-ME-Received: <xmr:URbSZ-bMdMWJ4Wn8T-FC7NbF_NW1yHQkBKoDCcH05wPgGbfz-_xHizO_VqJrf9C8C2qt56BfuabN1mU2Ql5Ll0Du6aBGhkxBxliV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeifeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughgohhntghhrghr
    ohhvsehushgvrhhsrdhsfhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:URbSZxVOvZ-fTM3hUTHR95Ez0VUqTnys2aO7sfFLhE8NukOxaMoA0A>
    <xmx:URbSZ0nhYIWlnJNX62F59bdFE_TNH9pjtaWXB0mrk3GxVN8obgMCaw>
    <xmx:URbSZ2ce2lL-6DuzWz4swy39cXBg3C9Gs3476eJI26OgRAzSeOtrRQ>
    <xmx:URbSZ2ENwQniFKBO8jrRXM0b0OOLfuEYKiYD-f1W3lXfBtuztDZgBw>
    <xmx:URbSZyZbomHBm9g63mfhDBh_b6L0ZI9iRvpn9et5x1MGGzWC4J5mBwBI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 19:18:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Dmitry Goncharov
 <dgoncharov@users.sf.net>
Subject: Re: [PATCH 2/2] merge-ort: fix slightly overzealous assertion for
 rename-to-self
In-Reply-To: <CABPp-BH+9JcP6FDP6RFQzZbwW=XOWnWAR8PmrCS6hG4iyd2pPQ@mail.gmail.com>
	(Elijah Newren's message of "Wed, 12 Mar 2025 15:36:07 -0700")
References: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
	<f48b3310d4ae8d05780fd25e467083c4dc9852cc.1741275027.git.gitgitgadget@gmail.com>
	<Z9ID/2zx25qesuJs@nand.local>
	<CABPp-BH+9JcP6FDP6RFQzZbwW=XOWnWAR8PmrCS6hG4iyd2pPQ@mail.gmail.com>
Date: Wed, 12 Mar 2025 16:18:39 -0700
Message-ID: <xmqqr031x2gg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> But it might be worth mentioning that having side-effects in
> assertions is a huge no-no, and I understand that when folks have to
> debug one of those (I had to in a separate project years ago which was
> kind of nasty), that they sometimes jump to the conclusion that
> assertions are bad.

Yes, assert() invites such mistakes.  Why not avoid them when there
are better alternatives like "if (condition) BUG()"?

