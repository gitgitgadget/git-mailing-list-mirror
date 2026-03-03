Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736A48033C
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550036; cv=none; b=gDE7aqXpQnxfQpdO/GgkuaKpqsukA7whGJ6sPy6JYE4lmrhDGEy/Xf+UIQTG0mpS+9wy8YAWBu7X/611V8YtQTk/L+aMFUua5p4WHlfLW7nX+n2H+rK+15M73Unq4H3hOjen1XV0X08N4jScgE2HE7iO4+0MV4eriimlHASDz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550036; c=relaxed/simple;
	bh=YX4pseIlSdg4JZCjQb6hJTtDKw0tY8bNIIdVKlYB0Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQfsfFR1uR5LJMRTedG9Y/QiTOww4BuVVfHiHV6HoNUjfAfczA8yg/LzZocCeMO88G4z3GgcOyz7JlVpmspa9n1E2Ca0zRA1WQ1QB2Jn7YxXYkShBduN2xddmAfBhmouzipY9zbN9f++vGADfnLZTEDSEc/3xCgLISHFBxFr56E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U8/z/BIu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0cnEVchf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U8/z/BIu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0cnEVchf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C933EC0313;
	Tue,  3 Mar 2026 10:00:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 03 Mar 2026 10:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550033;
	 x=1772636433; bh=tovveTyn9AjpDq4gxtjcxURqXdJoy9fVxey6YLN3g14=; b=
	U8/z/BIuGkvBz61M0cVA/yhc7iuIP4DDxJVW/xJb3mnWBbCoIynK+tCOqW4sTTeP
	ALlKd4KyVKl+QPQk0TZg+f3jqCqxL20mweR3A/zUclehqzbBZZ9WAcp7EYixk13S
	EAHtnrak4EPVGeUWx+00O28TLvwfrR2nCCc0S0wEeLIsOEfwTaZfgLpaGIS1YI1q
	WZwKh6bbOSwLMH6uYHpT4rh6L9U6xf8EO/bIyFHdrwAPmdIbpkeYb6kXFlHCzL1/
	S9jVu8Z/u2ia6A/lqkx7pVc01vCoaUEv/S/OysZkXsO0yIVgzR9DApWwJRNksiSe
	Leql5M2VrzjvuKcqS0hrMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550033; x=
	1772636433; bh=tovveTyn9AjpDq4gxtjcxURqXdJoy9fVxey6YLN3g14=; b=0
	cnEVchfpCL66xMOhE+u/cgbTpKoRRqpu+NhcRHoYvIdxrSzhMvT8F4rmUw7whTq8
	hhLCXbjUIX5csMYV4CAOPgR1QVfKOijRHdry38rNxQB1sJ+YInhPrrVgkysyJAns
	ZFCIJq0A/cOj1V3DDWJPRSBu6mjRueIipUPsQLa3BaPkcGvccvv4XreuPluMkVlR
	kZZxfeluudikrOTc8YlUoM6Q7d3vHR62ksNtivVModoLdzRY855TYte8+dZfZahQ
	iOzU3eki8dfNd33dU8YKOk9rc0zqVTLpb+w0YXEM173TQnwmjhBy8XxTb001pI7c
	aV2KiIqa1BqIVijyvpXlA==
X-ME-Sender: <xms:kfemabOQa3onYErfKKlal_rZkk1gbZqk4m-lDrZYiToYL7LVBwDg9A>
    <xme:kfemac8uAMaJnRG4FCPdwPXCasSRQA643YWYMMCxGxA7886BOsZlH-3b-j4ngf2SY
    mAtUxRWu84cV0x_cFA8GIYXcI3FT4cy3G9rkFEAPs__hixHfqxD4jM>
X-ME-Received: <xmr:kfemafT1345QEJBcNQbOPpXgMUU0EG5c-4I85eCkVrIFm_I5ZFJPE6v3O5wbiKUiJ6eqzA2UYVq3PokOMpXhBq1--GB-L8fRRZqlgFk2qiH7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomh
X-ME-Proxy: <xmx:kfemaen-ZDqhCmVkz8s1yJKVkvhBCKzJXCYC3DmoidMTK0Y1zLMpZg>
    <xmx:kfemafQUE1RgvNnqrSoFlUgWDIilEcarElRq1TRNdbl-ltHrvi3Y7w>
    <xmx:kfemacNxeSiTTmFdKGVPAQfxfHUQTgOCZACUeLJN7bXW4bVoSo2Yng>
    <xmx:kfemaYW1mdmicu5L7Z2Mxtod1MlUktjiBH2W13wor7TW-BCs7CPzaw>
    <xmx:kfemaUoUlxEBwzX2L87iqkEtaaFtzzUsNvFBHwzuOBmkhOu7J_8GmmaV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fca75961 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Mar 2026 16:00:16 +0100
Subject: [PATCH v2 01/10] upload-pack: fix debug statement when flushing
 packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pks-upload-pack-write-contention-v2-1-7321830f08fe@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

When git-upload-pack(1) writes packfile data to the client we have some
logic in place that buffers some partial lines. When that buffer still
contains data after git-pack-objects(1) has finished we flush the buffer
so that all remaining bytes are sent out.

Curiously, when we do so we also print the string "flushed." to stderr.
This statement has been introduced in b1c71b7281 (upload-pack: avoid
sending an incomplete pack upon failure, 2006-06-20), so quite a while
ago. What's interesting though is that stderr is typically spliced
through to the client-side, and consequently the client would see this
message. Munging the way how we do the caching indeed confirms this:

  $ git clone file:///home/pks/Development/linux/
  Cloning into bare repository 'linux.git'...
  remote: Enumerating objects: 12980346, done.
  remote: Counting objects: 100% (131820/131820), done.
  remote: Compressing objects: 100% (50290/50290), done.
  remote: Total 12980346 (delta 96319), reused 104500 (delta 81217), pack-reused 12848526 (from 1)
  Receiving objects: 100% (12980346/12980346), 3.23 GiB | 57.44 MiB/s, done.
  flushed.
  Resolving deltas: 100% (10676718/10676718), done.

It's quite clear that this string shouldn't ever be visible to the
client, so it rather feels like this is a left-over debug statement. The
menitoned commit doesn't mention this line, either.

Remove the debug output to prepare for a change in how we do the
buffering in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2d2b70cbf2..c2643c0295 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -457,11 +457,9 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	}
 
 	/* flush the data */
-	if (output_state->used > 0) {
+	if (output_state->used > 0)
 		send_client_data(1, output_state->buffer, output_state->used,
 				 pack_data->use_sideband);
-		fprintf(stderr, "flushed.\n");
-	}
 	free(output_state);
 	if (pack_data->use_sideband)
 		packet_flush(1);

-- 
2.53.0.697.g625c4fb2da.dirty

