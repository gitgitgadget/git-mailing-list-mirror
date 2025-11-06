Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8C2FC03C
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460987; cv=none; b=lsTrrBk0En7WaBlOMuveJoBLv36+wcElvMd0vI/KsrikJC0iEYpgNhnx0D9GN4nYQCui/Tsy++XHN/2RbKIbz00K/G79r10rNVHaHj1GbCRfCE5qCnkrARYeIxM1bIhWJnjj1rn85NfKFKo63VhHtFokLQcSQIVkmnTRM3xHza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460987; c=relaxed/simple;
	bh=N4qbrW6jiCvRENUgeiJHeHCDZTqnxDrhwEiHccsHMSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nex0PhrVw/eiWLIFkOodDhHbRmuq5XbZxk09PuhWb1HyzFDficvKme6OMSIO/8lmZ38WCjKT5dNcYAVHz3rw54MnWx1d2tm2Nana3waQg+k+L5E5BmzoH0ZdMrNVLcgDuPd6Hjx66w96jDR/yGdSPgEYbIwTJf2PRZHHxDPmUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J4Vl//s9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6j6BTIe; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J4Vl//s9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6j6BTIe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B30D014000B0;
	Thu,  6 Nov 2025 15:29:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 06 Nov 2025 15:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762460983; x=1762547383; bh=anC1c2VkQu
	fG1ALMqTj5oaraitHQO5Tj/ECsR+ClZPw=; b=J4Vl//s9Yaoay6c9PKqgWeUFF9
	VoFoU/3zSMMgLzcvornBcM/SKymLLI3yHWNWl4sLAib4MoNZAgMQRqKbE5eDJSMQ
	7QEQ5RatSaBAQg4kEFjkwfNg1qcpoP/r+rlSu/wPdr84iHmY49LyM+AL9HdNXPku
	+2wz02VOuExznycZd9tX7x/pr6bdUoZsWQD2Q4j8PWpBbciDrethepXGFKy589v6
	VQeg6n32Odzb0vPfG8Iyx4cLv8xXjZ/ARgiBee9YrTkf8RUSW7gKZKgIvCzLE3RK
	T/8/jk162eh8bjKWz2dg/eJtnsgXgpbbDKHeamhUrvFLGnxlvEYnJSduvpww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762460983; x=1762547383; bh=anC1c2VkQufG1ALMqTj5oaraitHQO5Tj/EC
	sR+ClZPw=; b=Z6j6BTIepquBWdoGcHOdo8QMjf1mgLLSYxChJiLHWIsiklcYsUt
	BrZS1mlbc4fI7Z3OM0WNMcyHXAsSnSysSDuGKliNtG/yBKUBAy6M2jRSQJZDedvq
	fGe+/lcDAcH2XyuTERCmvq11hnMnRtb3Y8RuMhj9qiWMkVCLu9V+/RIR0/PmlrtF
	jAr9X9L8iLqRhrR9C/XsTGoZSQVsraRwg53KmdFN4e2VtdhQp2p5znPGpPFxE490
	Z69MDxCK9Vi/jjXkEIuAJl/F64d2oq91+j2j8mLPBsdhQGohcijBrVcejp7tq12K
	GlkvcD965qxhYfkWNnLdVC8R6B6tw5juB3Q==
X-ME-Sender: <xms:NwUNaUmhyM0Ap1mYZiKuJYgsHODYVEYyqKmMq8xhWBQGZUFLj64ZUQ>
    <xme:NwUNaXiDEdQZ7HPIj502GKLz9priSCiZTn2cAJGUqumu_mpp_WbItkOIshbzBIBfi
    YDzKv5GyjeYRUuqyH-l5K4L9MTv5PdPv05rN4Gar_-FRtHh21OLHA>
X-ME-Received: <xmr:NwUNacck9pKtb6aEBAgSD6dVuXvZ4Lz81rQtgZAWDW7EZ9H1ahBiWrM-I-j6pCn2OJxAN85AEzLKXVsEXUzMUhcpgcI2kXRXbdCZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnthhonhhinhesuggvlhhp
    vghutghhrdgvuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NwUNaXjiORVEtZleqlqzPIS6gLgVqVv1IjcXmuXf2VuR3xZ9-H_EOg>
    <xmx:NwUNaUwMM0imNnwwr-ugG6T9cXPeC-s_SzL7ZK3d_OEkGxhPibWDRA>
    <xmx:NwUNaTOjCGhN9M5DmM3kRoreKn9i78nA6I3ifUUC5TzABIGP_2ynCA>
    <xmx:NwUNaVXFWclG83PpVmYTN20o5DgNQlSxDfTdbFnU-dxCptOBLWxw-w>
    <xmx:NwUNaVp-bh9_-9OdVR4EdYvb7iiz-m80c_VpCNc0OgwYkI0XPI23u-00>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 15:29:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Antonin Delpeuch
 <antonin@delpeuch.eu>
Subject: Re: [PATCH v4 2/2] blame: make diff algorithm configurable
In-Reply-To: <xmqqh5vbum6k.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	03 Nov 2025 08:15:47 -0800")
References: <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
	<pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
	<920a6f3acbc86e72c6ea236f8dbd3d559398409a.1762034252.git.gitgitgadget@gmail.com>
	<d0bee2f2-106c-42cf-8101-c76bb54ee1ba@gmail.com>
	<xmqqh5vbum6k.fsf@gitster.g>
Date: Thu, 06 Nov 2025 12:29:41 -0800
Message-ID: <xmqqo6pehpl6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> One thing I'd not thought about before was the interaction between 
>> "--no-minimal" and "--diff-algorithm" The code above makes 
>> "--no-minimal" behave like "diff-algorithm=myers" which is consistent 
>> with the current behavior where the only options for the diff algorithm 
>> are "minimal" or "myers". An alternative would be for "--no-minimal" to 
>> just clear XDF_NEED_MINIMAL and behave like a no-op if it is given after 
>> "--diff-algorithm=patience" or "--diff-algorithm=histogram". I don't 
>> really have a strong preference either way.
>
> Good observation.
>
> In the longer term, I think we would be better off if we treated
> "minimal" just like "histogram" and "patience", in that
> ...
> other algorithms from the usual repertoire, the option "no-minimal"
> no longer makes sense.

Just to avoid confusion, the idea above to deprecate and kill
"--no-minimal" is totally outside of this topic to teach "git blame"
the "--diff-algorithm=<algo>" command line option.

I think in the shorter term I think it is OK for the implementation
to do whatever it happens to do when given "--no-minimal", and as
you observed, it is fine to behave like "--diff-algorithm=myers".
I also like your idea to hide --minimal with the OPT_HIDDEN bit.

Thanks.
