Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C1199929
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294086; cv=none; b=UtwtNP+8v+3aEw3yQdYyDkCqLfOJhcHqLQXJ+bHI3ZR+SttEDwEgH1KsWi4CAtUaBOm8VgTLbBqaixReE84xmaCV1AG2olmCzsXEXq0OrZRUiMmmPofueqrYIkoR6MbigrBNs6gCvCk4GyL18B6EHarInMXlkuusU9uqLdb9bWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294086; c=relaxed/simple;
	bh=n0YYFnKG0Z5waAlhY4RcJmIWLorfJDJh9o074oEo94g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD3zTxtTxuxi1dinREtWoyYQdG2kFSudArjUVooPgReZt1iEB9HCeCDKYOUVeJ+MW/xeFvLHPYayu17HCqFKuOA9dM5pH8eVYdqd0oYLgFVcuAb0usE3wkgMISK9MK1BgYZ9D0dCBR2xKIfhjxhLf3IACsS5s1XYgZT0XMffyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PSTsJ9gy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2WY6ZHG; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PSTsJ9gy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2WY6ZHG"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B79211400BF;
	Mon,  7 Oct 2024 05:41:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 07 Oct 2024 05:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728294083; x=1728380483; bh=TnS8YODOt8
	11XiE3AZbjyId959gVB7Oq0pbBkXGj09k=; b=PSTsJ9gyHZvkydd2dnGMy36Q47
	/pVcCkACAvHRUrN+Nnfd0r4Gwi18cG+hlCDm/5dwWidatSwlgiQ5Z+Bh3qrFY2VV
	jwdly/HlroKG1t0i7mt7MCvKdtfa2NOug1zHrH33Dg7Rdrf1PFTkAKv1IGfuhPBa
	EgRB+slqPwnd/6Vrn2hpjvTJkVhjpsncQsfUVj7vd6xZK7lV+yYnONey5eD2qYtE
	/cZUHuSyXId5i9rlx79dhMpIU+C8+oxY7zsHhlYmqk+xrTPwu6WVXiXMbZZu9+RJ
	2aloVzdKRmV3bgObSUOj1Jxv1ao8jqZXewMJztVFhvGN+hUkSKkbQdZhk23w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728294083; x=1728380483; bh=TnS8YODOt811XiE3AZbjyId959gV
	B7Oq0pbBkXGj09k=; b=B2WY6ZHGNU/JMfbAuo59pTQdK8Ta/J7hfa8bZF05foQn
	xLwXDKahWX+FRo5TwyIsmp5Xl15jqO5Rt6XmtEIjSZMnSLow5+KejnWZw0IeaGKh
	1fKtTuDrd6D9XthVvqIpxhFd21ru3cn9T4nvYqwhpc9V//AhW1cURMYsmuIfBaZn
	Jqy3qIxmHF2DQNY6wt31UcWzNvpWNjaH9CMp4qTT+4b55SHciP2RrqNdAa9ygQYO
	cgJbPiL+z3042l7TVCIJl8shi+Fti2gO1IFnzulYZk0U0WSs5ffFHmVAKg6OlEHX
	8KtAtCZgdyOIkVgRm8nzowf2Q5DJgKQ5iqhpZTqlSg==
X-ME-Sender: <xms:w6wDZ-aEr5bTv2MLGe_2zRdIwD_7sBTCOjFqM3x-CK5W39OkL-QKvA>
    <xme:w6wDZxZWIBpsa071SmQb0coKssSKWT-as30Eyqfx8gXSiv_oYj9F3xwYQLJzlpQbN
    bBVuVp-1eEuh8MNcA>
X-ME-Received: <xmr:w6wDZ4_DxJS9Y_t9nn5tyXnUnINTN2Pp328oRVtNXNzqpvD6RtrSKNT_Zpt6jPKB_2IMDkYToRV_Adufujr3b4tWWJ6IarXIOd5EqT11KjAJzqxYCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:w6wDZwoqMa5f71aX78dgDPrePm28ckpzRWf6UeeokbWdkzQTruyz_w>
    <xmx:w6wDZ5qmLwDGSdKAc8lnFJ45g5zuh45W0RIkUBozob8hydpZZepmQA>
    <xmx:w6wDZ-Tn1oZ1GTLBIx_y0eMQnfaE1qbwbCFZVbPxpf2uJq5ntFU1RQ>
    <xmx:w6wDZ5olpW7eiUKQd0mAo5V8sBQkUPjvG7rjVI7k5dtc5rEV9jG8Wg>
    <xmx:w6wDZw0tqxU5B0FTWIpxQmCqwWU2XEmdcKjG3UAeGu4cL7ibrHOGLTEn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 05:41:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac5145e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 09:40:24 +0000 (UTC)
Date: Mon, 7 Oct 2024 11:41:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 17/23] midx-write: fix leaking buffer
Message-ID: <ZwOswYaNe74WkJHJ@pks.im>
References: <cover.1727687410.git.ps@pks.im>
 <5db4e17db9b9b991e0dbe56d7043b56e5d161097.1727687410.git.ps@pks.im>
 <ZvsXrQadrU78rEha@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvsXrQadrU78rEha@nand.local>

On Mon, Sep 30, 2024 at 05:27:09PM -0400, Taylor Blau wrote:
> On Mon, Sep 30, 2024 at 11:14:01AM +0200, Patrick Steinhardt wrote:
> > The buffer used to compute the final MIDX name is never released. Plug
> > this memory leak.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  midx-write.c                            | 2 ++
> >  t/t5334-incremental-multi-pack-index.sh | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/midx-write.c b/midx-write.c
> > index 1ef62c4f4b..625c7d3137 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -1445,6 +1445,8 @@ static int write_midx_internal(const char *object_dir,
> >  			return -1;
> 
> Would you also want to strbuf_release() the final_midx_name buffer here
> as well?
> 
> I guess the point is moot since there are a number of other finalization
> steps that we likewise skip here by returning -1 directly instead of
> jumping to the cleanup sub-routine.
> 
> In the above sense I'm OK with it as-is, but it would be nice to verify
> that this portion of the code is leak-free even when we return early
> (e.g., because we couldn't rename() the tempfile into place).
> 
> Of course, because final_midx_name is local to the body of this
> conditional, I think you'd need to do something like:
> 
>     if (ctx.incremntal) {
>         struct strbuf final_midx_name = STRBUF_INIT;
> 
>         /* ... */
> 
>         get_split_midx_filename_ext(&final_midx_name, object_dir,
>                                     midx_hash, MIDX_EXT_MIDX);
> 
>         if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
>             result = error_errno(_("unable to rename new multi-pack-index layer"));
>             strbuf_release(&final_midx_name); /* <- here */
>             goto cleanup;
>         }
> 
>         strbuf_release(&final_midx_name); /* ... <- and here */
> 
>         keep_hashes[ctx.num_multi_pack_indexes_before] =
>           xstrdup(hash_to_hex(midx_hash));
>     }

Potentially. Until now we never really cared all that much about
releasing resources in error paths, and for all I can see this leak
isn't hit in our test suite. But it is an easy fix to make, so I can
include this in case I'll have to reroll this series due to other
reasons.

Patrick
