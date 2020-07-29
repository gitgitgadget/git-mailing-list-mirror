Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B084C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF8E2075D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steve-org-uk.20150623.gappssmtp.com header.i=@steve-org-uk.20150623.gappssmtp.com header.b="ZAbcCd7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2SMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2SMX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:12:23 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7B6C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 11:12:23 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p16so9447166ile.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=steve-org-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APsLfTvysCxO7tlIh3eg8m7ox4e6hCRBn6Sph6PKjOQ=;
        b=ZAbcCd7gJoslPinm3zxyAMwa5gNHdgh2DZJvEC+oGzEY4quOhNEDLgxeBkhNSZ0rTJ
         y8KJgWSoKp80JfFc1+RWKcc+sPFhFICqR+vEKjYb1mwMPAIOJlwFQ7ps6ONiThmvpcJ/
         dqmcTWUf4EmzXnvr2IssPPQRi0aNFCkC8sSl41iETNJP0vAvBhVQ475L5m7oXekMl/YU
         8SRUphMpHsW7e5fpQPkYK84rXJ75ogQKpORzml/flPfnP0fZLn2oki8vQrPm6pGLifi5
         s81JOiafHn+iOudvjT1Oqb/98FX2Qb/cOsahFRNdhDZeQI6ryUM/HjZuXQ+2dSKD64BD
         Xb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APsLfTvysCxO7tlIh3eg8m7ox4e6hCRBn6Sph6PKjOQ=;
        b=cNzj3GxlHYnKGHoNJ6FccAuT6P/wMq1pcuoaR/4/KedxDofLM08JyjDWZjmFQ4u00G
         q6iWN19kCsTw1so1YIJAgedTFHuNIvtMsdlUHVGryXhi1GKE0gckskTyC3LAPsWgcGHU
         JYAUP1uCyOCZnuj5VKhJP9B/clgyRaDxxVnvUM0kQ/LgdlyJqntAevN2XuUTU6lC8yPP
         +GpBCowZF+HIYV724yvHlcMIJgeONQ4EfGdrP3Aw81+qel13IukjibtsHrVMbKDddDYa
         CPCjLR9b0DgD7h/3h4DEAUXFGsCIXSQSxqhSlcLfHgisyc4tdrtPZ+F8511AN3kvDiNe
         MRBg==
X-Gm-Message-State: AOAM533euqV8d0RoQbzjVBZQSJo0cczkWf6HZe431b4wE+PvHDCDH5wf
        8nQCFtAuQ0HzWwRdTWIxXfa62U7yCkbzOsrLd5WZJg==
X-Google-Smtp-Source: ABdhPJyFzps9/yyqr+mm9bnYkkFUghQ8I56UBEOvVs+cuwvCkzUOqrfjv4rTHBONe7a8a5I2RAQ9mKZ4AGAmHcOiN+M=
X-Received: by 2002:a05:6e02:1146:: with SMTP id o6mr583444ill.132.1596046341598;
 Wed, 29 Jul 2020 11:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.685.git.1595993608886.gitgitgadget@gmail.com> <571792b3-e65b-e6e8-34b9-56a87a47de8d@gmail.com>
In-Reply-To: <571792b3-e65b-e6e8-34b9-56a87a47de8d@gmail.com>
From:   Steve Kemp <steve@steve.org.uk>
Date:   Wed, 29 Jul 2020 21:12:09 +0300
Message-ID: <CAHvqdm4Zj_US3ohNCcPzbKUocWp36jwgJ4KnGk9edn4NevuMNg@mail.gmail.com>
Subject: Re: [PATCH] comment: fix spelling mistakes inside comments
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 29 Jul 2020 at 16:45, Derrick Stolee <stolee@gmail.com> wrote:

> Double sign-off? Perhaps keep the org.uk version, since that
> is the email you use for authorship.

Sorry, thanks.

> In my opinion, this change is not harmful, but also isn't super
> necessary. I could go either way.

If it were a white-space change, or a some trivial style-guide fixup
I'd have left it alone. As it is the patch fixes a couple of mistakes,
albeit trivial ones, I thought it was worth submitting.

I'd be happy to see it merged, or dropped, whichever seems most
appropriate. I appreciate it is internal and not user-visible, but
when I read comments with typos in them they jump out!

Updated patch, trivially, below.

Steve
-- 


From: Steve Kemp <steve@steve.org.uk>

This commit fixes a couple of minor spelling mistakes inside
comments.

Signed-off-by: Steve Kemp <steve@steve.org.uk>
---
    comment: Fix spelling mistakes inside comments

    This commit fixes a couple of minor spelling mistakes inside comments.

    Signed-off-by: Steve Kemp steve@steve.fi [steve@steve.fi]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-685%2Fskx%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-685/skx/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/685

 add-patch.c  | 2 +-
 column.c     | 2 +-
 grep.c       | 2 +-
 ref-filter.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index f899389e2c..a1d66c1b75 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1203,7 +1203,7 @@ static int edit_hunk_loop(struct add_p_state *s,
  for (;;) {
  int res = edit_hunk_manually(s, hunk);
  if (res == 0) {
- /* abandonded */
+ /* abandoned */
  *hunk = backup;
  return -1;
  }
diff --git a/column.c b/column.c
index 4a38eed322..a58969baba 100644
--- a/column.c
+++ b/column.c
@@ -107,7 +107,7 @@ static void display_plain(const struct string_list *list,
  printf("%s%s%s", indent, list->items[i].string, nl);
 }

-/* Print a cell to stdout with all necessary leading/traling space */
+/* Print a cell to stdout with all necessary leading/trailing space */
 static int display_cell(struct column_data *data, int initial_width,
  const char *empty_cell, int x, int y)
 {
diff --git a/grep.c b/grep.c
index 13232a904a..54af9f813e 100644
--- a/grep.c
+++ b/grep.c
@@ -1817,7 +1817,7 @@ static int grep_source_1(struct grep_opt *opt,
struct grep_source *gs, int colle
  * We might set up the shared textconv cache data here, which
  * is not thread-safe. Also, get_oid_with_context() and
  * parse_object() might be internally called. As they are not
- * currenty thread-safe and might be racy with object reading,
+ * currently thread-safe and might be racy with object reading,
  * obj_read_lock() must be called.
  */
  grep_attr_lock();
diff --git a/ref-filter.c b/ref-filter.c
index 8447cb09be..f836f3830c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1980,7 +1980,7 @@ static int for_each_fullref_in_pattern(struct
ref_filter *filter,
  * of oids. If the given ref is a tag, check if the given tag points
  * at one of the oids in the given oid array.
  * NEEDSWORK:
- * 1. Only a single level of inderection is obtained, we might want to
+ * 1. Only a single level of indirection is obtained, we might want to
  * change this to account for multiple levels (e.g. annotated tags
  * pointing to annotated tags pointing to a commit.)
  * 2. As the refs are cached we might know what refname peels to without

base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
-- 
gitgitgadget
