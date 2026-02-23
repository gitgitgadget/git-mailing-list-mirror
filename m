Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680933C1A7
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870823; cv=none; b=g6dYYjsh1NswJITsEzYVVeoFIVbRzWfcdApfMYsj03DAxJeETJdCGTl8FQB1bKXvYRPlrqOuAVKxClo0gYF2xSRNF3It65pfOV5DLuhnVC08ll8HhHbpN/pvODb2gDv5wU2N0r5pCxt5oHQihdme44f5gy0DFfzEUmJcKlgbnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870823; c=relaxed/simple;
	bh=J1xIVTkz/yk+hURZOSzVDCZgjlTHVI7+kNk6GGsesDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FZ+VmGZvJVopfKuOLk/mDMtbWuTThWJf7AsLg/LLrUTckUVIyKNFOh6st91qcIJv2c7y8Y811cawW85Nw/SzhTLXegT6hOZaee/acIiS1ifxzNuA06GO/kGPSFAPm/kOAgOOg/yL4/txDsL9mnMRFeGjxPweXzb7XI4zg/XcmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=z+pxBUmQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U42Kuxkq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="z+pxBUmQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U42Kuxkq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 97D89EC0552;
	Mon, 23 Feb 2026 13:20:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 13:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771870821; x=1771957221; bh=i7lr5TtF2O
	TyM3z+4JctbKAqepD1Tjx32DY7JBFYHwc=; b=z+pxBUmQmreruRRuJSPkTlbtF4
	S7FJiKxlkOWGgGFL/d8bnmhLu1ZJqk2u5OGBhHE2PueBEIdAMeXlbA8e+26Hue/q
	ULX72Q8wxjnPTgdmuSgU8hphxPJY9iX+/7Tf1Er3+ACSdaqU34qfFRgVoBti/bMm
	6UDrpOAi3r21aQGv74E1NazGbDbEe0D8AobnkcLdPiYqaz/4QA9SMnfW2Hc1KlO5
	LdPU5sqrHKwQIN/yhuEwazMyq6Io2s5xViOWCnL/suKPjShKOP4OO8d1cICj9Q1a
	fYFz5f1Vc389Egguz7hGD0SSFLTqOhsJ/L+bbCxXVxlYkCsLaMISS2kOH6TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771870821; x=1771957221; bh=i7lr5TtF2OTyM3z+4JctbKAqepD1Tjx32DY
	7JBFYHwc=; b=U42KuxkqUnH6MWlxKE4tcPC1z4Yvg5abH7NTMrUeS6eoMMwGHzL
	Pxx2qF0R7rLCMpo5Pi9xLzMirFwMurKJxzEjJXBkI6+DKAcX2I1IUXzIsshiIkuV
	w5LAXX82Hjas+3woOsFTif+YIrhEGlY8J36WMUh4I5GTvwF25mF79Tmpvh1m5luB
	yFdtBDV8lm3gwRx1Z9ZCmLkE8ZcRId1kgioitjlSxpwH4nQ1+UYZlMAqHv9IsY73
	Su7ItzYtGJpvyW3r7yFdsilHRH19pmxYMBXymgo7P/dJPAvg8KHH1QccQZh/i2AB
	FMEE0Oo/VF/JzayjasJPPDUz5NaITpdbgOg==
X-ME-Sender: <xms:ZZqcafdWpuzDoDA-U8w-ziCSgBY2zbX9Cop2VOU5J9BvTa6rgsOsOQ>
    <xme:ZZqcacOx1_VTLuNmRBVQOKC8neNOQm_boenelu_wKBWm89DFiWcuJcsPYsBOP_HY4
    fWn8Z6ZKscWkPNPKt7pvSqmuBdn3szAvsJM6dSR0LVJG2P_rNHUkA>
X-ME-Received: <xmr:ZZqcadjvOd5ep5mrs2eChOyRAJ7hcGvNmXZjnRgU3kHgb2PfNvwJDPqQX4GJ22liySWtC2JRatW2M9876RNXGNMrj72XREJ89g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsrghmohhnohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:ZZqcaf08Z_CjfJ2MwdKd80OxkcO37v8pl-sfowmstU1Ei5cJo1WCBA>
    <xmx:ZZqcaXh7PWl8msvDQHH4sJW9FQW_a-s_TU44kGScIuSwuy8jysFkiQ>
    <xmx:ZZqcafevUT0do81x-lX9V6c4XbDQAU5EinpWqAA9BjdSABUk7bQI1g>
    <xmx:ZZqcaanpfnHCTagyQUhdg18Gv7rwH7SshmLDjhQyvp5P6x6BAQa-QA>
    <xmx:ZZqcaRBU3gP1LePTb853js7xoPji5vQOGm7poN9SmoihuyX7fCSOIjZg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 13:20:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Ryzhikov via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Ryzhikov <samonon@gmail.com>
Subject: Re: [PATCH] docs: remove {litdd} usage
In-Reply-To: <pull.2215.git.git.1771846234706.gitgitgadget@gmail.com> (Michael
	Ryzhikov via GitGitGadget's message of "Mon, 23 Feb 2026 11:30:34
	+0000")
References: <pull.2215.git.git.1771846234706.gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 10:20:19 -0800
Message-ID: <xmqq5x7nnwyk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Ryzhikov via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: samonon <samonon@gmail.com>
>
> *** Problem.
> {litdd} is used as alias for -- (when not inside backticks) because --
> is a reserved text in asciidoc. There is some problems with this:
> - need to remember that in some cases -- should be replaced with {litdd}
> - unnecessary config options when exporting adoc to other formats
> - in HTML it looks like "&#x2d;&#x2d;" instead of "--" (it works, but
>    browser should correctly decode hex symbols in html link:
>    see htmldocs/git-sh-i18n.html)
>
> *** Solution
> For better readability just escape -- using \.
> This is default asciidoc mechanism that don't need any configuration.
> Tested with "make all doc" - links inside linkgit: work.

Hmph, I do not quite see the point of this churn.  We'd need to
remember to do \-- instead of doing {litdd}, either way.

I do not know what you want to say with "when exporting to other
formats", as we already are formatting these source files into HTML
and manual pages.

