Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA833603CD
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384328; cv=none; b=nmVN8bpjMvWQGnyEpPE2KsHFmr6PDBOrKvkkMOelkCwAIj/ABBUnAaHS/riIeTWqx2XpgPSvSPk78S1Y4Jnoo1EOnvE9EaUv5UPiJQoaoK+86NhBJqvKNq47OpnpJOudWdEUivTSKqEeth0iu+8gW4l8IA8QB+DGAlI/JA5Fwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384328; c=relaxed/simple;
	bh=CJd/YtH89c8NPdkS0lm7ncPxyzMy7tgRZ6JU5l9/6cU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOJpcgNWROlwxlVtpJslR83x/f93LxdnUy42QWuu/Jd/Vt449QmYRio1B/onekvVeDgKtKajkYIqL9ZrYGnUpTv4Y6hcy7Q+P06oE95cl3/oCQbnGQ7xIjrEk9GPoI2q3nU+Xe+GMD56/98SpNZgQcXrLox3g+gvbGkwKiWLEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=okjY3a+9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hwYBM/X9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="okjY3a+9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hwYBM/X9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E1CE21D0010D;
	Fri, 13 Mar 2026 02:45:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 02:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384326;
	 x=1773470726; bh=NCHDglmGZZ/ujYXInHdTvZIupg5ltPb5huy4o5VnwvE=; b=
	okjY3a+9DTLlpbchrnfZqUi6x4+NbGbmErMfOg43FrAF5g8Fw/UedSCf+4K9yVcf
	VS7hTKtzOUVu29Cu7zCq33Fg+rPYl9eD0Zt+Qz1m4F5owSSVs+wxz+y+z5+wLMmr
	nFLbuhn6Eh1sEpXUBYZ0Ag8hcJg+PVhbd11RMTQgtBIPTCFZrOo257E2bL+CL1y+
	gQzexzw0PXBFqrIyePbW5nc9BLmhYUL2zB93sp2c5A4UBkP3iVcK0tV16tZvzjWX
	lJPSZoRK9O+3o6lDRtLb7prxeVjTLEbfTCoZMwCpLPxTG34RjhN9Mx3YUtYodAP0
	sqh1osChM4Sn8iMpy6txbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384326; x=
	1773470726; bh=NCHDglmGZZ/ujYXInHdTvZIupg5ltPb5huy4o5VnwvE=; b=h
	wYBM/X9R8E2sKL0kPUBmuix8gh4lq5KFVBJ3gZU865oog/WA4ktWy5ZP+Gvw6CV5
	6FzJc75PSm4atB1k9mbJgkf2q2ihWa90c3SyuE8HZNQkVNKwf++GwrXTBvN8zc1N
	fEplZmeU8+YGsdCLoizeocg+GffeR2ehTvXZGnuy8PinnGs14ik2NO+GvOJnGV/s
	q79IxncmXegyUiV6vDbrnjsHjXPmc44KOVdfPd3guq2s9E4ce0hxW0s79hZNNBtH
	tnnO93q/D5M5mLOjkCLVRsNq1C8/wwMB6n/G1VxbqpJn+xvjnMrtK42MgjKbk8hh
	YqxFUkCZoDGK06XSXBZSQ==
X-ME-Sender: <xms:hrKzaeszBmHm1BAzFUgsGQUItb-AQHn3xGeQiKR-9xekSMJ-iS08uQ>
    <xme:hrKzaaUjGqTpoubU91DoHLRMQd1Jl1Bz1A1ezjIgBBYTH2PiTHA45eewhWNgex5t7
    gvptyrOIv5Fdo8ANfjC9np7-YppYUIa4a-NRjWZV0lXcDmGN_8C>
X-ME-Received: <xmr:hrKzaSH-VfBVJbXXpBuUjZVVBFfvVOUmOWYrzUke0IKGDYeBrhSHko0SqNXpRnDCQugC639-u0bbgJsmoU9fkfj1wvQJBSnAvHo7hiVVuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehmshhmihhlvgihsehgihhtlhgrsgdrtghomh
X-ME-Proxy: <xmx:hrKzaU0E_AC4aLep-IDwy7J_HsJPWHUBEKr168TaE2g_kRPpZHRuNg>
    <xmx:hrKzacO_PMlMNmovdbs08dyy0K1zU5dV6WD3aPTmV8A4w3dRNL4Dyg>
    <xmx:hrKzab4x5ygPVfw0JIagVHoykv5aInSgLjXqB7u-ra6RgD6TWhka2w>
    <xmx:hrKzae0pghYnkffxyLCVs4OM2owl0IbhyAHvzE5DhA8D0rRzbSMUwQ>
    <xmx:hrKzaTUlrnzFO6YOg9_6gJVO1TrOXGSAf3EamK7W4QwHFGn3rLSPV6tK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad60993f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Mar 2026 07:45:13 +0100
Subject: [PATCH v4 02/10] upload-pack: adapt keepalives based on buffering
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pks-upload-pack-write-contention-v4-2-7a9668061f7f@pks.im>
References: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
In-Reply-To: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

The function `create_pack_file()` is responsible for sending the
packfile data to the client of git-upload-pack(1). As generating the
bytes may take significant computing resources we also have a mechanism
in place that optionally sends keepalive pktlines in case we haven't
sent out any data.

The keepalive logic is purely based poll(3p): we pass a timeout to that
syscall, and if the call times out we send out the keepalive pktline.
While reasonable, this logic isn't entirely sufficient: even if the call
to poll(3p) ends because we have received data on any of the file
descriptors we may not necessarily send data to the client.

The most important edge case here happens in `relay_pack_data()`. When
we haven't seen the initial "PACK" signature from git-pack-objects(1)
yet we buffer incoming data. So in the worst case, if each of the bytes
of that signature arrive shortly before the configured keepalive
timeout, then we may not send out any data for a time period that is
(almost) four times as long as the configured timeout.

This edge case is rather unlikely to matter in practice. But in a
subsequent commit we're going to adapt our buffering mechanism to become
more aggressive, which makes it more likely that we don't send any data
for an extended amount of time.

Adapt the logic so that instead of using a fixed timeout on every call
to poll(3p), we instead figure out how much time has passed since the
last-sent data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b3a8561ef5..f6f380a601 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -29,6 +29,7 @@
 #include "commit-graph.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "trace.h"
 #include "write-or-die.h"
 #include "json-writer.h"
 #include "strmap.h"
@@ -218,7 +219,8 @@ struct output_state {
 };
 
 static int relay_pack_data(int pack_objects_out, struct output_state *os,
-			   int use_sideband, int write_packfile_line)
+			   int use_sideband, int write_packfile_line,
+			   bool *did_send_data)
 {
 	/*
 	 * We keep the last byte to ourselves
@@ -232,6 +234,8 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
 	 */
 	ssize_t readsz;
 
+	*did_send_data = false;
+
 	readsz = xread(pack_objects_out, os->buffer + os->used,
 		       sizeof(os->buffer) - os->used);
 	if (readsz < 0) {
@@ -247,6 +251,7 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
 				if (os->packfile_uris_started)
 					packet_delim(1);
 				packet_write_fmt(1, "\1packfile\n");
+				*did_send_data = true;
 			}
 			break;
 		}
@@ -259,6 +264,7 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
 			}
 			*p = '\0';
 			packet_write_fmt(1, "\1%s\n", os->buffer);
+			*did_send_data = true;
 
 			os->used -= p - os->buffer + 1;
 			memmove(os->buffer, p + 1, os->used);
@@ -279,6 +285,7 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
 		os->used = 0;
 	}
 
+	*did_send_data = true;
 	return readsz;
 }
 
@@ -290,6 +297,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	char progress[128];
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
+	uint64_t last_sent_ms = 0;
 	ssize_t sz;
 	int i;
 	FILE *pipe_fd;
@@ -365,10 +373,14 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	 */
 
 	while (1) {
+		uint64_t now_ms = getnanotime() / 1000000;
 		struct pollfd pfd[2];
-		int pe, pu, pollsize, polltimeout;
+		int pe, pu, pollsize, polltimeout_ms;
 		int ret;
 
+		if (!last_sent_ms)
+			last_sent_ms = now_ms;
+
 		reset_timeout(pack_data->timeout);
 
 		pollsize = 0;
@@ -390,11 +402,21 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		if (!pollsize)
 			break;
 
-		polltimeout = pack_data->keepalive < 0
-			? -1
-			: 1000 * pack_data->keepalive;
+		if (pack_data->keepalive < 0) {
+			polltimeout_ms = -1;
+		} else {
+			/*
+			 * The polling timeout needs to be adjusted based on
+			 * the time we have sent our last package. The longer
+			 * it's been in the past, the shorter the timeout
+			 * becomes until we eventually don't block at all.
+			 */
+			polltimeout_ms = 1000 * pack_data->keepalive - (now_ms - last_sent_ms);
+			if (polltimeout_ms < 0)
+				polltimeout_ms = 0;
+		}
 
-		ret = poll(pfd, pollsize, polltimeout);
+		ret = poll(pfd, pollsize, polltimeout_ms);
 
 		if (ret < 0) {
 			if (errno != EINTR) {
@@ -403,16 +425,18 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 			}
 			continue;
 		}
+
 		if (0 <= pe && (pfd[pe].revents & (POLLIN|POLLHUP))) {
 			/* Status ready; we ship that in the side-band
 			 * or dump to the standard error.
 			 */
 			sz = xread(pack_objects.err, progress,
 				  sizeof(progress));
-			if (0 < sz)
+			if (0 < sz) {
 				send_client_data(2, progress, sz,
 						 pack_data->use_sideband);
-			else if (sz == 0) {
+				last_sent_ms = now_ms;
+			} else if (sz == 0) {
 				close(pack_objects.err);
 				pack_objects.err = -1;
 			}
@@ -421,11 +445,14 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 			/* give priority to status messages */
 			continue;
 		}
+
 		if (0 <= pu && (pfd[pu].revents & (POLLIN|POLLHUP))) {
+			bool did_send_data;
 			int result = relay_pack_data(pack_objects.out,
 						     output_state,
 						     pack_data->use_sideband,
-						     !!uri_protocols);
+						     !!uri_protocols,
+						     &did_send_data);
 
 			if (result == 0) {
 				close(pack_objects.out);
@@ -433,6 +460,9 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 			} else if (result < 0) {
 				goto fail;
 			}
+
+			if (did_send_data)
+				last_sent_ms = now_ms;
 		}
 
 		/*
@@ -448,6 +478,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		if (!ret && pack_data->use_sideband) {
 			static const char buf[] = "0005\1";
 			write_or_die(1, buf, 5);
+			last_sent_ms = now_ms;
 		}
 	}
 

-- 
2.53.0.904.g2727be2e99.dirty

