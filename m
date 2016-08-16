Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE0C1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 15:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbcHPPNq (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 11:13:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:52153 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbcHPPNp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 11:13:45 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LviG8-1b8M4O1kQ0-017XYY; Tue, 16 Aug 2016 17:13:40
 +0200
Date:	Tue, 16 Aug 2016 17:13:25 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] t/Makefile: ensure that paths are valid on platforms we
 care
In-Reply-To: <5a23270d14386fa9fb8e75ab328337fef579d06f.1471337271.git.johannes.schindelin@gmx.de>
Message-ID: <b7691bb3c9c0b46dbea7b29638120e9288cfb9b8.1471360183.git.johannes.schindelin@gmx.de>
References: <5a23270d14386fa9fb8e75ab328337fef579d06f.1471337271.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7AiHTudvvDIixMHJwGoG0XbGLzvv7pSqDYXyFKUe8T54m3kFvJR
 D8FNxQUEhHVSQAC0yKsNrLo0ttxvA7qM29czbq6T68jVkT7kp4d6Uytb9nOfm4c1F83/pSi
 cBvdC9zfNHS9+sZWqOMBB1mFFMpyLyT4isODsxCPV+if038hrVYy29mjyl1HrxcLjOYfvUM
 ggKeX/Vwrfow2e2pubHuQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:zAA/8LSPSbo=:iebBtf9ka5PPOTuBg5iE5N
 zhUuaZ9UEalO8hXLYT3/djqFk4V+uIzexAJ0MEgzo4AnZvu6sQNtkQTOEf667WYQfnHKvARzQ
 aL/HKyoa/OZ4c1M1j0APCN5QDivfxDluOCQylQFH2eKMgyu3aHCeDgodAte4oEyD6CA9EWKmi
 +/YoRFrTFQHsR9tpkRHTx6d3EZPGS4BZAZ+z1TwGm39y4RvbSHfS3c6NpvRhEBiGuV/IAupD8
 wnio4vIbeOcfLaenWd2pL9aj38H/MQBIqlDEV4dxZ7oL36RHw69+8uSqnV2aCgtIKLbfrFaFB
 gmrWKr4HkzCxjutIVGJO3n4sh+c+jMhW6oMSO9CJHuJstekP2zV1qvQK2P0ZaOADs3bIr3UPK
 LvLBleySDjQhxWtf9dgtDsBaUP2rlBLiUnzwZaT5WsHZt0RpHRnEZKB1bLoe3/EOQ6RJL3bGj
 tK+sNIM00bf4nIDoZGBO+wdFZyaac8lguwHvFF/7g8fg4a4FypGwxZjrT5HzrtGEg/NlznJYV
 l7/+DHevyJMnnLrdN2AADJBRNA7S9lnTkwK8OuUn77e9YKJst6rLxIYngbksKKZvsK9tLcqxR
 3SyJ5kpwieZ5PmlB0SRP+ZtQvXxFhokDOYDfjjPRWf0lXPSJStyxlVDSRlR2nhbDv10KMJRgT
 ICbuvVw2P/anu8t48yItCziZRQMBJu2xak9fArSKnJHesbVPtR+s4X7rfjcTU5zF+Hj5XYhSA
 reFgmZhU0ZeM+8wsDl9suITnOucQR+f8/8BfG2xuuLVUovJBmvkd6GiYCeSnrjZU+54/Tm+us
 K3HWJ1w
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Some pathnames that are okay on ext4 and on HFS+ cannot be checked
out on Windows. Tests that want to see operations on such paths on
filesystems that support them must do so behind appropriate test
prerequisites, and must not include them in the source tree (instead
they should create them when they run). Otherwise, the source tree
cannot even be checked out.

Make sure that double-quotes, asterisk, colon, greater/less-than,
question-mark, backslash, tab, vertical-bar, as well as any non-ASCII
characters never appear in the pathnames with a new test-lint-* target
as part of a `make test`. To that end, we call `git ls-files` (ensuring
that the paths are quoted properly), relying on the fact that paths
containing non-ASCII characters are quoted within double-quotes.

In case that the source code does not actually live in a Git
repository (e.g. when extracted from a .zip file), or that the `git`
executable cannot be executed, we simply ignore the error for now; In
that case, our trusty Continuous Integration will be the last line of
defense and catch any problematic file name.

Noticed when a topic wanted to add a pathname with '>' in it.  A
check like this will prevent a similar problems from happening in the
future.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Again some touch-ups to the commit message.

	Please note that the paths are now quoted within double-quotes,
	thanks to the core.quotepaths setting. As such, non-ASCII
	characters are no longer caught through the backslash, but through
	the double-quote character (i.e. '"').

	As previously, tested on Linux and Windows and verified that it
	does the job.

Published-As: https://github.com/dscho/git/releases/tag/test-lint-filenames-v3
Fetch-It-Via: git fetch https://github.com/dscho/git test-lint-filenames-v3
Interdiff vs v2:

 diff --git a/t/Makefile b/t/Makefile
 index bf9cad9..d613935 100644
 --- a/t/Makefile
 +++ b/t/Makefile
 @@ -69,9 +69,12 @@ test-lint-shell-syntax:
  	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)
  
  test-lint-filenames:
 -	@illegal="$$(git ls-files | grep '[	"*:<>?\\|]')"; \
 -		test -z "$$illegal" || { \
 -		echo >&2 "illegal file name(s): " $$illegal; exit 1; }
 +	@# We do *not* pass a glob to ls-files but use grep instead, to catch
 +	@# non-ASCII characters (which are quoted within double-quotes)
 +	@bad="$$(git -c core.quotepath=true ls-files 2>/dev/null | \
 +			grep '["*:<>?\\|]')"; \
 +		test -z "$$bad" || { \
 +		echo >&2 "non-portable file name(s): $$bad"; exit 1; }
  
  aggregate-results-and-cleanup: $(T)
  	$(MAKE) aggregate-results


 t/Makefile | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 18e2b28..d613935 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -52,7 +52,8 @@ clean-except-prove-cache:
 clean: clean-except-prove-cache
 	$(RM) .prove
 
-test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
+test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
+	test-lint-filenames
 
 test-lint-duplicates:
 	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
@@ -67,6 +68,14 @@ test-lint-executable:
 test-lint-shell-syntax:
 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)
 
+test-lint-filenames:
+	@# We do *not* pass a glob to ls-files but use grep instead, to catch
+	@# non-ASCII characters (which are quoted within double-quotes)
+	@bad="$$(git -c core.quotepath=true ls-files 2>/dev/null | \
+			grep '["*:<>?\\|]')"; \
+		test -z "$$bad" || { \
+		echo >&2 "non-portable file name(s): $$bad"; exit 1; }
+
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
 	$(MAKE) clean
-- 
2.9.2.691.g78954f3

base-commit: 70dce4aee55ad8a39a53f86f37a4bd400e0cac7d
