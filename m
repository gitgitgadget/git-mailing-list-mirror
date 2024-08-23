Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF961865EE
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417053; cv=none; b=S3p35nEyHmyt1tT0BxTEC+stEyrCOfGqmcMUqe3JAkQG0jeyMPMSyT7j8yhRX290h6mDwqyK5m+TeHz25xL3U3qY9VzQgyZI71ODmrFVHlAy0NPwQ5bNO6V7kY+E7Ij2xK+t9gNMfQxihz0ILUrqSVOWHJ1iDB5CW4zZrKi+M+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417053; c=relaxed/simple;
	bh=pShdfL5DyaDkyb2qj+zt00vbZTuiAEvYjUqDw6kFjXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE7VDnMZLC5/Qnm517F4WRIM/jZDwsEATcAJ52fNf5bMeb+PfMzzwo8gxCQHICBoSU+BIKP2KQr4cxWGcmX7iwpz7JhT+/ouoCp2njEr4STlsh+OM/JvqPzSlazhLD0jtzN1hUCqry/A34IrdhWxu3aaGrSH19BSjz50LiIt4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GBXPSw4v; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GBXPSw4v"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-709485aca4bso1335601a34.1
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724417051; x=1725021851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zbu7mH6e7/7IFLivkTHCmTicxEdXAGGnDBzecr0APs=;
        b=GBXPSw4vanDepzg5Jj7KoXf9IcUZ8diwZSpdSSDZm2Tvvg/f9I/2kCHCZ5C9jKFGNE
         Wp/Vf3CheOecOY28rnCmGFds0yKTND1ewlGPRrOFjyZqjF8WF26JwIzmwr+XjyXUIOr2
         NcTxDO4vesfQq6aO6eRECirK/cEQ8cNnv1hCqfxH6ldSgi7hhFOrkEWxBiTTUA/YAWup
         AayfDLgmaJZEzkBLevjEKq/4B48hzRhPIVrzIJz8SaCvt5d3lAjFJlGe5OC8ouOxjdIj
         OsLvKBrJx/hY7gcRVDFCccZEND/fWzvABG3xm+n0te36lRseQbhx2dyz7HdXEG2oEyII
         x7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417051; x=1725021851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Zbu7mH6e7/7IFLivkTHCmTicxEdXAGGnDBzecr0APs=;
        b=JjyHGCpi45sSwbh+ukkbMefc53FxXM9nuAUQeqA+cixR9KWSeqIwFs6weLWFaizcTQ
         iZ47Mw6ih4h/UvKi11TWnx4vYIfkQsLPhGk+r9YHsBOIntDLBe9BQqAnzj9276fzC55a
         582KWunqTrT0zWAFqheKsH3+85FNWACQPk2WTyLlcDvv0UcSklVUYmPjnGzOeed2ZfLi
         ohf3T2MG/mw2Wyc24vTQAjn/ZGzm/wI6RfAxI3Ei0kmb9bXpYmFWzJR9O6BPLVdl/kKL
         m1cxgPiln0DHtzxEhzvwB8dp+DYaTp8hwB68M3rtnb2tArJAhkXcN9DpWzH8x+qfjdCh
         VBJQ==
X-Gm-Message-State: AOJu0Yyc5ilO1/a7N5t65HzF7kmM4uBFOn01rdsqfHu63bO98Bjfz38G
	8W3Gc8p38hHT/H7EF5c5jY0Zrx9WtNFyvJAH5dvDREAW5XkIsOvFU7iFVID0GlEGJJSm/w/6zYQ
	a
X-Google-Smtp-Source: AGHT+IEo6AblqlNvZ9wYxrbGF7/c+p/ePxw39l70p/KU0BQuUkKoE+GJED339ze0CYQmL478XqV87A==
X-Received: by 2002:a05:6808:1508:b0:3de:13bf:3092 with SMTP id 5614622812f47-3de2a86db99mr2228260b6e.24.1724417050755;
        Fri, 23 Aug 2024 05:44:10 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad56c5esm3068023a12.75.2024.08.23.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:44:10 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [WIP v2 3/4] revision: don't mark commit as UNINTERESTING if --exclude-promisor-objects is set
Date: Fri, 23 Aug 2024 20:43:53 +0800
Message-ID: <20240823124354.12982-4-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823124354.12982-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20240823124354.12982-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if commit is marked as UNINTERESTING, the bit will propagate down to its
parents. This is undesirable in --exclude-promisor-objects, since a promisor
objects' parents can be a normal object.
---
 revision.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 7bb03a84c2..02227e6a0a 100644
--- a/revision.c
+++ b/revision.c
@@ -3609,7 +3609,9 @@ static int mark_uninteresting(const struct object_id *oid,
 {
 	struct rev_info *revs = cb;
 	struct object *o = lookup_unknown_object(revs->repo, oid);
-	o->flags |= UNINTERESTING | SEEN;
+	if (o->type != OBJ_COMMIT)
+		o->flags |= UNINTERESTING | SEEN;
+
 	return 0;
 }
 
-- 
2.45.2

