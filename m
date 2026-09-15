Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6106C3D567F
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489537; cv=none; b=NJNplXyzR2OjEOiczQmeKPWQrEnCKRhXQD55WKAfHHSvKNVfSUiDhjKM12vlGNs8dUF15LXJxlf+VS/swqsQThiFlGfgQhDBSAw3Uwt1P/eqyHZRYm5fKHQZwvoZv7SR8mqr1Q0bxIAf9cPKec4MutrlfTeV43Pq2hw6aWqwsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489537; c=relaxed/simple;
	bh=dJsqMPQN3ngYG5qZTgXyqqu7b6/sT+NEqi5kfg59e/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jc0GWNQW6knjPaORJt8MNMCZ9nLdQGbqdfqhs1IeRCHxlo9SCVki9e4F9dzIl6Ol0v2zR7THrH2oaTeZ4RRtImzL8twkrvTSDFyxRNsIMFX71CQ3kG/leY5W8r25zOkua/loSHEOGK+b4hHlGH7WpJ8UYAcONKfkFdUfP61MFkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gluV725z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wUTSMDab; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gluV725z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wUTSMDab"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 387BA1D00233;
	Tue, 15 Sep 2026 12:25:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 15 Sep 2026 12:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789489534; x=1789575934; bh=pJ1HpEJv5Z
	YWDuMhWJD7eL9U8DBjhCNX2+dUPOuiHz8=; b=gluV725z0VslOCjKu6Wrb36Sre
	r5trkxe7WXMAkci07wzxGIcrbtzDU6H46doN98BiyQBaBMSippJLZLHjFBI1gbjG
	E9RWBNaZ2fuHtEkd8pF/MWwBQ47UFTuqC8pXUTLT01T2mg5bYEkJj7v82kgAQcFc
	07KVBSbhWWaER/jxhHcnT5SIc9fqKI690hfXx/1ThBo2QCgDlGKqoXMSjozEuXOg
	5xKG5kACeLsWE9I8LjIJtsaU+eiesQkJ2Xo2W9i5Et1Q5QyIpx5RRZvFUmHivx10
	pkG6xpRe2j4QFKcg1YZTazjQ/SznSjrR4xDXJ/TIFiDEdEWoZIpTTjJ/cFLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789489534; x=1789575934; bh=pJ1HpEJv5ZYWDuMhWJD7eL9U8DBjhCNX2+d
	UPOuiHz8=; b=wUTSMDabgZpCj/O41zOpwBLZcHnCbVBpTnj0lGa0HTMJ2tjiy4/
	9Z+BpC9aUj1aeTuyfueFTQludVGMbPg6Dx/8zfSUJGUKgfzwlyU9QRlO43YJWNUm
	+wlJPLUrfHTWpuA8u7RybXU6BViygSwxI3ai3V/ko1ciqaPRAMW8vBdK2UUuU7BX
	eY7Ckj0faGRPqEdrrDJNOx5CefL3UAxBZRYGD2wh5EesvC6B/ufYXNSZI6bgx5Xp
	z36F4JpxZEmqBvXYhvUJsHEbIkLZorIo9K5hd5UKzJg6UY3HPx87Mnn32uVaOmd5
	Uv1Dxunf2KDGDWam1GFVQ45dhLVeGx12/eA==
X-ME-Sender: <xms:fXGpat2jhwUS8MTKsWF1aQo7pI-fHCcLnEfy98LLh5xUk88vuZsvUQ>
    <xme:fXGparET5FBybHJV_umgdgcQhhlwcqeWld6MAxAEq1eOK1NXeFnvHxXDYMpfBSnL5
    4JkbDl0VxW01NCgJRO3ayjxULvJ0wLPsfrBxZepT5OfP4QvXy50Dw>
X-ME-Received: <xmr:fXGpai52422uXVseqZtmefyiy8Qnzl1Li30R8iq-KzXkAFdHkYGc71eZQpD-lrTpAgsiTUPAGwHOjhJIpoqmesVp3ztfDBG4bVbX>
X-ME-Proxy-Cause: dmFkZTESWEpRvZFS2kx6B7tO1kLxmTy31V3FARIORbMcTZay4ap2PbxQEUsz9NVk70y1sP
    lcWpDBzxbi9uCbHi0q5LoIwIVosFQgx1ktR5AqSUu3AXOrjXvh5qD75OW6RwK5G09Mx0Ji
    HFTO10uDPPl22iDa3jdlMcEUbbKqm1fJsLjMx77qenxq4u874xWUt0i1YeDaoYAX4rxl6p
    f/RGB9T7ILlMXBAQMzDU/iqWwW6xhCByUY7ytc62I0Ah0KGt1x0N/6I4qHghwNMMI5LU4m
    rZqXsxXbKmRgceRVHaU8GZfSmPFGcab2AijSrwyD8giCIDvf1YZnMa0xPvz+jnGoBqPJHg
    URspHA/s0QDjFiOUfruMyv1NgEfMfucG56DchwDZMPoVM7dQrMTncR5LrnkADUfHiCQqx1
    mUnhxFlarzGyA9aPt+60oB98WAYQC/rXWPe6R+4pDaa5QMUIGiQgJobcey+h+ZG4DM7U/W
    OmMCPcUwTRnCHIealbd5FlBrldEiMt7HcU48gQPR3OqH7ggXmdunrfYdQjQTE6uTAqjbQ1
    bsuSG4xrQoxIMFdQnXL3JFLycVWaO7WZ44ArBNXXBb68RNSHBUrLUL/PSKuY47KbWxmf44
    D5GxyecuX+RRQRDrKjGE7yJjEHULXUc6odKl6DRYNzNu/vrYzxL+go7A4BIg
X-ME-Proxy: <xmx:fXGpapuzjtXROemX35_ZNGaqjbigOIPeR4L0k3od8JkakwCqCVoS6Q>
    <xmx:fXGpar7wRM3aqUSKMouJqzn4YJEZUPPSXnzYiIiCngMeoVyesjAEqg>
    <xmx:fXGpasWCY1i95Fp0sD1zQWUzAoLh2yP3N8ACJHL0d0rxeKJCmkgK2w>
    <xmx:fXGpal-_YvXRbbU09sB8ypxt25MS8QAPx3EYWYZsu8c5rgeE1at-JQ>
    <xmx:fnGpah2oGHsN0-k-6zBdkW3TDZGOLY-qElPqguK2fyMSdkHH6_eMQZxK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 12:25:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] doc lint fixes for pack-refs and refs
In-Reply-To: <20260915131036.393249-1-tmz@pobox.com> (Todd Zullinger's message
	of "Tue, 15 Sep 2026 09:10:30 -0400")
References: <20260912191509.844954-1-tmz@pobox.com>
	<20260915131036.393249-1-tmz@pobox.com>
Date: Tue, 15 Sep 2026 09:25:32 -0700
Message-ID: <xmqqpkye1nyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> I was reading git-refs(1) after noticing it learned some new tricks
> in the 2.56.0 release notes.  The formatting stood out because the
> first two commands, migrate and verify are bold (in the man pages)
> but subsequent commands are not.  The HTML is similarly affected,
> with those commands colored differently than the rest in our online
> documentation:
>
>     https://git-scm.com/docs/git-refs
>
> This is due to inconsistent backtick-quotes.
>
> As git-refs.adoc includes pack-refs-options.adoc, I updated it to
> consistently use backtick quoting and converted the only other file
> which includes it, git-pack-refs.adoc.
>
> Changes since v2:
>
>     * improve wording of pack-refs commit message and change
>       "configuration key" to "options".

Thanks, will replace.
