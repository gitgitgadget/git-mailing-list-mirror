Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998921F453
	for <e@80x24.org>; Fri,  9 Nov 2018 05:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeKIO7A (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 09:59:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41015 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeKIO7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 09:59:00 -0500
Received: by mail-io1-f67.google.com with SMTP id a5-v6so456526ioq.8
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 21:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y5ytokkqAmCLOe0AYopGFYG37yGl48RLnleCKmmRnkE=;
        b=BdgRWqXam7Cyxyj1j5wWPHzt5NNKjKs/Eq9BgSsv35lxAFvc/iN52z8EFBsXSvSeXF
         0Hgz7KR83INEhyyw8J+5o9GjS0+KZFu3l8n1TSjc8zERL6Dj8CT6uoMQBMkh+rFz/v0T
         asuTBztWcpsI8sStCckdst2lxHx+Hc8gBSidMKhtbNTaGHg5Yqy+Ab3htap3708eM4Ja
         dCAcC18oa7tFbyxKlUHHmLcfovCPywlk9T00C4IHFmOAj4KW5AFaz+ki//W5lTs7Vrmt
         S6zI1RTgVnNGiUwCpLaeLRIkADjHt5kLYnIfOAKqO/7CRbDLtHu0bG4KkXC1xfvU7bLA
         XbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y5ytokkqAmCLOe0AYopGFYG37yGl48RLnleCKmmRnkE=;
        b=tWTzp+6/9NZ3oHQrvJN4tudDOivH0liTiSaTfwIDs4Z05O1r9y7aJGe/BjtcIkZSjH
         w+wVVkRcfIEXLxbhZe5/KvGanTqiV6TSoJWQHlL22+8spuieroY40/JSRb3hlzPs+jTm
         8T4IOMxVxL8DamIqJmeBajfy5FFHdgvp6um4+CtJs4dFyzt7vNf3dhU03Qj40CmvdEGo
         MZv33HSPy8UD67ZSp28gIBi6yUQrXXDuh90fhkF/L4bZO7PWWYoXOQu+er6pf+GJbsz1
         f4wbCRDv48TJpDMv149ejP5JpIl5i24YJnBxt8+/hArBESyDeth2I+Ieqldzs6mEwJwY
         ymPQ==
X-Gm-Message-State: AGRZ1gKK5mkj4oEoBQ6MHMZuvKFdPf4mJ+YZyevI+a6yoY2BzAyFx3di
        ljVWGDmsvoLc2+L7M5zrFK0=
X-Google-Smtp-Source: AJdET5cxp/gopegA91zm9yp5h60YWHqDjbuFJLwpBe3HI9bo5wAt1n72nsmTv4iLvy9L7KrLMqOZ/A==
X-Received: by 2002:a5e:c201:: with SMTP id v1-v6mr24042iop.302.1541740805120;
        Thu, 08 Nov 2018 21:20:05 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id f197-v6sm314702itc.4.2018.11.08.21.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 21:20:04 -0800 (PST)
Date:   Fri, 9 Nov 2018 00:20:02 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, liu.denton@gmail.com, anmolmago@gmail.com,
        briankyho@gmail.com, david.lu97@outlook.com,
        shirui.wang@hotmail.com
Subject: [PATCH v3] remote: add --save-to-push option to git remote set-url
Message-ID: <8fded8b84b593497177de740f80b3499c4269758.1541740174.git.liu.denton@gmail.com>
References: <xmqqin1754c5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqin1754c5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
On Fri, Nov 09, 2018 at 12:15:22PM +0900, Junio C Hamano wrote:
> This sounds more like "saving to push" (i.e. what you are saving is
> the existing "url" and the "push" is a shorthand for "pushURL",
> which is the location the old value of "url" is aved to), not "save
> (the) push(URL)".  So if adding this option makes sense, I would say
> "--save-to-push" (or even "--save-to-pushURL") may be a more
> appropriate name for it.
> 

My original intention was for it to mean "save push behavior" but I
agree with you that it's unclear so I'm changing it to --save-to-push.

> Ambigous in what way?  You asked the current URL to be saved as a
> pushURL, so existing pushURL destinations should not come into play,
> I would think.  If there are more than one URL (not pushURL), on the
> other hand, I think you have a bigger problem (where would "git fetch"
> fetch from, and how would these multiple URLs are prevented from
> trashing refs/remotes/$remote/* with each other's refs?), so
> stopping the operation before "set-url" makes the problem worse is
> probably a good idea, but I think that is true with or without this
> new option.
> 

> I _think_ in the future (if this option turns out to be widely used)
> people may ask for this condition to be loosened somewhat, but it is
> relatively easy to start restrictive and then to loosen later, so I
> think this is OK for now.
> 

I agree, there's no reason why we shouldn't allow appending to the push
URLs if one already exists so I removed that removed that restriction.
---
 Documentation/git-remote.txt |  5 +++++
 builtin/remote.c             | 26 +++++++++++++++++++++-----
 t/t5505-remote.sh            | 11 +++++++++++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 0cad37fb81..8f9d700252 100644
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
@@ -155,6 +156,10 @@ With `--delete`, instead of changing existing URLs, all URLs matching
 regex <url> are deleted for remote <name>.  Trying to delete all
 non-push URLs is an error.
 +
+With `--save-to-push`, the current URL is saved into the push URL before
+setting the URL to <url>. Note that this command will not work if more than one
+URL is defined because the behavior would be ambiguous.
++
 Note that the push URL and the fetch URL, even though they can
 be set differently, must still refer to the same place.  What you
 pushed to the push URL should be what you would see if you
diff --git a/builtin/remote.c b/builtin/remote.c
index f7edf7f2cb..3249c3face 100644
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
+				die(_("--save-to-push can only be used when only one url is defined"), remotename);
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
2.19.1

