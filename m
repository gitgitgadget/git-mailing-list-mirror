Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5726C77B71
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 15:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbjDEPWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjDEPWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 11:22:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE03CA9
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 08:22:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p34so21109636wms.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680708133;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WG0QLVg899f39Wzidkk2PcHyG4+xcyN3nMwFm/6/eco=;
        b=Yfa1IuGiEbppNeuM7fck80B3HwxZVUIbupZySrDNcDw3SgIB8sbsj5HUVbB/DKGnyg
         iVKKuFLKyrQusurOKvpXTBlSVKtxqEC720ljxxRQv2VhAB72hxCIAHgMwiPkTHRmSppF
         Oa6FrkQ5dGiOflBiR0IOeSUMpHSlEfHresH79G4qCDPGn7PMy7NnLUBpkeEN4FyEAXRS
         fGYtSNwRfyvfhIAPh/CYt4MWR5jbjhhqK+ysNwJgSK05qBeo5ItwKXiv51Y0B1pXTVgy
         ayWTKaD4aYM/bLA1BFYv5VR5qA1D+yLhVVzeA2Drsz4wj6WYgwUpHjTh6ZpgiXxIIaKP
         l+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680708133;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WG0QLVg899f39Wzidkk2PcHyG4+xcyN3nMwFm/6/eco=;
        b=DRrgBvQjg2s2aqB5wOQTGtPZ2Y6Ptclxpo1HgxJvSP+sBii6XOpuJtuKKhRG0WLTY/
         vsd3W/qjt3BXZxlmpK6GE68eiV3sfZ2ARhgNN+Z9+pXVYMayyWeRSk2Hw9gDPY/kH5O8
         mKP4H+k/v13LOmSLB9DZ2o0GwVxNFIcfYPNWpWUTlkeU4DT82wo7x4IFws21EwwrHq6P
         XQB3C5CeT46PD8a7RRIUVDrdGijO1T/GAGrNk/npCp6ITd/E4MQ+VKLP+HdHkByt4JLN
         YR7/yxW3y6sWbD2RYuApAOa6kD2E+L6vQKqUps9tB1fdQkMhvd2idQUQz9ASimBs+WHH
         3e7A==
X-Gm-Message-State: AAQBX9e2ItUCzbpJTDRye4YLm7SoktJzY5xODtEHiH2trdaRaWv5wqi8
        VTbaKqcmGOkww/31aKi0IcWvy5px6gE=
X-Google-Smtp-Source: AKy350ZX1gEqnSSjeOd7zgjSSIiXh1OWsY/e3/KpvKOfF87AlZC+4vptNFOHIi+PrtjuWYKdTNc8Pw==
X-Received: by 2002:a7b:c38a:0:b0:3ea:e834:d0d1 with SMTP id s10-20020a7bc38a000000b003eae834d0d1mr5060697wmj.36.1680708133276;
        Wed, 05 Apr 2023 08:22:13 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003edc11c2ecbsm2515610wmj.4.2023.04.05.08.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:22:12 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 0/5] rebase: cleanup merge strategy option handling
Date:   Wed,  5 Apr 2023 16:21:43 +0100
Message-Id: <cover.1680708043.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.670.g64ef305212.dirty
In-Reply-To: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Cleanup the handling of --strategy-option now that we no longer need to
support "--preserve-merges" and properly quote the argument when saving
it to disc.

Thanks to Elijah for his comments on V1.

Changes since V1:

I've rebased these patches onto 'master' to avoid conflicts with
'sg/parse-options-h-initializers' in the new patch 2 (this series
depends on 'ab/fix-strategy-opts-parsing' but that has now been merged
to master).

Patch 1 - Unchanged.

Patch 2 - New patch to store the merge strategy options in an "struct
          strvec". This patch also introduces a new macro OPT_STRVEC()
          to collect options into an "struct strvec".

Patch 3 - Small simplification due to the changes in patch 2.

Patch 4 - Moved the code to quote a list so it can split by
          split_cmdline() into a new function quote_cmdline() as
	  suggested by Elijah.

Patch 5 - Reworded the commit message as suggested by Elijah.


Base-Commit: 140b9478dad5d19543c1cb4fd293ccec228f1240
Published-As: https://github.com/phillipwood/git/releases/tag/sequencer-merge-strategy-options%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/140b9478d...3515c31b4
Fetch-It-Via: git fetch https://github.com/phillipwood/git sequencer-merge-strategy-options/v2

Phillip Wood (5):
  rebase: stop reading and writing unnecessary strategy state
  sequencer: use struct strvec to store merge strategy options
  rebase -m: cleanup --strategy-option handling
  rebase -m: fix serialization of strategy options
  rebase: remove a couple of redundant strategy tests

 alias.c                        | 18 +++++++
 alias.h                        |  3 ++
 builtin/rebase.c               | 54 ++++-----------------
 builtin/revert.c               | 20 ++------
 parse-options-cb.c             | 16 +++++++
 parse-options.h                | 10 ++++
 sequencer.c                    | 57 ++++++++++------------
 sequencer.h                    | 12 +++--
 t/t3402-rebase-merge.sh        | 21 --------
 t/t3418-rebase-continue.sh     | 88 +++++++++++++---------------------
 t/t3436-rebase-more-options.sh | 18 -------
 11 files changed, 126 insertions(+), 191 deletions(-)

Range-diff against v1:
1:  029d0bf2b6 = 1:  2353c753f5 rebase: stop reading and writing unnecessary strategy state
-:  ---------- > 2:  dd7b82cdd5 sequencer: use struct strvec to store merge strategy options
2:  a01b182644 ! 3:  ccef0e6f4b rebase -m: cleanup --strategy-option handling
    @@ builtin/rebase.c: struct rebase_options {
      		.config_autosquash = -1,                \
      		.update_refs = -1,                      \
      		.config_update_refs = -1,               \
    -+		.strategy_opts = STRING_LIST_INIT_NODUP	\
    ++		.strategy_opts = STRING_LIST_INIT_NODUP,\
      	}
      
      static struct replay_opts get_replay_opts(const struct rebase_options *opts)
    @@ builtin/rebase.c: static struct replay_opts get_replay_opts(const struct rebase_
      
     -	if (opts->strategy_opts)
     -		parse_strategy_opts(&replay, opts->strategy_opts);
    -+	if (opts->strategy_opts.nr) {
    -+		ALLOC_ARRAY(replay.xopts, opts->strategy_opts.nr);
    -+		replay.xopts_nr = opts->strategy_opts.nr;
    -+		replay.xopts_alloc = opts->strategy_opts.nr;
    -+		for (size_t i = 0; i < opts->strategy_opts.nr; i++)
    -+			replay.xopts[i] =
    -+				xstrdup(opts->strategy_opts.items[i].string);
    -+	}
    ++	for (size_t i = 0; i < opts->strategy_opts.nr; i++)
    ++		strvec_push(&replay.xopts, opts->strategy_opts.items[i].string);
      
      	if (opts->squash_onto) {
      		oidcpy(&replay.squash_onto, opts->squash_onto);
3:  9af68cb065 ! 4:  9a90212ef2 rebase -m: fix serialization of strategy options
    @@ Commit message
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    + ## alias.c ##
    +@@
    + #include "alloc.h"
    + #include "config.h"
    + #include "gettext.h"
    ++#include "strbuf.h"
    + #include "string-list.h"
    + 
    + struct config_alias_data {
    +@@ alias.c: void list_aliases(struct string_list *list)
    + 	read_early_config(config_alias_cb, &data);
    + }
    + 
    ++void quote_cmdline(struct strbuf *buf, const char **argv)
    ++{
    ++	for (const char **argp = argv; *argp; argp++) {
    ++		if (argp != argv)
    ++			strbuf_addch(buf, ' ');
    ++		strbuf_addch(buf, '"');
    ++		for (const char *p = *argp; *p; p++) {
    ++			const char c = *p;
    ++
    ++			if (c == '"' || c =='\\')
    ++				strbuf_addch(buf, '\\');
    ++			strbuf_addch(buf, c);
    ++		}
    ++		strbuf_addch(buf, '"');
    ++	}
    ++}
    ++
    + #define SPLIT_CMDLINE_BAD_ENDING 1
    + #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
    + #define SPLIT_CMDLINE_ARGC_OVERFLOW 3
    +
    + ## alias.h ##
    +@@
    + #ifndef ALIAS_H
    + #define ALIAS_H
    + 
    ++struct strbuf;
    + struct string_list;
    + 
    + char *alias_lookup(const char *alias);
    ++/* Quote argv so buf can be parsed by split_cmdline() */
    ++void quote_cmdline(struct strbuf *buf, const char **argv);
    + int split_cmdline(char *cmdline, const char ***argv);
    + /* Takes a negative value returned by split_cmdline */
    + const char *split_cmdline_strerror(int cmdline_errno);
    +
      ## sequencer.c ##
     @@ sequencer.c: static void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
    - 	count = split_cmdline(strategy_opts_string,
    - 			      (const char ***)&opts->xopts);
    + 
    + 	count = split_cmdline(strategy_opts_string, &argv);
      	if (count < 0)
     -		die(_("could not split '%s': %s"), strategy_opts_string,
     +		BUG("could not split '%s': %s", strategy_opts_string,
      			    split_cmdline_strerror(count));
    - 	opts->xopts_nr = count;
    - 	for (i = 0; i < opts->xopts_nr; i++) {
    + 	for (i = 0; i < count; i++) {
    + 		const char *arg = argv[i];
     @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
      
      static void write_strategy_opts(struct replay_opts *opts)
      {
     -	int i;
      	struct strbuf buf = STRBUF_INIT;
      
    --	for (i = 0; i < opts->xopts_nr; ++i)
    --		strbuf_addf(&buf, " --%s", opts->xopts[i]);
    +-	for (i = 0; i < opts->xopts.nr; ++i)
    +-		strbuf_addf(&buf, " --%s", opts->xopts.v[i]);
     -
     +	/*
     +	 * Quote strategy options so that they can be read correctly
     +	 * by split_cmdline().
     +	 */
    -+	for (size_t i = 0; i < opts->xopts_nr; i++) {
    -+		char *arg = opts->xopts[i];
    -+
    -+		if (i)
    -+			strbuf_addch(&buf, ' ');
    -+		strbuf_addch(&buf, '"');
    -+		for (size_t j = 0; arg[j]; j++) {
    -+			const char c = arg[j];
    -+
    -+			if (c == '"' || c =='\\')
    -+				strbuf_addch(&buf, '\\');
    -+			strbuf_addch(&buf, c);
    -+		}
    -+		strbuf_addch(&buf, '"');
    -+	}
    ++	quote_cmdline(&buf, opts->xopts.v);
      	write_file(rebase_path_strategy_opts(), "%s\n", buf.buf);
      	strbuf_release(&buf);
      }
4:  3e02eeff78 ! 5:  3515c31b40 rebase: remove a couple of redundant strategy tests
    @@ Metadata
      ## Commit message ##
         rebase: remove a couple of redundant strategy tests
     
    -    The test removed in t3402 has been redundant ever since 80ff47957b
    -    (rebase: remember strategy and strategy options, 2011-02-06) which added
    -    a new test the first part of which (as noted in the commit message)
    -    duplicated the existing test. The test removed in t3418 has been
    -    redundant since the merge backend was removed in 68aa495b59 (rebase:
    -    implement --merge via the interactive machinery, 2018-12-11) as it now
    -    tests the same code paths as the preceding test.
    -
    +    Remove a test in t3402 that has been redundant ever since 80ff47957b
    +    (rebase: remember strategy and strategy options, 2011-02-06).  That
    +    commit added a new test, the first part of which (as noted in the old
    +    commit message) duplicated an existing test.
    +
    +    Also remove a test t3418 that has been redundant since the merge backend
    +    was removed in 68aa495b59 (rebase: implement --merge via the interactive
    +    machinery, 2018-12-11), since it now tests the same code paths as the
    +    preceding test.
    +
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## t/t3402-rebase-merge.sh ##
-- 
2.40.0.670.g64ef305212.dirty

