Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B88AC4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 04:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE1624650
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 04:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jflURlrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgB0EfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:35:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35960 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbgB0EfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 23:35:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so1844715wma.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 20:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h8jez2YpBFSY2NDRWBYsDPtHtoLRE/Nj37crYAm4hHU=;
        b=jflURlrlJDfmUIhaafAIaAUSUotGuqaWZexObduBGHaXEFqyqShEUQGzv7W5ty7joe
         jF52XghPIvYdHb6+/vSPKDSbQtMkOKR5tWdqk8dctrRE3YVLmP1pnrR6chZO3pFcvLIc
         TP0AVbYKWBuQOC6vhYCZKXY4Xfj//ZO1JFCTVSLYIQVwp/cB7wzNPbchJ/JpVQycAc4a
         8mmriYepGGm8Tcf4d0+lNoHVRvtzYfNnKx5YlWJt7debq6YNzpiB4pLJ521xnJs61qqZ
         pzGuOE1bMPhIvkDplUjw4N18qr2g2ts4LLmXU9DFCA/74Z9zQZWnZieUl0dO7zk8Gy46
         +ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h8jez2YpBFSY2NDRWBYsDPtHtoLRE/Nj37crYAm4hHU=;
        b=jsz60k1SGZkHkgcbkNQQGFbSBA8dkOadvZPjLxwV8f8jEC+6xPlK81o0rQkLna6fc3
         jDjABOa9cTb63VlYrU9ujymho7ivXmZusoFgL40Lw8qTiDk6BV1wB1xHhO3f8/G4NbgF
         hj8t7SQsk6X48TObu0OAEqf4kayQZxC2PHEU7VdFEl4QdW+/dEiRB8WQuohKCe+uqr82
         ukGfnfCoe2hXm7TrKBVvabG+4KrWW9nz3TS2behOEZQTXUGuhYkhnt8tM46/MYD9UxAm
         IfX3tsFoVCCrFmKB2SA4L9Fhx+UCB7nlypLnXUg4PTDljpVXNnHI6ivrii0k51NMWH9v
         xX0w==
X-Gm-Message-State: APjAAAUj4scbBU7iPI7dmJbzGXx+I2V+udk7Yk+AEY74ySwpA1ZIGyyX
        hzm5EQ4iVhaE5JS/VMxPYEuEHCLd
X-Google-Smtp-Source: APXvYqz/Gn8woPlfzhnSNivzG+/+H57xW66li7WmEwqlW8A/4Os7wCMWOfUhNNu7e/ya4WjKJDgqOw==
X-Received: by 2002:a05:600c:2285:: with SMTP id 5mr2669311wmf.162.1582778113432;
        Wed, 26 Feb 2020 20:35:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm5702771wrs.97.2020.02.26.20.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 20:35:12 -0800 (PST)
Message-Id: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
References: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 04:35:07 +0000
Subject: [PATCH v6 0/4] [Outreachy] advice: revamp advise API
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

 * Define a new const char array for the new advice's key.
 * Come up with a new config variable name and add this name to 
   advice_config_keys[]
 * Call advise_if_enabled(new_advice_key, "advice message to be printed")
 * Or call advice_enabled(new_advice_key) first and then follow it by
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

 Makefile               |   1 +
 advice.c               | 124 ++++++++++++++++++++++++++++++++++++++---
 advice.h               |  50 ++++++++++++++++-
 builtin/tag.c          |   5 +-
 t/helper/test-advise.c |  19 +++++++
 t/helper/test-tool.c   |   1 +
 t/helper/test-tool.h   |   1 +
 t/t0018-advice.sh      |  32 +++++++++++
 t/t7004-tag.sh         |   1 +
 9 files changed, 222 insertions(+), 12 deletions(-)
 create mode 100644 t/helper/test-advise.c
 create mode 100755 t/t0018-advice.sh


base-commit: c7a62075917b3340f908093f63f1161c44ed1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-548%2FHebaWaly%2Fadvice_refactoring-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-548/HebaWaly/advice_refactoring-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/548

Range-diff vs v5:

 1:  f668d9b7ca0 = 1:  f668d9b7ca0 advice: extract vadvise() from advise()
 -:  ----------- > 2:  828b4aee19d advice: change "setupStreamFailure" to "setUpstreamFailure"
 2:  b7f10d060a4 ! 3:  176e38a841d advice: revamp advise API
     @@ -18,10 +18,6 @@
          rid of 'advice_config[]' and the global variables once we migrate all
          the callers to use the new APIs.
      
     -    Also change the advise call in tag library from advise() to
     -    advise_if_enabled() to construct an example of the usage of the new
     -    API.
     -
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
       diff --git a/Makefile b/Makefile
     @@ -39,44 +35,82 @@
       diff --git a/advice.c b/advice.c
       --- a/advice.c
       +++ b/advice.c
     +@@
     + int advice_nested_tag = 1;
     + int advice_submodule_alternate_error_strategy_die = 1;
     + 
     ++const char ADVICE_ADD_EMBEDDED_REPO[] = "advice.addEmbeddedRepo";
     ++const char ADVICE_AM_WORK_DIR[] = "advice.amWorkDir";
     ++const char ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME[] = "advice.checkoutAmbiguousRemoteBranchName";
     ++const char ADVICE_COMMIT_BEFORE_MERGE[] = "advice.commitBeforeMerge";
     ++const char ADVICE_DETACHED_HEAD[] = "advice.detachedHead";
     ++const char ADVICE_FETCH_SHOW_FORCED_UPDATES[] = "advice.fetchShowForcedUpdates";
     ++const char ADVICE_GRAFT_FILE_DEPRECATED[] = "advice.graftFileDeprecated";
     ++const char ADVICE_IGNORED_HOOK[] = "advice.ignoredHook";
     ++const char ADVICE_IMPLICIT_IDENTITY[] = "advice.implicitIdentity";
     ++const char ADVICE_NESTED_TAG[] = "advice.nestedTag";
     ++const char ADVICE_OBJECT_NAME_WARNING[] = "advice.objectNameWarning";
     ++const char ADVICE_PUSH_ALREADY_EXISTS[] = "advice.pushAlreadyExists";
     ++const char ADVICE_PUSH_FETCH_FIRST[] = "advice.pushFetchFirst";
     ++const char ADVICE_PUSH_NEEDS_FORCE[] = "advice.pushNeedsForce";
     ++const char ADVICE_PUSH_NON_FF_CURRENT[] = "advice.pushNonFFCurrent";
     ++const char ADVICE_PUSH_NON_FF_MATCHING[] = "advice.pushNonFFMatching";
     ++const char ADVICE_PUSH_UNQUALIFIED_REF_NAME[] = "advice.pushUnqualifiedRefName";
     ++const char ADVICE_PUSH_UPDATE_REJECTED[] = "advice.pushUpdateRejected";
     ++
     ++/* make this an alias for backward compatibility */
     ++const char ADVICE_PUSH_UPDATE_REJECTED_ALIAS[] = "advice.pushNonFastForward";
     ++
     ++const char ADVICE_RESET_QUIET_WARNING[] = "advice.resetQuiet";
     ++const char ADVICE_RESOLVE_CONFLICT[] = "advice.resolveConflict";
     ++const char ADVICE_RM_HINTS[] = "advice.rmHints";
     ++const char ADVICE_SEQUENCER_IN_USE[] = "advice.sequencerInUse";
     ++const char ADVICE_SET_UPSTREAM_FAILURE[] = "advice.setUpstreamFailure";
     ++const char ADVICE_STATUS_AHEAD_BEHIND_WARNING[] = "advice.statusAheadBehindWarning";
     ++const char ADVICE_STATUS_HINTS[] = "advice.statusHints";
     ++const char ADVICE_STATUS_U_OPTION[] = "advice.statusUoption";
     ++const char ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE[] = "advice.submoduleAlternateErrorStrategyDie";
     ++const char ADVICE_WAITING_FOR_EDITOR[] = "advice.waitingForEditor";
     ++
     ++
     + static int advice_use_color = -1;
     + static char advice_colors[][COLOR_MAXLEN] = {
     + 	GIT_COLOR_RESET,
      @@
       	{ "pushNonFastForward", &advice_push_update_rejected }
       };
       
      -static void vadvise(const char *advice, va_list params)
      +static const char *advice_config_keys[] = {
     -+	[ADD_EMBEDDED_REPO]			 = "addEmbeddedRepo",
     -+	[AMWORKDIR]				 = "amWorkDir",
     -+	[CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]	 = "checkoutAmbiguousRemoteBranchName",
     -+	[COMMIT_BEFORE_MERGE]			 = "commitBeforeMerge",
     -+	[DETACHED_HEAD]				 = "detachedHead",
     -+	[FETCH_SHOW_FORCED_UPDATES]		 = "fetchShowForcedUpdates",
     -+	[GRAFT_FILE_DEPRECATED]			 = "graftFileDeprecated",
     -+	[IGNORED_HOOK]				 = "ignoredHook",
     -+	[IMPLICIT_IDENTITY]			 = "implicitIdentity",
     -+	[NESTED_TAG]				 = "nestedTag",
     -+	[OBJECT_NAME_WARNING]			 = "objectNameWarning",
     -+	[PUSH_ALREADY_EXISTS]			 = "pushAlreadyExists",
     -+	[PUSH_FETCH_FIRST]			 = "pushFetchFirst",
     -+	[PUSH_NEEDS_FORCE]			 = "pushNeedsForce",
     -+
     -+	/* make this an alias for backward compatibility */
     -+	[PUSH_UPDATE_REJECTED_ALIAS]		 = "pushNonFastForward",
     -+
     -+	[PUSH_NON_FF_CURRENT]			 = "pushNonFFCurrent",
     -+	[PUSH_NON_FF_MATCHING]			 = "pushNonFFMatching",
     -+	[PUSH_UNQUALIFIED_REF_NAME]		 = "pushUnqualifiedRefName",
     -+	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
     -+	[RESET_QUIET_WARNING]			 = "resetQuiet",
     -+	[RESOLVE_CONFLICT]			 = "resolveConflict",
     -+	[RM_HINTS]				 = "rmHints",
     -+	[SEQUENCER_IN_USE]			 = "sequencerInUse",
     -+	[SET_UPSTREAM_FAILURE]			 = "setupStreamFailure",
     -+	[STATUS_AHEAD_BEHIND_WARNING]		 = "statusAheadBehindWarning",
     -+	[STATUS_HINTS]				 = "statusHints",
     -+	[STATUS_U_OPTION]			 = "statusUoption",
     -+	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie",
     -+	[WAITING_FOR_EDITOR] 			 = "waitingForEditor",
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
     ++	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
     ++	ADVICE_PUSH_NON_FF_CURRENT,
     ++	ADVICE_PUSH_NON_FF_MATCHING,
     ++	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
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
      +};
      +
      +static const char turn_off_instructions[] =
     @@ -84,7 +118,7 @@
      +   "Disable this message with \"git config %s false\"");
      +
      +static void vadvise(const char *advice, int display_instructions,
     -+		    char *key, va_list params)
     ++		    const char *key, va_list params)
       {
       	struct strbuf buf = STRBUF_INIT;
       	const char *cp, *np;
     @@ -106,42 +140,35 @@
      +	va_end(params);
      +}
      +
     -+static int get_config_value(enum advice_type type)
     ++static int get_config_value(const char *advice_key)
      +{
      +	int value = 1;
     -+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
      +
     -+	git_config_get_bool(key, &value);
     -+	free(key);
     ++	git_config_get_bool(advice_key, &value);
      +	return value;
      +}
      +
     -+int advice_enabled(enum advice_type type)
     ++int advice_enabled(const char *advice_key)
      +{
     -+	switch (type) {
     -+	case PUSH_UPDATE_REJECTED:
     -+		return get_config_value(PUSH_UPDATE_REJECTED) &&
     -+		       get_config_value(PUSH_UPDATE_REJECTED_ALIAS);
     -+	default:
     -+		return get_config_value(type);
     -+	}
     ++	if (advice_key == ADVICE_PUSH_UPDATE_REJECTED)
     ++		return get_config_value(ADVICE_PUSH_UPDATE_REJECTED) &&
     ++		       get_config_value(ADVICE_PUSH_UPDATE_REJECTED_ALIAS);
     ++	else
     ++		return get_config_value(advice_key);
      +}
      +
     -+void advise_if_enabled(enum advice_type type, const char *advice, ...)
     ++void advise_if_enabled(const char *advice_key, const char *advice, ...)
      +{
     -+	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
      +	va_list params;
      +
     -+	if (!advice_enabled(type))
     ++	if (!advice_enabled(advice_key))
      +		return;
      +
      +	va_start(params, advice);
     -+	vadvise(advice, 1, key, params);
     ++	vadvise(advice, 1, advice_key, params);
       	va_end(params);
     -+	free(key);
       }
       
     - int git_default_advice_config(const char *var, const char *value)
      @@
       {
       	int i;
     @@ -163,58 +190,55 @@
       
      +/*
      + * To add a new advice, you need to:
     -+ * Define an advice_type.
     ++ * Define a new const char array.
      + * Add a new entry to advice_config_keys list.
      + * Add the new config variable to Documentation/config/advice.txt.
      + * Call advise_if_enabled to print your advice.
      + */
     -+enum advice_type {
     -+	ADD_EMBEDDED_REPO,
     -+	AMWORKDIR,
     -+	CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
     -+	COMMIT_BEFORE_MERGE,
     -+	DETACHED_HEAD,
     -+	FETCH_SHOW_FORCED_UPDATES,
     -+	GRAFT_FILE_DEPRECATED,
     -+	IGNORED_HOOK,
     -+	IMPLICIT_IDENTITY,
     -+	NESTED_TAG,
     -+	OBJECT_NAME_WARNING,
     -+	PUSH_ALREADY_EXISTS,
     -+	PUSH_FETCH_FIRST,
     -+	PUSH_NEEDS_FORCE,
     -+	PUSH_NON_FF_CURRENT,
     -+	PUSH_NON_FF_MATCHING,
     -+	PUSH_UNQUALIFIED_REF_NAME,
     -+	PUSH_UPDATE_REJECTED_ALIAS,
     -+	PUSH_UPDATE_REJECTED,
     -+	RESET_QUIET_WARNING,
     -+	RESOLVE_CONFLICT,
     -+	RM_HINTS,
     -+	SEQUENCER_IN_USE,
     -+	SET_UPSTREAM_FAILURE,
     -+	STATUS_AHEAD_BEHIND_WARNING,
     -+	STATUS_HINTS,
     -+	STATUS_U_OPTION,
     -+	SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
     -+	WAITING_FOR_EDITOR,
     -+};
     -+
     ++extern const char ADVICE_ADD_EMBEDDED_REPO[];
     ++extern const char ADVICE_AM_WORK_DIR[];
     ++extern const char ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME[];
     ++extern const char ADVICE_COMMIT_BEFORE_MERGE[];
     ++extern const char ADVICE_DETACHED_HEAD[];
     ++extern const char ADVICE_FETCH_SHOW_FORCED_UPDATES[];
     ++extern const char ADVICE_GRAFT_FILE_DEPRECATED[];
     ++extern const char ADVICE_IGNORED_HOOK[];
     ++extern const char ADVICE_IMPLICIT_IDENTITY[];
     ++extern const char ADVICE_NESTED_TAG[];
     ++extern const char ADVICE_OBJECT_NAME_WARNING[];
     ++extern const char ADVICE_PUSH_ALREADY_EXISTS[];
     ++extern const char ADVICE_PUSH_FETCH_FIRST[];
     ++extern const char ADVICE_PUSH_NEEDS_FORCE[];
     ++extern const char ADVICE_PUSH_NON_FF_CURRENT[];
     ++extern const char ADVICE_PUSH_NON_FF_MATCHING[];
     ++extern const char ADVICE_PUSH_UNQUALIFIED_REF_NAME[];
     ++extern const char ADVICE_PUSH_UPDATE_REJECTED_ALIAS[];
     ++extern const char ADVICE_PUSH_UPDATE_REJECTED[];
     ++extern const char ADVICE_RESET_QUIET_WARNING[];
     ++extern const char ADVICE_RESOLVE_CONFLICT[];
     ++extern const char ADVICE_RM_HINTS[];
     ++extern const char ADVICE_SEQUENCER_IN_USE[];
     ++extern const char ADVICE_SET_UPSTREAM_FAILURE[];
     ++extern const char ADVICE_STATUS_AHEAD_BEHIND_WARNING[];
     ++extern const char ADVICE_STATUS_HINTS[];
     ++extern const char ADVICE_STATUS_U_OPTION[];
     ++extern const char ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE[];
     ++extern const char ADVICE_WAITING_FOR_EDITOR[];
      +
       int git_default_advice_config(const char *var, const char *value);
       __attribute__((format (printf, 1, 2)))
       void advise(const char *advice, ...);
      +
      +/**
     -+ Checks if advice type is enabled (can be printed to the user).
     -+ Should be called before advise().
     ++ * Checks if advice type is enabled (can be printed to the user).
     ++ * Should be called before advise().
      + */
     -+int advice_enabled(enum advice_type type);
     ++int advice_enabled(const char *advice_key);
      +
      +/**
     -+ Checks the visibility of the advice before printing.
     ++ * Checks the visibility of the advice before printing.
      + */
     -+void advise_if_enabled(enum advice_type type, const char *advice, ...);
     ++void advise_if_enabled(const char *advice_key, const char *advice, ...);
      +
       int error_resolve_conflict(const char *me);
       void NORETURN die_resolve_conflict(const char *me);
     @@ -240,7 +264,7 @@
      +	  Any advice type can be used for testing, but NESTED_TAG was selected
      +	  here and in t0018 where this command is being executed.
      +	 */
     -+	advise_if_enabled(NESTED_TAG, argv[1]);
     ++	advise_if_enabled(ADVICE_NESTED_TAG, argv[1]);
      +
      +	return 0;
      +}
 3:  01b195ebe1d ! 4:  2dee0abd452 tag: use new advice API to check visibility
     @@ -2,9 +2,9 @@
      
          tag: use new advice API to check visibility
      
     -    Following the new helpers added to the advice library,
     -    replace the global variable check approach by the new
     -    API calls
     +    change the advise call in tag library from advise() to
     +    advise_if_enabled() to construct an example of the usage of
     +    the new API.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
     @@ -18,7 +18,7 @@
      -int advice_nested_tag = 1;
       int advice_submodule_alternate_error_strategy_die = 1;
       
     - static int advice_use_color = -1;
     + const char ADVICE_ADD_EMBEDDED_REPO[] = "advice.addEmbeddedRepo";
      @@
       	{ "waitingForEditor", &advice_waiting_for_editor },
       	{ "graftFileDeprecated", &advice_graft_file_deprecated },
     @@ -50,7 +50,7 @@
      -	if (type == OBJ_TAG && advice_nested_tag)
      -		advise(_(message_advice_nested_tag), tag, object_ref);
      +	if (type == OBJ_TAG)
     -+		advise_if_enabled(NESTED_TAG, _(message_advice_nested_tag),
     ++		advise_if_enabled(ADVICE_NESTED_TAG, _(message_advice_nested_tag),
      +				  tag, object_ref);
       
       	strbuf_addf(&header,

-- 
gitgitgadget
