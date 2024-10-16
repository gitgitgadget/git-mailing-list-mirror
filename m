Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E264204921
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069039; cv=none; b=aH7mEnYAg7CPJQ91CN3bxwqQwp/QQ0nlKAV5bso0b+mBkXzEQiGEvcgqsSoup93meI4XCS7cbzJWeZfaFnwKRdmjNzMWyOV8HiSDvT5fJvkmkkZTU7HCt2a2IQavobX+geQb1Ah493m/+uJ04bWBNGyfVDjVZUjQxNPx1k9bzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069039; c=relaxed/simple;
	bh=jHuhnIIJF9PSLxRDuclKRrShOdkLMLj/1t5jxjiOBkY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXciVFt+enBqqY45HjwrYouQQEnTx53Dpfzsdw9hEbORfSlT2ksKtw/rMnLNzPrla0v+4DWUGpE33CsCoLmag8f++0mn9QhPc9k0XRVeLSChrFKfNtfUgVuAuGz4Uwqh8a08AHYtZdXJjG0B/6urEIGa/uQnXvWjri5jfkvoWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LWN+SIh6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AcA5dq2L; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LWN+SIh6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AcA5dq2L"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9331311401BC
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 04:57:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Oct 2024 04:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729069036;
	 x=1729155436; bh=Yv2FR/VV8BsV6kAE0xDV4GODpTx/rW3/mT4j2OF5np0=; b=
	LWN+SIh6KlaEpHzUaLhETCFzQ2G+CNdZcl9FzKlycP8cZslmYY6BWGbJ+4WC3i4t
	LJtKDIGK801y6FpMm1Pr6oNfyWITD5+Us07xwy3zWTcsS9lq2bxkaMuzjuwjjA1I
	Sw1t5/s63ggSJaaHk259lTz60OgfeGfDrVhZ76J8dYTDfARRkVgrOMQ6whqpnt6d
	Q190Ukc/aa17zlGsQiy6AwS2h48fcz8lzi2OedSJ1mhj0zee1cvjhoOVEOlRhNhr
	j+otSsDNM0mc/NbNkXxCUhI47/2vyGbSTh0lTZFJSrNL3FvV6HX9qvvIQGn8DrUD
	24z90+dWnXmruEJCLpZNOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729069036; x=
	1729155436; bh=Yv2FR/VV8BsV6kAE0xDV4GODpTx/rW3/mT4j2OF5np0=; b=A
	cA5dq2L0wCIQzImVrlxKY0I21RSEOL5qmIbSgLxcG0QlEwTg7Dnk71WeNrJcMx9J
	QWym4alr4X07f/+vy9RRNUCDos+8H/AQJujplJt9LvgbDHg+gXk0wI7K8ywyvVnH
	KMKtg/Do14RPj2gB8UXcI2jvxhn/nO5+V+85Rw58vv5tgIuQeDnMiIr+iaWqdy/p
	iDCkKc1wd30vHhSALwrMIsk7SA8ZRBsOwkzVTSU80rXw27q1MwNVqsoJa3urP0UE
	yKXr86G7+lanGYFvM/fQfbJBKJ2QsyGmmf4qaeupYmq6IDw3N76qR7I5dmVggrm8
	NRF1BObEzkRyW/RbuYZfQ==
X-ME-Sender: <xms:7H8PZyClNE_lsgzVhRJK3LZ5ZJP1A44AYCwxNtiLQ-eeZKzJa36tsA>
    <xme:7H8PZ8gqO0cfZFsCT7ztLXju_6OqhYS9v-opWvu479mv3FGryrnVSSkWfFpL1SLXg
    qU5JgvssFY_I4D7Xw>
X-ME-Received: <xmr:7H8PZ1k_YVR4KzC81qW-Qn0ZcLAyfv4O0WIbg4EionELE651kuW4jnkh1a-xRCHjyHSJxcX1yAlYCvl0TJnDZnXOD8sisGmSQ8vwTkvKnXM4SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelheffgfegie
    eufeehieethfegveejvddvjedtueduvedvvddtkedtgfegjeffkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7H8PZwxbQSWVXM0eDvIa-NSgyZj9ZC8ky8O0eKUemlA15V8u7Psfig>
    <xmx:7H8PZ3RQ9Ce06QwkbQ_zyckNaofmQiW2S3-PhXVA4dIKOkJKMwXYTQ>
    <xmx:7H8PZ7YVJcdglD5ENtmYQIZY51yT4BDMx8O7P2aDMtT-SVZmjScv_w>
    <xmx:7H8PZwRUsWb_b110-DkQj7KxdpksOt_WxiAHmq4tkSt8XqqLCfChVg>
    <xmx:7H8PZ-I7DB0FzFJHDuwybO_qpr8482A7F4H1_UPyN0lOZYa3pG1Bdc8m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 16 Oct 2024 04:57:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0448b227 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 16 Oct 2024 08:55:57 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:57:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <Zw9_46fbvbGhjmYw@pks.im>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
 <Zw9P90_QtiAAH3yz@pks.im>
 <gtdjnvonjodr435wuv2pofnww2pdcd33s22xxz5ypwkpvdythc@vrajz5ttkjbz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gtdjnvonjodr435wuv2pofnww2pdcd33s22xxz5ypwkpvdythc@vrajz5ttkjbz>

On Wed, Oct 16, 2024 at 10:47:03AM +0200, Wolfgang Müller wrote:
> On 2024-10-16 07:32, Patrick Steinhardt wrote:
> > On Tue, Oct 15, 2024 at 01:48:26PM +0200, Wolfgang Müller wrote:
> > > diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> > > index c20c885724..ed39c67ba1 100755
> > > --- a/t/t4201-shortlog.sh
> > > +++ b/t/t4201-shortlog.sh
> > > @@ -143,6 +143,11 @@ fuzz()
> > >  	test_grep "too many arguments" out
> > >  '
> > >  
> > > +test_expect_success 'shortlog --author from non-git directory does not segfault' '
> > > +	git log --no-expand-tabs HEAD >log &&
> > > +	env GIT_DIR=non-existing git shortlog --author=author <log 2>out
> > > +'
> > > +
> > 
> > I'd like to see another testcase added that exercises behaviour when
> > git-shortlog(1) is passed SHA256 output outside of a repo, as I'm
> > curious how it'll behave in that scenario.
> 
> I had a look at this in builtin/shortlog.c's read_from_stdin() and am
> pretty sure that git-shortlog(1), when reading from stdin, simply
> ignores anything but either the "Author:" or "Commit:" lines, depending
> on the value given by --group. The --group=format: option is not
> supported when reading from stdin. Neither is --format handled at all.
> 
> So I don't think there is actually a way to make git-shortlog(1)
> encounter and handle a commit hash when reading from stdin; the hash
> algorithm seems completely meaningless for its user-facing behaviour. As
> far as I have seen the closest it comes to getting into contact with a
> hash (or more specifically, hexsz) is when cmd_shortlog() sets:
> 
> 	log.abbrev = rev.abbrev;
> 
> This relies on the parsing machinery in parse_revision_opt() - the one
> this patch is for. Technically --abbrev is honored by git-shortlog(1)
> when reading from stdin, but its value goes unused because of the
> difference in code paths when reading from stdin. Do take this with a
> grain of salt, however, this is my first look at the inner workings of
> git-shortlog(1).

Okay, thanks for the explanation.

Given that we do set `log.abbrev` I think we should be hitting code
paths in git-shortlog(1) that use it. `git shortlog --format=%h` for
example would use `log.abbrev`, wouldn't it? It would be nice to figure
out whether this can be made to misbehave based on which object hash we
have in the input.

> As for the test, I'd be happy to provide one if this is still deemed
> necessary after considering the above. There's two questions I have:
> 
> 1) Is this already covered by GIT_TEST_DEFAULT_HASH=sha256? Running the
> t4201-shortlog testsuite with that passes.

I think it doesn't hurt to have an explicit test for this scenario, even
if it just demonstrates that things don't crash or behave in weird ways.

> 2) I've already experimented with setting up a test for this and am
> unsure how to cleanly set up a sha256 repository. Ordinarily it should
> be a simple init/add (perhaps with test_commit), but t4201-shortlog is
> already running within a git repository if I understand the setup step
> correctly. Is there a clean way to escape from there, or would it simply
> be fine creating another repository within that one?

You can take e.g. b2dbf97f47 (builtin/index-pack: fix segfaults when
running outside of a repo, 2024-09-04) as inspiration for how to achieve
this.

Patrick
