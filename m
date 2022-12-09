Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B0C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 21:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLIVod (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIVob (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 16:44:31 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE78303EF
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 13:44:30 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id jc4-20020a17090325c400b00189ceee4049so5177047plb.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 13:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vaHs/6uz6xN9Hj9JCOiUwWBi81CnrWwQtZGGEW7p7jc=;
        b=EGopmfhVSUUJcExEkkZ7K6v2eAk1dA4ciN4YyU1lImqzoP6adxwooUaXvoDG4xLKEe
         w1uXOlIVc9vJgQC8qq1FDkoLf9HUdUujcYfDAYk9H4VqKB8jiorXmNw+b7enYBO7U+ze
         Mjv6XDKQ4Z/cd+l13j0exN0jndayTLTHsHVzg2uEPJ6GoRomA+G2rV3GPgwr+ZQ3Ncfr
         pFOAZ8KN1MCL6yjoNVwV9u3yrazxZj8ZiFlNUGpiqy/qspKv/ZJ6Qcb6HJpBP0L2CkYJ
         hWAV9ODjrVj+htgwwNjU+KAUC1M7oojc6t3YcArwtOsoawwYqJR8QFgrVlgXA5CC77op
         VBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaHs/6uz6xN9Hj9JCOiUwWBi81CnrWwQtZGGEW7p7jc=;
        b=m5YcLri8S/N6nA0KRNKfBGMLVqPCNSLOzyjmsGrfeGWJv1y4iaT6TrBrjpfHWeYApl
         dKLYRpBsmEIJQjni1yJ3NgO8TOnps9/8Spt//lDQlnCDqADdoMTWJw/JcyBwliFiUV/q
         3B5bV9pAP91Yu2FzeWo0WPxWm1zUYuVywYjbLGzvxGan3/h0vRezhY/FGnlXERI4Ao2b
         QHy3xngsEc8LQnXqBYblgsDah+65hg2eHsG4GXoJm5xoVDvoLhjsfHza+7btBcNRXNP/
         uZLcGK4BdYgP6ZPiuWk1bqmfpydVi4quL1rPevde6QkB/OklQy47BwDFHTCT2zp7GZ+l
         iMXw==
X-Gm-Message-State: ANoB5pmHilnhz8VHKe9GRR1LZS+zmM68uC74YysdPlsR6g7LwWJtEdfM
        g1t8NpduVY8JCD+p0iS5BNrPqwSE6J9QzRdD+PSKoQ0lKB+KKqwJM4I5kFZ/afQWhVZo0AMF8S1
        I2le6CY9VZEvymtopXnprjvD+Iqsk2zg1uYSYfoJRidwhlRgwBbOqGMff5GAstJLJI48w/566sl
        tI
X-Google-Smtp-Source: AA0mqf6i+XrGlK3E5W8ubJ95HKkGq+75AVQl7RNYazDeS8dMw5syt1euZRf59ge5qqRNvNK2VR7S1e5FqtaSmn+pfIFV
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:f707:b0:176:b0ce:3472 with
 SMTP id h7-20020a170902f70700b00176b0ce3472mr90350561plo.169.1670622269720;
 Fri, 09 Dec 2022 13:44:29 -0800 (PST)
Date:   Fri,  9 Dec 2022 13:44:21 -0800
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <cover.1670622176.git.jonathantanmy@google.com>
Subject: [PATCH v4 0/4] Don't lazy-fetch commits when parsing them
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for your comments. Here's a reroll.

Jonathan Tan (4):
  object-file: remove OBJECT_INFO_IGNORE_LOOSE
  object-file: refactor map_loose_object_1()
  object-file: emit corruption errors when detected
  commit: don't lazy-fetch commits

 commit.c       |  15 ++++++-
 object-file.c  | 108 ++++++++++++++++++++++++-------------------------
 object-store.h |   7 ++--
 3 files changed, 69 insertions(+), 61 deletions(-)

Range-diff against v3:
1:  be0b08cac2 = 1:  be0b08cac2 object-file: remove OBJECT_INFO_IGNORE_LOOSE
2:  7419e4ac70 ! 2:  4b2fb68743 object-file: refactor map_loose_object_1()
    @@ Commit message
          2. Simultaneously gets a path and fd given an OID
          3. Memory maps an fd
     
    -    Split this function up. Only one caller needs 1, so inline that. As for
    -    2, a future patch will also need this functionality and, in addition,
    -    the calculated path, so extract this into a separate function with an
    -    out parameter for the path.
    +    Keep 3 (renaming the function accordingly) and inline 1 and 2 into their
    +    respective callers.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
    @@ object-file.c: static int quick_has_loose(struct repository *r,
      	return map;
      }
      
    -+static void *map_loose_object_1(struct repository *r,
    -+				const struct object_id *oid,
    -+				unsigned long *size,
    -+				const char **path)
    -+{
    +@@ object-file.c: void *map_loose_object(struct repository *r,
    + 		       const struct object_id *oid,
    + 		       unsigned long *size)
    + {
    +-	return map_loose_object_1(r, NULL, oid, size);
     +	const char *p;
     +	int fd = open_loose_object(r, oid, &p);
     +
     +	if (fd < 0)
     +		return NULL;
    -+	if (path)
    -+		*path = p;
     +	return map_fd(fd, p, size);
    -+}
    -+
    - void *map_loose_object(struct repository *r,
    - 		       const struct object_id *oid,
    - 		       unsigned long *size)
    - {
    --	return map_loose_object_1(r, NULL, oid, size);
    -+	return map_loose_object_1(r, oid, size, NULL);
      }
      
      enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
3:  7c9ed861e7 ! 3:  07d28db92c object-file: emit corruption errors when detected
    @@ Commit message
         which an indirect caller of do_oid_object_info_extended() will need
         such functionality.
     
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## object-file.c ##
     @@ object-file.c: static int loose_object_info(struct repository *r,
    + 			     struct object_info *oi, int flags)
      {
      	int status = 0;
    ++	int fd;
      	unsigned long mapsize;
    -+	const char *path = NULL;
    ++	const char *path;
      	void *map;
      	git_zstream stream;
      	char hdr[MAX_HEADER_LEN];
    +@@ object-file.c: static int loose_object_info(struct repository *r,
    + 	 * object even exists.
    + 	 */
    + 	if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
    +-		const char *path;
    + 		struct stat st;
    + 		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
    + 			return quick_has_loose(r, oid) ? 0 : -1;
     @@ object-file.c: static int loose_object_info(struct repository *r,
      		return 0;
      	}
      
     -	map = map_loose_object(r, oid, &mapsize);
    -+	map = map_loose_object_1(r, oid, &mapsize, &path);
    ++	fd = open_loose_object(r, oid, &path);
    ++	if (fd < 0) {
    ++		if (errno != ENOENT)
    ++			error_errno(_("unable to open loose object %s"), path);
    ++		return -1;
    ++	}
    ++	map = map_fd(fd, path, &mapsize);
      	if (!map)
      		return -1;
      
    @@ object-file.c: static void *read_object(struct repository *r,
      	oi.contentp = &content;
      
     -	if (oid_object_info_extended(r, oid, &oi, 0) < 0)
    -+	if (oid_object_info_extended(r, oid, &oi,
    -+				     die_if_corrupt ? OBJECT_INFO_DIE_IF_CORRUPT : 0)
    -+	    < 0)
    ++	if (oid_object_info_extended(r, oid, &oi, die_if_corrupt
    ++				     ? OBJECT_INFO_DIE_IF_CORRUPT : 0) < 0)
      		return NULL;
      	return content;
      }
4:  5924a5120b = 4:  1a0cd5b244 commit: don't lazy-fetch commits
-- 
2.39.0.rc1.256.g54fd8350bd-goog

