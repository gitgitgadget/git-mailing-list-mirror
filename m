Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3C31E8BC
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041066; cv=none; b=dwBs4iS7jzUhxQ77kS1kwtYstnRY4FujGXGoAzg0/OoP99zAWI8RTG9iQlT04Ah0WSQUnWPFe7Nbfjrg/lupkmeRS3X7F9WmcGGRuD9vD4lT36wUxo+GvYIRmD9rkzMQm/FvcKsQAiU0f6ysKrb6JPfze2jrebGxet9KnMevnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041066; c=relaxed/simple;
	bh=w/S1VZcgHMcbO1SwkTnCMaDvyECGPmD73WfIuEBTDmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQmkg3khwQ2vQw8UwK5vTPkYSLTMlSWaDb1yrtPujSxkvqdyrXsDHzBNF7iXPD/c8F6yK/P3XXvToRMmQLT3X03A+r+zqJhzqHVtrb9hcV5SJQVOaP8kuRJW+CI2/edFfQYu3ohLcpXO6G6SSZ5ZZsH/thwL5aDcHseE0PFiZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=it6HWu/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyVjji1/; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="it6HWu/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyVjji1/"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BC24DEC0396;
	Tue, 16 Sep 2025 12:44:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 16 Sep 2025 12:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758041062; x=1758127462; bh=++nZzsL0uQ
	kFzBFx3HPoaDDByBsaSUtRXx8AbGuLRhE=; b=it6HWu/X5aYXa/Qm8eE6DMFnrc
	c9ZH2AqrOayOITcx+/pMpgSmgkxxCtNSNwZd3vfBC/SQvJ+MRxt4nRDe4W8sSaCX
	ZJyYJA45xBSbOqr4At5dnRcsbGGgTPsOVc27BJDUD9Sti3BhM1M2RgebapqjtQAX
	CiQKwnv3XpE41UgQdO66ed5WFBjPbIYywL0XGsK5ZxVLF6hhON9SwPFhiHi3cyDi
	cdRoKKKqeFJM44eB0u5le40qPTqykWB956AVAhMqbevrVHz8t06DUcTsaL0xPvrc
	f6U9BmPZifsIyv60fd41pts6WWc4q1GUxD5jPYnXjn62HK5awCCANoTRB6Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758041062; x=1758127462; bh=++nZzsL0uQkFzBFx3HPoaDDByBsaSUtRXx8
	AbGuLRhE=; b=hyVjji1/czvdB+S1ndnD1qH73iNlPy3Z5c0tZkRUSoe+8vOnKt2
	JXwAWWHWNT0RWZfNbEtzNgKurI0P8DqwHnzSSwYO+YDwIBeGzqHrXUTRnDxxJq4d
	GW97w4RfFX7gEHzDdPE2tRXRkq9R34xeCJKHlXEhuaFeHAGtEmxwL3weTgTx7ujA
	K5rlPwkIKbkCm+nTU/UP5/UIwlXt5qFG3Jba8WucddeKxFeU5GZcOYEH+q5/Rwoz
	Yee66Wi3l0+s8NsTpOmv57njwwccbvUfJxmb3lQmBlh0WaEW/E9b5ipZXN9+1saU
	7nULKtgT/RqX7B1tyacqCD37ppcDOKJS9Mw==
X-ME-Sender: <xms:5pPJaGig4M2VAz53CXSffwoqnyJU8b6waoiJrF3R0ylVAvlNuZlX_g>
    <xme:5pPJaChPtCvMKg2-rDtME8iEglSVp4Qf475jQlOlAzd0DcNtaESotgkx42-SHGCU4
    Bjch1pMRRRcn6hs6Q>
X-ME-Received: <xmr:5pPJaEjOZMnnPUFFJcTcXrk0rVkYxlAcSfRK9neU5z3BPSDIpbKf2CzlMjAE6vymAw2MFkxK4w-t0cw1w9zv4CQ7gzahSkiXqWiXzhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5pPJaKJBtiDxkxgHl__en6llmFWL_K34VJhg79tnnf9APrbrApzWGQ>
    <xmx:5pPJaLHX5a0-dziU3Q6blBcERi7uCCc991QY1TKTQ7XKBsmDJorXkA>
    <xmx:5pPJaGQkCzakEXhYhW5gzR8f41TCqbT-aqYgr1kKljofkjm5-TQoHw>
    <xmx:5pPJaPeXEUFrvg1gFkQ9JZUbevgFzW1NSlYKKczd-x4Qrv4X87gLMg>
    <xmx:5pPJaKE_Ba9NeH73Mx6utdosrzJqJzTgBIV4uiKU39PfDcBYPecQwK0q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 12:44:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/6] bulk-checkin: remove ODB transaction nesting
In-Reply-To: <pk2cpihxk4j4ywgq3dtknybyzjeon7ajgmwq4yhknojjsfiqo2@q5dsygszdkar>
	(Justin Tobler's message of "Mon, 15 Sep 2025 21:55:15 -0500")
References: <20250909191134.555689-1-jltobler@gmail.com>
	<20250909191134.555689-2-jltobler@gmail.com> <aMJu4yoO5-Xp52oJ@pks.im>
	<aMijGE2CveYcQaWc@nand.local>
	<pk2cpihxk4j4ywgq3dtknybyzjeon7ajgmwq4yhknojjsfiqo2@q5dsygszdkar>
Date: Tue, 16 Sep 2025 09:44:20 -0700
Message-ID: <xmqqfrcmny8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>> In addition, it would be useful to hear from the commit message *why*
>> this is safe to do. Justin's message suggests that nested transactions
>> are noops, so doing something like:
>> 
>>   begin_odb_transaction();
>>     begin_odb_transaction();
>>       write_object();
>>     end_odb_transaction(); <- object not yet added to the main ODB
>>   end_odb_transaction();   <- now it is
>> 
>> only results in the object being added to the main ODB when the final
>> end_odb_transaction() is called.
>
> Yes, well said. {begin,end}_odbtransaction() operations on inner
> transactions are effectively a noop. They simple manage an internal
> counter to know when a new transaction should be started/finished.

In other words, that part of the design is inherited from the old
bulk-checkin infrastructure?  It was done for simplicity and I was
always unsure if I made the right design decisions there, so it is
nice to see that I found at least somebody who seems to agree with
it well enough to inherit it into a newly reinvented subsystem ;-)

> Yes, this patch removes the logic that manages the internal nested
> transaction counter in favor of requiring callers to check if a
> transaction has already been started or not.

OK.  Is that related to those "make it a silent no-op to pass a
NULL, instead of forcing the caller to check" changes?

Can all callers tell reliably if there is a transaction already
going?  One transaction may start somewhere and end in a far away
place, and these two places may not be ancestor-decendant in the
call graph but merely a distant relative that shares a grand grand
parent.

> The ultimate goal of this patch is make it so invoking
> end_odb_transaction() on a transaction guarantees it is flushed.

Either flushed or a noop, I guess?

> With
> this guarantee we would no longer need flush_odb_transaction() and the
> transaction interface eventually can be simplified to just
> {begin,end}_odb_transaction(). This also avoids a potential class of
> errors where a caller _thinks_ they have committed a transaction and
> that the objects should be visible, but they actually are not because it
> was a nested transaction.
>
> The nice thing about the current implementation though is that nested
> transactions are automatically treated as noops and the caller doesn't
> have to check if there is already a pending transaction. This is safer
> and less error-prone.

True.

> Thinking about this some more though, we should be able to continue to
> have {begin,end}_odb_transaction() function as noops when there is
> already a pending transaction and also be able to drop the internal
> transaction nesting mechanism at the same time. To do this, instead of
> erroring out in begin_odb_transaction() when there is already a
> transaction, we can simply return NULL. If a caller wants to know if a
> new transaction was actually started, they can just check the return
> value afterwords. This removes the burden from the caller to explicitly
> check if there is a pending transaction beforehand. Furthermore, since
> an ODB only allows a single transaction at a time, it probably makes
> sense for operations at the ODB layer to guard against this anyway.
>
> This change would pair nicely with the change made to
> end_odb_transaction() in version 2 of this series. In this version, when
> end_odb_transaction() is provided a NULL transaction, it now functions
> as a noop as well. If a transaction _is_ provided though, it is
> guaranteed to be flushed with addresses the main goal on this patch.

OK.
