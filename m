Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923D2D979F
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999710; cv=none; b=h2IQy6do52PHcWgNS3Q6vptUkzi6ceEphpe5FUJ0d2IDIgcAbZPAZPNEXhgPtwIOaz+7TbliFAthhbO9BnURBU/axD5Vffj8JnL7O9CV+JN3XbNAC9SGmJGg26l6YjAIUznh/VAoSaUVLy7V9Dv0N2lQBMS2w2RgaEKyGkxF02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999710; c=relaxed/simple;
	bh=HTlnRNECngXFaDEJ9bqTcmal/6xAfwk8Fl6qQI7x+R8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CN3GPEvz/mJJGMPjwOFLsPWTvttQVBn0NUqlVaERD191PRi1ZbhVgvpFZzo7VpHuS0V/izeD9DIXkPJiVWTDugHOiL9QUY/KU7Z05y/zoes6pvMazGL+MgWWcM41Xr5wGSrtjKii6qGj7szbv8M7f+xDyzfkufvBVJ4hFyg+uuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQfSDpw1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQfSDpw1"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87c21c5d3eeso69919476d6.2
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999704; x=1761604504; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7IGkPy5Pqshma4hCM5A0WkucYYkS6LWSfiUYX3gsWcY=;
        b=KQfSDpw1Vv0BblJUnTT4a/aUeQy/OFKZsNMe3RnVWIX3pVZEiKzL10sGKyQzWmCYJy
         nA9Ei5z7jXmjGytoHXBIg7Fgp2+w9hLn+jsHdM+xy2Vba5Eqa0hgy/8fVRqNZa97RRIz
         FoEpWZn+rQpS+ON4/d+glrm0eywUGrBUMdxPxUSOVvUtd1NHtBExSxuqnbLNj7oOVFGn
         uu0ZOzt6WLtBKLmhUalOPe+6ys0I7StTdYHYgyDvQg3KpEW7zNmeIWoVSIZAjEajhliN
         0VvzMaeJgrUMvxlj91YQ8dSsxS5IRKC91o3IGUfPbR3iNDj5ioQ2yvTrVSP1Jb35b6UF
         82AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999704; x=1761604504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IGkPy5Pqshma4hCM5A0WkucYYkS6LWSfiUYX3gsWcY=;
        b=SSMALMb/BRG5UuW27+kUrEpUG8JeEM6UCglGzOL08sqtHBylzVgdcjkoDrA7ocinNM
         00/BaUQOJUREr5vKRgaYgWovhSxNrIy3jS9vXpmM6jeZkk8ulfmIwTgsm+V9kVVHBBWq
         XUTVVPk0mncueB/rV1BjqYIW+15qwy8RNNo0Qtgr3V8Lw/RvBrkRUtSWVut4ZmI4RJmt
         zVJQ9B+csXRsANpiF4po8u5EbcdWkMnxUUDn9EKzxfPnod6HpNQnb9CmlqZ+VqXnbYwg
         dWKbN3AB57Py423LKnqAuy1/LloO1NMy0j9/SKHt4WCssqHUoparUNajtNAj8C5AnjT5
         IKmA==
X-Gm-Message-State: AOJu0YzCvqEtsWa3xsbScqkffgJGErgkT0RLgkcwCe5wvF5bmstbmvxL
	3bcbJsEVCqqIy8fVwMPIRfjkOYpcmm3TlmETLcpFXR5zeFK5uo0r9b2L9SRyD926
X-Gm-Gg: ASbGncsFaTE7mvXHBxbtl4Y/LJq/qZSgUuzxsS3BK2r6U0ULZbYeNxlWSyOx5Eh/hT7
	h9urJDb6VgnTVbrrhx9ERjaykqS7DIDnxglPS0bHqq5nxEy9SQad5inkkKCHrayDxwU43Ju3Yty
	nFk8+2nklxrAO5qAf6FbULFAS70aIlNvv2qN8PQm8b8usHs+1DjkkuLHN0vlcqGBMhfHMWpd3Vt
	grwmTvtiGu1F0OzA9dxwZA0nuwlNx0FBeJ/D5StUlSPpwe2kwJ8XoZzwWbWuLTt+E5UCVJk+SOQ
	kUZItnGOEJ8LavxRdto9pHU1mPbk6GDEGFqYZLHhkA8LRoRLMPF7XdCpzg81kUK+DAsJOLQgOdI
	Z5OJGxYGcSSNeSKDnbiCIY+4+hYv0wl3c1VcLsx+GO/H1QdMQfAIVNo1QIWpfQ0Cwl6+qSpxw6b
	248a8xLn51ExqQfR4=
X-Google-Smtp-Source: AGHT+IG/4dbb0eYoucVgYaChsIqUaZ9TypTpffaKWap7qiGhUtQYMy8HV66aIKIxdZBvvQhjUpzv2w==
X-Received: by 2002:a05:6214:e66:b0:7ec:6871:d0a3 with SMTP id 6a1803df08f44-87c2070f4b8mr163946766d6.11.1760999704383;
        Mon, 20 Oct 2025 15:35:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.209.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf5237273sm59029776d6.26.2025.10.20.15.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:35:03 -0700 (PDT)
Message-Id: <pull.1993.git.1760999702581.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Oct 2025 22:35:02 +0000
Subject: [PATCH] macOS: queue for munmap operations
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
Cc: Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

Executing many mmap/munmap calls alternately can cause a huge load on
macOS. In order to reduce it, we should temporarily store munmap
operations in a queue and process them all at once when the queue is
filled. When the program terminates, we can discard any remaining munmap
operations as corresponding mmaped regions are automatically reclaimed.

Add a queue for munmap operations to perform them all at once.

Here are some example timings. On the Linux kernel repository that
requires about 1700 mmap/munmap calls:

  time git ls-tree -r -l --full-tree 211ddde > /dev/null

  Before:
        real    0m2.083s
        user    0m0.201s
        sys     0m1.873s

  After:
        real    0m0.243s
        user    0m0.179s
        sys     0m0.052s

On a private repository that requires about 943000 mmap/munmap calls:

  time git ls-tree -r -l --full-tree xxxxxxx > /dev/null

  Before:
        real    27m15.138s
        user    0m5.084s
        sys     27m9.636s

  After:
        real    0m24.209s
        user    0m3.055s
        sys     0m21.123s

Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    macOS: queue for munmap operations

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1993%2FKojiNakamaru%2Ffeature%2Fosx-queued-munmap-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1993/KojiNakamaru/feature/osx-queued-munmap-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1993

 Makefile                            |  1 +
 compat/osxmmap.c                    | 49 +++++++++++++++++++++++++++++
 compat/posix.h                      |  7 +++++
 contrib/buildsystems/CMakeLists.txt |  4 +++
 meson.build                         |  2 ++
 5 files changed, 63 insertions(+)
 create mode 100644 compat/osxmmap.c

diff --git a/Makefile b/Makefile
index f79c905bdc..058bc83753 100644
--- a/Makefile
+++ b/Makefile
@@ -1654,6 +1654,7 @@ ifeq ($(uname_S),Darwin)
 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
         endif
 	PTHREAD_LIBS =
+	COMPAT_OBJS += compat/osxmmap.o
 endif
 
 ifdef NO_LIBGEN_H
diff --git a/compat/osxmmap.c b/compat/osxmmap.c
new file mode 100644
index 0000000000..5f9cf633ca
--- /dev/null
+++ b/compat/osxmmap.c
@@ -0,0 +1,49 @@
+#include <pthread.h>
+#include "../git-compat-util.h"
+/* We need original mmap/munmap here. */
+#undef mmap
+#undef munmap
+
+/*
+ * OSX doesn't have any specific setting like Linux's vm.max_map_count,
+ * so COUNT_MAX can be any large number. We here set it to the default
+ * value of Linux's vm.max_map_count.
+ */
+#define COUNT_MAX (65530)
+
+struct munmap_queue {
+	void *start;
+	size_t length;
+};
+
+void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
+{
+	/*
+	 * We can simply discard munmap operations in the queue by
+	 * restricting mmap arguments.
+	 */
+	if (start != NULL || flags != MAP_PRIVATE || prot != PROT_READ)
+		die("invalid usage of mmap");
+	return mmap(start, length, prot, flags, fd, offset);
+}
+
+int git_munmap(void *start, size_t length)
+{
+	static pthread_mutex_t mutex;
+	static struct munmap_queue *queue;
+	static int count;
+	int i;
+
+	pthread_mutex_lock(&mutex);
+	if (!queue)
+		queue = xmalloc(COUNT_MAX * sizeof(struct munmap_queue));
+	queue[count].start = start;
+	queue[count].length = length;
+	if (++count == COUNT_MAX) {
+		for (i = 0; i < COUNT_MAX; i++)
+			munmap(queue[i].start, queue[i].length);
+		count = 0;
+	}
+	pthread_mutex_unlock(&mutex);
+	return 0;
+}
diff --git a/compat/posix.h b/compat/posix.h
index 067a00f33b..3fa1218289 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -278,6 +278,13 @@ int git_munmap(void *start, size_t length);
 
 #include <sys/mman.h>
 
+#if defined(__APPLE__)
+#define mmap git_mmap
+#define munmap git_munmap
+void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+int git_munmap(void *start, size_t length);
+#endif
+
 #endif /* NO_MMAP || USE_WIN32_MMAP */
 
 #ifndef MAP_FAILED
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index edb0fc04ad..5c08f2fe5c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -271,6 +271,10 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		compat/strdup.c)
 	set(NO_UNIX_SOCKETS 1)
 
+elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
+	list(APPEND compat_SOURCES
+		compat/osxmmap.c)
+
 elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
 	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
 	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
diff --git a/meson.build b/meson.build
index cee9424475..b9b6e731b1 100644
--- a/meson.build
+++ b/meson.build
@@ -1275,6 +1275,8 @@ elif host_machine.system() == 'windows'
   else
     libgit_sources += 'compat/mingw.c'
   endif
+elif host_machine.system() == 'darwin'
+  libgit_sources += 'compat/osxmmap.c'
 endif
 
 if host_machine.system() == 'linux'

base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
-- 
gitgitgadget
