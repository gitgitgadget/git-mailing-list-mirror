Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720251F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeHET0L (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45803 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeHET0L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so10102741wrv.12
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOenwZNGfWniwPG3/SIwhY/2EEYAaLfG7UyqT+beZeU=;
        b=DehCCzmVLKLUO1e00mIB/3RI2Bs4vubirD7yWWOc2/lcygAfsvFt8yPbbqPwMBJUC+
         zwYcw8EzEFCxKnG8iWi1hGF6LgGWZdl39WwDC0yHOq9XQ/Hx8/CI54Nxo40vQNCDsYhL
         +vB+xb7SPvJKsaWulLIZuxktlKlD1QRwEje7RQJnK+Q0Aj6ca0Kh++nIsrpKdFdsotFK
         C5CGK8NHDEr8KIQI8tjhCxZJNx3i6mgw+WwfU5zR3r0LN8+GP/En2gZ94lHRyeAe55ma
         BFdyf6TcXUL8ZyC8WW7884Ujdr2v+aYvc86KH51lOdWX970SVpTOXOwVakmztfdHNcH9
         S5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOenwZNGfWniwPG3/SIwhY/2EEYAaLfG7UyqT+beZeU=;
        b=DRks+bMXbuDuoLEJrDA3hRGNFaLMGs1xS1DUWTCnrZ32w14Jof0tvQbzNKkyqGihbo
         OkYgY4jFSr2EgcOg7+GFDQRjubRYZZe5aEycflWZMVJpJvRx8N9rRoFqYem75fNa/w6t
         fBl5M2Yk4eJ93k5DnQSGrRnbJ8C+LGrcCLpv6Dpn6o3AXOtrMVWIyLmSo0oJhW6HfPzN
         3205GxNuxKxOGZO+WptDFMpUwiX/tKwWm0KQUV92kf0BhodBmNU63HMQ1iCmmvJ06ie5
         fyDEEGX4O6Ua6NcGKYb+GmOm5uLqk4WwUdQMvULBEaHMxsCkOq1D9j6mlheljC+0UV3I
         4aUw==
X-Gm-Message-State: AOUpUlEVnBBaX6q+JzmjmYxsHM1E9oh+l85Jx3XagpCPupkj4Tx8DFdh
        3hZAl2Oy+zfeJzwQaYb4qjZ6eEam
X-Google-Smtp-Source: AAOMgpfWjAdSED9cGJF8VUBASXeNm8JnhWzE/NJsndsAMFvGQ8V6O9KEzCEv7OMz7UiW+VLzPsPEog==
X-Received: by 2002:a5d:648a:: with SMTP id r10-v6mr7789166wru.109.1533489652871;
        Sun, 05 Aug 2018 10:20:52 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id j8-v6sm11116662wru.41.2018.08.05.10.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:20:51 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 05/11] rerere: add documentation for conflict normalization
Date:   Sun,  5 Aug 2018 18:20:31 +0100
Message-Id: <20180805172037.12530-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.720.gf7a957e2e7
In-Reply-To: <20180805172037.12530-1-t.gummerer@gmail.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180805172037.12530-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add some documentation for the logic behind the conflict normalization
in rerere.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/technical/rerere.txt | 140 +++++++++++++++++++++++++++++
 rerere.c                           |   4 -
 2 files changed, 140 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/technical/rerere.txt

diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
new file mode 100644
index 0000000000..3d10dbfa67
--- /dev/null
+++ b/Documentation/technical/rerere.txt
@@ -0,0 +1,140 @@
+Rerere
+======
+
+This document describes the rerere logic.
+
+Conflict normalization
+----------------------
+
+To ensure recorded conflict resolutions can be looked up in the rerere
+database, even when branches are merged in a different order,
+different branches are merged that result in the same conflict, or
+when different conflict style settings are used, rerere normalizes the
+conflicts before writing them to the rerere database.
+
+Different conflict styles and branch names are normalized by stripping
+the labels from the conflict markers, and removing the common ancestor
+version from the `diff3` conflict style. Branches that are merged
+in different order are normalized by sorting the conflict hunks.  More
+on each of those steps in the following sections.
+
+Once these two normalization operations are applied, a conflict ID is
+calculated based on the normalized conflict, which is later used by
+rerere to look up the conflict in the rerere database.
+
+Removing the common ancestor version
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Say we have three branches AB, AC and AC2.  The common ancestor of
+these branches has a file with a line containing the string "A" (for
+brevity this is called "line A" in the rest of the document).  In
+branch AB this line is changed to "B", in AC, this line is changed to
+"C", and branch AC2 is forked off of AC, after the line was changed to
+"C".
+
+Forking a branch ABAC off of branch AB and then merging AC into it, we
+get a conflict like the following:
+
+    <<<<<<< HEAD
+    B
+    =======
+    C
+    >>>>>>> AC
+
+Doing the analogous with AC2 (forking a branch ABAC2 off of branch AB
+and then merging branch AC2 into it), using the diff3 conflict style,
+we get a conflict like the following:
+
+    <<<<<<< HEAD
+    B
+    ||||||| merged common ancestors
+    A
+    =======
+    C
+    >>>>>>> AC2
+
+By resolving this conflict, to leave line D, the user declares:
+
+    After examining what branches AB and AC did, I believe that making
+    line A into line D is the best thing to do that is compatible with
+    what AB and AC wanted to do.
+
+As branch AC2 refers to the same commit as AC, the above implies that
+this is also compatible what AB and AC2 wanted to do.
+
+By extension, this means that rerere should recognize that the above
+conflicts are the same.  To do this, the labels on the conflict
+markers are stripped, and the common ancestor version is removed.  The above
+examples would both result in the following normalized conflict:
+
+    <<<<<<<
+    B
+    =======
+    C
+    >>>>>>>
+
+Sorting hunks
+~~~~~~~~~~~~~
+
+As before, lets imagine that a common ancestor had a file with line A
+its early part, and line X in its late part.  And then four branches
+are forked that do these things:
+
+    - AB: changes A to B
+    - AC: changes A to C
+    - XY: changes X to Y
+    - XZ: changes X to Z
+
+Now, forking a branch ABAC off of branch AB and then merging AC into
+it, and forking a branch ACAB off of branch AC and then merging AB
+into it, would yield the conflict in a different order.  The former
+would say "A became B or C, what now?" while the latter would say "A
+became C or B, what now?"
+
+As a reminder, the act of merging AC into ABAC and resolving the
+conflict to leave line D means that the user declares:
+
+    After examining what branches AB and AC did, I believe that
+    making line A into line D is the best thing to do that is
+    compatible with what AB and AC wanted to do.
+
+So the conflict we would see when merging AB into ACAB should be
+resolved the same way---it is the resolution that is in line with that
+declaration.
+
+Imagine that similarly previously a branch XYXZ was forked from XY,
+and XZ was merged into it, and resolved "X became Y or Z" into "X
+became W".
+
+Now, if a branch ABXY was forked from AB and then merged XY, then ABXY
+would have line B in its early part and line Y in its later part.
+Such a merge would be quite clean.  We can construct 4 combinations
+using these four branches ((AB, AC) x (XY, XZ)).
+
+Merging ABXY and ACXZ would make "an early A became B or C, a late X
+became Y or Z" conflict, while merging ACXY and ABXZ would make "an
+early A became C or B, a late X became Y or Z".  We can see there are
+4 combinations of ("B or C", "C or B") x ("X or Y", "Y or X").
+
+By sorting, the conflict is given its canonical name, namely, "an
+early part became B or C, a late part becames X or Y", and whenever
+any of these four patterns appear, and we can get to the same conflict
+and resolution that we saw earlier.
+
+Without the sorting, we'd have to somehow find a previous resolution
+from combinatorial explosion.
+
+Conflict ID calculation
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Once the conflict normalization is done, the conflict ID is calculated
+as the sha1 hash of the conflict hunks appended to each other,
+separated by <NUL> characters.  The conflict markers are stripped out
+before the sha1 is calculated.  So in the example above, where we
+merge branch AC which changes line A to line C, into branch AB, which
+changes line A to line C, the conflict ID would be
+SHA1('B<NUL>C<NUL>').
+
+If there are multiple conflicts in one file, the sha1 is calculated
+the same way with all hunks appended to each other, in the order in
+which they appear in the file, separated by a <NUL> character.
diff --git a/rerere.c b/rerere.c
index be98c0afcb..da1ab54027 100644
--- a/rerere.c
+++ b/rerere.c
@@ -394,10 +394,6 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
  * and NUL concatenated together.
  *
  * Return the number of conflict hunks found.
- *
- * NEEDSWORK: the logic and theory of operation behind this conflict
- * normalization may deserve to be documented somewhere, perhaps in
- * Documentation/technical/rerere.txt.
  */
 static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
 {
-- 
2.18.0.720.gf7a957e2e7

