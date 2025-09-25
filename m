Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E51A2541
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784195; cv=none; b=U1burssL+L/wzMh8CeY8c3FzBxeQoqaDGMBJ0srt/aO8ZQyB2jNBNCEt08UpLFI2sOiGEWZPym/oG1HqkMKmkzJDVKVFkx7mGeCVLLmqzlekeWw57SGGVn1CTHJMwnDHhIe+SgfxlZ2fFV5+xSsJF/niF6j28zOFnJpSHH6t9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784195; c=relaxed/simple;
	bh=/yOueebCvNf4aFVekNkZLcF6USVNHz5Fu71hATxcm0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qHx6WxxaLCatjEVPkpFRGSs3cRiAFfuE83EPXagiRDL24z8hA3rUrh8edK9PvVJlIZ11lcnMR6n6xfBbWPL5igbYSdRu04yuFVvIonr1NIzK+urYBjXN/TDyXenIfKpciMOulw+NtmvmG7qLBbXXh/mldbMla4m8JLdqNOD1GLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=13F+3hda; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DnpS3F4v; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="13F+3hda";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DnpS3F4v"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE93C7A0074;
	Thu, 25 Sep 2025 03:09:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 25 Sep 2025 03:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758784192; x=1758870592; bh=bWJOKt7EeM
	XXBwcEHmBzg481tdjafeTJZGjSZXxYrro=; b=13F+3hdaozn0JEH3f1AXCTHtsF
	6tMFElaYYRwi/txdnP1qoAqnQQ3VTYYRMpM9KGS6gpMoDGqAMz0MX+s885fzKHWy
	A1slBVvDzY+5RoSuxit3XrGEnShs3gx+NdDMMZD9hhlG2Z+8iiHwxMRLC4aZ35zV
	VRqa5wIjYq8lAcIQWISPWoyFJKebEYGb2fD6FmdyirTZi3LT8dBTrsH+dJpjbJW/
	27quMdAsCqF1RNZijFOSUV9JlHOZM0BBdfW9HZArmoU0Vs021Xc28xUtuSS/Ai+x
	b6ea5ZC76xE/C41fUBAPvhc9u8k0sE9rt4MmJeQVzgpLBTJfEmofaPa4S50Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758784192; x=1758870592; bh=bWJOKt7EeMXXBwcEHmBzg481tdjafeTJZGj
	SZXxYrro=; b=DnpS3F4vj0hBqX+1OnlsoQqWDLFIutRxdlyMPssc8baYVdJRRd4
	L3etkQpq4npIU/V2p5PZURAQ45Bevmot7Nn9IKqt4W21atwDuNIPARTUoMtxj03P
	Cg/TwvjIC6mhywGsgNd8IMIyeeDD5EQ6YO+mKVquWZEodTDQ8iZPhqV7Be7v1Eu/
	mZ0ghsnfQ3m6tT/5ONynoQH6oZ+znhVb/R1c8pLHVjVhq5OOd5x7f4DcQ9kEfXMC
	YJJsBdytCtSrCehA6uDPorI44J1IeCXrZKgp5KfPBVBsw83WxPBucBKV/Q7KfM7k
	BVWo1fi22MYP4cniIuXSPc34JW7nao9nLTQ==
X-ME-Sender: <xms:wOrUaABiXnX6nwi5krLfNuN-VwAzTdFfMJ0T7WvWViZDS3dSPuWZaQ>
    <xme:wOrUaBm1pKtZf-AiS31ewA32glHxSPwrWYDzyYWBoPPVdGdyVo2z3GoOjztPJrgfV
    yzhCT4c8rdYQjGkzPGpn4GKj5BF8QjBJeTtOHFbV8lyEZBblvlA>
X-ME-Received: <xmr:wOrUaJxPbkSnSCGMRCfP9fON4JAKo6v8QZfzQ4-w1d_vu11gLLUd56ZCK4DK28n3ObrNUDG56CxY-k_UUIE8kOtFwEgFQQIhR-oh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wOrUaDQrN1_KFdaxVfJj8c-of1D0mKwEIpkXnbbMELwccCDpxBOP2A>
    <xmx:wOrUaJ-rfC--NVEXKGr0mp-dvgh5rKyJ0fHXQiH6fqWrLw29YBGsJA>
    <xmx:wOrUaJvqkTMH1aJUSNL_4vMqncjgaucBY98HPm2xW_RbLOR9Rq73sQ>
    <xmx:wOrUaJN2j0GczLkYVH-Hhg6iBZm_GmdCDT8gDywO4fM8Ijt89zpylQ>
    <xmx:wOrUaFS223ouIlK8n_QBqSFl7ZuMoJxVs1pCXuBRXWudRb7BykZX-lEa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 03:09:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v5 10/13] xdiff: delete rchg aliasing
In-Reply-To: <CAH=ZcbAm8++qGNX883epk0h3NA-Z=8+RX1bDJeTe=n2jjSsdmg@mail.gmail.com>
	(Ezekiel Newren's message of "Wed, 24 Sep 2025 16:46:34 -0600")
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<7b0856108a29f42e5a4d3faf7489d5522b683f71.1758662670.git.gitgitgadget@gmail.com>
	<0bb4f30b-6737-43a2-9aeb-3903c0dc5ce6@gmail.com>
	<CAH=ZcbCf7bUTL=BwCD8B6-AVHZg+K3JafvksLQWUx2D-XR58wA@mail.gmail.com>
	<xmqqqzvvn9tq.fsf@gitster.g>
	<CAH=ZcbAcvoXJYPHE=mcZSqPLuUPxKcSs-vd307X7uXi+aG3evw@mail.gmail.com>
	<xmqqikh7k05r.fsf@gitster.g>
	<CAH=ZcbAm8++qGNX883epk0h3NA-Z=8+RX1bDJeTe=n2jjSsdmg@mail.gmail.com>
Date: Thu, 25 Sep 2025 00:09:50 -0700
Message-ID: <xmqqh5wrhutd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> I'd agree that my reasons for making this change are insufficient. I
> think usage tracking tools _is_ a weak argument, but perhaps not quite
> as weak as what you're thinking. For example, when I renamed the rchg
> field to changed, it was as simple as right-clicking the field,
> choosing Rename, typing 'changed', and letting the IDE update every
> use. Patch 11/13, "xdiff: rename rchg -> changed in xdfile_t", was
> generated directly from that one action. That patch was clean because
> I had already gone through and removed all the aliases of that field.

If I am reading you correctly, you are describing IDE's syntax-aware
editor's symbol renaming feature; I am not quite sure what it has to
do with "usage tracking", which would be more of static analysis
thing, no?

Surely, IDE makes these symbol renaming easy and that would be one
reason that makes "because we will change this part of the code in
later commit" less relevant, isn't it?  Whether the struct member
rchg is accessed directly in the conditional and loop, or is used as
the source of an assignment to a local variable, it needs to be
renamed either way.  And with tools, it is not as bad.

>> Sure.  But looking at the use of rchg[12] in xdl_build_script(), if
>> they were "const char *", combined with the fact that they are local
>> and their addresses are never taken (to be leaked to our callers),
>> you wouldn't have much trouble with the current code, or would you
>> still have issues?
>
> For xdl_build_script() specifically it would work just fine keeping
> the local variable aliasing in.

And transliterating that directly to Rust would not cause the borrow
issue as you described?  Then it would be great.  One less thing to
worry about when we need to look at C and then write an equivalent
in Rust.

> 2. Keep this commit with reasons like this:
>   * Refactor churn: Later commits will refactor rchg.
>   * No additional meaning: The local variables express the same
> meaning as the struct field itself. Also, the conditional and the
> inner loop is easy enough to follow without using the local aliases to
> make the code shorter.

If you have to go route #2, I can live with it, but "No additional
meaning" is _not_ a valid reason to remove aliasing variables.

By definition, a local variable that aliases something like a deeply
nested structure member should *not* introduce any additional
meaning (in other words, if the code modifies that local variable
making it out of sync with the underlying structure, the variable is
not without "addtional meaning" and is no longer an alias).

The whole reason I asked you to justify removal of the local
variable on the basis of lack of readability improvement ("the
original is simple enough to read without shorter variables") was
just that.  "This variable is merely an alias to something else",
aka "There is no meaning added by the presence of this variable", is
*not* a valid reason to remove it by itself.

So, with the same code but with a better justification like "the
original uses a few local variables to shorten the code, but open
coding the access to underlying members of nested structure without
these local variables is not all that hard to read, so let's do so",
would probably be an acceptable explanation with no need for other
excuses, I would think.

Thanks.
