Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958A11F424
	for <e@80x24.org>; Thu, 26 Apr 2018 22:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbeDZWuT (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 18:50:19 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35603 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbeDZWuS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 18:50:18 -0400
Received: by mail-wr0-f175.google.com with SMTP id w3-v6so58259199wrg.2
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 15:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0kmce0t5mOZNjrCSwg5MbrpB053vco6SYy5XzCcebs4=;
        b=ibubsbMBEPOguXC4svRYDY99MGYU1bxHlW82VhDkWi+S/9hvz+k5evWA9UnJ3n0jwj
         HzgrKLbDSWz6Ve4pzVykR1m41abZBvUTNi20pQGpg9J5sSzU3T9TP/msvaUzSmnKFSAt
         m5E4v9wIu7flKdHYZ1M0qJD9OyOOy3JlwJhUCaxIKv6XuXU8UxC5kX5EPnyY1IQHuIK3
         K80ZowpXxsKkc5F3HQ3yMUn9MPk86VjEwmMpY4TxO0DJneMfaCCm1+lnbW+3fggx+H6N
         dvjUEHD9sjAWlcPXiFrhhwcOBO/sYt1pKuKLXXAhcmq/+mpjJWw6gaIJ6zEXg1MfIgOz
         F8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0kmce0t5mOZNjrCSwg5MbrpB053vco6SYy5XzCcebs4=;
        b=UPDcG3v/EhnLgnzIxnoXPbWmGM1anPQPY/wHTL0A3ETf2dlGdJVJreVnwQ18018rrB
         uJOE51REj0tDPDmZxpd6kkKhz2ry4cKcSRQqvsKpJAIBiKFp8wYiLXGM3P1DyxJS1FEZ
         J2N0qmuvUuFjOBEbZUQYRkSvYv61VahW83MbqsuWtW1CPvPiQUiaNgwbUxNAwjcmc1+e
         Kuong7+5PI/WOmQGR3FjlXuu2YEhefpAZfq12RQC/PLeOkgNj2/GxI5nAm+0wAawnUCJ
         5xS701tv0BuCXFTbC4UDE/vWYg36Y77DdbtKDeoFZOgSZF0LM3GIsU890OvpuPnnglqr
         KkhQ==
X-Gm-Message-State: ALQs6tA0mNwl+hvrgk+p+12EXFLqOWtcQ+EjMxHbuKFlT2edocOU34qv
        Bna6kNiF8j5ZeA82yJrlkrtM50Bt
X-Google-Smtp-Source: AIpwx49UAzr8w4EuxCthSPa5T2yMg4JVnlg9akhno+DqJnWJB7tLkYGGrF4/S4HFWp581EVcGsJkTg==
X-Received: by 2002:adf:8df7:: with SMTP id o110-v6mr30565582wrb.251.1524783016139;
        Thu, 26 Apr 2018 15:50:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b10-v6sm27605337wrn.42.2018.04.26.15.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 15:50:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     Wink Saville <wink@saville.com>
Subject: Re: Fetching tags overwrites existing tags
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
        <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com>
        <CAKk8isr-7bSVqEv8EjF2UgFfw75D2oVZPJFui30pbY6kWfeL_Q@mail.gmail.com>
        <CAKk8ispWBoG7D+u8x+s+iB+wzXUN=7vpxgmz5wjL67P6XUmw9g@mail.gmail.com>
Date:   Fri, 27 Apr 2018 07:50:13 +0900
In-Reply-To: <CAKk8ispWBoG7D+u8x+s+iB+wzXUN=7vpxgmz5wjL67P6XUmw9g@mail.gmail.com>
        (Wink Saville's message of "Thu, 26 Apr 2018 12:39:06 -0700")
Message-ID: <xmqqfu3h1t22.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> I've tried to teach 'git remote add' the --prefix-tags option using the
> technique Junio provided. At moment it is PR #486 on github [1]
> and I'd love some comments on whether or not this the right direction
> for fetching tags and putting them in the branches namespace.
>
> -- Wink
>
> [1] https://github.com/git/git/pull/486

FWIW, here is how that pull/486/head looks like.

-- >8 --

From: Wink Saville <wink@saville.com>
Date: Thu, 26 Apr 2018 09:56:11 -0700
Subject: [PATCH] Teach remote add the --prefix-tags option

When --prefix-tags is passed to `git remote add` the tagopt is set to
--prefix-tags and a second fetch line is added so tags are placed in
the branches namespace.

For example:
  $ git remote add -f --prefix-tags gbenchmark git@github.com:google/benchmark
  Updating gbenchmark
  warning: no common commits
  remote: Counting objects: 4406, done.
  remote: Compressing objects: 100% (18/18), done.
  remote: Total 4406 (delta 7), reused 13 (delta 6), pack-reused 4382
  Receiving objects: 100% (4406/4406), 1.34 MiB | 7.46 MiB/s, done.
  Resolving deltas: 100% (2865/2865), done.
  From github.com:google/benchmark
   * [new branch]      clangtidy       -> gbenchmark/clangtidy
   * [new branch]      iter_report     -> gbenchmark/iter_report
   * [new branch]      master          -> gbenchmark/master
   * [new branch]      releasing       -> gbenchmark/releasing
   * [new branch]      reportercleanup -> gbenchmark/reportercleanup
   * [new branch]      rmheaders       -> gbenchmark/rmheaders
   * [new branch]      v2              -> gbenchmark/v2
   * [new tag]         v0.0.9          -> refs/remote-tags/gbenchmark/v0.0.9
   * [new tag]         v0.1.0          -> refs/remote-tags/gbenchmark/v0.1.0
   * [new tag]         v1.0.0          -> refs/remote-tags/gbenchmark/v1.0.0
   * [new tag]         v1.1.0          -> refs/remote-tags/gbenchmark/v1.1.0
   * [new tag]         v1.2.0          -> refs/remote-tags/gbenchmark/v1.2.0
   * [new tag]         v1.3.0          -> refs/remote-tags/gbenchmark/v1.3.0
   * [new tag]         v1.4.0          -> refs/remote-tags/gbenchmark/v1.4.0

And the .git/config remote "gbenchmark" section looks like:
  [remote "gbenchmark"]
    url = git@github.com:google/benchmark
    fetch = +refs/heads/*:refs/remotes/gbenchmark/*
    fetch = +refs/tags/*:refs/remote-tags/gbenchmark/*
    tagopt = --prefix-tags
---
 Documentation/git-remote.txt |  8 ++++--
 builtin/remote.c             | 47 +++++++++++++++++++++++++++++++++---
 remote.c                     |  2 ++
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 4feddc0293..cdfd24e2ea 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=<fetch|push>] <name> <url>
+'git remote add' [-t <branch>] [-m <master>] [-f] [--prefix-tags | --tags | --no-tags] [--mirror=<fetch|push>] <name> <url>
 'git remote rename' <old> <new>
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
@@ -54,7 +54,11 @@ With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
 With `--tags` option, `git fetch <name>` imports every tag from the
-remote repository.
+remote repository to refs/tags, use --prefix-tags to import them
+to refs/remote-tags/<name>/<tag>.
++
+With `--prefix-tags` option, `git fetch <name>` imports every tag from the
+remote repository to refs/remote-tags/<name>/<tag>.
 +
 With `--no-tags` option, `git fetch <name>` does not import tags from
 the remote repository.
diff --git a/builtin/remote.c b/builtin/remote.c
index 805ffc05cd..75813eeaa3 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -11,7 +11,7 @@
 
 static const char * const builtin_remote_usage[] = {
 	N_("git remote [-v | --verbose]"),
-	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
+	N_("git remote add [-t <branch>] [-m <master>] [-f] [--prefix-tags | --tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
 	N_("git remote rename <old> <new>"),
 	N_("git remote remove <name>"),
 	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
@@ -101,7 +101,8 @@ static int fetch_remote(const char *name)
 enum {
 	TAGS_UNSET = 0,
 	TAGS_DEFAULT = 1,
-	TAGS_SET = 2
+	TAGS_SET = 2,
+	TAGS_SET_PREFIX = 3
 };
 
 #define MIRROR_NONE 0
@@ -123,6 +124,16 @@ static void add_branch(const char *key, const char *branchname,
 	git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
+static void add_remote_tags(const char *key, const char *branchname,
+		       const char *remotename, struct strbuf *tmp)
+{
+	strbuf_reset(tmp);
+	strbuf_addch(tmp, '+');
+	strbuf_addf(tmp, "refs/tags/%s:refs/remote-tags/%s/%s",
+				branchname, remotename, branchname);
+	git_config_set_multivar(key, tmp->buf, "^$", 0);
+}
+
 static const char mirror_advice[] =
 N_("--mirror is dangerous and deprecated; please\n"
    "\t use --mirror=fetch or --mirror=push instead");
@@ -161,6 +172,9 @@ static int add(int argc, const char **argv)
 		OPT_SET_INT(0, "tags", &fetch_tags,
 			    N_("import all tags and associated objects when fetching"),
 			    TAGS_SET),
+		OPT_SET_INT(0, "prefix-tags", &fetch_tags,
+			    N_("import all tags and associated objects when fetching and prefix with <name>"),
+          TAGS_SET_PREFIX),
 		OPT_SET_INT(0, NULL, &fetch_tags,
 			    N_("or do not fetch any tag at all (--no-tags)"), TAGS_UNSET),
 		OPT_STRING_LIST('t', "track", &track, N_("branch"),
@@ -215,10 +229,35 @@ static int add(int argc, const char **argv)
 	}
 
 	if (fetch_tags != TAGS_DEFAULT) {
+		if (fetch_tags == TAGS_SET_PREFIX) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "remote.%s.fetch", name);
+			if (track.nr == 0)
+				string_list_append(&track, "*");
+			for (i = 0; i < track.nr; i++) {
+				add_remote_tags(buf.buf, track.items[i].string,
+						name, &buf2);
+			}
+		}
+
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.tagopt", name);
-		git_config_set(buf.buf,
-			       fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
+		char* config_val = NULL;
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
index 91eb010ca9..f383ce3cdf 100644
--- a/remote.c
+++ b/remote.c
@@ -447,6 +447,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 			remote->fetch_tags = -1;
 		else if (!strcmp(value, "--tags"))
 			remote->fetch_tags = 2;
+		else if (!strcmp(value, "--prefix-tags"))
+			remote->fetch_tags = -1; // A fetch for refs/tags is present so tags are retrieved
 	} else if (!strcmp(subkey, "proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
-- 
2.17.0-391-g1f1cddd558
