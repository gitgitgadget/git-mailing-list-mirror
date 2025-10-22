Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE2246763
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150505; cv=none; b=PNYE6NpizC9IBXH1R9i4Seeem57f9a0TgQQj6sO8wxRYloJUcZQf96waBFSH2uFVRNcSFFoI9gwVamtxd4BPUb+8215AhuHhkcdrhRuC0aXCiAsk+D2BWFav5ytww72hffLJoKGzt6wNn1QyxnVOdPnWbSVSsM1MSU6lPX5yX3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150505; c=relaxed/simple;
	bh=Jn6Ai7vSmxV8b9C6tdFTDses9DLBzRqTLO/N8HwKqfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CPNl0Xx0d5zAu/6lpja8DlydD2IiuF/caigGK4YA14ss8CwWVykCsF9S/b3qbntUh156/FnoDWMRS30zOKh6UzgnlGp/UFF0cQ4ma1viw250fdW3r1loatMHaESN8qQBCXjfHPhGYP/RHHmgxOKXgVx+n0VjK/JNbg3RfVpKlB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bn2I7o2F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rMHRHaiO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bn2I7o2F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rMHRHaiO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B83391400176;
	Wed, 22 Oct 2025 12:28:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 22 Oct 2025 12:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761150502; x=1761236902; bh=O1oOIXJFyR
	/IkF7/UC6b5Pyu67VUGohE0FRTt6M6U68=; b=bn2I7o2FBm47HDN53PCSNzRgD1
	njEVwVNXFU3aUuSWO7p0MmzMrd3LsfmIP0Oef9MSjMf4+szGL87blkLaRL31N32e
	PyDZqPu/wOo+WeIFTDKkEUvk6xYwJlnl+nnJ8xTlza8bPsI2hpNnAmJ+28z36FC6
	q1lOj03NCsb0S3UgGdWzEWJtfXRe4GbLKGdQ1yxKQnrHhr8R00Dc5SX0mQsBRbvA
	7mvhTjSPYYr2oVQfic6wul3ZVfDA64WKXilDRJIqo9/G321GN4btIdQdSzKgl4+U
	dAAdgAWSSbQAKKkL8AYfNG0T/u2mwS/masWr8Mk0qYJPorx+mpj+ZAMqM9pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761150502; x=1761236902; bh=O1oOIXJFyR/IkF7/UC6b5Pyu67VUGohE0FR
	Tt6M6U68=; b=rMHRHaiOxf21AsNHDRP4M77xHcbShZItBFLRhAImF85CSkoNOJA
	ynBF30DfRFcT2GjDXHk51o/BCRpL8D2JEW6qIHByuNjeEBJMivlfY8pbdV9QTgo0
	8tRZ4cGTm5XJRF0MPkKTxF92oPVId7qhsw7q7OxtTNNla17Pfd1tfOi90cDz5TuS
	012wyC3gl2WiIG+Cc0jgVRlva3CxoBC6jY+yXhH/ZzKxuwi755Z6mBTnlsEvlSAT
	4FZyW4duZDMFyhE6wSIgBulolyXmjKEbq7kPouwJW46I8Mm/o3CxUWInJNYkf1rD
	EhilDa4UTW0CW0b2KlbbJHXO9ZIIlKj6B6g==
X-ME-Sender: <xms:Jgb5aPxivKcD6vf1PwrFrLPlFs3e60PMffia5GISWgaIgS184cYhVQ>
    <xme:Jgb5aOJzoY_Dg6Xqduh6yhi-SQEludcqYqnjKYst1KnAIcGultOWpuawZCUKmJ5ly
    xJ_UAqKWyPtxtds82lGLszqc2m63ZEwfBJX6OEvRgkeKnLJrYSx>
X-ME-Received: <xmr:Jgb5aBr2RalJ_1fkO3BHvKYjp21NchB59qEAQBfmWCBUTkFi2iX5p0DAwUyHOp2kn8LYGiOOXVDCubzqnY6acGBCl4qwDE0Yxynx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepveegudetudffjeekledvieekvddvheekueeuhedttdejveefkeektefhgfeh
    ueetnecuffhomhgrihhnpeguihhffhdrtgifnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjrghkvgesiihimhhmvghrmhgrnhdrihhopdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:Jgb5aFJPft-_TpxZX4jHhJ_0PE2YrFL4XQYzu0KKHLC-JE6ZOI5mrw>
    <xmx:Jgb5aOQuuRSkvWyN9wNkRPnTuVpqrt-hRhWWh00FoAOHISphXw-S2w>
    <xmx:Jgb5aMsoJimZntsEwjNPGPAOdMPIicvze-U4qmHzoUaFm9hXMWI5sg>
    <xmx:Jgb5aHYIQ8k3S_MIxCBQnZOTK0YsJqOIXK2ewI_7O-lycspz5f1Tcw>
    <xmx:Jgb5aELMFfTLo2J5gxTlakjTX-TKYGjWawqgQvovnRZPotPPHEW_1I8b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 12:28:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>, Lidong Yan <yldhome2d2@gmail.com>
Cc: Jake Zimmerman <jake@zimmerman.io>,  git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
In-Reply-To: <xmqqa51j0zzj.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	22 Oct 2025 07:31:44 -0700")
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
	<20251017075153.GA4078773@coredump.intra.peff.net>
	<xmqq7bwt1kyf.fsf@gitster.g>
	<20251018094037.GA1060824@coredump.intra.peff.net>
	<xmqqh5vww7xa.fsf@gitster.g>
	<20251021073640.GB259661@coredump.intra.peff.net>
	<xmqqy0p4wcac.fsf@gitster.g>
	<E76C71D8-103E-4C37-B05C-86DC180BD519@gmail.com>
	<xmqqa51j0zzj.fsf@gitster.g>
Date: Wed, 22 Oct 2025 09:28:20 -0700
Message-ID: <xmqqms5izysb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Lidong Yan <yldhome2d2@gmail.com> writes:
>
>>> + diff_free_file(o);
>>> + o->file = xfopen("/dev/null", "w");
>>> + o->close_file = 1;
>>> + o->color_moved = 0;
>>> o->dry_run = 1;
>>> o->found_changes = 0;
>>> diff_flush_patch(p, o);
>>> 
>>
>> This would make everything going to "/dev/null" after the flush_quietly() call.
>> I think we need to restore o->file.
>
> Ah, true, the original location was only for NO_OUTPUT but the other
> caller to the diff_flush_patch_quietly() helper does deal with other
> cases as well.

Now it turns out to be rather ugly, having to go back and forth on a
few members of the diff_options structure.  I suspect there are
members other than color_moved that would not affect the outcome
(like --word-diff and --color-words) that cost us without giving any
benefit in this context that we may want to disable, but that would
make it even uglier.

I am having second thoughts on this approach to move the redirection
to patch_quietly(), which means for N-path change, we end up /dev/null
redirection N times.  We have two callers, so we may be better off
having the redirection around the loops that contain these callers?

I dunno.


 diff.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git c/diff.c w/diff.c
index 9b8d658b9e..d28f69e5ce 100644
--- c/diff.c
+++ w/diff.c
@@ -6177,14 +6177,28 @@ static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options
 {
 	int saved_dry_run = o->dry_run;
 	int saved_found_changes = o->found_changes;
+	int saved_color_moved = o->color_moved;
+	FILE *saved_file = o->file;
 	int ret;
 
+	/*
+	 * Do the dry-run check while sending output to /dev/null and
+	 * extra computation like color_moved that would not change
+	 * the final outcome disabled.
+	 */
+	o->file = xfopen("/dev/null", "w");
+	o->color_moved = 0;
 	o->dry_run = 1;
 	o->found_changes = 0;
+
 	diff_flush_patch(p, o);
 	ret = o->found_changes;
+	fclose((o->file);
+
 	o->dry_run = saved_dry_run;
 	o->found_changes |= saved_found_changes;
+	o->color_moved = saved_color_moved;
+	o->file = saved_file;
 	return ret;
 }
 
@@ -6876,15 +6890,6 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
-		/*
-		 * run diff_flush_patch for the exit status. setting
-		 * options->file to /dev/null should be safe, because we
-		 * aren't supposed to produce any output anyway.
-		 */
-		diff_free_file(options);
-		options->file = xfopen("/dev/null", "w");
-		options->close_file = 1;
-		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
