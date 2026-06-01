Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9E3431E3
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352300; cv=none; b=tzgzgnljD4IQeh/hkne13gqXFhRklgSzAt8hzWmrf2cp9dFsDVVHB94KzjwtjMXp47BoTneTwys6G52YLzxg0vDCHApJd9fiUwsMJpIQCtC7tfHYARmhIBjdb83K4NUPwqVKn2w577U3K3RuEc3C7BXAEfZ9SBIHQFA1pdxBBZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352300; c=relaxed/simple;
	bh=LDvtFZqWrJIxUBOfH0EQqByj0rsByVZhLDOeHLqKrxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ltiy/i5C7qM6gf/dMI8VI9U0+Lw24Wb2pAoRJ3Q4ba3JotsR+St8VN74CBxwxsA3aJFS0paHJyvST6h0Y5SPCP4GAFkA1Msm2GYHYb/GqTqBuLpm2V7ZCP7ePsVSY2usIRvk93HpGPXpDsMp/KhoVJQDmiW4wN4dT1dMoe843Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JFgSKgF8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DDQrE3tM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JFgSKgF8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DDQrE3tM"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E10B21D00103;
	Mon,  1 Jun 2026 18:18:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 01 Jun 2026 18:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780352297; x=1780438697; bh=CzcUl5JGe8
	BRkDYSSlOMnNFfgnsE0sC1IaR1lxiiwUM=; b=JFgSKgF81fk8QbOkDnyTLyjfWH
	7Xn8yiPTfulfoGVo2kbRNkq4PYirENl35jikz0Z3nX6Wbo5t6hNMxTY1i2+WsPVI
	bS7jgQU2cdD5MV4wF9+/L9CEppsam0k688wrxyvuXtTnOL82f7qahlXlrIPSfoE9
	DUEwAtk8B1kTWKyzPoLOhrtn+CFv5cVe+uSgyRppGfHyxZo+9OgvoVi37t/eyt6s
	c0RtOWVQMtPHGS+YQzv08GU8fsQLCYn2/jjeSH6qoBXtYr4QdzPBZ4MO9K9jYqST
	ZXqYklZmGdhzhJNj+uN5Zzu5lrC3OCmiRhj7v3RLg+f+QbLHDoZYEyyuTtyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780352297; x=1780438697; bh=CzcUl5JGe8BRkDYSSlOMnNFfgnsE0sC1IaR
	1lxiiwUM=; b=DDQrE3tM9KQ5aY4wE0Kth28GW+Mp1bMIXbjUCkCJ6fhg8AewiFD
	N026x4VJ314qTSqcw5sqhZhOfqQyuIcxK9ldFUMPO7rqFpJxE3oqoVNmE8tmWbj1
	hm+jkmluT7zdMgiNideTdngJ5RYiYcK9yrD6Cs8zuVmMiOx9k4yyxRkGupqyoNPA
	D3k7sQ4D+sHoQl5+kxp9xEjukB410WL94GnDajSN4FV7kMFP6J1ERlt6/s4vNi2p
	G7sTImRwQbq5+2nkvphBJ4+89dvPJEV44d6lDV5fujFqP2nb0yzE+lavEBuGdPQm
	Jg8jyu4gtIB5kIzI9qsUkcg0c7016H5Bizw==
X-ME-Sender: <xms:KQUeaoB59P-C-TCZivZETxKfkWRLDH66V2LokqVBa6pk-4YX0DubAA>
    <xme:KQUeasDl4Sc9Ly_Z5mtM0HIbg-gu8eEPNLI_KHjm8ZztlasSKSU1CV6BJqsb1rwXF
    DypBEuAP4fO688wwVG_B_gmFGgJ1SiGQTP3qCnSYQKTKcNuSDic>
X-ME-Received: <xmr:KQUearoPr3HmqllD0gNmBKV5sgF6YFHqaLseOwHa8sV1N4o1PN_FQSHOVW1K0bJq1m8aUh48fqGCO-Kj8UCRYj6ueInJEWnIGMkk>
X-ME-Proxy-Cause: dmFkZTFfcpMkR9P4pG8PT0bkga7w6jonMd6eBh7E+e/JlMrXGTS2l/TXfDqNDQJU/5t39/
    YcyAqRWRQPrsh0YNc3FTCFEEATzCTshZ4a2KyHG9uzlCLn5O/aXSNHtIQxA2+UEeQW/V6h
    KggoPgL7PTK2vMjyf9mS7YWyR5STx4dacJJUX/CqKWxD//WnLTD4tAaNQXwdD0ycQEYtze
    q2deN276UBHlU+r9D+/Te2aDQPSL6qYNZaUkQuXFsN0ecuWe5oLu9d22hbVAQlDGUnlznn
    zbe0RnNcpGIPjuyudLKv5zt0wWEyYpeeBoEudXqRAWcPqK6UB23D1PB2ER36hJ5qiGwAV0
    JrZ+VbAfYpZdgtLTslAL4d0hOzeBG72nvVhAIUnhBUmZN3JlFiwmNkGhYqcGiTbfqvzz78
    FLLUWTpFKda07sv7hmJsz8C4E3UfF/fbwAemKWuEQj6hKarAIqjXRwYr2X+P47t3w2HvZl
    WCoJbZ/TCbtYeCeNnHW24K1YFqNGuyAGrtjBBnZcqqH0L8eDp/v1pZhv79dIebrnS6qU+6
    aY3fI0uGpdLNyph3D/W+IEXJlMKAJanr6g1t8XOc8zjR/wWg9v4R1AVxF3edhxnGR+P1QR
    +PgOg1MTzf7bO6lGueerA/oT94Pkkr2gWBUW/0FfOW9tK0lkdscX8lz15Bsw
X-ME-Proxy: <xmx:KQUeauknH3_zderOqanoa3zS0z7bxTn9YRZ5RtifLvX7d96yANE7fQ>
    <xmx:KQUeajycJE0inQo4Nj1RGEfbPRoXaHcQzj7LWsHry6aW6QVezyYYgA>
    <xmx:KQUeau-utcMD8gMdof81EDUYCfvo9BU0P3vQ1W8kwltM48u7ftUZVw>
    <xmx:KQUeanKQnV4rQhey3M0Dr7uNsdvml2C5i1s4sdTHqKAYN8Vb9WQMwA>
    <xmx:KQUeaunB6pcQOuO66UDNVWLGhM_ckhhDiu5xWCPfpHOWBgO8Z1khqTDw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 18:18:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
In-Reply-To: <ah2VL-ftCQelNoOc@pks.im> (Patrick Steinhardt's message of "Mon,
	1 Jun 2026 16:20:31 +0200")
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
	<20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
	<276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
	<ah12uk7IFxS92OR1@pks.im>
	<042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
	<ah2VL-ftCQelNoOc@pks.im>
Date: Tue, 02 Jun 2026 07:18:16 +0900
Message-ID: <xmqqh5nl3nx3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 01, 2026 at 02:48:05PM +0100, Phillip Wood wrote:
>> 
>> 
>> On 01/06/2026 13:10, Patrick Steinhardt wrote:
>> > On Mon, Jun 01, 2026 at 11:31:46AM +0200, Kristoffer Haugsbakk wrote:
>> > > On Mon, Jun 1, 2026, at 09:56, Patrick Steinhardt wrote:
>> > > > diff --git a/git.c b/git.c
>> > > > index a72394b599..6bf6a60360 100644
>> > > > --- a/git.c
>> > > > +++ b/git.c
>> > > > @@ -591,7 +591,9 @@ static struct cmd_struct commands[] = {
>> > > >   	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
>> > > >   	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
>> > > >   	{ "init", cmd_init },
>> > > > +#ifndef WITH_BREAKING_CHANGES
>> > > >   	{ "init-db", cmd_init },
>> > > 
>> > > This can be marked as deprecated.
>> > > 
>> > > 	{ "init-db", cmd_init, DEPRECATED },
>> > 
>> > Ah, indeed! Added locally now, thanks.
>> 
>> Deprecating this command seems very sensible to me. As well as marking it
>> deprecated, do we want to print a warning when it is run? I imagine anyone
>> who has this command in their muscle memory is unlikely to be reading the
>> man page on a regular basis so wont see the warning there.
>
> I was wondering whether we want to call `you_still_use_that()` here. I
> found it to be a bit heavy-handed as it's so trivial to replace with
> git-init(1), but on the other hand it's a trivial thing to do.

I personally think you_still_use_that() was a mistake.  Perhaps
log-family of commands were used often enough to warrant it, but not
"init" that takes exactly the same variations of arguments and is
shorter than "init-db".  And you_still_use_that() would not help
scripted use all that much.
