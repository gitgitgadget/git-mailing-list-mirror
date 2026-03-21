Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A330C343
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774128546; cv=none; b=YTX65aJfvKbiJ5DfhJc1FTiKtR6Vk3Blell7RrmkTWu32xp2DcIeXTYf7wF2kp3d22XrjhwbmwPwlIiLxbEvfwIWGr9kt3vuTycK7jIxQC+SEp8TgQK39dNIFJEKG2ts70MrZ5ko+DL6t4zHw1VhrbvJ6zlfGPdKiBAZtXwT1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774128546; c=relaxed/simple;
	bh=6vdwHsiRe/sjRqBs8S24ipN67V/LcQ1TZ7hYD14+R0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtgnbWKyiMmjc1qbA0WEP6WZySKatFEqMEjwbe+VevpBiKyNLTHKbhyRg80iAJp/T2ZBuaJ7URosF+v9cuOUXcesQAVoH47Ud2Zdwrj+7A7iUzZ/JTHXXVHyBw1vjs7w0kFXghEs7OD7kaxGVJg7mp32yKxe/uthzEY9TZnVhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwqBT3QL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwqBT3QL"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b7c2788dso1024839f8f.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774128543; x=1774733343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gVs3GDvHVKyIqpKd1g8e2Ryjpm7jkYWzp030l7ZgS4I=;
        b=cwqBT3QLx4jl+HkQkHMrn+fFeUBwpNgGyKj02OnZt8x6ma2dqz0Z4nE3VUmyD/fOrF
         BHyLKnoO5WxhPjMnm/uisYl12PrvMrRgilp5TCTN6ANvlKFFWsp3KNQFWN7qFUbpZLyW
         xnVzI2yBaHeHMvBmgMQTG55B1+hrYrKGplwGLn02nwAOPi5fQha6F/Rlp4gDLe5l8o5u
         TU+2s9D+04Dv8avB4+E3jYBWY9nJ3XI5BVslpk44brdNWm79bJzL2gIbVjIwdAQI2yOO
         TyKczizermWriSfD8q39ChUu+cYppbTwFPLZL7cjPZgp7QMjs3OKtaOCzWUOc/pYV1xo
         +ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774128543; x=1774733343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVs3GDvHVKyIqpKd1g8e2Ryjpm7jkYWzp030l7ZgS4I=;
        b=rBQAVMsCGtPllpqW32fnsaee3f9yJLzu1/8rtxFRzftV9cwEzwqicKnovIa1/GFNnE
         uBz89JZFlMmlDKUv2k0x76+ZhV6G65D+NkROiZXmYLt/pDRY130F0Rpw1tIBPvVUwd+a
         nojqJ+l+SOg/FSBGnM09If608JUcV2Vc3gjL9Yp2kwvxP88GIwfVOkkXBgkztLh10ces
         /mXe+BI4m2XgqjgkirqudKg8lFF1gDkBIdaNRv4SVxQ6pMvUAv9u952YadDHCsnaBZuJ
         V+04td+M6Ay73KB0qTZ2Q/7EVMZOMecy0wQvUSnDsbtiBshYgQKvxiVtU2+23FSO7biT
         jSDA==
X-Gm-Message-State: AOJu0Yy/GMwv+eVJhzwvBSmvMVYbqdbiYAr+1VxZWj2TAiVmx1jcSG2O
	jCvT+eWTEo1KLA98CN7BTAeBjxE1YJGa/3qwoAQvbW42rv+wLyH0iUkcfKEgQoXD9xo=
X-Gm-Gg: ATEYQzyoffAXNQD908idjGjRRg63zz9tNKFyTEEuk0jeXrnWX4PqkeOeWkfyAk43BTB
	GXU4F6rmo7dhKBv0TAyVDhYxDrSDYY+z8DiM0AOeLwZgX1A/zx5VqT/DsZt45oIP/uXmL3IJar5
	UPF4+s3pfBHUO7Pywb8ZCVScqRvgOH4hYdSMbt+Stu7o/91d1+MhRE0bt38Ck0ywGz69xa5SMyu
	wQD9kgFToKCYI7Th1FLI2lPXdJcnKAj7kIilVHUikzteZJCGtEWxHnctrlEE8rs2KOGD6aew81s
	kjDTqKWf6I0MiuvuUnnLzfN4vhQ7fTev4cIC6NvA0ST8wrNVw/mK2OiZpTZMzU1M0Z80GX7y4Dz
	ONkSLzoXDV5TaDyRmyUFJwfaXD1RxUmvdNMR6kD16QNu/BZo76VDnJytNCAarLB971nw4uKoKFT
	wsgsi4F5jzdBEzDOd32+UobVGINe+Y1E0LbZ1EHiXmu6E=
X-Received: by 2002:a05:6000:2601:b0:43b:4352:1bd9 with SMTP id ffacd0b85a97d-43b64290e38mr11167070f8f.48.1774128543341;
        Sat, 21 Mar 2026 14:29:03 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470b243sm16541728f8f.26.2026.03.21.14.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 14:29:03 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:29:01 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 3/3] repack-promisor: preserve content of promisor files
 after repack
Message-ID: <6967066fe347cc2377d0f5dce14cfa7e569a8b66.1774125871.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>

When a repack involving promisor packfiles happens, the new ".promisor"
file is created empty, losing all the debug info that might be present
inside the ".promisor" files before the repack.

Use the "copy_all_promisor_files()" function created previously to
preserve the contents of all ".promisor" files inside the first
".promisor" file created by the repack.

Also, update the documentation accordingly.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/git-repack.adoc |  4 ++--
 repack-promisor.c             | 23 +++++++++++++++--------
 2 files changed, 17 insertions(+), 10 deletions(-)

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
index 90318ce150..6670728669 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -40,6 +40,7 @@ static void finish_repacking_promisor_objects(struct repository *repo,
 					      const char *packtmp)
 {
 	struct strbuf line = STRBUF_INIT;
+	int is_first_promisor = 1;
 	FILE *out;
 
 	close(cmd->in);
@@ -55,19 +56,25 @@ static void finish_repacking_promisor_objects(struct repository *repo,
 
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
 
+		/*
+		 * Fetch-pack sometimes generates non-empty .promisor files
+		 * containing the ref names and associated hashes at the point of
+		 * generation of the corresponding packfile. These pieces of info
+		 * are only used for debugging reasons. In order to preserve
+		 * these, let's copy the contents of all .promisor files in the
+		 * first promisor file created.
+		 */
+		if (is_first_promisor) {
+			copy_all_promisor_files(repo, promisor_name);
+			is_first_promisor = 0;
+		}
+
 		item->util = generated_pack_populate(item->string, packtmp);
 
 		free(promisor_name);
-- 
2.43.0

