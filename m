Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A09C77B73
	for <git@archiver.kernel.org>; Wed, 24 May 2023 21:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbjEXVlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbjEXVlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 17:41:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F1412E;
        Wed, 24 May 2023 14:41:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d3578c25bso1655261b3a.3;
        Wed, 24 May 2023 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684964505; x=1687556505;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnRtfp3tCrc8AQGHdXIr2CkyOeWD7CxPqj01SWcWm7w=;
        b=hPCpmXqv5TBFfN120t1mLg42XkRg6GkCky62hsjV7r5/W62ZLMeqg1vTscG51AtduN
         oV2OJ0UfOhIhbtDmjh1LR5RzkmgcpNBWc94k/tLrKvjwaVM5zO+teoFcHATKutq6CdYT
         frYGIq7uCrkvKmGNoCcO4Ja+DbXlQxcUFukaC9TWXO5r16lUbRAvZ/MD1myAl4DZkHlr
         A/RGKPMX3jMKcAQm8U77beGvaoJlQC5clZGKQoXwUyubvtvABzOrjTcSgPL0i7yD2fgz
         RqCNERP4ES2AU7uXJVGVgyugVLtBX6hCgxkiaEa979SvC2rAn32Oiy5lv5vIDkgFEDzv
         ksXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684964505; x=1687556505;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KnRtfp3tCrc8AQGHdXIr2CkyOeWD7CxPqj01SWcWm7w=;
        b=amnlGfw2hAKDaOw4c8kHJUsDcT6yyLTEFySVgpAqcMb3IgbtAYPA6RJRSlf8hVLCQN
         ctFy0kxaOt6eyn+xuP2SENQuFIjUV8D4fsuLL1JYiWShvLZkwXBaf2i8honxjAkIxHQ8
         wqHe5QJ1hiZL4qSKML64nQWl8HR8Ogl4Pmyjvn2PPoqvkFenwzyWIw7V50mQ19eXB46x
         cXvPaJI10i7ViUGfV4y8Bnm4xYseC1feN2Ns9IGJGGNDcYlSXZ3krFsHsOhDcYDMxida
         2rZ/s/bXc6ybN5RV9+T/HxczivLObHB1NnKMkUPJK4EE2INLqkuIKaQzFv4W2ah5Vf+z
         zDxg==
X-Gm-Message-State: AC+VfDwf7XcWy4ffS18z6tLhZfXhqjR+YjxYOQlpOc83Ltgyi7Km/9W8
        5Fo/mNQ/e5S4DHi1b9zW6dD0mb5Z94Gxmg==
X-Google-Smtp-Source: ACHHUZ62UsUotsIPTwqYG1Zvfp4uop24dca2CgX3JxTrHawl6ClC6zVVXFC3FqpSmZpgMRwy5AjS9g==
X-Received: by 2002:a05:6a20:9f8e:b0:103:8c8b:c689 with SMTP id mm14-20020a056a209f8e00b001038c8bc689mr18382839pzb.51.1684964504761;
        Wed, 24 May 2023 14:41:44 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id e17-20020a63db11000000b0053f06d09725sm2122764pgg.32.2023.05.24.14.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 14:41:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.41.0-rc2
Date:   Thu, 25 May 2023 06:41:44 +0900
Message-ID: <xmqqedn5fluv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.41.0-rc2 is now available for testing at
the usual places.  It is comprised of 525 non-merge commits since
v2.40.0, contributed by 80 people, 25 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.41.0-rc2' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.40.0 are as follows.
Welcome to the Git development community!

  Adam Johnson, André Baptista, Andy Koppe, Clement Mabileau,
  Corentin Garcia, Cristian Le, Daniel Watson, D. Ben Knoble,
  Douglas Anderson, Edwin Kofler, Jonas Haag, Jouke Witteveen,
  Matthias Görgens, Maxim Cournoyer, Michael Henry, Michael
  Strawbridge, Nico Rieck, Raghul Nanth A, Rolf Eike Beer, Shuqi
  Liang, Siddharth Singh, Stanislav Malishevskiy, Stephane Odul,
  Vítor Pinho, and Xin Xing.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Ævar Arnfjörð Bjarmason, Alex Henrie, Andreas Schwab,
  Andrei Rybak, Beat Bolli, brian m. carlson, Christian Hesse,
  Derrick Stolee, Elijah Newren, Emily Shaffer, Eric Sunshine,
  Eric Wong, Fangyi Zhou, Felipe Contreras, Glen Choo, Han Xin,
  Jacob Keller, Jeff King, Jiang Xin, Joakim Petersen, Johannes
  Schindelin, Johannes Sixt, John Cai, John Keeping, Josh Soref,
  Junio C Hamano, Kristoffer Haugsbakk, Linus Arver, Linus
  Torvalds, Martin Ågren, Mathias Krause, Matthew John Cheetham,
  M Hickford, Michael J Gruber, Mike Hommey, Oswald Buddenhagen,
  Øystein Walle, Patrick Steinhardt, Paul Eggert, Philippe Blain,
  Phillip Wood, Randall S. Becker, René Scharfe, Robin Jarry,
  Rubén Justo, RyotaK, Sohom Datta, SZEDER Gábor, Tao Klerks,
  Taylor Blau, Teng Long, Todd Zullinger, Torsten Bögershausen,
  William Sprent, and ZheNing Hu.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.41 Release Notes (draft)
===============================

UI, Workflows & Features

 * Allow information carried on the WWW-Authenticate header to be
   passed to the credential helpers.

 * A new "fetch.hideRefs" option can be used to exclude specified refs
   from "rev-list --objects --stdin --not --all" traversal for
   checking object connectivity, most useful when there are many
   unrelated histories in a single repository.

 * "git push" has been taught to allow deletion of refs with one-level
   names to help repairing a repository who acquired such a ref by
   mistake.  In general, we don't encourage use of such a ref, and
   creation or update to such a ref is rejected as before.

 * Allow "git bisect reset" to check out the original branch when the
   branch is already checked out in a different worktree linked to the
   same repository.

 * A few subcommands have been taught to stop users from working on a
   branch that is being used in another worktree linked to the same
   repository.

 * "git format-patch" learned to write a log-message only output file
   for empty commits.

 * "git format-patch" honors the src/dst prefixes set to nonstandard
   values with configuration variables like "diff.noprefix", causing
   receiving end of the patch that expects the standard -p1 format to
   break.  "format-patch" has been taught to ignore end-user configuration
   and always use the standard prefixes.

   This is a backward compatibility breaking change.

 * Lift the limitation that colored prompts can only be used with
   PROMPT_COMMAND mode.

 * "git blame --contents=<file> <rev> -- <path>" used to be forbidden,
   but now it finds the origins of lines starting at <file> contents
   through the history that leads to <rev>.

 * "git pack-redundant" gave a warning when run, as the command has
   outlived its usefulness long ago and is nominated for future
   removal.  Now we escalate to give an error.

 * "git clone" from an empty repository learned to propagate the
   choice of the hash algorithm from the source repository to the
   newly created repository over any one of the v0/v1/v2 protocol.

 * "git mergetool" and "git difftool" learns a new configuration
   guiDefault to optionally favor configured guitool over non-gui-tool
   automatically when $DISPLAY is set.

 * "git branch -d origin/master" would say "no such branch", but it is
   likely a missed "-r" if refs/remotes/origin/master exists.  The
   command has been taught to give such a hint in its error message.

 * Clean-up of the code path that deals with merge strategy option
   handling in "git rebase".

 * "git clone --local" stops copying from an original repository that
   has symbolic links inside its $GIT_DIR; an error message when that
   happens has been updated.

 * The "--format=..." option of "git for-each-ref", "git branch", and
   "git tag" commands learn "--omit-empty" to hide refs whose
   formatting results in an empty string from the output.

 * The sendemail-validate validate hook learned to pass the total
   number of input files and where in the sequence each invocation is
   via environment variables.

 * When "gc" needs to retain unreachable objects, packing them into
   cruft packs (instead of exploding them into loose object files) has
   been offered as a more efficient option for some time.  Now the use
   of cruft packs has been made the default and no longer considered
   an experimental feature.

 * The output given by "git blame" that attributes a line to contents
   taken from the file specified by the "--contents" option shows it
   differently from a line attributed to the working tree file.

 * "git send-email" learned to give the e-mail headers to the validate
   hook by passing an extra argument from the command line.

 * The credential subsystem learns to help OAuth framework.

 * The titles of manual pages used to be chomped at an unreasonably
   short limit, which has been removed.

 * Error messages given when working on an unborn branch that is
   checked out in another worktree have been improved.

 * The documentation was misleading about the interaction between
   GIT_DEFAULT_HASH and "git clone", which has been clarified to
   stress that the variable is to be ignored by the command.

 * "git send-email" learned "--header-cmd=<cmd>" that can inject
   arbitrary e-mail header lines to the outgoing messages.

 * "git fsck" learned to detect bit-flip breakages in the reachability
   bitmap files.

 * The "--stdin" option of "git name-rev" has been replaced with
   the "--annotate-stdin" option more than a year ago.  We stop
   advertising it in the "git name-rev -h" output.

 * "git push --all" gained an alias "git push --branches".

 * "git fetch" learned the "--porcelain" option that emits what it did
   in a machine-parseable format.

 * "git --attr-source=<tree> cmd $args" is a new way to have any
   command to read attributes not from the working tree but from the
   given tree object.


Performance, Internal Implementation, Development Support etc.

 * Code clean-up to clarify directory traversal API.

 * Code clean-up to clarify the rule that "git-compat-util.h" must be
   the first to be included.

 * More work towards -Wunused.

 * Instead of forcing each command to choose to honor GPG related
   configuration variables, make the subsystem lazily initialize
   itself.

 * Remove workaround for ancient versions of DocBook to make it work
   correctly with groff, which has not been necessary since docbook
   1.76 from 2010.

 * Code clean-up to include and/or uninclude parse-options.h file as
   needed.

 * The code path that reports what "git fetch" did to each ref has
   been cleaned up.

 * Assorted config API updates.

 * A few configuration variables to tell the cURL library that
   different types of ssl-cert and ssl-key are in use have been added.

 * Split key function and data structure definitions out of cache.h to
   new header files and adjust the users.

 * "git fetch --all" does not have to download and handle the same
   bundleURI over and over, which has been corrected.

 * "git sparse-checkout" command learns a debugging aid for the sparse
   rule definitions.

 * "git write-tree" learns to work better with sparse-index.

 * The on-disk reverse index that allows mapping from the pack offset
   to the object name for the object stored at the offset has been
   enabled by default.

 * "git fsck" learned to validate the on-disk pack reverse index files.

 * strtok() and strtok_r() are banned in this codebase.

 * The detect-compilers script to help auto-tweaking the build system
   had trouble working with compilers whose version number has extra
   suffixes.  The script has been taught that certain suffixes (like
   "-win32" in "gcc 10-win32") can be safely stripped as they share
   the same features and bugs with the version without the suffix.

 * ctype tests have been taught to test EOF, too.

 * The implementation of credential helpers used fgets() over fixed
   size buffers to read protocol messages, causing the remainder of
   the folded long line to trigger unexpected behaviour, which has
   been corrected.

 * The implementation of the default "negotiator", used to find common
   ancestor over the network for object tranfer, used to be recursive;
   it was updated to be iterative to conserve stackspace usage.

 * Our custom callout formatter is no longer used in the documentation
   formatting toolchain, as the upstream default ones give better
   output these days.

 * The tracing mechanism learned to notice and report when
   auto-discovered bare repositories are being used, as allowing so
   without explicitly stating the user intends to do so (with setting
   GIT_DIR for example) can be used with social engineering as an
   attack vector.

 * "git diff-files" learned not to expand sparse-index unless needed.


Fixes since v2.40
-----------------

 * "git fsck" learned to check the index files in other worktrees,
   just like "git gc" honors them as anchoring points.
   (merge 8d3e7eac52 jk/fsck-indices-in-worktrees later to maint).

 * Fix a segfaulting loop.  The function and its caller may need
   further clean-up.
   (merge c5773dc078 ew/commit-reach-clean-up-flags-fix later to maint).

 * "git restore" supports options like "--ours" that are only
   meaningful during a conflicted merge, but these options are only
   meaningful when updating the working tree files.  These options are
   marked to be incompatible when both "--staged" and "--worktree" are
   in effect.
   (merge ee8a88826a ak/restore-both-incompatible-with-conflicts later to maint).

 * Simplify UI to control progress meter given by "git bundle" command.
   (merge 8b95521edb jk/bundle-progress later to maint).

 * "git bundle" learned that "-" is a common way to say that the input
   comes from the standard input and/or the output goes to the
   standard output.  It used to work only for output and only from the
   root level of the working tree.
   (merge 0bbe10313e jk/bundle-use-dash-for-stdfiles later to maint).

 * Once we start running, we assumed that the list of alternate object
   databases would never change.  Hook into the machinery used to
   update the list of packfiles during runtime to update this list as
   well.
   (merge e2d003dbed ds/reprepare-alternates-when-repreparing-packfiles later to maint).

 * The code to parse "git rebase -X<opt>" was not prepared to see an
   unparsable option string, which has been corrected.
   (merge 15a4cc912e ab/fix-strategy-opts-parsing later to maint).

 * "git add -p" while the index is unmerged sometimes failed to parse
   the diff output it internally produces and died, which has been
   corrected.
   (merge 28d1122f9c jk/add-p-unmerged-fix later to maint).

 * Fix for a "ls-files --format="%(path)" that produced nonsense
   output, which was a bug in 2.38.
   (merge cfb62dd006 aj/ls-files-format-fix later to maint).

 * "git receive-pack" that responds to "git push" requests failed to
   clean a stale lockfile when killed in the middle, which has been
   corrected.
   (merge c55c30669c ps/receive-pack-unlock-before-die later to maint).

 * "git rev-parse --quiet foo@{u}", or anything that asks @{u} to be
   parsed with GET_OID_QUIETLY option, did not quietly fail, which has
   been corrected.
   (merge dfbfdc521d fc/oid-quietly-parse-upstream later to maint).

 * Transports that do not support protocol v2 did not correctly fall
   back to protocol v0 under certain conditions, which has been
   corrected.
   (merge eaa0fd6584 jk/fix-proto-downgrade-to-v0 later to maint).

 * time(2) on glib 2.31+, especially on Linux, goes out of sync with
   higher resolution timers used for gettimeofday(2) and by the
   filesystem.  Replace all calls to it with a git_time() wrapper and
   (merge 370ddcbc89 pe/time-use-gettimeofday later to maint).

 * Code clean-up to use designated initializers in parse-options API.
   (merge 353e6d4554 sg/parse-options-h-initializers later to maint).

 * A recent-ish change to allow unicode character classes to be used
   with "grep -P" triggered a JIT bug in older pcre2 libraries.
   The problematic change in Git built with these older libraries has
   been disabled to work around the bug.
   (merge 14b9a04479 mk/workaround-pcre-jit-ucp-bug later to maint).

 * The wildmatch library code unlearns exponential behaviour it
   acquired some time ago since it was borrowed from rsync.
   (merge 3dc0b7f0dc pw/wildmatch-fixes later to maint).

 * The index files can become corrupt under certain conditions when
   the split-index feature is in use, especially together with
   fsmonitor, which have been corrected.
   (merge 061dd722dc js/split-index-fixes later to maint).

 * Document what the pathname-looking strings in "rev-list --object"
   output are for and what they mean.
   (merge 15364d2a3c jk/document-rev-list-object-name later to maint).

 * Fix unnecessary truncation of generation numbers used in-core.
   (merge d3af1c193d ps/ahead-behind-truncation-fix later to maint).

 * Code clean-up around the use of the_repository.
   (merge 4a93b899c1 ab/remove-implicit-use-of-the-repository later to maint).

 * Consistently spell "Message-ID" as such, not "Message-Id".
   (merge ba4324c4e1 jc/spell-id-in-both-caps-in-message-id later to maint).

 * Correct use of an uninitialized structure member.
   (merge dc12ee77ab jx/cap-object-info-uninitialized-fix later to maint).

 * Tests had a few places where we ignored PERL_PATH and blindly used
   /usr/bin/perl, which have been corrected.
   (merge c1917156a0 jk/use-perl-path-consistently later to maint).

 * Documentation mark-up fix.
   (merge 78b6369e67 la/mfc-markup-fix later to maint).

 * Doc toolchain update to remove old workaround for AsciiDoc.
   (merge 8806120de6 fc/remove-header-workarounds-for-asciidoc later to maint).

 * The userdiff regexp patterns for various filetypes that are built
   into the system have been updated to avoid triggering regexp errors
   from UTF-8 aware regex engines.
   (merge be39144954 rs/userdiff-multibyte-regex later to maint).

 * The approxidate() API has been simplified by losing an extra
   function that did the same thing as another one.
   (merge 8a7f0b666f rs/remove-approxidate-relative later to maint).

 * Code clean-up to replace a hardcoded constant with a CPP macro.
   (merge c870de6502 rs/get-tar-commit-id-use-defined-const later to maint).

 * Doc build simplification.
   (merge 9a09ed3229 fc/doc-stop-using-manversion later to maint).

 * "git archive" run from a subdirectory mishandled attributes and
   paths outside the current directory.
   (merge 92b1dd1b9e rs/archive-from-subdirectory-fixes later to maint).

 * The code to parse capability list for v0 on-wire protocol fell into
   an infinite loop when a capability appears multiple times, which
   has been corrected.

 * Geometric repacking ("git repack --geometric=<n>") in a repository
   that borrows from an alternate object database had various corner
   case bugs, which have been corrected.
   (merge d85cd18777 ps/fix-geom-repack-with-alternates later to maint).

 * The "%GT" placeholder for the "--format" option of "git log" and
   friends caused BUG() to trigger on a commit signed with an unknown
   key, which has been corrected.
   (merge 7891e46585 jk/gpg-trust-level-fix later to maint).

 * The completion script used to use bare "read" without the "-r"
   option to read the contents of various state files, which risked
   getting confused with backslashes in them.  This has been
   corrected.
   (merge 197152098a ek/completion-use-read-r-to-read-literally later to maint).

 * A small API fix to the ort merge strategy backend.
   (merge 000c4ceca7 en/ort-finalize-after-0-merges-fix later to maint).

 * The commit object parser has been taught to be a bit more lenient
   to parse timestamps on the author/committer line with a malformed
   author/committer ident.
   (merge 90ef0f14eb jk/parse-commit-with-malformed-ident later to maint).

 * Retitle a test script with an overly narrow name.
   (merge 8bb19c14fb ob/t3501-retitle later to maint).

 * Doc update to clarify how text and eol attributes interact to
   specify the end-of-line conversion.
   (merge 6696077ace ah/doc-attributes-text later to maint).

 * Gitk updates from GfW project.
   (merge 99e70f3077 js/gitk-fixes-from-gfw later to maint).

 * "git diff --dirstat" leaked memory, which has been plugged.
   (merge 83973981eb jc/dirstat-plug-leaks later to maint).

 * "git merge-tree" reads the basic configuration, which can be used
    by git forges to disable replace-refs feature.
   (merge b6551feadf ds/merge-tree-use-config later to maint).

 * A few bugs in the sequencer machinery that results in miscounting
   the steps have been corrected.
   (merge 170eea9750 js/rebase-count-fixes later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge f7111175df as/doc-markup-fix later to maint).
   (merge 90ff7c9898 fc/test-aggregation-clean-up later to maint).
   (merge 9b0c7f308a jc/am-doc-refer-to-format-patch later to maint).
   (merge b10cbdac4c bb/unicode-width-table-15 later to maint).
   (merge 3457b50e8c ab/retire-scripted-add-p later to maint).
   (merge d52fcf493b ds/p2000-fix-grep-sparse later to maint).
   (merge ec063d2591 ss/hashmap-typofix later to maint).
   (merge 1aaed69d11 rs/archive-mtime later to maint).
   (merge 2da2cc9b28 ob/rollback-after-commit-lock-failure later to maint).
   (merge 54dbd0933b ob/sequencer-save-head-simplify later to maint).
   (merge a93cbe8d78 ar/test-cleanup-unused-file-creation later to maint).
   (merge cc48ddd937 jk/chainlint-fixes later to maint).
   (merge 4833b08426 ow/ref-format-remove-unused-member later to maint).
   (merge d0ea2ca1cf dw/doc-submittingpatches-grammofix later to maint).
   (merge fd72637423 ar/t2024-checkout-output-fix later to maint).
   (merge d45cbe3fe0 ob/sequencer-i18n-fix later to maint).
   (merge b734fe49fd ob/messages-capitalize-exception later to maint).
   (merge ad353d7e77 ma/gittutorial-fixes later to maint).
   (merge a5855fd8d4 ar/test-cleanup-unused-file-creation-part2 later to maint).
   (merge 0c5308af30 sd/doc-gitignore-and-rm-cached later to maint).
   (merge cbb83daeaf kh/doc-interpret-trailers-updates later to maint).
   (merge 3d77fbb664 ar/config-count-tests-updates later to maint).
   (merge b7cf25c8f4 jc/t9800-fix-use-of-show-s-raw later to maint).

----------------------------------------------------------------

Changes since v2.40.0 are as follows:

Adam Johnson (1):
      ls-files: fix "--format" output of relative paths

Alex Henrie (5):
      rebase: add documentation and test for --no-rebase-merges
      rebase: deprecate --rebase-merges=""
      rebase: add a config option for --rebase-merges
      format-patch: correct documentation of --thread without an argument
      docs: rewrite the documentation of the text and eol attributes

Andreas Schwab (1):
      git-merge-tree.txt: replace spurious HTML entity

Andrei Rybak (19):
      t1005: assert output of ls-files
      t1006: assert error output of cat-file
      t1010: don't create unused files
      t1302: don't create unused file
      t1400: assert output of update-ref
      t1404: don't create unused file
      t1507: assert output of rev-parse
      t3060: fix mention of function prune_index
      t2107: fix mention of the_index.cache_changed
      t2024: fix loose/strict local base branch DWIM test
      t1300: drop duplicate test
      t1300: check stderr for "ignores pairs" tests
      t1300: add tests for missing keys
      t0300: don't create unused file
      t1300: fix config file syntax error descriptions
      t1300: don't create unused files
      t1450: don't create unused files
      t1502: don't create unused files
      t2019: don't create unused files

Andy Koppe (1):
      restore: fault --staged --worktree with merge opts

Beat Bolli (1):
      unicode: update the width tables to Unicode 15

Christian Hesse (1):
      imap-send: include strbuf.h

Clement Mabileau (1):
      branch: improve error log on branch not found by checking remotes refs

Corentin Garcia (1):
      doc/git-config: add unit for http.lowSpeedLimit

Daniel Watson (1):
      SubmittingPatches: clarify MUA discussion with "the"

Derrick Stolee (19):
      object-file: reprepare alternates when necessary
      for-each-ref: add --stdin option
      for-each-ref: explicitly test no matches
      commit-graph: refactor compute_topological_levels()
      commit-graph: simplify compute_generation_numbers()
      commit-graph: return generation from memory
      commit-reach: implement ahead_behind() logic
      for-each-ref: add ahead-behind format atom
      commit-reach: add tips_reachable_from_bases()
      p2000: remove stray '--sparse' flag from test
      fetch: download bundles once, even with --all
      ci: update 'static-analysis' to Ubuntu 22.04
      fsck: create scaffolding for rev-index checks
      fsck: check rev-index checksums
      fsck: check rev-index position values
      fsck: validate .rev file header
      fsck: verify checksums of all .bitmap files
      fsck: use local repository
      merge-tree: load default git config

Edwin Kofler (1):
      completion: suppress unwanted unescaping of `read`

Elijah Newren (94):
      treewide: ensure one of the appropriate headers is sourced first
      treewide: remove unnecessary git-compat-util.h includes in headers
      treewide: remove unnecessary cache.h includes
      treewide: remove unnecessary cache.h includes in source files
      alloc.h: move ALLOC_GROW() functions from cache.h
      hash.h: move some oid-related declarations from cache.h
      hex.h: move some hex-related declarations from cache.h
      cache.h: remove dependence on hex.h; make other files include it explicitly
      pretty.h: move has_non_ascii() declaration from commit.h
      ident.h: move ident-related declarations out of cache.h
      object.h: stop depending on cache.h; make cache.h depend on object.h
      dir.h: refactor to no longer need to include cache.h
      object-store.h: move struct object_info from cache.h
      replace-object.h: move read_replace_refs declaration from cache.h to here
      treewide: replace cache.h with more direct headers, where possible
      Remove unnecessary includes of builtin.h
      diff.h: remove unnecessary include of object.h
      t2021: fix platform-specific leftover cruft
      unpack-trees: heed requests to overwrite ignored files
      dir: separate public from internal portion of dir_struct
      dir: add a usage note to exclude_per_dir
      dir: mark output only fields of dir_struct as such
      unpack-trees: clean up some flow control
      sparse-checkout: avoid using internal API of unpack-trees
      sparse-checkout: avoid using internal API of unpack-trees, take 2
      unpack_trees: start splitting internal fields from public API
      unpack-trees: mark fields only used internally as internal
      unpack-trees: rewrap a few overlong lines from previous patch
      unpack-trees: special case read-tree debugging as internal usage
      unpack-trees: add usage notices around df_conflict_entry
      treewide: remove unnecessary cache.h inclusion from a few headers
      treewide: be explicit about dependence on gettext.h
      treewide: remove unnecessary inclusion of gettext.h
      treewide: remove unnecessary cache.h inclusion from several sources
      environment: move comment_line_char from cache.h
      abspath.h: move absolute path functions from cache.h
      cache.h: remove expand_user_path()
      path.h: move function declarations for path.c functions from cache.h
      wrapper.h: move declarations for wrapper.c functions from cache.h
      treewide: remove unnecessary includes of cache.h
      environment.h: move declarations for environment.c functions from cache.h
      treewide: remove cache.h inclusion due to environment.h changes
      setup.h: move declarations for setup.c functions from cache.h
      treewide: remove cache.h inclusion due to setup.h changes
      write-or-die.h: move declarations for write-or-die.c functions from cache.h
      csum-file.h: remove unnecessary inclusion of cache.h
      treewide: be explicit about dependence on trace.h & trace2.h
      treewide: be explicit about dependence on advice.h
      treewide: be explicit about dependence on convert.h
      treewide: be explicit about dependence on pack-revindex.h
      treewide: be explicit about dependence on oid-array.h
      treewide: be explicit about dependence on mem-pool.h
      treewide: remove unnecessary cache.h inclusion
      object-name.h: move declarations for object-name.c functions from cache.h
      treewide: remove cache.h inclusion due to object-name.h changes
      git-zlib: move declarations for git-zlib functions from cache.h
      treewide: remove cache.h inclusion due to git-zlib changes
      object-file.h: move declarations for object-file.c functions from cache.h
      treewide: remove cache.h inclusion due to object-file.h changes
      object.h: move some inline functions and defines from cache.h
      treewide: remove cache.h inclusion due to object.h changes
      editor: move editor-related functions and declarations into common file
      treewide: remove cache.h inclusion due to editor.h changes
      pager.h: move declarations for pager.c functions from cache.h
      treewide: remove cache.h inclusion due to pager.h changes
      cache.h: remove unnecessary includes
      treewide: remove double forward declaration of read_in_full
      treewide: reduce includes of cache.h in other headers
      mailmap, quote: move declarations of global vars to correct unit
      protocol.h: move definition of DEFAULT_GIT_PORT from cache.h
      treewide: be explicit about dependence on strbuf.h
      symlinks.h: move declarations for symlinks.c functions from cache.h
      packfile.h: move pack_window and pack_entry from cache.h
      server-info.h: move declarations for server-info.c functions from cache.h
      copy.h: move declarations for copy.c functions from cache.h
      base85.h: move declarations for base85.c functions from cache.h
      pkt-line.h: move declarations for pkt-line.c functions from cache.h
      match-trees.h: move declarations for match-trees.c functions from cache.h
      ws.h: move declarations for ws.c functions from cache.h
      versioncmp.h: move declarations for versioncmp.c functions from cache.h
      dir.h: move DTYPE defines from cache.h
      tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define from cache.h
      hash-ll.h: split out of hash.h to remove dependency on repository.h
      cache,tree: move cmp_cache_name_compare from tree.[ch] to read-cache.c
      cache,tree: move basic name compare functions from read-cache to tree
      treewide: remove cache.h inclusion due to previous changes
      cache.h: remove unnecessary headers
      fsmonitor: reduce includes of cache.h
      commit.h: reduce unnecessary includes
      object-store.h: reduce unnecessary includes
      diff.h: reduce unnecessary includes
      reftable: ensure git-compat-util.h is the first (indirect) include
      merge-ort: fix calling merge_finalize() with no intermediate merge
      t5583: fix shebang line

Emily Shaffer (1):
      mailmap: change primary address for Emily Shaffer

Eric Sunshine (1):
      tests: diagnose unclosed here-doc in chainlint.pl

Eric Wong (3):
      commit-reach: avoid NULL dereference
      fetch: support hideRefs to speed up connectivity checks
      fetch: pass --no-write-fetch-head to subprocesses

Fangyi Zhou (1):
      rebase: fix capitalisation autoSquash in i18n string

Felipe Contreras (16):
      advice: add diverging advice for novices
      test: simplify counts aggregation
      test: don't print aggregate-results command
      object-name: fix quiet @{u} parsing
      completion: prompt: use generic colors
      doc: remove GNU troff workaround
      doc: remove manpage-base-url workaround
      doc: asciidoc: remove custom header macro
      doc: simplify man version
      doc: set actual revdate for manpages
      doc: git-checkout: trivial callout cleanup
      doc: git-checkout: reorganize examples
      doc: remove custom callouts format
      doc: manpage: remove maximum title length
      doc: doc-diff: specify date
      test: rev-parse-upstream: add missing cmp

Glen Choo (10):
      config.c: plumb config_source through static fns
      config.c: don't assign to "cf_global" directly
      config.c: create config_reader and the_reader
      config.c: plumb the_reader through callbacks
      config.c: remove current_config_kvi
      config.c: remove current_parsing_scope
      config: report cached filenames in die_bad_number()
      config.c: rename "struct config_source cf"
      clone: error specifically with --local and symlinked objects
      setup: trace bare repository setups

Han Xin (2):
      negotiator/default: avoid stack overflow
      negotiator/skipping: fix some problems in mark_common()

Jacob Keller (2):
      blame: allow --contents to work with non-HEAD commit
      blame: use different author name for fake commit generated by --contents

Jeff King (90):
      ref-filter: drop unused atom parameter from get_worktree_path()
      ls-refs: drop config caching
      serve: use repository pointer to get config
      serve: mark unused parameters in virtual functions
      object-name: mark unused parameters in disambiguate callbacks
      http-backend: mark argc/argv unused
      http-backend: mark unused parameters in virtual functions
      ref-filter: mark unused callback parameters
      mark "pointless" data pointers in callbacks
      run-command: mark error routine parameters as unused
      mark unused parameters in signal handlers
      list-objects: mark unused callback parameters
      for_each_object: mark unused callback parameters
      prio-queue: mark unused parameters in comparison functions
      notes: mark unused callback parameters
      fetch-pack: mark unused parameter in callback function
      rewrite_parents(): mark unused callback parameter
      for_each_commit_graft(): mark unused callback parameter
      userformat_want_item(): mark unused parameter
      run_processes_parallel: mark unused callback parameters
      help: mark unused parameter in git_unknown_cmd_config()
      fsck: factor out index fsck
      fsck: check index files in all worktrees
      fsck: mention file path for index errors
      fsck: check even zero-entry index files
      drop pure pass-through config callbacks
      bundle: turn on --all-progress-implied by default
      bundle: let "-" mean stdin for reading operations
      bundle: document handling of "-" as stdin
      parse-options: consistently allocate memory in fix_filename()
      parse-options: use prefix_filename_except_for_dash() helper
      diff: factor out src/dst prefix setup
      t4013: add tests for diff prefix options
      diff: add --default-prefix option
      format-patch: do not respect diff.noprefix
      format-patch: add format.noprefix option
      add-patch: handle "* Unmerged path" lines
      http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
      http: prefer CURLOPT_SEEKFUNCTION to CURLOPT_IOCTLFUNCTION
      range-diff: drop useless "offset" variable from read_patches()
      http: support CURLOPT_PROTOCOLS_STR
      range-diff: handle unterminated lines in read_patches()
      range-diff: use ssize_t for parsed "len" in read_patches()
      rebase: prefer --default-prefix to --{src,dst}-prefix for format-patch
      mailmap: drop debugging code
      http: drop unused parameter from start_object_request()
      http: mark unused parameter in fill_active_slot() callbacks
      transport: mark unused parameters in fetch_refs_from_bundle()
      git_connect(): fix corner cases in downgrading v2 to v0
      fast-export: drop const when storing anonymized values
      fast-export: simplify initialization of anonymized hashmaps
      fast-export: factor out anonymized_entry creation
      fast-export: de-obfuscate --anonymize-map handling
      fast-export: drop data parameter from anonymous generators
      fast-export: drop unused parameter from anonymize_commit_message()
      Makefile: force -O0 when compiling with SANITIZE=leak
      pack-redundant: escalate deprecation warning to an error
      docs: document caveats of rev-list's object-name output
      fast-import: fix file access when run from subdir
      builtins: always pass prefix to parse_options()
      builtins: annotate always-empty prefix parameters
      builtins: mark unused prefix parameters
      mark "argv" as unused when we check argc
      t/helper: mark unused argv/argc arguments
      parse-options: drop parse_opt_unknown_cb()
      pack-redundant: document deprecation
      tests: run internal chain-linter under "make test"
      tests: replace chainlint subshell with a function
      tests: drop here-doc check from internal chain-linter
      tests: skip test_eval_ in internal chain-lint
      t/lib-httpd: pass PERL_PATH to CGI scripts
      v0 protocol: fix infinite loop when parsing multi-valued capabilities
      t5512: stop referring to "v1" protocol
      v0 protocol: fix sha1/sha256 confusion for capabilities^{}
      t5512: add v2 support for "ls-remote --symref" test
      t5512: allow any protocol version for filtered symref test
      t5512: test "ls-remote --heads --symref" filtering with v0 and v2
      v0 protocol: use size_t for capability length/offset
      gpg-interface: set trust level of missing key to "undefined"
      notes: clean up confusing NULL checks in init_notes()
      fetch_bundle_uri(): drop pointless NULL check
      t4212: avoid putting git on left-hand side of pipe
      parse_commit(): parse timestamp from end of line
      parse_commit(): handle broken whitespace-only timestamp
      parse_commit(): describe more date-parsing failure modes
      doc-diff: drop SOURCE_DATE_EPOCH override
      t7001: avoid git on upstream of pipe
      t7001: use "ls-files --format" instead of "cut"
      t: drop "verbose" helper function
      t/lib-httpd: make CGIPassAuth support conditional

Jiang Xin (5):
      github-actions: run gcc-8 on ubuntu-20.04 image
      ci: remove the pipe after "p4 -V" to catch errors
      ci: use the same version of p4 on both Linux and macOS
      ci: install python on ubuntu
      object-info: init request_info before reading arg

Johannes Schindelin (31):
      compat/win32/syslog: fix use-after-realloc
      nedmalloc: avoid new compile error
      t0033: GETTEXT_POISON fix
      t0003: GETTEXT_POISON fix, part 1
      t0003: GETTEXT_POISON fix, conclusion
      t5619: GETTEXT_POISON fix
      t5604: GETTEXT_POISON fix, part 1
      t5604: GETTEXT_POISON fix, conclusion
      clone.c: avoid "exceeds maximum object size" error with GCC v12.x
      split-index & fsmonitor: demonstrate a bug
      split-index; stop abusing the `base_oid` to strip the "link" extension
      fsmonitor: avoid overriding `cache_changed` bits
      unpack-trees: take care to propagate the split-index flag
      t3701: we don't need no Perl for `add -i` anymore
      t5563: prevent "ambiguous redirect"
      apply --reject: overwrite existing `.rej` symlink if it exists
      gettext: avoid using gettext if the locale dir is not present
      tests: avoid using `test_i18ncmp`
      Git 2.31.8
      Git 2.32.7
      Git 2.33.8
      Git 2.34.8
      Git 2.35.8
      Git 2.36.6
      Git 2.37.7
      Git 2.38.5
      Git 2.39.3
      Git 2.40.1
      gitk: prevent overly long command lines
      rebase --update-refs: fix loops
      rebase -r: fix the total number shown in the progress

John Cai (2):
      name-rev: make --stdin hidden
      attr: teach "--attr-source=<tree>" global option to "git"

John Keeping (1):
      format-patch: output header for empty commits

Josh Soref (1):
      subtree: support long global flags

Jouke Witteveen (1):
      send-email docs: Remove mention of discontinued gmail feature

Junio C Hamano (38):
      gpg-interface: lazily initialize and read the configuration
      bundle: don't blindly apply prefix_filename() to "-"
      Start the 2.41 cycle
      The second batch
      am: refer to format-patch in the documentation
      The third batch
      http.c: clear the 'finished' member once we are done with it
      The fourth batch
      The fifth batch
      The sixth batch
      e-mail workflow: Message-ID is spelled with ID in both capital letters
      The seventh batch
      clone: propagate object-format when cloning from void
      The eighth batch
      The ninth batch
      The tenth batch
      The eleventh batch
      The twelfth batch
      The thirteenth batch
      doc: GIT_DEFAULT_HASH is and will be ignored during "clone"
      The fourteenth batch
      The fifteenth batch
      The sixteenth batch
      diff: refactor common tail part of dirstat computation
      diff: plug leaks in dirstat
      t9800: correct misuse of 'show -s --raw' in a test
      The seventeenth batch
      The eighteenth batch
      Git 2.41-rc0
      tests: do not negate test_path_exists
      t2021: do not negate test_path_is_dir
      test: do not negate test_path_is_* to assert absense
      A bit more before -rc1
      send-email: clear the $message_id after validation
      t9001: mark the script as no longer leak checker clean
      Git 2.41-rc1
      A few more topics after 2.41-rc1
      Git 2.41-rc2

Kristoffer Haugsbakk (5):
      config: tell the user that we expect an ASCII character
      doc: interpret-trailers: don’t use heredoc in examples
      doc: interpret-trailers: use input redirection
      doc: interpret-trailers: don’t use deprecated config
      doc: interpret-trailers: fix example

Linus Arver (1):
      MyFirstContribution: render literal *

M Hickford (3):
      credential/wincred: include wincred.h
      credential/wincred: store password_expiry_utc
      credential: new attribute oauth_refresh_token

Martin Ågren (2):
      gittutorial: drop early mention of origin
      gittutorial: wrap literal examples in backticks

Mathias Krause (1):
      grep: work around UTF-8 related JIT bug in PCRE2 <= 10.34

Matthew John Cheetham (3):
      t5563: add tests for basic and anoymous HTTP access
      http: read HTTP WWW-Authenticate response headers
      credential: add WWW-Authenticate header to cred requests

Maxim Cournoyer (3):
      send-email: extract execute_cmd from recipients_cmd
      send-email: add --header-cmd, --no-header-cmd options
      send-email: detect empty blank lines in command output

Michael J Gruber (1):
      t3070: make chain lint tester happy

Michael Strawbridge (2):
      send-email: refactor header generation functions
      send-email: expose header information to git-send-email's sendemail-validate hook

Mike Hommey (1):
      Handle some compiler versions containing a dash

Nico Rieck (1):
      gitk: escape file paths before piping to git log

Oswald Buddenhagen (5):
      sequencer: remove pointless rollback_lock_file()
      sequencer: rewrite save_head() in terms of write_message()
      sequencer: actually translate report in do_exec()
      messages: capitalization and punctuation exceptions
      t/t3501-revert-cherry-pick.sh: clarify scope of the file

Patrick Steinhardt (27):
      receive-pack: fix stale packfile locks when dying
      fetch: move reference width calculation into `display_state`
      fetch: move output format into `display_state`
      fetch: pass the full local reference name to `format_display`
      fetch: centralize handling of per-reference format
      fetch: centralize logic to print remote URL
      fetch: centralize printing of reference updates
      commit-graph: fix truncated generation numbers
      midx: fix segfault with no packs and invalid preferred pack
      repack: fix trying to use preferred pack in alternates
      repack: fix generating multi-pack-index with only non-local packs
      pack-objects: split out `--stdin-packs` tests into separate file
      pack-objects: fix error when packing same pack twice
      pack-objects: fix error when same packfile is included and excluded
      pack-objects: extend test coverage of `--stdin-packs` with alternates
      t/helper: allow chmtime to print verbosely without modifying mtime
      repack: honor `-l` when calculating pack geometry
      repack: disable writing bitmaps when doing a local repack
      fetch: fix `--no-recurse-submodules` with multi-remote fetches
      fetch: split out tests for output format
      fetch: add a test to exercise invalid output formats
      fetch: print left-hand side when fetching HEAD:foo
      fetch: refactor calculation of the display table width
      fetch: introduce `display_format` enum
      fetch: lift up parsing of "fetch.output" config variable
      fetch: move option related variables into main function
      fetch: introduce machine-parseable "porcelain" output format

Paul Eggert (1):
      git-compat-util: use gettimeofday(2) for time(2)

Phillip Wood (8):
      wildmatch: fix exponential behavior
      wildmatch: avoid undefined behavior
      wildmatch: hide internal return values
      rebase: stop reading and writing unnecessary strategy state
      sequencer: use struct strvec to store merge strategy options
      rebase -m: cleanup --strategy-option handling
      rebase -m: fix serialization of strategy options
      rebase: remove a couple of redundant strategy tests

Raghul Nanth A (1):
      describe: enable sparse index for describe

René Scharfe (6):
      archive: improve support for running in subdirectory
      t5000: use check_mtime()
      userdiff: support regexec(3) with multi-byte support
      date: remove approxidate_relative()
      get-tar-commit-id: use TYPEFLAG_GLOBAL_HEADER instead of magic value
      test-ctype: check EOF

Robin Jarry (1):
      send-email: export patch counters in validate environment

Rubén Justo (10):
      bisect: fix "reset" when branch is checked out elsewhere
      worktree: introduce is_shared_symref()
      branch: fix die_if_checked_out() when ignore_current_worktree
      rebase: refuse to switch to a branch already checked out elsewhere (test)
      switch: reject if the branch is already checked out elsewhere (test)
      branch: test for failures while renaming branches
      branch: use get_worktrees() in copy_or_rename_branch()
      branch: description for orphan branch errors
      branch: rename orphan branches in any worktree
      branch: avoid unnecessary worktrees traversals

SZEDER Gábor (6):
      treewide: include parse-options.h in source files
      treewide: remove unnecessary inclusions of parse-options.h from headers
      parse-options.h: use consistent name for the callback parameters
      parse-options.h: rename _OPT_CONTAINS_OR_WITH()'s parameters
      parse-options.h: use designated initializers in OPT_* macros
      cocci: remove 'unused.cocci'

Shuqi Liang (4):
      write-tree: integrate with sparse index
      t1092: update a write-tree test
      t1092: add tests for `git diff-files`
      diff-files: integrate with sparse index

Siddharth Singh (1):
      hashmap.h: fix minor typo

Sohom Datta (1):
      docs: clarify git rm --cached function in gitignore note

Stanislav Malishevskiy (1):
      http: add support for different sslcert and sslkey types.

Tao Klerks (1):
      mergetool: new config guiDefault supports auto-toggling gui by DISPLAY

Taylor Blau (37):
      commit-graph: introduce `ensure_generations_valid()`
      pack-write.c: plug a leak in stage_tmp_packfiles()
      t5325: mark as leak-free
      pack-revindex: make `load_pack_revindex` take a repository
      pack-revindex: introduce GIT_TEST_REV_INDEX_DIE_ON_DISK
      pack-revindex: introduce `pack.readReverseIndex`
      config: enable `pack.writeReverseIndex` by default
      t: invert `GIT_TEST_WRITE_REV_INDEX`
      t1300: demonstrate failure when renaming sections with long lines
      config: avoid fixed-sized buffer when renaming/deleting a section
      config.c: avoid integer truncation in `copy_or_rename_section_in_file()`
      config.c: disallow overly-long lines in `copy_or_rename_section_in_file()`
      Git 2.30.9
      pack-write.c: plug a leak in stage_tmp_packfiles()
      builtin/repack.c: fix incorrect reference to '-C'
      builtin/gc.c: ignore cruft packs with `--keep-largest-pack`
      t/t5304-prune.sh: prepare for `gc --cruft` by default
      t/t6501-freshen-objects.sh: prepare for `gc --cruft` by default
      t/t6500-gc.sh: refactor cruft pack tests
      t/t6500-gc.sh: add additional test cases
      t/t9300-fast-import.sh: prepare for `gc --cruft` by default
      builtin/gc.c: make `gc.cruftPacks` enabled by default
      repository.h: drop unused `gc_cruft_packs`
      string-list: multi-delimiter `string_list_split_in_place()`
      string-list: introduce `string_list_setlen()`
      t/helper/test-hashmap.c: avoid using `strtok()`
      t/helper/test-oidmap.c: avoid using `strtok()`
      t/helper/test-json-writer.c: avoid using `strtok()`
      banned.h: mark `strtok()` and `strtok_r()` as banned
      credential.c: store "wwwauth[]" values in `credential_read()`
      t/lib-credential.sh: ensure credential helpers handle long headers
      contrib/credential: avoid fixed-size buffer in osxkeychain
      contrib/credential: remove 'gnome-keyring' credential helper
      contrib/credential: .gitignore libsecret build artifacts
      contrib/credential: avoid fixed-size buffer in libsecret
      contrib/credential: embiggen fixed-size buffer in wincred
      run-command.c: fix missing include under `NO_PTHREADS`

Teng Long (1):
      push: introduce '--branches' option

William Sprent (2):
      builtin/sparse-checkout: remove NEED_WORK_TREE flag
      builtin/sparse-checkout: add check-rules command

ZheNing Hu (2):
      receive-pack: fix funny ref error messsage
      push: allow delete single-level ref

brian m. carlson (1):
      upload-pack: advertise capabilities when cloning empty repos

Ævar Arnfjörð Bjarmason (33):
      auto-crlf tests: don't lose exit code in loops and outside tests
      t/lib-patch-mode.sh: fix ignored exit codes
      tests: don't lose exit status with "(cd ...; test <op> $(git ...))"
      tests: don't lose "git" exit codes in "! ( git ... | grep )"
      tests: don't lose exit status with "test <op> $(git ...)"
      tests: don't lose misc "git" exit codes
      sequencer.c: fix overflow & segfault in parse_strategy_opts()
      cocci: remove dead rule from "the_repository.pending.cocci"
      cocci: fix incorrect & verbose "the_repository" rules
      cocci: sort "the_repository" rules by header
      cocci: add missing "the_repository" macros to "pending"
      cocci: apply the "cache.h" part of "the_repository.pending"
      cocci: apply the "commit-reach.h" part of "the_repository.pending"
      cocci: apply the "commit.h" part of "the_repository.pending"
      cocci: apply the "diff.h" part of "the_repository.pending"
      cocci: apply the "object-store.h" part of "the_repository.pending"
      cocci: apply the "pretty.h" part of "the_repository.pending"
      cocci: apply the "packfile.h" part of "the_repository.pending"
      cocci: apply the "promisor-remote.h" part of "the_repository.pending"
      cocci: apply the "refs.h" part of "the_repository.pending"
      cocci: apply the "rerere.h" part of "the_repository.pending"
      cocci: apply the "revision.h" part of "the_repository.pending"
      post-cocci: adjust comments for recent repo_* migration
      libs: use "struct repository *" argument, not "the_repository"
      config tests: cover blind spots in git_die_config() tests
      config tests: add "NULL" tests for *_get_value_multi()
      config API: add and use a "git_config_get()" family of functions
      versioncmp.c: refactor config reading next commit
      config API: have *_multi() return an "int" and take a "dest"
      for-each-repo: error on bad --config
      config API users: test for *_get_value_multi() segfaults
      config API: add "string" version of *_value_multi(), fix segfaults
      for-each-repo: with bad config, don't conflate <path> and <cmd>

Øystein Walle (2):
      ref-filter: remove unused ref_format member
      branch, for-each-ref, tag: add option to omit empty lines


