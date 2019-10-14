Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03001F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 22:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfJNWC2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 18:02:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43911 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbfJNWC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 18:02:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so11105899pfo.10
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=775WZwykUfG1N0MmBz46m/7GS0ygHUtkQMExCY3UHIw=;
        b=LO+jRkOzBI0R135uSEjw85M7TV9er9KS8CG3/4QiFy9mjI7es0nj2NMVcT0fN19hoc
         MgBrJW62jcWIZa8CQllekvgHWS5XfgS6jXPkkG0Gj4MScWjTUrYkIMLolQpNlfu2ge3d
         LA3z00jw1fkDVpdPrGc/sWvrHHli4Pn9pKTi1YdXzsC0DGBlk9Uwkm90xATA64nu12sf
         s0lIVUuU3S0K/8fBN7aCkNrOefhu5/vPFJFcbZqKJrW0n8epXgZ1aYxvrw1TmN+Ac6lG
         HaHI0navoZCGLCeiCOsglkEVz4N2BaENPYoDGkUjQpXAXC2Lb12AS2pzqPy4BsaWeBnK
         CuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=775WZwykUfG1N0MmBz46m/7GS0ygHUtkQMExCY3UHIw=;
        b=W2oKp8r3+VCeFDoeE6SHppLT5sjEZ8xwIpC8LSTGUB3FGtwvW8OigXqzWCeMtGOue3
         O5CJqcQzGsT++jkse/t72fj40Ql0YZ1ylXHIsSmHu8HDP9RhWPbqQdnloK2H3/Inkuca
         IPWogIZTmMBhEruGIKbIu0ERh37Clu1JqcKD9QqC27gdGgZZLCbB/OazAubQ/cjSTnS4
         kyuX7hxwwAokmgZzQ9uCxOzaJrV/RSI4OXzkJHWvy9QaLMjkbTw+OvmG6zNHjDEwYM+/
         o5mhOv9oYnEAgkx6zl087J3Ce9hfeNmEN9FwJea/mf5qVqKEZq9T+thgmB8oFV11Iad3
         Ev3w==
X-Gm-Message-State: APjAAAWKmk8QkhgwnWKgu8oUrsJqEMz1OB8UMR5G7To8SX8+3u8kXL5b
        5IizXvqpC71kO4bydj2bqwz8Nk4uTtM=
X-Google-Smtp-Source: APXvYqzvUc0oivho2L8TZtHsSn3/KWSrOwr6JZ5/blj7gQOMKiuSaCYARY2DIEBMdSb84y6RRdfkKA==
X-Received: by 2002:a17:90a:3628:: with SMTP id s37mr38679323pjb.38.1571090546742;
        Mon, 14 Oct 2019 15:02:26 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb00:1b0::c0a9])
        by smtp.gmail.com with ESMTPSA id p11sm20518895pgb.1.2019.10.14.15.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 15:02:25 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/1] Teach remote add the --prefix-tags option
Date:   Mon, 14 Oct 2019 15:01:00 -0700
Message-Id: <d47c5de5fc812b1fbd04bb259a522e453d4b21e2.1571089481.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2.7164.g7daebe18fb
In-Reply-To: <cover.1571089481.git.wink@saville.com>
References: <cover.1571089481.git.wink@saville.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When --prefix-tags is passed to `git remote add` the tagopt is set to
--prefix-tags and a second fetch line is added so tags are placed in
a separate hierarchy per remote.

For example:
  $ git remote add -f --prefix-tags gbenchmark git@github.com:google/benchmark
  Updating gbenchmark
  warning: no common commits
  remote: Counting objects: 4406, done.
  remote: Compressing objects: 100% (18/18), done.
  remote: Total 4406 (delta 7), reused 13 (delta 6), pack-reused 4382
  Receiving objects: 100% (4406/4406), 1.34 MiB | 7.58 MiB/s, done.
  Resolving deltas: 100% (2865/2865), done.
  From github.com:google/benchmark
   * [new branch]      clangtidy       -> gbenchmark/clangtidy
   * [new branch]      iter_report     -> gbenchmark/iter_report
   * [new branch]      master          -> gbenchmark/master
   * [new branch]      releasing       -> gbenchmark/releasing
   * [new branch]      reportercleanup -> gbenchmark/reportercleanup
   * [new branch]      rmheaders       -> gbenchmark/rmheaders
   * [new branch]      v2              -> gbenchmark/v2
   * [new tag]         v0.0.9          -> tags/gbenchmark/v0.0.9
   * [new tag]         v0.1.0          -> tags/gbenchmark/v0.1.0
   * [new tag]         v1.0.0          -> tags/gbenchmark/v1.0.0
   * [new tag]         v1.1.0          -> tags/gbenchmark/v1.1.0
   * [new tag]         v1.2.0          -> tags/gbenchmark/v1.2.0
   * [new tag]         v1.3.0          -> tags/gbenchmark/v1.3.0
   * [new tag]         v1.4.0          -> tags/gbenchmark/v1.4.0

And the .git/config remote "gbenchmark" section looks like:
  [remote "gbenchmark"]
    url = git@github.com:google/benchmark
    fetch = +refs/heads/*:refs/remotes/gbenchmark/*
    fetch = +refs/tags/*:refs/remotes/tags/gbenchmark/*
    tagopt = --prefix-tags

Based on a solution proposed by Junio on the email list [1]

[1]: https://public-inbox.org/git/xmqqbme51rgn.fsf@gitster-ct.c.googlers.com/T/#me7f7f153b8ba742c0dc48d8ec79c280c9682d32e

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Wink Saville <wink@saville.com>
---
 Documentation/git-remote.txt |  8 +++++--
 builtin/remote.c             | 42 ++++++++++++++++++++++++++++++++----
 remote.c                     |  2 ++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 9659abbf8e..db0238e8bd 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--tags | --prefix-tags | --no-tags] [--mirror=<fetch|push>] <name> <url>
 'git remote rename' <old> <new>
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
@@ -54,7 +54,11 @@ With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
 With `--tags` option, `git fetch <name>` imports every tag from the
-remote repository.
+remote repository to refs/tags, use --prefix-tags to import them
+to refs/remotes/tags/<name>/<tag>.
++
+With `--prefix-tags` option, `git fetch <name>` imports every tag from the
+remote repository to refs/remotes/tags/<name>/<tag>.
 +
 With `--no-tags` option, `git fetch <name>` does not import tags from
 the remote repository.
diff --git a/builtin/remote.c b/builtin/remote.c
index 5591cef775..88991f9fbe 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -14,7 +14,7 @@
 
 static const char * const builtin_remote_usage[] = {
 	N_("git remote [-v | --verbose]"),
-	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
+	N_("git remote add [-t <branch>] [-m <master>] [-f] [--prefix-tags | --tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
 	N_("git remote rename <old> <new>"),
 	N_("git remote remove <name>"),
 	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
@@ -104,7 +104,8 @@ static int fetch_remote(const char *name)
 enum {
 	TAGS_UNSET = 0,
 	TAGS_DEFAULT = 1,
-	TAGS_SET = 2
+	TAGS_SET = 2,
+	TAGS_SET_PREFIX = 3
 };
 
 #define MIRROR_NONE 0
@@ -126,6 +127,14 @@ static void add_branch(const char *key, const char *branchname,
 	git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
+static void add_remote_tags(const char *key, const char *remotename,
+			    struct strbuf *tmp)
+{
+	strbuf_reset(tmp);
+	strbuf_addf(tmp, "+refs/tags/*:refs/remotes/tags/%s/*", remotename);
+	git_config_set_multivar(key, tmp->buf, "^$", 0);
+}
+
 static const char mirror_advice[] =
 N_("--mirror is dangerous and deprecated; please\n"
    "\t use --mirror=fetch or --mirror=push instead");
@@ -164,6 +173,9 @@ static int add(int argc, const char **argv)
 		OPT_SET_INT(0, "tags", &fetch_tags,
 			    N_("import all tags and associated objects when fetching"),
 			    TAGS_SET),
+		OPT_SET_INT(0, "prefix-tags", &fetch_tags,
+			    N_("import all tags and associated objects when fetching and prefix with <name>"),
+			    TAGS_SET_PREFIX),
 		OPT_SET_INT(0, NULL, &fetch_tags,
 			    N_("or do not fetch any tag at all (--no-tags)"), TAGS_UNSET),
 		OPT_STRING_LIST('t', "track", &track, N_("branch"),
@@ -185,6 +197,8 @@ static int add(int argc, const char **argv)
 		die(_("specifying a master branch makes no sense with --mirror"));
 	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
 		die(_("specifying branches to track makes sense only with fetch mirrors"));
+	if (mirror && (fetch_tags == TAGS_SET_PREFIX))
+		die(_("specifying a --prefix-tags makes no sense with --mirror"));
 
 	name = argv[0];
 	url = argv[1];
@@ -218,10 +232,30 @@ static int add(int argc, const char **argv)
 	}
 
 	if (fetch_tags != TAGS_DEFAULT) {
+		if (fetch_tags == TAGS_SET_PREFIX) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "remote.%s.fetch", name);
+			add_remote_tags(buf.buf, name, &buf2);
+		}
+
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.tagopt", name);
-		git_config_set(buf.buf,
-			       fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
+		char *config_val = NULL;
+		switch (fetch_tags) {
+		case TAGS_UNSET:
+			config_val = "--no-tags";
+			break;
+		case TAGS_SET:
+			config_val = "--tags";
+			break;
+		case TAGS_SET_PREFIX:
+			config_val = "--prefix-tags";
+			break;
+		default:
+			die(_("Unexpected TAGS enum %d"), fetch_tags);
+			break;
+		}
+		git_config_set(buf.buf, config_val);
 	}
 
 	if (fetch && fetch_remote(name))
diff --git a/remote.c b/remote.c
index e50f7602ed..d916fda029 100644
--- a/remote.c
+++ b/remote.c
@@ -421,6 +421,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 			remote->fetch_tags = -1;
 		else if (!strcmp(value, "--tags"))
 			remote->fetch_tags = 2;
+		else if (!strcmp(value, "--prefix-tags"))
+			remote->fetch_tags = -1;
 	} else if (!strcmp(subkey, "proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
-- 
2.16.2.7164.g7daebe18fb

