Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674CBC352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D3E20870
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll91FUSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgBJAbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40017 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgBJAbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so5415819wru.7
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/f/RbunZ3oX3X6TkjfyxUFiJayzsGjXKRgQcjZDFgRo=;
        b=ll91FUSfNBunhRNUizUqA5Ct5669Az4CORmsZouKTjy+m1ltk6BiP/jEsOYumm2rNh
         V8riC41ZzlB+hrIxZO6ro8DUQCQoUFbzW5uOj0jAy0/7fwfVslA3xHCTNQWtJntyRaxe
         Jf7Dbt7q72CIO0KLt2R6cbwSfymeqXkJsoDjVssl+gHvHsVhDMdpe1ifJD58fExlcRAt
         a721K93EKe3V/nnbP5I9DyIvwozdFpHqLEeZLwBPtX+SGTY4CDodPH9pKOkOmrQqTLE6
         b3H48I/KukUVuDbbfwfJA34793Mb/p35F21ILcCge5LKby4EZ/WDwisJukxK0/TNX3HL
         HtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/f/RbunZ3oX3X6TkjfyxUFiJayzsGjXKRgQcjZDFgRo=;
        b=ScVOhIrkafF/Yw8TX9tZ6lxv8jrNNuBLRSVmOUdkZ19dE+ZoKIATd5u2fT0s5+moov
         TWi/Mnmly2v4q/dx8h4+2VCaaBrR+q+6Y7BNRINGUH/8wy4aiBDGR8vMLXaY34juBbSw
         4JrhbClHFZ1IJ0lxmVmFWmSBGiots8lXUX85LUQKRAVk93cMpnmaJnP6Vlrk1Kb6HW31
         a7AC+NFEEdOfy4A4Z9E7tiRAjGV7kLL+Qdn4cTvqDQsSHgU8VWhWFqXF2q5hVJa+QoaI
         ZbMYvJC3PbSLmIVUPnp2+Fn5qpFqtGG+b9x5Zn7eyeW/oyduhYbIcRenSpBySXKtAQLs
         aMdQ==
X-Gm-Message-State: APjAAAX++kQ5moj8I+kg2CEHZMjvxbAZhbVk9/rcTfDmVkGqw4K9Rq19
        8GnngCJMocKDYNFSOXWcI952x3dp
X-Google-Smtp-Source: APXvYqyPP3wmyzvNE+tl1W0VXgv8va2Fjx7LqJsGsCYs+l0u7Wbf2irwOftKqCcdIKEo6yWB4DO+uw==
X-Received: by 2002:adf:f109:: with SMTP id r9mr12954640wro.406.1581294666258;
        Sun, 09 Feb 2020 16:31:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i16sm13275269wrr.71.2020.02.09.16.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:05 -0800 (PST)
Message-Id: <64c20d0556e9e72663940da7f58a8e55a75fa9d0.1581294660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:55 +0000
Subject: [PATCH v7 06/10] config: clarify meaning of command line scoping
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

CONFIG_SCOPE_CMDLINE is generally used in the code to refer to config
values passed in via the -c option.  Options passed in using this
mechanism share similar scoping characteristics with the --file and
--blob options of the 'config' command, namely that they are only in use
for that single invocation of git, and that they supersede the normal
system/global/local hierarchy.  This patch introduces
CONFIG_SCOPE_COMMAND to reflect this new idea, which also makes
CONFIG_SCOPE_CMDLINE redundant.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c              | 6 +++---
 config.h              | 2 +-
 t/t1308-config-set.sh | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 7422bdebb1..fe1e44a43a 100644
--- a/config.c
+++ b/config.c
@@ -1737,7 +1737,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 		free(path);
 	}
 
-	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
+	current_parsing_scope = CONFIG_SCOPE_COMMAND;
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
@@ -3305,8 +3305,8 @@ const char *config_scope_name(enum config_scope scope)
 		return "local";
 	case CONFIG_SCOPE_WORKTREE:
 		return "worktree";
-	case CONFIG_SCOPE_CMDLINE:
-		return "command line";
+	case CONFIG_SCOPE_COMMAND:
+		return "command";
 	default:
 		return "unknown";
 	}
diff --git a/config.h b/config.h
index d3ed41ef8e..b570f4ce43 100644
--- a/config.h
+++ b/config.h
@@ -301,7 +301,7 @@ enum config_scope {
 	CONFIG_SCOPE_GLOBAL,
 	CONFIG_SCOPE_LOCAL,
 	CONFIG_SCOPE_WORKTREE,
-	CONFIG_SCOPE_CMDLINE,
+	CONFIG_SCOPE_COMMAND,
 };
 const char *config_scope_name(enum config_scope scope);
 
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 728a2b87ce..fba0abe429 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -265,7 +265,7 @@ test_expect_success 'iteration shows correct origins' '
 	value=from-cmdline
 	origin=command line
 	name=
-	scope=command line
+	scope=command
 	EOF
 	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
 	test_cmp expect actual
-- 
gitgitgadget

