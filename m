From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] Introduce core.initHook
Date: Tue, 25 Mar 2008 00:21:59 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803250020490.4353@racer.site>
References: <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar> <20080323235610.GB25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803240101220.4353@racer.site> <20080324002302.GD25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803241155300.4353@racer.site> <20080324122153.GF25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803241611200.4353@racer.site> <7vr6dzuaxf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803242232410.4353@racer.site> <7vhcevu4ou.fsf@gitster.siamese.dyndns.org>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, Steffen Prohaska <prohaska@zib.de>,  tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>,  git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Mar 25 00:23:02 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdw0H-0004SG-Kg
	for gcvm-msysgit@m.gmane.org; Tue, 25 Mar 2008 00:22:57 +0100
Received: by ug-out-1516.google.com with SMTP id 1so8373012uga.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 24 Mar 2008 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=a1gBczflkpID/+49SzaxGVf7J10HhYc6TB28PvZNb3E=;
        b=i99z34m9y4HtpRJ/BisjjbRWKwGfJG4+z6qQp1ICR9CejUmzJNXWE5lxTHPpb2jfkIQ7jR5Zhe2mSM9Z+47OLBC6IrFoQxD8agFcUxihNGgoSXKZzzlPCRS/pWFD6EAtM6n3jY1EEJ1k9oMy3/F6pOpMPnDKfE9Truc/fhv+24Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=lH15JDzwUmt0L4o9aBOmFu16TKyxzq0ni0RFn3addb+XiB54l+5JW6xxjASQMYaNOKsXLa+ndAL2wCaHqAPx3L7JI8ydaKWt9UBhNgCyU+rcOjfcYFQsm8gbAEUmQdB5EHi9yW0BrUTEExGGFQEmjqiQtv0/WdLApPDHNUS1uic=
Received: by 10.150.185.14 with SMTP id i14mr577973ybf.7.1206400935311;
        Mon, 24 Mar 2008 16:22:15 -0700 (PDT)
Received: by 10.44.54.11 with SMTP id c11gr2018hsa.0;
	Mon, 24 Mar 2008 16:22:15 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.14.4 with SMTP id r4mr8898661pyi.2.1206400934096; Mon, 24 Mar 2008 16:22:14 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id z53si101892pyg.1.2008.03.24.16.22.13; Mon, 24 Mar 2008 16:22:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 24 Mar 2008 23:22:04 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43] by mail.gmx.net (mp007) with SMTP; 25 Mar 2008 00:22:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182GpFXKwk2LoqcLiLuEs8xTd6CU4dou9/zPsM598 KEjImxuCjMn0me
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcevu4ou.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78123>



This variable, if set, specifies the path of a hook which is executed
after every git-init.  It can be used to override settings in the
templates per-user.

In case of a re-initialization, the hook gets called with the argument
"reinit".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

On Mon, 24 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	> > +	if (run_init_hook())
> > 	> > +		return 1;
> > 	> > +
> > 	> 
> > 	> Hmm.  Exit without a message even under !quiet?
> >
> > 	Even under quiet, run_init_hook() will complain if the hook is 
> > 	invalid.
> 
> Sorry, I may have been unclear but I was wondering more about the case the
> hook script errored out silently.

Ooops.  You're right.  This is the interdiff:

diff --git a/builtin-init-db.c b/builtin-init-db.c
index e1a54b5..cdeb1d7 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -332,7 +332,8 @@ static int run_init_hook(int reinit)
        argv[0] = init_hook;
        if (reinit)
                argv[1] = "reinit";
-       return run_command_v_opt(argv, 0);
+       return run_command_v_opt(argv, 0) ?
+               error("hook '%s' failed", init_hook) : 0;
 }


 Documentation/config.txt   |    5 +++++
 Documentation/git-init.txt |    6 ++++++
 builtin-init-db.c          |   29 +++++++++++++++++++++++++++++
 t/t0001-init.sh            |   21 +++++++++++++++++++++
 4 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index efde54d..355f049 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -358,6 +358,11 @@ core.whitespace::
   does not trigger if the character before such a carriage-return
   is not a whitespace (not enabled by default).
 
+core.inithook::
+	The path to a program which is run after each call to
+	linkgit:git-init[1].  The hook is called with the argument
+	"reinit" if an existing repository is re-initialized.
+
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 03a4f0e..26deaaf 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -60,6 +60,12 @@ If you are initializing a non-bare repository, the config variable
 `receive.guardCurrentBranch` is set to true.  This avoids problems with
 pushing into the current branch, which does not touch the working tree.
 
+If you want to run a specific script everytime git-init was issued, you
+can set the variable `core.initHook` in /etc/gitconfig or $HOME/.gitconfig,
+or in the existing repository when re-initializing.  In the case that you
+reinitialize a repository, the hook is called with the single argument
+"reinit".
+
 --
 
 
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 36c12a2..cdeb1d7 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "run-command.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -310,6 +311,31 @@ static void guess_repository_type(const char *git_dir)
 	return;
 }
 
+static const char *init_hook;
+static int config_init_hook(const char *key, const char *value)
+{
+	if (!strcmp(key, "core.inithook"))
+		return git_config_string(&init_hook, key, value);
+	return 0;
+}
+
+static int run_init_hook(int reinit)
+{
+	const char *argv[3] = { NULL, NULL, NULL };
+
+	git_config(config_init_hook);
+	if (!init_hook)
+		return 0;
+	if (access(init_hook, X_OK) < 0)
+		return error("init hook '%s' not found", init_hook);
+
+	argv[0] = init_hook;
+	if (reinit)
+		argv[1] = "reinit";
+	return run_command_v_opt(argv, 0) ?
+		error("hook '%s' failed", init_hook) : 0;
+}
+
 static const char init_db_usage[] =
 "git-init [-q | --quiet] [--template=<template-directory>] [--shared]";
 
@@ -407,6 +433,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
+	if (run_init_hook(reinit))
+		return 1;
+
 	if (!quiet)
 		printf("%s%s Git repository in %s/\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c015405..7c18d24 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -113,4 +113,25 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 	fi
 '
 
+cat > init-hook.sh << EOF
+#!$SHELL_PATH
+
+git config test.message success
+EOF
+chmod a+x init-hook.sh
+
+# using reinit because of lacking system/global config in the tests
+
+test_expect_success 'core.initHook' '
+
+	mkdir hook &&
+	(cd hook &&
+	 git init &&
+	 test -z "$(git config test.message)" &&
+	 git config core.initHook "$(pwd)"/../init-hook.sh &&
+	 git init &&
+	 test success = "$(git config test.message)")
+
+'
+
 test_done
-- 
1.5.5.rc1.178.gd799d
