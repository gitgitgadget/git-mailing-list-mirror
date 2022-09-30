Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D32C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiI3LAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiI3LA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:00:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1B61D8495
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 03:38:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so6175390wrb.13
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=EgATJ0M2wouHHwT5p03WQ8IxzYCXwHeEtCdeT1ydhO8=;
        b=S9PhT/CxcOQKG/IrMerTeuDJjHnNZVtIX7Giqwupgebp36Mipq3E8AfIAS0onR3G5N
         Ecj8Mvq1FKybImuwJEjVYRc5t9//DJmWqVyRYc1bfTFyWr12fCJW46QoEHtO5PBPQcQv
         bRkno9eb6vka+CGzefb+9B5MFJN3LCWDdMaT6aElko4pDAr9wd9HtgqOY7HwhGb3WOW3
         xC43R2Cam6ypidTZ16E4X4imH1nF5kZkeNbgbsl49XnyHh4C/ytlZ+ew8ZRuC02dXIl2
         QUwvxhY59/oWEr+9XHJ3aauE7vtHA7X0WxNk5S569wvPnsRISYhhsJDy6TzZfSRhF+eW
         OP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EgATJ0M2wouHHwT5p03WQ8IxzYCXwHeEtCdeT1ydhO8=;
        b=N1+YJ4x0k3WfeQ6vPgAC6XuCati1taNaxhyCJGQIMmEH2v0VOW8F1KBsmJigkqdmHp
         8t5Ftw6aE3oFkYJllkCh/CUqso0Io7jGeXViQ9HvfvXtKa99iDtt5oFK8Txlm7FWsV/k
         2u8V47D1eQr/JvBht3vKWuwQdJKYcMCO/RsATo9e/WQj2U0uAyPaltIvY3M9rMJd6Oh7
         L/ErsVJ3mdXmmxcsq+9uQbZZMgx/3EsdhESnVTWwMoppKtl0R1dEkD4VeodlloBwPM8F
         OnQuZiaMga7QYEPFUMR3VpEXPxX+MS2BxbczkrGs8IKGBQji0JlyuCCeCcU20EgPfNv2
         c1XA==
X-Gm-Message-State: ACrzQf23Wk702wvHey8FD9n38vfGo7s7Dmni2m0/uFXVCjWz6Uecp2c6
        OfKKkBOSadcSCX19lbFCx497ndxzfkY=
X-Google-Smtp-Source: AMsMyM7VbK9douQIMH5NAPG3nRf7qM/pRSBt0JxP8wboc9kjOhzoU+R1rl5zCxvkymt6J/w+hg3O4A==
X-Received: by 2002:a17:907:7625:b0:779:e6f7:a669 with SMTP id jy5-20020a170907762500b00779e6f7a669mr5998047ejc.472.1664533758049;
        Fri, 30 Sep 2022 03:29:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d12-20020a056402144c00b00457618d3409sm1402092edx.68.2022.09.30.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:29:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oeDGe-001edr-2F;
        Fri, 30 Sep 2022 12:29:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: do not fail a no-op --edit-desc
Date:   Fri, 30 Sep 2022 12:21:48 +0200
References: <xmqqczbftina.fsf@gitster.g> <xmqq8rm1mz1d.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq8rm1mz1d.fsf@gitster.g>
Message-ID: <220930.86v8p5updv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 29 2022, Junio C Hamano wrote:

> Imagine running "git branch --edit-description" on a branch without
> a branch description, and then exit the editor after emptying the
> edit buffer, which is the way to tell the command that you changed
> your mind and you do not want the description after all.
>
> The command should just happily oblige, adding no branch description
> for the current branch, and exit successfully.  But it fails to do
> so:
>
>     $ git init -b main
>     $ git commit --allow-empty -m commit
>     $ GIT_EDITOR=: git branch --edit-description
>     fatal: could not unset 'branch.main.description'
>
> The end result is OK in that the configuration variable does not
> exist in the resulting repository, but we should do better, by using
> git_config_set_gently() and ignoring only the specific error that is
> returned when removing a missing configuration variable.
>
> A nice side effect is that it allows us to give a pair of messages
> that are tailored to the situation.  Instead of reporting a failure
> to set or unset a configuration variable "branch.X.description", we
> can report that we failed to set or unset the description for branch
> X, allowing the user to be oblivious to the irrelevant detail that
> the branch description is implemented as a configuration variable.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * So, this is the "other" implementation.  It is a bit more code
>    than the simpler one, but may be OK.  I labeled this as v2 but I
>    do not mean I consider this one is an improved version of the
>    other one.  They are merely alternatives.
>
>  builtin/branch.c  | 13 ++++++++++++-
>  t/t3200-branch.sh |  3 +++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git c/builtin/branch.c w/builtin/branch.c
> index 5d00d0b8d3..033d8bd29b 100644
> --- c/builtin/branch.c
> +++ w/builtin/branch.c
> @@ -606,6 +606,7 @@ static int edit_branch_description(const char *branch_name)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	struct strbuf name = STRBUF_INIT;
> +	int status;
>  
>  	read_branch_desc(&buf, branch_name);
>  	if (!buf.len || buf.buf[buf.len-1] != '\n')
> @@ -624,7 +625,17 @@ static int edit_branch_description(const char *branch_name)
>  	strbuf_stripspace(&buf, 1);
>  
>  	strbuf_addf(&name, "branch.%s.description", branch_name);
> -	git_config_set(name.buf, buf.len ? buf.buf : NULL);
> +
> +	status = git_config_set_gently(name.buf, buf.len ? buf.buf : NULL);
> +	if (status && !(status == CONFIG_NOTHING_SET && !buf.len)) {
> +		if (buf.len)
> +			die(_("failed to set description for branch '%s'"), 
> +			    branch_name);
> +		else
> +			die(_("failed to unset description for branch '%s'"), 
> +			    branch_name);
> +	}
> +

I was curious to follow up on your suggestion in your 3rd paragraph, so
I tried implementing this in the config API, results below, if you're
interested in it assume my SOB.

But, having done that I discovered that your code here has a bug,
admittedly a pretty obscure one. The CONFIG_NOTHING_SET flag on "set"
doesn't mean "nothing to set, because it's there already", it means
"either <that>, or the key is multi-value and I'm bailing out".


Which, with my patch below we can see in action with the then-one
remaining user of CONFIG_NOTHING_SET:
	
	0 $ git grep -n -C3 CONFIG_NOTHING_SET
	builtin/config.c-862-           value = normalize_value(argv[0], argv[1]);
	builtin/config.c-863-           UNLEAK(value);
	builtin/config.c-864-           ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
	builtin/config.c:865:           if (ret == CONFIG_NOTHING_SET)
	builtin/config.c-866-                   error(_("cannot overwrite multiple values with a single value\n"
	builtin/config.c-867-                   "       Use a regexp, --add or --replace-all to change %s."), argv[0]);
	builtin/config.c-868-           return ret;

The way that's buggy with your patch is if you have a config like:

	[branch "master"]
	description = foo
	description = bar

Then --edit-description and get "bar" in your $EDITOR, change it to an
empty buffer and save it, previously we'd error out, after we'll report
success, but leave the double-value'd config in place.

I think the obvious fix is to continue with what I have below, and then
simply change what the CONFIG_NOTHING_SET flag means, and to have it
only mean "the config was in this state already, nothing to do".

Which, come to think of it also means that all the existing callers
except that one caller in config.c are probably buggy.

diff --git a/builtin/branch.c b/builtin/branch.c
index a1bbdd79458..fa8f08290ea 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -601,7 +601,6 @@ static int edit_branch_description(const char *branch_name)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf name = STRBUF_INIT;
-	int status;
 
 	read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
@@ -621,16 +620,8 @@ static int edit_branch_description(const char *branch_name)
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
 
-	status = git_config_set_gently(name.buf, buf.len ? buf.buf : NULL);
-	if (status && !(status == CONFIG_NOTHING_SET && !buf.len)) {
-		if (buf.len)
-			die(_("failed to set description for branch '%s'"), 
-			    branch_name);
-		else
-			die(_("failed to unset description for branch '%s'"), 
-			    branch_name);
-	}
-
+	git_config_set_multivar(name.buf, buf.len ? buf.buf : NULL, NULL,
+				CONFIG_FLAGS_IGNORE_NOTHING_SET);
 	strbuf_release(&name);
 	strbuf_release(&buf);
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 985b845a18b..54163cd3a78 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -665,12 +665,8 @@ static void handle_push_default(const char* old_name, const char* new_name)
 	if (push_default.scope >= CONFIG_SCOPE_COMMAND)
 		; /* pass */
 	else if (push_default.scope >= CONFIG_SCOPE_LOCAL) {
-		int result = git_config_set_gently("remote.pushDefault",
-						   new_name);
-		if (new_name && result && result != CONFIG_NOTHING_SET)
-			die(_("could not set '%s'"), "remote.pushDefault");
-		else if (!new_name && result && result != CONFIG_NOTHING_SET)
-			die(_("could not unset '%s'"), "remote.pushDefault");
+		git_config_set_multivar("remote.pushDefault", new_name, NULL,
+					CONFIG_FLAGS_IGNORE_NOTHING_SET);
 	} else if (push_default.scope >= CONFIG_SCOPE_SYSTEM) {
 		/* warn */
 		warning(_("The %s configuration remote.pushDefault in:\n"
@@ -889,17 +885,15 @@ static int rm(int argc, const char **argv, const char *prefix)
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "branch.%s.%s",
 						item->string, *k);
-				result = git_config_set_gently(buf.buf, NULL);
-				if (result && result != CONFIG_NOTHING_SET)
-					die(_("could not unset '%s'"), buf.buf);
+				git_config_set_multivar(buf.buf, NULL, NULL,
+							CONFIG_FLAGS_IGNORE_NOTHING_SET);
 			}
 		}
 		if (info->push_remote_name && !strcmp(info->push_remote_name, remote->name)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.pushremote", item->string);
-			result = git_config_set_gently(buf.buf, NULL);
-			if (result && result != CONFIG_NOTHING_SET)
-				die(_("could not unset '%s'"), buf.buf);
+			git_config_set_multivar(buf.buf, NULL, NULL,
+						CONFIG_FLAGS_IGNORE_NOTHING_SET);
 		}
 	}
 
diff --git a/config.c b/config.c
index cbb5a3bab74..57ec50208b3 100644
--- a/config.c
+++ b/config.c
@@ -3245,7 +3245,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		}
 		/* if nothing to unset, error out */
 		if (!value) {
-			ret = CONFIG_NOTHING_SET;
+			ret = flags & CONFIG_FLAGS_IGNORE_NOTHING_SET ?
+				0 : CONFIG_NOTHING_SET;
 			goto out_free;
 		}
 
@@ -3309,7 +3310,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		/* if nothing to unset, or too many matches, error out */
 		if ((store.seen_nr == 0 && value == NULL) ||
 		    (store.seen_nr > 1 && !store.multi_replace)) {
-			ret = CONFIG_NOTHING_SET;
+			ret = flags & CONFIG_FLAGS_IGNORE_NOTHING_SET ?
+				0 : CONFIG_NOTHING_SET;
 			goto out_free;
 		}
 
diff --git a/config.h b/config.h
index ca994d77147..b491479a863 100644
--- a/config.h
+++ b/config.h
@@ -299,6 +299,12 @@ int git_config_parse_key(const char *, char **, size_t *);
  */
 #define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
 
+/*
+ * When CONFIG_FLAGS_NOTHING_SET is specified the non-gentle
+ * git_config_set_*() functions will ignore a CONFIG_NOTHING_SET.
+ */
+#define CONFIG_FLAGS_IGNORE_NOTHING_SET (1 << 2)
+
 int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
 void git_config_set_multivar(const char *, const char *, const char *, unsigned);
 int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
