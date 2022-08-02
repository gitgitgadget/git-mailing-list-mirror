Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B95C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiHBPd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHBPd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:33:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2CF245
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:33:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v3so17442251wrp.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=rGWdOYYl+SQaeBv4mV4xIE4G1LNKhzNK65URak6SHEg=;
        b=k92THkje62Q4nkZSjwroR7Ub105K6z1dVlqDZv2VB3Ulbx9q2sgRGCORizCMrxZc4a
         MBmQtitORax7uAQmn6GCPvDXGY7IsTlSqkhg2TCJBNXELgS064UyGCCzqT+jHyQXdjHC
         f/DIBg9EYH3dA5OkL+Q6W3kXn421rm6ZcptUosC/GLLWoJTxvXvNaTctH+8uzFV8R3lG
         12L7/KR1Vo8DmmD4SzVvSEImfkUShVIpAadtETMSIGSUUwV0Xnqwo7/HOn72YJWLDZDR
         kQQjvM7msX9CqCCLGUTw9VR6lJE0ex+USQ6D9ldXdsCZjYHeqH28fFAv8Vc/hT+3TTla
         3ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rGWdOYYl+SQaeBv4mV4xIE4G1LNKhzNK65URak6SHEg=;
        b=fJtreYDrgNzMJovYVi2Iy5WpChKb+lbpYhCgyYgOriRGcDB/czTV0DmopEpgX5mn7T
         ICJiANqVwaXkbP+DOyHRxnN4sg8+q2iDfsEp41mEo1LE3cltdHHu64+maXQ5xorCh3fE
         3pv0lrjcyGQwHDOLuWKZfBtoMc4sr5L/YATT+KvUg9ku+lrHBcoy3h+L8GwXSOLFUj69
         aI1NRFtmDx2R1jjPRcLFhkFRFAtlHb055tsWOrBN1ZUxYXGGWBEyPquYddedKjhO1/Cx
         uOnC0ozsr+Coo+ns0zmQbfSSUSX+dodyGhcXke/0q1DSjX0US2l7OGXs+msJy9/9Puj3
         kBTg==
X-Gm-Message-State: ACgBeo0wDYqqR0NkJiyCutGqVtASNCStEaJQEZJU2KzHrmnY5Fhvy4de
        8NCrltQkQDwUZwlehfCgxDnGhDHI4UhBBQ==
X-Google-Smtp-Source: AA6agR7ifq0ALcViIz/XmuX7Q4oF3XsgecXB1MKUYBkzhFLD0Oru880A6IQMuvxkAK1bngIu41kWig==
X-Received: by 2002:a05:6000:15c1:b0:220:60ba:db68 with SMTP id y1-20020a05600015c100b0022060badb68mr8012712wry.196.1659454402555;
        Tue, 02 Aug 2022 08:33:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y7-20020adffa47000000b0021e9396b135sm15332531wrr.37.2022.08.02.08.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:33:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/6] revisions API: fix more memory leaks
Date:   Tue,  2 Aug 2022 17:33:10 +0200
Message-Id: <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes various leaking users of the revisions API.

Changes since v2:

* I think the rewrite here of fixing the leak should address Jeff
  King's concerns. I was somewhat mentally stuck on trying to change
  the code to make the leak fix easier, and then having the leak fix.

  But I think as the new 3/6 shows fixing the leak first is much
  easier, and more straightforward to explain.

* A new 4/6 then follows-up and rewrites the variable clobbering that
  was needed for the pre-image of 3/6.

* Don't reference the "XXX" comment in 6/6.

* A typo fix, pointed out by Eric Sunshine.

Thanks all for the review on the v2!

Ævar Arnfjörð Bjarmason (6):
  bisect.c: add missing "goto" for release_revisions()
  test-fast-rebase helper: use release_revisions() (again)
  log: fix a memory leak in "git show <revision>..."
  log: refactor "rev.pending" code in cmd_show()
  bisect.c: partially fix bisect_rev_setup() memory leak
  revisions API: don't leak memory on argv elements that need free()-ing

 bisect.c                                      | 28 ++++++++++-------
 builtin/log.c                                 | 31 +++++++++++++------
 builtin/submodule--helper.c                   |  5 ++-
 remote.c                                      |  5 ++-
 revision.c                                    |  2 ++
 revision.h                                    |  3 +-
 t/helper/test-fast-rebase.c                   |  2 --
 t/t0203-gettext-setlocale-sanity.sh           |  1 +
 t/t1020-subdirectory.sh                       |  1 +
 t/t2020-checkout-detach.sh                    |  1 +
 t/t3307-notes-man.sh                          |  1 +
 t/t3920-crlf-messages.sh                      |  2 ++
 t/t4069-remerge-diff.sh                       |  1 +
 t/t7007-show.sh                               |  1 +
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  1 +
 t/t9122-git-svn-author.sh                     |  1 -
 t/t9162-git-svn-dcommit-interactive.sh        |  1 -
 17 files changed, 59 insertions(+), 28 deletions(-)

Range-diff against v2:
1:  12a4a20c59f = 1:  12a4a20c59f bisect.c: add missing "goto" for release_revisions()
2:  bbd3a7e5ecc ! 2:  a04fade9d9d test-fast-rebase helper: use release_revisions() (again)
    @@ Commit message
                   ... when != \( I \| &I \)
     
         That rule should arguably use only &I, not I (as we might be passed a
    -    pointer). He distinction would matter if anyone cared about the
    +    pointer). The distinction would matter if anyone cared about the
         side-effects of a memset() followed by release() of a pointer to a
         variable passed into the function.
     
4:  54b632c1124 ! 3:  83fc1835fe5 log: fix common "rev.pending" memory leak in "git show"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    log: fix common "rev.pending" memory leak in "git show"
    -
    -    Fix a very common memory leak introduced in 5d7eeee2ac6 (git-show: grok blobs,
    -    trees and tags, too, 2006-12-14).
    -
    -    When "git show" displays commits it needs to temporarily clobbers the
    -    "rev.pending" array, but by doing so we'll fail to
    -    release_revisions(), as we have for most other uses of "struct
    -    rev_info" since 2da81d1efb0 (Merge branch 'ab/plug-leak-in-revisions',
    -    2022-06-07).
    -
    -    In the preceding commit this code was made to use a more extendable
    -    pattern, which we can now complete. Once we've clobbered our
    -    "rev.pending" and invoked "cmd_log_walk_no_free()" we need to
    -    "object_array_clear()" our old "rev.pending".
    -
    -    So in addition to the now-populated &pending array, to avoid leaking
    -    the memory related to the one member array we've created. The
    -    &rev.pending was already being object_array_clear()'d by the
    -    release_revisions() added in f6bfea0ad01 (revisions API users: use
    -    release_revisions() in builtin/log.c, 2022-04-13), now we'll also
    -    correctly free the previous data (f6bfea0ad01 noted this memory leak
    -    as an outstanding TODO).
    -
    -    This way of doing it is making assumptions about the internals of
    -    "struct rev_info", in particular that the "pending" member is
    -    stand-alone, and that no other state is referring to it. But we've
    -    been making those assumptions ever since 5d7eeee2ac6 (git-show: grok
    -    blobs, trees and tags, too, 2006-12-14).
    +    log: fix a memory leak in "git show <revision>..."
    +
    +    Fix a memory leak in code added in 5d7eeee2ac6 (git-show: grok blobs,
    +    trees and tags, too, 2006-12-14). As we iterate over a "<revision>..."
    +    command-line and encounter ad OBJ_COMMIT we want to use our "struct
    +    rev_info", but with a "pending" array of one element: the one commit
    +    we're showing in the loop.
    +
    +    To do this 5d7eeee2ac6 saved away a pointer to rev.pending.objects and
    +    rev.pending.nr for its iteration. We'd then clobber those (and alloc)
    +    when we needed to show an OBJ_COMMIT.
    +
    +    We'd therefore leak the "rev.pending" we started out with, and only
    +    free the new "rev.pending" in the "OBJ_COMMIT" case arm as
    +    prepare_revision_walk() would draw it down.
    +
    +    Let's fix this memory leak. Now when we encounter an OBJ_COMMIT we
    +    save away the "rev.pending" before clearing it. We then add a single
    +    commit to it, which our indirect invocation of prepare_revision_walk()
    +    will remove. After that we restore the "rev.pending".
    +
    +    Our "rev.pending" will then get free'd by the release_revisions()
    +    added in f6bfea0ad01 (revisions API users: use release_revisions() in
    +    builtin/log.c, 2022-04-13)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/log.c ##
    -@@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
    - 		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
    - 
    - 	memcpy(&pending, &rev.pending, sizeof(rev.pending));
    -+	memcpy(&rev.pending, &blank, sizeof(rev.pending));
    - 	rev.diffopt.no_free = 1;
    - 	for (i = 0; i < pending.nr && !ret; i++) {
    - 		struct object *o = pending.objects[i].item;
     @@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
      			rev.shown_one = 1;
      			break;
      		case OBJ_COMMIT:
    --			memcpy(&rev.pending, &blank, sizeof(rev.pending));
    ++		{
    ++			struct object_array old;
    ++
    ++			memcpy(&old, &rev.pending, sizeof(old));
    + 			rev.pending.nr = rev.pending.alloc = 0;
    + 			rev.pending.objects = NULL;
      			add_object_array(o, name, &rev.pending);
      			ret = cmd_log_walk_no_free(&rev);
    ++			memcpy(&rev.pending, &old, sizeof(rev.pending));
      			break;
    -@@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
    ++		}
    + 		default:
      			ret = error(_("unknown type: %d"), o->type);
      		}
    - 	}
    -+	object_array_clear(&pending);
    - 
    - 	rev.diffopt.no_free = 0;
    - 	diff_free(&rev.diffopt);
     
      ## t/t0203-gettext-setlocale-sanity.sh ##
     @@
3:  1629299f883 ! 4:  fd474666e7c log: make the intent of cmd_show()'s "rev.pending" juggling clearer
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    log: make the intent of cmd_show()'s "rev.pending" juggling clearer
    +    log: refactor "rev.pending" code in cmd_show()
     
    -    Adjust code added in 5d7eeee2ac6 (git-show: grok blobs, trees and
    -    tags, too, 2006-12-14) to use the "memcpy a &blank" idiom introduced
    -    in 5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
    -    macro, 2021-07-01).
    +    Refactor the juggling of "rev.pending" and our replacement for it
    +    amended in the preceding commit so that:
     
    -    Now the types in play are guaranteed to correspond, i.e. we used "int"
    -    here for the "count" before, but the corresponding "nr" is an
    -    "unsigned int". By using a "blank" object we almost entirely bypass
    -    that, we'll only need to declare our own "unsigned int i".
    +     * We use an "unsigned int" instead of an "int" for "i", this matches
    +       the types of "struct rev_info" itself.
     
    -    There are no functional changes here aside from potential overflow
    -    guard rails, the structure only has these three members ("nr", "alloc"
    -    and "objects"), but now we're obviously future-proof against assuming
    -    that.
    +     * We don't need the "count" and "objects" variables introduced in
    +       5d7eeee2ac6 (git-show: grok blobs, trees and tags, too, 2006-12-14).
    +
    +       They were originally added since we'd clobber rev.pending in the
    +       loop without restoring it. Since the preceding commit we are
    +       restoring it when we handle OBJ_COMMIT, so the main for-loop can
    +       refer to "rev.pending" didrectly.
    +
    +     * We use the "memcpy a &blank" idiom introduced in
    +       5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
    +       macro, 2021-07-01).
    +
    +       This is more obvious than relying on us enumerating all of the
    +       relevant members of the "struct object_array" that we need to
    +       clear.
    +
    +     * We comment on why we don't need an object_array_clear() here, see
    +       the analysis in [1].
    +
    +    1. https://lore.kernel.org/git/YuQtJ2DxNKX%2Fy70N@coredump.intra.peff.net/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Helped-by: Jeff King <peff@peff.net>
     
      ## builtin/log.c ##
     @@ builtin/log.c: static void show_setup_revisions_tweak(struct rev_info *rev,
    @@ builtin/log.c: static void show_setup_revisions_tweak(struct rev_info *rev,
      {
      	struct rev_info rev;
     -	struct object_array_entry *objects;
    -+	struct object_array blank = OBJECT_ARRAY_INIT;
    -+	struct object_array pending = OBJECT_ARRAY_INIT;
     +	unsigned int i;
      	struct setup_revision_opt opt;
      	struct pathspec match_all;
    @@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
      
     -	count = rev.pending.nr;
     -	objects = rev.pending.objects;
    -+	memcpy(&pending, &rev.pending, sizeof(rev.pending));
      	rev.diffopt.no_free = 1;
     -	for (i = 0; i < count && !ret; i++) {
     -		struct object *o = objects[i].item;
     -		const char *name = objects[i].name;
    -+	for (i = 0; i < pending.nr && !ret; i++) {
    -+		struct object *o = pending.objects[i].item;
    -+		const char *name = pending.objects[i].name;
    ++	for (i = 0; i < rev.pending.nr && !ret; i++) {
    ++		struct object *o = rev.pending.objects[i].item;
    ++		const char *name = rev.pending.objects[i].name;
      		switch (o->type) {
      		case OBJ_BLOB:
      			ret = show_blob_object(&o->oid, &rev, name);
    @@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
      				ret = error(_("could not read object %s"),
      					    oid_to_hex(oid));
     -			objects[i].item = o;
    -+			pending.objects[i].item = o;
    ++			rev.pending.objects[i].item = o;
      			i--;
      			break;
      		}
     @@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
    - 			rev.shown_one = 1;
    - 			break;
      		case OBJ_COMMIT:
    + 		{
    + 			struct object_array old;
    ++			struct object_array blank = OBJECT_ARRAY_INIT;
    + 
    + 			memcpy(&old, &rev.pending, sizeof(old));
     -			rev.pending.nr = rev.pending.alloc = 0;
     -			rev.pending.objects = NULL;
     +			memcpy(&rev.pending, &blank, sizeof(rev.pending));
    ++
      			add_object_array(o, name, &rev.pending);
      			ret = cmd_log_walk_no_free(&rev);
    ++
    ++			/*
    ++			 * No need for
    ++			 * object_array_clear(&pending). It was
    ++			 * cleared already in prepare_revision_walk()
    ++			 */
    + 			memcpy(&rev.pending, &old, sizeof(rev.pending));
      			break;
    + 		}
5:  2af2bce2d17 = 5:  dae5872e722 bisect.c: partially fix bisect_rev_setup() memory leak
6:  3c57e126554 ! 6:  5e637f55ff1 revisions API: don't leak memory on argv elements that need free()-ing
    @@ Commit message
         revisions API: don't leak memory on argv elements that need free()-ing
     
         Add a "free_removed_argv_elements" member to "struct
    -    setup_revision_opt", and use it to fix several memory leaks, e.g. the
    -    one with a "XXX" comment added in 8a534b61241 (bisect: use argv_array
    -    API, 2011-09-13).
    +    setup_revision_opt", and use it to fix several memory leaks.
     
         We have various memory leaks in APIs that take and munge "const
         char **argv", e.g. parse_options(). Sometimes these APIs are given the
-- 
2.37.1.1233.ge8b09efaedc

