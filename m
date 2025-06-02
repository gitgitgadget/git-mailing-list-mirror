Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36085221739
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879805; cv=none; b=s6OjvGrDDyUS7Qee8Szbt5o6eKdDL3ezfZh0YemxTbY2TRbZVezfp7TP2+NtinXMinDobKA8yHpIHlFzWUiL6KDnj9rfI7+q/ilBdjWaGwOq8SGpYD48k/FGCWzWYF8TZLV8u+6GeMf6oFLgjomOib0XwkqwRGHi5o/sSuj/ZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879805; c=relaxed/simple;
	bh=q0baTZI18Rbzwbjfm/JckjJPoPE3NsfzsrWe6cVIrCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7vWMJ1VRwRwBKsEAInycSEvfWkeSZDI5fjsHrFYtgP7EifAnJ8BmXiRwk38rHsah5F+zsEjuuH636cgflHK2PFY3Vzvj/29vgsNzvfsXSpAxsPn33Tsl/fay7XRV6PHuuoUdD4pvXykbidT3XHZF59FwQaRtlO1pUmkQhqhnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ql31NkoV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JrammniO; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ql31NkoV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JrammniO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E191625400BA;
	Mon,  2 Jun 2025 11:56:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Jun 2025 11:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748879800; x=1748966200; bh=QS49cF9HAD
	HTArVit2p1qG8bMeMNYsmWZR2qC8LKsFE=; b=ql31NkoVQRLK/PhiTw1IgFTk3X
	WvhONQxXvkiXwEQd/tv0mjeEFd3k7KvaUcA1apRL0uUQz5tX43dx1PHxljRw5/gg
	Lh8YSt6A/Rqwq/MWj8Rxc1VDVkw6foDwlfnB+4T44pRjD/KG3B0/NbsFWMQLep6T
	ZdH8pT5J8Vh7+bBNeRaJYIb4RCDUvl0nnkq0fPhxa4natSmnrSqHP9oWrPF7ugrt
	CTFUPtJ2B9eqISbp8qyslDgjoWpmkVjN2l/CHXZY8cb35IkAXqqudzEEY4BnZljg
	uZIYxG4chdkkKSG0p1Hr+ZMcCOth3kT7w/nTzI5ERcdjmUXxjL1CEHon0laQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748879800; x=1748966200; bh=QS49cF9HADHTArVit2p1qG8bMeMNYsmWZR2
	qC8LKsFE=; b=JrammniOhsjQQvtL1KdQCyaJeNQ49nQMnBuGFaPri508S+Ze4QZ
	yRGcg/8PBNkiM+jJJ5AsJePHfYVG95CneCFKLSqsg8uwOM3c/MO9UftD2UqHiInn
	msH2q1MIrO7FByCerdqCyLnaifInLDY7RfjR28Zkdhb/g9Ar/hhAzE9+lTyskrVl
	lD5F3hCwbFVlP+PJ7VTeOkifm03+fFROaOwkW+O6Ait5VLblwIfxHGv/4InVmErh
	G1LxNaJw8AMcZQRtL87vdqMS22OclksJzzm8GIj9ZDGQo5/eyS4IzrEUA2xq+kYR
	23+DmRoUtONDBDtL3Q3u2XJsK6U9I+f5ngw==
X-ME-Sender: <xms:uMk9aBwx4cjFfTZexWmG2O6vPI2_7_-E3gdMmoeRHMa1f-vADupCNQ>
    <xme:uMk9aBQtx68J68zPJSh1qMPijnC_l8r4JR8pYuY5_A0plRgmEIqqnKRYgQWNf2LGo
    OffaOHUORCgozXS1w>
X-ME-Received: <xmr:uMk9aLWBHqjl6r0TyTZklC_k6KhiosXDRaLQVjEiGvag8fi_2MSRDTmvwc8-nxUGhBsU2ReNpQYyS9jrHLEUYijFogT7c31JV9cS4bj5b_UT5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkedtleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:uMk9aDhERcsDRzkVOylGHqMC_eGeDvNiXQ08MKLt-FUOhX5hjcOwYA>
    <xmx:uMk9aDAgrHe1HkEmS-C6prEwRbS42H4Cj29rfCaWV14wxy2UOsa4PA>
    <xmx:uMk9aMJwW2bOMFkWVQa0VXSy6i1cOQQ0urRSxTBmcxgReABLfjP-Tg>
    <xmx:uMk9aCDgsl16c1Y2ReKW5vKONVQFUGycoZ6f_0R5vCAwi8MCtpb0CQ>
    <xmx:uMk9aEKlvifcb5jZDNP89GzubbulET9ApXoGOnQhLtXJ9V3pWLJA6cvq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 11:56:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72d75fd2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 15:56:38 +0000 (UTC)
Date: Mon, 2 Jun 2025 17:56:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	jltobler@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] receive-pack: handle reference deletions separately
Message-ID: <aD3JsdlRPVi4wjuz@pks.im>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-3-903d1db3f10e@gmail.com>
 <aD2SPsro694yr60Z@pks.im>
 <xmqq7c1uuq52.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7c1uuq52.fsf@gitster.g>

On Mon, Jun 02, 2025 at 08:20:09AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> >> index 9e3cfb85cf..7157ced2a6 100644
> >> --- a/builtin/receive-pack.c
> >> +++ b/builtin/receive-pack.c
> >> @@ -1879,6 +1880,8 @@ static void execute_commands_non_atomic(struct command *commands,
> >>  	for (cmd = commands; cmd; cmd = cmd->next) {
> >>  		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
> >>  			continue;
> >> +		if (only_deletions ^ is_null_oid(&cmd->new_oid))
> >> +			continue;
> >>  
> >>  		cmd->error_string = update(cmd, si);
> >>  	}
> >
> > Fancy.
> 
> Is that a new synonym for "not worth being overly clever to
> sacrifice readability"?

Yeah. I wasn't quite sure whether I like it or not as it felt a bit too
clever to me indeed. But I didn't feel strongly about it either, so it
turned into the above somewhat unhelpful remark.

> This may be a comment for [2/3], but a two-call sequence
> 
> 	doit(only_deletions = yes);
> 	doit(only_deletions = no);
> 
> looked somewhat iffy for a first reader, as it hints that the second
> call would do both non-deletions (i.e. creation and modification)
> and deletions, which makes readers wonder "so we delete twice and
> rely on that it is not an error to delete something that does not
> exist?"

I also wondered whether it wouldn't be nicer to have the loop in
`doit()` itself. It would require a bit of reindenting though, which is
why I didn't propose that variant.

> >> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> >> index 029ef92d58..34eb3a5a07 100755
> >> --- a/t/t5516-fetch-push.sh
> >> +++ b/t/t5516-fetch-push.sh
> >> @@ -744,8 +744,8 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
> >>  		EOF
> >>  
> >>  		cat >update.expect <<-EOF &&
> >> -		refs/heads/main $orgmain $newmain
> >>  		refs/heads/next $orgnext $newnext
> >> +		refs/heads/main $orgmain $newmain
> >>  		EOF
> >>  
> >>  		cat >post-receive.expect <<-EOF &&
> >
> > Hm, so the ordering does change now as all deletes will now be listed
> > before the updates. We don't make any guarantees about how these are
> > sorted, but it makes me a bit uneasy to see this change. Can we avoid
> > this change in behaviour somehow?
> 
> Good eyes.
> 
> I was wondering about the "git push -v" reporting and was happy that
> the order there follows the order the pushing side listed refs and
> the reordering on the receiving end would not have any effect.  The
> hooks on the receiving end can indeed observe this change.
> 
> They can observe, but can they notice?  If the pusher listed refspec
> elements for deletions first before creations and modifications on
> their command line, that would be what the hooks see.  They do not
> know what the original "push" said so they have nothing to compare
> and complain.
> 
> Ahhh, but humans that control the both ends may notice and complain.
> 
> OK, I think I agree with you that it is worth to at least spend some
> brain cycles thinking about avoiding the behaviour change.

Hm. The thing I didn't realize is that the changed output order is for
the "update" hook. I thought it was for the "post-receive" hook, where I
do expect that ordering may matter as you see the whole picture of all
refs that have been updated. But for the "update" hook I think it is
sensible to change the ordering -- after all, the order of updates does
change a bit now. Furthermore, the "update" hook itself doesn't have the
complete picture anyway, so it's way less likely that anybody relies on
the ordering.

Patrick
