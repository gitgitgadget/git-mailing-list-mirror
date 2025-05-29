Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223651E531
	for <git@vger.kernel.org>; Thu, 29 May 2025 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748542566; cv=none; b=ELg7muytsZVdGxfeqSea7t2pHsGa6EHydn3TuEWQT/MuKS1aw4cOZS1pQhKeRQRL8YW3fX8xSWp6kfU1+iDBic4lDM+OxxbYV/3qnvIZ9YMfgydSi/PwrlA2leEPOfOwfEES+3Ghb0fspJwjYOYkauWdxKODybWtv2Me2rfoX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748542566; c=relaxed/simple;
	bh=M5uXmYP/y4A/fvwlGs8ViKbf/ahjYjiz0iPG2D2kCdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s/h6Ull37WpBfqMC0dJN3F1Tn18xdBQ/cky6y+s++zps53UHUxfsVTyIeMS7SXWy+49Ob+uMtEJiHZmek4dHIwwMh90knvgimZB7HW+EnHEAnb57i9mBwMNNojUf7+2CsalufJtvRLb35oN4vyCuGFn6D3vV4fs2mSKruKtUI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YBeWcU9m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kI2AuX6v; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YBeWcU9m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kI2AuX6v"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 208F71380337;
	Thu, 29 May 2025 14:16:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 29 May 2025 14:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748542560; x=1748628960; bh=ZShQp0NCvC
	PGqQbHXaVfSqaXjznyCWbKPzTdnBktbUg=; b=YBeWcU9mf03Dsul/0sdgIExguA
	a5s67T05CutMRfaINChQOv5EkI1zQ+N6kdoBAGax3MSMbEnFimuQJ1DPBe1AlJ/h
	IibFXlUdbvFfTIexP6Pwbpyhn0gxth/hND2Gpjlz9rIJWLyNF18YltiOO2jnYU2O
	KUrjJRtTVD9EXqeg84gHQQiQFingZkA3OW84tjZ8s4xJ/74IhQONLUh6OuKXbmIz
	XXHkYdWauudajnRQQKFOIA2xhyv3jphWWsd2yfjsIjWKFOR2D0qSHxBkrmGnVvkr
	5laltUb1n1dD/7HqsZ4/GgtvYWRfPYeuWs08XLioEkgyqfiHH9Jja0BvC34w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748542560; x=1748628960; bh=ZShQp0NCvCPGqQbHXaVfSqaXjznyCWbKPzT
	dnBktbUg=; b=kI2AuX6vgkZfK9bpO6tghMCxdhbHAM1U8PRtHWnxxAn/HyPAWXi
	phMvBIZ/Zq9xVhBzWhD+93iGOhvr63dRDSAW9PhJkcawcAxVCZFRT6295Kva+1xe
	FL4WWAiHs1MaMXTVOOfBcBPjQ++aTBkhBZ2zaCSPI00B39+j9iES75Z5XyO/VVa6
	spr0o58vSOZqiPK0wI8sF9haou59R4Cg+MosVEGZdKLUIN2jAKPTVNX2Lxd76/dK
	3Ks73P5j90yytHvkSaT/RJhEywROlzVzgjVUreFyOmsvLoayLhpogIzVsOmlIJNS
	PQBxsQAUEtz+c2r7hHSPS0CcGSrXdaKdKEw==
X-ME-Sender: <xms:X6Q4aBS6N5iBqIz0FTjlqwoisHAar830heL6b9vXbXZPB_sIgU74Vg>
    <xme:X6Q4aKxOTgu6FXxWCKdbmMLzqzVA5IB-FscrzJKnMTdfdW3Qe2OYnGBSBkPR-vcJ4
    HTR6BFNuDWoYwbKvg>
X-ME-Received: <xmr:X6Q4aG1f9tD5MMzUz5A5hMB_A7vKzbhZrSJcYneTSq0LNb3myyzxKHWVQ_xhGX6Jd5NMuIahSEgRQ4iGp1sohWJlt5aJIbfpn-VAHck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieekfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuddvfeev
    leeuteekhfevheelfeduffejleffgfelteeugeduuedtgeeigeelhfenucffohhmrghinh
    epudeifedrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhi
    vhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjuhhlihgrnhesshifrghgvghmrghkvghrshdrohhrghdprhgtphhtthho
    pehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepiihihi
    grohesughishhrohhothdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhhrghnnhgv
    shdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X6Q4aJD7ARYz0vibPVNf4iWv_PmGYDm2AltlZUzEJWFiK6vZqk39-g>
    <xmx:X6Q4aKhA3ysKRvA5QY56IOS9xV27zOKdvSWp1XbJAUOgOyqrifkTFg>
    <xmx:X6Q4aNoT7A32noXyYfjyiL10spG76RKYyJbG6xJaKSLr2xskEBXpFQ>
    <xmx:X6Q4aFjh79KwyivRxqyznGItUO_dYLgzhe0G6U4r4S4Md4Mc1e2jmw>
    <xmx:YKQ4aEnKryklUA87a1EOQvUB2q7SgFfMgLbzzdNlKuH1XIEToXzDSVzL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 14:15:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
In-Reply-To: <20250528070521.17379-3-gargaditya08@live.com> (Aditya Garg's
	message of "Wed, 28 May 2025 07:05:34 +0000")
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250528070521.17379-1-gargaditya08@live.com>
	<20250528070521.17379-3-gargaditya08@live.com>
Date: Thu, 29 May 2025 11:15:57 -0700
Message-ID: <xmqqa56vl1uq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> The current documentation for git-send-email had an inconsistent use of
> "", ``, and '' for quoting. This commit improves the formatting by
> using the same style throughout the documentation.

Nice.

> Also, at some places, minor grammatical errors were fixed, and some
> non existent links were removed.
>
> Finally, the cpan links of necessary perl modules have been added to
> make their installation easier.

Hmmm.

>  sendemail.multiEdit::
> -	If true (default), a single editor instance will be spawned to edit
> +	If `true` (default), a single editor instance will be spawned to edit
>  	files you have to edit (patches when `--annotate` is used, and the
> -	summary when `--compose` is used). If false, files will be edited one
> +	summary when `--compose` is used). If `false`, files will be edited one
>  	after the other, spawning a new editor each time.

Looks good.  "edit files you have to edit" reads somewhat funny, but
the topic of this change is to correct mark-up, so it is the right
thing to do to leave it as-is, at least in this step.

>  sendemail.confirm::
> @@ -101,7 +101,7 @@ sendemail.signedOffCc (deprecated)::
>  
>  sendemail.smtpBatchSize::
>  	Number of messages to be sent per connection, after that a relogin
> -	will happen.  If the value is 0 or undefined, send all messages in
> +	will happen.  If the value is `0` or undefined, send all messages in

Ditto.  "or undefined" will make readers wonder how they would
specify such a value (i.e. 'undef' in Perl) in their configuration
file, and may need rephrasing, but again not within the topic of
this step.

> -When `--compose` is used, git send-email will use the From, To, Cc, Bcc,
> -Subject, Reply-To, and In-Reply-To headers specified in the message. If
> -the body of the message (what you type after the headers and a blank
> -line) only contains blank (or Git: prefixed) lines, the summary won't be
> +When `--compose` is used, `git send-email` will use the 'From', 'To', 'Cc',
> +'Bcc', 'Subject', 'Reply-To', and 'In-Reply-To' headers specified in the
> +message. If the body of the message (what you type after the headers and a
> +blank line) only contains blank (or Git: prefixed) lines, the summary won't be

Shouldn't 'Git:' in "or Git: prefixed" be marked-up somehow as well?

As these mail header names are all literal parts, shouldn't ehy be
marked up like `To`, `Cc`, etc.?

> -	by 'c_rehash', or a single file containing one or more PEM format
> -	certificates concatenated together: see verify(1) -CAfile and
> -	-CApath for more information on these). Set it to an empty string
> +	by `c_rehash`, or a single file containing one or more PEM format
> +	certificates concatenated together). Set it to an empty string

What is this change about?  grammatical errors?  non existent links?
cpan links?  It does not look any of these.

> @@ -298,18 +297,18 @@ must be used for each option.
>  	connection and authentication problems.
>  
>  --batch-size=<num>::
> -	Some email servers (e.g. smtp.163.com) limit the number emails to be
> +	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
>  	sent per session (connection) and this will lead to a failure when
>  	sending many messages.  With this option, send-email will disconnect after
> -	sending $<num> messages and wait for a few seconds (see --relogin-delay)
> -	and reconnect, to work around such a limit.  You may want to
> -	use some form of credential helper to avoid having to retype
> -	your password every time this happens.  Defaults to the
> +	sending `$<num>` messages and wait for a few seconds
> +	(see `--relogin-delay`) and reconnect, to work around such a limit.
> +	You may want to use some form of credential helper to avoid having to
> +	retype your password every time this happens.  Defaults to the
>  	`sendemail.smtpBatchSize` configuration variable.
>  
>  --relogin-delay=<int>::
> -	Waiting $<int> seconds before reconnecting to SMTP server. Used together
> -	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
> +	Waiting `$<int>` seconds before reconnecting to SMTP server. Used together
> +	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginDelay`
>  	configuration variable.

Together with the previous hunk, "$" before the placeholder looks
incorrect, but it would be preferrable to leave it alone in order to
keep the patch focused on mark-up fixes alone.

As <num> and <int> are both placeholders, not something the users
would literally give, neither `<num>` or `num` is appropriate
mark-up for them, though.  Probably "_<num>_" (without double quotes
around it), if you look at Documentation/CodingGuidelines, I guess.

>  Automating
> @@ -318,7 +317,7 @@ Automating
>  --no-to::
>  --no-cc::
>  --no-bcc::
> -	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
> +	Clears any list of 'To:', 'Cc:', 'Bcc:' addresses previously
>  	set via config.

The same comment about mail-headers being literal applies here.

Even though the proposed log message talks about "minor grammatical
errors" and "non existent links", I didn't spot any changes about
them.  It is very possible that they are buried in the mark-up
fixes---it would make the patch much better to separate out such
changes and group the changes of the exact same kind into a single
patch.

I'll stop here for now; I may come back and continue from here
later.

Thanks.
