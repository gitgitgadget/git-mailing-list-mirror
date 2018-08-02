Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E65E1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 11:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHBNqd (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 09:46:33 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41098 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbeHBNqd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 09:46:33 -0400
Received: by mail-ed1-f46.google.com with SMTP id s24-v6so838578edr.8
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYvk3aLBjZEKIjaw9Y2gLdMEKBCdfZHMiDdjbODImcM=;
        b=mcHO7cGDnV1NS/tDy1eiBDYMxbsSDjmkUXjtn0FIZCZHbwbGWVO8LzKPCii80VHRUx
         Ypj3ZEBHj4Z64N7hEfVL6V1KRiB+YpcchyaO44s4VsD4mRPZZcdDaGA6x6qZHP5um6S0
         JBL9FAVbZquleR6szvS6g9VyOv99ImxXbQWYFEOeex4IQXL4IFv3NYZgZJqs8tITk9GK
         jIPOptRncZPw/8da7iGBwXN71b8tkkz1KqqGlTBVee3tfvp8i8sZFAUw08+2z9jTPw8w
         5U+LXyDo7OHFtsGZb4lSxe4B5qz7e2YUc0uaYtrYi/XkfDKv1LtR8HsFgdo/e+pg4Wfk
         G1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYvk3aLBjZEKIjaw9Y2gLdMEKBCdfZHMiDdjbODImcM=;
        b=DicQA+prgyAuSz1kJuJmFcCeFWjpRXJBoGZ5q8T4MrfZqxrns49r1+awgT+ABjbUq7
         aQpHW7UwE3o9JLlN6zh/AyWR+f3BS3+lzeLGaCNJZsMyfzki8jx4VdhAPIT5imvA5hBm
         Z9JTrcHIadgLIHmzu6673tuG6/tkzQ/I9/7UbcNSPba4vnyaKEaqEbDLWshiyvbwYuc1
         xbVGXdenvkVoiKAj8H8uLplpCQ+TCpbUqAYEY0PDp3ZwHR9Ke83STk26kWzuBi2THHuu
         kztJCXAOadFQVHOpO67NYzDONHvCcYmiirm0SgnoAbD/IYyGg9HwMuNGJ8ZHTedv8hzR
         5Dtw==
X-Gm-Message-State: AOUpUlHNQ/ziw4eksSEGganf49TxG/lT8mxAwWUTqS75jqlnDIl5luZI
        9dUc5ZDM43iyk4gnxD/sq9wTNgKq
X-Google-Smtp-Source: AAOMgpfwUv1DoFf67174Edxz8I7IfdSOt3/zoMTREoUi5uDrTi9viQlU95BgkkKAlNb5vS91D05YAw==
X-Received: by 2002:a50:c251:: with SMTP id t17-v6mr3032808edf.108.1533210940043;
        Thu, 02 Aug 2018 04:55:40 -0700 (PDT)
Received: from localhost.localdomain (x4db11307.dyn.telefonica.de. [77.177.19.7])
        by smtp.gmail.com with ESMTPSA id u2-v6sm863675eds.43.2018.08.02.04.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 04:55:39 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PoC] coccinelle: make Coccinelle-related make targets more fine-grained
Date:   Thu,  2 Aug 2018 13:55:22 +0200
Message-Id: <20180802115522.16107-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180723135100.24288-1-szeder.dev@gmail.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


So, I have this PoC patch below on top of this patch series for some
months now; actually this series was all fallout from working on this
patch.  It makes 'make -j<N> coccicheck' much faster (speedup of over
99% :) in some scenarios that, in my experience, occur rather
frequently when working on Coccinelle semantic patches (as opposed to
occasionally running 'make coccicheck' to see whether there are any
regressions).

However, it's not ready for inclusion as it is, because,
unfortunately, the improvements are not without some disadvantages, as
explained in the second half of the commit message below.

Anyway, I'm sending this out, because I don't see how I could make it
any better, but other contributors working on semantic patches might
still find it useful to keep this in their own fork, even in its
current form.  And perhaps someone will come up with a brilliant idea
to address those disadvantages...

Also available at:

  https://github.com/szeder/git make-coccicheck-finegrained


  -- >8 --

Subject: [PATCH] [PoC] coccinelle: make Coccinelle-related make targets more fine-grained

When running 'make coccicheck', each semantic patch is applied to all
source files in a separate shell for loop.  This approach has the
following disadvantages:

  1. Even if you only modified a single C source file, that shell loop
     will still iterate over all source files and apply the semantic
     patches to all of them, wasting a lot of time.

  2. If you apply only a single semantic patch (either implicitly,
     after you modified only one of them (and the results of the
     previous 'make coccicheck' are still there), or explicitly, by
     running e.g. 'make contrib/coccinelle/array.cocci.patch'), then
     you won't be able to exploit multiple CPU cores to speed up the
     operation, because that shell loop will iterate over all source
     files sequentially.

  3. 'make coccicheck' can only use as many parallel jobs as the
     number of semantic patches, so even if you have more available
     CPU cores than that, you can't exploit them all to speed up this
     operation.

  4. During 'make coccicheck' there is only a single

       SPATCH contrib/coccinelle/<whatever>.cocci

     line (or as many lines as the number of parallel jobs) of output
     when starting to apply each semantic patch, and then comes a long
     silence without any indication of progress, because applying some
     of our semantic patches to all source files can take over a
     minute.  This can trick developers new to semantic patches into
     thinking that something went wrong, hung, ended up in an endless
     loop, etc.  It certainly confused my the first time.

Let's add a bit of Makefile metaprogramming to generate finer-grained
make targets applying one semantic patch to only a single source file,
and specify these as dependencies of the targets applying one semantic
patch to all source files.  This way that shell loop can be avoided,
semantic patches will only be applied to changed source files, and the
same semantic patch can be applied in parallel to multiple source
files.  The only remaining sequential part is aggregating the
suggested transformations from the individual targets into a single
patch file, which is comparatively cheap (especially since ideally
there aren't any suggestions).

This change brings spectacular speedup in the scenario described in
point (1) above.  When the results of a previous 'make coccicheck' are
there, the time needed to run

  touch apply.c ; time make -j4 coccicheck

went from 3m42s to 1.848s, which is just over 99% speedup, yay!, and
'apply.c' is the second longest source file in our codebase.  In the
scenario in point (2), running

  touch contrib/coccinelle/array.cocci ; time make -j4 coccicheck

went from 56.364s to 35.883s, which is ~36% speedup.

All the above timings are best-of-five on a machine with 2 physical
and 2 logical cores.  I don't have the hardware to bring any numbers
for point (3).  The time needed to run 'make -j4 coccicheck' in a
clean state didn't change, it's ~3m42s both with and without this
patch.

Unfortunately, this new approach has some disadvantages compared to
the current situation:

  - [RFC]
    With this patch 'make coccicheck's output will look like this
    ('make' apparently doesn't iterate over semantic patches in
    lexicographical order):

      SPATCH commit.cocci              abspath.c
      SPATCH commit.cocci              advice.c
      <... lots of lines ...>
      SPATCH array.cocci               http-walker.c
      SPATCH array.cocci               remote-curl.c

    which means that the number of lines in the output grows from
    "Nr-of-semantic-patches" to "Nr-of-semantic-patches *
    Nr-of-source-files".

    Now, while this certainly addresses point (4) above, it can be
    considered too much, and I'm not sure that (4) is that big an
    issue to justify this much output.

    OTOH, I couldn't yet figure out a way to print a single 'SPATCH
    contrib/coccinelle/<whatever>.cocci' line at the beginning of
    applying that semantic patch without triggering unnecessary work,
    effectively killing most of the runtime benefits.  Or to somehow
    iterate over source files in the outer loop and over semantic
    patches in the inner loop, so we could have one output line per
    file.

  - [RFC]
    The overhead of applying a semantic patch to all source files
    became larger.  'make coccicheck' currently runs only one shell
    process and creates two output files for each semantic patch.
    With this patch it will run approx.  "Nr-of-semantic-patches *
    Nr-of-source-files" shell processes and create twice as many
    output files.

    This overhead can be quantified by measuring the runtime of:

      make -j4 SPATCH=true coccicheck

    and this patch increases it from 0.142s to 1.479s.  While this is
    indeed an order of magnitude increase, it's still negligible
    compared to the "real" runtime of 3m42s.

    So the increased overhead doesn't seem to matter on Linux, but I
    would expect that it's worse on OSX and Windows; though I'm not
    sure whether Coccinelle (with all its OCaml dependencies) works on
    those platforms in the first place.

  - [RFC]
    This approach uses $(eval), which we haven't used in any of our
    Makefiles yet.  I wonder whether it's portable enough.  And it's
    ugly and complicated.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile                      | 52 ++++++++++++++++++++++++-----------
 contrib/coccinelle/.gitignore |  3 +-
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index d616c04125..f516dd93d1 100644
--- a/Makefile
+++ b/Makefile
@@ -2674,25 +2674,44 @@ COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
 else
 COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
 endif
+COCCI_SEM_PATCHES = $(wildcard contrib/coccinelle/*.cocci)
 
-%.cocci.patch: %.cocci $(COCCI_SOURCES)
-	@echo '    ' SPATCH $<; \
-	ret=0; \
-	for f in $(COCCI_SOURCES); do \
-		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
-			{ ret=$$?; break; }; \
-	done >$@+ 2>$@.log; \
-	if test $$ret != 0; \
+define cocci_template
+$(cocci_sem_patch)_dirs := $$(addprefix $(cocci_sem_patch).patches/,$$(sort $$(dir $$(COCCI_SOURCES))))
+
+$$($(cocci_sem_patch)_dirs):
+	@mkdir -p $$@
+
+# e.g. 'contrib/coccinelle/strbuf.cocci.patches/builtin/commit.c.patch'
+# Applies one semantic patch to _one_ source file.
+$(cocci_sem_patch).patches/%.patch: % $(cocci_sem_patch)
+	@printf '     SPATCH %-25s %s\n' $$(notdir $(cocci_sem_patch)) $$<; \
+	if ! $$(SPATCH) --sp-file $(cocci_sem_patch) $$< $$(SPATCH_FLAGS) >$$@ 2>$$@.log; \
 	then \
-		cat $@.log; \
+		rm -f $$@; \
+		cat $$@.log; \
 		exit 1; \
-	fi; \
-	mv $@+ $@; \
-	if test -s $@; \
-	then \
-		echo '    ' SPATCH result: $@; \
 	fi
-coccicheck: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.cocci))
+
+# e.g. 'contrib/coccinelle/strbuf.cocci.patch'
+# Applies one semantic patch to _all_ source files.
+$(cocci_sem_patch).patch: $(cocci_sem_patch) $$($(cocci_sem_patch)_dirs) $$(patsubst %,$(cocci_sem_patch).patches/%.patch,$(COCCI_SOURCES))
+	@>$$@+; \
+	for f in $$(filter %.patch,$$^); do \
+		if test -s $$$$f; \
+		then \
+			cat $$$$f >>$$@+; \
+		fi \
+	done; \
+	mv $$@+ $$@; \
+	if test -s $$@; then \
+		echo '    ' SPATCH result: $$@; \
+	fi
+endef
+
+$(foreach cocci_sem_patch,$(COCCI_SEM_PATCHES),$(eval $(cocci_template)))
+
+coccicheck: $(addsuffix .patch,$(COCCI_SEM_PATCHES))
 
 .PHONY: coccicheck
 
@@ -2907,7 +2926,8 @@ profile-clean:
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
 cocciclean:
-	$(RM) contrib/coccinelle/*.cocci.patch*
+	$(RM) contrib/coccinelle/*.cocci.patch
+	$(RM) -r contrib/coccinelle/*.cocci.patches/
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) *.res
diff --git a/contrib/coccinelle/.gitignore b/contrib/coccinelle/.gitignore
index d3f29646dc..7ae6ffa983 100644
--- a/contrib/coccinelle/.gitignore
+++ b/contrib/coccinelle/.gitignore
@@ -1 +1,2 @@
-*.patch*
+*.cocci.patch
+*.cocci.patches/
-- 
2.18.0.408.g42635c01bc

