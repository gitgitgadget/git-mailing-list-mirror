Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172292DF68
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767575791; cv=none; b=MThyTY5W0l2iTyL29QIaR8nu7Gd0HLvqTPXLYPgxjUYxzlLc8TVcf1jI007d2XExEkjiDRhycPBaBiy2si2FwlzbPhRufC5TwHxZB72WpCQtO4QjfqNJMURCFP2WH53WM/H36HFgznsx6gmZ+CaEk9DarNp7nGFWHr8JR5/990I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767575791; c=relaxed/simple;
	bh=Sig8i7tSGvvu88ofKhDi8cVs/lPUPGsI9kaQmdq2udA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hc+HUGhli+u36eVtz4UXsDZBItq+R3kbHjqltIIvtBk47YhjjK7iXzYiXxkA7n7AugXDJaL/L31m4UvzpLMRwdhkqdRgfLA+JhTPMkUaxiQJ1YqWwporCPGKx9mLxPACat9QylfqQ+xIXqIB5WF7NvOUjQmximeT6ueiOINqhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uk+j85ac; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFxBI/OB; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uk+j85ac";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFxBI/OB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 482BB7A00C4;
	Sun,  4 Jan 2026 20:16:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 04 Jan 2026 20:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767575788; x=1767662188; bh=yY1vN8qLlx
	OjqEaX0HcyJGsEXQucY170fd76wwlqj2U=; b=Uk+j85ac1s2na+Dw84FOGHfyde
	stEJENWmgOxAQ7G3k8uih6+4guX0IqE56s9q2P3m4GDGn2j5c9Gkk6VJlNZ3XAxk
	htPhZo3usZvrssFrqZt7fB2yC0cKbnkcD0UUgf/GnjPYOOHljqteWVsB+LCSvuof
	ysjKOzhfN6la5spSbJDWzEy1+YnbTt6Qogyb61tai2TW7l7bkPMj7SIQp+xIL+6D
	zJezZYqUk/FdyDDC9mwrmQzGOuI5V0iLJDqJlC71gVjHKHQOocB574vEApeufy0K
	unuk1tD/q5aHQvC4jszOnHz89nURKidR+JGCN9vhfgvEturdubbju71smy8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767575788; x=1767662188; bh=yY1vN8qLlxOjqEaX0HcyJGsEXQucY170fd7
	6wwlqj2U=; b=XFxBI/OBHVHT+mGY+H6DDh+bFZfvUKTq5wvGs+gZWgazhOymroA
	av5Fta6T+Xc8MrhIyPlmeuu9j2ynZEWo0YYpK0cZGwmMuTNSR80TtJpKLn9ilHhR
	TSyUIuOxpw2E+jCnC6jwzmw8ubnjhv+V/Bk6So/OoXC1ihbvyp470l+r0rdqRVK1
	+AcZAjh4NwwNRhG3hRPUl8JSlWlcq6zxY03TVNu1XBn179SjasRQcXoGgjXtTTfe
	wHJIYlPY3D6WLkAjt7CHybhkfXKtZUvXJPiOtO/6W/WADKX2F4bHxwatu52XaQtm
	xoubaAKQIQ6ziPgPALk5d0WQhRmkSVCkYKA==
X-ME-Sender: <xms:7BBbadwyLMifODMGpMPndtMk4faqXd-IGvJyQiNHh3RY0uxsk-LV6A>
    <xme:7BBbaX1dPQlK00GcuuA4AdJfDH97iJIZ1Ol8lEeDCkosxa9Jr41jHslHcHMBer37W
    zQOIASYljHfJOMGlZz_3XmYoN2MhJVN_XpCDDLFd3uFlZ2b7c9gDQ>
X-ME-Received: <xmr:7BBbaT4qe39ewXDa_3GDKjI9oqU0wTZ3YzGTv2BWRC5FshRk7th9FP2Pg4ey0xIR_BMHtsqWFhw9vg-SerNxJ0VRRXZDIjl51nkeG1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelheeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7BBbaSXmzVEHF1gEhLZmAxzB9S_Z7oLMbnvCtjGTcGvpMcxFCCTVqA>
    <xmx:7BBbaaCJImAm_jWUNxqdy_ZcbRWs8XX05xlbkbF3WpkbIGjwdu4VxQ>
    <xmx:7BBbaZ5sxR1ERHpSNCeF9cNsScclxv-Nn13wEl21I-sXEZkrQQSGAw>
    <xmx:7BBbadwZek34TjfPT21Zu5h_5ECTY0rgBIIaNxpRHX-yOJlmqdwkNg>
    <xmx:7BBbaYhRkJ7DgqW2BowUIS9aeL85OBd3HX_cxvFwKfYveOayh2dTdtKb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 20:16:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: Another look?
In-Reply-To: <20260104104855.31105-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Sun, 4 Jan 2026 11:48:55 +0100")
References: <20260104102749.30950-1-haraldnordgren@gmail.com>
	<20260104104855.31105-1-haraldnordgren@gmail.com>
Date: Mon, 05 Jan 2026 10:16:26 +0900
Message-ID: <xmqqqzs4n9jp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Sorry, here's what the code block will look like:
>
> ```
> 	} else if (abf == AHEAD_BEHIND_QUICK) {
> 		strbuf_addf(sb,
> 			    _("Your branch and '%s' refer to different commits.\n"),
> 			    branch_name);
> 		if (advice_enabled(ADVICE_STATUS_HINTS))
> 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
> 				    "git status --ahead-behind");
> 	} else if (!theirs && !ours) {
> 		strbuf_addf(sb,
> 			_("Your branch is up to date with '%s'.\n"),
> 			branch_name);
> ```

I did not check what comes before or after this block, but the above
looks like a reversed ordering.  If you have "the branches are the
same" check first, it would make more sense, as after ruling out
that case, QUICK can short-cut comparison and asy "they are
different", and presumably after these two else/if arms, you'd have
cases for "theirs && !ours -> they are ahead of us", "!theirs &&
ours -> we are ahead of them", and "theirs && ours -> we diverged"
to handle.
