Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EBE2E11D2
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749944736; cv=none; b=Vp4+wWk3ZOUnF8lSrovFWmcx9BWJ4p5gABYPoza7BZ4AYeFcutGiY9iYGFBIhdkcamIDIDWlyFIF6iq6CNbV04/02+JTwSJ1OYG8uXE/T4COqOhUcIw9KGZxSqjncW3dTMy5wmLwbqkIYlyzFOO890QPMSv/S4xLkzScz1KZRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749944736; c=relaxed/simple;
	bh=jpVae++wYCZ30pgJ3iG8FN1udVHoLw7jjAKcA0CvAoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sE1b1oCnrA+8EflD0SI2O/MYL4GnwbELtXhzQn24t59ebeIVDrdWb9nFYu79H4MF5S4fb/V1FvvrhuVT1NfgqBhCPF1yo5QZbp5qNXVT+pIulSwxt7skTPeC5aC0+iZxOrEutCe4ql8c3B+U14EXHRQMG40dAigNCj7D01LjcUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ecym2x7T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pCTYSrfI; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ecym2x7T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pCTYSrfI"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D13B425400E6;
	Sat, 14 Jun 2025 19:45:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sat, 14 Jun 2025 19:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749944733; x=1750031133; bh=UDdlgMUbIF
	6F5xGb6Noe8mVz8Q7Pd+TgZaAMDzFlMn4=; b=Ecym2x7T4oNYP1EU1anjGZpDKU
	vT1yxXK0ph4juXdX7lywQIHlqQcCtL4GfZo91Od12Sdmsj9XAcnnchb00mre4byO
	ULVa0XJXhxqoA4rkp6Ef+06Mw1GH99wNReE3mIxb22r+ErE9hDyXjmkVNLZePeBR
	OqMU30fYGaY5pD4vVGVMOPF50HBAm9vuSlEZP48v19J9aD10oaxFEJoGh3QKR/+Q
	tatymXob7HC6lBNFl6MRhYKasneHsJvlZ6QEV+M7uDd99pN/zLnxrzAnH8IZ5Sdo
	oneIe1ZwpYEDs4W0a8uz7wm0YAahP6k3TwJk5j/ptNEscPTQzJ3KobcDJ7Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749944733; x=1750031133; bh=UDdlgMUbIF6F5xGb6Noe8mVz8Q7Pd+TgZaA
	MDzFlMn4=; b=pCTYSrfIbt3lrslO0q9f4Jq/S+QCDkbvecyagAuLwgeFq149LLW
	eXabzQIWXshhRI+/pni0pu0wzeFytkELOhxd9sPB2sn7U+W4OLJwC+ssp/1RcGh2
	LzgdjCd7B6TLAZsQfaT+1JMGE2TAjgYfGaqfEvJawFHvMMlnvnV7yO1ssKwfHymp
	Adcbe8/CGZL0GQUltEHqamS2Df5opHY+aZhTLe6Wb0gNvpaNnbFHV1rj1qN0TkYr
	KEHDK5xvDujqm949VJNxFihfYaO+9AEGSryo3XB5ORwaaVw50VdHiRlff/Xojh6z
	7C/pvo/36aqkjH9jxieNP/S2zeShDFa1qlQ==
X-ME-Sender: <xms:nQlOaCMs44ky9z9VfbBkCX_4DRo57zDpy3AOUd3zI4sHxxE6RUxx4w>
    <xme:nQlOaA9ZmyEjYVHwUXcj1EasAIeqwaWbT7JU94OYK4r9W1BOZm5tKc0NdFZ9AY3ws
    gZXzsb9SpV5e4BL0A>
X-ME-Received: <xmr:nQlOaJS9XPT6TCXYmSaCVLFx9ttwZpoVu8B6gsgbBpecokTo2zr0gSIt0rFRz7wMB5Xt5ZAJ1SWrrCajieCzx8pVMT5ytlB3VoQR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvggvthhsohhnih
    eftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nQlOaCscI78r2b8fkGbbqelqI1YLlKf1_37jhm7vGDsqSKaq57LxAQ>
    <xmx:nQlOaKdkKWtSlT0EcXhljvT6iNA1AH4a-nVC5Pcor2f99rom4A09kA>
    <xmx:nQlOaG2B6O1U-o-jiofsFIe8k27rJkaY7weGRoxeC_iNsnWwibfzjw>
    <xmx:nQlOaO-aYHl-QUzQCMQGXj-Hplfprb1NDimZm5fzlFja_cz07s8o5w>
    <xmx:nQlOaIoNPLEMdnnFHD3OgFNFfSR31ExDGlKzhWleQ2DGy1aLzX2Ti3y9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 19:45:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][RFC PATCH 0/2] Add refs list subcommand
In-Reply-To: <20250614070536.17320-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Sat, 14 Jun 2025 12:35:34 +0530")
References: <20250614070536.17320-1-meetsoni3017@gmail.com>
Date: Sat, 14 Jun 2025 16:45:31 -0700
Message-ID: <xmqqsek16g6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> This RFC is meant to start a broader discussion on:
>
>   - The desired default behavior of pattern matching in git refs list
>
>   - Which features from both git-show-ref and git-for-each-ref should be
>     preserved, rethought, or dropped
>
>   - How much backward compatibility we want to offer, and through what
>     interface (e.g., compatibility flags)
>
> Feedback and thoughts on these topics would be very welcome.

In addition to these three points, 0th point perhaps is "Is it
desirable to unify these two commands in the first place?"

I only use "show-ref" when I care about a single ref in a script,
expecting to be able to switch on its exit status.  Everything else
I'd use for-each-ref.

But then that particular unique advantage of show-ref over for-each-ref
can be done with "rev-parse --verify".

So, I'd rather not to see yet another command to do the same thing.
Rather, is it insufficient to just use for-each-ref or rev-parse,
let the sleeping show-ref alone, and be happy?

> Meet Soni (2):
>   builtin/refs: add list subcommand
>   t: add tests for refs list subcommand
>
>  Documentation/git-refs.adoc |  25 ++++++++
>  builtin/refs.c              | 110 ++++++++++++++++++++++++++++++++++++
>  t/meson.build               |   1 +
>  t/t1461-refs-list.sh        |  95 +++++++++++++++++++++++++++++++
>  4 files changed, 231 insertions(+)
>  create mode 100755 t/t1461-refs-list.sh
