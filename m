Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534C4052A6
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797510; cv=none; b=CiR4kWFf3M3Gj6HIild2IAupbMygGQ+Zhp3AKzzaIzNGgLOW3K/WYP7WQ4hYmDIByWvHWLuT/8HmYWQpNUpJ3DAne34jOSJa2oB3kSMQFwMBook49nfH7yfkfzH36rUjUreMmIfq13Ihyn6fKoP9tHsmNkrBRel6qUoaAP3psb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797510; c=relaxed/simple;
	bh=5TB7HZa+VFooNIp4qn2MdRrE1mveS/dF18K5kctR+Jk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qW8wvTe1JE7HomVO4rhRbDRJBQAtIIKlRuVqbAO6JsRH/8z66hmlculwi5BXEyxTXglKwz9VRshCo2M1y9VxFmg54zgBztw54v4vg2iYuhG/ISWgZMKL+CM0MU8Jwy8xfnLov/MSy8AFbpG1uHHKg9rQEOqkLBVKSbUt2t9GqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rYyOg1kb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=naftPmuK; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rYyOg1kb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="naftPmuK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D5EC14000D7;
	Wed, 30 Sep 2026 15:45:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 30 Sep 2026 15:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790797508;
	 x=1790883908; bh=lJObnPydLAKg9JwQhESyrQOo8aMPrH1IyQqK75dyAVU=; b=
	rYyOg1kb/tSUw+s3E3RbEJNGWwZcXOt0zNl1GxMWbCcKXrGo7H8ktUKoWBCYhL2v
	ui3lnT7rb7WRrLMX5eBMpG+lnYYkckSV18is/iZmmYWWX1XGW/lOG+H2wupFTiGh
	eyLxH+jWHbjxE8Sfgt02+oJ7pFEodiTwCJn14ylrp+rqnVdtulzdFckMJ4hNK3qW
	e9MlywecwWgdWP6+AJq817VDAAQo1y9U6QvcZvtDjtIAtb+NzU2IJYTKdejNVWpC
	0fGPSvMMna4q2MmkC1hWbAm6A3I8meSzAGlp0bE5FKKjAoPvqdjOOBJua6rpdYVS
	SeQd8FR2VK1kh+IUJmTqnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790797508; x=
	1790883908; bh=lJObnPydLAKg9JwQhESyrQOo8aMPrH1IyQqK75dyAVU=; b=n
	aftPmuKYQFntYvznJ7zi9PQi+3pSgUB6BOzY5lgo0EU6h5E2B9GnLnhYBP+lniFl
	+iMTuMB8JWssLk0T9Ufh2je8pdAXJFAFiR0kVR6dzvwhpBMH8tUn9bsY6gNz18bs
	D8WOHgIS0z8w1FfBVHjJTvj8maBYM3uEmOuGkkRHo/qdHui1XmQvAfWRv97dZmx/
	B0vm1fv81HnxAmgqMSO8FkCe2IqgEeRCyOiInzREr7IteugRcxkfGFqZC/tHSU3i
	hlYJVx3/grotqrBDDyGJnifW0eCuhWIWCF/DJKnyvbwUIPQc5O5dEL6JN2rIgch/
	JxsJudPHKfrSxN94OCb4w==
X-ME-Sender: <xms:xGa9av5Gmy_f9U1vLI5WQZ8JzTCp4qjl1d4GOOwzdQ6xMwVY2Jvsng>
    <xme:xGa9arxUOphAn3dDi3Ib9FuiPVDL5oWYGgobRhFx6WgGz7DvRT-8ap-YYQlrNFAUW
    CYVLuTi3AZWTv3Aqc3n1cz5uX_x5k-pmNKthDNCTjEyedv5qW6maA>
X-ME-Received: <xmr:xGa9auyOWQHK8qrEgv1bDLFNQNv70BDQDFwDsJ8sFY9x0g7WTnlEiNEwmzrbvtsSDPoQoSQ7qOSu1YcLhDopAembqnNc6Mxj6QD->
X-ME-Proxy-Cause: dmFkZTFZ2K1Jo9yAQIxAmv4zPxZ9BJyTq2pzRIlDrBR6Oj3ImqknnI4R9Z6e3YR6qHZ73H
    sjab7Fz6uESWTHAp5RgNTsD1DA5bT91rPibZvhxu981paZbxcLWCFLdPc7apKsSZGxmAZG
    N+ppKjMWLmzUXptUYVPDzAcbbaG3kgLRWF3+tR0bNQfhdmQq+G6pyx1Fx/Q+BqD9qZlihY
    SXCi+ea575DvMf5/BVN/evu55Tr4BP4q3sDEPyryF06ECK3P/w+301yTYIfPpsVEcH20zG
    ltqffaCoLfw2Cy0rzuKq7zK6mihSCk7+nptFw1BiYCwd/ZfaXc1/9qR5UU3HSF3QXTRiDs
    2ZSbyHYqduF2aCNWEjatXSeIQXIu388NNVcGdEt9s66kVUlMAFIlFArafEAqxwY3T0xL95
    +QJI5cCnoanIEOfELAxVx1I3C9OEZzJPiWzg4wjvJNxM8hSXv14ZF6EF6jTVno0aFAK88S
    2xDhT8cmPsicuSMF1AY4iNmk2VzxL+m4ITrAuJRzXOB6P63CsPGHPDpt21yr4J+Cuc0F/n
    MUVBRZb7k14FCWZhQKnyMl7XXYN28U86W8vdYZ/0jJyHIo1rl861T4gE9+bNo2XLKI+pc5
    qzzFggBo8xEqiNJFTjvysgPK3wTazn8Ze7tVe8X4diY62/fEmIQk1w1ibNJA
X-ME-Proxy: <xmx:xGa9arwMu_jVyD3tBUNkSO8efH122Qwn-1FH3Ie9gWDaU-roRuaZbQ>
    <xmx:xGa9agYRe---Hq-2DV8M718rUmUe-kQGxP09n5w7RAZahKhCf6iDzw>
    <xmx:xGa9akX9NXKhWOSw-8wPYd9EowQCnJU6pe-GQCfobufvNP1g8sBypA>
    <xmx:xGa9amgcXso50oRlwn2bpctynfQGhUCBGTe7he9QA6-arsPYgSJsSg>
    <xmx:xGa9asbkghswmFJz8CvOfco-tmoeTLg-4vEg7FyUXt_d6pxrP-8X9T3v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 15:45:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [RFC PATCH 2/4] doc: gitbreaking-changes: replace msg-ids with
 URLs
In-Reply-To: <ar0OltAkeTiCx81c@pks.im> (Patrick Steinhardt's message of "Wed,
	30 Sep 2026 15:28:54 +0200")
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
	<URLs_not_just_msg_ids.d1e@m5gid.xyz> <ar0OltAkeTiCx81c@pks.im>
Date: Wed, 30 Sep 2026 12:45:06 -0700
Message-ID: <xmqqeceaa5h9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 28, 2026 at 12:41:26PM +0200, kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>> 
>> This document has used msg-ids to reference emails since its
>> inception.[1] This makes the text a bit more terse, and is perhaps
>> also convenient for people who can use msg-ids to link to messages
>> in their inbox. But we should consider how convenient this is for people
>> in general, now that this is a more public-facing page (see previous
>> commit). And I suspect that most people will be forced to paste the
>> msg-id according to the described URL template:
>> 
>>     https://lore.kernel.org/git/$message_id/
>> 
>> Let’s instead replace all of the msg-ids with complete links. That way
>> everyone can jump right to the discussions.
>
> Fair. The links may of course break if at any point in time
> lore.kernel.org were to vanish or change its interface. But if so we can
> adapt accordingly, also because the message ID can still be extracted
> trivially.

One caveat is that some "funny characters" in message IDs need to be
URL-encoded.

A recent example I saw was <20260930061524.GNkIK%taahol@utu.fi>;
https://lore.kernel.org/git/20260930061524.GNkIK%25taahol@utu.fi/ is
the URL you need to visit to view the message.

Having said that, I am somewhat negative on what this particular
patch does.  We should instead give both, having something like

 cf. https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g/[<xmqqa59i45wc.fsf@gitster.g>^]

in the source, and render a readable link text with reachable href
when shown in the browser.
