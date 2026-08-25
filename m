Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D547ECFD
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668219; cv=none; b=CjiPTHcWAFxbqwxb87w1WKRi/7sPmOp+mFM4Ws4thIHibWaW1gGxlES5YqpVLizD3jnV4+FLu/b2ARcnRAzUbkFY+E8bu1j0iryKlNSNq0d/HbOlcR2KQJYzPmmmEVU7Xsq8vVXLpZI5cMAaNYXXvliP/mThazSA9W8h0umhTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668219; c=relaxed/simple;
	bh=Fi64fjQ9+ezxl4wCx8vVDWJiOnLcywSv3gY2wdPy7ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgSV8hzDiRIEtnuqims+2/hFgxwa/bxL4iyk6ISxoZVGjkC8K2lfQkGRFKUMCY0kH/C6eiJwDK2MNZZyBciQpltkHFZj5GdSd3XUMCe2wZOxIfZ84Akr0CwVJuSFhUs67ahVpR4lCmkDpEasklZ2xPFm7C8g4498RGZSbeGkNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EhZ3vZh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNtR9owA; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EhZ3vZh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNtR9owA"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CD021D00123
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 25 Aug 2026 10:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787668217;
	 x=1787754617; bh=oUnmCgHMeOM/TYoC1dIRBSbIaA6SGWcZ4yXWHyQQC84=; b=
	EhZ3vZh4R6JQe9hF2Ad1NSqyaQ9IviKwzVPzDIvgcMB8qR/Hmr21xr3t5+ob9e2x
	5mvZpLSXbroTtiLyXinG7eZXSkW2lz939S9ngv6ekfKxS8TnBJE0q3PiNtB1+iqz
	KyBPoR0rO8YA5Bavvqw5IrunEVKfhjGHY8GApXAakngDKXSvvvnLE6HjjR2Gznwd
	yaAtaWCJNl09Nfb5EwVKNvST0AXUBP5LOrEi9qU17ZshEoAntI7XDXaWrWLLAsUC
	6dhDZyGhEOoVuBUMSGYqw8PVsWMasw+IU+jkqSi/AHbrKmcNbUdobhueET3YEplH
	o/kD4IRcQ5g44S/mg9dzFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787668217; x=
	1787754617; bh=oUnmCgHMeOM/TYoC1dIRBSbIaA6SGWcZ4yXWHyQQC84=; b=f
	NtR9owAzHxcu/FRIYfc0rKBcN9C4aUo1bNtVLVPtE36D228WcLcBEkgwAssIfgST
	Yo9VnQwcIiDM0yau5sdtZMdBC2bDv++oN+U1zTQmOau9HM9EuHfSSei6d1c6H6ij
	FxspdL3ZVIYDsAv7k5Jub0gLqPNRer1yJOE26LMDcWKI62M1oloxvLqrQoCpJffQ
	6eAhiTiRONhlcM/jE/ofqIRJbL/0UvfJtVgX/4ydVMPxuuSVnPQUlHfJj1/YKeUT
	a6e7k6lyg5SRSYaZT18VhYtrw9TuW28/QesTEuzKtP5WFv9PRG3q24z0GcPBkK6s
	+GyzMt1qCHYrlhtrCx4XA==
X-ME-Sender: <xms:-aaNavOMQN3LNiuGTEKU3rZjJNDtct_qmIo7HCSFQ_hsm-oiUeGbCw>
    <xme:-aaNag5qwoMmiq6djNg4J0RolL8ZmaZ8Ox8cxkhxHT9uCl8Qv-UGBSnXJ2-Nozi5e
    KC4f4Mq8VDQI5oDkMMSbv_PUQFpKDQzfjkup7qqZ0q2fehyg3HrXw>
X-ME-Received: <xmr:-aaNaj4nGirmAbpo83u8B-RoQn0zB1NbpffZ6hzZApNw320btg-q4mHITp8dYR8sPbLRbpNoeXlBaWYqkRi3nULHbYoqZ5CHzUcmt2H6ag>
X-ME-Proxy-Cause: dmFkZTF7di7P9fqeVtKyfLKbViZD7TBnl4srwz5Ve7VQBJmvFG7KMshIDpaCixvYPMRY1h
    MToVw8leZsp6NRTEnNkzR2GbnzhIeSkDMXyz6tF1rPG3WCmPgAfOp7w9ECiJnWNm3qggyf
    pLU70w6A34nyTdJBsTiO7P4+tQsyhOcfD6IbKuN50FcBA4BTbgRys6YYiGRQNZVpKGXBR8
    +Yz6NjycNLVfAEeHhUraj08VjNvG7b1J92ThlgvTW+tWd3AIJZcCqdUSRypwuSKWRIkp/w
    B5AADDwhd0O4ES96La8mcFBQZ+myORW03YyVssffHdRAHA1X5QkXTM5vsOoGZqFrWVlOo6
    ZRexnXOezoh4WClspnPyKfXFMRmVWCxFEYBMjdwQwA3CvRVYs8N5iVKa6OM1+2J//km/oj
    a3etYQYkyMO0a62jpWuTb3BYgjQwMfSFQ9yyWFZmYXFORd/RnO1eC4RHHAoo6hg4SUyoDv
    mfvfFcMfiVHT3fii1lHjGvKSA/K2iI8zo/playTxu6GITbLq7Og2+TC25/JVRYejKM1MIj
    1+EbwT7z4GufUMiUu7AMgJKvxgwVBOJ6rjK7PtkwFnhqJC4FAZj/IZobNjLmjqTxwz/SzJ
    65yrrjV+7BKi8fOOhs640sHcIYF5fZWXVDxzsiXJK7JxjVR9qfetNPGzhNYQ
X-ME-Proxy: <xmx:-aaNao3qAcZiACgyQYYcv4QPGkwVPqMTyno_PLf4UWucgvQsuxFw8A>
    <xmx:-aaNanWBrCjphv_F48iCRW9WSSEBDhfo7nNyfbMBCaqrqkFaXUXmNA>
    <xmx:-aaNar4pSd1k6Ud5Cfq3joCKfzPgOHYqau0PR7yI6SUc_MdW5Taplg>
    <xmx:-aaNamKDzkGN1G-23_IjWyPHnRAXUCNblbpK8Ga6q2hAUMm2rAo-zA>
    <xmx:-aaNaj_3KdSUlwFewz-FDz4SPKSQNfoqIzsIb6IL7fYGQ8j2xDD0lK5b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2dbeefdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:30:03 +0200
Subject: [PATCH 01/10] builtin/fsck: use `fsck_obj_buffer()` when checking
 loose objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-source-fsck-v1-1-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When checking loose objects we manually parse the object buffer we have
read from the on-disk file, mark the object and then call `fsck_obj()`.
Almost the exact same steps are also performed by `fsck_obj_buffer()`.

Stop open-coding this logic and call `fsck_obj_buffer()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 892c5661d9..3c4127f4d8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -722,7 +722,6 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 		      void *cb_data)
 {
 	struct for_each_loose_cb *data = cb_data;
-	struct object *obj;
 	enum object_type type = OBJ_NONE;
 	size_t size;
 	void *contents = NULL;
@@ -751,21 +750,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 	if (!contents && type != OBJ_BLOB)
 		BUG("read_loose_object streamed a non-blob");
 
-	obj = parse_object_buffer(data->repo, oid, type, size,
-				  contents, &eaten);
-
-	if (!obj) {
-		errors_found |= ERROR_OBJECT;
-		error(_("%s: object could not be parsed: %s"),
-		      oid_to_hex(oid), path);
-		if (!eaten)
-			free(contents);
-		return 0; /* keep checking other objects */
-	}
-
-	obj->flags &= ~(REACHABLE | SEEN);
-	obj->flags |= HAS_OBJ;
-	if (fsck_obj(data->repo, obj, contents, size))
+	if (fsck_obj_buffer(oid, type, size, contents, &eaten, data->repo))
 		errors_found |= ERROR_OBJECT;
 
 	if (!eaten)

-- 
2.55.0.822.g20453c30eb.dirty

