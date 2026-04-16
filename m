Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1140F1E520A
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776336386; cv=none; b=rS9cD+X2JDYhA65J2bNr2BEczfjgK8p47yxs3+6Dltfgu3+MoeqFjddLPU5XYeLpooCAijACR7QedS589UNL3Ml99uVGudeL1qJz13t1k86NR0Z+e3oflkIP6xMPRZFd90EYkg7RTWHEgEUHr9RwwKlOm7e/GWB8m3qqasAD93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776336386; c=relaxed/simple;
	bh=Zf3TpI8Qnhbvir2k55C9/rfP+Q384Kv6yTdOKXrxN6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMSFG+D2jvX/0nINFd45aYwhJanZAMjV31BOXnMn6je9S8ynb8cx2PsTN1iBqytOvSgnP9WgOL4BwYuVurd7HZcIJKFVWxGhKociUhG2nZZdiwvk/14LQTyClpAEpjUsXMkWB6wbLFedIvwz19de3/Trdsah/JwE6ojNJ2AXJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DZUB4xBq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vzOSrx36; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DZUB4xBq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vzOSrx36"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ED61F1D0024E;
	Thu, 16 Apr 2026 06:46:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Apr 2026 06:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776336383; x=1776422783; bh=FSUGaYQNk+
	//aPTzv02Cwrzu6GIvD5sC5s/8utulNMI=; b=DZUB4xBqjzUWpXAAs5bYfmDhdE
	agn3WkrRZ0VPZrClWY5ZbVlBA8onFkMqymZKEwqC/V3La4Nbx/nmgfc6E4Ascp7s
	yKYani/J3M3KYlsyHLX81aTcusa+qreELSi3tA/SwqXGg30tAF4rKLQBnT2O1lD0
	dhTO9iPFNEpCBiJj+eHHMXh609ewbrJcOqOjCFDaoVvADR8BzNY8GyYbaLQ4Q9fN
	2w13wgdw+rGHP8z4yUPFZqMuWK+HGTuJvvi45Z550iU7WQobcyEE9oCinMbY0dpB
	qle/k3BniAWNLKCbl0i6Xq/rykIBJUfNqYiodAz3LXPPsgeJez3w+xUEkI/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776336383; x=1776422783; bh=FSUGaYQNk+//aPTzv02Cwrzu6GIvD5sC5s/
	8utulNMI=; b=vzOSrx36Jaw5g63G+kGSGxt+vjhbRs5KOqHFaKlicGltVazBRwS
	A6wW8HF+5FCO9aBA8Fe93nmg1kPiUrMMHv78jLYRJiY+1jFh9/syA5oGuU7ByCPf
	qGqiYERMtCFkjT7YhQ4PA00F4cEnSsnw+rLSXixJ+rtYYJpZl8i+AsASC5JKPMrK
	jcGoOUuUUsisBLNhWGq2XNDvOxAwqsccYjtIVjMNet89q9FGJ+AVqdaiTJJi1PhR
	zQjYmFgczJR/GL9YnAtSejBOujwgTKJCYz9o/fk2JsXp+G/uzw8N23qjrsGP3Vxj
	SBPpUZHPsI0VmT/0WkRziCFyks3ysHCqIbQ==
X-ME-Sender: <xms:_73gaQ9YgqPpXDi1CE41cN3Pnz-kS7KXroGCAyT4lSIU6fytuiE5xQ>
    <xme:_73gaQLwQpu3qC8hSR1x1pANo5RtUHCeUK5i-Ev8hP4NO0kyrISkJtc0jzyNpW3Cf
    KnxqFTUIf81KtdCLWQEj6qLqWlOQyGljIPtuNlxWUi75c2BbX2ZPg>
X-ME-Received: <xmr:_73gaTYFeHHvDK4yzB-JEjdccKny1FzcpknNygRQh5j2ohDDhoyDfTKd1VyC_szI4KaXScFD5uP29Dy16QCWKzKtD2Asm-XM9HWghP2n7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepvefhfeeftdetleeugfdtuefgtdekuefgleektd
    ehgeeikeduudeuveeghedukeffnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:_73gaaI_W6-3mxscM79bRjntJmpaog3x_fzuO3ifuXt2zTuR7pYnXQ>
    <xmx:_73gaZAfvzQlQcKY0AccldToKAzXlNOG8iic8QIIwy1cFyik66KckQ>
    <xmx:_73gaXpRDS_LSrC7ZV5pg_yEKBtlv61jJ7craQppMlgwdFOHWsvGFA>
    <xmx:_73gachWKlatSPk9KlBmHn6dE4_mNcg-4nOiyJf3zjoY05kHoE6oVw>
    <xmx:_73gaY43wf0e4btPB18WeoNwtCHp8dpU6Pv8sDTHpyYQRkEDqNA6fwZD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 06:46:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f559a6c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 10:46:20 +0000 (UTC)
Date: Thu, 16 Apr 2026 12:46:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/12] t: detect errors outside of test cases
Message-ID: <aeC99qYToLuiyZco@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
 <20260415-b4-pks-tests-with-set-e-v2-12-4e4904a96f15@pks.im>
 <20260416060059.GC646814@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416060059.GC646814@coredump.intra.peff.net>

On Thu, Apr 16, 2026 at 02:00:59AM -0400, Jeff King wrote:
> On Wed, Apr 15, 2026 at 03:06:45PM +0200, Patrick Steinhardt wrote:
> 
> > Improve the status quo by enabling the errexit option so that any such
> > unchecked failures will cause us to abort immediately.
> > 
> > Note that for now, we only enable this option for Bash 5 and newer. This
> > is because other shells have wildly different behaviour, and older
> > versions of Bash (especially on macOS) are buggy. The list of enabled
> > shells may be extended going forward.
> 
> OK, we know that this does not cause false positives because all of the
> tests should pass. It would be nice if we could verify that it catches
> bugs, too. Doing this:
> 
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index e4d32bb4d2..5521f21e64 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -980,4 +980,6 @@ test_expect_success 're-init reads matching includeIf.onbranch' '
>  	test_cmp expect err
>  '
>  
> +test_expect_foobar 'baz'
> +
>  test_done
> 
> will fail for me, but only if I specially ask to use bash, either
> manually or by setting TEST_SHELL_PATH (since /bin/sh is dash on
> Debian). Is there something in both GitHub and GitLab CI that will
> reliably use an acceptable version of bash?
> 
> I guess perhaps Windows, though I don't know what version is used there.
> But should we maybe set TEST_SHELL_PATH in at least one of the linux
> builds?

Our Fedora-based builds use Bash 5.3.0, so we at least have some test
coverage [1]. But I agree that it would make sense to maybe also make
one of our Ubuntu-based builds use Bash explicitly instead of Dash.

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/jobs/13947942805
