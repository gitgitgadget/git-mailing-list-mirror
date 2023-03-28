Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23675C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjC1RwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjC1RwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:52:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BE0D502
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:51:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l12so13077324wrm.10
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0tGuDHpx1r9hSxAgFEblXCcRr2FfaPGPd4X3wVbygg=;
        b=QJwThH8YE+e3OBLEeIxzHN/sLCxUgD1Z0WCLGatJLJl4bHa2M938IEpDRRHCaMsAMi
         Z5pJLE9ofwEA3UJeTPHScTtOvEUOMSDz58ZF8cJrntpyhH5Igv8Z76fsVB2CZoi/bi/9
         HJ0ZuyEj1S8NjMYWUvA1rqh3mfIXjvs8s5qkcm7DVmyq08JFyUa6ytTfK8OJSN5uSn+S
         8orluX9CnsSqnVbiHnz+TsDnFQYuATPpFJVJpZ+3xPuSFicZKYMRchB8a/rTrtEnw5Ms
         AvzUSRaUxDv80320R6Sx1xlTkQ/h04fk6K2/I4AHpuCZipBVY66adB/pktO2iOfhTTIb
         523A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0tGuDHpx1r9hSxAgFEblXCcRr2FfaPGPd4X3wVbygg=;
        b=OVEHru735qnOtwjpDIehGvI2hqjB8BcTSZHu69S8xJGBYEcI+DmUjlhoKwygjnkkFP
         WbIXqZeD2GhdS4tPmOr/jZNtP86G/hFrwX/+gSjnjv//qsnVKF8hJ3vwbghnEVcbDmhd
         +vXG54G871WNXASVsTWBL2DHUJRF1+U85vkjK/x93jtRDlVLG8ENgFuBDBo3qK+C6Zgu
         /idCQbAzGCP7SY9i+YzB2YsTQgrpj+YMmQhzacOqwG+Xpm5CdNd9txmEkW2I0CT9rOo5
         631om5o6v3ZvUC8kfdWt+YG8Luu/vknAuOKbxAdoEK5Gy2GX8kJR71F6LR4KHP5FczC5
         moKQ==
X-Gm-Message-State: AAQBX9fe1AyLPTk27U61O9tvhz6VGDsGfj3AuUJYpllgK0Tp3YgO12cf
        1XHwIapUb5XWpU+RTZwvUrtavVXJBtk=
X-Google-Smtp-Source: AKy350bPF6/7ntpH9Gn2y1JpqVZ3rCLWBUzmh0AGj3SV7ZRBYe+8l4DprzBykF8eY3nfBq5Naxnlng==
X-Received: by 2002:a5d:4004:0:b0:2bf:bf05:85ac with SMTP id n4-20020a5d4004000000b002bfbf0585acmr12311448wrp.23.1680025915934;
        Tue, 28 Mar 2023 10:51:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10-20020adffa8a000000b002ce3d3d17e5sm28371175wrr.79.2023.03.28.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:51:55 -0700 (PDT)
Message-Id: <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Mar 2023 17:51:46 +0000
Subject: [PATCH v3 0/8] config.c: use struct for config reading state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note to Junio: 8/8 (which renames "cs" -> "set") conflicts with
ab/config-multi-and-nonbool. I previously said that I'd rebase this, but
presumably a remerge-diff is more ergonomic + flexible (let me know if I'm
mistaken), so I'll send a remerge-diff in a reply (I don't trust GGG not to
mangle the patch :/).

After sending this out, I'll see if cocci can make it easy enough to change
config_fn_t. If so, I'll probably go with that approach for the future
'libified' patches, which should also line up nicely with what Ævar
suggested.

= Changes in v3

 * Adjust the *_push() function to be unconditional (like the *_pop()
   function)

 * Various commit message and comment cleanups

= Changes in v2

 * To reduce churn, don't rename "struct config_source cf" to "cs" early in
   the series. Instead, rename the global "cf" to "cf_global", and leave the
   existing "cf"s untouched.
   
   Introduce 8/8 to get rid of the confusing acronym "struct config_source
   cf", but I don't mind ejecting it if it's too much churn.

 * Adjust 5/8 so to pass "struct config_reader" through args instead of
   "*data". v1 made the mistake of thinking "*data" was being passed to a
   callback, but it wasn't.

 * Add a 7/8 to fix a bug in die_bad_number(). I included this because it
   overlaps a little bit with the refactor here, but I don't mind ejecting
   this either.

 * Assorted BUG() message clarifications.

= Description

This series prepares for config.[ch] to be libified as as part of the
libification effort that Emily described in [1]. One of the first goals is
to read config from a file, but the trouble with how config.c is written
today is that all reading operations rely on global state, so before turning
that into a library, we'd want to make that state non-global.

This series doesn't remove all of the global state, but it gets us closer to
that goal by extracting the global config reading state into "struct
config_reader" and plumbing it through the config reading machinery. This
makes it possible to reuse the config machinery without global state, and to
enforce some constraints on "struct config_reader", which makes it more
predictable and easier to remove in the long run.

This process is very similar to how we've plumbed "struct repository" and
other 'context objects' in the past, except:

 * The global state (named "the_reader") for the git process lives in a
   config.c static variable, and not on "the_repository". See 3/6 for the
   rationale.

 * I've stopped short of adding "struct config_reader" to config.h public
   functions, since that would affect non-config.c callers.

Additionally, I've included a bugfix for die_bad_number() that became clear
as I did this refactor.

= Leftover bits

We still need a global "the_reader" because config callbacks are reading
auxiliary information about the config (e.g. line number, file name) via
global functions (e.g. current_config_line(), current_config_name()). This
is either because the callback uses this info directly (like
builtin/config.c printing the filename and scope of the value) or for error
reporting (like git_parse_int() reporting the filename of the value it
failed to parse).

If we had a way to plumb the state from "struct config_reader" to the config
callback functions, we could initialize "struct config_reader" in the config
machinery whenever we read config (instead of asking the caller to
initialize "struct config_reader" themselves), and config reading could
become a thread-safe operation. There isn't an obvious way to plumb this
state to config callbacks without adding an additional arg to config_fn_t
and incurring a lot of churn, but if we start replacing "config_fn_t" with
the configset API (which we've independently wanted for some time), this may
become feasible.

And if we do this, "struct config_reader" itself will probably become
obsolete, because we'd be able to plumb only the relevant state for the
current operation, e.g. if we are parsing a config file, we'd pass only the
config file parsing state, instead of "struct config_reader", which also
contains config set iterating state. In such a scenario, we'd probably want
to pass "struct key_value_info" to the config callback, since that's all the
callback should be interested in anyway. Interestingly, this was proposed by
Junio back in [2], and we didn't do this back then out of concern for the
churn (just like in v1).

[1]
https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com
[2]
https://lore.kernel.org/git/CAPc5daV6bdUKS-ExHmpT4Ppy2S832NXoyPw7aOLP7fG=WrBPgg@mail.gmail.com/

Glen Choo (8):
  config.c: plumb config_source through static fns
  config.c: don't assign to "cf_global" directly
  config.c: create config_reader and the_reader
  config.c: plumb the_reader through callbacks
  config.c: remove current_config_kvi
  config.c: remove current_parsing_scope
  config: report cached filenames in die_bad_number()
  config.c: rename "struct config_source cf"

 config.c               | 584 ++++++++++++++++++++++++-----------------
 config.h               |   1 +
 t/helper/test-config.c |  17 ++
 t/t1308-config-set.sh  |   9 +
 4 files changed, 368 insertions(+), 243 deletions(-)


base-commit: dadc8e6dacb629f46aee39bde90b6f09b73722eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1463%2Fchooglen%2Fconfig%2Fstructify-reading-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1463/chooglen/config/structify-reading-v3
Pull-Request: https://github.com/git/git/pull/1463

Range-diff vs v2:

 1:  75d0f0efb79 = 1:  75d0f0efb79 config.c: plumb config_source through static fns
 2:  7555da0b0e0 ! 2:  39db7d8596a config.c: don't assign to "cf_global" directly
     @@ config.c: static struct key_value_info *current_config_kvi;
       
      +static inline void config_reader_push_source(struct config_source *top)
      +{
     -+	if (cf_global)
     -+		top->prev = cf_global;
     ++	top->prev = cf_global;
      +	cf_global = top;
      +}
      +
 3:  4347896f0a4 ! 3:  72774fd08f3 config.c: create config_reader and the_reader
     @@ config.c: static struct key_value_info *current_config_kvi;
      +static inline void config_reader_push_source(struct config_reader *reader,
      +					     struct config_source *top)
       {
     --	if (cf_global)
     --		top->prev = cf_global;
     +-	top->prev = cf_global;
      -	cf_global = top;
     -+	if (reader->source)
     -+		top->prev = reader->source;
     ++	top->prev = reader->source;
      +	reader->source = top;
      +	/* FIXME remove this when cf_global is removed. */
      +	cf_global = reader->source;
     @@ config.c: static struct key_value_info *current_config_kvi;
      -	cf_global = cf_global->prev;
      +	ret = reader->source;
      +	reader->source = reader->source->prev;
     -+	/* FIXME remove this when cf is removed. */
     ++	/* FIXME remove this when cf_global is removed. */
      +	cf_global = reader->source;
       	return ret;
       }
 4:  22b69971749 ! 4:  e02dddd560f config.c: plumb the_reader through callbacks
     @@ config.c: static struct config_reader the_reader;
       
       /*
      @@ config.c: static inline void config_reader_push_source(struct config_reader *reader,
     - 	if (reader->source)
     - 		top->prev = reader->source;
     + {
     + 	top->prev = reader->source;
       	reader->source = top;
      -	/* FIXME remove this when cf_global is removed. */
      -	cf_global = reader->source;
     @@ config.c: static inline struct config_source *config_reader_pop_source(struct co
       		BUG("tried to pop config source, but we weren't reading config");
       	ret = reader->source;
       	reader->source = reader->source->prev;
     --	/* FIXME remove this when cf is removed. */
     +-	/* FIXME remove this when cf_global is removed. */
      -	cf_global = reader->source;
       	return ret;
       }
 5:  afb6e3e318d ! 5:  c79eaf74f89 config.c: remove current_config_kvi
     @@ config.c: static enum config_scope current_parsing_scope;
       {
      +	if (reader->config_kvi)
      +		BUG("source should not be set while iterating a config set");
     - 	if (reader->source)
     - 		top->prev = reader->source;
     + 	top->prev = reader->source;
       	reader->source = top;
     + }
      @@ config.c: static inline struct config_source *config_reader_pop_source(struct config_reade
       	return ret;
       }
 6:  a57e35163ae = 6:  05d9ffa21f6 config.c: remove current_parsing_scope
 7:  3c83d9535a0 ! 7:  eb843e6f08d config: report cached filenames in die_bad_number()
     @@ Commit message
      
          Fix this by refactoring the current_config_* functions into variants
          that don't BUG() when we aren't reading config, and using the resulting
     -    functions in die_bad_number(). Refactoring is needed because "git config
     -    --get[-regexp] --type=int" parses the int value _after_ parsing the
     -    config file, which will run into the BUG().
     +    functions in die_bad_number(). "git config --get[-regexp] --type=int"
     +    cannot use the non-refactored version because it parses the int value
     +    _after_ parsing the config file, which would run into the BUG().
      
     -    Also, plumb "struct config_reader" into the new functions. This isn't
     -    necessary per se, but this generalizes better, so it might help us avoid
     -    yet another refactor.
     +    Since the refactored functions aren't public, they use "struct
     +    config_reader".
      
          1. https://lore.kernel.org/git/20160518223712.GA18317@sigill.intra.peff.net/
      
 8:  9aec9092fdf = 8:  ab800aa104c config.c: rename "struct config_source cf"

-- 
gitgitgadget
