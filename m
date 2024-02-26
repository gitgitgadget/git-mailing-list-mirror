Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471412C7F6
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983572; cv=none; b=qoRVpUQ+vGUK2lCBcxgd/+C01EaRHnj4ZgL+44LtAhw2qewu8uF9VA7Y8iEB2Op8SEm/09tb6mH8oWxvSgozD60NkdEWxKZoD3lLXZFkoX9ep+3BHXkM0Vcd+DVpwGA31bUTgkUkO33Caa391MuO4z2O5jxTGo6uSgADF/AtfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983572; c=relaxed/simple;
	bh=FKmDwszd8j4PtKBkMGfED1fxwvx/9tAnkZfU3CzKlD4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I7KAcm7HQzn3RJDK0olOLL6bupzxYn9S6yDWwT2cw/BL/0WSN73BKYMe5VLMtOzrmEPx9mLa8YnO6djasDJxUzfIpzwWadzhgve4txEtMZEE6QZRi6+ItXhclJMgtP7JETvC32TIC3QzGiffFmfT8egZfhXnkLYj6Wci41SQuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwOP0l7h; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwOP0l7h"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41296dce264so24644735e9.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983568; x=1709588368; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojRn63jU9XfSAQzkLgCCW9dMjb3fFbMEE1XrppnOcnE=;
        b=KwOP0l7hEkKpy/w4U68bFK8zkWfsEs4yIMfLNLnisYegkoasjq+V1AEIHWE4SCbDON
         axg0bn8QCj2d035DrrRL8XjYlSu/VCmrXnCrOeJLhrPBanIEDbycB2hsFOp2MEXfNQKc
         /X+GKPwf7OaHITENDqHxW9ZmFq8Q8HcAJlYinlRPkw/Fu8YAMI5xcjw2IbBk3lT3ha3s
         1PPbs4eDiFksfKhDjavqySUVOPOO7TUO7T6Uq34FFMEb0T8eIDb5kboHpx3zo/kII/K6
         lgafUwxrNoCTVPCmXMJg5Gwli6K6hfozUWzcU2eytqE9n8qR7YESbfbdsw6lhwtsyQXv
         ro7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983568; x=1709588368;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojRn63jU9XfSAQzkLgCCW9dMjb3fFbMEE1XrppnOcnE=;
        b=q8ud2aZ0SeQNQJGjgP0hVwDw5Kz9EduOE5Qh3R2fTJSFmbYlOA9hk4CWfq00X3Bflb
         3CCzhBoEJ5pE2KZ4L4AjfltSZOcjYJUEG/zaNhXnluCLZVXcGjta/E9fpZv7WAYmXXgi
         NmyQXWPVyA8MhqzJksiA9J2pQb+PujVWnYsc9EYRrqPanXskAV0F/boYAMfLUdlWRvD0
         xlUxCAiJ9DSPOTEJtF+d9jd+AdubhUS0Bt/MNC61tyMN6WIZYl34O/rcErk0WjrNRl5Z
         80QtG96fKx1qII8uZ3lIH/ZvijQMPZU7Ij6wtobKHHTrL0jctSlHf5nbv+tO2YHzo4Eg
         +mEg==
X-Gm-Message-State: AOJu0YwEJVkpM9kwvjohJlI5r5MXHylt3pW9Gm5GWPrKkqVFOoqzC80D
	TzJ5cxPasAZd5dMgyvWAKf2dslzY2Vxzi7MKcZJI0+rac9qLx7g+qhO6duWc
X-Google-Smtp-Source: AGHT+IF8YPFB2qyjQcpRD8aVBBevsIRXhxwXj9/Pzto4fXa3cxmbMRs39GITPWM8IRhRkGxBkQFmOQ==
X-Received: by 2002:a05:6000:1046:b0:33d:9232:5aed with SMTP id c6-20020a056000104600b0033d92325aedmr5301638wrx.52.1708983567914;
        Mon, 26 Feb 2024 13:39:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17-20020adfe291000000b0033d56aa4f45sm9144298wri.112.2024.02.26.13.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:27 -0800 (PST)
Message-ID: <64ae07aaeaa2f9e91d153ddd1aacefb62188456f.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:12 +0000
Subject: [PATCH v3 01/14] name-hash: add index_dir_find()
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

index_dir_exists() returns a boolean to indicate if there is a
case-insensitive match in the directory name-hash, but does not
provide the caller with the exact spelling of that match.

Create index_dir_find() to do the case-insensitive search *and*
optionally return the spelling of the matched directory prefix in a
provided strbuf.

To avoid code duplication, convert index_dir_exists() to be a trivial
wrapper around the new index_dir_find().

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 name-hash.c | 9 ++++++++-
 name-hash.h | 7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index 251f036eef6..3a58ce03d9c 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -685,13 +685,20 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	return slow_same_name(name, namelen, ce->name, len);
 }
 
-int index_dir_exists(struct index_state *istate, const char *name, int namelen)
+int index_dir_find(struct index_state *istate, const char *name, int namelen,
+		   struct strbuf *canonical_path)
 {
 	struct dir_entry *dir;
 
 	lazy_init_name_hash(istate);
 	expand_to_path(istate, name, namelen, 0);
 	dir = find_dir_entry(istate, name, namelen);
+
+	if (canonical_path && dir && dir->nr) {
+		strbuf_reset(canonical_path);
+		strbuf_add(canonical_path, dir->name, dir->namelen);
+	}
+
 	return dir && dir->nr;
 }
 
diff --git a/name-hash.h b/name-hash.h
index b1b4b0fb337..0cbfc428631 100644
--- a/name-hash.h
+++ b/name-hash.h
@@ -4,7 +4,12 @@
 struct cache_entry;
 struct index_state;
 
-int index_dir_exists(struct index_state *istate, const char *name, int namelen);
+
+int index_dir_find(struct index_state *istate, const char *name, int namelen,
+		   struct strbuf *canonical_path);
+
+#define index_dir_exists(i, n, l) index_dir_find((i), (n), (l), NULL)
+
 void adjust_dirname_case(struct index_state *istate, char *name);
 struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 
-- 
gitgitgadget

