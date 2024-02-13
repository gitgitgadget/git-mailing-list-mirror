Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99661664
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857548; cv=none; b=UvBFel2zxEFhI4TTgSu9kaAAER4An+asgwqP433uGs3glmwcm/l4nsobg3PoeBxD888hm+dB312R+jrfzcVCZe2cntGLpzdb5yyYDjk7RXFZsnSmfDzSJwa177r6nbfFbwtT/ep9S+cnBwVCdRYRcOScxu6Bfg5OB7PUTZafe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857548; c=relaxed/simple;
	bh=IR8eqPDa/F5VetSJPo06qDYzDIC2LWswTrMTPwfxyFc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dTO6dTHSL7fZVbI+d0sOOksYTm+yNdgE3qADxdEy+QorFWZTlyn6xDN7QVKqb8Dk8N+ChrgQRPtPizz+Q6mWzMxtQYoXa3ft5Pxp2nJcRmskGoDHAHNCagxQFDZHoGk8LEQCHfebQz5gj4fkQNmZ2YXIajNCK+eaXGkjR5dAULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JikCt7La; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JikCt7La"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0c7e6b240so65756401fa.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707857544; x=1708462344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FfJ8OLbW0SLI3KnEqx8Hdgwz9ENLAvM+QmJC0JSTDs=;
        b=JikCt7LaFFxXYL6RYjyV5zRmVthsMe2I1bIlHPr3bmFWNYS77rvmLw5ZwqA7uvTswm
         zUkCT1Qm8OGC97Lk5gZy7toQph6Mvjc/5ELOhPoxonyFQnz6Pqp2YSjQVa6FWi0oE29Q
         KLYYiR8wXX843LONkHwPBgQjrHFV8xMqGwfXtjTV9XT9TvEEG1DoHex30z2SCicSXfFr
         n0g1Np4EMZDDHO1DhSDXxTXkRu5xazarFc1wl1TeTONqhREdOOT2B2gXK8sJsJpY/0Om
         POhjoEYvQNG8sCfLB8Oy4+PWyNOSqYB1T1eoNhvp41YqDzSkJokVdzrTqvuESK6iVvUP
         a81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707857544; x=1708462344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FfJ8OLbW0SLI3KnEqx8Hdgwz9ENLAvM+QmJC0JSTDs=;
        b=RMM2c8He9XsrsizuvxLOVlyxP7uSzR5ndgyCTkJj5DjD9F0BTRz1TjVcDxjglmAC0e
         EwAHBJkl0YZx8ELrct/kSqgcUDLkWd54iAq8gSUTx9+K5AtcZIOIrJwCIxEPSj9ZOn4V
         Fw4dRZ89jAiLYCdOK8xztrcSk328y674PlZVyQ3YHqOB8ppsytbg+TMj6bQsuVvIXdQY
         bmzG7DyFwGB6fQCvYcZTcaD2LDg6IVDaN1/QrOcLpmQVI6BM4FkluYogznZfB3WIrvSF
         NsbLCTQby/ko0keDGKIaL4Xi9NK6EjNKlDXs8QDGKXTIGRqu6W+iOm7wuQ2NPex3lgc8
         Q/Vg==
X-Gm-Message-State: AOJu0YwxJAzK1sPBlFqzeNY8gr+gCFPYCGOS6v+BBY6JIZEhlnjG86U/
	bk3OV34zqaMJU2SGGJsl+Iv8PAK9zzYYlQEXVpWeOa+yMmZG1e5BVuDERDzi
X-Google-Smtp-Source: AGHT+IG8/wsXwGlfdOXMvwcrA2it7RBLwZ38CE857dXTpg7DDIGlNCclLAd7HU5YCx1gfo3Ntk7ycw==
X-Received: by 2002:a2e:8e2f:0:b0:2d0:de6f:c697 with SMTP id r15-20020a2e8e2f000000b002d0de6fc697mr462739ljk.13.1707857544103;
        Tue, 13 Feb 2024 12:52:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b00411b7c91470sm2961404wmb.12.2024.02.13.12.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 12:52:23 -0800 (PST)
Message-ID: <3464545fe3feceb08408618c77a70cc95745bfe9.1707857541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 20:52:11 +0000
Subject: [PATCH 02/12] name-hash: add index_dir_exists2()
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
Cc: Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Create a new version of index_dir_exists() to return the canonical
spelling of the matched directory prefix.

The existing index_dir_exists() returns a boolean to indicate if
there is a case-insensitive match in the directory name-hash, but
it doesn't tell the caller the exact spelling of that match.

The new version also copies the matched spelling to a provided strbuf.
This lets the caller, for example, then call index_name_pos() with the
correct case to search the cache-entry array for the real insertion
position.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 name-hash.c | 16 ++++++++++++++++
 name-hash.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/name-hash.c b/name-hash.c
index 251f036eef6..d735c81acb3 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -694,6 +694,22 @@ int index_dir_exists(struct index_state *istate, const char *name, int namelen)
 	dir = find_dir_entry(istate, name, namelen);
 	return dir && dir->nr;
 }
+int index_dir_exists2(struct index_state *istate, const char *name, int namelen,
+		      struct strbuf *canonical_path)
+{
+	struct dir_entry *dir;
+
+	strbuf_init(canonical_path, namelen+1);
+
+	lazy_init_name_hash(istate);
+	expand_to_path(istate, name, namelen, 0);
+	dir = find_dir_entry(istate, name, namelen);
+
+	if (dir && dir->nr)
+		strbuf_add(canonical_path, dir->name, dir->namelen);
+
+	return dir && dir->nr;
+}
 
 void adjust_dirname_case(struct index_state *istate, char *name)
 {
diff --git a/name-hash.h b/name-hash.h
index b1b4b0fb337..2fcac5c4870 100644
--- a/name-hash.h
+++ b/name-hash.h
@@ -5,6 +5,8 @@ struct cache_entry;
 struct index_state;
 
 int index_dir_exists(struct index_state *istate, const char *name, int namelen);
+int index_dir_exists2(struct index_state *istate, const char *name, int namelen,
+		      struct strbuf *canonical_path);
 void adjust_dirname_case(struct index_state *istate, char *name);
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 
-- 
gitgitgadget

