Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35168205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 08:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755789AbdAJIsw (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:48:52 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35866 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755491AbdAJIss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:48:48 -0500
Received: by mail-pf0-f195.google.com with SMTP id b22so11588438pfd.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AJEvnGOQehCo8m7ppEIGxiBfVsPeWXv/W8aiINw7l9w=;
        b=tED4RjCYOB7wIxjCemHRKCaoG0aNTpnxEq4YxMSE/HyT6DwB+BQEufo88asqQJSV2O
         jrr/LHfH/iJfWSZrsQ+EM6/OWgV3Uq5P2995TsTBOE69B/VnhLeECUQ9fqTPJcfhBp6o
         84DCAivuhTX38kqKA9BUp20grVX1k5kboB8WoQYFi3KrWQYNQqTBNWe15wUI/XB3b0J6
         GQZQFyosgIhj6vgIECzK1XXLdHG2f/EX+UsY9uqRu+4yhjoimQMaNK7rk7Q7glom1v6R
         2C8be19XgABDePKrNOhYy3+leNYA141+P/Iuo1Z9T8a8BfuNMQUW0ru/rvF6RB1Z+AXQ
         8EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AJEvnGOQehCo8m7ppEIGxiBfVsPeWXv/W8aiINw7l9w=;
        b=j0VmzoQV0h/EfoaYfoy79goIPeNWKiiVF98u3rLNl592ghPGgLjXQJ3gkpbz9g15W7
         SsZqU+TFpxdyvKLybFmabNcasWOWnTmeeXFdql5EE4+dYyG/JCUKoLEV+YNcRhPN/Vs0
         QCWAS0ZcjVNQbV5tC9cthm0J3O4nZIDrglj60M2nGf+BVmWXbd4EtIHIsdj9r7uCPJTQ
         JWIV5jcgbrQ+SCPKa3xpBSqI2iot4hO1ogoUsfW/hy0rerj05FccdrpxZqMIO7J3PrEk
         eXP/NSmgxVtpVzvUhpaWKOTU9zI/dC/miA/ILxnrYPcNj1fYyrCjGrAUmv8ubc6x+sZE
         QH/g==
X-Gm-Message-State: AIkVDXLa9qgIk97XnXY9fmJNm+tk0szc0eyUwsrdLottGhqxeiIiK2JzM4geHzk6aXfQsw==
X-Received: by 10.84.237.22 with SMTP id s22mr3290219plk.163.1484038128117;
        Tue, 10 Jan 2017 00:48:48 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:48:47 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v10 00/20] port branch.c to use ref-filter's printing options
Date:   Tue, 10 Jan 2017 14:19:33 +0530
Message-Id: <20170110084953.15890-1-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options.

Initially posted here: $(gmane/279226). It was decided that this series
would follow up after refactoring ref-filter parsing mechanism, which
is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

v1 can be found here: $(gmane/288342)
v2 can be found here: $(gmane/288863)
v3 can be found here: $(gmane/290299)
v4 can be found here: $(gmane/291106)
v5b can be found here: $(gmane/292467)
v6 can be found here: http://marc.info/?l=git&m=146330914118766&w=2
v7 can be found here: http://marc.info/?l=git&m=147863593317362&w=2
v8 can be found here: http://marc.info/?l=git&m=148112502029302&w=2
v9 can be found here: http://marc.info/?l=git&m=148285579607683&w=2

Changes in this version:
1. Changes in commit messages. Made 01/20 a little more clearer.
2. Better documentation regarding usage of negative refs (15/20) and
small changes to the examples introduced to avoid confusion.
3. Revert the changes made to 'static char branch_colors[]'.
(http://marc.info/?t=148285594700011&r=1&w=2)

Thanks to Junio and Jacob for their suggestions wrt the previous version.
Interdiff at the bottom.

Karthik Nayak (20):
  ref-filter: implement %(if), %(then), and %(else) atoms
  ref-filter: include reference to 'used_atom' within 'atom_value'
  ref-filter: implement %(if:equals=<string>) and
    %(if:notequals=<string>)
  ref-filter: modify "%(objectname:short)" to take length
  ref-filter: move get_head_description() from branch.c
  ref-filter: introduce format_ref_array_item()
  ref-filter: make %(upstream:track) prints "[gone]" for invalid
    upstreams
  ref-filter: add support for %(upstream:track,nobracket)
  ref-filter: make "%(symref)" atom work with the ':short' modifier
  ref-filter: introduce refname_atom_parser_internal()
  ref-filter: introduce refname_atom_parser()
  ref-filter: make remote_ref_atom_parser() use
    refname_atom_parser_internal()
  ref-filter: rename the 'strip' option to 'lstrip'
  ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
  ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
  ref-filter: add an 'rstrip=<N>' option to atoms which deal with
    refnames
  ref-filter: allow porcelain to translate messages in the output
  branch, tag: use porcelain output
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  87 +++++--
 builtin/branch.c                   | 288 +++++++---------------
 builtin/tag.c                      |   6 +-
 ref-filter.c                       | 490 +++++++++++++++++++++++++++++++------
 ref-filter.h                       |   7 +
 t/t3203-branch-output.sh           |  16 +-
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  88 ++++++-
 t/t6302-for-each-ref-filter.sh     |  94 +++++++
 10 files changed, 781 insertions(+), 304 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 81db67d74..08be8462c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -95,13 +95,17 @@ refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
 	The option core.warnAmbiguousRefs is used to select the strict
-	abbreviation mode. The `lstrip=<N>` or `rstrip=<N>` option can
-	be appended to strip `<N>` slash-separated path components
-	from the left or right of the refname respectively (e.g.,
-	`%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
-	`%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).  if
-	`<N>` is a negative number, then only `<N>` path components
-	are left behind.
+	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
+	slash-separated path components from the front of the refname
+	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
+	`%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).
+	if `<N>` is a negative number, then only `<N>` path components
+	are left behind. (e.g., `%(refname:lstrip=-2)` turns
+	`refs/tags/foo` into `tags/foo` and `%(refname:rstrip=-1)`
+	turns `refs/tags/foo` into `refs`). When the ref does not
+	have enough components, the result becomes an empty string if
+	stripping with positive <N>, or it becomes the full refname if
+	stripping with negative <N>.  Neither is an error.

 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
@@ -222,8 +226,8 @@ We call them "opening atoms" and sometimes denote them as %($open).

 When a scripting language specific quoting is in effect, everything
 between a top-level opening atom and its matching %(end) is evaluated
-according to the semantics of the opening atom and its result is
-quoted.
+according to the semantics of the opening atom and only its result
+from the top-level is quoted.


 EXAMPLES
@@ -325,7 +329,7 @@ An example to show the usage of %(if)...%(then)...%(end).
 This prints the authorname, if present.

 ------------
-git for-each-ref --format="%(refname)%(if)%(authorname)%(then) %(color:red)Authored by: %(authorname)%(end)"
+git for-each-ref --format="%(refname)%(if)%(authorname)%(then) Authored by: %(authorname)%(end)"
 ------------

 SEE ALSO
diff --git a/builtin/branch.c b/builtin/branch.c
index 4051a18b6..cbaa6d03c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -37,12 +37,12 @@ static unsigned char head_sha1[20];

 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
-	"%(color:reset)",
-	"%(color:reset)",	/* PLAIN */
-	"%(color:red)",		/* REMOTE */
-	"%(color:reset)",	/* LOCAL */
-	"%(color:green)",	/* CURRENT */
-	"%(color:blue)",	/* UPSTREAM */
+	GIT_COLOR_RESET,
+	GIT_COLOR_NORMAL,       /* PLAIN */
+	GIT_COLOR_RED,          /* REMOTE */
+	GIT_COLOR_NORMAL,       /* LOCAL */
+	GIT_COLOR_GREEN,        /* CURRENT */
+	GIT_COLOR_BLUE,         /* UPSTREAM */
 };
 enum color_branch {
 	BRANCH_COLOR_RESET = 0,


--
2.11.0
