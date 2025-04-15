Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867882BE100
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757225; cv=none; b=aMvHgqBlW+r76ju6ffSVWC748KpwEWWMdmt2lJYMYLFgB+tjiwYFc2e0ifzgkY1m+9vNV1n4uYmKqqzc+640/N0j8GaDz1Zrn8z+ZDeYs6FTQkClXTxDBCGMRKLFpVFot/QcqRtggGbNIzorqtHdh6CgvxBghxYg+ZMWRrk4PRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757225; c=relaxed/simple;
	bh=4ISpk/ejtkGsMPU2wfniBoAdH9D4V1/0yyjaWAx9Vk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUwXRspG4FPM124xsj4Thm6VlHl6qUO+vuJ2WdtLT40YEtARpfxYAY6VjqTwVeV+RWnjfkuLcXzoN/DcIYaLrlja9GD9LXyCBYSZJ4gEzKS5c6uQgU2lNZ+qPbyndzaU2I08xjX870Icpei5cqQqqCe0E3q1f2x1iNaVaPCUBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GRvlH2XG; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GRvlH2XG"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476af5479feso54156171cf.2
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744757222; x=1745362022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N7nuh9dYwlBWEQNqm3Hh+kPeEYcXto7w0OIy6dlunYk=;
        b=GRvlH2XGaO8xsPRUC+KIwjN6B4iy767ggBGZWic3/gHMfxoiLjK4QFwv+bLZfzIU6/
         hT2BbSaJ9FdMQXziPhV2B9L+9SjKVQDyJDC3O/J8dSv16fhBa1cKzDVdiWtRP0E3qxU+
         jy+Uoz2L3E5Wo0QszyKqTEUVUiXBDDmd12DlniABnwPjTUgac/vVDcRmSOAaioJcVZ1Y
         uSoNza7fiQ2Q1CyAvamrO9Z3A/k9HdSEF7jprJNIYvVwww3HXuTzl48yUvUGdHBYa9PI
         ztUNr+oaiFilviRUX+3tD9H7sl3bPOScC4zqx8jlTmXO09/n7fp1zoII/gdTG62F3jsc
         t3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757222; x=1745362022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7nuh9dYwlBWEQNqm3Hh+kPeEYcXto7w0OIy6dlunYk=;
        b=RP3TxuxQdVCO6qfpUdfCvV/DVCCWtb0zt/IuoEGV+GGYNf3E9XLy5+Vv2dmT3A0G4V
         ZM9ZL7o8fVquPR7krmwWAyAwcIpeWv9+5OHmXuTYbVAObKx7sqqSDQyBEwqmDsrBwVfP
         VuorzZEAhBFFxieLb8G7v30DUiHbLVm6xK+uXHvTgt3f3r4aalE+o7/UpAcBURnLa36T
         3Y7ty0Tnudz7wxqXfotJGuL2YzuM6ZTUlFnCgPS56lUDh+xApyPovUC1bxxVQoDsaIYK
         j5NQ7JBSUL0VgvS52mLj7oPfg6V4/gm8AGmq0CeSOaMNZXAXAswt4pd0pNzsOkW5WxGM
         r74w==
X-Gm-Message-State: AOJu0YzUqbfQpaLpY1FopcwLxrAIDMMH+UKReUXz5pwFx0eJYql+T1vK
	FOsR19AE9BavG9Ta2Q8xUng/EKxWKQruOwh2VuFHGwiHkFtQzmgK2875PTJPuJSeNol0Cix3Qj6
	QXUc=
X-Gm-Gg: ASbGncvhPlRYO2m3+PxCH1s4SetgIxpLvsHNAjhbZpJsHvzxCCLUG/YJTb8moSLIUwJ
	ufHPSMtYIPclATkc/kck2ebRkPXMJvafcfPXT1P102k3PqNz9ouFJXSGhAwgtOrRE0Em9Oam83r
	Ph3s56hM66jUaal+PAPNT0Yy1PVM6gG5OtBmdSur8peCiSh+r3veETo1onKydZ5FVqeWX6U9Wnu
	z/bddg2NgB2BCWRs/GzO32gFXGC+uxdM48lliuMWpU972N/a/Kh5e/cY5tdkOocatK6z69DfWz6
	A5XxFJdg5vzEDnj+T661lv07nD0aQzhemRgKv2gJfc9yi0D9rJYBuqUy+bYEVyBZPgA0SwDdz2F
	1NA9HfI+ELyOe
X-Google-Smtp-Source: AGHT+IGJWHllwBXa1unv/kBZ7wUvys9rCbWJaACPdiG6gIUurmv7XOdMBACq2Wp1/VR+T6qnuQ2mVQ==
X-Received: by 2002:a05:622a:c8:b0:476:a969:90c5 with SMTP id d75a77b69052e-47ad3a3dc46mr12901941cf.24.1744757222219;
        Tue, 15 Apr 2025 15:47:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796ed9cc97sm99163011cf.61.2025.04.15.15.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:47:02 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:47:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/9] pack-objects: perform name-hash traversal for
 unpacked objects
Message-ID: <240e90b68d18b3231826d2a68e4e251c893e645a.1744757204.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744757204.git.me@ttaylorr.com>

With '--unpacked', pack-objects adds loose objects (which don't appear
in any of the excluded packs from '--stdin-packs') to the output pack
without considering them as reachability tips for the name-hash
traversal.

This was an oversight in the original implementation of '--stdin-packs',
since the code which enumerates and adds loose objects to the output
pack (`add_unreachable_loose_objects()`) did not have access to the
'rev_info' struct found in `read_packs_list_from_stdin()`.

Excluding unpacked objects from that traversal doesn't affect the
correctness of the resulting pack, but it does make it harder to
discover good deltas for loose objects.

Now that the 'rev_info' struct is declared outside of
`read_packs_list_from_stdin()`, we can pass it to
`add_objects_in_unpacked_packs()` and add any loose objects as tips to
the above-mentioned traversal, in theory producing slightly tighter
packs as a result.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d60cb042c9..eb2a4099cc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3644,7 +3644,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	string_list_clear(&exclude_packs, 0);
 }
 
-static void add_unreachable_loose_objects(void);
+static void add_unreachable_loose_objects(struct rev_info *revs);
 
 static void read_stdin_packs(int rev_list_unpacked)
 {
@@ -3671,7 +3671,7 @@ static void read_stdin_packs(int rev_list_unpacked)
 	ignore_packed_keep_in_core = 1;
 	read_packs_list_from_stdin(&revs);
 	if (rev_list_unpacked)
-		add_unreachable_loose_objects();
+		add_unreachable_loose_objects(&revs);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
@@ -3790,7 +3790,7 @@ static void enumerate_cruft_objects(void)
 						_("Enumerating cruft objects"), 0);
 
 	add_objects_in_unpacked_packs();
-	add_unreachable_loose_objects();
+	add_unreachable_loose_objects(NULL);
 
 	stop_progress(&progress_state);
 }
@@ -4068,8 +4068,9 @@ static void add_objects_in_unpacked_packs(void)
 }
 
 static int add_loose_object(const struct object_id *oid, const char *path,
-			    void *data UNUSED)
+			    void *data)
 {
+	struct rev_info *revs = data;
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
 
 	if (type < 0) {
@@ -4090,6 +4091,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 	} else {
 		add_object_entry(oid, type, "", 0);
 	}
+
+	if (revs && type == OBJ_COMMIT)
+		add_pending_oid(revs, NULL, oid, 0);
+
 	return 0;
 }
 
@@ -4098,11 +4103,10 @@ static int add_loose_object(const struct object_id *oid, const char *path,
  * add_object_entry will weed out duplicates, so we just add every
  * loose object we find.
  */
-static void add_unreachable_loose_objects(void)
+static void add_unreachable_loose_objects(struct rev_info *revs)
 {
 	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
-				      add_loose_object,
-				      NULL, NULL, NULL);
+				      add_loose_object, NULL, NULL, revs);
 }
 
 static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
@@ -4358,7 +4362,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs();
 	if (pack_loose_unreachable)
-		add_unreachable_loose_objects();
+		add_unreachable_loose_objects(NULL);
 	if (unpack_unreachable)
 		loosen_unused_packed_objects();
 
-- 
2.49.0.230.ga662d77f78

