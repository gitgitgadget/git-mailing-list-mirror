Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB435C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiFFRyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiFFRyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:54:43 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B852F9AD7
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:54:42 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id lw3-20020a17090b180300b001e31fad7d5aso12387809pjb.6
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=zE7mR/vFtOCJ4k2mHp4GJfPgTPP87f/5FyBUhl0YnW4=;
        b=dUJQnvaRbTxnnFQPgQ/tlnLjOran+Pt0ZTVAGf/MZa3rG5tDq5VXCevhqlX5ljusoq
         ygtDI0WX8T5ItzL0k2FS/NR9s2U/s076PcrzD/Ejjl0psQ2LUP6QIWWf4kR7cn9TEHNi
         qkV82pdGAls691UDdnFE7mz06TxY1U+te5HNPLU4Nq6K70nCNJOFXGNhSwI4vj7wOYRh
         hOZT7z7ccWgycSPH4iZSYjo4WXfnT0HodWNaSSiB42GWxFnqCie1eggZwK7K7dXQgZmq
         7vw02mNKlduobrAVBioIL6N1bRmOTu/DF8WzFfyu8N5NNacgp2pgWkQFuZDbFrpnit7U
         JXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=zE7mR/vFtOCJ4k2mHp4GJfPgTPP87f/5FyBUhl0YnW4=;
        b=akXMuGj4/oHEq4sAHxdJdYCviSvz/MBvY5VzjRDTXqLwl7Dk9RBATjQB+AW8/CikA5
         N4p7omfB4xOx8tlZ2ty3CcBA7uDmGfIKj9aSHpfoZI24exHW7H7lKGMk+Kx9JaNjs/WN
         WawGVmLexeehibCQHXnrhd0qkCoUzMLGuuJZ/5BweTPymIoJN3tmwLSMH8CzD3Xy2jIQ
         9/3Pm3H5Bx+os+PB6Zxxnu20Kn2rh2iXMfSCFG4m1GQ8I9ECc18NUZ5hkYWOW797gv3z
         TiIAsi/mPehaxEusS/NOL+tjkQbQT62NbGl0N9GR8GADdokKl48IP9BQDEEB9Vn39zM7
         wYdQ==
X-Gm-Message-State: AOAM5332wPKxsKLjSYR2yirb/VKkNuTM0RpOjYBuYOiI9ZDXUpHQLpBY
        Vh16BYyFclFZNfSmMV3q1oP7gPdp2SzVbiVjGanl73WJn7tNCVWFIW1Cm/NVZDZqiEmTGQA0brs
        cLHQrXog245zDGNEda7dKJWFpzAJJEg2UDlLWo75vlL5BW9OGp0uFaxOomuMEBFw43m+6Z8QkdW
        Yx
X-Google-Smtp-Source: ABdhPJzfyhXfNLZKIeAR0IFsumK928tpVv+OmfKG4QUb2ZFBBsIVxKapXLuF7ZajBvXr0faHa36NdseXdfi/31sBG6ug
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:e8e:b0:518:287c:ce82 with
 SMTP id bo14-20020a056a000e8e00b00518287cce82mr25227948pfb.4.1654538081347;
 Mon, 06 Jun 2022 10:54:41 -0700 (PDT)
Date:   Mon,  6 Jun 2022 10:54:37 -0700
In-Reply-To: <20220323210803.1130790-1-jonathantanmy@google.com>
Message-Id: <20220606175437.1740447-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220323210803.1130790-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3] commit,shallow: unparse commits if grafts changed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit is parsed, it pretends to have a different (possibly
empty) list of parents if there is graft information for that commit.
But there is a bug that could occur when a commit is parsed, the graft
information is updated (for example, when a shallow file is rewritten),
and the same commit is subsequently used: the parents of the commit do
not conform to the updated graft information, but the information at the
time of parsing.

This is usually not an issue, as a commit is usually introduced into the
repository at the same time as its graft information. That means that
when we try to parse that commit, we already have its graft information.

But it is an issue when fetching a shallow point directly into a
repository with submodules. The function
assign_shallow_commits_to_refs() parses all sought objects (including
the shallow point, which we are directly fetching). In update_shallow()
in fetch-pack.c, assign_shallow_commits_to_refs() is called before
commit_shallow_file(), which means that the shallow point would have
been parsed before graft information is updated. Once a commit is
parsed, it is no longer sensitive to any graft information updates. This
parsed commit is subsequently used when we do a revision walk to search
for submodules to fetch, meaning that the commit is considered to have
parents even though it is a shallow point (and therefore should be
treated as having no parents).

Therefore, whenever graft information is updated, mark the commits that
were previously grafts and the commits that are newly grafts as
unparsed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks everyone for your reviews. I've updated the test following =C3=86var=
's
suggestion.
---
Range-diff against v2:
1:  368e40d660 ! 1:  a22cc1b02b commit,shallow: unparse commits if grafts c=
hanged
    @@ Commit message
         unparsed.
    =20
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
    +    ---
    +    Thanks everyone for your reviews. I've updated the test following =
=C3=86var's
    +    suggestion.
    =20
      ## commit.c ##
     @@ commit.c: int commit_graft_pos(struct repository *r, const struct o=
bject_id *oid)
    @@ shallow.c: int commit_shallow_file(struct repository *r, struct shal=
low_lock *lk
     =20
    =20
      ## t/t5537-fetch-shallow.sh ##
    -@@ t/t5537-fetch-shallow.sh: test_expect_success 'fetch --update-shall=
ow into a repo with submodules' '
    +@@ t/t5537-fetch-shallow.sh: test_expect_success 'fetch --update-shall=
ow' '
    + test_expect_success 'fetch --update-shallow into a repo with submodul=
es' '
    + 	git init a-submodule &&
    + 	test_commit -C a-submodule foo &&
    ++
    ++	test_when_finished "rm -rf repo-with-sub" &&
    + 	git init repo-with-sub &&
    + 	git -C repo-with-sub submodule add ../a-submodule a-submodule &&
    + 	git -C repo-with-sub commit -m "added submodule" &&
      	git -C repo-with-sub fetch --update-shallow ../shallow/.git refs/hea=
ds/*:refs/remotes/shallow/*
      '
     =20
     +test_expect_success 'fetch --update-shallow a commit that is also a s=
hallow point into a repo with submodules' '
    -+	git init repo-with-unreachable-upstream-shallow &&
    -+	git -C repo-with-unreachable-upstream-shallow submodule add ../a-sub=
module a-submodule &&
    -+	git -C repo-with-unreachable-upstream-shallow commit -m "added submo=
dule" &&
    ++	test_when_finished "rm -rf repo-with-sub" &&
    ++	git init repo-with-sub &&
    ++	git -C repo-with-sub submodule add ../a-submodule a-submodule &&
    ++	git -C repo-with-sub commit -m "added submodule" &&
     +
     +	SHALLOW=3D$(cat shallow/.git/shallow) &&
    -+	git -C repo-with-unreachable-upstream-shallow fetch --update-shallow=
 ../shallow/.git "$SHALLOW":refs/heads/a-shallow
    ++	git -C repo-with-sub fetch --update-shallow ../shallow/.git "$SHALLO=
W":refs/heads/a-shallow
     +'
     +
      test_expect_success 'fetch --update-shallow (with fetch.writeCommitGr=
aph)' '

 commit.c                 | 16 +++++++++++++++-
 shallow.c                |  7 +++++++
 t/t5537-fetch-shallow.sh | 12 ++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 59b6c3e455..1537ea73d0 100644
--- a/commit.c
+++ b/commit.c
@@ -120,6 +120,17 @@ int commit_graft_pos(struct repository *r, const struc=
t object_id *oid)
 		       commit_graft_oid_access);
 }
=20
+static void unparse_commit(struct repository *r, const struct object_id *o=
id)
+{
+	struct commit *c =3D lookup_commit(r, oid);
+
+	if (!c->object.parsed)
+		return;
+	free_commit_list(c->parents);
+	c->parents =3D NULL;
+	c->object.parsed =3D 0;
+}
+
 int register_commit_graft(struct repository *r, struct commit_graft *graft=
,
 			  int ignore_dups)
 {
@@ -145,6 +156,7 @@ int register_commit_graft(struct repository *r, struct =
commit_graft *graft,
 			(r->parsed_objects->grafts_nr - pos - 1) *
 			sizeof(*r->parsed_objects->grafts));
 	r->parsed_objects->grafts[pos] =3D graft;
+	unparse_commit(r, &graft->oid);
 	return 0;
 }
=20
@@ -253,8 +265,10 @@ void reset_commit_grafts(struct repository *r)
 {
 	int i;
=20
-	for (i =3D 0; i < r->parsed_objects->grafts_nr; i++)
+	for (i =3D 0; i < r->parsed_objects->grafts_nr; i++) {
+		unparse_commit(r, &r->parsed_objects->grafts[i]->oid);
 		free(r->parsed_objects->grafts[i]);
+	}
 	r->parsed_objects->grafts_nr =3D 0;
 	r->parsed_objects->commit_graft_prepared =3D 0;
 }
diff --git a/shallow.c b/shallow.c
index 8ad5f22832..cf289a4c6d 100644
--- a/shallow.c
+++ b/shallow.c
@@ -97,6 +97,13 @@ int commit_shallow_file(struct repository *r, struct sha=
llow_lock *lk)
 {
 	int res =3D commit_lock_file(&lk->lock);
 	reset_repository_shallow(r);
+
+	/*
+	 * Update in-memory data structures with the new shallow information,
+	 * including unparsing all commits that now have grafts.
+	 */
+	is_repository_shallow(r);
+
 	return res;
 }
=20
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 92948de7a0..10e9a7ff26 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -164,12 +164,24 @@ test_expect_success 'fetch --update-shallow' '
 test_expect_success 'fetch --update-shallow into a repo with submodules' '
 	git init a-submodule &&
 	test_commit -C a-submodule foo &&
+
+	test_when_finished "rm -rf repo-with-sub" &&
 	git init repo-with-sub &&
 	git -C repo-with-sub submodule add ../a-submodule a-submodule &&
 	git -C repo-with-sub commit -m "added submodule" &&
 	git -C repo-with-sub fetch --update-shallow ../shallow/.git refs/heads/*:=
refs/remotes/shallow/*
 '
=20
+test_expect_success 'fetch --update-shallow a commit that is also a shallo=
w point into a repo with submodules' '
+	test_when_finished "rm -rf repo-with-sub" &&
+	git init repo-with-sub &&
+	git -C repo-with-sub submodule add ../a-submodule a-submodule &&
+	git -C repo-with-sub commit -m "added submodule" &&
+
+	SHALLOW=3D$(cat shallow/.git/shallow) &&
+	git -C repo-with-sub fetch --update-shallow ../shallow/.git "$SHALLOW":re=
fs/heads/a-shallow
+'
+
 test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)'=
 '
 	(
 	cd shallow &&
--=20
2.36.1.255.ge46751e96f-goog

