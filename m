Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A651358399
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529252; cv=none; b=opvHdHoKOubjIYTZt2z2KIywoj/Hz/VMtSEA/S+Pg39+BKnTtE9LJoEUn4izMKQDVCg/0Ch6B7bK3gNcgTsl0ctRkOhzBKY/qblAWmLnuzJQR3+b2gBuDRx1+fr+OHDKODN7XliUL2eD/oPl/54t3rcU11yWr1731kWwuSBkZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529252; c=relaxed/simple;
	bh=ED2LXA1pm+4R/17+/6TLbayyheE4CONYAqupzme3tIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2wYd6D1eWXtjByRV7tkceTaKAHUtBsQrDem+3oN+eB19racsZ6hbK8vAI2m7KU0kCOW99qAm58vvx2kKCrQnfSWY9hC42JisrkV1rdNI1iq9bPbZFQbzr9RJgQ4wKW2d1WzAD/odpdLTjl9KYjjZNGOHPBXFadVG228Jm/2Ofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kHFrLYTK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW09splU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kHFrLYTK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SW09splU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 229F3EC01A6;
	Wed, 12 Aug 2026 06:07:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 12 Aug 2026 06:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786529250; x=1786615650; bh=dhadoO63es
	lrJsPjVmNJ+t8z5jXkyDWgS9bOSem6Jtk=; b=kHFrLYTKFOwKPHx3jPLSnoW9CB
	j9NVikZ2LGt4Qf8tSQAtI7xPQkR8VP79Y1lBWRi/ajbKzAXzABGstpwBBhWz46mi
	kCj5EC8Ln2Dg9Gs2FICHD1dBZjvegIzD/0MR50hey41Cwpk7yMPQtPKc5+YV9svV
	kNyqwBaQR9TJruTBY+4X+Mq6j7uyHpQaXoe+v/lNurVNh5ulKarqoO/7bzJxTAhS
	9k13NJOVldpyimp6uKooS+h/8tucEQMC/ujwlm4wYcRvM0hJpM2YlVvpSm2bvT+J
	dYGZMdBEMbIYwhUXU5xNN/Cq3ix2jJ0uy+40TMjmj3oDO/sJRM/hxBiejTUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786529250; x=1786615650; bh=dhadoO63eslrJsPjVmNJ+t8z5jXkyDWgS9b
	OSem6Jtk=; b=SW09splUojcsWQ/cHveaxkDIVCsAnYbimCoDLNfBcCQro3Hb73q
	O5tY4pvrziW7TDMl8BoMgBmO0/3upktgPLsYrtatzmDviNRULuJk5z2zO1phb35D
	O748VQ7YxRdXAL4O5UeRVcXw4asvYEyOtP4+i67KLSUK1hsbVnCfv7aQ04lHYO3r
	ddzbYnlB3TBnS/OmqUzfYvKOdKXEIGX80xphWH2vLbuO7qBRJcrNgGGcBLAcvbMZ
	sbByyJUAQ8ZsptherTOqGrK0H8pTLRTCG5qniDh/vcMPQA+p7iBpzCD/nrl7S1xb
	p+IM5hcr44lfnHRGXm21BPimYwcyOCI0ijg==
X-ME-Sender: <xms:4kV8aquuQqOHWODyFnhJUlCfOVvMAEVJbnHejvmazONe8p8OzyLUWg>
    <xme:4kV8alegiZSAp-1KpnAYctUuh3tYgj6H8cRdVAKpWt6mwza5o71ySlwNzSEuEcuQX
    HfaNYG4sDSr6-EpzBz2AJJvJIZkXflkk4NqNn--zNSfIoY74Z_hGA>
X-ME-Received: <xmr:4kV8ajZlJFvdv2fzISoC7nIyIoMUpEiyorH_E8pl8DwN3cfUQZKpTuwbciiVVxch6O9JdTP13zgOalszn1iw8IudiVC4B-9WwvTw1Mh0Yw>
X-ME-Proxy-Cause: dmFkZTEqHxMvoEq+W0hKH0zgk0LG4//poLE2jmasl3ma3fJ+s1bCPitYMNsoZ0lCt+/3Xj
    1inSb41nL0I+RUjPyMc2E3dmi+Fz9MqUr6xZRHdAsLOLxYJy1GmwDsThaVL5dv+qx6euJz
    WVYqQiOpUqsJ4DEwVp3rTOjg0e0/ehJTT77RgmKxm3aWRF9lD/06GYHSwMs5v6+biv7+HO
    uSAzj7HNd6PwdIRuICOeXWBiuQ+77jJxyynJAaEvhhOUYr5sapJyyBSGzDaYghiv6gf79p
    GJ8gMlXD3c+WoQYzCvXOCBQKjRak6SeoasgxeYLu7t7P61MslPOdBKJbOzbKIV70H6mxjB
    G+nmqPO+ZIj30yqT2d5DU116PoN7uZRSu/Q77epMIVy/WU1R//D7UEo1PAVFabMuc1pjYY
    vTzcW0TXBJSwsNjrQK3rYFRkdmFm6Edmq584Wa8CbY/yOQjUYKbsqGzNRlwUXE1asg9mw0
    OZAlhPtiteU4BL/A6xPNMhy3mcWGlhEYkTM2W3w7wPjZ3OpC/LhYBSBSzM/tYe0rKWAFBi
    dJc8DnkVnoEjG0HWHcgg0sGElY8YkkJEJLVTNYluXUvAMGgeDq9gsG9lSjLMOn5UtuAyY+
    2CBtSuDkd3AhwMco/7jGXAvewSCEfpPYpmZp8Wdmwq3pk6n1q+yMxEaWkk4g
X-ME-Proxy: <xmx:4kV8agXlD8uBU5kU6dw9h5JErYoAR8OhXRax2EBygaonZEmXWO56BA>
    <xmx:4kV8ath-6R29q6FYsPZoLWdFdm_4PPZPMYPOYvKZgoYPwEL5_gy0cw>
    <xmx:4kV8amX9GGFNC9xYhEFmUCXgMNUHHishY3kawdDh6_gMN9tS8G4E-Q>
    <xmx:4kV8asNU_dXhgpVRizwbOcsYCJ2HIq3b_IfamIaBVxGtgcl3mstoRg>
    <xmx:4kV8aldcZ9mUEw6Vr9T4M5ixa-dsIqKQ9sf_uc0b9JmQV4AroUkUwBpL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 06:07:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f86d4ded (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 10:07:27 +0000 (UTC)
Date: Wed, 12 Aug 2026 12:07:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] t7900: adapt some tests to use a throwaway repository
Message-ID: <anxF0P0KVizediDg@pks.im>
References: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im>
 <20260807-pks-t7900-fix-flaky-test-v1-1-08d0ea0fbbc5@pks.im>
 <CAOLa=ZTAV=JqOvE0xkE4zmHMm=xx40_3g42ob9RDBRXmw3u6_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTAV=JqOvE0xkE4zmHMm=xx40_3g42ob9RDBRXmw3u6_g@mail.gmail.com>

On Wed, Aug 12, 2026 at 01:19:13AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index 4238569b68..6735a9e082 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
> > @@ -67,41 +67,57 @@ test_expect_success 'run [--auto|--quiet] with gc strategy' '
[snip]
> >  test_expect_success 'maintenance.auto overrides gc.auto' '
> > -	test_when_finished "rm -f trace" &&
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> >
> > -	test_config maintenance.auto false &&
> > -	test_config gc.auto 1 &&
> > -	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
> > -	test_subcommand ! git maintenance run --auto --quiet --detach <trace &&
> > +		git config set maintenance.auto false &&
> > +		git config set gc.auto 1 &&
> 
> So we change from using `test_config` to `git config`, I assume this is
> because earlier since we used a shared folder, we had to undo any config
> changes made. Now that's no longer needed. Nit: This is okay, but
> would've been nicer to call out.

The issue with `test_config` is that it executes `test_when_finished`,
and that function cannot run in subshells. So we have to use `git config
set` instead, but because it's a throw-away repository it doesn't
matter.

Patrick
