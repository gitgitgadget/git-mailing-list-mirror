Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F41DDC37
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577385; cv=none; b=MCDn9kNuDJSMBxpdZ7bgfY0SWHOcl7VrrTZ5Qupeo65CoNUBZxYMrMRdKaHJFIeOIhv6vHWAUOE3mZ2YHZaRgqoroeNZA51qW4SVKfs1R/eX1WGE0U0P2TM3zVKgs3DWXvU3ZJPvHT1+OX/jpbzU/kPaLVf4BS9ZwXyVXAbkCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577385; c=relaxed/simple;
	bh=Uah7mDvTSCf5gZp+dOBxsi0PcRsGnhVQ3iR/UTQLfic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJCsyh1VO5IUJyFs/inrAbIAiZLkH8AZvb8mh9QGZBsG3RNn7QLGI+S473iN76HEhTnW/ajRP5lQEHIV+IhxpEhrGxJyi7JA9ofktcVn7biwqKqYb401O2Jn6RKmqVCst/bY3zSyrA/bsdT2Rg5NUbg1f6+qpTfpTLpXRddAZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DFCRzaxO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x5MwyhCI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DFCRzaxO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x5MwyhCI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 50A1CEC00AA;
	Mon, 28 Sep 2026 02:36:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 02:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790577382;
	 x=1790663782; bh=eDhVt3SQe3gq29vHytwH99ZsYZTcCWfXPzu/QIPgHDo=; b=
	DFCRzaxOiqnEz5NmimKIUX/p/4uArRymOJTIyDWdzrXmawCOOEzzaCY6T6QpTXXZ
	KXCGO9Ib+WS2Nq9jPSS1MFYFNm/02LWPrg1a6FycG5NJK8jNCYsOgOG4M2HISzIq
	nd5jtZOBU9GZIGWGKbXfpLuFYm1+pubMj6TOd/qPVJbML9njYxCC8MIt3NsPX0P3
	Q+9DGJbQHEKvIk/7Qqd6NaHCDsNYFJXXyiZn+c6tm+lS+r0xxjGYJISZRj7NDV4n
	AtFCKHHBEEIzHnO2o0/gnjvRbVuQeg65eQwFAPIHPBypeb32x8EDGvEqwRM6d/52
	D28uuXM0fepe999risxRjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790577382; x=
	1790663782; bh=eDhVt3SQe3gq29vHytwH99ZsYZTcCWfXPzu/QIPgHDo=; b=x
	5MwyhCIRSuiYIsvPMlTGvMCg8RN5XB1KyLxZaafddSmUpVlae5OTye2qGB6sPdE1
	GhozfxXloDxBORwSPQElS2/ZDcbWu+es7gf+qWTjV1pDuoJtoVuiG5rOg1ciIIbW
	FZ9c6MjAOGHQXZuYvkO7JEcHijCVUz2QOMM1+GP8hZ6//9kfiJSQ6QW8rKCHBUhO
	9fbIrAO+WmBTwn5CId4/fRJvOOxDpY4BaLhDK9WALL/T6W/cCzMGIPDrWQ7+z5ZE
	ZDcwL2YfsIU8SEqy2/K+2iuJ1CrbLE052maXJ+s/Z1FjY2br8SPhj+8T/fi2yhz9
	wVWu7TmMMX1TBMEXNYNbw==
X-ME-Sender: <xms:5gq6aqfOT3XbRX-YuGfFujvofPoVAgQT2iX0toB36CgUhvO8JYAS6Q>
    <xme:5gq6arr-aqxCFeOpKxDBIbMK6W998s2v5nPnV2s9dpuC5g801hYMMWaR2VbFhNr_G
    MqDN7QEasPF5D-qTldwWqJtNqOa133yNBdUhS6_7Z3miAkyDfkw-tKu>
X-ME-Received: <xmr:5gq6ao6ZX97GpFn4FOOX7gNRqCK1KsxDr15Hg2e460T_CWZG4o1YXA>
X-ME-Proxy-Cause: dmFkZTGz8lV18ZGTSLPpb0EH2of5DOr/k6py+yVss6fkiaJA9ZmzWX3mVmt/J6Tr+fo1mx
    SsAjL6js7JxmSZexQcJZLMM67jYiLa9z7lSjvnX7L4DJR+R96Ov8dqLTMehRpPfg4TRaXi
    Wb6DILIOSyLTRPA6NhCJ3F+Yb5gwHLtGLTvuN0iHGMdNttZZjSTTnwCz+kvc9T99bk31cc
    spMddvNS4ZWCcFjuj1SGybIrbQ3xSW3maMqJwPDM4Ob6yG6gFicdLe8m3Qk2RCEQZFrWhw
    MEeZ5FXLjPdre9slnTeVwnJL0hEKO+lcwZCcBse7S3cYKR5PTvx7ie0sqXe+/IbOe0emFY
    At0KDp8QvyUYWPuNjN1ixUQgqN4j7FbCdryzUO/7bIrRiu6d+KjT828qIa6SSvpOjrVpmh
    GJ3JGplIP/BeQtCVDEhZiqreRR/ORFbPgDU2XQztgp3r6OiwF9XWBU/Ncw6DCsGTBoE9xm
    mHMwwPHjvkAWOAoRz1Q5Q+LC3KemyD9RQSurT5S2pnV+jiAyxp4apJzNMGb9ffucq59XGM
    tAJkXoU0d7EjOrnJlzGIp2yESjQWyJR8ThXKmYQEz442wrJl1VDNiq1ZqcjxqMFbpBH1Rs
    6RePKjunmQqfG+D9kSIRAf8FwPKul3XX38eH0Q1J/b1/IBMJaxuqKO2upKaQ
X-ME-Proxy: <xmx:5gq6ahp5XC67SEoZ8T8J-swej5LMszKDswS0g8dZtEcJQbaOczihrg>
    <xmx:5gq6aqhnhmzOJwRJXeOsnu19Lg9FVt42wFm7DmijKXLN6HgSyN16KQ>
    <xmx:5gq6arKTzD_UH2r5aZVLOtECPubDEkK9jtrEQo3worH9T0bmAy0ekw>
    <xmx:5gq6aqDYt-h8jCzJoMh9XHsCIx6bMuBVeKZrUXgzkY3Q-g6T-bDMFw>
    <xmx:5gq6anqVyqtzjYFhA9Yom8qjKrfTMVYUl1xsmVp-8Nx33soVlt-eFPYE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 02:36:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b3f52d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 06:36:19 +0000 (UTC)
Date: Mon, 28 Sep 2026 08:36:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t4205: compare huge output without diff
Message-ID: <aroK4d5GZ6VoFUim@pks.im>
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
 <20260923-ci-large-test-resources-v1-1-c28416d59475@gmail.com>
 <arS_l1hPIr7I2Gn-@pks.im>
 <CAJ-ks9kJWc0e7aEX4vAL-RoJ5kVvfjDABqV86_hZf2Fn-085GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kJWc0e7aEX4vAL-RoJ5kVvfjDABqV86_hZf2Fn-085GA@mail.gmail.com>

On Thu, Sep 24, 2026 at 04:41:05PM -0400, Tamir Duberstein wrote:
> On Thu, Sep 24, 2026 at 2:13 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Sep 23, 2026 at 01:13:28PM -0400, Tamir Duberstein wrote:
> > > The huge-commit test compares two files with a line larger than 2 GiB.
> > > In Linux GitHub Actions jobs, git log produces its huge output but
> > > its subsequent diff process is killed with SIGKILL.
> >
> > I've never seen that failure before. Do you maybe have a link to it?
> 
> The failures happened on a private repo that I've since lost access to
> - but I believe it was precipitated by GitHub runners having half the
> memory in private repos as in public ones [1].

Okay.

> > > Use test_cmp_bin to compare the output byte for byte without constructing
> > > a line-oriented diff. Remove the two large files after a successful
> > > comparison, releasing more than 4 GiB before subsequent tests.
> >
> > It would be great to back up the claim that test_cmp_bin is better than
> > test_cmp, e.g. by comparing peak RSS and its runtime.
> 
> As for the comparison: on Linux arm64 with GNU
> diffutils 3.8 using two identical files containing 2,147,483,649 "1" bytes
> followed by "0\n" (matching this test's expected output) gave:
> 
> Command              Mean +/- stddev       Maximum RSS (KiB)
> diff -u expect actual  5.276 +/- 0.572 s              4199924
> cmp expect actual      0.506 +/- 0.099 s                 1264

Quite a significant win indeed.

> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > >  t/t4205-log-pretty-formats.sh | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> > > index 4be5c51489..6279a7e9bc 100755
> > > --- a/t/t4205-log-pretty-formats.sh
> > > +++ b/t/t4205-log-pretty-formats.sh
> > > @@ -1189,7 +1189,8 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
> > >  test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit message' '
> > >       git log -1 --format="%B%<(1)%x30" $huge_commit >actual &&
> > >       echo 0 >>expect &&
> > > -     test_cmp expect actual
> > > +     test_cmp_bin expect actual &&
> > > +     rm expect actual
> > >  '
> >
> > Hm. Sure, releasing these files isn't a bad idea by itself. But we
> > rewrite "expect" in the next test anyway, and "actual" will be rewritten
> > two tests further down. So does it really buy us that much...?
> 
> You're right, this probably does not buy much.
> 
> Would you like me to include the performance comparison in v2?

I think that'd be good, yes. Providing context like this to the reviewer
makes everyone's life easier :)

> As for the deletion: would you prefer I drop it?

My personal take is that we can just drop it as it doesn't buy us much.
If we want to keep it we should be honest about its effect in the commit
message.

Patrick
