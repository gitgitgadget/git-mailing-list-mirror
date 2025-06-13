Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F022E11B5
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832715; cv=none; b=TXJt2rc+daCKsDvxZuoHPjj+5HTJeM9e4ejq0FFgiCLDVgPJ94M36nBRGu+vGHVi7dCLQmowZxyHSBjW9OJZ8vQibZPKC9ve3nW9RgjODcrRJdyj3KfXel9r8wLyKbfNN6oCwn5MJ78FC2d6O+A5u3Amzb86Nw/zU+64oR9F7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832715; c=relaxed/simple;
	bh=oM3cvRKG1e4vn5Zr0GqOsPPLjWw3O0QuIGXKAC3VQPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X6Ts5A8MwfgoHv599rLW5pg5MJrLKWK1cXT8rTPbaSW1J55TbAu1xZO/vdv7SMEedw8Ho4socaWj7AwmzouJ4ZAxYUDzdjhH9HWTpeFkFAsLHTUnDACNMkqBCQR5/F1337po7Sciijw+gFZ3tvQbLt9lJV8E0XVj1o99/R8bODo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AFK+rzc2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jgORiMlx; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AFK+rzc2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgORiMlx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32FF9114013D;
	Fri, 13 Jun 2025 12:38:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 13 Jun 2025 12:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749832712;
	 x=1749919112; bh=0NG5pvwvpfQM+3mIhJ18GV0Y6UDd59Ji4eeRIbHTwCs=; b=
	AFK+rzc27pyilpvpZpBuW/W/lnEhR8tvm+a/Dp/XPlOmA6e5dCPcbtyvWLyvJXTd
	rpsi61XsYwH3Wo86fOILl70o1GTxm1yZoiEPXSAMTU7opdA10zQrRXA2PxsZ6ii2
	Rr/7nES904JjlgQqpx3pY3f4xWEi2cUNquYP73PW2yM6HbdipN0p+OLA3KjctXk0
	wFow/dl3bHbb3YiwdEMINKQPa5pU54lBfuMMxYpF40+MCxySzd2pCW4RPM3PeN0e
	klSasjfIfciF/3kC7dIOjKxgtlqygJArCgpn+QRJx72IDFLanZIxsEaODMoG9AOo
	oozCnkb5OHC8rvrLWQ9rig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749832712; x=
	1749919112; bh=0NG5pvwvpfQM+3mIhJ18GV0Y6UDd59Ji4eeRIbHTwCs=; b=j
	gORiMlxfkpLd93toHLfkYrzqFufqb2/9OlAGXVqh3NH6geqWhwo6fR6Qh7pwUS/3
	g4miqhWhKhCQDve/RaP5OKO8gkdAd0uyU3w8h36os2jBdV9bahGm8bnfvPc/91Ez
	NunVBoQiLxZoBO371mbho0E/72UlOZrh3cByiL4xOJBnCBqIDxr4SZALoUkk+/p4
	8uzD75m5YeM3Uj8E7PY3Q8sMYJQs59pQi3AkA6qlekkTjbnxWGVBle3aDAZRfoJi
	499oX1XgHesz4HW4RUdpXgWNTXVtMjRWwZ8Hr5ojyBWX0Z8VjrJzBIEI46sd+HOl
	fh9rryX+eqfNeVA/u/w6w==
X-ME-Sender: <xms:CFRMaAgzyrwHVgJDOex6jjnp9wsnRMi9ww72rkXanJhNL60a4GXY2A>
    <xme:CFRMaJAGR09M59KoLsAaIyf_MSuhqJ4n_HDNXKv-Dl9Gx92FO0_3D8UztIqCwT77Y
    8FT62uxxIDUYTO55g>
X-ME-Received: <xmr:CFRMaIGDQ3Veu6ZLDAaa83Zb9cs4DKqriJedhWMg8ExLzlc2T3QzinvY3NI14Xsv2BU7ggf605a2ErCUFeTTIO8xjLyCXimSgzyB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:CFRMaBRQtPO1Ctfh6S-LPy47jPGzPPKtRR6s9LzCI1Mc6Mp95_MWkA>
    <xmx:CFRMaNzUayq36yC68OwQWEFj_uPlRQkOjTZyiRT48HbcQoiehoEd3w>
    <xmx:CFRMaP7l3XTSMCMoCm6rXQIS7MjGAnE3vHCFzxRJTyr1oCEokxGe_w>
    <xmx:CFRMaKyy4tvSW-d01b61nGFkLc7-k84BdG8nNyrp9cEO80hejuW6jg>
    <xmx:CFRMaIh-YjcN0AMRio4n1joe9u_pMzqXv9g30_D-gYPl8uUgr1p-25N2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 12:38:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] merge/pull: extend merge.stat configuration
 variable to cover --compact-summary
In-Reply-To: <deb4951a-5d1b-416d-bcad-5d675d8155cc@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 13 Jun 2025 14:09:52 +0200")
References: <20250612222537.2426059-1-gitster@pobox.com>
	<20250612222537.2426059-3-gitster@pobox.com>
	<deb4951a-5d1b-416d-bcad-5d675d8155cc@app.fastmail.com>
Date: Fri, 13 Jun 2025 09:38:30 -0700
Message-ID: <xmqqv7oz8um1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Fri, Jun 13, 2025, at 00:25, Junio C Hamano wrote:
>> Extend it to be "Boolean or text", that takes false, true, or
>> "compact", with the last one triggering the --compact-summary
>> option introduced earlier.
>
> Would it make sense to make `diffstat` an alias for `true`?  I’m not
> sure since you need to keep `true` anyway so you still have that
> historical artifact (?)[1] of `true` meaning `diffstat`.

Correct.  But people can bikeshed about adding such synonyms later
without breaking existing users, so I would not consider such a
tweak for the initial version.

> There’s also several places in this doc which uses something similar
> judging by a search for “defaults to”.  Only exception is
> `merge.renameLimit`:
>
>     If not specified, defaults to

Having something before "Defaults to X" (like "if left unspecified"
etc.) may not be logically and technically needed, as that is the
definion of what the "default" is.

Having said that, I somehow find the resulting sentence easier to
read with such an introducer, but perhaps it is just me.

Among the output of

    $ git grep -E -i ', default' Documentation/

we already have quite a few of them.

Thanks.

Documentation/config/commitgraph.adoc:repository, defaulting to 1 if there are none.
Documentation/config/merge.adoc:	rename detection during a merge.  If not specified, defaults
Documentation/fetch-options.adoc:is set (see linkgit:git-config[1]), defaulting to 'on-demand' if unset.
Documentation/git-init.adoc:The option can have the following values, defaulting to `group` if no value
Documentation/git-send-email.adoc:value; if that is unspecified, default to `auto`.
Documentation/git-send-email.adoc:	value; if that is unspecified, default to --signed-off-by-cc.
Documentation/git-send-email.adoc:	configuration value; if that is unspecified, default to --no-cc-cover.
Documentation/git-send-email.adoc:	configuration value; if that is unspecified, default to --no-to-cover.
Documentation/git-send-email.adoc:that is unspecified, default to 'self' if --suppress-from is
Documentation/git-send-email.adoc:	value; if that is unspecified, default to --no-suppress-from.
Documentation/git-send-email.adoc:is unspecified, default to 'auto' unless any of the suppress options
