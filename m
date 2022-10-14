Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A110C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiJNPdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJNPcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:32:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3BEAC9F
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bp11so8117509wrb.9
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyHp44ea796Bm+h62F+npYKatJbISFsFdh6TPLTwNLo=;
        b=Z7olGB/t+iqhxhFLjtnXQsp+DVGdsNtrbA/uWiGeIYImXqrI6p9zanSjY/H2LB1bur
         s20FYBpx8vlCoct9IA5oEax3HK4AO6UUcE8x66ORPGMJAMfm6u3fBNPdExBe126ZtO/s
         BsRiKMl8MpEln+Fmt2x/iV5d2ZDp3Ja3vgZ+ECJL9b4RgnjlbQVaNfwtHQEsNFkP09P3
         opGVv4nKGGu0baVK6koopDcCj2pe5a5G+IStgzO1NiIFrI3YjXydjmjDY67Mr9tDE0ov
         nLprLHqOj5jnNfon2Y5JiRXiUCT9+z40okVuFXF5U5YG6vDbUz9Lp4S3owVvDhY++FPu
         bvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyHp44ea796Bm+h62F+npYKatJbISFsFdh6TPLTwNLo=;
        b=zpw2nqkpXiIbrpg/65DNFV6cIwlchQQX9TGlXj1KHxwX3t2+egMWbixV08SJQFUtZC
         lyxg8xjz684dSBFxqgJVli2AnsJeiwwG3FFa3l26QuSEZXUJ5fX1O9MdMaw8Mp/JX2zU
         +fbbOAnimDNeyWgBDc5OoqENJgOo5+AzQykdOq8jp0r2d/ibPndFX0NrOFxknKMnBReh
         2WnuzJA6UBwNoXdzNx4mkZA26JYag5ANePrKY/VRlV8tmxZG6kxrxIA1QE3l8rcrpWy6
         7BTfssD8t+OhCGJTfhGhgCal/ATU/KdqSf/82WegdK/gc6DVDCXPAsveDum89x5EP7x9
         QaHw==
X-Gm-Message-State: ACrzQf0y1CdwNxub7Uy4/Ul87FLrUIX7q7dy3i079EyU0m4b9zuZkUJZ
        wDqY8N+k59LB/Yn2nkHxH+vbJPRqtTCxZw==
X-Google-Smtp-Source: AMsMyM5FoeL18dDljsXRN1ksuPwkyVur9Zx+uk3pvyXGHBM6XwRsok5Oe5aUM3gmvB4XgONAJX9PcA==
X-Received: by 2002:adf:e4d1:0:b0:232:eb2:68bc with SMTP id v17-20020adfe4d1000000b002320eb268bcmr3716554wrm.231.1665761506084;
        Fri, 14 Oct 2022 08:31:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/11] cocci: run against a generated ALL.cocci
Date:   Fri, 14 Oct 2022 17:31:26 +0200
Message-Id: <patch-v3-10.11-52177ea2a68-20221014T152553Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com> <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The preceding commits to make the "coccicheck" target incremental made
it slower in some cases. As an optimization let's not have the
many=many mapping of <*.cocci>=<*.[ch]>, but instead concat the
<*.cocci> into an ALL.cocci, and then run one-to-many
ALL.cocci=<*.[ch]>.

A "make coccicheck" is now around 2x as fast as it was on "master",
and around 1.5x as fast as the preceding change to make the run
incremental:

	$ git hyperfine -L rev origin/master,HEAD~,HEAD -p 'make clean' 'make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' -r 3
	Benchmark 1: make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'origin/master
	  Time (mean ± σ):      4.258 s ±  0.015 s    [User: 27.432 s, System: 1.532 s]
	  Range (min … max):    4.241 s …  4.268 s    3 runs

	Benchmark 2: make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'HEAD~
	  Time (mean ± σ):      5.365 s ±  0.079 s    [User: 36.899 s, System: 1.810 s]
	  Range (min … max):    5.281 s …  5.436 s    3 runs

	Benchmark 3: make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'HEAD
	  Time (mean ± σ):      2.725 s ±  0.063 s    [User: 14.796 s, System: 0.233 s]
	  Range (min … max):    2.667 s …  2.792 s    3 runs

	Summary
	  'make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'HEAD' ran
	    1.56 ± 0.04 times faster than 'make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'origin/master'
	    1.97 ± 0.05 times faster than 'make coccicheck SPATCH=spatch COCCI_SOURCES="$(echo $(ls o*.c builtin/h*.c))"' in 'HEAD~'

This can be turned off with SPATCH_CONCAT_COCCI, but as the
beneficiaries of "SPATCH_CONCAT_COCCI=" would mainly be those
developing the *.cocci rules themselves, let's leave this optimization
on by default.

For more information see my "Optimizing *.cocci rules by concat'ing
them" (<220901.8635dbjfko.gmgdl@evledraar.gmail.com>) on the
cocci@inria.fr mailing list.

This potentially changes the results of our *.cocci rules, but as
noted in that discussion it should be safe for our use. We don't name
rules, or if we do their names don't conflict across our *.cocci
files.

To the extent that we'd have any inter-dependencies between rules this
doesn't make that worse, as we'd have them now if we ran "make
coccicheck", applied the results, and would then have (due to
hypothetical interdependencies) suggested changes on the subsequent
"make coccicheck".

Our "coccicheck-test" target makes use of the ALL.cocci when running
tests, e.g. when testing unused.{c,out} we test it against ALL.cocci,
not unused.cocci. We thus assert (to the extent that we have test
coverage) that this concatenation doesn't change the expected results
of running these rules.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                      | 40 ++++++++++++++++++++++++++++++++---
 contrib/coccinelle/.gitignore |  1 +
 shared.mak                    |  1 +
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index bd3b5c21d6f..0dc25a2c7ad 100644
--- a/Makefile
+++ b/Makefile
@@ -1310,6 +1310,25 @@ SPATCH_TEST_FLAGS =
 # COMPUTE_HEADER_DEPENDENCIES=no this will be unset too.
 SPATCH_USE_O_DEPENDENCIES = YesPlease
 
+# Set SPATCH_CONCAT_COCCI to concatenate the contrib/cocci/*.cocci
+# files into a single contrib/cocci/ALL.cocci before running
+# "coccicheck".
+#
+# Pros:
+#
+# - Speeds up a one-shot run of "make coccicheck", as we won't have to
+#   parse *.[ch] files N times for the N *.cocci rules
+#
+# Cons:
+#
+# - Will make incremental development of *.cocci slower, as
+#   e.g. changing strbuf.cocci will re-run all *.cocci.
+#
+# - Makes error and performance analysis harder, as rules will be
+#   applied from a monolithic ALL.cocci, rather than
+#   e.g. strbuf.cocci.
+SPATCH_CONCAT_COCCI = YesPlease
+
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
@@ -3155,9 +3174,10 @@ check: $(GENERATED_H)
 		exit 1; \
 	fi
 
+COCCI_GEN_ALL = contrib/coccinelle/ALL.cocci
 COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
-COCCI_RULES = $(COCCI_GLOB)
-COCCI_NAMES = $(COCCI_RULES:contrib/coccinelle/%.cocci=%)
+COCCI_NAMES = $(sort ALL $(COCCI_GLOB:contrib/coccinelle/%.cocci=%))
+COCCI_RULES = $(filter-out $(COCCI_GEN_ALL),$(COCCI_GLOB))
 
 COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
 COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
@@ -3171,6 +3191,7 @@ COCCI_RULES_GLOB += cocci%
 COCCI_RULES_GLOB += .build/contrib/coccinelle/%
 COCCI_RULES_GLOB += $(COCCICHECK_PATCHES)
 COCCI_RULES_GLOB += $(COCCICHEC_PATCHES_PENDING)
+COCCI_RULES_GLOB += $(COCCI_GEN_ALL)
 COCCI_GOALS = $(filter $(COCCI_RULES_GLOB),$(MAKECMDGOALS))
 
 COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
@@ -3182,6 +3203,10 @@ COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN) >$@
 
+$(COCCI_GEN_ALL): $(COCCICHECK)
+	$(call mkdir_p_parent_template)
+	$(QUIET_SPATCH_CAT)cat $^ >$@
+
 ifeq ($(COMPUTE_HEADER_DEPENDENCIES),no)
 SPATCH_USE_O_DEPENDENCIES =
 endif
@@ -3214,7 +3239,7 @@ $(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s),$(s:%.c=%.o)))
 endef
 
 ifdef COCCI_GOALS
-$(eval $(foreach c,$(COCCI_RULES),$(call cocci-matrix,$(c))))
+$(eval $(foreach c,$(COCCI_RULES) $(COCCI_GEN_ALL),$(call cocci-matrix,$(c))))
 endif
 
 define spatch-rule
@@ -3235,7 +3260,11 @@ COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
 $(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
 $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
+ifdef SPATCH_CONCAT_COCCI
+$(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : $(COCCI_GEN_ALL)
+else
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
+endif
 	$(call mkdir_p_parent_template)
 	$(QUIET_SPATCH_TEST)$(SPATCH) $(SPATCH_TEST_FLAGS) \
 		--very-quiet --no-show-diff \
@@ -3248,7 +3277,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
 coccicheck-test: $(COCCI_TEST_RES_GEN)
 
 coccicheck: coccicheck-test
+ifdef SPATCH_CONCAT_COCCI
+coccicheck: contrib/coccinelle/ALL.cocci.patch
+else
 coccicheck: $(COCCICHECK_PATCHES)
+endif
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test
@@ -3523,6 +3556,7 @@ cocciclean:
 	$(RM) -r .build/contrib/coccinelle
 	$(RM) $(COCCICHECK_PATCHES)
 	$(RM) $(COCCICHECK_PATCHES_PENDING)
+	$(RM) $(COCCI_GEN_ALL)
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
diff --git a/contrib/coccinelle/.gitignore b/contrib/coccinelle/.gitignore
index d3f29646dc3..2709d98eb91 100644
--- a/contrib/coccinelle/.gitignore
+++ b/contrib/coccinelle/.gitignore
@@ -1 +1,2 @@
+/ALL.cocci
 *.patch*
diff --git a/shared.mak b/shared.mak
index 5ccd6889fcb..66dcf6768db 100644
--- a/shared.mak
+++ b/shared.mak
@@ -73,6 +73,7 @@ ifndef V
 ## Used in "Makefile": SPATCH
 	QUIET_SPATCH			= @echo '   ' SPATCH $@;
 	QUIET_SPATCH_TEST		= @echo '   ' SPATCH TEST $(@:.build/%=%);
+	QUIET_SPATCH_CAT		= @echo '   ' SPATCH CAT $$^ \>$@;
 
 ## Used in "Makefile": SPATCH_*TMPL (quoted for use in "define"'s)
 	QUIET_SPATCH_CAT_TMPL		= @echo '   ' SPATCH CAT $$$$^ \>$$@;
-- 
2.38.0.1092.g8c0298861b0

