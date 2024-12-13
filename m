Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2BE143759
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734117609; cv=none; b=VT3zEKwU0VGJa6M76eNwr5A841GG5Gk/k2SiwRjo9y9h0sieBVO+TG+HFVAXD0GpjpPkUI+HFXtLImMa2WFUL+PMfbKfgeQOV+DMOPGItENpjY3ClK3wLtAydgqzeP4uwMWoyWd4Ga9XE2FeeRtkSep596KL9nDNCLMM3tUaphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734117609; c=relaxed/simple;
	bh=5/TwBJq+3hdECY7FGu/zPdyyiKjk+KCKc7Ys1/LV0aU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gruHwniykfbhWHx7SxMNhsyMCfd/Tt9lZubuGNm10BUQyZ+GwEK2/w2UN/CTQlAt1l7zRkzd2vtIGk19+zUA5SX0liPBey2FA8d/pgoyiiOFJ4CSDpNqXb+7NyvMEtZwEzQjF8hW012uaZiBQ3b/3G+iSkwuM2raJwzyWlaMsww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XH5IExmX; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XH5IExmX"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef9b8b4f13so18335237b3.2
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 11:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1734117605; x=1734722405; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5IfZJuuiAsuLu6YcmXGvusB06Jq5ZZ5HPmgTb6IsuY=;
        b=XH5IExmXVJxJTx/Xxzn+mgLZ1tNViDTcqPXpu9LL+cyh35jaO9f5thNvSJ9bPloyLy
         RWLazp7iG/+SJGNDIK8bBNZQPbqnVcEk9uKtS4GNH7GULfodBLdULyIKmWDnMVXuycB4
         nXWVfGchvogaSxyBbsBPZJmqn+O9zj5eym1meezUyAwIuRDfOw2skUqT+LhieB7jO+/Q
         clMdO7B3Ps7j/0QinXIhoO4YIOuNqqTV2tAxvRwjdsNy5UCQhxg6gpIfa/ZK3seeF/wz
         ah5wzyzYfWodEgzONPZjL1vEdJX3wRx5nPm6ZiDZKf7SrvLjlghiSRQodJvmmN3mHvvr
         FsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734117605; x=1734722405;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5IfZJuuiAsuLu6YcmXGvusB06Jq5ZZ5HPmgTb6IsuY=;
        b=u3mf6Sz2pLJQNLASopVAISN7puWNgipnTMaQhcwQpceVxHlSk1nzY6sjk6ww4P7L1g
         Ch+r1oNCaJEolR1RfV2LCbre4dTJWrjbfBKYxZtGWNIjbNC/Gh6VK7xi88jm/SoJi1RY
         f3H3kQSfgR50xrpdapX+TiwjFdwevfb/YrivVPp2uILOw5ycnO2ZlJd8vAPas5pygaAF
         LQQINyLhOoI2btKfTX/fGN5i7+9VrE344JqCB+AjmPSdfqHUblYrt8WJxX8+W47GnKf9
         oxS0biC/1UCXxxP2likginNlhHj5EUOgPvipMRTi3PDP5aFTYNtfrgFVszL69Wb53P/g
         RbkA==
X-Gm-Message-State: AOJu0YwxOWSJ9ANxCqVjFOJ8tKyGAhzGRoYHgbX20MthVNlC8VHXNcph
	CJWYd+dwfdW5Y2qWrTmAGMUfO2X69Y8TYRt0puOsZSPdsPVznPYvJ+8hb9yKMFb4qxL7TwFyBOR
	06mM=
X-Gm-Gg: ASbGncumyymKoa0bH8mi2ncLvI9fTORi4gsw3P0e7Iho6oN+JCg0/ZGj7nweR6K3GLx
	ZdVQehYHSD0mlRTKz8xTBg24egalo97EjMUFx70Z7D6f9VkUs6xCouJHhysGjaTIsiPQgzSirUx
	dAkEeyOqoLXjmKnsjIkSOWqCrtrEDh9eStFdEKfbRNDVdlJ1kY6IJ6nn3AUn5mI4J4r4hY+6Qi+
	bQVOf/HYB0qEI+BgqnkYAM0IA0lgLsFVNOGKxMvWldaahuzrWaYJRXEutPyGbVzIiKslzDa5wLl
	uvkrh0W3IMr+TGbfhInhKxv/+x6s
X-Google-Smtp-Source: AGHT+IFcYESkzGt3S+CrnZjiQm1yZ644NEK+UEXS7wm2T3vKEums+Zv151IMQOV/G/R44fOWL/7LNA==
X-Received: by 2002:a05:690c:2902:b0:6ef:8f40:46bd with SMTP id 00721157ae682-6f279b15205mr37771797b3.22.1734117605296;
        Fri, 13 Dec 2024 11:20:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288fc51acsm489187b3.6.2024.12.13.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:20:04 -0800 (PST)
Date: Fri, 13 Dec 2024 14:20:02 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] pack-bitmap.c: ensure pack validity for all reuse packs
Message-ID: <7fdbfadc04926efc094633b238a55168c92e3d58.1734117577.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Commit 44f9fd6496 (pack-bitmap.c: check preferred pack validity when
opening MIDX bitmap, 2022-05-24) prevents a race condition whereby the
preferred pack disappears between opening the MIDX bitmap and attempting
verbatim reuse out of its packs.

That commit forces open_midx_bitmap_1() to ensure the validity of the
MIDX's preferred pack, meaning that we have an open file handle on the
*.pack, ensuring that we can reuse bytes out of verbatim later on in the
process[^1].

But 44f9fd6496 was not extended to cover multi-pack reuse, meaning that
this same race condition exists for non-preferred packs during verbatim
reuse. Work around that race in the same way by only marking valid packs
as reuse-able. For packs that aren't reusable, skip over them but
include the number of objects they have to ensure we allocate a large
enough 'reuse' bitmap (e.g. if a pack in the middle of the MIDX
disappeared but we still want to reuse later packs).

Since we're ensuring the validity of these packs within the verbatim
reuse code, we no longer have to special-case the preferred pack and
open it within the open_midx_bitmap_1() function.

An alternative approach to the one taken here would be to open all
MIDX'd packs from within open_midx_bitmap_1(). But that would be both
slower and make the bitmaps less useful, since we can still perform some
pack reuse among the packs that still exist when the *.bitmap is opened.

After applying this patch, we can simulate the new behavior after
instrumenting Git like so:

    diff --git a/packfile.c b/packfile.c
    index 9560f0a33c..aedce72524 100644
    --- a/packfile.c
    +++ b/packfile.c
    @@ -557,6 +557,11 @@ static int open_packed_git_1(struct packed_git *p)
     		; /* nothing */

     	p->pack_fd = git_open(p->pack_name);
    +	{
    +		const char *delete = getenv("GIT_RACILY_DELETE");
    +		if (delete && !strcmp(delete, pack_basename(p)))
    +			return -1;
    +	}
     	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
     		return -1;
     	pack_open_fds++;

and adding the following test:

    test_expect_success 'disappearing packs' '
            git init disappearing-packs &&
            (
                    cd disappearing-packs &&

                    git config pack.allowPackReuse multi &&

                    test_commit A &&
                    test_commit B &&
                    test_commit C &&

                    A="$(echo "A" | git pack-objects --revs $packdir/pack-A)" &&
                    B="$(echo "A..B" | git pack-objects --revs $packdir/pack-B)" &&
                    C="$(echo "B..C" | git pack-objects --revs $packdir/pack-C)" &&

                    git multi-pack-index write --bitmap --preferred-pack=pack-A-$A.idx &&

                    test_pack_objects_reused_all 9 3 &&

                    test_env GIT_RACILY_DELETE=pack-A-$A.pack \
                            test_pack_objects_reused_all 6 2 &&
                    test_env GIT_RACILY_DELETE=pack-B-$B.pack \
                            test_pack_objects_reused_all 6 2 &&
                    test_env GIT_RACILY_DELETE=pack-C-$C.pack \
                            test_pack_objects_reused_all 6 2

            )
    '

Note that we could relax the single-pack version of this which was most
recently addressed in dc1daacdcc (pack-bitmap: check pack validity when
opening bitmap, 2021-07-23), but only partially. Because we still need
to know the object count in the pack, we'd still have to open the pack's
*.idx, so the savings there are marginal.

Note likewise that we add a new "if (!packs_nr)" early return in the
pack reuse code to avoid a potentially expensive allocation on the
'reuse' bitmap in the case that no packs are available for reuse.

[^1]: Unless we run out of open file handles. If that happens and we are
  forced to close the only open file handle of a file that has been
  removed from underneath us, there is nothing we can do.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 683f467051..ff09b15eb7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -389,8 +389,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	struct stat st;
 	char *bitmap_name = midx_bitmap_filename(midx);
 	int fd = git_open(bitmap_name);
-	uint32_t i, preferred_pack;
-	struct packed_git *preferred;
+	uint32_t i;
 
 	if (fd < 0) {
 		if (errno != ENOENT)
@@ -445,18 +444,6 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		}
 	}
 
-	if (midx_preferred_pack(bitmap_git->midx, &preferred_pack) < 0) {
-		warning(_("could not determine MIDX preferred pack"));
-		goto cleanup;
-	}
-
-	preferred = bitmap_git->midx->packs[preferred_pack];
-	if (!is_pack_valid(preferred)) {
-		warning(_("preferred pack (%s) is invalid"),
-			preferred->pack_name);
-		goto cleanup;
-	}
-
 	return 0;
 
 cleanup:
@@ -2285,8 +2272,10 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 			if (!pack.bitmap_nr)
 				continue;
 
-			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
-			memcpy(&packs[packs_nr++], &pack, sizeof(pack));
+			if (is_pack_valid(pack.p)) {
+				ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
+				memcpy(&packs[packs_nr++], &pack, sizeof(pack));
+			}
 
 			objects_nr += pack.p->num_objects;
 		}
@@ -2320,16 +2309,22 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 			pack_int_id = -1;
 		}
 
-		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
-		packs[packs_nr].p = pack;
-		packs[packs_nr].pack_int_id = pack_int_id;
-		packs[packs_nr].bitmap_nr = pack->num_objects;
-		packs[packs_nr].bitmap_pos = 0;
-		packs[packs_nr].from_midx = bitmap_git->midx;
+		if (is_pack_valid(pack)) {
+			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
+			packs[packs_nr].p = pack;
+			packs[packs_nr].pack_int_id = pack_int_id;
+			packs[packs_nr].bitmap_nr = pack->num_objects;
+			packs[packs_nr].bitmap_pos = 0;
+			packs[packs_nr].from_midx = bitmap_git->midx;
+			packs_nr++;
+		}
 
-		objects_nr = packs[packs_nr++].bitmap_nr;
+		objects_nr = pack->num_objects;
 	}
 
+	if (!packs_nr)
+		return;
+
 	word_alloc = objects_nr / BITS_IN_EWORD;
 	if (objects_nr % BITS_IN_EWORD)
 		word_alloc++;

base-commit: caacdb5dfd60540ecec30ec479f147f3c8167e11
-- 
2.47.1.441.g7fdbfadc049
