Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79F4D0A0B
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218154; cv=none; b=oYzjFwn7RfMGm8g1TRji8nhbmTenFnvQYohXjYp2HtxPvbO5OMcnSIiH+0IhAQDoG2Fd3cwUWrCXu7DZrvFFen96mxoAx43GdaQFQ0BDcBXZ76DP7aUSwidjoqlo6GwxgKOjZk4TsABha255f4zdGiqmpHF5MTxsWLQtMqxbb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218154; c=relaxed/simple;
	bh=huhBkjWrm8qm8wLP/pYt68TC7cu6bWurYpwoY9mSRKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAmLAbGWBMn9ffeHdVAjgKVa/uE4Fym9w4qkK71jRcRWuamA0ZNLUyJ3lJZ3znqVLStISpPMnWLn6Ir6CGMy7ybOIkDuVHS/vQFPFun8HWHLbs/lt13tIHt/Jo+b1jsRayx6tZDSHorbM6GX9KWI3KTnO8Sm28ZBDWoQ6iZnumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fepm+/6t; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fepm+/6t"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so13402275e9.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791218148; x=1791822948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eyMGIkLSUClzwQ7044oyeFDPtkDW5LdxQzwVsKcK52M=;
        b=fepm+/6tfl7f6TtZJSolmiuSRE3gdGZnotUvPIy3EEQQUvjur+lDeJhFvvt+046J4a
         JnKEPK1NN4Z5R9Ocxp43iVmYRR4i5sHvkqvSBXRs8BXnISyWT61SV/IMPIqfgRtqh6PM
         PfzCU123IY4FSrsbtZA4QQLY87ceI96FsdSikQQ/i04IaLlzeLLGemzm9knJNopn4EDO
         2ttt1TsGEGK/GD0NOkPsZDxaTIjtVRK9+NFkqKCceOVkDYNVu4ZFg+ho+4YeFBM6cLvE
         gTboel/bG35pL9X9I7QpKxh6KfwUQDkxUuOKnS3bz1hiW6bCSYqUkAOHEaucHS319oGv
         Cc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218148; x=1791822948;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eyMGIkLSUClzwQ7044oyeFDPtkDW5LdxQzwVsKcK52M=;
        b=O4BVa29eq9k6tA+UM9Hy+1Ig2ypiXxzYM8rc2ESmuKePovuw/zYnpP/Ci00UFROq/p
         Zt1DtMOAQnyq8nzhkHcf+C5ozK+FZlr2i4UIGv7hbskMzsGDoO67Gg7DBlbadNNwQ3y5
         pTZuXEXXxbnzxAgwy7HFTW1g5xFm3Swsvh6GMZeBGI6vicqWf/ILh2FFoZm+cyuM5Dmc
         7SP9ZZoRmO9o6DEtKt+3DPzGLKoE9Pi5U9VxQ7B0mpciD0iyJqb3B4PRE47FmA5UsCG8
         CXpjb0f7RjYnPDRYlRwwXb6XhWYaLxjzrLbwrZs5i4/Ikr7zI8qUoXz+KC5H7WKkl+5I
         2Zjw==
X-Gm-Message-State: AFuF++nZrTwsUdcsBXSRr4SHkSFLZWZxzjRo8+HlRTi0c4TA2kBFB+cQ
	I7+tsB17Ea/Glvt4fxb/0EF0VjvWi/p+CiUjKnV+5DuHd44/qtiaNnccwJrx/grv
X-Gm-Gg: AYBFou391ro66glHs4xVyP81PnPnXHZvoWmP9aNodfx1AOXOZBFJqK8HaX9rZcXFCSQ
	H7qaHd8uDwEjH30z5NIRUJF0SkkNFmp9oDBTg2cOWz5Z8aprcKrraFucuaUbygnM3AHa69sMkZu
	NVYSQd9jMbYLYbGRJimoMgP3rUV8SwKxgIiBXbxec3RPhgnP/GIWD7aHNHcHeaEpx4Y8pqnuBDb
	GxthTJ9Jq0K4vS2XNSYoKrC6XHB6bc9TPUPMTN2J4bf2ZrGb9SUkKNthTm5no85yMZNMwosLZQF
	UqDWosevHUf5GP/tmWW2L7S2esZXZX7HclVwbTJjxauXm2o9jg2tLhq3OwpIBPw+Uf52TFodqnC
	yXP5HC4b1MClhmcbdLO8AgguwF1pFeq1LAhmjZJ+zxMBvZSg2KgzZrXeD0G9A4eBTuTRkuNRtJL
	LsVxQxYHYyABmMzXd3Gn0m6b8gVC3m/l7fWsGoDlXVU9rIE8iJNABAPF/Ie72KiAFGC4OwkLh0d
	w==
X-Received: by 2002:a05:600c:548c:b0:4a0:1eb1:133b with SMTP id 5b1f17b1804b1-4a0275599aamr189746115e9.12.1791218147941;
        Mon, 05 Oct 2026 09:35:47 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6229e025sm4540545f8f.31.2026.10.05.09.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:35:47 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/2] stash create: remove duplicate changes detection
Date: Mon,  5 Oct 2026 17:35:30 +0100
Message-ID: <1617d92942d283017272ca6f27f1254f8f9389b0.1791218125.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Before it creates a stash, git checks if there are any unstaged,
or uncommitted changes. If there isn't anything to stash it bails
out. Since ef0f0b4509 (stash: optimize `get_untracked_files()`
and `check_changes()`, 2019-02-25) "git stash store" has checked
for changes twice, once in create_stash() before we refresh the
index and then again in do_create_stash() after the index has been
refreshed. That commit claims it is an optimization but it is not
clear what it is trying to optimize by checking for changes twice,
especially as checking for changes before refreshing the index is
unreliable (the scripted version of "git stash store", called "git
update-index -q --refresh" before looking for any changes).

Avoid checking for changes twice by removing the call to
check_changes_tracked_files() from store_stash() and restore the return
code handling in store_stash() that was removed by ef0f0b4509 so that
we continue to exit 0 when there are no changes to stash. In principle
we could remove the call to check_changes() from do_store_stash()
instead, but then we'd need to pass in the list of untracked files.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 7a9843413b1..9a5006e3d92 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1655,8 +1655,6 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	if (!check_changes_tracked_files(&ps))
-		return 0;
 
 	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
 			      NULL, 0);
@@ -1665,7 +1663,11 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 
 	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
-	return ret;
+	/*
+	 * ret is 1 if there were no changes. In this case, we should
+	 * not error out.
+	 */
+	return ret < 0;
 }
 
 static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
-- 
2.56.0.134.g299a3c16181

