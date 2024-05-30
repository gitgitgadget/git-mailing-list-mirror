Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B21EA8D
	for <git@vger.kernel.org>; Thu, 30 May 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084497; cv=none; b=AX4FywfdZXdhaEdsBnskRwUSBnWXJO23uCfperjH47R0xcVt/6LI5hD+plUwQrP6yUJGGGSfmDQGHRTWZ/twe92+/A3X58YPMCEIKUOfGfh7pr5/t+0bwAvTDwuKwmOZ5opbi8qasN7F5p0gafXB5kEjjBP0SV+gCSvO8u9RAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084497; c=relaxed/simple;
	bh=aKQPkl/A6HAqc0FgF8zRF1Y1KOkAC6B0PHrnxAzH48E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ihM3bUCMlj2Np3ZvSDlxacGihqIohcb/DfIKhYcYtMbdL50s/I8rD0BCPiu2k+PQq84OM5mGv/jUMKo9s/gdzGfaW7we75+xsTzk7uQsLRwi17u8MmXLx2Sq/tQQdFh4597PGuFxii6RHTcjWpgjP7QYskw3JARjwpVRZZoiN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bjg03cGj; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bjg03cGj"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CF9D13A27D;
	Thu, 30 May 2024 11:54:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aKQPkl/A6HAqc0FgF8zRF1Y1KOkAC6B0PHrnxA
	zH48E=; b=bjg03cGjplSxd7S/ODsWlFwhFbza66tYRsuWkcPDGdwJpYXyolGuk+
	LtZ9oO4lTIOO7D/hkyevpBC8bWfrBZa9vImCapaRxaVSo0FXa5hlCsUsYQdg8xdI
	nmOBqesPYjd8ppTctiLoPFJM2PaVe487yBnGxgEf6xsjJrFwlvARg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C7B0C3A27C;
	Thu, 30 May 2024 11:54:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6D5B3A279;
	Thu, 30 May 2024 11:54:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t/: migrate helper/test-example-decorate to the
 unit testing framework
In-Reply-To: <tubjmjeczh6iigem32ulffvt2ucpygbm4frsr3jsps5tv2i7v5@ly3wge23zn6f>
	(Ghanshyam Thakkar's message of "Thu, 30 May 2024 14:09:09 +0530")
References: <20240528125837.31090-1-shyamthakkar001@gmail.com>
	<xmqq8qzsuwh1.fsf@gitster.g>
	<CAP8UFD1YVyZj-uGfGXp6UxMfj3kZC5XXNed-5s-jj=ROx4URnA@mail.gmail.com>
	<tubjmjeczh6iigem32ulffvt2ucpygbm4frsr3jsps5tv2i7v5@ly3wge23zn6f>
Date: Thu, 30 May 2024 08:54:51 -0700
Message-ID: <xmqqjzjbqoqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F4073014-1E9C-11EF-9FDE-8F8B087618E4-77302942!pb-smtp21.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> The latter provides much more context (we almost don't have to open
> t-example-decorate.c file itself in some cases to know what failed)
> than the former. Now, of course we can add more test_msg()s to the
> former to improve, but I feel that this approach of splitting them
> provides and improves the information provided on stdout _without_
> adding any of my own test_msg()s. And I think that this is a good
> middleground between cluttering the stdout vs providing very little
> context while also remaining a faithful copy of the original.

If so, why stop at having four, each of which has more than one step
that could further be split?  What's the downside?

    Note: Here in this review, I am not necessarily suggesting the
    tests in this patch to be further split into greater number of
    smaller helper functions.  I am primarily interested in finding
    out what the unit test framework can further do to help unit
    tests written using it (i.e., like this patch).  If using
    finer-grained tests gives you better diagnosis, but if it is too
    cumbersome to separate the tests out further, is it because the
    framework is inadequate in some way?  How can we improve it?

Thanks.
