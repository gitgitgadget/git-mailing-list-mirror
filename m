Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C676C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiLAT15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiLAT1p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:27:45 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC41329C92
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:27:43 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3b48b605351so25902017b3.22
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 11:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RN/hHorXE4h1LGy1HPs5RWPP6Hyui6R8TjabuvFI1BI=;
        b=Z8S39NQUWEGmZk+i2iiIKsQXbaLf+IY/zS2oC6lprUfANhefXo1vyys+Dk7I7SKxh8
         9IFYOEHavw8LBAHMP15r6IZLdMNuLn6FBPt8mNoPgxpHjpSLUeF8X+n18+/Gxi44WdzY
         2kHK1xGkDVwijGLtLsqhmcfBlPoS61PxAtbX/lErtpuliMgwNzCkm4O3onHGPgh0neda
         zW7L48g0wgoptlg32Qk7TIn7v9vkCqIxzTmFgOoVH1Bh5yDuddxUfwk3hMbdmWqIgic8
         igGuLlfagsjwQ5KXC2mebW784j1Ty4uNFr+SRsjswWQbzNYY8eGvxR6FAk2qzpVNlLwm
         pZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RN/hHorXE4h1LGy1HPs5RWPP6Hyui6R8TjabuvFI1BI=;
        b=7nJOdhF+JN7osbZ40YupvKXlJArh6OsupvWOOwEj/ywUHpWRvqjfsou867uQOGIVV4
         BD740IZeYfiWF/tlzCJIOK7aX+jyIY7qqfp+27IUQIahiIXX+6RqNm48tnWkBoJPZRT/
         IRVex3pyuEWp5zTKbWGmcElHhE+JypbgnqkAkTuvHU3vZtQGVR+YejQZhBxinA3V5Obz
         OY2sOcPzVYPGtFjB/VEFhVwOVWFfPswf4KOUg4C8iAEOXEOfl5OWVu+9jse/gyqFXHzU
         6t3Huk8hK/LxLYAv2ojpaxJavEaJ+2oTrQlWWU+bsKFDefTSuiKb0/Xr75VZSZCnGvlf
         moyg==
X-Gm-Message-State: ANoB5pnC90lkk5rOTeoX8ZNHHFM9WJZUFfzdYAblYosXNRcZxwjAgDkD
        izGGQLjoUnbxZ3q6AKSo39ku6WqLewa5IN8y4TLamie6kYpOTKXHSRfH3sRx+aqRnWJCjXBJI2Y
        kju/fXxdcb6E9gwIHIqMwHDX92eMO35qMYK6X4sgB/zCZr+bHBqBLqP89KaW8adU9ppOxmdA59L
        gj
X-Google-Smtp-Source: AA0mqf4whqJsTt5kmp3pbAtP9j0pIBaWjp9+XSmpTntzZcJ1LwMGrcubq9VlKXXThn2v/+vDn2miYwTElCmEYVr+5eoz
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:5d5:0:b0:6f9:5e19:4729 with SMTP
 id 204-20020a2505d5000000b006f95e194729mr12850595ybf.311.1669922862409; Thu,
 01 Dec 2022 11:27:42 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:27:33 -0800
In-Reply-To: <cover.1669922792.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1669922792.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <a38229c42ae1dec4dcc52e6dc949f4a90846129d.1669922792.git.jonathantanmy@google.com>
Subject: [PATCH v2 4/4] commit: don't lazy-fetch commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing commits, fail fast when the commit is missing or
corrupt, instead of attempting to fetch them. This is done by inlining
repo_read_object_file() and setting the flag that prevents fetching.

This is motivated by a situation in which through a bug (not necessarily
through Git), there was corruption in the object store of a partial
clone. In this particular case, the problem was exposed when "git gc"
tried to expire reflogs, which calls repo_parse_commit(), which triggers
fetches of the missing commits.

(There are other possible solutions to this problem including passing an
argument from "git gc" to "git reflog" to inhibit all lazy fetches, but
I think that this fix is at the wrong level - fixing "git reflog" means
that this particular command works fine, or so we think (it will fail if
it somehow needs to read a legitimately missing blob, say, a .gitmodules
file), but fixing repo_parse_commit() will fix a whole class of bugs.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 commit.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 572301b80a..17e71f5be4 100644
--- a/commit.c
+++ b/commit.c
@@ -508,6 +508,13 @@ int repo_parse_commit_internal(struct repository *r,
 	enum object_type type;
 	void *buffer;
 	unsigned long size;
+	const struct object_id *real_oid;
+	struct object_info oi = {
+		.typep = &type,
+		.sizep = &size,
+		.contentp = &buffer,
+		.real_oidp = &real_oid,
+	};
 	int ret;
 
 	if (!item)
@@ -516,11 +523,18 @@ int repo_parse_commit_internal(struct repository *r,
 		return 0;
 	if (use_commit_graph && parse_commit_in_graph(r, item))
 		return 0;
-	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
-	if (!buffer)
+
+	/*
+	 * Git does not support partial clones that exclude commits, so set
+	 * OBJECT_INFO_SKIP_FETCH_OBJECT to fail fast when an object is missing.
+	 */
+	if (oid_object_info_extended(r, &item->object.oid, &oi,
+	    OBJECT_INFO_LOOKUP_REPLACE | OBJECT_INFO_SKIP_FETCH_OBJECT) < 0) {
+		die_if_corrupt(r, &item->object.oid, real_oid);
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
+	}
 	if (type != OBJ_COMMIT) {
 		free(buffer);
 		return error("Object %s not a commit",
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

