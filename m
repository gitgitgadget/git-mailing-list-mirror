Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203932222AE
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801966; cv=none; b=MReSUSWv0FQTnee9LsEaBHQIM8/PbL8LQgvcWHG1KRD90sU/7FyJsVMXnSFf75RUYza78q4Sae4RcwbeQ+hGUs0LqfoVu/0lPd9H+EE8taO1EFijjpfDQqCAVfaStxmazzRNGwCzUGW+OQN9JhVwn9o/lxr6dxCDzUEBNON4ST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801966; c=relaxed/simple;
	bh=NfWsFzSYOIgGKmxLzAzG22yo0d+9EJEBg1zlDSQE3Zs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OJsIWJVb3x9ibZC/GtCid0CFFjIfuvaA4STXCyhy0wdYx4weCVSQ+lS1QEG+ELN5aV1HeoaUf/fTkGShsDd2ZS2pfYgi1xdNYSrrd4542+60QGGr+OWYCFosNSr+eDHqAanUUUnVmLU7Vqks0jdtZeNnSdIYQnR8V8E7Rd/Yyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz4BY07z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz4BY07z"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f3ac22948so766416f8f.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 06:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739801962; x=1740406762; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BphjqXivp+kbr6jdwKp7aprdZi7Zp9najoHip7ZnufA=;
        b=bz4BY07zqbFkqQtBTA8gzybiMqh0tKmBmvoAk7sBhIv1lB1YSSaawktMwxOuxtbaVm
         r2wbm/s/3cu3k7Rb5DH+if6ZtzeaTbXWIYlq9JPBZehzduuzCqxTPoO9KT7yiwxFfC8y
         t4nevMMUczD7cDTG03umjf2Bx1h4xoAQLjryn67koRkhvm9+ssIfGMgB6EjSIwUzd02T
         tFNIljjHXN4bw1QJuX8Zxoo4QwDqeoKSrgJ/JL6rlntGZDdT/MPqWZ1ztGFetOa0GcDy
         eSimweytG0hQzgNqw54gUrX4cmRvrSnshzA5Xzf6S459gzv8EaMLbi65B5PZ/8NWhOBw
         qXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801962; x=1740406762;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BphjqXivp+kbr6jdwKp7aprdZi7Zp9najoHip7ZnufA=;
        b=HF7agslt2+tKLFf6KeRAEKjSZnA3lrYucrt0ZRVXhIzbTg0tLEWd2jPFLv5uAT1eqy
         vpmSnCbrPvRYgYgYTwAfvAqGU+aLaN6nzVsoeowGZhuFOxDQ1Yfl4RpzDr4s7AD5RL3g
         cmURZmqDxaYdHiZvL2EjgYPDhn+DVuq4kjSnE8rlhZh4gs6oVt5qhU+m51haF5K7pKCL
         tKTPH0oqsca+CIJDT90f7RTUtDh8oY+p8xb8EdhurqkMtArghdTiC0baHJ/vHv33uWlH
         1BWdzdDWAFetCYLrah2pv0+h4XorqhFR72b8/zhRUkzmuUlxWW+DsEDRAmuoA9qRzTlL
         TDmA==
X-Gm-Message-State: AOJu0YysmzhE1h7R2DDZf9WMm6L0m7lTU84ogGiX3RjAjqWoW8U5XLWo
	G1zpDCttMD5gSA3/powf7dZB8K00SjpAmVCZrbLdJ4UMAGL54bxbU8YhSA==
X-Gm-Gg: ASbGnct+LLEIKomhQk5+rtO3pc7UrKnGEc8VoMtI9vMsJAm9JCYRfAmjBuB055kGjyx
	eHWP2aM9XUj4jkANKdhuYdDTnA/xzFkjJ354vvPCN8BGUdurbI+TqdDZ2iwRfds9fLLJQKknotl
	dN5sZVSn0PfAs50seokrszryJedL0k1iw8wbs1pXUmJnlmuKjRk2eEH2jEbDouJswG0iEElzfkh
	n+TrllvALdmI1rWr3oqPnvJeNxwiuwyr7jArZSSZZQygtKkGPCKF/oqEi3RZTmjZakPzFyJNkfc
	Bxt2g1LRDZ7mCi9i
X-Google-Smtp-Source: AGHT+IEkR1feTjH3IrFTB3IGKstxU19dzIK4j4XaHPAIMLqCmEfUnewM0Da01VSFQ9pnlQvCnhHNUA==
X-Received: by 2002:a05:6000:1fa7:b0:38f:4cb4:b822 with SMTP id ffacd0b85a97d-38f4cb4ce41mr1652043f8f.26.1739801961640;
        Mon, 17 Feb 2025 06:19:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25913f5asm12550179f8f.52.2025.02.17.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:19:21 -0800 (PST)
Message-Id: <pull.1852.v2.git.1739801960334.gitgitgadget@gmail.com>
In-Reply-To: <pull.1852.git.1736933815236.gitgitgadget@gmail.com>
References: <pull.1852.git.1736933815236.gitgitgadget@gmail.com>
From: "Chris Howlett via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Feb 2025 14:19:20 +0000
Subject: [PATCH v2] help: add prompt-yes setting for autocorrect
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Chris Howlett <chowlett09@gmail.com>,
    Chris Howlett <chowlett09@gmail.com>

From: Chris Howlett <chowlett09@gmail.com>

The help.autocorrect functionality is really useful, saving frustration
when a dev fat-fingers a command, and git has a pretty good idea what
was originally intended. The config settings are a nice selection, with
"prompt" asking the user to confirm that they want to run the assumed
command.

However, with "prompt", the choice defaults to "No" - that is, hitting
return will _not_ run the command. For me at least, if git is confident
it knows which command I wanted, it's usually right, and the golden path
would be to run the command.

Therefore this patch adds "prompt-yes" as a counterpart config setting
for help.autocorrect, which does the same as "prompt", but defaults to
"Yes" - hitting return will run the assumed command.

I have not added any tests because the test suite doesn't have any tests
(that I could find) for the "prompt" behaviour - I'm assuming this is
because it's hard/impossible to simulate the interactive terminal prompt

Signed-off-by: Chris Howlett <chowlett09@gmail.com>
---
    Add prompt-yes config setting for help.autocorrect
    
    Changes since v1:
    
     * PR rebased against master and fixed up, to account for e21bf2c and
       e4542d8
    
    ------------------------------------------------------------------------
    
    This is my first patch request to git - please do let me know if I
    should be doing something differently!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1852%2Fasilano%2Fautocorrect-allow-prompt-default-yes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1852/asilano/autocorrect-allow-prompt-default-yes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1852

Range-diff vs v1:

 1:  b87c772089e ! 1:  cade4f1719e help: add prompt-yes setting for autocorrect
     @@ Commit message
      
          Signed-off-by: Chris Howlett <chowlett09@gmail.com>
      
     - ## Documentation/config/help.txt ##
     -@@ Documentation/config/help.txt: help.autoCorrect::
     + ## Documentation/config/help.adoc ##
     +@@ Documentation/config/help.adoc: immediately.
       deciseconds (0.1 sec).
     - 	 - "immediate": run the suggested command immediately.
     + 	 - "never": don't run or show any suggested command.
       	 - "prompt": show the suggestion and prompt for confirmation to run
      -the command.
      +the command. The default choice at the prompt is "No"
      +	 - "prompt-yes": show the suggestion and prompt for confirmation to run
      +the command. The default choice at the prompt is "Yes"
     - 	 - "never": don't run or show any suggested command.
       
       help.htmlPath::
     + 	Specify the path where the HTML documentation resides. File system paths
      
       ## help.c ##
      @@ help.c: struct help_unknown_cmd_config {
       	struct cmdnames aliases;
       };
       
     -+#define AUTOCORRECT_PROMPT_YES (-4)
     ++#define AUTOCORRECT_PROMPT_YES (-5)
     + #define AUTOCORRECT_SHOW (-4)
       #define AUTOCORRECT_PROMPT (-3)
       #define AUTOCORRECT_NEVER (-2)
     - #define AUTOCORRECT_IMMEDIATELY (-1)
     -@@ help.c: static int git_unknown_cmd_config(const char *var, const char *value,
     - 			cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
     - 		} else if (!strcmp(value, "prompt")) {
     - 			cfg->autocorrect = AUTOCORRECT_PROMPT;
     -+		} else if (!strcmp(value, "prompt-yes")) {
     -+			cfg->autocorrect = AUTOCORRECT_PROMPT_YES;
     - 		} else {
     - 			int v = git_config_int(var, value, ctx->kvi);
     - 			cfg->autocorrect = (v < 0)
     +@@ help.c: static int parse_autocorrect(const char *value)
     + 
     + 	if (!strcmp(value, "prompt"))
     + 		return AUTOCORRECT_PROMPT;
     ++	if (!strcmp(value, "prompt-yes"))
     ++		return AUTOCORRECT_PROMPT_YES;
     + 	if (!strcmp(value, "never"))
     + 		return AUTOCORRECT_NEVER;
     + 	if (!strcmp(value, "immediate"))
      @@ help.c: char *help_unknown_cmd(const char *cmd)
       	if ((cfg.autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
       		cfg.autocorrect = AUTOCORRECT_NEVER;


 Documentation/config/help.adoc |  4 +++-
 help.c                         | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/help.adoc b/Documentation/config/help.adoc
index b369589cec9..69b13b119f1 100644
--- a/Documentation/config/help.adoc
+++ b/Documentation/config/help.adoc
@@ -18,7 +18,9 @@ immediately.
 deciseconds (0.1 sec).
 	 - "never": don't run or show any suggested command.
 	 - "prompt": show the suggestion and prompt for confirmation to run
-the command.
+the command. The default choice at the prompt is "No"
+	 - "prompt-yes": show the suggestion and prompt for confirmation to run
+the command. The default choice at the prompt is "Yes"
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 8d91afe851d..2a25882af02 100644
--- a/help.c
+++ b/help.c
@@ -552,6 +552,7 @@ struct help_unknown_cmd_config {
 	struct cmdnames aliases;
 };
 
+#define AUTOCORRECT_PROMPT_YES (-5)
 #define AUTOCORRECT_SHOW (-4)
 #define AUTOCORRECT_PROMPT (-3)
 #define AUTOCORRECT_NEVER (-2)
@@ -570,6 +571,8 @@ static int parse_autocorrect(const char *value)
 
 	if (!strcmp(value, "prompt"))
 		return AUTOCORRECT_PROMPT;
+	if (!strcmp(value, "prompt-yes"))
+		return AUTOCORRECT_PROMPT_YES;
 	if (!strcmp(value, "never"))
 		return AUTOCORRECT_NEVER;
 	if (!strcmp(value, "immediate"))
@@ -650,6 +653,9 @@ char *help_unknown_cmd(const char *cmd)
 	if ((cfg.autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
 		cfg.autocorrect = AUTOCORRECT_NEVER;
 
+	if ((cfg.autocorrect == AUTOCORRECT_PROMPT_YES) && (!isatty(0) || !isatty(2)))
+		cfg.autocorrect = AUTOCORRECT_IMMEDIATELY;
+
 	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
@@ -738,6 +744,15 @@ char *help_unknown_cmd(const char *cmd)
 			if (!(starts_with(answer, "y") ||
 			      starts_with(answer, "Y")))
 				exit(1);
+		} else if (cfg.autocorrect == AUTOCORRECT_PROMPT_YES) {
+			char *answer;
+			struct strbuf msg = STRBUF_INIT;
+			strbuf_addf(&msg, _("Run '%s' instead [Y/n]? "), assumed);
+			answer = git_prompt(msg.buf, PROMPT_ECHO);
+			strbuf_release(&msg);
+			if (starts_with(answer, "n") ||
+			      starts_with(answer, "N"))
+				exit(1);
 		} else {
 			fprintf_ln(stderr,
 				   _("Continuing in %0.1f seconds, "

base-commit: 03944513488db4a81fdb4c21c3b515e4cb260b05
-- 
gitgitgadget
