Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EADBC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhLITXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhLITXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:23:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364F4C061A32
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:19:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u17so11484554wrt.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otP/fS0DMAxwL/ktTFsEF847f97cFdYd5Wn5jvZxUIM=;
        b=nxPBdYHy878UVWeUsyjp5O20tmsi6b0ORZA2Stu5YRvQkLafNTDPUCqTX5Th4emjjO
         Ua2YrfOqAxnmGuQ0v66hSYr74Rj3Ks6m4Kcq+dc39Mih0DJA5aeMp0p6xSrbnUlBGwz6
         RMm8Ojgr/ZNcSPjcm5EvdZM8N2tRS+pMGmBkGCi1PbZLc6ziECmPlTU996BNCq2/h+9U
         sTqwk8CpP5mz20+Q//4B/afkPZ8Zsd1DFieire3Que5JzM+ZMBb8Cq0pUBeEaOeHq0xY
         73juqi7YksHl/YPTsE/PVnzsT+miB6BOXpQfFPH9Nr6eNbAGDSjJCJmItaucFyQGJbqP
         v0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otP/fS0DMAxwL/ktTFsEF847f97cFdYd5Wn5jvZxUIM=;
        b=Yfr/UxcCK4Lk637PJ3Y20HMzDv52Vma4t415aqF2DnYuWtzuhy8UWZyPg9rPUMiGyt
         WNdkytGRirk9ta0yj3BRdPwnRPdzwtIvj+WCvRYj6tGAORBDhQBYPeFoJjZcCujerC1z
         rV4vloQTMvB9MCpI9wJDLFKU2jJb9vTVz31iCa9N+drB/1Hwl0SJvLZl1xNtC0LYkj6m
         uW5H60UiNl3PUvgQh8gc6j0MaT8SiROR+xmQf/hnL8ZCqbLk4Uu1YcRZFZt2KUvUQ5RI
         +tPaxs7OCd7G846KCkCSc2R5YDnkNIIJ2r0d2+ApWEG19qGi+b96NHh8KC9H6feUEhjf
         tCNw==
X-Gm-Message-State: AOAM531/qVDSc98QEjQ2cUSfeeAx5F3E9RoH6upEtD89mzJJryKOZnZa
        V5gyKfXFtprQNcerFfKqviAwsRygcYfWig==
X-Google-Smtp-Source: ABdhPJydlLeuZIXJXfLhoj23EM1F+R7ljiiq85/hD1YBrzCnB8TXIgsyW4MwzHNAd/eB9KQfDZFjbw==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr8691728wrv.200.1639077574571;
        Thu, 09 Dec 2021 11:19:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x13sm562180wrr.47.2021.12.09.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:19:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 03/10] range-diff.c: use "size_t" to refer to "struct string_list"'s "nr"
Date:   Thu,  9 Dec 2021 20:19:20 +0100
Message-Id: <RFC-patch-03.10-183418f1223-20211209T191653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g0f9292b224d
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding commit the "nr" member of "struct string_list" was
changed to be "size_t" instead of an "unsigned int". Let's follow suit
here and do the same for our corresponding index variables.

We can also use the st_mult() helper again prepare the argument to
ALLOC_ARRAY(), but this time correctly as the "n" is unsigned. The
same goes for a new addition of "st_add()" for "a->nr + b->nr".

There was a segfault in range-diff.c and linear-assignment.c due to an
"int" overflow. This doesn't solve that problem, but on my system
moves it around a bit. Before this we'd segfault in the
"get_correspondences()" function in range-diff.c, specifically on this
line in the first loop in that function:

    cost[i + n * j] = 0

Now we'll instead make it all the way into compute_assignment() called
by that same function, and segfault on line 37 of linear-assignment.c in:

    if (COST(j, i1) > COST(j, i))

Which is defined as:

    #define COST(column, row) cost[(column) + column_count * (row)]

And will overflow thusly, with a segfault as we try to use that as a
negative index into "cost":

    (GDB) p j + column_count * i
    $10 = -2147454537

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 range-diff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 170e8623313..41003033752 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -237,7 +237,7 @@ static int patch_util_cmp(const void *dummy, const struct patch_util *a,
 static void find_exact_matches(struct string_list *a, struct string_list *b)
 {
 	struct hashmap map = HASHMAP_INIT((hashmap_cmp_fn)patch_util_cmp, NULL);
-	int i;
+	size_t i;
 
 	/* First, add the patches of a to a hash map */
 	for (i = 0; i < a->nr; i++) {
@@ -308,11 +308,11 @@ static int diffsize(const char *a, const char *b)
 static void get_correspondences(struct string_list *a, struct string_list *b,
 				int creation_factor)
 {
-	int n = a->nr + b->nr;
+	size_t n = st_add(a->nr, b->nr);
 	int *cost, c, *a2b, *b2a;
-	int i, j;
+	size_t i, j;
 
-	ALLOC_ARRAY(cost, n * n);
+	ALLOC_ARRAY(cost, st_mult(n, n));
 	ALLOC_ARRAY(a2b, n);
 	ALLOC_ARRAY(b2a, n);
 
@@ -473,7 +473,7 @@ static void output(struct string_list *a, struct string_list *b,
 {
 	struct strbuf buf = STRBUF_INIT, dashes = STRBUF_INIT;
 	int patch_no_width = decimal_width(1 + (a->nr > b->nr ? a->nr : b->nr));
-	int i = 0, j = 0;
+	size_t i = 0, j = 0;
 	struct diff_options opts;
 	struct strbuf indent = STRBUF_INIT;
 
-- 
2.34.1.930.g0f9292b224d

