Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DE179972
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497480; cv=none; b=cAKWOjsh6AJwCbLMr0c5O7ohQV1qjmT9OTk7wGTKOzpin52I3SMriWkrlqwRaMbhMgB8pzCVoqGZByK3f2+cRPLtqlkySUoqHGYpntoA9PoRMP8G/tbVKubvYvAw3dSdyb0IIO3uCGjcfBeXYrnHpMyrpuVRSEIqYEVcU7k4v88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497480; c=relaxed/simple;
	bh=5Qa4+AkGHxm9RMvfADRJqOQNrnEUiuzId6BJrbS3BrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iifV03A6EsXlJKUwK3ZyThPB6UpwrbyOym0aKGf8vDaCczvuU/yinlZIWtqpsNwnEMw2zW4Am3jjpXaehrxio6bHtHbG9Zn0Ik6GSliWBBtViXSdwG1CbQCmhaonBWxjnDL4NeWe/xjnA8WVl9JmkzGb38s28v/iSwo7LV+ejJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EyvYHVCa; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EyvYHVCa"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F128C39182;
	Tue, 30 Apr 2024 13:17:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5Qa4+AkGHxm9
	RMvfADRJqOQNrnEUiuzId6BJrbS3BrQ=; b=EyvYHVCa3UOR1GDO3j5TzYCd+iMD
	lGM3+6A9MWYIAU3eKLiLxIzYKguvZ6Q5SRRNzN9KLH3kHKX4NLp/3vipOAnCJ1uF
	9rdJEgcqeIU+zcM+Mch3iV7JDlrf3YX4PD5AolYgwV7KLbSjZCDryu6OwKDaRBRH
	URJ3fj4bCMgh9VQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E651139181;
	Tue, 30 Apr 2024 13:17:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5733039180;
	Tue, 30 Apr 2024 13:17:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Jeff King <peff@peff.net>,  Git List <git@vger.kernel.org>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
In-Reply-To: <90464326-0d0a-4cc6-84cd-eb1e5489a91a@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 30 Apr 2024 18:35:12 +0200")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
	<10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
	<xmqqfrv4ug3l.fsf@gitster.g>
	<20240430105256.GH1279403@coredump.intra.peff.net>
	<90464326-0d0a-4cc6-84cd-eb1e5489a91a@gmail.com>
Date: Tue, 30 Apr 2024 10:17:56 -0700
Message-ID: <xmqqedamrcqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 96935A64-0715-11EF-B923-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> Indeed. I had to read this several times to wonder why it was not a
>> mistake to leave the first fputs() but use vprintf() and puts() for th=
e
>> other two (for those just reading, the answer is that puts() prints an
>> extra newline, so we can only use it at the end).
>
> I did not know the details (or had happily forgotten them) but Junio
> ignoring my comments in [1] intrigued me :-).  A simple test would have
> been quick, but "man puts" was quicker;  my comments were not correct.

I thought you were suggesting to fold fputs()+putchar('\n') into
puts(), which is a change that does not break.  I didn't even know
that you were suggesting to make more changes that would break the
output.  After all, you said only "can be less explicit" without
saying which use of "stdout" you meant to make "less explicit" ;-).
