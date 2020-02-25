Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193C8C35DF5
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 10:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85BB21556
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 10:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSm0MtxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgBYKzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:55:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42750 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgBYKzp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 05:55:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id p18so10512898wre.9
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U1tluum9JaMtJ92SqW/AYgJCZxHafiu6HCjUz8hiDOo=;
        b=hSm0MtxPZcgYTDaqA732JFpybg4W+7nCUIbITVwOG2PUydnf/CFfYojDBOY09IN5Wb
         t3jM/JV5skJPzTqFtVgpIyzdTLBRWtfesCdVxHzuCQZh1yELNStLK4YK4B3oqw0KGTzw
         IU0WadkUyC5pJth3O+tIeCNYhQwA0s0JSPgrCgdsHvO1N+XiNLEDMCN5+7v2wsZxZZUT
         vsfeku9l8KUahVqJQ5cySWUWs6HDZ0m9qBDLqaToPJaxijSXTfN7lZbH+3/P/NJMrwgS
         49xdr69ShYkYmHAJGk7DMsD/gk3+zJm3Yi0a6j+ZK/eBqcAiLsHK6+DqCcDNUfMvMPdz
         sDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U1tluum9JaMtJ92SqW/AYgJCZxHafiu6HCjUz8hiDOo=;
        b=Pa7E7SlFpqhPW39bnbk9uQ+FvbuupWio62Viso+lT/hr5L+sze5BqV2r+f2eR6IFhc
         vdYxhSVsAh6ZxRxh2+iUuNjaWFqPaVuIDYhKzkbnQdqwCktUqrcyjb7CzgpyUyNwZIq1
         RW8iwPbgQ7qSt+Wl9XSgxUWlgdTQiHieVhZXMC3XWCoM+EW6Q4mBdedVDnwI/uGXHG1E
         kPiO6cQx2DoLXYBBZlMS/Wlvu5YC3hmYn+sNmMObmmJlf0ItOi4aSR5qfvUeK9+FuX0Q
         iLOrBWPdgn2ka8p/njuR4K1uza0zGYAR6vp/imXJcuHo0GboQLt4cOMpom5xdrsVR8zo
         XdjA==
X-Gm-Message-State: APjAAAXCWat8hsOYwMXpX8skTqyxPva1F4EN15qjI690r/lQYl2UzCrX
        Q4gYp6Vh8zBYnydubbnqFYoJj5WS
X-Google-Smtp-Source: APXvYqyS/UMYfC0C7kS02kj4lQrb7B475Xww40bQwDERe8ph5jlbr4xU79jbpRfHxEv3x+woiB7i+g==
X-Received: by 2002:adf:e908:: with SMTP id f8mr8611209wrm.37.1582628142451;
        Tue, 25 Feb 2020 02:55:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm3672602wmc.27.2020.02.25.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 02:55:41 -0800 (PST)
Message-Id: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Feb 2020 10:55:37 +0000
Subject: [PATCH v5 0/3] [Outreachy] advice: revamp advise API
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
 advice.c               | 97 ++++++++++++++++++++++++++++++++++++++----
 advice.h               | 53 ++++++++++++++++++++++-
 builtin/tag.c          |  5 ++-
 t/helper/test-advise.c | 19 +++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0018-advice.sh      | 32 ++++++++++++++
 t/t7004-tag.sh         |  1 +
 9 files changed, 199 insertions(+), 11 deletions(-)
 create mode 100644 t/helper/test-advise.c
 create mode 100755 t/t0018-advice.sh


base-commit: c7a62075917b3340f908093f63f1161c44ed1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-548%2FHebaWaly%2Fadvice_refactoring-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-548/HebaWaly/advice_refactoring-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/548

Range-diff vs v4:

 1:  f668d9b7ca0 = 1:  f668d9b7ca0 advice: extract vadvise() from advise()
 2:  04c3e5760f6 ! 2:  b7f10d060a4 advice: revamp advise API
     @@ -45,52 +45,53 @@
       
      -static void vadvise(const char *advice, va_list params)
      +static const char *advice_config_keys[] = {
     ++	[ADD_EMBEDDED_REPO]			 = "addEmbeddedRepo",
     ++	[AMWORKDIR]				 = "amWorkDir",
     ++	[CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]	 = "checkoutAmbiguousRemoteBranchName",
     ++	[COMMIT_BEFORE_MERGE]			 = "commitBeforeMerge",
     ++	[DETACHED_HEAD]				 = "detachedHead",
      +	[FETCH_SHOW_FORCED_UPDATES]		 = "fetchShowForcedUpdates",
     -+	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
     ++	[GRAFT_FILE_DEPRECATED]			 = "graftFileDeprecated",
     ++	[IGNORED_HOOK]				 = "ignoredHook",
     ++	[IMPLICIT_IDENTITY]			 = "implicitIdentity",
     ++	[NESTED_TAG]				 = "nestedTag",
     ++	[OBJECT_NAME_WARNING]			 = "objectNameWarning",
     ++	[PUSH_ALREADY_EXISTS]			 = "pushAlreadyExists",
     ++	[PUSH_FETCH_FIRST]			 = "pushFetchFirst",
     ++	[PUSH_NEEDS_FORCE]			 = "pushNeedsForce",
     ++
      +	/* make this an alias for backward compatibility */
      +	[PUSH_UPDATE_REJECTED_ALIAS]		 = "pushNonFastForward",
      +
      +	[PUSH_NON_FF_CURRENT]			 = "pushNonFFCurrent",
      +	[PUSH_NON_FF_MATCHING]			 = "pushNonFFMatching",
     -+	[PUSH_ALREADY_EXISTS]			 = "pushAlreadyExists",
     -+	[PUSH_FETCH_FIRST]			 = "pushFetchFirst",
     -+	[PUSH_NEEDS_FORCE]			 = "pushNeedsForce",
      +	[PUSH_UNQUALIFIED_REF_NAME]		 = "pushUnqualifiedRefName",
     -+	[STATUS_HINTS]				 = "statusHints",
     -+	[STATUS_U_OPTION]			 = "statusUoption",
     -+	[STATUS_AHEAD_BEHIND_WARNING]		 = "statusAheadBehindWarning",
     -+	[COMMIT_BEFORE_MERGE]			 = "commitBeforeMerge",
     ++	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
      +	[RESET_QUIET_WARNING]			 = "resetQuiet",
      +	[RESOLVE_CONFLICT]			 = "resolveConflict",
     ++	[RM_HINTS]				 = "rmHints",
      +	[SEQUENCER_IN_USE]			 = "sequencerInUse",
     -+	[IMPLICIT_IDENTITY]			 = "implicitIdentity",
     -+	[DETACHED_HEAD]				 = "detachedHead",
      +	[SET_UPSTREAM_FAILURE]			 = "setupStreamFailure",
     -+	[OBJECT_NAME_WARNING]			 = "objectNameWarning",
     -+	[AMWORKDIR]				 = "amWorkDir",
     -+	[RM_HINTS]				 = "rmHints",
     -+	[ADD_EMBEDDED_REPO]			 = "addEmbeddedRepo",
     -+	[IGNORED_HOOK]				 = "ignoredHook",
     ++	[STATUS_AHEAD_BEHIND_WARNING]		 = "statusAheadBehindWarning",
     ++	[STATUS_HINTS]				 = "statusHints",
     ++	[STATUS_U_OPTION]			 = "statusUoption",
     ++	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie",
      +	[WAITING_FOR_EDITOR] 			 = "waitingForEditor",
     -+	[GRAFT_FILE_DEPRECATED]			 = "graftFileDeprecated",
     -+	[CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]	 = "checkoutAmbiguousRemoteBranchName",
     -+	[NESTED_TAG]				 = "nestedTag",
     -+	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie"
      +};
      +
      +static const char turn_off_instructions[] =
      +N_("\n"
      +   "Disable this message with \"git config %s false\"");
      +
     -+static void vadvise(const char *advice, va_list params,
     -+		    int display_instructions, char *key)
     ++static void vadvise(const char *advice, int display_instructions,
     ++		    char *key, va_list params)
       {
       	struct strbuf buf = STRBUF_INIT;
       	const char *cp, *np;
       
       	strbuf_vaddf(&buf, advice, params);
       
     -+	if(display_instructions)
     ++	if (display_instructions)
      +		strbuf_addf(&buf, turn_off_instructions, key);
      +
       	for (cp = buf.buf; *cp; cp = np) {
     @@ -101,7 +102,7 @@
       	va_list params;
       	va_start(params, advice);
      -	vadvise(advice, params);
     -+	vadvise(advice, params, 0, "");
     ++	vadvise(advice, 0, "", params);
      +	va_end(params);
      +}
      +
     @@ -109,6 +110,7 @@
      +{
      +	int value = 1;
      +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
     ++
      +	git_config_get_bool(key, &value);
      +	free(key);
      +	return value;
     @@ -116,7 +118,7 @@
      +
      +int advice_enabled(enum advice_type type)
      +{
     -+	switch(type) {
     ++	switch (type) {
      +	case PUSH_UPDATE_REJECTED:
      +		return get_config_value(PUSH_UPDATE_REJECTED) &&
      +		       get_config_value(PUSH_UPDATE_REJECTED_ALIAS);
     @@ -130,11 +132,11 @@
      +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
      +	va_list params;
      +
     -+	if(!advice_enabled(type))
     ++	if (!advice_enabled(type))
      +		return;
      +
      +	va_start(params, advice);
     -+	vadvise(advice, params, 1, key);
     ++	vadvise(advice, 1, key, params);
       	va_end(params);
      +	free(key);
       }
     @@ -159,43 +161,43 @@
       extern int advice_nested_tag;
       extern int advice_submodule_alternate_error_strategy_die;
       
     -+/**
     -+ To add a new advice, you need to:
     -+ - Define an advice_type.
     -+ - Add a new entry to advice_config_keys list.
     -+ - Add the new config variable to Documentation/config/advice.txt.
     -+ - Call advise_if_enabled to print your advice.
     ++/*
     ++ * To add a new advice, you need to:
     ++ * Define an advice_type.
     ++ * Add a new entry to advice_config_keys list.
     ++ * Add the new config variable to Documentation/config/advice.txt.
     ++ * Call advise_if_enabled to print your advice.
      + */
      +enum advice_type {
     -+	FETCH_SHOW_FORCED_UPDATES = 0,
     -+	PUSH_UPDATE_REJECTED = 1,
     -+	PUSH_UPDATE_REJECTED_ALIAS = 2,
     -+	PUSH_NON_FF_CURRENT = 3,
     -+	PUSH_NON_FF_MATCHING = 4,
     -+	PUSH_ALREADY_EXISTS = 5,
     -+	PUSH_FETCH_FIRST = 6,
     -+	PUSH_NEEDS_FORCE = 7,
     -+	PUSH_UNQUALIFIED_REF_NAME = 8,
     -+	STATUS_HINTS = 9,
     -+	STATUS_U_OPTION = 10,
     -+	STATUS_AHEAD_BEHIND_WARNING = 11,
     -+	COMMIT_BEFORE_MERGE = 12,
     -+	RESET_QUIET_WARNING = 13,
     -+	RESOLVE_CONFLICT = 14,
     -+	SEQUENCER_IN_USE = 15,
     -+	IMPLICIT_IDENTITY = 16,
     -+	DETACHED_HEAD = 17,
     -+	SET_UPSTREAM_FAILURE = 18,
     -+	OBJECT_NAME_WARNING = 19,
     -+	AMWORKDIR = 20,
     -+	RM_HINTS = 21,
     -+	ADD_EMBEDDED_REPO = 22,
     -+	IGNORED_HOOK = 23,
     -+	WAITING_FOR_EDITOR = 24,
     -+	GRAFT_FILE_DEPRECATED = 25,
     -+	CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME = 26,
     -+	NESTED_TAG = 27,
     -+	SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE = 28,
     ++	ADD_EMBEDDED_REPO,
     ++	AMWORKDIR,
     ++	CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
     ++	COMMIT_BEFORE_MERGE,
     ++	DETACHED_HEAD,
     ++	FETCH_SHOW_FORCED_UPDATES,
     ++	GRAFT_FILE_DEPRECATED,
     ++	IGNORED_HOOK,
     ++	IMPLICIT_IDENTITY,
     ++	NESTED_TAG,
     ++	OBJECT_NAME_WARNING,
     ++	PUSH_ALREADY_EXISTS,
     ++	PUSH_FETCH_FIRST,
     ++	PUSH_NEEDS_FORCE,
     ++	PUSH_NON_FF_CURRENT,
     ++	PUSH_NON_FF_MATCHING,
     ++	PUSH_UNQUALIFIED_REF_NAME,
     ++	PUSH_UPDATE_REJECTED_ALIAS,
     ++	PUSH_UPDATE_REJECTED,
     ++	RESET_QUIET_WARNING,
     ++	RESOLVE_CONFLICT,
     ++	RM_HINTS,
     ++	SEQUENCER_IN_USE,
     ++	SET_UPSTREAM_FAILURE,
     ++	STATUS_AHEAD_BEHIND_WARNING,
     ++	STATUS_HINTS,
     ++	STATUS_U_OPTION,
     ++	SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
     ++	WAITING_FOR_EDITOR,
      +};
      +
      +
     @@ -278,22 +280,26 @@
      +
      +. ./test-lib.sh
      +
     -+cat > expected <<EOF
     -+hint: This is a piece of advice
     -+hint: Disable this message with "git config advice.nestedTag false"
     -+EOF
     -+test_expect_success 'advise should be printed when config variable is unset' '
     ++test_expect_success 'advice should be printed when config variable is unset' '
     ++	cat >expect <<-\EOF &&
     ++	hint: This is a piece of advice
     ++	hint: Disable this message with "git config advice.nestedTag false"
     ++	EOF
      +	test-tool advise "This is a piece of advice" 2>actual &&
     -+	test_i18ncmp expected actual
     ++	test_i18ncmp expect actual
      +'
      +
     -+test_expect_success 'advise should be printed when config variable is set to true' '
     ++test_expect_success 'advice should be printed when config variable is set to true' '
     ++	cat >expect <<-\EOF &&
     ++	hint: This is a piece of advice
     ++	hint: Disable this message with "git config advice.nestedTag false"
     ++	EOF
      +	test_config advice.nestedTag true &&
      +	test-tool advise "This is a piece of advice" 2>actual &&
     -+	test_i18ncmp expected actual
     ++	test_i18ncmp expect actual
      +'
      +
     -+test_expect_success 'advise should not be printed when config variable is set to false' '
     ++test_expect_success 'advice should not be printed when config variable is set to false' '
      +	test_config advice.nestedTag false &&
      +	test-tool advise "This is a piece of advice" 2>actual &&
      +	test_must_be_empty actual
 3:  3cc0a17123d ! 3:  01b195ebe1d tag: use new advice API to check visibility
     @@ -38,7 +38,7 @@
      -extern int advice_nested_tag;
       extern int advice_submodule_alternate_error_strategy_die;
       
     - /**
     + /*
      
       diff --git a/builtin/tag.c b/builtin/tag.c
       --- a/builtin/tag.c

-- 
gitgitgadget
