Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A91DEFC0
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170730; cv=none; b=Fn2gum/AEYtSntA0QhacMOUKx3qAjyqLYDW1QHjPtzrX8mkvT/TNe4irq3GJc1hx5oiW2Wd0Z0Mt36WcRDiQ4FlGkPikoOVJJqijguF1zTlusW/HfZYHvYo65CMwxo+R5cXgNPgZX8g8GGbadjCpa+4nia2xXYSlUtJ1ktnA1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170730; c=relaxed/simple;
	bh=5GLpRW1pJnghx+3+As4hETJ4Zg+ZbAxKjnJcu+50mF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E0WQ2thk5qMMeiadDoMSs6ZxDkByLrf8mra/XoB+OJwsouWbKMG5FbPmLwQU4C2o1mFfGkAMpcZDoJpTPXChF6NvJKJY80fGG0kDUMF0C2FpdWQF887dgirWkYMcaeQbD/0mgeQAGvJNVGQvz+Rvf4G08iyQ2xcc1ElxMpwNBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7NXD7uo; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7NXD7uo"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-724f6189a4aso5479803b3a.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 12:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733170728; x=1733775528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iv2Pi4eVb7KbicHQ0WDVKbT+pc93lbW2+tfBsrUYFn4=;
        b=K7NXD7uok6hNMpmnpSd59s1oLMZ5AG10dZAtzguZJyq77vohoBQUKCF8oNhRJpPuJ+
         ASWKjQ8Hm42fHMsRwt/UeUQeTLa0e7Kbl72Ni+A6/p8VCJjlxehj6FJ1P4WX2gWbGCtH
         sro8/5BSJOnDOLXR1V8azH7M6/0mCYiBOs/ukobSz9uvx7Br/nOidbAiylYYOa5nWre0
         RihHzLRmpV4MvAJQDaXnewnLzWTC9BodERszdVOUz+2U6chLWqOnpcMQrxIdZqEz1lAI
         /oB8Pnp+uQzd8VqUSqp4Lisq9wytJp1qaT01K9EhSxo6psIMG74CtILMotvEbxJEEiO0
         WVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170728; x=1733775528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iv2Pi4eVb7KbicHQ0WDVKbT+pc93lbW2+tfBsrUYFn4=;
        b=cqjmJq95+UvD62Ud5ti013fsVUq9DzqeLaFZXTC0fj9X51GZ+mmjgtGBe83qoh0u7V
         17+P/6gBIM1uFhZP7Nkup8cRmOzblBl3UbOpT9JnjVRrT2bQ2uRE42Nn+gDgXfzpNRxf
         53edzJoNGovB2jfpw4Alqx6fv6dFyVkI2uZ2tMahEJKuH2IBoeFnq1iQsrXw4tUfju8y
         Hc+6I5CI+CuGfvivaQJrtVlIDMMnNJvoxgWgg5yUvCeRtIJDMfRjmJ0iE7nIoDXF+O0y
         45OFS1pfzHYPglsm6vytfgB3DDJ+3mcfzQBON2K9WFQaN5wxo96W+DxZfheYRqATdpNg
         u81w==
X-Gm-Message-State: AOJu0YydcKNlygu55eiHMZ84mk7D0ry50GxK25RdwZHc90Lb0pc7Ze8V
	vGC4XBFVBAHF6qxsnwuuO+k/LYRrCd+VOiBQGfcIOoQK1v+1PqZfRoOFgZEE4Wg6bi7IHlv5lBL
	LxwUk27xw9MxGVCsUnTUwXTXRmY3LwvA/bLH/X4hkggOlDemWieyLPAgiNCF78w6rhm0YKBkX6K
	orUqgwdXreNQMyUQeKL+YPbxdFx47kvfrzWoaMjN8mgV2UEkPnX2s1uYUKY765vp92kw==
X-Google-Smtp-Source: AGHT+IE+sDOJIKGKnBpxP+tve4WKGW8VKX+YUVmyvxC7YHFAx/vnDdG4hLB/P08QUH9Y4YItpYgjstlw6nHVpC+d3EtI
X-Received: from plb11.prod.google.com ([2002:a17:903:440b:b0:215:9d29:1aa8])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc47:b0:215:5204:3913 with SMTP id d9443c01a7336-21552044c13mr200768585ad.52.1733170727743;
 Mon, 02 Dec 2024 12:18:47 -0800 (PST)
Date: Mon,  2 Dec 2024 12:18:39 -0800
In-Reply-To: <cover.1733170252.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <300f53b8e39fa1dd55f65924d20f8abd22cbbfc9.1733170252.git.jonathantanmy@google.com>
Subject: [PATCH 2/3] index-pack: no blobs during outgoing link check
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

As a follow-up to the parent of this commit, it was found that not
checking for the existence of blobs linked from trees sped up the fetch
from 24m47.815s to 2m2.127s. Teach Git to do that.

The benefit of doing this is as above (fetch speedup), but the drawback
is that if the packfile to be indexed references a local blob directly
(that is, not through a local tree), that local blob is in danger of
being garbage collected. Such a situation may arise if we push local
commits, including one with a change to a blob in the root tree,
and then the server incorporates them into its main branch through a
"rebase" or "squash" merge strategy, and then we fetch the new main
branch from the server.

This situation has not been observed yet - we have only noticed missing
commits, not missing trees or blobs. (In fact, if it were believed that
only missing commits are problematic, one could argue that we should
also exclude trees during the outgoing link check; but it is safer to
include them.)

Due to the rarity of the situation (it has not been observed to happen
in real life), and because the "penalty" in such a situation is merely
to refetch the missing blob when it's needed, the tradeoff seems
worth it.

(Blobs may also be linked from tag objects, but it is impossible to know
the type of an object linked from a tag object without looking it up in
the object database, so the code for that is untouched.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8e7d14c17e..58d24540dc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -830,8 +830,10 @@ static void do_record_outgoing_links(struct object *obj)
 			 * verified, so do not print any here.
 			 */
 			return;
-		while (tree_entry_gently(&desc, &entry))
-			record_outgoing_link(&entry.oid);
+		while (tree_entry_gently(&desc, &entry)) {
+			if (S_ISDIR(entry.mode))
+				record_outgoing_link(&entry.oid);
+		}
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
-- 
2.47.0.338.g60cca15819-goog

