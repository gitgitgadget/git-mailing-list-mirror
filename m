Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153F32470F
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646978; cv=none; b=T8c5pV1qEsCDN2svL6SuKwAS/1T76SUXtjAVAurTFJ8yTIP+YfmnNjjTP0WBW96x0kGBg8aGptjnpp9tzOOA8auTfI5FQpb5qYmfsO0KEdqgxff4hfTGCd8w0mSM5zrcVQvzAc7w8W0mCOEASjLLfyrXYr5yacKo145nZHebVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646978; c=relaxed/simple;
	bh=tQ60WXY44ND8928oyUsIq51XOgN86rvxWdAlp7aBQz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NsZc/f9mftOUgSeL4Ro++EpQYp5uRU1DEZvhycQ+Pq08bx0j7XgnsVnJLrbSwHVPZ1fq71F9gwZVnXaUgWtMyhjs3yhSoAwYo13IEnYR0RDcdsHoaedq70Frd0zwyV/BMw/1pNHi2rueGzZ6NJwFC9V1iMT2GRumJKEznT1hpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oqxhxK0d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LowJ/eD3; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oqxhxK0d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LowJ/eD3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 02BDCEC01BD;
	Mon, 28 Sep 2026 21:56:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 21:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790646974; x=1790733374; bh=pb53s5+SqL
	f9hh8ZBQT709vTq2aOa9BsL3Yw4qG7ubY=; b=oqxhxK0dqtHrrsxBxkRUEM0NGg
	EqOhoMf/1ImK01vQ1HUoeBXf+wQf8J7BlVh/+F4tUGT8WAFrHcSgl5J/CtI+hfGm
	VANh3loE0qxgw1UH2Bua2BALRESBtZ5nn2Kidwk4+T1zZZqeRNYqIhv6//rqL4no
	E4xG+8Vya+O2KnyEUv4Y/n4kMEdELz21aanhwAKyh1LmEZWXpSpbQOqJFAzsMVPz
	YxARRyjHwi7Ew+meKUSADCs9c2fxZOnzq8U68WmrHkTD0Fzw6chKou2VHrjDx4e7
	5G8EQnEBAh7OiXXmMtuLf6cG/lyl9Q9TIGocGFFBqHkdvQ63N06gpuVLMX0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790646974; x=1790733374; bh=pb53s5+SqLf9hh8ZBQT709vTq2aOa9BsL3Y
	w4qG7ubY=; b=LowJ/eD3fxN3ASH+lpGrqsN8x5rsaM/+fq62BM8ItB55SEFZKm3
	t0aVoFbp6IOUo1BH5kZcwwnuvXFzfoPkTzE0FXlgKin3JiCTvTtaApbvZLko7XxI
	cYT3a6Piaj0h/m/otgV4kV3HjSOyJ+xxW46OS01T5I6iyfZcSWhys4MVq0aC8PM7
	KygMRTuaCC/7YEgQRvgwX2AcK9xnu7ICm0+Yq4aOSwZ1bPIehHCeBE7CbKCqXMtX
	DUiGqTkQsmor2SxcxcGIzawpR/8F/sTkfT7QBBUti8CTW39F9JX33SWWuGoqiBEo
	FqKe0GbnO4VFfHC1URA+HWB+EP0yKxfPI4g==
X-ME-Sender: <xms:vhq7ajRrSw9JZ5qZ2BHURrPZ_P3ZY6jaEBH_3uAol9TXJ0F-jRisGA>
    <xme:vhq7aoeezigdPfzMdO45sxPMlfjBKXGCsPBM2bYLTpLHEZUxJGzclM93aP65IL5nW
    CsUCEvpv1xq56unqLCAiiHSqzu6uepmM68lEHC5LAuwKZGLmByzybg>
X-ME-Received: <xmr:vhq7aioknoE2PJbOonqeA8In3H7ouyNgdKyKn9Y0bzf3o7GTLVdKEt45Kjf5DfOdQlqQoYELw6YM3jXhfof04tg50-XjSn-WryeP>
X-ME-Proxy-Cause: dmFkZTEORuPmM6vAqw+Nu+kwMRSvh6IyBtEpI3DM5ec8x2ZqFbD+FIwz/D0g9XBXc4U5J2
    otlabwH/NfEMYb6yNybQ5Wf1SG7CvD5V5GxNA8lsiTV7oHtqCiImkomkRUkxq/gQzUwnsQ
    KQJ9WuQnsxgpCnogey1X57jyPX9nlSqXrO6WUQn31dwP08/zWR4aO29ICeueGNIKNBKoue
    Af8UVgb+o7xOK7FXQhYGHHXucb46QXXl6aixFkgymJHKQ9pXhe6Mw/XWjm+DWGiiamS1v6
    gayaNrlMdn1OVmfY7QeM1SAvv6oX5RyNe3jU/04fsX2WpiKunrM5sw5TrM85F5JZAnxXnL
    pJ9ss0cV0n8gWwbdbjF3IZ8HI260qX0ruGHWwr3ZLjSnGo2pPor8/ORfFevpo/9KHB+A9W
    foLNy5S283PtZpMpD1MPgt8vHbMmiSYQ3IQKro4q6MAubzKVuKy1i9gS4QcQMFBIrAYEI6
    AMgV6wLa5syS+XlnQJ1rwRyQQ1Mf0a00SJPEfJ4eAf0MC3XVjWL8N6pTsU4/qhjrrJBgiL
    husNj+XgLdgg6vmC60ECL9vmW7gTk3d6wYN+BZh7PW+N1ZbsaK8Ru90wIf+W3jujCVrPmn
    dMLQViXWuXGYoz2mziGzUIiPg2hCF2sCudRazcHA8TiAbznzYr84Fyo0fdsg
X-ME-Proxy: <xmx:vhq7ap-ReOsj0gega1a5adwDQCXBkMePifNWWODrVE0xEOcq_nBsww>
    <xmx:vhq7auepNBxTJNoWGDx2EAlE1C6RiPuBRQFZ9wMJxnOiFjTAoLQeEw>
    <xmx:vhq7ajIANtXiJFp9asn7bsyXDo9ocp5BsLpXMJ6EotMQibqaI27u6w>
    <xmx:vhq7auh3S-TerxUHLutcjZ9rq87m6b10-lb9CEmez59iVre2Lppe2A>
    <xmx:vhq7avBS_uIV4FfEDCGBXccb0bp43dO9WJDZGPDcsrNxFG-xc7rRZRjD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 21:56:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Julia Evans <julia@jvns.ca>,  Julia Evans <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
In-Reply-To: <20260929013233.GA1089022@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 28 Sep 2026 21:32:33 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<xmqq33uyz3yp.fsf@gitster.g>
	<20260924233726.GB765100@coredump.intra.peff.net>
	<01f196af-3a6a-40e6-86c9-f8b4ce7bfe47@app.fastmail.com>
	<20260929013233.GA1089022@coredump.intra.peff.net>
Date: Mon, 28 Sep 2026 18:56:12 -0700
Message-ID: <xmqqse2skegz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Sep 28, 2026 at 04:41:54PM -0400, Julia Evans wrote:
>
>> > I think that is giving us a good signal, though. The guide should be
>> > mentioned in command-list.txt, so that it is linked from git(1).
>> 
>> Thanks, will fix this (and will move the conflict-marker-size change).
>> 
>> Should I be trying to apply my patches to `seen` before submitting them?
>
> In general, no, you don't have to. In this case it turned up useful
> ...
> If you do want to look ahead, I think "next" or "jch" is often a more
> useful target.

As Julia is working mostly on documentation modernization, what you
and I view as an advantage may not be as relevant to her as it is to
those who work with code.

Regardless of which "more advanced" branch you pick to cross-check
with other topics in flight, I do not think you want to apply your
patches _on_ that branch.  Rather, apply your patches on a stable
base (e.g., a release tag, or the tip of then-current 'master'), and
make a trial merge of your topic branch into the "more advanced"
target branch.

Even without building, you may find merge conflicts, through which
you will learn what other contributors are working on in the same
area.  You may run git log --merge --left-right -p right there while
you have conflicts, and may even learn that a helper function or two
your topic would benefit from have already been written in their
topics.  Even when there is no textual conflict, 'make' (just
building alone) may reveal that an API function your topic depends
on has been updated by another topic in flight, and the result does
not even build as a consequence.  Again, you learn about the topics
by others that may be very relevant to you.

If you are working in a fairly isolated area, none of the above may
happen, of course.

> A topic on the seen branch just means it was seen by the
> maintainer, and might not even pass all of the tests. Whereas "next" is
> fairly stable, and "jch" is (I believe) what Junio runs day to day (so a
> subset of "seen" that seems pretty stable).

These days my personal rule is to make sure that the topics must be
in 'jch' before it is marked with "Will merge to 'next'".
