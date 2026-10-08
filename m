Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74443C2B9B
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440134; cv=none; b=B4gAAfTfJCzA1zLTnLnnFaMOZt1ywm4pzklYAjifa4JP4YSZC7rNpQkN0wlcMArHKzjLlNnEzjjpgl1aOF92rH2NMWzeDQIpQmiHN/bAWzHZ3pWC7KMxziVUP3CV+XBXpf2z5BCoGOcHQ/obvCIhoS9c50l0jniUTnrXi7fdIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440134; c=relaxed/simple;
	bh=q1AefQ3K0sNC2yRTR7qo4E57jYGYy5FQXDOTUj6eBHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHDQKwBpO2k7JVPF1tW13jXugtbF+O9QvltxfP/bnr0ySq5mH0Qy1lqvPISuOJQKusXtKHH4foeaQW0e6AJlp0jZLc0nnD+z5RjxPDSCxiZ1eF6bdo6m+a7ewdraKN+ImfDMNEg2cElHZJqPMiOmhSP5Z2LSnTlzFiSWzGHVZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N0Pp1u/G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RtksbuUL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N0Pp1u/G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RtksbuUL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E2692EC00CF
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 02:15:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Oct 2026 02:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791440131; x=1791526531; bh=QlSqXmRvvM
	Ay2lZwxN7OsdtSGUKTcxXx8C1cM56sN9g=; b=N0Pp1u/GtcyzTSkkJYeFFRXh9u
	xbV1wSNC7v4in5tDTytYevDF46nSXbgcja61Et7h0lv5YEVutbkuP8FKtM+CpbkV
	iMi0BdLzIWFS1y/kXC7gbNTGbnj1af+UG/LQkCEBjfZq2YZgnONMwlvCRSy4wkDz
	O9m1HhqwFI5ErQkbolZFE6R4JFGz/C2+94NKwIhlmlr+Ew+Qzja8TOzaVc9p6spv
	l1PV5bZFrKXvlj1vTCKktB1P9cX6Mi95/qnHcZJLX5Gmj5WpBVunr4xoAz2xtRLu
	rrvcB6ncrM2feJrx1GH4RmlgpEcQswa5YusdkeZ8sUCwqBTOKHHmCnqGP9kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791440131; x=1791526531; bh=QlSqXmRvvMAy2lZwxN7OsdtSGUKTcxXx8C1
	cM56sN9g=; b=RtksbuULGueCoeqTvZ6jZf2Wgsv8gWStDJazDB4/6SuFALUzeLx
	24jMAWeDe/LTu7Gz6JmXsYGJorRGuDVhKDPYrLEMx7cxC9ZmU7eQPC//JuKISrtE
	I3LMBIEv0pVfvg3ubwpcBI60nqUyusPwiD/gH09grT1g/ZqU3Gy3AbVr5il1OF26
	bClpS62sCEEoqKhRoFY92M6BHE1lcHQgyqYpJfaySYeGO1umhkJJY/N8DRmAU+4d
	k6hA65jGTNGB4AnY7Jg2s/oxGLmFxJnYKqDqDyqfnZ7TrdrFXEHxc57Y0Jim2SsM
	s1WwDQxiQezZygpnciclX/JqmlN8QmosEzg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791440131; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nam7D4YCSD50wusgfXPGK5XyYPePwaS/OnuqminzuZCdDxL
	JzXieJhbjUKnQwBip5BumfnV+yISB1TMcQ80TFau6XUN6czuOCvn0rXfmd+ExtOQ
	UMdj14B9X/2u5lGtCJkwBWC4zdAz7tjA8Sspor5uOsX6U4bSzwXhHkcKFZxTj9MO
	D1Bx5xZ8eiwi0bPFpXqg1XYBxeXmO9v0/021n6I4vQ30mUbWNOFvkt0uf4M9WDOZ
	zzR3epo4pZqXHAB87YcNcLA2bpNpBf1hlMpZ+gXlSeya+zGdi9Qk0V7SWwT1v1QG
	PjBVdX83aXT9tjU+QLxOQhBQvlSGuRG0tpFhO3A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:X6SRJ5QQ8R+kw/YuPyZTGpeEyr7Sfw/TjpoHYLUnTBc=:q1AefQ3K0sNC2yRTR7qo4E57jYGYy5FQXDOTUj6eBHQ=;
X-ME-Sender: <xms:AzXHamQsiiv9mjVe-bwDMdLQaOa9yIzMF1-oz_xTuAskfFOgV4siOw>
    <xme:AzXHaix_FbVgMdJ52vdJCNrdFg9m362pnp5LJW-B9EaznNJs0pJ5yF-s-vNjqgbH3
    BPKzNi2LT47hwa5AKYQZuKphgIGZal9goxsJ0t8i92LMTqJsUu3xQ>
X-ME-Received: <xmr:AzXHao274jxeiqrqFcOO10yuRpn-n6ng5VGRCnRze9wDwDGbHSSVkg>
X-ME-Proxy-Cause: dmFkZTEq7f3JZpY38BvQkmOqRAumaW7K7/LC01GnYiwiE03GgMehkYI1zz/zgaRzOwIb2X
    i8nJJXo0OUvxxfYinu5e6TN9i/kuyGpNyjCtcJmtjClH02SlhiVsziI3I63kJ8JUVjQARj
    +rNvfMn4qpvtnLs0LrISYzYG+lWBHPZjh5NJH8CjtmWhSggXt/PokNHigj55gT0uee38HS
    Bweu1y3GPL0vWRRkDIRH5gr0KZ1VAaZCbSG+a5M3whSlxHr/YAc9vzke1OcQwySxFp4NmE
    pJP0sLEc5f5zfeSZQZNZ2HPgMdC4EKoEB3CuMIk8LEeNNhfIfk22yQigk+aI0tL1cCVYnq
    fnvSnYySHXlUZ2Fll+IjhNTXWUiO/ByogR91mTmtVmmI/UdRl/e+DCXiOVctrmwOw2nMUg
    lZNBNvcMYQC2ASNGAPwwhw2mIRA/ivEf6wa4IM1ZnTMZ2vIpqfhYZ7Yr2RtVHVU5j9nAPp
    CiGMBNeHDw7hdQFCXRgDvJoBCr/gFywgE/nrV0tXbTwtLYoqee4B5cYPGVVz3nDXM0Rp6y
    IUCTwY73VvnjSHFrOwnXMq/hLdjtctUOQoEfiRB5g+lF0n9JQWntvFOBeuJAddJ4EKfGos
    7FF5vznJ0CSJWYONbzQo4Ad/TN+w7W67U7v84MR3GPQALI6+vBRSfjsfM8fg
X-ME-Proxy: <xmx:AzXHag6XJqa9_a-_XEJNFVm8IG7LIzO5vx002Q8ELIwSFL0ZFvgqOw>
    <xmx:AzXHarUaTnzFQqYVgxZSECpGv05XXctQUoyPU2wwEH--Ikj-J-xbxQ>
    <xmx:AzXHavBKsvy4V2dxktUjazg5yukkneaMRLH6aDTu5WJ4chmv2bcuuQ>
    <xmx:AzXHaq6baIQgavkc0qCHlomm4zXY560-r9vJGvuLU8hdirltFazrnQ>
    <xmx:AzXHava966kOLLRMBrh2opfhZNQdUH-et8DT7xifuDHLH1mpT4pp_rVh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 02:15:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aeda4761 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 06:15:29 +0000 (UTC)
Date: Thu, 8 Oct 2026 08:15:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] ci: bump debian-11 job to debian-12
Message-ID: <asc0_sjw8beWy2y5@pks.im>
References: <20260905135822.GA3914811@coredump.intra.peff.net>
 <20260906151137.GA328152@coredump.intra.peff.net>
 <xmqqzewp5jhi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzewp5jhi.fsf@gitster.g>

On Wed, Oct 07, 2026 at 01:44:09PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > BTW, I noticed that the linux32 build is using ubuntu 20.04, which has
> > been out of LTS for a year. But bumping isn't really an option; they
> > dropped i386 platform support, and so has Debian.
> >
> > I'm mostly inclined to leave it unless/until it starts creating
> > headaches. To some degree, if we cannot even find an image to test
> > again, it might not be an important enough platform to care about. But I
> > can also imagine there is a long tail of oddball 32-bit platforms that
> > Git does run on (like small ARM chips), and it's nice to at least have
> > some coverage. Possibly there's an ARM image we could use (looks like
> > armhf?).
> >
> > We also seem to use 20.04 for linux-TEST-vars. On the surface there's no
> > reason it couldn't be using ubuntu-latest, though I think this may be
> > one of those cases where it's doing double duty as "test exotic configs"
> > and "test on an older platform". But might be worth bumping to the
> > oldest in-scope LTS.
> >
> > All out of scope for this patch, and mostly I'm inclined to ignore it
> > for now until we hit problems (and then decide if it's worth
> > accommodating or if old systems are too old).
> 
> I am getting annoyed enough to see that the lack of 20.04 is finally
> giving failures more often than it used to.  And am planning to
> suggest to:
> 
>  * drop linux32 job
> 
>  * update linux-TEST-vars to run with ubuntu:rolling like everybody
>    else with the default version of gcc
> 
> I personally do not see much value in the test-vars job in that
> enabling all exotic configs all at once would not match use patterns
> of any real world users, which may likely to enable only some but
> not all of them, and for that reason am also tempted to propose to
> just remove it at the same time as we remove linux32 job.

I think it'd be great to continue exercising i386, and Debian still has
supported images for that.

Ialso think that we should keep the TEST-vars job. It has catched
regressions several times for me in the past. Sure, the combination of
flags in typically not exercised. But I think that by itself is not a
good enough argument to drop this entirely.

But, oh well, you probably just want to snipe somebody into doing this.
So fine, I'll bite and will send patches later today.

Patrick
