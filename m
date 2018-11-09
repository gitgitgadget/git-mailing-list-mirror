Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C69DE1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 02:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeKIMQT (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 07:16:19 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41992 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeKIMQT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 07:16:19 -0500
Received: by mail-io1-f66.google.com with SMTP id h19-v6so259714iog.9
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 18:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JNUcf7Eu/ASF0tKjCcgdZP8ihpZr0y8VeSOeQTIJH4Q=;
        b=tDhhbYI7gariTEMePcDizU7jH4lwcs9E3jpAZIicQFQ9wwTS8q5oRUq2SI8mv6Xcbo
         Ljqi0u5miCVg5ysbo3HkUiwIwCaVcDdq36V5LSb7Mu7eVUQDCs5vaW0H4I52PeYPZLmY
         P+L1VKtqBp0bcFpYaB0k/ushpa34bkurTJbQvMp6X4pObOtBgS+a6MvIEwSSa7WT7/Xy
         CFSP0YYM1mt327dQuKOwge+RhQu/hhoUzMlqH/7O/McqmAeVuaiYVo5+ITgRRYzdsmXx
         iopnbZFJoNTPLapiWUqidVhT8IuVGWXgD1UNu7OZV5Wl5fCXfzQCDyhmMVm66sk66lfY
         pUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JNUcf7Eu/ASF0tKjCcgdZP8ihpZr0y8VeSOeQTIJH4Q=;
        b=FxRmXciL/R6vohoIPHv7p7PJ7vdymTp6r8pASPDqNEGPqoliXW+S8Q0sJDum84k4jl
         Xdz0X0TMDaJF65lDDXEX8E0kOiOe2ggiblcLe1UyJyXBgDfsToW+mb61eVRRmm0xwJJ7
         8pJw3CdlTlb4U4ImeOC31eZTXOYd5YW/9TH0OrQ/K2xNm7jC8iBq/n6d0NVz9KaM3Gn5
         e0+9bPONJyi37bzhq79QGpit0U52w89dgFs9C1WyRtbX9S6IaYzxTg0PUDlwMyNbmAAW
         de2q4I4nOgJMTMabQvQpMK8GNX9jm3WK/c2dUKPTj47+Tm95rT0wRXFvZrmxSepoi2LT
         cN2Q==
X-Gm-Message-State: AGRZ1gIO7VVaBRXTw8IEJmZ+sq1iviwpEjqOI1SVtcBxLq5vDQ23EpzC
        l9lvC99UBiz3ZjWp9MNr/TM=
X-Google-Smtp-Source: AJdET5e5Hqsf3tbewxq5EL0djm7sqo0uZCFtmB897RqBtfCMSLvLxhetJTpn5CvHkwVHn0aa1L7OUA==
X-Received: by 2002:a6b:631a:: with SMTP id p26-v6mr5895402iog.175.1541731068602;
        Thu, 08 Nov 2018 18:37:48 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-142-182.dsl.bell.ca. [76.68.142.182])
        by smtp.gmail.com with ESMTPSA id x13-v6sm117725ita.8.2018.11.08.18.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 18:37:47 -0800 (PST)
Date:   Thu, 8 Nov 2018 21:37:45 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, liu.denton@gmail.com, anmolmago@gmail.com,
        briankyho@gmail.com, david.lu97@outlook.com,
        shirui.wang@hotmail.com
Subject: [RFC PATCH v2] remote: add --save-push option to git remote set-url
Message-ID: <b910987d3aa778b39b6e27a75fe685a4797b8422.1541730538.git.liu.denton@gmail.com>
References: <xmqq8t2f218l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t2f218l.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the --save-push option to `git remote set-url` such that when
executed, we move the remote.*.url to remote.*.pushurl and set
remote.*.url to the given url argument.

For example, if we have the following config:

	[remote "origin"]
		url = git@github.com:git/git.git

`git remote set-url --save-push origin https://github.com/git/git.git`
would change the config to the following:

	[remote "origin"]
		url = https://github.com/git/git.git
		pushurl = git@github.com:git/git.git

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
I decided to address your comments and reroll the patch one more time. 

Even though the option isn't _that_ commonly used, I've managed to use
it a couple of times since I've implemented so I believe that this
option should be included.

---
 Documentation/git-remote.txt |  5 +++++
 builtin/remote.c             | 25 ++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 0cad37fb81..8ce85fe2f2 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
 'git remote set-url --add' [--push] <name> <newurl>
 'git remote set-url --delete' [--push] <name> <url>
+'git remote set-url --save-push' <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>...
 'git remote prune' [-n | --dry-run] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
@@ -155,6 +156,10 @@ With `--delete`, instead of changing existing URLs, all URLs matching
 regex <url> are deleted for remote <name>.  Trying to delete all
 non-push URLs is an error.
 +
+With `--save-push`, the current URL is saved into the push URL before setting
+the URL to <url>. Note that this command will not work if more than one URL is
+defined or if any push URLs are defined because behavior would be ambiguous.
++
 Note that the push URL and the fetch URL, even though they can
 be set differently, must still refer to the same place.  What you
 pushed to the push URL should be what you would see if you
diff --git a/builtin/remote.c b/builtin/remote.c
index f7edf7f2cb..0eaec7ef38 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -24,8 +24,9 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote set-branches [--add] <name> <branch>..."),
 	N_("git remote get-url [--push] [--all] <name>"),
 	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url --add [--push] <name> <newurl>"),
+	N_("git remote set-url --delete [--push] <name> <url>"),
+	N_("git remote set-url --save-push <name> <url>"),
 	NULL
 };
 
@@ -77,8 +78,9 @@ static const char * const builtin_remote_geturl_usage[] = {
 
 static const char * const builtin_remote_seturl_usage[] = {
 	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url --add [--push] <name> <newurl>"),
+	N_("git remote set-url --delete [--push] <name> <url>"),
+	N_("git remote set-url --save-push <name> <url>"),
 	NULL
 };
 
@@ -1519,7 +1521,7 @@ static int get_url(int argc, const char **argv)
 
 static int set_url(int argc, const char **argv)
 {
-	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
+	int i, push_mode = 0, save_push = 0, add_mode = 0, delete_mode = 0;
 	int matches = 0, negative_matches = 0;
 	const char *remotename = NULL;
 	const char *newurl = NULL;
@@ -1532,6 +1534,8 @@ static int set_url(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOL('\0', "push", &push_mode,
 			 N_("manipulate push URLs")),
+		OPT_BOOL('\0', "save-push", &save_push,
+			 N_("change fetching URL behavior")),
 		OPT_BOOL('\0', "add", &add_mode,
 			 N_("add URL")),
 		OPT_BOOL('\0', "delete", &delete_mode,
@@ -1543,6 +1547,8 @@ static int set_url(int argc, const char **argv)
 
 	if (add_mode && delete_mode)
 		die(_("--add --delete doesn't make sense"));
+	if (save_push && (push_mode || add_mode || delete_mode))
+		die(_("--save-push cannot be used with other options"));
 
 	if (argc < 3 || argc > 4 || ((add_mode || delete_mode) && argc != 3))
 		usage_with_options(builtin_remote_seturl_usage, options);
@@ -1564,6 +1570,15 @@ static int set_url(int argc, const char **argv)
 		urlset = remote->pushurl;
 		urlset_nr = remote->pushurl_nr;
 	} else {
+		if (save_push) {
+			if (remote->url_nr != 1 || remote->pushurl_nr != 0)
+				die(_("--save-push can only be used when one url and no pushurl is defined"), remotename);
+
+			strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
+			git_config_set(name_buf.buf, remote->url[0]);
+			strbuf_reset(&name_buf);
+		}
+
 		strbuf_addf(&name_buf, "remote.%s.url", remotename);
 		urlset = remote->url;
 		urlset_nr = remote->url_nr;
-- 
2.19.1

