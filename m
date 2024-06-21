Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED234644C
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997616; cv=none; b=sbw3wx51f38PJ3R2eGOiE7SRUBPfvp2jHvQmUzE69tbYpWCMpqHF9wAcPAIzUI6UPuK91/hFcTQS5ACADs+r86FdwPETl9E/OMbg+/+osrHXYqfAyTKCfs8bABmInXhLJuffkGBFXbrPi6Blm6+EmSDlmLh+evfdX0jyqEerFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997616; c=relaxed/simple;
	bh=bTs5lUdlGG/PSdeYrXez7EX5cHOAKIGW4B71cf60WY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fmpc0CYJP5VEYtLFM5MfKuIq12TbjHQiWadZmE2IyqnaQ0MmLX1L0tWEIyQVCRBEasWIQJb6Z1+xrpY7eNOfPMelNKzMsk105REbnNbIQEWy3hXRTdpdKuhRMX4A7oy/h6m6EKYQ4vQdjNivtYUWNdANQGysc4M9UfgoQAGlr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PcrhosWc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PcrhosWc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A2856221B8;
	Fri, 21 Jun 2024 15:20:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bTs5lUdlGG/PSdeYrXez7EX5cHOAKIGW4B71cf
	60WY4=; b=PcrhosWcg5a/LuLaFdnqGe6BXbKbgJPSARj4X9dE3UGGBFyTVwtQ/+
	fdR6FtHUmASiwIev+SAkDhrQnsh7kHwHi01YEfD3Z3CpMS7AZ9gzXbfymxKReCJA
	Mj/5FN11N6UttQ570iWGgPqyO++Edak4A+nd9yL4aCLiGUtK8zWcU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EB98221B7;
	Fri, 21 Jun 2024 15:20:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 123F5221B5;
	Fri, 21 Jun 2024 15:20:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Randall S. Becker'" <the.n.e.key@gmail.com>,  <git@vger.kernel.org>,
  "'Randall S. Becker'" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
In-Reply-To: <xmqqwmmijf6f.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	21 Jun 2024 11:58:48 -0700")
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
	<20240621154552.62038-2-randall.becker@nexbridge.ca>
	<xmqqmsnekvir.fsf@gitster.g>
	<016501dac409$7dd5bc00$79813400$@nexbridge.com>
	<xmqqwmmijf6f.fsf@gitster.g>
Date: Fri, 21 Jun 2024 12:20:04 -0700
Message-ID: <xmqqplsaje6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 44501046-3003-11EF-A5EB-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> At least for build on platforms without libcURL, you build with
> NO_CURL defined, i.e. "make NO_CURL=NoThanks", and anything that
> includes <curl/curl.h> is *NOT* compiled at all, avoiding the broken
> build.

Unfortunately, we cannot use the same trick, i.e. "Makefile
knows not to even compile when NO_CURL is set", as this change is to
help.c and we cannot say "if you do not have libcURL, you do not get
any help" ;-)

        #ifndef NO_CURL
        #include "git-curl-compat.h"
        #endif

may be a simplest workaround, as Makefile does this:

        ifdef NO_CURL
                BASIC_CFLAGS += -DNO_CURL
		...

