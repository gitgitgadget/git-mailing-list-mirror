Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2202D3ECF
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780862858; cv=none; b=c2LDVHh2DLCEVj1joHQQA9w6HMXr/3Zb8eY9Dr1lGqvFHYtXyToFhy7pcGNlxZyYLNH7gXj8EE11swJymBHXfHFepIDsB59lQKL5mbr/8sKoYZqF2+HX70dp8wKGGFTvcTA+UuXjFT7O3VbptSplhwYRXJnBkiI7eQtGX625/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780862858; c=relaxed/simple;
	bh=E3YH2NsR3c0AahacOCDHLkoZj7zmhVAWg6C2tLy5Zmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmXsQbMS1I+j1+/Y7rcRUzK9RMzLocuRoZXZ6GiprlKTqiFWNrq8H4IB2i70Gg1OO9d3g0/4FzHiE9GfBI6axsIOfrt24u62z7IE/NGN0UxlEhFLtwtYU+9Cq8HK+v/nRxYquZf26nkaS4CD85e2BUm8XuIflv59mTxPdCO7iLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ1in4Lp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ1in4Lp"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef616daf6so3193000f8f.3
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780862855; x=1781467655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLgJZ5a9KlIc4yY9JP7NcwQI/C1fNfirNTu+ufN8Y/E=;
        b=PQ1in4Lph1rTk66fUpfGFziWgSxPDVyt/kq8jbwsuZi1lTZuTxtwvCBSGjaFgS493g
         Y06NWN1s0THgsNNNvmAvXwnAp+FvzLdkaGoeTVm6b0AvEjkPknrmQu2raHxcNrks3iYC
         Bm2n+qqoRXDdjBloo4xQDqMFCfiCdBL5Tg5kgSxTWe8HfIOaBhbkqwEl+zMwF4LSozdG
         i3TgsAEvWZb+e5ZcOKrAWb3YmQQyseg/W7yiJm+Ysibzi/grgCQqRY+lMt6nGeKR0srb
         yE5qzj2wO19RTIOtYcc29F2jXdX6Nz2ZMqt6PedOGYtL+uS7C/SmuEOEos8sb5SevQTa
         Uapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780862855; x=1781467655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iLgJZ5a9KlIc4yY9JP7NcwQI/C1fNfirNTu+ufN8Y/E=;
        b=Llocqpkz3/vskFtCwEX0OM1NMBEfdxSoWBvXPABvJeIHI8UtYGtIvSBCfzzXN5MF/x
         WMCv7tutZzREoAM+7Zvq44q8gus16svN8EkrfjW+kUJPrh7geHElPpppf6PYHzeozwdp
         me6EQPydOURG6L/AXC/HWxoGElP/V+FImwW50aQXeVUudiG6+x5dCyLVJR26wff6UCxy
         ySFAiJ7pNQGtFz51dKPTQl46ZRFcqwPdD/G5OPmheN21i3CzkTlaROOcLKJLjgolkhRb
         +gmkeveOGh8Nk9DXN84ahQL7SHuxw9v76E/WazmXRehTlHV4141EF7ecxhXrPHLhKQX4
         +gOw==
X-Gm-Message-State: AOJu0YwpzcmSMxUK4lHLQoX9qUmcpKw8nv68FVBshynwmPjekdputVjL
	ZvDaqaab/nnL9c9JHCCEgFIcUzbHjfHt8dgw6hBJexuZsUqzakcwHZQHPx6eBU95
X-Gm-Gg: Acq92OH8DYkgQpQLbISnzf2EjwwLB2pVlWgvT4sHsDfyzlBb+2eplY1KmIZyHjOrer6
	Gz+ZsYXuf5zfcx97jJX1WqWzxC1HjU+UHjM/X6LLONHqiweJDPB6txFn1QgcvpZHv8NW8O7TkvK
	X+GBoMgFP073/BTTBZZtivtdn4FpfDsbaUXBloYh8c1gIoiCsbPOUWlWMMZ+2go7shtPNhJ08Jh
	wUHwrFEoCJE5W9S4h0CuuwIgBji9OmvHTFQRf8Suim8dYtoXyczFVv9Np83oSGWIZuqBnOpTXWM
	N5OquiLIVzKL0rVrlP146IlSw6LYLkdtVVyXajhRH/WlSEmVBnzVkiL7GGuG/F9S9eBrUbQDwNj
	l9cqq2Q9GDnj3hR8wdZJA7GwPPBqBQP3J7PLPxKHOX8R4+ChDaGFbY4BQX7XV38ylcO/NVDcwAM
	3KdXQIEx0WzKJY67nwbA+354dnl1FrvYDd/58i6dHhpGdG6OeExnKYfDUwbWl4FShsJ+6Mo9Ov5
	33SMiG0FFg0FTjpF4ePBYXRjsNL9aN73y0vpgNmTbHu7C8NpL6EidrN04qmIM3bZ52aW7uP5af5
	CVJ+QEgj4laT/T7Arz6T/iaPwnqkcXcrUpRLELQuQKyaac384vTsc8VbVfsH/1KeI1Naxlt5YNG
	+sHe25eSNMIF1Hg6ljXJccJpoJ84PoE7V/JkHrbPXOfIlUJTwtXa+BrJ4XrddV3iKU4YknO4VGw
	jC5zZJT2s31cP7+VA/C3RCGZxR
X-Received: by 2002:a5d:678a:0:b0:45e:f381:cd8a with SMTP id ffacd0b85a97d-460302dcad1mr13737188f8f.2.1780862854831;
        Sun, 07 Jun 2026 13:07:34 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (static-21-4-87-188.ipcom.comunitel.net. [188.87.4.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm35511890f8f.10.2026.06.07.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:07:34 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sun, 07 Jun 2026 22:07:20 +0200
Subject: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
In-Reply-To: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

When using `git history reword` if the new message is the same as the
original it continues anyway creating a new commit with the same
message and updates its descendants, modifying the history after this
'reworded' commit even though there was no actual change.

`git commit --amend` and `git rebase -i` + reword share this behavior,
however `git history reword` is different:
1. Works in-memory without touching the index or the worktree [1], so
   there are no side effects like staged files that could justify
   rewriting the history when the commit message is the same.
2. `git history` by default updates all the branches [2] that contain the
   original commit making it more costly than `git rebase -i` that only
   updates the current branch.

Add a check if the original commit message is the same as the new one
and abort if so.

[1]: https://lore.kernel.org/git/20260113-b4-pks-history-builtin-v11-8-e74ebfa2652d@pks.im/
[2]: https://git-scm.com/docs/git-history#_description

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/history.c         | 10 ++++++++++
 t/t3451-history-reword.sh | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/builtin/history.c b/builtin/history.c
index 0fc06fb204..51a22a9a1c 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -135,6 +135,13 @@ static int commit_tree_ext(struct repository *repo,
 					  original_body, action, &commit_message);
 		if (ret < 0)
 			goto out;
+
+		if (!strcmp(original_body, commit_message.buf)) {
+			fprintf(stderr, _("Message unchanged,"
+					  " aborting reword.\n"));
+			ret = 1;
+			goto out;
+		}
 	} else {
 		strbuf_addstr(&commit_message, original_body);
 	}
@@ -718,6 +725,9 @@ static int cmd_history_reword(int argc,
 	if (ret < 0) {
 		ret = error(_("failed writing reworded commit"));
 		goto out;
+	} else if (ret == 1) {
+		ret = 0;
+		goto out;
 	}
 
 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index de7b357685..54ea8a7207 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -396,4 +396,24 @@ test_expect_success 'retains changes in the worktree and index' '
 	)
 '
 
+test_expect_success 'aborts if the commit message is the same' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+
+		git rev-parse HEAD >oid-before &&
+		write_script fake-editor.sh <<-\EOF &&
+		true
+		EOF
+		test_set_editor "$(pwd)"/fake-editor.sh &&
+		git history reword HEAD 2>err &&
+		git rev-parse HEAD >oid-after &&
+		test_cmp oid-before oid-after &&
+		test_grep "Message unchanged" err
+	)
+'
+
 test_done

-- 
2.54.0

