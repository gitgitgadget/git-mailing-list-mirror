Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC834750D
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009806; cv=none; b=tqYssPEBZBJVYvV+2Pom03B1vDU2AN4rQ7/peQKLCugZM2X8m9nMY8cg2k3l0n8VH1P0SKe432HnOC7q9Cb/ESRBHow/8PWuWz+nUxj4IMgCUXdpPRwNhIiZYLx34xQZZ/gWmGp0rjNoOffqaSxl9nxD31vhV3FWtOTzWBhgTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009806; c=relaxed/simple;
	bh=PAUIaKBWs19ZGsKmvPZiWTIkWjBonIi9L0AEgm+DzcI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XwHw4WEz6EiHcBV+nroVlcosv7/l1k7SY4p7kVAlJx2Z/qHSSOHoyMh9GOBE8zxYhDeq78CzmVbYiTwLgEH7cIYaasyah0a/HHVMGag0nACFQ34QTSsk71eVAVNnb+7aHrUuCnmBlflXcPmWBEcMjcl+oHSaU1yWzGzU959tEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR8bb5Gc; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR8bb5Gc"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4af173320f9so4444450b6e.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 20:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789009802; x=1789614602; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=do59vihRbaH1+UHVns74BkpF/UEFVUPTPdU+UopYjMs=;
        b=eR8bb5GcbzTdtq5JibFWJmjio/yi3l0+rB3KrAnfFkkl90XnztJpTjnVI4P33chooO
         3eS/x1u9JwxxI6F+Agh2L65uplu4DeuCf5Gg967AYTnSP0aneZjb2Lx4lp5DLmF5WDFY
         RUJF6Y+/oRz24rT3zXhT/VtLgXceP2cSHykMMApDlJ9Q9zxNIjrRE4nhlCkkrtuM2r/d
         fiyxCrAbsaT4WahXZ6TL8Dwjc5RBbstDfsbkejM+iE4n7GrvAqtF4SlZ7ERaVJaHTXZU
         gBKXumwhyZ0X5GWXjjh922nJL49QOjK0gTHrWSaTMxtsAg0Cp/wEiGdk48IbkWdObmRG
         +u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789009802; x=1789614602;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=do59vihRbaH1+UHVns74BkpF/UEFVUPTPdU+UopYjMs=;
        b=RxJvJuybXXK6l9HkW3WR2AlHIVjPupXdZ+D5pRL5X02zkuMz3iC4TVUYBS4Udhzrah
         NnSVbj+U4X4X6WU7v3x32TtgtFhhqlFyBgCXIMK1H4JJyrfQjuITi+pT+zRXLSso8wOC
         OdbKtXwondkHib/JdnTsffAVLr8Apnr8K4ghhaySry2WADrddD7ikjFcc2RcXCNhR1xM
         ewNQ25RcR1r0C51Wbyuje/ghm2pvwzzQ6QmSRe9E/fdRrEfkDMNvlrnhuGqZmkm4g0OD
         uxjjYbm31yuve9Zh0XCXg3IUfa/wI5yCriVyIe6SPxZWI50u69UfxkdXUzPotsH9INLU
         WWWQ==
X-Gm-Message-State: AFuF++kkxmhojPeM/HTdJarOTVo46QvH8uKeEKu9qes4clSo5IrAm+0j
	9NZV+ugzao2miOJbTEm6mgYM1Y+gfDtRLOiZeg9QL9yftLlV3xxWEPfciIQnbN+W
X-Gm-Gg: AYBFou1VV3MenIDuKufourZYvQ2EypKTTJNFRLK/7smhuczh1i83ExMDSh5dMaqiMcK
	ehfpWN5p29TiVGOOuBZ37ffufe5uwdrYlTa7II3ifoFtoj2B+S7D4Dp/KwT0uraNPu4QLC9qxcO
	hvDWwfRSp2mb8VLyaaIgUZtSq79VZBwwFngtlykAHR9v3hQyuvKcBofGrUtHojzIlSXmU4mElCn
	CxsxszAoWgJlwyVblicG5j5sOibrmCzyGg5+kNbJJ9ZKkfgdTxQCVaE6Uo3riykQx7E1cQA50Kh
	D3gMdfu0J4w2MdsfMoh+LF4DEFhxAbEFixcP58XHSAKL60BuDIPHFtiSd/Jz8//jfXvmYyL3yn7
	ujUWMSWAV0uV+esjdIp7zUBoG2KoFl03vm6EJmGnne/T4OWk/955ELz06yUZVPbGWxYZ2C4b7Sy
	y6Wpdx4y2Ict9aJFotFF44IGAi6nCQlFjQ2Um1n1RjcNckEHD9j9sGc/EJa0hBTh2N+gr3cfGhz
	XJbNw==
X-Received: by 2002:a05:6808:244e:b0:4b9:e5fa:890f with SMTP id 5614622812f47-4b9e5fa8f39mr20534180b6e.34.1789009802263;
        Wed, 09 Sep 2026 20:10:02 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.255.209])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47947f96dd2sm9993154fac.14.2026.09.09.20.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 20:10:00 -0700 (PDT)
Message-Id: <pull.2388.v7.git.git.1789009798902.gitgitgadget@gmail.com>
In-Reply-To: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
From: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 03:09:58 +0000
Subject: [PATCH v7] var: support broken-down idents, signing key, multiple
 args, and -z
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Andrew Pleeter <andrewpleeter@gmail.com>,
    Andrew Pleeter <andrewpleeter@gmail.com>

From: Andrew Pleeter <andrewpleeter@gmail.com>

While 'git var' exposes GIT_AUTHOR_IDENT and GIT_COMMITTER_IDENT,
extracting individual components (name, email, or date) currently
requires callers to manually parse the composite string. Furthermore,
there is no way to query the resolved commit signing key through
'git var', and the command only accepts a single variable at a time.

Teach 'git var' to expose individual identity components and commit
signing configuration, and allow querying multiple variables with
optional NUL-termination:

- Add GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE.
- Add GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE.
- Add GIT_SIGNING_KEY to resolve the key that would be used to sign
  the resulting commit if you were to run 'git commit' right now.
- Allow passing multiple variable arguments (e.g., 'git var
  GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL') to output each variable
  sequentially.
- Support '-z' to terminate variable outputs with NUL bytes.
- Format 'git var -l -z' using the same convention as 'git config
  list -z' (newline separating key and value, NUL separating entries).
- Delimit values of multi-valued variables with NUL when '-z' is given,
  and output an extra delimiter after multi-valued variables when
  querying multiple variables to disambiguate the stream.
- When querying multiple variables, print an empty record for any
  variable that has no value and continue processing remaining variables.
- Use parse_options() to strictly require options before arguments.
- Update Documentation/git-var.adoc and t/t0007-git-var.sh.

Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
---
    var: support broken-down idents, signing key, multiple args, and -z
    
    Teach git var to expose individual identity components and commit
    signing configuration, and allow querying multiple variables with
    optional NUL-termination.
    
    
    Changes since v6:
    =================
    
     * Grouped GIT_AUTHOR_* and GIT_COMMITTER_* entries together into
       concise definitions in Documentation/git-var.adoc to avoid repetitive
       descriptions, per feedback from Junio C. Hamano.
     * Added explicit BUG() checks in ident_part() for NULL name/email
       pointers and date/timezone to protect against unforeseen changes in
       split_ident_line().
     * Changed struct git_var member multiread to return void (void
       (*multiread)(struct string_list *)) since list->nr communicates
       length.
     * Simplified list_vars() to use an unconditional else block for
       ptr->multiread instead of redundant else if.
     * In cmd_var(), do not set a non-zero exit status for missing variables
       in multi-variable queries; callers can see the empty record (e.g.
       GIT_CONFIG_SYSTEM under GIT_CONFIG_NOSYSTEM), matching Phillip Wood's
       recommendation.
     * Used putc(term, stdout) in cmd_var() when emitting delimiters.
     * In t/t0007-git-var.sh, converted -z tests to pipe output through
       nul_to_q so test_cmp produces clean diffs rather than binary
       comparison errors.
    
    
    Changes since v5:
    =================
    
     * Reverted cosmetic refactoring in get_git_var() to keep the diff
       minimal and focused on adding ptr->multiread.
     * Added BUG("unknown ident_part %d", part) to default case in
       ident_part() and removed redundant NULL checks on split.name_begin
       and split.mail_begin.
     * Adopted first-class int (*multiread)(struct string_list *) callback
       in struct git_var for multi-valued variables like GIT_CONFIG_GLOBAL,
       cleanly populating a struct string_list instead of relying on
       embedded NUL buffers.
     * Improved GIT_AUTHOR_* and GIT_COMMITTER_* documentation in
       Documentation/git-var.adoc to describe the values that would be used
       if you were to run git commit right now.
     * Explicitly documented that single-variable queries and git var -l do
       not print an extra delimiter after multi-valued variables.
    
    
    Changes since v4:
    =================
    
     * Simplified git_signing_key() to directly call get_signing_key() as
       used throughout Git (in tag, send-pack, and sign_buffer()).
     * Renamed null_term to nul_term across builtin/var.c, and simplified
       show_config() callback handling.
     * Replaced the redundant pre-validation loop in cmd_var() by validating
       arguments directly in the main execution loop.
     * When querying multiple variables, print an empty record (blank line
       or \0 with -z) for any variable that has no value, and continue
       printing remaining variables instead of terminating prematurely.
     * Switched multi-valued variable storage (git_config_val_global()) to
       internal \0 delimiters, iterating directly through string sequences
       without allocating a temporary string_list.
     * For multi-variable queries, output an extra delimiter (\n or \0)
       after multi-valued variables to clearly mark the end of their list.
     * Explicitly documented the git var -l -z format and multi-variable
       handling in Documentation/git-var.adoc.
     * Added comprehensive tests for unset variables and multi-valued stream
       delimiters in t/t0007-git-var.sh.
    
    
    Changes since v3:
    =================
    
     * Renamed GIT_DEFAULT_KEY to GIT_SIGNING_KEY per feedback from Phillip
       Wood and Junio C Hamano; dropped the alias mechanism and
       commit.gpgsign check.
     * Used parse_options() with PARSE_OPT_STOP_AT_NON_OPTION in
       builtin/var.c, strictly enforcing that options precede variable
       arguments.
     * Adopted git config list -z format (key\nvalue\0) for git var -l -z to
       prevent ambiguity with = in config keys.
     * Delimited multi-valued variable outputs (e.g. GIT_CONFIG_GLOBAL) with
       NUL bytes under -z.
     * Replaced char part in ident_part() with enum ident_part.
     * Split synopsis in Documentation/git-var.adoc into separate lines for
       -l and <variable>..., and removed awkward legacy phrasing ("of a
       piece of code").
     * Added tests in t/t0007-git-var.sh covering the new -z format,
       multi-valued -z, and argument ordering.
    
    
    Changes since v2:
    =================
    
     * Drop git ident / git whoami subcommand entirely.
     * Add GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE.
     * Add GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and GIT_COMMITTER_DATE.
     * Add GIT_SIGNING_KEY to resolve commit signing keys.
     * Teach git var to accept multiple variable arguments (git var <var1>
       <var2> ...).
     * Add -z option to terminate outputs with NUL bytes (including git var
       -l -z).
     * Update Documentation/git-var.adoc and t/t0007-git-var.sh.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2388%2Fanpl1623%2Fmaster-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2388/anpl1623/master-v7
Pull-Request: https://github.com/git/git/pull/2388

Range-diff vs v6:

 1:  3b51f61a11 ! 1:  87f5f459ed var: support broken-down idents, signing key, multiple args, and -z
     @@ Documentation/git-var.adoc: OPTIONS
       ---------
       `GIT_AUTHOR_IDENT`::
      -    The author of a piece of code.
     -+    The author name, email, and date that would be used if you were to
     -+    run `git commit` right now.
     -+
      +`GIT_AUTHOR_NAME`::
     -+    The author name that would be used if you were to run `git commit`
     -+    right now.
     -+
      +`GIT_AUTHOR_EMAIL`::
     -+    The author email that would be used if you were to run `git commit`
     -+    right now.
     -+
      +`GIT_AUTHOR_DATE`::
     -+    The author date and timezone that would be used if you were to run
     -+    `git commit` right now.
     ++    The authorship information that would be recorded in the
     ++    resulting commit object if you ran `git commit` right now.
     ++    `GIT_AUTHOR_IDENT` consists of the author's name, e-mail
     ++    address, and timestamp+timezone. These three pieces of
     ++    information are available separately as `GIT_AUTHOR_NAME`,
     ++    `GIT_AUTHOR_EMAIL`, and `GIT_AUTHOR_DATE`.
       
       `GIT_COMMITTER_IDENT`::
      -    The person who put a piece of code into Git.
     -+    The committer name, email, and date that would be used if you were
     -+    to run `git commit` right now.
     -+
      +`GIT_COMMITTER_NAME`::
     -+    The name of the committer that would be used if you were to run
     -+    `git commit` right now.
     -+
      +`GIT_COMMITTER_EMAIL`::
     -+    The email of the committer that would be used if you were to run
     -+    `git commit` right now.
     -+
      +`GIT_COMMITTER_DATE`::
     -+    The committer date and timezone that would be used if you were to run
     -+    `git commit` right now.
     ++    The committer information that would be recorded in the
     ++    resulting commit object if you ran `git commit` right now.
     ++    `GIT_COMMITTER_IDENT` consists of the committer's name, e-mail
     ++    address, and timestamp+timezone. These three pieces of
     ++    information are available separately as `GIT_COMMITTER_NAME`,
     ++    `GIT_COMMITTER_EMAIL`, and `GIT_COMMITTER_DATE`.
      +
      +`GIT_SIGNING_KEY`::
      +    The key that would be used to sign the resulting commit if you were
     @@ builtin/var.c
       #include "run-command.h"
      +#include "strbuf.h"
      +#include "string-list.h"
     -+
     + 
     +-static const char var_usage[] = "git var (-l | <variable>)";
      +static const char * const var_usage[] = {
      +	N_("git var [-z] -l"),
      +	N_("git var [-z] <variable>..."),
      +	NULL
      +};
     - 
     --static const char var_usage[] = "git var (-l | <variable>)";
     ++
      +enum ident_part {
      +	IDENT_NAME,
      +	IDENT_MAIL,
     @@ builtin/var.c
      +
      +	switch (part) {
      +	case IDENT_NAME:
     ++		if (!split.name_begin || !split.name_end)
     ++			BUG("split_ident_line() gave NULL names???");
      +		return xmemdupz(split.name_begin,
      +				split.name_end - split.name_begin);
      +	case IDENT_MAIL:
     ++		if (!split.mail_begin || !split.mail_end)
     ++			BUG("split_ident_line() gave NULL mail???");
      +		return xmemdupz(split.mail_begin,
      +				split.mail_end - split.mail_begin);
      +	case IDENT_DATE:
     -+		if (!split.date_begin)
     -+			return NULL;
     -+		if (split.tz_end)
     -+			return xmemdupz(split.date_begin,
     -+					split.tz_end -
     -+					split.date_begin);
     -+		if (split.date_end)
     -+			return xmemdupz(split.date_begin,
     -+					split.date_end -
     -+					split.date_begin);
     -+		return NULL;
     ++		if (!split.date_begin || !split.tz_end)
     ++			BUG("split_ident_line() gave NULL date/tz???");
     ++		return xmemdupz(split.date_begin,
     ++				split.tz_end - split.date_begin);
      +	default:
      +		BUG("unknown ident_part %d", part);
      +	}
     @@ builtin/var.c: static char *git_config_val_system(int ident_flag UNUSED)
       }
       
      -static char *git_config_val_global(int ident_flag UNUSED)
     -+static int git_config_val_global(struct string_list *list)
     ++static void git_config_val_global(struct string_list *list)
       {
      -	struct strbuf buf = STRBUF_INIT;
       	char *user, *xdg;
     @@ builtin/var.c: static char *git_config_val_system(int ident_flag UNUSED)
      -		return NULL;
      -	}
      -	return strbuf_detach(&buf, &unused);
     -+	return !list->nr;
       }
       
       struct git_var {
       	const char *name;
       	char *(*read)(int);
      -	int multivalued;
     -+	int (*multiread)(struct string_list *);
     ++	void (*multiread)(struct string_list *);
       };
       static struct git_var git_vars[] = {
       	{
     @@ builtin/var.c: static struct git_var git_vars[] = {
      +				free(val);
       			}
      -			free(val);
     -+		} else if (ptr->multiread) {
     ++		} else {
      +			struct string_list list = STRING_LIST_INIT_DUP;
      +			size_t i;
      +
     -+			if (!ptr->multiread(&list)) {
     -+				for (i = 0; i < list.nr; i++)
     -+					printf("%s%c%s%c", ptr->name, delim,
     -+					       list.items[i].string, term);
     -+			}
     ++			ptr->multiread(&list);
     ++			for (i = 0; i < list.nr; i++)
     ++				printf("%s%c%s%c", ptr->name, delim,
     ++				       list.items[i].string, term);
      +			string_list_clear(&list, 0);
       		}
      +	}
     @@ builtin/var.c: static const struct git_var *get_git_var(const char *var)
      -	char *val;
      +	int list = 0;
      +	int nul_term = 0;
     -+	int ret = 0;
      +	int i;
      +	char term;
      +	struct option options[] = {
     @@ builtin/var.c: static const struct git_var *get_git_var(const char *var)
      -	if (!git_var)
      -		usage(var_usage);
      +	term = nul_term ? '\0' : '\n';
     ++
     ++	for (i = 0; i < argc; i++) {
     ++		const struct git_var *git_var = get_git_var(argv[i]);
       
      -	val = git_var->read(IDENT_STRICT);
      -	if (!val)
      -		return 1;
     -+	for (i = 0; i < argc; i++) {
     -+		const struct git_var *git_var = get_git_var(argv[i]);
     ++		if (!git_var)
     ++			usage_with_options(var_usage, options);
       
      -	printf("%s\n", val);
      -	free(val);
     -+		if (!git_var)
     -+			usage_with_options(var_usage, options);
     -+
      +		if (git_var->read) {
      +			char *val = git_var->read(IDENT_STRICT);
      +
      +			if (!val) {
      +				if (argc == 1)
      +					return 1;
     -+				ret = 1;
     -+				printf("%c", term);
     ++				putc(term, stdout);
      +				continue;
      +			}
      +			printf("%s%c", val, term);
      +			free(val);
     -+		} else if (git_var->multiread) {
     ++		} else {
      +			struct string_list list = STRING_LIST_INIT_DUP;
      +			size_t j;
      +
     -+			if (git_var->multiread(&list) || !list.nr) {
     -+				if (argc == 1) {
     -+					string_list_clear(&list, 0);
     -+					return 1;
     -+				}
     -+				ret = 1;
     -+				printf("%c", term);
     -+			} else {
     -+				for (j = 0; j < list.nr; j++)
     -+					printf("%s%c", list.items[j].string, term);
     -+				if (argc > 1)
     -+					printf("%c", term);
     ++			git_var->multiread(&list);
     ++			if (argc == 1 && !list.nr) {
     ++				string_list_clear(&list, 0);
     ++				return 1;
      +			}
     ++			for (j = 0; j < list.nr; j++)
     ++				printf("%s%c", list.items[j].string, term);
     ++			if (argc > 1)
     ++				putc(term, stdout);
      +			string_list_clear(&list, 0);
      +		}
      +	}
       
     --	return 0;
     -+	return ret;
     + 	return 0;
       }
      
       ## t/t0007-git-var.sh ##
     @@ t/t0007-git-var.sh: test_expect_success '`git var -l` works even without HOME' '
      +
      +test_expect_success 'get multiple variables with -z' '
      +	test_tick &&
     -+	printf "%s\0" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
     -+	git var -z GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL >actual &&
     ++	printf "%sQ%sQ" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
     ++	git var -z GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL >actual.raw &&
     ++	nul_to_q <actual.raw >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'get multi-valued variable with -z' '
      +	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
     -+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" git var -z GIT_CONFIG_GLOBAL >actual &&
     -+	printf "%s\0" "$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" >expected &&
     -+	test_cmp expected actual
     ++	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" git var -z GIT_CONFIG_GLOBAL >actual.raw &&
     ++	printf "%sQ%sQ" "$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" >expect &&
     ++	nul_to_q <actual.raw >actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_expect_success 'git var -l -z' '
     @@ t/t0007-git-var.sh: test_expect_success '`git var -l` works even without HOME' '
      +
      +	$GIT_COMMITTER_NAME
      +	EOF
     -+	test_must_fail git var GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
     ++	git var GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'get multiple variables with -z and unset variable' '
      +	test_config user.signingkey "" &&
     -+	printf "%s\0\0%s\0" "$GIT_AUTHOR_NAME" "$GIT_COMMITTER_NAME" >expect &&
     -+	test_must_fail git var -z GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
     ++	printf "%sQ%sQ" "$GIT_AUTHOR_NAME" "Q$GIT_COMMITTER_NAME" >expect &&
     ++	git var -z GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual.raw &&
     ++	nul_to_q <actual.raw >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'get multiple variables including multi-valued variable with -z' '
      +	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
     -+	printf "%s\0%s\0%s\0\0%s\0" "$GIT_AUTHOR_NAME" \
     ++	printf "%sQ%sQ%sQQ%sQ" "$GIT_AUTHOR_NAME" \
      +		"$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" \
      +		"$GIT_AUTHOR_EMAIL" >expect &&
      +	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
     -+		git var -z GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual &&
     ++		git var -z GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual.raw &&
     ++	nul_to_q <actual.raw >actual &&
      +	test_cmp expect actual
      +'
      +


 Documentation/git-var.adoc |  66 ++++++++--
 builtin/var.c              | 252 +++++++++++++++++++++++++++++--------
 t/t0007-git-var.sh         | 127 +++++++++++++++++++
 3 files changed, 384 insertions(+), 61 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 697c10aded..ccbb9f8e8d 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -9,12 +9,16 @@ git-var - Show a Git logical variable
 SYNOPSIS
 --------
 [synopsis]
-git var (-l | <variable>)
+git var [-z] -l
+git var [-z] <variable>...
 
 DESCRIPTION
 -----------
-Prints a Git logical variable. Exits with code 1 if the variable has
-no value.
+Prints Git logical variables. Exits with code 1 if any requested
+variable has no value. When multiple variables are requested, an empty
+record (a blank line, or an empty NUL-terminated record when `-z` is given)
+is printed for any variable that has no value, and the command continues
+processing the remaining variables.
 
 OPTIONS
 -------
@@ -24,19 +28,55 @@ OPTIONS
 	as well. (However, the configuration variables listing functionality
 	is deprecated in favor of `git config list`.)
 
+`-z`::
+	Terminate entries with NUL instead of newline. When used with
+	`-l`, the variable name and its value are separated by a newline,
+	and each entry is terminated with a NUL byte.
+
 EXAMPLES
 --------
-	$ git var GIT_AUTHOR_IDENT
-	Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
-
+* Get the author identity:
++
+------------
+$ git var GIT_AUTHOR_IDENT
+Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
+------------
+
+* Get the author name and email:
++
+------------
+$ git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+Eric W. Biederman
+ebiederm@lnxi.com
+------------
 
 VARIABLES
 ---------
 `GIT_AUTHOR_IDENT`::
-    The author of a piece of code.
+`GIT_AUTHOR_NAME`::
+`GIT_AUTHOR_EMAIL`::
+`GIT_AUTHOR_DATE`::
+    The authorship information that would be recorded in the
+    resulting commit object if you ran `git commit` right now.
+    `GIT_AUTHOR_IDENT` consists of the author's name, e-mail
+    address, and timestamp+timezone. These three pieces of
+    information are available separately as `GIT_AUTHOR_NAME`,
+    `GIT_AUTHOR_EMAIL`, and `GIT_AUTHOR_DATE`.
 
 `GIT_COMMITTER_IDENT`::
-    The person who put a piece of code into Git.
+`GIT_COMMITTER_NAME`::
+`GIT_COMMITTER_EMAIL`::
+`GIT_COMMITTER_DATE`::
+    The committer information that would be recorded in the
+    resulting commit object if you ran `git commit` right now.
+    `GIT_COMMITTER_IDENT` consists of the committer's name, e-mail
+    address, and timestamp+timezone. These three pieces of
+    information are available separately as `GIT_COMMITTER_NAME`,
+    `GIT_COMMITTER_EMAIL`, and `GIT_COMMITTER_DATE`.
+
+`GIT_SIGNING_KEY`::
+    The key that would be used to sign the resulting commit if you were
+    to run `git commit` right now.
 
 `GIT_EDITOR`::
     Text editor for use by Git commands.  The value is meant to be
@@ -85,9 +125,13 @@ endif::git-default-pager[]
     The path to the global (per-user) configuration files, if any.
 
 Most path values contain only one value. However, some can contain multiple
-values, which are separated by newlines, and are listed in order from highest to
-lowest priority.  Callers should be prepared for any such path value to contain
-multiple items.
+values, which are separated by newlines (or NUL bytes if `-z` is given),
+and are listed in order from highest to lowest priority. When querying
+multiple variables, an extra newline (or an extra NUL byte if `-z` is
+given) is printed after the values of a multi-valued variable to mark the
+end of its list. (Single-variable queries and `git var -l` do not print
+an extra delimiter). Callers should be prepared for any such path value to
+contain multiple items.
 
 Note that paths are printed even if they do not exist, but not if they are
 disabled by other environment variables.
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..e8472ac722 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,25 +12,109 @@
 #include "config.h"
 #include "editor.h"
 #include "environment.h"
+#include "gpg-interface.h"
 #include "ident.h"
 #include "pager.h"
-#include "refs.h"
+#include "parse-options.h"
 #include "path.h"
-#include "strbuf.h"
+#include "refs.h"
 #include "run-command.h"
+#include "strbuf.h"
+#include "string-list.h"
 
-static const char var_usage[] = "git var (-l | <variable>)";
+static const char * const var_usage[] = {
+	N_("git var [-z] -l"),
+	N_("git var [-z] <variable>..."),
+	NULL
+};
+
+enum ident_part {
+	IDENT_NAME,
+	IDENT_MAIL,
+	IDENT_DATE,
+};
 
 static char *committer(int ident_flag)
 {
 	return xstrdup_or_null(git_committer_info(ident_flag));
 }
 
+static char *ident_part(const char *ident, enum ident_part part)
+{
+	struct ident_split split;
+
+	if (!ident)
+		return NULL;
+	if (split_ident_line(&split, ident, strlen(ident)))
+		return NULL;
+
+	switch (part) {
+	case IDENT_NAME:
+		if (!split.name_begin || !split.name_end)
+			BUG("split_ident_line() gave NULL names???");
+		return xmemdupz(split.name_begin,
+				split.name_end - split.name_begin);
+	case IDENT_MAIL:
+		if (!split.mail_begin || !split.mail_end)
+			BUG("split_ident_line() gave NULL mail???");
+		return xmemdupz(split.mail_begin,
+				split.mail_end - split.mail_begin);
+	case IDENT_DATE:
+		if (!split.date_begin || !split.tz_end)
+			BUG("split_ident_line() gave NULL date/tz???");
+		return xmemdupz(split.date_begin,
+				split.tz_end - split.date_begin);
+	default:
+		BUG("unknown ident_part %d", part);
+	}
+}
+
+static char *committer_name(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), IDENT_NAME);
+}
+
+static char *committer_email(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), IDENT_MAIL);
+}
+
+static char *committer_date(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), IDENT_DATE);
+}
+
 static char *author(int ident_flag)
 {
 	return xstrdup_or_null(git_author_info(ident_flag));
 }
 
+static char *author_name(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), IDENT_NAME);
+}
+
+static char *author_email(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), IDENT_MAIL);
+}
+
+static char *author_date(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), IDENT_DATE);
+}
+
+static char *git_signing_key(int ident_flag UNUSED)
+{
+	char *signing_key = get_signing_key();
+
+	if (signing_key && !*signing_key) {
+		free(signing_key);
+		return NULL;
+	}
+	return signing_key;
+}
+
 static char *editor(int ident_flag UNUSED)
 {
 	return xstrdup_or_null(git_editor());
@@ -90,45 +174,61 @@ static char *git_config_val_system(int ident_flag UNUSED)
 	return NULL;
 }
 
-static char *git_config_val_global(int ident_flag UNUSED)
+static void git_config_val_global(struct string_list *list)
 {
-	struct strbuf buf = STRBUF_INIT;
 	char *user, *xdg;
-	size_t unused;
 
 	git_global_config_paths(&user, &xdg);
 	if (xdg && *xdg) {
 		normalize_path_copy(xdg, xdg);
-		strbuf_addf(&buf, "%s\n", xdg);
+		string_list_append(list, xdg);
 	}
 	if (user && *user) {
 		normalize_path_copy(user, user);
-		strbuf_addf(&buf, "%s\n", user);
+		string_list_append(list, user);
 	}
 	free(xdg);
 	free(user);
-	strbuf_trim_trailing_newline(&buf);
-	if (buf.len == 0) {
-		strbuf_release(&buf);
-		return NULL;
-	}
-	return strbuf_detach(&buf, &unused);
 }
 
 struct git_var {
 	const char *name;
 	char *(*read)(int);
-	int multivalued;
+	void (*multiread)(struct string_list *);
 };
 static struct git_var git_vars[] = {
 	{
 		.name = "GIT_COMMITTER_IDENT",
 		.read = committer,
 	},
+	{
+		.name = "GIT_COMMITTER_NAME",
+		.read = committer_name,
+	},
+	{
+		.name = "GIT_COMMITTER_EMAIL",
+		.read = committer_email,
+	},
+	{
+		.name = "GIT_COMMITTER_DATE",
+		.read = committer_date,
+	},
 	{
 		.name = "GIT_AUTHOR_IDENT",
 		.read = author,
 	},
+	{
+		.name = "GIT_AUTHOR_NAME",
+		.read = author_name,
+	},
+	{
+		.name = "GIT_AUTHOR_EMAIL",
+		.read = author_email,
+	},
+	{
+		.name = "GIT_AUTHOR_DATE",
+		.read = author_date,
+	},
 	{
 		.name = "GIT_EDITOR",
 		.read = editor,
@@ -145,6 +245,10 @@ static struct git_var git_vars[] = {
 		.name = "GIT_DEFAULT_BRANCH",
 		.read = default_branch,
 	},
+	{
+		.name = "GIT_SIGNING_KEY",
+		.read = git_signing_key,
+	},
 	{
 		.name = "GIT_SHELL_PATH",
 		.read = shell_path,
@@ -163,8 +267,7 @@ static struct git_var git_vars[] = {
 	},
 	{
 		.name = "GIT_CONFIG_GLOBAL",
-		.read = git_config_val_global,
-		.multivalued = 1,
+		.multiread = git_config_val_global,
 	},
 	{
 		.name = "",
@@ -172,31 +275,37 @@ static struct git_var git_vars[] = {
 	},
 };
 
-static void list_vars(void)
+static void list_vars(int nul_term)
 {
 	struct git_var *ptr;
-	char *val;
+	char delim = nul_term ? '\n' : '=';
+	char term = nul_term ? '\0' : '\n';
 
-	for (ptr = git_vars; ptr->read; ptr++)
-		if ((val = ptr->read(0))) {
-			if (ptr->multivalued && *val) {
-				struct string_list list = STRING_LIST_INIT_DUP;
+	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {
+		if (ptr->read) {
+			char *val = ptr->read(0);
 
-				string_list_split(&list, val, "\n", -1);
-				for (size_t i = 0; i < list.nr; i++)
-					printf("%s=%s\n", ptr->name, list.items[i].string);
-				string_list_clear(&list, 0);
-			} else {
-				printf("%s=%s\n", ptr->name, val);
+			if (val) {
+				printf("%s%c%s%c", ptr->name, delim, val, term);
+				free(val);
 			}
-			free(val);
+		} else {
+			struct string_list list = STRING_LIST_INIT_DUP;
+			size_t i;
+
+			ptr->multiread(&list);
+			for (i = 0; i < list.nr; i++)
+				printf("%s%c%s%c", ptr->name, delim,
+				       list.items[i].string, term);
+			string_list_clear(&list, 0);
 		}
+	}
 }
 
 static const struct git_var *get_git_var(const char *var)
 {
 	struct git_var *ptr;
-	for (ptr = git_vars; ptr->read; ptr++) {
+	for (ptr = git_vars; ptr->read || ptr->multiread; ptr++) {
 		if (strcmp(var, ptr->name) == 0) {
 			return ptr;
 		}
@@ -207,42 +316,85 @@ static const struct git_var *get_git_var(const char *var)
 static int show_config(const char *var, const char *value,
 		       const struct config_context *ctx, void *cb)
 {
+	int *nul_term = cb;
+	char delim = *nul_term ? '\n' : '=';
+	char term = *nul_term ? '\0' : '\n';
+
 	if (value)
-		printf("%s=%s\n", var, value);
+		printf("%s%c%s%c", var, delim, value, term);
 	else
-		printf("%s\n", var);
+		printf("%s%c", var, term);
 	return git_default_config(var, value, ctx, cb);
 }
 
 int cmd_var(int argc,
 	    const char **argv,
-	    const char *prefix UNUSED,
+	    const char *prefix,
 	    struct repository *repo UNUSED)
 {
-	const struct git_var *git_var;
-	char *val;
+	int list = 0;
+	int nul_term = 0;
+	int i;
+	char term;
+	struct option options[] = {
+		OPT_BOOL('l', NULL, &list,
+			 N_("list all variables")),
+		OPT_BOOL('z', NULL, &nul_term,
+			 N_("terminate entries with NUL")),
+		OPT_END(),
+	};
 
-	show_usage_if_asked(argc, argv, var_usage);
-	if (argc != 2)
-		usage(var_usage);
+	argc = parse_options(argc, argv, prefix, options,
+			     var_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (strcmp(argv[1], "-l") == 0) {
-		repo_config(the_repository, show_config, NULL);
-		list_vars();
+	if (list) {
+		if (argc)
+			usage_with_options(var_usage, options);
+		repo_config(the_repository, show_config, &nul_term);
+		list_vars(nul_term);
 		return 0;
 	}
+
+	if (!argc)
+		usage_with_options(var_usage, options);
+
 	repo_config(the_repository, git_default_config, NULL);
 
-	git_var = get_git_var(argv[1]);
-	if (!git_var)
-		usage(var_usage);
+	term = nul_term ? '\0' : '\n';
+
+	for (i = 0; i < argc; i++) {
+		const struct git_var *git_var = get_git_var(argv[i]);
 
-	val = git_var->read(IDENT_STRICT);
-	if (!val)
-		return 1;
+		if (!git_var)
+			usage_with_options(var_usage, options);
 
-	printf("%s\n", val);
-	free(val);
+		if (git_var->read) {
+			char *val = git_var->read(IDENT_STRICT);
+
+			if (!val) {
+				if (argc == 1)
+					return 1;
+				putc(term, stdout);
+				continue;
+			}
+			printf("%s%c", val, term);
+			free(val);
+		} else {
+			struct string_list list = STRING_LIST_INIT_DUP;
+			size_t j;
+
+			git_var->multiread(&list);
+			if (argc == 1 && !list.nr) {
+				string_list_clear(&list, 0);
+				return 1;
+			}
+			for (j = 0; j < list.nr; j++)
+				printf("%s%c", list.items[j].string, term);
+			if (argc > 1)
+				putc(term, stdout);
+			string_list_clear(&list, 0);
+		}
+	}
 
 	return 0;
 }
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 2b60317758..75f688a1b1 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -276,4 +276,131 @@ test_expect_success '`git var -l` works even without HOME' '
 	)
 '
 
+test_expect_success 'get author identity components' '
+	test_tick &&
+	echo "$GIT_AUTHOR_NAME" >expect.name &&
+	echo "$GIT_AUTHOR_EMAIL" >expect.email &&
+	echo "$GIT_AUTHOR_DATE" >expect.date &&
+	git var GIT_AUTHOR_NAME >actual.name &&
+	git var GIT_AUTHOR_EMAIL >actual.email &&
+	git var GIT_AUTHOR_DATE >actual.date &&
+	test_cmp expect.name actual.name &&
+	test_cmp expect.email actual.email &&
+	test_cmp expect.date actual.date
+'
+
+test_expect_success 'get committer identity components' '
+	test_tick &&
+	echo "$GIT_COMMITTER_NAME" >expect.name &&
+	echo "$GIT_COMMITTER_EMAIL" >expect.email &&
+	echo "$GIT_COMMITTER_DATE" >expect.date &&
+	git var GIT_COMMITTER_NAME >actual.name &&
+	git var GIT_COMMITTER_EMAIL >actual.email &&
+	git var GIT_COMMITTER_DATE >actual.date &&
+	test_cmp expect.name actual.name &&
+	test_cmp expect.email actual.email &&
+	test_cmp expect.date actual.date
+'
+
+test_expect_success 'get multiple variables' '
+	test_tick &&
+	cat >expect <<-EOF &&
+	$GIT_AUTHOR_NAME
+	$GIT_AUTHOR_EMAIL
+	$GIT_COMMITTER_NAME
+	$GIT_COMMITTER_EMAIL
+	EOF
+	git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables with -z' '
+	test_tick &&
+	printf "%sQ%sQ" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
+	git var -z GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multi-valued variable with -z' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" git var -z GIT_CONFIG_GLOBAL >actual.raw &&
+	printf "%sQ%sQ" "$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" >expect &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git var -l -z' '
+	git var -l -z >actual &&
+	tr "\0" "\n" <actual >actual.lines &&
+	echo "$GIT_AUTHOR_NAME" >expect &&
+	sed -n "/^GIT_AUTHOR_NAME$/{n;p;}" actual.lines >actual.author &&
+	test_cmp expect actual.author &&
+	echo false >expect &&
+	sed -n "/^core\.bare$/{n;p;}" actual.lines >actual.bare &&
+	test_cmp expect actual.bare
+'
+
+test_expect_success 'get GIT_SIGNING_KEY with user.signingkey configured' '
+	test_config user.signingkey "TEST_KEY_ID" &&
+	echo "TEST_KEY_ID" >expect &&
+	git var GIT_SIGNING_KEY >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get GIT_SIGNING_KEY fails when unset' '
+	test_config user.signingkey "" &&
+	test_must_fail git var GIT_SIGNING_KEY
+'
+
+test_expect_success 'git var -l lists new variables' '
+	git var -l >actual &&
+	test_grep "^GIT_AUTHOR_NAME=" actual &&
+	test_grep "^GIT_AUTHOR_EMAIL=" actual &&
+	test_grep "^GIT_AUTHOR_DATE=" actual &&
+	test_grep "^GIT_COMMITTER_NAME=" actual &&
+	test_grep "^GIT_COMMITTER_EMAIL=" actual &&
+	test_grep "^GIT_COMMITTER_DATE=" actual
+'
+
+test_expect_success 'git var -l lists GIT_SIGNING_KEY when configured' '
+	test_config user.signingkey "TEST_KEY_ID" &&
+	git var -l >actual &&
+	test_grep "^GIT_SIGNING_KEY=TEST_KEY_ID" actual
+'
+
+test_expect_success 'options must precede variable arguments' '
+	test_must_fail git var GIT_AUTHOR_NAME -z
+'
+
+test_expect_success 'get multiple variables with unset variable outputs blank record' '
+	test_config user.signingkey "" &&
+	cat >expect <<-EOF &&
+	$GIT_AUTHOR_NAME
+
+	$GIT_COMMITTER_NAME
+	EOF
+	git var GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables with -z and unset variable' '
+	test_config user.signingkey "" &&
+	printf "%sQ%sQ" "$GIT_AUTHOR_NAME" "Q$GIT_COMMITTER_NAME" >expect &&
+	git var -z GIT_AUTHOR_NAME GIT_SIGNING_KEY GIT_COMMITTER_NAME >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get multiple variables including multi-valued variable with -z' '
+	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
+	printf "%sQ%sQ%sQQ%sQ" "$GIT_AUTHOR_NAME" \
+		"$TRASHDIR/foo/git/config" "$TRASHDIR/.gitconfig" \
+		"$GIT_AUTHOR_EMAIL" >expect &&
+	HOME="$TRASHDIR" XDG_CONFIG_HOME="$TRASHDIR/foo" \
+		git var -z GIT_AUTHOR_NAME GIT_CONFIG_GLOBAL GIT_AUTHOR_EMAIL >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
-- 
gitgitgadget
