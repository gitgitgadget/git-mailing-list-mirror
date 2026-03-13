Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3ED382F06
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436843; cv=none; b=ShKBu8qLUNxX4k12ln7Ac5ZB86a3a5wmlTzhvH7jtBV88U42aO4OPFCsDW5bTFz/LdmpKJNrqFf+SPTF5CD2jfu85iutNgheDpidajGmCg/du90Yqi2bhaW3CX7ESJrHpRj+vfPu/+5ZpWewe4kMo1Q6z9oSYyIv2dhWIT046rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436843; c=relaxed/simple;
	bh=mODKFV84P72ple4f01gwja5jjTtrA4aVh2UoTu/yKAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pd2lG06uB+1af8CX2kXMMnCFBg7HzzvuDxv9IXIOEXbbD/32GuTEzXQL9BZtKS+WWbkISYbco78neF39FFntbF7Lg5GuHVZHQbKZx0w6jlvcAaY7+HuM7C5p9KzJSkErP+rEkYQB4O2Zi9jdVroSfuB8VUkhcG8rydekMLFgz4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ORsQ9yT0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KQlFLEe7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ORsQ9yT0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KQlFLEe7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C03CF1D001B0;
	Fri, 13 Mar 2026 17:20:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 17:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773436839; x=1773523239; bh=pJXOBb78dF
	rrn6187BYxtYFjRkqR8GLMAZLVgIVuFM4=; b=ORsQ9yT0JZeSAquWLX7i0lZ+cw
	3vJjfSgYWfQ4dXN3wfkjkpk/L5iiPHtSjT7E379ifMfYrmc5hQtYFFzIAFI/ZPcL
	tfskHQUDgGEzmXzZx82tHGHttoy9v48DTB2PBfvabYtbTrILVAoSC/ycPvI0A1SB
	6dvKTZ/iOj/2O3I6RaO29J1muArPQn0HCrAbbc3JEH3d04o2Up0fg/uSuQp3UnTY
	l5zmeb6h/eVDLhvuNKewODthlWGzCRpyHk1cBm74K5FnJao/Eml42dcppv337z7V
	x0PETmM5iUx79s5+TZhirQe2Q05nW2XSefNzom2ad7shrCpeKs84zt0HOKdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773436839; x=1773523239; bh=pJXOBb78dFrrn6187BYxtYFjRkqR8GLMAZL
	VgIVuFM4=; b=KQlFLEe7RiMHJR/72WsTHUPFel4N4dar/3f8a1Ju1HS4N+5FLK0
	HAl83kwMQvlmaTVdhIRoruZHuWPRILKxLjnUExtLliaTQNDfuuQ7imlScsyr9wqz
	xx8fXzppJAYe3tT/effgglnzffT7EOmBWtuRyxfKXaeQzepcKncpn8UNo17OWnLu
	Qxg957IAuifZHNvfm3dUm6NV0PeqySjxSLSUdY2sh5Ght1pF6zwsbDfc6lQ10iSf
	KXcDjw4PpPJw1EN8CjnYiGK7k0ZCTgMihh0t00myA2l7p5SCg3ha7XKbLq7BpbTk
	FdtNC+lWfr70itUTCcde750TNp/5QinWcrg==
X-ME-Sender: <xms:p3-0aZgIRP81ejFMn_aRcy7au8APwkcsBZJo_0_dPn6OIhIv-VhO4g>
    <xme:p3-0aU4f_aY1cEQzZi9p25kYputW_a3Qx-enE8JVrlSSQU6eFCLJQtgzlLIjjILQU
    8KpV1ILqC402-GYuOwe5g7vuBndlTXnTerPkNYiDpuO-Heb1PNjqA>
X-ME-Received: <xmr:p3-0aRb74KaF3KbsRbtFNqkQ2ywbDwUdnzn8Dfcto8i8Nx-cCP_d4quXKhY7LLIjrOCkKb2OOCY5xhoe1YPZDBrCZD1c4h0X9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvrhhitgdr
    phgvihhjihgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:p3-0aZ7WSUEEpMfhExBOijTiGxz85O66lCMKu9DYtrE5_SpN5p2pvg>
    <xmx:p3-0aUASADaHVQfa5gXA4smqNr4msQmRRzxZU0ueGk-OvnVDDQpK-Q>
    <xmx:p3-0afeeaWUfUhG-vnFLZbHpXrESg4Yxzw_s8bjUCadqDfC-4RrDpw>
    <xmx:p3-0aTLhtyat6Q_VaCHG6D0iMr4z1a1KXp_MEtk_QzL5UtgIsF9Djw>
    <xmx:p3-0aVJqPVVXLvaGRBKi0rgF66jeXuef38UKgXEpCqt4fQu0ChHJsq34>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 17:20:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: eric.peijian@gmail.com
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH 1/1] Add preparing state to reference-transaction hook
In-Reply-To: <20260313193537.62827-2-eric.peijian@gmail.com> (eric peijian's
	message of "Fri, 13 Mar 2026 15:35:36 -0400")
References: <20260313193537.62827-1-eric.peijian@gmail.com>
	<20260313193537.62827-2-eric.peijian@gmail.com>
Date: Fri, 13 Mar 2026 14:20:37 -0700
Message-ID: <xmqqpl572zq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

eric.peijian@gmail.com writes:

> From: Eric Ju <eric.peijian@gmail.com>
>
> From: Eric Ju <eju@gitlab.com>

This is curious.  The former matches the sign-off, but I somehow
suspect that the @gitlab.com identity may be what you want to use
for both of them, if this is a company sponsored work by an
employee?  I dunno.

Also the commit title deviates from the established "<area>: <what
is done>" format.

    Subject: [PATCH] refs: add 'preparing" phase to the transaction hook

or something?

Other than that, both the cover letter and the proposed log message
very well explain the motivation behind the new feature.  I wish
everybody wrote their log messages as clearly as this one.

> The "reference-transaction" hook is invoked multiple times during a ref
> transaction. Each invocation corresponds to a different phase:
>
> - The "prepared" phase indicates that references have been locked.
> - The "commit" phase indicates that all updates have been written to disk.
> - The "abort" phase indicates that the transaction has been aborted and that
>   all changes have been rolled back.

"commit" -> "committed" and "abort" -> "aborted", if the existing
documentation is to be trusted.

> This hook can be used to learn about the updates that Git wants to perform.
> For example, forges use it to coordinate reference updates across multiple
> nodes.
>
> However, the phases are insufficient for some specific use cases. The earliest
> observable phase in the "reference-transaction" hook is "prepared", at which
> point Git has already taken exclusive locks on every affected reference. This
> makes it suitable for last-chance validation, but not for serialization. So by
> the time a hook sees the "prepared" phase, it has no way to defer locking, and
> thus it cannot rearrange multiple concurrent ref transactions relative to one
> another.

I cannot quite picture how "rearrangement" would happen, though.

Would the hook notice "ah there is a preparing hook invocation
incoming", stall the caller by not immediately returning and instead
wait for a different Git process to invoke the same ref-transaction
hook "preparing" invocation, and somehow decide to let the latter go
first before releasing the former?

> Introduce a new "preparing" phase that runs before the "prepared" phase, that
> is before Git acquires any reference lock on disk. This gives callers a
> well-defined window to perform validation, enable higher-level ordering of
> concurrent transactions, or reject the transaction entirely, all without
> interfering with the locking state.
>
> This change is strictly speaking not backwards compatible. Existing hook
> scripts that do not know to handle unknown phases handle the "preparing" state

"know to handle unknown phrases handle"?

> string will encounter an unknown phase, and that might cause them to return an
> error now. But the hook is considered to expose internal implementation details
> of how Git works, and as such we have been a bit more lenient with changing its
> exact semantics, like for example in a8ae923f85 (refs: support symrefs in
> 'reference-transaction' hook, 2024-05-07).
>
> An alternative would be to introduce a "reference-transaction-v2" hook that
> knows about the new phase. This feels like a rather heavy-weight option though,
> and was thus discarded.

And documenting the design alternatives and decision like these two
paragraphs is very much appreciated.

The insertion of a new hook invocation itself is at a very much
expected place in the code path.  Well written.

Will queue.  Thanks.
