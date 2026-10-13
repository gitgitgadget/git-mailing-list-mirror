Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146E4F4739
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894056; cv=none; b=jsIir0N4wyULGN7MiF+VBbGuZcjosuzM/XEY6ZV/Snd4KzzGq2P5CtGfWlCZc+Okxz8dFlnrr2i+ASa0L8kzXtv+ywIzF5XifxucKAlT2v1TQA0Nc1qQe64YFJdpWBDq4a8cND5e9lPfNcJa9I4Y955HBhl7B9OF7EBz9ARZzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894056; c=relaxed/simple;
	bh=cV7SBs4LPpocy2u6cnoDUYyIeQ5WO5tncolUeQECyoE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cJcRy97Dp9ZDzuc0VGt6lrEUdlMD23ndHfwEHKTg5M6qO5EgDkRB7s20tc7WsRixV+LJjgnON2rhKFhNuvRfMUoVRpgIRzWq6RZkizgeb5ADxCN2k4TPOoSgw3fELwG4XQKpzosEhML/Pu7ifuipJPyTWK7vNzhSiuACyZ7X2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=P4GDuibC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tt3vF9Jf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="P4GDuibC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tt3vF9Jf"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 876331400152
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:20:53 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 13 Oct 2026 08:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791894051;
	 x=1791980451; bh=nvvfhf83BQ/E71Qf6vShcore6G3he2GPtBQFWl32jmM=; b=
	P4GDuibCDLnxjWPVR4qwo386unnm8derTHha6JAr8FLXCNZSKBg9Sl4umw/YhM3K
	r+9iNO52wq9nNuBcoplywQVIPoPho0UdSxY2RsmFokHFa9Ivlu77cD+j2e0aRmPB
	yGB0pqNlB5RuCUZ0ThdjIdgWWvJgYGuV/PE8Rd3OXggv8e2PYqmXNV9WuPz+xDjR
	bPI7vQp+C0745bJFZtujmLJRRKMJdXuHaeiNxPfzRDBq6ZMIQpHKF7402VtRNF7q
	HURpgrQ1Qdv8jnAJZxkxMSfHl6gJ54KPexk+BG7mH7rgfzTbmSm5X+XlQc7F1X0a
	DVAqOJACLJSREpHclmgbqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791894051; x=1791980451; bh=n
	vvfhf83BQ/E71Qf6vShcore6G3he2GPtBQFWl32jmM=; b=Tt3vF9JfPiDtISTzW
	EymszyxdashDVnhkSCyE0LwtTAAUVFdCxX34MMdORSchdFdBsaKdUcNEl58dreqG
	IhwCdzENRdL2lQGrRcFR5CPz2s6lrQYGG6FJXCpRHxVEoifx3ksL/mGgX4a82OPu
	i/IIgwjqs7qHQ/Vf/4mwyNfiIYxzINZkOjjs0T2N598bJqyIRvM/MzwBZ1oPBWRG
	vPsAsG50ZUgkUFx4858vjpBPSUmvUc24IlWLLRNINf9VEXmxbqtWS2Z3bodD9K1u
	Pt5575TE8Te3TyfzV5j1PXdwwS+L55Xz7aVnI7HhWRSxwpoTlPp6lpvM+u3TLt4N
	JHfkw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791894051; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dPNys1W9pE9bssosiDyWInxj6AbXe5G4NF609NJHFhtiyam
	tZ78CYAF43nm9wQZnXyVZwizTsM+DQlmTKnKgEws3MWNJkVcg1SaJm5jyG7m16Zh
	0ZS8i73Px9TBYeaccEmH243Z4mx2AgoJAzYsvhbykV3xKQ8vKIaPVXhoMfDMLkBV
	MshAYV9VgtO80v4DJwdAxqcDRWf1+EUoNEOcH2V6HsrfNAlK1hb+2O0o/2P0A89G
	1eM/2QWu/ddrUodBSMtDIY6bGpM5XTy5Zv/P5GSpakhivUSssPNVN8wr3JBL58QA
	FUlsIduduS81rSmDNWQbfOSE0Rm+SGRnXKAzDsA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CmcRmFV+AWk/wkOrL+kKMq2uAg6OELqNN7LHJh7h+tU=:cV7SBs4LPpocy2u6cnoDUYyIeQ5WO5tncolUeQECyoE=;
X-ME-Sender: <xms:IiLOamd8DGqC6ROoBOnDzJYlmKOIzizM1LUD6K1q1gXNu6b6VAFJdoU>
    <xme:IiLOarBVmDvd4GJidcAjabqwDw4liNcpRnpv2JQ8_9PnGXIQh3LOdX8XkRRxinMO7
    pheoVjHJRD6RNtatg-6AtVUIO4ib_yjelaEtyFDG2whHux7AEVqlW4>
X-ME-Proxy-Cause: dmFkZTEIwJU1+dmwMcwbB+5sC+NnFCrgt/ymJgxvLS6EQGSVoCbyCzdlAfbjsfJP/FPGf0
    dF7NCFSJhJVJJHBJt+LGO6RWcP1s/Ej9kshJ/JLostQf5TCGPXvZHpuHYv/NnbkEHbUPj0
    doL53E5l8PY/hVCtKBPCmLSs/iRUblUtGApcU/wA87fCN/t5Rdb/6Z4P15Yo3LGbE3PggN
    BodiL9ojZE239/Fy7ElYiWgZmwwGxFc/tbrBYtf2Sdo5lUEcsyg8Yv/q+IH12i/slXNwKu
    EERXpFQDjyj/+ddWOS7qgw/rjcYvce7qniphd5v5B2l2OTWCZC3Z0dwOSvgw7SCrmWn/M1
    WHNfiiHyom95MXDljQm6yvqtJNhUPq7/Gx7UY0K0pMLl1++JrJQaLFkpWGeYYC6D5JCBy3
    yn2kZH7ouMJ8VBTEci96agvGMC0wbVVnj/kDIDEv1KOf+qDSieiFaGTLYh8idY/pOq3rPD
    +z+RvmygLbmOVBWb21i4uaIp/MxVQ1TVWG4/dsZ9vvAi/xX9zSmKicRz7HzjrJbbeyUUYk
    HGExNtR7nsjKlxYbPnxB2An9KS24WtEoN3EpXkImiwR9pUm16yMoW3fsbSYDWNasvZKaWS
    cL52p9PrVLK8fcZkpAjCcOnPx37L5j/ku+yQT6dB8Cp9yZmS7ukqdpvsfmMw
X-ME-Proxy: <xmx:IyLOakZIipmtcp7fJS7ALspP25y96xJR-7JaYsWrFUEE0Jfff4D5-w>
    <xmx:IyLOanItItoQOXXX7FjirHwETIe7VQRJTAYlLjaRkEJvtAy-OMTRrA>
    <xmx:IyLOaiBB28D6Z6y58kCpd0A6OpUt1eEZrvLfCzcnZSIMeQgC2aLLkw>
    <xmx:IyLOasr77u2YQJkukFuYFS0FHvdE7ipAxahPBGtpQyxZcLfhCAC0_Q>
    <xmx:IyLOapUBhHNFqK50oGdkxDJHYbs0GixqHsd9EUz1GHu8SVVXPnfw_dH2>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2DB2922C0095; Tue, 13 Oct 2026 08:20:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEXXgXC9MU77
Date: Tue, 13 Oct 2026 14:20:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Julia Evans" <julia@jvns.ca>, git@vger.kernel.org,
 "Thomas Bachem" <gitgitgadget@gmail.com>
Message-Id: <2642391e-1cef-4071-ae3f-db6fee3fab74@app.fastmail.com>
In-Reply-To: <5dad29e9-24e6-494a-9b0f-701af856ae69@app.fastmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <cb482e6d-0c76-4f34-b72c-03b5234d4f37@app.fastmail.com>
 <5dad29e9-24e6-494a-9b0f-701af856ae69@app.fastmail.com>
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026, at 13:48, Julia Evans wrote:
> On Wed, Oct 7, 2026, at 3:02 PM, Kristoffer Haugsbakk wrote:
>>>[snip]
>>>  Documentation/detached-head.adoc   |  43 ++++++++++
>>>  Documentation/git-checkout.adoc    | 129 +-------------------------=
---
>>>  Documentation/gitdetachedhead.adoc |  14 ++++
>>
>> Why in one word instead of hyphenating `detached-head`?
>> (gitdetached-head(7))
>
> Currently the guides are all one word with no hyphens.
> Happy to use a different style if folks think we shouldn't use
> the current naming convention for the guides

I=E2=80=99m confused. It doesn=E2=80=99t look like that to me?

    $ git help --guides
    The Git concept guides are:
       core-tutorial    A Git core tutorial for developers
       credentials      Providing usernames and passwords to Git
       cvs-migration    Git for CVS users
       diffcore         Tweaking diff output
       everyday         A useful minimum set of commands for Everyday Git
       faq              Frequently asked questions about using Git
       glossary         A Git Glossary
       namespaces       Git namespaces
       remote-helpers   Helper programs to interact with remote reposito=
ries
       submodules       Mounting one repository inside another
       tutorial         A tutorial introduction to Git
       tutorial-2       A tutorial introduction to Git: part two
       workflows        An overview of recommended workflows with Git

    'git help -a' and 'git help -g' list available subcommands and some
    concept guides. See 'git help <command>' or 'git help <concept>'
    to read about a specific subcommand or concept.
    See 'git help git' for an overview of the system.

What is definitely the case is that there is no hyphen between `git` and
the first word, maybe in order to distinguish section 1 commands) and
section 5 and 7 manpages.

>
>[snip]
