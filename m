Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD801A6820
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784866802; cv=none; b=IQVIe13KEbUPavczHvQsPJIqB/aPujOEOosewctYxVRlD+CroQNL0fVB0dcOb0R+vz7NiGYaDT+k9BEBhBlo0lYGq+iJ4DcI/tnh58Sb2nURelSjZAb5RMyZBP/mgY2InPaF8hWZOz/5wG+VbaMoBDMHUvlbtOglluS57FDBBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784866802; c=relaxed/simple;
	bh=LOn9qYRyes0TR6pVzwRYRySYnp0V/UPP6AcpLIsS1pQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lORb6x6X4Jdhx5eN+b/682/+sD6LjALr0gWip7xF85/KDCXZNVptj/na13Hm0TSvTuOIPeL0VFnHkgMmZPbcGAfA/u/rAC++pNMjPZQUSwmiabceTs/7itzpSGWVLfb8AiDR2sKh5iC5y6PEtFpnDTjYCf6XK0mIFQ0L5SXNIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XB2vV+p7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TdlnCzs7; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XB2vV+p7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TdlnCzs7"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFC827A0345;
	Fri, 24 Jul 2026 00:19:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 24 Jul 2026 00:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784866799; x=1784953199; bh=x9AX9iru51
	X5BX8CypylFUiEzqtZ3O9kPeh5I5ek3YU=; b=XB2vV+p7lj53ygw9EM7lZmxls8
	z+cSbT/WgCFa453RPT/NgFszMytrLINn/nj/WlNaNEEfYaFtq6ygvSc4jU4T8U8V
	F8Tw4H8elXMdZGpq6t4ZNnYnnkm5ArXh+vOUcVR5cYQx3bDWuzGx4O5kBJ4RXKzU
	druiSYAiZpiDncv+eEHyHjhUfw3sBNL1ZCnSRmnmajRKysBAbHPFvRMiygCJKD6/
	3gagtLaBu9h8Ez82pMT2yL2mAeWs6yOGzRZWz16+kI4KZCar322Mj82ziohJs3pn
	pOdnWKi+5G+d1+kRMfymiNOlFba30wjBZnRKXXBXuGjyqeeBSx2aa0KxZXbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784866799; x=1784953199; bh=x9AX9iru51X5BX8CypylFUiEzqtZ3O9kPeh
	5I5ek3YU=; b=TdlnCzs7hPH5sssvO3wfsI7etOvIjydqZYvthed5doJGOk4SetU
	cvgXJ89GSw1oL2C7cR+G8tA0tJFgpQKLgi2er2QHVi6CgmvND0Y+tgb97DB8Vrci
	CjF3A1XbuC+ZBiYWmXIOLffFbBJ4NC4ffcVsPIMQbEcc97aLgJGRaUBMDF+VllUZ
	Bkq8OUEb+R/9X/yjbsFqg9mBC5LozgCAmnxDCNvMFa+lu5qFzCZMKKz3Cwo5yD36
	dgJ+OWRh6SddrDpKO9zXWuG65aW8jjcSCN0Q10s3LWqimjmm2/8KbAhsWlUE2ziY
	OSFRdEW0+i8BDAMY4KEZfImOXSXNyWnrxjw==
X-ME-Sender: <xms:7-diatsc5ViwreTBKa6VBPFFAuTps0WQMhEL_h_6AQZo4dKsMuIubA>
    <xme:7-diat4CMOcMbWG7N9cj4Wr-Wdj5050VgmXkGtClD4Bjf3kQl9S35YBvNLlQTV9SL
    PPt_a1i_t0dE166L0mXXEK5peDnaxeDmHC3qN_nkZU8kEMhkLT2qw>
X-ME-Received: <xmr:7-diauK0Ku9tDmTF4JJnubC3-Mq2v8RpWVKKhSxe_7_Lc8TQiPCl-0oI91eS7R71HzRWe5G6lzIbfFJ7qUT4gdclIEoiOPZ3Vw>
X-ME-Proxy-Cause: dmFkZTFlFWkm9p4bvLOFndm4Z8VX+915asVc1QAIRsQEApVeGc6vjPFG+xO2RasuFFNC9P
    CQYoLE4/5H6OguksFsrYyEJ/g2swmZYwXKqAXhMOMz8FviexCagOllDKOUg7BPYjBYz993
    jyEo4DLoMhsd10SjEvtX55N3L4hM3rPLvP7hk6rGIs52YKy9W66YsGpJQ6urXjj/MGKauj
    /H3uEZk/u1rzSde0cfRimug72kgQ+2nFwHIstKA6xlYaQcVSZsjKKtG6SMTVeKhgQbzn6Y
    uNwy5Q+o0YV1uTRvsDlwfK6TvDsboGT+kK1fMGDuuvU0qgMOrlEOw/61/5M4J8MoERBARF
    OmtkWcMDk7o2w3rUHJT8WAB01vyl42tRAiZeNO27ltPUzlvRqIDGVRezbBOVtR33ckAsQX
    GBBNph4hhPTG5S8/nluYYticZyEydK8gV2VO1U/ZSeVZvh1UdXSf2R1FZJVFcdyRu49jo5
    x5PpWbmbu59NMH7D7PC0g1ke4upAwIh7PGxr3nskxYEowWTyv8yR9I+n8dPGnYDjhHidsO
    kviNg8mH1Tjz9f0FJUPje4ZYdfR7sZURvJGvwQoMAkb8oWP98wrXQWzInfQ2vdbHUEIOWc
    EeHKYnrNQuFf8/6N0f03zv4vLqDf2Ln5/qfOLM+u6u0P9VKvGMGO2+pj79gQ
X-ME-Proxy: <xmx:7-diat6T1NhHaaYQ2tOn24lBN9f_ZyOK6xp8ZXGieiW-9GosZLvmWg>
    <xmx:7-diahzlZY7y_15MYpVMeTzgrhY3fZPjmRURpJrkxBvFL4VvVY_wCg>
    <xmx:7-diahY2m7W1VjF810RyfuXpRP4KPIL4VIiqNC8em6yxawD2aoOkGA>
    <xmx:7-diajTVyCOQMkqayq3Frfyzw8_r5niJUKbWyTfCCfRXOyr-pw3u7g>
    <xmx:7-diag1SZznY3CElYzvl5wAe7Sf6GMtsANgoytRzZuXaQnNPksE0yKlY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 00:19:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chungmin Lee <chungmin@chungminlee.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] regexec: work around macOS TRE memory leak on invalid
 UTF-8
In-Reply-To: <20260722053127.37244-1-chungmin@chungminlee.com> (Chungmin Lee's
	message of "Tue, 21 Jul 2026 22:31:27 -0700")
References: <20260722053127.37244-1-chungmin@chungminlee.com>
Date: Thu, 23 Jul 2026 21:19:57 -0700
Message-ID: <xmqqpl0d9fyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chungmin Lee <chungmin@chungminlee.com> writes:

> This came out of a real incident: "git grep -i" over a repository that
> contains PDFs exhausted memory on an otherwise idle Mac mini and took the
> machine down with a kernel watchdog panic ("no checkins from watchdogd").
> The leak is in the system regex engine, not in git, but git is what
> drives it into the leaking path, once per line.
>
> Why this belongs in regexec_buf():

Why does this belong to Git, not macOS, in the first place?

> diff --git a/compat/regexec.c b/compat/regexec.c
> new file mode 100644
> index 000000000..0677162a8
> --- /dev/null
> +++ b/compat/regexec.c
> @@ -0,0 +1,108 @@
> +#include "git-compat-util.h"
> +
> +#ifdef REGEXEC_MAY_LEAK_ON_ILLSEQ
> +
> +#include <wchar.h>
> +
> +/*
> + * macOS's libc regex engine (TRE) leaks the buffer it allocates for a
> + * match whenever regexec() encounters an invalid multibyte sequence in
> + * a multibyte locale: it returns REG_ILLSEQ without freeing that buffer.
> + * A single "git grep" over a file with binary data can call regexec()
> + * once per line and leak gigabytes, which has been observed to exhaust
> + * memory and trigger a kernel watchdog panic.
> + *
> + * The leak happens inside regexec() before it returns, so reacting to
> + * REG_ILLSEQ cannot avoid it: the invalid bytes must never reach the
> + * matcher.  Split the buffer at each invalid sequence and search the
> + * surrounding runs of valid text separately.  A match on either side of
> + * the invalid bytes is still found (the same result the matcher gives on
> + * valid input), but the leaking REG_ILLSEQ path is never reached.
> + *
> + * Use mbrtowc() to decide where to split, so that we split at exactly the
> + * bytes the platform's own decoder -- and thus the regex engine, which
> + * decodes the same way -- rejects.  A hand-rolled validator would
> + * have to guess that boundary; being too lenient reintroduces the leak.
> + */

This clearly seems to be a workaround for a platform bug.  Do we
know how long we will need to keep it?

> +/*
> + * Search buf[start, end) for a match.  REG_STARTEND reports offsets
> + * relative to buf, so a hit needs no translation.  ^ may only match at
> + * the real start of the buffer and $ only at its real end, so suppress
> + * them when this segment does not reach those boundaries.
> + */
> +static int regexec_segment(const regex_t *preg, const char *buf,
> +			   size_t start, size_t end, size_t size,
> +			   size_t nmatch, regmatch_t pmatch[], int eflags)
> +{
> +	eflags |= REG_STARTEND;
> +	if (start > 0)
> +		eflags |= REG_NOTBOL;
> +	if (end < size)
> +		eflags |= REG_NOTEOL;
> +	pmatch[0].rm_so = start;
> +	pmatch[0].rm_eo = end;
> +	return regexec(preg, buf, nmatch, pmatch, eflags);
> +}
> +
> +int regexec_buf(const regex_t *preg, const char *buf, size_t size,
> +		size_t nmatch, regmatch_t pmatch[], int eflags)
> +{
> +	size_t seg_start = 0, i = 0;
> +	mbstate_t mbs;
> +
> +	assert(nmatch > 0 && pmatch);
> +
> +	/*
> +	 * Only a multibyte locale drives TRE through the leaking multibyte
> +	 * path.  In a single-byte locale (MB_CUR_MAX == 1) no byte is
> +	 * invalid, so search the whole buffer as before.  MB_CUR_MAX
> +	 * reflects the current LC_CTYPE, the same locale mbrtowc() below
> +	 * decodes against.
> +	 */
> +	if (MB_CUR_MAX == 1) {
> +		pmatch[0].rm_so = 0;
> +		pmatch[0].rm_eo = size;
> +		return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
> +	}
> +
> +	memset(&mbs, 0, sizeof(mbs));
> +	while (i < size) {
> +		unsigned char c = (unsigned char)buf[i];
> +		size_t n;
> +
> +		if (c < 0x80) {		/* ASCII fast path */
> +			i++;
> +			continue;
> +		}
> +
> +		n = mbrtowc(NULL, buf + i, size - i, &mbs);
> +		if (!n)			/* embedded NUL decodes to one byte */
> +			n = 1;
> +		if (n != (size_t)-1 && n != (size_t)-2) {
> +			i += n;
> +			continue;
> +		}

OK.  I wonder if we want to document what -1 and -2 signify (in
other words, why we stop only when the call returns one of these
two values), or is it too obvious for users of mbrtowc()?

In any case, if control reaches here, we saw either an invalid
sequence (-1) or not enough bytes to complete a whole multi-byte
character (-2), i.e., the case where regexec() would have trouble
matching starting at offset 'i'.  The bytes before that position
make an OK substring.

> +		/* buf[i] begins an invalid sequence; search the run before it */
> +		if (i > seg_start) {
> +			int ret = regexec_segment(preg, buf, seg_start, i, size,
> +						  nmatch, pmatch, eflags);
> +			if (ret != REG_NOMATCH)
> +				return ret;
> +		}

Naturally, this "check the OK prefix string" approach makes readers
wonder what happens when the pattern is "right anchored$" and the OK
prefix would match if the string truly ended at 'i' (or, if this is a
second or subsequent segment, the pattern is "^left anchored", and
the segment would match if the string started at 'seg_start').  The
use of 'REG_STARTEND' in regexec_segment() above, combined with
'REG_NOTBOL'/'REG_NOTEOL', is a clever way to work around it cleanly.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 880977640..3861c9353 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -992,6 +992,10 @@ static inline int strtol_i(char const *s, int base, int *result)
>  #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
>  #endif
>  
> +#ifdef REGEXEC_MAY_LEAK_ON_ILLSEQ

Hmph, how many different symbols do we need to deal with this?  The
Makefile has DARWIN_TRE_REGEXEC_LEAK_WORKAROUND and CPP macro is
REGEXEC_MAY_LEAK_ON_ILLSEQ?

> +int regexec_buf(const regex_t *preg, const char *buf, size_t size,
> +		size_t nmatch, regmatch_t pmatch[], int eflags);
> +#else
>  static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
>  			      size_t nmatch, regmatch_t pmatch[], int eflags)
>  {
> @@ -1000,6 +1004,7 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
>  	pmatch[0].rm_eo = size;
>  	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
>  }
> +#endif

It is a bit awkward that the next platform needing its own
implementation of regexec_buf() to work around a different platform
bug would have to do:

	#if defined(REGEXEC_MAY_LEAK_ON_ILLSEQ) || defined(SOME_OTHER_PLATFORM_BUG)
	int regexec_buf(.....);
	#else
	static inline int regexec_buf(.....)
	... the current definition comes here ...
	#endif

I thought it was more common to:

 * Have each platform with such a need define an override in its own
   platform header file:

    int darwin_regexec_buf(.....);
    #define regexec_buf darwin_regexec_buf

 * Have a header file like 'git-compat-util.h' include such a header
   file (conditionally on relevant platforms, of course); and

 * Have the common header file do this:

        #ifndef regexec_buf
        static inline int regexec_buf(.....)
        ... the current definition comes here ...
        #endif

Right now, macOS is the only platform that needs an override, so the
result would be about the same amount of code.  However, in the long
run, this structure may give us a better organization, no?

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> ...
> +test_expect_success MACOS,MB_REGEX 'grep anchors ^ and $ at true line ends past invalid UTF-8' '

Do we need to allow this test to fail on non macOS hosts?  Why?

> +	LC_ALL=en_US.UTF-8 git grep -h "^before" invalid-utf8-embedded >actual &&
> +	test_cmp invalid-utf8-embedded actual &&
> +	LC_ALL=en_US.UTF-8 git grep -h "world\$" invalid-utf8-embedded >actual &&
> +	test_cmp invalid-utf8-embedded actual
> +'
> +

Thanks.
