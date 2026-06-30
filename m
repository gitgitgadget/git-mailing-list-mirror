Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3BD3B71D1
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833364; cv=none; b=GaNpuMbLxqELOdaEHjOQBAzHvOApHDNqXXikFCF8bhXXNX0fHXbBEMZICXBfz3S4W4td/uDa5MX8zYiJxRpVrBYtCZue0dmH3Gdm97ECBd1JTtXC8lF2f00JtEVvAk3efdnBrN4EIS48ruslU1GPHDP3dkbOkcKpY+0hML5gUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833364; c=relaxed/simple;
	bh=DRByKRfTAjmsA/mZtJFr7XqrIpcgAwNceEh9YMoHPlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6tFR7jnlmq4ik94Jm+5FsNBJzE7yOdXvn9L3KYRqYPjayUPdmntJC6gcpIVGwKL0bKVva37ptlCa/YXSRbkLte+a3O2G6zBTty/DCXtONhqqjdrhHyxre46RokXj+s2+B/hHSBgujTYwPX2PVU6emaeL1x2mj5pAiPcLKLOrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4kkzD2R; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4kkzD2R"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-471eeac43bfso3035640f8f.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833358; x=1783438158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cLIFu/IzKY5Iebb6tHrpeJRFmKBeUn2USzMDsTzY8ps=;
        b=X4kkzD2RadqBPcuSH/Gy2YhBm07GAiH+7voyAIwJL9+8c696GsV0heRW1Ko0SsvAIA
         mgYTK/JYsmouhZZNOmYbQtbO5JWD1zYqv0yAQ/M0UrxURGL55m4nZ/Cjz+K7m4FbCl54
         fNRO4bpTX42C6JPGOELnLFSc9f2oAzaRsxHbt3A8UCOoX2ovG3s0y/iu5JYKX8BlA+nd
         jKACuJoUqkKaHL30T62dTiQIKHKNdpeoSWQR+CIEQ0o1jeR4vyQ+0rHFDBir/npdKJhs
         1M4RebX/UeLJvnxzOGd+z0H3suIJG8WR03vdrmEh7dpf51OYO03GP8LIfs0u0DNTrFKe
         5LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833358; x=1783438158;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLIFu/IzKY5Iebb6tHrpeJRFmKBeUn2USzMDsTzY8ps=;
        b=HYXLFFpuG93zOjB8AbkgSE+9HhMPDCtYhrayZkS+0AHDcXg8y3YecFUNWE/FpcLmeb
         7Ob9GWi/It5O/1npj6JFuApoxqYy5kkejIl6GUyrP3XbSi9flsLszkWdklKuTJ6kBfQf
         ty6Xuuh7DGfwD4K3uDg7XGZcwCd8eWuWT8VJvz5GhiCqwxnjf/Y0XG9iINLGzJ6mPJm2
         z5qKNyXOHkxWoMHDPcwJd8o7YeyGmcwrxMNswmm8hD+57vzgcFjBwmL8Me+Wwls28HPP
         wLg4r5ewRTTk/N239OYBTC76b+lOK9m1UOBhybzy2h6q+BdSjKsVBubBGyLF8V34kwAR
         hg8w==
X-Gm-Message-State: AOJu0Yz7eVcp2k0Y4C5QlANhGnP7X13r9dNmg4o0sMyxFFGNEfLoVVCQ
	RQ83ymk3cAxXLnPykBO314YVwqfuAeVVOXHyvPgWzMDQdEJ7qkVbhhls0oJS+w==
X-Gm-Gg: AfdE7cnggf1FfbezRCJjUYV/a6taZk+/64yo5UtjjjORXcRpdcSXOxqKQcYp+s7rmW0
	33wVA2hDMQ8lM0Hk7sXPfxQV0K/OjJbJ/Sl4jXYHGTSaDEJZiX/OeR60V/2vtNGYGE7X/MERH0H
	k00JIz6fTtSFxNXQP+E0hwGSJ60TctbVoBi10bHCisEso1rd9AhPHe9VC96gvJE91A90P6r7Tyv
	IYjsKX1aj9Fr2i/TghxYqw4jNSySBhlgcNoVTq6rAE0MWd0aL+4kykTXtJUSLQNWpBpv8ucb/cY
	Xp7ixL+CKBm/QTKHunEdkvbztioAihqm+cRH+o+RmHNCEXJeS9EAXNomlt3J1arxMXdSMJaklZf
	4vMSOsR2ZTXcVkLpRpglMkPsq7IIuWrsyKtcwFjUby2JJXbDiYGg+yhFzTEFHlQwhncpGjrRYm6
	+o3OvCnPQo0cjV0H4E
X-Received: by 2002:a05:6000:4201:b0:474:5a38:f650 with SMTP id ffacd0b85a97d-47657d2d0eamr1699587f8f.3.1782833357657;
        Tue, 30 Jun 2026 08:29:17 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:17 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 03/11] sequencer: be more careful with external merge
Date: Tue, 30 Jun 2026 16:28:53 +0100
Message-ID: <16fba1e823bae633da6c4b76e239aa013fe2c6c9.1782833268.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com> <cover.1782833268.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If an external merge strategy cannot merge (for example because it
would overwrite an untracked file) it exits with a non-zero exit
code other than 1. This should be treated differently to a merge
with conflicts which is signalled by an exit code of 1 because as
the merge failed we need to reschedule the last pick. The caller
expects us to return -1 in this case. Also reschedule without trying
to merge if the commit message cannot be written as that prevents us
from successfully picking the commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 19 +++++++++++++++----
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 32a09b6e87d..e6626c4db4e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2453,14 +2453,25 @@ static int do_pick_commit(struct repository *r,
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		res = write_message(ctx->message.buf, ctx->message.len,
-				    git_path_merge_msg(r), 0);
+		if (write_message(ctx->message.buf, ctx->message.len,
+				  git_path_merge_msg(r), 0)) {
+			res = -1;
+			goto leave;
+		}
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res |= try_merge_command(r, opts->strategy,
-					 opts->xopts.nr, opts->xopts.v,
+		res = try_merge_command(r, opts->strategy,
+					opts->xopts.nr, opts->xopts.v,
 					common, oid_to_hex(&head), remotes);
+		/*
+		 * If the there were conflicts, try_merge_command() returns 1,
+		 * any other no-zero return code means that either the merge
+		 * command could not be run, or it failed to merge.
+		 */
+		if (res && res != 1)
+			res = -1;
+
 		commit_list_free(common);
 		commit_list_free(remotes);
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 58b3bb0c271..297b84e60d5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1249,6 +1249,17 @@ test_expect_success 'interrupted rebase -i with --strategy and -X' '
 	git rebase --continue &&
 	test $(git show conflict-branch:conflict) = $(cat conflict) &&
 	test $(cat file1) = Z
+'
+
+test_expect_success 'failing pick with --strategy is rescheduled' '
+	test_when_finished "rm -rf bin; test_might_fail git rebase --abort" &&
+	mkdir bin &&
+	echo exit 2 | write_script bin/git-merge-fail &&
+	git log -1 --format="pick %H # %s" HEAD >expect &&
+	test_must_fail env PATH="$PWD/bin:$PATH" \
+		git rebase --no-ff --strategy fail HEAD^ &&
+	test_cmp expect .git/rebase-merge/git-rebase-todo &&
+	test_cmp expect .git/rebase-merge/done
 '
 
 test_expect_success 'rebase -i error on commits with \ in message' '
-- 
2.54.0.200.gfd8d68259e3

