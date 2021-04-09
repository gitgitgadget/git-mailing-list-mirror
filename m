Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2D5C43462
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CB061175
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhDIEGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhDIEF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:05:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792CEC0613D7
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so3947679wma.3
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9tI7NjqGm1gdGZXm6Zxtdy8WZ+Qp03lTyopeWaOGTw=;
        b=Kni948ZH5s06FfwTqGpZLz3X5HD054LI9n5SRLUQGLoO7CN/FAROs2R97VxPew22Uq
         pieKwqkGdNJCr54dNw2wCmE5+SbwCDRmIMW6bQM3DyDZBGkmJS9P/5WoU/f6lAGf0m7R
         DjBNt92Q0GHEvicCQUc5gcx/67eFq2T5sgQndDJABIsJfD/5XIiSV8F9T99js44qzbTI
         T65jsqjv8wbcRQtamPuhMpt8IPCfOy1O2Qt790JFa7wA6rs72EOM1s+zy1ISA+NyJTe5
         8tjHDoiFzYO/pfkaUP/oXnAj8b2NEfY/P+MDtV6QIIqhGCkcVFSwwIz1ABTCisZOz3ym
         Kz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9tI7NjqGm1gdGZXm6Zxtdy8WZ+Qp03lTyopeWaOGTw=;
        b=CEB8ggYkFZKpUdSkQ6u5Kj2j/ROL5InPZYzFtAfhZH+N5cW3oZmD+6GXEj+zRM+JoL
         KDzyDx/dlx7TWVvq9ww71CvEnqqwK5oN6abH/e3NL6cnuyUgAZ/4dcWpbnpMbLWVmKi5
         xXUYN8C/Pzw4zFBn3M6dJzCUa1L3nvYLjJhG4kJPM/WJlyUNmH2VeVABWyKJKLYQW444
         TIEgIt2ztoxolu+nXCFSOM5zFYsPB4CygD/olTClF5CV8NsG06TXKp9qcPqZijBmsDYL
         0OqWhZEOsWsPIUZNo5Fs1coMPRQadiNnZgybbKZL9iEN6zcyYZtThFbaGNOMK8fPvlwt
         cWsA==
X-Gm-Message-State: AOAM5325qDfSVxGBFE+/Pcnc7IEFa/AxgFSAiKPfomMQXgBIsP9QO5l+
        K2Vlg0ncnIMCFrXNIDmLzoRNXjghSORCiQ==
X-Google-Smtp-Source: ABdhPJw3g2qDA4UZifKwpaPSY9aDYPc1DqHn+mxeVzXU6CXBfY6CGnLMIFiUpqToE3FmIV5QQYa8Bg==
X-Received: by 2002:a1c:bc8b:: with SMTP id m133mr11717876wmf.103.1617941144738;
        Thu, 08 Apr 2021 21:05:44 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:44 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 06/13] doc: typeset dummy URLs and protocols in monospace
Date:   Fri,  9 Apr 2021 06:02:54 +0200
Message-Id: <20210409040301.3260358-7-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap dummy URLs and protocols names with backticks as indicated in the
CodingGuidelines. Note that some asciidoc predefined attributes are
replaced by their corresponding characters as they are made literal:

    {tilde} => ~
    {startsb} => [
    {endsb} => ]

Remove backticks of two URLs as they prevent them to be clickable.
Reflect this in the CodingGuidelines: only dummy URLs should be wrapped
with backticks.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/CodingGuidelines     |  2 +-
 Documentation/git-archimport.txt   |  2 +-
 Documentation/git-cvsimport.txt    |  2 +-
 Documentation/git-daemon.txt       |  6 +++---
 Documentation/git-http-backend.txt |  2 +-
 Documentation/git-remote-ext.txt   | 10 ++++-----
 Documentation/git-remote-fd.txt    |  2 +-
 Documentation/git-svn.txt          |  4 ++--
 Documentation/gitfaq.txt           |  4 ++--
 Documentation/gitweb.txt           | 10 ++++-----
 Documentation/urls.txt             | 34 +++++++++++++++---------------
 11 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 45465bc0c9..554fba1a47 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -607,7 +607,7 @@ Writing Documentation:
  or commands:
 
  Literal examples (e.g. use of command-line options, command names,
- branch names, URLs, pathnames (files and directories), configuration and
+ branch names, dummy URLs, pathnames (files and directories), configuration and
  environment variables) must be typeset in monospace (i.e. wrapped with
  backticks):
    `--pretty=oneline`
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index b5c9e500ca..72237659d9 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -97,7 +97,7 @@ OPTIONS
 	pruned.
 
 -a::
-	Attempt to auto-register archives at `http://mirrors.sourcecontrol.net`
+	Attempt to auto-register archives at http://mirrors.sourcecontrol.net
 	This is particularly useful with the `-D` option.
 
 -t <tmpdir>::
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 586184bbd4..ead844944e 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -221,7 +221,7 @@ Problems related to tags:
 If you suspect that any of these issues may apply to the repository you
 want to import, consider using cvs2git:
 
-* cvs2git (part of cvs2svn), `http://subversion.apache.org/`
+* cvs2git (part of cvs2svn), http://subversion.apache.org/
 
 GIT
 ---
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index e9cce4e468..1298ceb723 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -55,8 +55,8 @@ OPTIONS
 --base-path=<path>::
 	Remap all the path requests as relative to the given path.
 	This is sort of "Git root" - if you run `git daemon` with
-	`--base-path=/srv/git` on example.com, then if you later try to pull
-	'git://example.com/hello.git', `git daemon` will interpret the path
+	`--base-path=/srv/git` on `example.com`, then if you later try to pull
+	`git://example.com/hello.git`, `git daemon` will interpret the path
 	as `/srv/git/hello.git`.
 
 --base-path-relaxed::
@@ -139,7 +139,7 @@ otherwise `stderr`.
 --user-path=<path>::
 	Allow {tilde}user notation to be used in requests.  When
 	specified with no parameter, requests to
-	git://host/{tilde}alice/foo is taken as a request to access
+	`git://host/~alice/foo` is taken as a request to access
 	'foo' repository in the home directory of user `alice`.
 	If `--user-path=path` is specified, the same request is
 	taken as a request to access `path/foo` repository in
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index c97c10ba09..e63816e430 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 A simple CGI program to serve the contents of a Git repository to Git
-clients accessing the repository over http:// and https:// protocols.
+clients accessing the repository over `http://` and `https://` protocols.
 The program supports clients fetching using both the smart HTTP protocol
 and the backwards-compatible dumb HTTP protocol, as well as clients
 pushing using the smart HTTP protocol.
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index fd9b621fa2..49057434cd 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -16,7 +16,7 @@ This remote helper uses the specified '<command>' to connect
 to a remote Git server.
 
 Data written to stdin of the specified '<command>' is assumed
-to be sent to a git:// server, `git-upload-pack`, `git-receive-pack`
+to be sent to a `git://` server, `git-upload-pack`, `git-receive-pack`
 or `git-upload-archive` (depending on situation), and data read
 from stdout of <command> is assumed to be received from
 the same service.
@@ -42,17 +42,17 @@ The following sequences have a special meaning:
 
 '%G' (must be the first characters in an argument)::
 	This argument will not be passed to '<command>'. Instead, it
-	will cause the helper to start by sending git:// service requests to
+	will cause the helper to start by sending `git://` service requests to
 	the remote side with the service field set to an appropriate value and
 	the repository field set to rest of the argument. Default is not to send
 	such a request.
 +
-This is useful if remote side is git:// server accessed over
+This is useful if remote side is `git://` server accessed over
 some tunnel.
 
 '%V' (must be first characters in argument)::
 	This argument will not be passed to '<command>'. Instead it sets
-	the vhost field in the git:// service request (to rest of the argument).
+	the vhost field in the `git://` service request (to rest of the argument).
 	Default is not to send vhost in such request (if sent).
 
 ENVIRONMENT VARIABLES
@@ -93,7 +93,7 @@ begins with `ext::`.  Examples:
 	Represents a repository with path /repo accessed using the
 	helper program `git-server-alias foo`.  The path to the
 	repository and type of request are not passed on the command
-	line but as part of the protocol stream, as usual with git://
+	line but as part of the protocol stream, as usual with `git://`
 	protocol.
 
 "ext::git-server-alias foo %G/repo %Vfoo"::
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 14868c4678..239844f827 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -22,7 +22,7 @@ to be pipes connected to a remote Git server (<infd> being the inbound pipe
 and <outfd> being the outbound pipe.
 
 It is assumed that any handshaking procedures have already been completed
-(such as sending service request for git://) before this helper is started.
+(such as sending service request for `git://`) before this helper is started.
 
 <anything> can be any string. It is ignored. It is meant for providing
 information to user in the URL in case that URL is displayed in some
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f42cf6b189..93868c9226 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -798,8 +798,8 @@ svn-remote.<name>.useSvnsyncprops::
 svn-remote.<name>.rewriteRoot::
 	This allows users to create repositories from alternate
 	URLs.  For example, an administrator could run `git svn` on the
-	server locally (accessing via file://) but wish to distribute
-	the repository with a public http:// or svn:// URL in the
+	server locally (accessing via `file://`) but wish to distribute
+	the repository with a public `http://` or `svn://` URL in the
 	metadata so users of it will see the public URL.
 
 svn-remote.<name>.rewriteUUID::
diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 92e8106af4..01d6a27cf6 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -140,8 +140,8 @@ How do I use multiple accounts with the same hosting provider using HTTP?::
 	Usually the easiest way to distinguish between these accounts is to use
 	the username in the URL.  For example, if you have the accounts `author`
 	and `committer` on `git.example.org`, you can use the URLs
-	https://author@git.example.org/org1/project1.git and
-	https://committer@git.example.org/org2/project2.git.  This way, when you
+	`https://author@git.example.org/org1/project1.git` and
+	`https://committer@git.example.org/org2/project2.git`.  This way, when you
 	use a credential helper, it will automatically try to look up the
 	correct credentials for your account.  If you already have a remote set
 	up, you can change the URL with something like `git remote set-url
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 1feb9c2b08..689afb38c0 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -586,7 +586,7 @@ These configurations enable two things. First, each unix user (`<user>`) of
 the server will be able to browse through `gitweb` Git repositories found in
 `~/public_git/` with the following url:
 
-  http://git.example.org/~<user>/
+  `http://git.example.org/~<user>/`
 
 If you do not want this feature on your server just remove the second
 rewrite rule.
@@ -610,7 +610,7 @@ $feature{'pathinfo'}{'default'} = [1];
 in your `gitweb` configuration file, it is possible to set up your server so
 that it consumes and produces URLs in the form
 
-  http://git.example.com/project.git/shortlog/sometag
+  `http://git.example.com/project.git/shortlog/sometag`
 
 i.e. without 'gitweb.cgi' part, by using a configuration such as the
 following.  This configuration assumes that `/var/www/gitweb` is the
@@ -670,19 +670,19 @@ named *without* a .git extension (e.g. `/pub/git/project` instead of
 
 The additional AliasMatch makes it so that
 
-  http://git.example.com/project.git
+  `http://git.example.com/project.git`
 
 will give raw access to the project's Git dir (so that the project can be
 cloned), while
 
-  http://git.example.com/project
+  `http://git.example.com/project`
 
 will provide human-friendly `gitweb` access.
 
 This solution is not 100% bulletproof, in the sense that if some project has
 a named ref (branch, tag) starting with `git/`, then paths such as
 
-  http://git.example.com/project/command/abranch..git/abranch
+  `http://git.example.com/project/command/abranch..git/abranch`
 
 will fail with a 404 error.
 
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 68ab4fbcc3..b0aa97823b 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -6,23 +6,23 @@ address of the remote server, and the path to the repository.
 Depending on the transport protocol, some of this information may be
 absent.
 
-Git supports ssh, git, http, and https protocols (in addition, ftp,
-and ftps can be used for fetching, but this is inefficient and
+Git supports `ssh`, `git`, `http`, and `https` protocols (in addition, `ftp`,
+and `ftps` can be used for fetching, but this is inefficient and
 deprecated; do not use it).
 
-The native transport (i.e. git:// URL) does no authentication and
+The native transport (i.e. `git://` URL) does no authentication and
 should be used with caution on unsecured networks.
 
 The following syntaxes may be used with them:
 
-- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
-- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- `ssh://[user@]host.xz[:port]/path/to/repo.git/`
+- `git://host.xz[:port]/path/to/repo.git/`
+- `http[s]://host.xz[:port]/path/to/repo.git/`
+- `ftp[s]://host.xz[:port]/path/to/repo.git/`
 
 An alternative scp-like syntax may also be used with the ssh protocol:
 
-- {startsb}user@{endsb}host.xz:path/to/repo.git/
+- `[user@]host.xz:path/to/repo.git/`
 
 This syntax is only recognized if there are no slashes before the
 first colon. This helps differentiate a local path that contains a
@@ -32,15 +32,15 @@ url.
 
 The ssh and git protocols additionally support ~username expansion:
 
-- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
-- git://host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
-- {startsb}user@{endsb}host.xz:/~{startsb}user{endsb}/path/to/repo.git/
+- `ssh://[user@]host.xz[:port]/~[user]/path/to/repo.git/`
+- `git://host.xz[:port]/~[user]/path/to/repo.git/`
+- `[user@]host.xz:/~[user]/path/to/repo.git/`
 
 For local repositories, also supported by Git natively, the following
 syntaxes may be used:
 
-- /path/to/repo.git/
-- \file:///path/to/repo.git/
+- `/path/to/repo.git/`
+- `file:///path/to/repo.git/`
 
 ifndef::git-clone[]
 These two syntaxes are mostly equivalent, except when cloning, when
@@ -85,8 +85,8 @@ For example, with this:
 		insteadOf = work:
 ------------
 
-a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
-rewritten in any context that takes a URL to be "git://git.host.xz/repo.git".
+a URL like `work:repo.git` or like `host.xz:/path/to/repo.git` will be
+rewritten in any context that takes a URL to be `git://git.host.xz/repo.git`.
 
 If you want to rewrite URLs for push only, you can create a
 configuration section of the form:
@@ -103,6 +103,6 @@ For example, with this:
 		pushInsteadOf = git://example.org/
 ------------
 
-a URL like "git://example.org/path/to/repo.git" will be rewritten to
-"ssh://example.org/path/to/repo.git" for pushes, but pulls will still
+a URL like `git://example.org/path/to/repo.git` will be rewritten to
+`ssh://example.org/path/to/repo.git` for pushes, but pulls will still
 use the original URL.
-- 
2.31.1.133.g84d06cdc06

