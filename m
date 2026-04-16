Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C01725A642
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350739; cv=none; b=Gm5/HsP7qEvmfU+kJsstMYc9ECU69h1y8MfRSknN19zUndOCo3Q2TfH5RYHzonaqJSyT3Jbqja0+NYb8DXSIZrHFcWQ1gOc37r0CyH6Yz9FBTuRo4/V38sgfpVdTXUN5Ubkr73+/kFjlck1v7TnmsBS2Cq+JkM770xY599ZBRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350739; c=relaxed/simple;
	bh=FAvlktzq4KeW6MQ2MEW43jQ9YxOajb9Vi2Dqw1Kg9ks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Faovb4gBmIwLY3HRurgn5kR4YIrV3XU24SxL8roDh9e8kmRnMJO0rqgU/LqxWx4juvGJ8YpnBzxIYOm+JjxZE9Y6cGFP17ItTYPacbtITfPy7WSUnh4NHUNrCYyvCtH4F2NAMczlSptT8/6yuPTjCgVZVdYBb9VAn46s7YqmPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ybyOAFRS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kEQy2Buk; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ybyOAFRS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEQy2Buk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 55B431D0024D;
	Thu, 16 Apr 2026 10:45:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 10:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776350737; x=1776437137; bh=sWf8cftVSg
	Sw24cc6PXZU5G7+vuMeCDtAkgK7b+OI+Y=; b=ybyOAFRS5NPJepZK9xdyW8baLR
	yqHHhUqy7HoONoboznTI2CCCF4Jo+C9DWkz2LvrVg+U7P+4odL6iqqv9LGEVRb2e
	gHe+Iiy5YsdKslFavANiUCscmA9s3VaCXc+AUaWPYPrewPR/xqTfn1ewz+1g1FqI
	ZhcDbjydn9WUZ4Aqk/r6JPq/vYMm8WXpWTuUf6QqZBBbky0/R3SiLjrSTg2KfcfI
	K4aPtD/q5gTdP3hrSaC+VuEHxDK+nQNZalr0PTV7hif6utiHBYCUirUancTVVrVf
	ocrLWeZ0Bch0BUyb7fD5Joc8SogdjY9/QR5Rzlb8SedUHoIPFlHcInhct/3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776350737; x=1776437137; bh=sWf8cftVSgSw24cc6PXZU5G7+vuMeCDtAkg
	K7b+OI+Y=; b=kEQy2BukceZcztFzYf1NGVOi3wCZbQnIGxO087oQvqoPL38Jt3Z
	o5DKBluXxd0wKCxFZ8y3fBxmhgrNlrGO1j6q9WI844W71REftOB2ddDAKzaadrh+
	Z2avTvlIa74uzOlfiSGxA1+xOvkV//xWLCKLzq7gPefWjy2AX8pNTw6uA97KlBj3
	P+v+X/pK93ogoqR5UbwDQkWwkaQ449c0L/37wtHJAGZ271FumQigO1mAO6Gh4dSD
	l0u2Ilhwsjd9bgL2vbigSRI6FBs19hKM3o8/M7A/3k43ItwszAzXmfB2MXVZdxs8
	qzXZFpCj5/CeU1Rm5b1DhFUWPm+Cxo4KmGQ==
X-ME-Sender: <xms:Efbgab_qDDBfmDxzSp3NlP4Rzx0cqSTFipqgenBX8FboMkjbFNamvw>
    <xme:EfbgaZ-RSRlchU-fh37LgRZOcnHIQa3ZJ6YjuppRWZ6F20Js320aq5TPW_5EfdBLh
    62WAZ-ykwWsCVeYKfWpC3oY6cdteNJifNvjteU-LrhIwJtXd9zu1Cg>
X-ME-Received: <xmr:EfbgabS2_-i60ZNscX4fgA-MO6XRt7uqPeXu0rgPK4RJIy_kLGXxh0krVxgD4Ck0uM4tqDog1h1eMrMfJDyB1U8nusa_m2NSyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EfbgadfwpQcktDVCF_KqdgmGeUMD1vvr-j9zwA8G27cYTFUk0EVDSw>
    <xmx:EfbgafCJ8Rc5JpwjWU8h2xCLUTMrHne2fbnqEn0TwnMcNISFZRRgig>
    <xmx:Efbgafm6Us-OLZRj4_TSqmPSYWRaXZ3ytUH6pbID7FQ-ceK-ibrRpA>
    <xmx:Efbgaaetm1k3S3y_nhVoHX7eKqqm6y4zrYCRzH_ypO-Y3DJZuaYklw>
    <xmx:EfbgadC8Bhv1zUk1YNNLSau64J5Tqd6i1fv4kgBYPYRdqHXUEQ0jJuK2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 10:45:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: chris.torek@gmail.com,  git@vger.kernel.org,  gitgitgadget@gmail.com,
  peff@peff.net,  phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <20260416100556.27823-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 16 Apr 2026 12:05:56 +0200")
References: <xmqqfr4xcz7s.fsf@gitster.g>
	<20260416100556.27823-1-haraldnordgren@gmail.com>
Date: Thu, 16 Apr 2026 07:45:35 -0700
Message-ID: <xmqqpl3z3qwg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> I do think there is some possibility to handle this via maybe a new
> option 'git range-diff --rebase', or directly via GitGitGadget. This would
> automatically create a diff with only the files actually changed, which
> saves both author's and reviewer's time.

I am not sure.  Have you actually tried to apply two iterations (I
think it was between v11 and v12 but please double check) on the
same base and ran range-diff, and compared the result with what I
complained about?  You added one helper in the new iteration, that
replaces two helpers you added to the old iteration, and the part of
the range-diff that I called "less interesting" noise were the
change to the callers to the original two helpers to make them call
the unified helper, inevitably with different arguments.  I am not
sure a mechanical textual comparison tool can tell them from the
more interesting change that shows that two old helpers did not get
added and instead one new unified helper got added.  I do not expect
this to change if two versions compared were built on the same base.

And that is why I kept saying that the cover letter needs some
comments written by the author to guide readers which parts of the
changes are notable.
