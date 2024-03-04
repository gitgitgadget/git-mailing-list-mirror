Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7C3FB02
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572957; cv=none; b=Oddpz35dytIjKG8f4wP3ftXGtc79S7bFl6qitUpPaLdjIDZDPw430rRWgKtmUUZz2evcWwlOtoTy+vPFfXXMCSBd7ECp1eogCrp28pxiAwMUcxEHNpvgqFJJ7oFGEtSQx+BQdZuiURETiopYYhMzIt+5PYuVPD4gBi6U6+G+uzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572957; c=relaxed/simple;
	bh=gR9hLn35vuJNIfteWxtTCEnVVczU6slbA+5vFIbkGss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EyDYHS+0Yv7sHHK3PrSqGXWjcy8trttCPoB4mnfPmq0k4LGaoqZ4lDUdZ/ZG9R8ztKrBf442E+vdWFallDNmPyzYeBXIKa52qrBFZIuGk5ywC9OUPgClhKpAzAdniC7iFbGHzAcz3qb5HzywnQYlPjyQ2VWGAAgoRe0talXCgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lxLM0wnE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lxLM0wnE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A7D491CE701;
	Mon,  4 Mar 2024 12:22:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gR9hLn35vuJNIfteWxtTCEnVVczU6slbA+5vFI
	bkGss=; b=lxLM0wnETuUyUcFhx8VYtkogWq+80WZKo/9QiURBLOt8PMQI77fJib
	jkqIFEy8nBW/G39sWAgiBRyOncFI0d/6BjAY9cmTHd2WizNekXjFDR9hbVvJItWR
	x+qX6IZruKrwk4bdGeu41XuSSLFfnft/aoBP15AoZDEkyK4q8bLmE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A129A1CE6FF;
	Mon,  4 Mar 2024 12:22:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1679F1CE6FE;
	Mon,  4 Mar 2024 12:22:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/1] [PATCH] t9117: prefer test_path_* helper functions
In-Reply-To: <20240304095436.56399-2-shejialuo@gmail.com>
	(shejialuo@gmail.com's message of "Mon, 4 Mar 2024 17:54:36 +0800")
References: <20240301130334.135773-1-shejialuo@gmail.com>
	<20240304095436.56399-1-shejialuo@gmail.com>
	<20240304095436.56399-2-shejialuo@gmail.com>
Date: Mon, 04 Mar 2024 09:22:32 -0800
Message-ID: <xmqq7cihrjxj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C9FAE4A4-DA4B-11EE-8730-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> test -(e|d) does not provide a nice error message when we hit test
> failures, so use test_path_exists, test_path_is_dir instead.

OK.

>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---

Just for the next single-patch topic you'd work on, here below the
three-dash line is where you may mention what's different between
the previous iteration and this one, if you wanted to, instead of
having a separate cover-letter message.

>  t/t9117-git-svn-init-clone.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

The patch looks good to me.  Thanks (and thanks for all the
reviewers of the previous rounds).

