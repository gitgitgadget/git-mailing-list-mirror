Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410624B28
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678921; cv=none; b=REiD68HLeLE5lYdUd6k8m/+D6gkzKgs+0Cd9SzXtrjpRfuR3bigQb0SUrcMShDXI2CGUHN4r3nnv/zBIQlootnNnFiILQqyRkhNxhstX50sNSeWC+GRDwe2+I8t38cyJcXVOD+Su4PaI8P/iYjl+eHnNXSpPAqzaizu4RD8Yk5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678921; c=relaxed/simple;
	bh=Qw8LDWt0lo0R7zwfkur59fpKx7IRzvi0EflATTEaXzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfTVx6Ix10hzX3ChQnaFrytsoba9cwcy7y3iAI4jx/caCY/hwxbDB94NiU7+lwIaCJYAdd63iXwLIUr4K03RlI/DG99iu/CbwHTLNbUY+CSiSwvDiGoqAZLrGXpe9yBPSf1fHoi+rtJDFn136iqShJSC6c4d75N7nKTlpYi1YTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MC0Ge0ji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s7hj99XB; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MC0Ge0ji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s7hj99XB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7ADE1140008B;
	Mon, 20 Apr 2026 05:55:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Apr 2026 05:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776678918; x=1776765318; bh=DVRGhJfnVz
	v+xo6vbckNj684b48engqYQkstdYC+dmE=; b=MC0Ge0jix/89rcz5WWkbbmROrn
	eXDX8X3pKo4x4ExB8BXlJOVU2CH1zSIFbwM4VvFcFRqDi05d+Mx1D5BDhWM3iyVt
	Bmnu5oB2Yse00o/i4SAEAALEcGX480oqqPo/wa04FpIFLk2F5pvzg8AbHeTPooYS
	+bNEwC0t8pO+0BpV3PMDnsdlsl96UVw3ErEERjHt5uugFCcHIwuaUaJMCCpceuV3
	FDDdA0atdwkohrPBzO4MVXe0+dAcY3/2eHQqKhbSGOcsdD57qp/pTzeLc0WbUmww
	O7Qm+FN/FINXWxGH0tFVISXMlHlRsx/gIB3TVOer7L7RWioxQHs10jiiOdJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776678918; x=1776765318; bh=DVRGhJfnVzv+xo6vbckNj684b48engqYQks
	tdYC+dmE=; b=s7hj99XBRCxEP3/PDWsBGCVZBJCbmZMrq3tLtrHih9oqsKl1ECp
	+dxAg37wzZlG4TSD/p2dUTwiroA6B2SSurpr3Hey8CSHkFrVUSQYso/GcWhhk7AT
	NeOYp6+fLX6v5GJryPu91Lk+dYZDF2AkohLAGyk17x4KZahGhlO2RlgYVfJpD9hg
	poRcrDLcvrNXMD7O0Jb5wAR32giFGczqrlOMB6eDNevgZxfg86QM2PCenvAsAwoy
	u9okYr1U1XvKn6qq5PqvLilkRbl8GSyAPiOBiuXW+KwqFj1Xjz2dXaO+VMlQEypP
	1NV+FsZTbyNzTP6iiYQNLFI+pO11Xk6Fj+g==
X-ME-Sender: <xms:BfjlaZ9WjtJt1rLarPjsUx9Ub2vn-Pq1L2c_o1FGC7rswsydTK1Hgg>
    <xme:BfjlaRiQtozecpfy0b8idlHDBckrV9FDx1imXa51hf79Tp1licLYQZrWOhT3xlXze
    BIJGl5rrSfx2BaViFQ_8kEg8LvBcT1fh9CavaH5ploTDLWARAx3Tw>
X-ME-Received: <xmr:BfjlaQFKnudsgPRkIHVUyH2Daz5R8GMyCOMjlKWJI5uRH7TqDzMgsjGBgWcClctcgN50p33mXbWQ0lE_o63wX5UHSCMUF5EhKrwWxjTHjQ6Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhsthhinhesphgrrhhithih
    rdhiohdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopegthh
    hrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepshhiugguhhgrrh
    hthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BfjlaQ_EqF_seO7VxZ0LYW_5Wv9Lemt7sWwRnU0NPEAVMySUSiYuPw>
    <xmx:BfjlaXzvPakqMR0NPHhiqvGeFL5sem0GB3CY3CDzW96ZZ2eUsNr4wg>
    <xmx:BfjlacMdZZa65J-4ZkEghf1KDFYL_OTKvTq2BfVQE6d8gBA-Xpo4rQ>
    <xmx:Bfjlac_7d-DHcKogRO4zxawv8R2tLuzRjDDPiRWhqKa-NNe77J6KPg>
    <xmx:BvjlaXMFMT7TmKaVRU-80ORLXTQD-_Sug59mnZudGBaREu1iBA_sWqUk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 05:55:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 104a449a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 09:55:13 +0000 (UTC)
Date: Mon, 20 Apr 2026 11:55:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, toon@iotcl.com, karthik.188@gmail.com,
	justin@parity.io
Subject: Re: [PATCH v1 1/1] rev-list: add --missing=print-only mode
Message-ID: <aeX3_nKaCaXOdSE6@pks.im>
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260419084840.33986-2-siddharthasthana31@gmail.com>
 <aeXZOAtILSr638LG@pks.im>
 <491a27af-3ea4-4978-9d51-9c540ad31589@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <491a27af-3ea4-4978-9d51-9c540ad31589@gmail.com>

On Mon, Apr 20, 2026 at 09:57:02AM +0100, Phillip Wood wrote:
> On 20/04/2026 08:43, Patrick Steinhardt wrote:
> > On Sun, Apr 19, 2026 at 02:18:40PM +0530, Siddharth Asthana wrote:
> > 
> > >   static struct oidmap missing_objects;
> > >   enum missing_action {
> > > -	MA_ERROR = 0,    /* fail if any missing objects are encountered */
> > > -	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
> > > -	MA_PRINT,        /* print ALL missing objects in special section */
> > > -	MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing object info */
> > > +	MA_ERROR = 0, /* fail if any missing objects are encountered */
> > > +	MA_ALLOW_ANY, /* silently allow ALL missing objects */
> > > +	MA_PRINT, /* print ALL missing objects in special section */
> > > +	MA_PRINT_INFO, /* same as MA_PRINT but also prints missing object info */
> > > +	MA_PRINT_ONLY, /* print ONLY missing objects, without the "?" prefix */
> > 
> > Makes me wonder whether we'll eventually also want to have
> > `MA_PRINT_INFO_ONLY`.
> 
> Perhaps we'd be better to add a "--missing-only" option that limits the
> output to missing objects? That would avoid the problem of
> "--missing=print-only" not really explaining what it does as well.

Yes, I had the same thought.

Patrick
