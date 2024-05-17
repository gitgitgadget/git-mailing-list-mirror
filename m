Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228CDB647
	for <git@vger.kernel.org>; Fri, 17 May 2024 03:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715917100; cv=none; b=mcdyw4XMHIqyHMxovmPqvMxOWQgbK0ZXH2Ttvj+Ssxx1Y5/A86ejFEhJQUyxdH58B6NM4X3pRBestAqo6AX4A9cgMQnEvsLFNTRbRRntOWWw9cY+R2/7m+UC3qFa4c5qMlLsZ6AZUGqqkDHugYjVU1PBVKuJJw2A4wa0yKuCvu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715917100; c=relaxed/simple;
	bh=rRUV9AtQVCTF4DVK/InEIkICbzttRU8eDJLW4WNJ99E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b6egxtdD+gNZcy1IciX+ZCoLD1CpCTmi7cX+eCtVkHcW1GAfzNilISu+RgXlVL5+uGkWPxR/EGeo93Vs2zGDhUk/TPun7JAkPiZgu5ga/ZuWe02aEq/EDDfr/9TWvF5r8ywRXergzrWuRF9QBk6GZHHucUdQdSaE52+jHy5euY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] diff: copies-harder support
In-Reply-To: <xmqq8r09u5u5.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 May 2024 08:36:18 -0700")
Organization: Gentoo
References: <20240311213928.1872437-1-sam@gentoo.org>
	<875xwr27le.fsf@gentoo.org> <87sezm1116.fsf@gentoo.org>
	<8734qihft5.fsf@gentoo.org> <xmqq8r09u5u5.fsf@gitster.g>
Date: Fri, 17 May 2024 04:38:15 +0100
Message-ID: <87r0e1f6qg.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sam James <sam@gentoo.org> writes:
>
>> ping - let me know if I need to do anything different. Thanks!
>>
>>>>
>>>>
>>>>>  Documentation/config/diff.txt   |  8 +++++---
>>>>>  Documentation/config/status.txt |  4 +++-
>>>>>  diff.c                          | 14 +++++++++++---
>>>>>  diff.h                          |  1 +
>>>>>  diffcore-rename.c               |  6 ++++--
>>>>>  merge-ort.c                     |  2 +-
>>>>>  merge-recursive.c               |  2 +-
>>>>>  7 files changed, 26 insertions(+), 11 deletions(-)
>
> Copies-harder is supported from the command line already.  We do not
> want a configuration variable for it.  diff.renames configuration
> was already a mistake enough.  Let's not pile on a new mistake on an
> old mistake that it is too late for us to take back.

Thanks for the reply. It's a shame that a conceptual NACK wasn't
delivered in v1 [0] though. Also, Elijah said a configuration option made
sense in v1 and you responded to him and didn't disagree, so I took it
as conceptually okay.

I'm aware of the command line option existing. It doesn't work well for
us because it's really only suitable for certain classes of repos where
you essentially *always* want it enabled (any ebuild repository), but
you don't otherwise given its speed and you may not even be
expecting many copies/renames elsewhere.

[0] https://lore.kernel.org/git/xmqq7cmu9s29.fsf@gitster.g/

>
> Thanks.

thanks,
sam
