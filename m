Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A28A3FB3B
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654360; cv=none; b=uQ+DKMGM5tiDexg1iJh5Q+7w3+euQ9zs+2euEwEWiFRdmkIm1cazxYoGuswHeileAwfP3tBkiZJmaj+04b9UBe/CYeV4wZMjnBrid+NIBH9UQIfm5CaJ0jcy0pyc6UzXdUj5U9Lm5ulml6KXFn4yPtkKGBYzThhJ+zmDsNWFqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654360; c=relaxed/simple;
	bh=begEOI7f/m/R9vYym3nI2v66699lpOs1+nrapTOn/hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xe1S93rtdv5++19LUT+ZBA0cOnVmUjQmoHxpMdSANkvkbdoLoxa8bTpF4l9aGXY4s0WqV08S3ZQ+1ZXCteqADrIg8VvKPgpQ6DYM57TUO4alQ81jgzVofv+2GVzTaO+3FGwDCfcle1Gwt7gohO0EmyZVElzTmuiFAg5IdTAvbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k03UHXjX; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k03UHXjX"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DEC618899;
	Wed, 14 Aug 2024 12:52:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=begEOI7f/m/R9vYym3nI2v66699lpOs1+nrapT
	On/hc=; b=k03UHXjXjP8p4PkJM+etypDFJVQh5Ml8IpwvYsStlKMlv733zA6vfL
	9JiG80kuvGGEYynp45Vuoft+1c6lkJIn3mmmaXjcbwTzwJzav23YGqBCqAJkbVNJ
	s211Z1gsOZ+AwjPw56mh7dbA32iYYjYU8nOp5vlYp0FW/9gVkpIj0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1595718898;
	Wed, 14 Aug 2024 12:52:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D6E518897;
	Wed, 14 Aug 2024 12:52:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <christian.couder@gmail.com>,
  Christian Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v3] t: migrate t0110-urlmatch-normalization to the
 new framework
In-Reply-To: <20240814142057.94671-1-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Wed, 14 Aug 2024 19:50:46 +0530")
References: <20240813172432.55487-1-shyamthakkar001@gmail.com>
	<20240814142057.94671-1-shyamthakkar001@gmail.com>
Date: Wed, 14 Aug 2024 09:52:36 -0700
Message-ID: <xmqqa5hf11yj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9C77BBF0-5A5D-11EF-8142-9B0F950A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> And since we can construct strings with arbitrary bytes in C, let's
> also remove the test files which contain URLs with arbitrary bytes in
> the 't/t0110' directory and instead embed those URLs in the unit test
> code itself.

Yeah, that was what I meant to say.  As long as we do not have an
embedded NUL in these test pattern strings, "const char *" literals
are fine (and if we need to use embedded NUL, we'd need <ptr,len>).

Thanks.  Will queue.
