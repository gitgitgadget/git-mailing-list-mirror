Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D752F4335
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890589; cv=none; b=JE+cUE8mJy3LPbfiUZUuWUKwRk9/4H9Az+bYocd8ofPFTiz4S0V1FolaIwMx94+Puh88853G4ElrGXAAZmUIcGl7CoEm8mFw8fRQZFqfIFVtFhKBxfaTjW00wAi3fFXU/Cig0zCWu08ckf7BhS6J2qD1TJRq6+IDnX63zOse0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890589; c=relaxed/simple;
	bh=j9lRG62biMHT9dkRAYsPbwPsGil+5f9i4NvRnTGmwes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=baGr+30ObXCTRwSWE3QlMKeVhJ/FT3Qs3J39/CaHb7YHThr96HFY5so7Ne1pcdZ1yK1QS8huCQsw6vamAzeVUp1GAXU7bg6vfHK7SU5LFjf3G+jGwnz/+78NkAqyz69DcwHkcK0d45iG1xhczTUBgOIekkqV1JPdvPMJHCVFAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V8mft06O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L48yxJ/1; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V8mft06O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L48yxJ/1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F0E71400154;
	Wed, 25 Jun 2025 18:29:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 25 Jun 2025 18:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750890585; x=1750976985; bh=KJ0VX4gW/H
	aCIEwVbwsQ+jDLE/7CnyVviKjHldKyXek=; b=V8mft06O2J+JlIConqb2ADb6W9
	1yuYN+ycA4I8iEe7Pur9sX4VFvD6GwhxhtIAuIH0PYnmRSi19ukYevCQCFQ8nvi5
	PTjQ91tSZhaWlWX/lZews51gJ9IplBR0bigI+FgWyTI4/e8d5+3mQ74ORYgetwE9
	IvZSo4++ARgw1pC0ODqGTSrpymTLFwbOKyES7XrJPjtV4mDmm3PXuSnYp4T3TdSZ
	NoRLTbCicOKZ70HPHG3j1Sq+PQXc1/hIh9zzScYeElc0l+inj1CEFHU1wtulnR3Y
	O6zpRCgGhMWUctKPPz/s6PYtB+xYXLtcLqbf39hV1EU+CMbjnggfS9mH5XfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750890585; x=1750976985; bh=KJ0VX4gW/HaCIEwVbwsQ+jDLE/7CnyVviKj
	HldKyXek=; b=L48yxJ/1mxg822MBnUnasiNOW076hcVICilALT9v7b7lUYeAZ7S
	oeDKUYUQgrB/HeS8MwBJN3TeK9mDauvPoG5gDYvPEM5JmUEn287cQLoz8Ev2gdCn
	Qim2NJMScEHeTbPiRavpAoad6diSXh4any5bIfH7A8LerajatwUXYGy3q38mmGSq
	SrlOsXyBvu2lhfXxJXWW9eTvhFMzQBfd7GYlER+ia4+wsv5hxDC5ECdjcxhsALXV
	0ukCccs7eFfMcexK53Mpy6TxUwNm2c2R1n6kI4cDrena+qoCcg4BEI5pjshNca9B
	WIq6ZM9eoQs8VqhuHzHFT0DWfNeO1yK3RfA==
X-ME-Sender: <xms:WXhcaHDaQvcQIUsjTxpp-r-hQg_emWLTYZpwMT1yFu0I4aePKDtQoQ>
    <xme:WXhcaNi97R738DgU-x-x1kxONw-5XSNgCuy2BwTWzfLmyE0WyNbdoXHDBlHxEV0ZZ
    g5D52xVr2LoRDwiiA>
X-ME-Received: <xmr:WXhcaCk9Sg5SnW-QmjsZrqUFJZrPC4FOXZinoCkGrfy0OMDsOJKj77GtqJRIkssK_yJJ3kHk_IEdet9oqi7dV8eJYGSUvUEC8CvDAxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeeljecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:WXhcaJxMPv2xchufp4w_xDeWwsi7bdHnFdCSHb7IuDCNz-VU3ZwwXg>
    <xmx:WXhcaMSKbvCDtfLpZTIkLLRy1X1A5aWPQQ88BrH5fiX4C9blzZNlrw>
    <xmx:WXhcaMbJUxUbe5TqbHPGROzUrkTQAmIzky4KrsmujQ0ctXvvt5uJrQ>
    <xmx:WXhcaNReGoX2nW4YJkWIC3hzLkMacYujQ7x8ZQAbO5JK7FQzdoh8Sw>
    <xmx:WXhcaIfmwdLd_Gch6DiKMPTKMm_1RbEijEcyfC8RBw9-Zi4NGOAMCOf_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 18:29:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 2/5] promisor-remote: allow a server to advertise
 more fields
In-Reply-To: <20250625125055.1375596-3-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 25 Jun 2025 14:50:52 +0200")
References: <20250611134506.2975856-1-christian.couder@gmail.com>
	<20250625125055.1375596-1-christian.couder@gmail.com>
	<20250625125055.1375596-3-christian.couder@gmail.com>
Date: Wed, 25 Jun 2025 15:29:43 -0700
Message-ID: <xmqqbjqbsbe0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> For now the "promisor-remote" protocol capability can only pass "name"
> and "url" information from a server to a client in the form
> "name=<remote_name>,url=<remote_url>".
>
> Let's make it possible to pass more information by introducing

Motivation, like "in order to allow the client more efficient
transfer", "in order to give more control on what can be fetched
from the server", etc., needs to be given before we say "let's do
X".  We want to do X not because we can do X; we want to do X as it
currently seems to us the best way to achieve Y.  What is our Y in
this case for the proposed feature?

> a new
> "promisor.sendFields" configuration variable. This variable should
> contain a comma or space separated list

By making it easier for casual humans who manually write the
configuration variable (presumably while testing) and allowing both
comma and space as separator, this design decision is forcing one
more rule to worry about for those who are writing the parser for
the value.  There may be some existing configuration variables with
such a "leninent" syntax, but I'd rather see us not make the mess
even worse.

> of field names that will be
> looked up in the configuration of the remote on the server to find the
> values that will be passed to the client.

I know the name "field" was discussed in earlier iterations, but
these three lines together with "For example" in a later paragraph,
it hints to me that this mechanism is to choose variable-value pairs
for which among remotes.<name>.* variables to send after name=<name>
and url=<url>; is my understanding correct?  If so, can we clarify
the paragraphs around here even more so that I do not even have to
ask this question?

What do we call the third-level of a variable name in the
configuration file?  The description on the "--regexp" option in
"git config --help" hints one:

    With `get`, interpret the name as a regular expression. Regular
    expression matching is currently case-sensitive and done against
    a canonicalized version of the key in which section and variable
    names are lowercased, but subsection names are not.

So a for remote.origin.partialCloneFilter, "remote" is the section
name, "origin" is the subsection name, and "partialCloneFilter" is
the variable name.

Armed with that knowledge, perhaps something like:

    <<the motivation comes here, and then ...>> In order to give
    additional information to the client, the server side can set a
    new 'promisor.sendAdditionalVariables' configuration variable,
    whose value is a comma separated list of variable names.  

    The values of the configuration variables specified by this
    variable for the given remote [*] are sent as comma separated
    list of variable=<value>, after name=<name>,url=<url> in the
    promisor-remote capability.

    [*] Concatenating each of these variable names listed as the
    value of promisor.sendAdditionalVariables after remote.<name>.
    results in the configuration variables exposed to the client.

to replace all of the above, and then it ...

> Only a set of predefined fields are allowed. The only fields in this
> set are "partialCloneFilter" and "token". The "partialCloneFilter"
> field specifies the filter definition used by the promisor remote,
> and the "token" field can provide an authentication credential for
> accessing it.

... is a good thing to describe that we have these two supported.

And this one ...

> For example, if "promisor.sendFields" is set to "partialCloneFilter",
> and the server has the "remote.<name>.partialCloneFilter" config
> variable set to a value for a remote, then that value will be passed
> in the form "partialCloneFilter=<value>" after the "name" and "url"
> fields.

... has already been covered.  My main point is that we should
clarify what a 'field' is and how it relates to the variables in the
configuration file of which side (the server, not the client) a lot
earlier than we say "these two are the only ones that are
supported".  Before understanding what a field is, "only these two
are valid" does not give readers much useful information.

> A following commit will allow the client to use the information to
> decide if it accepts the remote or not. For now the client doesn't do
> anything with the additional information it receives.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config/promisor.adoc    |  22 +++++
>  Documentation/gitprotocol-v2.adoc     |  59 +++++++++---
>  promisor-remote.c                     | 134 ++++++++++++++++++++++++--
>  t/t5710-promisor-remote-capability.sh |  31 ++++++
>  4 files changed, 221 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index 2638b01f83..beb8f65518 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -9,6 +9,28 @@ promisor.advertise::
>  	"false", which means the "promisor-remote" capability is not
>  	advertised.
>  
> +promisor.sendFields::
> +	A comma or space separated list of additional remote related
> +	field names. A server will send these field names and the
> +	associated field values from its configuration when
> +	advertising its promisor remotes using the "promisor-remote"
> +	capability, see linkgit:gitprotocol-v2[5]. Currently, only the
> +	"partialCloneFilter" and "token" field names are supported.
> ++
> +* "partialCloneFilter": contains the partial clone filter
> +  used for the remote.
> ++
> +* "token": contains an authentication token for the remote.
> ++
> +When a field name is part of this list and a corresponding
> +"remote.foo.<field name>" config variable is set on the server to a
> +non-empty value, then the field name and value will be sent when
> +advertising the promisor remote "foo".
> ++
> +This list has no effect unless the "promisor.advertise" config
> +variable is set to "true", and the "name" and "url" fields are always
> +advertised regardless of this setting.
> +
>  promisor.acceptFromServer::
>  	If set to "all", a client will accept all the promisor remotes
>  	a server might advertise using the "promisor-remote"
> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index 9a57005d77..0583fafa09 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -785,33 +785,59 @@ retrieving the header from a bundle at the indicated URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
>  
> -promisor-remote=<pr-infos>
> +promisor-remote=<pr-info>
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  The server may advertise some promisor remotes it is using or knows
>  about to a client which may want to use them as its promisor remotes,
> +instead of this repository. In this case <pr-info> should be of the
>  form:
>  
> +	pr-info = pr-fields | pr-info ";" pr-info
>  
> +	pr-fields = field-name "=" field-value | pr-fields "," pr-fields

Typically a name is at most a few words (concatenated with some
punctuation), and url would probably be a few hundred bytes at most?
can we afford to cram even more var=value on the same line?

The syntax allows you to send more than one name/url pair on the
same promisor-remote.  Length aside, does this pr-fields mechanism
give the values of these fields for multiple remotes?

Suppose you want to advertise promisor-remote "A" and "B", and your
sendFields says "token".  What does your promisor-remote=<pr-info> look
like in such a case?

    name=A,url=https://git.git/A,token=foo;name=B,url=https://git.git/B,token=bar

Do we explicitly say that the set of var=val on promisor-remote are
grouped into distinct sets with ';' and each set talks about only
one remote?  I.e.

    name=A,name=B,url=https://git.git/A,url=https://git.git/B,token=foo,token=bar

may be syntactically allowed in the above BNF, but it needs _some_
rule to match which URL and which token go with which name.  Do we
also need to say that within a single ';' separated group, a variable
can only appear once?  IOW, this is invalid?

    name=A,url=https://git.git/A,token=foo,token=bar

> +where all the `field-name` and `field-value` in a given `pr-fields`
> +are field names and values related to a single promisor remote.
>  
> +The server MUST advertise at least the "name" and "url" field names
> +along with the associated field values, which are the name of a valid
> +remote and its URL, in each `pr-fields`. The "name" and "url" fields
> +MUST appear first in each pr-fields, in that order.

With

    pr-fields = pr-fields "," pr-fields

the rule in the last sentence does not make sense.  You'd need a
distinct BNF non-terminal to name the one you want the rule to apply
to.  Perhaps something like

	pr-info = pr-one-remote-info | pr-info ';' pr-one-remote-info 
	pr-one-remote-info = pr-fields
        pr-fields = pr-field | pr-fields ',' pr-field
	pr-field = variable '=' value

Then you can safely say 'name' and 'url', must be the first two that
appear in each pr-one-remote-info.

> +After these mandatory fields, the server MAY advertise the following
> +optional fields in any order:
> +
> +- "partialCloneFilter": The filter specification used by the remote.
> +Clients can use this to determine if the remote's filtering strategy
> +is compatible with their needs (e.g., checking if both use "blob:none").
> +It corresponds to the "remote.<name>.partialCloneFilter" config setting.
> +
> +- "token": An authentication token that clients can use when
> +connecting to the remote. It corresponds to the "remote.<name>.token"
> +config setting.
> +
> +No other fields are defined by the protocol at this time. Clients MUST
> +ignore fields they don't recognize to allow for future protocol
> +extensions.

This forces us to never add support for a field that MUST be
understood for the protocol to operate correctly.  Is it sensible?

Just like the index file format defines optional extensions that can
be ignored (implication of which is that you MUST die if you do not
understand any non-optional ones), shouldn't we have some mechanism
to tell "if you do not understand this, do not use the remote, or
your repository will be broken in a horrible way"?

I dunno.
