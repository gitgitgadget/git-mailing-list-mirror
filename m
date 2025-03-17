Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF962054E2
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252471; cv=none; b=jqjRGz75SXDRgRGCRuDzTv85HhvwW+1MjPp1OWEkTTj0QWh8pdQwq2OZ7s6Z5lxvE46aFKPyq//zu+nsEla6EvfuyQcMb1/1NOqMlGPvWSE3tcYEgQega0RoDO5IeO7N/6a0nxJ8GrxvgCdKvPS5f6BB7w3PbuO0FlKa1Ca7FKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252471; c=relaxed/simple;
	bh=khtaKfzVhSGR3VzM/Ryv7AscpphOzMF3BZVP160i4rc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DPQO8kmJ12ROgC+lmea9PhbbjVDf5qJSfTboh+YNunqxaTT/brlSVNqVCDLy0DSUO9J1b1HzI4wC8Nx61pGkJ86DFNKmduYCnSq/949lgnYuvtB2NN+rZP6iEtJXJMu41nvoKnQpslI90Wh5rwLFA60sTjpyhoxmm/b880rrDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NWWiMBfd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O87uiQur; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NWWiMBfd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O87uiQur"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BAD61140271;
	Mon, 17 Mar 2025 19:01:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 17 Mar 2025 19:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742252468; x=1742338868; bh=EUA3NI9sMH
	AQIE9+u9rgNvzmSdjNf8P04EbYLIXAUQc=; b=NWWiMBfd1hb5gjwM4vFPW+Yj2x
	//xdUcf6FvXGMPhycOG6mF+cqQmc/QzNGcSJBkZwDLPZ48TNvwiTx3nIGcaA8sNT
	IImkAtOnhqwxf2BZ+h4Jl+oFCyqkk7ro5jm7gR6McBlGIV+VFtTkk5E2ltivOlS+
	ghYt/TPR+YzuPS/Sa+hYwxdUdsXs4YEl7UkFXHbb/jWEHUqUYkJp9tmW/x2G0+hB
	dBykvWghukAjP1EcxNrX7qZXPvwRTZjeIbG3f879aX6ChRo/NjWkOaHPSnwGeq5U
	Uhgc/IPf8WQlEoKHwtMNfS3g7SJ+JLXr0bXjiA+Tw4twZJlHUK9G2jvVn6Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742252468; x=1742338868; bh=EUA3NI9sMHAQIE9+u9rgNvzmSdjNf8P04Eb
	YLIXAUQc=; b=O87uiQurwTMQ3w9VHZOr1Lga6JEAfr6ycTyaYaTwaM+bQboUefV
	WsNPdipKwusS9fDOjyQSmf8/QMlaBfYa7IGE0RQszndX1h8JzxumFHL8zy/mzLwb
	tkLr17qYjrkLIJo198cIf/lVq7o618pfzIKKa1KndiYvweYCDj8mndWwAv/Lx1/l
	71hj2KjQKw4c2lPuWqw1Nw7QNYFXmo65CE4mthAkcc4ef6IoGM6vbywd+oDiBJzv
	HkYjoGiXq4UBJypcRS0+2I5DRS6OYC6I3Z9VIoZa7DBOcdnQLxth3w7dHX8jPsmR
	8EW/7I5+YwfktyanBQvEySuRXQqW01S405Q==
X-ME-Sender: <xms:tKnYZ-R6DbfrMmg3KjQNXTmzIWcM_4Lhc6CqyVJM-87Gx3m_9opIDg>
    <xme:tKnYZzxHTFdHbvekFEK8PWTioKoY8KxQQEQTldiiPt5m1I6E3hQidfZdY-XWbIJmN
    aU_7jQWdICDcNNMfg>
X-ME-Received: <xmr:tKnYZ72UKl4-l3P1hH8qtbxkEGe8uLi5YjPz3CyBTd5k80mQpZViT4YyDjWK0wKG438qR6oIm_57lWKuAHfpL5-qIbSgqo88mvskG9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopedtheiihihtfedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:tKnYZ6CO4qLUh1Etl7hDUUtesyryttyOcxiG0lUiaWGkS34PAp-ooQ>
    <xmx:tKnYZ3g-Xl7LlJdC7zvaHS2itdT6QzI-rI7QkPnwrox5hZuI2eNjgg>
    <xmx:tKnYZ2oFxwGoRT_bYxXSaWiwpLAMd9SLVU0GQJLLCbHJlCGpX8wuPg>
    <xmx:tKnYZ6gb8OyZKX7or1KV2Glbi-1L8n5WJauch3tVx8PJjdNxj9beYg>
    <xmx:tKnYZ0vu_lr02W99daYGW8mH1jxd9oUOfA2jhbRKMbNCPM0ld74PaACE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 19:01:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Zheng Yuting <05zyt30@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v4 0/2] smtp_auth_maybe: unified error capture and
 status code processing optimization
In-Reply-To: <20250316050920.3264895-1-05ZYT30@gmail.com> (Zheng Yuting's
	message of "Sun, 16 Mar 2025 13:09:18 +0800")
References: <xmqqsengn1ms.fsf@gitster.g>
	<20250316050920.3264895-1-05ZYT30@gmail.com>
Date: Mon, 17 Mar 2025 16:01:06 -0700
Message-ID: <xmqq5xk76z4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zheng Yuting <05zyt30@gmail.com> writes:

> This v4 patch series includes two improvements:
>
> 1. Unified error capture:
> Consolidate exception handling within a single eval block by introducing
> local variables to store results and error states, thereby streamlining
> code structure and enabling future extensibility.
>
> 2. Status code processing optimization:
> After catching the authentication exception, parse the three-digit status
> code in the error message, For temporary errors (4yz), only print warnings
> and return success, while for permanent errors (5xx), return failure,
> Unrecognized status codes are treated as permanent errors by default.
>
> Zheng Yuting (2):
>   Unify capture of SMTP errors
>   Error handling for SMTP status codes

Give title your commits following the project convention
(Documentation/SubmittingPatches:summary-section).

I think these two can share "sendemail:" as their "<area>:" part.

	sendemail: capture errors in an eval {} block
	sendemail: finer-grained SMTP error handling

or something like that, perhaps.

For both patches, the usual way to compose a log message of this
project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.  I got an impression that at least your 1/2 it was
unclear which part was explaining the state before the patch and
which part was about the state after the patch.

Thanks.
