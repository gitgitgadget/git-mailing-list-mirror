Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D732FC11D30
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB8C20836
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn9sdG3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgBXPNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:13:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39475 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgBXPNY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 10:13:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id m13so12276374edb.6
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 07:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LLyk+HZ83CjWfHAlXnXjz9l6EnJHsJiIPVTnS791VQg=;
        b=Zn9sdG3A+UhV8aORL54HMCsZq33U4vy1VCphl8uUdypTeh2TVWTCSHswha32VnJz0s
         2Xwl+Mq8vIhsQ1Xlwrg7K4o5n9x/+7G4nL4+PfJvmGwqfsD43aTP83Ea88wGn60ThQfq
         bdUab2EQaxy5RED2lWdgzOZ9qnAybSu8F68aJaDmujQ2FnOcaKKmicQG25ehPa6tZkX7
         YdAb4jcFFqSEyW6RwYBrbxl5v4emYTPbZvwZ9aODZVHEMgs36qHCMfmQvjq9pMKHPtY7
         TZu8ZlaUMVrHHj5Nf9VIFanlon4H7eDsfnvU85bIigTB2JsEasAtmUI4dlKSxOeeaNp8
         Vwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LLyk+HZ83CjWfHAlXnXjz9l6EnJHsJiIPVTnS791VQg=;
        b=qHXBghWnDM17PUCizQH/m8i4WDYOPiJDKSL2dD4pJuaS0l+mhQXy8w9K+NIn7TR09l
         +SIcLLI8QQv0rx2i6wcWvlLO146BtzmIjun+Aex8h6j6yhPwbi5lMaotLA7CHC2rVf+1
         bGUR3O/tThWUwwjUJl26iYjABy4yDKC11MmX8D/w8QOxLI6R6unxhvXOHbPd4HM7fA/7
         xTZwowF0h0G4wPSl4COnDF9LFVVhxlMHxlaFNmOVel0EiZ2njeOtD/804QSFdfSRBHaE
         GEFM68XJETS6jS32bsG7vyZ+hSrN6AljXeECrpk5TWoA87x4Em9qnvY7oA5F9386oRqJ
         cLOA==
X-Gm-Message-State: APjAAAXgdG5k/gYH4J25o49ReCUc+5EgbDY/eZK9UJDSVZwZKb2/UYW+
        HsjrX7NUmdSGosLle64Po9TTmr1e
X-Google-Smtp-Source: APXvYqwA6K2OiFCJhmSSvJ4kYg4lToCbTjvGxBkcqDXA6sN3vZfRx5c0XM5r1NiXEXJPeWExaRijNA==
X-Received: by 2002:a17:907:1059:: with SMTP id oy25mr45865354ejb.142.1582557200867;
        Mon, 24 Feb 2020 07:13:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16sm961695edr.83.2020.02.24.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:13:19 -0800 (PST)
Message-Id: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Feb 2020 15:13:15 +0000
Subject: [PATCH v4 0/3] [Outreachy] advice: revamp advise API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Main changes in V4:

 * Re-order the commits.
 * Free the output after using xstrfmt().


----------------------------------------------------------------------------

Changes in V3:

 * Remove the new wrapper advice_push_update_rejected_enabled() (which was
   added in V2 to handle a special case of having a config variable alias),
   and replace it by adding switch cases to advice_enabled() (The reason
   behind this change is that another special case came up while I was
   migrating the rest of the advise calls to the new APIs.)
 * Remove trailing whitespaces.


----------------------------------------------------------------------------

Main changes in V2:

 * Rename advise_ng to advise_if_enabled.
 * Add a new advise_enabled() helper.
 * Add a list of config variables names to replace advice_config[] (used by
   list_config_advices()).
 * Send an enum parameter to the new advise helpers instead of strings.
 * Extract vadvise() from advise() and advise_if enabled().


----------------------------------------------------------------------------

The advice API is currently a little bit confusing to call. quoting from
[1]:

When introducing a new advice message, you would

 * come up with advice.frotz configuration variable

 * define and declare advice_frotz global variable that defaults to
   true

 * sprinkle calls like this:

  if (advice_frotz)
    advise(_("helpful message about frotz"));

A new approach was suggested in [1] which this patch is based upon.

A new advise_if_enabled() is introduced to gradually replace advise()
advice_enabled() helper is also introduced to be used by those callers who:

 * Only need to check the visibility without calling advise() (they call
   die() or error() instead for example)
 * Need to carry out some heavy processing to display an advice, in this
   case they'll do: if(advice_enabled(advice_type))  advise("some advice message");
   
   

To introduce a new advice message, the caller needs to:

 * Add a new_advice_type to 'enum advice_type'
 * Come up with a new config variable name and add this name to 
   advice_config_keys[]
 * Call advise_if_enabled(new_advice_type, "advice message to be printed")
 * Or call advice_enabled(new_advice_type) first and then follow is by
   advice("advice message to be printed") as explained earlier.
 * Add the new config variable to Documentation/config/advice.txt

The reason a new list of configuration variables was added to the library is
to be used by the list_config_advices() function instead of advice_config[].
And we should get rid of advice_config[] once we migrate all the callers to
use the new APIs instead of checking the global variables (which we'll get
rid of as well).

In the future, we can investigate generating the documentation from the list
of config variables or vice versa to make introducing a new advice much
easier, but this approach will do it for now.

V2 makes the process of introducing a new advice longer than V1 and almost
as long as the original library, but having the advice library responsible
for checking the message visibility is still an improvement and in my own
opinion the new structure makes better sense and makes the library less
confusing to use.

After this patch the plan is to change the advise() calls to
advise_if_enabled() whenever possible, or at least replace the global
variables checks by advise_enabled() when advise_if_enabled() is not
suitable.

[1] https://public-inbox.org/git/xmqqzhf5cw69.fsf@gitster-ct.c.googlers.com/

Heba Waly (3):
  advice: extract vadvise() from advise()
  advice: revamp advise API
  tag: use new advice API to check visibility

 Makefile               |  1 +
 advice.c               | 95 ++++++++++++++++++++++++++++++++++++++----
 advice.h               | 53 ++++++++++++++++++++++-
 builtin/tag.c          |  5 ++-
 t/helper/test-advise.c | 19 +++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0018-advice.sh      | 28 +++++++++++++
 t/t7004-tag.sh         |  1 +
 9 files changed, 193 insertions(+), 11 deletions(-)
 create mode 100644 t/helper/test-advise.c
 create mode 100755 t/t0018-advice.sh


base-commit: c7a62075917b3340f908093f63f1161c44ed1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-548%2FHebaWaly%2Fadvice_refactoring-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-548/HebaWaly/advice_refactoring-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/548

Range-diff vs v3:

 2:  a2a145c705e ! 1:  f668d9b7ca0 advice: extract vadvise() from advise()
     @@ -2,9 +2,9 @@
      
          advice: extract vadvise() from advise()
      
     -    extract a version of advise() that uses an explict 'va_list' parameter.
     -    Call it from advise() and advise_if_enabled() for a functionally
     -    equivalent version.
     +    In preparation for a new advice method, extract a version of advise()
     +    that uses an explict 'va_list' parameter. Call it from advise() for a
     +    functionally equivalent version.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
     @@ -13,16 +13,11 @@
       --- a/advice.c
       +++ b/advice.c
      @@
     - 	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie"
     + 	{ "pushNonFastForward", &advice_push_update_rejected }
       };
       
      -void advise(const char *advice, ...)
     -+static const char turn_off_instructions[] =
     -+N_("\n"
     -+   "Disable this message with \"git config %s false\"");
     -+
     -+static void vadvise(const char *advice, va_list params,
     -+		    int display_instructions, char *key)
     ++static void vadvise(const char *advice, va_list params)
       {
       	struct strbuf buf = STRBUF_INIT;
      -	va_list params;
     @@ -31,57 +26,21 @@
      -	va_start(params, advice);
       	strbuf_vaddf(&buf, advice, params);
      -	va_end(params);
     -+
     -+	if(display_instructions)
     -+		strbuf_addf(&buf, turn_off_instructions, key);
       
       	for (cp = buf.buf; *cp; cp = np) {
       		np = strchrnul(cp, '\n');
      @@
     - 	}
     + 	strbuf_release(&buf);
       }
       
     --static const char turn_off_instructions[] =
     --N_("\n"
     --   "Disable this message with \"git config %s false\"");
      +void advise(const char *advice, ...)
      +{
      +	va_list params;
      +	va_start(params, advice);
     -+	vadvise(advice, params, 0, "");
     ++	vadvise(advice, params);
      +	va_end(params);
      +}
     - 
     - void advise_if_enabled(enum advice_type type, const char *advice, ...)
     - {
     --	struct strbuf buf = STRBUF_INIT;
     --	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
     - 	va_list params;
     --	const char *cp, *np;
     --	
     -+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
      +
     - 	if(!advice_enabled(type))
     - 		return;
     - 
     - 	va_start(params, advice);
     --	strbuf_vaddf(&buf, advice, params);
     -+	vadvise(advice, params, 1, key);
     - 	va_end(params);
     --
     --	strbuf_addf(&buf, turn_off_instructions, key);
     --	
     --	for (cp = buf.buf; *cp; cp = np) {
     --		np = strchrnul(cp, '\n');
     --		fprintf(stderr,	_("%shint: %.*s%s\n"),
     --			advise_get_color(ADVICE_COLOR_HINT),
     --			(int)(np - cp), cp,
     --			advise_get_color(ADVICE_COLOR_RESET));
     --		if (*np)
     --			np++;
     --	}
     --	strbuf_release(&buf);
     --
     - }
     - 
       int git_default_advice_config(const char *var, const char *value)
     + {
     + 	const char *k, *slot_name;
 1:  4ab141426f3 ! 2:  04c3e5760f6 advice: revamp advise API
     @@ -40,24 +40,10 @@
       --- a/advice.c
       +++ b/advice.c
      @@
     - int advice_waiting_for_editor = 1;
     - int advice_graft_file_deprecated = 1;
     - int advice_checkout_ambiguous_remote_branch_name = 1;
     --int advice_nested_tag = 1;
     - int advice_submodule_alternate_error_strategy_die = 1;
     - 
     - static int advice_use_color = -1;
     -@@
     - 	{ "waitingForEditor", &advice_waiting_for_editor },
     - 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
     - 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
     --	{ "nestedTag", &advice_nested_tag },
     - 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
     - 
     - 	/* make this an alias for backward compatibility */
       	{ "pushNonFastForward", &advice_push_update_rejected }
       };
       
     +-static void vadvise(const char *advice, va_list params)
      +static const char *advice_config_keys[] = {
      +	[FETCH_SHOW_FORCED_UPDATES]		 = "fetchShowForcedUpdates",
      +	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
     @@ -92,18 +78,39 @@
      +	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie"
      +};
      +
     - void advise(const char *advice, ...)
     ++static const char turn_off_instructions[] =
     ++N_("\n"
     ++   "Disable this message with \"git config %s false\"");
     ++
     ++static void vadvise(const char *advice, va_list params,
     ++		    int display_instructions, char *key)
       {
       	struct strbuf buf = STRBUF_INIT;
     -@@
     - 	strbuf_release(&buf);
     - }
     + 	const char *cp, *np;
       
     + 	strbuf_vaddf(&buf, advice, params);
     + 
     ++	if(display_instructions)
     ++		strbuf_addf(&buf, turn_off_instructions, key);
     ++
     + 	for (cp = buf.buf; *cp; cp = np) {
     + 		np = strchrnul(cp, '\n');
     + 		fprintf(stderr,	_("%shint: %.*s%s\n"),
     +@@
     + {
     + 	va_list params;
     + 	va_start(params, advice);
     +-	vadvise(advice, params);
     ++	vadvise(advice, params, 0, "");
     ++	va_end(params);
     ++}
     ++
      +static int get_config_value(enum advice_type type)
      +{
      +	int value = 1;
      +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
      +	git_config_get_bool(key, &value);
     ++	free(key);
      +	return value;
      +}
      +
     @@ -118,42 +125,21 @@
      +	}
      +}
      +
     -+static const char turn_off_instructions[] =
     -+N_("\n"
     -+   "Disable this message with \"git config %s false\"");
     -+
      +void advise_if_enabled(enum advice_type type, const char *advice, ...)
      +{
     -+	struct strbuf buf = STRBUF_INIT;
      +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
      +	va_list params;
     -+	const char *cp, *np;
     -+	
     ++
      +	if(!advice_enabled(type))
      +		return;
      +
      +	va_start(params, advice);
     -+	strbuf_vaddf(&buf, advice, params);
     -+	va_end(params);
     -+
     -+	strbuf_addf(&buf, turn_off_instructions, key);
     -+	
     -+	for (cp = buf.buf; *cp; cp = np) {
     -+		np = strchrnul(cp, '\n');
     -+		fprintf(stderr,	_("%shint: %.*s%s\n"),
     -+			advise_get_color(ADVICE_COLOR_HINT),
     -+			(int)(np - cp), cp,
     -+			advise_get_color(ADVICE_COLOR_RESET));
     -+		if (*np)
     -+			np++;
     -+	}
     -+	strbuf_release(&buf);
     -+
     -+}
     -+
     ++	vadvise(advice, params, 1, key);
     + 	va_end(params);
     ++	free(key);
     + }
     + 
       int git_default_advice_config(const char *var, const char *value)
     - {
     - 	const char *k, *slot_name;
      @@
       {
       	int i;
     @@ -170,10 +156,7 @@
       --- a/advice.h
       +++ b/advice.h
      @@
     - extern int advice_waiting_for_editor;
     - extern int advice_graft_file_deprecated;
     - extern int advice_checkout_ambiguous_remote_branch_name;
     --extern int advice_nested_tag;
     + extern int advice_nested_tag;
       extern int advice_submodule_alternate_error_strategy_die;
       
      +/**
     @@ -235,21 +218,6 @@
       void NORETURN die_resolve_conflict(const char *me);
       void NORETURN die_conclude_merge(void);
      
     - diff --git a/builtin/tag.c b/builtin/tag.c
     - --- a/builtin/tag.c
     - +++ b/builtin/tag.c
     -@@
     - 	if (type <= OBJ_NONE)
     - 		die(_("bad object type."));
     - 
     --	if (type == OBJ_TAG && advice_nested_tag)
     --		advise(_(message_advice_nested_tag), tag, object_ref);
     -+	if (type == OBJ_TAG)
     -+		advise_if_enabled(NESTED_TAG, _(message_advice_nested_tag), tag, object_ref);
     - 
     - 	strbuf_addf(&header,
     - 		    "object %s\n"
     -
       diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
       new file mode 100644
       --- /dev/null
     @@ -266,7 +234,10 @@
      +
      +	setup_git_directory();
      +
     -+	//use any advice type for testing
     ++	/*
     ++	  Any advice type can be used for testing, but NESTED_TAG was selected
     ++	  here and in t0018 where this command is being executed.
     ++	 */
      +	advise_if_enabled(NESTED_TAG, argv[1]);
      +
      +	return 0;
     @@ -329,15 +300,3 @@
      +'
      +
      +test_done
     -
     - diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
     - --- a/t/t7004-tag.sh
     - +++ b/t/t7004-tag.sh
     -@@
     - 	hint: already a tag. If you meant to tag the object that it points to, use:
     - 	hint: |
     - 	hint: 	git tag -f nested annotated-v4.0^{}
     -+	hint: Disable this message with "git config advice.nestedTag false"
     - 	EOF
     - 	git tag -m nested nested annotated-v4.0 2>actual &&
     - 	test_i18ncmp expect actual
 -:  ----------- > 3:  3cc0a17123d tag: use new advice API to check visibility

-- 
gitgitgadget
