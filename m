Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABE9C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45501208C4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 20:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/X+1EOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgBSUeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:34:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53371 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUeG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 15:34:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so2122978wmh.3
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 12:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mYP5Fd2X5aEGmzjnsWrJfU2Y+UPCe5OwL6zFJiyqK0Q=;
        b=I/X+1EOktMgH1fCYzF9lH8Y9AG1QsXWn63Q31ZU533Lc9NRLxwwiJEvosHsAUScbJH
         e5S18KUDMilpw1soZpICyvHS/O9l3Zn072EppBwfiYbWz6MGi/TbhQQNiJty9taCbg8S
         6drg2WpvpnjNtOQ3Mom+ZWzmIgUsMj1xG56IcirTai4Rom0PNrNS7jcJTBtd0kxMPTWJ
         Pe7H2B4PQt1BgzMm1Of0sMTW+rMEJp4kIHkTMD5RcDJdJ2TNqjqRNg3X1d9ysjuLul9v
         DBOOquB3v3wBKyL3awlnFzDve0u6oGa7fekCj9Ms0480qTjoCWCud+IYGsMGtL14I0T5
         IRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mYP5Fd2X5aEGmzjnsWrJfU2Y+UPCe5OwL6zFJiyqK0Q=;
        b=JGKNT6hvCTjrfFpCXDkRuWlyzd+l9LyPphBtD4dlExBY6GTD/qDcQNbIxDHtw2IHho
         VMq4M7OV7BP7nMh8cv7ysNK/qzl+xvg/UnBuhzfnuhDp8TVbo9FRM938YVyUyiPOVp3k
         yvr1A425hePT9UnSH4SEmVKveJCpycTrs9Rm8zo2dZ2Y2ceuRn4j2dM69nKtwksBKlW6
         1g91PL90AkB4kHIauccbsyknGC0T2Z1ck3NivzD8PlRwDnMpI7qZx9GstQY3dEBjlE6f
         3q6DTdb6CtIV1Bk/+JmhvU252ec9F29gUcTTqH4oCo+tx/g/LQ2diqSd5HxvdwydmxKm
         TPWA==
X-Gm-Message-State: APjAAAVnvQmld+AGyaF1BT+4LzJ8mg0w8asidghwd2ZUOxctJ0BmWdvs
        1Jd9vXD2jvhKVioZ2zTNTyCH9CAt
X-Google-Smtp-Source: APXvYqxAxTquBy514foih64QHk3DR+DJNTIV2NNp0gUNaBDnnv7IQsIUlcqaYbhZvp2BDLM6Q+rvCw==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr11629571wme.37.1582144443315;
        Wed, 19 Feb 2020 12:34:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13sm1228031wrn.46.2020.02.19.12.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:34:02 -0800 (PST)
Message-Id: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
References: <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 20:33:59 +0000
Subject: [PATCH v3 0/2] [Outreachy] advice: revamp advise API
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

Heba Waly (2):
  advice: revamp advise API
  advice: extract vadvise() from advise()

 Makefile               |  1 +
 advice.c               | 93 ++++++++++++++++++++++++++++++++++++++----
 advice.h               | 53 +++++++++++++++++++++++-
 builtin/tag.c          |  4 +-
 t/helper/test-advise.c | 16 ++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0018-advice.sh      | 28 +++++++++++++
 t/t7004-tag.sh         |  1 +
 9 files changed, 187 insertions(+), 11 deletions(-)
 create mode 100644 t/helper/test-advise.c
 create mode 100755 t/t0018-advice.sh


base-commit: c7a62075917b3340f908093f63f1161c44ed1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-548%2FHebaWaly%2Fadvice_refactoring-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-548/HebaWaly/advice_refactoring-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/548

Range-diff vs v2:

 1:  080d12b5c69 ! 1:  4ab141426f3 advice: refactor advise API
     @@ -1,6 +1,6 @@
      Author: Heba Waly <heba.waly@gmail.com>
      
     -    advice: refactor advise API
     +    advice: revamp advise API
      
          Currently it's very easy for the advice library's callers to miss
          checking the visibility step before printing an advice. Also, it makes
     @@ -63,7 +63,7 @@
      +	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
      +	/* make this an alias for backward compatibility */
      +	[PUSH_UPDATE_REJECTED_ALIAS]		 = "pushNonFastForward",
     -+	
     ++
      +	[PUSH_NON_FF_CURRENT]			 = "pushNonFFCurrent",
      +	[PUSH_NON_FF_MATCHING]			 = "pushNonFFMatching",
      +	[PUSH_ALREADY_EXISTS]			 = "pushAlreadyExists",
     @@ -99,7 +99,7 @@
       	strbuf_release(&buf);
       }
       
     -+int advice_enabled(enum advice_type type)
     ++static int get_config_value(enum advice_type type)
      +{
      +	int value = 1;
      +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
     @@ -107,11 +107,15 @@
      +	return value;
      +}
      +
     -+int advice_push_update_rejected_enabled(void)
     ++int advice_enabled(enum advice_type type)
      +{
     -+	return advice_enabled(PUSH_UPDATE_REJECTED) ||
     -+	       advice_enabled(PUSH_UPDATE_REJECTED_ALIAS);
     -+	
     ++	switch(type) {
     ++	case PUSH_UPDATE_REJECTED:
     ++		return get_config_value(PUSH_UPDATE_REJECTED) &&
     ++		       get_config_value(PUSH_UPDATE_REJECTED_ALIAS);
     ++	default:
     ++		return get_config_value(type);
     ++	}
      +}
      +
      +static const char turn_off_instructions[] =
     @@ -223,12 +227,7 @@
      +int advice_enabled(enum advice_type type);
      +
      +/**
     -+ Checks if PUSH_UPDATE_REJECTED advice type is enabled.
     -+ */
     -+int advice_push_update_rejected_enabled(void);
     -+
     -+/**
     -+ Checks the visibility of the advice before priniting.
     ++ Checks the visibility of the advice before printing.
      + */
      +void advise_if_enabled(enum advice_type type, const char *advice, ...);
      +
     @@ -266,7 +265,7 @@
      +	die("usage: %s <advice>", argv[0]);
      +
      +	setup_git_directory();
     -+	
     ++
      +	//use any advice type for testing
      +	advise_if_enabled(NESTED_TAG, argv[1]);
      +
 2:  3e4f52e5526 ! 2:  a2a145c705e advice: extract vadvise() from advise()
     @@ -38,7 +38,7 @@
       	for (cp = buf.buf; *cp; cp = np) {
       		np = strchrnul(cp, '\n');
      @@
     - 	
     + 	}
       }
       
      -static const char turn_off_instructions[] =

-- 
gitgitgadget
