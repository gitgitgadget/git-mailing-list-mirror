Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD54B1E78
	for <git@vger.kernel.org>; Thu,  8 May 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746701089; cv=none; b=i3q1pw1ZPJUkAD4OQVyFdoYoiRRS0/f2d2Swl8OyZlOiFEDdpCh7ngiLYmfJTIyrEaCamHuwHeySnIxMFqggsqDYEuL9RPIhaWSqvJ2K8kgrJk4CzPzjFBAKBRjZFMG+542Rxy2JrWbw+mVDs7iJnszYdDTB2Ll8qWVkZCC4hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746701089; c=relaxed/simple;
	bh=2lE5yXY5ydITlpM17y7VcxKLk6tjrN3t8PNsrvcpqig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=thCrixvJyzQ4bKlgqAo8/qg2SFrzsoEeswWYnd6jllgCbSCfYuUpui52OzwQyuW70aNVE9HzXhdRXRJyciBavMb5Q2hxhPE14aZKoPc0Z5bf9E8JyJya6GaF2reuXp5xrgFZuxY18nRlyHmLHPawt8ZEIwPmvJLiX3bUnYi+xw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EFmkDQb+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EFmkDQb+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22fa48f7cb2so3979645ad.1
        for <git@vger.kernel.org>; Thu, 08 May 2025 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1746701086; x=1747305886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVv9HDSbK3a0I5ahzuNiYjqbslGAyt2WChLVxojlqPg=;
        b=EFmkDQb+CXk0JnVLCVQp/JeeScFD5VgMIlgmbypOUyycl5OYWtkNJ+t0rAiQLydwLt
         rxzJ3q2/KcRB/MeUXJnLLgA2GLO1BLZ+SvWvSSSHWibALSRmBn4yuBs70UeNDgiUWy/E
         c3OmDAblj/7yDiyktg30HVaNDCNpyqGkg2rNTWQA64DMfgywMZTRgrRRHstBcna/7Mj7
         RXGHtwg12j3aGvwmCDQvLpfkZX8EglhNTblDFmNF0vIQNU58JkYivGXBnffmAeMz9ck2
         MaClCbHCC8Y4VnL/hScRlN0ScCyaefzX2O5uEf9T1H/paZbYpdlrzgZYT6ETSaDrJREH
         Te6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746701086; x=1747305886;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVv9HDSbK3a0I5ahzuNiYjqbslGAyt2WChLVxojlqPg=;
        b=YudG+GDzQkfyXTOzbPtvVDXFT/BWW7wsSvCBcHnPaPVWO3XNVqWRa9l0Vhug5ha3YF
         +qVdsBiDBIc9oR4+GLn2lEtLw6T4TonkOhLdgVd2trqWWPElpL1SyohJ5ZMNd0aM362+
         FP6aSwLeb2Os+Ycvzf6jXNKrTFM400zXxGaSaiyrGjOVmPJAUTiuI3TOfY1e20GQbhGp
         okEHpRUm4FtBMCLZAdTWVVwpMQIAvFK0JD6MSPoh4GUI+jhWwdTIfd02oGjXPYa7V3ie
         bC4GBBI3/K39Kf5prqWehboWjL8QCukQz2qnHa2v69pRo8IyA4W9QU5+eFoSX1dDIzig
         QXiQ==
X-Gm-Message-State: AOJu0YzdJzZRbliXWG3UaSvuVfLIHtUC/ZH/fKg3Yj70XSxNV0Esqo3P
	kVi7iVKaDu6BUspOfp/d5bPr24C9AT/jlLvLYS+8qg5zNBFo0HO/UiAwCLGgyzA=
X-Gm-Gg: ASbGncuD0GPDKr1pb4Y4ewqH0KjugHvRfCR0x4kf0gAZJFajt6rLbBur7JGbcqVO9gz
	7l8he2ZmRZWbzYPsbtj1/5loaimEoOhGshfg5J0nZ+j99Cab4dApFHJomAqQV6mvwfeJSMjO5+3
	Yn2Pdm8o8x3y4oG3Sh5x/B3L2X4Fcwc/AcLQZp3cQPPTHblv4OZXgKh0YXmR6+dFALVU/rX/iVP
	k/WbRQUSaa9fgl8UtV9/kfvqxCKIreAxJJnJn/vW0yw32VBz0vkyadKHjNtTGuSAXvRNiv3nH+w
	GeLkfayRrgUUcLnWLIyrdb8iNNVjoBTR+AubL11TVSxEYrNiYrK1dg25CH4xEHecwFklXMK0cMc
	kLjnRf+tx0A==
X-Google-Smtp-Source: AGHT+IESUUXFtofzgNeDtR3mENKPtLujGH6ftsMgtMyEx5P7/nHPlTQ95yMVeQgrhvxypD2WfIHk1w==
X-Received: by 2002:a17:902:e844:b0:21f:136a:a374 with SMTP id d9443c01a7336-22e5edeb97amr92700455ad.43.1746701085753;
        Thu, 08 May 2025 03:44:45 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522f886sm109050265ad.226.2025.05.08.03.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 03:44:45 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: trnka@scm.com
Cc: git@vger.kernel.org,
	jonathantanmy@google.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2] builtin/repack: Honor --keep-pack and .keep when repacking promisor objects
Date: Thu,  8 May 2025 18:44:37 +0800
Message-ID: <20250508104437.51513-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.48.1
Reply-To: 19759704.fSG56mABFh@electra
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tomáš Trnka <trnka@scm.com>

git-repack currently does not pass --keep-pack or --honor-pack-keep to
the git-pack-objects handling promisor packs. This means that settings
like gc.bigPackThreshold are completely ignored for promisor packs.

The simple fix is to just skip keep packs when iterating promisor packs.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
Original-patch-by: Tomáš Trnka <trnka@scm.com>
---
The original patch passes the --keep-pack arguments to pack-objects. While
this approach avoids repacking the keep packs, the objects in the keep
packs are still enumerated. These objects are iterated in repack and sent
to be packed, only to be skipped in pack-objects.

Filtering out the keep packs in repack_promisor_objects is more efficient,
the objects in keep packs are not enumerated and sent to pack-objects.

In a test repo with a 2.7G promisor pack. The original patch took longer to
repack the repo, most of the time was spent on enumerating objects.

The original patch:

$ time git repack -ad --keep-pack=pack-a26479ad4f9dff58448df6fca4953844009b3920.pack
Enumerating objects: 19091575, done.
Counting objects: 100% (5934/5934), done.
Delta compression using up to 12 threads
Compressing objects: 100% (4517/4517), done.
Writing objects: 100% (5934/5934), done.
Total 5934 (delta 2885), reused 2986 (delta 1192), pack-reused 0 (from 0)
git repack -ad --keep-pack=pack-a26479ad4f9dff58448df6fca4953844009b3920.pack  43.94s user 46.83s system 134% cpu 1:07.60 total

This patch:

$ time git repack -ad --keep-pack=pack-a26479ad4f9dff58448df6fca4953844009b3920.pack
Enumerating objects: 20952, done.
Counting objects: 100% (18323/18323), done.
Delta compression using up to 12 threads
Compressing objects: 100% (9022/9022), done.
Writing objects: 100% (18323/18323), done.
Total 18323 (delta 11340), reused 15753 (delta 8771), pack-reused 0 (from 0)
git repack -ad --keep-pack=pack-a26479ad4f9dff58448df6fca4953844009b3920.pack  8.65s user 3.14s system 62% cpu 18.838 total

I also noticed that this patch produced a smaller packfile.
1.6M compared to 4.5M generated by the original patch.
I suspect this is because some objects exist in multiple packs,
so pack-objects still repacks them even if they are actually present
in keep-packs.
---
 builtin/repack.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 59214dbdfd..fb09df53c0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -252,8 +252,9 @@ static void existing_packs_release(struct existing_packs *existing)
 /*
  * Adds all packs hex strings (pack-$HASH) to either packs->non_kept
  * or packs->kept based on whether each pack has a corresponding
- * .keep file or not.  Packs without a .keep file are not to be kept
- * if we are going to pack everything into one file.
+ * .keep file or not.  Packs without a .keep file or specified by
+ * --keep-pack are not to be kept if we are going to pack everything
+ * into one file.
  */
 static void collect_pack_filenames(struct existing_packs *existing,
 				   const struct string_list *extra_keep)
@@ -278,8 +279,15 @@ static void collect_pack_filenames(struct existing_packs *existing,
 		strbuf_addstr(&buf, base);
 		strbuf_strip_suffix(&buf, ".pack");
 
-		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep)
+		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep) {
 			string_list_append(&existing->kept_packs, buf.buf);
+			/*
+			 * mark packs specified by --keep-pack as keep in core, keep packs
+			 * are ignored by repack_promisor_objects. This avoids passthrough
+			 * --keep-pack args to pack-objects
+			 */
+			p->pack_keep_in_core = 1;
+		}
 		else if (p->is_cruft)
 			string_list_append(&existing->cruft_packs, buf.buf);
 		else
@@ -412,7 +420,9 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	 * of a {type -> size} ordering, which may produce better deltas.
 	 */
 	for_each_packed_object(the_repository, write_oid, &cmd,
-			       FOR_EACH_OBJECT_PROMISOR_ONLY);
+			       FOR_EACH_OBJECT_PROMISOR_ONLY |
+				   FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
+				   FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS);
 
 	if (cmd.in == -1) {
 		/* No packed objects; cmd was never started */
-- 
2.48.1

