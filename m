From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] defaults for where to merge from (take 3, inline)
Date: Thu, 01 Mar 2007 17:33:05 +0100
Message-ID: <45E70041.1030705@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org>	<Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>	<45E68897.8000607@lu.unisi.ch>	<81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>	<45E68EDE.2090405@lu.unisi.ch>	<81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>	<45E69297.8070001@lu.unisi.ch>	<81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>	<45E69EEE.8070905@lu.unisi.ch>	<81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com> <7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 17:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMoDW-0002Xw-TX
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 17:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965338AbXCAQdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 11:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbXCAQdL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 11:33:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:14812 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965337AbXCAQdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 11:33:09 -0500
Received: by nf-out-0910.google.com with SMTP id o25so933448nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 08:33:08 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=SOwhgBcvlsWSvKbhFWS3nKG0Gc67P1FvSFYnRLv+ZWOL58sIL9/2R6INqiRySPlKKfvo1LtWvGsf6vqTEXRDrXC3IRC1pn7ekzBrPLdK4HVN7NzJfqk+sRAzvDMoD6eHIW/CeKSbNocm2UUwaYahvd+tbFiVg7IvwomyXj2Abfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=oN2/w1PH2nPZTO5gfno0oprMX6Wi9XYTw4KR6Q9wrMhGH9khvPRoV3eo0uP+AD/48POYtKxO3b13Rd/ujnwwmwv86R+96WBqfz4yHWrHJOSuVx0wW/ZaRtSZLcb8884HuWZk2K7q3IJdCDGNJl3/a0IFv45kezWrBOMSXZwbtiw=
Received: by 10.48.202.18 with SMTP id z18mr6034550nff.1172766788073;
        Thu, 01 Mar 2007 08:33:08 -0800 (PST)
Received: from ?192.168.76.141? ( [195.176.176.226])
        by mx.google.com with ESMTP id g1sm1061668muf.2007.03.01.08.33.06;
        Thu, 01 Mar 2007 08:33:06 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41104>

>  (2) by reviewing the changes to the .config writer.  That
>      traditionally has been one of the more fragile parts of the
>      system, and I am reluctant to look at it.

Just FYI, this was broken into a separate patch.

> I would just feel better to see a patch like this, which is a
> significant improvement to the system, to be properly signed-off
> by the submitter.

I hope this is better, I tried to follow the steps in
SubmittingPatches properly.  The code is actually the same
as take 3.


* git-branch: register where to merge from, when branching off a remote branch.

A rather standard (in 1.5) procedure for branching off a remote archive is:

  git checkout -b branchname remote/upstreambranch
  git config --add branch.branchname.remote remote
  git config --add branch.branchname.merge refs/heads/upstreambranch

In this case, we can save the user some effort if "git branch" (and
"git checkout -b") automatically do the two "git-config --add"s when the
source branch is remote.  There is a good chance that some user wants
to merge something different, but in that case they have to specify what
to merge _anyway_.

The behavior is controlled by core.trackremotebranches, and can be
fine-grained to a specific invocation of "git branch" using the new
--track and --no-track options.

Signed-off-by: Paolo Bonzini  <bonzini@gnu.org>
---
 Documentation/git-branch.txt |    8 +++++
 builtin-branch.c             |   58 +++++++++++++++++++++++++++++++++++++------
 cache.h                      |    1 
 config.c                     |    5 +++
 environment.c                |    1 
 5 files changed, 64 insertions(+), 9 deletions(-)


diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index aa1fdd4..14dc07d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-branch' [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]
-'git-branch' [-l] [-f] <branchname> [<start-point>]
+'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-m | -M) [<oldbranch>] <newbranch>
 'git-branch' (-d | -D) [-r] <branchname>...
 
@@ -25,6 +25,12 @@ It will start out with a head equal to the one given as <start-point>.
 If no <start-point> is given, the branch will be created with a head
 equal to that of the currently checked out branch.
 
+When a local branch is started off a remote branch, git will setup
+the branch so that gitlink:git-pull[1] will appropriately merge from
+that remote branch.  If this behavior is undesired, it is possible
+to change it using the `core.trackremotebranches` option, or the
+`--track` and `--no-track` options.
+
 With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
 <newbranch>, and a reflog entry is created to remember the branch
diff --git a/builtin-branch.c b/builtin-branch.c
index d0179b0..20de049 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -12,7 +12,7 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]";
+  "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]";
 
 #define REF_UNKNOWN_TYPE    0x00
 #define REF_LOCAL_BRANCH    0x01
@@ -308,15 +307,36 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 	free_ref_list(&ref_list);
 }
 
+static void register_branch_pull (const char *name, const char *remote_name)
+{
+	char *slash = strchr(remote_name, '/');
+
+	char *config_key = xmalloc(strlen(name) + 15);
+	char *merge_value = xmalloc(strlen(remote_name) + 10);
+
+	char *remote_value = xstrdup(remote_name);
+	remote_value[slash - remote_name] = 0;
+	sprintf(config_key, "branch.%s.remote", name);
+	git_config_set(config_key, remote_value);
+
+	sprintf(merge_value, "refs/heads/%s", slash + 1);
+	sprintf(config_key, "branch.%s.merge", name);
+	git_config_set(config_key, merge_value);
+
+	free (config_key);
+	free (remote_value);
+	free (merge_value);
+}
+
 static void create_branch(const char *name, const char *start_name,
 			  unsigned char *start_sha1,
-			  int force, int reflog)
+			  int force, int reflog, int track)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
 	unsigned char sha1[20];
-	char ref[PATH_MAX], msg[PATH_MAX + 20];
-	int forcing = 0;
+	char *real_ref = NULL, ref[PATH_MAX], msg[PATH_MAX + 20];
+	int forcing = 0, remote = 0;
 
 	snprintf(ref, sizeof ref, "refs/heads/%s", name);
 	if (check_ref_format(ref))
@@ -333,7 +353,9 @@ static void create_branch(const char *name, const char *start_name,
 	if (start_sha1)
 		/* detached HEAD */
 		hashcpy(sha1, start_sha1);
-	else if (get_sha1(start_name, sha1))
+	else if (dwim_ref(start_name, strlen (start_name), sha1, &real_ref))
+		remote = !prefixcmp(real_ref, "refs/remotes/");
+	else
 		die("Not a valid object name: '%s'.", start_name);
 
 	if ((commit = lookup_commit_reference(sha1)) == NULL)
@@ -354,8 +376,16 @@ static void create_branch(const char *name, const char *start_name,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	/* When branching off a remote branch, set up so that git-pull
+	   automatically merges from there.  */
+	if (remote && track)
+		register_branch_pull (name, real_ref + 13);
+
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
+
+	if (real_ref)
+		free (real_ref);
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -397,11 +427,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int delete = 0, force_delete = 0, force_create = 0;
 	int rename = 0, force_rename = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
-	int reflog = 0;
+	int reflog = 0, track;
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
 	git_config(git_branch_config);
+	track = track_remote_branches;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -412,6 +443,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			i++;
 			break;
 		}
+		if (!strcmp(arg, "--track")) {
+			track = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--no-track")) {
+			track = 0;
+			continue;
+		}
 		if (!strcmp(arg, "-d")) {
 			delete = 1;
 			continue;
@@ -490,9 +529,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	else if (rename && (i == argc - 2))
 		rename_branch(argv[i], argv[i + 1], force_rename);
 	else if (i == argc - 1)
-		create_branch(argv[i], head, head_sha1, force_create, reflog);
+		create_branch(argv[i], head, head_sha1, force_create, reflog,
+			      track);
 	else if (i == argc - 2)
-		create_branch(argv[i], argv[i+1], NULL, force_create, reflog);
+		create_branch(argv[i], argv[i+1], NULL, force_create, reflog,
+			      track);
 	else
 		usage(builtin_branch_usage);
 
diff --git a/cache.h b/cache.h
index 8bbc142..585a9b4 100644
--- a/cache.h
+++ b/cache.h
@@ -205,6 +205,7 @@ extern int trust_executable_bit;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
+extern int track_remote_branches;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
diff --git a/config.c b/config.c
index 0ff413b..49df7bd 100644
--- a/config.c
+++ b/config.c
@@ -294,6 +294,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.trackremotebranches")) {
+		track_remote_branches = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.legacyheaders")) {
 		use_legacy_headers = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 570e32a..e440d05 100644
--- a/environment.c
+++ b/environment.c
@@ -17,6 +17,7 @@ int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
+int track_remote_branches = 1;
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 char *git_commit_encoding;
