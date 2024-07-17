Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33718EBF
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256835; cv=none; b=FKK1ZPbFHvBU7yM3/Y24Q3ODgZK834q3d7TAJbXi8WWa0B9v/ZrlsPcrpZLQrkOVPBTVMRN33vmMma7UhTQ879TADxIN4Y/p/GoNXeGz0BQk/0CCj/2+y2n3hshm84mbgf6V0wb5NUkCn2cfohycjVNSP68jHXufCmDgorizhLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256835; c=relaxed/simple;
	bh=rTGF/nmFOx2H1Uov7q+V49ibjPqqA6nFdMll1nznZQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UH1QZTiMVu+gFWLzVFLEK9KfvLJw9AOT1ykoEu5QZsHU3p3Xc2ZCTOCZcIwfJwdsMY0++L8BvGeG3UevNeigBFEE59dOtdwWd8szaZE2S4aKgmzbjAlLbZAWyHlpRh5hUoEaDZ4s9jGHJfDqvdhF2kt268HOvoTK9+dYbfcJQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LaiyOv2Z; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LaiyOv2Z"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 92055235A1;
	Wed, 17 Jul 2024 18:53:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rTGF/nmFOx2H1Uov7q+V49ibjPqqA6nFdMll1n
	znZQI=; b=LaiyOv2Z5jdlK6Rycd8qfVOrobszhjMCd+4VKt694oAi2PMJtBUMer
	8mJ72VdpbQGowwUAPnpj2E/cP5SYIlsdMn1HUwALmm8+tXy4GmL9Oiq0omTNJmoU
	9c/r4xFXWn9ZEivczwH1DzHzNj/So8P1HJzG4/cnt1kAjud1WRceQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 89871235A0;
	Wed, 17 Jul 2024 18:53:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11F752359D;
	Wed, 17 Jul 2024 18:53:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
In-Reply-To: <0e2c66ce-d870-4a03-a26e-a928183b9b2b@ramsayjones.plus.com>
	(Ramsay Jones's message of "Wed, 17 Jul 2024 23:36:46 +0100")
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
	<xmqqikx42c42.fsf@gitster.g>
	<9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
	<xmqqr0br26ok.fsf@gitster.g>
	<8dd1a2c7-5b9f-4e2f-9c5a-d5d5758714e2@ramsayjones.plus.com>
	<0e2c66ce-d870-4a03-a26e-a928183b9b2b@ramsayjones.plus.com>
Date: Wed, 17 Jul 2024 15:53:47 -0700
Message-ID: <xmqq5xt33a10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6E278CBE-448F-11EF-8D1D-C38742FD603B-77302942!pb-smtp20.pobox.com

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 17/07/2024 20:20, Ramsay Jones wrote:
> [snip]
>
>> (SP_EXTRA_FLAGS didn't exist then)
> This is absolute rubbish, of course! ;)
>
> I don't know what I was thinking, but I suspect I was thinking about
> the recent _APPEND variables - except they were only for CFLAGS and
> LDFLAGS! Ho Hum.
>
> Sorry about that.

That's OK.  So in short, with a separate SP_EXTRA_FLAGS with "-Wno-vla",
Luc's patch is a sufficient fix without any downsides, no?
