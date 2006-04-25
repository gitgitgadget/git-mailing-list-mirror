From: Rocco Rutte <pdmef@gmx.net>
Subject: [PATCH] Make die() and error() prefix line with binary name if set
Date: Tue, 25 Apr 2006 16:08:55 +0200
Message-ID: <20060425140854.GG5482@bolero.cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-From: git-owner@vger.kernel.org Tue Apr 25 16:10:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYOE2-0005jh-BS
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 16:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWDYOJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 10:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWDYOJF
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 10:09:05 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:9355 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S932231AbWDYOJD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 10:09:03 -0400
Received: from mailhost.cs.tu-berlin.de (postfix@mail.cs.tu-berlin.de [130.149.17.13])
	by mail.cs.tu-berlin.de (8.9.3p2/8.9.3) with ESMTP id QAA01316
	for <git@vger.kernel.org>; Tue, 25 Apr 2006 16:09:01 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTP id 18596F259;
	Tue, 25 Apr 2006 16:09:01 +0200 (MEST)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
 by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 10224)
 with ESMTP id 06421-33; Tue, 25 Apr 2006 16:08:55 +0200 (MEST) 12690
Received: from bolero.cs.tu-berlin.de (bolero.cs.tu-berlin.de [130.149.19.1])
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTP;
	Tue, 25 Apr 2006 16:08:55 +0200 (MEST)
Received: (from pdmef@localhost)
	by bolero.cs.tu-berlin.de (8.13.6+Sun/8.12.8/Submit) id k3PE8tfi009216;
	Tue, 25 Apr 2006 16:08:55 +0200 (MEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (SunOS)
X-Virus-Scanned: by amavisd-new at cs.tu-berlin.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19146>

Since lots of logic is implemented via shell scripts, it's in
general useful to print out where an error occured. Previously
only some commands manually added the binary name to die() and
error() calls.

Now, git_set_appname() can be used to set the name of the binary
as first call in a binary's main() routine which will be used
as prefix in die() and error(). If it was not called, no prefix
will be printed.

Also fix minor identation issues.

Signed-off-by: Rocco Rutte <pdmef@gmx.net>

---

  apply.c              |   13 +++++++------
  blame.c              |    2 ++
  cat-file.c           |   10 ++++++----
  check-ref-format.c   |    2 ++
  checkout-index.c     |    8 +++++---
  clone-pack.c         |    2 ++
  commit-tree.c        |    2 ++
  connect.c            |    4 ++--
  convert-objects.c    |    2 ++
  daemon.c             |    4 +++-
  describe.c           |    2 ++
  diff-files.c         |    5 ++++-
  diff-index.c         |    5 ++++-
  diff-stages.c        |    5 ++++-
  diff-tree.c          |    2 ++
  entry.c              |   14 +++++++-------
  fetch-clone.c        |    8 +++-----
  fetch-pack.c         |    4 +++-
  fsck-objects.c       |    2 ++
  get-tar-commit-id.c  |    2 ++
  git-compat-util.h    |    1 +
  git.c                |    2 ++
  hash-object.c        |    2 ++
  http-fetch.c         |    2 ++
  http-push.c          |    5 +++--
  index-pack.c         |   17 +++++++----------
  init-db.c            |    2 ++
  local-fetch.c        |    2 ++
  ls-files.c           |    8 +++++---
  ls-tree.c            |    2 ++
  mailinfo.c           |    2 ++
  mailsplit.c          |    2 ++
  merge-base.c         |    2 ++
  merge-index.c        |    8 +++++---
  merge-tree.c         |    2 ++
  mktag.c              |    2 ++
  mktree.c             |    2 ++
  name-rev.c           |    2 ++
  pack-objects.c       |    5 +++--
  pack-redundant.c     |    2 ++
  patch-id.c           |    2 ++
  peek-remote.c        |    2 ++
  prune-packed.c       |    2 ++
  read-tree.c          |    5 +++--
  receive-pack.c       |    5 +++--
  repo-config.c        |    2 ++
  rev-list.c           |    2 ++
  rev-parse.c          |    5 ++++-
  send-pack.c          |    2 ++
  shell.c              |    2 ++
  show-branch.c        |    2 ++
  show-index.c         |    2 ++
  ssh-fetch.c          |    2 ++
  ssh-upload.c         |    2 ++
  stripspace.c         |    2 ++
  symbolic-ref.c       |    2 ++
  tar-tree.c           |    6 ++++--
  test-date.c          |    2 ++
  test-delta.c         |    2 ++
  tree-diff.c          |    2 +-
  unpack-file.c        |    2 ++
  unpack-objects.c     |    2 ++
  update-index.c       |   26 ++++++++++++++------------
  update-ref.c         |    2 ++
  update-server-info.c |    3 +++
  upload-pack.c        |   21 +++++++++++----------
  usage.c              |   14 ++++++++++++++
  var.c                |    3 +++
  verify-pack.c        |    2 ++
  write-tree.c         |   10 ++++++----
  70 files changed, 222 insertions(+), 86 deletions(-)

cb3d0f89bcead397d38e3445c1925d1107bcf062
diff --git a/apply.c b/apply.c
index 269210a..90c4c7c 100644
--- a/apply.c
+++ b/apply.c
@@ -142,7 +142,7 @@ static void *read_patch_file(int fd, uns
  		if (!nr)
  			break;
  		if (nr < 0)
-			die("git-apply: read returned %s", strerror(errno));
+			die("read returned %s", strerror(errno));
  		size += nr;
  	}
  	*sizep = size;
@@ -320,17 +320,17 @@ static char *gitdiff_verify_name(const c
  		name = orig_name;
  		len = strlen(name);
  		if (isnull)
-			die("git-apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
+			die("bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
  		another = find_name(line, NULL, 1, 0);
  		if (!another || memcmp(another, name, len))
-			die("git-apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
+			die("bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
  		free(another);
  		return orig_name;
  	}
  	else {
  		/* expect "/dev/null" */
  		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die("git-apply: bad git-diff - expected /dev/null on line %d", linenr);
+			die("bad git-diff - expected /dev/null on line %d", linenr);
  		return NULL;
  	}
  }
@@ -1570,8 +1570,7 @@ static void show_index_list(struct patch
  		if (patch->is_new)
  			sha1_ptr = null_sha1;
  		else if (get_sha1(patch->old_sha1_prefix, sha1))
-			die("sha1 information is lacking or useless (%s).",
-			    name);
+			die("sha1 information is lacking or useless (%s).", name);
  		else
  			sha1_ptr = sha1;
  
@@ -1960,6 +1959,8 @@ int main(int argc, char **argv)
  	int read_stdin = 1;
  	const char *whitespace_option = NULL;
  
+	git_set_appname("git-apply");
+
  	for (i = 1; i < argc; i++) {
  		const char *arg = argv[i];
  		char *end;
diff --git a/blame.c b/blame.c
index 07d2d27..804f108 100644
--- a/blame.c
+++ b/blame.c
@@ -752,6 +752,8 @@ int main(int argc, const char **argv)
  	int longest_file, longest_author;
  	int found_rename;
  
+	git_set_appname("git-blame");
+
  	const char* prefix = setup_git_directory();
  	git_config(git_default_config);
  
diff --git a/cat-file.c b/cat-file.c
index 628f6ca..75c400a 100644
--- a/cat-file.c
+++ b/cat-file.c
@@ -16,9 +16,9 @@ static void flush_buffer(const char *buf
  			/* Ignore epipe */
  			if (errno == EPIPE)
  				break;
-			die("git-cat-file: %s", strerror(errno));
+			die("%s", strerror(errno));
  		} else if (!ret) {
-			die("git-cat-file: disk full?");
+			die("disk full?");
  		}
  		size -= ret;
  		buf += ret;
@@ -101,6 +101,8 @@ int main(int argc, char **argv)
  	unsigned long size;
  	int opt;
  
+	git_set_appname("git-cat-file");
+
  	setup_git_directory();
  	git_config(git_default_config);
  	if (argc != 3 || get_sha1(argv[2], sha1))
@@ -154,11 +156,11 @@ int main(int argc, char **argv)
  		break;
  
  	default:
-		die("git-cat-file: unknown option: %s\n", argv[1]);
+		die("unknown option: %s\n", argv[1]);
  	}
  
  	if (!buf)
-		die("git-cat-file %s: bad file", argv[2]);
+		die("bad file", argv[2]);
  
  	flush_buffer(buf, size);
  	return 0;
diff --git a/check-ref-format.c b/check-ref-format.c
index a0adb3d..ce08eda 100644
--- a/check-ref-format.c
+++ b/check-ref-format.c
@@ -9,6 +9,8 @@ #include <stdio.h>
  
  int main(int ac, char **av)
  {
+	git_set_appname("git-check-ref-format");
+
  	if (ac != 2)
  		usage("git-check-ref-format refname");
  	if (check_ref_format(av[1]))
diff --git a/checkout-index.c b/checkout-index.c
index dd6a2d8..b515651 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -176,6 +176,8 @@ int main(int argc, char **argv)
  	int all = 0;
  	int read_from_stdin = 0;
  
+	git_set_appname("git-checkout-index");
+
  	prefix = setup_git_directory();
  	git_config(git_default_config);
  	prefix_length = prefix ? strlen(prefix) : 0;
@@ -271,16 +273,16 @@ int main(int argc, char **argv)
  		const char *arg = argv[i];
  
  		if (all)
-			die("git-checkout-index: don't mix '--all' and explicit filenames");
+			die("don't mix '--all' and explicit filenames");
  		if (read_from_stdin)
-			die("git-checkout-index: don't mix '--stdin' and explicit filenames");
+			die("don't mix '--stdin' and explicit filenames");
  		checkout_file(prefix_path(prefix, prefix_length, arg));
  	}
  
  	if (read_from_stdin) {
  		struct strbuf buf;
  		if (all)
-			die("git-checkout-index: don't mix '--all' and '--stdin'");
+			die("don't mix '--all' and '--stdin'");
  		strbuf_init(&buf);
  		while (1) {
  			char *path_name;
diff --git a/clone-pack.c b/clone-pack.c
index a4370f5..0139745 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -150,6 +150,8 @@ int main(int argc, char **argv)
  	int fd[2];
  	pid_t pid;
  
+	git_set_appname("git-clone-pack");
+
  	setup_git_directory();
  
  	nr_heads = 0;
diff --git a/commit-tree.c b/commit-tree.c
index 2d86518..e07b0eb 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -87,6 +87,8 @@ int main(int argc, char **argv)
  	char *buffer;
  	unsigned int size;
  
+	git_set_appname("git-commit-tree");
+
  	setup_ident();
  	setup_git_directory();
  
diff --git a/connect.c b/connect.c
index 6a8f8a6..70ab5ad 100644
--- a/connect.c
+++ b/connect.c
@@ -69,7 +69,7 @@ int get_ack(int fd, unsigned char *resul
  	int len = packet_read_line(fd, line, sizeof(line));
  
  	if (!len)
-		die("git-fetch-pack: expected ACK/NAK, got EOF");
+		die("expected ACK/NAK, got EOF");
  	if (line[len-1] == '\n')
  		line[--len] = 0;
  	if (!strcmp(line, "NAK"))
@@ -81,7 +81,7 @@ int get_ack(int fd, unsigned char *resul
  			return 1;
  		}
  	}
-	die("git-fetch_pack: expected ACK/NAK, got '%s'", line);
+	die("expected ACK/NAK, got '%s'", line);
  }
  
  int path_match(const char *path, int nr, char **match)
diff --git a/convert-objects.c b/convert-objects.c
index 12aacef..6b5d955 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -319,6 +319,8 @@ int main(int argc, char **argv)
  	unsigned char sha1[20];
  	struct entry *entry;
  
+	git_set_appname("git-convert-object");
+
  	setup_git_directory();
  
  	if (argc != 2 || get_sha1(argv[1], sha1))
diff --git a/daemon.c b/daemon.c
index 776749e..0bb84e8 100644
--- a/daemon.c
+++ b/daemon.c
@@ -666,6 +666,8 @@ int main(int argc, char **argv)
  	int inetd_mode = 0;
  	int i;
  
+	git_set_appname("git-daemon");
+
  	for (i = 1; i < argc; i++) {
  		char *arg = argv[i];
  
@@ -739,7 +741,7 @@ int main(int argc, char **argv)
  
  	if (strict_paths && (!ok_paths || !*ok_paths)) {
  		if (!inetd_mode)
-			die("git-daemon: option --strict-paths requires a whitelist");
+			die("option --strict-paths requires a whitelist");
  
  		logerror("option --strict-paths requires a whitelist");
  		exit (1);
diff --git a/describe.c b/describe.c
index ff65742..a882d00 100644
--- a/describe.c
+++ b/describe.c
@@ -143,6 +143,8 @@ int main(int argc, char **argv)
  {
  	int i;
  
+	git_set_appname("git-describe");
+
  	for (i = 1; i < argc; i++) {
  		const char *arg = argv[i];
  
diff --git a/diff-files.c b/diff-files.c
index ffbef48..0c99c00 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -39,9 +39,12 @@ static void show_modified(int oldmode, i
  int main(int argc, const char **argv)
  {
  	const char **pathspec;
-	const char *prefix = setup_git_directory();
+	const char *prefix;
  	int entries, i;
  
+	git_set_appname("git-diff-files");
+
+	prefix = setup_git_directory();
  	git_config(git_diff_config);
  	diff_setup(&rev.diffopt);
  	while (1 < argc && argv[1][0] == '-') {
diff --git a/diff-index.c b/diff-index.c
index e376d65..b066d48 100644
--- a/diff-index.c
+++ b/diff-index.c
@@ -171,13 +171,16 @@ int main(int argc, const char **argv)
  {
  	const char *tree_name = NULL;
  	unsigned char sha1[20];
-	const char *prefix = setup_git_directory();
+	const char *prefix;
  	const char **pathspec = NULL;
  	struct tree *tree;
  	int ret;
  	int allow_options = 1;
  	int i;
  
+	git_set_appname("git-diff-index");
+
+	prefix = setup_git_directory();
  	git_config(git_diff_config);
  	diff_setup(&diff_options);
  	for (i = 1; i < argc; i++) {
diff --git a/diff-stages.c b/diff-stages.c
index dcd20e7..bd40b8e 100644
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -57,9 +57,12 @@ static void diff_stages(int stage1, int 
  int main(int ac, const char **av)
  {
  	int stage1, stage2;
-	const char *prefix = setup_git_directory();
+	const char *prefix;
  	const char **pathspec = NULL;
  
+	git_set_appname("git-diff-stages");
+
+	prefix = setup_git_directory();
  	git_config(git_diff_config);
  	read_cache();
  	diff_setup(&diff_options);
diff --git a/diff-tree.c b/diff-tree.c
index 7207867..76222d5 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -67,6 +67,8 @@ int main(int argc, const char **argv)
  	struct object_list *list;
  	int read_stdin = 0;
  
+	git_set_appname("git-diff-tree");
+
  	git_config(git_diff_config);
  	nr_sha1 = 0;
  	init_revisions(opt);
diff --git a/entry.c b/entry.c
index 793724f..5cf36f9 100644
--- a/entry.c
+++ b/entry.c
@@ -76,7 +76,7 @@ static int write_entry(struct cache_entr
  	if (!new || strcmp(type, blob_type)) {
  		if (new)
  			free(new);
-		return error("git-checkout-index: unable to read sha1 file of %s (%s)",
+		return error("unable to read sha1 file of %s (%s)",
  			path, sha1_to_hex(ce->sha1));
  	}
  	switch (ntohl(ce->ce_mode) & S_IFMT) {
@@ -88,14 +88,14 @@ static int write_entry(struct cache_entr
  			fd = create_file(path, ntohl(ce->ce_mode));
  		if (fd < 0) {
  			free(new);
-			return error("git-checkout-index: unable to create file %s (%s)",
+			return error("unable to create file %s (%s)",
  				path, strerror(errno));
  		}
  		wrote = write(fd, new, size);
  		close(fd);
  		free(new);
  		if (wrote != size)
-			return error("git-checkout-index: unable to write file %s", path);
+			return error("unable to write file %s", path);
  		break;
  	case S_IFLNK:
  		if (to_tempfile) {
@@ -103,26 +103,26 @@ static int write_entry(struct cache_entr
  			fd = mkstemp(path);
  			if (fd < 0) {
  				free(new);
-				return error("git-checkout-index: unable to create "
+				return error("unable to create "
  						 "file %s (%s)", path, strerror(errno));
  			}
  			wrote = write(fd, new, size);
  			close(fd);
  			free(new);
  			if (wrote != size)
-				return error("git-checkout-index: unable to write file %s",
+				return error("unable to write file %s",
  					path);
  		} else {
  			wrote = symlink(new, path);
  			free(new);
  			if (wrote)
-				return error("git-checkout-index: unable to create "
+				return error("unable to create "
  						 "symlink %s (%s)", path, strerror(errno));
  		}
  		break;
  	default:
  		free(new);
-		return error("git-checkout-index: unknown file mode for %s", path);
+		return error("unknown file mode for %s", path);
  	}
  
  	if (state->refresh_cache) {
diff --git a/fetch-clone.c b/fetch-clone.c
index da1b3ff..d94c252 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -23,7 +23,7 @@ static int finish_pack(const char *pack_
  
  	pid = fork();
  	if (pid < 0)
-		die("git-clone-pack: unable to fork off git-index-pack");
+		die("unable to fork off git-index-pack");
  	if (!pid) {
  		close(0);
  		dup2(pipe_fd[1], 1);
@@ -113,14 +113,12 @@ int receive_unpack_pack(int fd[2], const
  	close(fd[1]);
  	while (waitpid(pid, &status, 0) < 0) {
  		if (errno != EINTR)
-			die("waiting for git-unpack-objects: %s",
-			    strerror(errno));
+			die("waiting for git-unpack-objects: %s", strerror(errno));
  	}
  	if (WIFEXITED(status)) {
  		int code = WEXITSTATUS(status);
  		if (code)
-			die("git-unpack-objects died with error code %d",
-			    code);
+			die("git-unpack-objects died with error code %d", code);
  		return 0;
  	}
  	if (WIFSIGNALED(status)) {
diff --git a/fetch-pack.c b/fetch-pack.c
index a3bcad0..f7053e7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -390,7 +390,7 @@ static int fetch_pack(int fd[2], int nr_
  		status = receive_unpack_pack(fd, "git-fetch-pack", quiet);
  
  	if (status)
-		die("git-fetch-pack: fetch failed.");
+		die("fetch failed.");
  
   all_done:
  	while (ref) {
@@ -408,6 +408,8 @@ int main(int argc, char **argv)
  	int fd[2];
  	pid_t pid;
  
+	git_set_appname("git-fetch-pack");
+
  	setup_git_directory();
  
  	nr_heads = 0;
diff --git a/fsck-objects.c b/fsck-objects.c
index 59b2590..5e004b6 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -442,6 +442,8 @@ int main(int argc, char **argv)
  {
  	int i, heads;
  
+	git_set_appname("git-fsck-objects");
+
  	setup_git_directory();
  
  	for (i = 1; i < argc; i++) {
diff --git a/get-tar-commit-id.c b/get-tar-commit-id.c
index 4166290..036094d 100644
--- a/get-tar-commit-id.c
+++ b/get-tar-commit-id.c
@@ -12,6 +12,8 @@ int main(int argc, char **argv)
  	char buffer[HEADERSIZE];
  	ssize_t n;
  
+	git_set_appname("git-get-tar-commit-id");
+
  	n = read(0, buffer, HEADERSIZE);
  	if (n < HEADERSIZE) {
  		fprintf(stderr, "read error\n");
diff --git a/git-compat-util.h b/git-compat-util.h
index 5d543d2..cc5370c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -39,6 +39,7 @@ #endif
  extern void usage(const char *err) NORETURN;
  extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
  extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern void git_set_appname(const char *name);
  
  #ifdef NO_MMAP
  
diff --git a/git.c b/git.c
index aa2b814..ad49bb7 100644
--- a/git.c
+++ b/git.c
@@ -71,6 +71,8 @@ int main(int argc, const char **argv, ch
  	char git_command[PATH_MAX + 1];
  	const char *exec_path = NULL;
  
+	git_set_appname("git");
+
  	/*
  	 * Take the basename of argv[0] as the command
  	 * name, and the dirname as the default exec_path
diff --git a/hash-object.c b/hash-object.c
index 43bd93b..0c95d05 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -42,6 +42,8 @@ int main(int argc, char **argv)
  	int prefix_length = -1;
  	int no_more_flags = 0;
  
+	git_set_appname("git-hash-object");
+
  	for (i = 1 ; i < argc; i++) {
  		if (!no_more_flags && argv[i][0] == '-') {
  			if (!strcmp(argv[i], "-t")) {
diff --git a/http-fetch.c b/http-fetch.c
index 861644b..69c7cdb 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1222,6 +1222,8 @@ int main(int argc, char **argv)
  	int arg = 1;
  	int rc = 0;
  
+	git_set_appname("git-http-fetch");
+
  	setup_git_directory();
  
  	while (arg < argc && argv[arg][0] == '-') {
diff --git a/http-push.c b/http-push.c
index b4327d9..0ff5b05 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2130,8 +2130,7 @@ static void fetch_symref(char *path, cha
  	if (start_active_slot(slot)) {
  		run_active_slot(slot);
  		if (results.curl_result != CURLE_OK) {
-			die("Couldn't get %s for remote symref\n%s",
-			    url, curl_errorstr);
+			die("Couldn't get %s for remote symref\n%s", url, curl_errorstr);
  		}
  	} else {
  		die("Unable to start remote symref request");
@@ -2315,6 +2314,8 @@ int main(int argc, char **argv)
  	int new_refs;
  	struct ref *ref;
  
+	git_set_appname("git-http-push");
+
  	setup_git_directory();
  	setup_ident();
  
diff --git a/index-pack.c b/index-pack.c
index b39953d..bcfd116 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -39,21 +39,18 @@ static void open_pack_file(void)
  
  	fd = open(pack_name, O_RDONLY);
  	if (fd < 0)
-		die("cannot open packfile '%s': %s", pack_name,
-		    strerror(errno));
+		die("cannot open packfile '%s': %s", pack_name, strerror(errno));
  	if (fstat(fd, &st)) {
  		int err = errno;
  		close(fd);
-		die("cannot fstat packfile '%s': %s", pack_name,
-		    strerror(err));
+		die("cannot fstat packfile '%s': %s", pack_name, strerror(err));
  	}
  	pack_size = st.st_size;
  	pack_base = mmap(NULL, pack_size, PROT_READ, MAP_PRIVATE, fd, 0);
  	if (pack_base == MAP_FAILED) {
  		int err = errno;
  		close(fd);
-		die("cannot mmap packfile '%s': %s", pack_name,
-		    strerror(err));
+		die("cannot mmap packfile '%s': %s", pack_name, strerror(err));
  	}
  	close(fd);
  }
@@ -97,8 +94,7 @@ static void bad_object(unsigned long off
  	va_start(params, format);
  	vsnprintf(buf, sizeof(buf), format, params);
  	va_end(params);
-	die("packfile '%s': bad object at offset %lu: %s",
-	    pack_name, offset, buf);
+	die("packfile '%s': bad object at offset %lu: %s", pack_name, offset, buf);
  }
  
  static void *unpack_entry_data(unsigned long offset,
@@ -425,6 +421,8 @@ int main(int argc, char **argv)
  	char *index_name_buf = NULL;
  	unsigned char sha1[20];
  
+	git_set_appname("git-index-pack");
+
  	for (i = 1; i < argc; i++) {
  		const char *arg = argv[i];
  
@@ -448,8 +446,7 @@ int main(int argc, char **argv)
  	if (!index_name) {
  		int len = strlen(pack_name);
  		if (len < 5 || strcmp(pack_name + len - 5, ".pack"))
-			die("packfile name '%s' does not end with '.pack'",
-			    pack_name);
+			die("packfile name '%s' does not end with '.pack'", pack_name);
  		index_name_buf = xmalloc(len);
  		memcpy(index_name_buf, pack_name, len - 5);
  		strcpy(index_name_buf + len - 5, ".idx");
diff --git a/init-db.c b/init-db.c
index ff29496..29c93e3 100644
--- a/init-db.c
+++ b/init-db.c
@@ -241,6 +241,8 @@ int main(int argc, char **argv)
  	char *path, *template_dir = NULL;
  	int len, i;
  
+	git_set_appname("git-init-db");
+
  	for (i = 1; i < argc; i++, argv++) {
  		char *arg = argv[1];
  		if (!strncmp(arg, "--template=", 11))
diff --git a/local-fetch.c b/local-fetch.c
index fa9e697..11bf6f8 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -207,6 +207,8 @@ int main(int argc, char **argv)
  	char *commit_id;
  	int arg = 1;
  
+	git_set_appname("git-local-fetch");
+
  	setup_git_directory();
  
  	while (arg < argc && argv[arg][0] == '-') {
diff --git a/ls-files.c b/ls-files.c
index 4a4af1c..15a9bb2 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -383,7 +383,7 @@ static void show_dir_entry(const char *t
  	int offset = prefix_offset;
  
  	if (len >= ent->len)
-		die("git-ls-files: internal error - directory entry not superset of prefix");
+		die("internal error - directory entry not superset of prefix");
  
  	if (pathspec && !match(pathspec, ps_matched, ent->name, len))
  		return;
@@ -471,7 +471,7 @@ static void show_ce_entry(const char *ta
  	int offset = prefix_offset;
  
  	if (len >= ce_namelen(ce))
-		die("git-ls-files: internal error - cache entry not superset of prefix");
+		die("internal error - cache entry not superset of prefix");
  
  	if (pathspec && !match(pathspec, ps_matched, ce->name, len))
  		return;
@@ -630,7 +630,7 @@ static void verify_pathspec(void)
  	}
  
  	if (prefix_offset > max || memcmp(prev, prefix, prefix_offset))
-		die("git-ls-files: cannot generate relative filenames containing '..'");
+		die("cannot generate relative filenames containing '..'");
  
  	real_prefix = NULL;
  	prefix_len = max;
@@ -653,6 +653,8 @@ int main(int argc, const char **argv)
  	int i;
  	int exc_given = 0;
  
+	git_set_appname("git-ls-files");
+
  	prefix = setup_git_directory();
  	if (prefix)
  		prefix_offset = strlen(prefix);
diff --git a/ls-tree.c b/ls-tree.c
index e4ef200..e037bf0 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -89,6 +89,8 @@ int main(int argc, const char **argv)
  	unsigned char sha1[20];
  	struct tree *tree;
  
+	git_set_appname("git-ls-tree");
+
  	prefix = setup_git_directory();
  	git_config(git_default_config);
  	if (prefix && *prefix)
diff --git a/mailinfo.c b/mailinfo.c
index b276519..7baa3ff 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -757,6 +757,8 @@ static const char mailinfo_usage[] =
  
  int main(int argc, char **argv)
  {
+	git_set_appname("git-mailinfo");
+
  	/* NEEDSWORK: might want to do the optional .git/ directory
  	 * discovery
  	 */
diff --git a/mailsplit.c b/mailsplit.c
index c529e2d..686920e 100644
--- a/mailsplit.c
+++ b/mailsplit.c
@@ -111,6 +111,8 @@ int main(int argc, const char **argv)
  	static const char *stdin_only[] = { "-", NULL };
  	char *name;
  
+	git_set_appname("git-mailsplit");
+
  	for (argp = argv+1; *argp; argp++) {
  		const char *arg = *argp;
  
diff --git a/merge-base.c b/merge-base.c
index 07f5ab4..29cdbd7 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -236,6 +236,8 @@ int main(int argc, char **argv)
  	struct commit *rev1, *rev2;
  	unsigned char rev1key[20], rev2key[20];
  
+	git_set_appname("git-merge-base");
+
  	setup_git_directory();
  	git_config(git_default_config);
  
diff --git a/merge-index.c b/merge-index.c
index 024196e..3430da5 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -42,7 +42,7 @@ static int merge_entry(int pos, const ch
  	int found;
  	
  	if (pos >= active_nr)
-		die("git-merge-index: %s not in the cache", path);
+		die("%s not in the cache", path);
  	arguments[0] = pgm;
  	arguments[1] = "";
  	arguments[2] = "";
@@ -67,7 +67,7 @@ static int merge_entry(int pos, const ch
  		arguments[stage + 4] = ownbuf[stage];
  	} while (++pos < active_nr);
  	if (!found)
-		die("git-merge-index: %s not in the cache", path);
+		die("%s not in the cache", path);
  	run_program();
  	return found;
  }
@@ -99,6 +99,8 @@ int main(int argc, char **argv)
  {
  	int i, force_file = 0;
  
+	git_set_appname("git-merge-index");
+
  	if (argc < 3)
  		usage("git-merge-index [-o] [-q] <merge-program> (-a | <filename>*)");
  
@@ -126,7 +128,7 @@ int main(int argc, char **argv)
  				merge_all();
  				continue;
  			}
-			die("git-merge-index: unknown option %s", arg);
+			die("unknown option %s", arg);
  		}
  		merge_file(arg);
  	}
diff --git a/merge-tree.c b/merge-tree.c
index 50528d5..1eca1d7 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -164,6 +164,8 @@ int main(int argc, char **argv)
  	struct tree_desc t[3];
  	void *buf1, *buf2, *buf3;
  
+	git_set_appname("git-merge-tree");
+
  	if (argc < 4)
  		usage(merge_tree_usage);
  
diff --git a/mktag.c b/mktag.c
index 2328878..dcc917e 100644
--- a/mktag.c
+++ b/mktag.c
@@ -109,6 +109,8 @@ int main(int argc, char **argv)
  	char buffer[MAXSIZE];
  	unsigned char result_sha1[20];
  
+	git_set_appname("git-mktag");
+
  	if (argc != 1)
  		usage("cat <signaturefile> | git-mktag");
  
diff --git a/mktree.c b/mktree.c
index ab63cd9..a1ac929 100644
--- a/mktree.c
+++ b/mktree.c
@@ -79,6 +79,8 @@ int main(int ac, char **av)
  	unsigned char sha1[20];
  	int line_termination = '\n';
  
+	git_set_appname("git-mktree");
+
  	setup_git_directory();
  
  	while ((1 < ac) && av[1][0] == '-') {
diff --git a/name-rev.c b/name-rev.c
index bad8a53..c426059 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -126,6 +126,8 @@ int main(int argc, char **argv)
  	struct object_list **walker = &revs;
  	int as_is = 0, all = 0, transform_stdin = 0;
  
+	git_set_appname("git-name-rev");
+
  	setup_git_directory();
  	git_config(git_default_config);
  
diff --git a/pack-objects.c b/pack-objects.c
index c0acc46..ecbe9f9 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1237,6 +1237,8 @@ int main(int argc, char **argv)
  	int num_preferred_base = 0;
  	int i;
  
+	git_set_appname("git-pack-objects");
+
  	setup_git_directory();
  
  	for (i = 1; i < argc; i++) {
@@ -1315,8 +1317,7 @@ int main(int argc, char **argv)
  
  		if (line[0] == '-') {
  			if (get_sha1_hex(line+1, sha1))
-				die("expected edge sha1, got garbage:\n %s",
-				    line+1);
+				die("expected edge sha1, got garbage:\n %s", line+1);
  			if (num_preferred_base++ < window)
  				add_preferred_base(sha1);
  			continue;
diff --git a/pack-redundant.c b/pack-redundant.c
index cd81f5a..e2eff1b 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -589,6 +589,8 @@ int main(int argc, char **argv)
  	unsigned char *sha1;
  	char buf[42]; /* 40 byte sha1 + \n + \0 */
  
+	git_set_appname("git-pack-redundant");
+
  	setup_git_directory();
  
  	for (i = 1; i < argc; i++) {
diff --git a/patch-id.c b/patch-id.c
index edbc4aa..0e2bd85 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -74,6 +74,8 @@ static const char patch_id_usage[] = "gi
  
  int main(int argc, char **argv)
  {
+	git_set_appname("git-patch-id");
+
  	if (argc != 1)
  		usage(patch_id_usage);
  
diff --git a/peek-remote.c b/peek-remote.c
index a90cf22..99dac1b 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -29,6 +29,8 @@ int main(int argc, char **argv)
  	pid_t pid;
  	int nongit = 0;
  
+	git_set_appname("git-pack-remote");
+
  	setup_git_directory_gently(&nongit);
  
  	for (i = 1; i < argc; i++) {
diff --git a/prune-packed.c b/prune-packed.c
index d24b097..106cc39 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -58,6 +58,8 @@ int main(int argc, char **argv)
  {
  	int i;
  
+	git_set_appname("git-prune-packed");
+
  	setup_git_directory();
  
  	for (i = 1; i < argc; i++) {
diff --git a/read-tree.c b/read-tree.c
index 26f4f7e..6e1b698 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -235,8 +235,7 @@ #endif
  
  static void reject_merge(struct cache_entry *ce)
  {
-	die("Entry '%s' would be overwritten by merge. Cannot merge.", 
-	    ce->name);
+	die("Entry '%s' would be overwritten by merge. Cannot merge.", ce->name);
  }
  
  /* Unlink the last component and attempt to remove leading
@@ -723,6 +722,8 @@ int main(int argc, char **argv)
  	unsigned char sha1[20];
  	merge_fn_t fn = NULL;
  
+	git_set_appname("git-read-tree");
+
  	setup_git_directory();
  	git_config(git_default_config);
  
diff --git a/receive-pack.c b/receive-pack.c
index 93929b5..54ec6dc 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -237,8 +237,7 @@ static void read_head_info(void)
  		    line[81] != ' ' ||
  		    get_sha1_hex(line, old_sha1) ||
  		    get_sha1_hex(line + 41, new_sha1))
-			die("protocol error: expected old/new/ref, got '%s'",
-			    line);
+			die("protocol error: expected old/new/ref, got '%s'", line);
  
  		refname = line + 82;
  		reflen = strlen(refname);
@@ -304,6 +303,8 @@ int main(int argc, char **argv)
  	int i;
  	char *dir = NULL;
  
+	git_set_appname("git-receive-pack");
+
  	argv++;
  	for (i = 1; i < argc; i++) {
  		char *arg = *argv++;
diff --git a/repo-config.c b/repo-config.c
index c5ebb76..793af68 100644
--- a/repo-config.c
+++ b/repo-config.c
@@ -86,6 +86,8 @@ static int get_value(const char* key_, c
  
  int main(int argc, const char **argv)
  {
+	git_set_appname("git-repo-config");
+
  	setup_git_directory();
  
  	while (1 < argc) {
diff --git a/rev-list.c b/rev-list.c
index 8b0ec38..4646372 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -296,6 +296,8 @@ int main(int argc, const char **argv)
  	struct commit_list *list;
  	int i;
  
+	git_set_appname("git-rev-list");
+
  	init_revisions(&revs);
  	revs.abbrev = 0;
  	revs.commit_format = CMIT_FMT_UNSPECIFIED;
diff --git a/rev-parse.c b/rev-parse.c
index 7f66ae2..aaaf813 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -172,8 +172,11 @@ int main(int argc, char **argv)
  {
  	int i, as_is = 0, verify = 0;
  	unsigned char sha1[20];
-	const char *prefix = setup_git_directory();
+	const char *prefix;
  	
+	git_set_appname("git-rev-parse");
+
+	prefix = setup_git_directory();
  	git_config(git_default_config);
  
  	for (i = 1; i < argc; i++) {
diff --git a/send-pack.c b/send-pack.c
index 409f188..803e193 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -361,6 +361,8 @@ int main(int argc, char **argv)
  	int fd[2], ret;
  	pid_t pid;
  
+	git_set_appname("git-send-pack");
+
  	setup_git_directory();
  	git_config(git_default_config);
  
diff --git a/shell.c b/shell.c
index 8c08cf0..c22cde1 100644
--- a/shell.c
+++ b/shell.c
@@ -32,6 +32,8 @@ int main(int argc, char **argv)
  	char *prog;
  	struct commands *cmd;
  
+	git_set_appname("git-shell");
+
  	/* We want to see "-c cmd args", and nothing else */
  	if (argc != 3 || strcmp(argv[1], "-c"))
  		die("What do you think I am? A shell?");
diff --git a/show-branch.c b/show-branch.c
index 24efb65..9ec3553 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -549,6 +549,8 @@ int main(int ac, char **av)
  	int head_at = -1;
  	int topics = 0;
  
+	git_set_appname("git-show-branch");
+
  	setup_git_directory();
  	git_config(git_show_branch_config);
  
diff --git a/show-index.c b/show-index.c
index c21d660..b8a9fba 100644
--- a/show-index.c
+++ b/show-index.c
@@ -7,6 +7,8 @@ int main(int argc, char **argv)
  	unsigned int entry[6];
  	static unsigned int top_index[256];
  
+	git_set_appname("git-show-index");
+
  	if (fread(top_index, sizeof(top_index), 1, stdin) != 1)
  		die("unable to read idex");
  	nr = 0;
diff --git a/ssh-fetch.c b/ssh-fetch.c
index 4eb9e04..4bab7e7 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -128,6 +128,8 @@ int main(int argc, char **argv)
  	int arg = 1;
  	const char *prog;
  
+	git_set_appname("git-ssh-fetch");
+
  	prog = getenv("GIT_SSH_PUSH");
  	if (!prog) prog = "git-ssh-upload";
  
diff --git a/ssh-upload.c b/ssh-upload.c
index b675a0b..9860cf4 100644
--- a/ssh-upload.c
+++ b/ssh-upload.c
@@ -119,6 +119,8 @@ int main(int argc, char **argv)
  	unsigned char sha1[20];
  	char hex[41];
  
+	git_set_appname("git-ssh-upload");
+
  	prog = getenv(COUNTERPART_ENV_NAME);
  	if (!prog) prog = COUNTERPART_PROGRAM_NAME;
  
diff --git a/stripspace.c b/stripspace.c
index 65a6346..95c2e43 100644
--- a/stripspace.c
+++ b/stripspace.c
@@ -34,6 +34,8 @@ int main(int argc, char **argv)
  	int incomplete = 0;
  	char line[1024];
  
+	git_set_appname("git-stripspace");
+
  	while (fgets(line, sizeof(line), stdin)) {
  		incomplete = cleanup(line);
  
diff --git a/symbolic-ref.c b/symbolic-ref.c
index 193c87c..a8b3b9d 100644
--- a/symbolic-ref.c
+++ b/symbolic-ref.c
@@ -19,6 +19,8 @@ static void check_symref(const char *HEA
  
  int main(int argc, const char **argv)
  {
+	git_set_appname("git-symbolic-ref");
+
  	setup_git_directory();
  	git_config(git_default_config);
  	switch (argc) {
diff --git a/tar-tree.c b/tar-tree.c
index fc60a90..7a388f5 100644
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -26,9 +26,9 @@ static void reliable_write(void *buf, un
  		if (ret < 0) {
  			if (errno == EPIPE)
  				exit(0);
-			die("git-tar-tree: %s", strerror(errno));
+			die("%s", strerror(errno));
  		} else if (!ret) {
-			die("git-tar-tree: disk full?");
+			die("disk full?");
  		}
  		size -= ret;
  		buf += ret;
@@ -308,6 +308,8 @@ int main(int argc, char **argv)
  	struct tree_desc tree;
  	struct strbuf current_path;
  
+	git_set_appname("git-tar-tree");
+
  	current_path.buf = xmalloc(PATH_MAX);
  	current_path.alloc = PATH_MAX;
  	current_path.len = current_path.eof = 0;
diff --git a/test-date.c b/test-date.c
index 93e8027..3d2cfbb 100644
--- a/test-date.c
+++ b/test-date.c
@@ -7,6 +7,8 @@ int main(int argc, char **argv)
  {
  	int i;
  
+	git_set_appname("git-test-date");
+
  	for (i = 1; i < argc; i++) {
  		char result[100];
  		time_t t;
diff --git a/test-delta.c b/test-delta.c
index 1be8ee0..bf6c6ac 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -27,6 +27,8 @@ int main(int argc, char *argv[])
  	void *from_buf, *data_buf, *out_buf;
  	unsigned long from_size, data_size, out_size;
  
+	git_set_appname("git-test-delta");
+
  	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
  		fprintf(stderr, "Usage: %s\n", usage);
  		return 1;
diff --git a/tree-diff.c b/tree-diff.c
index 1cdf8aa..5170ddf 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -191,7 +191,7 @@ int diff_tree(struct tree_desc *t1, stru
  			update_tree_entry(t2);
  			continue;
  		}
-		die("git-diff-tree: internal error");
+		die("internal error");
  	}
  	return 0;
  }
diff --git a/unpack-file.c b/unpack-file.c
index 23a8562..a49e230 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -27,6 +27,8 @@ int main(int argc, char **argv)
  {
  	unsigned char sha1[20];
  
+	git_set_appname("git-unpack-file");
+
  	if (argc != 2 || get_sha1(argv[1], sha1))
  		usage("git-unpack-file <sha1>");
  
diff --git a/unpack-objects.c b/unpack-objects.c
index 3b824b0..315ea67 100644
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -270,6 +270,8 @@ int main(int argc, char **argv)
  	int i;
  	unsigned char sha1[20];
  
+	git_set_appname("git-unpack-objects");
+
  	setup_git_directory();
  
  	quiet = !isatty(2);
diff --git a/update-index.c b/update-index.c
index facec8d..f8e24d4 100644
--- a/update-index.c
+++ b/update-index.c
@@ -354,7 +354,7 @@ static void chmod_path(int flip, const c
  	report("chmod %cx '%s'", flip, path);
  	return;
   fail:
-	die("git-update-index: cannot chmod %cx '%s'", flip, path);
+	die("cannot chmod %cx '%s'", flip, path);
  }
  
  static struct cache_file cache_file;
@@ -374,7 +374,7 @@ static void update_one(const char *path,
  
  	if (force_remove) {
  		if (remove_file_from_cache(p))
-			die("git-update-index: unable to remove %s", path);
+			die("unable to remove %s", path);
  		report("remove '%s'", path);
  		return;
  	}
@@ -450,8 +450,7 @@ static void read_index_info(int line_ter
  		if (!mode) {
  			/* mode == 0 means there is no such path -- remove */
  			if (remove_file_from_cache(path_name))
-				die("git-update-index: unable to remove %s",
-				    ptr);
+				die("unable to remove %s", ptr);
  		}
  		else {
  			/* mode ' ' sha1 '\t' name
@@ -460,8 +459,7 @@ static void read_index_info(int line_ter
  			 */
  			ptr[-42] = ptr[-1] = 0;
  			if (add_cacheinfo(mode, sha1, path_name, stage))
-				die("git-update-index: unable to update %s",
-				    path_name);
+				die("unable to update %s", path_name);
  		}
  		if (path_name != ptr)
  			free(path_name);
@@ -598,12 +596,17 @@ int main(int argc, const char **argv)
  	int i, newfd, entries, has_errors = 0, line_termination = '\n';
  	int allow_options = 1;
  	int read_from_stdin = 0;
-	const char *prefix = setup_git_directory();
-	int prefix_length = prefix ? strlen(prefix) : 0;
+	const char *prefix;
+	int prefix_length;
  	char set_executable_bit = 0;
  
+	git_set_appname("git-update-index");
+
  	git_config(git_default_config);
  
+	prefix = setup_git_directory();
+	prefix_length = prefix ? strlen(prefix) : 0;
+
  	newfd = hold_index_file_for_update(&cache_file, get_index_file());
  	if (newfd < 0)
  		die("unable to create new cachefile");
@@ -653,20 +656,19 @@ int main(int argc, const char **argv)
  				unsigned int mode;
  
  				if (i+3 >= argc)
-					die("git-update-index: --cacheinfo <mode> <sha1> <path>");
+					die("--cacheinfo <mode> <sha1> <path>");
  
  				if ((sscanf(argv[i+1], "%o", &mode) != 1) ||
  				    get_sha1_hex(argv[i+2], sha1) ||
  				    add_cacheinfo(mode, sha1, argv[i+3], 0))
-					die("git-update-index: --cacheinfo"
-					    " cannot add %s", argv[i+3]);
+					die("--cacheinfo cannot add %s", argv[i+3]);
  				i += 3;
  				continue;
  			}
  			if (!strcmp(path, "--chmod=-x") ||
  			    !strcmp(path, "--chmod=+x")) {
  				if (argc <= i+1)
-					die("git-update-index: %s <path>", path);
+					die("%s <path>", path);
  				set_executable_bit = path[8];
  				continue;
  			}
diff --git a/update-ref.c b/update-ref.c
index ba4bf51..1fd32d1 100644
--- a/update-ref.c
+++ b/update-ref.c
@@ -24,6 +24,8 @@ int main(int argc, char **argv)
  	unsigned char sha1[20], oldsha1[20], currsha1[20];
  	int fd, written;
  
+	git_set_appname("git-update-ref");
+
  	setup_git_directory();
  	git_config(git_default_config);
  	if (argc < 3 || argc > 4)
diff --git a/update-server-info.c b/update-server-info.c
index 0b6c383..3496d0e 100644
--- a/update-server-info.c
+++ b/update-server-info.c
@@ -7,6 +7,9 @@ int main(int ac, char **av)
  {
  	int i;
  	int force = 0;
+
+	git_set_appname("git-update-server-info");
+
  	for (i = 1; i < ac; i++) {
  		if (av[i][0] == '-') {
  			if (!strcmp("--force", av[i]) ||
diff --git a/upload-pack.c b/upload-pack.c
index 47560c9..ed16b53 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -38,10 +38,10 @@ static void create_pack_file(void)
  	int create_full_pack = (nr_our_refs == nr_needs && !nr_has);
  
  	if (pipe(fd) < 0)
-		die("git-upload-pack: unable to create pipe");
+		die("unable to create pipe");
  	pid = fork();
  	if (pid < 0)
-		die("git-upload-pack: unable to fork git-rev-list");
+		die("unable to fork git-rev-list");
  
  	if (!pid) {
  		int i;
@@ -84,19 +84,19 @@ static void create_pack_file(void)
  			}
  		*p++ = NULL;
  		execv_git_cmd(argv);
-		die("git-upload-pack: unable to exec git-rev-list");
+		die("unable to exec git-rev-list");
  	}
  	dup2(fd[0], 0);
  	close(fd[0]);
  	close(fd[1]);
  	execl_git_cmd("pack-objects", "--stdout", NULL);
-	die("git-upload-pack: unable to exec git-pack-objects");
+	die("unable to exec git-pack-objects");
  }
  
  static int got_sha1(char *hex, unsigned char *sha1)
  {
  	if (get_sha1_hex(hex, sha1))
-		die("git-upload-pack: expected SHA1 object, got '%s'", hex);
+		die("expected SHA1 object, got '%s'", hex);
  	if (!has_sha1_file(sha1))
  		return 0;
  	if (nr_has < MAX_HAS) {
@@ -162,7 +162,7 @@ static int get_common_commits(void)
  			packet_write(1, "NAK\n");
  			return -1;
  		}
-		die("git-upload-pack: expected SHA1 list, got '%s'", line);
+		die("expected SHA1 list, got '%s'", line);
  	}
  }
  
@@ -191,8 +191,7 @@ static int receive_needs(void)
  			sha1_buf = needs_sha1[needs];
  
  		if (strncmp("want ", line, 5) || get_sha1_hex(line+5, sha1_buf))
-			die("git-upload-pack: protocol error, "
-			    "expected to get sha, not '%s'", line);
+			die("protocol error, expected to get sha, not '%s'", line);
  		if (strstr(line+45, "multi_ack"))
  			multi_ack = 1;
  		if (strstr(line+45, "thin-pack"))
@@ -208,7 +207,7 @@ static int receive_needs(void)
  		 */
  		o = lookup_object(sha1_buf);
  		if (!o || !(o->flags & OUR_REF))
-			die("git-upload-pack: not our ref %s", line+5);
+			die("not our ref %s", line+5);
  		if (!(o->flags & WANTED)) {
  			o->flags |= WANTED;
  			needs++;
@@ -222,7 +221,7 @@ static int send_ref(const char *refname,
  	struct object *o = parse_object(sha1);
  
  	if (!o)
-		die("git-upload-pack: cannot find object %s:", sha1_to_hex(sha1));
+		die("cannot find object %s:", sha1_to_hex(sha1));
  
  	if (capabilities)
  		packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname,
@@ -261,6 +260,8 @@ int main(int argc, char **argv)
  	int i;
  	int strict = 0;
  
+	git_set_appname("git-upload-pack");
+
  	for (i = 1; i < argc; i++) {
  		char *arg = argv[i];
  
diff --git a/usage.c b/usage.c
index 1fa924c..bb89d66 100644
--- a/usage.c
+++ b/usage.c
@@ -5,8 +5,11 @@
   */
  #include "git-compat-util.h"
  
+static char appname[32+3]="";      /* +3 for ': \0' */
+
  static void report(const char *prefix, const char *err, va_list params)
  {
+	fputs(appname[0]?appname:"",stderr);
  	fputs(prefix, stderr);
  	vfprintf(stderr, err, params);
  	fputs("\n", stderr);
@@ -37,3 +40,14 @@ int error(const char *err, ...)
  	va_end(params);
  	return -1;
  }
+
+void git_set_appname(const char *name)
+{
+	size_t len=(name && *name)?strlen(name):0;
+	if (0==len)
+		return;
+	memcpy(appname,name,len>sizeof(appname)-3?sizeof(appname)-3:len);
+	appname[len++]=':';
+	appname[len++]=' ';
+	appname[len++]='\0';
+}
diff --git a/var.c b/var.c
index a57a33b..a816373 100644
--- a/var.c
+++ b/var.c
@@ -54,6 +54,9 @@ static int show_config(const char *var, 
  int main(int argc, char **argv)
  {
  	const char *val;
+
+	git_set_appname("git-var");
+
  	if (argc != 2) {
  		usage(var_usage);
  	}
diff --git a/verify-pack.c b/verify-pack.c
index c99db9d..e1b3b01 100644
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -35,6 +35,8 @@ int main(int ac, char **av)
  	int verbose = 0;
  	int no_more_options = 0;
  
+	git_set_appname("git-verify-pack");
+
  	while (1 < ac) {
  		char path[PATH_MAX];
  
diff --git a/write-tree.c b/write-tree.c
index dcad6e6..9f68fda 100644
--- a/write-tree.c
+++ b/write-tree.c
@@ -92,6 +92,8 @@ int main(int argc, char **argv)
  	int entries;
  	unsigned char sha1[20];
  	
+	git_set_appname("git-write-tree");
+
  	setup_git_directory();
  
  	entries = read_cache();
@@ -106,7 +108,7 @@ int main(int argc, char **argv)
  		die("too many options");
  
  	if (entries < 0)
-		die("git-write-tree: error reading cache");
+		die("error reading cache");
  
  	/* Verify that the tree is merged */
  	funny = 0;
@@ -121,7 +123,7 @@ int main(int argc, char **argv)
  		}
  	}
  	if (funny)
-		die("git-write-tree: not able to write tree");
+		die("not able to write tree");
  
  	/* Also verify that the cache does not have path and path/file
  	 * at the same time.  At this point we know the cache has only
@@ -148,11 +150,11 @@ int main(int argc, char **argv)
  		}
  	}
  	if (funny)
-		die("git-write-tree: not able to write tree");
+		die("not able to write tree");
  
  	/* Ok, write it out */
  	if (write_tree(active_cache, entries, "", 0, sha1) != entries)
-		die("git-write-tree: internal error");
+		die("internal error");
  	printf("%s\n", sha1_to_hex(sha1));
  	return 0;
  }
-- 
1.3.0.g36932-dirty
