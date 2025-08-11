Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380B442C
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949594; cv=none; b=BGJE/JMwNQPbWM2e98YfOOUvWcwoZeKSEF9dfpSf+/tpXLfNNarihyr9LDKH4hA+TQnSlQ7riOnaEPLVTWSPz2QXNdzOX76Eb3p3c0ykD5jQbDC2Djm8LEYgSwWEVdae6XnswzE/U/+sDhJB8Jl6igRei1sFHZTIjL2Bcia1zqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949594; c=relaxed/simple;
	bh=iULArl1vk1W+9dpfvWFAh3PwUxrm8CRaK+4ZD6CUmvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PdjzLLnTmVn8Jbn+k3DRQq+GNeScuYWD6LfxPvR0p7V+Mhmf/JC40dUaqEGE3guXDFg+67IGmCLJR+h7pJhj/js4jcJxdFLxH1FA3B8WXfNOqMUm90YQ5+IGZ8QaiiXLqeKMmbVrpTa/BsHStzoWLP4JPtpzGxKIfC4GL0MZz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AeYSLbKp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L/otwuyv; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AeYSLbKp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L/otwuyv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F0000EC0206;
	Mon, 11 Aug 2025 17:59:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 11 Aug 2025 17:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754949590; x=1755035990; bh=ShxFjGC6iX
	psl53I3mCGGnswM/h28t//a/pvk/2mfZc=; b=AeYSLbKpHkrOmgGLqQbyUNx3p5
	efHEfQHiknGrj2NlVaBDx3JQASf5qxr+mpalYLoVTE7igqp3ie3Za2MzSjpmQXZm
	UnkIZds3PFO8LbkcRbrHNIginWuJdi6hOZVc2L19qOQqFoG/JkuPoeErdiCH8EYt
	hfSa4r2ySUXiUJb+UXtTBHnG3rHWX5V4kzDkCXMUVriIbA/L01JJQU0PB5GeQD99
	og/N+c4RK6yDDNGWF3EpBocAdSPMW+dIM03WEcNG5nZ07lCKnrE57saTL0tlWc85
	do5G+O38cd1xf0nf5DKBXioYmm2lNokdS62dGrcGSZqnbzxgIjSe2fQ5cE8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754949590; x=1755035990; bh=ShxFjGC6iXpsl53I3mCGGnswM/h28t//a/p
	vk/2mfZc=; b=L/otwuyv57D6c2JI/1mLl3qCoBV+ZjXRcddgGeWlKM9lir46kkR
	IDAtoZP+cWpuGRHJEdIBIfoMSFx3X+qLIBSrkg/cF+06HDL6FOSI9dcSNpq4OUDj
	b4FFmkv7YJcYRV131o7rfgifU0Ssi1PynyeNe9CQKirYkJEVkQyqK70GaGkPrEj3
	EqbCxkWxnsWQedp+LqiGWPVC/X1fQ2MWNcKqRCtQ89W4aVIPH5oDVQM4ZWkoYhT1
	iLV8kPJnaoo3kbzoOrdJlWPtSv3lMhBJ8NwjEJMJ2XxEIHg2oUBFD8+lcQRYsQQ/
	3rs59+DA8NVeh0Ea1pjNgujZAShcEv0VjMQ==
X-ME-Sender: <xms:1meaaP5Fr3wuHq0sRUT0Iueqc4-t-ksnbZSIPF8PKemjGMlGFhtEOA>
    <xme:1meaaB2_N-3gg7cETCiu8aEFCFwga3pqFiwEQRLflmZ2-CWUYD7XZeiq9PQBPWCfZ
    SDchzbHyHQ_9ssRpg>
X-ME-Received: <xmr:1meaaCGLFeBIrOeqxqOUqthdzLwStBWiGoDxHvp6fMyTPk9jrNCTJcnfHqi3oXOfbanznyLW5qW-esasRsGKz8sxMiXSCK-FD0aFcqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:1meaaIhx1sx_jSvRUSTzmjTHnfY-qr7Y8ZIulOBxi1U6IHK7iC1D2Q>
    <xmx:1meaaNCEZlvm67FMjhUH-8ardpYybxT4SZ8fAYMyEHNNr16-li41Hw>
    <xmx:1meaaCS9fFgBNvHKKwBPgjOIMOMR0_WbmzarqR_X4bhTOH3syJGM_w>
    <xmx:1meaaKXA7oYzBKWA7Z1esu3JqVNbM4FxI4FZHqdTbWKGVNqzUfgwjw>
    <xmx:1meaaIyNrmwWCMuAS5ek85aaAVeoKEbJ17UwpfE6x9ilq3jvFp_ZFlJ5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 17:59:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v6 0/5] doc: git-rebase: clarify DESCRIPTION section
In-Reply-To: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 11 Aug 2025 21:51:10 +0000")
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 14:59:48 -0700
Message-ID: <xmqqpld1zfhn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * move "You can also use git rebase to reorder or combine commits:" to the
>    beginning
>  * replace "detailed description" with "simplified description" -- I thought
>    that I could write something that was relatively readable and also
>    accurate, but as usual Git has proven me wrong :). I tried to leave in
>    the details that I think seem relevant to using git: for example git
>    checkout --detach is relevant because it explains why git reflog works
>    well after a rebase.
>  * replace the git switch with git checkout that I'd missed previously
>
> I didn't use the git log --cherry-pick option in the explanation because I
> had personally never heard of that option before today, and I don't want
> people to have to read the git log man page to be able to understand the
> explanation. I also left out --reapply-cherry-picks just because I don't
> understand the use case so I couldn't evaluate how likely it is to be
> relevant to the person reading.

I agree with the above decision to leave unnecessary implementation
details out, and I also agree with the decision to talk about
rebasing done on the detached HEAD.  I will find out if I agree with
the remainder of details that are kept (and left out) later by
reading the patches ;-)

Thanks.

