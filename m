From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 09/11] config: add core.untrackedCache
Date: Sun, 24 Jan 2016 16:28:22 +0100
Message-ID: <1453649304-18121-10-git-send-email-chriscool@tuxfamily.org>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 16:29:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbr-000187-Nm
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbcAXP3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2016 10:29:41 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35047 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbcAXP25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:28:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so6790345wmz.2
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OsOVKWD8FTvgWlQ9c4OjsqbGnp0bBGcnbUgCao56dkE=;
        b=Y/pTBbw4Jkn5MjAniRceQiraA7uexMTJZcgls/gvUTKKAgWApISMIdaHKfa0hWm19l
         aefEOrXto49JNWDmMG0Y7cY/uWcd0UGwRn29MMDn5QhcXDSUwwtMJF8ZUvNJ7JaOsAEN
         am9XgRJETpBmkh931rlFKff+9T8GM4TQosi/eyvVtufUeW6HtZhJjNu/cW1cQe3DoZuC
         IOG+fdvJ+h0KWGJGHY0CTw6N7iyFwl9qy36NrAj3kgKD2p140dLLK6pBk5k8awPHH87U
         J1hqxEhHS4Ca7UUDNNaDkPfj9eQ/jTqdDAgayC82lzVAkPMM1sVArRKPpx/7y9//PZFR
         6/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=OsOVKWD8FTvgWlQ9c4OjsqbGnp0bBGcnbUgCao56dkE=;
        b=m/L/3gV9Xg5CUf7BuFfm9xGyIcS+Q+XlZeHi8AKErQF8V5GngJLXyELhzrRQkf8owg
         43vqLrIMu/K28ZwgOd3szZNaXBVr0U4e+ZJ9egGb3wxzZAou/602SohcCQqpMBpPkOXA
         u4KI8B6GI5WVgvq1L0IfHi+yVEKOUZiIzy9xSF1xuuR38olB8P11YhOyGqUf3YceZTik
         S7Oub0W7dse1+SlsakT2Z0jFYa/CL1lAXYCTpK6gaPJ6duTepBfXehuFeZXqAOEf8cyd
         QVcLzZoyLF1cQSZCpL+I/OPxTBA9J7pZFWXNuESjWBq3YveAl2wqk1sTsxAOF0s9uP/O
         ZGgA==
X-Gm-Message-State: AG10YOQ4PmiFLbe7nsAhoGL+VGwsmlU9jhBQIdT73twLn7+uCDu5gZBHseTvqZnX0sg0RQ==
X-Received: by 10.28.146.8 with SMTP id u8mr12824964wmd.72.1453649336263;
        Sun, 24 Jan 2016 07:28:56 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:54 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
In-Reply-To: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284660>

When we know that mtime on directory as given by the environment
is usable for the purpose of untracked cache, we may want the
untracked cache to be always used without any mtime test or
kernel name check being performed.

Also when we know that mtime is not usable for the purpose of
untracked cache, for example because the repo is shared over a
network file system, we may want the untracked-cache to be
automatically removed from the index.

Allow the user to express such preference by setting the
'core.untrackedCache' configuration variable, which can take
'keep', 'false', or 'true' and default to 'keep'.

When read_index_from() is called, it now adds or removes the
untracked cache in the index to respect the value of this
variable. So it does nothing if the value is `keep` or if the
variable is unset; it adds the untracked cache if the value is
`true`; and it removes the cache if the value is `false`.

`git update-index --[no-|force-]untracked-cache` still adds the
untracked cache to, or removes it, from the index, but this
shows a warning if it goes against the value of
core.untrackedCache, because the next time the index is read
the untracked cache will be added or removed if the
configuration is set to do so.

Also `--untracked-cache` used to check that the underlying
operating system and file system change `st_mtime` field of a
directory if files are added or deleted in that directory. But
because those tests take a long time, `--untracked-cache` no
longer performs them. Instead, there is now
`--test-untracked-cache` to perform the tests. This change
makes `--untracked-cache` the same as `--force-untracked-cache`.

This last change is backward incompatible and should be
mentioned in the release notes.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>

read-cache: Duy'sfixup

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt               |  9 +++++
 Documentation/git-update-index.txt     | 67 ++++++++++++++++++++++++++=
--------
 builtin/update-index.c                 | 35 ++++++++++++------
 cache.h                                |  1 +
 config.c                               | 20 ++++++++++
 contrib/completion/git-completion.bash |  1 +
 read-cache.c                           | 20 ++++++++--
 t/t7063-status-untracked-cache.sh      |  4 +-
 8 files changed, 125 insertions(+), 32 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 07f7a3b..354fd1c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -308,6 +308,15 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
=20
+core.untrackedCache::
+	Determines what to do about the untracked cache feature of the
+	index. It will be kept, if this variable is unset or set to
+	`keep`. It will automatically be added if set to `true`. And
+	it will automatically be removed, if set to `false`. Before
+	setting it to `true`, you should check that mtime is working
+	properly on your system.
+	See linkgit:git-update-index[1]. `keep` by default.
+
 core.checkStat::
 	Determines which stat fields to match between the index
 	and work tree. The user can set this to 'default' or
diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index a0afe17..c6cbed1 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -174,27 +174,30 @@ may not support it yet.
=20
 --untracked-cache::
 --no-untracked-cache::
-	Enable or disable untracked cache extension. This could speed
-	up for commands that involve determining untracked files such
-	as `git status`. The underlying operating system and file
-	system must change `st_mtime` field of a directory if files
-	are added or deleted in that directory.
+	Enable or disable untracked cache feature. Please use
+	`--test-untracked-cache` before enabling it.
++
+These options take effect whatever the value of the `core.untrackedCac=
he`
+configuration variable (see linkgit:git-config[1]). But a warning is
+emitted when the change goes against the configured value, as the
+configured value will take effect next time the index is read and this
+will remove the intended effect of the option.
=20
 --test-untracked-cache::
 	Only perform tests on the working directory to make sure
 	untracked cache can be used. You have to manually enable
-	untracked cache using `--force-untracked-cache` (or
-	`--untracked-cache` but this will run the tests again)
-	afterwards if you really want to use it. If a test fails
-	the exit code is 1 and a message explains what is not
-	working as needed, otherwise the exit code is 0 and OK is
-	printed.
+	untracked cache using `--untracked-cache` or
+	`--force-untracked-cache` or the `core.untrackedCache`
+	configuration variable afterwards if you really want to use
+	it. If a test fails the exit code is 1 and a message
+	explains what is not working as needed, otherwise the exit
+	code is 0 and OK is printed.
=20
 --force-untracked-cache::
-	For safety, `--untracked-cache` performs tests on the working
-	directory to make sure untracked cache can be used. These
-	tests can take a few seconds. `--force-untracked-cache` can be
-	used to skip the tests.
+	Same as `--untracked-cache`. Provided for backwards
+	compatibility with older versions of Git where
+	`--untracked-cache` used to imply `--test-untracked-cache` but
+	this option would enable the extension unconditionally.
=20
 \--::
 	Do not interpret any more arguments as options.
@@ -385,6 +388,37 @@ Although this bit looks similar to assume-unchange=
d bit, its goal is
 different from assume-unchanged bit's. Skip-worktree also takes
 precedence over assume-unchanged bit when both are set.
=20
+Untracked cache
+---------------
+
+This cache is meant to speed up commands that involve determining
+untracked files such as `git status`.
+
+This feature works by recording the mtime of the working tree
+directories and then omitting reading directories and stat calls
+against files in those directories whose mtime hasn't changed. For
+this to work the underlying operating system and file system must
+change the `st_mtime` field of directories if files in the directory
+are added, modified or deleted.
+
+You can test whether the filesystem supports that with the
+`--test-untracked-cache` option. The `--untracked-cache` option used
+to implicitly perform that test in older versions of Git, but that's
+no longer the case.
+
+If you want to enable (or disable) this feature, it is easier to use
+the `core.untrackedCache` configuration variable (see
+linkgit:git-config[1]) than using the `--untracked-cache` option to
+`git update-index` in each repository, especially if you want to do so
+across all repositories you use, because you can set the configuration
+variable to `true` (or `false`) in your `$HOME/.gitconfig` just once
+and have it affect all repositories you touch.
+
+When the `core.untrackedCache` configuration variable is changed, the
+untracked cache is added to or removed from the index the next time a
+command reads the index; while when `--[no-|force-]untracked-cache`
+are used, the untracked cache is immediately added to or removed from
+the index.
=20
 Configuration
 -------------
@@ -410,6 +444,9 @@ It can be useful when the inode change time is regu=
larly modified by
 something outside Git (file system crawlers and backup systems use
 ctime for marking files processed) (see linkgit:git-config[1]).
=20
+The untracked cache extension can be enabled by the
+`core.untrackedCache` configuration variable (see
+linkgit:git-config[1]).
=20
 SEE ALSO
 --------
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d90154c..7a55334 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1115,19 +1115,32 @@ int cmd_update_index(int argc, const char **arg=
v, const char *prefix)
 		the_index.split_index =3D NULL;
 		the_index.cache_changed |=3D SOMETHING_CHANGED;
 	}
-	if (untracked_cache > UC_DISABLE) {
-		if (untracked_cache < UC_FORCE) {
-			setup_work_tree();
-			if (!test_if_untracked_cache_is_supported())
-				return 1;
-			if (untracked_cache =3D=3D UC_TEST)
-				return 0;
-		}
-		add_untracked_cache(&the_index);
-		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
-	} else if (untracked_cache =3D=3D UC_DISABLE) {
+
+	switch (untracked_cache) {
+	case UC_UNSPECIFIED:
+		break;
+	case UC_DISABLE:
+		if (git_config_get_untracked_cache() =3D=3D 1)
+			warning("core.untrackedCache is set to true; "
+				"remove or change it, if you really want to "
+				"disable the untracked cache");
 		remove_untracked_cache(&the_index);
 		report(_("Untracked cache disabled"));
+		break;
+	case UC_TEST:
+		setup_work_tree();
+		return !test_if_untracked_cache_is_supported();
+	case UC_ENABLE:
+	case UC_FORCE:
+		if (git_config_get_untracked_cache() =3D=3D 0)
+			warning("core.untrackedCache is set to false; "
+				"remove or change it, if you really want to "
+				"enable the untracked cache");
+		add_untracked_cache(&the_index);
+		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
+		break;
+	default:
+		die("Bug: bad untracked_cache value: %d", untracked_cache);
 	}
=20
 	if (active_cache_changed) {
diff --git a/cache.h b/cache.h
index dfc459c..e2900d1 100644
--- a/cache.h
+++ b/cache.h
@@ -1606,6 +1606,7 @@ extern int git_config_get_bool(const char *key, i=
nt *dest);
 extern int git_config_get_bool_or_int(const char *key, int *is_bool, i=
nt *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest)=
;
+extern int git_config_get_untracked_cache(void);
=20
 struct key_value_info {
 	const char *filename;
diff --git a/config.c b/config.c
index 86a5eb2..647a15e 100644
--- a/config.c
+++ b/config.c
@@ -1594,6 +1594,26 @@ int git_config_get_pathname(const char *key, con=
st char **dest)
 	return ret;
 }
=20
+int git_config_get_untracked_cache(void)
+{
+	int val =3D -1;
+	const char *v;
+
+	if (!git_config_get_maybe_bool("core.untrackedcache", &val))
+		return val;
+
+	if (!git_config_get_value("core.untrackedcache", &v)) {
+		if (!strcasecmp(v, "keep"))
+			return -1;
+
+		error("unknown core.untrackedCache value '%s'; "
+		      "using 'keep' default value", v);
+		return -1;
+	}
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int =
linenr)
 {
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index ab4da7f..de4b5ed 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2056,6 +2056,7 @@ _git_config ()
 		core.sparseCheckout
 		core.symlinks
 		core.trustctime
+		core.untrackedCache
 		core.warnAmbiguousRefs
 		core.whitespace
 		core.worktree
diff --git a/read-cache.c b/read-cache.c
index 5be7cd1..a04ec8c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1497,10 +1497,23 @@ static struct cache_entry *create_from_disk(str=
uct ondisk_cache_entry *ondisk,
 	return ce;
 }
=20
-static void check_ce_order(struct index_state *istate)
+static void post_read_index_from(struct index_state *istate)
 {
 	unsigned int i;
=20
+	switch (git_config_get_untracked_cache()) {
+	case -1: /* keep: do nothing */
+		break;
+	case 0: /* false */
+		remove_untracked_cache(istate);
+		break;
+	case 1: /* true */
+		add_untracked_cache(istate);
+		break;
+	default: /* unknown value: do nothing */
+		break;
+	}
+
 	for (i =3D 1; i < istate->cache_nr; i++) {
 		struct cache_entry *ce =3D istate->cache[i - 1];
 		struct cache_entry *next_ce =3D istate->cache[i];
@@ -1622,9 +1635,10 @@ int read_index_from(struct index_state *istate, =
const char *path)
 		return istate->cache_nr;
=20
 	ret =3D do_read_index(istate, path, 0);
+
 	split_index =3D istate->split_index;
 	if (!split_index || is_null_sha1(split_index->base_sha1)) {
-		check_ce_order(istate);
+		post_read_index_from(istate);
 		return ret;
 	}
=20
@@ -1642,7 +1656,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 			     sha1_to_hex(split_index->base_sha1)),
 		    sha1_to_hex(split_index->base->sha1));
 	merge_base_index(istate);
-	check_ce_order(istate);
+	post_read_index_from(istate);
 	return ret;
 }
=20
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untrack=
ed-cache.sh
index 0e8d0d4..253160a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -8,10 +8,8 @@ avoid_racy() {
 	sleep 1
 }
=20
-# It's fine if git update-index returns an error code other than one,
-# it'll be caught in the first test.
 test_lazy_prereq UNTRACKED_CACHE '
-	{ git update-index --untracked-cache; ret=3D$?; } &&
+	{ git update-index --test-untracked-cache; ret=3D$?; } &&
 	test $ret -ne 1
 '
=20
--=20
2.7.0.181.gd7ef666.dirty
