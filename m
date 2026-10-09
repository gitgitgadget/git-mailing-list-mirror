Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A83F4DF8
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525345; cv=none; b=MZJasvY5q9+Kdal8v0N5xuQL0O8HSNfdveFljD8SYLRZmikkMsy3uSoyN2WhIn8QlCQ8gT8ppSbaE11M7cjx2Euqx+L/jgolqIwWoxO6LxbA4KTLH7yYdglEAPUG2bwjLCs69irAWwp+PhQ5qIGU8OYzjOmBbevdQ+mnIJyvl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525345; c=relaxed/simple;
	bh=bpN/KnflcWmgE4WS27IlPVC6m9lDgrQzIOrNcb8LVzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq6KqOnMiNHAShM8s8mMY1VnuEKllDPJrRDiivuKAg4woBlY2C03kb+cVQhhHu7OoUIMA9vNkdkOGo8bDjsa5ofX2W1EfAwD9wDSMtcTP9ZWQTduMkbm0PaPZPpjehNShCU3L2QpEFXx5MPkMf268m+6+PKTkvnPf40r8U32XvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K/I1KUSt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yYE75+Gp; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K/I1KUSt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yYE75+Gp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0300F1D0005C
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 01:55:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 01:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791525343; x=1791611743; bh=D6qMvAGzpQ
	rNmg6YoYrjdm/vOQy0cEijBOxJ1z44Bz0=; b=K/I1KUSt3QU5x4A9XKjMlUaVFY
	uhdncMvrn5inH+zjp7G+smsJYAu8k0ZPyDjhkGdqTsJ/7FODMW+9NfQKJt5uf4O3
	sGbohLVGy3xX1KHAAsKNcQITInmbWceDou/Egh2T5ujhobFL3kS6cYRKwG3sMeLx
	6hUh1wYE+hGVGOeFPJEIuMhuciZhiEYEY9lvKe4l5yjOap5Jwl9QzQ02gyQcmCTZ
	KGGrtzRZazgTlvxnUjsX2sVoal2m/UgkaEsKe80WQ2CYK6PH+nxYKeTdfaAB2CnZ
	cDOXhz8rBqrfYduuAXRlvZ8VQ1L/urXFSFkbyHcTDDP1p6kBhXaoKLx2hwGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791525343; x=1791611743; bh=D6qMvAGzpQrNmg6YoYrjdm/vOQy0cEijBOx
	J1z44Bz0=; b=yYE75+GpTiZY1EW+SCjLlTWkXwktqHRwfzONLU9ZWijyoTmS7Zn
	xtWG0QMqv8pW4YtsdsCwtmk00kITja6Ii9O0nHSNZkj70kDcyNDmDlMTTAlpxQR4
	VMYk2CjwLjqu02ZlZDiXFfsgo7bHckPgpmm8tYp9tADfyONTKnx1MN78E3hjsIFJ
	isqpRLXxYwBq6lPdjQRKNfI1u8AeQTJ8akX0nc86Sbkyk7JoHr2l2sBuMUpoKRX5
	/3xpg1QY0IEk6LAlXP5lpKmM9twm+lcYN01NlvQPjt7CXwEW7NHxE3YHvy40qbTG
	AvzfKlW6+48h97xDntwoEbBD0OJbdP5eVxQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791525343; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dhtvIHGJy2JH3zdTKyMvzL2W9TcfeHCopYeffsiwbW0S6g2
	zgUzlNi1H4SjjgRN+wF0T/C9titfnmgedW+ZnUsCZUcxtu0QRBz2twx1KYfF1aAL
	UK1p/UxOSrIiLlOXjWH0AWlQkMgS5K9Nycbk8jwMIEnjrDsTO1ct7GnYWHxzQzQe
	7GrwvwpHKuC7/zIo1UCXnwdL1uVgvF+qHV7RibEgLcxHfb87Ih0NMFcUzhF9r/s4
	zWMnAStoos24ucmCxpGP+zBZqKeDgMGZa82QAKY/ZMWHbPoDts/fhJUrKi+P5DM2
	KIwR8SYJ8hJvM2e/i+3CM/mLiL8R551O6lcx4jQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:MjDs0i9fXaSm4ODqQFX6t7yYjA1Xj/KPcJZ77/hN1wY=:bpN/KnflcWmgE4WS27IlPVC6m9lDgrQzIOrNcb8LVzk=;
X-ME-Sender: <xms:34HIasK8MdEffqdKmtwXRI72XCL7bXPIbtwroZZK8cNmMvVoqPl3Yw>
    <xme:34HIajmibbKtA6TN00SMXWzr4UXZ25nS21j7fKwrH9lPgwfeSCLJhD3PlzvUNm-0G
    MQLjIAxBeOzGzVdBeC4WGWOCyM6AzEkN0WqTZR5FZDwGnXEd_qHfw>
X-ME-Received: <xmr:34HIaqFQd6eiSATtVCS_2itCyXNIyl1i3_Vq9ZKIhndXfvJ8fq2McQn2ujELdt6JzQtwQQ>
X-ME-Proxy-Cause: dmFkZTFJbdZa+BvYMcx7EF+f2a2SVXuSSm1MI2SUVzzBW3xDrNvAPRsxsWckVpOL/b4OSu
    RhA3HwNiLaF7pwozX6WOa+nEsowAJV4em/qa5xtKV8vqMJsU+jLSuR3qYd0RmTNZmhZ8K2
    ZCjjtwA+1QB2bgImySIqlQCor1bAkrSQ9eS8jO03L7oepCrhXW8rqCP38z5AjoP/B26Y4l
    DtHTioI3NpQOxWpVEq1Voxc+ao97iQ5TxG27TtPB+jnBTCa7PH8a9NKFAThTsrc6o3So3O
    gORYOMoZnBoiQ6mV3Ks3sB3LhQun3cFboTrRY3Bu02P+IoM5O9Cf8v+qgkCkQJSP4q0Zf4
    q/OjFL9clL5dQsn01hwhJz8bTmVSJqrYe9C7gnDV01X2fkWlShspJHcV/zprkvL9LW2r91
    zVHByfmGAbh8HVorfa/z3ZdJQimwUlp2F7sYjgAM7oiknuL3n8u5cTwdJfVH07eZtDcFP0
    gHRfRNzlOrmrOFMRntzTDgZgR9zce75w/d3aa7+FLvaoLspQpvzfGhhFO+OUGMl9+D4U75
    Z+Am54Og0oe2vI7G61FX7IEzuC6MORkBh6AYvNoWENjRpxtfmyT5nTq5AxG49cTxbqJiUK
    Im4PRLIpj9QNbk3MAGlKHAQ0DufUZxdZSzukFhn7ba737Y/mR1S8vajVG97g
X-ME-Proxy: <xmx:34HIajF-dFsZbThDDsmiUso83ivUkE7RwYNYJbJYWaIwSBGKIAvJfA>
    <xmx:34HIanM8h9ekkus1RCUG3IvVYoVTvz6uqQhPBq1Uij9x5qPskzcRfg>
    <xmx:34HIaiGQecMYx_Urgi-_09pltVANobv-x1jWnY9HyTZTaJ9DzORJtQ>
    <xmx:34HIauMNf1zQfVdyF8Pi_XeTpiEv0BeHlj0bRQySG9OdjrUk_IYY7w>
    <xmx:34HIaiUx6wNCzdtIxLhvuc0qatkzmDbceOacSUEXt06u6V22e7ulCWFB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 01:55:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 18a1ec63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 05:55:41 +0000 (UTC)
Date: Fri, 9 Oct 2026 07:55:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] ci: drop redundant linux-reftable job
Message-ID: <asiB25AareJgkKL5@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
 <20261008-pks-ci-housekeeping-v1-8-baf015c589c0@pks.im>
 <xmqqzewoys2h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzewoys2h.fsf@gitster.g>

On Thu, Oct 08, 2026 at 11:18:14AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "linux-reftable" job exercises Git with reftables as its default
> > backend. But this job is arguably redundant because we already have the
> > "linux-reftable-leaks" job that exercises reftables with the leak
> > sanitizer enabled, and it is unlikely that we will catch any extra bugs
> > with the leak sanitizer disabled.
> >
> > Drop the job.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  .github/workflows/main.yml | 3 ---
> >  .gitlab-ci.yml             | 3 ---
> >  ci/run-build-and-tests.sh  | 2 +-
> >  3 files changed, 1 insertion(+), 7 deletions(-)
> 
> As linux-reftable-leaks job uses NO_{CVS,SVN,PR}_TESTS in ci/lib.sh
> to disable tests on these foreign-scm interoperability tests, this
> change means reftable is no longer tested with them at all, no?
> 
> Not that I personally see specific value in testing git-p4 with both
> reftable and reffiles backend, the loss of coverage needs to be
> noted, if not justified, in the proposed commit log message.
> 
> Other than that, nice thinking.

Hm, that's something I missed indeed. I don't really think that those
tests are all that important, and I'd rather have all of these tools
removed from our code base anyway. But I find it hard to argue that we
should just drop test coverage for them altogether.

So how about arguing the other way round and making the job more useful?
We don't have good test coverage of reftables with SHA256, so we could
adapt the job to exercise that combination.

Patrick
