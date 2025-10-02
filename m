Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E4199BC
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382395; cv=none; b=HpvIeTqMUOCPXeJoHIBWvPFJJpYa5Bkl/kmDF9T/xaH4ZQNe2Mtwjq+rmqmp+f4s2e6OpFRri5C9mkBTHo867Bee+RzFwe6eFiEc1B/hsGInW0WJDjkmTDFIpJTdJfk3ltB+8beKCaLiVacdp6a0JlXY0eU8RM5NnRwcMYoS+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382395; c=relaxed/simple;
	bh=Udtb2/5N+C7zh+mhyo7icJafc3AZhlPYue7StGYccgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QF3c8IcSkKU/WDxllrFpLLtfXYG28uCvOndtGUk2Ta1jwSckoPGCA2hvfos7/gVyyjNqFoe/1PNjVvBgXWcx70n6m604Ez3q3ErCq4oyqxMqq3Byfrikl/wOCaJinUkKVnxYCwnQMVmpSZFt6C7eD0MPLx8j7/jRBMioHpT/Lj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZLDC4hfA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yaf9uTJP; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZLDC4hfA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yaf9uTJP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C9801D00126;
	Thu,  2 Oct 2025 01:19:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 02 Oct 2025 01:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759382391; x=1759468791; bh=Mjc/f/3tVB
	P/6r9jJ8tqkl6fdWlgxAsKIShkQ4HplTQ=; b=ZLDC4hfAi4K7GHjdPTx7EWaXti
	Fz1HbrvYGpfsD6sIhuMNZHwVnEUY6Z+IhlI1YDDjkPc3U8yqFYhKAnmgJPcs9lZP
	+B0YbTfKJVqUznjGELMptSkBB6fN4pVX+YDtWvsc5dJrsmnmi8noTZdsMu2EQKcz
	uT1zAY9p58Dvo1+R/32QbohNIrXitZa5DBQvUpUUr6hZIP9+2H66imQYLdoykNS5
	oX4qYgDW/FyK6em/p87iWX0OLKj3dZPLytXFna9uXx/bV8hwSmv7hjFoRVkwHr1Y
	MkVYoAl666xv9DIEvK/CqlTK6e4echqzl1mcRoESa0DFBarm2/JAt97M6FbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759382391; x=1759468791; bh=Mjc/f/3tVBP/6r9jJ8tqkl6fdWlgxAsKISh
	kQ4HplTQ=; b=Yaf9uTJPizo66Kb7PYLF4pMgytWaDlOFu7bF2dDoDAEmfr2PbXI
	y9+6YCGIvE+HZOsLru16IoEbMKDB5F65nNbPoSOu5wi0CcwIxe0EO7RQY6W9RpV1
	rMe/nB/HAi8447CA2DTYL2PBUqeO6fFKqbjy2QsoJycSguYLmm+uLDcwL4trpOuH
	RG856H6KlnDCh8diRyJSFi19vfONKeDmjivuw393mUI48WFyB0QOhKxRQkT26egN
	qm+RP41Oyv94V41GjyyBXZXTghc6r9Orl7vIswPdd3zM0w19E5LnT0MN6TU5a4O7
	pGveXuDrrvGrBLckcBiV3a1BUX173WlIXQg==
X-ME-Sender: <xms:dgveaIiPHCcP7LoUh9Yo-onFP_yGf-0SWhE0eTfD_k963XHEuo9m9A>
    <xme:dgveaIdET0OHITRlvMQ7q_eDdYlozQSCuIIMFT2NN74QaIJvzCEBmCtEuN9dCaplH
    KhMCLCSspGi3_jiTAcDJCUoRRbM2XScP2T4daAHORRZjA5QWKOc9A>
X-ME-Received: <xmr:dgveaNd_Q1P4lStoaMFxGBoQV2UwaI44Xzop5Kkz07NPj93ezKgi9GZ7VrRuo6hoJnVTbYDQvwG883rLufODUf7Xw-F3rN9-y2pJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvnhhrihhq
    uhgvghhoghhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dgveaC8cl01TVcfxPcvTCIF4G33AZhcCxis7PjFBrtngGH-oD7jIoQ>
    <xmx:dgveaJm1XvQC-GNkVDq5xKbrHtgDGkSfblqYpFPZynv5hvO5d4VmRg>
    <xmx:dgveaE9JGEUE1WPKrcWCLaTBOnC8Dho9GAozsuy52IgDRsO2OKZ_Ig>
    <xmx:dgveaHk628EcJOPtj5zc6T07w_U1aZ6ENGMKbouW6IZUmH-w1oTABw>
    <xmx:dwveaIc9ptD6WCN0t4TI45xVHd7zKHhr12SOQsTXm9LGH6mYalLn8aLJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 01:19:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Henrique Soares <henriquegogo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: How mantainers check Git diffs and patches?
In-Reply-To: <aN3ozlH_pPnvdWPn@localhost> (Henrique Soares's message of "Wed,
	1 Oct 2025 23:51:58 -0300")
References: <aNygY8Cm7LEaBzV6@localhost> <xmqqh5wi3779.fsf@gitster.g>
	<aN3ozlH_pPnvdWPn@localhost>
Date: Wed, 01 Oct 2025 22:19:48 -0700
Message-ID: <xmqq5xcxzxqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Henrique Soares <henriquegogo@gmail.com> writes:

> On Wed, Oct 01, 2025 at 09:41:46AM -0700, Junio C Hamano wrote:
>> Patches are medium for reliable transmission.  Once you apply the
>> patch to your tree (perhaps giving it its own topic branch, perhaps
>> to a detached HEAD with the full intention that you will discard it
>> after you are done inspecting the change the patch brings in), you
>> can use any regular tools you use while developing and reviewing
>> your own code.
>
> It makes totally sense. So I suppose you avoid to review the code just
> checking the e-mail patch in e-mail client, but first applying locally
> and then check it in your code editor in a separate branch, worktree or
> whatever, then back to e-mail thread and comment the code, right?

The other way around.  With experience with the codebase, you'd
learn to tell if a small-looking patch is truly small and only need
the patch text to judge, would be helped if I have another window
and have the code that would be modified if I were to apply the
patch without actually applying, or its ramification is deep enough
that I better apply it before making the final decision.  For a
truly complex patch series I'd first apply them and then read with
"git log --reverse -p" with wider context (e.g., -W or -U8),
occasionally looking at the entire file at the step in question with
something like "git show HEAD~4:path/to/that/file".  It does not happen
all that often, but it is not so rare.
