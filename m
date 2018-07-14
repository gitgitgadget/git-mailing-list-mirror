Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484CD1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbeGNWFY (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38931 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeGNWFX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so28272128wre.6
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EBj0qzrqYATWwiFk2p+eCisRWC3N47zaVdEEaQo3MfA=;
        b=XKMhRMzVXhUZq8+wWgGPMoVnrEZlkAgoP+twL33+lMDu7ubFEKil86luTV/1nk05ZK
         xrC5Z7OiCo4ujsTV0uj/JQTIKjDP4rDjW3WYkp5jx56fdYxHJC4BvHnRWOSTwpAEDlKp
         pVNAvsvt8Rjhnv2RZO9S9A6L5O/Uxrke6/Sts1Ht/4BT1DbjoLzkpewqIz6F8H1tl+of
         ktQeNUWJfjuywDI44SyH7AfJZD1kt08AijpVWjt7AeuroPlAuXjGwuckKJkzZeNAjJpk
         hW7CBZL/QC50nhkelmdBQ3zzS5RkRHNuyaz0fqYdjEQBeYUA2J9cJw23auFjrz8B+D7Y
         fyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EBj0qzrqYATWwiFk2p+eCisRWC3N47zaVdEEaQo3MfA=;
        b=EacM1KpAX33lqlp/GleLyYRGA5tMUK3BSdnGdDTmsXKc+JY6oTp85XK9+LMgMmDFeu
         eqmyl7sx9KUksyT1JVB32VK+2b4qMRR8hDRHZDnSva5qfrCakeXVOMMicRfdwxcRL5Xp
         Kv/lH4Y0135N73HghRoIJeWTA1lHXn/O0rprQhgTVV4cqLZovvSzSd9af1CIrmh4CDQP
         UgFpEFq3/BJpoHsL509tgvzVCpE/mxutQ9hxbGN7BfruMcFrU2R6WIOh5O7OynWLDRNR
         NJ2o5/bTjod7IIN8tgYWA+DiaLm4te3Exj5H9LMHONoZiBZdkLstWytjmhu6hsoERGSq
         FOcw==
X-Gm-Message-State: AOUpUlE/8qMbo+ZJBsW2FqJAmirOwZ8/6Rc3J1JoThriukG0lbm2ANXt
        /C21/PM3F0TujKP08iphutfQxa4/
X-Google-Smtp-Source: AAOMgpccUTCYteNQnmpi12I2JIA2+iGL6nTaL1C/J1jsOhtRPyKuFeP+lz1R4Y4pJIlkxuhPm/timA==
X-Received: by 2002:adf:b851:: with SMTP id u17-v6mr8891855wrf.73.1531604696573;
        Sat, 14 Jul 2018 14:44:56 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id x6-v6sm31092180wrd.57.2018.07.14.14.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:44:55 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 05/11] rerere: add documentation for conflict normalization
Date:   Sat, 14 Jul 2018 22:44:37 +0100
Message-Id: <20180714214443.7184-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
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
index 0000000000..4102cce7aa
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
+the labels from the conflict markers, and removing extraneous
+information from the `diff3` conflict style. Branches that are merged
+in different order are normalized by sorting the conflict hunks.  More
+on each of those steps in the following sections.
+
+Once these two normalization operations are applied, a conflict ID is
+calculated based on the normalized conflict, which is later used by
+rerere to look up the conflict in the rerere database.
+
+Stripping extraneous information
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+markers are stripped, and the diff3 output is removed.  The above
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
2.17.0.410.g65aef3a6c4

