Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E4120A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 16:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLHQhq (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 11:37:46 -0500
Received: from 0x63.nu ([109.74.10.199]:48524 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbeLHQhq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 11:37:46 -0500
Received: from ip6-localhost ([::1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gVfbr-0000Dk-9O; Sat, 08 Dec 2018 17:37:43 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v4 1/7] doc: group pretty-format.txt placeholders descriptions
Date:   Sat,  8 Dec 2018 17:36:41 +0100
Message-Id: <20181208163647.19538-2-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208163647.19538-1-anders@0x63.nu>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20181208163647.19538-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The placeholders can be grouped into three kinds:
 * literals
 * affecting formatting of later placeholders
 * expanding to information in commit

Also change the list to a definition list (using '::')

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/pretty-formats.txt | 235 ++++++++++++++++---------------
 1 file changed, 125 insertions(+), 110 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 417b638cd8..86d804fe97 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -102,118 +102,133 @@ The title was >>t4119: test autocomputing -p<n> for traditional diff input.<<
 +
 The placeholders are:
 
-- '%H': commit hash
-- '%h': abbreviated commit hash
-- '%T': tree hash
-- '%t': abbreviated tree hash
-- '%P': parent hashes
-- '%p': abbreviated parent hashes
-- '%an': author name
-- '%aN': author name (respecting .mailmap, see linkgit:git-shortlog[1]
-  or linkgit:git-blame[1])
-- '%ae': author email
-- '%aE': author email (respecting .mailmap, see
-  linkgit:git-shortlog[1] or linkgit:git-blame[1])
-- '%ad': author date (format respects --date= option)
-- '%aD': author date, RFC2822 style
-- '%ar': author date, relative
-- '%at': author date, UNIX timestamp
-- '%ai': author date, ISO 8601-like format
-- '%aI': author date, strict ISO 8601 format
-- '%cn': committer name
-- '%cN': committer name (respecting .mailmap, see
-  linkgit:git-shortlog[1] or linkgit:git-blame[1])
-- '%ce': committer email
-- '%cE': committer email (respecting .mailmap, see
-  linkgit:git-shortlog[1] or linkgit:git-blame[1])
-- '%cd': committer date (format respects --date= option)
-- '%cD': committer date, RFC2822 style
-- '%cr': committer date, relative
-- '%ct': committer date, UNIX timestamp
-- '%ci': committer date, ISO 8601-like format
-- '%cI': committer date, strict ISO 8601 format
-- '%d': ref names, like the --decorate option of linkgit:git-log[1]
-- '%D': ref names without the " (", ")" wrapping.
-- '%e': encoding
-- '%s': subject
-- '%f': sanitized subject line, suitable for a filename
-- '%b': body
-- '%B': raw body (unwrapped subject and body)
+- Placeholders that expand to a single literal character:
+'%n':: newline
+'%%':: a raw '%'
+'%x00':: print a byte from a hex code
+
+- Placeholders that affect formatting of later placeholders:
+'%Cred':: switch color to red
+'%Cgreen':: switch color to green
+'%Cblue':: switch color to blue
+'%Creset':: reset color
+'%C(...)':: color specification, as described under Values in the
+            "CONFIGURATION FILE" section of linkgit:git-config[1].  By
+            default, colors are shown only when enabled for log output
+            (by `color.diff`, `color.ui`, or `--color`, and respecting
+            the `auto` settings of the former if we are going to a
+            terminal). `%C(auto,...)` is accepted as a historical
+            synonym for the default (e.g., `%C(auto,red)`). Specifying
+            `%C(always,...) will show the colors even when color is
+            not otherwise enabled (though consider just using
+            `--color=always` to enable color for the whole output,
+            including this format and anything else git might color).
+            `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
+            on the next placeholders until the color is switched
+            again.
+'%m':: left (`<`), right (`>`) or boundary (`-`) mark
+'%w([<w>[,<i1>[,<i2>]]])':: switch line wrapping, like the -w option of
+                            linkgit:git-shortlog[1].
+'%<(<N>[,trunc|ltrunc|mtrunc])':: make the next placeholder take at
+                                  least N columns, padding spaces on
+                                  the right if necessary.  Optionally
+                                  truncate at the beginning (ltrunc),
+                                  the middle (mtrunc) or the end
+                                  (trunc) if the output is longer than
+                                  N columns.  Note that truncating
+                                  only works correctly with N >= 2.
+'%<|(<N>)':: make the next placeholder take at least until Nth
+             columns, padding spaces on the right if necessary
+'%>(<N>)', '%>|(<N>)':: similar to '%<(<N>)', '%<|(<N>)' respectively,
+                        but padding spaces on the left
+'%>>(<N>)', '%>>|(<N>)':: similar to '%>(<N>)', '%>|(<N>)'
+                          respectively, except that if the next
+                          placeholder takes more spaces than given and
+                          there are spaces on its left, use those
+                          spaces
+'%><(<N>)', '%><|(<N>)':: similar to '%<(<N>)', '%<|(<N>)'
+                          respectively, but padding both sides
+                          (i.e. the text is centered)
+
+- Placeholders that expand to information extracted from the commit:
+'%H':: commit hash
+'%h':: abbreviated commit hash
+'%T':: tree hash
+'%t':: abbreviated tree hash
+'%P':: parent hashes
+'%p':: abbreviated parent hashes
+'%an':: author name
+'%aN':: author name (respecting .mailmap, see linkgit:git-shortlog[1]
+        or linkgit:git-blame[1])
+'%ae':: author email
+'%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
+        or linkgit:git-blame[1])
+'%ad':: author date (format respects --date= option)
+'%aD':: author date, RFC2822 style
+'%ar':: author date, relative
+'%at':: author date, UNIX timestamp
+'%ai':: author date, ISO 8601-like format
+'%aI':: author date, strict ISO 8601 format
+'%cn':: committer name
+'%cN':: committer name (respecting .mailmap, see
+        linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%ce':: committer email
+'%cE':: committer email (respecting .mailmap, see
+        linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%cd':: committer date (format respects --date= option)
+'%cD':: committer date, RFC2822 style
+'%cr':: committer date, relative
+'%ct':: committer date, UNIX timestamp
+'%ci':: committer date, ISO 8601-like format
+'%cI':: committer date, strict ISO 8601 format
+'%d':: ref names, like the --decorate option of linkgit:git-log[1]
+'%D':: ref names without the " (", ")" wrapping.
+'%e':: encoding
+'%s':: subject
+'%f':: sanitized subject line, suitable for a filename
+'%b':: body
+'%B':: raw body (unwrapped subject and body)
 ifndef::git-rev-list[]
-- '%N': commit notes
+'%N':: commit notes
 endif::git-rev-list[]
-- '%GG': raw verification message from GPG for a signed commit
-- '%G?': show "G" for a good (valid) signature,
-  "B" for a bad signature,
-  "U" for a good signature with unknown validity,
-  "X" for a good signature that has expired,
-  "Y" for a good signature made by an expired key,
-  "R" for a good signature made by a revoked key,
-  "E" if the signature cannot be checked (e.g. missing key)
-  and "N" for no signature
-- '%GS': show the name of the signer for a signed commit
-- '%GK': show the key used to sign a signed commit
-- '%GF': show the fingerprint of the key used to sign a signed commit
-- '%GP': show the fingerprint of the primary key whose subkey was used
-  to sign a signed commit
-- '%gD': reflog selector, e.g., `refs/stash@{1}` or
-  `refs/stash@{2 minutes ago`}; the format follows the rules described
-  for the `-g` option. The portion before the `@` is the refname as
-  given on the command line (so `git log -g refs/heads/master` would
-  yield `refs/heads/master@{0}`).
-- '%gd': shortened reflog selector; same as `%gD`, but the refname
-  portion is shortened for human readability (so `refs/heads/master`
-  becomes just `master`).
-- '%gn': reflog identity name
-- '%gN': reflog identity name (respecting .mailmap, see
-  linkgit:git-shortlog[1] or linkgit:git-blame[1])
-- '%ge': reflog identity email
-- '%gE': reflog identity email (respecting .mailmap, see
-  linkgit:git-shortlog[1] or linkgit:git-blame[1])
-- '%gs': reflog subject
-- '%Cred': switch color to red
-- '%Cgreen': switch color to green
-- '%Cblue': switch color to blue
-- '%Creset': reset color
-- '%C(...)': color specification, as described under Values in the
-  "CONFIGURATION FILE" section of linkgit:git-config[1].
-  By default, colors are shown only when enabled for log output (by
-  `color.diff`, `color.ui`, or `--color`, and respecting the `auto`
-  settings of the former if we are going to a terminal). `%C(auto,...)`
-  is accepted as a historical synonym for the default (e.g.,
-  `%C(auto,red)`). Specifying `%C(always,...) will show the colors
-  even when color is not otherwise enabled (though consider
-  just using `--color=always` to enable color for the whole output,
-  including this format and anything else git might color).  `auto`
-  alone (i.e. `%C(auto)`) will turn on auto coloring on the next
-  placeholders until the color is switched again.
-- '%m': left (`<`), right (`>`) or boundary (`-`) mark
-- '%n': newline
-- '%%': a raw '%'
-- '%x00': print a byte from a hex code
-- '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option of
-  linkgit:git-shortlog[1].
-- '%<(<N>[,trunc|ltrunc|mtrunc])': make the next placeholder take at
-  least N columns, padding spaces on the right if necessary.
-  Optionally truncate at the beginning (ltrunc), the middle (mtrunc)
-  or the end (trunc) if the output is longer than N columns.
-  Note that truncating only works correctly with N >= 2.
-- '%<|(<N>)': make the next placeholder take at least until Nth
-  columns, padding spaces on the right if necessary
-- '%>(<N>)', '%>|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
-  respectively, but padding spaces on the left
-- '%>>(<N>)', '%>>|(<N>)': similar to '%>(<N>)', '%>|(<N>)'
-  respectively, except that if the next placeholder takes more spaces
-  than given and there are spaces on its left, use those spaces
-- '%><(<N>)', '%><|(<N>)': similar to '%<(<N>)', '%<|(<N>)'
-  respectively, but padding both sides (i.e. the text is centered)
-- %(trailers[:options]): display the trailers of the body as interpreted
-  by linkgit:git-interpret-trailers[1]. The `trailers` string may be
-  followed by a colon and zero or more comma-separated options. If the
-  `only` option is given, omit non-trailer lines from the trailer block.
-  If the `unfold` option is given, behave as if interpret-trailer's
-  `--unfold` option was given.  E.g., `%(trailers:only,unfold)` to do
-  both.
+'%GG':: raw verification message from GPG for a signed commit
+'%G?':: show "G" for a good (valid) signature,
+        "B" for a bad signature,
+        "U" for a good signature with unknown validity,
+        "X" for a good signature that has expired,
+        "Y" for a good signature made by an expired key,
+        "R" for a good signature made by a revoked key,
+        "E" if the signature cannot be checked (e.g. missing key)
+        and "N" for no signature
+'%GS':: show the name of the signer for a signed commit
+'%GK':: show the key used to sign a signed commit
+'%GF':: show the fingerprint of the key used to sign a signed commit
+'%GP':: show the fingerprint of the primary key whose subkey was used
+        to sign a signed commit
+'%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
+        minutes ago`}; the format follows the rules described for the
+        `-g` option. The portion before the `@` is the refname as
+        given on the command line (so `git log -g refs/heads/master`
+        would yield `refs/heads/master@{0}`).
+'%gd':: shortened reflog selector; same as `%gD`, but the refname
+        portion is shortened for human readability (so
+        `refs/heads/master` becomes just `master`).
+'%gn':: reflog identity name
+'%gN':: reflog identity name (respecting .mailmap, see
+        linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%ge':: reflog identity email
+'%gE':: reflog identity email (respecting .mailmap, see
+        linkgit:git-shortlog[1] or linkgit:git-blame[1])
+'%gs':: reflog subject
+'%(trailers[:options])':: display the trailers of the body as
+                          interpreted by
+                          linkgit:git-interpret-trailers[1]. The
+                          `trailers` string may be followed by a colon
+                          and zero or more comma-separated options:
+** 'only': omit non-trailer lines from the trailer block.
+** 'unfold': make it behave as if interpret-trailer's `--unfold`
+   option was given. E.g., `%(trailers:only,unfold)` unfolds and
+   shows all trailer lines.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
-- 
2.17.1

