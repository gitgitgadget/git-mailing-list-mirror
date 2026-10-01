Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0F2E3FE
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 05:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790831653; cv=none; b=lYMxpE0EhaZouyjPFTTL7Yi1xUa8PF/fXNcOES1vPysX7f7+wfJ4Yol/VfpiAgulaIJlkAmgksgzSX4AdJdEpt3GgyMa2+p9AURVKwT4VG2UOMijFzCXci5/a72LCpl+RcDJSXaVNRm3KkFXIzUGtzjQeZv1YbC0Ro+fNRjE5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790831653; c=relaxed/simple;
	bh=cQPEZ2CAfS6LK5QvQW7zzK7v1ZsFVdWY7WWeHklwRIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUrYrtEp8dsZzO+8I04rxGh6VUEnyY1HSmKmmeGIh83q30/BAP1FOOO4ZhPNhZVG28h/ggRYc/ZbkvDqYX0x0tLhpF0GdquKJRTm7J4PT2MPYYZxfYaaInRCloFvaAEvtNLpQmtRRYVR+XwLVfhaXWcmnKgrq+w1kvkWVcwZNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZOV2fVcA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PDUM8jr5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZOV2fVcA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PDUM8jr5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 26451EC011C;
	Thu,  1 Oct 2026 01:14:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 01:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790831650; x=1790918050; bh=RZPaIDWWa9
	zruSZIZ8RYarLm/3EOV/Xo6qBSuRLdPRY=; b=ZOV2fVcAGfWAf4I4mY9w7hoa9W
	CLzYTlA3fgFoAzgMGIK8oShwaF+i/5c17xg8VadErdGrBZF8NHEzKxtTU/hsmiDD
	kNAXH6Bd47DQg2bmLfrGpsOIeIUY7D4a3eysixfvRFUBTm02T8twdj3xEKJ0wWY9
	rXe8omF8YwJHKUKKJjmNvNh6puaSvByOhRB1ck2+sHuUY+RM0K0QGs12NkAG24JG
	cT0rYmzjsfsShFa5sk3UlqJHStyK6guc5bEVkhuKSTGJuC2l11cu0E+TJLUv3Wp5
	JDL1MAf3i166gq41YGLwrYtfmNdANqbT8aMXFWCYX9kuFv9vs2dUTl9gyepw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790831650; x=1790918050; bh=RZPaIDWWa9zruSZIZ8RYarLm/3EOV/Xo6qB
	SuRLdPRY=; b=PDUM8jr5wnnYIY81+3jvIZfrhJlHKKAgQR6zublShswJJoIB9Cj
	g4kC/UEtj8I89xW97KHNd5d2/SKRLJ+WXq8v/0WEN7UMG4u7CwLmA444ZVasBkib
	KFuoYRe1Mz1/yubg0Zn57+Y+K6z8Pph6X4g+gZdeQldWgsPUYqWKTQ/f3Nc2h2Xh
	RCR/vddadOXHTxQf0oTF2i9SfP5n5lFaHuQdRcslXpQTeM/1XeYPdrz8DU0xJjkT
	rl3tr4AmWBhI6tH93v9aBzKeWyv1L6cx4ZK2Zxf6XF8kg2M+3dRM08UIOn7yg7c/
	3pu/iqpD8kPstA+G94eAaG3lmlklUrIWnew==
X-ME-Sender: <xms:Iey9aqz6ciKGw9_k4XK4Gr57p1uBKpnxkIKJiudLzmMYosuUXt6Ifw>
    <xme:Iey9atQD6plYwSDmiKkjRbyXziVscdI_Nl32urwLe7etWhJX27hwJ0BetbfpaVwO_
    GsBOh_l7h53X6t6sxn1dgug7oHyDi74-x58UbsTzioNWSCVcok5w1I>
X-ME-Received: <xmr:Iey9ahUnbpU2fy7SrRYEGqUYY_INraJe4lIp3e0vY3tMT5kaEIvZyJuR7CIxIyuAeexMOg>
X-ME-Proxy-Cause: dmFkZTEc3tjFsOc94JBQ3ATW1YbyFBg6XRsSSeekjbNj1fabeMH0MdVV+oWe0TTxpSMvyM
    WTUqYi/IiHDfiWaHfv6R/yN+T6VM9aSvggfBuRxyi1GNdp4kT03FxD5RGAUcyOcR5pJAG4
    H2/BlePgy1Zue22AJ+L1pD8UT6YpAXHUNHLUEJfT07IXPrnexsx7jpFmkvEwfAcvIa9/Rt
    LGEEZxfcMrpMPRfxulMx0nkajt5Q20np2gbuaA5V+Z3DTEiCRsn04gl89gjIX8JYhNwooV
    DNIY1jB1tFg2S83CTTiacRiDUS/Yu9vVxMyiMJ7U6Mm6v2w6GwYRDTbboRmTiX58KYF4MK
    cbJ/bBWb5XLCDgQgSWBK6DrXGVHdFZl96wXy62OntIMVZ6/86x35lGNwIi7w4dhXzEkajP
    eUkkVn50tIlnsgSvvH7oJEiZiSPjafc7nRguFUex/Nvmy65xfD9Jtv6T3wjvfYFr21IkuI
    xxjpDO3ruGtt8y9jOo/e9ED5g9bTec7LSPaVqT3k0qfSJwGBZz5KMvpy0K7vC7c1HrTUI8
    zyYZEskkcjeT4H7as8gI0xYKJokiSchlT8x/Co0cMkIyTp6XyA1FeKuDfYXB3kPWQtvbc8
    I4wPVu8ViA47w4ebECDVvzO8Tjy+J/G7fKY3Vef+2mZI+EtIPY0ztTyM2mOg
X-ME-Proxy: <xmx:Iey9avaPf600hH5fAw8rAvOfK7-_9oban4uNE40mDbYwFvfPRfLpvw>
    <xmx:Iey9an2FsDI2J8sL0Xloc-ZEAZwZeFi2GqbVhTxk_Af4_fSvV64jww>
    <xmx:Iey9ahhy6fCTc0YqBRTXnZ-_spWXGUyRO5aTHoxOkzXxe7DTYy0Tzg>
    <xmx:Iey9arY38tWcqtW6UGk5vs0RsDiQmBK9eF-zg2aAjT1j2dezWeZgcg>
    <xmx:Iuy9ao0ZbBq7g1PVP8mmVM4Bpbet1e5WyY5-jtGJmXx0spgNluu9tY9J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 01:14:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 626020dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 05:14:06 +0000 (UTC)
Date: Thu, 1 Oct 2026 07:14:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans <julia@jvns.ca>, Julia Evans <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
Message-ID: <ar3sGzEknG2_Un_E@pks.im>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
 <ar0MVRV5X8zgZfLy@pks.im>
 <5ba2088c-4919-465f-8892-4ed0685f81ea@app.fastmail.com>
 <xmqqqzia8ohv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzia8ohv.fsf@gitster.g>

On Wed, Sep 30, 2026 at 01:37:16PM -0700, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
> 
> >>> +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
> >>> +For example, here's a merge conflict where both sides edited a list of
> >>> +fruits in different ways:
> >>> +
> >>> +----
> >>> +FRUITS = [
> >>> +    "apple",
> >>> +<<<<<<< HEAD
> >>> +    "cherry",
> >>> +=======
> >>> +    "banana",
> >>> +>>>>>>> add-fruit
> >> Hide quoted text
> >>
> >> A bit of a tangent, but sometimes I wonder whether we should make the
> >> respective commits a bit easier to access. For example, we could put the
> >> equivalent of `git rev-parse --reference <commit>` here for each of the
> >> sides.
> >
> > Personally I'm not sure if the commit ID would do much for me, but I feel
> > like it would help me if it were possible to include the commit message. 
> 
> It would also help the resolution, not just committing after you are
> done.  It may not matter while picking between cherry and banana to
> show your personal preference on fruits, but in a more involved
> conflicted merge, it may help to be able to view "git show $commit",
> "git diff ...$commit", and "git diff $commit..." where $commit is
> the "add-fruit" side of the merge to understand what they wanted to
> do, and what we have done while they weren't looking.

Yup. Doesn't mean we cannot _also_ include the names that we have above.
So in the above example it could be for example:

+FRUITS = [
+    "apple",
+<<<<<<< HEAD: abcdefg (fruits: add apple, 2026-10-01)
+    "cherry",
+=======
+    "banana",
+>>>>>>> add-fruit: 12345678 (fruits: add banana, 2024-02-03)

That format would have a bunch of advantages:

  - We don't have to teach users about special refs like MERGE_HEAD to
    let them figure out how to access each of the commits.

  - It gives a bit more context about what each specific side does, at
    least if you have good commit messages.

  - It also gives a sense of timing because we include dates, and that
    may help in some situations to figure out what's what.

I'll create an issue on the GitLab side and ask someone in the team to
maybe give this a try.

> >> I tend to forget that by default, we only render ours/theirs in the
> >> conflict. I always feel like that makes it way harder to resolve
> >> conflicts as you don't have the context of what the code looked like
> >> originally. So I have diff3 configured locally for ages.
> >
> > Every time I show people diff3 someone tells me how happy they
> > are to learn it :)
> 
> Yes, we should encourage "merge.conflictstyle=diff3" (I feel about
> this strongly enough to think it should become the default).
> Knowing what the original was before one side wanted to say "cherry"
> while the other side wanted to say "banana" sometimes helps a great
> deal to decide what to do with the conflict.

I very much agree that it should be the default.

Patrick
