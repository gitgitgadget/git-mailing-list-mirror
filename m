Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3AD3B6362
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144888; cv=none; b=OMMf59xMUFh3YAI2DzutyEpuCm/nbFhF97MF8mV4zHL+H5IfILJ2NK7mjUhNAkIyqztBZQAU55oixTOsPXrJMG94vS9qJrYRIUN+6BWrP6BtLIJORWF3YpVY7HcTc6BzM+cUqptVogGY+cr6EZueQJXVrSBM+pS9HEIo+SczHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144888; c=relaxed/simple;
	bh=65p1001YdUZTaeoAetR86T2EQRAFvfGefvFx49kAC/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6ZUp+w54UZ3a4nzHRNVfIaYbMXZrh+KhEW17hCss93z8oqnJFj9DF9t9nvOgxgnqiTs01UL//aceH8TRim5HfjfumDMDJYNGrrg0uSoO8J2fpQ3p+/cyPCWV3OtiHa3oQgTQZL5HM4UDzUhDCgc+eohuv1N8IhrcUAvXY1Caec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AuKdOa5e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SiBVTlmk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AuKdOa5e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiBVTlmk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C981AEC0CA9;
	Tue, 10 Mar 2026 08:14:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 08:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773144886; x=1773231286; bh=y8zXPfPk8m
	GtMKec2txBEAfAAbnpP/zdTY/Y+ZzYUqs=; b=AuKdOa5entpvbgX/lOBxM76CnX
	fd1zU/z/Dx/RRvC4U9zYij8TmpwGxI4I6ZB/7/4NJ9lEBC5Oa23wKcIAzylYWmAl
	aZtOpq9kipILLhqwAUq+fC+FeuZGaLBjKHcyCYBCvaiSxQU9D/HFTlSs+CSSJwxp
	QKKf6gLt1v58gvExjiyF6GcBal3wzEk9cZty7pLu1PfUuiUMBf87YVgkw/BddByB
	+XWOEaz4Bge+Kd3jk3rtFOg7Q5MTwtGHMpsHmh8YlxZDxiHAclokQ3lLYX0N8F5z
	OY/lC8zulNfFW+0rCeCH423SRqCt93qOzxkX6Ba5w++24o3NfEI/xbYaRPMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773144886; x=1773231286; bh=y8zXPfPk8mGtMKec2txBEAfAAbnpP/zdTY/
	Y+ZzYUqs=; b=SiBVTlmkBcp6JqajaRidmowJoFc94t+7kbZDBcRw6Zsdo39s5Yg
	pWdl6FPdM2MkGCyAaU5pfZ5bLEZFEakeA5lusWVbUIZaptrcaYYup39Z04rEuxLf
	a13A0np83w/PXifpBkqaYScxdN6zEB7qMkIItlSAaXtC+UAHIyUf3gxN27Va/e/I
	g84bhqmIr0G8Q3vfKgyZmbp5p7kfcErf19LRGqScP6IfxebIBLo5FW175IyWy8m5
	pKtKXqFNS+5b0VuCPUA9q8m6gK3UDS8QLqEM+ciRZTVPcXObkRJ8luNpnOghGzfG
	/7dzg3H258/0WWX+DTnp4KWSry0fqNGABkw==
X-ME-Sender: <xms:NguwaVXs2qYcSFHVdTGlWUFjnn1NTK7EUiUvt7_DnsagNkr0L1a9_A>
    <xme:Nguwacm-FbN68LoS56mrGpUB4_PjXrvHz5ZVtT680_LlFiS5vtDBru14lhT_FzITp
    lVnB68ptm3k6Oqbpa-2fB8qquq72xUXfMUvieFce58fg2gFlUPQVAk>
X-ME-Received: <xmr:NguwaWbf4Gbt6khJaHmrUdbmINUlxsdW9-7JrXCOms6Pt3vcsTXW3jbFJQ38_nRqGhv1B-i3Lb_eE5X2e9cDfLzKpu_VqvTw_IFYJI9L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhsmhhilhgvhiesghhithhlrggsrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:NguwaXPQnBVi61vvM3qRNSzhYBu0O9VJOdyd7kw4lZZOJHxPrsu2aQ>
    <xmx:NguwabZIUaifPhLMJJJ_Kc2pxFiGheR-K7e5VJEqqR2QyhR-EYQrjA>
    <xmx:NguwaV3HTdwrbhNRvBkr5kAuFXW3n2Az_mLioA6UuZ7aeyVAn1GLKw>
    <xmx:NguwaReE4qUq9pn-3hue-nO3ZMvFKVrfWKEzhYbWy1NVmEMTTDjPiQ>
    <xmx:NguwaYzOMP0jOlGTuVF0VW3wW2YfvWN1i8t3nIkqeTtKITM57ayPRjbc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 08:14:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f1057ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 12:14:44 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:14:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 03/10] upload-pack: reduce lock contention when
 writing packfile data
Message-ID: <abALMbYE0C0UlwbD@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
 <20260303-pks-upload-pack-write-contention-v2-3-7321830f08fe@pks.im>
 <20260305011638.GC4943@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305011638.GC4943@coredump.intra.peff.net>

On Wed, Mar 04, 2026 at 08:16:38PM -0500, Jeff King wrote:
> On Tue, Mar 03, 2026 at 04:00:18PM +0100, Patrick Steinhardt wrote:
> 
> > Extend our use of the buffering infrastructure so that we soak up bytes
> > until the buffer is filled up at least 2/3rds of its capacity. The
> > change is relatively simple to implement as we already know to flush the
> > buffer in `create_pack_file()` after git-pack-objects(1) has finished.
> 
> This 2/3rds feels kind of arbitrary. Isn't our best bet to try to fill
> pkt-lines? Later you say:
> 
> > Now we could of course go even further and make sure that we always fill
> > up the whole buffer. But this might cause an increase in read(3p)
> > syscalls, and some tests show that this only reduces the number of
> > write(3p) syscalls from 130,000 to 100,000. So overall this doesn't seem
> > worth it.
> 
> But I am not clear how it increases the number of read() calls. I guess
> you are concerned that we'll get 50k, and then do a read for the
> remaining 14k, and then read 50k, and then 14k, and so on. But I'm
> unconvinced that 2/3 is really any better here, as it depends on the
> buffering patterns of the upstream writer. They could be writing 1 byte
> less than 2/3, and we'd wait to buffer, then read half their next
> packet, write it, then read the second of of their next packet, wait to
> buffer, and so on.
> 
> Even just doing:
> 
>   git clone --upload-pack='strace -e write git-upload-pack' --bare --no-local . foo.git
> 
> with this patch (and not the later one to increase the buffer size of
> pack-objects), I see an interesting flip-flop between packets of size
> 65515 and 61461. But we never send a single full-size one, even though
> pack-objects should be outpacing us (because we're slowed by running
> under strace). That's probably an OK loss of efficiency in practice, but
> it's very dependent on pack-objects buffering.

The big question though is whether it's a loss of efficiency compared to
the previous state where we didn't buffer at all.

> I'm still a little bit negative on the whole concept of buffering in
> upload-pack, just because the interactions between buffering layers can
> be so subtle. But I guess I'm not really making any argument that I
> didn't make in v1, and you kept this in v2, so I suppose you are not
> swayed by it. ;)

Yeah. Its usefulness highly depends on the downstream command indeed, so
it may or may not help. What I'm not convinced of though is that there
are likely scenarios where it'll perform _worse_ than before. If we can
come up with such a scenario then I'll be happy to drop this patch.

For downstream git-pack-objects(1) it shouldn't really make much of a
difference at the end of this series anyway, as it starts to write data
at pktline lengh. But it may help users of the pack-objects hook.

> If we are going to buffer in upload-pack, there is an obvious
> optimization that I didn't see in your series. When we send a keepalive,
> we should just send whatever we have in os->buffer (even if it is
> nothing).  If we are wasting 5 bytes of pkt-line header and a write()
> call to send the keepalive, we may as well send what data we do have.
> 
> I don't know how much it would help in practice, though. Most keepalives
> will come before the pack data starts, as once pack-objects starts
> producing data, it tends to do so pretty consistently. And of course we
> can't send os->buffer before we see the PACK header, because the whole
> point is to buffer the early bit waiting for packfile uris.
> 
> So it might not be worth adding.

It's an interesting idea indeed. We also need to be mindful that we try
to hold one byte back so that we can "fail" downstream callers in case
git-pack-objects(1) fails.

So we need to repeat some conditions here, but overall it's not too bad:

diff --git a/upload-pack.c b/upload-pack.c
index 1b1c81ea63..199bbd1ad6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -484,7 +484,16 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		 */
 		if (!ret && pack_data->use_sideband) {
 			static const char buf[] = "0005\1";
-			write_or_die(1, buf, 5);
+
+			if (output_state->packfile_started && output_state->used > 1) {
+				send_client_data(1, output_state->buffer, output_state->used - 1,
+						 pack_data->use_sideband);
+				output_state->buffer[0] = output_state->buffer[output_state->used - 1];
+				output_state->used = 1;
+			} else {
+				write_or_die(1, buf, 5);
+			}
+
 			last_sent_ms = now_ms;
 		}
 	}

I'll include this in the next version, thanks!

Patrick
