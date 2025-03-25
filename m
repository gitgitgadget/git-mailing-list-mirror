Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0171267F7E
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905882; cv=none; b=maj9sQVmZZfUFrY8c74VA6HGLNudorOGpN9S8r/g0NO+RcX9wK7wRlrAl+jNQEFUo3jf7QnPd6mYQhZkmt37OWHD6WUyuHGwwGr+/jDMgZEpzQnvtKth/QOG7thOZjs/oM9pqng/BTr4kT8UDXHze6na9ajLxzKG52kqSXGGCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905882; c=relaxed/simple;
	bh=chpKPrbFvQ7L90OMY4j32wFPnfYhrLcb6xPEl2Gtkho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKUIScgzLIn8ujAr4gloNEJE6MXiH1eR2m6UMR7KBUlgqfyr6SF9UI4rNCCxKJpC7FU3sWEPxWj4g/exLRmdm/4NNZE0/vbQBvZ+cDwJqq4GDqrKe+1rrYXKYEGvYwb7g/wrKH0vNKSpDULzPAIRLZ0zEsiNM41JoV6/spAbB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MMdchBq/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LXOp/6U6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MMdchBq/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LXOp/6U6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0495B1383903;
	Tue, 25 Mar 2025 08:31:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 25 Mar 2025 08:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742905880;
	 x=1742992280; bh=wEjVgaB8DsE3GCi+/tDZfogA0A7U5fWwdIyaZDCl30g=; b=
	MMdchBq/hjJsE8z4DkGKlJBDUQ3L2N/u4l+WlVzktbKL81ZsHQMZuT21X4al/68C
	y8jw7yQM0pddjD17FlrynOwKmR0Vx/5RNm5OCULck7I+8H1W+RyO+6t1cY0tx4NE
	uyaYA52uP3x57mdS6UeyaQeU35jir7WW8AtHQd7jve9oYbuay8W9+SbtPx8spH/1
	faInnpmrCKm9oZrrg5TjGzJ1VZdb8HdRgyootBRjNf9zDxqnO1UxBDHNT9M3wwBa
	m0KMkC3W/vjMQgmtwUxpwOI+xODVc6YXIwSVsqJrxBAAgmD+J3e2+leKjYIyL+gA
	UeUe7uV9br5ToFWiLjA2Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742905880; x=
	1742992280; bh=wEjVgaB8DsE3GCi+/tDZfogA0A7U5fWwdIyaZDCl30g=; b=L
	XOp/6U6t/MWVb84kvYbdh+yOmX2UgzNFNEbaHkmpzVCvtgzxPBg4QlqIL1hTyo6e
	CjUwiJezV1BSJaT5d0d8oXKlO3tD7CBcei4ASWrqBwnOAb9fsMJbn2b8j483fATi
	SCysBbDhFZRTLgzH4FdTAlTgcdhJY3MYkfzwh7gb2hn/5LIG9KawyKVSQhcA1nAW
	jQHvnVNFUWalrzIheYsEWLeQ1/2p/0cWNi09sVnerzM4D9ecFDhCWEdaYanvwpCN
	EqgORiZxuVZOlbmQ3w+fSgUZP9rMGECzjjO7YWm+2jMj6MgTy9qYS2hCuf1rDH3J
	za3wVy3ERfrreDBts+AeQ==
X-ME-Sender: <xms:F6LiZ3MTFanTWStjeOgR0V2g5kYUgntlW6JFUdqNMcj5ZA66d82ATA>
    <xme:F6LiZx-2bN06KW6Kv8raqoiyAyw7Ci5-fGkkjvEK5vc9qHw2gcmNKsi9lD8RskkA_
    VcVBVXDbgSIYnHOGg>
X-ME-Received: <xmr:F6LiZ2S93bDH9SU27MC62sUBJzkutfDmiQkHDxbWCoM-r1p0wiXR6zaeAoav7QTN9iDTrsd8GMbJKWtY6C4suW3PASSE6bfjiLF5tXzIUBJ_hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:F6LiZ7vnpBuDRBoFwve9UwmvKw-xtvb5nTmrL_a7iXquptjw7gyuNA>
    <xmx:F6LiZ_dwEPRktilBxZ38wTpPgWk2DccLtwIYiEA4iumC7uIuGuWhAg>
    <xmx:F6LiZ32fGIeDPqnuOo8-u7U81HXLJR1jv3mzqPmGJutfJb3wSPG5Kw>
    <xmx:F6LiZ7_Hn4S7dVmwI8fPxGbYd_TXvA_EKP-gLpYIplZn-VyBWIPBNA>
    <xmx:F6LiZ27vNCo0xLSNKcmxhcDEpdAd3rHeLnsHzrJyHhUINp6l-m-KWg7j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 08:31:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a127315 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 12:31:18 +0000 (UTC)
Date: Tue, 25 Mar 2025 13:31:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 7/8] refs: support rejection in batch updates during
 F/D checks
Message-ID: <Z-KiFeN0LXTR36lM@pks.im>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
 <20250320-245-partially-atomic-ref-updates-v4-7-3dcc1b311dc9@gmail.com>
 <Z-FZObjvIN-qzvlj@pks.im>
 <CAOLa=ZRx8gt=_J2cRFEsUEi31ia7qNL7SZ-WBWuWSyU=8SRt+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLa=ZRx8gt=_J2cRFEsUEi31ia7qNL7SZ-WBWuWSyU=8SRt+g@mail.gmail.com>

On Mon, Mar 24, 2025 at 05:48:32PM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Thu, Mar 20, 2025 at 12:44:02PM +0100, Karthik Nayak wrote:
> >> diff --git a/refs/files-backend.c b/refs/files-backend.c
> >> index be758ffff5..1d50d4013c 100644
> >> --- a/refs/files-backend.c
> >> +++ b/refs/files-backend.c
> >> @@ -864,7 +868,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
> >>  		 * make sure there is no existing packed ref that conflicts
> >>  		 * with refname. This check is deferred so that we can batch it.
> >>  		 */
> >> -		string_list_append(refnames_to_check, refname);
> >> +		item = string_list_append(refnames_to_check, refname);
> >> +		item->util = xmalloc(sizeof(update_idx));
> >> +		memcpy(item->util, &update_idx, sizeof(update_idx));
> >>  	}
> >>
> >>  	ret = 0;
> >
> > Hm, so we have to allocate the `util` field now to store the update
> > index, which is a bit unfortunate because all of this is part of the hot
> > loop. We cannot store a direct pointer though because the array of
> > updates may be reallocated, which would invalidate any pointers pointing
> > into the array.
> >
> 
> Yes, your inference is on point.
> 
> > I was wondering whether we could abuse an `uintptr_t` and use it to
> > store the update index as a pointer. It does feel somewhat dirty though.
> >
> 
> We can do something like this, it would be _clever_ but does feel very
> hacky.
> 
> I did so some benchmarking here
> 
> Benchmark 1: update-ref: create many refs (refformat = files, refcount
> = 100000, revision = master)
>   Time (mean ± σ):      7.396 s ±  0.175 s    [User: 0.962 s, System: 6.312 s]
>   Range (min … max):    7.145 s …  7.688 s    10 runs
> 
> Benchmark 2: update-ref: create many refs (refformat = files, refcount
> = 100000, revision = b4/245-partially-atomic-ref-updates)
>   Time (mean ± σ):      7.514 s ±  0.144 s    [User: 0.919 s, System: 6.438 s]
>   Range (min … max):    7.297 s …  7.750 s    10 runs
> 
> Summary
>   update-ref: create many refs (refformat = files, refcount = 100000,
> revision = master) ran
>     1.02 ± 0.03 times faster than update-ref: create many refs
> (refformat = files, refcount = 100000, revision =
> b4/245-partially-atomic-ref-updates)
> 
> Overall the perf degradation is very minimal. I also looked at the
> flamegraph to see if there is something. But most of the time seems to
> be spent in IO (reading refs and creating locks).
> 
> So I think we should be ok here, wdyt?

Okay. I'm not a huge fan of using the `->util` pointer like this, but I
don't have a better idea either, and the performance regression seems
acceptable. So let's roll with it until somebody has a better idea.

Thanks for doing the benchmark!

Patrick
