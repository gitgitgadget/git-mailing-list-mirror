Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7C30F52B
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693735; cv=none; b=AlfZEx669M4ifEyh0pNMQvvGVNQtzRVkKh9sHlHXxba2wM2gYqtdDrkcGhzaeZWNbgeCi5Q5lwkW55tHu2m3AMEBbMcLPKBJEdTYBO0+l//z0KVV6Kf7rkeKy9pG5oXFH0rWcrXKyDvEQywO9uEPKaLXOth1swbDTXnnkNJQ+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693735; c=relaxed/simple;
	bh=HU0I8OyKAlaxXBwWS2nt2bs1y5ssCqsSmRBdmpVW8gI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jXpl4DvvbC/AIT13S40AGldJAkaYCzKspWNjaGH9Ngi6YbvB1vf1qK4uOauOwpMtwAw9FOuxpLBNYuhaBsCHdxlzJgmlAJ2boTuIxJnCih+mfnTVVqWHhPqqSou5dJfSOInQkzOAQ2QqERshFfhk0ivqzqRyREFsRJMDiMeST74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uei6mR6u; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uei6mR6u"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12732165d1eso8335714c88.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693732; x=1773298532; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzhEY1+2Ssl9srF/RjM8HwEz0xGfWsh4k1JMaLxiVTU=;
        b=Uei6mR6uG705Ehiu/RQq55zfwUMqYvVN2iHlQGW99rBI1TK9mBlG6xU6H3T8+UqoGk
         2WWB5M5A4I02ntrNl8bOYaONGxQJkBrl4UtbddoBDqRYVrHlNjiWnymgUmzj7XJXALcx
         abdHoW99g9Y6omnhfF+zQN+cEn82+rwU3rYc9EFjcSHjGZ/Me6c/aLKPsilOU/Sb+UWF
         t6dqE3JQs8yZA09VFvgFnuX11ZS57FggFFJiQm1pNYYZWbcB+XWmY0jBEXOqq+sUFCYC
         pKhezZK8F1Zo6Vs675xSYH6bMvN+noAJD5fwy4lwOfdtLUpsaZbweHlbVMsvv7PaUwIO
         HksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693732; x=1773298532;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzhEY1+2Ssl9srF/RjM8HwEz0xGfWsh4k1JMaLxiVTU=;
        b=Yh2rvKm2TW7kcgavnPla0ckOZaN7m9ZJsqgxQ0zUGP/DZUgflOItDIU9SVw7fKaC+O
         po0GlsjGSYu61PiRR09/IyEc0/5qcy6Oo1llLFmWvJOLLW8ID+fmiXLR5L7Oi7VE+8GO
         BwvNs/HzOQ82JB0Q0/fl3EAodOA7ZfFHNHTU5DaPnRibxf2xoIVnC+ASh6fJWFEVXxV2
         yq9c8jcfeoMIIJtpMjNbHEl0fpScAbTn3u7W8zN2/vdOVyBYyjcTXC3A0aU9ucRldyfL
         SC10SWnSgINUtLQcnNmXd/o20HKsNQrJ8XJQLW5MBIMqF0sawiXl+M2fKf2fC31UAx0+
         rpXQ==
X-Gm-Message-State: AOJu0YzkKmFvM0JeTjfyNcknaQ4UDufmeVF8FKjTqITKBco8e/jDH+t8
	0MGbz7kciIptsRnqJXj3D3pPTOdE5OlJ+rbTHQqs0NWVIJCmzM1HpOGWCX9Usw==
X-Gm-Gg: ATEYQzyhXi9p8/otaz+tFUaKAWwMj0VAONFtK66M+lPkpWUH89yv7zKfL2wL7A6RkuG
	LphD0tFfQFftEd+6QXVEDsW5TMtN4bPmi49Q8UsvRCrwrbjMAxaoKpXiX69UVJYUVKIPwLWpS3c
	91coPMzAx5tjCphgnbVFHIka6NHAY/INa1IaKJRdTAEQJz9VsJyqXT0B8iVhnDkh4jqh92BOYxl
	Q2sUkkZ6mEibk2l7VmgMEItiR5rPEYqO9F2tgI4Fuv6yB/ynucHCbGjFxN7cMKDaagttjE7E10l
	sYklbpSgKnrpMs3iAwvcTXQ1Dw+0I+L8MkzDMkZpYL0U2KNln05opzA6S7XZCbVRSxKvexODfna
	frVJqDUofAxGNVZrBksMqVkRs5AhEO+ppWwi7BfNW55yrsaL24GP94bj1jKMRvmGmBreuIP+/G9
	7oZEz7RDNu+UlY9c6WMGxik4yhiM9OT4U0lhp1
X-Received: by 2002:a05:7022:41a8:b0:124:a610:62f6 with SMTP id a92af1059eb24-128b7104a3fmr1899067c88.44.1772693731782;
        Wed, 04 Mar 2026 22:55:31 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df391sm24123229c88.5.2026.03.04.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:29 -0800 (PST)
Message-Id: <03cf12d01b8d75610b4c35ff412cfe6cd222a171.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:07 +0000
Subject: [PATCH v11 07/12] fsmonitor: implement filesystem change listener for
 Linux
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Implement the built-in fsmonitor daemon for Linux using the inotify
API, bringing it to feature parity with the existing Windows and macOS
implementations.

The implementation uses inotify rather than fanotify because fanotify
requires either CAP_SYS_ADMIN or CAP_PERFMON capabilities, making it
unsuitable for an unprivileged user-space daemon.  While inotify has
the limitation of requiring a separate watch on every directory (unlike
macOS's FSEvents, which can monitor an entire directory tree with a
single watch), it operates without elevated privileges and provides
the per-file event granularity needed for fsmonitor.

The listener uses inotify_init1(O_NONBLOCK) with a poll loop that
checks for events with a 50-millisecond timeout, keeping the inotify
queue well-drained to minimize the risk of overflows.  Bidirectional
hashmaps map between watch descriptors and directory paths for efficient
event resolution.  Directory renames are tracked using inotify's cookie
mechanism to correlate IN_MOVED_FROM and IN_MOVED_TO event pairs; a
periodic check detects stale renames where the matching IN_MOVED_TO
never arrived, forcing a resync.

New directory creation triggers recursive watch registration to ensure
all subdirectories are monitored.  The IN_MASK_CREATE flag is used
where available to prevent modifying existing watches, with a fallback
for older kernels.  When IN_MASK_CREATE is available and
inotify_add_watch returns EEXIST, it means another thread or recursive
scan has already registered the watch, so it is safe to ignore.

Remote filesystem detection uses statfs() to identify network-mounted
filesystems (NFS, CIFS, SMB, FUSE, etc.) via their magic numbers.
Mount point information is read from /proc/mounts and matched against
the statfs f_fsid to get accurate, human-readable filesystem type names
for logging.  When the .git directory is on a remote filesystem, the
IPC socket falls back to $HOME or a user-configured directory via the
fsmonitor.socketDir setting.

Based-on-patch-by: Eric DeCosta <edecosta@mathworks.com>
Based-on-patch-by: Marziyeh Esipreh <marziyeh.esipreh@gmail.com>
Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 Documentation/config/fsmonitor--daemon.adoc |   4 +-
 Documentation/git-fsmonitor--daemon.adoc    |  28 +-
 compat/fsmonitor/fsm-health-linux.c         |  33 +
 compat/fsmonitor/fsm-listen-linux.c         | 746 ++++++++++++++++++++
 compat/fsmonitor/fsm-path-utils-linux.c     | 217 ++++++
 config.mak.uname                            |  10 +
 contrib/buildsystems/CMakeLists.txt         |   8 +-
 meson.build                                 |   4 +
 8 files changed, 1042 insertions(+), 8 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-linux.c
 create mode 100644 compat/fsmonitor/fsm-listen-linux.c
 create mode 100644 compat/fsmonitor/fsm-path-utils-linux.c

diff --git a/Documentation/config/fsmonitor--daemon.adoc b/Documentation/config/fsmonitor--daemon.adoc
index 671f9b9462..6f8386e291 100644
--- a/Documentation/config/fsmonitor--daemon.adoc
+++ b/Documentation/config/fsmonitor--daemon.adoc
@@ -4,8 +4,8 @@ fsmonitor.allowRemote::
     behavior.  Only respected when `core.fsmonitor` is set to `true`.
 
 fsmonitor.socketDir::
-    This Mac OS-specific option, if set, specifies the directory in
+    This Mac OS and Linux-specific option, if set, specifies the directory in
     which to create the Unix domain socket used for communication
     between the fsmonitor daemon and various Git commands. The directory must
-    reside on a native Mac OS filesystem.  Only respected when `core.fsmonitor`
+    reside on a native filesystem.  Only respected when `core.fsmonitor`
     is set to `true`.
diff --git a/Documentation/git-fsmonitor--daemon.adoc b/Documentation/git-fsmonitor--daemon.adoc
index 8fe5241b08..12fa866a64 100644
--- a/Documentation/git-fsmonitor--daemon.adoc
+++ b/Documentation/git-fsmonitor--daemon.adoc
@@ -76,9 +76,9 @@ repositories; this may be overridden by setting `fsmonitor.allowRemote` to
 correctly with all network-mounted repositories, so such use is considered
 experimental.
 
-On Mac OS, the inter-process communication (IPC) between various Git
+On Mac OS and Linux, the inter-process communication (IPC) between various Git
 commands and the fsmonitor daemon is done via a Unix domain socket (UDS) -- a
-special type of file -- which is supported by native Mac OS filesystems,
+special type of file -- which is supported by native Mac OS and Linux filesystems,
 but not on network-mounted filesystems, NTFS, or FAT32.  Other filesystems
 may or may not have the needed support; the fsmonitor daemon is not guaranteed
 to work with these filesystems and such use is considered experimental.
@@ -87,13 +87,33 @@ By default, the socket is created in the `.git` directory.  However, if the
 `.git` directory is on a network-mounted filesystem, it will instead be
 created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
 network-mounted filesystem, in which case you must set the configuration
-variable `fsmonitor.socketDir` to the path of a directory on a Mac OS native
+variable `fsmonitor.socketDir` to the path of a directory on a native
 filesystem in which to create the socket file.
 
 If none of the above directories (`.git`, `$HOME`, or `fsmonitor.socketDir`)
-is on a native Mac OS file filesystem the fsmonitor daemon will report an
+is on a native filesystem the fsmonitor daemon will report an
 error that will cause the daemon and the currently running command to exit.
 
+LINUX CAVEATS
+~~~~~~~~~~~~~
+
+On Linux, the fsmonitor daemon uses inotify to monitor filesystem events.
+The inotify system has per-user limits on the number of watches that can
+be created.  The default limit is typically 8192 watches per user.
+
+For large repositories with many directories, you may need to increase
+this limit.  Check the current limit with:
+
+    cat /proc/sys/fs/inotify/max_user_watches
+
+To temporarily increase the limit:
+
+    sudo sysctl fs.inotify.max_user_watches=65536
+
+To make the change permanent, add to `/etc/sysctl.conf`:
+
+    fs.inotify.max_user_watches=65536
+
 CONFIGURATION
 -------------
 
diff --git a/compat/fsmonitor/fsm-health-linux.c b/compat/fsmonitor/fsm-health-linux.c
new file mode 100644
index 0000000000..43d67c4b8b
--- /dev/null
+++ b/compat/fsmonitor/fsm-health-linux.c
@@ -0,0 +1,33 @@
+#include "git-compat-util.h"
+#include "config.h"
+#include "fsmonitor-ll.h"
+#include "fsm-health.h"
+#include "fsmonitor--daemon.h"
+
+/*
+ * The Linux fsmonitor implementation uses inotify which has its own
+ * mechanisms for detecting filesystem unmount and other events that
+ * would require the daemon to shutdown.  Therefore, we don't need
+ * a separate health thread like Windows does.
+ *
+ * These stub functions satisfy the interface requirements.
+ */
+
+int fsm_health__ctor(struct fsmonitor_daemon_state *state UNUSED)
+{
+	return 0;
+}
+
+void fsm_health__dtor(struct fsmonitor_daemon_state *state UNUSED)
+{
+	return;
+}
+
+void fsm_health__loop(struct fsmonitor_daemon_state *state UNUSED)
+{
+	return;
+}
+
+void fsm_health__stop_async(struct fsmonitor_daemon_state *state UNUSED)
+{
+}
diff --git a/compat/fsmonitor/fsm-listen-linux.c b/compat/fsmonitor/fsm-listen-linux.c
new file mode 100644
index 0000000000..e3dca14b62
--- /dev/null
+++ b/compat/fsmonitor/fsm-listen-linux.c
@@ -0,0 +1,746 @@
+#include "git-compat-util.h"
+#include "dir.h"
+#include "fsmonitor-ll.h"
+#include "fsm-listen.h"
+#include "fsmonitor--daemon.h"
+#include "fsmonitor-path-utils.h"
+#include "gettext.h"
+#include "simple-ipc.h"
+#include "string-list.h"
+#include "trace.h"
+
+#include <sys/inotify.h>
+
+/*
+ * Safe value to bitwise OR with rest of mask for
+ * kernels that do not support IN_MASK_CREATE
+ */
+#ifndef IN_MASK_CREATE
+#define IN_MASK_CREATE 0x00000000
+#endif
+
+enum shutdown_reason {
+	SHUTDOWN_CONTINUE = 0,
+	SHUTDOWN_STOP,
+	SHUTDOWN_ERROR,
+	SHUTDOWN_FORCE
+};
+
+struct watch_entry {
+	struct hashmap_entry ent;
+	int wd;
+	uint32_t cookie;
+	const char *dir;
+};
+
+struct rename_entry {
+	struct hashmap_entry ent;
+	time_t whence;
+	uint32_t cookie;
+	const char *dir;
+};
+
+struct fsm_listen_data {
+	int fd_inotify;
+	enum shutdown_reason shutdown;
+	struct hashmap watches;
+	struct hashmap renames;
+	struct hashmap revwatches;
+};
+
+static int watch_entry_cmp(const void *cmp_data UNUSED,
+			   const struct hashmap_entry *eptr,
+			   const struct hashmap_entry *entry_or_key,
+			   const void *keydata UNUSED)
+{
+	const struct watch_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct watch_entry, ent);
+	e2 = container_of(entry_or_key, const struct watch_entry, ent);
+	return e1->wd != e2->wd;
+}
+
+static int revwatches_entry_cmp(const void *cmp_data UNUSED,
+				const struct hashmap_entry *eptr,
+				const struct hashmap_entry *entry_or_key,
+				const void *keydata UNUSED)
+{
+	const struct watch_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct watch_entry, ent);
+	e2 = container_of(entry_or_key, const struct watch_entry, ent);
+	return strcmp(e1->dir, e2->dir);
+}
+
+static int rename_entry_cmp(const void *cmp_data UNUSED,
+			    const struct hashmap_entry *eptr,
+			    const struct hashmap_entry *entry_or_key,
+			    const void *keydata UNUSED)
+{
+	const struct rename_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct rename_entry, ent);
+	e2 = container_of(entry_or_key, const struct rename_entry, ent);
+	return e1->cookie != e2->cookie;
+}
+
+/*
+ * Register an inotify watch, add watch descriptor to path mapping
+ * and the reverse mapping.
+ */
+static int add_watch(const char *path, struct fsm_listen_data *data)
+{
+	const char *interned = strintern(path);
+	struct watch_entry *w1, *w2;
+
+	/* add the inotify watch, don't allow watches to be modified */
+	int wd = inotify_add_watch(data->fd_inotify, interned,
+				   (IN_ALL_EVENTS | IN_ONLYDIR | IN_MASK_CREATE)
+				    ^ IN_ACCESS ^ IN_CLOSE ^ IN_OPEN);
+	if (wd < 0) {
+		if (errno == ENOENT || errno == ENOTDIR)
+			return 0; /* directory was deleted or is not a directory */
+		if (errno == EEXIST)
+			return 0; /* watch already exists, no action needed */
+		if (errno == ENOSPC)
+			return error(_("inotify watch limit reached; "
+				       "increase fs.inotify.max_user_watches"));
+		return error_errno(_("inotify_add_watch('%s') failed"), interned);
+	}
+
+	/* add watch descriptor -> directory mapping */
+	CALLOC_ARRAY(w1, 1);
+	w1->wd = wd;
+	w1->dir = interned;
+	hashmap_entry_init(&w1->ent, memhash(&w1->wd, sizeof(int)));
+	hashmap_add(&data->watches, &w1->ent);
+
+	/* add directory -> watch descriptor mapping */
+	CALLOC_ARRAY(w2, 1);
+	w2->wd = wd;
+	w2->dir = interned;
+	hashmap_entry_init(&w2->ent, strhash(w2->dir));
+	hashmap_add(&data->revwatches, &w2->ent);
+
+	return 0;
+}
+
+/*
+ * Remove the inotify watch, the watch descriptor to path mapping
+ * and the reverse mapping.
+ */
+static void remove_watch(struct watch_entry *w, struct fsm_listen_data *data)
+{
+	struct watch_entry k1, k2, *w1, *w2;
+
+	/* remove watch, ignore error if kernel already did it */
+	if (inotify_rm_watch(data->fd_inotify, w->wd) && errno != EINVAL)
+		error_errno(_("inotify_rm_watch() failed"));
+
+	k1.wd = w->wd;
+	hashmap_entry_init(&k1.ent, memhash(&k1.wd, sizeof(int)));
+	w1 = hashmap_remove_entry(&data->watches, &k1, ent, NULL);
+	if (!w1)
+		BUG("double remove of watch for '%s'", w->dir);
+
+	if (w1->cookie)
+		BUG("removing watch for '%s' which has a pending rename", w1->dir);
+
+	k2.dir = w->dir;
+	hashmap_entry_init(&k2.ent, strhash(k2.dir));
+	w2 = hashmap_remove_entry(&data->revwatches, &k2, ent, NULL);
+	if (!w2)
+		BUG("double remove of reverse watch for '%s'", w->dir);
+
+	/* w1->dir and w2->dir are interned strings, we don't own them */
+	free(w1);
+	free(w2);
+}
+
+/*
+ * Check for stale directory renames.
+ *
+ * https://man7.org/linux/man-pages/man7/inotify.7.html
+ *
+ * Allow for some small timeout to account for the fact that insertion of the
+ * IN_MOVED_FROM+IN_MOVED_TO event pair is not atomic, and the possibility that
+ * there may not be any IN_MOVED_TO event.
+ *
+ * If the IN_MOVED_TO event is not received within the timeout then events have
+ * been missed and the monitor is in an inconsistent state with respect to the
+ * filesystem.
+ */
+static int check_stale_dir_renames(struct hashmap *renames, time_t max_age)
+{
+	struct rename_entry *re;
+	struct hashmap_iter iter;
+
+	hashmap_for_each_entry(renames, &iter, re, ent) {
+		if (re->whence <= max_age)
+			return -1;
+	}
+	return 0;
+}
+
+/*
+ * Track pending renames.
+ *
+ * Tracking is done via an event cookie to watch descriptor mapping.
+ *
+ * A rename is not complete until matching an IN_MOVED_TO event is received
+ * for a corresponding IN_MOVED_FROM event.
+ */
+static void add_dir_rename(uint32_t cookie, const char *path,
+			   struct fsm_listen_data *data)
+{
+	struct watch_entry k, *w;
+	struct rename_entry *re;
+
+	/* lookup the watch descriptor for the given path */
+	k.dir = path;
+	hashmap_entry_init(&k.ent, strhash(path));
+	w = hashmap_get_entry(&data->revwatches, &k, ent, NULL);
+	if (!w) {
+		/*
+		 * This can happen in rare cases where the directory was
+		 * moved before we had a chance to add a watch on it.
+		 * Just ignore this rename.
+		 */
+		trace_printf_key(&trace_fsmonitor,
+				 "no watch found for rename from '%s'", path);
+		return;
+	}
+	w->cookie = cookie;
+
+	/* add the pending rename to match against later */
+	CALLOC_ARRAY(re, 1);
+	re->dir = w->dir;
+	re->cookie = w->cookie;
+	re->whence = time(NULL);
+	hashmap_entry_init(&re->ent, memhash(&re->cookie, sizeof(uint32_t)));
+	hashmap_add(&data->renames, &re->ent);
+}
+
+/*
+ * Handle directory renames
+ *
+ * Once an IN_MOVED_TO event is received, lookup the rename tracking information
+ * via the event cookie and use this information to update the watch.
+ */
+static void rename_dir(uint32_t cookie, const char *path,
+		       struct fsm_listen_data *data)
+{
+	struct rename_entry rek, *re;
+	struct watch_entry k, *w;
+
+	/* lookup a pending rename to match */
+	rek.cookie = cookie;
+	hashmap_entry_init(&rek.ent, memhash(&rek.cookie, sizeof(uint32_t)));
+	re = hashmap_get_entry(&data->renames, &rek, ent, NULL);
+	if (re) {
+		k.dir = re->dir;
+		hashmap_entry_init(&k.ent, strhash(k.dir));
+		w = hashmap_get_entry(&data->revwatches, &k, ent, NULL);
+		if (w) {
+			w->cookie = 0; /* rename handled */
+			remove_watch(w, data);
+			if (add_watch(path, data))
+				trace_printf_key(&trace_fsmonitor,
+						 "failed to add watch for renamed dir '%s'",
+						 path);
+		} else {
+			/* Directory was moved out of watch tree */
+			trace_printf_key(&trace_fsmonitor,
+					 "no matching watch for rename to '%s'", path);
+		}
+		hashmap_remove_entry(&data->renames, &rek, ent, NULL);
+		free(re);
+	} else {
+		/* Directory was moved from outside the watch tree */
+		trace_printf_key(&trace_fsmonitor,
+				 "no matching cookie for rename to '%s'", path);
+	}
+}
+
+/*
+ * Recursively add watches to every directory under path
+ */
+static int register_inotify(const char *path,
+			    struct fsmonitor_daemon_state *state,
+			    struct fsmonitor_batch *batch)
+{
+	DIR *dir;
+	const char *rel;
+	struct strbuf current = STRBUF_INIT;
+	struct dirent *de;
+	struct stat fs;
+	int ret = -1;
+
+	dir = opendir(path);
+	if (!dir) {
+		if (errno == ENOENT || errno == ENOTDIR)
+			return 0; /* directory was deleted */
+		return error_errno(_("opendir('%s') failed"), path);
+	}
+
+	while ((de = readdir_skip_dot_and_dotdot(dir)) != NULL) {
+		strbuf_reset(&current);
+		strbuf_addf(&current, "%s/%s", path, de->d_name);
+		if (lstat(current.buf, &fs)) {
+			if (errno == ENOENT)
+				continue; /* file was deleted */
+			error_errno(_("lstat('%s') failed"), current.buf);
+			goto failed;
+		}
+
+		/* recurse into directory */
+		if (S_ISDIR(fs.st_mode)) {
+			if (add_watch(current.buf, state->listen_data))
+				goto failed;
+			if (register_inotify(current.buf, state, batch))
+				goto failed;
+		} else if (batch) {
+			rel = current.buf + state->path_worktree_watch.len + 1;
+			trace_printf_key(&trace_fsmonitor, "explicitly adding '%s'", rel);
+			fsmonitor_batch__add_path(batch, rel);
+		}
+	}
+	ret = 0;
+
+failed:
+	strbuf_release(&current);
+	if (closedir(dir) < 0)
+		return error_errno(_("closedir('%s') failed"), path);
+	return ret;
+}
+
+static int em_rename_dir_from(uint32_t mask)
+{
+	return ((mask & IN_ISDIR) && (mask & IN_MOVED_FROM));
+}
+
+static int em_rename_dir_to(uint32_t mask)
+{
+	return ((mask & IN_ISDIR) && (mask & IN_MOVED_TO));
+}
+
+static int em_remove_watch(uint32_t mask)
+{
+	return (mask & IN_DELETE_SELF);
+}
+
+static int em_dir_renamed(uint32_t mask)
+{
+	return ((mask & IN_ISDIR) && (mask & IN_MOVE));
+}
+
+static int em_dir_created(uint32_t mask)
+{
+	return ((mask & IN_ISDIR) && (mask & IN_CREATE));
+}
+
+static int em_dir_deleted(uint32_t mask)
+{
+	return ((mask & IN_ISDIR) && (mask & IN_DELETE));
+}
+
+static int em_force_shutdown(uint32_t mask)
+{
+	return (mask & IN_UNMOUNT) || (mask & IN_Q_OVERFLOW);
+}
+
+static int em_ignore(uint32_t mask)
+{
+	return (mask & IN_IGNORED) || (mask & IN_MOVE_SELF);
+}
+
+static void log_mask_set(const char *path, uint32_t mask)
+{
+	struct strbuf msg = STRBUF_INIT;
+
+	if (mask & IN_ACCESS)
+		strbuf_addstr(&msg, "IN_ACCESS|");
+	if (mask & IN_MODIFY)
+		strbuf_addstr(&msg, "IN_MODIFY|");
+	if (mask & IN_ATTRIB)
+		strbuf_addstr(&msg, "IN_ATTRIB|");
+	if (mask & IN_CLOSE_WRITE)
+		strbuf_addstr(&msg, "IN_CLOSE_WRITE|");
+	if (mask & IN_CLOSE_NOWRITE)
+		strbuf_addstr(&msg, "IN_CLOSE_NOWRITE|");
+	if (mask & IN_OPEN)
+		strbuf_addstr(&msg, "IN_OPEN|");
+	if (mask & IN_MOVED_FROM)
+		strbuf_addstr(&msg, "IN_MOVED_FROM|");
+	if (mask & IN_MOVED_TO)
+		strbuf_addstr(&msg, "IN_MOVED_TO|");
+	if (mask & IN_CREATE)
+		strbuf_addstr(&msg, "IN_CREATE|");
+	if (mask & IN_DELETE)
+		strbuf_addstr(&msg, "IN_DELETE|");
+	if (mask & IN_DELETE_SELF)
+		strbuf_addstr(&msg, "IN_DELETE_SELF|");
+	if (mask & IN_MOVE_SELF)
+		strbuf_addstr(&msg, "IN_MOVE_SELF|");
+	if (mask & IN_UNMOUNT)
+		strbuf_addstr(&msg, "IN_UNMOUNT|");
+	if (mask & IN_Q_OVERFLOW)
+		strbuf_addstr(&msg, "IN_Q_OVERFLOW|");
+	if (mask & IN_IGNORED)
+		strbuf_addstr(&msg, "IN_IGNORED|");
+	if (mask & IN_ISDIR)
+		strbuf_addstr(&msg, "IN_ISDIR|");
+
+	strbuf_strip_suffix(&msg, "|");
+
+	trace_printf_key(&trace_fsmonitor, "inotify_event: '%s', mask=%#8.8x %s",
+			 path, mask, msg.buf);
+
+	strbuf_release(&msg);
+}
+
+int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
+{
+	int fd;
+	int ret = 0;
+	struct fsm_listen_data *data;
+
+	CALLOC_ARRAY(data, 1);
+	state->listen_data = data;
+	state->listen_error_code = -1;
+	data->fd_inotify = -1;
+	data->shutdown = SHUTDOWN_ERROR;
+
+	fd = inotify_init1(O_NONBLOCK);
+	if (fd < 0) {
+		FREE_AND_NULL(state->listen_data);
+		return error_errno(_("inotify_init1() failed"));
+	}
+
+	data->fd_inotify = fd;
+
+	hashmap_init(&data->watches, watch_entry_cmp, NULL, 0);
+	hashmap_init(&data->renames, rename_entry_cmp, NULL, 0);
+	hashmap_init(&data->revwatches, revwatches_entry_cmp, NULL, 0);
+
+	if (add_watch(state->path_worktree_watch.buf, data))
+		ret = -1;
+	else if (register_inotify(state->path_worktree_watch.buf, state, NULL))
+		ret = -1;
+	else if (state->nr_paths_watching > 1) {
+		if (add_watch(state->path_gitdir_watch.buf, data))
+			ret = -1;
+		else if (register_inotify(state->path_gitdir_watch.buf, state, NULL))
+			ret = -1;
+	}
+
+	if (!ret) {
+		state->listen_error_code = 0;
+		data->shutdown = SHUTDOWN_CONTINUE;
+	}
+
+	return ret;
+}
+
+void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
+{
+	struct fsm_listen_data *data;
+	struct hashmap_iter iter;
+	struct watch_entry *w;
+	struct watch_entry **to_remove;
+	size_t nr_to_remove = 0, alloc_to_remove = 0;
+	size_t i;
+	int fd;
+
+	if (!state || !state->listen_data)
+		return;
+
+	data = state->listen_data;
+	fd = data->fd_inotify;
+
+	/*
+	 * Collect all entries first, then remove them.
+	 * We can't modify the hashmap while iterating over it.
+	 */
+	to_remove = NULL;
+	hashmap_for_each_entry(&data->watches, &iter, w, ent) {
+		ALLOC_GROW(to_remove, nr_to_remove + 1, alloc_to_remove);
+		to_remove[nr_to_remove++] = w;
+	}
+
+	for (i = 0; i < nr_to_remove; i++) {
+		to_remove[i]->cookie = 0; /* ignore any pending renames */
+		remove_watch(to_remove[i], data);
+	}
+	free(to_remove);
+
+	hashmap_clear(&data->watches);
+
+	hashmap_clear(&data->revwatches); /* remove_watch freed the entries */
+
+	hashmap_clear_and_free(&data->renames, struct rename_entry, ent);
+
+	FREE_AND_NULL(state->listen_data);
+
+	if (fd >= 0 && (close(fd) < 0))
+		error_errno(_("closing inotify file descriptor failed"));
+}
+
+void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
+{
+	if (state && state->listen_data &&
+	    state->listen_data->shutdown == SHUTDOWN_CONTINUE)
+		state->listen_data->shutdown = SHUTDOWN_STOP;
+}
+
+/*
+ * Process a single inotify event and queue for publication.
+ */
+static int process_event(const char *path,
+			 const struct inotify_event *event,
+			 struct fsmonitor_batch **batch,
+			 struct string_list *cookie_list,
+			 struct fsmonitor_daemon_state *state)
+{
+	const char *rel;
+	const char *last_sep;
+
+	switch (fsmonitor_classify_path_absolute(state, path)) {
+	case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
+	case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
+		/* Use just the filename of the cookie file. */
+		last_sep = find_last_dir_sep(path);
+		string_list_append(cookie_list,
+				   last_sep ? last_sep + 1 : path);
+		break;
+	case IS_INSIDE_DOT_GIT:
+	case IS_INSIDE_GITDIR:
+		break;
+	case IS_DOT_GIT:
+	case IS_GITDIR:
+		/*
+		 * If .git directory is deleted or renamed away,
+		 * we have to quit.
+		 */
+		if (em_dir_deleted(event->mask)) {
+			trace_printf_key(&trace_fsmonitor,
+					 "event: gitdir removed");
+			state->listen_data->shutdown = SHUTDOWN_FORCE;
+			goto done;
+		}
+
+		if (em_dir_renamed(event->mask)) {
+			trace_printf_key(&trace_fsmonitor,
+					 "event: gitdir renamed");
+			state->listen_data->shutdown = SHUTDOWN_FORCE;
+			goto done;
+		}
+		break;
+	case IS_WORKDIR_PATH:
+		/* normal events in the working directory */
+		if (trace_pass_fl(&trace_fsmonitor))
+			log_mask_set(path, event->mask);
+
+		if (!*batch)
+			*batch = fsmonitor_batch__new();
+
+		rel = path + state->path_worktree_watch.len + 1;
+		fsmonitor_batch__add_path(*batch, rel);
+
+		if (em_dir_deleted(event->mask))
+			break;
+
+		/* received IN_MOVE_FROM, add tracking for expected IN_MOVE_TO */
+		if (em_rename_dir_from(event->mask))
+			add_dir_rename(event->cookie, path, state->listen_data);
+
+		/* received IN_MOVE_TO, update watch to reflect new path */
+		if (em_rename_dir_to(event->mask)) {
+			rename_dir(event->cookie, path, state->listen_data);
+			if (register_inotify(path, state, *batch)) {
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				goto done;
+			}
+		}
+
+		if (em_dir_created(event->mask)) {
+			if (add_watch(path, state->listen_data)) {
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				goto done;
+			}
+			if (register_inotify(path, state, *batch)) {
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				goto done;
+			}
+		}
+		break;
+	case IS_OUTSIDE_CONE:
+	default:
+		trace_printf_key(&trace_fsmonitor,
+				 "ignoring '%s'", path);
+		break;
+	}
+	return 0;
+done:
+	return -1;
+}
+
+/*
+ * Read the inotify event stream and pre-process events before further
+ * processing and eventual publishing.
+ */
+static void handle_events(struct fsmonitor_daemon_state *state)
+{
+	/* See https://man7.org/linux/man-pages/man7/inotify.7.html */
+	char buf[4096]
+		__attribute__ ((aligned(__alignof__(struct inotify_event))));
+
+	struct hashmap *watches = &state->listen_data->watches;
+	struct fsmonitor_batch *batch = NULL;
+	struct string_list cookie_list = STRING_LIST_INIT_DUP;
+	struct watch_entry k, *w;
+	struct strbuf path = STRBUF_INIT;
+	const struct inotify_event *event;
+	int fd = state->listen_data->fd_inotify;
+	ssize_t len;
+	char *ptr, *p;
+
+	for (;;) {
+		len = read(fd, buf, sizeof(buf));
+		if (len == -1) {
+			if (errno == EAGAIN || errno == EINTR)
+				goto done;
+			error_errno(_("reading inotify message stream failed"));
+			state->listen_data->shutdown = SHUTDOWN_ERROR;
+			goto done;
+		}
+
+		/* nothing to read */
+		if (len == 0)
+			goto done;
+
+		/* Loop over all events in the buffer. */
+		for (ptr = buf; ptr < buf + len;
+		     ptr += sizeof(struct inotify_event) + event->len) {
+
+			event = (const struct inotify_event *)ptr;
+
+			if (em_ignore(event->mask))
+				continue;
+
+			/* File system was unmounted or event queue overflowed */
+			if (em_force_shutdown(event->mask)) {
+				if (trace_pass_fl(&trace_fsmonitor))
+					log_mask_set("forcing shutdown", event->mask);
+				state->listen_data->shutdown = SHUTDOWN_FORCE;
+				goto done;
+			}
+
+			k.wd = event->wd;
+			hashmap_entry_init(&k.ent, memhash(&k.wd, sizeof(int)));
+
+			w = hashmap_get_entry(watches, &k, ent, NULL);
+			if (!w) {
+				/* Watch was removed, skip event */
+				continue;
+			}
+
+			/* directory watch was removed */
+			if (em_remove_watch(event->mask)) {
+				remove_watch(w, state->listen_data);
+				continue;
+			}
+
+			strbuf_reset(&path);
+			strbuf_addf(&path, "%s/%s", w->dir, event->name);
+
+			p = fsmonitor__resolve_alias(path.buf, &state->alias);
+			if (!p)
+				p = strbuf_detach(&path, NULL);
+
+			if (process_event(p, event, &batch, &cookie_list, state)) {
+				free(p);
+				goto done;
+			}
+			free(p);
+		}
+		strbuf_reset(&path);
+		fsmonitor_publish(state, batch, &cookie_list);
+		string_list_clear(&cookie_list, 0);
+		batch = NULL;
+	}
+done:
+	strbuf_release(&path);
+	fsmonitor_batch__free_list(batch);
+	string_list_clear(&cookie_list, 0);
+}
+
+/*
+ * Non-blocking read of the inotify events stream. The inotify fd is polled
+ * frequently to help minimize the number of queue overflows.
+ */
+void fsm_listen__loop(struct fsmonitor_daemon_state *state)
+{
+	int poll_num;
+	/*
+	 * Interval in seconds between checks for stale directory renames.
+	 * A directory rename that is not completed within this window
+	 * (i.e. no matching IN_MOVED_TO for an IN_MOVED_FROM) indicates
+	 * missed events, forcing a shutdown.
+	 */
+	const int interval = 1;
+	time_t checked = time(NULL);
+	struct pollfd fds[1];
+
+	fds[0].fd = state->listen_data->fd_inotify;
+	fds[0].events = POLLIN;
+
+	/*
+	 * Our fs event listener is now running, so it's safe to start
+	 * serving client requests.
+	 */
+	ipc_server_start_async(state->ipc_server_data);
+
+	for (;;) {
+		switch (state->listen_data->shutdown) {
+		case SHUTDOWN_CONTINUE:
+			poll_num = poll(fds, 1, 50);
+			if (poll_num == -1) {
+				if (errno == EINTR)
+					continue;
+				error_errno(_("polling inotify message stream failed"));
+				state->listen_data->shutdown = SHUTDOWN_ERROR;
+				continue;
+			}
+
+			if ((time(NULL) - checked) >= interval) {
+				checked = time(NULL);
+				if (check_stale_dir_renames(&state->listen_data->renames,
+							    checked - interval)) {
+					trace_printf_key(&trace_fsmonitor,
+							 "missed IN_MOVED_TO events, forcing shutdown");
+					state->listen_data->shutdown = SHUTDOWN_FORCE;
+					continue;
+				}
+			}
+
+			if (poll_num > 0 && (fds[0].revents & POLLIN))
+				handle_events(state);
+
+			continue;
+		case SHUTDOWN_ERROR:
+			state->listen_error_code = -1;
+			ipc_server_stop_async(state->ipc_server_data);
+			break;
+		case SHUTDOWN_FORCE:
+			state->listen_error_code = 0;
+			ipc_server_stop_async(state->ipc_server_data);
+			break;
+		case SHUTDOWN_STOP:
+		default:
+			state->listen_error_code = 0;
+			break;
+		}
+		return;
+	}
+}
diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
new file mode 100644
index 0000000000..c9866b1b24
--- /dev/null
+++ b/compat/fsmonitor/fsm-path-utils-linux.c
@@ -0,0 +1,217 @@
+#include "git-compat-util.h"
+#include "fsmonitor-ll.h"
+#include "fsmonitor-path-utils.h"
+#include "gettext.h"
+#include "trace.h"
+
+#include <sys/statfs.h>
+
+#ifdef HAVE_LINUX_MAGIC_H
+#include <linux/magic.h>
+#endif
+
+/*
+ * Filesystem magic numbers for remote filesystems.
+ * Defined here if not available in linux/magic.h.
+ */
+#ifndef CIFS_SUPER_MAGIC
+#define CIFS_SUPER_MAGIC 0xff534d42
+#endif
+#ifndef SMB_SUPER_MAGIC
+#define SMB_SUPER_MAGIC 0x517b
+#endif
+#ifndef SMB2_SUPER_MAGIC
+#define SMB2_SUPER_MAGIC 0xfe534d42
+#endif
+#ifndef NFS_SUPER_MAGIC
+#define NFS_SUPER_MAGIC 0x6969
+#endif
+#ifndef AFS_SUPER_MAGIC
+#define AFS_SUPER_MAGIC 0x5346414f
+#endif
+#ifndef CODA_SUPER_MAGIC
+#define CODA_SUPER_MAGIC 0x73757245
+#endif
+#ifndef FUSE_SUPER_MAGIC
+#define FUSE_SUPER_MAGIC 0x65735546
+#endif
+
+/*
+ * Check if filesystem type is a remote filesystem.
+ */
+static int is_remote_fs(unsigned long f_type)
+{
+	switch (f_type) {
+	case CIFS_SUPER_MAGIC:
+	case SMB_SUPER_MAGIC:
+	case SMB2_SUPER_MAGIC:
+	case NFS_SUPER_MAGIC:
+	case AFS_SUPER_MAGIC:
+	case CODA_SUPER_MAGIC:
+	case FUSE_SUPER_MAGIC:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+/*
+ * Map filesystem magic numbers to human-readable names as a fallback
+ * when /proc/mounts is unavailable.  This only covers the remote and
+ * special filesystems in is_remote_fs() above; local filesystems are
+ * never flagged as incompatible, so we do not need their names here.
+ */
+static const char *get_fs_typename(unsigned long f_type)
+{
+	switch (f_type) {
+	case CIFS_SUPER_MAGIC:
+		return "cifs";
+	case SMB_SUPER_MAGIC:
+		return "smb";
+	case SMB2_SUPER_MAGIC:
+		return "smb2";
+	case NFS_SUPER_MAGIC:
+		return "nfs";
+	case AFS_SUPER_MAGIC:
+		return "afs";
+	case CODA_SUPER_MAGIC:
+		return "coda";
+	case FUSE_SUPER_MAGIC:
+		return "fuse";
+	default:
+		return "unknown";
+	}
+}
+
+/*
+ * Find the mount point for a given path by reading /proc/mounts.
+ *
+ * statfs(2) gives us f_type (the magic number) but not the human-readable
+ * filesystem type string.  We scan /proc/mounts to find the mount entry
+ * whose path is the longest prefix of ours and whose f_fsid matches,
+ * which gives us the fstype string (e.g. "nfs", "ext4") for logging.
+ */
+static char *find_mount(const char *path, const struct statfs *path_fs)
+{
+	FILE *fp;
+	struct strbuf line = STRBUF_INIT;
+	struct strbuf match = STRBUF_INIT;
+	struct strbuf fstype = STRBUF_INIT;
+	char *result = NULL;
+
+	fp = fopen("/proc/mounts", "r");
+	if (!fp)
+		return NULL;
+
+	while (strbuf_getline(&line, fp) != EOF) {
+		char *fields[6];
+		char *p = line.buf;
+		int i;
+
+		/* Parse mount entry: device mountpoint fstype options dump pass */
+		for (i = 0; i < 6 && p; i++) {
+			fields[i] = p;
+			p = strchr(p, ' ');
+			if (p)
+				*p++ = '\0';
+		}
+
+		if (i >= 3) {
+			const char *mountpoint = fields[1];
+			const char *type = fields[2];
+			struct statfs mount_fs;
+
+			/* Check if this mount point is a prefix of our path */
+			if (starts_with(path, mountpoint) &&
+			    (path[strlen(mountpoint)] == '/' ||
+			     path[strlen(mountpoint)] == '\0')) {
+				/* Check if filesystem ID matches */
+				if (statfs(mountpoint, &mount_fs) == 0 &&
+				    !memcmp(&mount_fs.f_fsid, &path_fs->f_fsid,
+					    sizeof(mount_fs.f_fsid))) {
+					/* Keep the longest matching mount point */
+					if (strlen(mountpoint) > match.len) {
+						strbuf_reset(&match);
+						strbuf_addstr(&match, mountpoint);
+						strbuf_reset(&fstype);
+						strbuf_addstr(&fstype, type);
+					}
+				}
+			}
+		}
+	}
+
+	fclose(fp);
+	strbuf_release(&line);
+	strbuf_release(&match);
+
+	if (fstype.len)
+		result = strbuf_detach(&fstype, NULL);
+	else
+		strbuf_release(&fstype);
+
+	return result;
+}
+
+int fsmonitor__get_fs_info(const char *path, struct fs_info *fs_info)
+{
+	struct statfs fs;
+
+	if (statfs(path, &fs) == -1) {
+		int saved_errno = errno;
+		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
+				 path, strerror(saved_errno));
+		errno = saved_errno;
+		return -1;
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "statfs('%s') [type 0x%08lx]",
+			 path, (unsigned long)fs.f_type);
+
+	fs_info->is_remote = is_remote_fs(fs.f_type);
+
+	/*
+	 * Try to get filesystem type from /proc/mounts for a more
+	 * descriptive name.
+	 */
+	fs_info->typename = find_mount(path, &fs);
+	if (!fs_info->typename)
+		fs_info->typename = xstrdup(get_fs_typename(fs.f_type));
+
+	trace_printf_key(&trace_fsmonitor,
+			 "'%s' is_remote: %d, typename: %s",
+			 path, fs_info->is_remote, fs_info->typename);
+
+	return 0;
+}
+
+int fsmonitor__is_fs_remote(const char *path)
+{
+	struct fs_info fs;
+
+	if (fsmonitor__get_fs_info(path, &fs))
+		return -1;
+
+	free(fs.typename);
+
+	return fs.is_remote;
+}
+
+/*
+ * No-op for Linux - we don't have firmlinks like macOS.
+ */
+int fsmonitor__get_alias(const char *path UNUSED,
+			 struct alias_info *info UNUSED)
+{
+	return 0;
+}
+
+/*
+ * No-op for Linux - we don't have firmlinks like macOS.
+ */
+char *fsmonitor__resolve_alias(const char *path UNUSED,
+			       const struct alias_info *info UNUSED)
+{
+	return NULL;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 33877020e9..638f7e1bde 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -68,6 +68,16 @@ ifeq ($(uname_S),Linux)
 		BASIC_CFLAGS += -std=c99
         endif
 	LINK_FUZZ_PROGRAMS = YesPlease
+
+	# The builtin FSMonitor on Linux builds upon Simple-IPC.  Both require
+	# Unix domain sockets and PThreads.
+        ifndef NO_PTHREADS
+        ifndef NO_UNIX_SOCKETS
+	FSMONITOR_DAEMON_BACKEND = linux
+	FSMONITOR_OS_SETTINGS = unix
+	BASIC_CFLAGS += -DHAVE_LINUX_MAGIC_H
+        endif
+        endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index d613809e26..b7da108f29 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -296,6 +296,10 @@ if(SUPPORTS_SIMPLE_IPC)
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
 		set(FSMONITOR_DAEMON_BACKEND "darwin")
 		set(FSMONITOR_OS_SETTINGS "unix")
+	elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
+		set(FSMONITOR_DAEMON_BACKEND "linux")
+		set(FSMONITOR_OS_SETTINGS "unix")
+		add_compile_definitions(HAVE_LINUX_MAGIC_H)
 	endif()
 
 	if(FSMONITOR_DAEMON_BACKEND)
@@ -1149,8 +1153,8 @@ endif()
 file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-BUILD-OPTIONS.in git_build_options NEWLINE_CONSUME)
 string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
 string(REPLACE "@DIFF@" "'${DIFF}'" git_build_options "${git_build_options}")
-string(REPLACE "@FSMONITOR_DAEMON_BACKEND@" "win32" git_build_options "${git_build_options}")
-string(REPLACE "@FSMONITOR_OS_SETTINGS@" "win32" git_build_options "${git_build_options}")
+string(REPLACE "@FSMONITOR_DAEMON_BACKEND@" "${FSMONITOR_DAEMON_BACKEND}" git_build_options "${git_build_options}")
+string(REPLACE "@FSMONITOR_OS_SETTINGS@" "${FSMONITOR_OS_SETTINGS}" git_build_options "${git_build_options}")
 string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_options}")
 string(REPLACE "@GIT_PERF_LARGE_REPO@" "" git_build_options "${git_build_options}")
diff --git a/meson.build b/meson.build
index 4f0c0a33b8..123d218460 100644
--- a/meson.build
+++ b/meson.build
@@ -1324,6 +1324,10 @@ fsmonitor_os = ''
 if host_machine.system() == 'windows'
   fsmonitor_backend = 'win32'
   fsmonitor_os = 'win32'
+elif host_machine.system() == 'linux' and threads.found() and compiler.has_header('linux/magic.h')
+  fsmonitor_backend = 'linux'
+  fsmonitor_os = 'unix'
+  libgit_c_args += '-DHAVE_LINUX_MAGIC_H'
 elif host_machine.system() == 'darwin'
   fsmonitor_backend = 'darwin'
   fsmonitor_os = 'unix'
-- 
gitgitgadget

