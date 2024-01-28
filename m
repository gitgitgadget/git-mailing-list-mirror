Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741AF3C46B
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472183; cv=none; b=Lji6gCq6SbfXzMzjRW1aDcswlogr0ueDkBp3hQv0JZYQhgx/6qFdHausuh0J8zBTQhAG0hRUUFeOG/LyNvHrFEPTofpV+BJ9kzaQUJY0jLq1hi5Ds9HdR44tPDr8myZkvpq/65E+8jVgPACnpPalY2sNRNPp2DtkF2PSq1tP7j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472183; c=relaxed/simple;
	bh=2vtrJHbRnX+npVfLN922a7kuIY3hHTq3L1bsZuVpGTg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fbsNddHK3ibcFRyPFx/fk6kzgCkse3+I5o/OaQTuzWj+qSLLiFgIdjkcii7E5ggwZOyR31u/2tvmNQqpYD8DpeCEqITKkRGP7NTbQX4pqWVD8aenBgBLkYt9KhjY6spU8vpFzjSM7LQBz2ptG+6cFigigJGjaz0DRBTwRTpjjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgk63iTn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgk63iTn"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so2446645e9.1
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 12:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706472179; x=1707076979; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dEGWprWWUyitE72gJhxPCNtNyO5AFJdA4Ck7/jeXsY=;
        b=Hgk63iTnaN4QmX7QNvt9Al0+oJsDBjzL/Sx1rKKxwod5gWAxB2wpk539Ivy1BjSLGv
         qyc6/ISumBTfuYTDR99rfDCz/FdQ+8ey8HBiGTKpKxHWWVW+h5BAdSD2O/ZRWy4LgcKr
         O2WC+0PjW0QCIHuLgF+tGzULmMaD3KbDAIjyyeuNQLX54C8zOcgr35dzWkDLiTa2uOnt
         Hj2L4bW6qSNUO537fDCh3Be6zmIe4aHviioGhmOKiY7EeGbN/cOJdCdhH+KW6sSnPSoD
         L/wxpypxM+imq68OU99v7VKWP+V8//sSVba4ZESvuU9KruW1Kk5PLfzTuXSf2MWytZY1
         auyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706472179; x=1707076979;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dEGWprWWUyitE72gJhxPCNtNyO5AFJdA4Ck7/jeXsY=;
        b=LEVy9MhX8RtrjNMwPCa8r+8oYq6gt9UuqpP/12W5fnKMN+DemiL0eeb1LI9FUwQff8
         AFIdvZ7fizRMkDo94m+BpFXc+S7y3tB+TZJSOWrc+isx4hsk43ld4FwmZ1dKJ0ehY/2v
         C0ageY4suHMXh17830AmQLAUu97DZSdkpRD7pOXIDjcY2XSs3Ex8veqW1s+B7r+yvcRD
         VE3rDc7BEZwegecGunxzLiQNLj+J2w08IjYT2C2vgENAhXyuFqrbRNu1SKmZK/0AOpuG
         e4BtdQlRJQdWur8FdYqxSMWL2PyGE949C9j654s+r2eMCSP355QI9rkJwj/NbIxRWc+4
         U7vg==
X-Gm-Message-State: AOJu0Ywkuyz7Z2CrxrsyBbBX85m63fFTIl99uF/CMpbOV7B+I4ejP0+T
	zk8SUzY4eyWk8j71st9AGzcwxMcfG+FHcrbl2xbgMzCGqzok2oaX42KUPBrn
X-Google-Smtp-Source: AGHT+IGyMz02B7fLY4s8sCvwXWByc+ZMywqXSP7h+M4GEi04y7bUEZdUvmaN7rC80yDa/c3lsmXnOg==
X-Received: by 2002:a05:600c:198f:b0:40e:f6b8:128d with SMTP id t15-20020a05600c198f00b0040ef6b8128dmr802528wmq.7.1706472178788;
        Sun, 28 Jan 2024 12:02:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d514c000000b0033ae798b6ffsm2639968wrt.38.2024.01.28.12.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 12:02:58 -0800 (PST)
Message-ID: <3e83f21eb4e35be0b43e2e40f79920d1b0d00dc1.1706472173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 20:02:52 +0000
Subject: [PATCH 4/5] builtin/help: add --config-all-for-completion
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

There is currently no machine-friendly way to show _all_ configuration
variables from the command line. 'git help --config' does show them all,
but it also sets up the pager. 'git help --config-for-completion' omits
some variables (those containing wildcards, for example) and 'git help
--config-section-for-completion' shows only top-level section names.

In a following commit we will want to have access to a list of all
configuration variables from the Bash completion script. As such, add a
new mode for the command, HELP_ACTION_CONFIG_ALL_FOR_COMPLETION,
triggered by the new option '--config-all-for-completion'. In this mode,
show all variables, just as HELP_ACTION_CONFIG, but do not set up the
pager.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/help.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/help.c b/builtin/help.c
index dc1fbe2b986..dacaeb10bf4 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -50,6 +50,7 @@ static enum help_action {
 	HELP_ACTION_DEVELOPER_INTERFACES,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
+	HELP_ACTION_CONFIG_ALL_FOR_COMPLETION,
 } cmd_mode;
 
 static const char *html_path;
@@ -86,6 +87,8 @@ static struct option builtin_help_options[] = {
 		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
 	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
 		    HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "config-all-for-completion", &cmd_mode, "",
+		    HELP_ACTION_CONFIG_ALL_FOR_COMPLETION, PARSE_OPT_HIDDEN),
 
 	OPT_END(),
 };
@@ -670,6 +673,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		opt_mode_usage(argc, "--config-for-completion", help_format);
 		list_config_help(SHOW_CONFIG_VARS);
 		return 0;
+	case HELP_ACTION_CONFIG_ALL_FOR_COMPLETION:
+		opt_mode_usage(argc, "--config-all-for-completion", help_format);
+		list_config_help(SHOW_CONFIG_HUMAN);
+		return 0;
 	case HELP_ACTION_USER_INTERFACES:
 		opt_mode_usage(argc, "--user-interfaces", help_format);
 		list_user_interfaces_help();
-- 
gitgitgadget

