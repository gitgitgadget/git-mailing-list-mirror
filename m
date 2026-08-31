Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD43BBFBB
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158788; cv=none; b=ZDAIzsAhDI8aeeHfJI7Kt0a2qCWD4WzEVW7i9iOG5nWvBf/3SBX5fiEqDwk/OwKLdDf0GdD+5CEqmHq3NNmB1ErpMVCVDczqR0BfGTYKIoyzFjgTPw3Fw1kTSpBRm7Kz0LyHT/HGuNCst0QfvdpuE3hDEOWwszVvi6E07uW+iLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158788; c=relaxed/simple;
	bh=moXfeSG1yOuUPFGa7IiZPAder5vTaA8zySzDDJXnYZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfABABDddl0Le7Ur7BdkOuwg1XMxhSUn0Bql55ztU9xTjyrfrtkyJCLBAB3h3cS5WRHkiEKq6cFygqsEEENNEeCLki4dOvUUI/FO43Y8JYHGzK9FgRBS/YgIrf/Efwtuvfo4TzMddtqn/eImG52F0RBepYK810FFK5A2f0GmwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dBTeUklC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ptlb7TGf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dBTeUklC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ptlb7TGf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CEB5F7A015B;
	Mon, 31 Aug 2026 02:46:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 31 Aug 2026 02:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158786;
	 x=1788245186; bh=WCMbjjauvbxcf8Cn+mV+knbaLlK1GBQO4D0RmDf4/h0=; b=
	dBTeUklCAxnvh5oz8Zqjn+QZ6xKVh9mDdtD/eHvHYqgz5zPIL4TwLla3/SnzGiFF
	w5bp2HTWOLz+/Ripc3GHOsbh6yiRaxWOBwdu+zSL/B7sfG0BzL73LmhoyQTR0nXh
	RnBCxINeys16dp8hq4uc+7jH5wsHLjJ61q7l89azL9BnoOM72lV9343KiPqL9JYN
	DGa0VPbYg+JFC79JC7hZdJ9geibl+0MO2Dn14UYoQ+BYASR4d4YQn/QutYhIj55V
	86uE32KyR5+djKyMK9Y4MEloJcaBIkVbOPRuK+pMbkD09HKeIr0QoUFEs7vfKfPP
	NaWFOlEJvhLFSByBryjM5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158786; x=
	1788245186; bh=WCMbjjauvbxcf8Cn+mV+knbaLlK1GBQO4D0RmDf4/h0=; b=P
	tlb7TGfVhYta6tYEOvvv1NfmOg65c1vCgoULbYa93FD82hOWVJ0UiMngLmkePC1a
	TZYSqARZfTJYLccom8UYT0hwyol8XfUiJW/wTDat/qLI6hoJ9k0PX9bzONpfZlwZ
	kNtYnh9KDIRESFLFGxMG0JXl7DsblfbTL7Um0qGD5CQkD0XHBqHOt6tPp4k9NJ9q
	T2z/qZQL2wjD+bQyAmK3VkXCpPN6QQJv37nRG6g0CriIaAK1D2OUn0bP2+bhrFqE
	dS2iZWznBRnXS1f34drOpD3Hj4XVQVZVJ+an9jL3lDLwlnVz9U/KtAlF+LAcQfQ7
	pDYGqL+/iLQczZ0cbE1UQ==
X-ME-Sender: <xms:QiOVap4qiIWsjBukz-SkUlYnS6UoO2VDZKiKaRC8GYJP-Q4wBJUyxQ>
    <xme:QiOVas64f1eB6Q-uOG1Cqdi5d1ih8CpLuzWe-974eOD8bKiYCGYDTqbm1Ju6OwF9a
    u440Rbwb2kxqkA74u2L4lAeCOAM_KX6yl56tPOr9z0EWe0k7d2JRg>
X-ME-Received: <xmr:QiOVauG5mzffklee-MO8bmwgnIfrExO7rjnmOnE1u-QgRkCZjW6hDsZ0QT29uMdMXFyGIA>
X-ME-Proxy-Cause: dmFkZTEYVf0dL7UGrcJrZICBDSB3LjjfPaqozSE//v2Uk+wmrGGsN1vPAxnqAgkLBIQ8YH
    jkGm/0q2QCpTLzGMeN0PR1MeaTkM5EPaoEuoMhHzPGrgkrrahxb2HsmJ1bVk4UiWR43FR+
    opCeq8ZwOupZwyvgFz/5EO1rlWMX9ymY395FZ4JB8b6N4ddSX0Lf/ccWyhtowb9unYs78i
    q65B8tbD9ISvvMC186S9fuYl1A66bWAlIet37pjlPsFSIH2y9YQw83JMBRERaOog6/NRAV
    yj9dTKgCGRxgJt3f7+n8VX5/0i3r6oQenmQAn+SILo/sIBIqcd93oq/gzZ6ziXimOnALU4
    dsaNPmIIk7+AwXC8spD1+snzMeB5jlE7Be3e+e3r+J9Rv0k+a/tOPpDRzU7StJus97rcZ+
    Oz93nkPmbOb6gMB+4TPmXWIeE1TMqu9HHlzInJykLi5wzngR8lGLSRUqmgcF+MHmzFSEsH
    4FslJ7pQqEvu3ajn48mpq9tNwIXqRwi8Z5ooVWeavjRt8rvQozYKEoo/CqdC9wTsp66KQ/
    sJM03h0NrUaGUoHzarW4Oz2GzvZYM9UBtnYamCYcpK+8FvKvkK5QPjdonN/kB3VkOvhoZw
    Pv3zCCvuIJwyOkTxzqIbk5J3j++C9GPpxqEQN3Tdj38KhFyTtwFhSXnDp3Mg
X-ME-Proxy: <xmx:QiOVatSTlDfJqCyyNBGU9xo6K3rz4gt9nDZjvH_K6r9eOuVrLc71dg>
    <xmx:QiOVavvmSTBGYblDrVxIB3YYNOo9in53kI_j0uDS-bnCftG6xcu4WA>
    <xmx:QiOVakzG-CtHH8jPRsFVZJchWQlUgkbwyRAlhea8uRxh-p5mF-PBUA>
    <xmx:QiOVah5pucz1dAuymuyPrI5XmG5lb1bgz85nZRJbMaa9MsVgR8AkXA>
    <xmx:QiOVanofuNvgP65vCvtp1AaJkg_4vWKRd1-6cZnTaFamf-YJuA7C1-vQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cad37c66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 08:46:16 +0200
Subject: [PATCH v2 02/10] builtin/fsck: merge `fsck_obj_buffer()` and
 `fsck_obj()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-source-fsck-v2-2-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The interfaces of the functions `fsck_obj()` and `fsck_obj_buffer()` are
somewhat similar to one another. The only difference between those two
is that `fsck_obj()` takes an already-parsed object as input, whereas
`fsck_obj_buffer()` parses the buffer and then calls `fsck_obj()`.

Furthermore, `fsck_obj()` has no callers other than `fsck_obj_buffer()`.

Refactor the code by merging those two functions. This makes it obvious
which function does what, and it allows us to get rid of the early
return in `fsck_obj()` in case `SEEN` is set as the only caller
unconditionally clears that bit before calling it anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3c4127f4d8..bed8481893 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -401,14 +401,27 @@ static void check_connectivity(struct repository *repo)
 	}
 }
 
-static int fsck_obj(struct repository *repo,
-		    struct object *obj, void *buffer, unsigned long size)
+static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
+			   unsigned long size, void *buffer, int *eaten, void *cb_data)
 {
+	struct repository *repo = cb_data;
+	struct object *obj;
 	int err;
 
-	if (obj->flags & SEEN)
-		return 0;
-	obj->flags |= SEEN;
+	/*
+	 * Note, buffer may be NULL if type is OBJ_BLOB. See
+	 * verify_packfile(), data_valid variable for details.
+	 */
+	obj = parse_object_buffer(repo, oid, type, size, buffer, eaten);
+	if (!obj) {
+		errors_found |= ERROR_OBJECT;
+		err = error(_("%s: object corrupt or missing"),
+			    oid_to_hex(oid));
+		goto out;
+	}
+
+	obj->flags &= ~REACHABLE;
+	obj->flags |= HAS_OBJ | SEEN;
 
 	if (verbose)
 		fprintf_ln(stderr, _("Checking %s %s"),
@@ -417,6 +430,7 @@ static int fsck_obj(struct repository *repo,
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
 		objerror(repo, obj, _("broken links"));
+
 	err = fsck_object(obj, buffer, size, &fsck_obj_options);
 	if (err)
 		goto out;
@@ -442,32 +456,11 @@ static int fsck_obj(struct repository *repo,
 	}
 
 out:
-	if (obj->type == OBJ_TREE)
+	if (obj && obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
 	return err;
 }
 
-static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-			   unsigned long size, void *buffer, int *eaten, void *cb_data)
-{
-	struct repository *repo = cb_data;
-	struct object *obj;
-
-	/*
-	 * Note, buffer may be NULL if type is OBJ_BLOB. See
-	 * verify_packfile(), data_valid variable for details.
-	 */
-	obj = parse_object_buffer(repo, oid, type, size, buffer, eaten);
-	if (!obj) {
-		errors_found |= ERROR_OBJECT;
-		return error(_("%s: object corrupt or missing"),
-			     oid_to_hex(oid));
-	}
-	obj->flags &= ~(REACHABLE | SEEN);
-	obj->flags |= HAS_OBJ;
-	return fsck_obj(repo, obj, buffer, size);
-}
-
 static int default_refs;
 
 static void fsck_handle_reflog_oid(struct repository *repo,

-- 
2.55.0.979.g7e5102b832.dirty

