Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B6410D3D
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461812; cv=none; b=W6sSAUZKDEfYN1PxVTfqzVkEheBYdx0wopyKVU79pZEakGoc9gcTQaLBFJtTXqJS6RaxdsJ0xXbiQKltVBt7E1kN82MGXnJmcbzvg6ROE/vaFNk5mIck7EKbVw93Qhw1uerSkpKYC+lfeSSLxofS/d2da4tgsbfz+Lb+pXdUG4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461812; c=relaxed/simple;
	bh=h4oqZ+0KhD5U3PQTq52x8FhB00qM/imD74O+zXuqiV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EzjjOYdKGOLKggX3IagWWrHCPRg25s7rBuFAhCYv3DPbrT9MsNeRT00NRzb9Ew5U2yoEaZp1U2SAIvIZbEJLsJ0n7KNNH86UV+dDOeixqckR9qMjVmT7Fas5HJ+XEyhRIUAzWvMxR9se/kayWasY8I6LPulcjK+3DMw5ImkKzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cT3Vs5Wd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D2Brr4j1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cT3Vs5Wd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D2Brr4j1"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9299FEC0128;
	Wed, 25 Mar 2026 14:03:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 25 Mar 2026 14:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774461809; x=1774548209; bh=tocbj/DagW
	u8LB8Gsxc61uglBUKoAZW42bk8biH9pMQ=; b=cT3Vs5Wd3P9iY+rCNXybTvdEun
	r/OIR7qUmAHNyZH+s2wdiOrhGjy1lNAk6QpWuuOavLXf0uRPEEAsGsPZH4oGmrRT
	oC3JbK4Z24EivVmaQSCi+auhwirr/Fi8n8cFjaiZ2lS93YHiSSqF0anqpyu0YfKM
	V6rcBiS1g7DMotJzTl2xKvsAi5Zut3Dpid/NynqxBAOTg68HxPMKRPfA4Be+9ebl
	H0Ub4oRoAoGh6oGbR6jD2qrqd9+NkyVAFxC2SicIGFO5EyO16hUg91jASPQv2pf6
	q3sZywihvdoibRN5n55zSLouSgG6CfV4eVWj9iq21FiqURL/CPa8gH8tABzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774461809; x=1774548209; bh=tocbj/DagWu8LB8Gsxc61uglBUKoAZW42bk
	8biH9pMQ=; b=D2Brr4j1tpzCqq1ejH1uikr3xiPQcvxJE3rgeLJD0w1oOmadxTc
	VO/kXO2jBPrn74Y5/LZ/bp846lZjt3RzoyTC8wbPs1/t/hrK0T+sJU9lTwaMapmR
	UqAamL/HexlilTVHyagMSUt4q9fBz5gIKrDWJ8ev51J9USp1SD+1tFGCWrXGI0R0
	hmQgix0gzPbFhVAYFZnEuoVckc552Pa6m+WYRN532zhPPHDbWkjfFsm2TBjDYIXF
	rqYxXcb8FSR1HDdp83pWFVnnd3K9eiMA9KKT3k09iTWk3E+UCfSjVEb0MxSuBJzC
	eWZKnQZc8aBWWnJBLC3I1j2BHyqk36EA2ZQ==
X-ME-Sender: <xms:cSPEaZuXKKtBc8FzfNrNc-Opvj02vHXP8YJtPOyM0-lAMz3sz4Z-ZQ>
    <xme:cSPEaWIQ03yIcylpSoxdra4OC6bw19Sz7Vb4sYxa8ogdCKJehcedMdkFQ4A6JhoDG
    Q3sZvrjzVN7fOZEU4OSLQtgIhBY3lE7S-o9jYQ8zxjXmIjQaGw_9g>
X-ME-Received: <xmr:cSPEaWlgsSWeSfym9AUk41UHLusU16ii5GF9pPicsOtlP1zz_Ey4lapo5sqGP98z-NB2enBqNfSrhinKixTJILjNfkZMiq_SiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhuihiivggutgdusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrghhothhskhihsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cSPEaXLS3TuiGo1e0D6HL3PKC-f7dzGzPnZjDl-AddoYgwfF9R0sUA>
    <xmx:cSPEab7VEgzmLQs1RLkDi_RSpBE6aTa08elE57_a7uh53x4auLwnBA>
    <xmx:cSPEab3UZW6d6-c_0ypW2GktL3K7BvXF4EV1KVlMytKOhmSMVzoZeQ>
    <xmx:cSPEaRfZwZCWqwNt21dEWyVyz3-k3ISIE3uPqB-ldMlVzf29IqJBXQ>
    <xmx:cSPEaa3CGpBmWFSCbTQug_q-m5ahrXzDSwVKDivNrmt8GyvBxPOuB2IQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 14:03:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Luiz Campos <luizedc1@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  sagotsky@gmail.com,
  Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH 0/1] add -p: support discarding hunks
In-Reply-To: <20260325075055.354709-1-luizedc1@gmail.com> (Luiz Campos's
	message of "Wed, 25 Mar 2026 04:50:54 -0300")
References: <20260325075055.354709-1-luizedc1@gmail.com>
Date: Wed, 25 Mar 2026 11:03:27 -0700
Message-ID: <xmqqcy0rvlao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luiz Campos <luizedc1@gmail.com> writes:

> Hi,
>
> This is an RFC for adding a 'discard hunk' action to `git add -p`.
>
> Currently, when using `git add -p`, users can stage or skip hunks,
> but cannot discard unwanted changes directly from the working tree.
> This often leads to repeatedly skipping the same hunks across
> multiple passes.
>
> This patch introduces a new 'x' action to discard the current hunk
> by reverse-applying it to the working tree.
>
> This idea was previously discussed on the mailing list:
> https://lore.kernel.org/git/X%2FiFCo0bXLR%2BLZXs@coredump.intra.peff.net/t/#m0576e6f3c6375e11cc4693b9dca3c1fc57baadd0
>
> Open questions:
> - Should discard happen immediately or be deferred until patch application?
> - Are there edge cases involving overlapping hunks or edited hunks?

After reading the discussion (by the way, I do not recall seeing it,
so thank you very much for having a link to it), I agree with what
Peff said back then.  "add -p" that touches the working tree feels
quite weird.

In addition to that, letting it make destructive change makes the
idea even less appetizing.  Once you remove the changes introduced
by the hunk, it is forever gone.  A "discard" in "add -p" would not
solve your problem without adding many unhappy users who lost their
work by mistake.  I do not want to see people trigger "discard" by
mistake in "add -p" session _and_ find that there is no way to undo
that mistaken discard.

"stash -p" followed by "add -p" is probably the best we can do that
is safe.  When the unwanted change is truly unwanted garbage that
you would never ever want to see again, "restore -p" followed by
"add -p" would be an alternative.

One reason why they are not satisfying is because during the later
"add -p" session, we will notice that some unwanted things we failed
to notice and get rid of (either by sending them to stash or restoring
it away) are still there, reminding us that we are imperfect human,
and at that point, it is not easy to switch back to the "stash -p"
or "restore -p" from there.

What you want is probably a _single_ command that lets you inspect
the differences among the HEAD, the index, and the working tree, and
allows you to move things hunk-by-hunk in different directions.

 * You can go through the "git diff --cached" (i.e., changes already in
   the index), and selectively undo/revert the changes to the index,
   similar to "git reset -p".

 * You can go through the "git diff" (i.e., changes between the
   index and the working tree), and selectively apply the changes to
   the index, similar to "git add -p".

 * You can go through the "git diff HEAD" (i.e. changes since your
   last commit), and selectively send the changes to a stash entry,
   similar to "git stash -p".  This is not destructive.

And if the single command lets you switch among working with these
modes, you no longer need to worry about forgetting to send
some changes to stash to concentrate on working on the rest.

In addition, optionally you can also have this in the same command:

 * You can go through the "git diff", and selectively revert the
   changes to the working tree, similar to "git restore -p".

This additional mode *is* destructive, but if you know from the hunk
that you will never need the change in it, it would be a right tool
for it.
