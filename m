Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C015330D43
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475113; cv=none; b=HgSgPeu7ANwGOHbK8I3LBT3QsuBS+hZmkvM43lHYYG4OQqY86NQqtjQZyo2OIwaVL0DeAe+i2h4ainqTXUYfLFiTlZbWtakVy1UELt4eqLjXT8ia4exhdlY+FSNEhfXkfM7deAOWzDAz4vDbqpbjVpFVIabgyTCquSAVs5HcgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475113; c=relaxed/simple;
	bh=JAJBswdr3mnbiXyXKLR8SlIkmDujTqEbYe01NjyEhJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dry4qwIoP7Z1o1x0pqh7V+fm27nO805TbtQB7D9xbu3VQyXtb4KevWdrTLkG5Dd+DxfqNK1hObzzVNshHeFwQvULP2HiQGWekbqItqmM5p1qmw11OmaagssFouG4YIvd1k1EWejgVLGlSereoBSXwnZnxGKTcOI/bfZTB5TyqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GwL8Kf62; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ljhq6aKi; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GwL8Kf62";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljhq6aKi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 49E15EC00D9;
	Mon,  2 Mar 2026 13:11:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 13:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772475111; x=
	1772561511; bh=kPgsTrAqprJOKpHqlM8lJJgSF1gYBkh6skmJakcjOhc=; b=G
	wL8Kf62Mc46WUuZ60Wri7mjJPq5zsBtp9L59blUPCRWfkNc6KGJwfJDTzjLbK6y9
	lRZ2e8WKogWhpDxc65FuCblex4bLXGp00e2mk3l9G9lSlKrucFSwI20L+hlxZySb
	uYidXV+W0IN38KNLwbU5E/zOBWYyPXa5U8SWcNVRA0xkKyiW1ndZ3SgLAZmAc5Wz
	Sl8cA1cQK2HxdT1u8C+pBLRXQBod6ttOKv/BLB29P3ebGEtMl765UmWACkiP4VRE
	Anrv4nu3AT6rtY/WR5IgMwGsHkP/kCzdC2dtAkwYnJya+csfnYxfXNJjAv3uxbv+
	k013OGv1v1T/3rJFaOMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772475111; x=1772561511; bh=k
	PgsTrAqprJOKpHqlM8lJJgSF1gYBkh6skmJakcjOhc=; b=ljhq6aKiZqpOhKOSi
	xleh3ebTvdPDJpNIBN2KmCPzEsWlnMbcPR+C1RFjKMblxi6Vq8eLHwuQH4L+yEUs
	5WdvZbxDpWdqgI0o5X8A/p9yK3+CDXMlR9S0fYE5cH57/490LoSHJzuhtJ4yTL0f
	3j5D+wpWiPdzoudywGeCtkCoNnDfBYiY5Ui2AzE8mq3jMLTILFuZ4d2Qk0YPYTtl
	zbvoeM5pqv9xTix2WoYwr0/O5WZi01pyc5ZVaUj+6B650NJFeS++plQaIZcw63Wd
	1HSaoZHOUYRh8xPNP/xc7reHDwnzlJtuxHfvD+MQA+4V/A7mjQJGupSN9Ilh6zix
	dIdJA==
X-ME-Sender: <xms:5tKlaR8YH6uMtsKG_RUXRUZtyqRYWOZnAldi6SaWMsBsJI8op-upiw>
    <xme:5tKlaSQGSWLw-zS5qCn6neSMYKfzRF6GWOo7KRe6WKKJlytMjkiSmtCSQtGW5uRYK
    zPejgxwoXfH8m5Ns92r3Hc9BICTiS8LgVnygQIUgDuf6XTTJLlVIA>
X-ME-Received: <xmr:5tKlaTcucsn5Tczi0ZOGsqZ98NkSL_LXPURmZrSJjCc3Ovx1XDTvphO-x-JEDZ66IF0eLanVRvr1mfo-wGhLTMKQ-OO49369ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdfflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddv
    udeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohep
    ohhpohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthh
    hinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:5tKlacQYTNiJATqlIrFD1rDfzpnsmv7x24VrhM6eqvWIBBcPtzOLQQ>
    <xmx:5tKlaXJ7dJ94Htglmc67XLahHfzL-Zbpn1M0fn2MeJXwkWMlRcWyAA>
    <xmx:5tKlaRJzmw0M1xKnwl9ATA0FDhizoVvgTI65uvkDFWNKkyAyo1ZsNw>
    <xmx:5tKlaaiT6rhgnHEHEUb0G5ELIhAVJOldbnfo9yU5FYUyZYbt9iaM-A>
    <xmx:59KlaVLw_gVaghJdaMRSJOn5SqXIKnoJ92hIIVSf4fmL_c21oW_4GMwQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:11:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	"D.  Ben Knoble" <ben.knoble@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/3] Sanitizing sideband output
Date: Mon,  2 Mar 2026 10:11:46 -0800
Message-ID: <20260302181149.3502811-1-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-549-g863838a955
In-Reply-To: <xmqqv7gcnwd4.fsf@gitster.g>
References: <xmqqv7gcnwd4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The topic has been waiting for an action but haven't seen any.  Here
is a follow-up message in an attempt to unblock.

>> Users who need different behavior get configuration options:
>> sideband.allowControlCharacters provides an escape hatch for environments
>> that require raw passthrough. The defaults in Git v3.0 will be secure.
>>
>> This series applies cleanly on v2.53.0.
>
> Thanks for an updated series.  They applied cleanly and merged
> cleanly to 'seen'.

> I have three problems with this round, some minor, some fundamental.

... among which I already retracted one.

>  * There is a value "default" that the user can use to configure it,
>    which changes its behaviour across Git 3.0 version boundary.  I
>    think this is a horrible design.  Those who do not configure may
>    be showing their acceptance "I can go with whatever the tool's
>    designers choose with the option, and if that changes in the
>    middle, I can adapt", but for those who do, the configuration is
>    a mechanism, an escape hatch, to express their preference and
>    avoid getting disrupted by future change of behaviour.
>
>    Fixing it is easy here; just remove "default".  Those who want to
>    live in the fiture earlycan set it to "color" and it will stay
>    valid across Git 3.0 version boundary.  Those who want to make
>    sure their control sequences won't be broken can set it to "pass
>    everything" and it will stay valid across Git 3.0 version
>    boundary.

The patch [1/3] in this series addresses this issue.  This is to be
applied on top of Dscho's [5/6].

>  * I would have preferred to see the early parts of the series all
>    being opt-in, and that subset of the series be able to graduate
>    earlier.  Way earlier than the default flip to prove that they do
>    not hurt when unconfigured (they are theoretically no-op while
>    being opt-in, but we want to make sure), and that they do help
>    when configured.  And then once we are satisfied, the default
>    flip can be discussed and applied.

This is what I already retracted.  The structure of the posted
series to start extra tight and then tighten the default with the
last patch is actually good for experiment.  We can merge all the
steps without the "Loosen until Git 3.0 and then tighten Git 3.0
with WITH_BREAKING_CHANGES option" patch to 'next' and see who
screams.  Once it proves to be not too bad, we can then merge that
last step also to 'next' and make sure the loosened state still
works as expected.

So, the plan is to merge the early part of the series, INCLUDING the
"do not introduce the value 'default' that will change its meaning
in the configuration file" step, to 'next', while holding the last
"Loosen until Git 3.0" step back.  The last step in Dscho's series
[6/6] has to be adjusted because of minor textual conflicts with the
"do not introduce the value 'default'" step, so a rebased version of
it appears as [2/3] in this series.

>  * The overall approach is "we know better than our users what
>    control sequences we want to pass, so we will write code to
>    recognize these small number of control sequences and allow
>    them", which I am worried that would put more users at risk.
>
>    But the thing is that our code may not know better than the users
>    what control sequences, which have little security implications,
>    users want to use in the payload between their servers and their
>    desktop clients.  What happens to these users who use the control
>    sequences that the code does not recognize and still want to keep
>    using them?  They have to either
>
>      (1) write code to teach git to recognize their control
>          sequences (perhaps they do want ISO/IEC 2022 passed) and
>          tweak the allowlist mechanism to support it, or
>
>      (2) use the allowlist mechanism to pass everything, even the
>          sequences they are not interested in passing that have
>          security implications.
>
>    Most of them I suspect will do the latter, which is not what we
>    want to see.
>
>    Can't we do this the other way around?  The code may not be able
>    to know what control sequences the users may want to use better
>    than the users, but the code (and the author of the code) should
>    know what control sequences have negative security implications
>    much better than the users.  Instead of teaching the code to
>    recognize control sequences to color strings [*} that have little
>    security implications, can we teach the code to recognise control
>    sequences that we do *not* want to pass and neuter them, without
>    molesting control sequences with little security implications
>    that users may want to use?

And I cannot do this part myself, as the posted series does not shed
any light what uncertainty we fear in the bytestream coming from the
other side.  If we know what malicious data we want to protect
against, we can surgically and specifically protect against them,
but there is no hint in the posted series X-<.


Summary of patches in this series:

 * [1/3] sideband: drop 'default' configuration

   Remove the value 'default' from the allowed values for the
   sideband.allowControlCharacters configuration variable.  Applies
   on top of Dscho's [5/6].

 * [2/3] sideband: delay sanitizing by default to Git v3.0

   Dscho's [6/6] rebased on top of [1/3] of this series.

 * [3/3] sideband: conditional documentation fix

   Documentation mark-up update to help translators with the
   conditional documentation added in [2/3].


 Documentation/config/sideband.adoc  | 13 ++++++++++---
 sideband.c                          | 10 ++++++----
 t/t5409-colorize-remote-messages.sh | 18 +++++++++++++-----
 3 files changed, 29 insertions(+), 12 deletions(-)

-- 
2.53.0-549-g863838a955

