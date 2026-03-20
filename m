Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE440DFC6
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773987535; cv=none; b=KoJV/VArKxOJBgnn072MYiZtqO/sv+pRQqr8n9iSrge6K3qYKDbPF640dxjaBpMEfWyQaHQUxtgffRq2LCE5q0UX2wGRa21JHMvWl3g3vaBXQOdyLdnCieH+hf3bzPkZlE/rsrom5tg4I3I8EGPxmWcAkqsyr+8t+J125kJIuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773987535; c=relaxed/simple;
	bh=DhurKSUJ4qLVluKDFxB89P+GW2spKCUzXB+5cxTVyG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7iB7mCSwQbcuqo4CnOOAByy/s7IaJgBe4nUvIqtYI+bgSLsa5jTFkyvk2AoOYJmDznPz7KMZ9nnp80DpcPYkhB+dPrG0SCX8TeSuS3hCQI/wWjEYcQA297dEOHSgMHHXrxij8MnbU1XCDeMaPc3Iw30uIReB2GqEVwAr70bPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aPAHSNmT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aPAHSNmT"
Received: (qmail 65691 invoked by uid 106); 20 Mar 2026 06:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=DhurKSUJ4qLVluKDFxB89P+GW2spKCUzXB+5cxTVyG8=; b=aPAHSNmTNJP33W6qh6Ryn6YFNMTH3e5eT+Ewe7/2paXcYKXyk5jGaqS4rNGctmQQGdIDuULIjCC4J6B66kNFoOzId+skhFbSEZTRiOh88albJS7pJDMPF5kyh6jPdgRTuj3kSLG+Tyd61dBP1XT7MgmwnPsHxlwV0JSxGKSq1iUZPxbafbGVLebUKBVzbi0frz8xc7fJq30sgV+UlTW8KVuUkKD75RlzCsP++XZ5x3OKjOjVKgohU4QunPVF7E/hcgxHuZOr9qyzliyCCqdIfGBsXuSbLyDdHy+KPU7I9XTHFH2rCVZOrYiB9MSpUt6Vg2MpOZ2XJHAGTAf8K/REHg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 06:18:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96039 invoked by uid 111); 20 Mar 2026 06:18:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2026 02:18:52 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Mar 2026 02:18:52 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
Message-ID: <20260320061852.GA35538@coredump.intra.peff.net>
References: <xmqq341wnvbk.fsf@gitster.g>
 <xmqqcy0zii0s.fsf@gitster.g>
 <20260319233546.GA3632561@coredump.intra.peff.net>
 <xmqqcy0zgtmu.fsf@gitster.g>
 <20260320041803.GA18125@coredump.intra.peff.net>
 <xmqq341vgilb.fsf@gitster.g>
 <20260320055709.GA35291@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320055709.GA35291@coredump.intra.peff.net>

On Fri, Mar 20, 2026 at 01:57:09AM -0400, Jeff King wrote:

> I haven't measured to see what the exact cost is, but I know that
> looping over a strbuf (with a reset in the loop, or the implied reset
> from a getline call) is a common optimization trick that does have a
> measurable improvement for some cases.

Try something like this:

  # input file is all objects in linux.git
  cd linux.git
  git repack -ad
  git show-index <.git/objects/pack/pack-*.idx | cut -d' ' -f2 >input

  # now do something that primarily reads a bunch of lines
  git cat-file --buffer --batch-check='%(objectname)" <input

That's a somewhat silly command, though it does do something useful (it
checks that each object exists). Here is master ("git.old") versus
applying your patch ("git.new"):

  Benchmark 1: ./git.old cat-file --buffer --batch-check="%(objectname)" <input
    Time (mean ± σ):      3.152 s ±  0.057 s    [User: 3.067 s, System: 0.085 s]
    Range (min … max):    3.048 s …  3.225 s    10 runs
  
  Benchmark 2: ./git.new cat-file --buffer --batch-check="%(objectname)" <input
    Time (mean ± σ):      3.377 s ±  0.065 s    [User: 3.295 s, System: 0.082 s]
    Range (min … max):    3.279 s …  3.480 s    10 runs
  
  Summary
    ./git.old cat-file --buffer --batch-check="%(objectname)" <input ran
      1.07 ± 0.03 times faster than ./git.new cat-file --buffer --batch-check="%(objectname)" <input

That's a fairly extreme example, but I think shows that the extra
allocations do have measurable overhead. If you ask it do more work
(asking for %(objecttype) or something) the relative change becomes
smaller, but the absolute slowdown (a few hundred ms) remains.

-Peff
