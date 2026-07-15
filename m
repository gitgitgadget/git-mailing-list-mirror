Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F6322C73
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096564; cv=none; b=PMXaqvAbQGCk4+sz2lTQZFACV/ZF/z4Xob0rVSvKq4C5rn8f5Z5Sc9F0izJuoH2CZPDw3Mu93jH0mygFnkN9wepWTzMra+rtbVdjS5u//v5Gw/pNGI87XEJYVcG6RpOdZH7OPu6Z6pz6q2GJKa/epRjRw1qOlspOEvJGMRwou1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096564; c=relaxed/simple;
	bh=/hMSysPlI8knV3KeQJ0AcPKsr8dChrKP2cVFd0LS5sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNKGQLu0vRwM15kgaFsVWjz7qxfmLCApZRL0x/mM+5L2c99yfBkrJjbJu4K5sNpw/DFZnliZ9arMjLy+YLsvJlVsqmMKLnBjPytLkC4lpP/COGtw4wy+iEdnYAywOH8uk2q5U7S6JKQX277dAlyS/ijqzTt9Y0qJOZIgy4ZWtb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jk6wZGvh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EWDWxAeH; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jk6wZGvh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EWDWxAeH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CB8011D00015;
	Wed, 15 Jul 2026 02:22:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 15 Jul 2026 02:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784096561;
	 x=1784182961; bh=u/KYJs4R6UmAlSxz1SZtqf9XD2+tbp6s9JuW/cdNqvA=; b=
	jk6wZGvhcK3HynO9+4+rw6Oa4CbEW1te0cv8Fx3dbUg4zU2mhgvjPYMwwANc/nZ0
	iakpVvIx0tO7h0g4xEs55DlcWDjwxD1lBehJPOR9kYSU4XznajuYMMg5vN19was/
	Y98Dq5szkBTMLYkU9f63q7ksHLA7HW9CKK/qDKyaULTxJGmyEO/4CRSAJH8GQ87j
	HmogcTmt0I/4gOWvEP8yFdvCJBfY2CcBExpdeiXarJsxiklKfoYRh46bKsEpaTCU
	D8PmOZerhQOor51rhvWpO0cdMXeJWx1ghb/83v5lEfSgIADwaG/SKFDgYVpZ/2Ig
	v3YZgNgQJFQsE4uAHHjzlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096561; x=
	1784182961; bh=u/KYJs4R6UmAlSxz1SZtqf9XD2+tbp6s9JuW/cdNqvA=; b=E
	WDWxAeHXqqLYOggsHu6AtJdpziThAXy5Z6+OG/iQAqtBT06im61/o6ER0O4NzF3o
	DPqcKNUPLqdiH6BEjIEn5N4iT7R98rMZ59O+ufC+v7q0DdZo+ze1pZvzAW8EF77w
	hwNwEOYYk4y0Q91D24S/lap9aRoGtI5YqqBNjri6JxojPIWZ5guyEWaeUOqOSUH4
	lU6/zriSq+8y7S7qxDXBBbnuKfZwx8vJh5OWcnEOUL31efRjUdt7VGEzzf+VkyAR
	A2mosXfys7tcDuU1ZT7TDDrE+m11XHxrb0a9a9ekIEczL9KviggtPJHGLTw0cPtf
	zouAGMUmUGk50diYKuBGA==
X-ME-Sender: <xms:MSdXam-0yeX-aCVtUvrfz02cQH5KKp1e7rNSuUwfQxBnAsEee4sbbA>
    <xme:MSdXaqbOwp6gHgxZK4yHWD019rgyKffVm_m6kr4q2XCZDtMLKsRchxhx3u5_amZHM
    Wn_a0Dc2PRUgYPBPc00zedeOIlgsRDM0swzkBcf43pXP2jXAlAYJw>
X-ME-Received: <xmr:MSdXal17Zly835pqQFLjUJ3Ok2Ho_zvp727v1m3m3QQV7WFKx86t7gCmuTggifI6GidvwUlA7S8yHgD7lq1OCJ6FJhJ9uewdFuoqmi_C_mk>
X-ME-Proxy-Cause: dmFkZTFE+YB/+tAuPzC/TvjlXEPq4aubpa6Ljtxm2DA3nhwEKViS4QAXVCAGF2wRqpD2tG
    rjqCj7yrsh2K3uZv6BicpW5yYVDxtAn+hMsT9FU7TKtbZqakq4uWROhTjl1al8fUmioom/
    gefFG9Bba9YcV+ffziVUcMJmrNrrzA1KCy4PmFtbw9vUYPLeSjOeBKQy1qWCBKQ/50XXpB
    m/31leo7PRkC9756xsv1BKVgX6QCG7e5YYGSgPuf8wI3G3bR95XgOr9DD596qSCfzNLZcs
    S4vIMLLbl/r0AJQpYarwXHNGipYH7Jk4IaGmmUxih8kNXIrTailxiil1zVP+0fyXZKWzT6
    ISjwfdPqn/v7cUqVnWOI5NqcF2pLNUyljtn/PPZ7G4klMJIyXmVL1Wv7Ckp3n3LLwE6/7F
    FW7ULTaatZe/TUKCGvB0SwYll+8EdQ9lpckDUIVbXRKa7chPwA+sFmrslkQx7vW0yu3sMS
    7M+aKDIAFINqOuh1l/z9Mun39Uz04A6cVcIZGWnbc/msqmrsul9ujEcJhjuPvGKME55h8m
    s22Bpm4+Xve7llv7AhWxBGh9ESQS32uh+YzCwRNFtGrsNtlMNBZwoqZqqOtSBL07KrJYlz
    EDS5gNEnMj8cRd/xIXvScUITBI+eEw1r0ituYpW36QhwYTqMC4qyZ1VDai/Q
X-ME-Proxy: <xmx:MSdXalaEIa5JdkZ7GyAqruIl2kY5hVY26xaIIGT7sY3soO9iGxEzVw>
    <xmx:MSdXatJr6DpKnJIMDYkG794gkRZOfjpT4VTmgwLRwUkICiMv2O0JNg>
    <xmx:MSdXakGznPbTJ1yIOkEjn5G6kkCFDy5FI8OvQWZgS_Y7ohs8zGrzhw>
    <xmx:MSdXaksvuXVO13BnEfufr_rUOLP-nE0l-ZggKwmVtM6et_BnM75CDQ>
    <xmx:MSdXal0YvLoM5WWKnHS_7PW6b7r5l1CQuD5n1yeaip2MW77ynTSzlPDI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d159eef5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 08:22:31 +0200
Subject: [PATCH v4 1/9] odb/source-packed: improve lookup when enumerating
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-odb-for-each-object-filter-v4-1-616d7adf7fb7@pks.im>
References: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
In-Reply-To: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When iterating through objects of a packed source that have a specific
prefix we do so via two different methods:

  - When a multi-pack index is available we use that one to efficiently
    loop through all objects.

  - We then loop through all packfiles that aren't covered by a
    multi-pack index.

Regardless of which mechanism we use, we then iterate through all the
objects indexed by the respective data structure. Curiously though,
while we use the indices for enumerating the objects, we completely
ignore it for the actual object lookup. Instead, we call into the
generic `odb_source_read_object_info()` function, which will itself
consult the indices to figure out where the object in question even
lives.

This has two consequences:

  - It's inefficient, as we basically have to figure out the position of
    the object a second time.

  - It's subtly wrong, as it may now happen that a specific object will
    be looked up via a different pack in case it exists multiple times.
    This is unlikely to have any real-world consequences, but it's still
    the wrong thing to do.

Fix the issue by using `packed_object_info()` directly. While at it,
rename the `store` variable to `source`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0edea5356d..9cfa02b7a2 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -143,7 +143,7 @@ static bool should_exclude_pack(struct packed_git *p, enum odb_for_each_object_f
 }
 
 static int for_each_prefixed_object_in_midx(
-	struct odb_source_packed *store,
+	struct odb_source_packed *source,
 	struct multi_pack_index *m,
 	const struct odb_for_each_object_options *opts,
 	struct odb_source_packed_for_each_object_wrapper_data *data)
@@ -170,6 +170,7 @@ static int for_each_prefixed_object_in_midx(
 		 */
 		for (i = first; i < num; i++) {
 			const struct object_id *current = NULL;
+			struct packed_git *pack;
 			struct object_id oid;
 
 			current = nth_midxed_object_oid(&oid, m, i);
@@ -177,9 +178,8 @@ static int for_each_prefixed_object_in_midx(
 			if (!match_hash(len, opts->prefix->hash, current->hash))
 				break;
 
-			if (opts->flags) {
+			if (opts->flags || data->request) {
 				uint32_t pack_id = nth_midxed_pack_int_id(m, i);
-				struct packed_git *pack;
 
 				if (prepare_midx_pack(m, pack_id)) {
 					pack_errors = true;
@@ -193,9 +193,9 @@ static int for_each_prefixed_object_in_midx(
 
 			if (data->request) {
 				struct object_info oi = *data->request;
+				off_t offset = nth_midxed_offset(m, i);
 
-				ret = odb_source_read_object_info(&store->base, current,
-								  &oi, 0);
+				ret = packed_object_info(source, pack, offset, &oi);
 				if (ret)
 					goto out;
 
@@ -219,7 +219,7 @@ static int for_each_prefixed_object_in_midx(
 }
 
 static int for_each_prefixed_object_in_pack(
-	struct odb_source_packed *store,
+	struct odb_source_packed *source,
 	struct packed_git *p,
 	const struct odb_for_each_object_options *opts,
 	struct odb_source_packed_for_each_object_wrapper_data *data)
@@ -246,8 +246,9 @@ static int for_each_prefixed_object_in_pack(
 
 		if (data->request) {
 			struct object_info oi = *data->request;
+			off_t offset = nth_packed_object_offset(p, i);
 
-			ret = odb_source_read_object_info(&store->base, &oid, &oi, 0);
+			ret = packed_object_info(source, p, offset, &oi);
 			if (ret)
 				goto out;
 

-- 
2.55.0.313.g8d093f411d.dirty

