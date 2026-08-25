Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0CB32B105
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675795; cv=none; b=bG36QL44gix7UaLO44yxqwLc7EwoBwEztiJsN6cDIU3QuwHVTyIHhLxln2oNQlGTUbaaxEJRITj3fP/qW0it2jwUBcVJrd7HwmgfCXiGr1X9/rpKy5QPLyJtgPA1pFCv+vWv+QrGqfkTZIH1U1Kg4skDfCzZ0BJ7UweW4MIiApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675795; c=relaxed/simple;
	bh=JIvjH1cf2QmGN90+9iL11/k45AK6RYRyy4ZMXww+PGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=koMo3YHcKb15yuYpKqqhRtYpibJO1vHt2/YmLKAHuSR67J+SYNwJBWC8FgR7Cqv+7qciigaxaZKZRFjJWwFI5RrumqI55SrPPMFoYoAVES9ZXy2za6LsUX/mh3Zy7q6hbKMi2D78k13zpfbsK7oxa7DhY86cTTT0vGeOq3rgVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jPwsWv76; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CyBaCYy+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jPwsWv76";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CyBaCYy+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E2B6F1D00155;
	Tue, 25 Aug 2026 12:36:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 25 Aug 2026 12:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787675792; x=1787762192; bh=rpLD4sxv4X
	RetERYSktAH3+U5naiL0j+woatKlT35nc=; b=jPwsWv76l39mAPEJgH3Qtt+loF
	2CkAfNksxJzpsKW9j/EIBblELe3ETk3hNQqDjBf106kOuO9ki/LLkpGxxG8IRgPx
	syPn3LRpc4lshnbYKlFpiIVbIWJ74T4Dc6pgAXPl5lQh1PsFLpkL1HbtnGf/osCX
	Ph5Hi0FIEjSt0lCIBqWj1g9pLXKYxpaEy2LkcF+xUK2mPXNtHITbXq0CYFbx4duw
	CmjKOc6wNto+CcTNxPK1+LFXz9kPeFxusWJ6XRP8B93uGxjTD0PTMJHiMSrtxDvV
	J6SH1l8GFnRMCKSQhettO/rFNgO2WAqrWYSbd0slT/ycxBPRkvwLSEZD8cIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787675792; x=1787762192; bh=rpLD4sxv4XRetERYSktAH3+U5naiL0j+woa
	tKlT35nc=; b=CyBaCYy+N1MdKLfcCE6pc14Om8Xl7cXFZEi8PjxVVvprt+wIYnT
	nTy7568h1z6BjLqEoHw0voWkeNtY2ZzDhuZUp9W5edU4u/RNVWEGhvhnvZta1ECg
	H14SmcT4kzsHHIHRBESF/dwW+ECdsOZjvOs3vdAaGly8vkJqKdC/2Y6XWxYPrbXV
	U+aNl5Zh0dRsKl++cO3X8vWqW7B/p2fBk9YF3XlrTEIVnvRdAz/EzncBtBmevlJG
	XplvcZYU9V40jFgAHl3Ik9SXAk7zOtIyOWkdtfOb9c/7taIZ9gcUytSvHFPMZRzr
	i+5wc/hb/SXE1C3JHJGLyEOIq0oxdsafKAA==
X-ME-Sender: <xms:kMSNal9P9HmyEf6iZXh7bTPv0zO7CnvmE63GVHZ6Q7s9POZZMvOYog>
    <xme:kMSNahIdu6sr3XFGQfLI90hIRgA0xnAFfoEjax3YbXCRTcJDM2uiK6AGPiQlXmVAP
    uy6f_RDV93Etub3HqBsMN-3x6g-Ok5sckHzXTeQURlKMUlgauMV3A>
X-ME-Received: <xmr:kMSNagaV39emX4YWhUq5Vjx3TOCNCbojRtLIvyHrxhdU9T6lY01gZvgASBeLdKhhObm2J5tPeJ7TTHOikBXKAWjL6bU2XZfRvw>
X-ME-Proxy-Cause: dmFkZTE2RhSLZ6KGvZuTFFr8zjyVmhwUJMjMURBcztYHnhmSr0XiomgG7ERRx5/zikwYn+
    ZZJrnUOMimPymk06TrczLzMzsCbgdumlg+xcE3XSerByTu9ZCrCuxY7N9VzzYxjrL9qM9q
    Qt7okbzuE6Pw6ud7n92XOmFLjwkKj0z/RW4O9/nwcC63R2lnDhrRvBvAro2zCJbZSzQK/5
    1ROrQyQpB0HK1mi5i0OPqxVxu+4pQ1jgWt+LQ3CDFa1uF9m/zRPtO4dM6cqad7h3nhJbdv
    M7s3CH5L2OJBRK8N58QZ9Z3ylNCsK3m8zkdHRjy3SMrXrApKmumawbPhTSS/oZIWBH6SAX
    b+VC/DM6OsOCDDIzhGXZea1s9IimRIKL8Au28aCTtPyUq8toBtL76ZkyHYOX/gj1p2zJWF
    AnlCcgoWZCZHhxvLcRryHa5ZD6LJLlxrpsjLuaO9OTZkBILsOK2X6y+2lUaFVuMaYk/KeG
    xOyFOYkQC6Gum/5gyeup/q5cOHWy1n6k7oOMcA+Dc3kqR7qWLfaCRVhGynmoA+37HLmXmo
    VzgvoEVde4mV9kSe/facI58zfFitW4CCxTy5/wrtMIah/pUYWZfqGwaTt9OJY7jPjvTYAn
    7jVBoFvhUMixzSxPqOTrBV0qMdAVXSCXEc3dnePbdh1V1Mu0mdhEMcKaQ7ZA
X-ME-Proxy: <xmx:kMSNajJbaEicHHhvoS8zqIF6JwcwyAcNre3_Kbwuf1KqAK9YIPYIig>
    <xmx:kMSNauA7124cFTzE6SfdRuBlVKmI7IB2KkXDDh7vwIHhYdGJIVoDoA>
    <xmx:kMSNaoo_gQ6xQGHY3rmfE8hoORLRncVrUFyL-r566iAp79e9eTUJ1A>
    <xmx:kMSNapgTKfkOCVdrV5nyAprlSY7RM9AxDtVfStF1mQv1KKkONAz67g>
    <xmx:kMSNaj29gu2HbABxno7xmZ2x0IaV893DIZerq5ldaOu3u2lHoKcEdttX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 12:36:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in
 breaking changes mode
In-Reply-To: <20260729233215.398654-7-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 29 Jul 2026 23:32:15 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260729233215.398654-7-sandals@crustytoothpaste.net>
Date: Tue, 25 Aug 2026 09:36:30 -0700
Message-ID: <xmqq8q5unomp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> IDs.  Note that in t5324, we change the hex character from "A" to "b"
> because in SHA-256 mode, "a" is the correct value, so our test_must_fail
> assertion will unexpectedly succeed in that case.

This was a bit hard to read and puzzled me, as you have two "A" and
change only one of them to "b".

Is the idea that we wanted to make sure we use lowercase letters,
because we do not want to see the tested "verify" command fail for
now-forbidden uppercase hex but we want the command to read the data
as valid hex and fail because it notices the corruption?  So the
first hunk is a no-op change (i.e., the first hash identifier on the
first line is corrupt with the 30-th char in the file replaced with
either 'a' or 'A'), while the second hunk is not (i.e., the second
hash identifier on the second line in the file is corrupt with the
70-th char in the file replaced with 'A' but it is OK with 'a'
because in the SHA-256 mode, the correct character for the place
happens to be 'a')?  It is puzzling if that is the case, because
what this series wanted to tighten was that we used to treat hex
chars case insensitively.  So, if 'a' happened to be the right
uncorrupted value for position 70, how did the original that
replaced it to 'A' tested a "corrupted" state?


> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index bf7ba0e558..29db815c77 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -349,7 +349,7 @@ test_expect_success 'verify after commit-graph-chain corruption (base)' '
>  		test_must_fail git commit-graph verify 2>test_err &&
>  		grep -v "^+" test_err >err &&
>  		test_grep "invalid commit-graph chain" err &&
> -		corrupt_file "$graphdir/commit-graph-chain" 30 "A" &&
> +		corrupt_file "$graphdir/commit-graph-chain" 30 "a" &&
>  		test_must_fail git commit-graph verify 2>test_err &&
>  		grep -v "^+" test_err >err &&
>  		test_grep "unable to find all commit-graph files" err
> @@ -364,7 +364,7 @@ test_expect_success 'verify after commit-graph-chain corruption (tip)' '
>  		test_must_fail git commit-graph verify 2>test_err &&
>  		grep -v "^+" test_err >err &&
>  		test_grep "invalid commit-graph chain" err &&
> -		corrupt_file "$graphdir/commit-graph-chain" 70 "A" &&
> +		corrupt_file "$graphdir/commit-graph-chain" 70 "b" &&
>  		test_must_fail git commit-graph verify 2>test_err &&
>  		grep -v "^+" test_err >err &&
>  		test_grep "unable to find all commit-graph files" err

