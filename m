Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8CBF1FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 08:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbcHPIuR (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 04:50:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:49187 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753307AbcHPIuP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 04:50:15 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LwrS8-1b6nlX1pPc-016Pbj; Tue, 16 Aug 2016 10:50:07
 +0200
Date:	Tue, 16 Aug 2016 10:50:05 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] t/Makefile: make sure that paths can be checked out on
 platforms we care
In-Reply-To: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
Message-ID: <5a23270d14386fa9fb8e75ab328337fef579d06f.1471337271.git.johannes.schindelin@gmx.de>
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GWiG6YY+PrkcoPmXqZqHZqYMp+Y9S+3X1bXyzoL2DTIaH+dhZbL
 6E4vo0UavLflmmUqMPR2yEB5OyW8fkcLyA/6GrgaNLdORxcMF1L1stLZaGEzaevCUs8ioQI
 IkZJ+LCzvRx1YooiTKFPhzCBqW5jK5dlEEkepFlppIVJYl4ggNPKB95XWCdlZyU3EwylUPT
 9uHj+En3HwAh3ggJPLb8A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:MJlHDr8NvLQ=:IrUJOjgmABVLhxjaKLe18/
 d3GZ7zjSjnbQzKCfw/zYOFYdoTRJ12yWLfcfX6tqtsy4gn1Nq2p+HdRF1x2bhiKrGR7brBq3T
 /JP0+vYX4E9P5s2JHr0IgA141n5X8wqNOVPC9JXbeicrpJdt8FYYRXuW/fTtns/7dbPo8GZvL
 iljGzE1P/MjXdnYEc3Xqp8m0DL1RA1gDwCAvjXsKDusgCE5YXJO2xsuYI/1qFHyU09v69LzAC
 9RbLHIpYyBs3/X9S5z+y9bST5vsSe2zJ1oXBJKo4ateZO8w2HpLhVwAjUErwSXkx21ULW7H1D
 CrqdKfCdYNj8oK8mBs+s25ZFB+S7+scIj1U1cEfFIN1HpM3CSdtuujGeyU+a5GkvTnaZuK9BJ
 BF9OOnCCxVbAQ355PDZkqBxKy2svkET74v+7UXM7GsszGDDMkDQn8xsOo+dZoITayX2a6twnt
 GNCiELedlcmH4Df6mYi6YILQzdcgXqLI6xhme/Q99bxjHCmrZXr+Leo00NYeRwBBYR3sGtvfn
 WcEoFItPIb7HjhAdqcXbn2N8vjFPwpwgNbdlkDLvEJHRqYmXc7OWX1dxNkAOd0YvUhBwYVk1G
 wqMPnUzsg0rCqIY+EdmaU61qRxFIXnhPgcvpxOsQ9pwJegB3XQnucQrbdzIubMBDaz3s6aWs2
 BdAId8w0iP3qjRpY7CTHeFQ5yX7Nyyi2ardVtNA+L1fvITSXsDqBUDyS927chFIEvJFMopV/S
 goKSJ0jrg4Zgg25oIMI3DSrxwu24tO+cqoZyuvuh2Kqcgb4WmqmOrZy+2P2xl3qATFAgh5AR1
 4C6OQ98
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
characters above 0x7f never appear in the pathnames with a new
test-lint-* target as part of a `make test`.

Noticed when a topic wanted to add a pathname with '>' in it.  A
check like this will prevent a similar problems from happening in the
future.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I re-munged the commit message (I saw that you munged it in `pu`
	and did not quite like the wording, so I permitted myself the
	indulgence).

	And of course I tested this, and it does *not* list all files in
	subdirectories of t/ as problematic.

Published-As: https://github.com/dscho/git/releases/tag/test-lint-filenames-v2
Fetch-It-Via: git fetch https://github.com/dscho/git test-lint-filenames-v2
Interdiff vs v1:

 diff --git a/t/Makefile b/t/Makefile
 index 3c0eb48..bf9cad9 100644
 --- a/t/Makefile
 +++ b/t/Makefile
 @@ -69,7 +69,7 @@ test-lint-shell-syntax:
  	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)
  
  test-lint-filenames:
 -	@illegal="$$(git ls-files | grep '["*:<>?\\|]')"; \
 +	@illegal="$$(git ls-files | grep '[	"*:<>?\\|]')"; \
  		test -z "$$illegal" || { \
  		echo >&2 "illegal file name(s): " $$illegal; exit 1; }
  


 t/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 18e2b28..bf9cad9 100644
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
@@ -67,6 +68,11 @@ test-lint-executable:
 test-lint-shell-syntax:
 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS)
 
+test-lint-filenames:
+	@illegal="$$(git ls-files | grep '[	"*:<>?\\|]')"; \
+		test -z "$$illegal" || { \
+		echo >&2 "illegal file name(s): " $$illegal; exit 1; }
+
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
 	$(MAKE) clean
-- 
2.9.2.691.g78954f3

base-commit: 70dce4aee55ad8a39a53f86f37a4bd400e0cac7d
