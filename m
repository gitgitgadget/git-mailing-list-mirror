Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EA26FA6F
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774745092; cv=none; b=n/oop8UKlC4GTRtmlsfjn+MsTomRRChMLA1s/Q8UfQUsTmN4PXj67fjHX3yjxUpHTZeG+WDAv0/k1nrBe4MBRxNXSaBrqGr3ychgpBcDHgw3ameT2OfqUNuaAHdVKj3PcQSepOeND1OsIF0+sJ7Hsbxahqg5kw9P2lIhIVvf/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774745092; c=relaxed/simple;
	bh=uqQqw/FzAvfWEr3dTDEsizKX4MQDbtbncQ1EG7XVUtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QdGFMQg1I1atbqCMENS4l+q4b6xBtG9g1JX9xCWDAfPPZQ/Ch0X6XDdpNzd/66AtDzzEXJzmusBvEqb2oB0lU7d0T1wgx0wx+p/eED4AkrJSvlH6R5wpGXyInrYXQ8XC74nUTaTGDTIUu8eu3H8fUufyM8g5YbbTyQxd/4csaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SgObgFjd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KR1X06iN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SgObgFjd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KR1X06iN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 965F714001B4;
	Sat, 28 Mar 2026 20:44:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 28 Mar 2026 20:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774745090; x=1774831490; bh=S6TsotDPvq
	x+/YDRRZXMAzzS6mjLJ9wqtxbOg0MX3TY=; b=SgObgFjd7XGbT5uHEZ1tZ8wOQP
	jYK+yJtGZZmbtX+HJ/UKfJzDJgKhrPLqbBLC7ScyaXfDM0FA6lJq7L17/GauFgiX
	Ng2/aL7NKBHAAhhGC+zzUBbOuD4vWod65SyvTZHxsEESFsfD09KZKC5B3HhKbyQp
	xWsmfjjZ8Pucm9PiRnhJmxqjKdZFvV+lLPAUfk1xECgA05Hvj1SxOxieryiVQhnv
	y4wvJaMJnuxDgnt+jRyxz1K/gTi+4Q82dp6nZ/y/hXkb3AmVrFPJqgvS2+87VNuV
	+C5u5UiUJdeEuYLB92wNJfbBK6HWP4HC2/9fsLJKxUN5esnURpBx6AusYqGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774745090; x=1774831490; bh=S6TsotDPvqx+/YDRRZXMAzzS6mjLJ9wqtxb
	Og0MX3TY=; b=KR1X06iN1mk1vbRGJO4oc34A3ujXIQhxyhE7A/27wBkFMqB/HIg
	zl/ab7jvGIH37APYAtlKnJDpgP3BQeOwpfOZygM78x2T0eA9/FvnljdhkyLupIiO
	w7R8Ayswv5dHjeDZjvoLETswCEMTplLh7ncAGQL17w1KdfWYFhhjaVr3fE3KQVaI
	FgFT+4cHwA46JUWPV5Q27Wu7QDYioIyBt02RFlYfUusLPT1SO+WhlSpKBeL7YYDc
	bszGNU8XqbNOOw1Ql2MlZ/qmmqosDWdH0DDwl5FK45ivxCDDHxkrDeqbSbHDAWGX
	OVxkJCmsdE8zRuni6ocUnbiGI1JwjfPYclQ==
X-ME-Sender: <xms:AnbIac1SUUea8STv6Qxs5ULrQt_owxD-NQ-HHnDHZsSLkD3legwwUQ>
    <xme:AnbIaehm0jqlE1xI7dOggpaf3AWLfJ77ZgMdHQknw72SFDKpDpqiqW-bmD53gjDIU
    wJOlNrSqB30_IUgrV4lEoIIz-YRQdaQZvfDQ8Gp5INutHY-qEQ_9qA>
X-ME-Received: <xmr:AnbIaSRJaFb5fd-hFi1q9lw3Balee6xvaJJt2UEuisSAn6Y-L9KBDxDeCGNzioFSRFuUgWB6PorXVq1UTR9uCbIoHXzGAgKDGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeegieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephedvgfeiuefftdfftefgtdffiefgheffleekhfekieejffeiffdvuefgffek
    tddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdhiohenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehvihhkihhnghhttgegsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AnbIafj_FwrgYv-4XTM_sSaIN8Qf7Lin-VHUiKUcp2-xz3PgvZCEIg>
    <xmx:AnbIaS5IMk9okGAViM1e2BEJUcQy8QgAY5w3hw0JnjI2lahRHY_V_g>
    <xmx:AnbIacCQO14ndLNFlptWLyAH_8m4dWLumEa_YN1et2N-ds7ligcBmA>
    <xmx:AnbIaZYrPAKaVnXaN2vorQd6_HCQvSESQP_VRIewhYVGjqCUPHj8XQ>
    <xmx:AnbIaSjDhl00q4bYrQSow207rZH_CxoCoxgy43ms3_Fbn3SW_jWfJ0aP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Mar 2026 20:44:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 00/16] Microproject: avoid suppressing git's exit code
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com> (Trieu Huynh's
	message of "Sun, 29 Mar 2026 05:02:39 +0900")
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Date: Sat, 28 Mar 2026 17:44:48 -0700
Message-ID: <xmqqpl4nh3b3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Trieu Huynh <vikingtc4@gmail.com> writes:

> Piping git command output directly to subsequent command (eg. grep)
> hides the exit code of git behind the pipe.  A crash in git would go
> unnoticed because the shell only sees grep's exit code.
>
> This series extends the same fix to 16 more test files, following the
> approach introduced in t8003 [1] (redirect output to a temporary file,
> then use test_grep on that file).
>
> Note: t2206 is a special case -- some tests cd into a subdirectory
> that is itself a git repo and run 'git add .' on the whole working
> tree.  To prevent the temporary file from being accidentally staged,
> it is written as '../actual', outside the inner repo.
>
> Related-to: https://lore.kernel.org/git/20260328132955.172262-1-vikingtc4@gmail.com/T/#t
> See-also: https://lore.kernel.org/git/xmqq4im2sjnu.fsf@gitster.g/T/#t

See also https://git.github.io/General-Microproject-Information/#:~:text=Only%20ONE%20quality%20focused%20microproject%20per%20applicant

Thanks.
