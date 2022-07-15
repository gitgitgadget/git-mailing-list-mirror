Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE32CCA47B
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 02:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbiGOCiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 22:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiGOCis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 22:38:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103D313D60
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:38:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j1so453455wrs.4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 19:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QthTSLypmOYJy2Q+e0wkNAUHp71zDPTfkW3MkMLzLy8=;
        b=nbin3FcxuISvKU9hhwfgTFET/WuRXfBsmtGBn3o1vdIfqkDrEwJP9zwMWKC88L6eFE
         EFG+HZfpgTcRmXZWwPrk5f8Qo7ZStlRMx8uoAH7mcj0/f9XPoaM79EvRaewUgVJ/HZCM
         Q0Q2cU84sPBgFKUGRHu/rXHjGY/wTKHqGbbj72byziJqXzvdvJThYMQQMRoJhderKAbG
         5J/ocu6RbxrfLyZ8q7bbT2AOJxXBdGJJW6J6mf6jPsNXyI+GFkmffCwnwj9VS4MQDTGH
         asmyNzVUuw8CieE7/GpJmvVLkxY5qKYlfye63LhvtGCz/LCyfmGHSBUcxM26bK6wEnqh
         tKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QthTSLypmOYJy2Q+e0wkNAUHp71zDPTfkW3MkMLzLy8=;
        b=yN++zxOV35y2O2oNDus+rf2BIC9V0bXFP2K9TfrXg3koxJvOTZ9WYgxB350jzAIHrx
         HRrFVHKJjJjClvRX/BwzLrlWphbg4HLnm+2nz9IrwWo1wDrkNfdNq1uZRZ8R3CQoTiXu
         cpRcKwTpP6zsKKcg6li0LbnWKxbM6SMymTqfZi10FT77WHm5zL+IV/M0pRparZFIw5RS
         Vx9eqplEUQTTgmUJ08EuEVP5JZTkWdNv9NDzFhWViaOvbEfoFdrreDcc+D6lvAFRp1uU
         eILHTzeINgPjbrTgJiAdxJut7vORWVt8I9d/ANyUgVXkc6cbfIoF7Jwi4Um1wFJeDRU6
         wyAg==
X-Gm-Message-State: AJIora8HvoBAimTWunBFJuvBGsk9OnnL+8TSijFyGWi/4e0hWr6+6lCS
        vIJj16N+3aREqbiYaUB9Jy/m/WJHDGo=
X-Google-Smtp-Source: AGRyM1voprMHP6d+PZQisJ8ENGo/JIXIePOz0LKup4y49sUgtvR6obIQTJYrVw096EmRtxJMCVD+0w==
X-Received: by 2002:a5d:6d0c:0:b0:21d:a0d7:bf04 with SMTP id e12-20020a5d6d0c000000b0021da0d7bf04mr11271752wrq.76.1657852723954;
        Thu, 14 Jul 2022 19:38:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17-20020adffd51000000b0021d746d4820sm2632727wrs.37.2022.07.14.19.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 19:38:43 -0700 (PDT)
Message-Id: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Jul 2022 02:38:39 +0000
Subject: [PATCH v2 0/3] Remove use of "whitelist"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
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

Thanks, -Stolee

Derrick Stolee (3):
  Documentation: remove use of whitelist
  t/*: avoid "whitelist"
  *: avoid "whitelist"

 Documentation/git-cvsserver.txt |  2 +-
 Documentation/git-daemon.txt    | 15 +++++++--------
 Documentation/git.txt           |  3 +--
 daemon.c                        |  8 ++++----
 git-cvsserver.perl              |  2 +-
 t/README                        |  9 ++++-----
 t/lib-proto-disable.sh          |  6 +++---
 t/t5812-proto-disable-http.sh   |  2 +-
 t/t5815-submodule-protos.sh     |  4 ++--
 t/t9400-git-cvsserver-server.sh |  2 +-
 t/test-lib-functions.sh         |  2 +-
 t/test-lib.sh                   |  2 +-
 transport.c                     |  8 ++++----
 13 files changed, 31 insertions(+), 34 deletions(-)


base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1274%2Fderrickstolee%2Fallow-deny-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1274/derrickstolee/allow-deny-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1274

Range-diff vs v1:

 1:  ec81aac05c4 ! 1:  19632a2d245 Documentation: use allowlist and denylist
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    Documentation: use allowlist and denylist
     +    Documentation: remove use of whitelist
      
     -    Using "allowlist" and "denylist" is a more precise definition of the
     -    functionality they provide. The previous color-based words assume
     -    cultural interpretation to provide the meaning.
     +    The word "whitelist" has cultural implications that are not inclusive.
     +    Thankfully, it is not difficult to reword and avoid its use.
      
     -    Focus on replacements in the Documentation/ directory since these are
     -    not functional uses.
     +    Remove uses of "whitelist" in the Documentation/ directory. In all
     +    cases, we can rewrite the sentences to add clarity instead of relying on
     +    the reader understanding this term.
      
     +    The most substantial change is to git-daemon.txt which had several uses,
     +    but we can refer to the input directories as a list of included
     +    directories, making the descriptions slightly simpler.
     +
     +    Helped-by: Jeff King <peff@peff.net>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-cvsserver.txt ##
     @@ Documentation/git-cvsserver.txt: circumstances, allowing easier restricted usage
       GIT_CVSSERVER_BASE_PATH takes the place of the argument to --base-path.
       
      -GIT_CVSSERVER_ROOT specifies a single-directory whitelist. The
     -+GIT_CVSSERVER_ROOT specifies a single-directory allowlist. The
     ++GIT_CVSSERVER_ROOT specifies a single allowed directory. The
       repository must still be configured to allow access through
       git-cvsserver, as described above.
       
      
       ## Documentation/git-daemon.txt ##
     -@@ Documentation/git-daemon.txt: It verifies that the directory has the magic file "git-daemon-export-ok", and
     +@@ Documentation/git-daemon.txt: that service if it is enabled.
     + It verifies that the directory has the magic file "git-daemon-export-ok", and
       it will refuse to export any Git directory that hasn't explicitly been marked
       for export this way (unless the `--export-all` parameter is specified). If you
     - pass some directory paths as 'git daemon' arguments, you can further restrict
     +-pass some directory paths as 'git daemon' arguments, you can further restrict
      -the offers to a whitelist comprising of those.
     -+the offers to a allowlist comprising of those.
     ++pass some directory paths as 'git daemon' arguments, the offers are limited to
     ++repositories within those directories.
       
       By default, only `upload-pack` service is enabled, which serves
       'git fetch-pack' and 'git ls-remote' clients, which are invoked
     @@ Documentation/git-daemon.txt: OPTIONS
       	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
       	'git daemon' will refuse to start when this option is enabled and no
      -	whitelist is specified.
     -+	allowlist is specified.
     ++	specific directories are specified.
       
       --base-path=<path>::
       	Remap all the path requests as relative to the given path.
     @@ Documentation/git-daemon.txt: OPTIONS
       	and %D for the absolute path of the named repository.
       	After interpolation, the path is validated against the directory
      -	whitelist.
     -+	allowlist.
     ++	list.
       
       --export-all::
       	Allow pulling from all directories that look like Git repositories
     @@ Documentation/git-daemon.txt: standard output to be sent to the requestor as an
       
       <directory>::
      -	A directory to add to the whitelist of allowed directories. Unless
     -+	A directory to add to the allowlist of allowed directories. Unless
     ++	A directory to add to the list of allowed directories. Unless
       	--strict-paths is specified this will also include subdirectories
       	of each named directory.
       
     @@ Documentation/git-daemon.txt: git		9418/tcp		# Git Version Control System
       'git daemon' as inetd server::
       	To set up 'git daemon' as an inetd service that handles any
      -	repository under the whitelisted set of directories, /pub/foo
     -+	repository under the allowlisted set of directories, /pub/foo
     - 	and /pub/bar, place an entry like the following into
     - 	/etc/inetd all on one line:
     +-	and /pub/bar, place an entry like the following into
     +-	/etc/inetd all on one line:
     ++	repository in the directory list of `/pub/foo` and `/pub/bar`,
     ++	place an entry like the following into `/etc/inetd` all on one line:
       +
     + ------------------------------------------------
     + 	git stream tcp nowait nobody  /usr/bin/git
      
       ## Documentation/git.txt ##
      @@ Documentation/git.txt: for full details.
     + 	`protocol.allow` is set to `never`, and each of the listed
       	protocols has `protocol.<name>.allow` set to `always`
       	(overriding any existing configuration). In other words, any
     - 	protocol not mentioned will be disallowed (i.e., this is a
     +-	protocol not mentioned will be disallowed (i.e., this is a
      -	whitelist, not a blacklist). See the description of
     -+	allowlist, not a denylist). See the description of
     ++	protocol not mentioned will be disallowed. See the description of
       	`protocol.allow` in linkgit:git-config[1] for more details.
       
       `GIT_PROTOCOL_FROM_USER`::
 2:  0d82c2a09c5 ! 2:  3c3c8c20bcb t/*: use allowlist
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    t/*: use allowlist
     +    t/*: avoid "whitelist"
      
     -    Using "allowlist" is a more precise definition of the functionality
     -    provided. The previous color-based word assume cultural interpretation
     -    to provide the meaning.
     +    The word "whitelist" has cultural implications that are not inclusive.
     +    Thankfully, it is not difficult to reword and avoid its use.
      
          Focus on changes in the test scripts, since most of the changes are in
     -    comments and test names. The one exception is the renamed test_allowlist
     -    helper.
     +    comments and test names. The renamed test_allow_var helper is only used
     +    once inside the widely-used test_proto helper.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ t/README: GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
       GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
      -SANITIZE=leak will run only those tests that have whitelisted
      -themselves as passing with no memory leaks. Tests can be whitelisted
     -+SANITIZE=leak will run only those tests that have allowlisted
     -+themselves as passing with no memory leaks. Tests can be allowlisted
     - by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
     - "test-lib.sh" itself at the top of the test script. This test mode is
     - used by the "linux-leaks" CI target.
     +-by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
     +-"test-lib.sh" itself at the top of the test script. This test mode is
     +-used by the "linux-leaks" CI target.
     ++SANITIZE=leak will run only those tests that have marked themselves as
     ++passing with no memory leaks by setting "TEST_PASSES_SANITIZE_LEAK=true"
     ++before sourcing "test-lib.sh" itself at the top of the test script. This
     ++test mode is used by the "linux-leaks" CI target.
     + 
     + GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
     + default to n.
      
       ## t/lib-proto-disable.sh ##
      @@
     @@ t/lib-proto-disable.sh
       
      -# Test clone/fetch/push with GIT_ALLOW_PROTOCOL whitelist
      -test_whitelist () {
     -+# Test clone/fetch/push with GIT_ALLOW_PROTOCOL allowlist
     -+test_allowlist () {
     ++# Test clone/fetch/push with GIT_ALLOW_PROTOCOL environment variable
     ++test_allow_var () {
       	desc=$1
       	proto=$2
       	url=$3
     @@ t/lib-proto-disable.sh: test_config () {
       #   $3 - the URL to try cloning
       test_proto () {
      -	test_whitelist "$@"
     -+	test_allowlist "$@"
     ++	test_allow_var "$@"
       
       	test_config "$@"
       }
     @@ t/t5812-proto-disable-http.sh: test_expect_success 'create git-accessible repo'
       test_proto "smart http" http "$HTTPD_URL/smart/repo.git"
       
      -test_expect_success 'curl redirects respect whitelist' '
     -+test_expect_success 'curl redirects respect allowlist' '
     ++test_expect_success 'curl redirects respect allowed protocols' '
       	test_must_fail env GIT_ALLOW_PROTOCOL=http:https \
       			   GIT_SMART_HTTP=0 \
       		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
     @@ t/t5815-submodule-protos.sh
       #!/bin/sh
       
      -test_description='test protocol whitelisting with submodules'
     -+test_description='test protocol allowlisting with submodules'
     ++test_description='test protocol restrictions with submodules'
       . ./test-lib.sh
       . "$TEST_DIRECTORY"/lib-proto-disable.sh
       
     @@ t/t5815-submodule-protos.sh: test_expect_success 'update of ext not allowed' '
       '
       
      -test_expect_success 'user can override whitelist' '
     -+test_expect_success 'user can override allowlist' '
     ++test_expect_success 'user can override with environment variable' '
       	GIT_ALLOW_PROTOCOL=ext git -C dst submodule update ext-module
       '
       
     @@ t/t9400-git-cvsserver-server.sh: test_expect_success 'req_Root (export-all)' \
          sed -ne \$p log | grep "^I LOVE YOU\$"'
       
      -test_expect_success 'req_Root failure (export-all w/o whitelist)' \
     -+test_expect_success 'req_Root failure (export-all w/o allowlist)' \
     ++test_expect_success 'req_Root failure (export-all w/o directory)' \
         '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
       
       test_expect_success 'req_Root (everything together)' \
     @@ t/test-lib-functions.sh: test_set_prereq () {
       		!*)
       			;;
      -		# (Temporary?) whitelist of things we can't easily
     -+		# (Temporary?) allowlist of things we can't easily
     ++		# (Temporary?) list of things we can't easily
       		# pretend not to support
       		SYMLINKS)
       			;;
     @@ t/test-lib.sh: then
       fi
       
      -# skip non-whitelisted tests when compiled with SANITIZE=leak
     -+# skip non-allowlisted tests when compiled with SANITIZE=leak
     ++# skip unmarked tests when compiled with SANITIZE=leak
       if test -n "$SANITIZE_LEAK"
       then
       	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 3:  8aaceedb7a8 ! 3:  0d862cbbebe *: use allowlist and denylist
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    *: use allowlist and denylist
     +    *: avoid "whitelist"
      
     -    Using "allowlist" and "denylist" is a more precise definition of the
     -    functionality they provide. The previous color-based words assume
     -    cultural interpretation to provide the meaning.
     +    The word "whitelist" has cultural implications that are not inclusive.
     +    Thankfully, it is not difficult to reword and avoid its use.
      
     -    These changes to the Git codebase are mostly cosmetic. Several comments
     -    are updated. The renamed protocol_allowlist() method is local to
     -    transport.c so does not update any header file API definition. There are
     -    some untranslated error messages that are reworded, so this _might_
     -    affect error parsers. However, two of the three error messages are
     -    around option parsing, so they are "fast failures". The one perhaps
     -    meaningful change is the logerror() in daemon.c.
     +    A previous change already modified the documentation for git-cvsserver
     +    and git-daemon to refer to a directory list. It is simple to update the
     +    comments and error messages here to refer to that directory list.
      
     -    After this change, the only remaining uses of the previous words are
     -    in release notes for older versions of Git.
     +    In the case of transport.c, the GIT_ALLOW_PROTOCOL environment variable
     +    was referred to as a "whitelist", but the word "allow" is already part
     +    of the variable. Replace "whitelist" with "allow_list" in these cases to
     +    demonstrate that we are processing a list of allowed protocols.
     +
     +    After this change, the only remaining uses of "whitelist" and its
     +    companion "blacklist" are in release notes for older versions of Git and
     +    in the sha1dc project, which is maintained independently.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ daemon.c: static const char *path_ok(const char *directory, struct hostinfo *hi)
       		 * appends optional {.git,.git/.git} and friends, but
       		 * it does not use getcwd().  So if your /pub is
      -		 * a symlink to /mnt/pub, you can whitelist /pub and
     -+		 * a symlink to /mnt/pub, you can allowlist /pub and
     ++		 * a symlink to /mnt/pub, you can include /pub and
       		 * do not have to say /mnt/pub.
       		 * Do not say /pub/.
       		 */
     @@ daemon.c: static const char *path_ok(const char *directory, struct hostinfo *hi)
       	}
       
      -	logerror("'%s': not in whitelist", path);
     -+	logerror("'%s': not in allowlist", path);
     ++	logerror("'%s': not in directory list", path);
       	return NULL;		/* Fallthrough. Deny by default */
       }
       
     @@ daemon.c: static int run_service(const char *dir, struct daemon_service *service
       	 * is ok with us doing this.
       	 *
      -	 * path_ok() uses enter_repo() and does whitelist checking.
     -+	 * path_ok() uses enter_repo() and does allowlist checking.
     ++	 * path_ok() uses enter_repo() and checks for included directories.
       	 * We only need to make sure the repository is exported.
       	 */
       
     @@ daemon.c: int cmd_main(int argc, const char **argv)
       
       	if (strict_paths && (!ok_paths || !*ok_paths))
      -		die("option --strict-paths requires a whitelist");
     -+		die("option --strict-paths requires a allowlist");
     ++		die("option --strict-paths requires a directory list");
       
       	if (base_path && !is_directory(base_path))
       		die("base-path '%s' does not exist or is not a directory",
     @@ git-cvsserver.perl: $state->{allowed_roots} = [ @ARGV ];
       # don't export the whole system unless the users requests it
       if ($state->{'export-all'} && !@{$state->{allowed_roots}}) {
      -    die "--export-all can only be used together with an explicit whitelist\n";
     -+    die "--export-all can only be used together with an explicit allowlist\n";
     ++    die "--export-all can only be used together with an explicit directory list\n";
       }
       
       # Environment handling for running under git-shell
      
     - ## sha1dc/sha1.c ##
     -@@
     -        defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
     -        defined(__sparc))
     - /*
     -- * Should define Big Endian for a whitelist of known processors. See
     -+ * Should define Big Endian for a allowlist of known processors. See
     -  * https://sourceforge.net/p/predef/wiki/Endianness/ and
     -  * http://www.oracle.com/technetwork/server-storage/solaris/portingtosolaris-138514.html
     -  */
     - #define SHA1DC_BIGENDIAN
     - 
     --/* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> */
     -+/* Not under GCC-alike or glibc or *BSD or newlib or <processor allowlist> */
     - #elif (defined(_AIX) || defined(__hpux))
     - 
     - /*
     -- * Defines Big Endian on a whitelist of OSs that are known to be Big
     -+ * Defines Big Endian on a allowlist of OSs that are known to be Big
     -  * Endian-only. See
     -  * https://lore.kernel.org/git/93056823-2740-d072-1ebd-46b440b33d7e@felt.demon.nl/
     -  */
     - #define SHA1DC_BIGENDIAN
     - 
     --/* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> or <os whitelist> */
     -+/* Not under GCC-alike or glibc or *BSD or newlib or <processor allowlist> or <os allowlist> */
     - #elif defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
     - /*
     -  * As a last resort before we do anything else we're not 100% sure
     -- * about below, we blacklist specific processors here. We could add
     -+ * about below, we denylist specific processors here. We could add
     -  * more, see e.g. https://wiki.debian.org/ArchitectureSpecificsMemo
     -  */
     --#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor whitelist> or <os whitelist> or <processor blacklist> */
     -+#else /* Not under GCC-alike or glibc or *BSD or newlib or <processor allowlist> or <os allowlist> or <processor denylist> */
     - 
     - /* We do nothing more here for now */
     - /*#error "Uncomment this to see if you fall through all the detection"*/
     -
       ## transport.c ##
      @@ transport.c: static int external_specification_len(const char *url)
       	return strchr(url, ':') - url;
       }
       
      -static const struct string_list *protocol_whitelist(void)
     -+static const struct string_list *protocol_allowlist(void)
     ++static const struct string_list *protocol_allow_list(void)
       {
       	static int enabled = -1;
       	static struct string_list allowed = STRING_LIST_INIT_DUP;
     @@ transport.c: static enum protocol_allow_config get_protocol_config(const char *t
      -	const struct string_list *whitelist = protocol_whitelist();
      -	if (whitelist)
      -		return string_list_has_string(whitelist, type);
     -+	const struct string_list *allowlist = protocol_allowlist();
     -+	if (allowlist)
     -+		return string_list_has_string(allowlist, type);
     ++	const struct string_list *allow_list = protocol_allow_list();
     ++	if (allow_list)
     ++		return string_list_has_string(allow_list, type);
       
       	switch (get_protocol_config(type)) {
       	case PROTOCOL_ALLOW_ALWAYS:

-- 
gitgitgadget
