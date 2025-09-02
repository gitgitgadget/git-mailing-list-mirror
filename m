Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7F341662
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835427; cv=none; b=qQHP+kieUYcvVypeo9MQo0fZi4KuSIwRhF2STlqzOLqOu6lQFYp23Y1Rbg5XoLePEmzF3rRSLvM+QsFEmULrDDq4hiUDCfVmM/tNahVUeOzPHpC/VlTyEjw9jRE8NaaehkFndjodp0krMe5UO6NblscL7Q7W9cC55jiDtlxECa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835427; c=relaxed/simple;
	bh=erLurS3gC67D4Em25AvosJ99hrdVhDnVejUccpkiF6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSUEc8vkuiBDx6GugDkCFzt7X5ImcvQa02hR3WUwoziF2RJdyw81ef8gs7V7csMcJxoKVi7bydp36iFIY1RF5nR9/UG2CzjDwy49CVExSUbcUyXD0hw2FPdZt0DDTuhfzQdyCRtAfGj2hpAkFL2HXDcsgQmpOzkYv/ocRliUfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mpyGGdSY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ca/vIwRs; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mpyGGdSY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ca/vIwRs"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6268EEC0470;
	Tue,  2 Sep 2025 13:50:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 02 Sep 2025 13:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756835424; x=1756921824; bh=lji5OqiEIs
	MfDAV04zwhFFTaaUCJDtSIsAMZnhFrDjo=; b=mpyGGdSYXJfa9l6RxJP+lAEtxO
	+v+hTH16GGWJIv0+/3QpmEp72hgEmdq3t2yEsMgCDbu0agAHFGrvE/VF9nVbCrWQ
	2lWuZLyBQs+yeOiuSvqlRJajwJkJczryw+cGnVLYns4Qx5ZzI2U/cKy7Yt2SmOCa
	pwaOyDkN0bzjIyfKj+yrqXe2czJ3f0wV4S1Eh1unMnahnhz914Yodo016+UzV3in
	DzadShim5kGBGbbwQPgK+VL+IrQqq4zknTr+u5+1lL5u16jtJbrRbTK+c9cwGNWn
	wIjjQ36WAYjemgjY0p0CIRjI3PcZSHU5dvFYdNr0xVKSUeZ93Z9WXDhofJpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756835424; x=1756921824; bh=lji5OqiEIsMfDAV04zwhFFTaaUCJDtSIsAM
	ZnhFrDjo=; b=ca/vIwRswFvDBT0thBHv2msmqCp0SHu0TZiYAwjWeplOpx2Rt+A
	S5XXMpGyqrAbYed+6Z42d9w3wnJjyZeErW9pWwoL1hO8AVZXSkEwsRMvksO1j8qM
	xz5h4gseP0HIUUOCP4tjky4g4r+QnQMLKa8CJz/kqAnbETUDlbJYQdWhw0agPWEY
	c7xuPIjLTYs0JfSDjQeFBtp2l6yFnqrtVFvDXMFgXYxrhvDJZfy2BsTtfwm5wQrN
	yAHMZAIBsYKAG5KlpZKhI87lqw22IU+KCb/GZ8TWfxhkEtWRYowKJSVNXr16Womu
	VkAQkisP0zFyS8cofdnl9F6OFZq7AKkpxXA==
X-ME-Sender: <xms:YC63aEcj8SLCQ4pbxJMlN1MkM9zl3mBcocgH4jYDgb_ZupIEfyPWkQ>
    <xme:YC63aJfXT9JF9wIo4Ife_0gnoWSEdDpi0K-ato0OAFH8qI7QxUN3WjuMw-clND1Z9
    EzfEyS2Z_Csr048Xg>
X-ME-Received: <xmr:YC63aO_4ruGGqoAJm1BXEys0hsIjxKVfGTTbbeYNp2jB9cR0ibDSgFVt8LydmznQ-00YtK09645EmTqcZaQM981REAe_eMkDZ9dZgYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufe
    ejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghr
    sehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YC63aFkz3HNCuZp342aoAkR41O-iV8YnPY-OoCi55KYKLLzvj2ummg>
    <xmx:YC63aA9UgbmlP3Fpc6lalg-mG5DXbK6b4hi1nD6c7dfCMTLwuAT_aQ>
    <xmx:YC63aDlOPRszLp7HSROsdaqgj2S-loSmJucViM35YwO2brFVlgr-4Q>
    <xmx:YC63aN1EHJtGt1pW0UgqhCZ44ZEm6WR1fXacpwLjVH3npeINIsd4pQ>
    <xmx:YC63aFSfmuElo0UsCDfHVLiYDqdqFIoJYQU906eaerChk_kzNS5wA-0i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 13:50:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2025, #01; Tue, 2)
In-Reply-To: <017701dc1c2f$ec839800$c58ac800$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Tue, 2 Sep 2025 13:35:01 -0400")
References: <xmqqv7m0kd1a.fsf@gitster.g>
	<017701dc1c2f$ec839800$c58ac800$@nexbridge.com>
Date: Tue, 02 Sep 2025 10:50:22 -0700
Message-ID: <xmqqy0qwiw0x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On September 2, 2025 12:58 PM, Junio C Hamano wrote:
>...

Please please do trim your quotes.  You are asking your readers that
many many lines you left here are relevant and need to be read
before they respond to you, and I saw no relevance to topics you
interjected something, like ...

>>* lc/rebase-trailer (2025-08-03) 2 commits
>> - rebase: support --trailer
>> - trailer: append trailers in-process and drop the fork to
> `interpret-trailers`

... this.  Unfortunately I am not sure what you wanted to say by
saying `interpret-trailers` here.  Are you pointing out a typo and
giving a typofix or something?

>>* ag/send-email-imap-sent (2025-08-11) 2 commits
>> - send-email: enable copying emails to an IMAP folder without actually
> sending
>>them

Ditto.

>> - Merge branch 'ac/deglobal-sparse-variables' into
> ds/sparse-checkout-clean

Ditto.

I'll stop here.

Thanks.
