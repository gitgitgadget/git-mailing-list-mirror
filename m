Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AECC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbiGSScY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbiGSScX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:32:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247B457240
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso8427442wma.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fpQxic85HfZjGB3SjKaD6WfzysQzyUpJ5zcRrHyVeIM=;
        b=WshHXUXFeSjykxWuoLO3IlfskDgAXcg10APWZUewTXWbExX1pwk1nTP1C4G8dqj/1O
         dB0w3W8c6Cuo9NGKiKE77tCQghkHocfozp05O0lLkSrn1AsxIIvGyz896dDdnfN4mn4b
         lM5pCSok+j6942XrVm+Screyr+BuslbxqdJDIZ8XnMDu+p9b7e2EO5prLtCFACTYK7Bq
         newlTTz235K4fn2V9Sn2QGvF0vVl67jVGGnauYIyHQn6n2J2uT6ohy5gMhaYDXCmwZux
         XzQjY5c4CNlj3JE7hj1d2nk47vjdj8gYE648SQjvBIPuxphwkVtuqN2K58YSQKIaqzrs
         PRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fpQxic85HfZjGB3SjKaD6WfzysQzyUpJ5zcRrHyVeIM=;
        b=zMnx5lq1lsc4mF7JoIfoBQFFAN55s1KoisA+qlpdbdwbftza+CAMWtP5m8WFtlZ/p8
         AuqRBlbTstn8KAIJRYAhP5HN/SiEt6OsLnjXhtj+aeCzJxJ1DabH1NCjCAA+oTq7LVYF
         LUeh9C2Vtjlm0yFiuT05iD5xHcVM3zpSxKSyHx2jARTwFpRxI+ls6BZF1LsHOiO5Y/xL
         H3+qhY32OVV0cuuqFeAjy5eY3Ekl+JwyURCJXejLB44EExsILBoQXoMoD0EWz8lmFxHb
         Rau5qVYP6d4xUZBgHNOfLBk4Q5Y0tXDhULPBQIZXLBJmqwsOGWbC+NgaYElxatLCYGeN
         lpwg==
X-Gm-Message-State: AJIora98fhqZovxK0FoFp0bDOY3HRjQdLklqhIt10PYECa7asnjQLgOB
        pYZutNJKHVxE3rnfgCr27hFXBwS0nK4=
X-Google-Smtp-Source: AGRyM1vitB9krwyPUu5VrVD2lIHZHPJznX9kufmUk3Qaj5g8cQQ7Gto/P1qfxpgRER1CwHkF3V2p/Q==
X-Received: by 2002:a05:600c:502b:b0:3a3:1f5c:57f5 with SMTP id n43-20020a05600c502b00b003a31f5c57f5mr569720wmr.5.1658255539005;
        Tue, 19 Jul 2022 11:32:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b0021d60994b0asm13756152wrc.100.2022.07.19.11.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:32:18 -0700 (PDT)
Message-Id: <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
References: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:32:12 +0000
Subject: [PATCH v3 0/5] Remove use of "whitelist"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The word "whitelist" has cultural implications that make its use
non-inclusive.

A previous version of this series recommended the replacement of
"allowlist", but that term is still new and not accepted by some common
dictionaries.

Instead, this version avoids the use of "whitelist" by rewording the
sentences that use it. In many cases, this improves readability since the
term is used suddenly without other context (and in some cases, is not
necessary at all).

There is one case where "whitelist" is replaced with "allow_list" but that
is because we are operating on a string list parsed from the
GIT_ALLOW_PROTOCOL environment variable.


Updates in v3
=============

 * Reorganized patches so changes to git-daemon and git-cvsserver are
   bunched together across code, documentation, and tests. Their
   documentation is more thoroughly modified to clarify the role of the
   directory arguments.
 * The changes surrounding SANITIZE=leak are delayed for Ævar's work that
   will update the documentation while changing the behavior of the test
   variables.
 * Several replacements are made to clarify meaning instead of doing a
   simple replacement. Thanks, Ævar for the suggestions.

Thanks, -Stolee

Derrick Stolee (5):
  daemon: clarify directory arguments
  git-cvsserver: clarify directory list
  git.txt: remove redundant language
  t: avoid "whitelist"
  transport.c: avoid "whitelist"

 Documentation/git-cvsserver.txt | 19 ++++++++++---------
 Documentation/git-daemon.txt    | 21 +++++++++++----------
 Documentation/git.txt           |  4 +---
 daemon.c                        |  8 ++++----
 git-cvsserver.perl              |  2 +-
 t/lib-proto-disable.sh          |  6 +++---
 t/t5812-proto-disable-http.sh   |  2 +-
 t/t5815-submodule-protos.sh     |  4 ++--
 t/t9400-git-cvsserver-server.sh |  2 +-
 t/test-lib-functions.sh         |  3 +--
 transport.c                     |  8 ++++----
 11 files changed, 39 insertions(+), 40 deletions(-)


base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1274%2Fderrickstolee%2Fallow-deny-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1274/derrickstolee/allow-deny-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1274

Range-diff vs v2:

 1:  19632a2d245 ! 1:  d5ca7bffac0 Documentation: remove use of whitelist
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    Documentation: remove use of whitelist
     +    daemon: clarify directory arguments
      
     -    The word "whitelist" has cultural implications that are not inclusive.
     -    Thankfully, it is not difficult to reword and avoid its use.
     +    The undecorated arguments to the 'git-daemon' command provide a list of
     +    directories. When at least one directory is specified, then 'git-daemon'
     +    only serves requests that are within that directory list. The boolean
     +    '--strict-paths' option makes the list more explicit in that
     +    subdirectories are no longer included.
      
     -    Remove uses of "whitelist" in the Documentation/ directory. In all
     -    cases, we can rewrite the sentences to add clarity instead of relying on
     -    the reader understanding this term.
     +    The existing documentation and error messages around this directory list
     +    refer to it and its behavior as a "whitelist". The word "whitelist" has
     +    cultural implications that are not inclusive.  Thankfully, it is not
     +    difficult to reword and avoid its use. In the process, we can define the
     +    purpose of this directory list directly.
      
     -    The most substantial change is to git-daemon.txt which had several uses,
     -    but we can refer to the input directories as a list of included
     -    directories, making the descriptions slightly simpler.
     +    In Documentation/git-daemon.txt, rewrite the OPTIONS section around the
     +    '<directory>' option. Add additional clarity to the other options that
     +    refer to these directories.
      
     -    Helped-by: Jeff King <peff@peff.net>
     -    Helped-by: Junio C Hamano <gitster@pobox.com>
     -    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     +    Some error messages can also be improved in daemon.c. The
     +    '--strict-paths' option requires '<directory>' arguments, so refer to
     +    that section of the documentation directly. A logerror() call points out
     +    that a requested directory is not in the specified directory list. We
     +    can use "list" here without any loss of information.
      
     - ## Documentation/git-cvsserver.txt ##
     -@@ Documentation/git-cvsserver.txt: circumstances, allowing easier restricted usage through git-shell.
     - 
     - GIT_CVSSERVER_BASE_PATH takes the place of the argument to --base-path.
     - 
     --GIT_CVSSERVER_ROOT specifies a single-directory whitelist. The
     -+GIT_CVSSERVER_ROOT specifies a single allowed directory. The
     - repository must still be configured to allow access through
     - git-cvsserver, as described above.
     - 
     +    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-daemon.txt ##
      @@ Documentation/git-daemon.txt: that service if it is enabled.
     @@ Documentation/git-daemon.txt: OPTIONS
       	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
       	'git daemon' will refuse to start when this option is enabled and no
      -	whitelist is specified.
     -+	specific directories are specified.
     ++	directory arguments are provided.
       
       --base-path=<path>::
       	Remap all the path requests as relative to the given path.
     @@ Documentation/git-daemon.txt: standard output to be sent to the requestor as an
       
       <directory>::
      -	A directory to add to the whitelist of allowed directories. Unless
     -+	A directory to add to the list of allowed directories. Unless
     - 	--strict-paths is specified this will also include subdirectories
     - 	of each named directory.
     +-	--strict-paths is specified this will also include subdirectories
     +-	of each named directory.
     ++	The remaining arguments provide a list of directories. If any
     ++	directories are specified, then the `git-daemon` process will
     ++	serve a requested directory only if it is contained in one of
     ++	these directories. If `--strict-paths` is specified, then the
     ++	requested directory must match one of these directories exactly.
       
     + SERVICES
     + --------
      @@ Documentation/git-daemon.txt: git		9418/tcp		# Git Version Control System
       
       'git daemon' as inetd server::
     @@ Documentation/git-daemon.txt: git		9418/tcp		# Git Version Control System
      -	repository under the whitelisted set of directories, /pub/foo
      -	and /pub/bar, place an entry like the following into
      -	/etc/inetd all on one line:
     -+	repository in the directory list of `/pub/foo` and `/pub/bar`,
     -+	place an entry like the following into `/etc/inetd` all on one line:
     ++	repository within `/pub/foo` or `/pub/bar`, place an entry like
     ++	the following into `/etc/inetd` all on one line:
       +
       ------------------------------------------------
       	git stream tcp nowait nobody  /usr/bin/git
      
     - ## Documentation/git.txt ##
     -@@ Documentation/git.txt: for full details.
     - 	`protocol.allow` is set to `never`, and each of the listed
     - 	protocols has `protocol.<name>.allow` set to `always`
     - 	(overriding any existing configuration). In other words, any
     --	protocol not mentioned will be disallowed (i.e., this is a
     --	whitelist, not a blacklist). See the description of
     -+	protocol not mentioned will be disallowed. See the description of
     - 	`protocol.allow` in linkgit:git-config[1] for more details.
     + ## daemon.c ##
     +@@ daemon.c: static const char *path_ok(const char *directory, struct hostinfo *hi)
     + 		/* The validation is done on the paths after enter_repo
     + 		 * appends optional {.git,.git/.git} and friends, but
     + 		 * it does not use getcwd().  So if your /pub is
     +-		 * a symlink to /mnt/pub, you can whitelist /pub and
     ++		 * a symlink to /mnt/pub, you can include /pub and
     + 		 * do not have to say /mnt/pub.
     + 		 * Do not say /pub/.
     + 		 */
     +@@ daemon.c: static const char *path_ok(const char *directory, struct hostinfo *hi)
     + 			return path;
     + 	}
     + 
     +-	logerror("'%s': not in whitelist", path);
     ++	logerror("'%s': not in directory list", path);
     + 	return NULL;		/* Fallthrough. Deny by default */
     + }
     + 
     +@@ daemon.c: static int run_service(const char *dir, struct daemon_service *service,
     + 	 * a "git-daemon-export-ok" flag that says that the other side
     + 	 * is ok with us doing this.
     + 	 *
     +-	 * path_ok() uses enter_repo() and does whitelist checking.
     ++	 * path_ok() uses enter_repo() and checks for included directories.
     + 	 * We only need to make sure the repository is exported.
     + 	 */
     + 
     +@@ daemon.c: int cmd_main(int argc, const char **argv)
     + 		cred = prepare_credentials(user_name, group_name);
     + 
     + 	if (strict_paths && (!ok_paths || !*ok_paths))
     +-		die("option --strict-paths requires a whitelist");
     ++		die("option --strict-paths requires '<directory>' arguments");
       
     - `GIT_PROTOCOL_FROM_USER`::
     + 	if (base_path && !is_directory(base_path))
     + 		die("base-path '%s' does not exist or is not a directory",
 -:  ----------- > 2:  db32444b879 git-cvsserver: clarify directory list
 -:  ----------- > 3:  c1c83c4284b git.txt: remove redundant language
 2:  3c3c8c20bcb ! 4:  e08342f07d2 t/*: avoid "whitelist"
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    t/*: avoid "whitelist"
     +    t: avoid "whitelist"
      
          The word "whitelist" has cultural implications that are not inclusive.
          Thankfully, it is not difficult to reword and avoid its use.
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     - ## t/README ##
     -@@ t/README: GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
     - test suite. Accept any boolean values that are accepted by git-config.
     - 
     - GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
     --SANITIZE=leak will run only those tests that have whitelisted
     --themselves as passing with no memory leaks. Tests can be whitelisted
     --by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
     --"test-lib.sh" itself at the top of the test script. This test mode is
     --used by the "linux-leaks" CI target.
     -+SANITIZE=leak will run only those tests that have marked themselves as
     -+passing with no memory leaks by setting "TEST_PASSES_SANITIZE_LEAK=true"
     -+before sourcing "test-lib.sh" itself at the top of the test script. This
     -+test mode is used by the "linux-leaks" CI target.
     - 
     - GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
     - default to n.
     -
       ## t/lib-proto-disable.sh ##
      @@
       # Test routines for checking protocol disabling.
     @@ t/t5812-proto-disable-http.sh: test_expect_success 'create git-accessible repo'
       test_proto "smart http" http "$HTTPD_URL/smart/repo.git"
       
      -test_expect_success 'curl redirects respect whitelist' '
     -+test_expect_success 'curl redirects respect allowed protocols' '
     ++test_expect_success 'http(s) transport respects GIT_ALLOW_PROTOCOL' '
       	test_must_fail env GIT_ALLOW_PROTOCOL=http:https \
       			   GIT_SMART_HTTP=0 \
       		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
     @@ t/t5815-submodule-protos.sh
       #!/bin/sh
       
      -test_description='test protocol whitelisting with submodules'
     -+test_description='test protocol restrictions with submodules'
     ++test_description='test protocol filtering with submodules'
       . ./test-lib.sh
       . "$TEST_DIRECTORY"/lib-proto-disable.sh
       
     @@ t/t5815-submodule-protos.sh: test_expect_success 'update of ext not allowed' '
       '
       
      -test_expect_success 'user can override whitelist' '
     -+test_expect_success 'user can override with environment variable' '
     ++test_expect_success 'user can filter protocols with GIT_ALLOW_PROTOCOL' '
       	GIT_ALLOW_PROTOCOL=ext git -C dst submodule update ext-module
       '
       
      
     - ## t/t9400-git-cvsserver-server.sh ##
     -@@ t/t9400-git-cvsserver-server.sh: test_expect_success 'req_Root (export-all)' \
     -   'cat request-anonymous | git-cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
     -    sed -ne \$p log | grep "^I LOVE YOU\$"'
     - 
     --test_expect_success 'req_Root failure (export-all w/o whitelist)' \
     -+test_expect_success 'req_Root failure (export-all w/o directory)' \
     -   '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
     - 
     - test_expect_success 'req_Root (everything together)' \
     -
       ## t/test-lib-functions.sh ##
      @@ t/test-lib-functions.sh: test_set_prereq () {
       		# test_unset_prereq()
       		!*)
       			;;
      -		# (Temporary?) whitelist of things we can't easily
     -+		# (Temporary?) list of things we can't easily
     - 		# pretend not to support
     +-		# pretend not to support
     ++		# List of things we can't easily pretend to not support
       		SYMLINKS)
       			;;
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: then
     - 	test_done
     - fi
     - 
     --# skip non-whitelisted tests when compiled with SANITIZE=leak
     -+# skip unmarked tests when compiled with SANITIZE=leak
     - if test -n "$SANITIZE_LEAK"
     - then
     - 	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
     + 		# Inspecting whether GIT_TEST_FAIL_PREREQS is on
 3:  0d862cbbebe ! 5:  a4f31877b15 *: avoid "whitelist"
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    *: avoid "whitelist"
     +    transport.c: avoid "whitelist"
      
          The word "whitelist" has cultural implications that are not inclusive.
          Thankfully, it is not difficult to reword and avoid its use.
      
     -    A previous change already modified the documentation for git-cvsserver
     -    and git-daemon to refer to a directory list. It is simple to update the
     -    comments and error messages here to refer to that directory list.
     -
     -    In the case of transport.c, the GIT_ALLOW_PROTOCOL environment variable
     -    was referred to as a "whitelist", but the word "allow" is already part
     -    of the variable. Replace "whitelist" with "allow_list" in these cases to
     -    demonstrate that we are processing a list of allowed protocols.
     -
     -    After this change, the only remaining uses of "whitelist" and its
     -    companion "blacklist" are in release notes for older versions of Git and
     -    in the sha1dc project, which is maintained independently.
     +    The GIT_ALLOW_PROTOCOL environment variable was referred to as a
     +    "whitelist", but the word "allow" is already part of the variable.
     +    Replace "whitelist" with "allow_list" in these cases to demonstrate that
     +    we are processing a list of allowed protocols.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     - ## daemon.c ##
     -@@ daemon.c: static const char *path_ok(const char *directory, struct hostinfo *hi)
     - 		/* The validation is done on the paths after enter_repo
     - 		 * appends optional {.git,.git/.git} and friends, but
     - 		 * it does not use getcwd().  So if your /pub is
     --		 * a symlink to /mnt/pub, you can whitelist /pub and
     -+		 * a symlink to /mnt/pub, you can include /pub and
     - 		 * do not have to say /mnt/pub.
     - 		 * Do not say /pub/.
     - 		 */
     -@@ daemon.c: static const char *path_ok(const char *directory, struct hostinfo *hi)
     - 			return path;
     - 	}
     - 
     --	logerror("'%s': not in whitelist", path);
     -+	logerror("'%s': not in directory list", path);
     - 	return NULL;		/* Fallthrough. Deny by default */
     - }
     - 
     -@@ daemon.c: static int run_service(const char *dir, struct daemon_service *service,
     - 	 * a "git-daemon-export-ok" flag that says that the other side
     - 	 * is ok with us doing this.
     - 	 *
     --	 * path_ok() uses enter_repo() and does whitelist checking.
     -+	 * path_ok() uses enter_repo() and checks for included directories.
     - 	 * We only need to make sure the repository is exported.
     - 	 */
     - 
     -@@ daemon.c: int cmd_main(int argc, const char **argv)
     - 		cred = prepare_credentials(user_name, group_name);
     - 
     - 	if (strict_paths && (!ok_paths || !*ok_paths))
     --		die("option --strict-paths requires a whitelist");
     -+		die("option --strict-paths requires a directory list");
     - 
     - 	if (base_path && !is_directory(base_path))
     - 		die("base-path '%s' does not exist or is not a directory",
     -
     - ## git-cvsserver.perl ##
     -@@ git-cvsserver.perl: $state->{allowed_roots} = [ @ARGV ];
     - 
     - # don't export the whole system unless the users requests it
     - if ($state->{'export-all'} && !@{$state->{allowed_roots}}) {
     --    die "--export-all can only be used together with an explicit whitelist\n";
     -+    die "--export-all can only be used together with an explicit directory list\n";
     - }
     - 
     - # Environment handling for running under git-shell
     -
       ## transport.c ##
      @@ transport.c: static int external_specification_len(const char *url)
       	return strchr(url, ':') - url;

-- 
gitgitgadget
