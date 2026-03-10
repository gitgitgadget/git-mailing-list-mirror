Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916CD391E73
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149114; cv=none; b=aOROP7vsvGWX8uSB+3jadKHCsGvMOrHe/bKx9qDQAhKtn6IbX49U3D8dkJ7SA9e/EjCa53IKEkNjf0LzusySUfBVtG6wEe5C6fSifhNBSFjwGvsU+RGEe0+4nZlu3DTS+nryoTQA2gmiGdxPClGqvuBpj3xxotAKTXC02z4CjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149114; c=relaxed/simple;
	bh=N6T4w57oXDdgjx5NaPsKziU9zhR5ErNpMErRGhxaTIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vCz3gFcSLv453n6IRGYLkLlr5bwcb0IViRNWd5/lvDLYAp5hhzTSWBmzHONciomBJMpQvjv8h7q2l8vQal0hT9A5RZopeTTybX6f7SiwBsU/HF43XG3Zm+rn/7ssXaoJwCYC+hzj0q8ccctJDlazdzWOvXnBcvS0wj8kLYmIf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hLzdKr8A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obJXVDJy; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hLzdKr8A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obJXVDJy"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E11B7EC0B07;
	Tue, 10 Mar 2026 09:25:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 10 Mar 2026 09:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149111;
	 x=1773235511; bh=xTQYyUI87L5+8i3sL/i1lsh5fAp3JF7fjlChDdHLXEY=; b=
	hLzdKr8ADKCg7rXaUJXhZWMH+eplHXgvF8QcGuv3A6DGNYKqU2jBiR7dLo0Xss9u
	ndWbjWURjHHbABgnuT0UrW5fHEJJCNBB0xCTgkmNnCvFK5AafMQj9xRVV5TCNITn
	gbMOw6Ab0U5qxf+aGDFp4zxgqxZPZQbxVZ9mPERuoX9Ihc+kD/zIXwSC5y11HBiP
	0JB2tb5a7f6BEetxBgGC+mmMhMokRyr/Y0FkZFV19JrvSojv2UYVSppArDmN30QT
	ptyhQHjr3jZ8yRSEqseKejvLtCtpWyGvP4iSFoEcxIfxwRE/14wehCV9zdjlyfDY
	PPR53+eqSKAO4DesslE19Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149111; x=
	1773235511; bh=xTQYyUI87L5+8i3sL/i1lsh5fAp3JF7fjlChDdHLXEY=; b=o
	bJXVDJy3wJN5EmyJ5gv7BbJFtUa29ivNEW7HIiF2OABdHIeZLL59wPjfBRjyJrrh
	38sJ1PMbgjpPwAsYJL4mLqFKZ3FJc4Sro4V+IaZ7ixPVTUGrHJGvl+KGQKC1jTim
	OUG/CSaHl28NTbso1pYvYm6bre2/b4NY6znCeMUAB9GJHW94Fy23kN5b3Ol7xRqb
	du88/DzyPd+igFfkI4pDy1scaTh24a1BwSFDjdss25NhgBZfrP6EEh1yLJE9r/lZ
	msVTmifvbs6lESNvVMAE541PZbfKrOKSHrDQBbSrc5OaWrqRUZILYrq0XNvt85BU
	1irEeuAsVF6IjSbHQgiJw==
X-ME-Sender: <xms:txuwadmI8Wowgp4vKKqHOPEIKBrFjxm_HYWRbdAzb_CwebJG0M37OA>
    <xme:txuwafsgA_urOm5iBnr6wUdVdcdc_anDssZTRRPqShqta-yMFnDujYM-SRW-PeWPB
    UszEacSlCu-B7m9TJWPQwoiaAyUieGfjczgcJ7e1XhvkBvWOhgWlWk>
X-ME-Received: <xmr:txuwab8fbWT-mun5Bu-b0aYryBtB1zVM5-t5mG7F1uFe0_mPsVaAgjC8I15aAUfGqFKvtS5H1m75kTIkyRDxD3b-BPjj7UEjDYpKHrcW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehmshhmihhlvgihsehgihhtlhgrsgdrtghomh
X-ME-Proxy: <xmx:txuwaZNIsTjxj12Psqo3OaC0LHBIA169MFbhKl6Dx01nzJVJnNYDhg>
    <xmx:txuwaZG1SQG8ewiI931pmCYIXtOcNlyancLmtlx4iZGDQcXnqfEw8g>
    <xmx:txuwaXTuKunyFky3GKJeShWQSnhV2pDyZy1FYSWfatnMY0YuQNzH9g>
    <xmx:txuwaWsHrZoC2PyjQ7z_xRNPmucY7YXAyTI7I8tY2_Y9kKat0YBkhw>
    <xmx:txuwabsvCCQ2OPZnyuv3L3oFSEfe6EcuRmG3Uid_8ThWCP1Hv_YNGLOH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 198569f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 14:24:58 +0100
Subject: [PATCH v3 02/10] upload-pack: adapt keepalives based on buffering
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-pks-upload-pack-write-contention-v3-2-8bc97aa3e267@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
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
2.53.0.880.g73c4285caa.dirty

