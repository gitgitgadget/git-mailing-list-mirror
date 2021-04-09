Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F0C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD7C610C8
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhDIEHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhDIEGq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:06:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC2C061765
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so460020wrt.5
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0swm8W6WJgBbvUjZYIG4vVLuuT+kNRjgzO4USZSCbY=;
        b=ulK6HgZHWqSPa4CAxlPo1lSZhJruTY9jNfsUfMRpVCSeky1117hIYF4OirhV9XuAuY
         5KXZyJr5oWHHs3R/oyjigVOtvwpB/B6KvV40UuGqYORnZqZ2hS0i2VnGwQRBd3mMwtON
         YgJ87xzs4Vne4U0boKekohdNm+2ascCOgS8H+N8mAx4JUVgvPbaSkOUgiltwf5NjLNV1
         AlZsD8PJQsXef9zJZ5H9xawlKDRdAAYU2q+yW7Q+i0seiZ/1wrDTwQUUMaJU/BwM+s7O
         AfZOb0Dy5aik5Jeo86jOUd3ie/Mh398Y1ytJZFecmD/9DVZBeL6v4xPXbJovv6RxvJgQ
         JCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0swm8W6WJgBbvUjZYIG4vVLuuT+kNRjgzO4USZSCbY=;
        b=tYiK1EApAXsOF3peo2KY3NAVpEWo0vl7m2MIHDcq3oxc/sByzju3DKddwtnyRjKB6U
         ero+Ebec+ejLjwCeeQCEYP/Hqzk82yTTS+whIOqnIT0gPQJoKA5ri+iWGwCuL+i6dqEJ
         JH15Y2nwdhbd0oxwflnj0s1f5FlhkhXerK++n0ZjQuw2ZOb02rxOROJpx2e3UXAEAHXe
         yG9PIxxKttIx6T+v7AuifJqFnjLoGJ1gngaoKdP1tTEdTHiP0BChdWnO2xPgiLckt/+1
         jPLCUl33Y1SrHn9MgmjDtcFCCppcEsF4bZal6t5L7DV8PAXqot0ldVYO31ZRdlEpeAul
         Yevw==
X-Gm-Message-State: AOAM530wje0mY49UjxwZIGCa4MIMacpKu+5dnK2vVUPPf63gHKLER+5l
        2Y2HY05/2UmVAVsEyNkRa0sHNdcOBAjZbw==
X-Google-Smtp-Source: ABdhPJxQn39QD/1Z2Ok4YYGmdm9secVfLKlJX7yI48djnE8MG1s1ZPAXzmd+iPCNK9Fg88G6Hv33PA==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr15467918wrv.353.1617941152449;
        Thu, 08 Apr 2021 21:05:52 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:51 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 12/13] doc: typeset environment vars without $ in monospace
Date:   Fri,  9 Apr 2021 06:03:00 +0200
Message-Id: <20210409040301.3260358-13-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap environment variables without $ with backticks as indicated in the
CodingGuidelines.

The following command and regex assisted the substitution with manual
intervention to exclude false positives.

    REGEX="(^|[[:space:]]+)['\"]?([A-Z]+)(_[A-Z0-9]+)+['\"]?([[:punct:]]|[[:space:]]+|$)" &&
    for f in $(grep -Pl "$REGEX" *.txt --exclude-dir=RelNotes); do
        emacsclient $f;
    done

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/diff-options.txt        |  2 +-
 Documentation/git-commit.txt          | 12 ++++++------
 Documentation/git-config.txt          | 18 +++++++++---------
 Documentation/git-cvsexportcommit.txt |  4 ++--
 Documentation/git-cvsimport.txt       |  4 ++--
 Documentation/git-cvsserver.txt       | 22 +++++++++++-----------
 Documentation/git-daemon.txt          |  8 ++++----
 Documentation/git-filter-branch.txt   |  6 +++---
 Documentation/git-for-each-ref.txt    |  2 +-
 Documentation/git-fsck.txt            | 10 +++++-----
 Documentation/git-http-backend.txt    | 22 +++++++++++-----------
 Documentation/git-imap-send.txt       |  4 ++--
 Documentation/git-ls-remote.txt       |  2 +-
 Documentation/git-remote-ext.txt      |  6 +++---
 Documentation/git-remote-fd.txt       |  2 +-
 Documentation/git-rev-parse.txt       |  4 ++--
 Documentation/git-send-email.txt      |  4 ++--
 Documentation/git-sh-setup.txt        |  4 ++--
 Documentation/git-svn.txt             |  2 +-
 Documentation/git-tag.txt             |  2 +-
 Documentation/git-var.txt             |  8 ++++----
 Documentation/git.txt                 | 12 ++++++------
 Documentation/gitignore.txt           |  2 +-
 Documentation/gitnamespaces.txt       |  6 +++---
 Documentation/gitweb.conf.txt         | 10 +++++-----
 Documentation/gitweb.txt              | 10 +++++-----
 Documentation/glossary-content.txt    |  2 +-
 27 files changed, 95 insertions(+), 95 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 1b594732aa..0e44e9c2db 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -695,7 +695,7 @@ the normal order.
 --
 +
 Patterns have the same syntax and semantics as patterns used for
-fnmatch(3) without the FNM_PATHNAME flag, except a pathname also
+fnmatch(3) without the `FNM_PATHNAME` flag, except a pathname also
 matches a pattern if removing any number of the final pathname
 components matches the pattern.  For example, the pattern "`foo*bar`"
 matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0594ed1db5..b58eda6bfb 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -504,12 +504,12 @@ COMMIT INFORMATION
 Author and committer information is taken from the following environment
 variables, if set:
 
-	GIT_AUTHOR_NAME
-	GIT_AUTHOR_EMAIL
-	GIT_AUTHOR_DATE
-	GIT_COMMITTER_NAME
-	GIT_COMMITTER_EMAIL
-	GIT_COMMITTER_DATE
+	`GIT_AUTHOR_NAME`
+	`GIT_AUTHOR_EMAIL`
+	`GIT_AUTHOR_DATE`
+	`GIT_COMMITTER_NAME`
+	`GIT_COMMITTER_EMAIL`
+	`GIT_COMMITTER_DATE`
 
 (nb "<", ">" and "\n"s are stripped)
 
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 2201ce6058..e2e0c51535 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -143,7 +143,7 @@ See also <<FILES>>.
 
 `-f config-file`::
 `--file config-file`::
-	Use the given config file instead of the one specified by GIT_CONFIG.
+	Use the given config file instead of the one specified by `GIT_CONFIG`.
 
 `--blob blob`::
 	Similar to `--file` but use the given blob instead of a file. E.g.
@@ -335,25 +335,25 @@ can specify any filename you want.
 ENVIRONMENT
 -----------
 
-GIT_CONFIG::
+`GIT_CONFIG`::
 	Take the configuration from the given file instead of `.git/config`.
 	Using the `--global` option forces this to `~/.gitconfig`. Using the
 	`--system` option forces this to `$(prefix)/etc/gitconfig`.
 
-GIT_CONFIG_NOSYSTEM::
+`GIT_CONFIG_NOSYSTEM`::
 	Whether to skip reading settings from the system-wide
 	`$(prefix)/etc/gitconfig` file. See linkgit:git[1] for details.
 
 See also <<FILES>>.
 
-GIT_CONFIG_COUNT::
-GIT_CONFIG_KEY_<n>::
-GIT_CONFIG_VALUE_<n>::
-	If GIT_CONFIG_COUNT is set to a positive number, all environment pairs
-	GIT_CONFIG_KEY_<n> and GIT_CONFIG_VALUE_<n> up to that number will be
+`GIT_CONFIG_COUNT`::
+`GIT_CONFIG_KEY_`<n>::
+`GIT_CONFIG_VALUE_`<n>::
+	If `GIT_CONFIG_COUNT` is set to a positive number, all environment pairs
+	`GIT_CONFIG_KEY_`<n> and `GIT_CONFIG_VALUE_`<n> up to that number will be
 	added to the process's runtime configuration. The config pairs are
 	zero-indexed. Any missing key or value is treated as an error. An empty
-	GIT_CONFIG_COUNT is treated the same as GIT_CONFIG_COUNT=0, namely no
+	`GIT_CONFIG_COUNT` is treated the same as `GIT_CONFIG_COUNT`=0, namely no
 	pairs are processed. These environment variables will override values
 	in configuration files, but will be overridden by any explicit options
 	passed via `git -c`.
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index a9ef265a34..bc4a82822a 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -19,7 +19,7 @@ Exports a commit from Git to a CVS checkout, making it easier
 to merge patches from a Git repository into a CVS repository.
 
 Specify the name of a CVS checkout using the `-w` switch or execute it
-from the root of the CVS working copy. In the latter case GIT_DIR must
+from the root of the CVS working copy. In the latter case `GIT_DIR` must
 be defined. See examples below.
 
 It does its best to do the safe thing, it will check that the files are
@@ -70,7 +70,7 @@ OPTIONS
 
 `-w`::
 	Specify the location of the CVS checkout to use for the export. This
-	option does not require GIT_DIR to be set before execution if the
+	option does not require `GIT_DIR` to be set before execution if the
 	current directory is within a Git repository.  The default is the
 	value of `cvsexportcommit.cvsdir`.
 
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index c5105348ec..9bed5e943f 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -153,8 +153,8 @@ This option can be used several times to provide several detection regexes.
 ---------
 +
 `git cvsimport` will make it appear as those authors had
-their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
-all along.  If a time zone is specified, GIT_AUTHOR_DATE will
+their `GIT_AUTHOR_NAME` and `GIT_AUTHOR_EMAIL` set properly
+all along.  If a time zone is specified, `GIT_AUTHOR_DATE` will
 have the corresponding offset applied.
 +
 For convenience, this data is saved to `$GIT_DIR/cvs-authors`
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index bd8930eb2b..2ec7fae1ee 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 SSH:
 
 [verse]
-export CVS_SERVER="git cvsserver"
+export `CVS_SERVER`="git cvsserver"
 'cvs' -d :ext:user@server/path/repo.git co <HEAD_name>
 
 pserver (/etc/inetd.conf):
@@ -131,11 +131,11 @@ Then provide your password via the pserver method, for example:
    cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co <HEAD_name>
 ------
 No special setup is needed for SSH access, other than having Git tools
-in the PATH. If you have clients that do not accept the CVS_SERVER
+in the PATH. If you have clients that do not accept the `CVS_SERVER`
 environment variable, you can rename `git-cvsserver` to `cvs`.
 
 Note: Newer CVS versions (>= 1.12.11) also support specifying
-CVS_SERVER directly in CVSROOT like
+`CVS_SERVER` directly in CVSROOT like
 
 ------
 cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
@@ -143,7 +143,7 @@ cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
 This has the advantage that it will be saved in your 'CVS/Root' files and
 you don't need to worry about always setting the correct environment
 variable.  SSH users restricted to `git-shell` don't need to override the default
-with CVS_SERVER (and shouldn't) as `git-shell` understands `cvs` to mean
+with `CVS_SERVER` (and shouldn't) as `git-shell` understands `cvs` to mean
 `git-cvsserver` and pretends that the other end runs the real 'cvs' better.
 --
 2. For each repo that you want accessible from CVS you need to edit config in
@@ -182,7 +182,7 @@ allowing access over SSH.
    automatically saving it in your 'CVS/Root' files, then you need to set them
    explicitly in your environment.  CVSROOT should be set as per normal, but the
    directory should point at the appropriate Git repo.  As above, for SSH clients
-   _not_ restricted to `git-shell`, CVS_SERVER should be set to `git-cvsserver`.
+   _not_ restricted to `git-shell`, `CVS_SERVER` should be set to `git-cvsserver`.
 +
 --
 ------
@@ -192,8 +192,8 @@ allowing access over SSH.
 --
 4. For SSH clients that will make commits, make sure their server-side
    .ssh/environment files (or .bashrc, etc., according to their specific shell)
-   export appropriate values for GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL,
-   GIT_COMMITTER_NAME, and GIT_COMMITTER_EMAIL.  For SSH clients whose login
+   export appropriate values for `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL`,
+   `GIT_COMMITTER_NAME`, and `GIT_COMMITTER_EMAIL`.  For SSH clients whose login
    shell is bash, .bashrc may be a reasonable alternative.
 
 5. Clients should now be able to check out the project. Use the CVS 'module'
@@ -312,9 +312,9 @@ ENVIRONMENT
 These variables obviate the need for command-line options in some
 circumstances, allowing easier restricted usage through `git-shell`.
 
-GIT_CVSSERVER_BASE_PATH takes the place of the argument to `--base-path`.
+`GIT_CVSSERVER_BASE_PATH` takes the place of the argument to `--base-path`.
 
-GIT_CVSSERVER_ROOT specifies a single-directory whitelist. The
+`GIT_CVSSERVER_ROOT` specifies a single-directory whitelist. The
 repository must still be configured to allow access through
 `git-cvsserver`, as described above.
 
@@ -337,12 +337,12 @@ To get a checkout with the Eclipse CVS client:
 
 Protocol notes: If you are using anonymous access via pserver, just select that.
 Those using SSH access should choose the 'ext' protocol, and configure 'ext'
-access on the Preferences->Team->CVS->ExtConnection pane. Set CVS_SERVER to
+access on the Preferences->Team->CVS->ExtConnection pane. Set `CVS_SERVER` to
 "`git cvsserver`". Note that password support is not good when using 'ext',
 you will definitely want to have SSH keys setup.
 
 Alternatively, you can just use the non-standard extssh protocol that Eclipse
-offer. In that case CVS_SERVER is ignored, and you will have to replace
+offer. In that case `CVS_SERVER` is ignored, and you will have to replace
 the cvs utility on the server with `git-cvsserver` or manipulate your `.bashrc`
 so that calling 'cvs' effectively calls `git-cvsserver`.
 
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 533be2b997..e4006d0459 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -25,7 +25,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-A really simple TCP Git daemon that normally listens on port "DEFAULT_GIT_PORT"
+A really simple TCP Git daemon that normally listens on port `DEFAULT_GIT_PORT`
 aka 9418.  It waits for a connection asking for a service, and will serve
 that service if it is enabled.
 
@@ -149,7 +149,7 @@ otherwise `stderr`.
 	Log details about the incoming connections and requested files.
 
 `--reuseaddr`::
-	Use SO_REUSEADDR when binding the listening socket.
+	Use `SO_REUSEADDR` when binding the listening socket.
 	This allows the server to restart without waiting for
 	old connections to time out.
 
@@ -330,8 +330,8 @@ selectively enable/disable services per repository::
 
 ENVIRONMENT
 -----------
-`git daemon` will set REMOTE_ADDR to the IP address of the client
-that connected to it, if the IP address is available. REMOTE_ADDR will
+`git daemon` will set `REMOTE_ADDR` to the IP address of the client
+that connected to it, if the IP address is available. `REMOTE_ADDR` will
 be available in the environment of hooks called when
 services are performed.
 
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 01b572f565..34e36493fe 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -75,9 +75,9 @@ The filters are applied in the order as listed below.  The <command>
 argument is always evaluated in the shell context using the 'eval' command
 (with the notable exception of the commit filter, for technical reasons).
 Prior to that, the `$GIT_COMMIT` environment variable will be set to contain
-the id of the commit being rewritten.  Also, GIT_AUTHOR_NAME,
-GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL,
-and GIT_COMMITTER_DATE are taken from the current commit and exported to
+the id of the commit being rewritten.  Also, `GIT_AUTHOR_NAME`,
+`GIT_AUTHOR_EMAIL`, `GIT_AUTHOR_DATE`, `GIT_COMMITTER_NAME`, `GIT_COMMITTER_EMAIL`,
+and `GIT_COMMITTER_DATE` are taken from the current commit and exported to
 the environment, in order to affect the author and committer identities of
 the replacement commit created by linkgit:git-commit-tree[1] after the
 filters have run.
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 74be946d9d..5f52b386c1 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -132,7 +132,7 @@ For all objects, the following names can be used:
 	The object name (aka SHA-1).
 	For a non-ambiguous abbreviation of the object name append `:short`.
 	For an abbreviation of the object name with desired length append
-	`:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
+	`:short=<length>`, where the minimum length is `MINIMUM_ABBREV`. The
 	length may be exceeded to ensure unique object names.
 `deltabase`::
 	This expands to the object name of the delta base for the
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 6c98485d8f..7ab9123d58 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -52,9 +52,9 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	now aren't, but are still in that corresponding reflog.
 
 `--full`::
-	Check not just objects in GIT_OBJECT_DIRECTORY
+	Check not just objects in `GIT_OBJECT_DIRECTORY`
 	(`$GIT_DIR/objects`), but also the ones found in alternate
-	object pools listed in GIT_ALTERNATE_OBJECT_DIRECTORIES
+	object pools listed in `GIT_ALTERNATE_OBJECT_DIRECTORIES`
 	or `$GIT_DIR/objects/info/alternates`,
 	and in packed Git archives found in `$GIT_DIR/objects/pack`
 	and corresponding pack subdirectories in alternate
@@ -153,13 +153,13 @@ Extracted Diagnostics
 Environment Variables
 ---------------------
 
-GIT_OBJECT_DIRECTORY::
+`GIT_OBJECT_DIRECTORY`::
 	used to specify the object database root (usually `$GIT_DIR/objects`)
 
-GIT_INDEX_FILE::
+`GIT_INDEX_FILE`::
 	used to specify the index file of the index
 
-GIT_ALTERNATE_OBJECT_DIRECTORIES::
+`GIT_ALTERNATE_OBJECT_DIRECTORIES`::
 	used to specify additional object database roots (usually unset)
 
 GIT
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index a286c3648f..6fcbc88567 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -57,10 +57,10 @@ configuration file:
 URL TRANSLATION
 ---------------
 To determine the location of the repository on disk, `git http-backend`
-concatenates the environment variables PATH_INFO, which is set
-automatically by the web server, and GIT_PROJECT_ROOT, which must be set
-manually in the web server configuration.  If GIT_PROJECT_ROOT is not
-set, `git http-backend` reads PATH_TRANSLATED, which is also set
+concatenates the environment variables `PATH_INFO`, which is set
+automatically by the web server, and `GIT_PROJECT_ROOT`, which must be set
+manually in the web server configuration.  If `GIT_PROJECT_ROOT` is not
+set, `git http-backend` reads `PATH_TRANSLATED`, which is also set
 automatically by the web server.
 
 EXAMPLES
@@ -70,7 +70,7 @@ to `/var/www/git/foo/bar.git`.
 
 Apache 2.x::
 	Ensure mod_cgi, mod_alias, and mod_env are enabled, set
-	GIT_PROJECT_ROOT (or DocumentRoot) appropriately, and
+	`GIT_PROJECT_ROOT` (or DocumentRoot) appropriately, and
 	create a ScriptAlias to the CGI:
 +
 ----------------------------------------------------------------
@@ -244,12 +244,12 @@ ENVIRONMENT
 `git http-backend` relies upon the `CGI` environment variables set
 by the invoking web server, including:
 
-* PATH_INFO (if GIT_PROJECT_ROOT is set, otherwise PATH_TRANSLATED)
-* REMOTE_USER
-* REMOTE_ADDR
-* CONTENT_TYPE
-* QUERY_STRING
-* REQUEST_METHOD
+* `PATH_INFO` (if `GIT_PROJECT_ROOT` is set, otherwise `PATH_TRANSLATED`)
+* `REMOTE_USER`
+* `REMOTE_ADDR`
+* `CONTENT_TYPE`
+* `QUERY_STRING`
+* `REQUEST_METHOD`
 
 The `GIT_HTTP_EXPORT_ALL` environmental variable may be passed to
 `git-http-backend` to bypass the check for the `git-daemon-export-ok`
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 644fa7e847..b1eae4550f 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -39,12 +39,12 @@ OPTIONS
 
 `--curl`::
 	Use libcurl to communicate with the IMAP server, unless tunneling
-	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
+	into it.  Ignored if Git was built without the `USE_CURL_FOR_IMAP_SEND`
 	option set.
 
 `--no-curl`::
 	Talk to the IMAP server using git's own IMAP routines instead of
-	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
+	using libcurl.  Ignored if Git was built with the `NO_OPENSSL` option
 	set.
 
 
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 0bc6dbabf3..929749e6c0 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -42,7 +42,7 @@ OPTIONS
 `--upload-pack=<exec>`::
 	Specify the full path of `git-upload-pack` on the remote
 	host. This allows listing references from repositories accessed via
-	SSH and where the SSH daemon does not use the PATH configured by the
+	SSH and where the SSH daemon does not use the `PATH` configured by the
 	user.
 
 `--exit-code`::
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 49057434cd..bc0f315078 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -58,17 +58,17 @@ some tunnel.
 ENVIRONMENT VARIABLES
 ---------------------
 
-GIT_TRANSLOOP_DEBUG::
+`GIT_TRANSLOOP_DEBUG`::
 	If set, prints debugging information about various reads/writes.
 
 ENVIRONMENT VARIABLES PASSED TO COMMAND
 ---------------------------------------
 
-GIT_EXT_SERVICE::
+`GIT_EXT_SERVICE`::
 	Set to long name (`git-upload-pack`, etc...) of service helper needs
 	to invoke.
 
-GIT_EXT_SERVICE_NOPREFIX::
+`GIT_EXT_SERVICE_NOPREFIX`::
 	Set to long name (upload-pack, etc...) of service helper needs
 	to invoke.
 
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 239844f827..ce61ae4165 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -30,7 +30,7 @@ context.
 
 ENVIRONMENT VARIABLES
 ---------------------
-GIT_TRANSLOOP_DEBUG::
+`GIT_TRANSLOOP_DEBUG`::
 	If set, prints debugging information about various reads/writes.
 
 EXAMPLES
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 191ec94ec7..8d7b157429 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -208,7 +208,7 @@ Options for Files
 
 `--local-env-vars`::
 	List the GIT_* environment variables that are local to the
-	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
+	repository (e.g. `GIT_DIR` or `GIT_WORK_TREE`, but not `GIT_EDITOR`).
 	Only the names of the variables are listed, not their value,
 	even if they are set.
 
@@ -385,7 +385,7 @@ Example
 ~~~~~~~
 
 ------------
-OPTS_SPEC="\
+`OPTS_SPEC`="\
 some-command [<options>] <args>...
 
 some-command does foo and bar!
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index abd617524c..87ef1ceff3 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -63,7 +63,7 @@ This option may be specified multiple times.
 This option may be specified multiple times.
 
 `--compose`::
-	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
+	Invoke a text editor (see `GIT_EDITOR` in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
 When `--compose` is used, `git send-email` will use the From, Subject, and
@@ -81,7 +81,7 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
 	the value of the `sendemail.from` configuration option is used.  If
 	neither the command-line option nor `sendemail.from` are set, then the
 	user will be prompted for the value.  The default for the prompt will be
-	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
+	the value of `GIT_AUTHOR_IDENT`, or `GIT_COMMITTER_IDENT` if that is not
 	set, as returned by `git var -l`.
 
 `--reply-to=<address>`::
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index d1e999d60e..2cd438ca1b 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -81,8 +81,8 @@ require_clean_work_tree rebase "Please commit or stash them."
 ----------------
 
 get_author_ident_from_commit::
-	outputs code for use with eval to set the GIT_AUTHOR_NAME,
-	GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE variables for a given commit.
+	outputs code for use with eval to set the `GIT_AUTHOR_NAME`,
+	`GIT_AUTHOR_EMAIL` and `GIT_AUTHOR_DATE` variables for a given commit.
 
 create_virtual_base::
 	modifies the first file so only lines in common with the
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 5e31bd8088..0185ff1d1b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -722,7 +722,7 @@ ADVANCED OPTIONS
 
 -i<GIT_SVN_ID>::
 --id <GIT_SVN_ID>::
-	This sets GIT_SVN_ID (instead of using the environment).  This
+	This sets `GIT_SVN_ID` (instead of using the environment).  This
 	allows the user to override the default refname to fetch from
 	when tracking a single URL.  The `log` and `dcommit` commands
 	no longer require this switch as an argument.
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 8c6a00d0aa..23b259fc60 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -366,7 +366,7 @@ the tag object affects, for example, the ordering of tags in the
 `gitweb` interface.
 
 To set the date used in future tag objects, set the environment
-variable GIT_COMMITTER_DATE (see the later discussion of possible
+variable `GIT_COMMITTER_DATE` (see the later discussion of possible
 values; the most common form is "YYYY-MM-DD HH:MM").
 
 For example:
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index a33b76589a..82448d40a4 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -31,13 +31,13 @@ EXAMPLES
 
 VARIABLES
 ---------
-GIT_AUTHOR_IDENT::
+`GIT_AUTHOR_IDENT`::
     The author of a piece of code.
 
-GIT_COMMITTER_IDENT::
+`GIT_COMMITTER_IDENT`::
     The person who put a piece of code into Git.
 
-GIT_EDITOR::
+`GIT_EDITOR`::
     Text editor for use by Git commands.  The value is meant to be
     interpreted by the shell when it is used.  Examples: `~/bin/vi`,
     `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
@@ -49,7 +49,7 @@ ifdef::git-default-editor[]
     The build you are using chose '{git-default-editor}' as the default.
 endif::git-default-editor[]
 
-GIT_PAGER::
+`GIT_PAGER`::
     Text viewer for use by Git commands (e.g., 'less').  The value
     is meant to be interpreted by the shell.  The order of preference
     is the `$GIT_PAGER` environment variable, then `core.pager`
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8e511669fe..2328f8bd0b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -104,7 +104,7 @@ sensitive information can be part of the key.
 
 `--exec-path[=<path>]`::
 	Path to wherever your core Git programs are installed.
-	This can also be controlled by setting the GIT_EXEC_PATH
+	This can also be controlled by setting the `GIT_EXEC_PATH`
 	environment variable. If no path is given, `git` will print
 	the current setting and then exit.
 
@@ -153,7 +153,7 @@ If you just want to run `git` as if it was started in `<path>` then use
 `--work-tree=<path>`::
 	Set the path to the working tree. It can be an absolute path
 	or a path relative to the current working directory.
-	This can also be controlled by setting the GIT_WORK_TREE
+	This can also be controlled by setting the `GIT_WORK_TREE`
 	environment variable and the `core.worktree` configuration
 	variable (see `core.worktree` in linkgit:git-config[1] for a
 	more detailed discussion).
@@ -169,7 +169,7 @@ If you just want to run `git` as if it was started in `<path>` then use
 	context about the superproject that invoked it.
 
 `--bare`::
-	Treat the repository as a bare repository.  If GIT_DIR
+	Treat the repository as a bare repository.  If `GIT_DIR`
 	environment is not set, it is set to the current working
 	directory.
 
@@ -493,7 +493,7 @@ double-quotes and respecting backslash escapes. E.g., the value
 	set, it is a list of directories that Git should not chdir up
 	into while looking for a repository directory (useful for
 	excluding slow-loading network directories).  It will not
-	exclude the current working directory or a GIT_DIR set on the
+	exclude the current working directory or a `GIT_DIR` set on the
 	command line or in the environment.  Normally, Git has to read
 	the entries in this list and resolve any symlink that
 	might be present in order to compare them with the current
@@ -520,7 +520,7 @@ double-quotes and respecting backslash escapes. E.g., the value
 	taken from `$GIT_DIR`. See linkgit:gitrepository-layout[5] and
 	linkgit:git-worktree[1] for
 	details. This variable has lower precedence than other path
-	variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
+	variables such as `GIT_INDEX_FILE`, `GIT_OBJECT_DIRECTORY`...
 
 `GIT_DEFAULT_HASH`::
 	If this variable is set, the default hash algorithm for new
@@ -582,7 +582,7 @@ Git Diffs
 +
 where:
 
-	<old|new>-file:: are files GIT_EXTERNAL_DIFF can use to read the
+	<old|new>-file:: are files `GIT_EXTERNAL_DIFF` can use to read the
                          contents of <old|new>,
 	<old|new>-hex:: are the 40-hexdigit SHA-1 hashes,
 	<old|new>-mode:: are the octal representation of the file modes.
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 6dd09bd290..c969961e32 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -110,7 +110,7 @@ PATTERN FORMAT
    The character "`?`" matches any one character except "`/`".
    The range notation, e.g. `[a-zA-Z]`, can be used to match
    one of the characters in a range. See fnmatch(3) and the
-   FNM_PATHNAME flag for a more detailed description.
+   `FNM_PATHNAME` flag for a more detailed description.
 
 Two consecutive asterisks ("`**`") in patterns matched against
 full pathname may have special meaning:
diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespaces.txt
index 6a273464a4..eb9f8d9801 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/gitnamespaces.txt
@@ -8,8 +8,8 @@ gitnamespaces - Git namespaces
 SYNOPSIS
 --------
 [verse]
-GIT_NAMESPACE=<namespace> `git upload-pack`
-GIT_NAMESPACE=<namespace> `git receive-pack`
+`GIT_NAMESPACE`=<namespace> `git upload-pack`
+`GIT_NAMESPACE`=<namespace> `git receive-pack`
 
 
 DESCRIPTION
@@ -51,7 +51,7 @@ names of refs as specified by `GIT_NAMESPACE`.  `git-upload-pack` and
 namespace.
 
 The smart HTTP server, linkgit:git-http-backend[1], will pass
-GIT_NAMESPACE through to the backend programs; see
+`GIT_NAMESPACE` through to the backend programs; see
 linkgit:git-http-backend[1] for sample configuration to expose
 repository namespaces as repositories.
 
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 9cd1e9dc67..0acca768e0 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -591,7 +591,7 @@ header.
 	Base URL for relative URLs in pages generated by `gitweb`,
 	(e.g. `$logo`, `$favicon`, `@stylesheets` if they are relative URLs),
 	needed and used '<base href="$base_url">' only for URLs with nonempty
-	PATH_INFO.  Usually `gitweb` sets its value correctly,
+	`PATH_INFO`.  Usually `gitweb` sets its value correctly,
 	and there is no need to set this variable, e.g. to `$my_uri` or "/".
 	See `$per_request_config` if you need to override it anyway.
 
@@ -902,7 +902,7 @@ EXAMPLES
 
 To enable blame, pickaxe search, and snapshot support (allowing "tar.gz" and
 "zip" snapshots), while allowing individual projects to turn them off, put
-the following in your GITWEB_CONFIG file:
+the following in your `GITWEB_CONFIG` file:
 
 --------------------------------------------------------------------------------
 $feature{'blame'}{'default'} = [1];
@@ -936,12 +936,12 @@ ENVIRONMENT
 The location of per-instance and system-wide configuration files can be
 overridden using the following environment variables:
 
-GITWEB_CONFIG::
+`GITWEB_CONFIG`::
 	Sets location of per-instance configuration file.
-GITWEB_CONFIG_SYSTEM::
+`GITWEB_CONFIG_SYSTEM`::
 	Sets location of fallback system-wide configuration file.
 	This file is read only if per-instance one does not exist.
-GITWEB_CONFIG_COMMON::
+`GITWEB_CONFIG_COMMON`::
 	Sets location of common system-wide configuration file.
 
 
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index e863f739b1..0325c82ed1 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -93,7 +93,7 @@ TAB and LF, (used to separate fields in a record).
 
 * Currently recognized fields are:
 `<repository path>`::
-	path to repository GIT_DIR, relative to `$projectroot`
+	path to repository `GIT_DIR`, relative to `$projectroot`
 `<repository owner>`::
 	displayed as repository owner, preferably full name, or email,
 	or both
@@ -122,7 +122,7 @@ listed in projects list file will be accessible).
 Generating projects list using `gitweb`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-We assume that GITWEB_CONFIG has its default Makefile value, namely
+We assume that `GITWEB_CONFIG` has its default Makefile value, namely
 'gitweb_config.perl'. Put the following in 'gitweb_make_index.perl' file:
 ----------------------------------------------------------------------------
 read_config_file("gitweb_config.perl");
@@ -130,7 +130,7 @@ $projects_list = $projectroot;
 ----------------------------------------------------------------------------
 
 Then create the following script to get list of project in the format
-suitable for GITWEB_LIST build configuration variable (or
+suitable for `GITWEB_LIST` build configuration variable (or
 `$projects_list` variable in `gitweb` config):
 
 ----------------------------------------------------------------------------
@@ -603,7 +603,7 @@ the third and the fourth.
 
 PATH_INFO usage
 ~~~~~~~~~~~~~~~
-If you enable PATH_INFO usage in `gitweb` by putting
+If you enable `PATH_INFO` usage in `gitweb` by putting
 ----------------------------------------------------------------------------
 $feature{'pathinfo'}{'default'} = [1];
 ----------------------------------------------------------------------------
@@ -637,7 +637,7 @@ complementary static files (stylesheet, favicon, JavaScript):
 </VirtualHost>
 ----------------------------------------------------------------------------
 The rewrite rule guarantees that existing static files will be properly
-served, whereas any other URL will be passed to `gitweb` as PATH_INFO
+served, whereas any other URL will be passed to `gitweb` as `PATH_INFO`
 parameter.
 
 *Notice* that in this case you don't need special settings for
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 122b5a71ea..e4db76fd04 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -366,7 +366,7 @@ should not be combined with other pathspec.
 
 `glob`;;
 	Git treats the pattern as a shell glob suitable for
-	consumption by fnmatch(3) with the FNM_PATHNAME flag:
+	consumption by fnmatch(3) with the `FNM_PATHNAME` flag:
 	wildcards in the pattern will not match a / in the pathname.
 	For example, "Documentation/{asterisk}.html" matches
 	"Documentation/git.html" but not "Documentation/ppc/ppc.html"
-- 
2.31.1.133.g84d06cdc06

