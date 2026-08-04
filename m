Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5657E32E729
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870596; cv=none; b=mog0La5CJIkEjoda72RmL7LMmptHSa420DmetjUsDl20ZCBU4ERm7SQf3aENgaQNyOrig4P4Aue1p0uaJG5tMFnsMCU5SmWKsuJRxRZyTYMGXgea9vXjE9SyGqASoWp4Id7xR2BshufpvaqxPsZey3VDgnV1V7PPUhRIMf8ZgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870596; c=relaxed/simple;
	bh=2xFwi5PmPyLrkddOumwx7yWNqtWTR4CbqPPeSkLT4jw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SlmtU/VFCsiQ5U5kW0mUnurzVr4MHLSKjqgtJlg+jzE1I4djCqOV3Mqx7x8K7mjpKeh2a+vGBnsK81es+qGp+1E2b4WTYYVbBTenU1mETdQ7Grpq3EqIKR2Emar8/U9ywYHQOGeUTVSiAbKc/FVkIFc3s8x9s8hmSuiszn9xsx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eUDmXeap; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N6hw1Wbf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eUDmXeap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N6hw1Wbf"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FFF1EC00E5;
	Tue,  4 Aug 2026 15:09:52 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 04 Aug 2026 15:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785870592;
	 x=1785956992; bh=Qdfdv073R0S6kMtVAPCzw6lDPHLtGIxaBJM+bCxY8Lc=; b=
	eUDmXeapEjbWWBsvFCwYYh79HkzHqWdaUfoK+6+ejvVyXxhb3GoTponz+IikFurB
	Ub8mwu16O2re6w3/fS5WtWaRnzEyXFo+SuRtXvFF9HoHX7qNwddbkxRFosmhYaDd
	5FDjY7rHqM+CKah8lR0vEzgWmb+65uHtgNOdg9VLedESOlflGRpzLdQh6mHMayYX
	Ig84OTfiIQ+X46kYK+JWlTJwUOu5hxtVVB5hK7QN5K3PY1bE9ZAnz+oXFo97yrMy
	zNdLUqUu3OEMhkGHDtpuc9qyk0RWkJjMAWVgfH/qFMc9SfC4zUj4L7yuXctXXAaQ
	N/KpUvHiPk5MELB08fRGpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785870592; x=
	1785956992; bh=Qdfdv073R0S6kMtVAPCzw6lDPHLtGIxaBJM+bCxY8Lc=; b=N
	6hw1WbfpeIb9GuMTjBYgUpPvDBvQZ0ZQWvFaQ18/HC7yTFcaJaQJlwP9J2ysSwTu
	MTonUQoVurW3t4a/ZWAng38pHYs+xSUTUj8qm2up9bhwpZg7IhybBvY6TEkJQDpE
	REWScAGVj1RcAUlnvmvYBVSWEGVxOQbntJ5inJlzKCvsZS+QkO77avwyzmbyJLsA
	bbsKbZb70fqoKTCjycXJhYqRIZ/aioWF8oG2GNJ5bUQG5KX/uqpTNX4sU2bZlt3v
	LY5g2E9SF/YilJZLDrCmrlUeNrs+S+VEXpmepYRHx4d53OsOL9LU0ggXd1GOa0EI
	JFOWnpWy7oDQli2LgrwYQ==
X-ME-Sender: <xms:_Thyauj_9ftIpBbZUQBxL1JTq9YEOv_-g4BqMFHtmeN7-7doV08PSJU>
    <xme:_Thyap05F0GRGL8HUtUqsocOHXMo01E13Py186g47s01VujxIZKBHDW4L7U-MzTlP
    hYwPDX4HZHwbnR7tGvwHuQCzPvIGUTtm31gdiz6JAvJ_AqOQ4vtQA>
X-ME-Proxy-Cause: dmFkZTFL/l/rf/MSxk7P6guGFLEdcKBbvZp7YFabFIz3V+8482+xdRzXui2HR/n/kdDsKy
    i8FIgdu7OdSX7tRVWiDsKfptFVrbK1kj5BVtJEdZ4PzXK/DeFzHuUeLVi0p0LaGgEFrfSH
    GKJJr2UbuIljzNC3vszgCuDUy778TPzs3O5CCpXhzHi0Ji+n4yeNbz+oqriZ2G+lb51mqS
    SDWSQUAfY6SZO09jPAuJI9hbKewSO426p3BR+l+GHBqfSBbKGe32gQflopX5dfVLuhoV6r
    2cp+vof70dKruKIbJpHcAnVtNNaU0tF9HYltbHHz6HlzRpME2MASoPflO+W7YB5WUiTuBl
    MkU7YRXglCh7A4TjSFhZ1dVOWQms3mgjisvl8BF6SWW5DkJXZ800pih3c6AU7qBn+dMOT1
    e3SpLm2/eXf2MhsiNEyuOI9imy0DAFCx6Rs94HxL/zur7efRXEm6HoOEMvoASUoNxBGxVs
    PD307O2deLCJQ57XCxAjmDwta3fhecDycAK3hyG2kAA9Phrgbcy9+8im6uWE0ZbN6xAZcE
    ji2gE3qSvaIm6eMQ2pPJXzJWQoQ0PuINB+5RZjgVfTVpPA5jvvyclS4uloXo9vklyeVOIX
    EPxdiTJXfTVQ/J1+BQUmPWAgqtVyuen48J2MxcDh1w2XRyPFC5xwSGgkyG8Q
X-ME-Proxy: <xmx:_jhyahL7e2p2DX22FsDxupzzDUIwCeIe_gs-gmFQD6S7Bp9QGLu3pw>
    <xmx:_jhyaq8gFKT9dC6umrtRO2zU3zb3nFGF5hl7CmzUCH9sV4GuFwnQlw>
    <xmx:_jhyakJahILpPcDwloTcnFsyXm4PLGgesEAf5n0Q5HH67ovfk186uw>
    <xmx:_jhyavkH4DqByGWrZo3Lfk8EL_q_-E4BEE0fr3GYr_p3MuojKOJlyQ>
    <xmx:ADlyaktcfRK-ty9qMkgS2nPYoTiZRMM728xMd7iduv-QioRpQ4FdKdEq>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3065F22C0061; Tue,  4 Aug 2026 15:09:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AU0jXUOk-qtB
Date: Tue, 04 Aug 2026 21:09:25 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <7f34d9b6-de00-44c5-a59c-11f154e7a64a@app.fastmail.com>
In-Reply-To: <anH3k9PvWHMpWLT_@pks.im>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
 <ref_migration_warning.b0a@msgid.xyz> <anH3k9PvWHMpWLT_@pks.im>
Subject: Re: [PATCH 1/2] doc: refs: put ref migration warning under the command
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026, at 16:30, Patrick Steinhardt wrote:
>>[snip]
>> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
>> index ce278c59bfc..98828041c23 100644
>> --- a/Documentation/git-refs.adoc
>> +++ b/Documentation/git-refs.adoc
>> @@ -35,6 +35,21 @@ COMMANDS
>>
>>  `migrate`::
>>  	Migrate ref store between different formats.
>> ++
>> +[CAUTION]
>> +--
>
> Hm, okay, first time I see this format. It feels like the rendered
> version is indented once level too deep, but I guess that's more of a
> problem with how asciidoc decides to process this. And it's a tiny nit
> only that may not even be worth addressing.

The admonition format is used in many places in the docs, but probably
mostly in the one-block/paragraph format:

    NOTE: <paragraph>

Not this this open-block syntax. (But see git-blame(1) for an open block
`NOTE` example.)

Like two times in git-clone(1). On that doc there is a contrast between
this markup and a `NOTE:` which is just that plain text. With just
`NOTE:`:

    This option ...

    NOTE: This operation ...

And with the markup (manpage):

    When the repository ...

        NOTE
        this is a possibly dangerous operation; ...

Or in HTML:

    When the repository ...

    NOTE | this is a possibly dangerous operation; ...
         | ...
         | ...

This is just an informational note and not an argument for using this
particular construct.

By the way, I think I looked at the AsciiDoc admonition reference[1] and
saw `CAUTION` and `WARNING`, but now I don=E2=80=99t recall why I chose =
Caution
over Warning.

=F0=9F=94=97 1: https://docs.asciidoctor.org/asciidoc/latest/blocks/admo=
nitions/

Thanks for taking a look.
