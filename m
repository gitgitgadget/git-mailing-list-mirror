Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB7E376BFB
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774207122; cv=none; b=QXtS1OwuHYg8Fl4r5ydK4Uzw/RENk3rMbVVi9dIExlMMHkNn43kWAF8Gy+1ZxwG2qdLKrw3MwzjpkXoshqydR5p1ZjKsb0xEs0KyJQlaNELw63MwQPHzYJZeifov+/Hw7mAb50W+fB1miLSZeCJCxWq9HBUsTYWpqxkKGTlecbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774207122; c=relaxed/simple;
	bh=6vdwHsiRe/sjRqBs8S24ipN67V/LcQ1TZ7hYD14+R0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3piWx86RvPPUbyFNp1A9EcH/k2G6eje2rBMd6ixQ+HCiINsLGl0BfTGQGi/PLqlyOiONngVbbuT0e/WaOmexymnU0ud1V2imq5YLFL1ySA9JhUpQ425o7U+sRbGq4Tl6zHA4blSgRcZlYoFSNVpMp41fxGICrUP8fZnZ9m26yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5BhB3Cy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5BhB3Cy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so14920435e9.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774207117; x=1774811917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gVs3GDvHVKyIqpKd1g8e2Ryjpm7jkYWzp030l7ZgS4I=;
        b=I5BhB3Cyc1QzFbm9q+WH93a3cz0tf6dDHuLBmpqUxt9bPT4ekS8Bys18HYGvh7CXYk
         2JUyRv3KPnWRbb9GDcLb41cbWHgzjduB+03cHHvqqc1H/pQ180JRYf1mPqcu63avtK1Q
         0UUNNk+xkqzhWxhnInWdyu3ObX03hcJoJD/Uq5lEeYJr9GNYwcanHWkmIpsw8owE62in
         hQylQv+miWSuNdQj6pSIBrPHpNrYa3MJtbxtICQcmP+AduyiGOjRXpA4HNDdT2umIR9H
         4wyO974y8ZztZrSzEyG3oMQ3sP2CHspAO0kF9zbzl4fg0oXvaeZJJbcjLKV6zPeOCRRv
         KZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774207117; x=1774811917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVs3GDvHVKyIqpKd1g8e2Ryjpm7jkYWzp030l7ZgS4I=;
        b=l5OWwbKlDf5BiWocj2ebmsioAF+eX81trO5gWnRyVkqhRCL/CcawKRDwCfuh/VvBdL
         F72EHHQthYfhQsW44CKfXfCSCsiVH+kSL4JlwmdD1WpLNxxfdgJbib5XPZLWSX0Gh3UE
         4lSNJEBe5XAfXnxA7P2CAQFiTRcr09+u4znolaBFFI8SAUiPflc1TM8qQk986+hz7v1g
         XXkvNiEh4EOjnaoVd0P/U2vo61SJxqVQCu3t2JJlDmiKNvaT84cOF8esZHbCPm2lh+Oe
         cRpZAoQPsHfTNUK4e4D1FvvKNFrlVs/dBqxTgwcpLTMonFAmWaNnA5F0S0jdetJPoVgc
         FuKw==
X-Gm-Message-State: AOJu0Yx8687Me8ZdbEPQUpHKAD6TPFbHYp1R6jf2ZXsIImIEaP9lUNm3
	6TLy9qIQIq6uYzwrt/ankSFq/3crtIKYNedwimgtBIT6BchKjwVXKANGfZAUYtWVUyM=
X-Gm-Gg: ATEYQzwHToWYvKETzC5Q+CKcK1TRjPLv4l84MejF5kQUA9w+6pKGrEHMFUhXE1oFNaw
	avvls+HPst0uBmikJKoWSCA8goPZ01wUK3mNsGcfPRQwKa1WrJBCqwSEfsdqtfayb3/YpzVNKi1
	c1ZdTQYZ3V+BYeNfiWpixe401PtTAgrKasQ9YFRS3DpUiL9L6W3ub8ePTI5VtorDHMb8iZV5PWA
	wzxAMNbhaPwWYv7ImaTXWcdQa60fSrdYo3meeDqH6SzdLTCeiIG6JggQ61T/Nj0K1fa6iJjaCth
	zf2JWM2f7Q5mNq4L0GB8AE1mv2J0GFcPSmEdWqY/F+MtT03b7FDbWiJfeMmt5heblj2+vEYJyq7
	SzNdfXCHTD9USHBPkxR8pyc6p27VbTckxIP3aID8bpGSVPVE3mVcxpTg0pAdIarGXdEikflyWPA
	sA+5gxW2PhDgB7EYlaCoBJCpMZLDhsNA07
X-Received: by 2002:a05:600c:468b:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-486feb5f9c1mr149155345e9.0.1774207117468;
        Sun, 22 Mar 2026 12:18:37 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe82a33asm204802265e9.11.2026.03.22.12.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 12:18:36 -0700 (PDT)
Date: Sun, 22 Mar 2026 20:18:34 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v2 3/4] repack-promisor: preserve content of promisor
 files after repack
Message-ID: <3dab969a3942532f49f6f9cdcddb5fb2be11e232.1774205661.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>

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

