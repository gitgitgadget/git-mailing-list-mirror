Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0558BE6FE2F
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 14:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjIVOKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjIVOKa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 10:10:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD06195
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:10:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so22672875e9.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695391821; x=1695996621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wan0nVC/tKehOnmYdzu7QYBPvNlFok8chw+FkTkh8ko=;
        b=ZOHjQp5vvb2tw8uauJz4GnPX44rsXUTSAlQoxh78LH4eX7xGDMCxwwDIwtqpeGvnpi
         3xay+SURdJZH3KE147KSX2nLWdF3rplFkosA06gkREmRp6XRnac2iLVvLkgBat3nOzGe
         6C7hHuGyvRRpU03qUSR8valVSM8V+RzJzF7bZ1Zk0wGFr3RJZaMdtwJzwbCDFhd65FRA
         I1MkzLyR0A49RknX4lvK7xLXmnuoLcSZzH9QYwGa3zwb1enWK9zOH1o1QEyirnXwhiZG
         XiEU7TVf/vS4QYk8Ncs9O0vyAiIWiaiIKDI4aMn3Zuq4hpAQe2f+dXaoYK/gW+7EeB/6
         EzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695391821; x=1695996621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wan0nVC/tKehOnmYdzu7QYBPvNlFok8chw+FkTkh8ko=;
        b=nL9SwgSz6dHsjZXuME5q6oeOouxocfXK8hdxCF+5ROkor/K23sDjbKNJwws6oL9viD
         z2uJGLO54cHStJtTYKNR39SvE8LY6yNLaD4xUoKsjAzFvQ8x6Fo0+lNhKfMzAj0S6agb
         Vl1I/jqQcSR8hWFOO7OXzfbsl9VCBEFfw3M0wbXQpYC5RaTlxs3foqxj7pufnRxFim+U
         xvk6R6RIZwR6G0WA9M0zARdS/JPSVLKJFUb85ZlTIshrRPZfutsqKAAf2Ihu5WeKgxb8
         qJE+JYDxlpzVrXAKS258FhSsMZ9+SilzoR3ZYagG3z+0v8xKD6S+Z5pTs2atGAPGe7TX
         b4cQ==
X-Gm-Message-State: AOJu0YyM7XuCDluaEw1aWJ3LmIetNS4oMsN77fn26XeD8fMtgX8Qj+0p
        MCo3gMoIlIb6G6P4cNBNuBwlCbdg4+g=
X-Google-Smtp-Source: AGHT+IENn1TteLMxr9FhPDH/aqTgPjZgteLIozR+wVUdCy820COtC9LddTioDcqwK3EU2iUoDas2pg==
X-Received: by 2002:a05:600c:20c1:b0:3fe:1679:ba7b with SMTP id y1-20020a05600c20c100b003fe1679ba7bmr8610020wmm.24.1695391820390;
        Fri, 22 Sep 2023 07:10:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c0b4300b003fe1fe56202sm4839881wmr.33.2023.09.22.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:10:20 -0700 (PDT)
Message-ID: <pull.950.git.1695391818917.gitgitgadget@gmail.com>
From:   "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 14:10:18 +0000
Subject: [PATCH] pretty-formats.txt: fix whitespace
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Josh Soref <jsoref@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Soref <jsoref@gmail.com>

* two spaces after periods for sentences
* comma (before/)after `i.e.` and `e.g.`
* comma after `etc.` when not ending a sentence
* space before `(`

Signed-off-by: Josh Soref <jsoref@gmail.com>
---
    pretty-formats.txt: fix whitespace
    
    follow-up-to:
    https://github.com/gitgitgadget/git/pull/939#discussion_r624652778
    
     * two spaces after periods for sentences
     * comma (before/)after i.e. and e.g.
     * space before (
    
    Signed-off-by: Josh Soref jsoref@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-950%2Fjsoref%2Fwhitespace-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-950/jsoref/whitespace-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/950

 Documentation/pretty-formats.txt | 68 ++++++++++++++++----------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d38b4ab5666..f64c0a2d92e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -15,7 +15,7 @@ There are several built-in formats, and you can define
 additional formats by setting a pretty.<name>
 config option to either another format name, or a
 'format:' string, as described below (see
-linkgit:git-config[1]). Here are the details of the
+linkgit:git-config[1]).  Here are the details of the
 built-in formats:
 
 * 'oneline'
@@ -96,15 +96,15 @@ stored in the commit object.  Notably, the hashes are
 displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts or history
-simplification into account. Note that this format affects the way
-commits are displayed, but not the way the diff is shown e.g. with
-`git log --raw`. To get full object names in a raw diff format,
+simplification into account.  Note that this format affects the way
+commits are displayed, but not the way the diff is shown, e.g., with
+`git log --raw`.  To get full object names in a raw diff format,
 use `--no-abbrev`.
 
 * 'format:<format-string>'
 +
 The 'format:<format-string>' format allows you to specify which information
-you want to show. It works a little bit like printf format,
+you want to show.  It works a little bit like printf format,
 with the notable exception that you get a newline with '%n'
 instead of '\n'.
 +
@@ -136,13 +136,13 @@ The placeholders are:
 	    default, colors are shown only when enabled for log output
 	    (by `color.diff`, `color.ui`, or `--color`, and respecting
 	    the `auto` settings of the former if we are going to a
-	    terminal). `%C(auto,...)` is accepted as a historical
-	    synonym for the default (e.g., `%C(auto,red)`). Specifying
+	    terminal).  `%C(auto,...)` is accepted as a historical
+	    synonym for the default (e.g., `%C(auto,red)`).  Specifying
 	    `%C(always,...)` will show the colors even when color is
 	    not otherwise enabled (though consider just using
 	    `--color=always` to enable color for the whole output,
 	    including this format and anything else git might color).
-	    `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
+	    `auto` alone (i.e., `%C(auto)`) will turn on auto coloring
 	    on the next placeholders until the color is switched
 	    again.
 '%m':: left (`<`), right (`>`) or boundary (`-`) mark
@@ -177,7 +177,7 @@ The placeholders are:
 			  spaces
 '%><( <N> )', '%><|( <M> )':: similar to '%<( <N> )', '%<|( <M> )'
 			  respectively, but padding both sides
-			  (i.e. the text is centered)
+			  (i.e., the text is centered)
 
 - Placeholders that expand to information extracted from the commit:
 '%H':: commit hash
@@ -225,9 +225,9 @@ The placeholders are:
 '%d':: ref names, like the --decorate option of linkgit:git-log[1]
 '%D':: ref names without the " (", ")" wrapping.
 '%(decorate[:<options>])'::
-ref names with custom decorations. The `decorate` string may be followed by a
-colon and zero or more comma-separated options. Option values may contain
-literal formatting codes. These must be used for commas (`%x2C`) and closing
+ref names with custom decorations.  The `decorate` string may be followed by a
+colon and zero or more comma-separated options.  Option values may contain
+literal formatting codes.  These must be used for commas (`%x2C`) and closing
 parentheses (`%x29`), due to their role in the option syntax.
 +
 ** 'prefix=<value>': Shown before the list of ref names.  Defaults to "{nbsp}`(`".
@@ -235,7 +235,7 @@ parentheses (`%x29`), due to their role in the option syntax.
 ** 'separator=<value>': Shown between ref names.  Defaults to "`,`{nbsp}".
 ** 'pointer=<value>': Shown between HEAD and the branch it points to, if any.
 		      Defaults to "{nbsp}`->`{nbsp}".
-** 'tag=<value>': Shown before tag names. Defaults to "`tag:`{nbsp}".
+** 'tag=<value>': Shown before tag names.  Defaults to "`tag:`{nbsp}".
 
 +
 For example, to produce decorations with no wrapping
@@ -277,7 +277,7 @@ endif::git-rev-list[]
 	"X" for a good signature that has expired,
 	"Y" for a good signature made by an expired key,
 	"R" for a good signature made by a revoked key,
-	"E" if the signature cannot be checked (e.g. missing key)
+	"E" if the signature cannot be checked (e.g., missing key)
 	and "N" for no signature
 '%GS':: show the name of the signer for a signed commit
 '%GK':: show the key used to sign a signed commit
@@ -287,7 +287,7 @@ endif::git-rev-list[]
 '%GT':: show the trust level for the key used to sign a signed commit
 '%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
 	minutes ago}`; the format follows the rules described for the
-	`-g` option. The portion before the `@` is the refname as
+	`-g` option.  The portion before the `@` is the refname as
 	given on the command line (so `git log -g refs/heads/master`
 	would yield `refs/heads/master@{0}`).
 '%gd':: shortened reflog selector; same as `%gD`, but the refname
@@ -302,48 +302,48 @@ endif::git-rev-list[]
 '%gs':: reflog subject
 '%(trailers[:<options>])'::
 display the trailers of the body as interpreted by
-linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
-a colon and zero or more comma-separated options. If any option is provided
+linkgit:git-interpret-trailers[1].  The `trailers` string may be followed by
+a colon and zero or more comma-separated options.  If any option is provided
 multiple times, the last occurrence wins.
 +
-** 'key=<key>': only show trailers with specified <key>. Matching is done
-   case-insensitively and trailing colon is optional. If option is
+** 'key=<key>': only show trailers with specified <key>.  Matching is done
+   case-insensitively and trailing colon is optional.  If option is
    given multiple times trailer lines matching any of the keys are
-   shown. This option automatically enables the `only` option so that
-   non-trailer lines in the trailer block are hidden. If that is not
+   shown.  This option automatically enables the `only` option so that
+   non-trailer lines in the trailer block are hidden.  If that is not
    desired it can be disabled with `only=false`.  E.g.,
    `%(trailers:key=Reviewed-by)` shows trailer lines with key
    `Reviewed-by`.
 ** 'only[=<bool>]': select whether non-trailer lines from the trailer
    block should be included.
 ** 'separator=<sep>': specify a separator inserted between trailer
-   lines. When this option is not given each trailer line is
-   terminated with a line feed character. The string <sep> may contain
-   the literal formatting codes described above. To use comma as
+   lines.  When this option is not given each trailer line is
+   terminated with a line feed character.  The string <sep> may contain
+   the literal formatting codes described above.  To use comma as
    separator one must use `%x2C` as it would otherwise be parsed as
-   next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
+   next option.  E.g., `%(trailers:key=Ticket,separator=%x2C )`
    shows all trailer lines whose key is "Ticket" separated by a comma
    and a space.
 ** 'unfold[=<bool>]': make it behave as if interpret-trailer's `--unfold`
-   option was given. E.g.,
+   option was given.  E.g.,
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
 ** 'keyonly[=<bool>]': only show the key part of the trailer.
 ** 'valueonly[=<bool>]': only show the value part of the trailer.
 ** 'key_value_separator=<sep>': specify a separator inserted between
-   trailer lines. When this option is not given each trailer key-value
-   pair is separated by ": ". Otherwise it shares the same semantics
+   trailer lines.  When this option is not given each trailer key-value
+   pair is separated by ": ".  Otherwise it shares the same semantics
    as 'separator=<sep>' above.
 
 NOTE: Some placeholders may depend on other options given to the
-revision traversal engine. For example, the `%g*` reflog options will
+revision traversal engine.  For example, the `%g*` reflog options will
 insert an empty string unless we are traversing reflog entries (e.g., by
-`git log -g`). The `%d` and `%D` placeholders will use the "short"
+`git log -g`).  The `%d` and `%D` placeholders will use the "short"
 decoration format if `--decorate` was not already provided on the command
 line.
 
-The boolean options accept an optional value `[=<bool-value>]`. The values
-`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
-sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
+The boolean options accept an optional value `[=<bool-value>]`.  The values
+`true`, `false`, `on`, `off`, etc., are all accepted.  See the "boolean"
+sub-section in "EXAMPLES" in linkgit:git-config[1].  If a boolean
 option is given with no value, it's enabled.
 
 If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
@@ -361,7 +361,7 @@ placeholder expands to a non-empty string.
 * 'tformat:'
 +
 The 'tformat:' format works exactly like 'format:', except that it
-provides "terminator" semantics instead of "separator" semantics. In
+provides "terminator" semantics instead of "separator" semantics.  In
 other words, each commit has the message terminator character (usually a
 newline) appended, rather than a separator placed between entries.
 This means that the final entry of a single-line format will be properly

base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
-- 
gitgitgadget
