Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA8720A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 14:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeLJOPP (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 09:15:15 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38297 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLJOPP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 09:15:15 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so18298175ith.3
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 06:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cjdua5+ngVBxdoxOznQ+3RfJBIADHZgdqbABAFWKrB8=;
        b=oEecHcSJ5UbFycuDcvTQNTocO51mo/C67GZmN+0lsMXQsWTicT95SbWB+ErsjGm6hU
         yWNndi2JazENE3VrEj21PJPOfkUcczHTHCS7NDru+KJ29uaLaMvFFkEyzj3FsaqXdCTb
         7oH2ZdmOAtKTF8Uv6KG45YMXVpFzHGQ9pTMfhuAHhhPEvKXiLEvLa0xuHIWOXt0lfPaX
         QuZ2FvWuRaARfGccR3KbMiEbno3JFnVB91t03HwqdAyL8xZs4x+5tASIAZnzRALtKoAP
         sWWoJvPbJPnViAtCjAfUMdfLf3Ci18L3KxBuRF8n2j1Ua8YCp/xHtsdmDncnic4P0GTV
         XSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cjdua5+ngVBxdoxOznQ+3RfJBIADHZgdqbABAFWKrB8=;
        b=mrASmbpCr/qNLwyB7AixF3nu6hfEUxzjDcNoWCT1UqUdzjHESHUq+ch0jrtPFf5Xj5
         WKSkTl2mnxvtcBUsJ5zRfC8xDQytj5IDendTSvJ/s3kMOo3mbFdWcv5XS526dikonpJx
         1WD+mAZ9OsPXzP+rT4Hz7Tuo1ToL6TpkLmMcnr13v4rT0n0w3fwD+ok8vnQzhTlcU2OG
         RX571yqZtFxu3T2Z78D1FPadFDnfP4bLqVsCssBLINqvhYbrLhg5QeFwIxC/qCs/m3eq
         O0E/YPaU+hn4qsBqXW9WGUqwSw2zJZBdTkLtZq5ByJQEmc89xCxQLIBH5/scTZcc7x1g
         AOwQ==
X-Gm-Message-State: AA+aEWaa+xSI0ByK59GuZsPeHsfRFmyLOCgiF6DOFuVmPKf/wqeX59z/
        5xoYZ3Dj7koXpH3VDwGS8azhdmSu
X-Google-Smtp-Source: AFSGD/X4Nohy0FlY37Z+3U/MkVYjgZALztb1xHXwINdrZ0umYslUZ7k9Sgf8MnbSHcAHdWDvkmRIGQ==
X-Received: by 2002:a05:660c:4c8:: with SMTP id v8mr11713138itk.93.1544451312943;
        Mon, 10 Dec 2018 06:15:12 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id b5sm4638699ioc.21.2018.12.10.06.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 06:15:12 -0800 (PST)
Date:   Mon, 10 Dec 2018 09:15:10 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v4] remote: add --save-to-push option to git remote set-url
Message-ID: <27cba756d792797a0d1145dd507497d9b64d7535.1544451081.git.liu.denton@gmail.com>
References: <8fded8b84b593497177de740f80b3499c4269758.1541740174.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fded8b84b593497177de740f80b3499c4269758.1541740174.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the --save-to-push option to `git remote set-url` such that
when executed, we move the remote.*.url to remote.*.pushurl and set
remote.*.url to the given url argument.

For example, if we have the following config:

	[remote "origin"]
		url = git@github.com:git/git.git

`git remote set-url --save-to-push origin https://github.com/git/git.git`
would change the config to the following:

	[remote "origin"]
		url = https://github.com/git/git.git
		pushurl = git@github.com:git/git.git

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

This patch improves upon v3 by adding the use-case for the new option,
as discussed here[1].

[1]: https://public-inbox.org/git/xmqqtvjlisnu.fsf@gitster-ct.c.googlers.com/
---
 Documentation/git-remote.txt | 12 ++++++++++++
 builtin/remote.c             | 26 +++++++++++++++++++++-----
 t/t5505-remote.sh            | 11 +++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 0cad37fb81..47aaae22c1 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
 'git remote set-url --add' [--push] <name> <newurl>
 'git remote set-url --delete' [--push] <name> <url>
+'git remote set-url --save-to-push' <name> <url>
 'git remote' [-v | --verbose] 'show' [-n] <name>...
 'git remote prune' [-n | --dry-run] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
@@ -155,6 +156,17 @@ With `--delete`, instead of changing existing URLs, all URLs matching
 regex <url> are deleted for remote <name>.  Trying to delete all
 non-push URLs is an error.
 +
+With `--save-to-push`, the current URL is saved into the push URL before
+setting the URL to <url>. Note that this command will not work if more than one
+URL is defined because the behavior would be ambiguous. A use-case for this
+feature is that you may have started your interaction with the repository with
+a single authenticated URL that can be used for both fetching and pushing, but
+over time you may have become sick of having to authenticate only to fetch.  In
+such a case, you can feed an unauthenticated/anonymous fetch URL to set-url
+with this option, so that the authenticated URL that you have been using for
+pushing becomes the pushURL, and the new, unauthenticated/anonymous URL will be
+used for fetching.
++
 Note that the push URL and the fetch URL, even though they can
 be set differently, must still refer to the same place.  What you
 pushed to the push URL should be what you would see if you
diff --git a/builtin/remote.c b/builtin/remote.c
index f7edf7f2cb..d683e67ba6 100644
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
+	N_("git remote set-url --save-to-push <name> <url>"),
 	NULL
 };
 
@@ -77,8 +78,9 @@ static const char * const builtin_remote_geturl_usage[] = {
 
 static const char * const builtin_remote_seturl_usage[] = {
 	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url --add [--push] <name> <newurl>"),
+	N_("git remote set-url --delete [--push] <name> <url>"),
+	N_("git remote set-url --save-to-push <name> <url>"),
 	NULL
 };
 
@@ -1519,7 +1521,7 @@ static int get_url(int argc, const char **argv)
 
 static int set_url(int argc, const char **argv)
 {
-	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
+	int i, push_mode = 0, save_to_push = 0, add_mode = 0, delete_mode = 0;
 	int matches = 0, negative_matches = 0;
 	const char *remotename = NULL;
 	const char *newurl = NULL;
@@ -1532,6 +1534,8 @@ static int set_url(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOL('\0', "push", &push_mode,
 			 N_("manipulate push URLs")),
+		OPT_BOOL('\0', "save-to-push", &save_to_push,
+			 N_("change fetching URL behavior")),
 		OPT_BOOL('\0', "add", &add_mode,
 			 N_("add URL")),
 		OPT_BOOL('\0', "delete", &delete_mode,
@@ -1543,6 +1547,8 @@ static int set_url(int argc, const char **argv)
 
 	if (add_mode && delete_mode)
 		die(_("--add --delete doesn't make sense"));
+	if (save_to_push && (push_mode || add_mode || delete_mode))
+		die(_("--save-to-push cannot be used with other options"));
 
 	if (argc < 3 || argc > 4 || ((add_mode || delete_mode) && argc != 3))
 		usage_with_options(builtin_remote_seturl_usage, options);
@@ -1564,6 +1570,16 @@ static int set_url(int argc, const char **argv)
 		urlset = remote->pushurl;
 		urlset_nr = remote->pushurl_nr;
 	} else {
+		if (save_to_push) {
+			if (remote->url_nr != 1)
+				die(_("--save-to-push can only be used when only one url is defined"));
+
+			strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
+			git_config_set_multivar(name_buf.buf,
+			      remote->url[0], "^$", 0);
+			strbuf_reset(&name_buf);
+		}
+
 		strbuf_addf(&name_buf, "remote.%s.url", remotename);
 		urlset = remote->url;
 		urlset_nr = remote->url_nr;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index d2a2cdd453..434c1f828a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1194,6 +1194,17 @@ test_expect_success 'remote set-url --delete baz' '
 	cmp expect actual
 '
 
+test_expect_success 'remote set-url --save-to-push bbb' '
+	git remote set-url --save-to-push someremote bbb &&
+	echo bbb >expect &&
+	echo "YYY" >>expect &&
+	echo ccc >>expect &&
+	git config --get-all remote.someremote.url >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.pushurl >>actual &&
+	cmp expect actual
+'
+
 test_expect_success 'extra args: setup' '
 	# add a dummy origin so that this does not trigger failure
 	git remote add origin .
-- 
2.19.2

