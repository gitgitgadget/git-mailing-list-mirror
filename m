Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1CFC38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiJZOVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiJZOVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:21:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48540110B19
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a13so41807208edj.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZWT4eQUnl7JvWQZvtW4Ga3nHUMHXrWigOVHcklDcTg=;
        b=GUd4gXLhLTq/Q+Hxpg+y5Kd/D1dJmlCjcxZrsqgPnwC+mxFICzM0Q4+RlOOKlFd7DG
         vkZSFM+NylbaddangJwxqJqUzKMcp02JaBTSimgnWdaM7q95zTVGWD2PinlWOYEUm6Il
         NDfhI1GWqXR7gY+yiHtcQGKjt+IeG4PmBtG4y/8WqRDxd2Qu7QwEA+SaQFvuTv2z1xi/
         CHHBp16fH8oO6cQHzP3qyEfGC2T7Su/pQAj00kNwvpTljXuKByOWis2PNWaVjhS3TVQA
         l6YvKX7UIOwtnqOIyVZ1dTReThtBjiriVlkc4uYxkG5/65+coHsQT0GfpPv7kUnQN9vH
         ANNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZWT4eQUnl7JvWQZvtW4Ga3nHUMHXrWigOVHcklDcTg=;
        b=7oyQGxVtSQG00u3KQ2JDO/nuykEqGQ7jIwetVVXGyMuTKj4pAC9uTaNr76cIOd2Ky2
         gdfaP7E1QgsSamhJkJe3kQfpGlXMPibNHuoy48fLSZQVcw5l05p9EIKsCW5HSsFQ2kSW
         QU8naIMIeFfTetFB7NGL1OOWwyz9OX4d2aPnSwD7IX6e01nFZd626CNya8RuaYqcEnlu
         EDUgJuCZnjkVheFVif5j8l8ngUtJMerQBjp02RxhDm13ji8rrr2UGMduVGl/NiVxAM4t
         7br+AD3X307RHf7oRG7ILZBCeEFlbCN/xwuFQjTVGSVCE0l3/koVWX8QdKQ53LE2jali
         Ontw==
X-Gm-Message-State: ACrzQf2T/bBg899p7McO6D5NVqat/k8RrpCrfCVRfAc0amUnldn3mf+w
        cPu+PsyU6OFLctD6bcykAEbNcH58IZnMcA==
X-Google-Smtp-Source: AMsMyM6nkbmniz+4NrUP5cK+PtQJEOryjsoAntmIU0cRfEaoBj7c0xgtzChzR5hzOWnkuoIjoMDW+g==
X-Received: by 2002:aa7:d357:0:b0:45b:dab5:9789 with SMTP id m23-20020aa7d357000000b0045bdab59789mr42228732edr.222.1666794063368;
        Wed, 26 Oct 2022 07:21:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:21:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/12] cocci: make "coccicheck" rule incremental
Date:   Wed, 26 Oct 2022 16:20:35 +0200
Message-Id: <patch-v4-08.12-340ce523436-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Optimize the very slow "coccicheck" target to take advantage of
incremental rebuilding, and fix outstanding dependency problems with
the existing rule.

The rule is now faster both on the initial run as we can make better
use of GNU make's parallelism than the old ad-hoc combination of
make's parallelism combined with $(SPATCH_BATCH_SIZE) and/or the
"--jobs" argument to "spatch(1)".

It also makes us *much* faster when incrementally building, it's now
viable to "make coccicheck" as topic branches are merged down.

The rule didn't use FORCE (or its equivalents) before, so a:

	make coccicheck
	make coccicheck

Would report nothing to do on the second iteration. But all of our
patch output depended on all $(COCCI_SOURCES) files, therefore e.g.:

    make -W grep.c coccicheck

Would do a full re-run, i.e. a a change in a single file would force
us to do a full re-run.

The reason for this (not the initial rationale, but my analysis) is:

* Since we create a single "*.cocci.patch+" we don't know where to
  pick up where we left off, or how to incrementally merge e.g. a
  "grep.c" change with an existing *.cocci.patch.

* We've been carrying forward the dependency on the *.c files since
  63f0a758a06 (add coccicheck make target, 2016-09-15) the rule was
  initially added as a sort of poor man's dependency discovery.

  As we don't include other *.c files depending on other *.c files
  has always been broken, as could be trivially demonstrated
  e.g. with:

       make coccicheck
       make -W strbuf.h coccicheck

  However, depending on the corresponding *.c files has been doing
  something, namely that *if* an API change modified both *.c and *.h
  files we'd catch the change to the *.h we care about via the *.c
  being changed.

  For API changes that happened only via *.h files we'd do the wrong
  thing before this change, but e.g. for function additions (not
  "static inline" ones) catch the *.h change by proxy.

Now we'll instead:

 * Create a <RULE>/<FILE> pair in the .build directory, E.g. for
   swap.cocci and grep.c we'll create
   .build/contrib/coccinelle/swap.cocci.patch/grep.c.

   That file is the diff we'll apply for that <RULE>-<FILE>
   combination, if there's no changes to me made (the common case)
   it'll be an empty file.

 * Our generated *.patch
   file (e.g. contrib/coccinelle/swap.cocci.patch) is now a simple "cat
   $^" of all of all of the <RULE>/<FILE> files for a given <RULE>.

   In the case discussed above of "grep.c" being changed we'll do the
   full "cat" every time, so they resulting *.cocci.patch will always
   be correct and up-to-date, even if it's "incrementally updated".

   See 1cc0425a27c (Makefile: have "make pot" not "reset --hard",
   2022-05-26) for another recent rule that used that technique.

As before we'll:

 * End up generating a contrib/coccinelle/swap.cocci.patch, if we
   "fail" by creating a non-empty patch we'll still exit with a zero
   exit code.

   Arguably we should move to a more Makefile-native way of doing
   this, i.e. fail early, and if we want all of the "failed" changes
   we can use "make -k", but as the current
   "ci/run-static-analysis.sh" expects us to behave this way let's
   keep the existing behavior of exhaustively discovering all cocci
   changes, and only failing if spatch itself errors out.

Further implementation details & notes:

 * Before this change running "make coccicheck" would by default end
   up pegging just one CPU at the very end for a while, usually as
   we'd finish whichever *.cocci rule was the most expensive.

   This could be mitigated by combining "make -jN" with
   SPATCH_BATCH_SIZE, see 960154b9c17 (coccicheck: optionally batch
   spatch invocations, 2019-05-06).

   There will be cases where getting rid of "SPATCH_BATCH_SIZE" makes
   things worse, but a from-scratch "make coccicheck" with the default
   of SPATCH_BATCH_SIZE=1 (and tweaking it doesn't make a difference)
   is faster (~3m36s v.s. ~3m56s) with this approach, as we can feed
   the CPU more work in a less staggered way.

 * Getting rid of "SPATCH_BATCH_SIZE" particularly helps in cases
   where the default of 1 yields parallelism under "make coccicheck",
   but then running e.g.:

       make -W contrib/coccinelle/swap.cocci coccicheck

   I.e. before that would use only one CPU core, until the user
   remembered to adjust "SPATCH_BATCH_SIZE" differently than the
   setting that makes sense when doing a non-incremental run of "make
   coccicheck".

 * Before the "make coccicheck" rule would have to clean
   "contrib/coccinelle/*.cocci.patch*", since we'd create "*+" and
   "*.log" files there. Now those are created in
   .build/contrib/coccinelle/, which is covered by the "cocciclean" rule
   already.

Outstanding issues & future work:

 * We could get rid of "--all-includes" in favor of manually
   specifying a list of includes to give to "spatch(1)".

   As noted upthread of [1] a naïve removal of "--all-includes" will
   result in broken *.cocci patches, but if we know the exhaustive
   list of includes via COMPUTE_HEADER_DEPENDENCIES we don't need to
   re-scan for them, we could grab the headers to include from the
   .depend.d/<file>.o.d and supply them with the "--include" option to
   spatch(1).q

1. https://lore.kernel.org/git/87ft18tcog.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 84 +++++++++++++++++++++++++++++++++++++-----------------
 shared.mak |  5 +++-
 2 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index b153a9db0ac..7cdbd050339 100644
--- a/Makefile
+++ b/Makefile
@@ -1303,10 +1303,6 @@ SANITIZE_ADDRESS =
 SPATCH_INCLUDE_FLAGS = --all-includes
 SPATCH_FLAGS =
 SPATCH_TEST_FLAGS =
-# Setting SPATCH_BATCH_SIZE higher will
-# usually result in less CPU usage at the cost of higher peak memory.
-# Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_BATCH_SIZE = 1
 
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
@@ -1314,7 +1310,6 @@ TRACK_SPATCH_DEFINES += $(SPATCH)
 TRACK_SPATCH_DEFINES += $(SPATCH_INCLUDE_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
-TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
 GIT-SPATCH-DEFINES: FORCE
 	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-SPATCH-DEFINES 2>/dev/null`" ; then \
@@ -3159,39 +3154,75 @@ check: $(GENERATED_H)
 
 COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
 COCCI_RULES = $(COCCI_GLOB)
+COCCI_NAMES = $(COCCI_RULES:contrib/coccinelle/%.cocci=%)
 
 COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
+COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
 COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
+COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
+
+# It's expensive to compute the many=many rules below, only eval them
+# on $(MAKECMDGOALS) that match these $(COCCI_RULES)
+COCCI_RULES_GLOB =
+COCCI_RULES_GLOB += cocci%
+COCCI_RULES_GLOB += .build/contrib/coccinelle/%
+COCCI_RULES_GLOB += $(COCCICHECK_PATCHES)
+COCCI_RULES_GLOB += $(COCCICHEC_PATCHES_PENDING)
+COCCI_GOALS = $(filter $(COCCI_RULES_GLOB),$(MAKECMDGOALS))
 
 COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
 COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
 
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
-COCCI_PATCHES = $(COCCI_RULES:%=%.patch)
-$(COCCI_PATCHES): GIT-SPATCH-DEFINES
-$(COCCI_PATCHES): $(COCCI_SOURCES)
-$(COCCI_PATCHES): %.patch: %
-	$(QUIET_SPATCH) \
-	if test $(SPATCH_BATCH_SIZE) = 0; then \
-		limit=; \
-	else \
-		limit='-n $(SPATCH_BATCH_SIZE)'; \
-	fi; \
-	if ! echo $(COCCI_SOURCES) | xargs $$limit \
-		$(SPATCH) $(SPATCH_FLAGS) \
-		$(SPATCH_INCLUDE_FLAGS) \
-		--sp-file $< --patch . \
-		>$@+ 2>$@.log; \
+.build/contrib/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN) >$@
+
+define cocci-rule
+
+## Rule for .build/$(1).patch/$(2); Params:
+# $(1) = e.g. "free.cocci"
+# $(2) = e.g. "grep.c"
+COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
+.build/$(1).patch/$(2): GIT-SPATCH-DEFINES
+.build/$(1).patch/$(2): .build/contrib/coccinelle/FOUND_H_SOURCES
+.build/$(1).patch/$(2): $(1)
+.build/$(1).patch/$(2): .build/$(1).patch/% : %
+	$$(call mkdir_p_parent_template)
+	$$(QUIET_SPATCH)if ! $$(SPATCH) $$(SPATCH_FLAGS) \
+		$$(SPATCH_INCLUDE_FLAGS) \
+		--sp-file $(1) --patch . $$< \
+		>$$@ 2>$$@.log; \
 	then \
-		cat $@.log; \
+		echo "ERROR when applying '$(1)' to '$$<'; '$$@.log' follows:"; \
+		cat $$@.log; \
 		exit 1; \
-	fi; \
-	mv $@+ $@; \
-	if test -s $@; \
+	fi
+endef
+
+define cocci-matrix
+
+$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(1),$(s)))
+endef
+
+ifdef COCCI_GOALS
+$(eval $(foreach c,$(COCCI_RULES),$(call cocci-matrix,$(c))))
+endif
+
+define spatch-rule
+
+contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
+	$(QUIET_SPATCH_CAT_TMPL)cat $$^ >$$@ && \
+	if test -s $$@; \
 	then \
-		echo '    ' SPATCH result: $@; \
+		echo '    ' SPATCH result: $$@; \
 	fi
+endef
+
+ifdef COCCI_GOALS
+$(eval $(foreach n,$(COCCI_NAMES),$(call spatch-rule,$(n))))
+endif
 
 COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
 $(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
@@ -3483,7 +3514,8 @@ profile-clean:
 cocciclean:
 	$(RM) GIT-SPATCH-DEFINES
 	$(RM) -r .build/contrib/coccinelle
-	$(RM) contrib/coccinelle/*.cocci.patch*
+	$(RM) $(COCCICHECK_PATCHES)
+	$(RM) $(COCCICHECK_PATCHES_PENDING)
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
diff --git a/shared.mak b/shared.mak
index 96b06acc455..5ccd6889fcb 100644
--- a/shared.mak
+++ b/shared.mak
@@ -71,9 +71,12 @@ ifndef V
 	QUIET_RC       = @echo '   ' RC $@;
 
 ## Used in "Makefile": SPATCH
-	QUIET_SPATCH			= @echo '   ' SPATCH $<;
+	QUIET_SPATCH			= @echo '   ' SPATCH $@;
 	QUIET_SPATCH_TEST		= @echo '   ' SPATCH TEST $(@:.build/%=%);
 
+## Used in "Makefile": SPATCH_*TMPL (quoted for use in "define"'s)
+	QUIET_SPATCH_CAT_TMPL		= @echo '   ' SPATCH CAT $$$$^ \>$$@;
+
 ## Used in "Documentation/Makefile"
 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
 	QUIET_XMLTO	= @echo '   ' XMLTO $@;
-- 
2.38.0.1251.g3eefdfb5e7a

