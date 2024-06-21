Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D78C1E
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996332; cv=none; b=hVxffp+yN8V0u2NReF+UT67M9yHGAJi0n/LJWSX+W4XQB6ZtM8R8OmltOts5GzD2zV5rUQOl2hkTbZj3Jq3P1837fst2unUdE+yKFu/d0uhSu6wIMcH2V5Pzu+RnBTUeA4E1ZEQ9yq2hyMXHUoUzCI8a2ng1cPCDyb9VnBsvml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996332; c=relaxed/simple;
	bh=MmScq802clZDWLEXmYl+Q7tvJ7qTLOe0M4z00QguIFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/FZZd0j7oT73s8Ta7O7/lc61cLH6/iKo8uSIsV8SRipLZ9U0gOR5m6zMKRnm0AE/KEUWhb/6QQ3scpDrlIWP94E6O+Zm+zItYRkcvwAPaRAdXXjOXmctH0AA6BA8giaSYXg/7qYD0zbEYPLjaRty1lfBSzfTr3qIGO5k/c/kOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BNu2HTW0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BNu2HTW0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1A6D264F1;
	Fri, 21 Jun 2024 14:58:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MmScq802clZDWLEXmYl+Q7tvJ7qTLOe0M4z00Q
	guIFw=; b=BNu2HTW0Rt5lLbXoEEIqKmg7TF8ZXq6E2mOoJXVWwKkGQCfveVTsdi
	7z5+rgdtyRENiIjBAvFMUALI7/5Q1zGqR4esbZIKivW2FTYytyCzPRs9wKBwTU4I
	Xl8Aq5vgsRoMdFaxLe2z9MzJpUqjPHzeJBWUBlAWtOJ9PhLN0jsgE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CAC0D264F0;
	Fri, 21 Jun 2024 14:58:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3896E264ED;
	Fri, 21 Jun 2024 14:58:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Randall S. Becker'" <the.n.e.key@gmail.com>,  <git@vger.kernel.org>,
  "'Randall S. Becker'" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
In-Reply-To: <016501dac409$7dd5bc00$79813400$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 21 Jun 2024 14:33:14
	-0400")
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
	<20240621154552.62038-2-randall.becker@nexbridge.ca>
	<xmqqmsnekvir.fsf@gitster.g>
	<016501dac409$7dd5bc00$79813400$@nexbridge.com>
Date: Fri, 21 Jun 2024 11:58:48 -0700
Message-ID: <xmqqwmmijf6f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4B411F24-3000-11EF-B0B9-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

<rsbecker@nexbridge.com> writes:

> In this case, I was modelling the include after http.c, and remote-curl.c,
> which would have the same problem. I was going for consistency. Would not
> all three have to be fixed in a separate patch?

At least for build on platforms without libcURL, you build with
NO_CURL defined, i.e. "make NO_CURL=NoThanks", and anything that
includes <curl/curl.h> is *NOT* compiled at all, avoiding the broken
build.  There is *NOTHING* that needs fixing in the existing code.
Only this patch under discussion is buggy that way.

>>FYI, in the merged result, I would prefer to order these entries
> semi-alphabetically,
>>e.g. perhaps stripping possible "lib" prefix or suffix and comparing the
> rest to result
>>in curl < openssl < z or something like that.  Then we know where to add a
> new one,
>>whose name we do not know yet, in the future.
>
> I think that is logical. Do you need this redone? Although the OpenSSL
> inclusion is already merged from what I can see.

That is why the statement has "FYI".  I'll do the merging.  

Having them as two patches, one for libcurl and the other for zlib,
would be slightly cleaner.  Otherwise my merge would have to become
"splitting the new one that adds libcurl+zlib into two hunks and let
the existing openssl one in between".
