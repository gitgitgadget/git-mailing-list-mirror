Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649033191BA
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695267; cv=none; b=ntYPKYo7VHhvi2m7P1FYjxNHdd8RMdLlqXExKXhUg94UYhRhzg6cufkbs2ZapZD1fbPJcQMz0Rqq7xdcktV2FkblRfjKsNv9SYPENKIAwcuaUgyzUMJ3KBqhgq/3tPLxNTVLG5gbAP+GA1tvdnf2byCz5KrLFosIggmW695/294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695267; c=relaxed/simple;
	bh=ZAe6kIBvVfal/BgoFncsiygWXoeFXrAKO052l8tLAf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e0vCpBp3kBLuKonxWUSaPxZWq0PupzKmIlb0K7m2lrbmL97QwEfYglSIfkAD7nS/Wra3PdQmWFktCF7Miq1nfDSK/mxhAtdjGKzY5A3SAG4wMuc5YKFgXZ4rNGr4y3dMAPnVqJiWGfGGzV5mOPmuzsAxMB+A18xNcGXBI12cUZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QdPJvQs7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HeYgABVY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QdPJvQs7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HeYgABVY"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B5CB7A00D8;
	Fri, 10 Jul 2026 10:54:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 10 Jul 2026 10:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1783695265; x=1783781665; bh=r+ls8vx7j2
	D7BrOo2ZD4fKh1tHzO1a2X2Dmpky8Q6So=; b=QdPJvQs7sScnwUv+OhLq/AMayH
	HlFGWzGx5yZZzvY93ObvyeAIHgU/EzuvSDqxm/Ho2FUkF0Iwy5YhIQ4AQQtpdykV
	uQOiaJM7VqJ3/VS5jCpY0q9klqHXcu4Vo/vA0k/85uIv6h3dfh6l15rJVnsbQzCt
	n0R7xuU+O576F2B0mn0ZiBVw7MOZXd4/30v+bta7xzjj4F6Sv0WBTWKQbIrZ4Yhw
	a0je1vH9AlWH8NiVjP9+b7AFJ3FUlxkMd3PmeYp651p8+OYS0QzQlNc031XaEst/
	qabtMSdsxvb3ssHC02lVzyy4YFEj/nvQ33GwhV4DK4NlmIhBF/OPvUZZaOFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783695265; x=1783781665; bh=r+ls8vx7j2D7BrOo2ZD4fKh1tHzO
	1a2X2Dmpky8Q6So=; b=HeYgABVYF5/+RVg3FDERXiv38BZEh3RYKbUcvpuQBbfp
	jqq5LBryXjgrIChkL6O29kt7wJv533wHaD6UUgh81p/aH07XnFfoiltRaWhkl4Dn
	L0E9GpRHscdckcP4s9wRfD8mRYgjU3g+cB6bf8epz09tu43rbFTn/ZXN0g0weRRB
	AnarcAxjO5A9fP7x3DKu/Vomu8q/tpDfuSDPBqejnLjKYH4HfM2ujw3nBu3t/0C6
	5V/pr7PQm4SHwOHHBXCi1l7kl/PDazLu5/urfObJRlEsyTqqVGVTRpaB3wdgaepG
	TCA3FKMzXEMrryliNAM6IZWh0pqRQcuKKojl6bvC0w==
X-ME-Sender: <xms:oAdRauSHSbA8IUwLXTf0EJaEe_8AzHSwjEScXq1hK3TuracD78_86Q>
    <xme:oAdRaqx0xIAzmuR8z-QA0XsBgpn9B4qUoJt4M_lFfTnsoqRhpmckbxbpVbjK8Bciu
    ijgG17ysK-7vuGgdBjIkVtRW4s22_ufyRco1SXG2d39U42cWO5c>
X-ME-Received: <xmr:oAdRag1D8njCRZCCCcoKI-UoDoHJnOeajI-bdiEUg1dFJRN4QVw9oJe74UlvJlK8LZOUkZOlxWSwhf0IBmmlM5Pgx4QHYtcHMR4n6LNzBdsyMA>
X-ME-Proxy-Cause: dmFkZTF/vLSFUKHNHujkTDoBZWcJowHtHMI16Ops/Sb/kqqJqp+AbNEfb71WHDMs34Q0dB
    h7t7o1F5oIe1mO6JghbpzscpWUNnbKRI9QgmeJXkRtZbbRuYMkBEgCBmgwAyzHtCL61nDq
    jC8RetO0DP+wsyhW6+338OcFbzytRUbc6b8zVE9oO8WWC2TN/icna/yzOz5e61bNXLN4yL
    lz91BvPv8cbiKKYDOJz81j/ogLkZJrCWUnOBtf4ouvY5LDVCR5+1T9/apxRJ3PVJ0rhux1
    Ox/8y6EvKPM4aI5QfkPlfqvVq0xHgfhKnd2Z+Hp1qNwFuwgmRVEKS3JtEmEs5lAwZdMHnA
    JgN+8qE9BteKAgaaMiqLbcf7DBEJYipusGgjFszGu81AmaXGCdJq0GTMjFL94OkQK5OMbV
    fBXdiY8ua8DpB2Z3M7bZ7LhwccptXOXsqopXSmjafaRTx5pobdv88WbMOPpfbXc8Ww5W8s
    b1MEFyNpT6kYK1tI/oJ+YE/og6Bg7RRtO4itMx1YRQwwJeiRP2I9cvu20kobizsHy2baT9
    Hh6BZwMWhWz1vWpKe4ezp11+noQHfaHqdnZ9wp639i9wLMOMh6qNJ4s16EKhvmMbUtARnv
    mWjsNnGgrz9YCoEHzGHWwHrLe0XEJvDwlOM0Nx2xqWuTFF6e+NVrXJeVYcfQ
X-ME-Proxy: <xmx:oAdRao5IgBalWBOlJ3jAzLS0G-wwWWRT5-Is_D4SsG5xvWSnXYq5Kg>
    <xmx:oAdRajWu94kHCpXbu4Ft0VcQjEyx7UNbr5JJWPvA_ybNNwmTZFGKJw>
    <xmx:oAdRanAYayLhaVPYrPIMFZT7Ur8SZC83isaMiuH6KeyAe45Tjk-V2A>
    <xmx:oAdRai4buQ4ZE3qhdrY0JBNHJylgbzMKJjC10zYk-BisZ8L_Kly8Fw>
    <xmx:oQdRahDF07VvttYJHAF6-RefgZ0C9_NCQ-VW4pugEQ_WcNOsBO7OM09t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 10:54:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id caee5309 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 14:54:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jul 2026 16:54:16 +0200
Subject: [PATCH] object-file: fix closing object stream twice
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pks-odb-stream-double-close-v1-1-d5fa233a37c7@pks.im>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBAG0KuQWTtJi40Gr2Jc9OdDR5GSDhgTw
 t2tunybt5KiCJROzUoFL1HJY4XdNRRvfryCJVVTa9qDOVrD00M5p8A6F/gnp7yEARyHrGDXRRe
 c7/a9sVSHqaCX928/X/7WJdwR529J2/YBeXiFS38AAAA=
X-Change-ID: 20260710-pks-odb-stream-double-close-49c4b4a93f01
To: git@vger.kernel.org
Cc: xuqing yang <rigelyoung@icloud.com>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

In 10a6762719 (object-file: adapt `stream_object_signature()` to take a
stream, 2026-02-23), we have refactored `stream_object_signature()` so
that it doesn't create the stream ad-hoc anymore. Instead, callers are
expected to pass in a stream, which allows them to construct the streams
from different sources.

While the stream was previously managed by `stream_object_signature()`,
the full lifecycle is now owned by the caller. Hence, it's the caller's
responsibility to close the stream, and the called function shouldn't do
that anymore.

And while the mentioned commit did drop one call that closed the stream,
there's a second such call that was missed when reading from the stream
fails. The consequence of this can be a double free of the stream.

Fix the bug by dropping that leftover call to `odb_read_stream_close()`.

Note that it was originally discussed whether this should be treated as
a security vulnerability. But there are only two callers: once via
`parse_object_with_flags()`, and once via `verify_packfile()`. Neither
of these callers plays any role on the transport layer, so this issue is
only relevant for objects that are already available via the local
object database. Furthermore, a packfile that is corrupted in this way
would be detected when receiving the packfile, so it's not easy for an
adversary to plant such a packfile, either. Consequently, we decided
that this is not covered as part of our threat model.

Reported-by: xuqing yang <rigelyoung@icloud.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch fixes a double-free of object streams introduced via
10a6762719 (object-file: adapt `stream_object_signature()` to take a
stream, 2026-02-23). It was reported to the security mailing list, but
because we couldn't find a way to abuse this issue remotely we decided
that the issue can be fixed in the open.

The fix is built on top of v2.54.0, which is where this issue was
introduced. It merges cleanly to "master".

Thanks!

Patrick
---
 object-file.c   |  5 +----
 t/t1450-fsck.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 2acc9522df..610faba5b6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -150,11 +150,8 @@ int stream_object_signature(struct repository *r,
 	for (;;) {
 		char buf[1024 * 16];
 		ssize_t readlen = odb_read_stream_read(st, buf, sizeof(buf));
-
-		if (readlen < 0) {
-			odb_read_stream_close(st);
+		if (readlen < 0)
 			return -1;
-		}
 		if (!readlen)
 			break;
 		git_hash_update(&c, buf, readlen);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 54e81c2636..bc326a78f6 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -538,6 +538,23 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 	test_grep -q "error: hash mismatch $(dirname $new)$(test_oid ff_2)" out
 '
 
+test_expect_success 'rev-list --verify-objects with truncated loose blob' '
+	git init truncated-blob &&
+	(
+		cd truncated-blob &&
+		blob=$(test-tool genrandom one 5k | git hash-object -t blob -w --stdin) &&
+		obj=.git/objects/$(test_oid_to_path $blob) &&
+
+		# Truncate the loose blob such that its header can still be
+		# parsed, but reading the object data fails mid-stream.
+		test_copy_bytes 64 <"$obj" >obj.tmp &&
+		mv obj.tmp "$obj" &&
+
+		test_must_fail git rev-list --verify-objects "$blob" 2>err &&
+		test_grep "hash mismatch" err
+	)
+'
+
 # An actual bit corruption is more likely than swapped commits, but
 # this provides an easy way to have commits which don't match their purported
 # hashes, but which aren't so broken we can't read them at all.

---
base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
change-id: 20260710-pks-odb-stream-double-close-49c4b4a93f01

