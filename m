Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39BD41F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeHNWte (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:49:34 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42326 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbeHNWte (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:49:34 -0400
Received: by mail-oi0-f66.google.com with SMTP id b16-v6so35870762oic.9
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGbm3jwMLUBhSKkAo8apHSyBVoNyBnMPPLJpgozfPeU=;
        b=WF2U/5UdMlWgYtuORWmc4jmyr+HKTHDeyTFie6+1eWpY1gTL6gy6jPHro43hW8qUtE
         JsRzcF4UgSq5LmdVvG/PXTLR4yZyg+v62EL6OhAj3HTUQkwM5bZHGRThq8NFdgGs5LtA
         hz2GvxkHeiOtTH74J1XFOnFyY25NLPGeTUB5GwFVcDtwCuRMD3KuwEUAtXm2RYWxTHv9
         FjkvxdSwb1Q8aNqlvGJ2mno7CZXNwDv2YaomzHkNcHgO2VDW8dnqzTL4gV3XmGLiUiGa
         TaOo9azyEOmumVylEK17r+qjoIgKKql8P8rteK4Q6+h05IRC0ktZLJQK0fhEwkVrDdUy
         UeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGbm3jwMLUBhSKkAo8apHSyBVoNyBnMPPLJpgozfPeU=;
        b=UNYGLcn5t4u+3dSj01OVpHRvdGVXplV6MeFp1vY3XOnVZtKYCSK9w6nfdSF5Zbcqda
         wh48pSh1IHcjwGzlXFiQIgXJyAMJoApYz/gC4Q6XetJntdye4m/dCMWdJXwRwEqU1Dl9
         i0EQAd3sbViXk7VH15Bc+aqU9jpM0uS9aG0vdGhdm+k0Tkkd6fQGtq2YhVA/7H8KgyI1
         LjvERv0LPzgWL1e+wZTzWc2HTvjwhP9+SW77xzW/VZmQuLDHguubJO28JP+uI6Qal3mT
         lCm+N341ih81fJcBo5jGXVOgwNyI9ua75Uu4Pjvm+BPwWFbA65Mx8vjS5gaTaegqq0qt
         0kzQ==
X-Gm-Message-State: AOUpUlECLwBLJ+YWJDQlpi2vr5FqJRiINCSewcH9KWwu6eTpL0ez99gO
        DREP9Dq7rYgad84hAyPV3OtqP04LxEcEpdt/7LpQ
X-Google-Smtp-Source: AA+uWPz8Tycmvhpq/f/WJxzx4kQBs5kdvDIYL4q2G8EipxpYzErvkdQ7MOgB5OpqNppaV1V/zta1Oljbw9MPVlcwYIQ=
X-Received: by 2002:aca:be56:: with SMTP id o83-v6mr24498150oif.301.1534276845609;
 Tue, 14 Aug 2018 13:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <05e69ef260ca2b28b2444b94850bddf44ca0388a.1534267611.git.matvore@google.com>
 <20180814181841.34446-1-jonathantanmy@google.com>
In-Reply-To: <20180814181841.34446-1-jonathantanmy@google.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Tue, 14 Aug 2018 13:00:33 -0700
Message-ID: <CAMfpvhKr4jmjZ3NUmxMyTM7KJxQX30UYXKf_rJ30A4C=P3tB=g@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:18 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > @@ -743,6 +743,9 @@ specification contained in <path>.
> >       A debug option to help with future "partial clone" development.
> >       This option specifies how missing objects are handled.
> >  +
> > +The form '--filter=tree:<depth>' omits all blobs and trees deeper than
> > +<depth> from the root tree. Currently, only <depth>=0 is supported.
> > ++
> >  The form '--missing=error' requests that rev-list stop with an error if
> >  a missing object is encountered.  This is the default action.
> >  +
>
> The "--filter" documentation should go with the other "--filter"
> information, not right after --missing.
Fixed. My problem was that I didn't know what the + meant - I guess it
means that the paragraph before and after are in the same section?

>
> > +test_expect_success 'setup for tests of tree:0' '
> > +     mkdir r1/subtree &&
> > +     echo "This is a file in a subtree" > r1/subtree/file &&
> > +     git -C r1 add subtree/file &&
> > +     git -C r1 commit -m subtree
> > +'
>
> Style: no space after >
Fixed.

>
> > +test_expect_success 'grab tree directly when using tree:0' '
> > +     # We should get the tree specified directly but not its blobs or subtrees.
> > +     git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
> > +     HEAD:
> > +     EOF
> > +     git -C r1 index-pack ../commitsonly.pack &&
> > +     git -C r1 verify-pack -v ../commitsonly.pack >objs &&
> > +     grep -E "tree|blob" objs >trees_and_blobs &&
> > +     test_line_count = 1 trees_and_blobs
> > +'
>
> Can we also verify that the SHA-1 in trees_and_blobs is what we
> expected?
Done - Now I'm comparing to the output of `git rev-parse HEAD:` and I
don't need the separate line count check either.
>
> > +test_expect_success 'use fsck before and after manually fetching a missing subtree' '
> > +     # push new commit so server has a subtree
> > +     mkdir src/dir &&
> > +     echo "in dir" > src/dir/file.txt &&
>
> No space after >
Fixed.

>
> > +     git -C src add dir/file.txt &&
> > +     git -C src commit -m "file in dir" &&
> > +     git -C src push -u srv master &&
> > +     SUBTREE=$(git -C src rev-parse HEAD:dir) &&
> > +
> > +     rm -rf dst &&
> > +     git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
> > +     git -C dst fsck &&
> > +     git -C dst cat-file -p $SUBTREE >tree_contents 2>err &&
> > +     git -C dst fsck
> > +'
>
> If you don't need to redirect to err, don't do so.
>
> Before the cat-file, also verify that the tree is missing, most likely
> through a "git rev-list" with "--missing=print".
That won't work though - the subtree's hash is not known because its
parent tree is not there. I've merged the three tests in this file,
and as a result am now using the check which makes sure the object
types are only "commit"

>
> And I would grep on the tree_contents to ensure that the filename
> ("file.txt") is there, so that we know that we got the correct tree.
Done.

>
> > +test_expect_success 'can use tree:0 to filter partial clone' '
> > +     rm -rf dst &&
> > +     git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
> > +     git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
> > +     cat fetched_objects \
> > +             | awk -f print_1.awk \
> > +             | xargs -n1 git -C dst cat-file -t >fetched_types &&
> > +     sort fetched_types -u >unique_types.observed &&
> > +     echo commit > unique_types.expected &&
> > +     test_cmp unique_types.observed unique_types.expected
> > +'
> > +
> > +test_expect_success 'auto-fetching of trees with --missing=error' '
> > +     git -C dst rev-list master --missing=error --objects >fetched_objects &&
> > +     cat fetched_objects \
> > +             | awk -f print_1.awk \
> > +             | xargs -n1 git -C dst cat-file -t >fetched_types &&
> > +     sort fetched_types -u >unique_types.observed &&
> > +     printf "blob\ncommit\ntree\n" >unique_types.expected &&
> > +     test_cmp unique_types.observed unique_types.expected
> > +'
>
> These two tests seem redundant with the 'use fsck before and after
> manually fetching a missing subtree' test (after the latter is
> appropriately renamed). I think we only need to test this sequence once,
> which can be placed in one or spread over multiple tests:
>
>  1. partial clone with --filter=tree:0
>  2. fsck works
>  3. verify that trees are indeed missing
>  4. autofetch a tree
>  5. fsck still works
Done - that's much nicer. Thanks!

Here is an interdiff from v4 of the patch:

diff --git a/Documentation/rev-list-options.txt
b/Documentation/rev-list-options.txt
index 9e351ec2a..0b5f77ad3 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -731,6 +731,9 @@ the requested refs.
 +
 The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
 specification contained in <path>.
++
+The form '--filter=tree:<depth>' omits all blobs and trees deeper than
+<depth> from the root tree. Currently, only <depth>=0 is supported.

 --no-filter::
  Turn off any previous `--filter=` argument.
@@ -743,9 +746,6 @@ specification contained in <path>.
  A debug option to help with future "partial clone" development.
  This option specifies how missing objects are handled.
 +
-The form '--filter=tree:<depth>' omits all blobs and trees deeper than
-<depth> from the root tree. Currently, only <depth>=0 is supported.
-+
 The form '--missing=error' requests that rev-list stop with an error if
 a missing object is encountered.  This is the default action.
 +
diff --git a/t/t5317-pack-objects-filter-objects.sh
b/t/t5317-pack-objects-filter-objects.sh
index 65f2cf446..fe7c13a03 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -74,7 +74,7 @@ test_expect_success 'get an error for missing tree object' '

 test_expect_success 'setup for tests of tree:0' '
  mkdir r1/subtree &&
- echo "This is a file in a subtree" > r1/subtree/file &&
+ echo "This is a file in a subtree" >r1/subtree/file &&
  git -C r1 add subtree/file &&
  git -C r1 commit -m subtree
 '
@@ -95,8 +95,10 @@ test_expect_success 'grab tree directly when using tree:0' '
  EOF
  git -C r1 index-pack ../commitsonly.pack &&
  git -C r1 verify-pack -v ../commitsonly.pack >objs &&
- grep -E "tree|blob" objs >trees_and_blobs &&
- test_line_count = 1 trees_and_blobs
+ grep -E "tree|blob" objs \
+ | awk -f print_1.awk >trees_and_blobs &&
+ git -C r1 rev-parse HEAD: >expected &&
+ test_cmp trees_and_blobs expected
 '

 # Test blob:limit=<n>[kmg] filter.
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index d2859aba1..c3186d934 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -157,7 +157,7 @@ test_expect_success 'partial clone with
transfer.fsckobjects=1 uses index-pack -
 test_expect_success 'use fsck before and after manually fetching a
missing subtree' '
  # push new commit so server has a subtree
  mkdir src/dir &&
- echo "in dir" > src/dir/file.txt &&
+ echo "in dir" >src/dir/file.txt &&
  git -C src add dir/file.txt &&
  git -C src commit -m "file in dir" &&
  git -C src push -u srv master &&
@@ -166,8 +166,32 @@ test_expect_success 'use fsck before and after
manually fetching a missing subtr
  rm -rf dst &&
  git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
  git -C dst fsck &&
- git -C dst cat-file -p $SUBTREE >tree_contents 2>err &&
- git -C dst fsck
+
+ # Make sure we only have commits, and all trees and blobs are missing.
+ git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
+ cat fetched_objects \
+ | awk -f print_1.awk \
+ | xargs -n1 git -C dst cat-file -t >fetched_types &&
+ sort fetched_types -u >unique_types.observed &&
+ echo commit >unique_types.expected &&
+ test_cmp unique_types.observed unique_types.expected &&
+
+ # Auto-fetch a tree with cat-file.
+ git -C dst cat-file -p $SUBTREE >tree_contents &&
+ grep file.txt tree_contents &&
+
+ # fsck still works after an auto-fetch of a tree.
+ git -C dst fsck &&
+
+ # Auto-fetch all remaining trees and blobs with --missing=error
+ git -C dst rev-list master --missing=error --objects >fetched_objects &&
+ test_line_count = 70 fetched_objects &&
+ cat fetched_objects \
+ | awk -f print_1.awk \
+ | xargs -n1 git -C dst cat-file -t >fetched_types &&
+ sort fetched_types -u >unique_types.observed &&
+ printf "blob\ncommit\ntree\n" >unique_types.expected &&
+ test_cmp unique_types.observed unique_types.expected
 '

 test_expect_success 'partial clone fetches blobs pointed to by refs
even if normally filtered out' '
@@ -186,28 +210,6 @@ test_expect_success 'partial clone fetches blobs
pointed to by refs even if norm
  git -C dst fsck
 '

-test_expect_success 'can use tree:0 to filter partial clone' '
- rm -rf dst &&
- git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
- git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
- cat fetched_objects \
- | awk -f print_1.awk \
- | xargs -n1 git -C dst cat-file -t >fetched_types &&
- sort fetched_types -u >unique_types.observed &&
- echo commit > unique_types.expected &&
- test_cmp unique_types.observed unique_types.expected
-'
-
-test_expect_success 'auto-fetching of trees with --missing=error' '
- git -C dst rev-list master --missing=error --objects >fetched_objects &&
- cat fetched_objects \
- | awk -f print_1.awk \
- | xargs -n1 git -C dst cat-file -t >fetched_types &&
- sort fetched_types -u >unique_types.observed &&
- printf "blob\ncommit\ntree\n" >unique_types.expected &&
- test_cmp unique_types.observed unique_types.expected
-'
-
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
