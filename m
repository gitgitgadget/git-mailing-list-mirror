Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56F43D4EA
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387665; cv=none; b=I61KZJexeqUacYhv8r9eoSBrZnNUgdJR62Euoik7496UkLfwpUfIdImvImZeRLy1u7BmcgMbAKjmC3wl+cUgtw100ZCxIY4lv2MmMLffJDhe/ofGiek2fHE6Ikqv2WPRmsfuL5oZMQjVqq2JeLX9zo4/OzTa7xqzja0lie5BYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387665; c=relaxed/simple;
	bh=c4XXmnrzJOOVT/WvZkrf5du7EWSGcmjpXDHs6N6N4dI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q8sv/dmkUaSRopwy0jSVBNf5eQNXOCppG7GhIQE1WohEXTGTedTni6wuKmp18u6mhExhqrE4uUeP/wV3h/C4r8QlWckzTrk+sZLY1YB2JYVpRZPWTDepxCUWjmkh6FtZGm5dwfpA4mwz7tlEqN3P3TOtOhzPp73GF87Ii0FHvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZO/KQ/D6; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZO/KQ/D6"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12ddbe104ccso1671219c88.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777387663; x=1777992463; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oq7Nz9LsH0FnrW80jJHsWOAgsz/LTK2Cm+OYz1qYXVs=;
        b=ZO/KQ/D65K2G/lDH91p0BCCXSgb7tPi+IR+TKbhLwXIJ15lefTUZL5xVxHtITHzimP
         zUfJDVsBBoNmHrtkRFGgo8CXBgcQ7qOZY06XJr2u6YY3eAl9zCmAVEry6XvSIZ2Ar9N2
         eq0BNdOya8vp0QVivZjRMufzF0YzGOw7qsLhqVCcKeXMyJcGPCF62FmtZ3E9+v7p0CiP
         GIcEvPoT3cIlhhCwZoghwbYmfaf0SPyvFkP6e9zhZBOtMWF4Ph1qFvwVWtjpEkCeCo4i
         rMJLM8SDCU4Z3q1AhSO3nekjFK+0t3IrOIohCL/3/BH/I6WhLCyJ9zgrTqDt1wnXhk/a
         rNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777387663; x=1777992463;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oq7Nz9LsH0FnrW80jJHsWOAgsz/LTK2Cm+OYz1qYXVs=;
        b=dJ/N3KdK4b7LUuc/VsK54Hg3izZ+FFXC4PvyKwsC2cfA/cDyX+/3xgXEmFut0LsZPs
         L/YwiKeRpCOpvy4YKCwqpst1a6GjnS6Efzv1eLTXJUpSExg59YIUyb4UDHzCj0S7dxrI
         q7C/7sE6O6ioOe6wikvB/pqyUdIXeSC88iql/fMIxtJMM8b3rJjAScsf8Fm1JBWhKYtt
         ETvbvWlg9uSMn1yCVxBhY6X2exIXsGTFgCa3wtkQBEfdSQmdUpjKkh8X13M9IO7E15KH
         qXsU3MyGkTtQv6epGe4j432befX9djyLz+8+i//Rtfl1TpSjIBEagNQnxj+RcwvxTmPr
         zNhQ==
X-Gm-Message-State: AOJu0YxxHldB/Ntq3FnloMip4M+XoSTXaD3GRoVCtMFpuRbB+bvpn5fZ
	hMRMmdiWf8nBsPQFkOAnERmiqot/mJXUyRy1vVsjCBrfHp34aoUauWsqiBF3EQ==
X-Gm-Gg: AeBDieuiyIRNGlzYmi+QDBp92BxDKaCJlh0UFwuFG7dMxKU4rPWUDFtZJXmtlJJnBWZ
	KMKVKQbeJ/r97B9CHfFK74djGZGwGjfDKFiOuu1T2yoMiQfDs0u4wWowtzGhxmy53YqDfFwPt4M
	+egnLWHD48BjdBSf85jeUsVosYgrhU17fdXK+fMbZB/PFr4NsNlU1I72JiHNRxKO7do9GnLCSpV
	QSuIYTmqQk6rl6EGyYXMp1e5KrFD3vsZFKdLhXUbkaUtlqQhVPmJJ1+pIcB0VcjgAtsReFhucrP
	756S/6nGIiOGACw76gB8RiRwF0lwNp6BIogPLYtIkNYB1xDLuQmZSg9JdnyjBgU8Jb2yYopQnv/
	dvQ7+t0//wrDdky4rGBzV5Lw5Dyturr2C17/3QAu1bNORTMCmuRyBki+LJCdMFmju+AhOsiyu+H
	Nj6PUgbVaestebOb2XxEvc1Vsm79CjMPej7Gwp
X-Received: by 2002:a05:7022:b9c:b0:11b:b3a1:714a with SMTP id a92af1059eb24-12ddd95654amr1525079c88.12.1777387662420;
        Tue, 28 Apr 2026 07:47:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.74.193])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd927c5fsm2104165c88.3.2026.04.28.07.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:47:41 -0700 (PDT)
Message-Id: <pull.2282.v4.git.git.1777387660841.gitgitgadget@gmail.com>
In-Reply-To: <pull.2282.v3.git.git.1777317998098.gitgitgadget@gmail.com>
References: <pull.2282.v3.git.git.1777317998098.gitgitgadget@gmail.com>
From: "Scott Bauersfeld via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 14:47:40 +0000
Subject: [PATCH v4] index-pack, unpack-objects: increase input buffer from 4
 KiB to 128 KiB
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Derrick Stolee <stolee@gmail.com>,
    Jeff King <peff@peff.net>,
    Scott Bauersfeld <sbauersfeld@g.ucla.edu>,
    Scott Bauersfeld <sbauersfeld@g.ucla.edu>

From: Scott Bauersfeld <sbauersfeld@g.ucla.edu>

index-pack and unpack-objects both read pack data from stdin through
a 4 KiB static buffer. In index-pack, each fill() flushes consumed
bytes to the pack file via write_or_die(), capping every write(2)
at 4 KiB. unpack-objects uses the same buffer pattern for reads.

On FUSE-backed filesystems every write(2) is a synchronous round
trip through the FUSE protocol (userspace -> kernel -> userspace ->
back), so the 4 KiB buffer turns a clone into many unnecessary tiny
writes with noticeable latency overhead.

Increase the buffer from 4 KiB to 128 KiB. Introduce a shared
DEFAULT_IO_BUFFER_SIZE constant in git-compat-util.h (next to
MAX_IO_SIZE) and use it in index-pack, unpack-objects, and the
hashfile layer in csum-file (which already used 128 KiB but
hardcoded the value).

Pack file writes to a FUSE filesystem with writeback caching
disabled during HTTPS clones of git/git (~293 MB pack):

  74,958 -> 4,687 (94% fewer)

Wall-clock time of git clone over HTTPS onto a FUSE passthrough
filesystem with writeback caching disabled, 3 runs per variant:

  vscode (~1.26 GB pack): 84.5s -> 75.7s avg (10% faster)
  git/git (~306 MB pack):  22.6s -> 20.0s avg (11% faster)

Signed-off-by: Scott Bauersfeld <sbauersfeld@g.ucla.edu>
---
    index-pack, unpack-objects: increase input buffer from 4 KiB to 128 KiB
    
    index-pack and unpack-objects read pack data from stdin through a 4 KiB
    static buffer. In index-pack, each fill() flushes consumed bytes to the
    pack file via write_or_die(), capping every write(2) at 4 KiB.
    unpack-objects uses the same buffer pattern for reads.
    
    On FUSE-backed filesystems every write(2) is a synchronous round trip
    through the FUSE protocol (userspace → kernel → userspace → back), so
    the 4 KiB buffer turns a clone into many unnecessary tiny writes with
    noticeable latency overhead.
    
    Increase the buffer from 4 KiB to 128 KiB. Introduce a shared
    DEFAULT_IO_BUFFER_SIZE constant in git-compat-util.h (next to
    MAX_IO_SIZE) and use it in index-pack, unpack-objects, and the hashfile
    layer in csum-file (which already used 128 KiB but hardcoded the value).
    
    
    Pack file write reduction
    =========================
    
    Pack file writes to a FUSE filesystem with writeback caching disabled
    during HTTPS clones of git/git (~293 MB pack):
    
    Unpatched avg Patched avg Change 74,958 4,687 −94%
    
    Write counts measured by logging writes in a FUSE passthrough daemon
    (libfuse 3.10.5, writeback cache off).
    
    
    Wall-clock time on FUSE
    =======================
    
    Measured wall-clock time of git clone over HTTPS onto a FUSE passthrough
    filesystem with writeback caching disabled. 3 runs per variant:
    
    Repo Unpatched avg Patched avg Change microsoft/vscode (~1.26 GB pack)
    84.5s 75.7s −10% git/git (~306 MB pack) 22.6s 20.0s −11%
    
    
    Changes since v3
    ================
    
     * Replaced strace-based syscall measurements with FUSE daemon write
       logging. The earlier strace numbers (72,465 → 24,943, 65% reduction)
       were distorted: strace -f ptrace intercepts every syscall in all
       traced processes and added enough overhead to distort the
       measurements. The FUSE daemon logging captures write sizes without
       perturbing the traced processes, showing the true reduction is 94%
       (74,958 → 4,687).
     * Note: Why 4,687 writes instead of ~2k writes as would be expected
       with a 128 KiB buffer size? It appears that fill() is calling xread()
       on a pipe and the linux default buffer size for pipes is 64KiB. I
       also tested using fcntl(F_SETPIPE_SZ) to increase the pipe's buffer
       size to 128KiB, which does indeed reduce total pack file writes to
       ~2.4K.
    
    
    Changes since v2
    ================
    
     * Renamed DEFAULT_PACKFILE_BUFFER_SIZE → DEFAULT_IO_BUFFER_SIZE per
       Stolee's feedback. The constant is not packfile-specific, since it is
       also used by the hashfile layer.
     * Stolee noted that WRITE_BUFFER_SIZE in read-cache.c could be
       consolidated. That constant was already removed in f6e2cd0625
       ("read-cache: delete unused hashing methods", 2021-05-18) when
       read-cache.c was converted to use the hashfile API, so there is
       nothing left to unify. The rename to DEFAULT_IO_BUFFER_SIZE helps
       account for the multiple usages of this constant.
    
    
    Changes since v1
    ================
    
     * Introduced shared DEFAULT_PACKFILE_BUFFER_SIZE constant in
       git-compat-util.h (next to MAX_IO_SIZE), replacing per-file #define
       and the hardcoded value in csum-file.c. Placed here rather than
       environment.h since it is an I/O buffer size, not an environment
       variable or repo config.
     * Added wall-clock timing on a FUSE filesystem.
     * Cleaned up the commit description a bit.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2282%2Fsbauersfeld%2Fsb%2Fincrease-index-pack-input-buffer-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2282/sbauersfeld/sb/increase-index-pack-input-buffer-v4
Pull-Request: https://github.com/git/git/pull/2282

Range-diff vs v3:

 1:  df754ac879 ! 1:  146b1846a5 index-pack, unpack-objects: increase input buffer from 4 KiB to 128 KiB
     @@ Commit message
          hashfile layer in csum-file (which already used 128 KiB but
          hardcoded the value).
      
     -    Syscall counts via strace on HTTPS clones of git/git (~296 MB pack,
     -    5 runs per variant, isolated builds from the same v2.54.0 source):
     +    Pack file writes to a FUSE filesystem with writeback caching
     +    disabled during HTTPS clones of git/git (~293 MB pack):
      
     -      index-pack pack file writes: 72,465 -> 24,943 avg (65% fewer)
     -      total write() syscalls:     310,192 -> 259,530 avg (16% fewer)
     -      writes of exactly 4096 bytes: ~40,077 -> 0
     +      74,958 -> 4,687 (94% fewer)
      
          Wall-clock time of git clone over HTTPS onto a FUSE passthrough
          filesystem with writeback caching disabled, 3 runs per variant:


 builtin/index-pack.c     | 3 +--
 builtin/unpack-objects.c | 3 +--
 csum-file.c              | 2 +-
 git-compat-util.h        | 6 ++++++
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ca7784dc2c..bb3639641c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -145,8 +145,7 @@ static int check_self_contained_and_connected;
 
 static struct progress *progress;
 
-/* We always read in 4kB chunks. */
-static unsigned char input_buffer[4096];
+static unsigned char input_buffer[DEFAULT_IO_BUFFER_SIZE];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
 static off_t max_input_size;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e01cf6e360..af67d1a1d3 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -23,8 +23,7 @@
 static int dry_run, quiet, recover, has_errors, strict;
 static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]";
 
-/* We always read in 4kB chunks. */
-static unsigned char buffer[4096];
+static unsigned char buffer[DEFAULT_IO_BUFFER_SIZE];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;
diff --git a/csum-file.c b/csum-file.c
index 9558177a11..d7a682c2b6 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -178,7 +178,7 @@ struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
 	f->algop = unsafe_hash_algo(algop);
 	f->algop->init_fn(&f->ctx);
 
-	f->buffer_len = opts->buffer_len ? opts->buffer_len : 128 * 1024;
+	f->buffer_len = opts->buffer_len ? opts->buffer_len : DEFAULT_IO_BUFFER_SIZE;
 	f->buffer = xmalloc(f->buffer_len);
 	f->check_buffer = NULL;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index ae1bdc90a4..5024814bd4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -712,6 +712,12 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
 # endif
 #endif
 
+/*
+ * Default buffer size for buffered I/O in index-pack, unpack-objects,
+ * and the hashfile layer in csum-file.
+ */
+#define DEFAULT_IO_BUFFER_SIZE (128 * 1024)
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
