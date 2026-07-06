Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017C2EB5A6
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369466; cv=none; b=QW7Nw2jSY1sehsAMD8d5nMiyUTtaFc4IwFl/qNW1loUgkOW1Zaq9xa2OTUPLRT5ZpWfz6GbWwWKz9t/4sGXVB19hQNoF8G4fncAmxEDBWbjD63ttqnqQohboctTXU5nG4c3+7dkdkf5qCx1+FZHvBaKrxsg0MRPvtdeEqwc8VNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369466; c=relaxed/simple;
	bh=rIsMGDqJrQC6w2pI32VIP4lz6/XuXVAr7HvqApx8qy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CD5nOmxcWyFMx6XgTJlw5nWCLa2QS3MgNb0hbRgBoGOLBfA8sRVnC9ywovvw0A/9PC6wxExL5eRIVRQZ1MrommJ0dvdP59Q5qSTbF/OF74GZZA3DRvX4al3SgGirK5AXW5CFwVygfeH3tUuYi/Du3KHQA7JCwklFVJNWOFZFWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LIrbi1Vs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U5fKXmem; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LIrbi1Vs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U5fKXmem"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5FA91400082;
	Mon,  6 Jul 2026 16:24:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 16:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783369463; x=1783455863; bh=Eg/n4xVmZr
	LxJkGNCXwoslY+U4HE292EIvZNtfR4GFo=; b=LIrbi1VsTWeANxBUrj1IPEjWe2
	Xw8rQhTNNP2JLOrgqR7EzYzzuXdIDBTgaigX5bwV8dDFHgweU5nYYcJxQ5mFCLjD
	/7AVyWzCZYZ3W5n1Uz6Ooh4BElDNbwFc85E4J3I4VSYQwVm6bPZotc6Oh4KVHt8J
	2PTKYigxpmx8XMq7JUJ/sV1HoMyRXPx7OPxVtA0o4n1VfXfrf5gu0grl0V3prtkO
	5Vdt1X94+hM/RPJ5/kuh00o+JWg+flJYeTh6hM+r/X6PtHjQ1VseQdOGiKVFLAI5
	n+WuOoNTX9LAArUEz4OKBngZfJYb3q6PQv8jiOnAHq4ZRD3KaR0djDj/4DWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783369463; x=1783455863; bh=Eg/n4xVmZrLxJkGNCXwoslY+U4HE292EIvZ
	NtfR4GFo=; b=U5fKXmemG7B6kdkz9KfIh1fxp1YV8lHdlIJJ4SFaKNNXK4d6ioS
	Y/+WzAk8C8RITN1ahS96M+NHCy4qK382pqCiN/IT5yhdp0eoxeebHmKqykyDqZOc
	F1PXdcSNIUeYGw37c3O69/BgfLciw6IMJ97BI+WHPIWqMa6+ytXecpRy8fVFU83m
	BqVF5sawqAJA9vjLeTFzhY1iGiY2/vRutvOallzvilYzF7u3Eh5GB2e25P31I2mR
	cGgH+XoxEtZaxf/+gjEhQngj4hXKrx5eORK0nkRMne12v05ahsEHc076YnzPafzK
	NqhwLSgldZ86NZD2p0EdU9+nYs7zMbyVHwA==
X-ME-Sender: <xms:9g5Man1k5Z-GLmJJBTD0_rH1E7Ju0epM7dy5vPDD2QG1KEADoLBPjg>
    <xme:9g5MagE1GasAxpPd4Z96PoSKOa-G5PLK0lZtPCLwl63sGZbqpCktN1eUovJwGO9n_
    ohOWbD9398O1wzflVOfDhdsNwrEI1kK3UqqSvV1OfePhs7_jCIi>
X-ME-Received: <xmr:9g5MaugFhWJzdiW9I7toejYKDLZn8suUyypGGV_u6oIPhWlM68y-owplHB8cnmUskGjy5cxKIo7hvmursWjaH5fXoAYI7lQ4Vgj1PmU>
X-ME-Proxy-Cause: dmFkZTFQ6P260r539wcA5fvZo45Zm23odAj5ZgZ3nzUzOg6hDp3bKo/2lvU44fSktZlJKh
    I4ldU2qOCvIKMqqwTrcUwUCQilXfgflDLVFAFOZ1TeHjYW4z+42w5kMG5Nbo/EHCP9xB7q
    Q+3kZnLjYMqqWTJK5UwWsu5yW1bsO592GF9Un3ryBi/F9URdRprPHETdNbmBT/8/xQTxJy
    4t2DSOil5oF34bGI1o5quoIXkoGhPAMiMawaGKygb0/JBW9LLgyi5dJp9xaeB8r6pyWAG4
    KiU7ambC83M/WTIewiGxAna26xBgbRjICS9SPjm5X6UgciRHUdXtvI+xFYamcKOTdQ2nYp
    2oOp1NA/+pjYvkkCfdLcFISWZFWks/hTu5IknLV8ZLIFwtYNAaSq4vamHGVbiAlUWBH3KK
    JbK/4zlQu42JI0P1w16XEycEh+62Xr+9vN7REGRMed5fIHBKjiueJ+Y+0iFIuWPsdUrfEr
    N5X4kx6Ruf2tRaqQQLX0JxtcNVIpXrJy2MGtXWYcMCDZPygkB4fx7yMEtBowm0hsB4yiK/
    AE6B/WmhythWjBmEJphH6PhY9zjJKeMOaHk57escXhkRU7batdZkMJngUqxcLpbPsq+cdW
    5C3WiNZsJxckoDbxjoF6SLma07nyjxgFbmFRPtJUpUgCrx/T3OCoHOFUgA1g
X-ME-Proxy: <xmx:9g5MarDxifhiK4CABqRcgebsDUlajvk2uwWRUcqeO2HuVUiLMKUiYg>
    <xmx:9g5MaoRY47Ii3ezknlqiMfCrWobkv1acIg_lf1lsEtKKDPC3vBlOlQ>
    <xmx:9g5MaoUot7DdwcjWqDUu4fyt1OzMC_RYYqal2WuVHAt6LKtVHHUTuw>
    <xmx:9g5MapeTHQSsfIzpp5gE0eNsu1cvnkSB_2ywBLdWhT9bk8zrE8mHYA>
    <xmx:9w5MasJAkdUiPVLNDY2awcOrZlxeXKs9in7q69fV1IMsrBIzTedA4C4P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 16:24:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Jeff King <peff@peff.net>,  Trevor Gross <tg@trevorgross.com>,
  git@vger.kernel.org,  Stefan Haller <lists@haller-berlin.de>,  Derrick
 Stolee <stolee@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: introduce `pick -x` to add "cherry picked
 from commit ..."
In-Reply-To: <5d238e0d-18ba-429a-a9a4-a3988b00e1e1@gmail.com> (Phillip Wood's
	message of "Mon, 6 Jul 2026 11:08:18 +0100")
References: <20260705140931.98262-2-tg@trevorgross.com>
	<20260706002415.GC2301945@coredump.intra.peff.net>
	<5d238e0d-18ba-429a-a9a4-a3988b00e1e1@gmail.com>
Date: Mon, 06 Jul 2026 13:24:21 -0700
Message-ID: <xmqqcxwzamtm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Usually a rebase is about rewriting the commits on a new base so that
>> you can throw away the old ones. And that's why git-rebase generally
>> rewrites the branch you're on, and replaces those old commits. So adding
>> a "cherry-picked from..." annotation doesn't make sense there; nobody
>> would have those old commits!
>
> Exactly

;-)  

Whew.  Briefly I wondered if I were the only one who felt 'rebase'
and 'cherry-pick' serve two different purposes and need to behave
differently, e.g., with respect to how notes on old commits are
dealt with.

> On a slight tangent I've sometimes wanted to be able to do
>
> 	git cherry-pick --exec 'make test' some commits

Yes, I agree that is something quite handy.

Thanks.
