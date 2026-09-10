Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2DF3033DF
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040477; cv=none; b=l3eFlSGH3HAJg1pbB+jzRtgylu8dqGegRn7nVxg84G0VIin/6VsfRvLbySJVQRxdGWoVXcGlSokOaYuv2g99AAfMF8xSPB3nUcZraqCmCTDA9HmiL92wbbUpIG9ZfI78/NTEiL21eKeHNiLzRP3S0CfNz6G/76P7i1gQKyK5cm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040477; c=relaxed/simple;
	bh=0E+PK4OS3GPfRgRTjA4rHxCVXMNJvEQ4PfdQbyfQgGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJZbb/3wzeonqCy6vb/HdRLJ+dkg5EpUUqzzK6F+kFa/m8+w4zq5nNCqJmrV8WpUlMTPRktrp+PiNOYBS5XxOvck36ltZtb7i0/nsQbdK771UApsWFJMmQb6TfgGywnmv/TTmLV0GcI6Vxv2RVZpulSTmg6h6TFPL0xNWdoMjZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEvszLPe; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEvszLPe"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-46adfc80ff6so4306795fac.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789040474; x=1789645274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GK6MsE2KsX/KsbPTu2bCedD9WskwP1Ddf0jsuCE1bt0=;
        b=eEvszLPe9bF+qlgKDbNSfJ5Y8tVJcIdVCHt+wquYOVaLu/xMxkYxwrmXIpQ1MhpRuI
         +SxxUwO31UxH5MRk6XG6AeUITbU2SXz7w1MpYe4K4u4MdgKXN9yNhk1BWtKSmi3epLdN
         ci1i3hB3bhjjtZyIXrpvIuAD6HBlH3Sl8NHk1nObBIyYoZPN8t+6QLEJUlqy/fmUtabC
         h8vcmOkdvwLTo5ktVkLYjHq/uRJ31a7vAIpQryFVPXO0fk4JjE4rLcuO4SxcMyWZepvO
         J+b47JekRR49N7dv0aXxCKb9pAsian7W+u+o0akN6LGwPFG7r+5+eGoom0yEHt6Zy9EV
         ZKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789040474; x=1789645274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GK6MsE2KsX/KsbPTu2bCedD9WskwP1Ddf0jsuCE1bt0=;
        b=foe6tr4jQ/5x3+yh7SnGL7VhBYw5MtIFJ7bo1UqhI9BiNYqyeecf7u2TYwRN6SFBk7
         yrJobdZCM1Qz3GwcWpox5CCnPgHtPUUamwG9SbeeIDRH3SmifDZa3mlpdB5KVnEtiopx
         d8BMMGGTmvqyFccQDlV9tbYI9D/6Tzgf7WLqHoTKSxU1W9jP1BW5yeQWTF3Xf0zMpPYc
         JOsrIlLL/ZT75wbl7jhbbz4YY2EIqzp9RAQgAXikoiYtaEdmXdx7rccAdw+bDp/rdHEE
         7Y6INXJfrEke4nUdO53tpFh2MtwpsBZ4UeOAPVToM4B53GugpI2GteIxtPKhtN1fseEb
         iwog==
X-Gm-Message-State: AFuF++kcGpqDNk+f+7RnrD0QInx5r41pQI5lQGdQb+x1mk4Fax6u3f0K
	29TNRY6XS2KikiH/4+Gmb29dR6aEnc2spK/A4KuT5+5iqFqymbUyEcHh/gQK1JkaH7U=
X-Gm-Gg: AYBFou1wqNhOyFe4LNGKIPs6Agw2Olvk3RBwJHoAuGuMYpJEwtxN9Iw9XVUkMx/u6aU
	O7VE2twVEv2BODHRM79tfYijymjy8VQwpKqdgI/tEn1G0fyEpUAN66lJl/HIkSJlRPuoo6K//gV
	ufWJBKH2qGScSbM0qnG14+FLehpHjT9OJSKaMxUtVhi3YIXm4cnZ1LjdFx+dQorD8XhQX5TnLlC
	//fyFqbgl3bnyBk03WPn0bVpyYF/hmoiHmhe9Ck0ueJVbZna2PZRLJn3cyhpAOXKS9R5D2QShOy
	8+eoN2icObOejwm0Fes7YpcLsgMLXxxbvsTSxBA5nKOUJksGWP/9Xc0bY6vbWlxTPanOne3YLJh
	XNxrZ+BmWrKQ2G6UtezJqA0Qi2ldTku3jTj/eOWoYylxBCBOPjdeGagbBb/Yqoz3a/g8oGJTR4G
	YYnOhfCcelT6UqhJRp5jqsi3tgOkBUvbSyC+Ae1tghDizBF31w9zVJFX51pZg+35Y0Z0OeLcPZz
	Z8wMqZy4K4BgFieB6cAh5Yes0wPl3lgTHMVqypC
X-Received: by 2002:a05:6871:1c2:b0:475:a1ec:961e with SMTP id 586e51a60fabf-475a1ec9c01mr23291361fac.32.1789040470796;
        Thu, 10 Sep 2026 04:41:10 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2406:7400:12b:61a6:ff8f:ddf5:ee1e:28ec])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm46821740c88.0.2026.09.10.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:41:10 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2] builtin/history: unuse the commit buffer after use
Date: Thu, 10 Sep 2026 17:09:51 +0530
Message-ID: <20260910114052.325683-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.55.0.806.gb8242b093d
In-Reply-To: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running `git history reword` on a commit with `SANITIZE` flag set
to `address,leak`, we could observe the following leak being reported:

-- 8< --

=================================================================
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
    #26 0x5cdcfffb4134 in _start (/home/sivaraam/.local/bin/git+0x217134) (BuildId: 549c1036ab1f9f4fd55546e5bf31c7bd81b008fd)

-- >8 --

A deeper investigation on this reveals the following as the root cause.

As part of rewording a commit in `git history`, we get the commit message
buffer in the `commit_tree_ext` function. This in turn obtains the buffer
from `repo_logmsg_reencode`. In this case, the buffer that we receive from
`repo_logmsg_reencode` ends up always being obtained from a call to
`repo_get_commit_buffer`. The buffer that `repo_get_commit_buffer` ends
up to be one that is not cached in the commit slab but a fresh buffer
that is returned from `odb_read_object`. This could be confirmed
confirmed by the stacktrace in the leak. A plausible reason for us
receiving an uncached buffer might be because the commit comes from the
commit-graph.

In any case, this uncached buffer is expected to be released with an
accompanying call to `repo_unuse_commit_buffer` which takes care of
free-ing it. This call is missing in the `commit_tree_ext` flow
thus resulting in the leak.

Fix this by ensuring we call `repo_unuse_commit_buffer` on the
original_message buffer.

For those who are curious, the following is a minimal way to
reproduce the leak. I'm including this here as the leak does
not happen when we get a cached commit obtained from the commit
slab:

-- 8< --
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
update refs/heads/main eaded0872b14b3937605c77c0042429ca1e3bbe1 fd19e3776c75b8da9555c7c616ce0df9db7c6641

=================================================================
==122337==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 263 byte(s) in 1 object(s) allocated from:

... snip ...

SUMMARY: AddressSanitizer: 263 byte(s) leaked in 1 allocation(s).
-- >8 --

This leak could also be triggered in our test suite if we run
t3451-history-reword.sh as follows:

-- 8< --
$ make SANITIZE=leak
$ cd t
$ GIT_TEST_COMMIT_GRAPH=1 ./t3451-history-reword.sh -v -i
-- >8 --

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
Changes since v2:

Just updated the commit message to clarify the root cause
more clearly. I haven't added an explicit test case as
it wasn't clear if it is really worth it as Peff points out.

Thank you, Peff, for your help with this!

On a tangent, I noticed that the leak is only triggereable
in the test suite, when we use `make SANITIZE=leak` and not
when we use `make SANITIZE=address,leak`. It seems we
intentionally disable leak detection in Asan via
the following line in t/test-lib.sh:

   prepend_var ASAN_OPTIONS : detect_leaks=0

I noticed the comment above saying the following

   # If we were built with ASAN, it may complain about leaks
   # of program-lifetime variables. Disable it by default to lower
   # the noise level.

I wonder if it has become stale now as we are fine with the test
suite reporting leaks when we build with `make SANITIZE=leak`.

Would it be worth while to avoid turning off detect_leaks while
using Asan?

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
2.55.0.806.gd4f651056d

