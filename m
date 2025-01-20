Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9651EBFFB
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389856; cv=none; b=fAA8McBYYvX5RQgFbZfWZN8LOOh5PCJAPWfu8LfDAi4WLPVeRkL3hH/TSo2WjDx2gF9qc18Qp1ctvusJB3xg79chcsPDbxbZrPsOI5ctAMuQ7HUdYSPklXvPFQ4Csr+welNfbCu0NmDT1sp1ixuUl9rSY+36HEoHHqO5U7JOKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389856; c=relaxed/simple;
	bh=nBUxtOxKd0EfM1G+CRxpU2GEzZsrsi0Bgm6oxsKJr1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PSvNFvXtuHmRI0hXbxcD6Qre/ndlTvC0jUXcNmKp/56D3qjGifC/HIE/lxuQFataVAouIY7yuwST6pBOTOnky+AbObf0uJoy+4ugBsrygbu1RZgPql//Ub0g4BvxdkUuQHtrFmiWvqyeFUIdokQZZtt1v76vUKsU9uJ6DyyssFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ixrd2HmM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NGEeZ7xY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ixrd2HmM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NGEeZ7xY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E4D713808BA;
	Mon, 20 Jan 2025 11:17:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 20 Jan 2025 11:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389854;
	 x=1737476254; bh=1xWD3eB/nwup8Owfvd6kqssEp1hg7DkY3fBeE09Z0Js=; b=
	ixrd2HmMtpR5NdvALkrLQWe7gbOrBEwANAY+dl+IbJbdsCbRIk/Kks3+tCiZR5kB
	uRiaaJUSeIBzOBBdbsGQb6kYZO1l610tYmxPLg+YzWCW4xN1qG06/f4Tqt7Zlb9R
	X3EMrvtliTdDhIhqk2TIRTKvHsWgaxp5bo+fhAWtijOFs+fGUKDrjX7fiuv6drIN
	vG8bOAPquNBCZGk8hlUnnylPvDHuS+8C56tFFEAu4CilGt0iYif32ojdkxLptw+n
	FQNb6ON8Q8p4iyAy9wyHht9HlULy8/jy59bUNRPXYPQKhwvSiTJ9TrSIh1C0Z3oB
	E9ipGiR6ScaYqE8LQsMQTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389854; x=
	1737476254; bh=1xWD3eB/nwup8Owfvd6kqssEp1hg7DkY3fBeE09Z0Js=; b=N
	GEeZ7xY81HMp+BPEEYEkesvFqZyqlrClX6x5J9WYaf0CbXmCe/1cJX3tUelJgGrZ
	SDB9/4X2iLpGoz80wCj5Pjbc5gYnIxrUYcoVPmua8ec9VQe8CbVWqruXQvwDQ7dA
	2YzJdmY6opZyvjmbz2lpMGBbWmqkhOdLf3fIxJmK8+w0kXZzd+FRLziPT8Pmnbgu
	OkIgvrVNmQrIwYpTusbyISnVLRonMCli8Yo5SVNnmmXGCpDZ4u8DrP1Az64ffTlB
	LeF+etsr72BxdhF+eoZ8pYSqOnCunmcovPGbGOUgMP9anjScdOLspi+GeuqfncPd
	LZtAts8wG+AVj27xkzCFw==
X-ME-Sender: <xms:HneOZ7JOItsN4ft7nH9TANm3ckC4iLxS2eHTEQEm2oQU4kM89RQt_A>
    <xme:HneOZ_KJXVDMeIoNYVaCAR8rzNmDCukbTDCLeRnmCsdiYc2lCJGlDZJyzKnF3_Sw6
    pXrW7B7fmxxy8XXgg>
X-ME-Received: <xmr:HneOZzuAO0BcmYgYiFYGbhl909EDWjH83oA3IpJXt4rkRq6yi_dqd8bYbL8AF7kaF0LU7O5dOwwDJJtBpC45e-qJFBLNvvyJ2J6LRAcQyCJPcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HneOZ0YH0nMSQATzjBoi4TIRhb78TqRWBFfSXxraMfRXv84q9lTAwA>
    <xmx:HneOZybBwadIPb9HiFPv8W034jwqG-PRUyJS07pbNL3-y89169Jj4A>
    <xmx:HneOZ4D99QRJAJwFgnLuCJpkQyll4xu9qD6d-Je8zpqf6lZPknQEdg>
    <xmx:HneOZwaBG0MQ_ka-McIcGhf7TMCeQ6nFIHCYGLMUZVrJ4CKBHQ2gTQ>
    <xmx:HneOZxmNOTge88Tz5gnEb-3MnmZil4P6F3jBokcU5tyixL8zIajaKgfY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 13511027 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 17:17:28 +0100
Subject: [PATCH v2 10/10] reftable: address trivial -Wsign-compare warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-10-b4566d02e4a5@pks.im>
References: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
In-Reply-To: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Address the last couple of trivial -Wsign-compare warnings in the
reftable library and remove the DISABLE_SIGN_COMPARE_WARNINGS macro that
we have in "reftable/system.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c |  7 ++-----
 reftable/stack.c  | 12 +++++-------
 reftable/system.h |  2 --
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index f7766a32ef..8919df8a4d 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -126,7 +126,7 @@ static int decode_string(struct reftable_buf *dest, struct string_view in)
 static int encode_string(const char *str, struct string_view s)
 {
 	struct string_view start = s;
-	int l = strlen(str);
+	size_t l = strlen(str);
 	int n = put_var_int(&s, l);
 	if (n < 0)
 		return -1;
@@ -565,7 +565,6 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 	uint64_t count = val_type;
 	int n = 0;
 	uint64_t last;
-	int j;
 
 	reftable_obj_record_release(r);
 
@@ -600,8 +599,7 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 	string_view_consume(&in, n);
 
 	last = r->offsets[0];
-	j = 1;
-	while (j < count) {
+	for (uint64_t j = 1; j < count; j++) {
 		uint64_t delta = 0;
 		int n = get_var_int(&delta, &in);
 		if (n < 0) {
@@ -610,7 +608,6 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 		string_view_consume(&in, n);
 
 		last = r->offsets[j] = (delta + last);
-		j++;
 	}
 	return start.len - in.len;
 }
diff --git a/reftable/stack.c b/reftable/stack.c
index 531660a49f..5c0d6273a7 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -220,9 +220,9 @@ void reftable_stack_destroy(struct reftable_stack *st)
 	}
 
 	if (st->readers) {
-		int i = 0;
 		struct reftable_buf filename = REFTABLE_BUF_INIT;
-		for (i = 0; i < st->readers_len; i++) {
+
+		for (size_t i = 0; i < st->readers_len; i++) {
 			const char *name = reader_name(st->readers[i]);
 			int try_unlinking = 1;
 
@@ -238,6 +238,7 @@ void reftable_stack_destroy(struct reftable_stack *st)
 				unlink(filename.buf);
 			}
 		}
+
 		reftable_buf_release(&filename);
 		st->readers_len = 0;
 		REFTABLE_FREE_AND_NULL(st->readers);
@@ -568,7 +569,6 @@ static int stack_uptodate(struct reftable_stack *st)
 {
 	char **names = NULL;
 	int err;
-	int i = 0;
 
 	/*
 	 * When we have cached stat information available then we use it to
@@ -608,7 +608,7 @@ static int stack_uptodate(struct reftable_stack *st)
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < st->readers_len; i++) {
+	for (size_t i = 0; i < st->readers_len; i++) {
 		if (!names[i]) {
 			err = 1;
 			goto done;
@@ -1767,14 +1767,12 @@ static int reftable_stack_clean_locked(struct reftable_stack *st)
 	}
 
 	while ((d = readdir(dir))) {
-		int i = 0;
 		int found = 0;
 		if (!is_table_name(d->d_name))
 			continue;
 
-		for (i = 0; !found && i < st->readers_len; i++) {
+		for (size_t i = 0; !found && i < st->readers_len; i++)
 			found = !strcmp(reader_name(st->readers[i]), d->d_name);
-		}
 		if (found)
 			continue;
 
diff --git a/reftable/system.h b/reftable/system.h
index 5274eca1d0..7d5f803eeb 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -11,8 +11,6 @@ license that can be found in the LICENSE file or at
 
 /* This header glues the reftable library to the rest of Git */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 
 /*

-- 
2.48.0.257.gd3603152ad.dirty

