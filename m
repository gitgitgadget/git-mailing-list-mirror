Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6415574E
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457340; cv=none; b=svV4FtfnkSRFKLMOnw6MQyGy4TsOViP5MdVYQ7mXAjx2QvK51cq2naZLBb4fnB/WPg7oN9isI64U5c+0wFNKzldgzQfdHjsFPM11m6wrGjFo72hR+U+tZWGvgJ92GNFV7la4XfbZz1HKDH83/s+0k+UlZF24oMs3d1WPSch4PTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457340; c=relaxed/simple;
	bh=jCP+DuMKRdVc5vE35ZVA3VG4YnuOYm5YBcCBHzIVJ68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVWWoWWasAX5BTnygh1rwTnveEseCkiXWYRFV6wr6m39mL5y2p/ZwxXFCWg9fABsTbjhWM4m74jV08cQfWyM9QFMZKMQ0cHLz3B24TCFXIwltmbfElBJ47pWR/eWH1QlcjeU+HFgKOCYZK60i8wThCJvvRGY7LaoTSLiLa8fxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFHQ4vIo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFHQ4vIo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22928d629faso42074235ad.3
        for <git@vger.kernel.org>; Mon, 05 May 2025 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746457337; x=1747062137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCneKDTnRyienMsod7zdD/XtyvozzVGgyXDwB++9LJM=;
        b=QFHQ4vIoi2wt2KmNzCfgX595ZChxasNVVXpv28DN2AtrUdW6zO6Mq6X0a+8Po/c29p
         gClKIgJTx6uKSq6/4Iz0yzlcJy8xZQpuURRnFwDJrX9DRTi4gmaeS93LndUpfGcjWYrs
         i9xD3MU+fypXuk03gMAGxpWu0jduAGXaXNEJKmMQr8AdS/GAlh9c3t+ByUZnaf5eYpcC
         dIyyskRDc81lNFPJSQKhyzPx1pyutFZoeTuunGtJFc0uHw3eZ92tEwknedyRtDnMgjwn
         AsGjdXqGiq1Q+mt46SV6DmRX/fOu17AkK/rqY5DiGcqRMqnV1hcjnl17jd26+AjI/665
         oA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746457337; x=1747062137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCneKDTnRyienMsod7zdD/XtyvozzVGgyXDwB++9LJM=;
        b=aDi9TrKLJNHcqza/wFu/zg/MyLW+NXJyci4G1BYOgLw2/B70ZxD9/1ge6bdbwrj9I9
         ImdARoeAyhqpm9kpP2O/NyPcVnxI0R1HU5A0smlh38DaM7vZVTy35hK/kR3as3LzW3jA
         9TbmKJUUOLfAhayGp8kX71Y2pYI0SkOtlHBbWn/u5N1as1ayOweTvJxbTvjhOiKSGQfE
         5IekNnWXnmRo9aGh9YwSKVgo7q4tcEHEkPr5EkGj/jWrQDc44j1vXFXQ54upDRlwtqmY
         z3PVTUt77lNV5LOyMmjeMnMRfYOgJbYWRbN6U19NlaFo3g8ag37bD/SzhE5fs8FZnBv/
         A8nw==
X-Gm-Message-State: AOJu0YzsN2eDXUyJ1ZnNVgQSk+GnsOuXUpuKYCqsGnAxqZEihbAko4yd
	GeyaGgA5wAp/qXPMPrBDzZRypev3D7PvosIO3fTl+rTrQjU+aFFtZJXOjg==
X-Gm-Gg: ASbGncvEiPRJ7SODn4+mZ7BC+KZNIcIzPlgAyH3R1L3YChkHV2vwBNS7ov99TqQzjgd
	vNiM5mBS0oiJz1g/MxdHnwanpUssQTmmXryteHHA7UFBh6vXKHTWFhet7tLSR1utaq2SSuxOOBN
	8Ja3/tax6yxFVuvGSq4l+pshyEBw6nH6iTs5bz0iXgVoMCGZ4BwuiUKKM4qB2ZptFGwr+y2rizY
	qKY88Lu4r2IZktCaAEzWPG0MYMBogaD/V6RCCbNFHy2akQ7St2ioRYD8v3NsMyytVwRXCUrmou2
	gbApA9DKpNLbmFtKr+EBg11vU4ky39j17QhdoLExqDgZ7ocZDG+ojHIL
X-Google-Smtp-Source: AGHT+IEYyekgSucrHeYTRQEDhh4bJ6KFOqkRxkpeoK7OHIsYeCl5aEFIrE2kbMo0LxhfgalqrMZ8JA==
X-Received: by 2002:a17:903:3c68:b0:220:e9f5:4b7c with SMTP id d9443c01a7336-22e1e8e9dd9mr118688885ad.17.1746457336475;
        Mon, 05 May 2025 08:02:16 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150ebf35sm55699405ad.21.2025.05.05.08.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:02:15 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	lucasseikioshiro@gmail.com,
	peff@peff.net,
	piotrsiupa@gmail.com,
	sandals@crustytoothpaste.net
Subject: [PATCH] dir.c: literal match with wildcard in pathspec should still glob
Date: Mon,  5 May 2025 20:32:03 +0530
Message-ID: <20250505150203.28408-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <xmqqwmavqfvp.fsf@gitster.g>
References: <xmqqwmavqfvp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a path with wildcard characters, e.g. 'f*o', exists in the
working tree, "git add -- 'f*o'" stops after happily finding
that there is 'f*o' and adding it to the index, without
realizing there may be other paths, e.g. 'foooo', that may match
the given pathspec.

This is because dir.c:do_match_pathspec() disables further
matches with pathspec when it finds an exact match.

Reported-by: piotrsiupa <piotrsiupa@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 dir.c                                 |   3 +-
 t/meson.build                         |   1 +
 t/t6137-pathspec-wildcards-literal.sh | 429 ++++++++++++++++++++++++++
 3 files changed, 432 insertions(+), 1 deletion(-)
 create mode 100755 t/t6137-pathspec-wildcards-literal.sh

diff --git a/dir.c b/dir.c
index 28b0e03feb..e162947d0a 100644
--- a/dir.c
+++ b/dir.c
@@ -519,7 +519,8 @@ static int do_match_pathspec(struct index_state *istate,
 		    ( exclude && !(ps->items[i].magic & PATHSPEC_EXCLUDE)))
 			continue;
 
-		if (seen && seen[i] == MATCHED_EXACTLY)
+		if (seen && seen[i] == MATCHED_EXACTLY && 
+		   ps->items[i].nowildcard_len == ps->items[i].len)
 			continue;
 		/*
 		 * Make exclude patterns optional and never report
diff --git a/t/meson.build b/t/meson.build
index bfb744e886..61285852e9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -788,6 +788,7 @@ integration_tests = [
   't6134-pathspec-in-submodule.sh',
   't6135-pathspec-with-attrs.sh',
   't6136-pathspec-in-bare.sh',
+  't6137-pathspec-wildcards-literal.sh',
   't6200-fmt-merge-msg.sh',
   't6300-for-each-ref.sh',
   't6301-for-each-ref-errors.sh',
diff --git a/t/t6137-pathspec-wildcards-literal.sh b/t/t6137-pathspec-wildcards-literal.sh
new file mode 100755
index 0000000000..20abad5667
--- /dev/null
+++ b/t/t6137-pathspec-wildcards-literal.sh
@@ -0,0 +1,429 @@
+#!/bin/sh
+test_description='test wildcards and literals with git add/commit (subshell style)'
+
+. ./test-lib.sh
+
+test_have_prereq FUNNYNAMES || {
+	skip_all='skipping: needs FUNNYNAMES (non-Windows only)'
+	test_done
+}
+
+prepare_test_files () {
+	for f in "*" "**" "?" "[abc]" "a" "f*" "f**" "f?z" "foo*bar" "hello?world" "hello_world"
+	do
+		>"$f" || return
+	done
+}
+
+test_expect_success 'add wildcard *' '
+	git init test-asterisk &&
+	(
+		cd test-asterisk &&
+		prepare_test_files &&
+		git add "*" &&
+		cat >expect <<-EOF &&
+		*
+		**
+		?
+		[abc]
+		a
+		f*
+		f**
+		f?z
+		foo*bar
+		hello?world
+		hello_world
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal \*' '
+	git init test-asterisk-literal &&
+	(
+		cd test-asterisk-literal &&
+		prepare_test_files &&
+		git add "\*" &&
+		cat >expect <<-EOF &&
+		*
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard **' '
+	git init test-dstar &&
+	(
+		cd test-dstar &&
+		prepare_test_files &&
+		git add "**" &&
+		cat >expect <<-EOF &&
+		*
+		**
+		?
+		[abc]
+		a
+		f*
+		f**
+		f?z
+		foo*bar
+		hello?world
+		hello_world
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard ?' '
+	git init test-qmark &&
+	(
+		cd test-qmark &&
+		prepare_test_files &&
+		git add "?" &&
+		cat >expect <<-\EOF | sort &&
+		*
+		?
+		a
+		EOF
+		git ls-files | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard [abc]' '
+	git init test-brackets &&
+	(
+		cd test-brackets &&
+		prepare_test_files &&
+		git add "[abc]" &&
+		cat >expect <<-\EOF | sort &&
+		[abc]
+		a
+		EOF
+		git ls-files | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard f*' '
+	git init test-f-wild &&
+	(
+		cd test-f-wild &&
+		prepare_test_files &&
+		git add "f*" &&
+		cat >expect <<-\EOF | sort &&
+		f*
+		f**
+		f?z
+		foo*bar
+		EOF
+		git ls-files | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal f\*' '
+	git init test-f-lit &&
+	(
+		cd test-f-lit &&
+		prepare_test_files &&
+		git add "f\*" &&
+		cat >expect <<-\EOF &&
+		f*
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard f**' '
+	git init test-fdstar &&
+	(
+		cd test-fdstar &&
+		prepare_test_files &&
+		git add "f**" &&
+		cat >expect <<-\EOF | sort &&
+		f*
+		f**
+		f?z
+		foo*bar
+		EOF
+		git ls-files | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal f\*\*' '
+	git init test-fdstar-lit &&
+	(
+		cd test-fdstar-lit &&
+		prepare_test_files &&
+		git add "f\*\*" &&
+		cat >expect <<-\EOF &&
+		f**
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard f?z' '
+	git init test-fqz &&
+	(
+		cd test-fqz &&
+		prepare_test_files &&
+		git add "f?z" &&
+		cat >expect <<-\EOF &&
+		f?z
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal \? literal' '
+	git init test-q-lit &&
+	(
+		cd test-q-lit &&
+		prepare_test_files &&
+		git add "\?" &&
+		cat >expect <<-\EOF &&
+		?
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard foo*bar' '
+	git init test-foobar &&
+	(
+		cd test-foobar &&
+		prepare_test_files &&
+		git add "foo*bar" &&
+		cat >expect <<-\EOF &&
+		foo*bar
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard hello?world' '
+	git init test-hellowild &&
+	(
+		cd test-hellowild &&
+		prepare_test_files &&
+		git add "hello?world" &&
+		cat >expect <<-\EOF &&
+		hello?world
+		hello_world
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal hello\?world' '
+	git init test-hellolit &&
+	(
+		cd test-hellolit &&
+		prepare_test_files &&
+		git add "hello\?world" &&
+		cat >expect <<-\EOF &&
+		hello?world
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal [abc]' '
+	git init test-brackets-lit &&
+	(
+		cd test-brackets-lit &&
+		prepare_test_files &&
+		git add "\[abc\]" &&
+		cat >expect <<-\EOF &&
+		[abc]
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: wildcard *' '
+	git init test-c-asterisk &&
+	(
+		cd test-c-asterisk &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c1" -- "*" &&
+		cat >expect <<-EOF &&
+		*
+		**
+		?
+		[abc]
+		a
+		f*
+		f**
+		f?z
+		foo*bar
+		hello?world
+		hello_world
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: literal *' '
+	git init test-c-asterisk-lit &&
+	(
+		cd test-c-asterisk-lit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c2" -- "\*" &&
+		cat >expect <<-EOF &&
+		*
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: wildcard f*' '
+	git init test-c-fwild &&
+	(
+		cd test-c-fwild &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c3" -- "f*" &&
+		cat >expect <<-EOF &&
+		f*
+		f**
+		f?z
+		foo*bar
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: literal f\*' '
+	git init test-c-flit &&
+	(
+		cd test-c-flit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c4" -- "f\*" &&
+		cat >expect <<-EOF &&
+		f*
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: wildcard pathspec limits commit' '
+	git init test-c-pathlimit &&
+	(
+		cd test-c-pathlimit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c5" -- "f**" &&
+		cat >expect <<-EOF &&
+		f*
+		f**
+		f?z
+		foo*bar
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: literal f\*\*' '
+	git init test-c-fdstar-lit &&
+	(
+		cd test-c-fdstar-lit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c6" -- "f\*\*" &&
+		cat >expect <<-EOF &&
+		f**
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: wildcard ?' '
+	git init test-c-qwild &&
+	(
+		cd test-c-qwild &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c7" -- "?" &&
+		cat >expect <<-EOF &&
+		*
+		?
+		a
+		EOF
+		git ls-tree -r --name-only HEAD | sort >actual &&
+		sort expect >expect.sorted &&
+		test_cmp expect.sorted actual
+	)
+'
+
+test_expect_success 'commit: literal \?' '
+	git init test-c-qlit &&
+	(
+		cd test-c-qlit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c8" -- "\?" &&
+		cat >expect <<-EOF &&
+		?
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: wildcard hello?world' '
+	git init test-c-hellowild &&
+	(
+		cd test-c-hellowild &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c9" -- "hello?world"  &&
+		cat >expect <<-EOF &&
+		hello?world
+		hello_world
+		EOF
+		git ls-tree -r --name-only HEAD | sort >actual &&
+		sort expect >expect.sorted &&
+		test_cmp expect.sorted actual
+	)
+'
+
+test_expect_success 'commit: literal hello\?world' '
+	git init test-c-hellolit &&
+	(
+		cd test-c-hellolit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c10" -- "hello\?world" &&
+		cat >expect <<-EOF &&
+		hello?world
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
2.49.GIT

