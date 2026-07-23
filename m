Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D77E3195FC
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850507; cv=none; b=AjO+60srS85YDYIb8z9I5N6wS6xw/y1OMsV7sNm+jvogHBKzUdhyJklxFItHz2M0sLJvVdoZuklLdUhrMC9Zkwds81QuC/mMuAAorngMTIg2vJ93wk3UkzlUYgU2j1YejfHg8WSbtQlHnNxULZ4Gz3GGc7e1cI4qKysvhFRWW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850507; c=relaxed/simple;
	bh=hbLfy8F2Zcl7jO/KqE84MWuQDyDZWGIIfYGBNqi0d0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dh/9GpqLBudcTmn5MFCujrNIXR4OWh8jV5E2gk08R0BUIOww+zvhvh9OhV4dwMNdhxh8AaOV78LqA9QV2nebXL203FXdVRIB++KTWDL3L7VrT3LX+FIeu4jmpUwHpAw9jo77TBlBxEx8gD639qnhHUdtPr8TOSgyoYSTvSdeX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fnbcPhMx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dhvw6T8w; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fnbcPhMx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dhvw6T8w"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E84691D00054;
	Thu, 23 Jul 2026 19:48:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 23 Jul 2026 19:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784850504; x=1784936904; bh=XmOi/fneYZ
	TT4nv3qoapUqj16H190OB2VMAUax29A20=; b=fnbcPhMxFbLOVK87ilHzC43Auh
	hg7PF585MYY66V6eD8KbxRiGrfGyQxVkJwwJcrVLf21V9dVMuqKM3Fk1MzpbMe2B
	LWcwYpXUGze3X/+Bgd0MQAB0GSMlv6GTnyuuE91FugmA1YUQO8OuYOuHwOwGVkLW
	bAzS5AMoKcwuvB/fgUtR6+0kr2bPm8bxm1CK3apA/u3psySdGUSRZlBwkO5FSzBl
	EKxqlSYa/sc8ODMe0dWLXuunJAqLUuowyUY1I+9Ajkk+/gM68d201965OkaGbKpQ
	qjAUtkFz2lGxqPtc0X8TgvrLr4BNMk25lRsV+cwDga9wimTp/fJciTOsNPFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784850504; x=1784936904; bh=XmOi/fneYZTT4nv3qoapUqj16H190OB2VMA
	Uax29A20=; b=Dhvw6T8woL6vCff2mfGmuL80ySmpNfAOfOQZW7F4vJT4pB3W88g
	gGn4I55rKemjUeoOwgiuYZncgdWa4Aj2to4T+6mkS4VqCjseLj8XbqI63DtqBy9n
	e3CynoTokGu0gP8YxTB+X6aAaqTGCCmNjxDJBL63JYN80ZGy8llfNO3uYdHth03G
	i19nvPOvEWqX5qeOi/rnJrDtl7IWEqH6WqClSPgsBuNcKXjxJEZfG0wT5f/Mm9KT
	t58KLu6g0mYdPrMEniP8Y2kWuQf1C9/GvVeK3TeQHWWhYyk6RSDhqeTx/IXWzPDX
	js4NVJysOjx5ItygPeAHM96AmQJy/mDLFuA==
X-ME-Sender: <xms:SKhiaiyttC3CmUFSLA_4pKd-ZoR8vvcwK-K-UWKu_L-4ZiEQMrgIWA>
    <xme:SKhialQEQvmghCDy6RTEfD6SA5N8R7YD9MjAaCkLEhRJ5KtGSeg4rjeVAZ6lQh6E5
    XJ2SR_PCZeshXpefa3bpleoV8mSTZTl4UYql1MesOjS7obKJ5K2Zg>
X-ME-Received: <xmr:SKhiapVdWbTPdy1xfDtaMJFr8Nd776NKuOPvZDo19111krq76Eo0gNPx-Fk_y_CHYlHGLcCXyw6iW59mH4MbfvgpXI8CEWpmrA>
X-ME-Proxy-Cause: dmFkZTGijOQ9Pkql4PtO+8YRnihD28H7ENSY1OQwcb+/Byf06PKmqw22/gqsWTK8Cw3IDK
    xSBvNQ8QwtMB9WTOOp07L0jaHPSnJ2y830V/NrnmEiMnoC7oxnOCSycNWCo3zbm7d+3TsJ
    spCKwgneuPjRNv17CwgQX9Nnb9XZ2mhjmb3WGhgvyJTHnj21a/aVVEHb6WARA0vMQ4kOss
    50dSlmAPmm4bu0df0zdr0ND9Ms7kj8EDn/EJz7BS5br1HDV/S/H1PmTrYiTJAU2jWYCJcm
    fp/aAGHl8M/JjUfpfSudKcdXI1JxmPl/neNCRFgWkucm2L3JUQ+2DPBhDjk6T5ARgJMcM3
    +DiIz/brAwSsmErnpHVZpwzQA2tW56s8YIGUGBglugzV+sKgmMtAr6J/3apZOv5hcDGKVG
    VV45pKblrT63lMs775wtNB3lJMtZcYpqlgXOae+JZdtzmMrvPAtO8A7GUubWHmtESkQy95
    oMhzbWmYmKqtwmNeBwgzGOedthRD9kiB7/G+JOQJ+ZAwUHrCzr+FrJLG763ECEzJxtgA8+
    MYqcJIVGMzKX0TlCGDW/mrX+P25e3Yfh/wqfD1pcNNIZLD3qpeHB8dVQRZ01vYMRYj5zJc
    CGswwgNXoSRqKNZOeBDQnoa9NcCBv+FWcCR70xL19uT+Z0XIyAKfVT3Oy31Q
X-ME-Proxy: <xmx:SKhianbEnGi7nCZLmgEJENApWfP41i1vtV5cs7Ms9UbqEHl-gDi3FA>
    <xmx:SKhiav3fSoE75vEcy-KZ-vIYnpvqxWMz82Qr3UnOVcLaE4oliIvU9A>
    <xmx:SKhiapj68IO65srPWqFfoc7_YjJ5FGjTyQBwo6r-h-Zh1R4JGZDhPA>
    <xmx:SKhiajZWygphZgStASYFhFEpV7Jr1d0zbquAapZ-KGp7R0X2IS36Cg>
    <xmx:SKhiag1wjJR5y4x1h5QVbedPR0l-bTtHuEFqDg1wRI_w_HHCnc3Aeyel>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 19:48:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Zakariyah Ali <zakariyahali100@gmail.com>
Subject: Re: [PATCH v3 0/2] completion: hide dotfiles for selected path
 completion
In-Reply-To: <pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
	(Zakariyah Ali via GitGitGadget's message of "Sat, 20 Jun 2026
	17:55:54 +0000")
References: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
	<pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 16:48:23 -0700
Message-ID: <xmqq4ihpclo8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The completion helper for index paths uses git ls-files rather than shell
> filename completion. As a result, leading-dot paths such as a tracked
> .gitignore were offered even when the user had not started the path with ..

I was reviewing the draft of the What's Cooking report and noticed  
that this topic is among a handful of stalled efforts going nowhere.

I think we are still waiting for a hopefully small and final update
(v4) to conclude this topic for close to a month, without any news.
Will we see an update anytime soon?  If not, let me mark the topic
to be discarded in my draft of the whats-cooking report.

Thanks.
