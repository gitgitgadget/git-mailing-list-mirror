Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976FA28B7DA
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301623; cv=none; b=ja2n8rc0atIwOkgc3F2Oo8VyeEiehhCMOoQkR2V24GVC6lD5wNLqiOh+yrkW8lc2vd+FXE5I34QnxlxMKCf9t8V4f5PL+0aD5LM2Zp+W8h4N5KAucBddHk9NmzPe2lBTilIf3aj0G0YbNCR9UxG6NSFb40qcCUTB+s3sVMtpmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301623; c=relaxed/simple;
	bh=iOziXYnOBkaxEhupO8T7Us20C2dFozVALoaemlQ1RCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzWYFANhejwhSVg7jB2hMzGW075FQ7v9JfWVVvcuP+HDwhZqMk/IDxAcKbrOG/65+lFRKW6ZvPgvB1mC2j1+LxNCR3IZO0VM5qRLQ6HS+5NlBOz/AWveZomery5fAmaxzEJel7ftv2Sh0603Z88W1sNHDJnbaYm+ESHTrF2fyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WcoCeo1v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UoW5/O2c; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WcoCeo1v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UoW5/O2c"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A6EDC1D00125;
	Wed, 24 Jun 2026 07:47:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 07:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782301620; x=1782388020; bh=TUttDDwJiB
	lm1FS85G5J6AnetEcZS0DuyZ8vuYHCSq0=; b=WcoCeo1vttQ0BKkE3AHJbVTQ/5
	zMqN24vUpeK7QKYn4C4gueTyvhC6dNSiLQQsHrUSzjAHCmAQ2zXRKp7Cda1Igf0Z
	xR4DbEQKriwEYFmGcb1A0u6BIU5F7MFubdZ9l1R6OFcuzcIVYole1GYJUHLQLvWw
	YAn8UBfHRJjNl+Dc+fkARuKEZvLKCaNxk0kqWKHm9qU871EJAOLgG+FlUTmT8p8H
	7BlB7azA+CC6Ft3LunLtqU+zXhy1Nsdbg9q4s46qZqhdI090ej/lQtCDTWh3gtKA
	H/KlaDm1OsZHW3XgWb3P70If18vYYcsgPeddfHVJD44kY8sJ6duaLpom5vNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782301620; x=1782388020; bh=TUttDDwJiBlm1FS85G5J6AnetEcZS0DuyZ8
	vuYHCSq0=; b=UoW5/O2c6TdC+8pyczYHJ+kva3/vQufkulI2qbfWIP8yhFr5CKZ
	WOntkdaBdrlRVSiybzn2IfLzr5cDCkfuUK3G878r1zd2u/RSE17Vn3NFC4IVC4p5
	DXRNptvHyUXGwOoBxxlJaeduH26IY5kf4EjRyLXU70rkUoznw51GMn+SoFK2vWhn
	5E9Tp62BINJWafApew4icu+uHevkjS47vtBdxp79ebTI4xIM/9SJjETOdXj+PyBq
	swNbgKrrwp4TO2LOQhF0RFL5Io7l+s3PuOtHkoD+g08O/MLa+q913/u9JIl3JUZe
	I0aMKrnMwG4SIAO3OFUEQ+3BtbfJaqIZ5qg==
X-ME-Sender: <xms:tMM7anH4i0nnE1ZXmspfxXBadfLsK7aye_s9dGEiPR2n6FGZQJ6mqw>
    <xme:tMM7arxFzMkqUpBBEaaSDZurKyO0bvC-d5r5THtx02iybIlmC6dSMcp6PnHc5K2RA
    bzy3gzgD_MPwAr86-b7BBLNjdhYSHt8AiDGMe34g61YaWPaeWHe-A>
X-ME-Received: <xmr:tMM7amihbvirCyHVcFBGfHg0Dbq4bIWcBtffJaZxalTiDG-biboMa-HIGBbRQSeRoiFk5FT5XaW_dmRSbH683mAN4Xb--i0gBc0zU5Il>
X-ME-Proxy-Cause: dmFkZTFwEDHISLUt/J2tPCIZLTAqLfffwN4OSgT4qNnQi9+LlY4R3ICLat+FpykPxER4MJ
    5mpBjml4pssxZGiDRK+hWlAJxYBPMat/PJv+PHUwmcw3i5m/h+khqDzNvDadf25DSOiyCD
    Qs241XEu/hgKWWovH7hBhdCnevXTWymGYLZMWP30u/NKDuDz1uk3Z4cUqYZ4/nhozi5SX0
    tNw7Mwwm1rQY3ZM0engPmaBF4HsmFcASo9yezlalC6x6nACWHZf33k3wJkLqIXVmneSnQh
    hx2cU1rdcDxmZb4wXqmIZEcz5RimB+NZp2+1X+2VNZu/PALVabji27x/nMYmY5nleR9uMf
    Mz+zxwY7Wc+TYLETD1reLojA4o3sp5PQyrQC04ajlM5ENvZbeH9PxqS+FBxKNJtOzeKE7T
    zaghKTS0afe9CP6JUkobXgt7qnNi7spmUBrKs8WO0Wm1UxtTsmSC6lZHaZ2Cs6+2+frcZI
    ieS+ln9dN4Qji7guvu1BVb20XwxQiYyvPRJ/FA0WGNN5cA6U8khDS4SfEbvtMZ1F94NPVy
    H+TDrWKAmfjMMInUBjEzWp+Gy/SajnA9KDd2Hr1i4qw2EVYSn8wlH6joNbACxQZbMDwh4I
    mwY1wD2Uf8b1+IWnxa2ZasjX8YZTBKsMHwloYngeZWHuR4Wq/jQNgQBeC9mA
X-ME-Proxy: <xmx:tMM7auysyBCMoCgkgQGZSX_04p9YrQM24MRCbZgflL6TQELvbXQo7A>
    <xmx:tMM7ahIkv-z59vM8eiUFR9h7MCVNfX-k4KBK-225Cadf4vNqEK9faA>
    <xmx:tMM7atQI9G79GQFIg-FM5mBSfVyT15j0tEyzTuleVfJ-r5skyUH72g>
    <xmx:tMM7ahpEGecfEBFbnutt0AodUfe_WgSneNO8w4QC23Dv3B5ycpJRQQ>
    <xmx:tMM7atasO2sTnjFhdA2TdfzqtIp7kSdNUTvJ28zlksXc4n6ah-eT78lo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 07:46:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id beb9b704 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 11:46:57 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:46:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Weijie Yuan <wy@wyuan.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] doc: advise batching patch rerolls
Message-ID: <ajvDrjk-bTvYaQtU@pks.im>
References: <cover.1781358364.git.wy@wyuan.org>
 <cover.1781714757.git.wy@wyuan.org>
 <496a08c74ddd9368587d032da7117520af1478ae.1781714757.git.wy@wyuan.org>
 <xmqq4ij1vywy.fsf@gitster.g>
 <ajVCD51lLvHreyJB@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajVCD51lLvHreyJB@wyuan.org>

On Fri, Jun 19, 2026 at 09:20:15PM +0800, Weijie Yuan wrote:
> Sorry for the late reply. I spent some time looking back through the
> discussions on earlier patch series, to check my patch itself, of course
> because I'm apparently a newcomer here.
> 
> On Wed, Jun 17, 2026 at 10:50:53AM -0700, Junio C Hamano wrote:
> > > If the comments require substantial rework, sending a new version
> > > +sooner may save reviewers from spending time on a version you already know will
> > > +change significantly.
> > 
> > I am not sure about this one.  Even though the intention to avoid
> > wasting reviewers' time spent on reading through the previous
> > version that will be invalidated is a good one, by definition, a
> > substantial rework will naturally take time, and it is better not to
> > rush and send an updated version with substantial changes that you
> > yourself haven't had a chance to thoroughly review yet.
> > 
> > In such a case, it would be a better idea to respond to the review
> > that made you realize a substantial rewrite is needed with a simple
> > "I'll make a substantial rework based on this comment, which would
> > invalidate this and that part of the current patch series, so please
> > do not waste reviewer cycles on these parts until I send an updated
> > series out" message.
> 
> I think the approach you recommended is obviously more reasonable.
> 
> It would be better to give everyone a heads-up "I am working on a
> new version."
> 
> I will improve this part accordingly.

Yeah, that works for me, as well.

> > > If the topic is close to being accepted and the remaining
> > > +comments are small, a quicker new version may also be fine.
> > 
> > I am not sure if this needs to be codified.
> > 
> > I often see (e.g., in patches from Patrick) that an iteration is
> > marked clearly as final candidate that the author is not aware of
> > any outstanding issues.  This encourages reviewers to ask "what
> > about this one raised there?"  to remind what is missed, or chime in
> > with "yup, this looks good" to show support.  Such a note is highly
> > recommended, but I do not see a need to say "the (supposedly) final
> > one is specifically allowed to be sent without waiting" even then.
> 
> Actually I thought Patrick would say something here ;-) so I waited a
> few more days to see whether anyone else had any suggestions.
> 
> But here I think Patrick's original intention is: If your series is
> *close* to be accepted, (while I'm not sure what the precise definition
> of this "close to be accepted", does it means: commented by Junio with
> "Looks good", or reviewed by the community/core contributors with "Makes
> sense"?) and this time there happens to be a small issue, you can
> re-roll quickly to make your series more "sturdy" to wait for
> maintainer's final examination and further merges.
> 
> So, I think the situation you are describing here is that this version
> of the patch has already been declared by the *author* to be the final
> version. (i.e. waiting for Junio to do the last exam)

My "close to be accepted" feeling is when you've had multiple rounds of
design discussions already, everyone is on the same page, and all you
got on the last review round is a couple of typo fixes.

But all of this is highly subjective, so it'll always depend and it
won't be easy to codify all of that. Nor is that necessary, I guess. We
really only want to provide some rough guidance.

> Therefore, I do not think the two situations conflict with each other,
> or are directly related. One concerns a patch that is already close to
> receiving the maintainer's final verdict, where a minor issue is
> discovered and the author quickly rerolls it. The other concerns an
> author who, without realizing that some issues remain unresolved, rushes
> to send what they believe to be the final version and then waits for the
> maintainer to review it.
> 
> For the latter case, I think it would be better to add a sentence along
> the lines of: "Before sending a new version/the final version, check
> once more whether there are any unresolved issues," if the existing
> documentation does not already make this clear.

I think that should mostly be clear with our documentation. And
eventually, we should also expect people to have some common sense :)

> That said, I am not familiar with how patch discussions have played out
> in the past, so please directly point out any mistakes in my
> understanding. I have to admit that, by this point in writing the
> message, I have become a little tangled up in my own reasoning.

I guess that's kind of expected, mostly because many of these things are
highly subjective and will depend on the situation. The guidance does
not have to be perfect, you'll probably be able to find counterexamples
for many of the cases.

Patrick
