Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DE3ED11B
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691933; cv=none; b=AjmWfemDin9lTXJ2jaQ2b8dDhLY46PzfCDn0rXwHtuLx2Dc++ZLrz9W7FOBA2GSkUZja9XALA/D0URl0mBUI2uegdYFAnY3pHj+v3IrNJjMNWHaMtThI7vKrBgHBYA5GW5vJbpqkDy5Mt21iF874IykrRFIf0X6VcXpIl3pqEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691933; c=relaxed/simple;
	bh=PnkF5FBALAPwhS+85tS/+lTj2oDPEBFMedFbx1kTuis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YIM62ZELujAy63zYoxYSjAVKt7aZNOXYurUqnLd9rU8vcpyngrv7vcJQIxinSUvUUMjgKGZMklbYtPFGm4f+dNFurQ7EAi8ZIKypWF7Rc8NRwMyqeGEBUKyU1c8jYwoU6rHCzoDPP9ez8XjtWLkTfu1okWfS+WfoCd4m52//e8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uw5t9oFA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r3MisysA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uw5t9oFA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r3MisysA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 526791D0022F;
	Mon, 16 Mar 2026 16:12:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 16:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773691931; x=1773778331; bh=PnkF5FBALA
	PwhS+85tS/+lTj2oDPEBFMedFbx1kTuis=; b=Uw5t9oFAf7b7vrxm3be2OUpkxF
	raUsbHqaenyH0IY2oQ7dWllVQxaFT2VY9acZuKAQF0nfLMsCuFkk2pa8j9zyCL1s
	72iNzMT72aWfbFNr2+rC0iqzdxXcWzNvSHYAU0Qo22KLPImhXfBlATb7D9REcbgr
	0fQn9orQW4UupJP4J5kNmS3saKg9r53i9Hb7p6KuvAR6Uvfp/CA8LOjkXzBb2DzJ
	tslXpCNT1KM3BSNm0lRS+28G6sH/jWktcJXE5aML7LD6bxvgoHkFCETTUReVpVRK
	NqkTwRWYO+Llx4t28McVqWxJwS9qBCsUlPvK0tHt44Rkyl6R8+jxfPwW5iwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773691931; x=1773778331; bh=PnkF5FBALAPwhS+85tS/+lTj2oDPEBFMedF
	bx1kTuis=; b=r3MisysADF+bcfbfZBqfHIpy7S9wzGnV3I9t3wa5A0+DJeuAuOn
	G61liYVerJGHlzGa3H1kjafg/RjHiMYsRIhNVMi7vedXqwiN56WUuH4a+Jv45H7w
	NMuLNkmyo5z/b+zJwVeONk3LmKWF1+811obNF3NJ0UK0rit4YhkR99/fvTo2I41I
	ZTJQbiXeQM50jKDtC9cFQuuSI8UCEkoA/AnvD7Rw93gZjKALZnjb/WdZ0xmCfMN0
	DJuyvBsheau7xFtfsoTjf27cng6UDudI0xFFrTFdTYhxudE9+Xl2rqOcV0GEvses
	S0749j48e3UAw0REA+UmoF/GjFhv7YDWtow==
X-ME-Sender: <xms:G2S4aYzXMwyM7qWINZlK50SmDmJ5Bd2AXDELbcvsmYM0Qcl7tYgDtQ>
    <xme:G2S4aTRP-UVFXydqfHBwDJC0P98EQAhaFOp_qCA08K-KDm-N91rN_fUFVWrmWY_EP
    QT-YPzlQy_331sHk0M91tPL-C4r56O2AKg-NjpEwQ3un_mvzc_J2x8>
X-ME-Received: <xmr:G2S4afV-KVLr4iKqhQ-Q73E4WEU5lJ10GvFmpvyLQo1PIycXSDxE4AsyABUnkXq5PdR4PgHsdYugFDEK55FYs1oqq-jPd04caQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgvrhhrhiifrghnghdukeefseihrghhohhordgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:G2S4aVY6t5x2YCIUC2BaSyu92bdAPbZjQBuOzLAwHHg-xR_r5T6RcA>
    <xmx:G2S4aV1Q9mBd0prFktUF5DL3n0or77HgXQ2r-mg-8PdDpfLrWsYOzA>
    <xmx:G2S4aXgTZp92ixVxftystix2WwJbvlmT1zl-m814eeWE1WS7yidNQw>
    <xmx:G2S4aZYtfx5Bp317HS7N45dJhCGHbuyMaphz5SzldLkfUAKyiIq6eQ>
    <xmx:G2S4aZXc7YJFaTfcHGh1juumYWc7ACEpsJod9yp0NP3_244N0O40lhrT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 16:12:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jialong Wang <jerrywang183@yahoo.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [GSoC PATCH v2] apply: report the location of corrupt patches
In-Reply-To: <177368589341.86550.13587211475575359717.git-reply-v2-queue@yahoo.com>
	(Jialong Wang's message of "Mon, 16 Mar 2026 14:31:33 -0400")
References: <20260315231538.68586-1-jerrywang183@yahoo.com>
	<xmqq8qq6y4ql.fsf@gitster.g>
	<177368589341.86550.13587211475575359717.git-reply-v2-queue@yahoo.com>
Date: Mon, 16 Mar 2026 13:12:09 -0700
Message-ID: <xmqq8qbro7om.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jialong Wang <jerrywang183@yahoo.com> writes:

> Thanks for the review.
>
> I sent a v3 after CI exposed two existing tests that still expected the
> old error format; v3 only updates those tests and does not change the
> main logic further.
>
> The other line-number-only error sites you pointed out, such as
> find_header() and parse_git_diff_header(), make sense to address in a
> follow-up patch.

I do not mind marking these as #leftoverbits; v3 looked great.
Thanks.
