Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D431355E
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419719; cv=none; b=Uv73/lDgJt4O+jag2AhZv4TZQjwkrFJjDAncPl8PKa8EnVghxKFE7PjXi99lTRX1Hkc94ZvAd3I1Ifp2tR7Ky2IlwSj7a3bx028jaIZ/bssGQDEvZjCAQM+MELCRD/pi7aT6manXGEtk9D4/QPFIfYcVJ2R3Rh5Qe8uxVFC1zsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419719; c=relaxed/simple;
	bh=aHz8zwVgyiJgzyC/3HROhoMO/uD2Q6cC0vxs7ZpPWkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSMjTHAW+nfP3mZIS3KR5O3q3QhPZR6lBkG6A1HHHt38KfjpUMHNLKmwW+cGeyZzKRsZYiWki5BihiTLl2a4Vepik6oVIH4bx5Ebt+hILOabEVBHns2PJOoQoYjbYA3KOBMhRnoiwqRLyvW4lp6hxrUx4w4Ye26Io9xkJt2JdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LLMRnBgX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UIFZ4Msg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LLMRnBgX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UIFZ4Msg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 30AC4EC01CA;
	Mon, 17 Nov 2025 17:48:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 17 Nov 2025 17:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763419716;
	 x=1763506116; bh=Qot/DrNmh+4Bm6gbXtqHgmSM0aB6wM29YG39xU3ItfM=; b=
	LLMRnBgXXQVRv9nLwwICNUu5sOGOrF4kTNr9UrF5SXdTfDQEls6Yt+KUmuOUt3+J
	bCTBRHgBCFJcmE7WlU0BBpVfczMjYjD86YxQguduUzqsypwxacgX934alBJCB0Ji
	K9MfTh/Opd0WOfpG0H6U/CEaDZB+doFeyoOCmX1kHCY2G0iAPQNzEQOPuvZFrdNB
	0TqXbVzw9YeEW6k3rRUDqqDRvHHC7nzT2rq+EXKCt2/o8rvjJ7gZrxCmNzgLU4nW
	XSz3HuOGV/VxTGMnOK6HC1R/WLlxlxGqnMw0/bhMHf8vVodTq8i1CqH+G7Ek6V9c
	FoagggSTd01dG9cbDUtvvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763419716; x=
	1763506116; bh=Qot/DrNmh+4Bm6gbXtqHgmSM0aB6wM29YG39xU3ItfM=; b=U
	IFZ4MsgPFmhhWWNMvDCER1XFbWwgRFsH1enXLePOhVQnlvzh3KOngRqncoVqAat3
	CFGXdGUneuuVYFSeNChbHCiYS1QFl1GCoPUvdz0HeP5lwZleZDmRB818O9FxQSpO
	nHatTDHm9QNduEpcaoiMpYKtKKV0ea0+ZpmdfGrRIpkZdlYOswXOGRD+N3t1uYmb
	rdJ0ZC6KdXCTRHX3U8xXL3SWLDUJj5bWgzdW4VB5dA7CVJk2ERUeLaWatXO1ACW5
	VtBb/BBXBXv1+BcwrKd81/AfBk8+HMvOfMsNlDs0YUKxUMeA+G2yK5h0xgYMGZZI
	DfVSHSz9qNHWnng1g2nmQ==
X-ME-Sender: <xms:RKYbaViOaVnX-0hOgy3Qm2NljP02A4MXB9bJf8BlAb5iltzcLJukkw>
    <xme:RKYbaRBsI9Rn0xwS5bTRkTuZun-JMvIa8yVzQf_dgPs4kl9qVP-WQmRQvPSfrhqX9
    yBQhjYxQotWLKVIHtAzTu8z0xdFPhXN8DhT9m4Cd01mTXqGX_9g>
X-ME-Received: <xmr:RKYbaaFw1RJCFi7_LoX6KMU8Qivm4IoFUqF0DRHPtVZaolwpgvc0USlm4XLupGBME-ePslsi19aBgIKBZfkXohSLr0EQjR9yd1Sa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RKYbaZKonRMhTqO7PZrsWvjWlB8HrYElLQQst-e9VzlpLOHBAxAhgw>
    <xmx:RKYbaeknba9QsPdDviMWdTcHn8cZLN--0vMdB_BtASq2uh5Vmbm82A>
    <xmx:RKYbaRSit-qCUnt_t0M1qCRWWRYeead0W7zRkDc2pg7zWmki79nWQQ>
    <xmx:RKYbaQIOKTaZVlY5sqFzjwTze1xNWHzcB4S45wM2TlAedGsRLVxOEQ>
    <xmx:RKYbaRlKLs0Rmh8X43cRhhHW86L3TYd0MHdzpQHxCvTtElrs1h0Mcm6o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 17:48:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #04; Fri, 14)
In-Reply-To: <a407a793-9636-42ea-afe8-1283b1e220b7@gmail.com> (Phillip Wood's
	message of "Mon, 17 Nov 2025 16:31:00 +0000")
References: <xmqqcy5kgsjk.fsf@gitster.g>
	<CALnO6CDCzNbYFC4BGmqC5bhou5rtie7K5OhR_cP1CXJfChim=A@mail.gmail.com>
	<a407a793-9636-42ea-afe8-1283b1e220b7@gmail.com>
Date: Mon, 17 Nov 2025 14:48:34 -0800
Message-ID: <xmqqo6p0gtrx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 15/11/2025 16:51, D. Ben Knoble wrote:
>> On Fri, Nov 14, 2025 at 5:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> * ps/history (2025-10-27) 12 commits
>>>   - builtin/history: implement "split" subcommand
>>>   - cache-tree: allow writing in-memory index as tree
>>>   - add-patch: add support for in-memory index patching
>>>   - add-patch: remove dependency on "add-interactive" subsystem
>>>   - add-patch: split out `struct interactive_options`
>>>   - add-patch: split out header from "add-interactive.h"
>>>   - builtin/history: implement "reword" subcommand
>>>   - builtin: add new "history" command
>>>   - replay: stop using `the_repository`
>>>   - replay: extract logic to pick commits
>>>   - wt-status: provide function to expose status for trees
>>>   - Merge branch 'sa/replay-atomic-ref-updates' into ps/history
>>>   (this branch uses sa/replay-atomic-ref-updates.)
>>>
>>>   "git history" history rewriting UI.
>>>
>>>   Comments?
>>>   source: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
>> 
>> But otherwise I generally am in favor of the idea and find it useful.
>
> I agree with this and I'm pleased it is reusing some of the internals of 
> "git replay" now. I've just reviewed the first half, I'll try and do the 
> rest sometime this week.

Thanks!
