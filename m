Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4C2E413
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766922398; cv=none; b=bMh4KRB8NTx0H68FhFxdQqmbzfrzKn9VVULlSmNtBhvJ5O0wZNU74ZwqV37N0xF8O4vIHDUYkZVxEDImiqneogYahI06i6gHLdfxEg1Rn1Xqc699+gAMwF4jy2l4b1lnEf6UneumQARavCJLYVpytmBohyVLY/FzLAEsE7ykRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766922398; c=relaxed/simple;
	bh=d9BiSrdLyATm7V3Z+V0E9JTBc69t7iW/EthrJGYIDXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dyuWrqphhUf8qY5oTGSqm7HWTSYQ2z/CNy9439b8ORgwYboLo48ShdqIThSc1U2TmzwWJ2SnGHy4JObXMcXgq5kQaxKTIhTRcXJvHsN36vfMkrSfVlXBi4ZX+1um4tDkrvMsvmp6HMG1E1DR9f5bH6T7orlWMztBaSYYM/H3B7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GFnq9gPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TUuiS8kS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GFnq9gPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TUuiS8kS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A37F71D00384;
	Sun, 28 Dec 2025 06:46:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 28 Dec 2025 06:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766922395; x=1767008795; bh=r0RKIQjeno
	jHtcUrVBv07JRMxvu5YiPwGkNcD6c3AV8=; b=GFnq9gPzr8Ltyowr2owtO4zepY
	Kyit7nK6yknuX52sk6Oe3BCXSIEYKpYkB6B7t64OPfdSQvKUYpNEQ+Js+QzWPkJ/
	P1wmZG523JZkzdi/7jel764YG9zpOo8+5p5JjzkgAzKE+F7QyNdK7ODkiwalUCNR
	YPKSc+WzAfsgDoEhTi+cC8fIHug0Uh3XrRsIYQOkwrDitc2m4ec2WEIvIsDreVof
	CSzVvJu9KYh7hd742fjcw7t0UP/6DtH5t5v4vr1c0dEF7vR1kRdRzrJarCice9n0
	0AZvJlGrvFoOx0dpbMZIQjqAwAg2bF0O0bfNbiQ6BQoecbFX2ZQtVekM3gHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1766922395; x=1767008795; bh=r0RKIQjenojHtcUrVBv07JRMxvu5YiPwGkN
	cD6c3AV8=; b=TUuiS8kSZ+wkqOUxRqOMtKhBqEkln+xYitPm9D+yLzDlHBplqa9
	qgZ0zrtPI2mxQPT6MgxC57lJJVLeqx8xKduSiJGUPvBicmzDVbbipqqsNDAJCJPU
	vFYgXCC7UYsgsSL3NZR7oazo2s5RWNbVSZswsyiivjxth8r6HgcwVBSWqX6ZEeAr
	WpDZhi6nRJyO5i1BpnPRnhL4+P8wVPXD0gtZmTpY8/4xy0MVH+YLLPTEItV03Lir
	rjuXLnvR3BP0MGut/OKMb3A1SrCw0mCjaSIyNYXB9+ETZk03as2YlZOWJIU1VM/8
	JZcF3uoaBRvatYHiP3D9Ppc72+hv6+fmrXw==
X-ME-Sender: <xms:mxhRaa71q6bYBGxy60-OSuGQV8AkZgpMzAjkYZS9N_cAs6xfBn-DFw>
    <xme:mxhRaa6viDmtrrdKZLuNP315xNzeBNKOGZ6lgCKfIClxYH1WIUxMHRbSF91a2taAR
    e7rpiOHye0RXAui-CWuDYS89lsmGewlVeyywjzimoyZnytEI6HODSM>
X-ME-Received: <xmr:mxhRaecuW5Px1rOouFt3EPD2MQAOi2ePVgwTnmPdpl-xpA42VcKrnY1dr6qdXy3r7JCPM0hRoOKvU_x9UEq_t5E5XnbudJYIMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejgedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mxhRaWCQChJsJwXx0zHgDEWiPBPigMK18noV9ez8rJD2-iwtRc1lXg>
    <xmx:mxhRaZ_u9jHFeNJjdqFQToLOGNvvzsbgjnU6Nnggcad0n7REsESjXg>
    <xmx:mxhRaZLBsEs88xsvlAhwySnOSufx1FKmAW_iHOiRgfWro8CycIEh1w>
    <xmx:mxhRaaiqrp6Qc9Poi4ujLWQ46uWBTVmByXRw3dZdDY5xTElZQrDC-A>
    <xmx:mxhRaSr2rfhHLjAF6a4sgrx435cwLAsNxC-eDoVA7gNmjxZvA1XCno1O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 06:46:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v8] status: show comparison with configured goal branch
In-Reply-To: <pull.2138.v8.git.git.1766666006561.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 25 Dec 2025
	12:33:26 +0000")
References: <pull.2138.v7.git.git.1766655947789.gitgitgadget@gmail.com>
	<pull.2138.v8.git.git.1766666006561.gitgitgadget@gmail.com>
Date: Sun, 28 Dec 2025 20:46:33 +0900
Message-ID: <xmqqjyy6kew6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success 'status shows ahead of both tracked branch and origin/main' '
> +	(
> +		cd test &&
> +		git checkout work >/dev/null &&

What is this redirecction for?

> +		git config status.goalBranch origin/main &&
> +		git status --long -b
> +	) >actual &&

Instead of redirecting the whole thing, if you are grabbing the
output from "git status", do it more like this, probably:

	(
		cd test &&
		... &&
		git status --long --branch >../actual
	)

> +	cat >expect <<-\EOF &&

Looking up what "<<-\EOF" means, it makes little sense to have these
lines ...

> +On branch work
> +Your branch is ahead of '\''origin/feature'\'' by 2 commits.
> +  (use "git push" to publish your local commits)
> +
> +Ahead of '\''origin/main'\'' by 3 commits.
> +
> +nothing to commit, working tree clean
> +EOF

... abut the left edge of the page.  Unlike <<\EOF, the dash sign
tells the shell that it should remove the leading tab from the line
before feeding "cat", and the point of using that construct "<<-\EOF"
to begin with is so that you can indent the here doc to the same
level as the command text.  IOW, you use "<<-\EOF" only because you
want to avoid these ugly lines that are sticking to the left, like
the above.  Instead you can do this:

	cat >expect <<-\EOF &&
	On branch work
	Your branch is ...
	  (use "git push" ...
	...
	EOF

and the shell strips the leading tabs from these lines.

> +	test_cmp expect actual
> +'


> +test_expect_success 'checkout shows ahead of both tracked branch and origin/main' '
> +	(
> +		cd test &&
> +		git checkout main >/dev/null &&
> +		git config status.goalBranch origin/main &&
> +		git checkout work 2>&1

Likewise.

> +	) >actual &&
> +	cat >expect <<-\EOF &&
> +Switched to branch '\''work'\''
> +Your branch is ahead of '\''origin/feature'\'' by 2 commits.
> +  (use "git push" to publish your local commits)
> +
> +Ahead of '\''origin/main'\'' by 3 commits.
> +EOF

Likewise.

Also, doesn't $SQ work here, i.e.

	cat >expect <<-EOF &&
	Switched to branch ${SQ}work${SQ}
	Your branch is ahead of ${SQ}...${SQ} by 2 commits.
	...
	EOF

As you want interpolation if you go this route, we lose quote from
the end of here-doc token and write "<<-EOF" here, instead of
"<<-\EOF".

> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status tracking origin/main shows only main' '
> +	(
> +		cd test &&
> +		git checkout b4 >/dev/null &&
> +		git status --long -b

Likewise.

> +	) >actual &&
> +	test_grep "ahead of .origin/main. by 2 commits" actual &&
> +	test_grep ! "Ahead of" actual
> +'

I'll stop here.
