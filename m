Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3E6404BF3
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833369; cv=none; b=pvF3QBEZvg79wD01CPigDG/zZmij8nVKH8BvN2SBUoEXqSQJs/Qa41lMnRaf+oHz9VHwWQ949TdNKgbHCzjIy+C2uBUvXno+wMbAOwiUnuftj1EKItuw6S8p1GVq31gERbtuwMRl7rAawMSWsBwbNsEhLic3nLRWKLDzoIuc3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833369; c=relaxed/simple;
	bh=lLVAbAbgXtue5njgNYuFnZGEEr/PFBQOPK6nA04an3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xky064Ud6b5eg0gVK0wRN/80b/NXzgrkT/H0unn1VC0zex1yFOZ8q72AoJ6A2/at6czbRPW85UehMvoVDvOtTcnH6WPiuQNiFzkJ0XS287OwzRNHxaRgDVKRxTDIvuwU4m531g9Y0s24eaaKWWzMffmj5TdwhbfA0DrlL31r6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK2wAALQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK2wAALQ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4728c12ba97so2099963f8f.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833363; x=1783438163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ULE36ecsd4IgeR44V91p2cm49W9Ag9rD/lTeJC6XCBI=;
        b=RK2wAALQg0vPap6TewfbuSybdPtzErW5vzovuFs/vVsApH0bWkT+WOIsfhBAzK27No
         QLQIHqqDNnae/GlBPe4LEsNUCOCtK8cG3Gj3pQUd3baScBgkKhitRhPFFfggIlPy0gAp
         E7wwyIqIhgRwKPMeNv8e1wzJOrOrihU9ThpCcpEh+7eyQyKq009Eg8TD4wlk66zXdaRJ
         oKFzqNz0PFfwa6EbLtt+5DDkfHBEBcWVDKDs+iCV0rqSMLeE/Hhd1/GQ2vitsT1ChbB3
         ieS6swbYJ/IkEys45F0ELqRn4Jo984B6pFhsMSgmAXwHgaldKJHBRjhUfc0U0aD4YHpK
         M8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833363; x=1783438163;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULE36ecsd4IgeR44V91p2cm49W9Ag9rD/lTeJC6XCBI=;
        b=OWLz+xXpTG48AzsBYrJNRS9KG+5TQBLVMrr1X2VlmbHjNlAmJ/6U/GnmirFIHn78Ca
         1tSICuAgPWpl4UBhSrhhzQbp+lp0gDJjjMWGJQo8xpyeg2gIrx7GiycBCtoLlHBBvXzR
         4tYiD+O+yxJmE1JOIQajiXbgQNUqtMrIjbqVOfCG5yJAzikrwnc+/q2aljZ5hNZ9KVoT
         KrlfELi/THdKvuq7E0jI0eI46T80yj+yfOMLZ7J0SmITIM8Kj72kBvaAsvtYvVWQj8Nm
         Kydlf4KmzbFXEk9BW2+Rou3LVLCbaUuCU0hyPqmXqZbd0ldxPp4fTV6Bwt9oqax5RyJG
         Gt3Q==
X-Gm-Message-State: AOJu0YxIUzn9bszh1FM9IG8tJ9drBhRPlTDL31VzuCjAkvRCtXoLpGzt
	8kmb/WNMAvROcMmDRLjL3s6GVgxi2Tv4voQneXMbQP2iNaZLA3yJibUYGof2Cw==
X-Gm-Gg: AfdE7cklIRKAXu+nI3xCazEKNsQlgryCWylDEN6K/RIfSPxpdAL1C6ehnyawi+E4N6d
	diCP7Q1kAlfRQTrY+pTNfI+ZwjLiawPdrwFyp3ScQg8De8sDNa0Qf507DlYfIjlpTYoFwBNJmTW
	6ipyOKkr8Uu/iDIeF6/g8wlyglvq9DQHxAJV1pIzWS3Ca5jwpQq+/7J+tb7H1ivPvcmbOxEGZuh
	22IApq9/TVKj6U1Q9prgirhSrbs9YFYUlEotfrHXxdVBz4vGRuDV6hoH/NVhNFu7fHdAF/Yt24R
	8VdJzPNgUCuBJvogSMDUDuvd+85QMhLhd/ONYH83+x6JUWYBIfVTb/56XuQikeobi13L+CNtQhU
	5nKxpbTIFQxIYemwvVtV6Is7ooCvLkCA5mMZFznM0T6feUU+AAVZSurqO8HHBQp/TC169ASSRiv
	TXIPpNs/k+HiMmFckJ5qW/osukXdU=
X-Received: by 2002:a05:6000:2dc3:b0:46d:df9:13bf with SMTP id ffacd0b85a97d-4765a3b80f4mr1713080f8f.37.1782833363120;
        Tue, 30 Jun 2026 08:29:23 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:22 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 09/11] sequencer: return early from pick_one_commit() on success
Date: Tue, 30 Jun 2026 16:28:59 +0100
Message-ID: <2541a4d6e3d41272c31c8fafdf4eadcbc71b63f3.1782833268.git.phillip.wood@dunelm.org.uk>
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

The only block that does not return early is the one guarded by
"!res". Move the return into that block to make it clear that after
recording the commit as rewritten all we do is return from the function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 416729f30a7..655a2e84bef 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4986,6 +4986,7 @@ static int pick_one_commit(struct repository *r,
 	} else if (!res) {
 		record_in_rewritten(&item->commit->object.oid,
 				    peek_command(todo_list, 1));
+		return 0;
 	} else if (res && is_fixup(item->command)) {
 		return error_failed_squash(r, item->commit, opts,
 					   item->arg_len, arg);
@@ -5009,7 +5010,8 @@ static int pick_one_commit(struct repository *r,
 		return error_with_patch(r, item->commit, arg, item->arg_len,
 					opts, res, to_amend);
 	}
-	return res;
+
+	BUG("Unhandled return value from do_pick_commit()");
 }
 
 static int pick_commits(struct repository *r,
-- 
2.54.0.200.gfd8d68259e3

