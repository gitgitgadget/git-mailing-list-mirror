Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF825524C
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052434; cv=none; b=PNprp8b3AFhtyPep4ULrPMXEcz5C5RrVU7tuC/Dc6aYJrZ+KaI9Cj5z+IpMXB5dWcMRgPIGXTFG1mvFY2GN7TlVxSfzo4y8KOH/JC8+CHdUb7ZI6q9xbhKWtvBEhl0lyWl4P8GQIX/YK/uP3iN0XxZEPTy4UuOwcaSKqVURSqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052434; c=relaxed/simple;
	bh=dziFcImDS/axn8VSFCtKNR1orp5kPY8E9Sd6EYNd+y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksEKE0ipIrSeGlo9DezzpCSvMAJLOSwSBlcmEbdw0jshCj1wCrz1mehpQ0Nfk5/Yz3Dt+K300+irDxB72WlT+2/mt32JVVDbCh94PINlgVUS+UIsGLa11v9BiQ3MbHXGH5zlskCq/lyHioKuhz5lzMwOKh7MC1LdtXCsfwQxU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6QQZhom; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6QQZhom"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f48c750afcso6589447a34.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789052431; x=1789657231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDF2iujX+zMZ71lsXsxubZYojzV5OXAPsCkJ5xv9iSA=;
        b=Z6QQZhomNH1lh3ofbwsRiAHN+kcsy9b8mBNDsm1frftm4RIwRreMtawUYGMBof+18n
         yiRKAGwSMqY1EYaWSOjAZbYIKaCeRMJTjQg/kJGnVe7a0NrzlBWWkPghAmBuluPIZQQe
         /i/E9ZOyBNu6d4aL/QEQTeE+esl6kohf6skH3u/c/PXi2k67en/URhnTonCO4nHfe2UU
         Nq5EYUkLjOIBjc/b7Q3X+GlJqt7PgkDAFdoS1F43XcDZErddEr2R6JMwGXQxz55SN6ZK
         Zm1Mn58Ki8aBlyieUSLzETgt2qu53KMthJcIoBzOz4MNwG9IVYCLiABw79O6HTS6MPr0
         DShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789052431; x=1789657231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDF2iujX+zMZ71lsXsxubZYojzV5OXAPsCkJ5xv9iSA=;
        b=fDUsLH+QCpAQmDygVK2FOJswQ9speZCn0JzWfdRGyIC+vXrhzABJdbH3tCeLxiH2aY
         euBu+4dfUaix1h7jASm5aWbzAqLcV45D8KV+89ErKcLOE50x3BD80tRurF0n+9TyCjo4
         i+L1EoGaRZCrtJ+AznJyej+dNvNG/N9xlCV3Uom64YWcuQ294jQphAnUuY3Z5xBoYfPS
         bylMm9HgD3Ay+UCkvXWuhVuLvTG2c9GgLXjbJIboYy5af7JSvquiE6c+KBzH/IhVNFxk
         zkGs7ly2enlmOle67aSog2FsjkG9+9022gNnVUk2eH3imPRK392wsCNQ+ukeIxcqRUwN
         2cbA==
X-Forwarded-Encrypted: i=1; AKwUvBzjbspwSuCdcT9EcGR5jHUx12p5+CkQ7EYs9ovaKwQxrkQ5365zjy4miGKy+NVzkafFC8U=@vger.kernel.org
X-Gm-Message-State: AFuF++lk5wwZWgRKRp4lGMaq26wXKndcIwnfM8bs+o7ZmGvyE3iDx2KO
	whuXjHknvh67k5pBzs8YuYbXJlhCBS5re6DQ5ScR3myRfqk/3K0mPjmK
X-Gm-Gg: AYBFou17eoDdAObgWZNDCUX7vfrqHckK/CAElxfaivcbIYaNIoHawfealo/dsK4BJAq
	LOM9fcGkcRiMfqPDzsNK6f3kQjRKlq0K+4Q2fJt7WK5/cwU3ZlfNSgHC5iXTczvCqMYk08zrTW/
	qGRZ6raEz5QFaKo7qVGPyvTm5zGnu7GfgR5Sp8t9l+aQzBLUcbbpvfKiuQeAKxnST0JhTyfgcUK
	Arm+SITS1SnJs5vlXcdX/nMZ7Mh5039WkWDn51MDiUbj7h/pcEXfgsuYg8VP7uRgunPeG1fPrYU
	yUglSHpsV8fIQWetj1UFSXywP4X0nBThBuTirgAAEyp0xtJk0sDjmYUM0qpr4T1VO2WDqnvGINe
	RdG9Mgb4jlTc6MTof4UP6hYiGm6791tIOjE+0Ovt6Q1BKb99NdxQf4lPS7bfSkVcRAxtQFRDfGH
	knWqkilk+e4AljpGleoGRZ2ep3MafnnW1MofigmMkFtu7brMzfkMUZajB4D2Vsk7ynzcQwIbQa7
	Sb4SiWZNMW4dTyKWJ2rKbg3spdE
X-Received: by 2002:a05:6820:4cc8:b0:6aa:de29:651 with SMTP id 006d021491bc7-6b6fbcd091cmr23860535eaf.16.1789052431090;
        Thu, 10 Sep 2026 08:00:31 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2406:7400:12b:61a6:ff8f:ddf5:ee1e:28ec])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1435c2ae6b5sm7712940c88.1.2026.09.10.08.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:00:30 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3] builtin/history: unuse the commit buffer after use
Date: Thu, 10 Sep 2026 20:30:15 +0530
Message-ID: <20260910150021.348548-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.55.0.806.gb8242b093d
In-Reply-To: <xmqq4ifxgree.fsf@gitster.g>
References: <xmqq4ifxgree.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running `git history reword` on a commit with `SANITIZE` flag set
to `address,leak`, we could observe a leak being reported (trace near
the end).

The root cause is as follows.

As part of rewording a commit, `commit_tree_ext` obtains the commit
message buffer from `repo_logmsg_reencode`. As we ask for no output
encoding, that function hands back the buffer from
`repo_get_commit_buffer` verbatim.

`repo_get_commit_buffer` returns the buffer cached in the commit slab
if there is one, and otherwise reads the object afresh via
`odb_read_object`. As the stacktrace below shows, we take the latter
path here. The buffer is uncached because the commit was parsed from
the commit-graph: such a parse is answered from the graph file alone,
so it never reads the object and never caches a buffer.

A buffer obtained this way is expected to be released with an
accompanying call to `repo_unuse_commit_buffer`, which takes care of
freeing it. This call is missing in the `commit_tree_ext` flow, thus
resulting in the leak.

Fix this by ensuring we call `repo_unuse_commit_buffer` on the
original_message buffer.

Using `repo_unuse_commit_buffer` is the correct way to release the
buffer since it frees only buffers the slab doesn't own. Plain free
would double-free on the cached path.

For those who are curious, the following is a minimal way to reproduce
the leak. Note the `git commit-graph --write` step, without which the
buffer comes from the commit slab and nothing leaks:

  $ git init scratch
  Initialized empty Git repository in /me/test-repos/scratch/.git/
  $ cd scratch/
  $ touch one && git add one && git commit -m "Commit one"
  [main (root-commit) 2182f9c] Commit one
   1 file changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 one
  $ touch two && git add two && git commit -m "Commit two"
  [main 5550f33] Commit two
   1 file changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 two
  $ git commit-graph write --reachable
  $ git history reword HEAD --dry-run
  update refs/heads/main eaded0872b14b3937605c77c0042429ca1e3bbe1
   fd19e3776c75b8da9555c7c616ce0df9db7c6641

This leak could also be triggered in our test suite if we run
t3451-history-reword.sh as follows:

  $ make SANITIZE=leak
  $ cd t
  $ GIT_TEST_COMMIT_GRAPH=1 ./t3451-history-reword.sh -v -i

=== Memory leak strack trace ===

==122337==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 263 byte(s) in 1 object(s) allocated from:
    #0 0x7002c14fd9c7 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x5cdd008ec077 in do_xmalloc /me/git/wrapper.c:55
    #2 0x5cdd008ec185 in do_xmallocz /me/git/wrapper.c:89
    #3 0x5cdd008ec1fa in xmallocz /me/git/wrapper.c:97
    #4 0x5cdd005b99d8 in unpack_loose_rest /me/git/object-file.c:216
    #5 0x5cdd005e45f4 in read_object_info_from_path odb/source-loose.c:174
    #6 0x5cdd005e4ba0 in odb_source_loose_read_object_info odb/source-loose.c:235
    #7 0x5cdd005d9f83 in odb_source_read_object_info odb/source.h:413
    #8 0x5cdd005daaed in odb_source_files_read_object_info odb/source-files.c:93
    #9 0x5cdd005d1c8c in odb_source_read_object_info odb/source.h:413
    #10 0x5cdd005d5bdd in do_oid_object_info_extended /me/git/odb.c:592
    #11 0x5cdd005d7080 in odb_read_object_info_extended /me/git/odb.c:747
    #12 0x5cdd005d75d8 in odb_read_object /me/git/odb.c:793
    #13 0x5cdd003d9af7 in repo_get_commit_buffer /me/git/commit.c:399
    #14 0x5cdd006739ed in repo_logmsg_reencode /me/git/pretty.c:716
    #15 0x5cdd0012287a in commit_tree_ext builtin/history.c:134
    #16 0x5cdd00122f33 in commit_tree_with_edited_message builtin/history.c:190
    #17 0x5cdd00126e44 in cmd_history_reword builtin/history.c:748
    #18 0x5cdd0012b051 in cmd_history builtin/history.c:1209
    #19 0x5cdcfffb8faf in run_builtin /me/git/git.c:510
    #20 0x5cdcfffb9ac6 in handle_builtin /me/git/git.c:786
    #21 0x5cdcfffba358 in run_argv /me/git/git.c:869
    #22 0x5cdcfffbaea9 in cmd_main /me/git/git.c:990
    #23 0x5cdd0030f27f in main /me/git/common-main.c:9
    #24 0x7002c102a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #25 0x7002c102a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #26 0x5cdcfffb4134 in _start (/home/sivaraam/.local/bin/git+0x217134)
    (BuildId: 549c1036ab1f9f4fd55546e5bf31c7bd81b008fd)

SUMMARY: AddressSanitizer: 263 byte(s) leaked in 1 allocation(s).

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
Changes since v2:

- Tried to improve the commit message to make it more readable (hopefully).

 builtin/history.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/history.c b/builtin/history.c
index 091465a59e..0e9259b5d7 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -154,6 +154,7 @@ static int commit_tree_ext(struct repository *repo,
 	free_commit_extra_headers(original_extra_headers);
 	strbuf_release(&commit_message);
 	free(original_author);
+	repo_unuse_commit_buffer(repo, commit_with_message, original_message);
 	return ret;
 }
 
-- 
2.55.0.806.gb8242b093d

