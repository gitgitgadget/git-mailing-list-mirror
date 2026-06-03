Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FDB37F01B
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517404; cv=none; b=cG8GucMXMZQxnvIbWUehk5+6Aulcu+BlCCSXLUWBAZXtly0kUCi9hPSKz6nsX3QJMnBt6mENkhORtVviNocisdmaRapiNXLjskMJFSNLrm3y9VbDFGeWe6LY45IEJasUH7XrN+rqM/CJnv+YI8Rig70F+fIeOx/naP+VzamL738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517404; c=relaxed/simple;
	bh=C0PgD6Uz+pw7bXjtWDz5fY9ShD6F0Mr7xHl4Ci1C1Zk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J4fkl2UxggCsRbGWH76rTRFSUROW+62jWFlu0Us4P58+LCyqOXQwmWw3fIjeTODKXyYGcMZEcV/Tud8DBZvnR4qCRyaqhjDIW3Wu6DvzkMhBe2ulL2q1+ganw6qTw6CJ5dbFhJyM16BBBk0PZoPlI+Gjbi5HuD6M6EP88udz8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZqV2+G5u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bw4MR2zT; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZqV2+G5u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bw4MR2zT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C106D1D00113;
	Wed,  3 Jun 2026 16:10:00 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 03 Jun 2026 16:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780517400;
	 x=1780603800; bh=DOXRQqTp4wKojCAnOi+xOGDn+j5sXBUTpFGrnYvQ1Rc=; b=
	ZqV2+G5u68oiAk9iwRaH6/PMKvRDPSRT58tk6VH6IuppmFqusRjICgWK5PJHV+uv
	ZQGwxr+FZE30N0gwcdXV3CfqW37JuL++D61ak6mS0+dHwqD16j61tu6DQ0HQMi9M
	eXINcbItQ7e1Mo/iSZVolSpc6B+3cx98We4dDBi0VvU73Mdp0jQNKJwDbsi0jiHi
	51zVvi7n77HjrzEXcSZR5jmz8MuSDb/FMZPXmslAKwmjmrU6+Ai4riIUxP0PvQPP
	f40rpkRTaOJSljSY0yTC9r8F6SfW+S7LYe3HQHuaRBJqqBbpfijPyNwU80ZvzJml
	/hoK5bamINQzQS3T+lohGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780517400; x=
	1780603800; bh=DOXRQqTp4wKojCAnOi+xOGDn+j5sXBUTpFGrnYvQ1Rc=; b=B
	w4MR2zTBo3At/U6LQSdgcazNyQ68zUaRO/ceNR/UWA2wcnGAm/MGgbGJQ/2vKoT+
	1KR0O5Oqz4DBuBXyKEn93h3AcxhJPvjBj2O8EI3ngorQySl+HJYklj05IJ7lLD0C
	uXlkg13z2GOr3N2X4wUtqCU4uHsSi5YKqoRGN9DeeYzVBA3bc2/hepTXwCBF64Ot
	yxrXAs7/+hfH/N33NqG/7sJxbFTWzVrd0KAWNfKlgyXJNYxaYxfvoPa3OCZVfQY/
	EkN5okkGxwpnZ1T9YkW5lSUDVLJZzw1Fg6uhbEkCnl0erm4KteAca4UqazoiJyjs
	eCORhN6uOB/Q6qWW4Zn6g==
X-ME-Sender: <xms:F4ogas_yCFC3r3f6tA0NS86Y0WpNJELAev5UUywnXTemzuztyDpjycM>
    <xme:F4ogavgvWFI9jbITLnXSm2wZB6Te5FnPWtL26lEg6hKb6iWbdI7E3vB5OFYpv7h_x
    r2RED-HZIxrK7LprhR3KZ4GNM29vMXoowV407XQoBkX2DFgpwRXjg>
X-ME-Proxy-Cause: dmFkZTGiKLicLoEDhM9X2qAIg6meYivN0WyGs6Sg7nVfFtHh0QRvrzyiebBdD5wvBn/TPB
    8oHwPRLH7hlrvUUWK0rSR5xVtD4smQFWsFCOHytzzGaK2BqJg5aSHQZGk+5on9nodzeIn+
    1EoybBQgVzQyp3zUDu5l1CkOsUI/PUwPquwrpdy97M1vHhcOSAwUd+hhU6CHe9E/BJS5ha
    /3utBNjPz3KjDJlGHQaLYfN7fb5eDKc41mw2fv6yynuJsj8uhYNpQVcd96GwQOW58A/G1s
    f6fSkx+pmSjwpwY9SQLj5N8H3m7qjwyz7NkT4QHCYGGPuyraBoA2J0gSM7gVsawRVxBVfu
    /79GyB5snv2afk/XzvYhCDcVbxfyR31zgDLxArDQVUvBw2o98T5izz3cPf8bLY0JRS08Ks
    ti2edccexKSnL//VMU2fVJ37DP3tXFVZmWusiYcv72Rm70iPVn/OHFj/Z9G8JSxUmQ6Aa/
    hbUdsOJZ1BQof+IkPqYoycfsh+hHAknh9SiLXVlWdmZ2JKPFOCee+GU6kCKbXz7HG3F63n
    386BCwwylXysBsDNfY/dEhJMhPLLjqnW9FBB3miv69N7p70LEr3Ehr5dIDiaY4UMpUhPxN
    +3jJkQTmGsdKcgBZcoo8r6DALqqUx/SPVXSqv86jQYq/R/lmXxD5mbHEoUCw
X-ME-Proxy: <xmx:F4ogaqfB674PgGNiNxPuWoEoVl-0UihLSEfyAThmxVMIJCkVeQFuVQ>
    <xmx:F4ogavKcgQEJVWCcstZO-RsjKrE7S_yPBzrQ_PgGUhYTTpCjhEpksw>
    <xmx:F4ogaqi1UbCZEaLZyJix1PoZ4scVnTMhGH9borL-UisVFK8Vlt_40g>
    <xmx:F4ogatRMraGRsnwBb65hA4asLOPVtLLJ7uOX1BHiYtjh_AsryFGveQ>
    <xmx:GIogapc4IdcUsd7tIsbRG6KVXaSza30CLwab4SU4tWWQDt6ypWDyEPpO>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA0163020097; Wed,  3 Jun 2026 16:09:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A75dYJwQ_vb3
Date: Wed, 03 Jun 2026 22:09:39 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Tuomas Ahola" <taahol@utu.fi>,
 "Weijie Yuan" <wy@wyuan.org>, "Ramsay Jones" <ramsay@ramsayjones.plus.com>
Message-Id: <f1dbb848-2d9b-488a-835b-2d23006b5fa6@app.fastmail.com>
In-Reply-To: <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
 <20260603-pks-b4-v2-1-a8aea0aa2c23@pks.im>
Subject: Re: [PATCH v2 1/3] Documentation/MyFirstContribution: recommend shallow
 threading
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026, at 08:58, Patrick Steinhardt wrote:
> The "MyFirstContribution" document recommends the use of deep threadin=
g:
> every cover letter of subsequent iterations shall be linked to the cov=
er
> letter of the preceding version. The result of this is that eventually,
> threads with many versions are getting nested so deep that it becomes
> hard to follow.
>
> Adapt the recommendation to instead propose shallow threading: instead
> of linking the cover letter to the previous cover letter, the user is
> supposed to always link it to the first cover letter. This still makes
> it easy to follow the iterations, but has the benefit of nesting to a
> much shallower level.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/MyFirstContribution.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>[snip]

Only today did I notice that your eleven-version git-history(1) series
uses this style. (Or: today I noticed that it=E2=80=99a thing)

https://lore.kernel.org/git/20250819-b4-pks-history-builtin-v1-0-9b77c32=
688fe@pks.im/

That would have had a bad rightward drift with the usual reply to
previous version style.

I=E2=80=99ve been reading Lore on Safari on mobile and some threads go s=
o deep
that the replies just become unclickable backticks. *Huh?* Well I can
use the Next/Previous buttons and maybe there is a way to make it work,
but I=E2=80=99ve just given up on those right-going subthreads. ;)

... and I also don=E2=80=99t see any drawbacks to that threading, using =
that
series as an example. It looks just as comprehensible as the usual
style.
