Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74D209F49
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262787; cv=none; b=bNZk+0s4rn9PjyovtL6K7xlXw/yvXUOzGe2K54oqjjeHghILl0x5q9mqGHOuAD6YJBD3x+cJ3h88t+Sjst2n13+u6WYJrdU5ulGCiBg4Zq/kiVm4c6gFakMvqiOv8iALq0vijMoFA4c+sRDie2QwJOAj9Q27eWslvr2u70RFU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262787; c=relaxed/simple;
	bh=RB858o40qlolunBXqIuHz9lOnO6CmSzXU4OGgb5LioE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bdQRvlHAWORI9hnK/KQCE9vbzKCd0EI+xkJJt6+WkVceRqJyaA9gC7GLZ2NU6e3W0H3I+gl7+96O3E1tRi21uoVQmmUUhjuFr+RaIPwoY9Bv+nv4aCdkn0CHk9VKAAUrdZFpyaDyvZ/1DbHct2oxsFTsVaEtCoPGrp7Mm7DnKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyjRwj5j; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyjRwj5j"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-29e525890e4so3045109fac.3
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262784; x=1733867584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4c9dVPxmreSId8/F9kkGAoIDK59JPJqOkX4hBvaaRs=;
        b=WyjRwj5jzzoCokqGbkRsEUQIcTyryFedhW31UV9UK105ock9H/3XNuGsv5epDD7nJh
         Zp3kfWFqOiqj/NXtUqLoMdspn23HR+mGWlq9pQ9OopACWgwBa1nN53t4aIS6v4lJpAZh
         NC/qjqAEmU3otxfF35UpbyjK+yb8CK5P3XBvTcw3lZD5Q+U36v8ZDWC/dDWelHTKpmWD
         gEe5Ra56rGOuqJhRjU0TacrCg4ksxTV/VpYxBzaLdwK1WFtCAkcDaB2ZyBbfJYtFEWY4
         Ofjnuwq9sYK6bUjEzyiUX5cZD1szCFHYXmMGob2qt5snVBqIzEpXVTtYQ4wmvOd1aRdL
         gUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262784; x=1733867584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4c9dVPxmreSId8/F9kkGAoIDK59JPJqOkX4hBvaaRs=;
        b=gEq32p6a0IqTlWuYQqGcqhjIDQcEhGoMz0J0UZ3tU0c4DyiFuRFVJ5pkK3pdyvaa+F
         y2Q+JY0qcNafI7GqjJGP6ESApVXQfif1VT1gxortyp86Ifnho0UKHQR0k7q0+WEllR5B
         rEXKzYnKZ1NOTaHMBxUdEk5GDj9C1GJrGR34+0AXt1rqNKaF+Ot7WgiHWKjZJgqdHLDm
         EDwIdVaYiTN5X0pZkzjkUrI9xHc5b9YhDTgvlRKlkaBWoE3354JRpR5XAAthLNU2eJ3+
         rZdpRF6LLqMKK2cGIIFKACkSQqsMRjJPYSmDjwz1dyds3x04gTHE9IEzkcGjA7VgPiVi
         rTXQ==
X-Gm-Message-State: AOJu0YxqLk6+lJHqocZCD5Y1HNpprw5j9CErLpZbM/kQ6aXYpDV6ytGS
	10v26q55/F1CBH9gMhteHpku4PwjFwV6wko2f+Wn0wVjvm0e6uQJsYJQEqgidsQ8r7yavpDzRdF
	VW5ZKM11+Ai6ozFbz6WepowGtkdw52rN0YyeWa/qg8/KC628ojYJAkBOJJ9+QL2dfU/p9xqg36/
	n/bff/M2+ahU8h6YLHnJlliHsLWPm7yee8/Ynq2gI64IFTRgrs18Yrpsc+kxrWVAp3+A==
X-Google-Smtp-Source: AGHT+IEdgO2HwB27JpP8QpK7YP8g1+L5VsCdOYr6UVHeHODo2nEcR3Iwx8WvGZJiCr0kfZEQMwFsvLWdn6ZgIETdyEO6
X-Received: from oacpy6.prod.google.com ([2002:a05:6871:e406:b0:29d:c4b7:250d])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:e386:b0:29e:7f8c:8f57 with SMTP id 586e51a60fabf-29e8884d9c9mr5298023fac.27.1733262784639;
 Tue, 03 Dec 2024 13:53:04 -0800 (PST)
Date: Tue,  3 Dec 2024 13:52:55 -0800
In-Reply-To: <cover.1733262661.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com> <cover.1733262661.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <a1d2a202031e4b932d053b5c216ecd57ec9c728a.1733262662.git.jonathantanmy@google.com>
Subject: [PATCH v3 2/3] index-pack --promisor: don't check blobs
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
 builtin/index-pack.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d1c777a6af..2e90fe186e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -817,6 +817,35 @@ static void record_outgoing_link(const struct object_id *oid)
 	oidset_insert(&outgoing_links, oid);
 }
 
+static void maybe_record_name_entry(const struct name_entry *entry)
+{
+	/*
+	 * Checking only trees here results in a significantly faster packfile
+	 * indexing, but the drawback is that if the packfile to be indexed
+	 * references a local blob only directly (that is, never through a
+	 * local tree), that local blob is in danger of being garbage
+	 * collected. Such a situation may arise if we push local commits,
+	 * including one with a change to a blob in the root tree, and then the
+	 * server incorporates them into its main branch through a "rebase" or
+	 * "squash" merge strategy, and then we fetch the new main branch from
+	 * the server.
+	 *
+	 * This situation has not been observed yet - we have only noticed
+	 * missing commits, not missing trees or blobs. (In fact, if it were
+	 * believed that only missing commits are problematic, one could argue
+	 * that we should also exclude trees during the outgoing link check;
+	 * but it is safer to include them.)
+	 *
+	 * Due to the rarity of the situation (it has not been observed to
+	 * happen in real life), and because the "penalty" in such a situation
+	 * is merely to refetch the missing blob when it's needed (and this
+	 * happens only once - when refetched, the blob goes into a promisor
+	 * pack, so it won't be GC-ed, the tradeoff seems worth it.
+	*/
+	if (S_ISDIR(entry->mode))
+		record_outgoing_link(&entry->oid);
+}
+
 static void do_record_outgoing_links(struct object *obj)
 {
 	if (obj->type == OBJ_TREE) {
@@ -831,7 +860,7 @@ static void do_record_outgoing_links(struct object *obj)
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

