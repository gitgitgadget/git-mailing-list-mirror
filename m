From: Luciano Rocha <luciano@eurotux.com>
Subject: [PATCH] git-init: inform user of `git --bare init' option
Date: Tue, 20 May 2008 20:48:50 +0100
Message-ID: <20080520194850.GB19226@bit.office.eurotux.com>
References: <20080519175313.GA17305@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 21:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyXqF-0004Li-N2
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 21:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757769AbYETTs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 15:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757677AbYETTs4
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 15:48:56 -0400
Received: from os.eurotux.com ([216.75.63.6]:60711 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756258AbYETTs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 15:48:56 -0400
Received: (qmail 11684 invoked from network); 20 May 2008 19:48:54 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@82.102.23.9)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 20 May 2008 19:48:54 -0000
Content-Disposition: inline
In-Reply-To: <20080519175313.GA17305@bit.office.eurotux.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82492>

Creation of a bare repository isn't consistent:

$ git init --bare
usage: git-init [-q | --quiet] [--template=<template-directory>] [--shared]
$ git --bare init
Initialized empty Git repository in ...

Document the second option, and show an error informing of it if the
user calls `git-init' with a `--bare' option.

Signed-off-by: Luciano Rocha <strange@nsk.pt>
---
 Documentation/git-init.txt |    2 ++
 builtin-init-db.c          |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index b17ae84..bb87e58 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -84,6 +84,8 @@ Running `git-init` in an existing repository is safe. It will not overwrite
 things that are already there. The primary reason for rerunning `git-init`
 is to pick up newly added templates.
 
+For creating a bare repository, use the form `git --bare init`.
+
 Note that `git-init` is the same as `git-init-db`.  The command
 was primarily meant to initialize the object database, but over
 time it has become responsible for setting up the other aspects
diff --git a/builtin-init-db.c b/builtin-init-db.c
index a76f5d3..65454b1 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -334,6 +334,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			template_dir = arg+11;
 		else if (!strcmp(arg, "--shared"))
 			shared_repository = PERM_GROUP;
+		else if (!strcmp(arg, "--bare"))
+			die("Run `git --bare init' instead to create a bare repository");
 		else if (!prefixcmp(arg, "--shared="))
 			shared_repository = git_config_perm("arg", arg+9);
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
-- 
1.5.5.1.317.ge7bcb.dirty
