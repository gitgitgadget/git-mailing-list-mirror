Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E8199EA0
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507439; cv=none; b=lKbL9samyH4EuBwNNnWYgIqlMc1HEHL59vQSJijbLoEBvCZPkZIZUAfrpdvFcxMOXhwfCK/UP/QZfLuJB6iq95S1XnaDiQ4vezp8s3MtQ60XGro8Ubg5fXwFO24KVhg8mGon9gcnD2oMroIXoX+XkzNmA1+44y14Rm4JqAOz0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507439; c=relaxed/simple;
	bh=kU6RN5L3f9BR0cMq/I1zpq0LmYek0R2+ZdZEG6HEr50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oAibj9w5V1twyhiaqL2IilHwUTDNkaZVyYj5YfrToB9U075a6d+2UWYVLjOszfO7SgVI958YLvRBdvYLWKZ3qhPSBwXti7b0QwcgV/9sTulAkg2gQaX5XGCRTvWnqm7kPDA/gZf6biA3iCBaLCCpiZeHprM7OZOCAVr//0oISlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=evfOZkao; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="evfOZkao"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C0D8C20D1C;
	Tue, 30 Apr 2024 16:03:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kU6RN5L3f9BR0cMq/I1zpq0LmYek0R2+ZdZEG6
	HEr50=; b=evfOZkaoBMPuWO+4qckd8OhcqHq+Pjua0MECjaPF1bKGBrtNPzUeEE
	Vbk8lq5JqGGzKZZd6CRAl93PYCQ9/kbuCcX1RiHTBVwlENloPAefNm1YSaCFPLy4
	IVze8qTb4st8ZNgIWUdlYqFtc760t00g95zdROrIxILZPy5jDpLGo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B940720D1B;
	Tue, 30 Apr 2024 16:03:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C452820D1A;
	Tue, 30 Apr 2024 16:03:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 00/23] pack-bitmap: pseudo-merge reachability bitmaps
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com> (Taylor Blau's message of
	"Mon, 29 Apr 2024 16:42:58 -0400")
References: <cover.1710972293.git.me@ttaylorr.com>
	<cover.1714422410.git.me@ttaylorr.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 30 Apr 2024 13:03:50 -0700
Message-ID: <xmqq34r2zkgp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C47BD0A2-072C-11EF-8CDC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>   - Rebased onto 2.45, so this is now based on 'master', which is at
>     786a3e4b8d (Git 2.45, 2024-04-29) at the time of writing.

Is there any notable reason for the rebase (other than "2.45 is out
now") that needs to be called out?  Something along the lines of
"topic X and Y has graduated and the helper function used by this
topic has changed its external interface"?

Thanks, queued.


