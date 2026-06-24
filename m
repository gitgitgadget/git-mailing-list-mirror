Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471201FDA61
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293620; cv=none; b=NnubSRd5WNAGhQZiAAYAzSYNTXBTeDOToJ1vqsF1HE0DV1idbizpkJ6hVOZRMwmwvyT+HXdhamnrGxiFWpsVHlHlgUJ64z6hYci+og2JoISFKpuqigD7QYH/pxZ5oP/PBsB87l0Bd+e45WvGh0dgc9uu+OhpjcZ6mU7K7GOZkLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293620; c=relaxed/simple;
	bh=czo95j0GoETddqN09t6aW0BA2SJslayYWU8LzTIu+YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaxWFXckUOjMo5vfOHY/L1lwL68IVsPmIcZZSM69lLpWnXAxd3+pFdBnez3A7w9BFof/c/UisxFPTPo1Aa7ay6aIGpHDslfIWs/LOq+FP1iRlF138CIKPJ5ytA2pimfLpD5YsJwRk6pXaofJ3Nx/yjwzOQS1NA60XrjFoDW+XNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n4ZVJ5tg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NmgtmH/I; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n4ZVJ5tg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NmgtmH/I"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 545BB1D0003B;
	Wed, 24 Jun 2026 05:33:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 05:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782293609;
	 x=1782380009; bh=R0QsTT1rNRDW5pUNg4o5+YarQJdHHZKEQE0N9h/KhVI=; b=
	n4ZVJ5tgM9sAmS/xgU95kIdRWnxpamsT0R1i8NreyIcm+nw9pUi7dltThCwvgrNm
	pFuusQel9+p6pZf3fivTj7Skv3q3q36yvbgtv55DhNWeROAlKIsDbB9MftRqr+5n
	w0ZzZmtoRsecYVaPYq39PTMaNuKj0JB7+RAcfpca1cdZ4FMHoPpzklIbbPP4cEs1
	wU1VQpdNQQeUdKfMp5ExEC9YncTG3QeCuDy/0xP9rrldGseXJrd1E2gLjJNX91Mw
	8CjfEe7Y6kkIkEHUfYN323X2p9VCOiDSyeGpG3SgrqzeAKPPAyntpX5ZBPYBwxIx
	JIqOOo2U/+mpFrFdw4pubg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782293609; x=
	1782380009; bh=R0QsTT1rNRDW5pUNg4o5+YarQJdHHZKEQE0N9h/KhVI=; b=N
	mgtmH/IlfiQDSqtoUuVw8X3WYm5gukYAWCRYxRRSK6ORa04AyTbRBdVqv0arm03E
	dc1xsA9tkI6EfcNdcfz+YcqOpFcg3N77+uMtRE4VE0x8cE5LQrI6cNRccA8oToWz
	opUwRmA9BHqw9481KTF0SDf2Yz0mLPphIY/0ph+eTUPpubx3tAqe5OrZOIOFxOm8
	SbkoL2mWPKM40O5OvMR7W2xJ6Fobl4fxaDk0KSPTWQFowbyXvZqeOe2jc373L0qk
	bEqf1DxNrdm5afik5P99bZp37jq16zUsnl2LXkhfqy1bSB0gprwj8qL71w5slspV
	UqFoa2htveDob5rf4KbFA==
X-ME-Sender: <xms:aaQ7av4OIgaq0gP30PH5jBInOUOc0_v5T8AFcFfUv1Hvkh4AQCjhMQ>
    <xme:aaQ7aq41tCRzwHbo2LIk3AC_PjSxdeG_vIxBzLD8pqZl47Xek_QVlnjzB8jlEoYYj
    vINJZ9vkQW62bgI4steHa5ybkN74L-DRElG8wnTuJnuq6JTHsmK5A>
X-ME-Received: <xmr:aaQ7akElph0ufENRNXYRt-1EoHVl8j7ImUd3Zo_JU6syKZOKktWbUoG4tctr_QTdmJiTIqKZwRwpmj7a8f-BFVVrwMF25HNODLQj9za->
X-ME-Proxy-Cause: dmFkZTGTVvSf6hWUF20CGOGNs9aWDIIoApokZy3QnuRr1e/19yHFrcadCZL2zdlOHsrq1P
    yG8f3EUWjqPdK8TpteAd0hvHsSEr7Gd88uRePazsUhB0Y6exLbl7FtoIQN4t2g4NKqYmW4
    WtHXyVUE7JeXqpObXvvjtsnntGvPUhYnmISmFJHOHnRw1f0lO7kf+pX9j6mAJGJ5x98PPy
    YLq3regmE7mJYi3SlrkTB+fcSjdJJ1vUfL0ZjjSo1sX1o1iuuX3/1UCSOjrrkddIm3/IWz
    BnHkk6uSfI8jDTi82tOlTn6QO+v7SAe5SF9dod8vYEDmmr8mNmEFqERYeYtH+fdI2w2Rsu
    CTACq2b9rDy0ZOctTgnf1UR9ZqnU7oAQqY987LX6KL/8Wr1yEHNfLIbAUmr73D+HyJgBhd
    4bBi7ChNJhgiW9FuFmP2YogeU2CI++h3ykHVnGatQIrQXW8wN/V4xMLrPJ8W+E6XpOFXfh
    Ah9UP6GLDYXnizTtWQy2cx6C9N35KEuVUWvadQEpj0K1t8yORaYeY5xx7oNZLUR8SstB+3
    oSJoH6iCpA+RLMr3lX+GxlI+/FeqQUkyQGEr6K0S2xukF2kS4BBsLLQLGjyp8E5SKI8g1T
    zpuxwlUdr+u8XUQ1vvUpEInsnKTA2vc5B4RnRGj1BzBUFBuwA99Ejh+d/vpA
X-ME-Proxy: <xmx:aaQ7arSL_MLSNtZVppNG0pW2bVSYiI-tmsjCAAaCDRAI-xa3VVsmqQ>
    <xmx:aaQ7aluxwbaZzR6arkHGY4ku4Q8P_XduL0s8NroldHXZ3oTcwY22qQ>
    <xmx:aaQ7aiwxTN37XpD3ZEna9o1tng0ng899qGS95TehYxyDWBDAhw1PzQ>
    <xmx:aaQ7an4qwwVBh-IJ1HAdLuRxIbHtxyEnIR-yQYr8vvYV9fTNXla9Wg>
    <xmx:aaQ7atpJcZ8tmb5EXWoS9BCZM8kwfH3M4zZmnG9S6x61tOdCsN-ePngs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 05:33:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75fc9398 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 09:33:27 +0000 (UTC)
Date: Wed, 24 Jun 2026 11:33:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] connected: search promisor objects generically
Message-ID: <ajukZGjCzg8E2U7E@pks.im>
References: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
 <20260622-pks-connected-generic-promisor-checks-v1-3-25eba2698202@pks.im>
 <CAP8UFD1tqBBRiJV18xBMcDDT4Q7xCkqOLrtJGAO7o4oA=-Vr=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1tqBBRiJV18xBMcDDT4Q7xCkqOLrtJGAO7o4oA=-Vr=w@mail.gmail.com>

On Tue, Jun 23, 2026 at 09:45:44AM +0200, Christian Couder wrote:
> On Mon, Jun 22, 2026 at 10:50 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/connected.c b/connected.c
> > index 7e26976832..9a666f0cdf 100644
> > --- a/connected.c
> > +++ b/connected.c
> > @@ -54,31 +66,30 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
> >                  * object is a promisor object. Instead, just make sure we
> >                  * received, in a promisor packfile, the objects pointed to by
> >                  * each wanted ref.
> > -                *
> > -                * Before checking for promisor packs, be sure we have the
> > -                * latest pack-files loaded into memory.
> >                  */
> > -               odb_reprepare(the_repository->objects);
> 
> Like Junio, I am not sure it's correct to remove the
> `odb_reprepare(the_repository->objects)` call.
> 
> I think it was added for good reasons in b739d971 (connected.c:
> reprepare packs for corner cases, 2020-03-13) and I am not sure
> odb_for_each_object_ext() is performing something similar.
> 
> At least the commit message should mention this change and explain a
> bit why the reasons the call was added are not valid anymore.

Yeah, I think you're both correct. The only explanation I have is that I
might have repeatedly misread this as `odb_prepare_alternates()`, which
is something we often call before suck loops.

> >                 do {
> > -                       struct packed_git *p;
> > -
> > -                       repo_for_each_pack(the_repository, p) {
> > -                               if (!p->pack_promisor)
> > -                                       continue;
> > -                               if (find_pack_entry_one(oid, p))
> > -                                       goto promisor_pack_found;
> > +                       opts.prefix = oid;
> > +
> > +                       err = odb_for_each_object_ext(the_repository->objects,
> > +                                                     NULL, promised_object_cb,
> > +                                                     NULL, &opts);
> > +                       if (err < 0)
> > +                               break;
> > +                       if (err > 0) {
> > +                               err = 0;
> > +                               continue;
> >                         }
> > +
> >                         /*
> >                          * Fallback to rev-list with oid and the rest of the
> >                          * object IDs provided by fn.
> >                          */
> >                         goto no_promisor_pack_found;
> > -promisor_pack_found:
> > -                       ;
> >                 } while ((oid = fn(cb_data)) != NULL);
> > +
> >                 if (opt->err_fd)
> >                         close(opt->err_fd);
> > -               return 0;
> > +               return err;
> >         }
> >
> >  no_promisor_pack_found:
> 
> These changes are difficult to understand as there are a number of
> `goto`, `break`, `return`, etc involved.

Yeah, agreed. I had my issues understanding this logic, too.

> I think it comes in the first place from check_connected() doing too
> many things, and adding a preparatory commit to refactor it would
> help.
> 
> For example the preparatory commit could move a lot of code from
> check_connected() to the following new functions:

I'll give that a try, thanks!

Patrick
