Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C07221F0A
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124009; cv=none; b=EnTVf4QRhT1hNtcU8vBoraUvu8MCQE0Seswjw08Musp1sn75ToXjDAPuOAJI3bItqb1SL7Ti97xBb+T3eXkDhgAdIIGiGlSMPqMKqlAS71k6Th7j02tW7mOYEVPKUnEyptYRdsmrYi8/GHDMpeDG1w2SGyE5M/2YZ0/GSh2QZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124009; c=relaxed/simple;
	bh=jbm5C88R/QVu/3tfajJBRfgMUjmh0TmKaF0FnYfvt2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KjuwvE9SAKPahITOvU6aTsvbcE49SqbZMJeQ80jkA8ioGYkN4fI6YM8K5vbw3MIfusTxjQPRIdDSkAKbFtEtXX3yXy0gN9teGbknBPddUIJrCWhncIh0++UWMp/uqHNXZQSyUUm1FsbY4kyIXIo/g5Hzst2/9TXsJnMSORUE4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZAvRjT3o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cjkX+mfx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZAvRjT3o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cjkX+mfx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 95A507A00AF;
	Mon, 21 Jul 2025 14:53:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 21 Jul 2025 14:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753124005; x=1753210405; bh=S21poanQ3x
	oA+0hcnew9N/5RS54ABaoxjt5YLvS0utQ=; b=ZAvRjT3omZ29Lrzx9MBNO3MFB4
	37qD/oKZ+q1gJGWdzLvWib2dhNLCM2O1apN1srCDYjqRnpPqV1YnjpxcLeVCTdKX
	BZd9IwU5XsVkN8ArM5OI02kbp1OA0lK+wVjUe7X3oQkzoMlcjWy4s024GulNBAFL
	QWRlww5lqdWzjgubj+7F9+sWWvtZKJhiiaV7gunz97Co0n26FVz1RhNpaatcvRuq
	GttN+TYkBp9ZpVbhWOvTkZo7r8p2/Sd5+BD0JRQaef4DZsWU+fO1ybQjECtS5f+m
	DdtkFqI73GieSuPn3W3momtM5QipHrBq1KWLQDTHabXDRqztSRhM3vnWd8hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753124005; x=1753210405; bh=S21poanQ3xoA+0hcnew9N/5RS54ABaoxjt5
	YLvS0utQ=; b=cjkX+mfxuawGnzg9BDPjQhwKQrOAW2Lp2gpYj0VYxGbO3sv1WQ3
	Trx0SAj7PEwCbelsj4YbF3UAA0YNrF2k0R4HOz8WysRX1SOYwrz+lOyje2zBCgq+
	IwuSyZXiXltsWFAVYkx7HiCpIr10lurG9TxOAqHHGsxFVBkfR9Mp+TrQqkOGalZA
	VnnbABG3HXzWdl5LnD504M+LG04CYomD7tPquOc2hFbOCtTxn4fuBlNs/N0h7HO6
	GvXpjnROVLWS/+34YAymI8OW3FrKzKc7aOTS/3IK7OB9ly1Y/dGeYhj9rLJmtWwR
	afl3nCnrpGk0woz25rRhR8GEsGA23PiUJOg==
X-ME-Sender: <xms:pYx-aOXJqg0kvvP98eZjuNI-TLXbhpqZeopHAHu_xjNPcFRGKIbHjw>
    <xme:pYx-aHhyxItWIzLZduM0_EiNUMR3goQF1SgfYsG6bqUxaE63tD9hzVHR0kuZ5XemY
    NQlbgtVZXMKArUV6g>
X-ME-Received: <xmr:pYx-aOCqBQ2z0xJIgykAGW5yDtf2nsVt35O-SsjUcmCDgLEJJ9jAOxxo8CbpSZif6J-qHwAfBv_wwgrqgAIDEVJoA-qXkKiurVjhfro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:pYx-aNuPrZGzBFPC2CMJjMBz_MTbJddDEr2aN4nmmrxr-_u6RsJRhA>
    <xmx:pYx-aCcAwV702km5uc1iwP1ZSHTrw-7q27BUmsdyVkNoK52V8OCstA>
    <xmx:pYx-aC9rBzdDYWschCbzPq2Shi90Bqt0kkaGRCszE6kdV15NoQ_xWQ>
    <xmx:pYx-aFS9fNyZbJ1p27FXjyo__b0HjcZREtsTyf67Sjj2_jBF-HRRoA>
    <xmx:pYx-aLbWa9S16MJv24eqwfjhCjceUei1rwIfDJEeQ5QvFg7dWACdNnww>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 14:53:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 2/5] promisor-remote: allow a server to advertise
 more fields
In-Reply-To: <CAP8UFD1wYXrEC2VYBHTL7NS1ksSa0oiBgB3Ua=6V1SnP=+RMsQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 21 Jul 2025 16:09:10 +0200")
References: <20250611134506.2975856-1-christian.couder@gmail.com>
	<20250625125055.1375596-1-christian.couder@gmail.com>
	<20250625125055.1375596-3-christian.couder@gmail.com>
	<xmqqbjqbsbe0.fsf@gitster.g>
	<CAP8UFD1wYXrEC2VYBHTL7NS1ksSa0oiBgB3Ua=6V1SnP=+RMsQ@mail.gmail.com>
Date: Mon, 21 Jul 2025 11:53:23 -0700
Message-ID: <xmqqtt35xtng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Ok, I have changed it to the following in v6:
>
>    To allow clients to make more informed decisions about which promisor
>    remotes they accept, let's make it possible to pass more information
>    by introducing a new "promisor.sendFields" configuration variable.

A meta observation, as I haven't even thought if the above proposal
makes sense or not, but a reponse for v5 like the above that comes
nearly at the same minite as v6 highly discourages any response to
this message that may want to say "oh, that is not a good idea
because ...".

>> By making it easier for casual humans who manually write the
>> configuration variable (presumably while testing) and allowing both
>> comma and space as separator, this design decision is forcing one
>> more rule to worry about for those who are writing the parser for
>> the value.  There may be some existing configuration variables with
>> such a "leninent" syntax, but I'd rather see us not make the mess
>> even worse.
>
> We indeed have a number of configuration variables accepting lists of
> items separated by both comma and space. As we cannot fix those easily
> for backward compatibility and they still make things a bit simpler
> for users, my opinion is that we'd better bite the bullet and make
> sure we have a simple and hard-to-misuse standard way to parse such
> lists.

The position is understandable (I am not saying agreeable), but if
one takes such a position, this series will get even longer, by
requiring such a refactoring and new set of helper functions in the
front of the series, to avoid making things even worse than they
currently are.  If you want to punt on that "simple standard way"
and leave it outside the series, then please do not add such syntax
to the variables in this series.

>> I know the name "field" was discussed in earlier iterations, but
>> these three lines together with "For example" in a later paragraph,
>> it hints to me that this mechanism is to choose variable-value pairs
>> for which among remotes.<name>.* variables to send after name=<name>
>> and url=<url>; is my understanding correct?  If so, can we clarify
>> the paragraphs around here even more so that I do not even have to
>> ask this question?
>
> Yeah, it seems to me that there was previously a sentence about what
> fields are, but it looks like I removed it by mistake. Anyway, before
> the paragraph about what the "promisor.sendFields" configuration
> variable contains, I have added the following in v6:
>
>    On the server side, information about a remote `foo` is stored in
>    configuration variables named `remote.foo.<variable-name>`. To make
>    it clearer and simpler, we use `field` and `field name` like this:
>
>      * `field name` refers to the <variable-name> part of such a
>        configuration variable, and
>
>      * `field` refers to both the `field name` and the value of such a
>        configuration variable.
>
>> What do we call the third-level of a variable name in the
>> configuration file?  The description on the "--regexp" option in
>> "git config --help" hints one:
>>
>>     With `get`, interpret the name as a regular expression. Regular
>>     expression matching is currently case-sensitive and done against
>>     a canonicalized version of the key in which section and variable
>>     names are lowercased, but subsection names are not.
>>
>> So a for remote.origin.partialCloneFilter, "remote" is the section
>> name, "origin" is the subsection name, and "partialCloneFilter" is
>> the variable name.
>
> Yeah, I thought that "variable name" could be confusing, so I prefered
> to use another word, "field", to talk about this.
> ...
> I'd rather avoid talking about "variable name" other than to explain
> what "field name" and "field" are. I think it would be too confusing,
> especially if the name of the new config options are still
> "promisor.sendFields" and "promisor.checkFields".

Sorry, the argument does not make much sense to me.

After all, the end-users who follow the documentation needs to know
which *VARIABLES* (in remotes.<name><VARIABLE>) to set to affect the
value that this mechanism lets them send out.  And the configuration
variable to control which of remotes.<name>.<VARIABLE> are sent out
is a new thing, and it itself calls it a FIELD.  Whatever name that
new thing chooses to call itself, the fact is that it is about what
the users have long known as configuration variables.

So, what makes this whole thing more confusing than necessary, to
me, looks like your use of the word "field" in the first place.  The
use of word "field" in "sendFields" and "checkFields" are much much
more recent than the concept of "configuration variables" that has
long been established in users' minds (as far as I know, these
"fields" are not even in any released versions), so I do not see why
we want to keep it and force users learn yet another word.  Just fix
the name of these new configuration variables, explain that they are
used to name other configuration variables, and be done it without
uttering "field" even once, and we would be good and less confusing,
wouldn't we?  Or am I being too naive and forgetting some already
established use of sendFields and checkFields?
