Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF61FC8
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762039053; cv=none; b=cQKc95vix4syU4dTGzcqdxlIiypFVS6Z3MT3NQwp1UPWWxSHcMCkz5JZPcbUe3HzTncZslL3kof+9ts3L+7zitHYyT2f8P21wAYS5Pcv9X45lTWrG7ovoekpep2HYi/HE4Nf2gBx/vrNFANFRLWteTIs/QBxCXXjgu2dwCo+imE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762039053; c=relaxed/simple;
	bh=P36gzth8JcBoxQnG473G5BiZoTgx2nWQ4U2jm/vKWaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOoDPrICCzdAH/GyRtri1pCyACCy2hyTHSFW+5jInzlds8frr0Yw0t2+GEeakIrkUP2YsAQlSk5urSInFxSdrQnBHzQIO+oX4H7eMiUJaH7mVOa8rpLrq6PnQaof7hgtQRdpZPGxbuj5jVcJT0/DYjk9UZoSPRyaXk0cEEDM/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f6Y1SoE7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CNbfALtc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f6Y1SoE7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CNbfALtc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9793B1D001B7;
	Sat,  1 Nov 2025 19:17:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 01 Nov 2025 19:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762039049; x=1762125449; bh=SkfzT0BEJS
	0wM1FRfEIVdHrU6m1svVTQxuMZJTxMF18=; b=f6Y1SoE7GYee4tcUtjOYRVh5RS
	74w8Wk2J3PPIGcwV+75uVCXSUdcvVPmtatGNBH8eg01gMapANVoNVK88RichfZMT
	3PAvYF3ztUNnabHngy4gasOPokT7nktBF2KdbaOrxEf+QJKX9CYPhGSS7vrpNI4n
	hTZz1Ossc6VS/e5DyMP8n4q5mnfwxrxVE3BFib+nN2FevRuCzd6s8Zdyy4NM5liP
	zP4Ue9TfMBihb6gG38NzhSzv+qi2zOWR07guhwTZl0jXmQU2omIJr8mDix2h84eW
	68yAGSULTMbQ/H6m9p2ZZbh/fszwjGpE9jiZOnw7sJNhhSAQeKXZe9sgAGmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762039049; x=1762125449; bh=SkfzT0BEJS0wM1FRfEIVdHrU6m1svVTQxuM
	ZJTxMF18=; b=CNbfALtc2A/1lNJi+8ArbUbzUWftmXX9T6ExH+bXof2nI+JT/B/
	DNqKAcPeww4vjgxxzWKdNIndMbXaTtFKtdY7adx+6ddCrZSX2I1izyipf+LR5F0t
	5lXAGg+Xqrvmk9xdIaJOEhDXwLJ566EDhYZ/pSJP6j/+CzLbe51yvjUWtSiD6Wuy
	OS/P3nwEWhvvvzk4fqQXzhUlrjEhx8v2nP6zb9uupADIIutUJ2uw8pgYJWsuhMgw
	/0eM0kluhSGlwNFEwcXk8qpofgp22OKIrxJr7xmK02stPH5i2eKSxjL7zU3ERr3Z
	+UOj80nA21QtzW5REuNxwe3TiOv8cwFrAIw==
X-ME-Sender: <xms:CZUGae72T-oVhDEghwKBzskw6PPUSsW_4H2tQaDyxN9SFgGhoH6GEQ>
    <xme:CZUGafXuH1XH0yuNU-oYOBqyOKe0ekxHfsfxnQUyk8U5aw7Wi4EsKwhsIMjcenwP9
    -hpFh984utQdng2VnY7DPyHnONB-rPBCf_RTe_NMo4k4nCv_-X-SA>
X-ME-Received: <xmr:CZUGaa3kouNhEbKqA39YJZGB-yAkKDBrtZi8b4xCPlwNyki9LA1uUQW_2OifGQBczI40dBlRzdoDA6ltSycHIIRfaWZtF6WGXGFR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeefieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqjhgvshhs
    rgeiiedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CZUGaU1PFQS5oeYOsED6UwU0mJG1bs-7nUafgET9mRYIkJbnu0OFyw>
    <xmx:CZUGaV9try1BM_EV7paRtICcQvK_nlu3073diwpuNfaC3A7cAA4BJQ>
    <xmx:CZUGaZ1sGlAcvXekIhJ6PG-irriSFwEf_zEaFJLNCLzod--QqO7DWw>
    <xmx:CZUGaa9WZI30H5MvcNVn4AmcbaLBN6Oqvh0SwLUahVjGEGehcdbW1w>
    <xmx:CZUGaXX93MI9CjRAPopbRlL7gHHmiGOwrmmolVFFtdQTDw-3dx_gv79f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Nov 2025 19:17:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: QueenJcloud <qjessa662@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitprotocol-http: document invalid 'want' error handling
In-Reply-To: <20251101161513.1794-1-qjessa662@gmail.com> (QueenJcloud's
	message of "Sat, 1 Nov 2025 17:15:12 +0100")
References: <20251101161513.1794-1-qjessa662@gmail.com>
Date: Sat, 01 Nov 2025 16:17:27 -0700
Message-ID: <xmqqwm49wdfc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

QueenJcloud <qjessa662@gmail.com> writes:

In the header part of this e-mail, we see this name/address

> From: QueenJcloud <qjessa662@gmail.com>

which I know from the past exchange is different from what you want
to be known as to this community (you have your preferred identity
on the Signed-off-by: line we see below).  In such a case, you can
do one of two things.

 * Fix your mail client program so that it places your preferred
   identity on the "From:" header; or

 * Start the body of your message with an extra "in-body header",
   i.e. "From: Queen Ediri Jessa <qjessa662@gmail.com>", and a blank
   line to separate the in-body header from the body of the message.

The former may be preferable, as you'd need to do so only once.

> Add documentation to describe how the server responds when a client sends an
> invalid 'want' line during the HTTP protocol exchange. This helps clarify the
> behavior of Git when handling malformed or unknown object requests, and
> ensures developers understand how such errors are reported.

Is it describing what happens to be the behaviour of one
implementation (namely, ours), or do all server implementations give
identical error message?  Back when the TODO: comment was written
and back when there weren't other reimplementations of Git, by
definition the error message our implementation give would have been
the only official one.  But now, it is way too late to declare "here
is what our implementation gives out, so everybody else must do the
same or they are in error".  We'd need to clarify what the intention
of this update is in this part of the proposed log message,
something like "HTTP server implementation of git-core and jGit give
different messages but since their messages share this and that
characteristics, which is something any reasonable reimplementations
of Git would sharee, specify that as the requirement here" (I am not
claiming that it was what you did to come up with this patch and
what you want the text of the patch to be taken as; I am just giving
a rough illustration of the level of detail expected in the proposed
log message to explain what backs the new text in the documentation
and how seriously the server implementors need to take it).

>  If any "want" object is not reachable, send an error:
> +When the client sends an invalid `want` line, the server responds with an
> +appropriate error message indicating the invalid object request. This ensures
> +the client can detect and handle protocol violations gracefully.
> +
> +For example, a malformed or unknown object hash in a `want` command will result
> +in a response similar to:
> +
> +    error invalid 'want' <object-id>
> +
> +This helps maintain clear communication between client and server during
> +fetch operations.

I am not sure if the additional information given here is worth this
many number of lines.  Wouldn't something like this

	If any "want" object is not reachable, send an error message
	that includes the offending object name to help the client
	diagnose which "want" command was the bad one.

tell the same thing more concisely and clearly?

Thanks.
