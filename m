Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5419204F77
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262193; cv=none; b=PvhzHmlOnsK/fZiN4ygIo7YbnfwI2BaVPi2T6tqEQHooZsRc/Emx8rojhEFmnOfsYQYFMBv9mSal3Z/FpHHFKZnTUnVuZRCfafyOeiw4BLgv1scCw2s/bFf5sL56T4U/aVqItNU2BRn/7VA27FxbwjxVXWcUGYjaLPDC0h0+w8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262193; c=relaxed/simple;
	bh=YSPDyeo4ZMIygmSkvwxktap1OJ8GvR/O2BT+VDOn3mA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kvbdEivsuB/oa2WMZRbg8I2tDjZM6cUgAOW7ekkwAs2FV5vmOkrd7/S8AYu5PwkDDTJRNyhf5UM2o4bFX9rgiFcaiudltWSFysO3e8Fhnli9M4BqmPxZhkDAQZ69tYzD0/zdr4keHjQWPdsIjn31xp0QVUa2TL8ZXK986+MfjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iu1FAOnn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iu1FAOnn"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee6eb39edaso5288967a91.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 13:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262191; x=1733866991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwWez5ol7FeBhH6sA5fPARd0zXOEP0zk86+9NV7+9aU=;
        b=iu1FAOnnNwbEMC4SGL5Q50WrVE9EeeYt/d7p7U2dyPCuIotUcm2Ab6sgSTjOwHGiLx
         u75gN3xqqTn9yhRzVe437FfVg5AYVIIOmDMXkQt5BwBfZ+dt/bk7a9VTYDAbvYeCFOVx
         5mtQntAHkQ2T243u4cDlWaeYH+Si+cT09yJLKoJkpw/x0AYssDrHLcWJw+Tj8ywnF/lA
         j1xPddDpyvEooYNpD370jkYBWs3hpS34XwogrBHK9xAwz/1gQkNzro6o6qfJqfkxs3jY
         JAP3j08jEehjZJZzNia8wQlcJuL5J4dgQkRfLbpQJCfpwzxs00TMZFgRWKpegNoa6K8O
         czSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262191; x=1733866991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwWez5ol7FeBhH6sA5fPARd0zXOEP0zk86+9NV7+9aU=;
        b=REG+tvW/B6mD3peoP+rgQPg/YF3BCBySFKJ50o0QyCk/dIw7M8X46BFhkuyqgA/dn0
         C/nMuQFE05zb+8lJFZnxkzoM34AqEHTPer/E8+QywyN9BOxz3/v2eclw0X6iBMOJV4yL
         ++uN2l1QBJdlevD9YPMEHL8GLX8138iaEsP4NuA3B93bnmV+xJEN2tK0xYNQz+hQPLCu
         DaVSFLzddk75aMMMg8aKhtVRbuwx3iLu13UycEPfAWWYMQIst1mtw+OUAvXwSGdT6oqX
         ZPynICcg2PGE6nkvhX0KNtFlFREH3cGTMTgLkpuc32BKJG7DU4vrbKsZJtvNDs2Xqoj0
         lQRQ==
X-Gm-Message-State: AOJu0YzFZhSnBOI8FXTJOGazZqECbB0EWf8DJKNCy+GVVbdGgl31OCpb
	5okcxsU3/UceX/vbYdlyoASL5DaXtlsLP54kwoGxlqM1KEUN+ilbiXONtizBvBRr6L2X8GHwBoI
	dOS/2ne3PnMFOBrvAkvDM9WfBRHZAlOuP2fKauUdYbA8ShTakkQmfeOlEUFpUitmWFgIBLhYNpE
	nMohX7rKyG/jKHs0Lgr0d6hahh94SmZ1yLClGv7fpo/BycbA6M5E9nduKQKgrqLFULLw==
X-Google-Smtp-Source: AGHT+IF+H78IibFS/IwwKrmeuLxix5R3V6H9HpgyxJtSoyhXhyasDXFhyalfJYlWVc7DD9k+QqBw/kRpPXo1Zeois1WG
X-Received: from pjyp7.prod.google.com ([2002:a17:90a:e707:b0:2ea:499c:f031])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3847:b0:2ee:a4f2:b307 with SMTP id 98e67ed59e1d1-2ef011daaf6mr5210062a91.4.1733262191355;
 Tue, 03 Dec 2024 13:43:11 -0800 (PST)
Date: Tue,  3 Dec 2024 13:43:03 -0800
In-Reply-To: <cover.1733259949.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com> <cover.1733259949.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <5a63c9a5cac8088730cc536f33b0af052c90aca1.1733259949.git.jonathantanmy@google.com>
Subject: [PATCH v2 2/3] index-pack --promisor: don't check blobs
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, ps@pks.im, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

As a follow-up to the parent of this commit, it was found that not
checking for the existence of blobs linked from trees sped up the fetch
from 24m47.815s to 2m2.127s. Teach Git to do that.

The tradeoff of not checking blobs is documented in a code comment.

(Blobs may also be linked from tag objects, but it is impossible to know
the type of an object linked from a tag object without looking it up in
the object database, so the code for that is untouched.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d1c777a6af..57b7888c42 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -817,6 +817,33 @@ static void record_outgoing_link(const struct object_id *oid)
 	oidset_insert(&outgoing_links, oid);
 }
 
+static void maybe_record_name_entry(const struct name_entry *entry)
+{
+	/*
+	 * The benefit of doing this is as above (fetch speedup), but the drawback
+is that if the packfile to be indexed references a local blob directly
+(that is, not through a local tree), that local blob is in danger of
+being garbage collected. Such a situation may arise if we push local
+commits, including one with a change to a blob in the root tree,
+and then the server incorporates them into its main branch through a
+"rebase" or "squash" merge strategy, and then we fetch the new main
+branch from the server.
+
+This situation has not been observed yet - we have only noticed missing
+commits, not missing trees or blobs. (In fact, if it were believed that
+only missing commits are problematic, one could argue that we should
+also exclude trees during the outgoing link check; but it is safer to
+include them.)
+
+Due to the rarity of the situation (it has not been observed to happen
+in real life), and because the "penalty" in such a situation is merely
+to refetch the missing blob when it's needed, the tradeoff seems
+worth it.
+	*/
+	if (S_ISDIR(entry->mode))
+		record_outgoing_link(&entry->oid);
+}
+
 static void do_record_outgoing_links(struct object *obj)
 {
 	if (obj->type == OBJ_TREE) {
@@ -831,7 +858,7 @@ static void do_record_outgoing_links(struct object *obj)
 			 */
 			return;
 		while (tree_entry_gently(&desc, &entry))
-			record_outgoing_link(&entry.oid);
+			maybe_record_name_entry(&entry);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
-- 
2.47.0.338.g60cca15819-goog

