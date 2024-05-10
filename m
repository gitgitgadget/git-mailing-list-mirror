Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037DCFC0B
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374135; cv=none; b=bGkD/0p7SshU3ngxzGdErf+knrAuc8fm646JD06jDFSawhEqx4d/uxRBP/NjvZnqcNfZI+J+UUOVqwGOMGa9+xoNN5wv+cR0ngOp6P84/jYgjvzWANoqZV9Uqr0qpM/XVmlrf/yGle7yP3pOP+OlYx0g/oad9t1e1w6MzSlE76Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374135; c=relaxed/simple;
	bh=zPVZ8C91qCUEeQIRYlM4Kh+zWI4cxHQ/ehgTUn9zr9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j40uDLNuV2uZeKiM9V8eKvpTvkSdWDs0oqK8K/17Kn1Yxzl2Y1NqcbbIC3X1WBvEJ9if/K2Fn9B2riGINR2jmPEKdEW9K3B+g0HqnkDXIppnSfHTYY0Y+iJb66eKMN9Uxm/o+okUlpqSmgnHdigydzZy4cM4NWjVfBQ2wtV/+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RskAuMeB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RskAuMeB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A604926AED;
	Fri, 10 May 2024 16:48:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zPVZ8C91qCUE
	eQIRYlM4Kh+zWI4cxHQ/ehgTUn9zr9s=; b=RskAuMeBH7ykrP0rsIHZg4CqolCx
	mQ1FUTbgce3KS5RtupnzzA/CtO0fxsLyZLcT1OWQhuq1qJ/pnm0Dy/8bbikEdCap
	p15AMEOjnbVcbZbO32E986TVnb1hYXIdtVeBgF0jYIgXOtIvc0oUu9+j1zH4CuK2
	iMkfySl2kCdK6oc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D3F826AEC;
	Fri, 10 May 2024 16:48:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0475C26AEB;
	Fri, 10 May 2024 16:48:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
In-Reply-To: <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
	(Kyle Lippincott's message of "Fri, 10 May 2024 13:32:15 -0700")
References: <20240509162219.GA1707955@coredump.intra.peff.net>
	<20240509162415.GB1708042@coredump.intra.peff.net>
	<CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
Date: Fri, 10 May 2024 13:48:50 -0700
Message-ID: <xmqqcypt4clp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B579861E-0F0E-11EF-8F7C-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Kyle Lippincott <spectral@google.com> writes:

> On Thu, May 9, 2024 at 9:24=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>>
>> On macOS, a bare "gcc" (without a version) will invoke a wrapper for
>> clang, not actual gcc. Even when gcc is installed via homebrew, that
>> only provides version-specific links in /usr/local/bin (like "gcc-13")=
,
>> and never a version-agnostic "gcc" wrapper.
>>
>> As far as I can tell, this has been the case for a long time, and this
>> osx-gcc job has largely been doing nothing.
>
> If it's been doing nothing (which I interpreted as "it's doing the
> same thing as osx-clang"), and we've not noticed any issues with that,
> do we need the job at all? Should we just rely on clang and not test
> with gcc on macOS, since it's not a compiler that's provided by the
> platform anymore?

A very tempting suggestion.  I do not see any problems with the
direction.

Thanks.
