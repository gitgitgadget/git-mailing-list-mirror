Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81078F2F
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500551; cv=none; b=Q6IkwAMTrx8kd74Hsj2kFoJ3kpI96s2D4bPICOPFVkyCuZKchy4Ja3CISgW6AAMsngXD8oWrMUwSd274IDh9fo+k4W/2somakT3VZHCEXEHViLsS2Kph0zqWTLCPZ0gx0+tPRx1Xl0n4/9Gwre2V/j/mwXILze3idw8NDvzEu4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500551; c=relaxed/simple;
	bh=eTi21tejfc+yxJbkuFR44k4um+gMjaBjNDSGRQKHiA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NURwNVWjfKb7WZl//kZXbhdfg+AoN0nTpaBiXtbBJRBI6wNPkzXW1d29uZhawF5FLBHcZ1nKFuyR+idtOwjV9KIgVolm/ktFDHxs6midtzOIbAsaO0qUiBKja/qiFn6BztDnaoZhdLvuryjpwTKyi0RK1HWT8OpInTsosza91fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GZqoDSqc; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GZqoDSqc"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664801de06aso1469862d50.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500549; x=1783105349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9vtFNTMk0zQgqD9VIN8sQBEastEPck8PRVcUHe9/rI=;
        b=GZqoDSqccTeoDKWPdfkT6jdN9M23DkgVhsueQ+SeCzvcFixzO50ZwnPdw27m8tetO4
         lerrvu44PY94cuBZw53mWKxs+AjW5mDs6A+J0wpz+bVKjvDb03BkXn/lgek/AZ/+Srsd
         Z5PZDh3Ae/sSsg9NErDxEho92jWInfEjgvt3EmYiwfcgGJcjRSSK94kMrygY7q+KwFlc
         h6gUR5dzMZQUXVbTQGIydI/wBs20zwiE+hde19xucJS8nc5k+m90C0qErB+f1yl/urxO
         KwamaZ+cBZZwF48MsXm1+5cycSXp//vdSnYlzbp0+iGVzUHSRkC6fleZ9A5k2NyjTS5P
         o1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500549; x=1783105349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9vtFNTMk0zQgqD9VIN8sQBEastEPck8PRVcUHe9/rI=;
        b=jimrP1qo6bbRwbv212R4WzUyx8Brsu3vt9ezwTILCROP4zvHgQ/3J+s/RnWbxGuxoW
         q5bmHLTElgyZincWRHdMmzqIRpEtHH/aqTZSv3loU6f2CN42oGpaTCgWNrmv9dtxI33+
         M6W/LyqLvqSUTMnUkFHdjFLvIzPCky30xRrBXXp96L2zswfF02q08e9HXy7LRUG/Msak
         urVZE1PMFo9OzZv/eHAgnV+zroWpshQAMO9DtFbgkIJtSOM+mFJnzr04MCX8ARxKedDM
         NBtONsi5ZIXuO/N0XKIWNmaiYrvpEWBmVMB/4HLg6JKW++n7chfVJdtKdW+4WhqKT4GB
         nI8w==
X-Gm-Message-State: AOJu0YzeEZeTtI5maSc6ZiXP5maBEFXT1uX/xeursaqCZBJXn6pMLq5T
	lF7kopVUcPrhJCjARuBDxaJ5K5zRdKedPSIgQNiBMMcr9n/phtj6VqJk9x+YUN3KIehBgD2usLf
	vO+AwhiIh1g==
X-Gm-Gg: AfdE7clNCtzwYIzmm5xZoWcKJnQMAaXxzg288ZA3+NQLaYtUOEA6kjU7pM2I9CQp1ni
	fjaVIq4xXZJVNdzxWK09IXp9UKZOkSf3T6aILkVFZGNN4dMhGUoDXGXbs11tESd9F5Al16uiFUl
	llQ53QMzc2CLWM64T7EB5M+4Ru02YnYkEaHKydDnSQFTZfBf8r3twkWWZ8cNA9RadT/jIJ9obtA
	pIsMA553jgDv+OSpcwcjYkdTS5Ed7mnRRzdYEHXK438s0ojF00PwsYK8C0aC/ai8aum6fLk1j/R
	aBQcfw3fexgigQXOccIdiTQWdLLHwz8VLYTHot4crUgs+GJYHbsanZ3fwgzMJIT+sbqbjnYIyyO
	T9csOkUsSH6jh715VbDhzsnnmHmFpYk94HnT8xsAZkr+AY1Up1+NS+v2GJA+4GTqM6ExUon3hvZ
	vtCC/pQ32Kk/ymQX2M6BrgGGobn80lWGkySQP6C/JEqHlZzuSsx28/y+Wpq3+CElozPbKd75Xa9
	U/fSZICOJC7Azcc5vveNZwvKFHTENpo0IO+P8mipSySGmLjJwQrsQW5phXY96aGgUgPEuDqv0hn
	ymDOEw==
X-Received: by 2002:a53:d9c4:0:b0:664:ae68:ca0e with SMTP id 956f58d0204a3-664ae68d0d7mr1126045d50.84.1782500549034;
        Fri, 26 Jun 2026 12:02:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f74b145sm3346150d50.1.2026.06.26.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:28 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 05/10] repack: delete geometric packs via existing_packs
Message-ID: <51752a0ef9f0ac1a4027eee67375ce0914daff28.1782500507.git.me@ttaylorr.com>
References: <cover.1782500507.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782500507.git.me@ttaylorr.com>

Now that packs above the geometric split are marked as retained, teach
geometric repacks to use the existing_packs deletion machinery instead of
calling pack_geometry_remove_redundant().

This lets geometric repacks share the same mark-then-remove path as
all-into-one repacks: packs below the split are marked for deletion, and
packs above the split are ignored because they were retained earlier.

When doing a geometric repack without --combine-cruft-below-size, retain
all cruft packs before marking anything for deletion. Geometric repacks do
not rewrite cruft packs in that mode, so the common deletion path must not
remove them.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 11 +++++------
 repack.c         |  8 ++++++++
 repack.h         |  1 +
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 66b46b86896..dfb6fed231d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -574,10 +574,13 @@ int cmd_repack(int argc,
 				       packtmp);
 	/* End of pack replacement. */
 
-	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
+	if (delete_redundant) {
 		if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL)
 			existing_packs_retain_midx_packs(&existing, &geometry);
-		existing_packs_mark_for_deletion(&existing, &names);
+		if (geometry.split_factor && !combine_cruft_below_size)
+			existing_packs_retain_all_cruft(&existing);
+		if (pack_everything & ALL_INTO_ONE || geometry.split_factor)
+			existing_packs_mark_for_deletion(&existing, &names);
 	}
 
 	if (write_midx != REPACK_WRITE_MIDX_NONE) {
@@ -609,10 +612,6 @@ int cmd_repack(int argc,
 		existing_packs_remove_redundant(&existing, packdir,
 						wrote_incremental_midx);
 
-		if (geometry.split_factor)
-			pack_geometry_remove_redundant(&geometry, &names,
-						       &existing, packdir,
-						       wrote_incremental_midx);
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
diff --git a/repack.c b/repack.c
index c7b79a3c113..90797561954 100644
--- a/repack.c
+++ b/repack.c
@@ -242,6 +242,14 @@ static struct string_list_item *locate_existing_pack(struct string_list *list,
 	return item;
 }
 
+void existing_packs_retain_all_cruft(struct existing_packs *existing)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, &existing->cruft_packs)
+		existing_packs_mark_retained(item);
+}
+
 void existing_packs_retain_cruft(struct existing_packs *existing,
 				 struct packed_git *cruft)
 {
diff --git a/repack.h b/repack.h
index f0d082df9e8..90c89630ef8 100644
--- a/repack.h
+++ b/repack.h
@@ -81,6 +81,7 @@ void existing_packs_collect(struct existing_packs *existing,
 			    const struct string_list *extra_keep);
 int existing_packs_has_non_kept(const struct existing_packs *existing);
 int existing_pack_is_marked_for_deletion(struct string_list_item *item);
+void existing_packs_retain_all_cruft(struct existing_packs *existing);
 void existing_packs_retain_cruft(struct existing_packs *existing,
 				 struct packed_git *cruft);
 void existing_packs_retain_from_geometry(struct existing_packs *existing,
-- 
2.55.0.rc2.10.g29e31820dce

