Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F8F215F4
	for <e@80x24.org>; Tue,  1 May 2018 16:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755877AbeEAQ7l (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 12:59:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37258 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755276AbeEAQ7j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 12:59:39 -0400
Received: by mail-pf0-f194.google.com with SMTP id e9so5516283pfi.4
        for <git@vger.kernel.org>; Tue, 01 May 2018 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=E1NXufBVokwltMusGQ7OekaBLX1Wgxu/jSNXwyZL1/g=;
        b=08HZQ+xhvI7GAIMNDCqhYHCctwDUVCwNeM0TMZ47RqAySr4ZTrJFYHLhae0FQsVl4t
         fenRWQn6gni566gTTeLNZY0PNW3XQxmVqc3fv/iCIOZYE6LKAPpnoZ2kCr5juH1sB5m6
         +DVIuLqcST0/cB8NzUl5EOkn7WoiqPmaasTr14gWMb++ePvwAtufBUhaJOkqNeP3X4/h
         RJn3rR5zbGL3jeD0veCZc0YKrE6AINKipYve0V7vAkWtCVO/WR9dDwhaKH2rbxyyyUCl
         nkHX1FlUY1hfnDh3Y+5mQmBK4U6AfUdsAl/Wkil0VPseQI1bYGtWqMIierPzeCF8I5xN
         KJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=E1NXufBVokwltMusGQ7OekaBLX1Wgxu/jSNXwyZL1/g=;
        b=MxSns9WhL18HzTJDd8R1oML5DsJqR+qPPVd1oqYSMEST5dSMl4vTM2jWCQPjLv5pbA
         GegJfWXjG2R3yequQXxiN15OuAQ1Z5xx/TTinN/4M3563P/yEtI47CXhhBAmFYIZxyK2
         1CPolIMG2x5lFmLt0GuDiV14K5vjxFvOhWKJlJ2CJJYcZ0zRQ0KmkKZBfuiHrn9Uiixj
         0NTW6JpugzWaRFBHJCBEKzBwMdxQmS06aLyDXLWOGrgeZ1ELebuIbniZOkS8baBFNC+I
         U8YAUYsmGaU2ttiLZw0aU2PqEj+JsEkQYiMj9nPdZmmGygJgxCC6TLO5Vsu1KHrsw4Ii
         02RA==
X-Gm-Message-State: ALQs6tBUAoPGTDyCpq1wmJE42QZw/fxT24FDPa7xtpEyJ70kOIbw0CLU
        aR2jVIUZTHEXFNZGJxrPIOizaaWidNs=
X-Google-Smtp-Source: AB8JxZqzAa7qSauso9g6EW+QVa6ZCjEiGdKYyp/xfDR0zbP0ivvrCTS4F5rkSWuwUcYKDsqQdd1jTA==
X-Received: by 10.98.59.24 with SMTP id i24mr16139648pfa.246.1525193978425;
        Tue, 01 May 2018 09:59:38 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:6e43::93dc])
        by smtp.gmail.com with ESMTPSA id r81sm22313311pfj.79.2018.05.01.09.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 09:59:36 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gitster@pobox.com
Subject: [RFC PATCH v4 1/3] Teach remote add the --remote-tags option
Date:   Tue,  1 May 2018 09:59:29 -0700
Message-Id: <20180501165931.25515-2-wink@saville.com>
X-Mailer: git-send-email 2.17.0.393.g4573f5e134
In-Reply-To: <20180501165931.25515-1-wink@saville.com>
References: <20180501165931.25515-1-wink@saville.com>
In-Reply-To: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When --remote-tags is passed to `git remote add` the tagopt is set to
--remote-tags and a second fetch line is added so tags are placed in
a separate hierarchy per remote.

For example:
  $ git remote add -f --remote-tags gbenchmark git@github.com:google/benchmark
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
   * [new tag]         v0.0.9          -> gbenchmark/v0.0.9
   * [new tag]         v0.1.0          -> gbenchmark/v0.1.0
   * [new tag]         v1.0.0          -> gbenchmark/v1.0.0
   * [new tag]         v1.1.0          -> gbenchmark/v1.1.0
   * [new tag]         v1.2.0          -> gbenchmark/v1.2.0
   * [new tag]         v1.3.0          -> gbenchmark/v1.3.0
   * [new tag]         v1.4.0          -> gbenchmark/v1.4.0

And the .git/config remote "gbenchmark" section looks like:
  [remote "gbenchmark"]
    url = git@github.com:google/benchmark
    fetch = +refs/heads/*:refs/remotes/gbenchmark/*
    fetch = +refs/tags/*:refs/remote-tags/gbenchmark/*
    tagopt = --remote-tags

Based on a solution proposed by Junio on the email list [1]

[1]: https://public-inbox.org/git/xmqqbme51rgn.fsf@gitster-ct.c.googlers.com/T/#me7f7f153b8ba742c0dc48d8ec79c280c9682d32e

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jacob Keller <jacob.keller@gmail.com>
Helped-by: Bryan Turner <bturner@atlassian.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Wink Saville <wink@saville.com>
---
 Documentation/git-remote.txt |  8 +++++--
 builtin/remote.c             | 44 ++++++++++++++++++++++++++++++++----
 refs.c                       |  1 +
 remote.c                     |  2 ++
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 4feddc0293..fc983c2ff1 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--tags | --remote-tags | --no-tags] [--mirror=<fetch|push>] <name> <url>
 'git remote rename' <old> <new>
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
@@ -54,7 +54,11 @@ With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
 With `--tags` option, `git fetch <name>` imports every tag from the
-remote repository.
+remote repository to refs/tags, use --remote-tags to import them
+to refs/remote-tags/<name>/<tag>.
++
+With `--remote-tags` option, `git fetch <name>` imports every tag from the
+remote repository to refs/remote-tags/<name>/<tag>.
 +
 With `--no-tags` option, `git fetch <name>` does not import tags from
 the remote repository.
diff --git a/builtin/remote.c b/builtin/remote.c
index 805ffc05cd..07832113e9 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -11,7 +11,7 @@
 
 static const char * const builtin_remote_usage[] = {
 	N_("git remote [-v | --verbose]"),
-	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
+	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --remote-tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
 	N_("git remote rename <old> <new>"),
 	N_("git remote remove <name>"),
 	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
@@ -101,7 +101,8 @@ static int fetch_remote(const char *name)
 enum {
 	TAGS_UNSET = 0,
 	TAGS_DEFAULT = 1,
-	TAGS_SET = 2
+	TAGS_SET = 2,
+	TAGS_SET_REMOTE = 3
 };
 
 #define MIRROR_NONE 0
@@ -123,6 +124,14 @@ static void add_branch(const char *key, const char *branchname,
 	git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
+static void add_remote_tags(const char *key, const char *remotename,
+			    struct strbuf *tmp)
+{
+	strbuf_reset(tmp);
+	strbuf_addf(tmp, "+refs/tags/*:refs/remote-tags/%s/*", remotename);
+	git_config_set_multivar(key, tmp->buf, "^$", 0);
+}
+
 static const char mirror_advice[] =
 N_("--mirror is dangerous and deprecated; please\n"
    "\t use --mirror=fetch or --mirror=push instead");
@@ -161,6 +170,9 @@ static int add(int argc, const char **argv)
 		OPT_SET_INT(0, "tags", &fetch_tags,
 			    N_("import all tags and associated objects when fetching"),
 			    TAGS_SET),
+		OPT_SET_INT(0, "remote-tags", &fetch_tags,
+			    N_("import all tags and associated objects when fetching to refs/remote-tags/<name>/<tag>"),
+			    TAGS_SET_REMOTE),
 		OPT_SET_INT(0, NULL, &fetch_tags,
 			    N_("or do not fetch any tag at all (--no-tags)"), TAGS_UNSET),
 		OPT_STRING_LIST('t', "track", &track, N_("branch"),
@@ -182,6 +194,10 @@ static int add(int argc, const char **argv)
 		die(_("specifying a master branch makes no sense with --mirror"));
 	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
 		die(_("specifying branches to track makes sense only with fetch mirrors"));
+	if ((fetch_tags == TAGS_SET_REMOTE) && mirror)
+		die(_("specifying --remote-tags makes no sense with --mirror"));
+	if ((fetch_tags == TAGS_SET_REMOTE) && track.nr)
+		die(_("specifying --remote-tags makes no sense with -t or --track"));
 
 	name = argv[0];
 	url = argv[1];
@@ -215,10 +231,30 @@ static int add(int argc, const char **argv)
 	}
 
 	if (fetch_tags != TAGS_DEFAULT) {
+		if (fetch_tags == TAGS_SET_REMOTE) {
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
+		case TAGS_SET_REMOTE:
+			config_val = "--remote-tags";
+			break;
+		default:
+			die(_("Unexpected TAGS enum %d"), fetch_tags);
+			break;
+		}
+		git_config_set(buf.buf, config_val);
 	}
 
 	if (fetch && fetch_remote(name))
diff --git a/refs.c b/refs.c
index 8b7a77fe5e..4075150e26 100644
--- a/refs.c
+++ b/refs.c
@@ -472,6 +472,7 @@ const char *prettify_refname(const char *name)
 {
 	if (skip_prefix(name, "refs/heads/", &name) ||
 	    skip_prefix(name, "refs/tags/", &name) ||
+	    skip_prefix(name, "refs/remote-tags/", &name) ||
 	    skip_prefix(name, "refs/remotes/", &name))
 		; /* nothing */
 	return name;
diff --git a/remote.c b/remote.c
index 91eb010ca9..86cccc0b6e 100644
--- a/remote.c
+++ b/remote.c
@@ -447,6 +447,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 			remote->fetch_tags = -1;
 		else if (!strcmp(value, "--tags"))
 			remote->fetch_tags = 2;
+		else if (!strcmp(value, "--remote-tags"))
+			remote->fetch_tags = -1;
 	} else if (!strcmp(subkey, "proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
-- 
2.17.0.393.g4573f5e134

