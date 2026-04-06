Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D917AE11
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775435111; cv=none; b=RQ9v3cQ7IHqPeTNKFY7ymXYiAcAfD3x6W3gMq6VQdoEewcETZvWzy1f14yirjwpz4ZCQqdOWO3d7FUop9sh5T4XnblAmGJz2vbadn43fhAS/CMJhD/4y6qzHWiW5ds5Qy3yZdD21VD0erxgNr5zEx+Xk/7lLfBjBqSd9j/3r1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775435111; c=relaxed/simple;
	bh=rIZ7id8YEG0likOiC4Mzxk+WYJfcFgWI0NNHYxb18Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onQHuhzU5fdJCysVEkFMPo+Sow1e1fIlxkV6uLD7hgmdPadXyilZ7OyONPZl6K6OPbgmvCigkNlSM53yyrdT0ErUE9YYsUVdsOhUi35/stETbjJktsNd3wb29MOfTEtZMlwMsaAIR/0KEyutDImoVVWBXVyrSrTyOC0jvglGmS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4T80Two; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4T80Two"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf906b007so1827408f8f.0
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775435108; x=1776039908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzzUk7TGBxN0Oao5JVJhj+llQ/FROGnFo17iVNGidN4=;
        b=K4T80TwoIDbPyD61CFe42fXZwkmhc5AEdyg5Fb+vbWn+9UD9bW76oZv0KE0xd3SmMy
         eOGkr4Dt5v1e8f6vzpxhVWwZNmwgWg0tIzJp5dX6degFwApFBww7Tsg+IGWW1BT4JIJd
         Sryvs5O9Vx5BkVB0/ni5MzDjpOXondRGm0mXjFt6mWbfkiM7nQj6kbz7P47TUBYLBc1u
         bWhjA1btFkDIaZFj/Kdgrfk7c4Cu1tRV8Lug3gs9IatYYkAgfM1WnmjEIax57wJ7kgfE
         LSVlB+Lk0RKS15UNnlQ1sVmDcqEaui8R7PgTSBu165e5SmUKOTKhsB2KnC0tvIexmDFg
         D+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775435108; x=1776039908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzzUk7TGBxN0Oao5JVJhj+llQ/FROGnFo17iVNGidN4=;
        b=eSr2kvTfMRdv7vQBfF0IA82xolfLBdjLtS7Kft7wrW4ZYwKgORKTXD+NPJb1oEsemY
         xYT6l7insGu3ALvH+w6e5Eb1gh11vjqCSsskKckEXfOarKhi3qD0JzxHZ34uwbHV/nFJ
         t2SNgpIFsCJp8D90uIpTo4XwrnN4QH2xy9mc2fuD/QyNDSe9iSplOxx7U4TTDLyi22qY
         LJIS9Pr8PdXJQObYP3Ww6fXc5Sgeyhm3pO5MXZFPklZTDjqV0OE9Ejf7dIpFerJBonqM
         1luzFd0jnNtEy5BWDTrQTza8/yV+qwRf+MWbGUvcJQm+DVvy+cQAHmlrvBz7k31DA9sZ
         GPzA==
X-Gm-Message-State: AOJu0YzVL79m9NwHBenaRAtAOi7IKx9fhW7zMCixyLg/UPyEWx6hQNS2
	TMs97xgdkd9AjaERK2PcH7B5FrdSOtZzasA/zswFzM4PLb1jykIOuOBNWW64yNxd30w=
X-Gm-Gg: AeBDieu/Ra5G4LxC8ytdNQfDLJfHk75RTix5ZBp0wKPE3M9DSNq95zA2yWGfDb99CJZ
	0CvL85OtC6ikN+UFJv2e37uktjrFwy2aVOSDlbwos3YV8vqiqVoh0XvfwwYDk3QKRfuV4/RDVUF
	S/jCiZH3ET/86w/vEJCxPqZOsrQUTGWoMvOAEpmbGsOQ4vQZb07MA2KTTPDuYJQbMZFatRPW1Yz
	I2RJwlBLy35NKVbcTEnJjFh3DjK+SD6gK2uPaeEiT/9mKH02cY6gpenBts104ZTQ/oLOO2xejje
	V+ZlfH61HQdvQlxSMHXBC0f16Zpka5XB/Pajo6UdYZi2TU5dr5E1S2QooW48Fm1dHrtuw/kzTGA
	YByWVFc3bXQeGvAC5H+33Llr+fRyCiXF2pP+TKGRfyZIHo4P53BQju69BAiYrRI4TpWw9TBHePm
	X6OjdyHoWuSPPATUiownGGcKeRLJGsB8tR
X-Received: by 2002:a05:6000:2c12:b0:43c:ff58:35c8 with SMTP id ffacd0b85a97d-43d292cba3dmr16332366f8f.28.1775435108138;
        Sun, 05 Apr 2026 17:25:08 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm36480549f8f.4.2026.04.05.17.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 17:25:07 -0700 (PDT)
Date: Mon, 6 Apr 2026 02:25:06 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v3 3/5] repack-promisor: preserve content of promisor
 files after repack
Message-ID: <c16b1198fdcf3ad9aaaf6f9436fe7558980edc73.1775431990.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>

When a repack involving promisor packfiles happens, the new ".promisor"
file is created empty, losing all the debug info that might be present
inside the ".promisor" files before the repack.

Use the "copy_promisor_content()" function created previously to preserve
the contents of all ".promisor" files inside the first ".promisor" file
created by the repack.

For geometric repacking, we have to create a `strset` that contains the
basenames of all excluded packs. For "normal" repacking this is not
necessary, since there should be no excluded packs.

Also, update the documentation accordingly.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/git-repack.adoc |  4 ++--
 repack-promisor.c             | 30 +++++++++++++++++-------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 673ce91083..33d3c8afbd 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -45,8 +45,8 @@ other objects in that pack they already have locally.
 +
 Promisor packfiles are repacked separately: if there are packfiles that
 have an associated ".promisor" file, these packfiles will be repacked
-into another separate pack, and an empty ".promisor" file corresponding
-to the new separate pack will be written.
+into another separate pack, and a ".promisor" file corresponding to the
+new separate pack will be written (with arbitrary contents).
 
 -A::
 	Same as `-a`, unless `-d` is used.  Then any unreachable
diff --git a/repack-promisor.c b/repack-promisor.c
index 6da452e8ff..37502e0023 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -156,7 +156,8 @@ static void copy_promisor_content(struct repository *repo,
 static void finish_repacking_promisor_objects(struct repository *repo,
 					      struct child_process *cmd,
 					      struct string_list *names,
-					      const char *packtmp)
+					      const char *packtmp,
+					      struct strset *not_repacked_basenames)
 {
 	struct strbuf line = STRBUF_INIT;
 	FILE *out;
@@ -174,19 +175,15 @@ static void finish_repacking_promisor_objects(struct repository *repo,
 
 		/*
 		 * pack-objects creates the .pack and .idx files, but not the
-		 * .promisor file. Create the .promisor file, which is empty.
-		 *
-		 * NEEDSWORK: fetch-pack sometimes generates non-empty
-		 * .promisor files containing the ref names and associated
-		 * hashes at the point of generation of the corresponding
-		 * packfile, but this would not preserve their contents. Maybe
-		 * concatenate the contents of all .promisor files instead of
-		 * just creating a new empty file.
+		 * .promisor file. Create the .promisor file.
 		 */
 		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
 					  line.buf);
 		write_promisor_file(promisor_name, NULL, 0);
 
+		/* Now let's fill the content of the newly created .promisor file */
+		copy_promisor_content(repo, line.buf, packtmp, not_repacked_basenames);
+
 		item->util = generated_pack_populate(item->string, packtmp);
 
 		free(promisor_name);
@@ -226,7 +223,7 @@ void repack_promisor_objects(struct repository *repo,
 		return;
 	}
 
-	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
+	finish_repacking_promisor_objects(repo, &cmd, names, packtmp, NULL);
 }
 
 void pack_geometry_repack_promisors(struct repository *repo,
@@ -237,6 +234,7 @@ void pack_geometry_repack_promisors(struct repository *repo,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *in;
+	struct strset not_repacked_basenames = STRSET_INIT;
 
 	if (!geometry->promisor_split)
 		return;
@@ -250,9 +248,15 @@ void pack_geometry_repack_promisors(struct repository *repo,
 	in = xfdopen(cmd.in, "w");
 	for (size_t i = 0; i < geometry->promisor_split; i++)
 		fprintf(in, "%s\n", pack_basename(geometry->promisor_pack[i]));
-	for (size_t i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++)
-		fprintf(in, "^%s\n", pack_basename(geometry->promisor_pack[i]));
+	for (size_t i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++) {
+		const char *name = pack_basename(geometry->promisor_pack[i]);
+		fprintf(in, "^%s\n", name);
+		strset_add(&not_repacked_basenames, name);
+	}
 	fclose(in);
 
-	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
+	finish_repacking_promisor_objects(repo, &cmd, names, packtmp,
+			strset_get_size(&not_repacked_basenames) ? &not_repacked_basenames : NULL);
+
+	strset_clear(&not_repacked_basenames);
 }
-- 
2.53.0.585.g1533fa96a8

