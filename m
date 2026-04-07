Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7631CAA7D
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775531618; cv=pass; b=UIP8/ZtZRj6E71Ll9Acr9yQIFIM/W6dxHAEbmncEBK8SVkutIkkl4F6cYSTZmqZzx5Cw112+9ksLr2bEaev9BSe9009Z33WYWh8zSC3k+MPYanWyKu0sHhikH0kNQmuG3tntcxDJC60ThvRteeTQ0ZV5pQmvyS63Tvnpq/rVRzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775531618; c=relaxed/simple;
	bh=PUi2rvrg1GRzSmIg07GujlkCBR2BeFA2LIz/JQjPsP0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Qjq6eKrxpVCasI2W6pTwO5SX6eVae/vessRTwr6YeNr9c36lxl3WeQ5NbxX/TDcRRm6BRgz+I6YRBXLnef20/C7SF5EOd2FWG3sdD4K/cgPF/y/PqQvPb+RrJamd13lnn4hyot+yMB8S3H0+ydmXDJ3gxTmMhaW9mmiCte8BP1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/GOE4OY; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/GOE4OY"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9697so28953c88.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 20:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775531615; cv=none;
        d=google.com; s=arc-20240605;
        b=YfxUWQgKGAD8vYR39EAB2I8dkGoVd3h6tJs6s8Aivna8HjcNYC3wlvykrVxR2n/ncG
         ze4HIJ0mYYoSyOIV1MjEs+ERyT6WZVufQW4hX/Rzt1ewnrCbDuECOxYd09Sjh9ajSFvS
         rZ/f1FMsyGrC0pv2RHznLi8rh6QI9YXPawjTnprNtJJiAmdvC78T8FUdO063ybCXN+Qo
         GNlOaT5qaFiVPSKs6rX94rYZ3kFHVAHOLpmlKYNkcx9WDmNSW7q6RqgvD1aarSZes5Fz
         WhoUHoyP7Q5C8KEPjLtShmGuzMFr+ipfjdZP2k9OpO1/je8j4cfh7ScZdLfUNs4eNUle
         Ndmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=sGMiZyW+HjrRP4sBPm78RDnwAzByp14nZvLCnjrBLfg=;
        fh=2IhH4Nl2QL3ayusMZSXHpWkT0wg8dTX3brNw7zyM9ps=;
        b=Ib0/B4oDs3H9feqSCdG2ewmNyepvqNsvmyx+IXdFnHeeCGqSSMg2NY+XATyrbtKNoD
         oAzUoaAncpnJRMnOhEHIUdjyI0wHIfWYZbYi/w3u6z79xnmGOL8/95jZ5pksK4CpeQ6q
         UDVsr6A/s2hhy//zCa7MAnWixc0Lc6BJmx4YaIy//u4Cvi2fDif1/emS+rFIbu8MAZ7u
         XdtdzXlHRABSAT7HfhRBmzUEyiuRkFVDM0wwAwajqzI+3RK1yLSoHzVXg+fg2/6fkor4
         Sy7YBUGoBbrm5vH4mwNxRei1CCkl1zBMXa3P/ELg3gjdb+/mKdL1YaQ9BqJGDQSurIrF
         Wucg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775531615; x=1776136415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sGMiZyW+HjrRP4sBPm78RDnwAzByp14nZvLCnjrBLfg=;
        b=c/GOE4OY1B1k/gNoOCjUMHMjWp5yZLbPKERcWrl+uq2jgRNqDFxuPdVr5/EdzKq4CQ
         xa+FErSai0qDpByTxq8YM1Si8vms6TJ3vcV6uO1pZd/sMlc3KrVCT7JhTF84RovK9cs4
         S0MXrK168dPPwc1m1bbGoInioEzWnegga4Nge5ssIxB/h4NJYE/B7NGt1ZtelwXpYcri
         mCY4lGE8HIseT6M+krZ45p9bfwU0uoGWPwW4tDsZHT4NYTcZukGwNmW1g5zItRLvWqyL
         8p7hldysy5NnLIN8kAToR1tIDHeI6Ululra2py5Pl85PsjC5+JNymLzKJHAZhYrruwQv
         OZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775531615; x=1776136415;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGMiZyW+HjrRP4sBPm78RDnwAzByp14nZvLCnjrBLfg=;
        b=YWUE7EeQ0fvQhugqpKRw18CglKZLwAjqNwRG6nwXGlIkz3yruJvjOh8YbHQS59e1H2
         m+vd2ASanWetSNpVpnsHTP37Z14AIMNagrCdmOGrZ9K47QcX/dxl1yEwAoI+oipc1y9R
         LjeoGp7pzd5VoZTDL4s/4fiNKmCxUmSnv8eeLn+PIfkDKLpy83z2S9s4VZsk1Rqgf96f
         rlzbwrR+b9FE/kZa10Ntajl0lg+MX510s9EIXHKxg7cL8Cu1jM/5jMDGI6W+yco/GxVZ
         FHzA11sCDqhcjEHSy3e9eABSt1LGeEK03+Llp7wiO+SLHZ5t3jCdvtlq3nfVtXXyAnoY
         jTnQ==
X-Gm-Message-State: AOJu0YxHo6tJ3wmpmelvD1BnTrxAB02JXqIof4Qa5TQ0Foo/24VMQLLy
	O55OGJPV9ELsYUTrdsMaYJcCVAHG7K6webp1VM8W2Srr5L3bv5/Zfc4DK1KryNlBY6z/Ob6YTWt
	ORGGdk1cxcwBDoFJPGgJPuPfnR3hEGlIJebmF3hFArkaI5JHBFSCS1WIXOWtfgQ==
X-Gm-Gg: AeBDieuowg/ym0evSZVce6qdihKjCPZtdrBzVwYAJChuUyu0RJq7CRWUpJJUW0suoB0
	2BrGAJTjkzwJT9wixmXMc8GWikBi2GoZoPWLrWBAV7/HgJdVxkmijD/DkU6/9XyUPWQrhoE/0tV
	ejN1zpY+rxZ8DSkXLF4temCR8jCZbvMbwxSB8kpo3XWlc62YcCJRKwmmBClGeASQdR2OXdcyod0
	pp6kSkst2+x8hSpKZ44eosB3aXJ8dDBHivSzkb8QwFmUmFiiZE6Ysnnr3pzSEj/X5gSKoxwnujy
	/NPiSaA=
X-Received: by 2002:a05:7022:438e:b0:12b:fa7f:e24b with SMTP id
 a92af1059eb24-12bfc53a65fmr385319c88.13.1775531614648; Mon, 06 Apr 2026
 20:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matt Stark <msta@google.com>
Date: Tue, 7 Apr 2026 13:13:18 +1000
X-Gm-Features: AQROBzCWaygz6u4n6gdReqadCQTbnho36xfB2i7zpBXMmGQ47hzH6k_FqmzAi04
Message-ID: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
Subject: [PATCH] headers: Preserve 'change-id' header in rebase / cherry-pick.
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, phillip.wood@dunelm.org.uk, 
	Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev, Edwin Kempin <ekempin@google.com>, 
	schacon@gmail.com, philipmetzger@bluewin.ch, konstantin@linuxfoundation.org, 
	newren@gmail.com, tytso@mit.edu, nico@cryptonector.com, 
	rikingcoding@gmail.com, Matt Stark <msta@google.com>
Content-Type: text/plain; charset="UTF-8"

In the discussions on
https://lore.kernel.org/git/Z_OGMb-1oV0Ex05e@pks.im/T/#m038be849b9b4020c16c562d810cf77bad91a2c87,
it seems to be that:
* There is consensus that a `change-id` header provides good value
* There is not consenus on what precise format that should take

This commit, rather than attempting to standardize the format, simply
preserves the change-id header in whatever format it used previously.

If we so choose, we can later decide on a standardized format, but since
git only preserves existing headers, this should not create backwards
incompatibility.

Signed-off-by: Matt Stark <msta@google.com>
---
 sequencer.c                           | 39 ++++++++++++++++++++++-----
 t/t3400-rebase.sh                     | 20 ++++++++++++++
 t/t3501-revert-cherry-pick.sh         | 15 +++++++++++
 t/t7501-commit-basic-functionality.sh | 15 +++++++++++
 4 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..093d47d42a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1530,12 +1530,12 @@ static int try_to_commit(struct repository *r,
  struct strbuf *msg, const char *author,
  const char *reflog_action,
  struct replay_opts *opts, unsigned int flags,
- struct object_id *oid)
+ struct object_id *oid,
+ struct commit_extra_header *extra)
 {
  struct object_id tree;
  struct commit *current_head = NULL;
  struct commit_list *parents = NULL;
- struct commit_extra_header *extra = NULL;
  struct strbuf err = STRBUF_INIT;
  struct strbuf commit_msg = STRBUF_INIT;
  char *amend_author = NULL;
@@ -1721,7 +1721,8 @@ static int do_commit(struct repository *r,
       const char *msg_file, const char *author,
       const char *reflog_action,
       struct replay_opts *opts, unsigned int flags,
-      struct object_id *oid)
+      struct object_id *oid,
+      struct commit_extra_header *extra_headers)
 {
  int res = 1;

@@ -1735,7 +1736,7 @@ static int do_commit(struct repository *r,
     msg_file);

  res = try_to_commit(r, msg_file ? &sb : NULL,
-     author, reflog_action, opts, flags, &oid);
+     author, reflog_action, opts, flags, &oid, extra_headers);
  strbuf_release(&sb);
  if (!res) {
  refs_delete_ref(get_main_ref_store(r), "",
@@ -2511,10 +2512,36 @@ static int do_pick_commit(struct repository *r,
  oid_to_hex(&commit->object.oid), msg.subject);
  } /* else allow == 0 and there's nothing special to do */
  if (!opts->no_commit && !drop_commit) {
- if (author || command == TODO_REVERT || (flags & AMEND_MSG))
+ if (author || command == TODO_REVERT || (flags & AMEND_MSG)) {
+ struct commit_extra_header *extra_headers = NULL;
+ if (commit) {
+ unsigned long size;
+ const char *buffer = repo_get_commit_buffer(r, commit, &size);
+ size_t out_len;
+ // The Gerrit, GitButler, and Jujutsu projects all have a concept of
+ // a "change id", and it behaves in a similar way between the three
+ // tools. The change id is conceptually associated with a commit.
+ // It follows a commit as its rewritten (e.g. by amending and
+ // rebasing).
+ // While git doesn't add this header itself, and currently has no plans
+ // to do so, there is consensus that if the header is added by another
+ // tool, git should at least preserve it.
+ const char *header_value = find_commit_header(buffer, "change-id", &out_len);
+ if (header_value) {
+ extra_headers = xmalloc(sizeof(*extra_headers));
+ *extra_headers = (struct commit_extra_header){
+ .next = NULL,
+ .key = xstrdup("change-id"),
+ .value = xmemdupz(header_value, out_len),
+ .len = out_len
+ };
+ }
+ repo_unuse_commit_buffer(r, commit, buffer);
+ }
  res = do_commit(r, msg_file, author, reflog_action,
  opts, flags,
- commit? &commit->object.oid : NULL);
+ commit ? &commit->object.oid : NULL, extra_headers);
+ }
  else
  res = error(_("unable to parse commit author"));
  *check_todo = !!(flags & EDIT_MSG);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index c0c00fbb7b..6b5d6fe56f 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -474,4 +474,24 @@ test_expect_success 'git rebase --update-ref with
core.commentChar and branch on
  test_grep "% Ref refs/heads/topic2 checked out at" actual
 '

+test_expect_success 'rebase preserves change-id header' '
+ test_commit "source-for-rebase" file-rebase content-rebase &&
+ git cat-file commit HEAD >commit_obj &&
+ awk "/^committer / { print; print \"change-id my-change-id\"; next
}1" commit_obj >commit_obj_mod &&
+ new_commit=$(git hash-object -t commit -w commit_obj_mod) &&
+ git branch -f source-branch $new_commit &&
+
+ git checkout -b target-branch HEAD^ &&
+ echo "unrelated" >file-unrelated &&
+ git add file-unrelated &&
+ git commit -m "unrelated" &&
+
+ git checkout source-branch &&
+ git rebase target-branch &&
+
+ git cat-file commit HEAD >result_obj &&
+ grep "^change-id my-change-id$" result_obj
+'
+
 test_done
+
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 8025a28cfd..0ada99f216 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -256,4 +256,19 @@ test_expect_success 'cherry-pick is unaware of
--reference (for now)' '
  grep "^usage: git cherry-pick" actual
 '

+test_expect_success 'cherry-pick preserves change-id header' '
+ test_commit "source-for-cherry" file-cherry content-cherry &&
+ git cat-file commit HEAD >commit_obj &&
+ awk "/^committer / { print; print \"change-id my-change-id\"; next
}1" commit_obj >commit_obj_mod &&
+ new_commit=$(git hash-object -t commit -w commit_obj_mod) &&
+ git branch -f source-branch $new_commit &&
+
+ git checkout -b target-branch HEAD^ &&
+ git cherry-pick source-branch &&
+
+ git cat-file commit HEAD >result_obj &&
+ grep "^change-id my-change-id$" result_obj
+'
+
 test_done
+
diff --git a/t/t7501-commit-basic-functionality.sh
b/t/t7501-commit-basic-functionality.sh
index a37509f004..e25dd9dc6f 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -793,4 +793,19 @@ test_expect_success '--dry-run --short' '
  git commit --dry-run --short
 '

+test_expect_success 'amend preserves change-id header' '
+ test_commit "source-for-amend" file-amend content-amend &&
+ git cat-file commit HEAD >commit_obj &&
+ awk "/^committer / { print; print \"change-id my-change-id\"; next
}1" commit_obj >commit_obj_mod &&
+ new_commit=$(git hash-object -t commit -w commit_obj_mod) &&
+ git reset --hard $new_commit &&
+
+ echo "amended content" >>file-amend &&
+ git add file-amend &&
+ git commit --amend --no-edit &&
+
+ git cat-file commit HEAD >result_obj &&
+ grep "^change-id my-change-id$" result_obj
+'
+
 test_done
-- 
2.53.0.1213.gd9a14994de-goog
