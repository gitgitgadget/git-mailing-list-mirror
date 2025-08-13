Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F3157493
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096160; cv=none; b=VMnzYwRiCbp7r+Jc8uZNTSxIJGzNHKZZhdJbtYIbZAlODjZq8/OMyXD152vgm3UrxsNlz81WgBNUZ0rYOJMUYazYz7acUuVzffPdCV0BSj6HEe4CVqYlwsb1IisFx7F+7hLH6JwTf+HJnzbB7wyEDxajkkdu3qXpmCQx2+VYqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096160; c=relaxed/simple;
	bh=DcCOw7IcuTyO2sN/pl115LvT0pTFEpKE5oMXxweEtlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m9iPOcwBtgFpOHi2fI+ixvy+ubQ1BwymuR4czPHGt0dgHw2jKAJW32VyewDsufTQEvmKaT8t9nX1xUlSivixwBdi0Q88ch0h+sA5SovuBoNY5bbSmYAYRgCCfMLBr7Phw4nqlvP/Afwv+WFbA5vRorRonF8hLCvTwuJDwhkVwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ga7kG112; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LBK+lLBU; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ga7kG112";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LBK+lLBU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 40E2F1D0007C;
	Wed, 13 Aug 2025 10:42:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 13 Aug 2025 10:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755096158;
	 x=1755182558; bh=VE1+Ak0s3aRCsDcxaJFn+XlteuqItq293lELPsZZmV8=; b=
	ga7kG112DMyMLjtSWsRl/Hn9B7iEXhjnbQHPryLREYCU/NEpqiX6uJs7ohKJTSox
	K5un8MnWzhLnraRD6m8icqsMeHsdfQVguqKtku1uyOvH2BiEr6QY/5HLu4TWQlvZ
	p7dDoj9xPOyvjEvUGoPu/ihDNzSDo1x8ZJilZnbcOLlVsvIQgANn8ieUEI5RIvXP
	cowjgsXsjg+9xjS1gtHRPSi/gyTG1hLeSJK2RIHc2jJT1baLC9+j4WIL2joFASB0
	jSzhlvlRBxpfl7YvXekzjIwerGtOe1sHaFIhqj1UOtuDnMouJpuJtOj2zTlDllbl
	aU4TYhUT/7+svbbR9PQyKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755096158; x=
	1755182558; bh=VE1+Ak0s3aRCsDcxaJFn+XlteuqItq293lELPsZZmV8=; b=L
	BK+lLBU/qHDVONQbpF3IGaA/qYfIukZdQzTpyJvXAFsl6XuxtpNgnyEQDZxsgh9v
	/XEV59Iis83LAukusYFsQG3dgVNH0u96pA7ZrLXxsdjciAdl7QEaajM9m2iBTkV1
	60ofcggEFOtzc4lOrMkp55J+ve99YpoM4CKXO4E7NLnD+WvAtdbw/CVLTPijOipd
	wxFOu7O4hLNGc/0bQN0mIjjU4rqkqhz0bCCoq85aJG22iGQUZFQGDnLlZEmj0qDc
	IdA0QIisHMH6WmPTZ9KQ+VJijJjQVH1AwkpphRlZ0JvHnXIPLxvqvgSMP/duYQ8v
	WBkbexQOpAhfBOK+HUgZQ==
X-ME-Sender: <xms:XaScaNlE0o6QntzdIVEhZn69KgN8LP86a4waCVo_wgNq2mEaNwmM2A>
    <xme:XaScaMFO7JN8Xd7lr1KhYt63cCRfY95dQRI3cG3XRUUSpLZlwPmLM7ZbuPLIjtL_e
    g6xX9PnVqjZjBR0Rw>
X-ME-Received: <xmr:XaScaNFxFSuQ9MZNggPrISkos3-3dJi8dHEz371fCynBbRbKaun-b_iKV1NVqb969ATaSIVZ2dMO07iQ80vyfdht9gIjf_rj_sXCEyE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughilhih
    rghnrdhprghlrghuiihovhesrggvghgvvgdrohhrghdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:XaScaJO3cDG-d_sc8xzxZRPYa_Zl2hsppLVxR-o6MD4G7GEWzgIjoA>
    <xmx:XaScaMG8ARLuQvp96uudqqzf0F-ca8qSbzYDvOnOxIm1AogJp2nrAw>
    <xmx:XaScaAPOEQjM9xvDO3qV6b10IDS-3bU9e5-J7_mFiSh5aUrP27eKKw>
    <xmx:XaScaN8pnlaBzvD2yNJHHe0iBhfZezCGCvehv1v2TWgwz6KiGNXsrg>
    <xmx:XqScaL26qTkm8bHa75pT_P3U6RFNKLRrVrxr4yVVIsr8xuITlu1Mvz1f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 10:42:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?=
 <dilyan.palauzov@aegee.org>
Cc: git@vger.kernel.org
Subject: Re: git diff shows twice =?utf-8?Q?=E2=80=9C=5C?= No newline at end
 of =?utf-8?Q?file=E2=80=9D?= - no need
 for repetition
In-Reply-To: <1b0d634286da16f32cd9faf541ee28c811d6c83f.camel@aegee.org>
	(=?utf-8?B?ItCU0LjQu9GP0L0g0J/QsNC70LDRg9C30L7QsiIncw==?= message of "Wed,
 13 Aug 2025 10:20:13
	+0300")
References: <1b0d634286da16f32cd9faf541ee28c811d6c83f.camel@aegee.org>
Date: Wed, 13 Aug 2025 07:42:36 -0700
Message-ID: <xmqq7bz7p9k3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Дилян Палаузов <dilyan.palauzov@aegee.org> writes:

> Hello,

[jc: please wrap long lines]

> when a file, which does not end in a new line, is modified, git
> diff shows twice the text “\ No newline at end of file”. As this
> piece of the file is not modified, I think git diff should print
> it once.

Perhaps "this piece of the file" is indeed modified.  In your
example, the file before the change had a line with ") }}" on it
without terminating newline at the end, and this piece of the file
is changed to a line with "}}" on it without terminating newline.
The first "\ No newline" belongs to (is a part of) the file before
the change and annotates something peculiar about that line, and the
second "\ No newline" belongs to (is a part of) the file after the
change.  If the line were complete before your change and you made
it incomplete while removing ") ", then the first "\ No newline"
would not have been in the output.  If you fixed the incomplete line
at the end of file by adding a newline at the end while you removing
") ", then the second "\ No newline" would not have been in the
output.  But in this case, I think you had it incomplete before the
change, and you did not fix it and the incompleteness of the line
remained after the change, so "diff" should mark both line before
and after the change incomplete with "\ No newline" marker.

> -) }}
> \ No newline at end of file
> +}}
> \ No newline at end of file
