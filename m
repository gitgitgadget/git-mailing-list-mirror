Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E2386C3B
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179682; cv=none; b=CbK4vDYV2QnmCTcreqinFn/H0g8hvYrQFAq8zpA2gBkN7NKeQE7EFMQWU7K5IW5ytyZCZwJ5k19e+RAZGdwXnTFDhmPFRaVFzMf+hjKFglJRpJAlnrnq9pbttalfhfOh4kBdluMzYkv4lSVWRo2XrkTpkg59Yp4WZ9TCrbgDdNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179682; c=relaxed/simple;
	bh=nFIiWZKiMWRJoBg4soZBIsyF7BjAX+CNOLLgEOnYBL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDh5xMama8jutvRecD3ifvgUniFVbHwLYTuVl01sm+B8URRUtbl3vMaaIDz8hxJIRFQr/u0OLdZ/Q6mPWsiP2euLT/OwD9piUWrmeFvqXPR83Qjz8LBVQOmi5JQsi039ikW1AIESHiLE3tJ7qKqI6bLNp8krtciyf561uk3XUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FNZg9RAh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jefg9kMl; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FNZg9RAh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jefg9kMl"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D2171D0010D;
	Thu, 16 Jul 2026 01:27:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 01:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784179679;
	 x=1784266079; bh=DdJa57rN0xKLQFlwtk63UsY0/TLTMf/ff89ZU3S77kI=; b=
	FNZg9RAhXvaQP+Id9myDmEyPOwMKC7TJ1O1jd7JDKALpDhSp/5bcirCiTzAG9p/y
	QhBtfEAaeIVjNC/tIsrN1GrpLUVdqOsp2akGWrqhgQEUYwD056b3BK7DbY1PC6oF
	K1RdKBNyQzfTyAFsVg67uQKT5a+asIZ9KhK7DjZkaER+iS7mhe3cN++ZStIXMyFf
	Hva0xPjxostlFXcrL8ol8Wd+ZAwbT6yMrxytOglHVN6efyymuyzaKJtWUKvISmfo
	0cRewMKGIv2Mu+2YVEuV8T7MCxfKZEBnAfJx6OIuDxEZxKBNwKMTy56aSLdS9FYj
	7CdfQkjSu3L/z8dLdZWCHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784179679; x=
	1784266079; bh=DdJa57rN0xKLQFlwtk63UsY0/TLTMf/ff89ZU3S77kI=; b=J
	efg9kMlyGoIs0NBgKZAnNmE7NcOR4jKYuYX0fmPcxxQLMpnPXUm7Yy53W+vR/uD4
	WKuZQPBYDBpiEtmzrKalAqLAGhOH0Ns3r/XINzR9KexfdpmsG80iGq1TAOCfzmWl
	ofTSbQwSYb2aI3LGnaSQmay4rcuW1Vmo6OG4SNg6kxn2hQBewRxCYmyp4Wx/823H
	7DO778ueJtx5R765mV77djT42F6ETtxe2aUW7sLZFT+hDoor0Y2x048xGmfCqdZf
	Szm4WDyJW1zObRlk0ID2tVnWlJIqYi17ps+c6W/y2fwrOZ6LiSvkBDjGbiCLowjR
	KKiLAe2AqYI7yKtEhHX0w==
X-ME-Sender: <xms:32tYatUUpEDKo32Kb3d9E-svS_h5n2es_2Li8iQmynyvDdF1Jchc5g>
    <xme:32tYajncg7O7ZrVw8f9ytlN2_0n6saZwPtuHGux6nYxBMnF8LkJeDAbAjZ_4ZLUHp
    RhT4ZgmTK4jg-HpxnpgQFkQptaB-TD089IHpd7WnYeflfcao12kZ6E>
X-ME-Received: <xmr:32tYanDw1I1rYhnB0CC9IUicCQmttwtHiRNceQn528UGWS_srCMEaJQuqivloZPpdh__nTbo6p8bH0FrtrVlZSqLlvrLnQIcyu4fLEF0>
X-ME-Proxy-Cause: dmFkZTGvQj+dHLiq/qLlM4R544QC+W6xkcXNO5YVn5t+OwVWqDkDL6fCddJBVvhKFR86Rp
    R9DTZTpJrebpjZUnQqwGTS12iLsFPB3lSxuMpX/Go/K4yBt2sFS9b2m78ebE5e5nIN3JHM
    4B/rxT04lB8L3ey4uE0aft7g3nA8NZ/fDuy/RJR8Bjc6WuXxDhJ7uV76vCg4KqJiymyWfC
    ZU/QQK4Esg6jNubc1VY/31xgGSY1m2ZDhV0Oc+Zu8dSlMO/cql4Tu3QwnkBrnVUkNTDbeo
    unHfYFA126UgURRLoDbHTDHuTtyzytpvkdvChTEzPjCYTZXtMI2/0z9v1ySZOfiSjMKQto
    tgz0UjzecsGy2fFt7DJb2MW8z6xxv27Enog3HDi8kBZCs9sJ92FBWeX5yyySv741T8cclj
    Ko0ybq6V6O0dZZArMvrahz1TEHIUK7C6nLy53GAQQjT8JlOBb69vtlRT72A12lNtQoHHHz
    EwKDMwwh7pXgnPmdbUIVA9xISFI5tCXDKaRraG2ix1y9VIh/3bLdmk1SsXVaOkwJbjfbZA
    11D3ZMy5FWrKSnPrnRGOw55Vd/YO8EHTvhFqu77Y3XHulY4GhpAr7FCBddRr1TO1Q/lhGj
    NI1I+8gP8gG6iMNKyRC1toj0IRtFAqZhbh0U6P86l8act0ijcFRy6UPv8nbw
X-ME-Proxy: <xmx:32tYardIyaJl9HW1DybIlqMooW5So8E5C4e8ThV4jvMmQEjw0mozRg>
    <xmx:32tYaqLdgsv6UZuVjjwgFsIjDlBgHk2aKux9_fiKisE18WkS9OLywg>
    <xmx:32tYamfVx6TrrHFozlTVkrsGp3_z6mts7Nv7ZhE19r6wy7kBFxK5Zg>
    <xmx:32tYap0ZWZvsQV10I0LWtDP_oxxqFpubGJqzrQ0OdwUs4OQzw71VSQ>
    <xmx:32tYaosx1WWYqUMR2bTUhoI0l8fDcTjuK0AIoof3O9A8S0myP40Xw5Md>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 01:27:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de47d0e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 05:27:56 +0000 (UTC)
Date: Thu, 16 Jul 2026 07:27:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] remote-curl: simplify passing of push specs
Message-ID: <alhr2bb0lUTHtvjO@pks.im>
References: <935883f3-3be4-4c51-9711-5208b9ef9ca1@web.de>
 <alcrhGUCVMCnm2-i@pks.im>
 <3b29757e-abcd-4235-a829-ea67c19e71d0@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b29757e-abcd-4235-a829-ea67c19e71d0@web.de>

On Wed, Jul 15, 2026 at 05:39:51PM +0200, René Scharfe wrote:
> On 7/15/26 8:41 AM, Patrick Steinhardt wrote:
> > On Wed, Jul 15, 2026 at 06:41:17AM +0200, René Scharfe wrote:
> >> diff --git a/remote-curl.c b/remote-curl.c
> >> index 9e614c5567..2c35dd5240 100644
> >> --- a/remote-curl.c
> >> +++ b/remote-curl.c
> >> @@ -1340,10 +1340,9 @@ static void parse_get(const char *arg)
> >>  	fflush(stdout);
> >>  }
> >>  
> >> -static int push_dav(int nr_spec, const char **specs)
> >> +static int push_dav(const char **specs)
> >>  {
> >>  	struct child_process child = CHILD_PROCESS_INIT;
> >> -	size_t i;
> >>  
> >>  	child.git_cmd = 1;
> >>  	strvec_push(&child.args, "http-push");
> > 
> > I wonder whether the interface would be even better if we simply passed
> > around a `const struct strvec *` directly. That makes it explicit what
> > kind of guarantees we have, and all transitive callers already have one
> > available anyway.
> 
> You mean that passing a managed array instead of a plain NULL-terminated
> one would make more places visibly safer at almost no cost?
> 
> >> @@ -1353,15 +1352,14 @@ static int push_dav(int nr_spec, const char **specs)
> >>  	if (options.verbosity > 1)
> >>  		strvec_push(&child.args, "--verbose");
> >>  	strvec_push(&child.args, url.buf);
> >> -	for (i = 0; i < nr_spec; i++)
> >> -		strvec_push(&child.args, specs[i]);
> >> +	strvec_pushv(&child.args, specs);
> > 
> > I thought that we had something like `strvec_pushvec()` that knew to
> > also optimize for this case so that we don't have to reallocate the
> > vector multiple times. And if we had that function it would even be more
> > efficient to pass it down the stack. But we seemingly don't have it, so
> > that argument is kind of moot.
> We could add one.  Not sure it would make a measurable difference; if
> the number of specs is huge there are probably other costs that dwarf
> pushing them to a strvec.

Yeah, I don't expect it to make a difference here, either. But by having
it we could use it in more places going forward, and that might lead to
tiny savings here and there that ultimately add up. So it'd be nudging
folks to "do the right thing".

> I have to admit that the simplicity of strvec_pushv() nudged me towards
> using a NULL-terminated array here, though.  So just having a
> strvec_pushvec() available could guide towards using the length-limited
> strvec instead of a simpler NULL-terminated array (which explodes if
> left unterminated).

And that's not a huge issue by itself. I think the version you have here
is totally fine, and I won't insist on a reroll. But I think it gives us
a good opportunity to improve the status quo, if we want to take it.

Thanks!

Patrick
