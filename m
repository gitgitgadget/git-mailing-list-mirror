Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59836253340
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539720; cv=none; b=BWJDHg9BVPnJFoSfVbLHl3Osodum7Lb77uLeQU5pxeIEG9oqXSWu+6ljJ+q8Cco0H2vuxalFpt/7VTm+j3mLnsjFi8lgfqdQdmaGv64lyk+LrqzBz46MiTxpFuuCzF+x8bcKlGAF05wMY/GogfeJwqw9q6/8GgeSUMv922zrjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539720; c=relaxed/simple;
	bh=elp9RaranDQ8tYGSJ/R2LC77YeqqifwMvYr4/WsfMB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AEMvkzdxCWttqedL3xFwNCndavT3aOjGJsB+Q8c2BD6d83zPqbilrVvAb41ZS3WAEfw9IE0HMUE2mnWQfcO1kwc8mh4Cn6XW1koFHE86chMc+SQgM1Es1iggC6TxdNSS4yEYyqyOKDCj0bBjqJRQ1g/1q/kpwF8k+RZuqk0zWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AtAppbMg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iNxPvFVb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AtAppbMg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iNxPvFVb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 771A2EC0259;
	Thu, 19 Feb 2026 17:21:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 19 Feb 2026 17:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771539718; x=1771626118; bh=ytK4nGC7gV
	5e3mjkxrhlK1Q2NfGXiyg6VMsmCccbm+0=; b=AtAppbMgiN+Uc9zFYyf0gN+IpI
	VrWYVVMClsssUhdTMrKQsMkpvNzFmhAuXD1izJMlvL0vf8iBRxUIjnbqqJX4+wnf
	0ljJnOVYl0f1coV7brnftamK/vEXpDpjk8iVzZKahfWepJgvgCna1gW69GlwzUut
	Jc68wbjatqky0SN87Ovs3HHSLSyg0oy7B8wF1fCrgbb1ReWTuxC9Uk34H339x4br
	gAUVGV0uHKtIXtlYBaH11cEPxTAfvG4Mp2F+11A+8ni6b9q1e8H1kV3K2BOFjGsQ
	ZmRp+zYlA5M2jivkiQmRBUdWBipys4B8+4NLOJTCuam4qpJsZ0Ct+TzN0gJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771539718; x=1771626118; bh=ytK4nGC7gV5e3mjkxrhlK1Q2NfGXiyg6VMs
	mCccbm+0=; b=iNxPvFVbkIIkrCI8xnF49r/7McVspABr0OOx5C95A7CRQfBAgXO
	J3zEL9+oy+60j6kxrCZriNUnneOpAq9wcpzZiBJ+bWdId5KccT0+NQofNQlO1JQo
	0K8dVf98C2oODgX5PNOnzSFpOa/S6KfTqEmaI1hGFp1TqegYi7gBLy7Njuu2AeyL
	P1r+C/5+Il+glz9DyOrQzrbqiNVwN7iAe5uxUnjzOH79ugDOYxyEHA83GEYH7sLX
	j9ARtsRk2ks9dWe49JnLVaQhVe2sMiRD9FRbgZiNGxfayM2HX1fYTbe+xo5XcVvk
	JuMFwSoyXC6K/X+apahD/DVg8S2B4AVjRNQ==
X-ME-Sender: <xms:Bo2XaQWUu_GUVxF7xWcLWWDIpLd6N8L3xBhsrDKBViA0l3J8zfl2ww>
    <xme:Bo2Xabdqo1nqS9Mcjgixbr9kzG2r6SuJbkqa1vI96udTij-4kNzkkBPhuuArkHoUU
    VcTuZsbekY4dvlb8R_X2u6LDySOG5_UqAxRrD4aGDVa_2paPf8l8ls>
X-ME-Received: <xmr:Bo2XactsO7IVO2Y5ZBtoSAlq2aj6JgLBkcNHtFPEhF36tdi37xFOr3HiTQ1F9icJdlxTSvyEkYuEg7Lrio8N9KVhcJUCrsgkew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgihqhhsihhmohhnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:Bo2Xaa_e0CGLPzVRgr5u6ffZ_2K9IwIYnMBcSFItKkFl6ibtp33DLg>
    <xmx:Bo2XaX3HaU6a0wNLfAMnxQNNmRyFOfNdpuwqQxRUkg0u_ZtvEHk4iw>
    <xmx:Bo2XafCXfL25QsfpAXQzzKZCNq4RQhudk2pEOHgkLnqmXZgsEsHCyQ>
    <xmx:Bo2XaTeZBybbb-2xXheVm0_xhBztfWeuAqRqhoSntqZdAGLbUXHQrQ>
    <xmx:Bo2XaaPRJ-3SqeOqtEpk_QMHV5dnVz61OVWxr2hPxx3eTzPMfxpfCCPP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 17:21:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Simon Cheng <cyqsimon@gmail.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/2] checkout: pass program-readable token to unified
 "main"
In-Reply-To: <aYYROwDxrHU-H3n_@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Feb 2026 17:05:15 +0100")
References: <20260127192936.904719-1-gitster@pobox.com>
	<20260129190616.645471-1-gitster@pobox.com>
	<20260129190616.645471-2-gitster@pobox.com> <aYYROwDxrHU-H3n_@pks.im>
Date: Thu, 19 Feb 2026 14:21:56 -0800
Message-ID: <xmqqtsvc1iij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jan 29, 2026 at 11:06:15AM -0800, Junio C Hamano wrote:
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index f9453473fe..4f189fde48 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
> [snip]
>> +	switch (which_command) {
>> +	case CHECKOUT_CHECKOUT:
>> +		usagestr = checkout_usage;
>> +		break;
>> +	case CHECKOUT_SWITCH:
>> +		usagestr = switch_branch_usage;
>> +		break;
>> +	case CHECKOUT_RESTORE:
>> +		usagestr = restore_usage;
>> +		break;
>> +	default:
>> +		BUG("No such checkout variant %d", which_command);
>> +	}
>
> Tiniest nit, really not worth addressing on its own: BUG messages
> typically start with a lower-case letter.
>
> Other than that I like that we have less global constants with this
> change.

Thanks.

As I locally amended the nit away while queuing, I guess I should
merge this down to 'next'.

