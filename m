Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8170FBF0
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748618688; cv=none; b=dBzqjKE06CsMR+XcNUhFrrZ09LV+ov7sylfmbXm+ZTW8WFQ06Ci8gdklvT23DXI07HVJIGLKfdvoEiR0VndsGUVVAfl6KXHx3UhbMtBoHxvFLInm0PV+r2JryyuWZ2/mq8HIND4KAaDpdMxRvo1xi7kCKuBnYBwEY4c6o0kTz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748618688; c=relaxed/simple;
	bh=q8DOwgqdQ6WufAwRvlsaWzph42niFmOlgbzt/L3ZoQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/hoxbAjXxlSmqZNc2jyMAq5pAnbFcT7QtP/cfs/D96faIXmZVzOvuIzeJM5XyqfsrPZRxKVwNrjS9I6NHD7iAmgRWkeqC+ldem9/x9YPAC18PXmeikvU1SmsR1gXNl+Mf30oQYb5M1rss7SR+06l9PLUTjlEELBbu/S4taHycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FyuMZnZv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f7YEutoB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FyuMZnZv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f7YEutoB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D4A2A13800E0;
	Fri, 30 May 2025 11:24:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 30 May 2025 11:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748618684;
	 x=1748705084; bh=2ZP42nTpvd5v8jYRGSTOMefQRNZKIAa95IY/4uQnYoA=; b=
	FyuMZnZvuGwV5Mrpy/DQeBtFuKynac0t0QrV/1CBqUQ3ecPRqK/W5To81jSyrqKq
	gC1bJPo7dvYGD+QVFeGqGCN/mBM4FiwV161L5Aove8/kur5butacUW01mamDIkA1
	/EOTBcxxgKSBCLHQvdCld6kL3J/125hBljmIMgnGBCg6xhd4aNRBAezaDCI3hutY
	DovC+T5kmadZx+Dy0ybf3vTcRjvM36wpoCm+JlG1xHPBiAw6lXr7M+unsq7oF1xd
	NM/v4MByjY0VP34TPTm7MLYu+gAMe09vObcUFy/cawYru6A7JsAFP8A+WgAGJs3C
	UlmFPXbKtchln9zPaIv9TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748618684; x=
	1748705084; bh=2ZP42nTpvd5v8jYRGSTOMefQRNZKIAa95IY/4uQnYoA=; b=f
	7YEutoBPFwgMVq0qYu7TkJ57uWIn598GFnth2UIUiN/cFTPUHWqFqlJvEi2xWqeT
	utZmzNT9YffAmNlzy3qQsbP8Pk+TEhEeLewmw1qPoCx8/PPL/I/+3RBgmhk1vHLI
	3otoMC15u/INKlNpjvG54fIf9PJZISFNmvU0BbTVRpZAJh57ACpS4jFlgKvGmtUQ
	NyOw5ZIVBxLeWQeORLm88vfDRrHkIwSGSuCpZVzDb5ksU0IavcxlhAXYkGucpo4k
	niidKx9LyoprdnANSZCLueKi2jaGxVxWk8r/LiU453uCSCOTzuBH/wz2RYa1oPUd
	SSDyqoPHp+0UwLuH7Q1oQ==
X-ME-Sender: <xms:vM05aKcFjdbeBHBSyqsR1AKjBZ6RDxOWm_f981pmW27EFY7r-vBknA>
    <xme:vM05aEOOCV0re263G_RWbfpj2Cs5tYvJKxEP4lvyjr09cl7-DClsCsCVE__laag48
    TjgT2eN_SgAXP3J-g>
X-ME-Received: <xmr:vM05aLgcBmpi7HjdYn4Y7KQr8wTljJJQkm2kFLRgiJghaBEFJb1TOVe0iSCFHQVALVjmd5B_AnVdJVVUvgqEs-YKHUnIjvJYRWwsV2alww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleefjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekrodttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepudetheffgeeutdef
    vefgteehhfegveffffdtveeiffejleeuteekteeujeegkeevnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfle
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtohhm
X-ME-Proxy: <xmx:vM05aH_26vCDe-p1wmr91xL4Tbd2nmlIQxFIn9OIA3ysCIk6n_rvZg>
    <xmx:vM05aGvS2EirCnPn9W3XL1YyQwGsClqSQx8TwX-mArvNXIiqwZru2A>
    <xmx:vM05aOFV6BYCb7Cay420AopWyGb4b1glwb9uEjTY7_k7HjpU44A3AA>
    <xmx:vM05aFNIHjplQQ_YeMMzugi_SrX6TwpPd469GMwxD-NJufz-2ExSLw>
    <xmx:vM05aAFYKe-5YOrsbfONOaPfy0fqCFIE8jhdQIheYP4CmEcGvVwP6PWV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:24:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72869bc1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:24:41 +0000 (UTC)
Date: Fri, 30 May 2025 17:24:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
	david asraf <dasraf9@gmail.com>
Subject: Re: [PATCH 11/11] builtin/maintenance: fix locking race when
 handling "gc" task
Message-ID: <aDnNuGvargGZtubY@pks.im>
References: <aDm7HcdCbam6wgbA@pks.im>
 <0D09F80A-B6FA-40E7-AB2B-A6F78F2D58E7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D09F80A-B6FA-40E7-AB2B-A6F78F2D58E7@gmail.com>

On Fri, May 30, 2025 at 11:10:27AM -0400, Ben Knoble wrote:
> 
> > Le 30 mai 2025 à 10:05, Patrick Steinhardt <ps@pks.im> a écrit :
> > 
> > ﻿On Fri, May 30, 2025 at 08:55:49AM -0400, Ben Knoble wrote:
> >>> @@ -1240,6 +1251,7 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts,
> >>>  else
> >>>      strvec_push(&child.args, "--no-quiet");
> >>>  strvec_push(&child.args, "--no-detach");
> >>> +    strvec_push(&child.args, "--skip-maintenance-before-detach");
> >> 
> >> I suspect this would be more obvious to me if I had the manual
> >> available right now, but if we are not detaching (« --no-detach ») why
> >> do we need to skip something before detaching (that presumably won’t
> >> happen)?
> > 
> > We have two levels here: git-maintenance(1) and git-gc(1), where the
> > former executes the latter when the "gc" task is configured. What is
> > important to realize is that in this setup it is not git-gc(1) which
> > detaches -- it is git-maintenance(1). So git-maintenance(1) runs in the
> > background, but any tasks it invokes itself must run synchronously in
> > the foreground.
> > 
> > The flow thus looks like this:
> > 
> >  1. git-maintenance(1) starts.
> >  2. We perform the pre-detach tasks from git-gc(1) in the same process.
> >  3. We detach and thus the main process exits.
> >  4. We execute git-gc(1) in the already-detached process.
> >  5. We wait for git-gc(1) to exit.
> >  6. The detached git-maintenance(1) exits.
> > 
> > So because (4) is running in the already-detached process we ask
> > git-gc(1) to not detach again. And because we already ran the pre-detach
> > tasks we also ask it to not run those again.
> > 
> > Patrick
> 
> Aha, thanks! I thought I understood the sequence, but I was wrong
> about some details.
> 
> I was wondering if not detaching should just imply skipping work
> before a (non-existent) detach—if there’s no detach, should we do any
> pre-detach work at all? But presumably that does the wrong thing for
> (non-detaching) invocations that come from outside git-maintenance,
> doesn’t it? Hm.

Yeah, we always want to do these tasks no matter whether we detach or
not.

> Maybe the flip-around for me is that « pre-detach work » here actually
> refers to « foreground work », which we obviously want to do even if
> we aren’t detaching, and which maintenance (which has already done
> this) needs to skip.

Hm. That's actually a better way to put it, agreed. Too bad I already
sent out the new version a couple minutes ago :) I'll have a look on
Monday and rephrase this part.

Patrick
