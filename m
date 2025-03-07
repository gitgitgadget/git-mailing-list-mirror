Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE52257438
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380391; cv=none; b=nd3qs1vxDwPLA6uLJCuHvPyjvA0P93us9mPz9bvyFOhsp8iMKC6ADTH6xnBJp8zRn4PAe4d8iCwSN9XTWEW/bOx7NR3rONjG/cNagsqiHDjIEM/bFrfMDOxCE9VpJwE0Wax0fe3r7qD0tKwnJ/nKt1p48g5ejT3MXPL/Cbh7fOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380391; c=relaxed/simple;
	bh=o4j1+y261l3G5Pi7SiPa0JFOK/P0CiJC4yPqMXaL6fc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V3KZ1589OMCxBm4sxlx64Xj1/bhRmk2EVVtbfNaoAW/nzP+ZRrm0lUXYpf0CKap8o/hwn3STUrdxU2/qGPbV72mw7qbTpqHxKA/prStt095G3uOyznqvk/xOA0qu/zw/wCw4bqzBeridw40BIOY0uYi2zAZ3og8gOEl3Kkvuol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lMkvrD1i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nnVQ9N0d; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lMkvrD1i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nnVQ9N0d"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D36BE1140184;
	Fri,  7 Mar 2025 15:46:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 07 Mar 2025 15:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741380388; x=1741466788; bh=vk/YIUW2R2
	PdLdbNtFtq/rL9HAx4dbGXZybeDI1TmU0=; b=lMkvrD1i8ZRBTjdygrnpt2yia/
	imm5ZPsPwDV5sdzgtuqXwt/fjf7fnBlHg+EGniQ+KGgrnI/wLDTwAW3uCTQie+Z6
	J1hpy4a/D0vikNQhHKPjeQfsgyjEro5yYRDm3mx0k2Y+D5/ZAbcuO/pKSYRBgUAT
	3NvDq7dJgmmh68fUbvJ7Td/22EymkhE9gCbwDhxF1dWBS+APDC7ivILpezzh1Uej
	AJnQgilKLbLJOohTexr0hbx7rAlNJLpQVnJ6wWdFm3zv50xlJi+Sq7aLoj0k1R5x
	UANaB0pJvD99/tNisFWPeCcndneWdHP/YRD5U4sxdlhphtLjmMPvMOw+eTDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741380388; x=1741466788; bh=vk/YIUW2R2PdLdbNtFtq/rL9HAx4dbGXZyb
	eDI1TmU0=; b=nnVQ9N0dkoSjRNIpFFoObOiONlrizqmlcrbBiwRvQLK7jYEmCVB
	8CUP8M4W3f21KX8/3eJxQpKr+gm7aYRDDlz2zldMUMrRRCzrhyzokq0Rg52Vj9r3
	jqlMnjQ0e+Yx5yX/XgM7G/9SNdiqYr315TwQBtjc0xZLTmOSjxWVcrptMisqHOL6
	6rgHM3rS0I4xHvEamXrRpr9lh3CbC3kkkbTijlvuVO5Z2YCK3XEMRTnvGRG8kbA5
	1q0+L/u4z9LcFZNzU7UqMAtKqFXTHPD/img+bcWi+VHA3Lyc+AQi/8Ba5i9djKeY
	zmdOp3wJW73BkDjE2nw+1x+QZOmmP8RCqXg==
X-ME-Sender: <xms:JFvLZzq41PpdEzmXc2C1w5y6jvwJrbobLF_uB4WyGbBfkZ-1IYNDig>
    <xme:JFvLZ9qohFPNyGe9L2XrpixL_I7l4AWq5rQ5IL-CxdUcegrXQMByC6fkmVjGxpg_T
    wInEfUJDdwed-0G8w>
X-ME-Received: <xmr:JFvLZwMZiGtovdVJPUzWLQvpUrVWZqapWutJmLCVMshvbFP9lw2_JiNPd5NW1DyRG1b-IWlD6aE8q-wjs0ITF-SOuQ-deHoZsIN_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JFvLZ27EEv3sMni8uKS-vX45E_zhpmyFF3q3JRQCa_-EqmjG88g-MQ>
    <xmx:JFvLZy47JFPzY5XMeYHi1oYADpC9HsoDb1nfHTQGhCsBHdoWl6lHtA>
    <xmx:JFvLZ-gi5-a-FQyWk7GcOjI_RvrXRcA_WlY7wzrPleWBAN6L07Ia-w>
    <xmx:JFvLZ07eQ8rXvpQIRUOnzgy33kMwloSy61tPQEg3Oj_ynNsv_9q3VA>
    <xmx:JFvLZ5YdMnMVA03B_Huo0kQBGGA5V5fdGi3cVq47JjB0Bg_Hlhyh5t5q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 15:46:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 6/8] refs: implement partial reference transaction
 support
In-Reply-To: <20250307195057.GA3675279@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 7 Mar 2025 14:50:57 -0500")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
	<20250307195057.GA3675279@coredump.intra.peff.net>
Date: Fri, 07 Mar 2025 12:46:27 -0800
Message-ID: <xmqq34foefh8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Mar 05, 2025 at 06:39:01PM +0100, Karthik Nayak wrote:
>
>> @@ -1456,6 +1471,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
>>  					    update->refname,
>>  					    oid_to_hex(&update->old_oid));
>>  				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
>> +
>> +				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
>> +					strbuf_setlen(err, 0);
>> +					ret = 0;
>> +					continue;
>> +				}
>> +
>>  				goto error;
>>  			}
>>  		}
>
> This new code isn't reachable, since we return in the lines shown in the
> diff context.
>
> Should it have been "ret = REF_TRANSACTION_ERROR"... in the first place?
> I think the "goto error" was already unreachable, so possibly the error
> is in an earlier patch. (I didn't look; Coverity flagged this in the
> final state in 'jch').

Sorry about that.  It shows that I lack the bandwidth necessary to
go through fine toothed comb on all the topics I queue.  Perhaps I
should be more selective and queue only the ones I personally had
enough bandwidth to look over (or have seen clear "I looked each and
every line of this series with fine toothed comb, put reviewed-by:
me" messages sent by trusted reviewers) while ignoring others?

I dunno.

Thanks.
