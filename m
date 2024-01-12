Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254521641A
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NFXKxKbq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A37531E531A;
	Fri, 12 Jan 2024 16:47:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Dfd/HxfFx6ezLUrwvN//w0yebs0E4ye8HODOzp
	jFhzU=; b=NFXKxKbqAadVHBzzYkeFWKGX6w7QoC7t1IjproFgT9ToZx+mHrOey8
	n69PAgsE72+T7rJPf4lujsHOZV0kNm1jb7XbT+Mv7LzInBlgNf8sZTbsyN5FLYb7
	9kCyhA2P8MpkbbQhd1VCdZdaebrbBTLXZDPZCeG+I5WFrnvfzQuY8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 99B7B1E5319;
	Fri, 12 Jan 2024 16:47:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF4CA1E5318;
	Fri, 12 Jan 2024 16:47:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Jeff King <peff@peff.net>,  Linus Arver via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] strvec: use correct member name in comments
In-Reply-To: <owlyo7dqig1w.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Fri, 12 Jan 2024 10:04:43 -0800")
References: <pull.1640.git.1705043195997.gitgitgadget@gmail.com>
	<20240112074138.GH618729@coredump.intra.peff.net>
	<owlyo7dqig1w.fsf@fine.c.googlers.com>
Date: Fri, 12 Jan 2024 13:47:47 -0800
Message-ID: <xmqqjzoe8br0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3A82BD68-B194-11EE-B560-25B3960A682E-77302942!pb-smtp2.pobox.com

Linus Arver <linusa@google.com> writes:

> Side note: should we start naming the parameters in strvec.h? I would
> think that it wouldn't hurt at this point (as the API is pretty stable).
> If you think that's worth it, I could reroll to include that in this
> series (and also improve my commit message for this patch).

I am not sure if it adds more value to outweigh the cost of
churning.  When the meaning of the parameters are obvious only by
looking at their types, a prototype without parameter names is
easier to maintain, by allowing the parameters to be renamed only
once in the implementation.  When the meaning of parameters are not
obvious from their types, we do want them to be named so that you
only have to refer to the header files to know the argument order.

"void *calloc(size_t, size_t)" would not tell us if we should pass
the size of individual element or the number of elements first, and
writing "void *calloc(size_t nmemb, size_t size)" to make it more
obvious is a good idea.

On the other hand, "void *realloc(void *, size_t)" is sufficient to
tell us that we are passing a pointer as the first parameter and the
desired size as the second parameter, without them having any name.

Are there functions declared in strvec.h you have in mind that their
parameters are confusing and hard to guess what they mean?  

Thanks.
