Received: from mail-wr2-f36.google.com (mail-wr2-f36.google.com [74.125.225.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56124DA52E
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673215; cv=none; b=sltkm5rnNyvGjH4mGTePtU7C0qlfo3ain3zSwngKhshg1mkinkj+rphUaCJ+Knxkc8jEV4rKgenyXSom3c360OUCJ8fxb2o/TWUIonv7zu5zWfYOvp7fQO++g7vJ7cKD2cJD+RQHKjWWYjAhpnKXlBRLsIl70V74Dowl+WeZ1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673215; c=relaxed/simple;
	bh=wJnPUEv6S7wFxW4ucLQuOrIa4GtVO88E1L6SzMDlDhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=so9LHJ3LIDyY9f8Cy/qaRyF+bDRJrfNtGhLUtD6bd/s4rwKaHxLGgO4C68G3WNHd5gZYPlAZdWvjGPXmfu4tYiIIh4YSkFT9GPUKEflkFS+HYZNQa40RY13E7ZxejbKe3Al9O+mKB4Y0QXiSkypMUJDZFs5Qf5dIYUx6iexC280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=clro6ljN; arc=none smtp.client-ip=74.125.225.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="clro6ljN"
Received: by mail-wr2-f36.google.com with SMTP id ffacd0b85a97d-4843c3ee4cfso1906955f8f.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 02:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790673201; x=1791278001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8hytDkN8KJvTuiHUV616eZNXZvg+nY8U+YnRypfGLPg=;
        b=clro6ljNl+ouXjbhnje45wfn1ypY05KTcOyylcEsP2AiNBXdxkHFOfr48fbaVH1gh7
         uKIQR+Er3n4D5F2jXr4xtbznVF0v9yQRRYvkNs1NszFis8uVk7afETOqvkjE57OMvqMa
         wrAHSYjOy4WT/Ab6cjm+AYRPr4SogEi2ayL+khxbf6l7aqiixKEMq/F28ZKJPDtr5O8E
         FViohVMKT/pMr0mLTUS6KEsM0UkElA24d7QiVFPSsENX/6uoiJWACZEC7d8P2stDub9n
         ocTQhWI0N0/HRa0Frmm5/yXu5B/aWXgWQaRkzLZZzgQ/ZWMp7eE/u/6BdTmqF7ijXenF
         By/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673201; x=1791278001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8hytDkN8KJvTuiHUV616eZNXZvg+nY8U+YnRypfGLPg=;
        b=kiIQdU7YgCVtz7yK0/qLs6A5hnLQAKMjZ2CRSB4z/SjLTy25EyUQ720WjaR6LECsTO
         +thhL9H0y/OSZPHowjcWpoEsgARDg9kMDLVl9Lgzp+rGDRg29eWaj6bo+hEWvLTplZMh
         vZyvq9BbdgjaoxQ0sooaa0j6D5BHPL+fJZFZN+1m4MDlORnCUtjnY/HN7oDx8RSYSuMq
         A298RnX1Y3Odd4n9d6sI6FoTtGTsbd5UY8WEFcBEjPocwjAhukKMxpG362F9fG7i277a
         18xjxYRj/fSu1qEPg3gp0SZnn9sR7KLYMpl1v1VbA1SJQcK0hsL9+6FEK6nGizfHR5zk
         e2Yw==
X-Gm-Message-State: AFq9FYIaLW7dTDMtaXPJ+1WRHK99VzNicIq6o3gZ/O+z6loBl5BAIJxY
	F+AKEXcim3ykPLd4xLw9+0GbHQhncnJb7DFwbGPne0k/hdH301LghsrIemphN3aWqXqRQCheedH
	3LpHTN6M=
X-Gm-Gg: AYBFou1LSTe1I99kSVMhZ6aiAIiZJm+0LExJCAvB0/EkfZ1aHCwGHJk9ifOsD5SEx93
	9JvcCNi+7BKq6K+MmzF3GzvqwMshkfwkrGX9HM2G/zJ57NWBYBvm54vw7xJHGR4VLNg97nB8b61
	CptcwCQrJd+mu5XUGrMOF4Eonu4k0RVqhgaRVBzX8KEuMvInN4tZtDwxscSAsZHMBk6roaToIUT
	Jlrs0JzWdzNYRf8qMuOjOLfFgOnGT0p5ssRGuiUBUH9XdzssLCld6FQ7D5aU8aLG+Pj+K2C/IJb
	mCiarN+d73j3CH9dMhJb6Z/u0JKjaeY/BUNOYgWkuNtI5aH6xIelSpDAC5YXL+8DRkCXtPWpq1E
	qHUfteIaSJPgHUkA7qdFT52zDpYH/aHokfCbTNMjI9cfYELND/ozVNtEzVUUoKK/qFWpAJ8IcDs
	2Kn81XVlhqpm9+G0i5WbMb0FNNULjNEh6hKmDum3JxvRz0mQKiAEqRd3IXYR3INFfSXAeC6Q2/T
	mtkWpQ=
X-Received: by 2002:a05:6000:41d3:b0:488:7f1d:2728 with SMTP id ffacd0b85a97d-4887f1d27e8mr21155180f8f.30.1790673200763;
        Tue, 29 Sep 2026 02:13:20 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af508cedfsm2568089f8f.30.2026.09.29.02.13.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 02:13:20 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Junio C Hamano <gitster@pobox.com>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH v4] push: fix --force-if-includes when remote-tracking ref has no reflog
Date: Tue, 29 Sep 2026 12:13:18 +0300
Message-ID: <20260929091319.86392-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905171330.34646-1-f@lex.la>
References: <20260905171330.34646-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 99a1f9ae10 (push: add reflog check for "--force-if-includes",
2020-10-03), is_reachable_in_reflog() looks for the remote tip in the
local branch's reflog and stops at entries older than the newest entry
of the remote-tracking ref's reflog. That timestamp comes from a
callback of refs_for_each_reflog_ent_reverse(), which never runs when
the remote-tracking ref has no reflog, so the variable stays
uninitialized.

With the files backend a remote-tracking ref that "git clone" created
has no reflog until it moves. On my machine the leftover value exceeded
any real timestamp, so the walk stopped at the first entry and the push
was rejected with "remote ref updated since checkout" though nothing on
the remote had changed.

That stopping point assumes an entry older than the last recorded move
of the remote-tracking ref cannot be the one we want. The record itself
can be missing: never written, deleted, or expired by gc. Initialize
the timestamp to zero for a missing record. timestamp_t is unsigned, so
nothing compares older and the walk stops only at the remote tip or at
the end of the local reflog. "Now" brings the bug straight back. A
fixed age narrows it: the push is rejected when the remote tip is
recorded only past the first entry older than that age and nothing
collected reaches it.

When the remote tip is not in the local reflog at all, a stopped walk
and a full one fall back to the same merge-base check, and the full one
hands it more entries.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes since v3:

- log message rewritten. Two things in it were wrong, not just
  unclear: it read as if a walk that stops at the cut-off skips the
  merge-base check, and it said there is "no such moment" when what is
  missing is the record of it.
- test uses setup_src_dup_dst and expires only the remote-tracking
  reflog.

t5533 passes 24/24 with the fix on files and on reftable, and the new
test fails on both without it. That failure is only reliable when built
with

	make CFLAGS_APPEND=-ftrivial-auto-var-init=pattern

otherwise the stack may hold a small number, as on your machine. So CI
would not catch this going uninitialized again.

One detail the expire hides: on files it leaves no reflog at all, on
reftable an empty one. The callback does not run either way.

The batch size growth looks worth its own patch. Not touched here.

 remote.c            |  2 +-
 t/t5533-push-cas.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 00723b385e..6d301698ca 100644
--- a/remote.c
+++ b/remote.c
@@ -2751,7 +2751,7 @@ static int check_and_collect_until(const char *refname UNUSED,
  */
 static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 {
-	timestamp_t date;
+	timestamp_t date = 0;
 	struct commit *commit;
 	struct commit **chunk;
 	struct check_and_collect_until_cb_data cb;
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index cba26a872d..c9aaeec8d1 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -396,4 +396,20 @@ test_expect_success '"--force-if-includes" should allow deletes' '
 	)
 '
 
+test_expect_success '"--force-if-includes" should allow forced update when remote-tracking ref has no reflog' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		git pull --rebase origin branch &&
+		# the bug needs a remote-tracking ref with no reflog, and
+		# the fetch above wrote one
+		git reflog expire --expire=all refs/remotes/origin/branch &&
+		git reset --hard HEAD^ &&
+		test_commit I &&
+		git push --force-if-includes --force-with-lease="branch"
+	)
+'
+
 test_done
-- 
2.55.0

