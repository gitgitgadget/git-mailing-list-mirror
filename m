Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1BEC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiKAWgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiKAWgg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABCF2192
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n12so40670016eja.11
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IS4hB0rTg39gKvfuG9yUxz+zAsc+iu0GLYuIPmCF14=;
        b=UoLrduzHKO2e4HvItxq5vFfya5r5w4Yk9ge2LATXTnJY3T1Ne7kjE5B9gQH9FCmmHl
         bcwsXgBLDLCTiRECc+q4LFqd64R256IMyA8OfciAdAYaZQp5WAAh4h3KJPTjpip/qyJE
         AWsd6xjCogkadxHheffFGaMO00VD2LnKapnBbCoYw2c7TR99VVfCVtO5VYGmziThUG+Z
         EUmTcc2idYV9RO3QRkEK2gyAIRts/ncby67QyJXpR/abxvRzQm9A0RlpHXNrXWxyvetH
         bTk5wy68UcV8x94sJXs+stYN95HmmGWdzBz9u5KgkeSUUHJk8UqRQOOHBj8TxT6MXTJN
         iKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IS4hB0rTg39gKvfuG9yUxz+zAsc+iu0GLYuIPmCF14=;
        b=kGlRJTLKTZros4qfJLnCV46V6CZbuFhvLVOpxe4+quULJ/qx2a/LBUg4lrTBo7tFT/
         xZyy6qKBo+Lg6XOSD6A9C7xHYT+STVzqRdCciyqvaoMPz/k5pLeucHRL4hzNI4ny6mGn
         FOm9GRU5XMzusTZxyqujctMLVisqGuanrBxMpXuK5B8Z82QZZwaNwNFvzQd158wBD+Vy
         xsAFe7iFzScEhnf8S8JlhY+6BAOUNmuBwhL+EGGE1SeQ/xSoTb2HI/USNC0oqmxCivDy
         SjVeiwidmUuY7iwhA83jNS286MPSNBmpJO20nzhlz45D59He1P2nGzUs4zRjf0GjUTrm
         zv1w==
X-Gm-Message-State: ACrzQf2WrgGKUddjaz2r4AMJCc6JEVd8m44DihvBtJfzXx/zGsw8aiuN
        ni2ElUyq/PCTElo9v9JZancJHdw2idL9kg==
X-Google-Smtp-Source: AMsMyM6rBNc9FNYeSSFJqK4QlwsQTuhiBcnbWtNMPaEBE7XA2bVmkwFNiIWuKRXvT1t9c/mNjYwfKw==
X-Received: by 2002:a17:907:9602:b0:780:8c9f:f99a with SMTP id gb2-20020a170907960200b007808c9ff99amr20745225ejc.465.1667342160562;
        Tue, 01 Nov 2022 15:36:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/13] cocci: make "incremental" possible + a ccache-like tool
Date:   Tue,  1 Nov 2022 23:35:42 +0100
Message-Id: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of the series to have "make coccicheck" run
incrementally. For the v1 and general overview see:
https://lore.kernel.org/git/cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com/

For a performance overview see the v4 CL:
http://lore.kernel.org/git/cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com

Updates since v4:

 * SZEDER pointed out I needed to remove the ALL.cocci. I did that by
   having that ALL.cocci generated in .build/contrib/coccinelle,
   instead among the user-maintained *.cocci files in
   contrib/coccinelle.

   I think it leaves things in a beter place, but there's some churn
   from 8/13 onwards in service of that.
 * To make that easier the *.cocci files are copied to .build before
   being executed, which makes making ALL.cocci and the
   "non-generated" *.cocci easier.
 * Fixed typo/breakage in "make coccicheck-pending" Updated .gitignore
 * rule along with 8/13 (no more *.patch+ files.FixeFixeFixeFixe
 * A few other misc changes (e.g. commit mesages, docs), see
   range-diff below.

Passing CI for this:
https://github.com/avar/git/actions/runs/3363433825/jobs/5586038736;
It finished static-analysis in ~7m now, instead of ~17m (master result
at:
https://github.com/git/git/actions/runs/3358829617/jobs/5566255602)

Ævar Arnfjörð Bjarmason (13):
  Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
  cocci rules: remove unused "F" metavariable from pending rule
  Makefile: add ability to TAB-complete cocci *.patch rules
  Makefile: have "coccicheck" re-run if flags change
  Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
  cocci: split off include-less "tests" from SPATCH_FLAGS
  cocci: split off "--all-includes" from SPATCH_FLAGS
  cocci: make "coccicheck" rule incremental
  cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
  Makefile: copy contrib/coccinelle/*.cocci to build/
  cocci rules: remove <id>'s from rules that don't need them
  cocci: run against a generated ALL.cocci
  spatchcache: add a ccache-alike for "spatch"

 .gitignore                                    |   1 +
 Makefile                                      | 175 ++++++++--
 contrib/coccinelle/.gitignore                 |   2 +-
 contrib/coccinelle/README                     |  49 +++
 contrib/coccinelle/hashmap.cocci              |   2 +-
 contrib/coccinelle/preincr.cocci              |   2 +-
 contrib/coccinelle/spatchcache                | 304 ++++++++++++++++++
 contrib/coccinelle/strbuf.cocci               |   2 +-
 contrib/coccinelle/swap.cocci                 |   2 +-
 .../coccinelle/the_repository.pending.cocci   |   1 -
 shared.mak                                    |   8 +-
 11 files changed, 515 insertions(+), 33 deletions(-)
 create mode 100755 contrib/coccinelle/spatchcache

Range-diff against v4:
 1:  c0306e3c397 =  1:  1c77706db26 Makefile + shared.mak: rename and indent $(QUIET_SPATCH_T)
 2:  14e757cc020 =  2:  d8556f94cb4 cocci rules: remove unused "F" metavariable from pending rule
 3:  210dbc6b101 =  3:  6bf908044eb Makefile: add ability to TAB-complete cocci *.patch rules
 4:  b859dae7509 =  4:  460025dbbf6 Makefile: have "coccicheck" re-run if flags change
 5:  11b9227722b =  5:  b00ceccf1d1 Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
 6:  1c30f4b543b =  6:  04d268e246b cocci: split off include-less "tests" from SPATCH_FLAGS
 7:  86827388627 =  7:  cae46461ebf cocci: split off "--all-includes" from SPATCH_FLAGS
 8:  340ce523436 !  8:  ee9ad433ab5 cocci: make "coccicheck" rule incremental
    @@ Makefile: check: $(GENERATED_H)
     +COCCI_NAMES = $(COCCI_RULES:contrib/coccinelle/%.cocci=%)
      
      COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
    -+COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
      COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
    -+COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
    -+
    +@@ Makefile: COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
    + COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
    + COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
    + 
     +# It's expensive to compute the many=many rules below, only eval them
     +# on $(MAKECMDGOALS) that match these $(COCCI_RULES)
     +COCCI_RULES_GLOB =
    @@ Makefile: check: $(GENERATED_H)
     +COCCI_RULES_GLOB += $(COCCICHECK_PATCHES)
     +COCCI_RULES_GLOB += $(COCCICHEC_PATCHES_PENDING)
     +COCCI_GOALS = $(filter $(COCCI_RULES_GLOB),$(MAKECMDGOALS))
    - 
    - COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
    - COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
    - 
    ++
      COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
      
     -COCCI_PATCHES = $(COCCI_RULES:%=%.patch)
    @@ Makefile: check: $(GENERATED_H)
     +define spatch-rule
     +
     +contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
    -+	$(QUIET_SPATCH_CAT_TMPL)cat $$^ >$$@ && \
    ++	$$(QUIET_SPATCH_CAT)cat $$^ >$$@ && \
     +	if test -s $$@; \
      	then \
     -		echo '    ' SPATCH result: $@; \
    @@ Makefile: profile-clean:
      	$(RM) GIT-SPATCH-DEFINES
      	$(RM) -r .build/contrib/coccinelle
     -	$(RM) contrib/coccinelle/*.cocci.patch*
    -+	$(RM) $(COCCICHECK_PATCHES)
    -+	$(RM) $(COCCICHECK_PATCHES_PENDING)
    ++	$(RM) contrib/coccinelle/*.cocci.patch
      
      clean: profile-clean coverage-clean cocciclean
      	$(RM) -r .build
     
    + ## contrib/coccinelle/.gitignore ##
    +@@
    +-*.patch*
    ++*.patch
    +
      ## shared.mak ##
     @@ shared.mak: ifndef V
      	QUIET_RC       = @echo '   ' RC $@;
    @@ shared.mak: ifndef V
     -	QUIET_SPATCH			= @echo '   ' SPATCH $<;
     +	QUIET_SPATCH			= @echo '   ' SPATCH $@;
      	QUIET_SPATCH_TEST		= @echo '   ' SPATCH TEST $(@:.build/%=%);
    ++	QUIET_SPATCH_CAT		= @echo '   ' SPATCH CAT $$^ \>$@;
      
    -+## Used in "Makefile": SPATCH_*TMPL (quoted for use in "define"'s)
    -+	QUIET_SPATCH_CAT_TMPL		= @echo '   ' SPATCH CAT $$$$^ \>$$@;
    -+
      ## Used in "Documentation/Makefile"
      	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
    - 	QUIET_XMLTO	= @echo '   ' XMLTO $@;
 9:  134b3743a60 =  9:  332fb6c8640 cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
 -:  ----------- > 10:  56ca8f5720a Makefile: copy contrib/coccinelle/*.cocci to build/
10:  89f778ac055 = 11:  73bb897c965 cocci rules: remove <id>'s from rules that don't need them
11:  a848d09527f ! 12:  55d2f638359 cocci: run against a generated ALL.cocci
    @@ Makefile: SPATCH_TEST_FLAGS =
     +#
     +# - Makes error and performance analysis harder, as rules will be
     +#   applied from a monolithic ALL.cocci, rather than
    -+#   e.g. strbuf.cocci.
    ++#   e.g. strbuf.cocci. To work around this either undefine this, or
    ++#   generate a specific patch, e.g. this will always use strbuf.cocci,
    ++#   not ALL.cocci:
    ++#
    ++#	make contrib/coccinelle/strbuf.cocci.patch
     +SPATCH_CONCAT_COCCI = YesPlease
     +
      # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
    @@ Makefile: check: $(GENERATED_H)
      		exit 1; \
      	fi
      
    -+COCCI_GEN_ALL = contrib/coccinelle/ALL.cocci
    ++COCCI_GEN_ALL = .build/contrib/coccinelle/ALL.cocci
      COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
    --COCCI_RULES = $(COCCI_GLOB)
    --COCCI_NAMES = $(COCCI_RULES:contrib/coccinelle/%.cocci=%)
    -+COCCI_NAMES = $(sort ALL $(COCCI_GLOB:contrib/coccinelle/%.cocci=%))
    -+COCCI_RULES = $(filter-out $(COCCI_GEN_ALL),$(COCCI_GLOB))
    - 
    - COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
    - COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
    -@@ Makefile: COCCI_RULES_GLOB += cocci%
    - COCCI_RULES_GLOB += .build/contrib/coccinelle/%
    - COCCI_RULES_GLOB += $(COCCICHECK_PATCHES)
    - COCCI_RULES_GLOB += $(COCCICHEC_PATCHES_PENDING)
    -+COCCI_RULES_GLOB += $(COCCI_GEN_ALL)
    - COCCI_GOALS = $(filter $(COCCI_RULES_GLOB),$(MAKECMDGOALS))
    - 
    - COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
    -@@ Makefile: COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
    + COCCI_RULES_TRACKED = $(COCCI_GLOB:%=.build/%)
    ++COCCI_RULES_TRACKED_NO_PENDING = $(filter-out %.pending.cocci,$(COCCI_RULES_TRACKED))
    + COCCI_RULES =
    ++COCCI_RULES += $(COCCI_GEN_ALL)
    + COCCI_RULES += $(COCCI_RULES_TRACKED)
    + COCCI_NAMES =
    + COCCI_NAMES += $(COCCI_RULES:.build/contrib/coccinelle/%.cocci=%)
    +@@ Makefile: $(COCCI_RULES_TRACKED): .build/% : %
      	$(call mkdir_p_parent_template)
      	$(QUIET_GEN) >$@
      
    -+$(COCCI_GEN_ALL): $(COCCICHECK)
    ++$(COCCI_GEN_ALL): $(COCCI_RULES_TRACKED_NO_PENDING)
     +	$(call mkdir_p_parent_template)
     +	$(QUIET_SPATCH_CAT)cat $^ >$@
     +
      ifeq ($(COMPUTE_HEADER_DEPENDENCIES),no)
      SPATCH_USE_O_DEPENDENCIES =
      endif
    -@@ Makefile: $(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(c),$(s),$(s:%.c=%.o)))
    - endef
    - 
    - ifdef COCCI_GOALS
    --$(eval $(foreach c,$(COCCI_RULES),$(call cocci-matrix,$(c))))
    -+$(eval $(foreach c,$(COCCI_RULES) $(COCCI_GEN_ALL),$(call cocci-matrix,$(c))))
    - endif
    - 
    - define spatch-rule
     @@ Makefile: COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
      $(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
      $(COCCI_TEST_RES_GEN): .build/%.res : %.c
    @@ Makefile: $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib
     +ifdef SPATCH_CONCAT_COCCI
     +coccicheck: contrib/coccinelle/ALL.cocci.patch
     +else
    - coccicheck: $(COCCICHECK_PATCHES)
    + coccicheck: $(COCCICHECK_PATCHES_INTREE)
     +endif
      
      # See contrib/coccinelle/README
      coccicheck-pending: coccicheck-test
    -@@ Makefile: cocciclean:
    - 	$(RM) -r .build/contrib/coccinelle
    - 	$(RM) $(COCCICHECK_PATCHES)
    - 	$(RM) $(COCCICHECK_PATCHES_PENDING)
    -+	$(RM) $(COCCI_GEN_ALL)
    - 
    - clean: profile-clean coverage-clean cocciclean
    - 	$(RM) -r .build
    -
    - ## contrib/coccinelle/.gitignore ##
    -@@
    -+/ALL.cocci
    - *.patch*
     
      ## contrib/coccinelle/README ##
     @@ contrib/coccinelle/README: Git-specific tips & things to know about how we run "spatch":
    @@ contrib/coccinelle/README: Git-specific tips & things to know about how we run "
     +   my_name", v.s. anonymous "@@") needs to be unique across all our
     +   *.cocci files. You should only need to name rules if other rules
     +   depend on them (currently only one rule is named).
    -
    - ## shared.mak ##
    -@@ shared.mak: ifndef V
    - ## Used in "Makefile": SPATCH
    - 	QUIET_SPATCH			= @echo '   ' SPATCH $@;
    - 	QUIET_SPATCH_TEST		= @echo '   ' SPATCH TEST $(@:.build/%=%);
    -+	QUIET_SPATCH_CAT		= @echo '   ' SPATCH CAT $$^ \>$@;
    - 
    - ## Used in "Makefile": SPATCH_*TMPL (quoted for use in "define"'s)
    - 	QUIET_SPATCH_CAT_TMPL		= @echo '   ' SPATCH CAT $$$$^ \>$$@;
12:  a728aa301a6 = 13:  ef578c230ea spatchcache: add a ccache-alike for "spatch"
-- 
2.38.0.1280.g8136eb6fab2

