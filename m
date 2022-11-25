Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C574C4167B
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 16:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKYQwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 11:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiKYQwh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 11:52:37 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF05B1D8
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 08:52:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so3840381wms.0
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 08:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcXlR0h72ZdBeZdt5CS5JyegptARI2JNFD8zhuGiBsk=;
        b=ayNjDCbwTVPgojfhGtvtq1g2Nk6eQwaJUTK/n/CDK8hGBUAsvZDru20NE73+iWXh4R
         N0+0cFLCSf9zz96jUbhrTjUU+ITWfI2BhjRkOGJwsLa3nfZiG7n63uocuOqmDsSC27er
         K0ETNOfxVal8goiLQV0SkX4C1vLk1iE71VHMDoOn5hpfHaEuL+dDwY4Pt5T7xXkcKPLJ
         lz8VF64Zs7nMSOQPGlOT92v1K5k63AUUmDG6PdpiDu1Rp/c3+yWxb7X+G9BDs2SVLu6N
         4FH8kcdl6uli541VqBhPJ7ouFxBMkxaWYYIMJHCh0lkBfyhdTjIF7rdLH3cC5x2/Vtwg
         lYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcXlR0h72ZdBeZdt5CS5JyegptARI2JNFD8zhuGiBsk=;
        b=xkiCRvw8oZHs9LzA1+jpkUDqgYV++CqZ/JO7mXZ3N/cIu57TwE3tGkSJFzSCiOErPw
         KyjPXso2imV5vd+07NdLaMFzUXJuvHhe70r/zvjP9CRMgJK4YYkG2ozbEaZ/QFAtsk9v
         X6A7ih3p4uV3S8xwW8N2z/BcmBvTvCsyRIq9Qjrz/abHg+Ys3rN7jPH9wP1RZ7kh4az/
         PilArDWscBevXgBPV0WyQfSXNVaEkTDnypRHt2YlCeI1uN8MJoyKugY9wA8VWv9jfH2d
         vk7Ed0HmcNbPgyszfiKHaYPAHkZmT5Z+Yrlh9+HimAzWM9h3IU9r/+w3jKBckm5KLgVh
         /3Wg==
X-Gm-Message-State: ANoB5pku2k/RiOUtAka7++e49NIANo/JQc30JWJ0fDQlQoPSaCLEkpCE
        IX8zpYgXhaXQRpniSXOa2juP8oMtO8E=
X-Google-Smtp-Source: AA0mqf40Q/EXZ13Ug0sHBb990Ec/yUuVYJxcSzcd8+dSz9QHlzHz2ksURvh/sFIaVxseRRskNd54Aw==
X-Received: by 2002:a05:600c:4a9a:b0:3c6:d811:6cff with SMTP id b26-20020a05600c4a9a00b003c6d8116cffmr32882390wmp.43.1669395153028;
        Fri, 25 Nov 2022 08:52:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b003cf37c5ddc0sm6302703wmq.22.2022.11.25.08.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 08:52:32 -0800 (PST)
Message-Id: <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
In-Reply-To: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 16:52:29 +0000
Subject: [PATCH v2 0/2] Improve consistency of git-var
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series makes a few distinct improvements to git-var to support
the change to git_editor() prompted [here][1] and ultimately support that
patch to introduce GIT_SEQUENCE_EDITOR as a handled logical variable.

Changes since v1:

 * Fix a whitespace issue in var.c:editor() (where I have my editor
   configured to use spaces instead of tabs; whoops)
 * Squash this down to two patches as suggested. I typically organize my
   commits to make it clear they don't actively break something, but I can
   certainly see the value in organizing them differently when there is
   already an extremely robust body of automated tests like there is for
   Git.
 * Rebased on current main; no conflicts.

Sean Allred (2):
  var: do not print usage() with a correct invocation
  var: allow GIT_EDITOR to return null

 Documentation/git-var.txt |  3 +-
 builtin/var.c             | 26 +++++++--------
 t/t0007-git-var.sh        | 69 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 15 deletions(-)


base-commit: c000d916380bb59db69c78546928eadd076b9c7d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1434%2Fvermiculus%2Fsa%2Fvar-improvements-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1434/vermiculus/sa/var-improvements-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1434

Range-diff vs v1:

 1:  d5f571f0bb3 ! 1:  a7ff842a3e8 var: do not print usage() with a correct invocation
     @@ builtin/var.c: static void list_vars(void)
       			printf("%s=%s\n", ptr->name, val);
       }
       
     +-static const char *read_var(const char *var)
      +static const struct git_var *get_git_var(const char *var)
     -+{
     -+	struct git_var *ptr;
     -+	for (ptr = git_vars; ptr->read; ptr++) {
     -+		if (strcmp(var, ptr->name) == 0) {
     -+			return ptr;
     -+		}
     -+	}
     -+	return NULL;
     -+}
     -+
     - static const char *read_var(const char *var)
       {
       	struct git_var *ptr;
     +-	const char *val;
     +-	val = NULL;
     + 	for (ptr = git_vars; ptr->read; ptr++) {
     + 		if (strcmp(var, ptr->name) == 0) {
     +-			val = ptr->read(IDENT_STRICT);
     +-			break;
     ++			return ptr;
     + 		}
     + 	}
     +-	return val;
     ++	return NULL;
     + }
     + 
     + static int show_config(const char *var, const char *value, void *cb)
      @@ builtin/var.c: static int show_config(const char *var, const char *value, void *cb)
       
       int cmd_var(int argc, const char **argv, const char *prefix)
     @@ builtin/var.c: int cmd_var(int argc, const char **argv, const char *prefix)
       		return 0;
       	}
       	git_config(git_default_config, NULL);
     +-	val = read_var(argv[1]);
     +-	if (!val)
      +
      +	git_var = get_git_var(argv[1]);
      +	if (!git_var)
     -+		usage(var_usage);
     -+
     - 	val = read_var(argv[1]);
     - 	if (!val)
     --		usage(var_usage);
     -+		return 1;
     + 		usage(var_usage);
       
     ++	val = git_var->read(IDENT_STRICT);
     ++	if (!val)
     ++		return 1;
     ++
       	printf("%s\n", val);
       
     + 	return 0;
 2:  905b109b458 < -:  ----------- var: remove read_var
 3:  8d49a718038 ! 2:  427cb7b55ac var: allow GIT_EDITOR to return null
     @@ builtin/var.c: static const char var_usage[] = "git var (-l | <variable>)";
      -		die("Terminal is dumb, but EDITOR unset");
      -
      -	return pgm;
     -+    return git_editor();
     ++	return git_editor();
       }
       
       static const char *pager(int flag)

-- 
gitgitgadget
