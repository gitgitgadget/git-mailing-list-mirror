Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728F2F3B
	for <git@vger.kernel.org>; Sat, 22 Jun 2024 05:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719033079; cv=none; b=EvO5qW35eFs4BkwfkzqD8e+cMVulT9RdIo+NKDSxlHRhPnOhnuSpB9bHxAA5Wn8vmCTCYEMfy2UD4fVRuTyRCFYoujZmgmULlkcDdKTqbAaJx2yqCOxghihs//d2oKJ/RfeupRD6z+1vymzLZHxgSNhU5mKZO35C1DuHi8JBNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719033079; c=relaxed/simple;
	bh=DsSQXJl6kH8T3ZOs1c19EoqfGgVEJe2s3FFfq5TpPTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UrpreTS0GdEqd4oPeO/z05QQKvUwos+9yRGXDoki0cLxQOh3QRv56ui+ftlWBgac9bTG30yLvk1rRvFEQK8ypjtsqxEuHmRApBN1QvM0dNNmLtXjGdfJR13gBa7vQ0gxslzqyf+Na8y5m9GmF+m7gAjtmgwmDSn5qsacIF1ggvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t5Fjzhzo; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t5Fjzhzo"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 88B683B2AF;
	Sat, 22 Jun 2024 01:11:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DsSQXJl6kH8T3ZOs1c19EoqfGgVEJe2s3FFfq5
	TpPTI=; b=t5FjzhzoUR/z76J7cYxY9sO3IJRQUpAVfsVDVYrvdLr43DuCoLWPrv
	JuTzqOwNMrGtU1GzBj8/3fSDFOYsj1uLEw4fXmox04J8aeranDOCvlV+nl8KEVQW
	sNaGHgR+FdEdew3iUMW5/k3RS3vK/IJ6S2SPB5M6gHLw8f19R4jW4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 756A23B2AE;
	Sat, 22 Jun 2024 01:11:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 066013B2AD;
	Sat, 22 Jun 2024 01:11:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Randall S. Becker'" <the.n.e.key@gmail.com>,  <git@vger.kernel.org>,
  "'Randall S. Becker'" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
In-Reply-To: <xmqqplsaje6z.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	21 Jun 2024 12:20:04 -0700")
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
	<20240621154552.62038-2-randall.becker@nexbridge.ca>
	<xmqqmsnekvir.fsf@gitster.g>
	<016501dac409$7dd5bc00$79813400$@nexbridge.com>
	<xmqqwmmijf6f.fsf@gitster.g> <xmqqplsaje6z.fsf@gitster.g>
Date: Fri, 21 Jun 2024 22:11:12 -0700
Message-ID: <xmqqtthlimtr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D8DBFA98-3055-11EF-9590-C38742FD603B-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Unfortunately, we cannot use the same trick, i.e. "Makefile
> knows not to even compile when NO_CURL is set", as this change is to
> help.c and we cannot say "if you do not have libcURL, you do not get
> any help" ;-)
>
>         #ifndef NO_CURL
>         #include "git-curl-compat.h"
>         #endif
>
> may be a simplest workaround, as Makefile does this:
>
>         ifdef NO_CURL
>                 BASIC_CFLAGS += -DNO_CURL
> 		...

So, the version I queued looks like so:

        diff --git a/help.c b/help.c
        index ce55aaa2c0..92bfef140b 100644
        --- a/help.c
        +++ b/help.c
        @@ -15,6 +15,10 @@
         #include "prompt.h"
         #include "fsmonitor-ipc.h"

        +#ifndef NO_CURL
        +#include "git-curl-compat.h" /* For LIBCURL_VERSION only */
        +#endif
        +
         struct category_description {
                uint32_t category;
                const char *desc;
        @@ -757,6 +761,9 @@ void get_version_info(struct strbuf ...

                        if (fsmonitor_ipc__is_supported())
                                strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
        +#if defined LIBCURL_VERSION
        +		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
        +#endif
         #if defined OPENSSL_VERSION_TEXT
                        strbuf_addf(buf, "OpenSSL: %s\n", OPENSSL_VERSION_TEXT);
         #endif

but then there are a few "side builds" at GitHub CI, one of which is
"minimum fuzzer" build.  It compiles bunch of object files without
giving much build options but the final target of the build is not
"git" but something else [*].  And because the job is not interesting
in building a working "git", the environment does not install libcURL,
leading to a failed build.

I sent a separate patch to address this build failure, which is
found at https://lore.kernel.org/git/xmqqwmmhimxx.fsf@gitster.g/



[Reference]
 * https://github.com/git/git/actions/runs/9623017127/job/26544995557
