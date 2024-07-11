Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDCB16D321
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727726; cv=none; b=DNFUjsdr+8hBUyDBmOMka5AH4CR9DKFhAXlS5zVpv+iuelPoQ26V/otw+bWSj/Jp+hk0WNYoHpHKF0Bu9hMMWZyMdNJqf8kphF9I4dnaTS7VKzoPN13Lm1oWM0ueVbcsb3mBUofh77+MvzbA1r6j+bhQv6OqhCj1zetNm8SsvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727726; c=relaxed/simple;
	bh=n8CDP+GTioF6x9cHexlw8sBNas3sqL3YKJrue4vZ65A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uE2WuuIqJOHKkeH52UB8BjF6OLyF8+K8PjzgQSN/P04Ce+W+bkchk17ebnzQu4qG5uNE03YkV8OaKDL6NMCjLDODTG3uGl515uhdyBwtNweYw5weL9C4hcPQOSCVU4hg9YOyy3oWW17dvfqYml6oWa0oCtcHEae4nspunQj5QDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OK8b9ZEe; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OK8b9ZEe"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 17E5219C31;
	Thu, 11 Jul 2024 15:55:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n8CDP+GTioF6x9cHexlw8sBNas3sqL3YKJrue4
	vZ65A=; b=OK8b9ZEexv5Img3eU3lYM9hxLWX1TMTnxDP06JgNzrM6e1a9d5qH1n
	0XklVPkOY60DcKXioMAm4IjY1653b8EHjX4G8uHAF6jGd3oq7po5m7LCrXWZ/piX
	zDE49hHCmsMezXkzEQnvBKsIfmdeu2kYqLMj+ssmPi0/uuc2Eo3WA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F9F119C30;
	Thu, 11 Jul 2024 15:55:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2ABE619C2F;
	Thu, 11 Jul 2024 15:55:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Kyle Lippincott <spectral@google.com>,  git@vger.kernel.org,  "Randall
 S. Becker" <rsbecker@nexbridge.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Documentation: add platform support policy
In-Reply-To: <xmqq34ofsoti.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	11 Jul 2024 12:36:57 -0700")
References: <20240709225042.2005233-1-emilyshaffer@google.com>
	<CAO_smVjZ7DSPdL+KYCm2mQ=q55XbEH7Vu_jLxkAa5WTcD9rq8A@mail.gmail.com>
	<CAJoAoZmo6ey1RAqgtM098LLLrdKODf2OYyV=YqyFH5VXiSB6RQ@mail.gmail.com>
	<xmqq34ofsoti.fsf@gitster.g>
Date: Thu, 11 Jul 2024 12:55:18 -0700
Message-ID: <xmqqv81br9eh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 80AD580C-3FBF-11EF-AA67-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <nasamuffin@google.com> writes:
>
>> ...but this seems harder to keep track of. Where are we remembering
>> these "due dates" and remembering to break them on purpose? I'm not
>> sure that there's a good way to enforce this.
>
> If you come up with a good way, let me know.  We have a few "test
> balloons" in the code base and a due date that allows us to say "now
> it is 18 months since this test balloon was raised, and nobody
> complained, so we can safely assume that all compilers that matter
> to users of this project support this language construct just fine"
> would be a wonderful thing to have.

Or, just set up a calendar reminder or an entry in an issue tracker
that are accessible publicly, only to ease the "keeping track of"
part?

As an open source public project, we would not want to depend too
heavily on a single vendor's offering for anything that is essential
to run the project, but as long as we make sure that:

 - the authoritative due date is in the commit log message that
   introduces something, e.g., "we add this limitation, which we
   will revisit and reconsider in 6 months", but

 - if any hosting, cloud, or any other service providers, be they
   commercial or run by volunteers, offer a way for us to make it
   easier to keep track of that authoritative due date established
   above, without additional strings attached, we may freely take
   it (in other words, we are not free-software-socialists against
   commercial services).

then the "reminder" part would not be something essential to run the
project, so ...
