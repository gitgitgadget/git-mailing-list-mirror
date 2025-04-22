Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E65194C75
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 05:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745300861; cv=none; b=QLOXjV8xKdwQfDwQltbVRG0IRGG4pvJa6M+hVez5affmuMrzEsktF/qFtCEJm6Yre90OgdlVhQUKmE/UQLNfa/ZCL3NU57Xoo6Md+DDRN43S/D5UMKm+gFg4B+spweSL4PGp4hYwln+Y0VfmmSGKnbx5vC0zFDolt8Rog16/qtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745300861; c=relaxed/simple;
	bh=go9RwyPjrh/ZeFtrmaAI8/+WYXDFkCqY1QMJYi9FaBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imA1+47WbYekvR8msZWjVX/DD5002O6/MA9WKz7cnTVcg0F58vD+3Ub5XNxl675KAf976TyrQWhZZGQn0dl/kicfbVryS0fsqLUXXClPn9epZhgSXJBzNiDTrPHnpPd6U2rODCtyrowO06UPPzRzWfvkkbUH9Fgmmv/T/SPwGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CVj96Jz/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qxIN/eA6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CVj96Jz/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxIN/eA6"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F6B2114027B;
	Tue, 22 Apr 2025 01:47:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 22 Apr 2025 01:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745300856; x=1745387256; bh=zqr2JpCjsl
	mOnqdZsWoE6JROZxn55rVrpGCa8LqtXKY=; b=CVj96Jz/mvzJ9+j7pD0e3Vw5i4
	dB9zdKFiakPdpvkyPHeD//Akj6opwxiejPaavUiEOvmAwV+FnPQIjxT0YTr264wa
	PyyPDH6E5kTIuOJF/eXLQ1YFTfUUtzisDwxGb7YEiD3Bfy/HqeUMIRkyLUb13UJW
	l1QZaLmDnuUGY9/tB5XwZDIQJR4m0xHFhU+Z1d3kDYaELHZ0TfCSBHtOdHukd0SF
	p8+TsHZ5JuEOf67tJo058clupvGySHZahVubU4L3yfLtUn0yj8+tPgrbpBBQnGv6
	JUZeJykJF4f93fgrvVgYkogJC2Fxm/Kv+KufuezKhM2pOGblOwFDuqAWi/Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745300856; x=1745387256; bh=zqr2JpCjslmOnqdZsWoE6JROZxn55rVrpGC
	a8LqtXKY=; b=qxIN/eA6dqAnb7VUFND0i9Fia4jb43pG6sxOXnXin2HscNt5lmz
	qT02jIbcWh2hDGW4n3rUkG7vmvBocSjD81qdaZuml1Kb0VY8o9DPyoOZpe8VGkzm
	M87qg3IxKhu/Rz2gRIYWqCB4YkIvFaCdNjN4+UwmQNagzkl1VMFn5m+7EhUCO+wv
	wTXHinLmYHpFCvBeRXWcJstvat8ByvvjU/sgeZ5jN3YJiJWj6z9xJ5Mp/ZRGIW6e
	si1eXvdKqZZazy3x2HqybTX5/XcmQLL4kfzoP81MkqL4eyhtNe/sCQy8+4fFdsmg
	2GfFPoKK/J9KbXBe5jt8lSTRv72306iapCQ==
X-ME-Sender: <xms:dy0HaDOKBpgJERVuKqn24U5ntPprgpDoJfBCxsTSAZKKpgqDR7ZP7Q>
    <xme:dy0HaN_F7IMtEAQHkHe10FbrK7pLu-GuExZnq8TK7oTBrhOfrnO6xUqUi91kL52QX
    qUEglGQRIQT0IuT7Q>
X-ME-Received: <xmr:dy0HaCTyiqix7dJEwyFFyKLsK2F4VjsYIHep4ypDFdNNvvK7TbLCAEBsGM7e2bvri5M_ITCcqfd8W4jAgtYWznQgSGYa0qp8yKUfRAR_AUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepkeehgedvjefgieehudegudffgfduvdfgudelveff
    vddvfffgjeeiveegtdejuddvnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhith
    hhuhgsrdgtohhmpdhvvggtthhorhdrtggtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepge
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrnhhthhhonhihfigrnhhghedufeesghhmrghilhdrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dy0HaHvdyE5LOfuEubuWUXSIQxJHOCLkYCw8s0aTpCwDouWkoC8hlw>
    <xmx:dy0HaLeTKhb4XgrX7QaDNXE_aXev4WT5Fyl5_SRYPS4Mz2J8moWKaw>
    <xmx:dy0HaD3rcRCmKwP9Wfz8MhjiVNeu9-ibyItuPPzXR-Z8GRl_c54NUg>
    <xmx:dy0HaH-Is47tc0c4Q8Wc2wDOdauLpttt9iv2uEW_I06icHn5Ytrc0A>
    <xmx:eC0HaK0pmHU-1exejyDzk4sLgN6WPt8e7jgW6UFwpOl4ewuTgqSwkMsM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 01:47:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ec140c5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 05:47:32 +0000 (UTC)
Date: Tue, 22 Apr 2025 07:47:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Anthony Wang <anthonywang513@gmail.com>, git@vger.kernel.org
Subject: Re: aw/t9811-modernize, was Re: What's cooking in git.git (Apr 2025,
 #04; Tue, 15)
Message-ID: <aActb3dB-r3s69h6@pks.im>
References: <xmqqbjsxkn6x.fsf@gitster.g>
 <20250418213531.GA89733@coredump.intra.peff.net>
 <xmqqtt6l9mlj.fsf@gitster.g>
 <xmqqmscd9mbl.fsf@gitster.g>
 <20250418215723.GA91116@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418215723.GA91116@coredump.intra.peff.net>

On Fri, Apr 18, 2025 at 05:57:23PM -0400, Jeff King wrote:
> On Fri, Apr 18, 2025 at 02:44:30PM -0700, Junio C Hamano wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Jeff King <peff@peff.net> writes:
> > >
> > >> So I don't know if git-p4 got smarter, or what. But we should probably
> > >> back out at least that part of the commit until we figure out what's
> > >> going on (where "we" is somebody who cares a lot more about p4 than I
> > >> do).
> > >
> > > Yes, and there was another breakage in that 2-hunk patch in the
> > > other hunk I sent out a fix for a few minutes ago.
> 
> Oh, sorry, I totally missed your fixes. Obviously, yeah, your patches
> look good. ;)
> 
> > We seem to have quite a many ubuntu/linux test jobs, none of which
> > failed due to the obvious syntax error in t9811, which probalby
> > means we are not running p4 tests at all on any of our Linux jobs.
> 
> I wondered that, too, but then I pulled the instructions for downloading
> p4 from ci/install-dependencies, under the ubuntu heading. I wonder if
> that is not triggering for some reason.

So the infrastructure seems to be working in general, as the jobs do
execute on GitLab CI [1], but on GitHub they indeed get skipped[2]. We
definitely download the artifacts though [3], as well.

I think the issue is where we put the resulting binaries: they get put
into "$HOME/path", but the problem is that "$HOME" is different between
"install-dependencies.sh" and "run-build-and-tests.sh" because the
latter is executed as unprivileged user.

Something like the below (untested) patch should fix this.

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/jobs/9760840184#L4002
[2]: https://github.com/git/git/actions/runs/14526556290/job/40759119217#step:8:1814
[3]: https://github.com/git/git/actions/runs/14526556290/job/40759119217#step:5:2190

-- >8 --

Subject: [PATCH] ci: fix p4d executable not being found on GitHub Actions

Our tests for git-p4(1) depend on the p4d(1) and p4(1) executables to
exist. As we require specific versions of those binaries which typically
aren't available on common distributions, we install them manually via
"ci/install-dependencies.sh".

This script will put the binaries into "$CUSTOM_PATH", which gets
defined by "ci/lib.sh" -- if not explicitly overridden, its value will
be set to "$HOME/path". This causes issues though when running our tests
as unprivileged user, as we do both in GitLab CI and GitHub Actions,
because "$HOME" will be different when installing dependencies and when
running the tests. Consequently, the downloaded binaries will not be
found unless "$CUSTOM_PATH" is overridden to a common location.

We already do this for GitLab CI, where it points to "/custom". Let's do
the same for GitHub Actions so that Perforce-based tests are executed
again.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 83ca8e4182b..412a9a5107b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -408,6 +408,7 @@ jobs:
       jobname: ${{matrix.vector.jobname}}
       CC: ${{matrix.vector.cc}}
       CI_JOB_IMAGE: ${{matrix.vector.image}}
+      CUSTOM_PATH: /custom
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
-- 
2.49.0.901.g37484f566f.dirty

