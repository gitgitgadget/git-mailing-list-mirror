Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AE0C3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 20:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E30721739
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 20:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6DJlfCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCBUCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:02:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51366 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBUCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 15:02:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id a132so439714wme.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 12:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V9tqEuvkoIkuRYaoIRDKP8/XGhiI2FJPKJOvC2rg5eg=;
        b=A6DJlfCzhhJUW5Fen0BVwhBoxxoKB1cTikIsnADA1qnLV0Mw/JyOe62yK+Y8k5X/FY
         KNzNR2GOPV9qzl6SE3IQmtsE1UpTGL+SySwqHYsP9chCvmGbj/CjcHhRu4dXQ4HIbdre
         HlWrdHti4ZM1IN7/tfmfwNx9A7q5hqAwMDUZKODD2xpwsPjxflzyVxzDw90r+4K0SQ4n
         Y+9rZu2sdGlAjkkeCtLTkvfoTRxU9zOGO37Xp6aXZtbEa5bMxw96bo7OT4C5da9UdY0l
         Vejozb+mCAHPUoU1r4qsFVyA7v/KnkEbM6H4e/bAmrgtV6nqgJSHGg0nvZ1e6CPlPSkT
         W8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V9tqEuvkoIkuRYaoIRDKP8/XGhiI2FJPKJOvC2rg5eg=;
        b=gYBOkIeANmpBEYTv3AKvl2ydq1yhXmCFrHcUEE7KF3rqTFr2yNANNV/tv0WKa4sDRf
         ayRtNidVDWeZn1loGrg5BMVivds118EwKf+mkEPT2RtWChGQfsadfloos7VaqbegUAt3
         fPg17RuGVImaMgWKQy8BbJ5K93MKQ7gf9244x0bA0pVaSA72FXrOGqeiv1c9+dPx6c3K
         oVc2vviAn1lOmMWJMxLK3uA0lBs63uTEPCpmPRL599OOPbj53kTH8eWlk36/jZZW2R2Q
         7Gt6Whwcww0oaniNXB+1jzrXzr3hbkOlOxdUYlWxTMP78uyfw4JhTGIDpD3PrDJjY2ZW
         M2NQ==
X-Gm-Message-State: ANhLgQ0gEG6SzKWOPH1xkfa+q8VJHj6fQCUS7SMeToswkgFYYTHd/IuL
        7aV17gUNIbVbbAylF8cyX1+MmrSw
X-Google-Smtp-Source: ADFU+vsOIruEp03osLSnGcRwMGluQQR32H31gpheISWdoJ1Vn/o3RSwh+k/k31/btAkEUe0KVODhgw==
X-Received: by 2002:a1c:2048:: with SMTP id g69mr77415wmg.187.1583179321994;
        Mon, 02 Mar 2020 12:02:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm149785wme.36.2020.03.02.12.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:02:01 -0800 (PST)
Message-Id: <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
References: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Mar 2020 20:01:56 +0000
Subject: [PATCH v7 0/4] [Outreachy] advice: revamp advise API
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

V7:

 * Back to the enum approach.
 * Cache enabled values in advice_setting array.
 * Although an approach was suggested to get rid of the switch case in
   advice_enabled(), it is kept because it'll be needed when handling other
   special cases e.g: ADVICE_ GRAFT_FILE_DEPRECATED.


----------------------------------------------------------------------------

In V6:

 * Replace the enum approach by const char arrays.
 * Fix camelCase name for one of the config variables.


----------------------------------------------------------------------------

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

 * Define a new advice_type enum.
 * Come up with a new config variable name and add this name to 
   advice_setting[]
 * Call advise_if_enabled(new_advice_type, "advice message to be printed")
 * Or call advice_enabled(new_advice_type) first and then follow it by
   advise("advice message to be printed") as explained earlier.
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

Heba Waly (4):
  advice: extract vadvise() from advise()
  advice: change "setupStreamFailure" to "setUpstreamFailure"
  advice: revamp advise API
  tag: use new advice API to check visibility

 Makefile               |  1 +
 advice.c               | 97 ++++++++++++++++++++++++++++++++++++++----
 advice.h               | 52 +++++++++++++++++++++-
 builtin/tag.c          |  5 ++-
 t/helper/test-advise.c | 21 +++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0018-advice.sh      | 32 ++++++++++++++
 t/t7004-tag.sh         |  1 +
 9 files changed, 199 insertions(+), 12 deletions(-)
 create mode 100644 t/helper/test-advise.c
 create mode 100755 t/t0018-advice.sh


base-commit: c7a62075917b3340f908093f63f1161c44ed1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-548%2FHebaWaly%2Fadvice_refactoring-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-548/HebaWaly/advice_refactoring-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/548

Range-diff vs v6:

 1:  f668d9b7ca0 = 1:  f668d9b7ca0 advice: extract vadvise() from advise()
 2:  828b4aee19d = 2:  828b4aee19d advice: change "setupStreamFailure" to "setUpstreamFailure"
 3:  176e38a841d ! 3:  a4673803eaf advice: revamp advise API
     @@ -13,10 +13,9 @@
          if the caller needs to carry out complicated processing based on that
          value.
      
     -    A list of config variables 'advice_config_keys' is added to be used by
     -    list_config_advices() instead of 'advice_config[]' because we'll get
     -    rid of 'advice_config[]' and the global variables once we migrate all
     -    the callers to use the new APIs.
     +    A list of advice_settings is added to cache the config variables names
     +    and values, it's intended to replace advice_config[] and the global
     +    variables once we migrate all the callers to use the new APIs.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
     @@ -35,87 +34,52 @@
       diff --git a/advice.c b/advice.c
       --- a/advice.c
       +++ b/advice.c
     -@@
     - int advice_nested_tag = 1;
     - int advice_submodule_alternate_error_strategy_die = 1;
     - 
     -+const char ADVICE_ADD_EMBEDDED_REPO[] = "advice.addEmbeddedRepo";
     -+const char ADVICE_AM_WORK_DIR[] = "advice.amWorkDir";
     -+const char ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME[] = "advice.checkoutAmbiguousRemoteBranchName";
     -+const char ADVICE_COMMIT_BEFORE_MERGE[] = "advice.commitBeforeMerge";
     -+const char ADVICE_DETACHED_HEAD[] = "advice.detachedHead";
     -+const char ADVICE_FETCH_SHOW_FORCED_UPDATES[] = "advice.fetchShowForcedUpdates";
     -+const char ADVICE_GRAFT_FILE_DEPRECATED[] = "advice.graftFileDeprecated";
     -+const char ADVICE_IGNORED_HOOK[] = "advice.ignoredHook";
     -+const char ADVICE_IMPLICIT_IDENTITY[] = "advice.implicitIdentity";
     -+const char ADVICE_NESTED_TAG[] = "advice.nestedTag";
     -+const char ADVICE_OBJECT_NAME_WARNING[] = "advice.objectNameWarning";
     -+const char ADVICE_PUSH_ALREADY_EXISTS[] = "advice.pushAlreadyExists";
     -+const char ADVICE_PUSH_FETCH_FIRST[] = "advice.pushFetchFirst";
     -+const char ADVICE_PUSH_NEEDS_FORCE[] = "advice.pushNeedsForce";
     -+const char ADVICE_PUSH_NON_FF_CURRENT[] = "advice.pushNonFFCurrent";
     -+const char ADVICE_PUSH_NON_FF_MATCHING[] = "advice.pushNonFFMatching";
     -+const char ADVICE_PUSH_UNQUALIFIED_REF_NAME[] = "advice.pushUnqualifiedRefName";
     -+const char ADVICE_PUSH_UPDATE_REJECTED[] = "advice.pushUpdateRejected";
     -+
     -+/* make this an alias for backward compatibility */
     -+const char ADVICE_PUSH_UPDATE_REJECTED_ALIAS[] = "advice.pushNonFastForward";
     -+
     -+const char ADVICE_RESET_QUIET_WARNING[] = "advice.resetQuiet";
     -+const char ADVICE_RESOLVE_CONFLICT[] = "advice.resolveConflict";
     -+const char ADVICE_RM_HINTS[] = "advice.rmHints";
     -+const char ADVICE_SEQUENCER_IN_USE[] = "advice.sequencerInUse";
     -+const char ADVICE_SET_UPSTREAM_FAILURE[] = "advice.setUpstreamFailure";
     -+const char ADVICE_STATUS_AHEAD_BEHIND_WARNING[] = "advice.statusAheadBehindWarning";
     -+const char ADVICE_STATUS_HINTS[] = "advice.statusHints";
     -+const char ADVICE_STATUS_U_OPTION[] = "advice.statusUoption";
     -+const char ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE[] = "advice.submoduleAlternateErrorStrategyDie";
     -+const char ADVICE_WAITING_FOR_EDITOR[] = "advice.waitingForEditor";
     -+
     -+
     - static int advice_use_color = -1;
     - static char advice_colors[][COLOR_MAXLEN] = {
     - 	GIT_COLOR_RESET,
      @@
       	{ "pushNonFastForward", &advice_push_update_rejected }
       };
       
      -static void vadvise(const char *advice, va_list params)
     -+static const char *advice_config_keys[] = {
     -+	ADVICE_ADD_EMBEDDED_REPO,
     -+	ADVICE_AM_WORK_DIR,
     -+	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
     -+	ADVICE_COMMIT_BEFORE_MERGE,
     -+	ADVICE_DETACHED_HEAD,
     -+	ADVICE_FETCH_SHOW_FORCED_UPDATES,
     -+	ADVICE_GRAFT_FILE_DEPRECATED,
     -+	ADVICE_IGNORED_HOOK,
     -+	ADVICE_IMPLICIT_IDENTITY,
     -+	ADVICE_NESTED_TAG,
     -+	ADVICE_OBJECT_NAME_WARNING,
     -+	ADVICE_PUSH_ALREADY_EXISTS,
     -+	ADVICE_PUSH_FETCH_FIRST,
     -+	ADVICE_PUSH_NEEDS_FORCE,
     -+	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
     -+	ADVICE_PUSH_NON_FF_CURRENT,
     -+	ADVICE_PUSH_NON_FF_MATCHING,
     -+	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
     -+	ADVICE_PUSH_UPDATE_REJECTED,
     -+	ADVICE_RESET_QUIET_WARNING,
     -+	ADVICE_RESOLVE_CONFLICT,
     -+	ADVICE_RM_HINTS,
     -+	ADVICE_SEQUENCER_IN_USE,
     -+	ADVICE_SET_UPSTREAM_FAILURE,
     -+	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
     -+	ADVICE_STATUS_HINTS,
     -+	ADVICE_STATUS_U_OPTION,
     -+	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
     -+	ADVICE_WAITING_FOR_EDITOR,
     ++static struct {
     ++	const char *key;
     ++	int enabled;
     ++} advice_setting[] = {
     ++	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
     ++	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
     ++	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
     ++	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
     ++	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
     ++	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
     ++	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
     ++	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
     ++	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity", 1 },
     ++	[ADVICE_NESTED_TAG]				= { "nestedTag", 1 },
     ++	[ADVICE_OBJECT_NAME_WARNING]			= { "objectNameWarning", 1 },
     ++	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists", 1 },
     ++	[ADVICE_PUSH_FETCH_FIRST]			= { "pushFetchFirst", 1 },
     ++	[ADVICE_PUSH_NEEDS_FORCE]			= { "pushNeedsForce", 1 },
     ++
     ++	/* make this an alias for backward compatibility */
     ++	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward", 1 },
     ++
     ++	[ADVICE_PUSH_NON_FF_CURRENT]			= { "pushNonFFCurrent", 1 },
     ++	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching", 1 },
     ++	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName", 1 },
     ++	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected", 1 },
     ++	[ADVICE_RESET_QUIET_WARNING]			= { "resetQuiet", 1 },
     ++	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict", 1 },
     ++	[ADVICE_RM_HINTS]				= { "rmHints", 1 },
     ++	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse", 1 },
     ++	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure", 1 },
     ++	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning", 1 },
     ++	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
     ++	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
     ++	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
     ++	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
      +};
      +
      +static const char turn_off_instructions[] =
      +N_("\n"
     -+   "Disable this message with \"git config %s false\"");
     ++   "Disable this message with \"git config advice.%s false\"");
      +
      +static void vadvise(const char *advice, int display_instructions,
      +		    const char *key, va_list params)
     @@ -140,43 +104,51 @@
      +	va_end(params);
      +}
      +
     -+static int get_config_value(const char *advice_key)
     ++int advice_enabled(enum advice_type type)
      +{
     -+	int value = 1;
     -+
     -+	git_config_get_bool(advice_key, &value);
     -+	return value;
     ++	switch(type) {
     ++	case ADVICE_PUSH_UPDATE_REJECTED:
     ++		return advice_setting[ADVICE_PUSH_UPDATE_REJECTED].enabled &&
     ++		       advice_setting[ADVICE_PUSH_UPDATE_REJECTED_ALIAS].enabled;
     ++	default:
     ++		return advice_setting[type].enabled;
     ++	}
      +}
      +
     -+int advice_enabled(const char *advice_key)
     -+{
     -+	if (advice_key == ADVICE_PUSH_UPDATE_REJECTED)
     -+		return get_config_value(ADVICE_PUSH_UPDATE_REJECTED) &&
     -+		       get_config_value(ADVICE_PUSH_UPDATE_REJECTED_ALIAS);
     -+	else
     -+		return get_config_value(advice_key);
     -+}
     -+
     -+void advise_if_enabled(const char *advice_key, const char *advice, ...)
     ++void advise_if_enabled(enum advice_type type, const char *advice, ...)
      +{
      +	va_list params;
      +
     -+	if (!advice_enabled(advice_key))
     ++	if (!advice_enabled(type))
      +		return;
      +
      +	va_start(params, advice);
     -+	vadvise(advice, 1, advice_key, params);
     ++	vadvise(advice, 1, advice_setting[type].key, params);
       	va_end(params);
       }
       
     +@@
     + 		if (strcasecmp(k, advice_config[i].name))
     + 			continue;
     + 		*advice_config[i].preference = git_config_bool(var, value);
     ++		break;
     ++	}
     ++
     ++	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
     ++		if (strcasecmp(k, advice_setting[i].key))
     ++			continue;
     ++		advice_setting[i].enabled = git_config_bool(var, value);
     + 		return 0;
     + 	}
     + 
      @@
       {
       	int i;
       
      -	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
      -		list_config_item(list, prefix, advice_config[i].name);
     -+	for (i = 0; i < ARRAY_SIZE(advice_config_keys); i++)
     -+		list_config_item(list, prefix, advice_config_keys[i]);
     ++	for (i = 0; i < ARRAY_SIZE(advice_setting); i++)
     ++		list_config_item(list, prefix, advice_setting[i].key);
       }
       
       int error_resolve_conflict(const char *me)
     @@ -190,40 +162,42 @@
       
      +/*
      + * To add a new advice, you need to:
     -+ * Define a new const char array.
     -+ * Add a new entry to advice_config_keys list.
     ++ * Define a new advice_type.
     ++ * Add a new entry to advice_setting array.
      + * Add the new config variable to Documentation/config/advice.txt.
      + * Call advise_if_enabled to print your advice.
      + */
     -+extern const char ADVICE_ADD_EMBEDDED_REPO[];
     -+extern const char ADVICE_AM_WORK_DIR[];
     -+extern const char ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME[];
     -+extern const char ADVICE_COMMIT_BEFORE_MERGE[];
     -+extern const char ADVICE_DETACHED_HEAD[];
     -+extern const char ADVICE_FETCH_SHOW_FORCED_UPDATES[];
     -+extern const char ADVICE_GRAFT_FILE_DEPRECATED[];
     -+extern const char ADVICE_IGNORED_HOOK[];
     -+extern const char ADVICE_IMPLICIT_IDENTITY[];
     -+extern const char ADVICE_NESTED_TAG[];
     -+extern const char ADVICE_OBJECT_NAME_WARNING[];
     -+extern const char ADVICE_PUSH_ALREADY_EXISTS[];
     -+extern const char ADVICE_PUSH_FETCH_FIRST[];
     -+extern const char ADVICE_PUSH_NEEDS_FORCE[];
     -+extern const char ADVICE_PUSH_NON_FF_CURRENT[];
     -+extern const char ADVICE_PUSH_NON_FF_MATCHING[];
     -+extern const char ADVICE_PUSH_UNQUALIFIED_REF_NAME[];
     -+extern const char ADVICE_PUSH_UPDATE_REJECTED_ALIAS[];
     -+extern const char ADVICE_PUSH_UPDATE_REJECTED[];
     -+extern const char ADVICE_RESET_QUIET_WARNING[];
     -+extern const char ADVICE_RESOLVE_CONFLICT[];
     -+extern const char ADVICE_RM_HINTS[];
     -+extern const char ADVICE_SEQUENCER_IN_USE[];
     -+extern const char ADVICE_SET_UPSTREAM_FAILURE[];
     -+extern const char ADVICE_STATUS_AHEAD_BEHIND_WARNING[];
     -+extern const char ADVICE_STATUS_HINTS[];
     -+extern const char ADVICE_STATUS_U_OPTION[];
     -+extern const char ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE[];
     -+extern const char ADVICE_WAITING_FOR_EDITOR[];
     ++ enum advice_type {
     ++	ADVICE_ADD_EMBEDDED_REPO,
     ++	ADVICE_AM_WORK_DIR,
     ++	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
     ++	ADVICE_COMMIT_BEFORE_MERGE,
     ++	ADVICE_DETACHED_HEAD,
     ++	ADVICE_FETCH_SHOW_FORCED_UPDATES,
     ++	ADVICE_GRAFT_FILE_DEPRECATED,
     ++	ADVICE_IGNORED_HOOK,
     ++	ADVICE_IMPLICIT_IDENTITY,
     ++	ADVICE_NESTED_TAG,
     ++	ADVICE_OBJECT_NAME_WARNING,
     ++	ADVICE_PUSH_ALREADY_EXISTS,
     ++	ADVICE_PUSH_FETCH_FIRST,
     ++	ADVICE_PUSH_NEEDS_FORCE,
     ++	ADVICE_PUSH_NON_FF_CURRENT,
     ++	ADVICE_PUSH_NON_FF_MATCHING,
     ++	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
     ++	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
     ++	ADVICE_PUSH_UPDATE_REJECTED,
     ++	ADVICE_RESET_QUIET_WARNING,
     ++	ADVICE_RESOLVE_CONFLICT,
     ++	ADVICE_RM_HINTS,
     ++	ADVICE_SEQUENCER_IN_USE,
     ++	ADVICE_SET_UPSTREAM_FAILURE,
     ++	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
     ++	ADVICE_STATUS_HINTS,
     ++	ADVICE_STATUS_U_OPTION,
     ++	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
     ++	ADVICE_WAITING_FOR_EDITOR,
     ++};
      +
       int git_default_advice_config(const char *var, const char *value);
       __attribute__((format (printf, 1, 2)))
     @@ -233,12 +207,12 @@
      + * Checks if advice type is enabled (can be printed to the user).
      + * Should be called before advise().
      + */
     -+int advice_enabled(const char *advice_key);
     ++int advice_enabled(enum advice_type type);
      +
      +/**
      + * Checks the visibility of the advice before printing.
      + */
     -+void advise_if_enabled(const char *advice_key, const char *advice, ...);
     ++void advise_if_enabled(enum advice_type type, const char *advice, ...);
      +
       int error_resolve_conflict(const char *me);
       void NORETURN die_resolve_conflict(const char *me);
     @@ -252,6 +226,7 @@
      +#include "test-tool.h"
      +#include "cache.h"
      +#include "advice.h"
     ++#include "config.h"
      +
      +int cmd__advise_if_enabled(int argc, const char **argv)
      +{
     @@ -259,6 +234,7 @@
      +	die("usage: %s <advice>", argv[0]);
      +
      +	setup_git_directory();
     ++	git_config(git_default_config, NULL);
      +
      +	/*
      +	  Any advice type can be used for testing, but NESTED_TAG was selected
 4:  2dee0abd452 ! 4:  3e213cb59b7 tag: use new advice API to check visibility
     @@ -18,7 +18,7 @@
      -int advice_nested_tag = 1;
       int advice_submodule_alternate_error_strategy_die = 1;
       
     - const char ADVICE_ADD_EMBEDDED_REPO[] = "advice.addEmbeddedRepo";
     + static int advice_use_color = -1;
      @@
       	{ "waitingForEditor", &advice_waiting_for_editor },
       	{ "graftFileDeprecated", &advice_graft_file_deprecated },

-- 
gitgitgadget
