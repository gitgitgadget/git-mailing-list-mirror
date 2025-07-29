Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E3220F32
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775708; cv=none; b=IEOEMS67K9RxFOfdJqxPnip/aDpNJ8guzX8LRvGUjTJAJnKOk+pVfhhTCPJzzzU1cEctnGMf8fHF80EwwNNF6JAQCwWfgNF8kcjCFkhneTu45288TsPA39PPi7yZ5sm/+xHJeXoO2nyV+sDBEvup5aH5g3mWvpx0fhxDwO/r158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775708; c=relaxed/simple;
	bh=P8wwsenO7pSfsyiBhuvUkGD9rDYmrxzzOP8vOhWY07c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjOG2e65Y4Xyx6JUKdrIAiIsBGtjcF5zEDwxIW1Phq7JagcEn0jDJ5JOeqbXFOnGNTV2o0KA+iC6KYtBeteqN3dNb+b/sSve1z39WVLXyw0JtTbb+MAMqzuUtVUedjCrKvZZeCjpqeyYkY0xRmlwdALulkdwR5+Rfa0d3Ic9vUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BftgSrei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDGBQDRt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BftgSrei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDGBQDRt"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8AD7B1D000D9;
	Tue, 29 Jul 2025 03:55:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 29 Jul 2025 03:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753775704; x=1753862104; bh=bgOvGqvlJu
	OcPtwAnCXc+Vobd+qnldoWdy/oBX2Fzpw=; b=BftgSrei1obVIPGToPxDzVJ7TY
	kOT8F6umIZ1t+/2BLSLubuIoEKakFWsbDc/umAzLI5eeqSmnmHK8HSZ3IJpbQtkr
	/f//b7lZ2kHqTen9OxsJqRTOod1YrSUuXAVNlXNGZCr2uaT/DhibRtt2lYEYNEzh
	Gw55Gem7eUKcvVZEgdBV8N5jzIVpNBN8PnxamP0FkQE0YWbHPg2n8stJbnZWqhkA
	ffVtd3yJXMhDaTT31GSWAw3WVMZpHA/OvZaK81tit2hdg1wdEN0HSCAjWeOn5X7z
	NOcPYXGxMbDhkI2KNanFsx+tRYVt1b+Szg4E/JKouG8HVzbkhqem4/KwFAZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753775704; x=1753862104; bh=bgOvGqvlJuOcPtwAnCXc+Vobd+qnldoWdy/
	oBX2Fzpw=; b=gDGBQDRtApq8lLdN2ODy2E4GiFojoblWvgEfAqRENee0BIoORkI
	jlW8K1nPYNFE9r8xr9RQOpwd6hrzlfvxiTQFk29YBo7ZXHKZd/0wrAQgzyoSeuyG
	rJ4fIarvi40eOP15A5bUFyBOI9ZqGF5UZ7jbe9VlrM0KAyGRnIfK+PD3dkY3sSAy
	Dyw4DODWX5ft6rWgO40hxwZRRkfopMj5O4a80lEbIR4CEJLjv0Zb+l5ePahTkmQl
	AnWQ6YTe45e3NOGFs+Z6NcXwr+7X0wEghYZyB4oeWGDdS3buKpJnO4mAapb6wvgo
	a3Ks/LouTCBaARt6lKlmjxGbdvV7FBOVIGg==
X-ME-Sender: <xms:WH6IaMAhw1Wmw5PY_N2ahH4NkIMDofiUMv3f24ahAOUhJ3XvciFEkw>
    <xme:WH6IaMG6q1zW9HKMQ7-6GRQGTbpZ6BVLE65VED1CQlWZknxzUxEenwp2ULXrqrDdX
    ToADffcciI_B8oRnA>
X-ME-Received: <xmr:WH6IaGBYg9UqMbS03rhyR3O0Br22vS3govMCC-vMfPOd1XkzmTKuK_FEnFBzfBoiGQgHg-KNkBr6SuhJp1vBC6_uDM_kwo2BJ3xHtXxp1bo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelgeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:WH6IaEW1h-oJCvSs1-yiZh5xrFTSi5riDHpx6ozgAV0RomnmjnQcaw>
    <xmx:WH6IaCqMjQxkUjiJlyrirq6EWwxPF-ToQXtvcyXDjW0V0XT6inUFog>
    <xmx:WH6IaITFxJqmyMVfDiL7jw198f4JuXT3i0zuiSgFwfiNXU0_-y1geA>
    <xmx:WH6IaE2sVcuuKLzSQIDw_l-PqNpNB5k4XogkiBXfYzsfCR0Zku8dlA>
    <xmx:WH6IaAXHeJKNk-VNi_Ohfv_dOExcTgqWWvp46sMrogGbyIfvswJYwvsH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 03:55:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67abbcc0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 07:55:01 +0000 (UTC)
Date: Tue, 29 Jul 2025 09:54:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 7/8] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Message-ID: <aIh-UWjs_092Dzdm@pks.im>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
 <20250725-pks-reflog-append-v2-7-e4e7cbe3f578@pks.im>
 <20250725113610.GA3015361@coredump.intra.peff.net>
 <aIeMgE-11UnAJINI@pks.im>
 <20250729071455.GB1426859@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729071455.GB1426859@coredump.intra.peff.net>

On Tue, Jul 29, 2025 at 03:14:55AM -0400, Jeff King wrote:
> On Mon, Jul 28, 2025 at 04:43:12PM +0200, Patrick Steinhardt wrote:
> > > > @@ -2508,8 +2507,9 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
> > > >  						struct object_id *oid,
> > > >  						struct strbuf *err)
> > > >  {
> > > > -	if (!(update->flags & REF_HAVE_OLD) ||
> > > > -		   oideq(oid, &update->old_oid))
> > > > +	if (update->flags & REF_LOG_ONLY ||
> > > > +	    !(update->flags & REF_HAVE_OLD) ||
> > > > +	    oideq(oid, &update->old_oid))
> > > >  		return 0;
> > > >  
> > > >  	if (is_null_oid(&update->old_oid)) {
> > > 
> > > Which make sense to me. But the weird thing I noticed is that when we do
> > > something similar for split_head_update(), we don't strip REF_HAVE_OLD!
> > 
> > And we shouldn't do that, as in the next commit we actually build on
> > always having `REF_HAVE_OLD` set for reflog-only updates. So I'd argue
> > that the problem is actually the other way round: when splitting off the
> > HEAD update we must resolve the old object ID if `REF_HAVE_OLD` is not
> > set.
> 
> Yeah, I agree that after your patches, split_head_update() should
> definitely not be clearing that flag. What I more meant was: this patch
> is introducing a behavior change for those split HEAD updates, which
> used to do the extra old-oid check but now won't (whereas for other
> symref log-only updates, you are preserving the behavior).
> 
> I _think_ that's a reasonable thing, but I wanted to make sure.
> 
> However...
> 
> > > (For those not familiar with that
> 
> ...did you mean to write more? I know you've been running into weird
> email truncation issues lately.

Sigh. Yes. I really need to figure this out, but I have no clue
whatsoever where to look.

Anyway, here's the remainder of that mail:

On Fri, Jul 25, 2025 at 07:36:10AM -0400, Jeff King wrote:
> On Fri, Jul 25, 2025 at 08:58:29AM +0200, Patrick Steinhardt wrote:
> > @@ -2508,8 +2507,9 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
> (For those not familiar with that function, it notices when we are
> updating refs/heads/foo that is pointed-to by HEAD, and then adds an
> extra HEAD reflog update to the transaction).
> 
> So as I understand it, right now we are doing an extra check_old_oid()
> on that log-only HEAD update, and after your patch we would stop doing
> so.
> 
> Which I _think_ is the right thing to do, but it made me wonder if the
> transaction were ever non-atomic. That is, could we split off a log-only
> update that succeeds, even though the old-oid check for the actual
> ref fails?

I think this can only happen the other way round: the log update never
gets persisted unless the parent ref is, as we'd otherwise abort. But
what can happen is that we end up with a broken reflog entry. See below.

> Historically, I'd guess the answer is mostly "no", because the point of
> ref transactions is to be all-or-nothing, and to do the locking and
> old-oid checking before writing out any updates. But I also think I saw
> some discussion of non-atomic transactions recently. I didn't really
> follow it, but is this a potential problem?

I'd say that the whole logic has always been flawed: we resolve the
target that "HEAD" points to without locking the reference. Consequently
we have a race in case "HEAD" got updated to point somewhere else, as
we'd still write a reflog entry to "HEAD".

What used to save us a bit is that at least the old object ID would be
correct in such a case because we used to verify it even for log-only
updates. But whether or not we write such a reflog message in the first
place is subject to a race. And when `REF_HAVE_OLD` wasn't set we might
even end up writing a different old object ID than what we write to the
target reference.

Theoretically speaking we'd have to lock "HEAD" immediately after we
have resolved it to ensure that it doesn't change anymore. But that lock
would be quite restrictive.

I guess the next-best thing that we can do is to lock "HEAD" as soon as
we find the ref that it's pointing to. If so, we can re-evaluate whether
"HEAD" still points to the same ref -- and if so, we split off the
update for the reflog. If it doesn't anymore then all bets are off, as
it may be the case that "HEAD" has now been changed to point to a ref
that has already been processed by us.

I guess the safest bet would be to just abort the whole transaction in
that case? After all it is a racy update, but it feels heavy-handed to
reject the whole transaction only because we fail to write a reflog
entry.

But even that doesn't solve this race completely: "HEAD" might have been
unborn at the start of a transaction or refer to a target ref that isn't
updated as part of the ref. So we wouldn't ever get to re-resolving the
ref. We could double check at the end of the transaction whether "HEAD"
has changed, but that isn't really working either as its target ref may
have flip-flopped.

In any case, I think we can improve the situation at least a bit:

  - We lock the parent update before calling `split_head_update()`. This
    ensures the old object ID is resolved already and cannot change
    anymore.

  - In `split_head_update()` we take in the parent lock as a parameter.
    If `REF_HAVE_OLD` is unset we take the old object ID from the parent
    lock and set `REF_HAVE_OLD` for the reflog entry. This ensures that
    we at least use the same old ID for both ref and reflog updates.

But the other race, that "HEAD" may have changed concurrently... I don't
think that one can be plugged without a bigger effort.

Patrick
