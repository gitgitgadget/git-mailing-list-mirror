Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB02D9499
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140094; cv=none; b=hx3ekkABWaZ0jLS8U4VXlvcb791W+i2dEqt5x2GKYf+XHKK1/7ttQ3eHMFAzEO70PQmQTxs+4GzEGUq7JAbw2wh+PbhzCHKEJtL+jT6aPSivnJVQkhcPiKQKO/O6J0OFQt/chiKI68wZnIaIw8IsUIIqL+/c8jMUJVpPMmUDihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140094; c=relaxed/simple;
	bh=BI7+Wd1VHr5+DfsJmrECbLyNhjjtnZ9Xe2DLRhfHisg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B6WV22s4/EHHZDWInetxcm3YDwwzludF1t9PvnQSQXpdy13+XGhL/dusCvVsULeNxUll8+VzgwmMHGvRCmZ8E7nkNLjUvg1a5YElNjCCp0iUbK0DSydYH+qnLFryKqtyZ7WrKFc4VfkjvxWtNUrd3cBDTIx7LmhAtdZYw0oJdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WPuz1X5J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVALoyyF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WPuz1X5J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVALoyyF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 20D471D00054;
	Mon, 25 Aug 2025 12:41:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 25 Aug 2025 12:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756140090; x=1756226490; bh=bhWVvNLgGw
	unFByGRj4Repv3TNmJJZyPQ0gGOgBJj2Y=; b=WPuz1X5JutaShSeqPH8W6O7AF1
	QrcGCKn0fmdnFMmcGyq6HnJJx3craIj0ymIDUjIul9JeRXOY1ywhK/gYhPTwWVpX
	7k9LcN4pbuPqm1csD4DrOh+Mhte5kR6J9DDmCfptEsSoLemStvV6oBNQkzDm+m4N
	tm0Z3k/sED/1aYhH+LSAzVL+qS35PUekYJ0yxTuI73Yt9RbB6ECo/QGGXIKkDmXh
	nr12v/2ef9iuZGtDFNHrSAMkVL8Vf0XYVjftyvZRuFUe1Rhu3cQ/F5a6DaKwhNUy
	Kpog/53vDRxUX1A18ihHUW7KcXoJ8xKwTuEPLNB7Sbf52gZhNidpo8yCnIEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756140090; x=1756226490; bh=bhWVvNLgGwunFByGRj4Repv3TNmJJZyPQ0g
	GOgBJj2Y=; b=eVALoyyFketWUehJBy+oInHn17m8V5LsauOCjJkLajEYsvrSZOL
	MmXlPwNEqyyBG4OOFNEsYZbnmM2p3t195ETK63ICVpSLMtE7cooqX9imK/Ih1Ntl
	AtqhL1/a2F/S3u1SIMnnkPyeRqD2PrVqR0Jmzz03kfmMwOXM//L0J70Bboc9wvzp
	Wfve6l2cIl0i3afb2rdeFE0iaK60a3Z5zLOiPPDY0K5ceZCY+wqTAl9Clo+FJx4w
	URGpFHAB5Z/g8CtyAczpbzPaH5T1IuQXX6xrSjMb3AiKR+d1Yh0Q416WAfurR8tB
	n1iTsC8xyxCkRw9eV/gY2KrDDAWXThZCf3w==
X-ME-Sender: <xms:OpKsaGvnKsh3WNEXrWjJu35ierIPVqK_pYge-I59Jrgu93fy8-hVbQ>
    <xme:OpKsaIZoX3pZi-mwC6v4h1qHjEFDThmupLGkVEWWpac78dvTFx3gQuDLU5Np2JR4U
    zqkxgyXU1MAbYKgvw>
X-ME-Received: <xmr:OpKsaNYC-dZklv7tvSJFR2AkZOJUWCoi7Pad7Zeusm_FWdpXLaUmMsAruE5av72aY6t9HXfth6qgHUSODG0ZUip2ertaKuIgEwyQGd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepmhgrrhht
    ihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OpKsaJkHGZqzCjCD2OXkwV_aQRyfbH8bTKg2wKdlI1QgXjTtrP2R3Q>
    <xmx:OpKsaA2wP6m-j8f7rDLyaxDz8TTex6c-qvLmjCLMESuzvdExvlRm2g>
    <xmx:OpKsaB30CF0ptwtG7KX7KE2AKTO2vtP-TPBMNs5Xb6v60wf6XOISlg>
    <xmx:OpKsaKrekQtFcgqjMVHc7fXv8jlYb1KdiphqtVy9p8LfX9SOuHeRlA>
    <xmx:OpKsaKOsNEwsvYz2nzzOoHup_vq-8YjTrRzMsw6xIuF7sQOf9Wh1gkjY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 12:41:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v2 10/16] add-patch: split out header from
 "add-interactive.h"
In-Reply-To: <20250824-b4-pks-history-builtin-v2-10-964ac12f65bd@pks.im>
	(Patrick Steinhardt's message of "Sun, 24 Aug 2025 19:42:23 +0200")
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
	<20250824-b4-pks-history-builtin-v2-10-964ac12f65bd@pks.im>
Date: Mon, 25 Aug 2025 09:41:29 -0700
Message-ID: <xmqqfrdfs69y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While we have a "add-patch.c" code file, its declarations are part of
> "add-interactive.h". This makes it somewhat harder than necessary to
> find relevant code and to identify clear boundaries between the two
> subsystems.
>
> Split up concerns and move declarations that relate to "add-patch.c"
> into a new "add-patch.h" header.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  add-interactive.h | 23 +++--------------------
>  add-patch.c       |  1 +
>  add-patch.h       | 26 ++++++++++++++++++++++++++
>  3 files changed, 30 insertions(+), 20 deletions(-)

What is left in the interactive side is the things "add -i" can do
other than "add -p" (aka "add -i" plus "5: patch"), which makes
sense.

It is surprising that this step does not touch any of the clients of
the "-p" machinery (like "git reset -p"), though.  They surely do
not need the rest of "add-interactive.h", do they?
