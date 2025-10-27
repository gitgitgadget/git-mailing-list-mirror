Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EDA2E7F25
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553467; cv=none; b=IM/Pu1PJ3yapO+w94rML9VZwTwWcgsKyOnnUKG+LXx+ZmkMIuriWG6jU93OJfH/FvZMe4CHcaBKsMX23xT8P92W/TFsu3Pv3r4cwNYpiyVr6POubZy4Xj00E8FDGw2TbfBetpTvmqi0mOL6VB2e4LPqX31OTpCNPb7nY9vyebu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553467; c=relaxed/simple;
	bh=IK0LSQT1V8rc7Pe2VKLXU1AmjjcNdOJwUNQ4cDxM1bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvf92jAp4mBRPwBm+9bNSnBA35Z5YKIUdMyOlWDYWzFHqv+7MXKXGjaaZh6NwR4XWXsMODM0e/tTzi4j+RHFCvrtQQQHRSMGJmXZvT/c3/iJDnG3NRYPyym4oj/fyDYF0NDlmoV3/05JxBM7YnXfnBtiN3A8VmO0KvEfwcwHMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G/4cBh3B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wKWt7xMT; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G/4cBh3B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wKWt7xMT"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 76C6CEC014C;
	Mon, 27 Oct 2025 04:24:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 27 Oct 2025 04:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761553463; x=1761639863; bh=HQKaDybj8I
	OWCSdE8ZCDCx6Env6GEK4IQPpc61lf7Gk=; b=G/4cBh3B3EgRAsngNAQverVQ/l
	0nQ5QeYoHJXdq2zOdrRdxLtxJRvYbgbUL9kMqeAwIs/Ff/58t3QicdPBiX7Y3Ztr
	fLlRdu+e0r+VmsfggQT7cvdlEKwRPuQSQ3ey2mvhKHxjn1lPuP7691+ECxU1n4QH
	WETpC0m9UBv5fsvi/UBCI6np3q2pyUct1zc/JOTARwxzEUVKc1cyDqP1G8FHFeDv
	/1VBws41j4zRKvN0105LEFI/fPqg2/H7uoMZfE5FO0CMUs73ck5gw/GYSXX9ydnF
	iYbrMrhE5/sSvEmHfJLQ06PUdZzSpbi7Sy05K08W/5cTRuRGnYsdXSC/WhLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761553463; x=1761639863; bh=HQKaDybj8IOWCSdE8ZCDCx6Env6GEK4IQPp
	c61lf7Gk=; b=wKWt7xMTf2rZmSj0U4droSp+FC3WuqHZosvJ5Z1QjeN2TlrpeSh
	jkSsQ2ezlu3h6FAg2oXtHrGQB4/yqqPqOI2sMgvypYDFkcyBAffUdQttgTAgIcs9
	f/UqgrcGZc7+P2TNeqM4r4E2FM2TJGe5K8wZMq255eWXacgPOugd4bmrsfhwFrQY
	ZfP3+4cno/ALxmdW5JshFbyGiEIDUt30GfJeEAKste8El5NEOIyT5vMJjx+K0KVg
	dV7NdTmc+DeUs2FskXwOVZICXZ2A4l2G243mdo59T3O7MsjNOLhANdih+4Jwckjg
	oMzPtCh/LobSZO/eMF7Y3p30iEQ8c8oGbmQ==
X-ME-Sender: <xms:Niz_aI8gvyeCa1toR2RqO8g4uPgMQ99qRJcjoS_w0RZxILaZ0-blIA>
    <xme:Niz_aEaY5qBt-cIF5HLtiZwaW1CvgP6omgDX50K7tra_j8gHOxMHiCpt_2_aI9Kxq
    QdaOrT9lACKLBXjGEXS3a3QvKhgqE9ONIBOS8UismW2hd65glG1mQ>
X-ME-Received: <xmr:Niz_aH0USQx5taWt0A4WuI9DVZHfBdNMuJbew2eQnvt5F7brHqWokRnU5v-Qh0zqqr8cAcWUF0ZT7_JyyL326-1OG_daTobX7AzIVMUR9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Niz_aPZ2rxD-gJjYDpWPygmX9DSk0vtqfD0atcLXDflonKvCXFgL5Q>
    <xmx:Niz_aPJ51CQ-LEr85LboEY2L9bDpfhNaY4GYT_RQB6auZqp6l3vKTQ>
    <xmx:Niz_aOF2T2o0eapTiYknrnlDARdsE3UwKXEF77Zkw4_CKzwGGEBvqg>
    <xmx:Niz_aGs6GGytPXHsdJ8QRLX0vJB6kGrVtFYgd7GPKzr7mWkKlRqFyg>
    <xmx:Nyz_aNbHh-aYr2R9PxwB_GEuMk1Sb4xN0kOi6zJekxj7J2I7HoX81H85>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:24:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e18b5ec2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:24:20 +0000 (UTC)
Date: Mon, 27 Oct 2025 09:24:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/10] builtin/maintenance: introduce
 "geometric-repack" task
Message-ID: <aP8sJF45dHsVlgqt@pks.im>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
 <20251024-pks-maintenance-geometric-strategy-v3-3-9b5b3bdb4387@pks.im>
 <20251025191550.GA279793@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025191550.GA279793@coredump.intra.peff.net>

On Sat, Oct 25, 2025 at 03:15:50PM -0400, Jeff King wrote:
> On Fri, Oct 24, 2025 at 08:57:16AM +0200, Patrick Steinhardt wrote:
> 
> > +		# Repacking should now cause a no-op geometric repack because
> > +		# no packfiles need to be combined.
> > +		ls -l .git/objects/pack >before &&
> > +		run_and_verify_geometric_pack 1 &&
> > +		ls -l .git/objects/pack >after &&
> > +		test_cmp before after &&
> 
> I got a CI failure from this test like this:
> 
>    + diff -u before after
>    --- before 2025-10-25 17:51:59.985025237 +0000
>    +++ after  2025-10-25 17:52:00.304026445 +0000
>    @@ -1,5 +1,5 @@
>     total 16
>    --rw-rw-r-- 1 builder builder 1252 Oct 25 17:51 multi-pack-index
>    +-rw-rw-r-- 1 builder builder 1252 Oct 25 17:52 multi-pack-index
>     -r--r--r-- 1 builder builder 1156 Oct 25 17:51 pack-68c20c4590a622a21395b4480621d55494112a83.idx
>     -r--r--r-- 1 builder builder  226 Oct 25 17:51 pack-68c20c4590a622a21395b4480621d55494112a83.pack
>     -r--r--r-- 1 builder builder   64 Oct 25 17:51 pack-68c20c4590a622a21395b4480621d55494112a83.rev
> 
> I'm not sure if this is a bug or a race condition in the test. If
> "no-op" means "do not generate a new pack, but do generate a new midx"
> then it's a race condition (the regenerated midx might move across the
> minute boundary).  If it means "do not even generate a new midx", then
> there is a bug. ;)
> 
> You can generate the race at will like this:
> 
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 0d76693fee..2b5141196f 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -501,6 +501,7 @@ test_expect_success 'geometric repacking task' '
>  		# Repacking should now cause a no-op geometric repack because
>  		# no packfiles need to be combined.
>  		ls -l .git/objects/pack >before &&
> +		sleep 60 &&
>  		run_and_verify_geometric_pack 1 &&
>  		ls -l .git/objects/pack >after &&
>  		test_cmp before after &&
> 
> though if we are going to be picky about timestamps, it probably makes
> sense to use a higher resolution. Sadly I don't think there's a portable
> way to do that with "ls", and "stat" is probably likewise something we
> can't assume. I'd turn to perl, but I know you've been trying to avoid
> depending on it. You can hack around it with:
> 
>   test-tool chmtime -v +0 .git/objects/pack/*
> 
> for this case, I'd think.

Interesting! I would say that this is an issue in git-repack(1) itself:
if the geometric repack didn't lead to any new packs, and if all of the
packs are already covered by a MIDX, then we still rather pointlessly
regenerate the MIDX even though it won't cover anything new.

I wonder whether we want a patch like the below one? Problem though is
that we'd also have to check whether any of the other options have
changed, otherwise we for example wouldn't generate bitmaps.

In any case though, I feel like this is a bit out of scope for this
patch series. Other strategies that write a MIDX behave the same, so
this is something we can fix later on.

Patrick

diff --git a/repack-midx.c b/repack-midx.c
index 6f6202c5bcc..efa47bb55b5 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -285,6 +285,35 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
+static bool midx_needs_repack(const struct repack_write_midx_opts *opts,
+			      const struct string_list *include)
+{
+	struct strset set = STRSET_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	bool needs_repack;
+
+	if (opts->existing->midx_packs.nr != include->nr)
+		return true;
+
+	for (size_t i = 0; i < opts->existing->midx_packs.nr; i++) {
+		const char *item = opts->existing->midx_packs.items[i].string;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, item);
+		strbuf_strip_suffix(&buf, ".pack");
+		strbuf_addstr(&buf, ".idx");
+
+		strset_add(&set, buf.buf);
+	}
+
+	needs_repack = false;
+	for (size_t i = 0; i < include->nr && !needs_repack; i++)
+		needs_repack = !strset_contains(&set, include->items[i].string);
+
+	strset_clear(&set);
+	return needs_repack;
+}
+
 int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -295,7 +324,7 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 	int ret = 0;
 
 	midx_included_packs(&include, opts);
-	if (!include.nr)
+	if (!include.nr || !midx_needs_repack(opts, &include))
 		goto done;
 
 	cmd.in = -1;

