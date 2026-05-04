Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698C21257E
	for <git@vger.kernel.org>; Mon,  4 May 2026 05:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777871392; cv=none; b=d8qwpHWRaSF+1UYnuHX8iyQNOFIXy7hSta1pRTNpjvxnrNnZWKSZhNEeLN2g/jsRVp+RHMjHeV7R6KsK4MFUa2PGwFWfbcSxzpMJoc8a3pROzzZI5InE0R7WQhgiJ2vInezKQkX+6PT7ZCEfsAlRFageg+XjnBdQciIgdicI3Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777871392; c=relaxed/simple;
	bh=YLWD6B89dRSeU1v2UxRORPLkQBBMI4WvCvkDDkfOujc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L76Pn3kEMlpFjeBTV1SCrnOMTk3mIVJCDS1ODhmmK28tdJZIa9ya49GgpeIIEBKhMcWt8CxzMrwFi0rManMBotIHQdWuV9f09fZjdhnpYNlmEhEeroHVpH7WPf5AMS/FF9nSytG3p8oRGUWdD1N9Zy2Xq4LLOqFjvoH66tF8wkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Opq5ecat; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tIGwDOfc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Opq5ecat";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tIGwDOfc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E643B7A0038;
	Mon,  4 May 2026 01:09:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 04 May 2026 01:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777871388; x=1777957788; bh=TJO78jGE/I
	WXrZbhCEb/xZbM5lXGbzG434WCZx8FL2o=; b=Opq5ecatQAcCWrnjv5Q+H4KnPn
	t4KqzPOLZANZhrlgxaumF8s4nMLpym3WGcutczSJLNHtreJfgBnIsTiCyZFZ4U0h
	6XTiplJhQgykUMk5Hn3kc4qw/t3DvkC+27M+Puqu3qWAk70kD5ZUQRoWCSDAoQfm
	lFCqFHdM8lETJv8+fvV9w/VWRfu2Z8c0n9hV9bVyAMeuEjyG5tye08Ct89IChcK9
	xYMsopjzs9ZBMMQDnEqtAMDFW1nAjC5ievyQiDY33Wl7r8pi0uAn6rSEck3LM0Ta
	Qew9D08999SF/08G0S/h836ARv2g7JI9GSYTImS/J7IG4rY+wbNahvKu0DBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777871388; x=1777957788; bh=TJO78jGE/IWXrZbhCEb/xZbM5lXGbzG434W
	CZx8FL2o=; b=tIGwDOfc4wl7e6pDgIsQ11nrbzmUtzgvMdaN34n+ZWIOgvwysiR
	wJWXi3d8pLVjufyXWzbSYAW1L5vsbhGJlqMz7kDuVtDd50TVC9zDxKWplYH+luf2
	Rcd0i17xie3LYNAdWFmdtzjijrjrNdwGJMpCgTpWBpO2RA50ddMU8VjCohu8jjL1
	TJoetUp5u3C5KgSiPdFC+KtWXNQstAthMWOx+UfR2bgTHEgoDd6jkbsJcpyGe1eT
	b/QrlR+yf0TPSKhViqGsG4VAWNn9XQ8yX1jM3nmN1D24pW2SX2hftqcFsYy1YDFv
	N6INk7jnWnJJL5SrbbEfn952bkJL5tIsIaw==
X-ME-Sender: <xms:HCr4aVfvcQggCuLLeF_U8G3NqjkHeHTIedjPtpZpNmNsuGK6QDpH0w>
    <xme:HCr4aaPS7W7dJagZm54Q3Tt63lvgX68g7KZVMHL1mRBidQ8MYs-Zi-cif6Br43SRK
    L5nJ8zsKHYW2gmR0L9ZMc1zyO1PPM7Xr1aICwUa-MWmelkzp3djrQ>
X-ME-Received: <xmr:HCr4aTgvr9xLEyEuy3SP2P4yBiepvTo_tJpzGujaO-yZXZUHkjGKg4L-vMvQsGejsL5vN0wSym-xnXu1xMDeWy8j2RM_e6e2dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    iigrrhgrnhgurhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:HCr4ad14w0toUIha-xOqEHs5xgjjcKuyaKD8zi0X3PFmqeItiFmoHQ>
    <xmx:HCr4adg5zp9lnY7OkZTyK1-Su6Op2ODlk6ac4soPxFb41Yn4eD6aqg>
    <xmx:HCr4adf-fETC3bWgfZykfe9yYDdyyeZkMtvbnTmZ6oGOEaFFUB-nvA>
    <xmx:HCr4aQm_TF54w5sGUsumg-OdClqPWpadzCaQPYv6iaSNicPsON1Sjw>
    <xmx:HCr4aXCLOBZfNgSV_nsbZOAhfosW0NfvehpjtX382qbXC_kb05esc4Q1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 01:09:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Andrey Zarubin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Andrey Zarubin <zarandr@gmail.com>
Subject: Re: [PATCH] pretty: add diff-stat log placeholders
In-Reply-To: <pull.2284.git.git.1777578903593.gitgitgadget@gmail.com> (Andrey
	Zarubin via GitGitGadget's message of "Thu, 30 Apr 2026 19:55:03
	+0000")
References: <pull.2284.git.git.1777578903593.gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 14:09:47 +0900
Message-ID: <xmqqmryfpxpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andrey Zarubin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Andrey Zarubin <zarandr@gmail.com>
>
> Currently, users who want per-commit line/file change counts in
> a custom log format must post-process `git log --shortstat`
> output because the pretty formatter exposes no equivalent
> placeholders.
>
> Introduce `%(diff-stat:files)`, `%(diff-stat:insertions)`,
> `%(diff-stat:deletions)`, and `%(diff-stat:lines)`, computed
> from the same diffstat machinery as `--shortstat` and cached
> once per commit during format expansion.
>
> Short aliases are provided as `%aF`, `%aA`, and `%aR`. The
> requested `%aI` and `%aD` forms are unavailable because those
> names already expand to author dates, so use additions/removals
> mnemonics instead.
>
> When log output is already walking a diff, the formatter reuses
> the current diff queue. Otherwise it computes a private summary
> lazily, so formats without these placeholders still pay no diff
> cost.
>
> Signed-off-by: Andrey Zarubin <zarandr@gmail.com>
> ---
>     pretty: add diff-stat log placeholders

Personally I find this a bit on the other side of the line between
sensible and insanity.  Will we next be adding a new placeholder to
show the summary (i.e. list of created, deleted, and renamed paths)
and another placeholder to show the entire patch text?


