Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D061F4198
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112072; cv=none; b=NMW/TAnu+ELdwGMqqWIybPSyoGFwVAA2FkTCmB8pdSJWgCMBi2OH5mfp3KNjoUKjbIMXE1uhTALOjRdXnL/dqsWwi6xFNOzGHy5fZEFp+8VPknOm6eBydQS8DtYqW2BKCxiVehgAerFh3kzfj9LlXepfEwqKhTIZlaG6znpcdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112072; c=relaxed/simple;
	bh=uKG3WxP7828PRm2hfmEwWZz0AHuqc0ED/bISemfaokM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1/g2N1/Zccz/aoSnmydJwItqcXsfSJZDBG6xeMMzCblaJ5vGbI+nz3xEN4tKsbsODjN+OyahA0XPQQNNxXfqUQKHJHmcZ4CadIav5kwIbLAfM5ITqfGxrtAlc9bs2hbH2jG6Wza8HdfEGMQQTOWg3HFgp1k55/jPa0LG9P0qPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QRBiXW+Z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QRBiXW+Z"
Received: (qmail 75827 invoked by uid 109); 25 Aug 2025 08:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uKG3WxP7828PRm2hfmEwWZz0AHuqc0ED/bISemfaokM=; b=QRBiXW+ZT40vqIawSnkAGDyFHhwAUYdv45mGEB9lP0y1tdLVVs3RgPlNxVu4RbONT2ZpGlnULcG25twPv0eGWp0uqyBK9J0qkVHW3q32YBHLjN2phavTZFgtzJZTml/nFE6X4hwUpsC5Arg+b1OQ6Yn5Up8TLJG12n45jRmrXh1xbyRBUm0GEv0oFdzYApC24ywvPqz9uT/b1PDZI11uUJYrIQw1XqICGVdUJk+hiGM2b761QysbawDITVjIvnPsED/uPVVT3SWqGxbZAqdnWEdCmdIB8M1Dyc+pSKuZQE2GCxD/n3/yJRwweLlqpCGFBdQIF6P1n3Rb+xmmWioahg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Aug 2025 08:54:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 151130 invoked by uid 111); 25 Aug 2025 08:54:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Aug 2025 04:54:29 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Aug 2025 04:54:28 -0400
From: Jeff King <peff@peff.net>
To: Ben Zanin <bzanin@gmail.com>
Cc: Dan Allen <danallen46@gmail.com>, git@vger.kernel.org
Subject: Re: I use whatchanged!
Message-ID: <20250825085428.GA367101@coredump.intra.peff.net>
References: <83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com>
 <877byxbtiw.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877byxbtiw.fsf@gmail.com>

On Wed, Aug 20, 2025 at 04:57:43PM -0400, Ben Zanin wrote:

> When I test that by running it inside a working directory of the git
> repo as of commit c44beea485f0f2feaf460e2ac87fdd5608d63cf0 / v2.51.0, it
> looks like the output of `git whatchanged --pretty='%at'` and that of
> `git log --raw --no-merges --pretty='%at'` is almost identical but for
> the addition of a couple of extra timestamps in the output:
> 
>     diff -U0 \
>       <(git whatchanged --i-still-use-this --pretty='%at') \
>       <(git log --raw --no-merges --pretty='%at')
> 
> ...gives me..:
> 
>     --- /dev/fd/63  2025-08-20 16:55:36.936065126 -0400
>     +++ /dev/fd/62  2025-08-20 16:55:36.936065126 -0400
>     @@ -39,0 +40 @@
>     +1754972997
>     @@ -3773,0 +3775 @@
>     +1745540054
>     @@ -18102,0 +18105 @@
>     +1717188675
>     @@ -210119,0 +210123 @@
>     +1179951046
>     @@ -243728,0 +243733 @@
>     +1113865892

Looks like those are cases where the commit is empty (it's not a merge,
and has the same tree as its first parent). E.g.:

  $ commits=8d2709d075d65ba386a4dac157129ef868c283e5^-
  $ git log --oneline --raw --no-merges $commits
  8d2709d075 A few hotfixes before -rc2

  $ git whatchanged --i-still-use-this $commits
  [no output]

The culprit is the revs.always_show_header flag, which git-log sets but
git-whatchanged does not. I don't think there is a way to influence it
with an option, though. You can simplify history by giving a pathspec,
but that can have broader changes (e.g., it may also simplify away side
branches).

I don't know if that's an option that should be added before declaring
whatchanged dead. Arguably the git-log behavior is much more reasonable,
but I don't know if anybody cares about being byte-for-byte identical to
whatchanged behavior.

-Peff
