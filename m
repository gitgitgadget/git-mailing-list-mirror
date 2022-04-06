Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF971C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 23:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiDFXYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiDFXYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 19:24:40 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A263BF
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 16:22:43 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id e2-20020a17090301c200b001545acd89c9so1846370plh.3
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 16:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=kqTweM9xZMPaxqFTwmJFToDna0FWAV6mbYyHgLIPjIE=;
        b=ktJSBldiiDgob5OnZ/0XqKkdnGZl9ziPGcp7e8najDeMPNrFHbXaHingopKH4j71Yh
         zmKod1/yaispVaqAS4nb+i9JCluH9ZTHg7RfK+Fg7gjjmfYSSUcMSc85oV9sFB9JhurP
         gYJtKE+OcUBarB+jUKAGPD/ZpNI8A0rA6o7jg0yV0fU6jHo2eDwNIX8zjIN3Adt7EjD2
         wpN7HwkstnHbH9ibzFFTmCLdpnktWeueRTJ9zbwXccUgb7KWFgXg6L2TPWshgoULtgP7
         CK8LYi0Q9F6qMFexZDY8mB020A7S9IK2djcuFRTBzTiQNokWvcbzItdVVL6IM/QOl1Ul
         GKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=kqTweM9xZMPaxqFTwmJFToDna0FWAV6mbYyHgLIPjIE=;
        b=ykLtn6OjNwQhCRHD8a4qq1i8jUTTLwRp3HGBMp5STSctTx3zN49aQ/XxJ3vLr+ujyW
         U39eQ/WzZSBLFD9mLciiG0dhpsmUeI63YFfeYrtuTRx5QstN+8pTW9uXWe88x4RmyTwS
         GFUvqLEVowuJgQkuFH9OACtJMUV9MM/iYenudbpm5TSb0Oy/6qkPkH23pHQnBaMbLeYj
         WWkkJuiSEiXVW/CwxCmSq/775PljmP/HNCCZqBzIjbK8NglUo8ldyt6vBYJFb8QgfPvr
         MvSOcEsG7NhAw0BE2xLql/pUfV3I2WukiWgKy8BxK2pObKkzIcci0Uwdld+Pl3YynRu1
         BPlg==
X-Gm-Message-State: AOAM533HcaKWHFNs1REXYXKF3Q5gpyqzuRrKWXO69UeYchpryJhDk9QA
        UbhJB8mne//SqqOTsIRRF/EAanwG+ZA1Jz1S6yrW1STooOL6E9qdn3/lVlU2Ptx3sUWDGz5yh+7
        OGpPe0qe9zCBmfkvIKKbELHQZvdM9guJAPrVFIMhg0Aw4fkNd00ZTPkll5DTOnhk=
X-Google-Smtp-Source: ABdhPJzPZE8FUGGKc7Z36Asa5GWUBpnvQCoonvoOvuD404l+r7dLtF/2613QbropVZzP2P8yep9m/11s0WUP3w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1bc6:b0:1c7:3229:652a with SMTP
 id oa6-20020a17090b1bc600b001c73229652amr12779320pjb.65.1649287362600; Wed,
 06 Apr 2022 16:22:42 -0700 (PDT)
Date:   Wed,  6 Apr 2022 16:22:31 -0700
In-Reply-To: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20220406232231.47714-1-chooglen@google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] fsck: detect bare repos in trees and warn
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="kjj whjj"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git tries not to distribute configs in-repo because they are a security
risk. However, an attacker can do exactly this if they embed a bare
repo inside of another repo.

Teach fsck to detect whether a tree object contains a bare repo (as
determined by setup.c) and warn. This will help hosting sites detect and
prevent transmission of such malicious repos.

See [1] for a more in-depth discussion, including future steps and
alternatives.

[1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.c=
orp.google.com/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 fsck.c          | 19 +++++++++++++++++++
 fsck.h          |  1 +
 setup.c         |  4 ++++
 t/t1450-fsck.sh | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/fsck.c b/fsck.c
index 3ec500d707..11c11c348a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -573,6 +573,9 @@ static int fsck_tree(const struct object_id *tree_oid,
 	int has_bad_modes =3D 0;
 	int has_dup_entries =3D 0;
 	int not_properly_sorted =3D 0;
+	int has_head =3D 0;
+	int has_refs_entry =3D 0;
+	int has_objects_entry =3D 0;
 	struct tree_desc desc;
 	unsigned o_mode;
 	const char *o_name;
@@ -602,6 +605,12 @@ static int fsck_tree(const struct object_id *tree_oid,
 		has_dotdot |=3D !strcmp(name, "..");
 		has_dotgit |=3D is_hfs_dotgit(name) || is_ntfs_dotgit(name);
 		has_zero_pad |=3D *(char *)desc.buffer =3D=3D '0';
+		has_head |=3D !strcasecmp(name, "HEAD")
+			&& (S_ISLNK(mode) || S_ISREG(mode));
+		has_refs_entry |=3D !strcasecmp(name, "refs")
+			&& (S_ISLNK(mode) || S_ISDIR(mode));
+		has_objects_entry |=3D !strcasecmp(name, "objects")
+			&& (S_ISLNK(mode) || S_ISDIR(mode));
=20
 		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
 			if (!S_ISLNK(mode))
@@ -739,6 +748,16 @@ static int fsck_tree(const struct object_id *tree_oid,
 		retval +=3D report(options, tree_oid, OBJ_TREE,
 				 FSCK_MSG_TREE_NOT_SORTED,
 				 "not properly sorted");
+	/*
+	 * Determine if this tree looks like a bare repository according
+	 * to the rules of setup.c. If those are changed, this should be
+	 * changed too.
+	 */
+	if (has_head && has_refs_entry && has_objects_entry)
+		retval +=3D report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_EMBEDDED_BARE_REPO,
+				 "contains bare repository");
+
 	return retval;
 }
=20
diff --git a/fsck.h b/fsck.h
index d07f7a2459..3f0f73b0f3 100644
--- a/fsck.h
+++ b/fsck.h
@@ -65,6 +65,7 @@ enum fsck_msg_type {
 	FUNC(NULL_SHA1, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
+	FUNC(EMBEDDED_BARE_REPO, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(GITIGNORE_SYMLINK, INFO) \
diff --git a/setup.c b/setup.c
index 04ce33cdcd..2600548776 100644
--- a/setup.c
+++ b/setup.c
@@ -336,6 +336,10 @@ int get_common_dir_noenv(struct strbuf *sb, const char=
 *gitdir)
  *  - either a HEAD symlink or a HEAD file that is formatted as
  *    a proper "ref:", or a regular file HEAD that has a properly
  *    formatted sha1 object name.
+ *
+ * fsck.c checks for bare repositories in trees using similar rules, but a
+ * duplicated implementation. If these are changed, the correspnding code =
in
+ * fsck.c should change too.
  */
 int is_git_directory(const char *suspect)
 {
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index de50c0ea01..a65827bc03 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -563,6 +563,42 @@ dot-backslash-case .\\\\.GIT\\\\foobar
 dotgit-case-backslash .git\\\\foobar
 EOF
=20
+test_expect_success "fsck notices bare repo" '
+(
+	mkdir -p embedded-bare-repo/bare &&
+	git init embedded-bare-repo &&
+	(
+		cd embedded-bare-repo/bare &&
+		echo content >HEAD &&
+		mkdir refs/ objects/ &&
+		echo content >refs/foo &&
+		echo content >objects/foo &&
+		git add . &&
+		git commit -m base &&
+		bad_tree=3D$(git rev-parse HEAD:bare) &&
+		git fsck 2>out &&
+		test_i18ngrep "warning.*tree $bad_tree: embeddedBareRepo: contains bare =
repository" out
+	)
+)'
+
+test_expect_success "fsck notices bare repo with odd casing" '
+(
+	mkdir -p embedded-bare-repo-case/bare &&
+	git init embedded-bare-repo-case &&
+	(
+		cd embedded-bare-repo-case/bare &&
+		echo content >heAD &&
+		mkdir Refs/ objectS/ &&
+		echo content >Refs/foo &&
+		echo content >objectS/foo &&
+		git add . &&
+		git commit -m base &&
+		bad_tree=3D$(git rev-parse HEAD:bare) &&
+		git fsck 2>out &&
+		test_i18ngrep "warning.*tree $bad_tree: embeddedBareRepo: contains bare =
repository" out
+	)
+)'
+
 test_expect_success 'fsck allows .=C5=87it' '
 	(
 		git init not-dotgit &&

base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
--=20
2.33.GIT

