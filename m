Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08A38DD6
	for <git@vger.kernel.org>; Fri, 17 May 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966893; cv=none; b=MYFydEfdX6SPKF/Vu2JnfWwhpdztKAs65ShzZX4tbzmcF3AqSEQCZrmmcsCD80hiL2O50ifZJ7K9qDQwfKV9Uzxc+Kx1ZdVeXmu4xBuKMDYRFOJSThle+VVbOwG3rwnJY7XrUCBuH/OKWabXFylhRtHxBaH0b17pxvxgEfFhYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966893; c=relaxed/simple;
	bh=s7oC3shRPrIlUBEVuoHtPgNaYyFydOvUcMIbH6Tk7VU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CQ49HWxzERYag2kOlf1X66yQooLxds8vFR6xDEHahWd3euHwDV2NbB48aDZaiMIlCU9gBhcm62A3oT9UWWN7h3QlNDTV3D/QmTgoP+hU6Ayn9oP8Dl4CfytLyc1dNQl2FVOrR8MQAvznK6uI89UUTPI8yEFEfOG6dB9II4oG1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iAD9+sbr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iAD9+sbr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C16D29364;
	Fri, 17 May 2024 13:24:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s7oC3shRPrIlUBEVuoHtPgNaYyFydOvUcMIbH6
	Tk7VU=; b=iAD9+sbrgKZP1CjTg3wA4rVaWIAvix5frJzuA1CLXAP0vPxAUFdyB3
	kEEoioaVuIgQMmAHckWqLRClcNvGyZpf6a7e4bOo697fzqsd8u8/yHvWwVkcMiwx
	OPhlsCfYfLbTR17kX+Qw6cqdLWuSFI4xTyKvAa71UolK/7uD7eusE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4409D29363;
	Fri, 17 May 2024 13:24:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A86A729362;
	Fri, 17 May 2024 13:24:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2] SubmittingPatches: add section for iterating patches
In-Reply-To: <20240517122724.270706-1-knayak@gitlab.com> (Karthik Nayak's
	message of "Fri, 17 May 2024 14:27:24 +0200")
References: <20240514123039.1029081-1-knayak@gitlab.com>
	<20240517122724.270706-1-knayak@gitlab.com>
Date: Fri, 17 May 2024 10:24:38 -0700
Message-ID: <xmqq34qgjqqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5768ADB6-1472-11EF-AF20-25B3960A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> Add a section to explain how to work around other in-flight patches and
> how to navigate conflicts which arise as a series is being iterated.
> This provides the necessary steps that users can follow to reduce
> friction with other ongoing topics and also provides guidelines on how
> the users can also communicate this to the list efficiently.
>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>
> Changes from v1 include:
> 1. Removed ampersands in the example commands.
> 2. Fixed grammar in commit message and text. 

Thanks, looking good.

Will queue.
