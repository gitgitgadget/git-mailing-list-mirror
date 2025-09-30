Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF314D283
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266107; cv=none; b=j9XWY73k7x0yRmp7wuNi2gU9183gXKEmEZGPgYhxaeuggGorG+pzGqnhZrAheMg6VEDnaVSwsDvhYcXZbIYOvei4DrnJUHuOSotnGXYnKEH9lbMBHe/YGucypQlZV2u65rvHTpJO78DQ7tlftW/nwCZNpg9h9kSlnI346JJt0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266107; c=relaxed/simple;
	bh=vDPgMMg6F4xfL7K9iTaZbEGbflFm3PPT8Yv/42aUFdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bg6KcURU422yZluJipm/Pme4tjAI+zvHDKtlE5J2VM3idWH4Vir0VHxrLNdPzpycdfPxEE64X0U/phGwNCPr9fuQlqRR+alc43agoQGGWoyfr2ZSA2a1ry9/dT1f+ROfAY5J0ZaQ9phgtjoGZ6UZwNa87NIvhuRn2lkMGyzhomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fTRXfGfH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFBZSnM7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fTRXfGfH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFBZSnM7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F5601400082;
	Tue, 30 Sep 2025 17:01:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 30 Sep 2025 17:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759266104; x=1759352504; bh=48Paj8LxE2
	7YrZl8pIBuRrxj7Ev7k9L8+9m9EAJvPfI=; b=fTRXfGfH7yYPxWmMC5c9uNXbb2
	PBVV7hX39iNY+4+lME+m37jq49SYAUDwEfMzgU5iXckbAD1DALDdv0s0YVCdlckF
	/LuevMpClxyBz1R0XE+ic4YYlLZ5UyODu+A+7Fl1wDRibVkq/7+A5sX0rOFi2zGd
	QU+m5PdKorvhA9oSfsPtoN9vUjTebAO7SfOtvXH57Xi3Df7CieZsXCyd00F+JOFV
	ZQuh9sNDnvVNbKEViPKi9Et5Po6tfGtsj5VpPyExSZV4xab664NCs7CDuwpPckmt
	J6AGmpTsYZUoAWy5ny+4vMRs6MOUvH4ET+PkOekS6bK6vU4nMMP7zD1BMoow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759266104; x=1759352504; bh=48Paj8LxE27YrZl8pIBuRrxj7Ev7k9L8+9m
	9EAJvPfI=; b=QFBZSnM76dyCngPs8yPnJ6FAg9rUBZXINZfRhn5keNq53cf9BqM
	coanAVBJrJ53PrSJnXO5gjAsCG4bC58xKQtQQmUXkpqA/MxX2kssb4OuqtYtK6D8
	4R1LTfSm7s4+xtO2EMkGOGj7xFuo9CFfj38Nmp37Rrae42w5P7Ye/qZwHGQbcuoe
	gwc7GwNUazticVchTzwPnnyUG391962pqKmPGtJFPEIJg6ghsCzUW9N74P2OJ78u
	ytjoMj7/K4qGpaSXn1nIfn+bB6yEkyoTTol2PYLQKg5jC4dBbM56sTEcaStBe46v
	aWdPanHpIqNMOUXJKN3eVgQIXtbMxKWHrdA==
X-ME-Sender: <xms:OEXcaAU6SvloHEI__nbbwC81Z4Cm6rJ_-66y38wa061dlu_64lP9mA>
    <xme:OEXcaIRzyJ733ZkpLail17r0J0tz68-Z2JaCZFT42eTtd0LWcc6o0jrmdN-Aldowb
    5OOtwEJC-52MCQ51yzt_EUU-4DeFLE801Yy1Z-wmjtj0Dmje1R9RA>
X-ME-Received: <xmr:OEXcaOMhlfGspQj4KwzE1GbnBGRMRIcxMKz0EGVkufojNkhSZRH10Dk3m9JH29PscKrrwbulLIp1-G3fOpiq512igIEvK_l0MFDj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudeitdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:OEXcaGTPItR0Ntj0DBxZr6rNDG05Uzclp5IbPVoQEDK74ctaxp7SJw>
    <xmx:OEXcaMj0y-dEcQzxaqxorrkTxMboU-FSFirS5xvZbDJ61Vi7fjHDXQ>
    <xmx:OEXcaP8HU5elrpG67MG9LWCJqwJz0DPuKIVeVVvO6fF7VZCAAL8UrA>
    <xmx:OEXcaDH4pZbi5in7LF_qaOKGD9_T87Tds3o4ZTmd-ox5wTYtsnu--g>
    <xmx:OEXcaO5ihFXjwGfbT6DDItU7vO90eXmJq9AqT7ySmJhndrpnNqR7kkgV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 17:01:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v4 4/5] doc: git-push: clarify "what to push"
In-Reply-To: <c1d4ea8d27ff037fcc40c2c6dc1c4f0bd9000b1b.1759262314.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 30 Sep 2025 19:58:33
	+0000")
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
	<c1d4ea8d27ff037fcc40c2c6dc1c4f0bd9000b1b.1759262314.git.gitgitgadget@gmail.com>
Date: Tue, 30 Sep 2025 14:01:42 -0700
Message-ID: <xmqq4isj4pu1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +To decide which branches, tags, or other refs to push, Git uses
> +(in order of precedence):
> +
> +1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
> +   or the `--all`, `--mirror`, or `--tags` options
> +2. The `remote.*.push` configuration for the repository being pushed to
> +3. The `push.default` configuration. The default is `push.default=simple`,
> +   which will push to a branch with the same name as the current branch.
> +   See the <<CONFIGURATION,CONFIGURATION>> section below for more on `push.default`.
> +
> +`git push` may fail if you haven't set an upstream for the current branch,
> +depending on what `push.default` is set to.
> +See the <<UPSTREAM-BRANCHES,UPSTREAM BRANCHES>> section below for more
> +on how to set and use upstreams.

Reads well, does not tell any lies, and I like it.

> @@ -696,7 +698,7 @@ a `git gc` command on the origin repository.
>  
>  include::transfer-data-leaks.adoc[]
>  
> -CONFIGURATION
> +CONFIGURATION[[CONFIGURATION]]
>  -------------

Looking at what we have in previous steps (e.g., post context of
1/5, the title of the new section in 2/5), I think you'd need to
elongate the underline.
