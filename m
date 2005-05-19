From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: [PATCH] cleanup of in-code names
Date: Thu, 19 May 2005 15:17:16 +0400
Message-ID: <20050519111717.4453.qmail@penza-gsm.ru>
Cc: git@vger.kernel.org, snake@penza-gsm.ru
X-From: git-owner@vger.kernel.org Thu May 19 13:19:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYj2P-0001OO-HN
	for gcvg-git@gmane.org; Thu, 19 May 2005 13:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVESLSr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 07:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVESLSr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 07:18:47 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:55203
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261768AbVESLRV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 07:17:21 -0400
Received: (qmail 4454 invoked by uid 1000); 19 May 2005 11:17:18 -0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Fixes all in-code names that leaved during "big name change".

Signed-off-by: Alexey Nezhdanov <snake@penza-gsm.ru>

---

Index: checkout-cache.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/checkout-cache.c  (mode:100644)
+++ uncommitted/checkout-cache.c  (mode:100644)
@@ -5,22 +5,22 @@
  *
  * Careful: order of argument flags does matter. For example,
  *
- *	checkout-cache -a -f file.c
+ *	git-checkout-cache -a -f file.c
  *
  * Will first check out all files listed in the cache (but not
  * overwrite any old ones), and then force-checkout "file.c" a
  * second time (ie that one _will_ overwrite any old contents
  * with the same filename).
  *
- * Also, just doing "checkout-cache" does nothing. You probably
- * meant "checkout-cache -a". And if you want to force it, you
- * want "checkout-cache -f -a".
+ * Also, just doing "git-checkout-cache" does nothing. You probably
+ * meant "git-checkout-cache -a". And if you want to force it, you
+ * want "git-checkout-cache -f -a".
  *
  * Intuitiveness is not the goal here. Repeatability is. The
  * reason for the "no arguments means no work" thing is that
  * from scripts you are supposed to be able to do things like
  *
- *	find . -name '*.h' -print0 | xargs -0 checkout-cache -f --
+ *	find . -name '*.h' -print0 | xargs -0 git-checkout-cache -f --
  *
  * which will force all existing *.h files to be replaced with
  * their cached copies. If an empty command line implied "all",
@@ -122,7 +122,7 @@
 	if (!new || strcmp(type, "blob")) {
 		if (new)
 			free(new);
-		return error("checkout-cache: unable to read sha1 file of %s (%s)",
+		return error("git-checkout-cache: unable to read sha1 file of %s (%s)",
 			path, sha1_to_hex(ce->sha1));
 	}
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
@@ -130,14 +130,14 @@
 		fd = create_file(path, ntohl(ce->ce_mode));
 		if (fd < 0) {
 			free(new);
-			return error("checkout-cache: unable to create file %s (%s)",
+			return error("git-checkout-cache: unable to create file %s (%s)",
 				path, strerror(errno));
 		}
 		wrote = write(fd, new, size);
 		close(fd);
 		free(new);
 		if (wrote != size)
-			return error("checkout-cache: unable to write file %s", path);
+			return error("git-checkout-cache: unable to write file %s", path);
 		break;
 	case S_IFLNK:
 		memcpy(target, new, size);
@@ -145,14 +145,14 @@
 		create_directories(path);
 		if (symlink(target, path)) {
 			free(new);
-			return error("checkout-cache: unable to create symlink %s (%s)",
+			return error("git-checkout-cache: unable to create symlink %s (%s)",
 				path, strerror(errno));
 		}
 		free(new);
 		break;
 	default:
 		free(new);
-		return error("checkout-cache: unknown file mode for %s", path);
+		return error("git-checkout-cache: unknown file mode for %s", path);
 	}
 	return 0;
 }
@@ -172,7 +172,7 @@
 			return 0;
 		if (!force) {
 			if (!quiet)
-				fprintf(stderr, "checkout-cache: %s already exists\n", path);
+				fprintf(stderr, "git-checkout-cache: %s already exists\n", path);
 			return 0;
 		}
 
@@ -195,7 +195,7 @@
 		if (!quiet) {
 			pos = -pos - 1;
 			fprintf(stderr,
-				"checkout-cache: %s is %s.\n",
+				"git-checkout-cache: %s is %s.\n",
 				name,
 				(pos < active_nr &&
 				 !strcmp(active_cache[pos]->name, name)) ?
Index: commit-tree.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/commit-tree.c  (mode:100644)
+++ uncommitted/commit-tree.c  (mode:100644)
@@ -98,7 +98,7 @@
  */
 #define MAXPARENT (16)
 
-static char *commit_tree_usage = "commit-tree <sha1> [-p <sha1>]* < changelog";
+static char *commit_tree_usage = "git-commit-tree <sha1> [-p <sha1>]* < changelog";
 
 int main(int argc, char **argv)
 {
Index: convert-cache.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/convert-cache.c  (mode:100644)
+++ uncommitted/convert-cache.c  (mode:100644)
@@ -304,7 +304,7 @@
 	struct entry *entry;
 
 	if (argc != 2 || get_sha1(argv[1], sha1))
-		usage("convert-cache <sha1>");
+		usage("git-convert-cache <sha1>");
 
 	entry = convert_entry(sha1);
 	printf("new sha1: %s\n", sha1_to_hex(entry->new_sha1));
Index: diff-cache.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/diff-cache.c  (mode:100644)
+++ uncommitted/diff-cache.c  (mode:100644)
@@ -179,7 +179,7 @@
 		argv++;
 		argc--;
 		if (!strcmp(arg, "-r")) {
-			/* We accept the -r flag just to look like diff-tree */
+			/* We accept the -r flag just to look like git-diff-tree */
 			continue;
 		}
 		if (!strcmp(arg, "-p")) {
Index: diff-files.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/diff-files.c  (mode:100644)
+++ uncommitted/diff-files.c  (mode:100644)
@@ -7,7 +7,7 @@
 #include "diff.h"
 
 static const char *diff_files_usage =
-"diff-files [-p] [-q] [-r] [-z] [paths...]";
+"git-diff-files [-p] [-q] [-r] [-z] [paths...]";
 
 static int generate_patch = 0;
 static int line_termination = '\n';
Index: diff-tree.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/diff-tree.c  (mode:100644)
+++ uncommitted/diff-tree.c  (mode:100644)
@@ -258,7 +258,7 @@
 			update_tree_entry(&tree2, &size2);
 			continue;
 		}
-		die("diff-tree: internal error");
+		die("git-diff-tree: internal error");
 	}
 	return 0;
 }
@@ -379,7 +379,7 @@
 		header = generate_header(name, sha1_to_hex(parent), buf, size);
 		diff_tree_sha1(parent, commit, "");
 		if (!header && verbose_header)
-			header_prefix = "\ndiff-tree ";
+			header_prefix = "\ngit-diff-tree ";
 		offset += 48;
 	}
 	return 0;
@@ -408,7 +408,7 @@
 }
 
 static char *diff_tree_usage =
-"diff-tree [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] <tree sha1> <tree sha1>";
+"git-diff-tree [-p] [-r] [-z] [--stdin] [-m] [-s] [-v] <tree sha1> <tree sha1>";
 
 int main(int argc, char **argv)
 {
@@ -461,7 +461,7 @@
 		}
 		if (!strcmp(arg, "-v")) {
 			verbose_header = 1;
-			header_prefix = "diff-tree ";
+			header_prefix = "git-diff-tree ";
 			continue;
 		}
 		if (!strcmp(arg, "--stdin")) {
Index: fsck-cache.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/fsck-cache.c  (mode:100644)
+++ uncommitted/fsck-cache.c  (mode:100644)
@@ -152,7 +152,7 @@
 	}
 
 	if (has_full_path) {
-		fprintf(stderr, "warning: fsck-cache: tree %s "
+		fprintf(stderr, "warning: git-fsck-cache: tree %s "
 			"has full pathnames in it\n", 
 			sha1_to_hex(item->object.sha1));
 	}
@@ -385,7 +385,7 @@
 			continue;
 		}
 		if (*arg == '-')
-			usage("fsck-cache [--tags] [[--unreachable] [--cache] <head-sha1>*]");
+			usage("git-fsck-cache [--tags] [[--unreachable] [--cache] <head-sha1>*]");
 	}
 
 	sha1_dir = get_object_directory();
Index: ls-files.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/ls-files.c  (mode:100644)
+++ uncommitted/ls-files.c  (mode:100644)
@@ -283,7 +283,7 @@
 }
 
 static const char *ls_files_usage =
-	"ls-files [-z] [-t] (--[cached|deleted|others|stage|unmerged|killed])* "
+	"git-ls-files [-z] [-t] (--[cached|deleted|others|stage|unmerged|killed])* "
 	"[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]";
 
 int main(int argc, char **argv)
Index: ls-tree.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/ls-tree.c  (mode:100644)
+++ uncommitted/ls-tree.c  (mode:100644)
@@ -81,7 +81,7 @@
 	return 0;
 }
 
-static const char *ls_tree_usage = "ls-tree [-r] [-z] <key>";
+static const char *ls_tree_usage = "git-ls-tree [-r] [-z] <key>";
 
 int main(int argc, char **argv)
 {
Index: merge-base.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/merge-base.c  (mode:100644)
+++ uncommitted/merge-base.c  (mode:100644)
@@ -60,7 +60,7 @@
 	if (argc != 3 ||
 	    get_sha1(argv[1], rev1key) ||
 	    get_sha1(argv[2], rev2key)) {
-		usage("merge-base <commit-id> <commit-id>");
+		usage("git-merge-base <commit-id> <commit-id>");
 	}
 	rev1 = lookup_commit_reference(rev1key);
 	rev2 = lookup_commit_reference(rev2key);
Index: merge-cache.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/merge-cache.c  (mode:100644)
+++ uncommitted/merge-cache.c  (mode:100644)
@@ -39,7 +39,7 @@
 	int found;
 	
 	if (pos >= active_nr)
-		die("merge-cache: %s not in the cache", path);
+		die("git-merge-cache: %s not in the cache", path);
 	arguments[0] = pgm;
 	arguments[1] = "";
 	arguments[2] = "";
@@ -64,7 +64,7 @@
 		arguments[stage + 4] = ownbuf[stage];
 	} while (++pos < active_nr);
 	if (!found)
-		die("merge-cache: %s not in the cache", path);
+		die("git-merge-cache: %s not in the cache", path);
 	run_program();
 	return found;
 }
@@ -97,7 +97,7 @@
 	int i, force_file = 0;
 
 	if (argc < 3)
-		usage("merge-cache [-o] <merge-program> (-a | <filename>*)");
+		usage("git-merge-cache [-o] <merge-program> (-a | <filename>*)");
 
 	read_cache();
 
@@ -118,7 +118,7 @@
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
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/read-tree.c  (mode:100644)
+++ uncommitted/read-tree.c  (mode:100644)
@@ -159,7 +159,7 @@
 	}
 }
 
-static char *read_tree_usage = "read-tree (<sha> | -m <sha1> [<sha2> <sha3>])";
+static char *read_tree_usage = "git-read-tree (<sha> | -m <sha1> [<sha2> <sha3>])";
 
 int main(int argc, char **argv)
 {
Index: rev-list.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/rev-list.c  (mode:100644)
+++ uncommitted/rev-list.c  (mode:100644)
@@ -27,7 +27,7 @@
 	}
 
 	if (!commit_arg || get_sha1(commit_arg, sha1))
-		usage("usage: rev-list [OPTION] commit-id\n"
+		usage("usage: git-rev-list [OPTION] commit-id\n"
 		      "  --max-count=nr\n"
 		      "  --max-age=epoch\n"
 		      "  --min-age=epoch\n");
Index: rev-tree.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/rev-tree.c  (mode:100644)
+++ uncommitted/rev-tree.c  (mode:100644)
@@ -64,7 +64,7 @@
 }
 
 /*
- * Usage: rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id2>]
+ * Usage: git-rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id2>]
  *
  * The cache-file can be quite important for big trees. This is an
  * expensive operation if you have to walk the whole chain of
@@ -98,7 +98,7 @@
 			basemask |= 1<<nr;
 		}
 		if (nr >= MAX_COMMITS || get_sha1(arg, sha1[nr]))
-			usage("rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id>]");
+			usage("git-rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id>]");
 		process_commit(sha1[nr]);
 		nr++;
 	}
Index: rpush.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/rpush.c  (mode:100644)
+++ uncommitted/rpush.c  (mode:100644)
@@ -14,7 +14,7 @@
 		do {
 			size = read(fd_in, sha1 + posn, 20 - posn);
 			if (size < 0) {
-				perror("rpush: read ");
+				perror("git-rpush: read ");
 				return;
 			}
 			if (!size)
@@ -26,7 +26,7 @@
 
 		buf = map_sha1_file(sha1, &objsize);
 		if (!buf) {
-			fprintf(stderr, "rpush: could not find %s\n", 
+			fprintf(stderr, "git-rpush: could not find %s\n", 
 				sha1_to_hex(sha1));
 			return;
 		}
@@ -35,9 +35,9 @@
 			size = write(fd_out, buf + posn, objsize - posn);
 			if (size <= 0) {
 				if (!size) {
-					fprintf(stderr, "rpush: write closed");
+					fprintf(stderr, "git-rpush: write closed");
 				} else {
-					perror("rpush: write ");
+					perror("git-rpush: write ");
 				}
 				return;
 			}
@@ -56,7 +56,7 @@
                 arg++;
         }
         if (argc < arg + 2) {
-                usage("rpush [-c] [-t] [-a] commit-id url");
+                usage("git-rpush [-c] [-t] [-a] commit-id url");
                 return 1;
         }
 	commit_id = argv[arg];
Index: tar-tree.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/tar-tree.c  (mode:100644)
+++ uncommitted/tar-tree.c  (mode:100644)
@@ -17,7 +17,7 @@
 #define EXT_HEADER_PATH		1
 #define EXT_HEADER_LINKPATH	2
 
-static const char *tar_tree_usage = "tar-tree <key> [basedir]";
+static const char *tar_tree_usage = "git-tar-tree <key> [basedir]";
 
 static char block[BLOCKSIZE];
 static unsigned long offset;
@@ -40,9 +40,9 @@
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
Index: unpack-file.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/unpack-file.c  (mode:100644)
+++ uncommitted/unpack-file.c  (mode:100644)
@@ -27,7 +27,7 @@
 	unsigned char sha1[20];
 
 	if (argc != 2 || get_sha1(argv[1], sha1))
-		usage("unpack-file.c <sha1>");
+		usage("git-unpack-file <sha1>");
 
 	puts(create_temp_file(sha1));
 	return 0;
Index: update-cache.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/update-cache.c  (mode:100644)
+++ uncommitted/update-cache.c  (mode:100644)
@@ -10,7 +10,7 @@
  * Default to not allowing changes to the list of files. The
  * tool doesn't actually care, but this makes it harder to add
  * files to the revision control by mistake by doing something
- * like "update-cache *" and suddenly having all the object
+ * like "git-update-cache *" and suddenly having all the object
  * files be revision controlled.
  */
 static int allow_add = 0, allow_remove = 0, allow_replace = 0, not_new = 0;
@@ -179,7 +179,7 @@
  * file that hasn't been changed but where the stat entry is
  * out of date.
  *
- * For example, you'd want to do this after doing a "read-tree",
+ * For example, you'd want to do this after doing a "git-read-tree",
  * to link up the stat cache details with the proper files.
  */
 static struct cache_entry *refresh_entry(struct cache_entry *ce)
@@ -373,17 +373,17 @@
 			}
 			if (!strcmp(path, "--cacheinfo")) {
 				if (i+3 >= argc)
-					die("update-cache: --cacheinfo <mode> <sha1> <path>");
+					die("git-update-cache: --cacheinfo <mode> <sha1> <path>");
 				if (add_cacheinfo(argv[i+1], argv[i+2], argv[i+3]))
-					die("update-cache: --cacheinfo cannot add %s", argv[i+3]);
+					die("git-update-cache: --cacheinfo cannot add %s", argv[i+3]);
 				i += 3;
 				continue;
 			}
 			if (!strcmp(path, "--force-remove")) {
 				if (argc <= i + 1)
-					die("update-cache: --force-remove <path>");
+					die("git-update-cache: --force-remove <path>");
 				if (remove_file_from_cache(argv[i+1]))
-					die("update-cache: --force-remove cannot remove %s", argv[i+1]);
+					die("git-update-cache: --force-remove cannot remove %s", argv[i+1]);
 				i++;
 				continue;
 			}
Index: write-tree.c
===================================================================
--- 9adfcec0fcbf1828127b46991ffb7f6c76586b73/write-tree.c  (mode:100644)
+++ uncommitted/write-tree.c  (mode:100644)
@@ -89,7 +89,7 @@
 	unsigned char sha1[20];
 
 	if (entries < 0)
-		die("write-tree: error reading cache");
+		die("git-write-tree: error reading cache");
 
 	/* Verify that the tree is merged */
 	funny = 0;
@@ -104,7 +104,7 @@
 		}
 	}
 	if (funny)
-		die("write-tree: not able to write tree");
+		die("git-write-tree: not able to write tree");
 
 	/* Also verify that the cache does not have path and path/file
 	 * at the same time.  At this point we know the cache has only
@@ -131,11 +131,11 @@
 		}
 	}
 	if (funny)
-		die("write-tree: not able to write tree");
+		die("git-write-tree: not able to write tree");
 
 	/* Ok, write it out */
 	if (write_tree(active_cache, entries, "", 0, sha1) != entries)
-		die("write-tree: internal error");
+		die("git-write-tree: internal error");
 	printf("%s\n", sha1_to_hex(sha1));
 	return 0;
 }
