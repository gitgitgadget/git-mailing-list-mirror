Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFC1F5601
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052912; cv=none; b=EFIjOr2oVafS9vET4Fox/o2QxhGvWNWwykLFnkmRhz/5lU23iWNBRcibuIXVks2IE72KWuhDPHZiIzZWecUBU9L8DUm6r7jtDtLKsLwtAcNAKrt5pK6G/+Xx8UxtOJEiC2r6SOtQ4smk6f36bJ7JFVfn6fQ0FlULzY+/1txc3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052912; c=relaxed/simple;
	bh=hMQudkP5PvPM3amYis0O62zHHl/xgIPtUsOVl2e/Fq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUxAq1S5WqBthj+grYQsH4DYDATIJ1Izxdsyr9/Eb84fCeau6H5qkRbsASGwtAY3nawwpOqGSvgq9TZIXxBcmDU+5hwo+Y0D7BYh7zXXD2w/N0l03SlBpSrW3r3hqQIrQbEx3/zxrDDoajDxJQdXIbS0b+CeS86rXdJNewthSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pYOhHxoI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCR+fmVQ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pYOhHxoI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCR+fmVQ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C8B311401CF;
	Tue, 28 Jan 2025 03:28:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 28 Jan 2025 03:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052909;
	 x=1738139309; bh=oeX5NsOVng39ZWoO7fVGs4ulJzBxgaUCVro90lPiDfo=; b=
	pYOhHxoIYaRFSnlU7JjlmT4gFWImsiY41a71GmBq8GSq0DUJLZLehbgy3TANHrHh
	XLYbYaIKznp4gilwfQ6Qb48QSQWszblyN2LznYZR7fGF071896QkuZ+dEUtYhxvB
	ozu1tx7Ez6ZjPLtb0kkzTEv4C1D+CyqkPhEJ4YYlEWG52u0lr+ywfs9HoxFC9O9Z
	QOXLGNHaYApbovKzaUoiV30j1P9FglyOlqR5TTK9erEbd/x9eyLqWBx4ToHqzQ1c
	VpiSRbHPLmUJWtx7CsS9eqEB/naqMpq7NesBEvrnG0qEcCwFHFoHG8nZowGeyVnU
	Bee5Uy1XnNbtOr5Fkzk90Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052909; x=
	1738139309; bh=oeX5NsOVng39ZWoO7fVGs4ulJzBxgaUCVro90lPiDfo=; b=n
	CR+fmVQfG6Uvf02phyZI4rK/VNdUtwyYsAmZelraNKa9hy86HjPRFyuFJNpkTXVd
	XdYSBtbevU3NT6ZEz6cZzkVe/6v9FarptW23wiMnJx1OKxvVQHZgRNSrhtXW9ABL
	6W7l2YCiZBBgsY3luzbskB8ICYrnuzg/cghFNHaoiw7nAzSKMqS2oFh1Had+kkBQ
	oPS2lac096Tekq3RBLiclX0obZhzul8+pfX8jqpssLOhyDjlkPALq/8TEjxwWf4z
	sRHDIFdNqgPOG9m1IL593SzQ8nHB+xh+NhEDsOz73UBxWIOyIs1PoYM1MnBwaMPT
	M88Q9pmo9IQMe6X1diDxg==
X-ME-Sender: <xms:LJWYZ4ROfEL4Z_FEWLxYszd3pi-uzAxdtl3j0pJdMFrTchZYp3Dmkw>
    <xme:LJWYZ1wiHh9X0oBdfNJAOsddYaEJCgjHvyeo0HNs5QAF-rpSR3px41XdvVLrMyqlU
    eMiJMgkF2uNTRBkvw>
X-ME-Received: <xmr:LJWYZ12h47474suUS15Y-V02l5fCJr24BCzmUCVB-wMvGscvFxbXqKTMMIKVJRRUmB2k7kKfmiE2KczNIhGCk8_FjEUHEVIm_Ym5c7Pz3tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:LJWYZ8CuhHbF0b8bJMPWiDchhYNdZt7OYVXRf0o5cLR_i1e5vYJOrA>
    <xmx:LJWYZxiswoAokiVq0eBINa_NidsESciYHGDJFyhNXSg9AQGR5v8qOw>
    <xmx:LJWYZ4pyh7BEgXBavkgZUxGs_EoYBR9y7Fbx6gY-O6083cWX94qXpQ>
    <xmx:LJWYZ0hSaZCDon9NAKoykGIfhYbO1DTjkAvVd1SfXfJm9xD9etYXHA>
    <xmx:LZWYZxfiB_nrryO7tUxlHC3hU9KOWdIm9vhYyQdkgKoOXJ0IcxllKO6Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 17529e8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:16 +0100
Subject: [PATCH v2 15/20] compat: consistently resolve headers via project
 root
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-15-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The way we include headers in the "compat/" directory is inconsistent:

  - Sometimes we use includes relative to the current file.

  - Sometimes we use includes relative to the project root directory,
    which is being added via a `-I` compiler switch.

  - On Windows we also use includes relative to "compat/", which is
    being added via another platform-specific `-I` compiler switch in
    "compat.mak.uname".

This makes it very confusing to figure out which specific file is being
included right now and from what layer that file comes.

Stop adding "compat/" to the Windows-specific include directories and
adapt all includes in "compat/" to be relative to the projet's root
directory. Despite being more consistent, it also makes it way easier to
spot where an include comes from.

This change also prepares for subsequent commits where we split up both
"compat/mingw.h" and "compat/msvc.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/access.c                          |  3 ++-
 compat/basename.c                        |  4 ++--
 compat/fileno.c                          |  2 +-
 compat/fopen.c                           |  2 +-
 compat/fsmonitor/fsm-health-darwin.c     |  2 +-
 compat/fsmonitor/fsm-health-win32.c      |  2 +-
 compat/fsmonitor/fsm-listen-darwin.c     |  4 ++--
 compat/fsmonitor/fsm-listen-win32.c      |  2 +-
 compat/inet_ntop.c                       |  2 +-
 compat/inet_pton.c                       |  2 +-
 compat/memmem.c                          |  2 +-
 compat/mingw.c                           | 24 ++++++++++++------------
 compat/mkdir.c                           |  2 +-
 compat/mkdtemp.c                         |  2 +-
 compat/mmap.c                            |  2 +-
 compat/msvc.c                            |  8 ++++----
 compat/nonblock.c                        |  4 ++--
 compat/obstack.c                         |  2 +-
 compat/pread.c                           |  4 ++--
 compat/precompose_utf8.c                 |  2 +-
 compat/qsort_s.c                         |  2 +-
 compat/regcomp_enhanced.c                |  2 +-
 compat/setenv.c                          |  2 +-
 compat/snprintf.c                        |  2 +-
 compat/strcasestr.c                      |  2 +-
 compat/strdup.c                          |  2 +-
 compat/strlcpy.c                         |  2 +-
 compat/strtoimax.c                       |  2 +-
 compat/strtoumax.c                       |  2 +-
 compat/unsetenv.c                        |  2 +-
 compat/win32/dirent.c                    |  2 +-
 compat/win32/flush.c                     |  2 +-
 compat/win32/path-utils.c                |  4 ++--
 compat/win32/pthread.c                   |  4 ++--
 compat/win32/syslog.c                    |  2 +-
 compat/win32/trace2_win32_process_info.c | 10 +++++-----
 compat/win32mmap.c                       |  2 +-
 compat/winansi.c                         |  6 +++---
 config.mak.uname                         |  4 ++--
 39 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/compat/access.c b/compat/access.c
index 19fda3e877..918f51a08b 100644
--- a/compat/access.c
+++ b/compat/access.c
@@ -1,5 +1,6 @@
 #define COMPAT_CODE_ACCESS
-#include "../git-compat-util.h"
+
+#include "git-compat-util.h"
 
 /* Do the same thing access(2) does, but use the effective uid,
  * and don't make the mistake of telling root that any file is
diff --git a/compat/basename.c b/compat/basename.c
index c33579ef61..2f59c5475b 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -1,5 +1,5 @@
-#include "../git-compat-util.h"
-#include "../strbuf.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
 
 /* Adapted from libiberty's basename.c.  */
 char *gitbasename (char *path)
diff --git a/compat/fileno.c b/compat/fileno.c
index 8e80ef335d..977d63bf62 100644
--- a/compat/fileno.c
+++ b/compat/fileno.c
@@ -1,5 +1,5 @@
 #define COMPAT_CODE_FILENO
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 int git_fileno(FILE *stream)
 {
diff --git a/compat/fopen.c b/compat/fopen.c
index 107b3e8182..4af1f14996 100644
--- a/compat/fopen.c
+++ b/compat/fopen.c
@@ -9,7 +9,7 @@
  *  fopen after including git-compat-util.h is inadequate in this case.
  */
 #define SUPPRESS_FOPEN_REDEFINITION
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 FILE *git_fopen(const char *path, const char *mode)
 {
diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
index c2afcbe6c8..68c9fd7363 100644
--- a/compat/fsmonitor/fsm-health-darwin.c
+++ b/compat/fsmonitor/fsm-health-darwin.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
+#include "compat/fsmonitor/fsm-health.h"
 #include "config.h"
 #include "fsmonitor-ll.h"
-#include "fsm-health.h"
 #include "fsmonitor--daemon.h"
 
 int fsm_health__ctor(struct fsmonitor_daemon_state *state UNUSED)
diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 2aa8c219ac..16e073383b 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
+#include "compat/fsmonitor/fsm-health.h"
 #include "config.h"
 #include "fsmonitor-ll.h"
-#include "fsm-health.h"
 #include "fsmonitor--daemon.h"
 #include "gettext.h"
 #include "simple-ipc.h"
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 43c3a915a0..b9414da0d1 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -1,6 +1,6 @@
 #ifndef __clang__
 #include <dispatch/dispatch.h>
-#include "fsm-darwin-gcc.h"
+#include "compat/fsmonitor/fsm-darwin-gcc.h"
 #else
 #include <CoreFoundation/CoreFoundation.h>
 #include <CoreServices/CoreServices.h>
@@ -24,8 +24,8 @@
 #endif
 
 #include "git-compat-util.h"
+#include "compat/fsmonitor/fsm-listen.h"
 #include "fsmonitor-ll.h"
-#include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 #include "fsmonitor-path-utils.h"
 #include "gettext.h"
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 9a6efc9bea..3fb5710e21 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
+#include "compat/fsmonitor/fsm-listen.h"
 #include "config.h"
 #include "fsmonitor-ll.h"
-#include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 #include "gettext.h"
 #include "simple-ipc.h"
diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index 68307262be..3bac8377cc 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -15,7 +15,7 @@
  * SOFTWARE.
  */
 
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 #ifndef NS_INADDRSZ
 #define NS_INADDRSZ	4
diff --git a/compat/inet_pton.c b/compat/inet_pton.c
index 2b9a0a4e22..60935a1c83 100644
--- a/compat/inet_pton.c
+++ b/compat/inet_pton.c
@@ -15,7 +15,7 @@
  * WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 #ifndef NS_INT16SZ
 #define NS_INT16SZ       2
diff --git a/compat/memmem.c b/compat/memmem.c
index 56bcb4277f..2df3e7b7b9 100644
--- a/compat/memmem.c
+++ b/compat/memmem.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 void *gitmemmem(const void *haystack, size_t haystack_len,
                 const void *needle, size_t needle_len)
diff --git a/compat/mingw.c b/compat/mingw.c
index 1d5b211b54..5b0593c59d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,22 +1,22 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
-#include "../git-compat-util.h"
-#include "win32.h"
+#include "git-compat-util.h"
+#include "compat/win32.h"
 #include <aclapi.h>
 #include <sddl.h>
 #include <conio.h>
 #include <wchar.h>
-#include "../strbuf.h"
-#include "../run-command.h"
-#include "../abspath.h"
-#include "../alloc.h"
-#include "win32/lazyload.h"
-#include "../config.h"
-#include "../environment.h"
-#include "../trace2.h"
-#include "../symlinks.h"
-#include "../wrapper.h"
+#include "strbuf.h"
+#include "run-command.h"
+#include "abspath.h"
+#include "alloc.h"
+#include "compat/win32/lazyload.h"
+#include "config.h"
+#include "environment.h"
+#include "trace2.h"
+#include "symlinks.h"
+#include "wrapper.h"
 #include "dir.h"
 #include "gettext.h"
 #define SECURITY_WIN32
diff --git a/compat/mkdir.c b/compat/mkdir.c
index 02aea3b32e..8bd7c9a927 100644
--- a/compat/mkdir.c
+++ b/compat/mkdir.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 #undef mkdir
 
 /* for platforms that can't deal with a trailing '/' */
diff --git a/compat/mkdtemp.c b/compat/mkdtemp.c
index 1136119592..4349e15eee 100644
--- a/compat/mkdtemp.c
+++ b/compat/mkdtemp.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 char *gitmkdtemp(char *template)
 {
diff --git a/compat/mmap.c b/compat/mmap.c
index 2fe1c7732e..0a50adc9b9 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
 {
diff --git a/compat/msvc.c b/compat/msvc.c
index 71843d7eef..5aacf3af19 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -1,6 +1,6 @@
-#include "../git-compat-util.h"
-#include "win32.h"
+#include "git-compat-util.h"
+#include "compat/win32.h"
 #include <conio.h>
-#include "../strbuf.h"
+#include "strbuf.h"
 
-#include "mingw.c"
+#include "compat/mingw.c"
diff --git a/compat/nonblock.c b/compat/nonblock.c
index 5b51195c32..99ea76a7a4 100644
--- a/compat/nonblock.c
+++ b/compat/nonblock.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "nonblock.h"
+#include "compat/nonblock.h"
 
 #ifdef O_NONBLOCK
 
@@ -14,7 +14,7 @@ int enable_pipe_nonblock(int fd)
 
 #elif defined(GIT_WINDOWS_NATIVE)
 
-#include "win32.h"
+#include "compat/win32.h"
 
 int enable_pipe_nonblock(int fd)
 {
diff --git a/compat/obstack.c b/compat/obstack.c
index 27cd5c1ea1..baab07aca4 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -19,7 +19,7 @@
 
 #include "git-compat-util.h"
 #include <gettext.h>
-#include "obstack.h"
+#include "compat/obstack.h"
 
 /* NOTE BEFORE MODIFYING THIS FILE: This version number must be
    incremented whenever callers compiled using an old obstack.h can no
diff --git a/compat/pread.c b/compat/pread.c
index 484e6d4c71..82161b5a2a 100644
--- a/compat/pread.c
+++ b/compat/pread.c
@@ -1,5 +1,5 @@
-#include "../git-compat-util.h"
-#include "../wrapper.h"
+#include "git-compat-util.h"
+#include "wrapper.h"
 
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset)
 {
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index f7cc7b3be5..994a2f1303 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -7,13 +7,13 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "compat/precompose_utf8.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
 #include "path.h"
 #include "strbuf.h"
 #include "utf8.h"
-#include "precompose_utf8.h"
 
 typedef char *iconv_ibp;
 static const char *repo_encoding = "UTF-8";
diff --git a/compat/qsort_s.c b/compat/qsort_s.c
index 0f7ff30f5f..66cd6e096d 100644
--- a/compat/qsort_s.c
+++ b/compat/qsort_s.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 /*
  * A merge sort implementation, simplified from the qsort implementation
diff --git a/compat/regcomp_enhanced.c b/compat/regcomp_enhanced.c
index 84193ce53b..693b63c2c4 100644
--- a/compat/regcomp_enhanced.c
+++ b/compat/regcomp_enhanced.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 #undef regcomp
 
 int git_regcomp(regex_t *preg, const char *pattern, int cflags)
diff --git a/compat/setenv.c b/compat/setenv.c
index 7849f258d2..c49df82534 100644
--- a/compat/setenv.c
+++ b/compat/setenv.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 int gitsetenv(const char *name, const char *value, int replace)
 {
diff --git a/compat/snprintf.c b/compat/snprintf.c
index 0b11688537..91a63cf3f7 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 /*
  * The size parameter specifies the available space, i.e. includes
diff --git a/compat/strcasestr.c b/compat/strcasestr.c
index 26896deca6..d66609361b 100644
--- a/compat/strcasestr.c
+++ b/compat/strcasestr.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 char *gitstrcasestr(const char *haystack, const char *needle)
 {
diff --git a/compat/strdup.c b/compat/strdup.c
index f3fb978eb3..9ef99f88f2 100644
--- a/compat/strdup.c
+++ b/compat/strdup.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 char *gitstrdup(const char *s1)
 {
diff --git a/compat/strlcpy.c b/compat/strlcpy.c
index 4024c36030..780b39ff82 100644
--- a/compat/strlcpy.c
+++ b/compat/strlcpy.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 size_t gitstrlcpy(char *dest, const char *src, size_t size)
 {
diff --git a/compat/strtoimax.c b/compat/strtoimax.c
index ac09ed89e7..c9ed79f0d1 100644
--- a/compat/strtoimax.c
+++ b/compat/strtoimax.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 intmax_t gitstrtoimax (const char *nptr, char **endptr, int base)
 {
diff --git a/compat/strtoumax.c b/compat/strtoumax.c
index 5541353a77..50fe26d746 100644
--- a/compat/strtoumax.c
+++ b/compat/strtoumax.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 uintmax_t gitstrtoumax (const char *nptr, char **endptr, int base)
 {
diff --git a/compat/unsetenv.c b/compat/unsetenv.c
index b9d34af613..d96e0d7bcc 100644
--- a/compat/unsetenv.c
+++ b/compat/unsetenv.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 int gitunsetenv(const char *name)
 {
diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
index 52420ec7d4..362622746d 100644
--- a/compat/win32/dirent.c
+++ b/compat/win32/dirent.c
@@ -1,4 +1,4 @@
-#include "../../git-compat-util.h"
+#include "git-compat-util.h"
 
 struct DIR {
 	struct dirent dd_dir; /* includes d_type */
diff --git a/compat/win32/flush.c b/compat/win32/flush.c
index 291f90ea94..bcad557eb4 100644
--- a/compat/win32/flush.c
+++ b/compat/win32/flush.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include <winternl.h>
-#include "lazyload.h"
+#include "compat/win32/lazyload.h"
 
 int win32_fsync_no_flush(int fd)
 {
diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
index 966ef779b9..20e9a69f56 100644
--- a/compat/win32/path-utils.c
+++ b/compat/win32/path-utils.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
-#include "../../git-compat-util.h"
-#include "../../environment.h"
+#include "git-compat-util.h"
+#include "environment.h"
 
 int win32_has_dos_drive_prefix(const char *path)
 {
diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
index 58980a529c..86199d67ba 100644
--- a/compat/win32/pthread.c
+++ b/compat/win32/pthread.c
@@ -7,8 +7,8 @@
  * no need for double-checking.
  */
 
-#include "../../git-compat-util.h"
-#include "pthread.h"
+#include "git-compat-util.h"
+#include "compat/win32/pthread.h"
 
 #include <errno.h>
 #include <limits.h>
diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 4e4794743a..587fb99ba9 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -1,4 +1,4 @@
-#include "../../git-compat-util.h"
+#include "git-compat-util.h"
 
 static HANDLE ms_eventlog;
 
diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index f147da706a..55e482f100 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -1,10 +1,10 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
-#include "../../git-compat-util.h"
-#include "../../json-writer.h"
-#include "../../repository.h"
-#include "../../trace2.h"
-#include "lazyload.h"
+#include "git-compat-util.h"
+#include "compat/win32/lazyload.h"
+#include "json-writer.h"
+#include "repository.h"
+#include "trace2.h"
 #include <psapi.h>
 #include <tlhelp32.h>
 
diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index e951934316..aff1768acb 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -1,6 +1,6 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
 {
diff --git a/compat/winansi.c b/compat/winansi.c
index ac2ffb7869..143685e5ab 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -6,11 +6,11 @@
 
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 #include <wingdi.h>
 #include <winreg.h>
-#include "win32.h"
-#include "win32/lazyload.h"
+#include "compat/win32.h"
+#include "compat/win32/lazyload.h"
 
 static int fd_is_interactive[3] = { 0, 0, 0 };
 #define FD_CONSOLE 0x1
diff --git a/config.mak.uname b/config.mak.uname
index b12d4e168a..cd9535a65c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -501,7 +501,7 @@ endif
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
 		compat/win32/dirent.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY -DNOGDI -DHAVE_STRING_H -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -ENTRY:wmainCRTStartup -SUBSYSTEM:CONSOLE
 	# invalidcontinue.obj allows Git's source code to close the same file
 	# handle twice, or to access the osfhandle of an already-closed stdout
@@ -692,7 +692,7 @@ ifeq ($(uname_S),MINGW)
 	HAVE_PLATFORM_PROCINFO = YesPlease
 	CSPRNG_METHOD = rtlgenrandom
 	BASIC_LDFLAGS += -municode
-	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -DNOGDI -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/trace2_win32_process_info.o \

-- 
2.48.1.362.g079036d154.dirty

