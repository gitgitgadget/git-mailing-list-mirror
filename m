Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84C2E62F
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914835; cv=none; b=bwFNhHh5ywUHyXX9szkOObqenUMH8OtJ+o4a+NskNItAc69FNSRguUQlqmYizzfcNG/r09niMQSjG7ZbGzFD1F1vFwyH4FtjgnrZ4FLQWguIJ2DVDG47Q6SHXCEpWbv4gN86fNohmKgxNFE63cxRDLB5gzKZ0IIqezWW+/FeBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914835; c=relaxed/simple;
	bh=RquOR0SVHntDyp96183gNEIRuNN1kANdbCqG8hoFYJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cF8/QiXoUdm5gA9Z5WUsmFscEHzBuSN5CKAaAZOLjxvsQ3yACtrZHsODv7oScKFRO4Fm5mehnTV2ABiXL53ufpNOjJZSvS9DvIONlTb8lIfJdeW6E2YQ8aUISKsEav3bEteQXfuXTIsuwO5xivpL04Mxze1+4cNnbTyMgvQ+1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lH0Y5iJ6; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lH0Y5iJ6"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 79CAA2EAF0;
	Tue, 23 Apr 2024 19:27:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RquOR0SVHntDyp96183gNEIRuNN1kANdbCqG8h
	oFYJc=; b=lH0Y5iJ62v/Ta8n9BqakIVZy9mK6PLSUR4kWq712WkufLXJ7DJ4BCF
	28MaTGOCom7HF+5NWiRaNHPJn+Kgnh74NGRrCJVdKRrQ5htp/A3Dm4vRGiApWRAN
	YGv72E7cM5MEYQ64x78bFVosLfBkUE+/+H2we7N/+y/C6Q/5eVlVI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 739012EAEF;
	Tue, 23 Apr 2024 19:27:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C967E2EAEE;
	Tue, 23 Apr 2024 19:27:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 7/8] trailer: make trailer_info struct private
In-Reply-To: <0e9ae049b8861fecf49c097e8d52e734f7a9c9b3.1713504153.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Fri, 19 Apr 2024 05:22:32
	+0000")
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<0e9ae049b8861fecf49c097e8d52e734f7a9c9b3.1713504153.git.gitgitgadget@gmail.com>
Date: Tue, 23 Apr 2024 16:27:08 -0700
Message-ID: <xmqq34rb64oj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0195E266-01C9-11EF-A8F9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> There are a couple disadvantages:
>
>   (A) every time the member of the struct is accessed an extra pointer
>       dereference must be done, and
>
>   (B) for users of trailer_info outside trailer.c, this struct can no
>       longer be allocated on the stack and may only be allocated on the
>       heap (because its definition is hidden away in trailer.c) and
>       appropriately deallocated by the user.

    (C) without good documentation on the API, the opaque struct is
        hostile to programmers by going opposite to "Show me your
        data structures, and I won't usually need your code; it'll
        be obvious." mantra.

The comment inside trailer.c does not count (the API users are not
supposed to peek in it---that's the whole point of making the
structure opaque).  You'd need to compensate with a bit more doc in
trailer.h to help the API users.

Other than that, looks "correct".
