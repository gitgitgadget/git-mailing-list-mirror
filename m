Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC51662EF
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657462; cv=none; b=BsdLUykj3cpsiP36nSXQREovGfxJ8mCm93WthbJb0U1F7GceZLV1vKY5ppOhcsHqAE6/HnJRhtNjt1RR5TGQeEa1bj8j4SR21Au2pj9xSAREVKhQZP+LFu8IkoEven9KBi1A/jFgSXIycjpq7W2nA+ksRjKc2hIVCKnf1u3/e1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657462; c=relaxed/simple;
	bh=gfcQSqjNX7L5NnjhXKdPgWm6c/qQO5JiVWGSvggWJ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjZrnXWckN9W+L20vrhpcT+XePj2+X+gkqaT4QiPEZy9d1+RLJSDd9EkUn3yjZ7yDIuR4ViER5D17UJXkkPeeHEtQZLw/YW45Q/UkFZmn8U5p7xaAosZBtdE0dWhqSO482r6qi2sfpxsz4dwT48yodawxteLohNSQQaf9cIKYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ciqbrNsn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w5qteIj3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ciqbrNsn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w5qteIj3"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A600B2540164;
	Thu, 27 Feb 2025 06:57:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 27 Feb 2025 06:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740657458; x=1740743858; bh=alfI1Jsdbv
	YXgzBXgBn2SV11CAWWNHk9ZeGgWzI5meg=; b=ciqbrNsn2H2JfxUcuO5b8140Mo
	1Qk7Lu8WVYRMjg76aHAgfl+U/BAmFEu15luAoXocFQH7LrIurzoV3aoa1OOX95c9
	QuHJYobMhDXDQMWGU9DvfLK5VJ9zbDR1D7F3tG/+aZAW8scR6AI7rx1qTbYSyIiE
	lkaYKO3J/lnSeqcLuTnstKL/+rTl97jJxhWoME7+le6XmFLLqu8zI5t81EHEASR4
	haPPAPr3kV+hqVEz/T15MzQ5ZXJCUXdghgXC8910xHJbKoRKUWjvp8Z/i5sNOIne
	gE7lss1GYillhsqli9D9fwZ8EdQA70RzWFSskMPNzCvtmlhbrE9Hs8bPNlMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740657458; x=1740743858; bh=alfI1JsdbvYXgzBXgBn2SV11CAWWNHk9ZeG
	gWzI5meg=; b=w5qteIj3Vc/RGC16iJ/rpod5Unl4EiEuTLu5Ubrke6IJp/jNICh
	2/u4M7PD47SsJZAnZWaMqfR/McldW69i65DMjuGhg2KFkWRFUzCa+BCI00w064fT
	MgBlYe7xe0kqL19FG29C04M+083/hpaSmt2vU/Ck0+tBRxT6To5xxA6lwqQvoTZO
	kMM775K5OcllbqlQUy8FJIdt2l6SBhgM2CqS0XcKNUuwl37QaYPQP6kb1MyNzLWq
	sqW+faa8dEyrTt/P/WVnvE1OYkhpa63UAMArfi05oQZkXRNx4Wcg9JMiehgH8rdM
	Ym3h4Rgy6Rl+6itjj+AT++OthaYahqUQLXw==
X-ME-Sender: <xms:MVPAZ4QEOOnShsLkkLX92dycSVbdKF53CfOXfFEc0yOvSD04xemN-w>
    <xme:MVPAZ1ygjopJgC-33vpWdjzjOhgX3o_hFisw-VR5hPaTUGN_T6mjmwcfnCvHMnCYC
    0HeQXd92xe2gyQ13w>
X-ME-Received: <xmr:MVPAZ11H_ba8igFRhaAU-OzapsHFn2iaQrXddViOXkUpZJ0IhYc7jtjfKYpqXoZnuEwEJBBiDx1Z_6NZxWoSWP3raCGIjJgPafVvRqfw7pZV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihf
    rghmihhlhidrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MlPAZ8BclCyMRJCFl0zn6R7jCBVWnlXmAKdAu2npH_EkFFis8fUnTw>
    <xmx:MlPAZxjCw4NxKz9CYz_ThRHqRb6UGbveKvpLzLZQE1hW1qeXsQlQyA>
    <xmx:MlPAZ4rQwTm0MZtGQ0jPOL-A7II6omltLrjYAqSA5j6vwLCpvJ6Hqw>
    <xmx:MlPAZ0hYtxYf5HENbWEHyBXUvVlwwEG8TkHTjU5FjkadOnUPvgfFVQ>
    <xmx:MlPAZ5j5kGeeVAMofuz64qjozJ2DigcjpRV1eVT6P_tyanljYWey27-R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 06:57:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9fdf3a03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Feb 2025 11:57:34 +0000 (UTC)
Date: Thu, 27 Feb 2025 12:57:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 03/16] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
Message-ID: <Z8BTKcUG6ogajfyq@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
 <20250225-pks-update-ref-optimization-v3-3-77c3687cda75@pks.im>
 <xmqq5xkwbavg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xkwbavg.fsf@gitster.g>

On Wed, Feb 26, 2025 at 02:26:59PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Most of the commands in git-update-ref(1) accept an old and/or new
> > object ID to update a specific reference to. These object IDs get parsed
> > via `repo_get_oid()`, which not only handles plain object IDs, but also
> > those that have a suffix like "~" or "^2". More surprisingly though, it
> > even knows to resolve references, despite the fact that its manpage does
> > not mention this fact even once.
> 
> Are you referring to <new-oid> and other placeholders with "oid" in
> their names?  I do think "oid" in our documentation implies that
> only full hexadecimal object names are allowed.  The glossary agrees
> by saying that <object id> is a synonym for <object name> that is
> usually 40-hex SHA-1.  However, that is not strictly enforced and we
> say <object> (or its typed variants like <commit-ish>) even when a
> command takes any extended SHA-1 expression, as described in
> Documentation/revisions.{txt,adoc}, not limited to full hexadecimal
> object name.
> 
> So, I am somewhat sympathetic to your confusion, but not that much.
> When we wrote the command and documented it back in 2005, we did
> mean to take any object name that is spelled in any way, not just
> full hexadecimal.  You may want to update the manual to emphasize
> that we encourage the use of full hexadecimal for this command and
> elsewhere where it is more appropriate.

Yeah. I have been aware of the behaviour beforehand, but an unsuspecting
user that reads through the manpage wouldn't be able to figure out at
all that this is the case. I guess this is something we should improve,
but I think it's outside of the scope of this series. #leftoverbits

Patrick
