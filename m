Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17124255F31
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057488; cv=none; b=JWaU91/2X6fz/a+ydsHFJ0i5rbcqqhcFKyqDU/jL82tuFedFVdEwkV12X0meRiZuVSQon+R0ywCEdw81HrRRbNSqefnv5Y+hDYG7LFq7W4wzZcIlKSHEOeZtuvni2ZDbA/gU6AdTYHvZq0aHIQlx5FEnBG6H5lDc/Cy529H9W4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057488; c=relaxed/simple;
	bh=Nv2iQzBQA7WTJ3KubMvX0j5aG3WXGC1B5fw60ksSIEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1jlHO6/z0TEC4Kt7Nvve72N5MSkCq0RcKwIqvHG5uBOKY0BW2falUwBkhrEVNOS4m+L1O822ItVZ+Ax2J0ZbESArhTUK86VNGbkpzhJiDdCQ0n4lrfNPQI3MNAfKiOQLNzcu9hvW4c5jtbMEmy6JhWBEWVuYQfGUGZ/54v60rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JWTctV7q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eBA5n6Bx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JWTctV7q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eBA5n6Bx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C50091D00056;
	Tue, 21 Oct 2025 10:38:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 21 Oct 2025 10:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761057485; x=1761143885; bh=qR1fXiDY41
	MarmfI/L0NOcQWevoiwzgntxm8cgnGfXs=; b=JWTctV7qX7nkegt0znVT2Ls8/N
	tZIw7YVEH9rcuSQ2mvTlX8J2TST4ILuIkqkzKErIh74LzwP7lDExIqwPGAql6OMr
	iK1/ND/hvBCz7UMxp2EAo7ZWwrDVXW2vOUR5JZUxzKIstpZKOLLYHkS58ZlHgxBf
	5M8pl0D9uqdfbDWiEKIVjZEWuaqkq6FAS+VxSO1hjLjsChpbS05llB4BFY+syVE/
	6erf0RLILdONP1gHv4GCfH+7XNcNPhx5+1t1jjnSz7jjeBGG1Id2oGAEFDe/NkMt
	7YWov/rSVv12qQFQwxxjWXzhjJtccfFMEjnzRmkNa6Q7vfJ2seUnYRB7zLzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761057485; x=1761143885; bh=qR1fXiDY41MarmfI/L0NOcQWevoiwzgntxm
	8cgnGfXs=; b=eBA5n6Bx1NRmGfuKxkNEuo0D1EHqZbSnj8mdeb8TmiFG6YDbGS2
	QGeKfhDRAsIwswU1wYO+6Uufmg+fKeMcEK8DxkQTxeF29vaJkp/WACWBfgj+/JT6
	ws38S2JrZ5YvuO2NHQxHMsHighvQnghFXVffOiUq2fIk3NHXyUv9x0tzB18M7KuM
	oFOBaURU3ZZQI9KOIS97kySktL/yrFykC6DrOpkPGR5sSrB+uZkOwsWqrI9ry9qL
	UinYgBp2PaBhHqAT0odcx7Upwlf3nH9wg2QxHEvDJdK1jjxON0RckVd+LtajHETw
	hFyzOrESfpHsxx0mFGcs1tG9y0IdH1bgD0A==
X-ME-Sender: <xms:zZr3aAXLRc5f0JMTV0ThvL4H3R1uxA9fGTIbOuX4Mjun_xP-VN9szw>
    <xme:zZr3aLfV5iGjOx_FrjJwlOQJ3bIqbSHCCjZVcv4hGq-dMYGOrP0az8vNwhHNqhsjp
    xziFN8SP2fwFDyc2oaVbmTloQk1gw5mKUw_tDah67xkSkHTMpRpzw>
X-ME-Received: <xmr:zZr3aMv7ES14T6-Z_qIegiR1QWC-aGuwv-9ZE-MrjW3cCQjlkuM53ZpvCAgp4B3swLRiwc7wyIaSgE1KTxkoa0nZEBJ99mdZz4Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepveegudetudffjeekledvieekvddvheekueeuhedttdejveefkeektefhgfeh
    ueetnecuffhomhgrihhnpeguihhffhdrtgifnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehjrghkvgesiihimhhmvghrmhgrnhdrihhopdhr
    tghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:zZr3aK_BpQfzbm-F5VTv2VK8Ip__ltngGHv5cq2diJFODPiOv4dUzA>
    <xmx:zZr3aH1uALJrMLYC9wdSJjOGUcRME_QIvxDW05iAhOfwAnEC6TaLhQ>
    <xmx:zZr3aPCyq3LKVF-2_CEQQhUZpz7UZ2KKJkAr3MnI5LLZmOjGNI4qbg>
    <xmx:zZr3aDcYWIHCx9KNeF0a5KKTovVhAHqImoAptPQ1R_SoryA6eAO4fg>
    <xmx:zZr3aHe2D4xXVhMultU6IztF6ZMD7cf48oyP1xESK_ck00n_2WJDC59w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:38:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jake Zimmerman <jake@zimmerman.io>,  Lidong Yan <yldhome2d2@gmail.com>,
  git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
In-Reply-To: <20251021073640.GB259661@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 21 Oct 2025 03:36:40 -0400")
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
	<20251017075153.GA4078773@coredump.intra.peff.net>
	<xmqq7bwt1kyf.fsf@gitster.g>
	<20251018094037.GA1060824@coredump.intra.peff.net>
	<xmqqh5vww7xa.fsf@gitster.g>
	<20251021073640.GB259661@coredump.intra.peff.net>
Date: Tue, 21 Oct 2025 07:38:03 -0700
Message-ID: <xmqqy0p4wcac.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Both.  We do not have to call flush_quietly() and can call the real
>> thing with output disabled.  The dry-run bit was only added to
>> implement the flush_quietly() variant.  If we lose the only caller
>> to flush_quietly(), all of the supporting infrastructure can go.
>
> It's not the only caller, though. b55e6d36eb added another earlier in
> diff_flush(), to handle --name-status, etc (which was its original
> goal). That code possibly remains broken, even with my patch, and
> would wait either on Lidong's dry-run fixes, or lifting the /dev/null
> into the flush_quietly() function.

Ah, OK.  That makes sense.

> So really, the regression fix should probably cover both of them (which
> it would if we move the /dev/null redirection into the flush_quietly()
> variant).

Do you mean something like this on top of your patch for 'maint',
and the latest from Lidong to the 'master' front, then?

Having calls to this helper in two loops in one function looks a bit
awkward but the conditions to enter these two loops are mutually
exclusive, so it is not like we can remember the result of the calls
we make in the first loop and reuse in the second loop, so this
probably is the best we can do.

--- >8 ---
Subject: diff: fix "-w -I<regex> --quiet"

An earlier fix made sure we stay quiet during "dry run" patch output
taken for the purpose of choosing which filepairs should be shown,
but the same helper function needs to be made silent when we iterate
over the diff-queue to compute the exit status.

 diff.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git c/diff.c w/diff.c
index 9b8d658b9e..1492ae108f 100644
--- c/diff.c
+++ w/diff.c
@@ -6172,6 +6172,8 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 	run_diff(p, o);
 }
 
+static void diff_free_file(struct diff_options *options);
+
 /* return 1 if any change is found; otherwise, return 0 */
 static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options *o)
 {
@@ -6179,6 +6181,15 @@ static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options
 	int saved_found_changes = o->found_changes;
 	int ret;
 
+	/*
+	 * run diff_flush_patch for the exit status. setting
+	 * options->file to /dev/null should be safe, because we
+	 * aren't supposed to produce any output anyway.
+	 */
+	diff_free_file(o);
+	o->file = xfopen("/dev/null", "w");
+	o->close_file = 1;
+	o->color_moved = 0;
 	o->dry_run = 1;
 	o->found_changes = 0;
 	diff_flush_patch(p, o);
@@ -6876,15 +6887,6 @@ void diff_flush(struct diff_options *options)
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
