Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF819250BFC
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811398; cv=none; b=KOgQWgRlYLuYWauD9cFpgyD+0W7uk+cdHZ6vHAktR+uLtiXdc1+Fvecn6eBvp6/i793KQOacwDiIATjRCpObS/Re47OZbYC0v5G7/CICGyl69MBQ8wFyiWXnx/rhYPuBv7gLgRPyQLZonXn9lSP4JuMBhspDJCiw43JftcndBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811398; c=relaxed/simple;
	bh=0BskvjjZ71ZVVPTR8M21hHJMIB523KFF4IjIXerhzwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwm9uURGeXE2dWj3CF7omdPS8NwOgoacD3Nf4gK+Cj8AQPhEkFvDJ24MUX9btLhnLDhdlfgPc63dJNCsH/W1YY7U2UeGh64IH0nYIczEOoMsFjv6IP++cozMcmCu6LLEfwH2k09AqKJYr5QGirbxkHCZvCqLD6N/scnnLFIGZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n49RYeNL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eBnK0s25; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n49RYeNL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eBnK0s25"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id BC2F91383156;
	Mon, 24 Mar 2025 06:16:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 06:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742811395; x=1742897795; bh=Vc2Vx6TSHt
	v1Po94EE3vUkewlM19iFNbGspb5UB9umI=; b=n49RYeNLfE7ebQ1uqwWh/E5RgM
	LmTGkt7atIsDEq9w2NWSDAf6HF34fqZsRMjlOrvZXsXgYJkRvA8YCNILSiQOu1M3
	YZBhJGmD1b5ujQomquNrvyVQqWk+ioGBMyDvn3Aq2iKyTiDzADLthTveIa+vYDo6
	3dMKNamh+kIn+DjkagSE3DF3rkbRkdIpUsqaQhdFLTKARVLwZxnKsvuhYNpgdyKS
	lqChLLQzr0X5egBHwUnZ3ms1l1BYotj5jlB7IkzUwu1LNyiQbgGAwrinTi4vbSyJ
	K1Cqqy9EhUnOQYn2wRR4lVcfk+GebAMSbko7p27ISd88PYgjLQuD9BpPgVWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742811395; x=1742897795; bh=Vc2Vx6TSHtv1Po94EE3vUkewlM19iFNbGsp
	b5UB9umI=; b=eBnK0s25iLNAeJZb8MBhFtm/JpYIfo/9BWiyISdKFqpefnOJNL0
	bHfIlaaqA263io3qPC1w9hSeaJmdLqlGhCmkSdiUtR11PYy88N4K6JEptaA/EqGa
	bgG8FYPc3EOmcqSz6CR/wP9l9iqNPVAp8b2lGVOLzYOLAnZoa1PoDZtjidyXTvUJ
	OzLzu3hoPki6FGM8teBgYSt6BQHkShCzTqmyEuYzACapxHgryrEr+S96zPo+ctms
	fj14fLDrmASxvwI0pkaM3B2u2wkVe+JTXlysRPmLEGAC6/vwnKm0jnHDnU2kn5uP
	/4GBmAQiF96sh4MntjkWPxeLBw1HeceXF7w==
X-ME-Sender: <xms:AzHhZ6Zye0JfB268drcqAEXDjSioEs79j2x9N4lSvB7JvZybzfDOWA>
    <xme:AzHhZ9YQjySQm5xGG-MJs0_CESerpFgRM4k8L9rHduQtT75v7TboZ8yfR6mHCVuPF
    XpkM5MopVYSqs59Fg>
X-ME-Received: <xmr:AzHhZ0_Hsipsepj8L7vjQRhlEmAJZnCSAr1-oh0LxBr42ABlekgxHTWGZQ9_yfCtFgKf4XOBPYAorLmzUjnqgPnhARGynGZNUTsFMMy3QJzvQJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegthhhr
    ihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:AzHhZ8pC51D5CD9I_79n2rByyugn49S7HbaCHAcU2DFDdu0msKLkXg>
    <xmx:AzHhZ1qw9DJhIovrQBqZli4t1pridUvlnGV1ZWs1p24p5O8McPcC0Q>
    <xmx:AzHhZ6SOfqhGZHONwXbS-H3i7emwBP3Tms95HSKXX1Sdr9qbTwVdhQ>
    <xmx:AzHhZ1ql15u_W0AyfYZV2uaceuIKPvZKt28S4qkuT02yY13iNzr-xQ>
    <xmx:AzHhZ-BZTyiGW1qiShHHKGV0Ow_l_mepg_BKRQlMqOYEWqaPMzksG-yq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 06:16:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8cd6f82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 10:16:32 +0000 (UTC)
Date: Mon, 24 Mar 2025 11:16:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	jltobler@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] blame: fix unblamable and ignored lines in porcelain mode
Message-ID: <Z-Ew_12NWX_5qATN@pks.im>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <xmqqzfhbrb78.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfhbrb78.fsf@gitster.g>

On Sun, Mar 23, 2025 at 08:58:03AM -0700, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > However, this option was never extended to the porcelain mode of
> > 'git-blame(1)'. Since the documentation does not indicate this
> > exclusion, it is a bug.
> 
> I agree it is a bug when people added ignore or unblamable support
> that they did not _consider_ what to do with their new pieces of
> information to help porcelain writers.  It is not a bug in the code
> per-se, but it is a bug in the brain of these people ;-)
> 
> But prefixing random garbage to the commit object name line in the
> porcelain mode output does not sound like the right solution to the
> bug, either.
> 
> When enhancing an existing output format, make sure that your
> changes will have minimum empact to existing parsers that do not
> know about your extension.  It is reasonably expected that existing
> Porcelain scripts reading from --porcelain mode output works by
> 
>  - Recognizing a line that match "^[0-9a-f]{40} \d+ \d+ \d+$" and
>    take it as the beginning of a new record;
> 
>  - Collect all info lines before the payload line.  Lines that
>    describe per-commit information are not repeated if it is already
>    shown, so remember them when you see the commit for the first
>    time, and recall them when you recognize the commit you already
>    saw.
> 
>  - A payload line is indented with HT and terminates the record.
> 
> If you start to add unrecognizable garbage to the line with very
> well known fixed format that is used as record delimiter, you would
> break the existing parsers, which is not a very nice thing to do.
> Are there other and better ways you can think of to add new pieces
> of information like this in a way with less severe damage?

I think the porcelain mode is already built so that it can be extended
with arbitrary new information, no? In `emit_one_suspect_detail()` we
end up printing one line per info we want to display. I would have
expected that we can extend that function to also print information
around unblamable or ignored commits, like we already do for boundary
commits. E.g. something like the patch further down.

Thanks!

Patrick

diff --git a/builtin/blame.c b/builtin/blame.c
index c470654c7ec..cd8322e2619 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -255,7 +255,8 @@ static void write_filename_info(struct blame_origin *suspect)
  * the first time each commit appears in the output (unless the
  * user has specifically asked for us to repeat).
  */
-static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
+static int emit_one_suspect_detail(struct blame_entry *ent,
+				   struct blame_origin *suspect, int repeat)
 {
 	struct commit_info ci = COMMIT_INFO_INIT;
 
@@ -275,6 +276,10 @@ static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
 	printf("summary %s\n", ci.summary.buf);
 	if (suspect->commit->object.flags & UNINTERESTING)
 		printf("boundary\n");
+	if (mark_unblamable_lines && ent->unblamable)
+		printf("unblamable\n");
+	if (mark_ignored_lines && ent->ignored)
+		printf("ignored\n");
 
 	commit_info_destroy(&ci);
 
@@ -295,7 +300,7 @@ static void found_guilty_entry(struct blame_entry *ent, void *data)
 		printf("%s %d %d %d\n",
 		       oid_to_hex(&suspect->commit->object.oid),
 		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
-		emit_one_suspect_detail(suspect, 0);
+		emit_one_suspect_detail(ent, suspect, 0);
 		write_filename_info(suspect);
 		maybe_flush_or_die(stdout, "stdout");
 	}
@@ -344,9 +349,10 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 #define OUTPUT_COLOR_LINE           (1U<<10)
 #define OUTPUT_SHOW_AGE_WITH_COLOR  (1U<<11)
 
-static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
+static void emit_porcelain_details(struct blame_entry *ent,
+				   struct blame_origin *suspect, int repeat)
 {
-	if (emit_one_suspect_detail(suspect, repeat) ||
+	if (emit_one_suspect_detail(ent, suspect, repeat) ||
 	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
 		write_filename_info(suspect);
 }
@@ -366,7 +372,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	       ent->s_lno + 1,
 	       ent->lno + 1,
 	       ent->num_lines);
-	emit_porcelain_details(suspect, repeat);
+	emit_porcelain_details(ent, suspect, repeat);
 
 	cp = blame_nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
@@ -376,7 +382,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 			       ent->s_lno + 1 + cnt,
 			       ent->lno + 1 + cnt);
 			if (repeat)
-				emit_porcelain_details(suspect, 1);
+				emit_porcelain_details(ent, suspect, 1);
 		}
 		putchar('\t');
 		do {
