Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF435F608
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550038; cv=none; b=A6dPjY2ugZex8B78M5kJwgc4gOw+/Hyf3SwMa/V7OQmEsMCQIT7DCUV67dR7Es5uWzaKyYOQwGQHEwvjBo6rnDpZm/J6cGxF6G4RDV7Ho74EhHmFe2Y7OZ+BkPXd4FbGE+D3rZmK/c1Ms+t+Gsk1vz4f/J8kCec8cp1kl7vo8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550038; c=relaxed/simple;
	bh=koIg7rsR1I0VRs+OZfxaO5eJG4GqE0x6wWHzmNcOphA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQiZ84Afq3ZppxXxdNF+xI5SWiLItl4nhChofE5RQKp4LaJRDPDELR4xTQsUcb3KnH9Dbp1+Sb8WrqagULZhSoski8vKcNpbhr/AFSeMEJzO2LQpLV/7D2PlDQJzccdgZR2xUg1YQOMa6DqbUQ4zfilVEfQcAD6lL8jNn6ts54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N4DngiQa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JaVSd70C; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N4DngiQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JaVSd70C"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5987CEC0571;
	Tue,  3 Mar 2026 10:00:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 03 Mar 2026 10:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550036;
	 x=1772636436; bh=lcO2IHCIjwGBO5jlI/QI7fGOMVFAwxHDnRf6ZXYjdiA=; b=
	N4DngiQarg5434eXwyx1YS28pvlSGZWJUZjj+LQm7gdG+fI4bveT/nYvKgXy4uBr
	ReumqH3iCG4oV8bStCfcJmG0CenP5O8tLTjavxXvSlMTihRKvF/gM1L20hJxWd37
	c0RikH0inpsuXyMEJR+f3eNl7GL98wSG2eawmJKKITOs3R9GsEqtasN0Ozdr9bhz
	GeqwngNyiu0pAB/uDC6JjCb1l6WszqSBWfXBN7tBiTdLLVEYoqA1W7d5fCst7t66
	3eRedFxi1fhaUiS8tJ6jelz3JK85vAWJgwNZn3LsT92IlagErU3QOuXP7dmYS+7e
	4wjurS+VcDRBNSmsbjIUbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550036; x=
	1772636436; bh=lcO2IHCIjwGBO5jlI/QI7fGOMVFAwxHDnRf6ZXYjdiA=; b=J
	aVSd70C7rpKdQMMA+PUBfc1/rJlushh7kWpeX7FcrIfiRXfhhvlT/UM21U3QRs/e
	maEnVEeGE+1LzveP6xIqWMY1HT2csjMqKrKh7i/+irinK45/cXz9otmyYiFpt5dJ
	IKLOsLWJJZUaMVf1/hrFL22SWQQE8e5QYXJv4kTrrb6ToZpMRiqSSLG9vacbHNf9
	knN1h+IR8mwODimScFJyJrUUhFDdLIGiGl8b3/7F6hm5xGir3dLnfqhtI3a05mDS
	XhN+hwfoAdNnq34MdA50SgCDpD9qqi3iii/FmKjIlhEyYEWVsOUh38/TVW/dRC5N
	+p0DP/zkQgegJ9QePmRNw==
X-ME-Sender: <xms:lPemaeuDbvydxx5vidmupalZL5IUg5XYpav7DrnTA68ZVPMoag4gaQ>
    <xme:lPemaacNZo_70uo2beZQjBueg7s9wW-5bKfn0Y0RmuEfypd9zOsx6HbV3HRQ9YppF
    9fOuLSRyHSHTi8BR3YzxYQ_hcSbiBGfZ3ERT62tmJooPdweF-UG9A>
X-ME-Received: <xmr:lPemaeznlZS52ymE46SPRdHa3LyNAGuNa2YHqVmnpJo0nx1LBcAAnjsLws0mQfDlYZTQaXqmmx1tvrQdmK0eXUO_zvowwavrktVxZySkSxKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomh
X-ME-Proxy: <xmx:lPemaYHV4UB4Jf_JBarSS64WICtSupGs3ByPB2JW0cBG0nGTcZJcMg>
    <xmx:lPemaawDJ-TSIEd_aTTDifKH35cqcJXKTTCW9VS38TPMBP53RR5VxQ>
    <xmx:lPemaRtmDwuA8q0qLjarTNnbyRJVHptj-dD3HkaJMLwIyMh-b6mSdw>
    <xmx:lPemaf3OGZ4vO11eUdA_POvFwI6j2DiHNWhx9wYcf5pSK_oLQT0VZg>
    <xmx:lPemaQKZq3YIW1mADp18LmaNipr5C7jg9sFgrtcIGW6tmaaV30SO9j_W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9467aebb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Mar 2026 16:00:17 +0100
Subject: [PATCH v2 02/10] upload-pack: adapt keepalives based on buffering
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pks-upload-pack-write-contention-v2-2-7321830f08fe@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
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
index c2643c0295..04521e57c9 100644
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
2.53.0.697.g625c4fb2da.dirty

