Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103110A24
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058146; cv=none; b=ofuZn9R8Xkd1qc4z9+pfCTElVoxE9iCkKhx1s36GmP7jjE+vbn1PewkO73qS3uzk3nB4Rh/lSPn2DuPFHhnjroQEErsk0xvYjGmxRwJQ4/sa4ejSsjawm6vNBNnhR80LJf+33vuHsVR9iB0jQLa3HrZ+I6TtGzyVzfsuoSI89OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058146; c=relaxed/simple;
	bh=C/bPUR51iMlXTsZv79UxWrPtqtG6eQZ5EfROD1xL28c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oULaDVWulmRZVEdtcgSxWSwl2X0dqRz4iB+uPvBxCcB+cwM/H2hksEb5DVRhbLpeu7YDF0g9ZH3mCLT1f6EEyuEervf/lEsxBLgbjkbzWwipN5PzFJQbhGSSnGw+yiI+QzkyAWg12dDuiOYutEZEVXAYujjcgA1ekGD/rB4SAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FwFnlRHE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HXsF/9e5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FwFnlRHE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HXsF/9e5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B93011401D4;
	Fri,  4 Oct 2024 12:09:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 04 Oct 2024 12:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728058143; x=1728144543; bh=OZPu+csY6w
	dD3Po4DxxfZNq/lG3y9DuUkf0pgI+rPmE=; b=FwFnlRHExrG+rSqR8e5jpCmU2D
	kuHl+LCl023jwvXs8c+bkXlRNbFVyqwSRSghT5mWplg/y8Mui1GaljzSXOxPch+A
	UodeCk/Mml5eVx5bL7Nn8d57qjWxtl735ejwPXgy5ucPha8AN1RWaXnZGTb9W1Wv
	dE0Ysdfy62PzJOx2MJiPgfCwyhi5aQyxrMqwkmh5kwjZt9no0gI84iBf8TYJk0yU
	gM8vnhbzEEgte6zbc8poPVl0NqT/sgQM0nAcjAPUmlTlTnWS/mo6VU0Z1At3NQj1
	uzEHgfat701CH7mudQs+V7S8pIAyBkyukcrKCvVzZawJqqyZUZ0G5iiIQh0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728058143; x=1728144543; bh=OZPu+csY6wdD3Po4DxxfZNq/lG3y
	9DuUkf0pgI+rPmE=; b=HXsF/9e5AABCnXKQ7moQPODJN4mxw4khJAHJlihUz0z3
	BDFfMXBqtf5CvMd9NiWi7T38xwxkwJkzJhuVWqboqJdRFwQnOrWTcUluZMDqsZqZ
	SxEcPDp9LVWviX8EG6uktZkI47REcGMAeWMlGixgbFgszwz/Z6A7ATZRtMjzjs5e
	2yKbCFlj46TZuzmLr884otsjAnMkw96clBuLwdTPFLp9SXXuT84A8FTKR11YvXxB
	yCUD4MD4yXC+uy+ZKhPxR3GhWyrnqiz7oz+ftHQfbGvNfKEKWwqO7NniL8qw9hl2
	xtQr3eq0NKb+6Qm3RY8UB653hqsTHek1tT4L6mk9yg==
X-ME-Sender: <xms:HxMAZ8MRTfgv76nOKyDDg-254IL_SszAMiDwB7hFzFrKlneSJ9ibxA>
    <xme:HxMAZy_ef7iMs4VvHFW2VolN5nAJ0GPx7TJWV8ojBYdQA-OTY3ehtzLbT3nAHdou8
    os7XJNFJTKLbCVVxg>
X-ME-Received: <xmr:HxMAZzQsxPyyhy9zo4XF0zns-x6wtjCQV_XRJjs9BK39INXOoTf6OYL7Tt7g6xBbqpxi7m7tFWS1oKVoZyQiOhsh0hZNjq6_Fv4t0Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HxMAZ0v2EPw7dHHIZb4c3iM0Mh7AFO8twqgud9T-dLzPE1mI66IYRw>
    <xmx:HxMAZ0cE6OPms6qChHHIfXcSASeu0yuCJBHbCWuYt4lvxdtBOH7cWA>
    <xmx:HxMAZ404_IHvfos8xp7gr3iydNdOT21pvD0_7UTmyMYNvPm2CVq2dw>
    <xmx:HxMAZ49TzM3vvDfTbWtgKVTYIEDkAO8e5vM3oCIJ5AgS5PFmMM0CEA>
    <xmx:HxMAZ5GFW0lM-_qoLx4kEnGLb3hGz9ZwbGcWUAQRvkjW4fiKng8Y78eP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 12:09:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  GIT Mailing-list <git@vger.kernel.org>
Subject: Re: v2.47.0-rc1 test failure on cygwin
In-Reply-To: <f29241a7-aadd-e824-97f3-a95ac6619951@gmx.de> (Johannes
	Schindelin's message of "Fri, 4 Oct 2024 13:11:15 +0200 (CEST)")
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
	<Zv9oIrKveu-JAGQM@pks.im> <Zv-HbT8qrM6IYKb4@pks.im>
	<8718c5c4-1d0a-104b-eb39-6338ae9c5dbf@gmx.de>
	<Zv--68J5qv60IuQz@pks.im>
	<f29241a7-aadd-e824-97f3-a95ac6619951@gmx.de>
Date: Fri, 04 Oct 2024 09:09:01 -0700
Message-ID: <xmqqbjzzg89u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But unfortunately this still caused permission errors when the new path
>> was held open by another process.
>
> Yes, this will _always_ be a problem, I think. The
> `FILE_RENAME_POSIX_SEMANTICS` as per its documentation should help, but if
> it does not in your tests it might actually not quite work as advertised
> (wouldn't be the first time I encounter such an issue).
>
> I tried to read through the code (it's a lot!) to figure out whether there
> is potentially any situation when the `tables.list` file is opened but not
> closed immediately, but couldn't find any. Do you know off-hand of any
> such scenario?
>
>> I think for now I'd still lean into the direction of adding the !WINDOWS
>> prerequisite to the test and increasing timeouts such that I can
>> continue to investigate without time pressure.
>
> Let me bang my head against this problem for a little while longer. You
> might be right, though, that this is a thing we cannot fix in time for
> v2.47.0, which would be sad.

If you folks think it would help stabilizing the tentative fix, I am
open to the idea of delaying the 2.47 by a few days.  Currently the
2.47-final is scheduled on the 7th (Monday), but we can do 2.47-rc2
on that day instead, and move the final to 10th (Thu) or 11th (Fri)
[*].

Thanks, all, for working together.


[Footnote]

 * All dates are US/Pacific, 10:00 am
