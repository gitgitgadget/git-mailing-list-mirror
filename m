Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAE9C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6462086A
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVwaqVeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHEXHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHEXHD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 19:07:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32881C061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 16:07:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g127so15057405ybf.11
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dxfeIGH221XMLr4o9HpO94QXkExVdJ0qzWlq5Oab7Go=;
        b=mVwaqVeY4bY8TFkQDB/tfqJ5UBHK2w27IPhhQBvZ5s21qZr/+KzQN6NNW6m0Nt8w+t
         SrN9+kf5de07ECG8q2u2JWJCymSeetrocTjqJRYYDfO1nF1wLc46H6cD/RiQKDABJQqN
         0E4sU2XYchDlrodiJ4w/b0zi6MiS37QptGIxZ44WIyB4RZ4baBd4ZLKjs6/BQutS/DqS
         zCUEG0GXFTAdKnSLIntjkPVGSfrBrE0g98Xi4pG9IsUzxAANGom7NF3qVJ3syBfab0Lx
         hiSFf7ojsR1bC1eBodPkcXlMHvrsTkp5htegvaoxSXl9CoWD7eOoNYIAyWfb4kkfqi65
         EyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dxfeIGH221XMLr4o9HpO94QXkExVdJ0qzWlq5Oab7Go=;
        b=AJ+/x+OzHQMqwTHrrt0/ZNJ52P4lX5OCleQv4dMGyut56xqbShWvHXcxm2M5uwOuj/
         1Eu+Ve+Rc/NrfUB/ioo+uOFuXC3gzDkFtcRsZoGTK8w7423liEOJUKnEp08yWLelcCus
         1TFULW5HTctMOyV7Kos6LbpI3SfkfHuqKbDl57rYmfWlp1FiFwP7XczK7jj1AqOvPTqj
         UjT1kuANp794GzWh2g1jDAm1QAiyOgvpkUyKzBoeKeThCJ/wAOwnKH6qCuc0GYp4yn6b
         0TLu3OdofoSOJ/tlXE7VLTDKUdsU4SU0P7Cnr038rVMwwJJS+RKSPpSrp5Z8Nqkgo7P+
         y41Q==
X-Gm-Message-State: AOAM533M8hUE26FULoifO6eqmwzUq2RSIEbw1iWNP3c7jvx6khI6+paz
        yCFjjxMp7KzNKhVnNPDrH3IaTPRbCjLKZ6vLoj5KAyBAT4CUJyHTba98q3IOudvaSM5D/lM8U8r
        Q1fwaf4bkdHyI/7YnBqBcTkhoUJ7fVez0bs3XkD/Gt+OmTG3oc/AjFH/1ikq+s9/b9lK665zFrS
        hx
X-Google-Smtp-Source: ABdhPJwLaRlR1CTyd0qfZDF80Vram4vyEWeNeyWFjHyxAhVJ3tBjrJ6BXt0czZP8Qb229ajBGt68cy0BU9W310eeZtVA
X-Received: by 2002:a05:6902:706:: with SMTP id k6mr8698266ybt.416.1596668822302;
 Wed, 05 Aug 2020 16:07:02 -0700 (PDT)
Date:   Wed,  5 Aug 2020 16:06:51 -0700
In-Reply-To: <cover.1596668156.git.jonathantanmy@google.com>
Message-Id: <1b5e1f02d29b990497ad274e1e67b072feb77eec.1596668156.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200728010403.95142-1-jonathantanmy@google.com> <cover.1596668156.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 3/4] pack-objects: no fetch when allow-{any,promisor}
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The options --missing=allow-{any,promisor} were introduced in caf3827e2f
("rev-list: add list-objects filtering support", 2017-11-22) with the
following note in the commit message:

    This patch introduces handling of missing objects to help
    debugging and development of the "partial clone" mechanism,
    and once the mechanism is implemented, for a power user to
    perform operations that are missing-object aware without
    incurring the cost of checking if a missing link is expected.

The idea that these options are missing-object aware (and thus do not
need to lazily fetch objects, unlike unaware commands that assume that
all objects are present) are assumed in later commits such as 07ef3c6604
("fetch test: use more robust test for filtered objects", 2020-01-15).

However, the current implementations of these options use
has_object_file(), which indeed lazily fetches missing objects. Teach
these implementations not to do so. Also, update the documentation of
these options to be clearer.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-pack-objects.txt | 11 +++++++----
 builtin/pack-objects.c             |  4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index eaa2f2a404..54d715ead1 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -270,15 +270,18 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	This option specifies how missing objects are handled.
 +
 The form '--missing=error' requests that pack-objects stop with an error if
-a missing object is encountered.  This is the default action.
+a missing object is encountered.  If the repository is a partial clone, an
+attempt to fetch missing objects will be made before declaring them missing.
+This is the default action.
 +
 The form '--missing=allow-any' will allow object traversal to continue
-if a missing object is encountered.  Missing objects will silently be
-omitted from the results.
+if a missing object is encountered.  No fetch of a missing object will occur.
+Missing objects will silently be omitted from the results.
 +
 The form '--missing=allow-promisor' is like 'allow-any', but will only
 allow object traversal to continue for EXPECTED promisor missing objects.
-Unexpected missing object will raise an error.
+No fetch of a missing object will occur.  An unexpected missing object will
+raise an error.
 
 --exclude-promisor-objects::
 	Omit objects that are known to be in the promisor remote.  (This
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7016b28485..2a2afb7cb1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3016,7 +3016,7 @@ static void show_object__ma_allow_any(struct object *obj, const char *name, void
 	 * Quietly ignore ALL missing objects.  This avoids problems with
 	 * staging them now and getting an odd error later.
 	 */
-	if (!has_object_file(&obj->oid))
+	if (!has_object(the_repository, &obj->oid, 0))
 		return;
 
 	show_object(obj, name, data);
@@ -3030,7 +3030,7 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
 	 * Quietly ignore EXPECTED missing objects.  This avoids problems with
 	 * staging them now and getting an odd error later.
 	 */
-	if (!has_object_file(&obj->oid) && is_promisor_object(&obj->oid))
+	if (!has_object(the_repository, &obj->oid, 0) && is_promisor_object(&obj->oid))
 		return;
 
 	show_object(obj, name, data);
-- 
2.28.0.236.gb10cc79966-goog

