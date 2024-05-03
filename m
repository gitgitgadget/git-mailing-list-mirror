Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE012B9C0
	for <git@vger.kernel.org>; Fri,  3 May 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748287; cv=none; b=MAFOrUGgfj+vTiWs5yKwRyC5w5R/fRv9erjr3L93wagBw6bbAQPvK74661ZvJqRaCCQN1rUlWzlrBFf9PmpqcJx+7TGXB7N1/aWlDh42uDF2rVHszwPnZRjNZepTpOBt5cS+Dkz4dNml18jSIwe4uFeNem/BgSF2EAj5W3gx5Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748287; c=relaxed/simple;
	bh=ls9ECDnxlSFInhHzcAqesBBK+3ww+d2FZNywxowOtJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8pglZZJOKDDVEdMTLtpKwHUfvan3cMydKoHrWStoRs4LgDySyKHFYGvAfBQ01ubSKiYL0znCD+3i6oCQQj+2LTDjmqDW/hl293xMIF9kMjOLWXF8miM8HgazmfwImIHKHyac0mBjnw67BYFdQsiT/9Ym1hFnffFDGwWgi1een8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=voDj/bWr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="voDj/bWr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0A792993A;
	Fri,  3 May 2024 10:57:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ls9ECDnxlSFInhHzcAqesBBK+3ww+d2FZNywxo
	wOtJI=; b=voDj/bWrYw5LO/hAhwu0HcywHB153hWivxW8wZwevxJnG+Vx5Cz6Rd
	T/T5kSS8+SAUBRtzgefIWOrpVHjd2ZBV8htnc6mQHFbcSuP6dUhe9PnsQr3ZFO3N
	4boq722BYtLFLRknXoBYVBx72ZyxBiEJUeXqIiqeWfEdA1MNXmPYE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8F3F29939;
	Fri,  3 May 2024 10:57:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A6A429938;
	Fri,  3 May 2024 10:57:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kang-Che Sung <explorer09@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: Combined diff format: Show all filenames by default?
In-Reply-To: <CADDzAfNz3R5yj1SdJYbBe0f8m3Sp-R+X6dRpYoJ8Foj6zijcDA@mail.gmail.com>
	(Kang-Che Sung's message of "Fri, 3 May 2024 10:06:37 +0800")
References: <CADDzAfNz3R5yj1SdJYbBe0f8m3Sp-R+X6dRpYoJ8Foj6zijcDA@mail.gmail.com>
Date: Fri, 03 May 2024 07:57:57 -0700
Message-ID: <xmqqmsp7aqoa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 878D9CBA-095D-11EF-A5AE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Kang-Che Sung <explorer09@gmail.com> writes:

> My reason for making it default:
> ...
> As the "combined diff" format is likely to last for a long time, it
> would be good for Git to set a right default for presenting this
> format.

As the format HAS ALREADY lasted for a long time since its
introduction in d8f4790e (diff-tree --cc: denser combined diff
output for a merge commit., 2006-01-24), it is too late to change
the default.

If a scripted use wants to parse out all the pathnames, it can write
the option on the command line just once in the script file and
forget about it.

For interactive use, the standard answer is "you can alias only for
yourself in ~/.git/config", but unfortunately, because the alias
works at the command level (e.g., an alias that allows "git lc" to
work as "git log --cc --combined-all-paths" can be written), an
optional behaviour like --combined-all-paths that is shared across a
family of commands (e.g., "log" and "show" both would benefit) is a
bit awkward to handle.  

I wonder if introducing an "aliases for options" mechanism would
improve the situation.  Take an otherwise unused character sequence,
say, cccc, and when you say "git <cmd> --cccc", pretend as if you
said "git <cmd> --cc --combined-all-paths" from the command line.

