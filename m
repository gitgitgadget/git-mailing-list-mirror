Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DB47CC63
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577396; cv=none; b=CKGfL3LSXFMuKRi/iHgv/TsgxQH2ec1f+F75AreNHP/7QuiMof7BSg09HoLT9lws3ujY8fPHicFM7v8vCgX7ijVdnLVw8f0GarhoY6g7lEIxOG3qJOwWT2M2JFf2iRoRKhFC2ERI+QTqkIdQOzgBUaqWSAxy/9M8WrDvXAj7cjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577396; c=relaxed/simple;
	bh=nvLl39ilpvZBg2nnOPyCoba/06gTrAFB5xT6TCHmZ2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmh9Us4+5FDqXUvgo1VxpcG86MpHKMLH+htb/btUieT4z1gljV2X3oJb7bxFYe2Bw6t1R8/kAJcfJAFWwP+1orkdOu20DqHZbWG6K2qIHekjB6Kd7kuvff+Jz61onHjh2bbM15i9DQdyqtU93tO4SUvHScb38LfMbKaRhfARAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MSS1QM8p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXIZpjnO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MSS1QM8p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXIZpjnO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45CC41400135;
	Thu,  4 Jun 2026 08:49:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 08:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780577391; x=1780663791; bh=nvLl39ilpv
	ZBg2nnOPyCoba/06gTrAFB5xT6TCHmZ2E=; b=MSS1QM8pc0O5T9Dx3fDThT19tz
	rmZOrD37uyOwxlFFT3KhFk275BhHTq6U8OqhPWTL78npr1RHdJMkMn0UHC0kprVx
	2HE5lbJ/u4PrRlCZ8LC5xUBes/lQjiKKGvrONnUGNC8k/rIIoofV2F4rnRh8KpGR
	cN4x7cbR9A8V+XcxMuv1qge1kDmlavngFX4s9rMZUGbFRcSGD5cB3EEMSGmIyu0z
	ACqI4lpUI+kJ13qTMPokelqnO1+fTOpQ2LP2/i0eg/uMEe5YdtMbeglmzwZK4hUc
	A+lNvZsHZNd/kuFlLHUkhhBX0/lm9441esT76lvUhdEMkFzT9hTKE0YSfAoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780577391; x=1780663791; bh=nvLl39ilpvZBg2nnOPyCoba/06gTrAFB5xT
	6TCHmZ2E=; b=MXIZpjnO+AcFM7UpsTqj2xh9cghlaezmxw4gvzZ5fEVbLRMqs8y
	19xRfNfgMyCCe0i40QiFMelZq3PZG83m4kAA0LtmsL7aJPeRgpJydAQhNHerengT
	nCKdjYzQf+Y13EV3f8URMML1sa1A46lRX+K/wdGW03tvZNn0qAJJksUtjBzn3bpf
	6D7KG26qVouvT8vQajOzTmwTDUpZvgtHACveU87t7XPF6iNN259xhvxpc0LjVM4x
	wKckF/RMVq9CqidF+brN5wFWUagpa+Tm6nY86MV3s0RAbqzASpl9MjOtGBECIxDB
	Ab8lBEkVOxUFVFTURfeifQ1b4lieIyI1Gzg==
X-ME-Sender: <xms:b3QhahHqdcGDEJLxB-f33HdbOm7EdeOeveIZjhGWGm8hiX9kzDHbHA>
    <xme:b3QhasWOv62E4ppbDFOjfXmr49tS3i-du3C2HQ5izZd-lSkrjFVX3Kxsi9uEb2uxP
    HPSyuJZPrpoWmMtEkzKYTggToakkaljLAGZXysSfRgJuNb7WD1e>
X-ME-Received: <xmr:b3Qhagy-ubwc819DUbdcGYaqdOSw-2vfdxNCufXlr0_ax-JKH1F6xryvQapcHiTdc2Wghf_GokUq6ILSBckX0nSJw_cRDvYrzV7OFhII9vM>
X-ME-Proxy-Cause: dmFkZTFTdPjtT7ahdr4g20pwf3YdciMM2L17Uzc3ji351JTtKZ34XjM8r9xS7Qr8dsBchO
    HBJEox+MM4jznMECUQ3fIi36ji735ij9cJ1JwYAVRbqtKFTuloJGr3pmwEoGhL/dscXWTe
    EIqSrzNuwZcWExsHmHmy9SWONmQDyus9aqKozZ2lA/SQqvdsVWbl9cUmL/KsUmE4jvR3JM
    znf+qlxTz/A1zXjTRzsfZdSK3yPIjbxPEujLUgIGLDOn7wqyFOtlfR1P1r4HNdVrFzL3cf
    UI1ETWAjOzTraGeIMGCjxwsuiULQEKPaXIGfdGQEMcCWl+lphS6qSu5YlLMcCvE0vUgeZu
    Q3yNrDIhy0Ecvj3QfvkKSUPff4QA0+2xnzk4B+Qx0IxnrFIYr/LBfs45GmdSOc77sWkZwe
    HeI9LsVjEflExvkN4a/EnbT0v/J/PApcumsUY79RjQY5QcQxFbTZ3X1h8tYdvyQ4l4tcRy
    oJdZ4pJUSQBzBN1SaTP/YpPcK++LuUvTJHxhHa7fj00i8nWIJMpcAFeY8EzttszXBu/kqC
    /zUucIywtTCZ0G9CruTLkK7AmnFqWdBJ63V6avY/H+mtjeTFzcR6/DmV4dryAoSmYjI7xv
    y4Bxm8dO9+xaNe8G7zoJnjuIrpcA1jo4oiSD9ij9lv2/yZ/bQUcQcve3bdaw
X-ME-Proxy: <xmx:b3QhaiP8vv6crT-_MBEPYk7Cq-7Iq44SLjSozlLXvwT2W_MYK0OxhA>
    <xmx:b3Qhap5K48GDls1Zl1Y3JDc-QzJ2Jf41W4FdKoV7gV8rJ7JX16OdEw>
    <xmx:b3QharOkEC7yO7_jt16uL0gbRi8UdaNk7XfL0eGxS5EEOUlaGuo8NA>
    <xmx:b3Qhavmkp3sdUlAewgt28Y1fyuvVzMd_n2esL3TgjeRNZuC6l3mypg>
    <xmx:b3QhasdUxnTUCYSiTFhHgR8S88mZ8aTrOX2sZrVMVoBO3n4Zjl9ozPEM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 08:49:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d62e8b8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 12:49:47 +0000 (UTC)
Date: Thu, 4 Jun 2026 14:49:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tomasz Konojacki <me@xenu.pl>
Cc: git@vger.kernel.org
Subject: Re: Is it intended behaviour that 'git gc' ignores the
 'commitGraph.changedPaths' setting?
Message-ID: <aiF0aN9BwBvQffGL@pks.im>
References: <20260604132419.F2FA.5C4F47F8@xenu.pl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604132419.F2FA.5C4F47F8@xenu.pl>

Hi,

On Thu, Jun 04, 2026 at 01:24:20PM +0200, Tomasz Konojacki wrote:
> It seems that 'git gc' (and also 'fetch' with 'fetch.writeCommitGraph'
> enabled) ignore the 'commitGraph.changedPaths' setting.

I think this is a bug -- it really should write the bloom filters when
you've enabled the above config option.

The root cause of this seems to be that we call
`write_commit_graph_reachable()` directly, and that basically means that
it becomes git-gc(1)'s responsibility to set all the correct flags. And
as we don't pay attention to "commitGraph.changedPaths" at all we simply
ignore it.

In Git 2.54, the default housekeeping strategy used by git-maintenance(1)
has changed from using git-gc(1) to use individual tasks for more
flexibility. One of these tasks is responsible for writing commit
graphs, and that task doesn't call `write_commit_graph_reachable()` but
instead executes git-commit-graph(1) directly. And because we do this
infrastructure works correctly.

So my recommendation would be to stop using git-gc(1) altogether -- I am
biased as I have helped implementing the new maintenance strategy, but I
would say that git-gc(1) is nowadays a legacy tool that inches closer
towards the end of its life. Git's default maintenance nowadays uses
git-maintenance(1) without using git-gc(1) at all anymore.

We could of course fix this, and it shouldn't be all that hard to do.
We'd either start using `run_write_commit_graph()` directly in git-gc(1)
or we'd start respecting the config option to pass the additional flag.
I myself probably don't care enough about git-gc(1) to do that anymore,
but if anybody else feels like it I'm happy to review.

Thanks!

Patrick
