Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E79220F2F
	for <git@vger.kernel.org>; Fri, 16 May 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389656; cv=none; b=jds2EiCP5mtXEfN89fzZOoRsg1LY6FpQhZxRhRDF/4Eexjt/eRQOso1wy/eZeSoP0TrIqtSIm7yGM6M4waq8u/XdWn8hlNokW0qebJxGY0oA4K2tKpip82HkHGzW5IP5D9SmTeNZ4NfqfAR4ctgFY6+TJjOeV8Li8/aFZg10LYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389656; c=relaxed/simple;
	bh=wJ4P5hd29X9LZZ54NDifFv88IZJ5ZLM3rr3q+KXdP1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t11NuTCCCmlmStOQsb71TbWBCRF6ZGAGqpk1/fZpFLs2ZS7gnK7EXGq5gqwmk6ctCgXFVDoxk56GR8tiyKZB0XshiI8poQh398F24jVXKc9v1gxDM9ppKvjnqTtwHlo8D6WmSnLaljjnF+bOD2jrmJP7pDlRMHSoRUyDl44AHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y7Fj1a12; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Io+90Huk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y7Fj1a12";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Io+90Huk"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A85A114016F;
	Fri, 16 May 2025 06:00:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 16 May 2025 06:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747389653; x=1747476053; bh=+1s7r+5wTx
	k00/urh/vwu6XR5p6DVTTnsuudVR/jt6M=; b=Y7Fj1a12U2L/yNX1RV8cJmvj5f
	rZkUo1JfQ7noQ5I7yfGLs3Dk5tzIHOgZ4+o6fqmWf9ONYFTCV10XTh8eix9J0r1M
	WhyLQf2DVCc7V5nPxn7ra4GaqmXj85pCt4xXOljNF9ZjSKysBSkpekzwxBVFOOwP
	gBcJ8wAyhH2cVMtkXyLzVlNDttCX1UCAzQvdlxxE76J/qwDn2IsLRkTOOS0iXOdc
	0odZyaF11E9pUrXTaFPxXRWlv/WdJ2znQhtpKSY84Y/+1HlQRoD1s7UX7kisAPea
	/Lp1rhqiSduz967M6XhAIq3fW/HeWQm/OCsy8guQVjjuApTavUJ03MsfCcMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747389653; x=1747476053; bh=+1s7r+5wTxk00/urh/vwu6XR5p6DVTTnsuu
	dVR/jt6M=; b=Io+90HukgL7Y3aydw4JjA67NTwGSAsCphY2Z3h5JOkY+COscAuG
	JqWWfjGNTa7T6M6cP8Ui/kZOQQKHoF0T+TcQZ0KQVavVH2YG/SSpSOwqSdlaqe7C
	A7EyZuudRJpuyeAtHZ6EqjwHje3S2PhxaAyzXyUw9bPKx2dN1ocOoeKULxxSULXy
	TDVto89lMH1lRmedjOFuW+5F513LMlhRsbaVZZQZpzKrF8o1xi6e1nJLPadJxKcz
	wuR0UbGuDN/a8rMIH2kCGJ+NFgvJb0QXmUeUl9M12tdhLMSBK2DxW1KrMRKvd0bc
	quB3ros5Q56IIyh85kPv7EuwR0sfnoNd/MA==
X-ME-Sender: <xms:1AwnaAaGaY16ZUhUQYvXjmhJkFgl2oXOS9C0K0Civ4IWyNVToK9XOA>
    <xme:1AwnaLaQ1Q2Itc8FOC8yDPFxzrchm9Z1I2PhdDqaH9oxN9lV6ixXz0f4MSZeztrAa
    e_U1dxzyPYxsUjqJw>
X-ME-Received: <xmr:1AwnaK95GvfgIujtbSt3U9s2nbmsnQ9eLjjJAKfRTXfQbHwtnX3Aq5XoF3w-8AvB5HusWdgn5AXjdh2mRkKjqZH-RlLXZgMW74mQkqAj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:1AwnaKp10DOlUfgXhsDuDiospFGB3MFDE0Rng8KkncmrnInuX7IQQw>
    <xmx:1AwnaLqZdHoTY66vb6mNBdmwPvvuEZrmbikA9FDnIuyPc5jPKeSB0w>
    <xmx:1AwnaIQsIWpLRnFEofKXlhi529t6IbYNgIVcQ4bWvWincQ2awiO87A>
    <xmx:1AwnaLodbPJFfDSBWsI0Tz3Z7FI-il0W9Bb526CN2bjlotVM8Zf2LA>
    <xmx:1QwnaAvwmY0COpG7T8mjYu0XYH48V_klJ-B28_9HCTeA3MCfPskjW55g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 06:00:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 119fa313 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 16 May 2025 10:00:50 +0000 (UTC)
Date: Fri, 16 May 2025 12:00:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, gitster@pobox.com
Subject: Re: [PATCH v2 2/4] fetch: use batched reference updates
Message-ID: <aCcM0QK6QBdWO2jj@pks.im>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
 <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-2-80cbaaa55d2e@gmail.com>
 <aCbP1SxncSVw2fCa@pks.im>
 <CAOLa=ZR+3RPDHucjEVx8s64nrVGjzNTu9gX6Nw5vwQGg8PtpUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR+3RPDHucjEVx8s64nrVGjzNTu9gX6Nw5vwQGg8PtpUw@mail.gmail.com>

On Fri, May 16, 2025 at 02:53:22AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, May 15, 2025 at 04:07:26PM +0200, Karthik Nayak wrote:
> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
> >> index 5279997c96..15eac2b1c2 100644
> >> --- a/builtin/fetch.c
> >> +++ b/builtin/fetch.c
> >> @@ -1688,6 +1644,37 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
> >>  	return result;
> >>  }
> >>
> >> +struct ref_rejection_data {
> >> +	int *retcode;
> >> +	int conflict_msg_shown;
> >> +	const char *remote_name;
> >> +};
> >> +
> >> +static void ref_transaction_rejection_handler(const char *refname,
> >> +					      const struct object_id *old_oid UNUSED,
> >> +					      const struct object_id *new_oid UNUSED,
> >> +					      const char *old_target UNUSED,
> >> +					      const char *new_target UNUSED,
> >> +					      enum ref_transaction_error err,
> >> +					      void *cb_data)
> >> +{
> >> +	struct ref_rejection_data *data = (struct ref_rejection_data *)cb_data;
> >
> > Nit: unnecessary cast.
> >
> >> +	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
> >> +		error(_("some local refs could not be updated; try running\n"
> >> +			" 'git remote prune %s' to remove any old, conflicting "
> >> +			"branches"), data->remote_name);
> >> +		data->conflict_msg_shown = 1;
> >> +	} else {
> >> +		char *reason = ref_transaction_error_msg(err);
> >> +
> >> +		error(_("fetching ref %s failed: %s"), refname, reason);
> >> +		free(reason);
> >> +	}
> >> +
> >> +	*data->retcode = 1;
> >> +}
> >
> > Okay, we stopped ignoring generic errors now and will print them. What
> > I'm still unclear about: which exact errors do we accept now that
> > `REF_TRANSACTION_ALLOW_FAILURE` is specified? Most of the error codes we
> > probably want to accept, but what about `REF_TRANSACTION_ERROR_GENERIC`?
> 
> The current mechanism in `ref_transaction_maybe_set_rejected()` doesn't
> handle `REF_TRANSACTION_ERROR_GENERIC` errors. This was a design choice
> (more of a requirement of what this error represents), where
> `REF_TRANSACTION_ERROR_GENERIC` errors cannot be resolved on an
> individual reference level. It includes:
> 
>   - System errors such as I/O errors
>   - Duplicates present
> 
> Both of these represent issues which are bigger than a single ref
> update, so we have to propagate these errors up.

The second case is also why the behaviour changes now, right? If we were
able to handle duplicates via the same mechanism then it would become
possible to retain current behaviour for git-receive-pack(1)?

Not that I'm proposing this -- I very much think that the current
behaviour in git-receive-pack(1) is a bug that should be fixed. Mostly
trying to understand.

> > This makes me wonder a bit about the current layout of how we handle
> > these errors. If the rejection handler was invoked while preparing the
> > transaction for each reference as we go instead of afterwards we could
> > decide on-the-fly whether a specific error should be ignored or not.
> > That might lead to a design that is both more flexible and more obvious
> > at the same time because error handling is now handled explicitly by the
> > callsite that wants to ignore some errors.
> >
> 
> I did ponder on this while I was building the batched transaction
> mechanism. I decided to take it iteratively. We can, for instance,
> modify `ref_transaction_maybe_set_rejected()` to work with a callback
> function which would allow the users to accept/reject errors.
> 
> However, even if we go down that route, `REF_TRANSACTION_ERROR_GENERIC`
> errors still cannot be overlooked, these errors will abort the entire
> transaction.

Okay, good.

> That said, I'm not trying to avoid going down that route. I do agree
> with the flexibility it does provide. Once we hit such a usecase, we
> should make that change.
> 
> For 'git-fetch(1)' and 'git-recieve-pack(1)', do you see a usecase?

No, I don't right now. I just want to avoid that we have to eventually
refactor all of this to support an alternative API. But agreed, there
isn't really much of a reason why we wouldn't be able to introduce such
a mechanism retroactively while keeping existing callers intact.

So let's stick with what we have and keep this in the back of our minds
if we ever need such a mechanism going forward.

> > Last but not least, I think that it would also allow us to decide ahead
> > of time whether we want to commit. Right now we basically say "just
> > commit it, whatever happens". But if I'm not mistaken, all the errors
> > that we care about and that callers may want to ignore are already
> > detected at prepare time. So if we already bubbled up relevant info
> > while calling `ref_transaction_prepare()` the caller may then decide to
> > not commit at all based on some criteria.
> >
> 
> Indeed, that is correct. I can confirm that even now all the calls to
> `ref_transaction_maybe_set_rejected()` are made in the prepare phase, so
> we could already do this, since `transaction->rejections` is already
> populated at this stage.

Good. After all, we shouldn't have to perform checks in the "commit"
phase. Things are locked, things have been checked, so it should
basically be a mere "let's move everything into place now". Which of
course can still fail, but the only valid reason should be system
failures.

Patrick
