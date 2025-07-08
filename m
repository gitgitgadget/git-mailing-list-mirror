Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A25383
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937173; cv=none; b=nj5RIUwTxIbxmSyw9iZw/JrTyYUWpGvBdWWJ42kc6UqvQnS18DUg98cWrEbT0RC1nvbi95b8GKywP/IWwN5F+qV+1nWNBWUr5D7sp+GA6rYplnexvO3+cD44zvG/ilA/I+8HK7wRsv8KUO62q1zylj6SQQCKgqLqkOp874zP9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937173; c=relaxed/simple;
	bh=Fw+ucrcgErC23Im9HFeWOmmOst5cj0Dikkd1AMv9bbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDB4V4PD1eQwfMHVRcw9QgNXJpL4jsvC6DvPVrGxCBu0oOSOFEI8W9hUKv8tWSY0irRGaWEalFWE+6JWxq601CwgM8loukbCc7RrGdd5jAaj7rPVwNe/PkkZx6VnpFpEDJ8qnBhICN0hDROWaoC77sXW0ynQczB7WwqHSZRLZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Vupzfod7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Vupzfod7"
Received: (qmail 10663 invoked by uid 109); 8 Jul 2025 01:12:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Fw+ucrcgErC23Im9HFeWOmmOst5cj0Dikkd1AMv9bbs=; b=Vupzfod7cu+FrkIUJHJiqkTVfsh7pM1eckN/d4siE3ZeCEHkt59TIAoXNNHIny4G7JLHj0LWqBIKA6QgBlWZaWyw649KdDZ7cC7Okwip3ljkIqzPWj4Yj95BbN+/R88Ohg1Um/Nm4sBtH6RH3cPcrz36FlD+w5l0lu/k/KGm3+erP4yXtRe3/nkwjw32T+BmZwwEM5A/ZaN5O5alclLRsZ8kPI5NF0S87gHjv6ul1YfZhac0BJ47GXj0O0PgjF4sU3Yy3FhkX1a3nBqFJ+wn6YgXdBz39Qvw3W9uPVKC7AkjAW6Gs5RrJE+28UiqeoHrzqJKXzcMEo4balHFAagcKQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jul 2025 01:12:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13621 invoked by uid 111); 8 Jul 2025 01:12:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Jul 2025 21:12:52 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Jul 2025 21:12:49 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 8/8] ci: use Meson's new `--slice` option
Message-ID: <20250708011249.GA547084@coredump.intra.peff.net>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
 <20250703-b4-pks-meson-cleanups-v1-8-2804c2932abe@pks.im>
 <xmqqldozzge4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldozzge4.fsf@gitster.g>

On Mon, Jul 07, 2025 at 05:16:03PM -0700, Junio C Hamano wrote:

> https://github.com/git/git/actions/runs/16129796573/job/45515034049#step:6:17
> 
> unfortunately ends like this:
> 
> Run meson test -C build --no-rebuild --print-errorlogs --slice 0/10
>   meson test -C build --no-rebuild --print-errorlogs --slice 0/10
>   shell: C:\Program Files\PowerShell\7\pwsh.EXE -command ". '{0}'"
>   env:
>     DEVELOPER: 1
> usage: meson test [-h] [--maxfail MAXFAIL] [--repeat REPEAT] [--no-rebuild]
>                   [--gdb] [--gdb-path GDB_PATH] [-i] [--list]
>                   [--wrapper WRAPPER] [-C WD] [--suite SUITE] [--no-suite SUITE]
>                   [--no-stdsplit] [--print-errorlogs] [--benchmark]
>                   [--logbase LOGBASE] [-j NUM_PROCESSES] [-v] [-q]
>                   [-t TIMEOUT_MULTIPLIER] [--setup SETUP]
>                   [--test-args TEST_ARGS] [--max-lines MAX_LINES]
>                   [--slice SLICE/NUM_SLICES]
>                   [args ...]
> meson test: error: argument --slice: SLICE is not a positive integer
> Error: Process completed with exit code 1.

I was just digging into this, too. I guess:

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 673b1c44b9..717bd2763b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -289,7 +289,7 @@ jobs:
     strategy:
       fail-fast: false
       matrix:
-        nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
+        nr: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
     concurrency:
       group: windows-meson-test-${{ matrix.nr }}-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}

is probably the right fix?

-Peff
