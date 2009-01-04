From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] remove trailing '\n's in 'die' macros
Date: Sun,  4 Jan 2009 21:38:41 +0300
Message-ID: <1231094321-8796-1-git-send-email-aspotashev@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 19:40:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJXtg-0008B9-45
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 19:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077AbZADSi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 13:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757622AbZADSiz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 13:38:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:31960 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZADSir (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 13:38:47 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2513613fgg.17
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yTb81CFtPlWfRf9IEa7xlpDUPLkdDhB6F0evIFDqauw=;
        b=dtx79egRYDXRvzjJ12GBwvwlR7tOABo0hAHKh/l6AqntBxXvqhCxqbyazKPVYcGXPg
         fD3/bnZ2k9GZdR/vxSi6C1hyhhANL39Kjb/w9FN3RVwckktI3i3qwl0M0SO2/MAo/ghQ
         DlykPfmG6j0aSpO1p/YhLdFf1MMYyZBmm37AY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WJPE+seNP0TNJR2+htiwhmJrsenZ4ZSGextZsNOU678e1KQkLfOsQoicfBj7NFlKxj
         oNd0NYyFcNFdeZJppbAnMy8XZLsg+tMIICkoS8SV6eSTnTQk4n5ERl/oPS8CXMAuha/A
         Qzxeq3rd4njSFuJY6nljcqtel1/kJqBgcPWOI=
Received: by 10.86.91.3 with SMTP id o3mr10227846fgb.77.1231094323810;
        Sun, 04 Jan 2009 10:38:43 -0800 (PST)
Received: from localhost.localdomain (ppp91-78-207-99.pppoe.mtu-net.ru [91.78.207.99])
        by mx.google.com with ESMTPS id 4sm16738939fge.45.2009.01.04.10.38.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jan 2009 10:38:43 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104532>

'\n's in the end of format strings given to 'die' are redundant because
die uses error reporting function like 'static void report(const char
*prefix, const char *err, va_list params)' which always adds a '\n'.

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 builtin-cat-file.c        |    2 +-
 builtin-clone.c           |   14 +++++++-------
 builtin-fetch.c           |    2 +-
 builtin-init-db.c         |    2 +-
 builtin-log.c             |    2 +-
 builtin-mailinfo.c        |    2 +-
 builtin-merge-recursive.c |    2 +-
 builtin-update-index.c    |    2 +-
 connect.c                 |    2 +-
 daemon.c                  |    2 +-
 diff.c                    |    2 +-
 git.c                     |    2 +-
 grep.c                    |    2 +-
 imap-send.c               |    6 +++---
 index-pack.c              |    2 +-
 pack-redundant.c          |    8 ++++----
 16 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 30d00a6..8fad19d 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -137,7 +137,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		break;
 
 	default:
-		die("git cat-file: unknown option: %s\n", exp_type);
+		die("git cat-file: unknown option: %s", exp_type);
 	}
 
 	if (!buf)
diff --git a/builtin-clone.c b/builtin-clone.c
index 2feac9c..f1a1a0c 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -192,15 +192,15 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 
 	dir = opendir(src->buf);
 	if (!dir)
-		die("failed to open %s\n", src->buf);
+		die("failed to open %s", src->buf);
 
 	if (mkdir(dest->buf, 0777)) {
 		if (errno != EEXIST)
-			die("failed to create directory %s\n", dest->buf);
+			die("failed to create directory %s", dest->buf);
 		else if (stat(dest->buf, &buf))
-			die("failed to stat %s\n", dest->buf);
+			die("failed to stat %s", dest->buf);
 		else if (!S_ISDIR(buf.st_mode))
-			die("%s exists and is not a directory\n", dest->buf);
+			die("%s exists and is not a directory", dest->buf);
 	}
 
 	strbuf_addch(src, '/');
@@ -224,16 +224,16 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 		}
 
 		if (unlink(dest->buf) && errno != ENOENT)
-			die("failed to unlink %s\n", dest->buf);
+			die("failed to unlink %s", dest->buf);
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf))
 				continue;
 			if (option_local)
-				die("failed to create link %s\n", dest->buf);
+				die("failed to create link %s", dest->buf);
 			option_no_hardlinks = 1;
 		}
 		if (copy_file(dest->buf, src->buf, 0666))
-			die("failed to copy file to %s\n", dest->buf);
+			die("failed to copy file to %s", dest->buf);
 	}
 	closedir(dir);
 }
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 7568163..de6f307 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -607,7 +607,7 @@ static void set_option(const char *name, const char *value)
 {
 	int r = transport_set_option(transport, name, value);
 	if (r < 0)
-		die("Option \"%s\" value \"%s\" is not valid for %s\n",
+		die("Option \"%s\" value \"%s\" is not valid for %s",
 			name, value, transport->url);
 	if (r > 0)
 		warning("Option \"%s\" is ignored for %s\n",
diff --git a/builtin-init-db.c b/builtin-init-db.c
index d30c3fe..ee3911f 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -29,7 +29,7 @@ static void safe_create_dir(const char *dir, int share)
 		}
 	}
 	else if (share && adjust_shared_perm(dir))
-		die("Could not make %s writable by group\n", dir);
+		die("Could not make %s writable by group", dir);
 }
 
 static void copy_templates_1(char *path, int baselen,
diff --git a/builtin-log.c b/builtin-log.c
index 99d1137..1fc1ae0 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -824,7 +824,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			committer = git_committer_info(IDENT_ERROR_ON_NO_NAME);
 			endpos = strchr(committer, '>');
 			if (!endpos)
-				die("bogus committer info %s\n", committer);
+				die("bogus committer info %s", committer);
 			add_signoff = xmemdupz(committer, endpos - committer + 1);
 		}
 		else if (!strcmp(argv[i], "--attach")) {
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index e890f7a..f7c8c08 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -494,7 +494,7 @@ static void convert_to_utf8(struct strbuf *line, const char *charset)
 		return;
 	out = reencode_string(line->buf, metainfo_charset, charset);
 	if (!out)
-		die("cannot convert from %s to %s\n",
+		die("cannot convert from %s to %s",
 		    charset, metainfo_charset);
 	strbuf_attach(line, out, strlen(out), strlen(out));
 }
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 6b534c1..703045b 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -33,7 +33,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	}
 
 	if (argc < 4)
-		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
+		die("Usage: %s <base>... -- <head> <remote> ...", argv[0]);
 
 	for (i = 1; i < argc; ++i) {
 		if (!strcmp(argv[i], "--"))
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 65d5775..5604977 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -486,7 +486,7 @@ static int unresolve_one(const char *path)
 static void read_head_pointers(void)
 {
 	if (read_ref("HEAD", head_sha1))
-		die("No HEAD -- no initial commit yet?\n");
+		die("No HEAD -- no initial commit yet?");
 	if (read_ref("MERGE_HEAD", merge_head_sha1)) {
 		fprintf(stderr, "Not in the middle of a merge.\n");
 		exit(0);
diff --git a/connect.c b/connect.c
index 2f55ad2..2f23ab3 100644
--- a/connect.c
+++ b/connect.c
@@ -315,7 +315,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 		/* Not numeric */
 		struct servent *se = getservbyname(port,"tcp");
 		if ( !se )
-			die("Unknown port %s\n", port);
+			die("Unknown port %s", port);
 		nport = se->s_port;
 	}
 
diff --git a/daemon.c b/daemon.c
index 60bf6c7..540700e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -716,7 +716,7 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 
 	gai = getaddrinfo(listen_addr, pbuf, &hints, &ai0);
 	if (gai)
-		die("getaddrinfo() failed: %s\n", gai_strerror(gai));
+		die("getaddrinfo() failed: %s", gai_strerror(gai));
 
 	for (ai = ai0; ai; ai = ai->ai_next) {
 		int sockfd;
diff --git a/diff.c b/diff.c
index 0484601..c159a5f 100644
--- a/diff.c
+++ b/diff.c
@@ -2039,7 +2039,7 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 			if (lstat(one->path, &st) < 0)
 				die("stat %s", one->path);
 			if (index_path(one->sha1, one->path, &st, 0))
-				die("cannot hash %s\n", one->path);
+				die("cannot hash %s", one->path);
 		}
 	}
 	else
diff --git a/git.c b/git.c
index e0d9071..a53e24f 100644
--- a/git.c
+++ b/git.c
@@ -158,7 +158,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			if (ret >= 0 && WIFEXITED(ret) &&
 			    WEXITSTATUS(ret) != 127)
 				exit(WEXITSTATUS(ret));
-			die("Failed to run '%s' when expanding alias '%s'\n",
+			die("Failed to run '%s' when expanding alias '%s'",
 			    alias_string + 1, alias_command);
 		}
 		count = split_cmdline(alias_string, &new_argv);
diff --git a/grep.c b/grep.c
index 600f69f..49e9319 100644
--- a/grep.c
+++ b/grep.c
@@ -395,7 +395,7 @@ static int match_expr_eval(struct grep_opt *o,
 		h |= match_expr_eval(o, x->u.binary.right, bol, eol, ctx, 1);
 		break;
 	default:
-		die("Unexpected node type (internal error) %d\n", x->node);
+		die("Unexpected node type (internal error) %d", x->node);
 	}
 	if (collect_hits)
 		x->hit |= h;
diff --git a/imap-send.c b/imap-send.c
index 3703dbd..c3fa0df 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -115,9 +115,9 @@ static int nfvasprintf(char **strp, const char *fmt, va_list ap)
 
 	len = vsnprintf(tmp, sizeof(tmp), fmt, ap);
 	if (len < 0)
-		die("Fatal: Out of memory\n");
+		die("Fatal: Out of memory");
 	if (len >= sizeof(tmp))
-		die("imap command overflow !\n");
+		die("imap command overflow!");
 	*strp = xmemdupz(tmp, len);
 	return len;
 }
@@ -482,7 +482,7 @@ static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 
 	va_start(va, fmt);
 	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
-		die("Fatal: buffer too small. Please report a bug.\n");
+		die("Fatal: buffer too small. Please report a bug.");
 	va_end(va);
 	return ret;
 }
diff --git a/index-pack.c b/index-pack.c
index 60ed41a..2931511 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -178,7 +178,7 @@ static char *open_pack_file(char *pack_name)
 		} else
 			output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 		if (output_fd < 0)
-			die("unable to create %s: %s\n", pack_name, strerror(errno));
+			die("unable to create %s: %s", pack_name, strerror(errno));
 		pack_fd = output_fd;
 	} else {
 		input_fd = open(pack_name, O_RDONLY);
diff --git a/pack-redundant.c b/pack-redundant.c
index 25b81a4..e93eb96 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -463,7 +463,7 @@ static void minimize(struct pack_list **min)
 		pll_free(perm_all);
 	}
 	if (perm_ok == NULL)
-		die("Internal error: No complete sets found!\n");
+		die("Internal error: No complete sets found!");
 
 	/* find the permutation with the smallest size */
 	perm = perm_ok;
@@ -573,14 +573,14 @@ static struct pack_list * add_pack_file(char *filename)
 	struct packed_git *p = packed_git;
 
 	if (strlen(filename) < 40)
-		die("Bad pack filename: %s\n", filename);
+		die("Bad pack filename: %s", filename);
 
 	while (p) {
 		if (strstr(p->pack_name, filename))
 			return add_pack(p);
 		p = p->next;
 	}
-	die("Filename %s not found in packed_git\n", filename);
+	die("Filename %s not found in packed_git", filename);
 }
 
 static void load_all(void)
@@ -636,7 +636,7 @@ int main(int argc, char **argv)
 			add_pack_file(*(argv + i++));
 
 	if (local_packs == NULL)
-		die("Zero packs found!\n");
+		die("Zero packs found!");
 
 	load_all_objects();
 
-- 
1.6.0.6
