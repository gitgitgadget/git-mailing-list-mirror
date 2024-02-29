Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0847A125
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236780; cv=none; b=UCi3OCNML0AUdngSewf9cEVFS4ZYnGpG2YvnmkRpThnv8uSM4Iu4HfC9kCYM/ozeD85ZE8NbXHum7cy+NBnWuyNJeG/sXCsEr9cCt28KGiXrk9D8z40hn62ndSbxbfNhzr1eU+Z421ZNsVIY8ou4D3357cUF7URunMQ2WPZ3TNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236780; c=relaxed/simple;
	bh=nHXdqVTZ1QZcbYNXHTWVfWGQBTdgUXlf+igRCHkzgks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FALbpSdB4glOfXCp7BovTWrRiviI6rEOAzT0CER8OvROEt0XA521rj8qvHjZGBchQVErmbpw8Z8HtWMacNPvtb7j4R5FnZF0Odq1dm+DYQz1XQMWla/SsriLv0jU34nPybbKOEEF9iXm+eoV3rB/yP6QKYLP50SjOJT4JihTLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=edbrf+U6; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="edbrf+U6"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 402FA1E6347;
	Thu, 29 Feb 2024 14:59:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nHXdqVTZ1QZcbYNXHTWVfWGQBTdgUXlf+igRCH
	kzgks=; b=edbrf+U6lDBk6c3teS/fYqg3PnbLdbz+++xMVhhrxncbhp4YA9PAJ1
	0bjt4xjUyX80H+tVcJYvGmKC3834D2UBqd7BE3x3Ut0hv0R5Yphl0mpHSryB4TSa
	9cz+NSrivAmo7RmGxruxmk6c0Yys6ykW02z/dHGFjUpsEjBpcXkAU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 35E5D1E6346;
	Thu, 29 Feb 2024 14:59:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92DFB1E6342;
	Thu, 29 Feb 2024 14:59:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Bruno
 Haible <bruno@clisp.org>
Subject: Re: [PATCH] docs: sort configuration variable groupings alphabetically
In-Reply-To: <20240229190229.20222-1-ericsunshine@charter.net> (Eric
	Sunshine's message of "Thu, 29 Feb 2024 14:02:29 -0500")
References: <6139934.yKrmzQ4Hd0@nimes>
	<20240229190229.20222-1-ericsunshine@charter.net>
Date: Thu, 29 Feb 2024 11:59:36 -0800
Message-ID: <xmqqmsrjdot3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 112CBC2E-D73D-11EE-B7F3-25B3960A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> NOTE: This change only sorts the top-level groupings (i.e. "core.*"
> comes after "completion.*"); it does not touch the ordering of variables
> within each group since variables within individual groups might
> intentionally be ordered in some other fashion (such as
> most-common-first or most-important-first).

I think this is a useful first step.

It is tempting to think, in this day and age, searching in a
document is so easy to start with a single keystroke (either ^F in a
browser, or '/' in a pager) that the ordering of entries does not
matter as much as it used to, but the reader may not know exactly
what variable they are looking for, and a predictable ordering helps
while they are browsing the list.

Will queue.  Thanks.
