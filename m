Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604637F751
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889145; cv=none; b=FxMlcusZl9y6XLzMDwLVWGDXtAZRAWkDW68vcpI2lcWXPMPnX/taXojaEUeCwsQvMLV0KAK7VNrIe7x2IlTEMyj329uSo1i+zLqVco3zk1UKIUJK4vAAqEF1hykEk7xNbPnvLicJpnm/ysRfy7LVmJWg+Pxyo+IJIPvqtw+lkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889145; c=relaxed/simple;
	bh=3mzIl0bUP85PDfd8dorAP82gG03+p9pjsHWdKadkA1Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UedlrfAgBETjmIKJ6khM1gva8xoPMl9YdBiwcGI6mEnNjnadjsqsvLegYDyjxe9zUnzM8HCtWCQybX5kphICFgOIU1Rx1cFW+tFg52D5n5lnbANJEom/sPrL3ZWhy5WDMR1i7LsHZ54+F4TNhcIauXXZXPg/R4rhBvcCrFKTKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SFfB6CwK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BsDwlYDC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SFfB6CwK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BsDwlYDC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EEC1BEC016F;
	Mon, 23 Feb 2026 18:25:42 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 18:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771889142;
	 x=1771975542; bh=v/lHY1zw9tNTa/4pxbbqz1TZa04eKl7lnbRu4NxAaMU=; b=
	SFfB6CwKQnVJWl92j6mscwbyYvElR9G2Pi6WZgyD0QUMIpwU6cdwworYWLRYIguf
	7bFbmZ0AIHIB7fydSXvzAlEHYfG4UqAwlGcEIMnzdgOMSQuzNQeoIOT8lLWHl3Y9
	3UXdYCq6sZ3kp5Oh5OgVKAxZzKG7tP9oGqfyUBylgmAlNrYc/aGtam2A4mY8zgyI
	uCjcqYfCkANGpMNBfvbf64BnkFRSPZLjxrE8mcEITgULxAovVt5PQP4R6oVfUafM
	3G2RXumDWkNtoinr6rzaqLM37y9cEIM2qH0pV8uVSyI1fVDDI0paS7uob/L9XRo+
	YcH1j63R5/K5NhpIKy72XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771889142; x=
	1771975542; bh=v/lHY1zw9tNTa/4pxbbqz1TZa04eKl7lnbRu4NxAaMU=; b=B
	sDwlYDC+A8IOuwVQirS22jClS8EcVVEal93KQc3txMqlabMlP4RDRwumx1UHHEvY
	sAgZ1y+a9SRIx7SIi28KYx+UTurn95iI55i/7TKAvZs3pHpT1J66fjwSDVVMvplA
	2rpKpW5njsicUw3u8XSMSeNd/CvADfEwzurjiEUKLRqxazNBoVJvHpC5pFLM/xo0
	ehz7bm7ML7ffE8wIR9e7H4G71pdt3wRkWp90NFH0GC8O7nlT6fH54qCMQp38pibj
	A2gSh59PM8Ff5as4y+s7duhPKc6IuRlV6Dbkq4xedYNM7KU9FYNDVzFwOVrFQmnP
	Yn1onD+YU40Z+r2taclSQ==
X-ME-Sender: <xms:9uGcaZOle3SnwIyDw4prMbbM9wrZjdcWuehg8HQRq69cxpPPB3icmdw>
    <xme:9uGcaWxleqhI7F2sv3DnSTNJ-2GXOFPZqb92KWFIHCpb_7PaIoOKrrsjv1PN_UKjA
    KiaErfcnfzTd882xyRFnvkx-ENy0QstILdz4yiWPPtLkdtrtq__RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveej
    gfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9uGcaY2FBIbtDol-8MjRiBQy-oJqw5xxw57FiMnFo9qS9Hvdy2yHEA>
    <xmx:9uGcaQ6ZBV3BuNgZNde32z_XTxoDffZyIogJjB7eW5dDnWgSo17zWQ>
    <xmx:9uGcabX0DY1eHsod43Cki9mvY_viyvupjOMyi_JwqGCOBsqAIXL1fA>
    <xmx:9uGcafAcPnRnO0peiFwsjTLUx6QtqP6dm2hCwDtgL8wHodLIX3OawA>
    <xmx:9uGcaTZvB4IBUHAugvX6go1rm4JzkzOP04oFZlL5qsD15aoJFPX3qWIK>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B7EDA1EA006B; Mon, 23 Feb 2026 18:25:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AebKJJRYDV9c
Date: Tue, 24 Feb 2026 00:25:22 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>
Message-Id: <ff92bec9-19b1-4107-9208-f692709ba9b4@app.fastmail.com>
In-Reply-To: <xmqqy0ko626g.fsf@gitster.g>
References: <CV_format.noprefix_boolean.39c@msgid.xyz>
 <format.noprefix_boolean.39d@msgid.xyz> <xmqqy0ko626g.fsf@gitster.g>
Subject: Re: [PATCH 1/2] format-patch: make format.noprefix a boolean
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026, at 19:03, Junio C Hamano wrote:
>>[snip]
>> Let=E2=80=99s only offer a breaking change fig leaf by hinting about =
the
>> previous behavior before dying.
>
> One case that is often problematic is what happens to those who use
> the same set of configuration variables with different versions of
> Git, before and after such behaviour change.  But I do not think
> this is such a bad thing.  The only reason why they had this
> variable set (to any value, or to a value-less true) with existing
> versions of Git is because they wanted to omit the prefixes, so when
> a new version of Git dies with "Heh, 'nothanks' is not a valid
> boolean value", they can edit the configuration variable to "1".

Yeah.

I like how this was handled for `core.commentString`: You can set both
`core.commentChar` and the new config and still be able to run on old
versions.

> And from that point of view, I think the hint given together with
> the "bad boolean" error can and should be phrased a bit more
> strongly, i.e.,
>
>> +		format_no_prefix =3D git_parse_maybe_bool(value);
>> +		if (format_no_prefix < 0) {
>> +			int status =3D die_message(
>> +				_("bad boolean config value '%s' for '%s'"),
>> +				value, var);
>> +			fprintf(stderr,
>> +				_("hint: '%s' used to accept any value but "
>> +				  "now only\n"
>> +				  "hint: accepts boolean values, like '%s'\n"),
>> +				var, "diff.noprefix");
>
> The target audience of this (hint) is those who have set this
> variable to a non-boolean strring from the existing version of Git,
> and the only thing they meant to express was "I do not want any
> prefix", so "we used to accept any value as true, but now accepts
> only valid boolean values", perhaps?  That would nudge those who
> wrote "[format] noprefix =3D NoThanks" to rewrite it correctly to
> "true" or "1", and not "no".

Very true. I=E2=80=99ll change to spell out that any value used to be
treated as `true`.

Right now it just says =E2=80=9Cused to accept any value=E2=80=9D. But n=
ot what it means
to accept any value...

> This is a related tangent, but shouldn't this use advise() without
> configuration?  There is no need to allocate an advice_type and use
> advise_if_enabled(), because correcting a malformed configuration is
> an action enough to squelch the message.

Oh, right. That fits well here.

In hindsight I think I should have used that in 5a312527 (whatchanged:
hint about git-log(1) and aliasing, 2025-09-17).
