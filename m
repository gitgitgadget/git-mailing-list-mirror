Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C7FC35241
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 00:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0172071E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 00:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENluPA91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgAXAVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:21:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52774 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgAXAVL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 19:21:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so91497wmc.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 16:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nsSHRoMTVDzFGt9P3612Y0UcRb/AtCC6gACe3c/8A1c=;
        b=ENluPA91Tfx5sQjelOwQh/RFXJaLRrlAr/EUed//2Svi5s3hnd5o3L1jAZmkUwo4j0
         Sj7YXhVDc4ADSYlJ5lY7+b5vzE8Lw4jPe53CRXTmu2vjPuWPAgqmtOp9EEB4utC1Nky1
         DltQOBX5B750i+UmU4/9xnCyV8enVhxgxwDMQIL8HcTy+Dbil5a2lXpfJh3WiM2Ea7DV
         sJLCuBPCFBvMwGTHO2G9uCXprV0KpAFQUlPXX2rqEAInakdobOo146wQl9gFLw9UZOdg
         Ag4nQtACh+lPquj1DkGqWU4hv5dZvXSwHETb9wvy8/d7ji6wCIJBYEpQvtpjuO41CUcg
         MZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nsSHRoMTVDzFGt9P3612Y0UcRb/AtCC6gACe3c/8A1c=;
        b=cA6w3Xc5WaJWTxfHnnUzhy2R7ue7lG4HB3Zk+6eJpS9YlD8K+BcJaMVzKt44rwReXl
         wcFhniLCJ3E3Y7KcsVRa+HYa8zgLwtMCy8RZbLlD3bAUSMyeJUU9vDPUN6DqUX5NLz23
         W+sMsW51lYpubloteA5dNrn9Q4WYwNkGf0CrTHc2QY4yThi+9avm6MkSgLU+sjvOWFag
         gM+tuIOOBhg/7AV5YamvJAnfSqUU/mx8Lg/b6mzH/+EIsXNsvni9SGws/L6cORO+P5qy
         /Wt2banf8gomXkiyKg1YGcNXR0Zlr4VplkjPqRjph7xZ8aYQYPuwT/ATQlGuCWYDT5sC
         bbFQ==
X-Gm-Message-State: APjAAAUloLslM405FqKPKpJCP7cMjVkpKOvnof24HC6MCCNFmvKbFYnn
        9yWz1e2dFxnC2biUuonhEvAC9hud
X-Google-Smtp-Source: APXvYqzAh7mm/1zWsdIYI/DSKs8ub6BznrCCncZiTSz3yX6dIUZBu1PNfP9ha597LNIVY1OlTjR8Fw==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr458743wmk.15.1579825268469;
        Thu, 23 Jan 2020 16:21:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x17sm4993297wrt.74.2020.01.23.16.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 16:21:07 -0800 (PST)
Message-Id: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 00:21:00 +0000
Subject: [PATCH v4 0/6] config: allow user to know scope of config options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was originally a pull request to the git-for-windows repository
[https://github.com/git-for-windows/git/pull/2399]. It adds a new option
--show-scope which would allow a user to see what scope a given
configuration value has (sytem, local, global, etc.).

changes since v3:

 * Cleaned up t1300
 * Expanded test coverage for t1300 to not rely as much on !MINGW by using a
   simpler filename for most tests
 * config_scope_name is now exposed in config.h
 * cleaned up commit messages for clarity/content (again)

Matthew Rogers (6):
  config: fix typo in variable name
  t1300: fix over-indented HERE-DOCs
  t1300: create custom config file without special characters
  config: split repo scope to local and worktree
  config: clarify meaning of command line scoping
  config: add '--show-scope' to print the scope of a config value

 Documentation/git-config.txt |  15 ++-
 builtin/config.c             |  46 +++++--
 config.c                     |  35 ++++-
 config.h                     |  20 +--
 remote.c                     |   3 +-
 submodule-config.c           |   4 +-
 t/helper/test-config.c       |  17 +--
 t/t1300-config.sh            | 240 ++++++++++++++++++++++-------------
 t/t1308-config-set.sh        |   4 +-
 upload-pack.c                |   3 +-
 10 files changed, 248 insertions(+), 139 deletions(-)


base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-478%2FROGERSM94%2Fadd-config-flags-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-478/ROGERSM94/add-config-flags-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/478

Range-diff vs v3:

 1:  f5a81a4d25 = 1:  f5a81a4d25 config: fix typo in variable name
 -:  ---------- > 2:  1b42f85399 t1300: fix over-indented HERE-DOCs
 -:  ---------- > 3:  9d19794dfd t1300: create custom config file without special characters
 2:  f06f9291b7 ! 4:  9f160e281a config: refine config scope enum
     @@ -1,6 +1,6 @@
      Author: Matthew Rogers <mattr94@gmail.com>
      
     -    config: refine config scope enum
     +    config: split repo scope to local and worktree
      
          Previously when iterating through git config variables, worktree config
          and local config were both considered "CONFIG_SCOPE_REPO".  This was
     @@ -93,14 +93,14 @@
       --- a/t/t1308-config-set.sh
       +++ b/t/t1308-config-set.sh
      @@
     + 	value=from-repo
     + 	origin=file
     + 	name=.git/config
     +-	scope=repo
     ++	scope=local
     + 
     + 	key=foo.bar
       	value=from-cmdline
     - 	origin=command line
     - 	name=
     --	scope=cmdline
     -+	scope=command
     - 	EOF
     - 	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
     - 	test_cmp expect actual
      
       diff --git a/upload-pack.c b/upload-pack.c
       --- a/upload-pack.c
 3:  97b8a7641d ! 5:  7f00f8559d config: clarify meaning of command line scoping
     @@ -53,3 +53,16 @@
       	default:
       		return "unknown";
       	}
     +
     + diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
     + --- a/t/t1308-config-set.sh
     + +++ b/t/t1308-config-set.sh
     +@@
     + 	value=from-cmdline
     + 	origin=command line
     + 	name=
     +-	scope=cmdline
     ++	scope=command
     + 	EOF
     + 	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
     + 	test_cmp expect actual
 4:  61ff3c64b5 ! 6:  5549db7e39 config: add '--show-scope' to print the scope of a config value
     @@ -76,26 +76,6 @@
       	strbuf_addch(buf, term);
       }
       
     -+static const char *scope_to_string(enum config_scope scope)
     -+{
     -+	switch (scope) {
     -+	case CONFIG_SCOPE_LOCAL:
     -+		return "local";
     -+	case CONFIG_SCOPE_GLOBAL:
     -+		return "global";
     -+	case CONFIG_SCOPE_SYSTEM:
     -+		return "system";
     -+	case CONFIG_SCOPE_WORKTREE:
     -+		return "worktree";
     -+	case CONFIG_SCOPE_COMMAND:
     -+		return "command";
     -+	case CONFIG_SCOPE_SUBMODULE:
     -+		return "submodule";
     -+	default:
     -+		return "unknown";
     -+	}
     -+}
     -+
      +static void show_config_scope(struct strbuf *buf)
      +{
      +	const char term = end_nul ? '\0' : '\t';
     @@ -211,6 +191,33 @@
       	/*
       	 * If we have a specific filename, use it. Otherwise, follow the
       	 * regular lookup sequence.
     +@@
     + 	}
     + }
     + 
     ++const char *scope_to_string(enum config_scope scope)
     ++{
     ++	switch (scope) {
     ++	case CONFIG_SCOPE_SYSTEM:
     ++		return "system";
     ++	case CONFIG_SCOPE_GLOBAL:
     ++		return "global";
     ++	case CONFIG_SCOPE_LOCAL:
     ++		return "local";
     ++	case CONFIG_SCOPE_WORKTREE:
     ++		return "worktree";
     ++	case CONFIG_SCOPE_COMMAND:
     ++		return "command";
     ++	case CONFIG_SCOPE_SUBMODULE:
     ++		return "submodule";
     ++	default:
     ++		return "unknown";
     ++	}
     ++}
     ++
     + const char *current_config_name(void)
     + {
     + 	const char *name;
      
       diff --git a/config.h b/config.h
       --- a/config.h
     @@ -228,6 +235,7 @@
      +	CONFIG_SCOPE_COMMAND,
      +	CONFIG_SCOPE_SUBMODULE,
      +};
     ++const char *scope_to_string(enum config_scope scope);
      +
       struct git_config_source {
       	unsigned int use_stdin:1;
     @@ -273,14 +281,38 @@
       --- a/t/helper/test-config.c
       +++ b/t/helper/test-config.c
      @@
     - 		return "repo";
     - 	case CONFIG_SCOPE_WORKTREE:
     - 		return "worktree";
     -+	case CONFIG_SCOPE_SUBMODULE:
     -+		return "submodule";
     - 	case CONFIG_SCOPE_COMMAND:
     - 		return "command";
     - 	default:
     +  *
     +  */
     + 
     +-static const char *scope_name(enum config_scope scope)
     +-{
     +-	switch (scope) {
     +-	case CONFIG_SCOPE_SYSTEM:
     +-		return "system";
     +-	case CONFIG_SCOPE_GLOBAL:
     +-		return "global";
     +-	case CONFIG_SCOPE_LOCAL:
     +-		return "repo";
     +-	case CONFIG_SCOPE_WORKTREE:
     +-		return "worktree";
     +-	case CONFIG_SCOPE_COMMAND:
     +-		return "command";
     +-	default:
     +-		return "unknown";
     +-	}
     +-}
     + static int iterate_cb(const char *var, const char *value, void *data)
     + {
     + 	static int nr;
     +@@
     + 	printf("value=%s\n", value ? value : "(null)");
     + 	printf("origin=%s\n", current_config_origin_type());
     + 	printf("name=%s\n", current_config_name());
     +-	printf("scope=%s\n", scope_name(current_config_scope()));
     ++	printf("scope=%s\n", scope_to_string(current_config_scope()));
     + 
     + 	return 0;
     + }
      
       diff --git a/t/t1300-config.sh b/t/t1300-config.sh
       --- a/t/t1300-config.sh
     @@ -313,6 +345,7 @@
      +	git config --blob=$blob --show-scope --list >output &&
      +	test_cmp expect output
      +'
     ++
      +test_expect_success '--show-scope with --local' '
      +	cat >expect <<-\EOF &&
      +		local	user.local=true

-- 
gitgitgadget
