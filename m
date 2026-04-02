Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641F32E8B98
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775173911; cv=none; b=c56eK4oEzb2e+VloZn5s1zjcCdnwV9rx81LnSw1IOrkU9ecb6QJPEr5bDZy6rkLQ0lEVcW3PocLuCtKeKN5TEQ4vNL/B3U5ONOnsZTeDO1/BAL+d1PQ/VdfEsvxPzT7l28kR1a2fGcdLa5jYlrym5JxJGWs7xlPixNkqqSMpmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775173911; c=relaxed/simple;
	bh=2C6fwB1NvU7beF8NJOIou4Wgoz0YyefDlhvB4g2advI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMQMJoYsa/i2/huXq4s3Erq8/IY4s7p8zGoJ9dYlhkvGcB5lxMjm/UuQxG//B62V6ujUB7PmthAqHUJssVXB6MHXsFKr+HsuiXjvpXy2t9xZDsRpdkdPrfUL9P70N7c6SMKlarpyM1O2nvjYEKufMnbLOePz1ijMPAkSA1BIGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WTDwMCBY; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WTDwMCBY"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a154cc6a48so18698196d6.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 16:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1775173909; x=1775778709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2C6fwB1NvU7beF8NJOIou4Wgoz0YyefDlhvB4g2advI=;
        b=WTDwMCBYPUR49U2Tv2FzFL2qJlIL9kXJBk9rNB+Yal0aFexOF8u8t0RzeS+WNjwEoe
         7AzMH8NxXfY3YQZn5k5cy0cnFZSPAwHSy+PvokppqHrQqceAa44eVCU4UFPTAHHi+lcz
         utO3EbttqiIQ942X6Hs/4X+A3Be+DU3Py8trl7NDS6eB8yDcunP8WsAWatxQcDNSedWY
         nKf1giDOBpUJ//+cE4MMI3qU4ZpdpstfLfu2GF3nS8lcXExrwOK1BRPUkmVmcbxgcKCG
         F5t9AzFqWeCUBFZSRzzwepGP/xKV/I0pNncJU3gC27qztyrWcn+p1TDfNujNgc0F3ZPE
         YzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775173909; x=1775778709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C6fwB1NvU7beF8NJOIou4Wgoz0YyefDlhvB4g2advI=;
        b=gqwRcrFtybWX0gvGv5vTO2jc4YHE7Ew4U2w1TRcev1tSrvPXq+kJoo3XDbhhgh6G2a
         bFJYzXnaUwWmaZNE7iWYl+seBBE/vz4qz+6jMFsPqrv10NWK3DxKlVjzOUe4bp2lUJ8e
         1YUQUtqZp03+92HfIWb+19mqSCUn/BNtEhLRn9omubkprMQZOmdpje+mJ+RMLpz5tXOB
         fZ3QPWxr+e6fZua8e31ohgYOkZiZJweMUlHmj9rwk8ZggHvej9EYG7Du/zl9kQbPDzoy
         mmWlouYxEOLca3SqwBGtPGXhsh87xEnSQxHHv6I06Ri/S8RadCWY0xKn4rass1Ki3bXR
         00OQ==
X-Gm-Message-State: AOJu0YyVKAG7NUz7OyCoOWiR/yxQSK0hSOIcVnyJ79hNuUnkJvL3maHR
	TVAgpQSogj2sf+9gD43Z5U3JQvgnkGzg2vxnS7mMU0FAolpOnYJ8F2sbgfIJQLgzw2w=
X-Gm-Gg: AeBDiev8bFl14L3G29AI/kLdH/iWW4NY6RGiTtbbcnWJFkAd1xhvEw2I06SqlKbmdjq
	3yjNEVgpUFS02+cFI/EiF5MNtvhB6KeRal/iftHVAWaGp0c126F9QFSmpr5vN3uQEmZ6Wp+CvZv
	sx3RhjsqjwNUJ4jGML4Ga7aia7oB5DE8Z19m+GHljsrvQTTPZABrFsJnNA5xsqQpP7KOUMCq0nb
	LVF433ClRja40+iWIbxaEggu4KdXDKUP3ezr38+8nsrQugAHIdPEb87Tl/fRKlM9iqL3mg2sGHW
	dxxkh5IgbPnODnDBKTpqFuXpAcGT8KghKLlJdBH7lXghYJjx1Xj+BazNjJHry2LYa+btq+R9xEc
	YgX6ckZfjJW8f01bA7L1yk+1JQsBhuy3nPa1xOtrgbfWQ2LyCYDdosJu2E+M8rm67WPoqYD9HvS
	dVOqplkwWQV8blEYyvlyX7xtN+VsZZr2TtDdDWwBSFKApuZvsbz0g0QVF8wBKbPudmyWJvAfQUU
	66+whnX6E8RpCM3inop+ggHz5FD2g==
X-Received: by 2002:a05:6214:3bc5:b0:89c:e5f0:8f23 with SMTP id 6a1803df08f44-8a701ecf235mr19470546d6.8.1775173909314;
        Thu, 02 Apr 2026 16:51:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf2769sm35465596d6.14.2026.04.02.16.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 16:51:48 -0700 (PDT)
Date: Thu, 2 Apr 2026 19:51:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 07/12] pseudo-merge: fix disk reads from
 find_pseudo_merge()
Message-ID: <ac8BE4StG2bJbFFc@nand.local>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331234622.GG2328529@coredump.intra.peff.net>
 <20260331235637.GA2328851@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331235637.GA2328851@coredump.intra.peff.net>

On Tue, Mar 31, 2026 at 07:56:37PM -0400, Jeff King wrote:
> On Tue, Mar 31, 2026 at 07:46:23PM -0400, Jeff King wrote:
>
> > So I think there is something wrong or missing from the test setup, and
> > this bears further investigation. Sadly the answer to the second part
> > ("does it work now") is still "no idea". I _think_ this takes us in a
> > positive direction, but my goal here is mainly to quiet the compiler
> > warning. Further bug-hunting on this experimental feature can be done
> > separately.
>
> If this is the wrong direction or if we just want to keep things minimal
> in this patch series, the absolute smallest fix is probably to cast away
> the constness explicitly in find_pseudo_merge(), along with a comment
> that the fix is almost certainly wrong. ;)

This approach makes the most sense to me as a band-aid fix to squelch
the Coverity warnings.

I pulled on this thread a little bit over the past couple of evenings
and found a fair number of pseudo-merge related bugs / oddities that I'd
like to fix more comprehensively.

But this is makes sense as a first step to quiet the noise from Coverity
without rushing the other fixes.

Thanks,
Taylor
