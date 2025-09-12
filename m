Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6C7494
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710481; cv=none; b=EvoRM+4ipmlNKuC2ZpTRMrXB/8zAL4JCjly7mKLQDETau7U/otjWmEjXa/A/eiCW6JpYkgv5X9kojcAdgdBtb9qvevmnRqeaLkSddyn5DPuOFsnkPCqyBoN2k3x3Pht1k3hSrnqO/SP/4TgSqGi/u3+A9Ft8X3UJ93p0puB34x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710481; c=relaxed/simple;
	bh=cZSNRkvhglTMo7ymg0Rekdwtlu/vLCmKxSO62thhJ0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JCqiqJk/hq3FTPSJp+YoMvY++aA4XGwRrEn3JoX8FGOS73dRVhQDtojTE46h8eAgq2DKeEDyBNSxMSJVhIRYAdZLZos0AX5ICjz4znugSh4OtA3P1moJGDztsp3QO5ctNk8jPb7JsOtD/r/ep8FxiEW0kPhEmn7Z+GlgEqpP5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hTqnU3AF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bywsDp7K; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTqnU3AF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bywsDp7K"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED51E14001A9;
	Fri, 12 Sep 2025 16:54:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 12 Sep 2025 16:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757710478; x=1757796878; bh=1qOyXzvy/v
	fnec2/D3uwzRXhS1KV4EFHTkXvdajhg7I=; b=hTqnU3AFESM0tlorXHCMnXHa6R
	P2iekIT7z8ve+I1Gn8E4PES+U/EvIfEfFhHPfz7d+Q71f6EipPrpF68OwN0wRaPa
	ob9Tuq6vWpKqRIHJOf3YWcJ8Z0vzVFUGlIhgu2MaD2dNDWc8WrBYEtp9qFzAXjt1
	8J+M/FmSxCC6o9aGEZDJn+jkGPgZeV3xzvnQ1uhjTA9IAkh0mrZd3+dbv8r+VxFz
	2kQ6Wda7jSUj8r1Z/1fT3MDxCMxPS+lQgVspaYIjjGI+1pZN41bsjYfhCu+DD6fA
	tLZZfiAvTnIXP4mzpt7S0vWmFXGr25AsmEwumQuwONpougfw1l1TOGd35Q9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757710478; x=1757796878; bh=1qOyXzvy/vfnec2/D3uwzRXhS1KV4EFHTkX
	vdajhg7I=; b=bywsDp7KobKi1nKALxkRGl+ufPElpP/bcoZ2kFXrdS5H1B0BVRT
	fbboYdB7bOig6Ze5LXSp7fV8DVerLWFkZVOSxRlQxUHdDzuV80OJ9+N3iyCBGDXt
	0z1MuH/yOEL7PxqPG+U7DcMhSzJbl2Vc1XWzAVWZEKw9EX7qTz/gtY8ex3o6yv3y
	r0pTxLqSVV/zRVYvIPIlTQCbZcjeJP1NxAZJto74+f+Oqr4zaraY+8rMJrkckJQn
	8F94b9Bwpmh1kCROyhD3PhNIxipk3NcSNeIh5uwpoJHXjiM92zJCCYXE90eyJzua
	3YlJDY8mjLInhksvJhNniX6FsQ5ZUW1SQdQ==
X-ME-Sender: <xms:jojEaO7LcKJSnZb2C8tsGL1jkOxAk5qSo_lNIe0M81EBy1JkJySRxQ>
    <xme:jojEaAUDai03ye5t9r9y8aqdFGYZlmLF7vUkqxK0Acm4wtzcwGVR7RS7oPZCzFjn8
    7AfkQe-lm2Q8nkigg>
X-ME-Received: <xmr:jojEaN42Y5fmDNcSbnrDCOmZF6ECXJpf3EDKK7bHkNP-DeVQ1QwjX0cf1P4njwct81WNWbU0ejZD85ARka6BBt1u2VgOZ-aiAAhpW2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhu
    lhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:jojEaLqfpxcvgvIVCGfqCv8Naq50k29ldYrOLrgJ3mq1cfNgmdVTgw>
    <xmx:jojEaAk9iMb3BDwEikkhsqE_JABhmxNhuNDSLoCEVzZnmFauSktDsg>
    <xmx:jojEaHOJLA-K-rtZuTPXyflU-Ikg8Dz7obb-GwQgF2Q6qdx3fn4TkQ>
    <xmx:jojEaEPcRejWIEMckNSwsfMFP1i9nvaqg3Nw8fxXUEZNYsMJ9AO_Fw>
    <xmx:jojEaHd2JyliYs65c8q-Ca3aUfTYVDPP8b-Am2wKWceNEoxLbLnOvIG6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 16:54:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v2 1/4] doc: git-push: clarify intro
In-Reply-To: <270edd2b00e63ef396ae69a9a7e9113a54f0df82.1757703309.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 12 Sep 2025 18:55:06
	+0000")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<270edd2b00e63ef396ae69a9a7e9113a54f0df82.1757703309.git.gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 13:54:37 -0700
Message-ID: <xmqqjz23l7ci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> From user feedback, 5 users are unsure what "ref" and/or "objects" means
> in this context. 3 users said they don't know what "complete the refs"
> means.

Well, "this concept I do not understand" from many users is not
necessarily mean that the concept does not have to be taught.

> -Updates remote refs using local refs, while sending objects
> -necessary to complete the given refs.
>
> +Updates one or more branches, tags, or other references in a remote
> +repository from your local repository.

This is a very good rewrite of the first half of the sentence.
Complete loss of the latter is a bit disturbing.

    Send data that records commits, directories, and files
    (collectively called "objects"), and update branches, tags and
    other references at the remote repository, to make newer part of
    the history available there.

or something?

> @@ -44,6 +40,9 @@ corresponding upstream branch, but as a safety measure, the push is
>  aborted if the upstream branch does not have the same name as the
>  local one.
>  
> +You can make interesting things happen to a repository
> +every time you push into it, by setting up 'hooks' there.  See
> +documentation for linkgit:git-receive-pack[1].
>  
>  OPTIONS[[OPTIONS]]
>  ------------------

Moving the description of the secondary effect down like this is a
welcome change.

The original had two blank lines to separate the previous section
and the subsequent OPTIONS section, but now we have only one.  It
would not make a difference in the rendered output, but having a
blank lines between paragraphs and two blank lines between sections,
if done consistently, would help reading the documentation in the
source form.

Thanks.
