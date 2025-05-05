Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E21DFF7
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459805; cv=none; b=SCA/TMzTKVmcdsjIrwh2EZgzpIY8nwFSlIbpUsRwC8dL+IUhkiWd1607zgBD8k48fcDE8ck44lprdlyEJCglItEFjr7eRWfsAe0XnwBKBHz6qMCthQitFwVLgJ9OZ/OrT6EXAhTRVjPIctAyegGP+Pr6JjLLLEy7AYi76lFDo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459805; c=relaxed/simple;
	bh=OfXnOZ2DNKOCBTpgS4Op8h/46fFn335rLbTIWh5O7GM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UTEeeAMed56Kfx6FPd+bVtj3k2yCwb+lQ0eGHzQx4oNl9B1h5z9DqrvpbJVNlij9LZbo0pREk5nlYz58d0e3WkYLUTh0gYkiQ6Vfl09AOjI0z/ZJsc/MtQ1BQwbFNNvX+xRDfUd8iA1zFxEvyyn9hdEvuzNSmymPIsQ1lwQ8Gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S7FTxlxi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3sLcy2z; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S7FTxlxi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3sLcy2z"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F02571140254;
	Mon,  5 May 2025 11:43:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 05 May 2025 11:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746459800; x=1746546200; bh=igWEIvryIv
	Y6F0CeypAfxVdq/MtSkYnjsR0Yh5qmTOU=; b=S7FTxlxibT9SplyZpXAQtCUElL
	jL4590AoNHisUv3XxiVIAe4DctS8B2Nc23ZOrOLoWlYJDYDVN63DKtqj3E98T3/p
	71lBwqPUT+tKQvV1HkvrF9wjFjd2wW8lQ19WMFmoCJ21aU3OCJegYMSF2Ki9CG+Z
	RNdsxObfhi8RE5/eYFusNlAjg1RA+AoK+zU1wxZnUV6wdfV+RrO1MzSfHs4zu/3a
	PDC85CD5S2y+FezQVOCRnJsOcz/z1HOFNnLiAGte6GKPUbQ6SUlSunBbLkD58L65
	lKTsZ7IT4RT3kUvnGGfr+5dwaiOfzMjstvXT90zWM2C+ZSBArdXBoEuQtkrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746459800; x=1746546200; bh=igWEIvryIvY6F0CeypAfxVdq/MtSkYnjsR0
	Yh5qmTOU=; b=e3sLcy2zoLFqd+40xsbB1rlO4LfiNq6fx3P67fwe33IDKHAn5OR
	02N1OON7GFV6tdGU0k7rTYJIvvTBrgX7BHrMfpi0L30g2Oz+CgaE/Sc47oz59L+/
	c1ep6sDVMixZCmykqFCgdhJhzkU754pjTie0ZMeGctA93iWAAsrJmLyanVhVrEcn
	1RYSUKnmgQokHIw+L8EwVO3CVRCdnYW1AZjW0ioOh3qPhBiSQdWat06dAm2NhZ6V
	/VT2VyHTisMiU0tHRUe6lmR/3o/0sP03e7yhI3VxkgZAAItVeOWypT3R90tkSonp
	AZEoUmT3JyoffD1os+T0/nvVDyDHoOcivOg==
X-ME-Sender: <xms:mNwYaMXDq7xKi5ga8oXVnce54rmUyvgCh7IDjpMpr8XyNf08jb86eQ>
    <xme:mNwYaAl1lz4JqVZkFqgqQu1luKx0meVawCmAHYpyqGhhklhWk1gMZFCkaTqCW8fwt
    MWWymw-DNqR6OiqAQ>
X-ME-Received: <xmr:mNwYaAZDT2NxHPSIaW_fsvR9KwPEzeBJBWLtc77TOaTttquNXdXDxRfTAJjdQsr_cR1GM8JN5yjycSM0PA3rONimLjctXTaECAQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedugeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mNwYaLVZYsHjcex4ADcrs06EbuOeErC7OTO9Ng4-C6NMAoBujFmqug>
    <xmx:mNwYaGmUmJh3Iu6Qv1HDttAuoEJKmRNUDlRGYwClHW_CLecp5qACaQ>
    <xmx:mNwYaAcjAG7qafzRRXZTxLEpowkk66K1eM6T3ZwVJa4dnzWABtVfvQ>
    <xmx:mNwYaIHFmMTYzCOvY0pUG7JUtYiNVPzfXpLTAqzCrTudYcubpPxq1w>
    <xmx:mNwYaCwlYGJ048bBNycwraju0qBIdzaYyXuh_VExbH6EZwKRRKHyAn9m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 11:43:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Collin Funk
 <collin.funk1@gmail.com>,  git@vger.kernel.org,  shejialuo@gmail.com
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
In-Reply-To: <20250503133158.GA4450@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 3 May 2025 09:31:58 -0400")
References: <20250502233403.289761-1-collin.funk1@gmail.com>
	<aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
	<20250503133158.GA4450@coredump.intra.peff.net>
Date: Mon, 05 May 2025 08:43:18 -0700
Message-ID: <xmqqtt5zoyg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That changed in cfea2f2da8 (packed-backend: check whether the
> "packed-refs" is regular file, 2025-02-28), which uses open_nofollow()
> to check for symlinks while we open it. But it feels like it would be
> more direct to just lstat() the file in the first place (which we end up
> doing anyway to check for other things besides symlinks!).
> ...
> It's not as "atomic" as open_nofollow() and fstat(), but I don't think
> we care about that for fsck. This is about consistency checking, not
> trying to beat races against active adversaries (not to mention that our
> open_nofollow() is best-effort anyway, and may be racy).

True.  Atomicity, which the use of open_nofollow() and fstat() tries
to achieve, may not matter in fsck.  We can think of the use of
open_nofollow() in this particular codepath merely as a convenient
helper function, and I do not think we have any problem with such a
helper function.

But open_nofollow() and its emulation can be called from other
codepaths that may care about atomicity, and I am not sure what our
attitude towards atomicity requirements vs platform capabilities
should be.

If an atomicity (or any other) requirement in a particular codepath
has a simple and obvious way to solve on common platforms, but that
the mechanism to implement the simple and obvious way is unavailable
on other platforms, where does it lead us?

For some kind of requirements, we can treat it merely as a quality
of implementation issue, similar to how finalize_object_file()
ideally wants to do the create(TMP) then link(TMP->FINAL) then
unlink(TMP) dance (because we want to detect collisions when able)
but has fallback implementation to create(TMP) then
rename(TMP->FINAL) (which punts on collision detection) on platforms
where the preferred way does not work.  It falls into this category,
I would think, to think of use of open_nofollow() in this codepath
as a mere helper function that makes the code in fsck shorter.

But for other kind of requirements, we want to fulfill them on all
platforms that we claim to support.  Using open_nofollow() to
achieve hard atomicity requirement would be a bug in such a
situation.  Should we somehow warn our developers against its use?

Idealists in us first try hard to find the right abstraction that
would work everywhere, and use compat/ layer to implement that
abstraction, but we of course are often not successful, and end up
with a series of #ifdef for pieces of platform-specific code in
fairly higher layer.  It feels that open_nofollow() that is not
necesarily atomic is the latter but that is done at a level that is
a bit too low.  I dunno.


