Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32898C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 14:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKIO5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKIO5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 09:57:36 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E020F4E
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 06:57:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m22so10131086eji.10
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hnJqX+JoJzk3T0Hzp52zEYvtq490O3RClSUmb9JHpDk=;
        b=IOZNn4sbeOiM/xi3DgNlEssi3YuT6LxQjIjQZ6Yi/BtjPUVHJpc1sh6Mr5ylk5npNM
         NQODl0j5vdAXsqwB71NB2APP0lDaqRpKf4ysZvlCfCnQMApIYdn8TAVDTqqpYesJcla4
         meWQ4AdwElPiy30lN/i7ht3pboBMQ04ti4ObxKXIrXkDXS8/Ao41oTZ36TrxQNrwbKqD
         l4k9uQhAtnzUFoQm6UX9XEI1gQGrzGHkrwKPRZQzAZUsovR8Ic0z0+K8f3HD2TOnPhIJ
         hKBd8+etJOo165G0YNazwtNhD11MieC9F668D/77esFSy4A5yY3PY514ApQq6ePlEDVE
         qfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnJqX+JoJzk3T0Hzp52zEYvtq490O3RClSUmb9JHpDk=;
        b=sZLMydPhC3P6I/u+tOS6MlkLpX80CX8B1AicO38QoJjR/TQSGVsxqwfIYIJacQWmD4
         oo4+/4EeUXfHlC01uXoO0VIcKeFDo8GhSDsm4V0yQRdW4yDrzjfQFsOtwtlcT4jH2jli
         e9oxS1BE7vRePOr9EmNf9Mwr/tQv5rQzmMXL4liWTaS61mIzYEQ5ROWAT19Gw/Ee+pud
         /x4hG8cdy7q84IudsQUsqI3w3GmyYL5PjTuLbqlJF0OC1Uec4rbMw6U7F89MlCKdLWob
         x020LJyFjYjO0L9Uc0q70AHS3iywB63yYVcj07yUExLmTlrNaZYgqRy7zauACrwHWLTB
         2JEQ==
X-Gm-Message-State: ACrzQf3WwtbJ3bA8xNX2P3BB70JOmqlIVKwVPEdBJ80b6xyIhr/WyIYG
        dBvd4xemwy5/ZW7xlcI0ihU=
X-Google-Smtp-Source: AMsMyM65IYj4hgnX4aQFf27y7sKIaCbuvr2XzqPVMZeN9fxLu1xKL4m9zunSu4Tj8hDkMITDtuxOtQ==
X-Received: by 2002:a17:906:af02:b0:7ad:917b:61ec with SMTP id lx2-20020a170906af0200b007ad917b61ecmr1175360ejb.513.1668005823402;
        Wed, 09 Nov 2022 06:57:03 -0800 (PST)
Received: from localhost (78-131-17-60.pool.digikabel.hu. [78.131.17.60])
        by smtp.gmail.com with ESMTPSA id kw6-20020a170907770600b0077909095acasm6065771ejc.143.2022.11.09.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:57:02 -0800 (PST)
Date:   Wed, 9 Nov 2022 15:57:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 08/13] cocci: make "coccicheck" rule incremental
Message-ID: <20221109145701.GD1731@szeder.dev>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
 <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
 <patch-v5-08.13-ee9ad433ab5-20221101T222616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v5-08.13-ee9ad433ab5-20221101T222616Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 11:35:50PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Optimize the very slow "coccicheck" target to take advantage of
> incremental rebuilding, and fix outstanding dependency problems with
> the existing rule.
> 
> The rule is now faster both on the initial run as we can make better
> use of GNU make's parallelism than the old ad-hoc combination of
> make's parallelism combined with $(SPATCH_BATCH_SIZE) and/or the
> "--jobs" argument to "spatch(1)".
> 
> It also makes us *much* faster when incrementally building, it's now
> viable to "make coccicheck" as topic branches are merged down.
> 
> The rule didn't use FORCE (or its equivalents) before, so a:
> 
> 	make coccicheck
> 	make coccicheck
> 
> Would report nothing to do on the second iteration. But all of our
> patch output depended on all $(COCCI_SOURCES) files, therefore e.g.:
> 
>     make -W grep.c coccicheck
> 
> Would do a full re-run, i.e. a a change in a single file would force
> us to do a full re-run.
> 
> The reason for this (not the initial rationale, but my analysis) is:
> 
> * Since we create a single "*.cocci.patch+" we don't know where to
>   pick up where we left off, or how to incrementally merge e.g. a
>   "grep.c" change with an existing *.cocci.patch.
> 
> * We've been carrying forward the dependency on the *.c files since
>   63f0a758a06 (add coccicheck make target, 2016-09-15) the rule was
>   initially added as a sort of poor man's dependency discovery.
> 
>   As we don't include other *.c files depending on other *.c files
>   has always been broken, as could be trivially demonstrated
>   e.g. with:
> 
>        make coccicheck
>        make -W strbuf.h coccicheck
> 
>   However, depending on the corresponding *.c files has been doing
>   something, namely that *if* an API change modified both *.c and *.h
>   files we'd catch the change to the *.h we care about via the *.c
>   being changed.
> 
>   For API changes that happened only via *.h files we'd do the wrong
>   thing before this change, but e.g. for function additions (not
>   "static inline" ones) catch the *.h change by proxy.
> 
> Now we'll instead:
> 
>  * Create a <RULE>/<FILE> pair in the .build directory, E.g. for
>    swap.cocci and grep.c we'll create
>    .build/contrib/coccinelle/swap.cocci.patch/grep.c.

Indeed, and the output of 'make coccicheck' with this patch looks like
this:

    MKDIR -p .build/contrib/coccinelle/hashmap.cocci.patch
    SPATCH .build/contrib/coccinelle/hashmap.cocci.patch/upload-pack.c
    SPATCH .build/contrib/coccinelle/hashmap.cocci.patch/merge-ort-wrappers.c
    SPATCH .build/contrib/coccinelle/hashmap.cocci.patch/unpack-trees.c
    SPATCH .build/contrib/coccinelle/hashmap.cocci.patch/gpg-interface.c
    SPATCH .build/contrib/coccinelle/hashmap.cocci.patch/linear-assignment.c

This is misleading, because it appears as 'spatch' would generate C
source files, but that's not the case, of course.

>    That file is the diff we'll apply for that <RULE>-<FILE>
>    combination, if there's no changes to me made (the common case)
>    it'll be an empty file.
> 
>  * Our generated *.patch
>    file (e.g. contrib/coccinelle/swap.cocci.patch) is now a simple "cat
>    $^" of all of all of the <RULE>/<FILE> files for a given <RULE>.
> 
>    In the case discussed above of "grep.c" being changed we'll do the
>    full "cat" every time, so they resulting *.cocci.patch will always
>    be correct and up-to-date, even if it's "incrementally updated".
> 
>    See 1cc0425a27c (Makefile: have "make pot" not "reset --hard",
>    2022-05-26) for another recent rule that used that technique.
> 
> As before we'll:
> 
>  * End up generating a contrib/coccinelle/swap.cocci.patch, if we
>    "fail" by creating a non-empty patch we'll still exit with a zero
>    exit code.
> 
>    Arguably we should move to a more Makefile-native way of doing
>    this, i.e. fail early, and if we want all of the "failed" changes
>    we can use "make -k", but as the current
>    "ci/run-static-analysis.sh" expects us to behave this way let's
>    keep the existing behavior of exhaustively discovering all cocci
>    changes, and only failing if spatch itself errors out.
> 
> Further implementation details & notes:
> 
>  * Before this change running "make coccicheck" would by default end
>    up pegging just one CPU at the very end for a while, usually as
>    we'd finish whichever *.cocci rule was the most expensive.
> 
>    This could be mitigated by combining "make -jN" with
>    SPATCH_BATCH_SIZE, see 960154b9c17 (coccicheck: optionally batch
>    spatch invocations, 2019-05-06).
> 
>    There will be cases where getting rid of "SPATCH_BATCH_SIZE" makes
>    things worse, but a from-scratch "make coccicheck" with the default
>    of SPATCH_BATCH_SIZE=1 (and tweaking it doesn't make a difference)
>    is faster (~3m36s v.s. ~3m56s) with this approach, as we can feed
>    the CPU more work in a less staggered way.
> 
>  * Getting rid of "SPATCH_BATCH_SIZE" particularly helps in cases
>    where the default of 1 yields parallelism under "make coccicheck",
>    but then running e.g.:
> 
>        make -W contrib/coccinelle/swap.cocci coccicheck
> 
>    I.e. before that would use only one CPU core, until the user
>    remembered to adjust "SPATCH_BATCH_SIZE" differently than the
>    setting that makes sense when doing a non-incremental run of "make
>    coccicheck".
> 
>  * Before the "make coccicheck" rule would have to clean
>    "contrib/coccinelle/*.cocci.patch*", since we'd create "*+" and
>    "*.log" files there. Now those are created in
>    .build/contrib/coccinelle/, which is covered by the "cocciclean" rule
>    already.
> 
> Outstanding issues & future work:
> 
>  * We could get rid of "--all-includes" in favor of manually
>    specifying a list of includes to give to "spatch(1)".
> 
>    As noted upthread of [1] a naïve removal of "--all-includes" will
>    result in broken *.cocci patches, but if we know the exhaustive
>    list of includes via COMPUTE_HEADER_DEPENDENCIES we don't need to
>    re-scan for them, we could grab the headers to include from the
>    .depend.d/<file>.o.d and supply them with the "--include" option to
>    spatch(1).q
> 
> 1. https://lore.kernel.org/git/87ft18tcog.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Makefile                      | 81 ++++++++++++++++++++++++-----------
>  contrib/coccinelle/.gitignore |  2 +-
>  shared.mak                    |  3 +-
>  3 files changed, 58 insertions(+), 28 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 25f0c7e837d..4bedff26285 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1306,10 +1306,6 @@ SANITIZE_ADDRESS =
>  SPATCH_INCLUDE_FLAGS = --all-includes
>  SPATCH_FLAGS =
>  SPATCH_TEST_FLAGS =
> -# Setting SPATCH_BATCH_SIZE higher will
> -# usually result in less CPU usage at the cost of higher peak memory.
> -# Setting it to 0 will feed all files in a single spatch invocation.
> -SPATCH_BATCH_SIZE = 1
>  
>  # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
>  TRACK_SPATCH_DEFINES =
> @@ -1317,7 +1313,6 @@ TRACK_SPATCH_DEFINES += $(SPATCH)
>  TRACK_SPATCH_DEFINES += $(SPATCH_INCLUDE_FLAGS)
>  TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
>  TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
> -TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
>  GIT-SPATCH-DEFINES: FORCE
>  	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
>  	    if test x"$$FLAGS" != x"`cat GIT-SPATCH-DEFINES 2>/dev/null`" ; then \
> @@ -3163,6 +3158,7 @@ check: $(GENERATED_H)
>  
>  COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
>  COCCI_RULES = $(COCCI_GLOB)
> +COCCI_NAMES = $(COCCI_RULES:contrib/coccinelle/%.cocci=%)
>  
>  COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
>  COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
> @@ -3170,32 +3166,65 @@ COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
>  COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
>  COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
>  
> +# It's expensive to compute the many=many rules below, only eval them
> +# on $(MAKECMDGOALS) that match these $(COCCI_RULES)
> +COCCI_RULES_GLOB =
> +COCCI_RULES_GLOB += cocci%
> +COCCI_RULES_GLOB += .build/contrib/coccinelle/%
> +COCCI_RULES_GLOB += $(COCCICHECK_PATCHES)
> +COCCI_RULES_GLOB += $(COCCICHEC_PATCHES_PENDING)
> +COCCI_GOALS = $(filter $(COCCI_RULES_GLOB),$(MAKECMDGOALS))
> +
>  COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
>  
> -COCCI_PATCHES = $(COCCI_RULES:%=%.patch)
> -$(COCCI_PATCHES): GIT-SPATCH-DEFINES
> -$(COCCI_PATCHES): $(COCCI_SOURCES)
> -$(COCCI_PATCHES): %.patch: %
> -	$(QUIET_SPATCH) \
> -	if test $(SPATCH_BATCH_SIZE) = 0; then \
> -		limit=; \
> -	else \
> -		limit='-n $(SPATCH_BATCH_SIZE)'; \
> -	fi; \
> -	if ! echo $(COCCI_SOURCES) | xargs $$limit \
> -		$(SPATCH) $(SPATCH_FLAGS) \
> -		$(SPATCH_INCLUDE_FLAGS) \
> -		--sp-file $< --patch . \
> -		>$@+ 2>$@.log; \
> +.build/contrib/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
> +	$(call mkdir_p_parent_template)
> +	$(QUIET_GEN) >$@
> +
> +define cocci-rule
> +
> +## Rule for .build/$(1).patch/$(2); Params:
> +# $(1) = e.g. "free.cocci"
> +# $(2) = e.g. "grep.c"
> +COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
> +.build/$(1).patch/$(2): GIT-SPATCH-DEFINES
> +.build/$(1).patch/$(2): .build/contrib/coccinelle/FOUND_H_SOURCES
> +.build/$(1).patch/$(2): $(1)
> +.build/$(1).patch/$(2): .build/$(1).patch/% : %
> +	$$(call mkdir_p_parent_template)
> +	$$(QUIET_SPATCH)if ! $$(SPATCH) $$(SPATCH_FLAGS) \
> +		$$(SPATCH_INCLUDE_FLAGS) \
> +		--sp-file $(1) --patch . $$< \
> +		>$$@ 2>$$@.log; \
>  	then \
> -		cat $@.log; \
> +		echo "ERROR when applying '$(1)' to '$$<'; '$$@.log' follows:"; \
> +		cat $$@.log; \
>  		exit 1; \
> -	fi; \
> -	mv $@+ $@; \
> -	if test -s $@; \
> +	fi
> +endef
> +
> +define cocci-matrix
> +
> +$(foreach s,$(COCCI_SOURCES),$(call cocci-rule,$(1),$(s)))
> +endef
> +
> +ifdef COCCI_GOALS
> +$(eval $(foreach c,$(COCCI_RULES),$(call cocci-matrix,$(c))))
> +endif
> +
> +define spatch-rule
> +
> +contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
> +	$$(QUIET_SPATCH_CAT)cat $$^ >$$@ && \
> +	if test -s $$@; \
>  	then \
> -		echo '    ' SPATCH result: $@; \
> +		echo '    ' SPATCH result: $$@; \
>  	fi
> +endef
> +
> +ifdef COCCI_GOALS
> +$(eval $(foreach n,$(COCCI_NAMES),$(call spatch-rule,$(n))))
> +endif
>  
>  COCCI_TEST_RES_GEN = $(addprefix .build/,$(COCCI_TEST_RES))
>  $(COCCI_TEST_RES_GEN): GIT-SPATCH-DEFINES
> @@ -3487,7 +3516,7 @@ profile-clean:
>  cocciclean:
>  	$(RM) GIT-SPATCH-DEFINES
>  	$(RM) -r .build/contrib/coccinelle
> -	$(RM) contrib/coccinelle/*.cocci.patch*
> +	$(RM) contrib/coccinelle/*.cocci.patch
>  
>  clean: profile-clean coverage-clean cocciclean
>  	$(RM) -r .build
> diff --git a/contrib/coccinelle/.gitignore b/contrib/coccinelle/.gitignore
> index d3f29646dc3..1d45c0a40c8 100644
> --- a/contrib/coccinelle/.gitignore
> +++ b/contrib/coccinelle/.gitignore
> @@ -1 +1 @@
> -*.patch*
> +*.patch
> diff --git a/shared.mak b/shared.mak
> index 96b06acc455..f437073e48c 100644
> --- a/shared.mak
> +++ b/shared.mak
> @@ -71,8 +71,9 @@ ifndef V
>  	QUIET_RC       = @echo '   ' RC $@;
>  
>  ## Used in "Makefile": SPATCH
> -	QUIET_SPATCH			= @echo '   ' SPATCH $<;
> +	QUIET_SPATCH			= @echo '   ' SPATCH $@;
>  	QUIET_SPATCH_TEST		= @echo '   ' SPATCH TEST $(@:.build/%=%);
> +	QUIET_SPATCH_CAT		= @echo '   ' SPATCH CAT $$^ \>$@;
>  
>  ## Used in "Documentation/Makefile"
>  	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
> -- 
> 2.38.0.1280.g8136eb6fab2
> 
