Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BEBF1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 16:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeKSDJA (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 22:09:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44583 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeKSDI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 22:08:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so24142624lji.11
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 08:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeHdwNasbmf/skFoWeHtCI7DAqBm7YUhihd0VLHhHOg=;
        b=SusIcsHaQJHKTV8/RXMmzxWihEiUCJQ73dJO3ZapHc/TVGw78UYHk24EAMy6no0x3T
         5x+5nueLjBYtoqoEi7trlg2q/XvuDs4PC+3Vdf6nBUEXRaTEyLbOogPGOQPTYglFIMOD
         BAiJnRbZP9WJfq6G91Do8DhjSPNPVjfnP4nJn/Ddkoe/cROkO8Qh+T8E+JVYz6jrkzwL
         KsmXD+LY1st2dCSRG94QIyrEU+Jea1+Ynq+tVGakIAPBlHjSB0OsthyghuGpgotN3Aov
         RoG4Zq9qHNrUUwjtHfj5HtBFMju3dy79C3IGGXSm4Bkut3fgdw3V2gaMU0pdHJ9Myfh5
         Aztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeHdwNasbmf/skFoWeHtCI7DAqBm7YUhihd0VLHhHOg=;
        b=OOlSPVFB2zQmOYWwVwtZMIixQHd309KpkKcWaz2XqNaqd36ZVxkQp37TUhgRLi/H/p
         9N0UxNUkVoBBAEsWBpp4+zxwuHMAU3z/BXj6ZpN8wN7hPyYI+e0TiJmyRSWsdM8ECiX0
         cjHe5NrOcCTmlL2CeRq2T0hVVOJRolRTua84CygCJjwJzidAf9rd63oYbfkuyb2Upd6j
         TMR5gyRJlhPXgEE3uW97UXf9aJPtjuKzZ3ScFRbxsBZXmkB3rFmjHZd4I+gd5X5j9d8b
         RBVVFQkyerfVX30NwYlts0U/HBtoVVfiAScqQTiwQMMKp+pHeNhEN5BrfJnhsSc7aQap
         DfDQ==
X-Gm-Message-State: AGRZ1gLPuwfXSmAArgGl/QIW6fHqbknzy1sxrLsmEiHobN5GPmB3YY8v
        6mmiy4QXVX6oxywSKK3nFJpZK2VI
X-Google-Smtp-Source: AJdET5eogXcVzgm59xfkPk48F8RpgWM8sL0Y3fyfeE61dHGzEvt/ls9Ewmcxijc+x6hlPibVzy7XyQ==
X-Received: by 2002:a2e:1551:: with SMTP id 17-v6mr9748675ljv.68.1542559692234;
        Sun, 18 Nov 2018 08:48:12 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f29sm4461603lfa.46.2018.11.18.08.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 08:48:11 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/5] tree-walk: support :(attr) matching
Date:   Sun, 18 Nov 2018 17:48:00 +0100
Message-Id: <20181118164800.32759-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181118164800.32759-1-pclouds@gmail.com>
References: <20181118164800.32759-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lets us use :(attr) with "git grep <tree-ish>" or "git log".

:(attr) requires another round of checking before we can declare that
a path is matched. This is done after path matching since we have lots
of optimization to take a shortcut when things don't match.

Note that if :(attr) is present, we can't return
all_entries_interesting / all_entries_not_interesting anymore because
we can't be certain about that. Not until match_pathspec_attrs() can
tell us "yes all these paths satisfy :(attr)".

Second note. Even though we walk a specific tree, we use attributes
from _worktree_ (or falling back to the index), not from .gitattributes
files on that tree. This by itself is not necessarily wrong, but the
user just have to be aware of this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/glossary-content.txt |  2 +
 t/t6135-pathspec-with-attrs.sh     | 58 +++++++++++++++++++++++++-
 tree-walk.c                        | 67 +++++++++++++++++++++++-------
 3 files changed, 112 insertions(+), 15 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 0d2aa48c63..023ca95e7c 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -404,6 +404,8 @@ these forms:
 - "`!ATTR`" requires that the attribute `ATTR` be
   unspecified.
 +
+Note that when matching against a tree object, attributes are still
+obtained from working tree, not from the given tree object.
 
 exclude;;
 	After a path matches any non-exclude pathspec, it will be run
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index e436a73962..457cc167c7 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -31,7 +31,7 @@ test_expect_success 'setup a tree' '
 	mkdir sub &&
 	while read path
 	do
-		: >$path &&
+		echo content >$path &&
 		git add $path || return 1
 	done <expect &&
 	git commit -m "initial commit" &&
@@ -48,6 +48,10 @@ test_expect_success 'pathspec with labels and non existent .gitattributes' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'pathspec with labels and non existent .gitattributes (2)' '
+	test_must_fail git grep content HEAD -- ":(attr:label)"
+'
+
 test_expect_success 'setup .gitattributes' '
 	cat <<-\EOF >.gitattributes &&
 	fileA labelA
@@ -74,6 +78,15 @@ test_expect_success 'check specific set attr' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check specific set attr (2)' '
+	cat <<-\EOF >expect &&
+	HEAD:fileSetLabel
+	HEAD:sub/fileSetLabel
+	EOF
+	git grep -l content HEAD ":(attr:label)" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'check specific unset attr' '
 	cat <<-\EOF >expect &&
 	fileUnsetLabel
@@ -83,6 +96,15 @@ test_expect_success 'check specific unset attr' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check specific unset attr (2)' '
+	cat <<-\EOF >expect &&
+	HEAD:fileUnsetLabel
+	HEAD:sub/fileUnsetLabel
+	EOF
+	git grep -l content HEAD ":(attr:-label)" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'check specific value attr' '
 	cat <<-\EOF >expect &&
 	fileValue
@@ -94,6 +116,16 @@ test_expect_success 'check specific value attr' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'check specific value attr (2)' '
+	cat <<-\EOF >expect &&
+	HEAD:fileValue
+	HEAD:sub/fileValue
+	EOF
+	git grep -l content HEAD ":(attr:label=foo)" >actual &&
+	test_cmp expect actual &&
+	test_must_fail git grep -l content HEAD ":(attr:label=bar)"
+'
+
 test_expect_success 'check unspecified attr' '
 	cat <<-\EOF >expect &&
 	.gitattributes
@@ -118,6 +150,30 @@ test_expect_success 'check unspecified attr' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check unspecified attr (2)' '
+	cat <<-\EOF >expect &&
+	HEAD:.gitattributes
+	HEAD:fileA
+	HEAD:fileAB
+	HEAD:fileAC
+	HEAD:fileB
+	HEAD:fileBC
+	HEAD:fileC
+	HEAD:fileNoLabel
+	HEAD:fileWrongLabel
+	HEAD:sub/fileA
+	HEAD:sub/fileAB
+	HEAD:sub/fileAC
+	HEAD:sub/fileB
+	HEAD:sub/fileBC
+	HEAD:sub/fileC
+	HEAD:sub/fileNoLabel
+	HEAD:sub/fileWrongLabel
+	EOF
+	git grep -l ^ HEAD ":(attr:!label)" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'check multiple unspecified attr' '
 	cat <<-\EOF >expect &&
 	.gitattributes
diff --git a/tree-walk.c b/tree-walk.c
index 517bcdecf9..08210a4109 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -949,7 +949,8 @@ static enum interesting do_match(struct index_state *istate,
 		       PATHSPEC_LITERAL |
 		       PATHSPEC_GLOB |
 		       PATHSPEC_ICASE |
-		       PATHSPEC_EXCLUDE);
+		       PATHSPEC_EXCLUDE |
+		       PATHSPEC_ATTR);
 
 	if (!ps->nr) {
 		if (!ps->recursive ||
@@ -981,14 +982,20 @@ static enum interesting do_match(struct index_state *istate,
 
 			if (!ps->recursive ||
 			    !(ps->magic & PATHSPEC_MAXDEPTH) ||
-			    ps->max_depth == -1)
-				return all_entries_interesting;
-
-			return within_depth(base_str + matchlen + 1,
-					    baselen - matchlen - 1,
-					    !!S_ISDIR(entry->mode),
-					    ps->max_depth) ?
-				entry_interesting : entry_not_interesting;
+			    ps->max_depth == -1) {
+				if (!item->attr_match_nr)
+					return all_entries_interesting;
+				else
+					goto interesting;
+			}
+
+			if (within_depth(base_str + matchlen + 1,
+					 baselen - matchlen - 1,
+					 !!S_ISDIR(entry->mode),
+					 ps->max_depth))
+				goto interesting;
+			else
+				return entry_not_interesting;
 		}
 
 		/* Either there must be no base, or the base must match. */
@@ -996,12 +1003,12 @@ static enum interesting do_match(struct index_state *istate,
 			if (match_entry(item, entry, pathlen,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
-				return entry_interesting;
+				goto interesting;
 
 			if (item->nowildcard_len < item->len) {
 				if (!git_fnmatch(item, match + baselen, entry->path,
 						 item->nowildcard_len - baselen))
-					return entry_interesting;
+					goto interesting;
 
 				/*
 				 * Match all directories. We'll try to
@@ -1022,7 +1029,7 @@ static enum interesting do_match(struct index_state *istate,
 				    !ps_strncmp(item, match + baselen,
 						entry->path,
 						item->nowildcard_len - baselen))
-					return entry_interesting;
+					goto interesting;
 			}
 
 			continue;
@@ -1057,7 +1064,7 @@ static enum interesting do_match(struct index_state *istate,
 		if (!git_fnmatch(item, match, base->buf + base_offset,
 				 item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
-			return entry_interesting;
+			goto interesting;
 		}
 
 		/*
@@ -1071,7 +1078,7 @@ static enum interesting do_match(struct index_state *istate,
 		    !ps_strncmp(item, match, base->buf + base_offset,
 				item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
-			return entry_interesting;
+			goto interesting;
 		}
 
 		strbuf_setlen(base, base_offset + baselen);
@@ -1085,6 +1092,38 @@ static enum interesting do_match(struct index_state *istate,
 		 */
 		if (ps->recursive && S_ISDIR(entry->mode))
 			return entry_interesting;
+		continue;
+interesting:
+		if (item->attr_match_nr) {
+			int ret;
+
+			/*
+			 * Must not return all_entries_not_interesting
+			 * prematurely. We do not know if all entries do not
+			 * match some attributes with current attr API.
+			 */
+			never_interesting = entry_not_interesting;
+
+			/*
+			 * Consider all directories interesting (because some
+			 * of those files inside may match some attributes
+			 * even though the parent dir does not)
+			 *
+			 * FIXME: attributes _can_ match directories and we
+			 * can probably return all_entries_interesting or
+			 * all_entries_not_interesting here if matched.
+			 */
+			if (S_ISDIR(entry->mode))
+				return entry_interesting;
+
+			strbuf_add(base, entry->path, pathlen);
+			ret = match_pathspec_attrs(istate, base->buf + base_offset,
+						   base->len - base_offset, item);
+			strbuf_setlen(base, base_offset + baselen);
+			if (!ret)
+				continue;
+		}
+		return entry_interesting;
 	}
 	return never_interesting; /* No matches */
 }
-- 
2.19.1.1327.g328c130451.dirty

