Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6613D53C
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774136476; cv=none; b=D7Glklbkd6ZMeto0lR0T2Py9OEVRGyyTWjYBT3d7aFu2o6Cp85auJvX0NmYc/L6gZooPHq1WyULfgwoN1RvtEVWtLtqYENgBHt0/82FVKDah+Z+0FQHUiZIRB2X1O0DSZpLDjNsY8JWBeYL3LRwoZ7ptvt7cVgRPOkMXATivzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774136476; c=relaxed/simple;
	bh=sJ+UUwDrWE4Zp7MKUqgLc+GzHTx8loSvcHWknTgs5q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYyO4hFBWJGHICzP6S6ZIFzIz6dzNUceH7veqsBnQlB50ZMMnGrvjCOQKCqdhylrwknFtCbK9876sPdsXJT9b1Y1u8uiJb6sfuubt1eoHE8jYeHVQ3D1S0IKjQpBR9rU8DyrLytKTlagsBZsQZygpBf9GmXUXOJtKuNlCTBwLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=avmKzfwa; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="avmKzfwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774136465; x=1774741265; i=l.s.r@web.de;
	bh=iM1vqGvl7mTeRE1aN2XYPZP0zxRBugyGWeO3WJUM9s4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=avmKzfwa50xHcrWp6AkPTkbpoDwq0CT018hkFztdLeqxakDmEFo9BpMYBquKC+5Z
	 ASB9Nda+pDb516Be0wuADT8Foyk/KzqEWN2GSfjZ8/7supbOmWS0adct5pEy7/S56
	 GHJ8Q+L6alPtco4lVasf4VKuFrLBrVqpf/5p8TIWsJfQaUdBQa0tNzNZfY5lIk1cq
	 KngyhS88hejPq+5aU5GSMp8pT/+Q7y0ZYO5e3LOvRwz1tGSXgQ6ABz9PXZ8C7RGHl
	 9gbif6HVlGEWaT6Z1BXrShqE7Bg1tAavdk6LUM5kqMWnhmrdLjQCP6gK3vIn+Yd4z
	 3qp0wilji+QLdHjhTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoNV4-1vFbq51Voe-00l5wm; Sun, 22
 Mar 2026 00:41:05 +0100
Message-ID: <ca9fa6c7-f693-4b85-a17f-8deeb05b45f7@web.de>
Date: Sun, 22 Mar 2026 00:41:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq341wnvbk.fsf@gitster.g> <xmqqcy0zii0s.fsf@gitster.g>
 <20260319233546.GA3632561@coredump.intra.peff.net>
 <3e387439-c066-4e45-b28b-43f77c8824d6@web.de>
 <20260321211828.GB736981@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260321211828.GB736981@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dlNwvcuP1ra4ida0z4gDedq07jRbsZIAlWRgQj3bpq3hyEVJQCX
 PH8bg5LH/kYqppdbE4osJucamgbDpaVFQIEup8bgppskVRCtcPD3A0kRTmUUE2SeAMUqI6O
 ODotTIxubSbFDpt3YLPIqtUkK7hoB1wgC7TeRBnggzVjaKRS8dS6zCNErTkTzkeRkJYxwtF
 KM0JEnLmdV0P5+9CP+qqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tBQY6FIZdEk=;Mw6F4c0RwTuDSlEGl3MkAkXfw23
 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

On 3/21/26 10:18 PM, Jeff King wrote:
> On Sat, Mar 21, 2026 at 09:47:18PM +0100, Ren=C3=A9 Scharfe wrote:
>=20
>> And yet this function can turn an empty strbuf into an allocated one
>> without rolling it back on error, leaving code similar to this silly
>> example here leaking:
>>
>> 	int copy_one_line(FILE *in, FILE *out, int term)
>> 	{
>> 		struct strbuf sb =3D STRBUF_INIT;
>> 		if (strbuf_getwholeline(&sb, in, term))
>> 			return -1;
>> 		fwrite(sb.buf, 1, sb.len, out);
>> 		strbuf_release(&sb);
>> 		return 0;
>> 	}
>=20
> Yes, I almost pointed that out, but I think it's mostly a non-issue
> in practice because you'd generally call it multiple times (usually in a
> loop, but sometimes just multiple individual calls). And then you have
> to release if any call ever succeeded, which means either doing so after
> the loop ends or in a cleanup block.
>=20
> Grepping for 'if (strbuf_get.*line', the closest I found was
> get_mail_commit_oid(), which reads a single line. It doesn't have an
> early return, though, since it has to clean up the FILE pointer anyway.

Caller strbuf_appendwholeline() handles a single line and invokes
strbuf_release() on error, so it swings in the opposite direction.

> So I dunno. I don't think it's been a problem in practice, but I'm not
> opposed to future-proofing if it's easy to do.

I also don't think it's a problem.

> I feel like there's a lot of discussion in this thread but we're not
> achieving anything practical.=20

Funny how attention works.

> If we do anything, I think it would be:
>=20
>   - drop the feof and reset at the top of the function, which are
>     redundant

Easy win.  We can also drop the feof(3) call from the non-getdelim(3)
version, but need to keep the reset there.

>   - make a noop read on an unallocated strbuf retain the unallocated
>     state (your example above)

That makes the function conform to the convention of rolling back on
error.  This transactional behavior is a bit easier to understand.  The
non-getdelim(3) version doesn't do that, though.  It returns whatever
it got and leaves error checking and rollback to its callers.

getdelim(3) doesn't allow that -- it has no way to indicate the length
of partial reads.  If we are OK with throwing away partial lines then
we better do that consistently in both versions?  Sounds a bit messed
up to bin perfectly good data just because some other platform has a
fancy function that goes quiet when it stumbles.  The alternative of
having inconsistent behavior seems worse, though.

Ren=C3=A9

