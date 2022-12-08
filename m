Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4826BC001B2
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 20:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiLHU50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 15:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLHU5S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 15:57:18 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26219492A
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 12:57:15 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x21-20020a62fb15000000b0057451601be4so1839507pfm.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 12:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9COKsWsMFvyCgnaK46XiQUNlyCim5hrhQEKx7wvmNjs=;
        b=EV8G+cXLW3ayH5E49Ptej36IQGbdg1Ey9zOhisR4HksYtzCwjKPW2mOM5qEl+vQPw6
         TSQ/RYfRTGo6sm36U3x/r5AggBj1dey6tvnls0DJToMJjV1qTUmaX2msvr9/fRrXYU0P
         XsAQIqrkJkKp3dHgZgoCRoXxsjdHkl7ZcFLEgcCN8ZlGxziM4oz1Wzz0XaS6QvXPt/pX
         hg0jN6WZVEbn3rPOjOwPAcdndkJ68f/QqnzANb3FaiO2mnbMt61GpGVDnbn0BT0Oi/jK
         u76RbOeIZAOZJUhWs+ADSyiliPFHAuSbK6bDwP1gfZBTCWJ/eBF2/VXO5KM5l/kyauv7
         FzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9COKsWsMFvyCgnaK46XiQUNlyCim5hrhQEKx7wvmNjs=;
        b=uwdodBPBnlv3evcB53LW5eIVoDTLP58HZ8oqy07nX1EHbSgwaDrFCTT1BrgywvWjyz
         8kuONaP5A2Ilks+jutMqXN42Qcr1bKPvwJl/PabBfuiqIWKIxLz358ZNv3I8RBLF/wZw
         tqTAVnwrSIb5VfL8P6MrtfDZmnxtbksZVPgwBEbEzrFroEpKKdcYM+LU656rQeAfhErP
         yUvbwaR0IIzK3IdkewSizvawD3c8Keh+yiRn5zVATFOwKbytsw4tP00YLgVjhsFjeQ01
         l+jz+kh8hPtEaFKC3j4uD6fvnh7pgWMfzssnfEa7kFeHR3PMApO7OCMCqHl5RciNlCdH
         +YAA==
X-Gm-Message-State: ANoB5plBc0oyUujTU5QE5sPPrDqzSB7hO/sjwDhgCn7IFZQwqKqMN5Ma
        fz257xH0Rije8AGTeTMuiP64tFE7Tw5ZwEOM9zudXMnL97wWSlWa0jily9iAgtkZIw+OdfeCLAO
        AyOBByFUrfy4aGskOEh3I5QLpIqzDB4SPxAyci7msKXVwk8+odIUvRkalLf6W7XD531+3QUoTLz
        /w
X-Google-Smtp-Source: AA0mqf5vyM4Bil5GxVBaS3s+M0a6J7jH3zk+PcKQL5sC5f0W+qV8oXcnNrHbu8Wuvc++Ws1SDDq1+r0gw4y7rZpxqGjv
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:c48:0:b0:470:1186:de85 with SMTP
 id 8-20020a630c48000000b004701186de85mr71527287pgm.609.1670533035082; Thu, 08
 Dec 2022 12:57:15 -0800 (PST)
Date:   Thu,  8 Dec 2022 12:57:04 -0800
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <cover.1670532905.git.jonathantanmy@google.com>
Subject: [PATCH v3 0/4] Don't lazy-fetch commits when parsing them
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        avarab@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your review. map_loose_object_1() definitely looks
less "busy" than before after following your suggestions.

Jonathan Tan (4):
  object-file: remove OBJECT_INFO_IGNORE_LOOSE
  object-file: refactor map_loose_object_1()
  object-file: emit corruption errors when detected
  commit: don't lazy-fetch commits

 commit.c       |  15 ++++++-
 object-file.c  | 111 +++++++++++++++++++++++++------------------------
 object-store.h |   7 ++--
 3 files changed, 73 insertions(+), 60 deletions(-)

Range-diff against v2:
1:  9ad34a1dce < -:  ---------- object-file: don't exit early if skipping loose
-:  ---------- > 1:  be0b08cac2 object-file: remove OBJECT_INFO_IGNORE_LOOSE
-:  ---------- > 2:  7419e4ac70 object-file: refactor map_loose_object_1()
2:  9ddfff3585 ! 3:  7c9ed861e7 object-file: emit corruption errors when detected
    @@ Commit message
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## object-file.c ##
    -@@ object-file.c: static int quick_has_loose(struct repository *r,
    -  * searching for a loose object named "oid".
    -  */
    - static void *map_loose_object_1(struct repository *r, const char *path,
    --			     const struct object_id *oid, unsigned long *size)
    -+				const struct object_id *oid, unsigned long *size,
    -+				char **mapped_path)
    - {
    - 	void *map;
    - 	int fd;
    -@@ object-file.c: static void *map_loose_object_1(struct repository *r, const char *path,
    - 		fd = git_open(path);
    - 	else
    - 		fd = open_loose_object(r, oid, &path);
    -+	if (mapped_path)
    -+		*mapped_path = xstrdup(path);
    -+
    - 	map = NULL;
    - 	if (fd >= 0) {
    - 		struct stat st;
    -@@ object-file.c: void *map_loose_object(struct repository *r,
    - 		       const struct object_id *oid,
    - 		       unsigned long *size)
    - {
    --	return map_loose_object_1(r, NULL, oid, size);
    -+	return map_loose_object_1(r, NULL, oid, size, NULL);
    - }
    - 
    - enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
     @@ object-file.c: static int loose_object_info(struct repository *r,
      {
      	int status = 0;
      	unsigned long mapsize;
    -+	char *mapped_path = NULL;
    ++	const char *path = NULL;
      	void *map;
      	git_zstream stream;
      	char hdr[MAX_HEADER_LEN];
    @@ object-file.c: static int loose_object_info(struct repository *r,
      	}
      
     -	map = map_loose_object(r, oid, &mapsize);
    --	if (!map)
    -+	map = map_loose_object_1(r, NULL, oid, &mapsize, &mapped_path);
    -+	if (!map) {
    -+		free(mapped_path);
    ++	map = map_loose_object_1(r, oid, &mapsize, &path);
    + 	if (!map)
      		return -1;
    -+	}
      
    - 	if (!oi->sizep)
    - 		oi->sizep = &size_scratch;
     @@ object-file.c: static int loose_object_info(struct repository *r,
      		break;
      	}
      
     +	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
     +		die(_("loose object %s (stored in %s) is corrupt"),
    -+		    oid_to_hex(oid), mapped_path);
    ++		    oid_to_hex(oid), path);
     +
      	git_inflate_end(&stream);
      cleanup:
    -+	free(mapped_path);
      	munmap(map, mapsize);
    - 	if (oi->sizep == &size_scratch)
    - 		oi->sizep = NULL;
     @@ object-file.c: static int do_oid_object_info_extended(struct repository *r,
      			continue;
      		}
    @@ object-file.c: int force_object_loose(const struct object_id *oid, time_t mtime)
      	if (!buf)
      		return error(_("cannot read object for %s"), oid_to_hex(oid));
      	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
    -@@ object-file.c: int read_loose_object(const char *path,
    - 	char hdr[MAX_HEADER_LEN];
    - 	unsigned long *size = oi->sizep;
    - 
    --	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
    -+	map = map_loose_object_1(the_repository, path, NULL, &mapsize, NULL);
    - 	if (!map) {
    - 		error_errno(_("unable to mmap %s"), path);
    - 		goto out;
     
      ## object-store.h ##
     @@ object-store.h: struct object_info {
    @@ object-store.h: struct object_info {
      #define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
      
     +/* Die if object corruption (not just an object being missing) was detected. */
    -+#define OBJECT_INFO_DIE_IF_CORRUPT 64
    ++#define OBJECT_INFO_DIE_IF_CORRUPT 32
     +
      int oid_object_info_extended(struct repository *r,
      			     const struct object_id *,
3:  c5fe42deb0 = 4:  5924a5120b commit: don't lazy-fetch commits
-- 
2.39.0.rc1.256.g54fd8350bd-goog

