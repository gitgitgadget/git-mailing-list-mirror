Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1951C1E505
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956538; cv=none; b=YSp/nYf6y2JpIurE5ZbF/D/rrWe1UJ/vXU4VR7tOIDbvY/QxgZjwtzNJHYPGcgwdRsxCPPENbTiS6ztV0f02/Ojxb27Tl1RNiGHWSg7c3obehAvQOHAosYNahcn36O3cu8XGIe/dGEV4axd6FMmEFL4xNCPflejEmE8hLE0sVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956538; c=relaxed/simple;
	bh=n8POLU/OQREXFeEAjyabbn/U/Vi1PRuvPKrxi9XdQ/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QaPDr2S9Rn1EJb3jGJcsGF9h/+R8xrJON2LiSeLOjwZ0CK7Hyfp/bq2GZt+kPTKgHtdd2v2sCN5F1ZhzLTp16jsdWaUHj30/JbzWPLNijzCflUUQ7QNH05qzfqF9MAwX1DOpUf5GfNHktc01taFkv4mHGyaSHnqytqdeb/lBlDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDqxOGdH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDqxOGdH"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so5583586276.1
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 11:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731956536; x=1732561336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gafxA9/MpVL42swZt2Kv+eAvKHDvCHJx8Mt/VfALvUs=;
        b=VDqxOGdHFDK1o4nDWXvoJjkCRNh5ZjY0DhZkWXvcCgxrZgdY8vrGMPuP7rT0nsZsIU
         JJjRnXEYtLBHhq7O9eDl31KJRYvRXnHCU15EiaBYj/TblEoqWzvSTX2iPe324yJUAQuv
         oPq++idEKjWLJMv4kgcWrMFkMgRWsqgVXGFF7kqp0lhWdyBD0bkeUALr6idUzai280dm
         eeudtD71K0xE8+uWWkUeCYFEiE37kYKKWo9fVvtiYYfmQdJePgMu7yrSNJajgjbHX4lD
         hY1kP5V2StGuCUNk4/OHoheRUPuF1B8HWEra6Fm5AFX7kKmgY23W9OtH4UfkEvh1M3FA
         Gsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731956536; x=1732561336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gafxA9/MpVL42swZt2Kv+eAvKHDvCHJx8Mt/VfALvUs=;
        b=QGn35b+kQ2v2TxmrzxZ5XxvV2JLC5TRyuCg5VaTiN2cCv9q+eoMffRka9sEN0m2VFh
         K4uohj/vBZ1kuZlKv/KtUdnU5LCGc/z6mR87Bw4o95ItPyBrrr7/tmOgNLudVtjVm0JM
         oryOsxdtB25Ye+7r/NhkCTf7ka13Bm1CDf3k7L9JwK6OBGCCoW4gXMUDksSDAPEOyUKd
         M6FPGXQW2d1Zs6dFygJxBGvkdb3qGZSVko6yYNO0olqDm2b/DFXm0T2/cODM7JehPwG5
         eZ9HvYCZLLFARPTkBMwjYwDmB0KcCndMtr6nP1FPgNVVCV1vo3Y6uqK4b2eH8Qqfe2TL
         oq9Q==
X-Gm-Message-State: AOJu0YwO7Y/ULcSV8X0O7+FAxfM58LXsUXJsXbqKqmLZMiQfbDruOcC6
	Aad0euverUk/sZw4udG7IdT1FEAN4XHiJYM7jBa6/xJDqjdn22KiH5t8JnkKX5mCS2wA/fXdo2R
	uZK/7nm1v66aoittiejkDeTlTTUhw43J6JnpRvRQ6O0HoAMMaS5UZqenyud5HW6YXYk/Q+mal4h
	8/0oKPczUPXRl4MZ6Q160o40ihWxBfEepDgPMmL1rjWeS5h58sz8qmwr9t5PS8kVZmRg==
X-Google-Smtp-Source: AGHT+IHbHjfaq1CvSDe+Y3Chc5Btn8JzwxMACrwRRH6psLr1bMyJj2L7Oxl4vGiVFvduB7mz3MdCPHqcV1dvZGhaODqc
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:f16a:183d:4e6a:6d27])
 (user=jonathantanmy job=sendgmr) by 2002:a25:7404:0:b0:e38:6c94:5916 with
 SMTP id 3f1490d57ef6-e38b786846bmr13110276.4.1731956535822; Mon, 18 Nov 2024
 11:02:15 -0800 (PST)
Date: Mon, 18 Nov 2024 11:02:06 -0800
In-Reply-To: <20241116032352.GA1782794@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241116032352.GA1782794@coredump.intra.peff.net>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241118190210.772105-1-jonathantanmy@google.com>
Subject: [PATCH] index-pack: teach --promisor to require --stdin
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, peff@peff.net, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"

Currently,

 - Running "index-pack --promisor" outside a repo segfaults.
 - It may be confusing to a user that running "index-pack --promisor"
   within a repo may make changes to the repo's object DB, especially
   since the packs indexed by the index-pack invocation may not even be
   related to the repo.

As discussed in [1], teaching --promisor to require --stdin and forbid a
packfile name solves both these problems. This combination of arguments
requires a repo (since we are writing the resulting .pack and .idx to
it) and it is clear that the files are related to the repo.

Currently, Git uses "index-pack --promisor" only when fetching into
a repo, so it could be argued that we should teach "index-pack" a new
argument (say, "--fetching-mode") instead of tying --promisor to a
generic argument like "--stdin". However, this --promisor feature could
conceivably be used whenever we have a packfile that is known to come
from the promisor remote (whether obtained through Git's fetch protocol
or through other means) so it seems reasonable to use --stdin here -
one could envision a user-made script obtaining a packfile and then
running "index-pack --promisor --stdin", for example. In fact, it might
be possible to relax the restriction further (say, by also allowing
--promisor when indexing a packfile that is in the object DB), but
relaxing the restriction is backwards-compatible so we can revisit that
later.

One thing to watch out for is the possibility of a future Git feature
that indexes a pack in the context of a repo, but does not necessarily
write the resulting pack to it (and does not necessarily desire to
make any changes to the object DB). One such feature would be fetch
quarantine, which might need the repo context in order to detect
hash collisions, but would also need to ensure that the object DB
is undisturbed in case the fetch fails for whatever reason, even if
the reason occurs only after the indexing is complete. It may not be
obvious to the implementer of such a feature that "index-pack" could
sometimes write packs other than the indexed pack to the object DB,
but there are already other ways that "fetch" could write to the object
DB (in particular, packfile URIs and bundle URIs), so hopefully the
implementation of this future feature would already include a test that
the object DB be undisturbed.

This change requires the change to t5300 by 1f52cdfacb (index-pack:
document and test the --promisor option, 2022-03-09) to be undone.
(--promisor is already tested indirectly, so we don't need the explicit
test here any more.)

[1] https://lore.kernel.org/git/20241114005652.GC1140565@coredump.intra.peff.net/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on jt/repack-local-promisor.

Looking into it further, I think that we also need to require no
packfile name to be given (so that we are writing the file to the
repository). Therefore, I've added that requirement both in the code and
in the documentation.

I've tried to summarize our conversation in the commit message - if you
notice anything missing or incorrect, feel free to let me know.
---
 Documentation/git-index-pack.txt | 2 ++
 builtin/index-pack.c             | 4 ++++
 t/t5300-pack-object.sh           | 4 +---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 4be09e58e7..ac96935d73 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -144,6 +144,8 @@ Also, if there are objects in the given pack that references non-promisor
 objects (in the repo), repacks those non-promisor objects into a promisor
 pack. This avoids a situation in which a repo has non-promisor objects that are
 accessible through promisor objects.
++
+Requires --stdin, and requires <pack-file> to not be specified.
 
 NOTES
 -----
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 08b340552f..c46b6e4061 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1970,6 +1970,10 @@ int cmd_index_pack(int argc,
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
 		die(_("the option '%s' requires '%s'"), "--fix-thin", "--stdin");
+	if (promisor_msg && !from_stdin)
+		die(_("the option '%s' requires '%s'"), "--promisor", "--stdin");
+	if (promisor_msg && pack_name)
+		die(_("--promisor cannot be used with a pack name"));
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (from_stdin && hash_algo)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index aff164ddf8..c53f355e48 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -332,10 +332,8 @@ test_expect_success 'build pack index for an existing pack' '
 	git index-pack -o tmp.idx test-3.pack &&
 	cmp tmp.idx test-1-${packname_1}.idx &&
 
-	git index-pack --promisor=message test-3.pack &&
+	git index-pack test-3.pack &&
 	cmp test-3.idx test-1-${packname_1}.idx &&
-	echo message >expect &&
-	test_cmp expect test-3.promisor &&
 
 	cat test-2-${packname_2}.pack >test-3.pack &&
 	git index-pack -o tmp.idx test-2-${packname_2}.pack &&
-- 
2.47.0.338.g60cca15819-goog

