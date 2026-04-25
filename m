Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68EA4315A
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777115983; cv=none; b=Y34LNs8AnCr0HqTZUIzYWk8H6MhdA1xnRCfE/6H1h/EmTrFkyAnmjruJ3Ei7s6EEV6S7kll5bhgp2JUX9aOs453nC5Ouh9V3ynsFHLL4vDgOzIrx7jwKS553RFNxESu2JIoZ0NRv4x2Q0lg/YfhT067CZvaUy3BESqr43olAbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777115983; c=relaxed/simple;
	bh=G78jtK/F9g5yWw+y8oSVXd5yko5pHqtj3B9TEthOz04=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=kMrZZrh3Il6pBOJU8CoQZEfyS+v8Jn+hVHzXpHbFVdr59Bq+TjC7nufrOBJPDnVqseSPguYh8gK+/DG9eyrf93AhhGQPIpxQXl5K1xzAzvo4B9EuI1Wg3fidOdIpg+HqVRoDmLC+sdszIY0ypN0MHc6YQpQXcMiJ2D2TWqr8Ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIaJIImS; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIaJIImS"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2d9916deb14so15481283eec.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777115980; x=1777720780; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JYiGg+3LvL1FELAupSMHq1f9+mG7pmO+ciuoSkicVy4=;
        b=kIaJIImSXNc7CEiaHo76B8tOrp9SE3bgOzbgpgl1BhzmWCnXun9GmKolro3bB2/5J0
         +8/b9g2G5q/05aMvzRfmdN3K4kxhOmoQ55haBKARk/V84B/iVwJcI+zzEVuXAPPT3cUI
         sQoh+E3GZm+Ljh44K+d2SvlTLo3vQj5zrF5ju/TS/v4TL2EVAUXPWohbpfiXBD1Phqjw
         GvxT2syzSrd8GDfZyNJE/N5nUlJC4CFZCSkbgfNLLoStIWGi3NAGk9XC8NmoCu1TK1TT
         00IN4x3OImjxDFnRBIPNgSs8niQYSQg/ULCu4zNbTXIAHCcQ6CSK+w+7o0qek6wY38PX
         XSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777115980; x=1777720780;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYiGg+3LvL1FELAupSMHq1f9+mG7pmO+ciuoSkicVy4=;
        b=X411FUK71NUKlFZ7CeDCmURyIf+bE7LV1j8sgEecyB98TOuZMcgTmzc1tmBX7VeHyQ
         w3woQEn37vaeZn3xmMKTkn/8Wev6Ode1JRZtMCoGebklAQej/fDcCbSJfRztRerr5xrn
         OHb2SoncfcsuQgbHjAhkgbqOG5b8TOL/0QASEo21fMkCSc3wn5HqXw7vwc+LlQd1q/61
         7hs+9hjwZoMMddxY7QGFBAq4CEsfVdPYzmjp2FldE7dNdokqDmKFqM8chzOyngSsFODH
         ZwaCDOJmRFjRykDhZ+GB8Vsy51/misA4fLqYnYsRLLQBeXy44sl/LV7Yx70NnRPy0NG5
         dLLg==
X-Gm-Message-State: AOJu0YwaZNlZT4o73r49LzHuVjyPZA5qv2xkJITmqFzoRLpnCDYU+Pgf
	YX6aAkSyZ6ClnKxaUsWUDS847rUJe0qmrJ2pfiOr9VeNFxA0QR1c80nKcpESRw==
X-Gm-Gg: AeBDies99po0J6ETzfaXHnkSs8SSbss/n7Hm0QOtI6mObXXaZ4jvq5jF8g/ZJTxsGog
	7PpAOQf+7A1CFf+4LQ77rJrKXcy1OPm64Pz36lFWXsFhCLRA6spr6nJA8B1o8E2dzA7uUxfdY/H
	0tpcm4RMtpKyzWerLIkN8gqbmQIwuNUJBEG5gIekZV12glpAqsoXSlu/sqos8j0RsVbPGKvE7lP
	1JFaSnP54F7AwVn/W8djYSCXsvp2eiiIvVmyUL/sLAiscW67XC0dDPHOeEFW3wd73NemyB3Mvpm
	dcZ1Nqxj16eJnspDMtXs+97YUJNmljCsHPmfn4mnjUIBZ1Y5oPfjFxdKPqrvL52c2vMKjyU1iSg
	RCMqjS0UtCGbrGsDeqjvGsPJEjZXj7EftuFbRDfBUYpyhRoDfhcCrnXotWMo9CrUwjv/ytwcVlV
	azBBxZ04oOsGK+uJUkK4unOQ5Rfngkg/ss3FTO
X-Received: by 2002:a05:7300:5728:b0:2be:2953:fd74 with SMTP id 5a478bee46e88-2e479723e13mr20036199eec.14.1777115979787;
        Sat, 25 Apr 2026 04:19:39 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.177.69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm45682048eec.8.2026.04.25.04.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 04:19:39 -0700 (PDT)
Message-Id: <pull.2283.git.git.1777115978088.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Apr 2026 11:19:38 +0000
Subject: [PATCH] remote: add --set-head option to 'git remote add'
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Mirror the behavior 'git clone' applies to its first remote: after
fetching, set refs/remotes/<name>/HEAD to the remote's default branch.

Equivalent to running:

    git remote add -f <name> <url>
    git remote set-head <name> -a

The new option implies --fetch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    remote: add --set-head option to 'git remote add'
    
    When using GitHub's gh tool to fork a repo, it seems that set-head isn't
    run on the upstream remote. So its default branch is not recorded
    locally, meaning that 'git log fork' will not work.
    
    With git remote add --set-head upstream , the default branch is set in
    the same step and things can work out of the box after a small change on
    'gh' that I will do as a next step.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2283%2FHaraldNordgren%2Fset_head-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2283/HaraldNordgren/set_head-v1
Pull-Request: https://github.com/git/git/pull/2283

 Documentation/git-remote.adoc |  9 ++++++++-
 builtin/remote.c              | 26 ++++++++++++++++++++++++--
 t/t5505-remote.sh             |  8 ++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index eaae30aa88..0ef49c4164 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git remote [-v | --verbose]
-git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
+git remote add [-t <branch>] [-m <master>] [-f] [--set-head] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
 git remote rename [--[no-]progress] <old> <new>
 git remote remove <name>
 git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
@@ -73,6 +73,13 @@ multiple branches without grabbing all branches.
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
 +
+With `--set-head` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
+up to point at the remote's default branch, mirroring the behavior of
+`git clone`. This is equivalent to running `git remote set-head <name> -a`
+after the remote is added, and implies `-f` so that the remote's refs are
+available locally. It cannot be combined with `-m <master>` or with a push
+mirror.
++
 When a fetch mirror is created with `--mirror=fetch`, the refs will not
 be stored in the `refs/remotes/` namespace, but rather everything in
 `refs/` on the remote will be directly mirrored into `refs/` in the
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3ba..8273b425a5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -23,7 +23,7 @@
 
 static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose]",
-	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
+	N_("git remote add [-t <branch>] [-m <master>] [-f] [--set-head] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
 	N_("git remote rename [--[no-]progress] <old> <new>"),
 	N_("git remote remove <name>"),
 	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
@@ -174,10 +174,21 @@ static int check_remote_collision(struct remote *remote, void *data)
 	return 0;
 }
 
+static int set_head_auto_for_remote(const char *name)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	strvec_pushl(&cmd.args, "remote", "set-head", "--auto", name, NULL);
+	cmd.git_cmd = 1;
+	if (run_command(&cmd))
+		return error(_("Could not set up HEAD for %s"), name);
+	return 0;
+}
+
 static int add(int argc, const char **argv, const char *prefix,
 	       struct repository *repo UNUSED)
 {
-	int fetch = 0, fetch_tags = TAGS_DEFAULT;
+	int fetch = 0, fetch_tags = TAGS_DEFAULT, set_head_auto = 0;
 	unsigned mirror = MIRROR_NONE;
 	struct string_list track = STRING_LIST_INIT_NODUP;
 	const char *master = NULL;
@@ -195,6 +206,8 @@ static int add(int argc, const char **argv, const char *prefix,
 		OPT_STRING_LIST('t', "track", &track, N_("branch"),
 				N_("branch(es) to track")),
 		OPT_STRING('m', "master", &master, N_("branch"), N_("master branch")),
+		OPT_BOOL(0, "set-head", &set_head_auto,
+			 N_("set refs/remotes/<name>/HEAD according to remote (implies --fetch)")),
 		OPT_CALLBACK_F(0, "mirror", &mirror, "(push|fetch)",
 			N_("set up remote as a mirror to push to or fetch from"),
 			PARSE_OPT_OPTARG | PARSE_OPT_COMP_ARG, parse_mirror_opt),
@@ -211,6 +224,12 @@ static int add(int argc, const char **argv, const char *prefix,
 		die(_("specifying a master branch makes no sense with --mirror"));
 	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
 		die(_("specifying branches to track makes sense only with fetch mirrors"));
+	if (set_head_auto && master)
+		die(_("--set-head and --master are mutually exclusive"));
+	if (set_head_auto && mirror && !(mirror & MIRROR_FETCH))
+		die(_("--set-head makes no sense with a push mirror"));
+	if (set_head_auto)
+		fetch = 1;
 
 	name = argv[0];
 	url = argv[1];
@@ -269,6 +288,9 @@ static int add(int argc, const char **argv, const char *prefix,
 			result = error(_("Could not setup master '%s'"), master);
 	}
 
+	if (set_head_auto && set_head_auto_for_remote(name))
+		result = 1;
+
 out:
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e592c0bcde..043c86315f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -81,6 +81,14 @@ test_expect_success 'add another remote' '
 	)
 '
 
+test_expect_success 'add remote with --set-head implies --fetch and sets HEAD' '
+	test_when_finished "git -C test remote remove third" &&
+	git -C test remote add --set-head third ../two &&
+	echo refs/remotes/third/main >expect &&
+	git -C test symbolic-ref refs/remotes/third/HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup bare clone for server' '
 	git clone --bare "file://$(pwd)/one" srv.bare &&
 	git -C srv.bare config --local uploadpack.allowfilter 1 &&

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
