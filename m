Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1505377AA4
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590848; cv=none; b=QqeKtIq/wy42vE2/73cWeUf0Mnfp2vF2QLapDYuLgZ7x3G1Mj/fDi7PEbUopam3OTmXeNnRsF21s0sJ9PJCbm712DcoqoAmnbAeieMizKdpFt0cY086eLVFIPV875ZfZ6/Y8XZVcMzIo5P5BkHNIRV5Ri1SXsRKmrA6PG811V14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590848; c=relaxed/simple;
	bh=mpqAOxgtFA82guWSj6z56t0YlXGMWO+stFeBDzr/Kbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6jwiI+lrL6UXHtSmtF+rK6Uy63l+mThO4/O1ExFnAy6YV13F/1841p/mAUslBePL9903JsycFd8Bjsodz3x1zOz4L2/FBGgE30kdOanprXY96KyPKhplZPeevdzosMsUMR8iMeBI6nVryh6mPI5t2N0XfZkY1RPIJQ+KW4t9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q+zAzC3A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TYvCQvIU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q+zAzC3A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TYvCQvIU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06066140004C;
	Mon, 24 Aug 2026 13:00:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 13:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787590845; x=1787677245; bh=iL5AD5bXDX
	/iJCrNj546ma6k+/NWRwvpXoyNz57QF2k=; b=Q+zAzC3AayDZGiGCkYO9mtGpYb
	T6UV1nBKk3Lt1aOQzfP3YU8IgwtMV+8B38+m46KKXQ/+VSxvcYwfS75epcR0bUfB
	sTACEYZpzD4sxmOTngazs8LqAv78syN/1GVO42qUlzvB3tUB2oOQO+QWxAYT5cCx
	0lcB/KRWez5c0q6y7rSshXd/Bg1Huim7KdzffB6YqFRSR8TsS7igGSJpkf1juzPm
	X47xnxoLp1h6EeZwOZYBekJk4XhjnEJ1v8FWANHG3Shoqvp/zcxPCiFQ3Tf8xR3v
	VcI+BVdMDgAXBitGIcllcjd3rrXfw6/P2bN5Pz0XpEyqJ0ezdExRvOvc2jWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787590845; x=1787677245; bh=iL5AD5bXDX/iJCrNj546ma6k+/NWRwvpXoy
	Nz57QF2k=; b=TYvCQvIUazLqgHz2leAe3GFy6TkMzYkfF6XjpDeD+5z7tUhm4q2
	y6zZE54cyAoT0Bd64g6FODeMd4J+zlStIul4H2zalvrk0XnNmb4KLl4mEsDZmhwC
	lT+c2ktdXe4+WLsruiwUW8FVIZozX4X1BfXRGxob2SwGZdQg8jtKbsoXRK1pRlVb
	mW8O36D87IPemyZT0/fwUsfezaLtM0f93s12hUbcqyCibWcZ8vJclHBm5f5JhvFF
	I8ILovMW+3TlCZkGxs24br2OfVls88iPt/CQtCDY3BIx0iI5BZLyvwtehFQ/9jr4
	tPfxWCmkntR0hQkr1LlwjEb/4weUX6sJtCw==
X-ME-Sender: <xms:vHiMatIfOG3MWL2jC4Ame3VpKYr98rqzEgnyzUwf1qsVKWKm1VO0Zw>
    <xme:vHiMaieoAUMWUg6zGSASaNzERZ2bNWf9w15sm0Mxz0GQK7jVwa6VldKd4TRaEQHr2
    qM93CP8sFQQRaMJdNHxGeIIfvHBIUREULgktcSW8JC8rgokAH3T6A>
X-ME-Received: <xmr:vHiMas9xMUEUzdNV97f-S4OJRPcYH_Mcc5BlAX2bxgYr-F2cDliheFKSCsb-amPvbd_5MXZLqWWkyQaeXLfk05tKOKdVUcaAokJD-p7bvw>
X-ME-Proxy-Cause: dmFkZTFyI/2DugUrigySZ8bTHIf2Ct/ikH6pb9GTPyUzjQMnitBmWKN92Gnb8GCZL313o3
    mvaOwf/lF9KcehRvK5n1EMwigR5DE5ONRoEjK2cdGBfE7m0RY9HIzUcjJjg4NcTCueoxzf
    FLs5hnzlqfsFV4wa3IJ1ohvoWH+R0U2uhmsaNxk0C1PN6g2MXgWovV2vo5flbJh6V1PTi8
    CBtIE3vSvls3QerJ5f87yr8H4CDuqkU5cqyNf7Ty2phZk87OfO6SXkLQlmaODY+QcsPsAn
    hYMCRMTgV21wwFsuGkg8Xx9ksJn9TguYfVRyRhWEaOvnBK2j+HJ4PQmb0MCPHiJwJZx8CL
    MA7vvWaLnAnHcwr0KFtV/cof1LlYSm+r2BnXJY00OXya/uspo0Au7cr2Rn42+8uNBV1Xet
    LBdQKu7mzugu4XCm1C5acHlzkQ3c085gnDsxS5CF6ocN9br8MbLVI/d7LnnRI/KOInswmd
    Tse/VEeMG5JKcJOWZ1de54Fluk6rGRcClZPCtv2hVfJ5GBjDO0/4lOJPu2cO3LJsNJz1s6
    I8Sj8jyk6wb23XHqd2H5Id81CKQYyEuLenOQEjNWTmqA3X/5D6fddkBhLuEqyAgcGFzU4Z
    iyxSW2121p+IUsdhQbV04dIlvMqXBTd0IYoxwBBNUbG28Mhy0YqhyH5wZbNw
X-ME-Proxy: <xmx:vHiMavqNUSpuREq8Pg7EDcCqjKa3WHqMXRAQieFXzaMHfx92cyF18A>
    <xmx:vHiMahCGyAZaxIcra30vwQqHqRXktRkT0DoRCoWBuRrr3H1C7Pgetg>
    <xmx:vHiMahx5YYGhZpX0q5429tHSXw-2mvbLyt7Wm6yz-URCGK4OJhVriQ>
    <xmx:vHiMau2UY4Lzy4x9me5vWiPBhYjdi9Uv-k-iUdDxpd8xoBAVnyC46Q>
    <xmx:vXiMajapBxFGa_NlMlALun3sLPr_Gy8Y-AAs-YrGBNS1ARz44hhu9qUJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 13:00:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b8d17f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Aug 2026 17:00:40 +0000 (UTC)
Date: Mon, 24 Aug 2026 19:00:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	jltobler@gmail.com, kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/3] hook: introduce the report hook for
 git-receive-pack(1)
Message-ID: <aox4tYaRQrCyZXnS@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
 <xmqqv78zr0pa.fsf@gitster.g>
 <xmqqo6erqzon.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6erqzon.fsf@gitster.g>

On Mon, Aug 24, 2026 at 08:57:12AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Karthik Nayak <karthik.188@gmail.com> writes:
> >
> >> ---
> >> Changes in v3:
> >> - Move out addition of proc-receive hook doc to 'git-receive-pack.adoc'
> >>   into a new commit.
> >> - Add a new commit to move out the response generation in receive-pack
> >>   to a new function.
> >> - Instead of die-ing on non-zero exit code, we modify each reference to
> >>   indicate that the hook failed.
> >> - Instead of correctly listing out the protocol, link to
> >>   linkgit:gitprotocol-pack[5], as the protocol also differs between v1
> >>   and v2.
> >> - Link to v2: https://patch.msgid.link/20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com
> >
> > This has some interaction with Justin's pluggable writes series.
> > Please help sanity check the conflict resolution I did near the tip
> > of 'seen' when I push the integration results out later today.
> 
> One more thing.  'report' is far too generic a name for this.  There
> are other features that plausibly would want to create their own
> reports.  It is understandable that one can be blinded by the
> thought that their invention is more important than everything else,
> but please resist such temptation.

That's probably on me, as I originally suggested "pre-report" when the
design was still in an earlier stage. But I agree with you -- both
"pre-report" and "report" are awful names. We have others like "update",
which sound way more generic than they really are, but that's not a good
reason to repeat that sin.

A better name might be "receive-report" or something like that.

Patrick
