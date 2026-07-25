Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C11175A95
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784974247; cv=none; b=R9y/orEzTCqtS7wWlG9jv0ZWMT2soENT8OJXlWiNvCGxq0GgSFHNrizt4dH7Al5L9M3C8oZuKe8P4tHjb0H/Q/e8Iip+zk7mPFjr3S4lvvGisoqOgO82Ygl6snIycyQqUoKgpLtBRyNkyFXIoAEhAS/zB2hAVPXOFEbeSzYLQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784974247; c=relaxed/simple;
	bh=w8oPDjFIBSiMfTrg2CZkc8sDfpex2sDbQUTBIYi6WUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISxEy5eb/2r9/zEsrZmzBr4JpsgZ0MNwUBdwntwukjF5Uf6kJuqSGpKHjChkQzy8d9Y607JXqLoxiL4UTJZsPABLn2AE2EaxJEpoRalGFw+dqp0f3piT8Jl2NCvR/AAPrQP9vsFYlUIyVCfmmU2UAuGjgV4FrlrRUKVBXcpKZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RSs0IyO7; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RSs0IyO7"
Received: (qmail 45860 invoked by uid 106); 25 Jul 2026 10:10:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=w8oPDjFIBSiMfTrg2CZkc8sDfpex2sDbQUTBIYi6WUA=; b=RSs0IyO78mSaww/f4sFow8jJbjtExDoZICV4otT6qD4FxWdioD/R5GNKqarQAhJ0kLSHQ0eQ3nTqkHDv2+lE1KkSX9rFChRr+2T/PwiX5nxtKkyk5HyKcNePJqXmLixuI8o39554GVpK22B71FanMFhKXZ6+xr0Qj8DeNEBuwF/ZnodKin5IFDhd5d2RVbcitPkwxNyXHhBmRYjxqJMVCZyEuYBIJ0zP66XgjYSEFFBhayI4UV4G6HQ+ccWzTfhpI3B7uL0fvrhvwWh1g2E1sDkHNXXYJvRmZYOnpDHN8dtWkgNqWb9CkEV/hyxtIocrSH5/WYJNn5GdQNQg3cj0tg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Jul 2026 10:10:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 45711 invoked by uid 111); 25 Jul 2026 10:10:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jul 2026 06:10:49 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 Jul 2026 06:10:43 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	me@ttaylorr.com, ps@pks.im, karthik.188@gmail.com,
	sandals@crustytoothpaste.net, avarab@gmail.com
Subject: Re: [PATCH v3 0/3] packfile URIs: support concurrent downloads
Message-ID: <20260725101043.GA2171844@coredump.intra.peff.net>
References: <cover.1783982021.git.tnyman@openai.com>
 <cover.1784676106.git.tnyman@openai.com>
 <xmqqldb19evx.fsf@gitster.g>
 <20260725090910.GA1438796@coredump.intra.peff.net>
 <20260725092154.GA1925154@coredump.intra.peff.net>
 <20260725100251.GA1933232@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260725100251.GA1933232@coredump.intra.peff.net>

On Sat, Jul 25, 2026 at 06:02:51AM -0400, Jeff King wrote:

> I wonder if we could just drop that "test -s" entirely. We'd _usually_
> see some bytes written before the second request starts. But it's OK if
> we don't. It just means the test is working in the reverse order (the
> second request may write its bytes first, and then the first one is the
> one "overwriting" it). I.e., the two are symmetric from our perspective.

Yeah, doing this:

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index dcb9667eeb..07aa218049 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -516,7 +516,6 @@ test_expect_success PERL,PIPE 'concurrent http-fetch --packfile cannot corrupt a
 	read ready <&8 &&
 	test "$ready" = ready &&
 	test_path_is_file "$tmpfile" &&
-	test -s "$tmpfile" &&
 	{
 		GIT_TRACE_CURL="$TRASH_DIRECTORY/overlap-second.trace" \
 		GIT_TRACE_CURL_NO_DATA=1 \
@@ -533,9 +532,6 @@ test_expect_success PERL,PIPE 'concurrent http-fetch --packfile cannot corrupt a
 	wait "$second_pid" &&
 	wait "$first_pid" &&
 	wait "$server_pid" &&
-	test_grep "HTTP/[0-9.]* 200" overlap-first.trace &&
-	test_grep "Range: bytes=[1-9][0-9]*-" overlap-second.trace &&
-	test_grep "HTTP/[0-9.]* 206" overlap-second.trace &&
 	printf "keep\t%s\npack\t%s\n" "$packhash" "$packhash" | sort >expect &&
 	sort first.out second.out >actual &&
 	test_cmp expect actual &&

is enough to make it pass reliably under --stress for me. We have to
drop the trace greps, because we don't actually know whether each
request will use a range or not. We'd _usually_ see a range for the
second one, but it's possible it might still see a zero-byte file. I
guess we probably see a "200" reliably for the first request, but it's
not all that interesting.

We can leave the test_path_is_file check, because we open the file
before making the request (it is only the actual writing of bytes that
is racy).

-Peff
