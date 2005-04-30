From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Rename usage and error message strings + rpull/rpush commands
Date: Sat, 30 Apr 2005 03:49:24 +0200
Message-ID: <20050430014924.GA11210@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 04:18:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRhXg-0003a3-0m
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 04:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbVD3Bui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 21:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbVD3Bug
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 21:50:36 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:54987 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S263124AbVD3Bt0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 21:49:26 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 9B7486E2C65; Sat, 30 Apr 2005 03:48:26 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1977D6E2C3B; Sat, 30 Apr 2005 03:48:26 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 9570D61FDE; Sat, 30 Apr 2005 03:49:24 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[ Sorry for the resend. Forgot to sign off and CC the ML. ]

Don't know if renaming the program identification strings are desirable.
However, the remote command used by rpull/rpush should probably be
changed.

 cat-file.c         |   10 +++++-----
 commit-tree.c      |    2 +-
 convert-cache.c    |    2 +-
 diff-cache.c       |    2 +-
 diff-files.c       |    2 +-
 diff-tree-helper.c |    2 +-
 diff-tree.c        |    4 ++--
 fsck-cache.c       |    4 ++--
 http-pull.c        |    2 +-
 ls-tree.c          |    2 +-
 merge-base.c       |    2 +-
 merge-cache.c      |    8 ++++----
 read-tree.c        |    2 +-
 rev-list.c         |    2 +-
 rev-tree.c         |    4 ++--
 rpull.c            |    4 ++--
 rpush.c            |    4 ++--
 show-files.c       |    2 +-
 tar-tree.c         |   10 +++++-----
 unpack-file.c      |    2 +-
 20 files changed, 36 insertions(+), 36 deletions(-)

Index: cat-file.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/cat-file.c  (mode:100644 sha1:3c47d79a16305d326a65768fe9f37ee25928510b)
+++ uncommitted/cat-file.c  (mode:100644)
@@ -13,17 +13,17 @@
 	unsigned long size;
 
 	if (argc != 3 || get_sha1_hex(argv[2], sha1))
-		usage("cat-file [-t | tagname] <sha1>");
+		usage("git-cat-file [-t | tagname] <sha1>");
 	buf = read_sha1_file(sha1, type, &size);
 	if (!buf)
-		die("cat-file %s: bad file", argv[2]);
+		die("git-cat-file %s: bad file", argv[2]);
 	if (!strcmp("-t", argv[1])) {
 		buf = type;
 		size = strlen(type);
 		type[size] = '\n';
 		size++;
 	} else if (strcmp(type, argv[1])) {
-		die("cat-file %s: bad tag", argv[2]);
+		die("git-cat-file %s: bad tag", argv[2]);
 	}
 
 	while (size > 0) {
@@ -34,9 +34,9 @@
 			/* Ignore epipe */
 			if (errno == EPIPE)
 				break;
-			die("cat-file: %s", strerror(errno));
+			die("git-cat-file: %s", strerror(errno));
 		} else if (!ret) {
-			die("cat-file: disk full?");
+			die("git-cat-file: disk full?");
 		}
 		size -= ret;
 		buf += ret;
Index: commit-tree.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/commit-tree.c  (mode:100644 sha1:23de13361944ad7ba7c5320cf7cdd04e81842c60)
+++ uncommitted/commit-tree.c  (mode:100644)
@@ -240,7 +240,7 @@
  */
 #define MAXPARENT (16)
 
-static char *commit_tree_usage = "commit-tree <sha1> [-p <sha1>]* < changelog";
+static char *commit_tree_usage = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
 
 int main(int argc, char **argv)
 {
Index: convert-cache.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/convert-cache.c  (mode:100644 sha1:631d1aa910e7328c99642495f93908c749074f91)
+++ uncommitted/convert-cache.c  (mode:100644)
@@ -304,7 +304,7 @@
 	struct entry *entry;
 
 	if (argc != 2 || get_sha1_hex(argv[1], sha1))
-		usage("convert-cache <sha1>");
+		usage("git-convert-cache <sha1>");
 
 	entry = convert_entry(sha1);
 	printf("new sha1: %s\n", sha1_to_hex(entry->new_sha1));
Index: diff-cache.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/diff-cache.c  (mode:100644 sha1:899e37361e5d34a38e4746b3cd290d9b96a6c8f8)
+++ uncommitted/diff-cache.c  (mode:100644)
@@ -143,7 +143,7 @@
 }
 
 static char *diff_cache_usage =
-"diff-cache [-r] [-z] [-p] [--cached] <tree sha1>";
+"git-diff-cache [-r] [-z] [-p] [--cached] <tree sha1>";
 
 int main(int argc, char **argv)
 {
Index: diff-files.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/diff-files.c  (mode:100644 sha1:fdd7dd4b0cc8c92a18ddaf0bcf8c9675fcab303b)
+++ uncommitted/diff-files.c  (mode:100644)
@@ -7,7 +7,7 @@
 #include "diff.h"
 
 static const char *show_diff_usage =
-"show-diff [-p] [-q] [-r] [-z] [paths...]";
+"git-show-diff [-p] [-q] [-r] [-z] [paths...]";
 
 static int generate_patch = 0;
 static int line_termination = '\n';
Index: diff-tree-helper.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/diff-tree-helper.c  (mode:100644 sha1:282b649f318cf3fa19c7f01da94ba590126f5443)
+++ uncommitted/diff-tree-helper.c  (mode:100644)
@@ -104,7 +104,7 @@
 }
 
 static const char *diff_tree_helper_usage =
-"diff-tree-helper [-R] [-z] paths...";
+"git-diff-tree-helper [-R] [-z] paths...";
 
 int main(int ac, const char **av) {
 	struct strbuf sb;
Index: diff-tree.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/diff-tree.c  (mode:100644 sha1:e7a5b7cc76f5d80e602184f1ef12f502d53a552b)
+++ uncommitted/diff-tree.c  (mode:100644)
@@ -227,7 +227,7 @@
 			update_tree_entry(&tree2, &size2);
 			continue;
 		}
-		die("diff-tree: internal error");
+		die("git-diff-tree: internal error");
 	}
 	return 0;
 }
@@ -250,7 +250,7 @@
 	return retval;
 }
 
-static char *diff_tree_usage = "diff-tree [-r] [-z] <tree sha1> <tree sha1>";
+static char *diff_tree_usage = "git-diff-tree [-r] [-z] <tree sha1> <tree sha1>";
 
 int main(int argc, char **argv)
 {
Index: fsck-cache.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/fsck-cache.c  (mode:100644 sha1:280a104050b665515418c00c33af8e6b0b0e2101)
+++ uncommitted/fsck-cache.c  (mode:100644)
@@ -51,7 +51,7 @@
 static int fsck_tree(struct tree *item)
 {
 	if (item->has_full_path) {
-		fprintf(stderr, "warning: fsck-cache: tree %s "
+		fprintf(stderr, "warning: git-fsck-cache: tree %s "
 			"has full pathnames in it\n", 
 			sha1_to_hex(item->object.sha1));
 	}
@@ -156,7 +156,7 @@
 			continue;
 		}
 		if (*arg == '-')
-			usage("fsck-cache [--tags] [[--unreachable] <head-sha1>*]");
+			usage("git-fsck-cache [--tags] [[--unreachable] <head-sha1>*]");
 	}
 
 	sha1_dir = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
Index: http-pull.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/http-pull.c  (mode:100644 sha1:192dcc370dee47c52c72915394bb6f2a79f64e12)
+++ uncommitted/http-pull.c  (mode:100644)
@@ -180,7 +180,7 @@
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("http-pull [-c] [-t] [-a] commit-id url");
+		usage("git-http-pull [-c] [-t] [-a] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
Index: ls-tree.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/ls-tree.c  (mode:100644 sha1:d2ab02e3484efaf851c50574e603c785d713bc87)
+++ uncommitted/ls-tree.c  (mode:100644)
@@ -80,7 +80,7 @@
 	return 0;
 }
 
-static const char *ls_tree_usage = "ls-tree [-r] [-z] <key>";
+static const char *ls_tree_usage = "git-ls-tree [-r] [-z] <key>";
 
 int main(int argc, char **argv)
 {
Index: merge-base.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/merge-base.c  (mode:100644 sha1:2c40881302e586366f03ae6ac6e7c0035847e2f0)
+++ uncommitted/merge-base.c  (mode:100644)
@@ -60,7 +60,7 @@
 	if (argc != 3 ||
 	    get_sha1_hex(argv[1], rev1key) ||
 	    get_sha1_hex(argv[2], rev2key)) {
-		usage("merge-base <commit-id> <commit-id>");
+		usage("git-merge-base <commit-id> <commit-id>");
 	}
 	rev1 = lookup_commit(rev1key);
 	rev2 = lookup_commit(rev2key);
Index: merge-cache.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/merge-cache.c  (mode:100644 sha1:11079b1cda9c50856a636a19bc41204903f1b522)
+++ uncommitted/merge-cache.c  (mode:100644)
@@ -33,7 +33,7 @@
 	int found;
 	
 	if (pos >= active_nr)
-		die("merge-cache: %s not in the cache", path);
+		die("git-merge-cache: %s not in the cache", path);
 	arguments[0] = pgm;
 	arguments[1] = "";
 	arguments[2] = "";
@@ -58,7 +58,7 @@
 		arguments[stage + 4] = ownbuf[stage];
 	} while (++pos < active_nr);
 	if (!found)
-		die("merge-cache: %s not in the cache", path);
+		die("git-merge-cache: %s not in the cache", path);
 	run_program();
 	return found;
 }
@@ -91,7 +91,7 @@
 	int i, force_file = 0;
 
 	if (argc < 3)
-		usage("merge-cache <merge-program> (-a | <filename>*)");
+		usage("git-merge-cache <merge-program> (-a | <filename>*)");
 
 	read_cache();
 
@@ -107,7 +107,7 @@
 				merge_all();
 				continue;
 			}
-			die("merge-cache: unknown option %s", arg);
+			die("git-merge-cache: unknown option %s", arg);
 		}
 		merge_file(arg);
 	}
Index: read-tree.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/read-tree.c  (mode:100644 sha1:604884a983e087e25afccc1c52beff3883036e58)
+++ uncommitted/read-tree.c  (mode:100644)
@@ -156,7 +156,7 @@
 	}
 }
 
-static char *read_tree_usage = "read-tree (<sha> | -m <sha1> [<sha2> <sha3>])";
+static char *read_tree_usage = "git-read-tree (<sha> | -m <sha1> [<sha2> <sha3>])";
 
 int main(int argc, char **argv)
 {
Index: rev-list.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/rev-list.c  (mode:100644 sha1:77bfc29db1aad08ba9d7d87ce08d33d4a88e74e3)
+++ uncommitted/rev-list.c  (mode:100644)
@@ -8,7 +8,7 @@
 	struct commit *commit;
 
 	if (argc != 2 || get_sha1_hex(argv[1], sha1))
-		usage("rev-list <commit-id>");
+		usage("git-rev-list <commit-id>");
 
 	commit = lookup_commit(sha1);
 	if (!commit || parse_commit(commit) < 0)
Index: rev-tree.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/rev-tree.c  (mode:100644 sha1:03c900f459c0e6ae7fc9455589be00375f44eac8)
+++ uncommitted/rev-tree.c  (mode:100644)
@@ -69,7 +69,7 @@
 }
 
 /*
- * Usage: rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id2>]
+ * Usage: git-rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id2>]
  *
  * The cache-file can be quite important for big trees. This is an
  * expensive operation if you have to walk the whole chain of
@@ -103,7 +103,7 @@
 			basemask |= 1<<nr;
 		}
 		if (nr >= MAX_COMMITS || get_sha1_hex(arg, sha1[nr]))
-			usage("rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id>]");
+			usage("git-rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id>]");
 		process_commit(sha1[nr]);
 		nr++;
 	}
Index: rpull.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/rpull.c  (mode:100644 sha1:c27af2c2464de28732b8ad1fff3ed8a0804250d6)
+++ uncommitted/rpull.c  (mode:100644)
@@ -108,13 +108,13 @@
 		arg++;
 	}
 	if (argc < arg + 2) {
-		usage("rpull [-c] [-t] [-a] commit-id url");
+		usage("git-rpull [-c] [-t] [-a] commit-id url");
 		return 1;
 	}
 	commit_id = argv[arg];
 	url = argv[arg + 1];
 
-	if (setup_connection(&fd_in, &fd_out, "rpush", url, arg, argv + 1))
+	if (setup_connection(&fd_in, &fd_out, "git-rpush", url, arg, argv + 1))
 		return 1;
 
 	get_sha1_hex(commit_id, sha1);
Index: rpush.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/rpush.c  (mode:100644 sha1:0293a1a46311d7e20b13177143741ab9d6d0d201)
+++ uncommitted/rpush.c  (mode:100644)
@@ -56,12 +56,12 @@
                 arg++;
         }
         if (argc < arg + 2) {
-                usage("rpush [-c] [-t] [-a] commit-id url");
+                usage("git-rpush [-c] [-t] [-a] commit-id url");
                 return 1;
         }
 	commit_id = argv[arg];
 	url = argv[arg + 1];
-	if (setup_connection(&fd_in, &fd_out, "rpull", url, arg, argv + 1))
+	if (setup_connection(&fd_in, &fd_out, "git-rpull", url, arg, argv + 1))
 		return 1;
 
 	service(fd_in, fd_out);
Index: show-files.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/show-files.c  (mode:100644 sha1:d4061f83031447aa9ee8ad16544e7bc084908838)
+++ uncommitted/show-files.c  (mode:100644)
@@ -207,7 +207,7 @@
 }
 
 static const char *show_files_usage =
-	"show-files [-z] (--[cached|deleted|others|stage|unmerged])* "
+	"git-show-files [-z] (--[cached|deleted|others|stage|unmerged])* "
 	"[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]";
 
 int main(int argc, char **argv)
Index: tar-tree.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/tar-tree.c  (mode:100644 sha1:5cc7cfef6db1269d81589b82255537fb64ba02fa)
+++ uncommitted/tar-tree.c  (mode:100644)
@@ -4,7 +4,7 @@
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
 
-static const char *tar_tree_usage = "tar-tree <key> [basedir]";
+static const char *tar_tree_usage = "git-tar-tree <key> [basedir]";
 
 static char block[BLOCKSIZE];
 static unsigned long offset;
@@ -27,9 +27,9 @@
 				continue;
 			if (errno == EPIPE)
 				exit(0);
-			die("tar-tree: %s", strerror(errno));
+			die("git-tar-tree: %s", strerror(errno));
 		} else if (!ret) {
-			die("tar-tree: disk full?");
+			die("git-tar-tree: disk full?");
 		}
 		size -= ret;
 		buf += ret;
@@ -176,7 +176,7 @@
 	if (size > 99)
 		size++;
 	if (size > RECORDSIZE)
-		die("tar-tree: extended header too big, wtf?");
+		die("git-tar-tree: extended header too big, wtf?");
 	write_header(NULL, NULL, NULL, headerfilename, 0100600, size);
 
 	records = block + offset;
@@ -202,7 +202,7 @@
 
 	namelen = path_len(S_ISDIR(mode), basepath, prefix, path);
 	if (namelen > 500) {
-		die("tar-tree: name too log of object %s\n", sha1_to_hex(sha1));
+		die("git-tar-tree: name too log of object %s\n", sha1_to_hex(sha1));
 	} else if (namelen > 100) {
 		char *sha1_hex = sha1_to_hex(sha1);
 		char headerfilename[51];
Index: unpack-file.c
===================================================================
--- c1546808797f6a3c4e6ae82069cee3dc316fbf24/unpack-file.c  (mode:100644 sha1:6ff3d51c182627f42b104932ecea9b95d6225a5d)
+++ uncommitted/unpack-file.c  (mode:100644)
@@ -27,7 +27,7 @@
 	unsigned char sha1[20];
 
 	if (argc != 2 || get_sha1_hex(argv[1], sha1))
-		usage("unpack-file.c <sha1>");
+		usage("git-unpack-file <sha1>");
 
 	puts(create_temp_file(sha1));
 	return 0;
-- 
Jonas Fonseca
