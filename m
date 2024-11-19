Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9991D04B9
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030625; cv=none; b=S3qDzmqVIieODZzfCAmzvS5HdiVJq2CiZHbD0WyfPMP9RA0JJmDEViHezimcNKP6zyfFj8Ut0lwU9bfA/AkO4tthqkhxKxDI7pLb+WRaAv9Zhlhk6XpOdod6HCKQrV9d4EPg8llITTkpXqcIAdpvsCviU0nps+t3iDncCPi5FVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030625; c=relaxed/simple;
	bh=LhvQQIaMVCcThIn4EaY1K6mtOP/w3nRUIfnApwsDYBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jctUaAyKohymo/pWQOSdgtRlC46xWh+om9ytH/GRZ+j1AOsnuEqoeBoThI97B4+iYS13RrTwXge/c16lNeYkPE8S9hsevJiAJgUpqM9yeFHX5r5PKRPNs6o4oeuCAkyaBzPVVNukXwbjMSdhnbqK2UHpRx5AD+TpuxPtEgF8rnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/8TLUpR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/8TLUpR"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539fb49c64aso4894472e87.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030621; x=1732635421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZ6OjmwDs7/UnYGWlZ9cTp03IXDjXqOObzSId9Tg2sg=;
        b=K/8TLUpR3wK1/i5skQnkkKjzKqtbn/2rKd3yqxJqYEp1Kw1ITcOPlbZR9RgtdI7ZTC
         wZV3TzLPgkpUCobzeAdtLBxC/OmAfc4chxGGG8pkIQHi8ifD4Z9n8+NbUkRJX8WlU1/a
         QQf46MWlEK7S1zsci0lxoBsu7yDCekfFU1+OiGelETnjg/I6HxkGhuphM7swzV9IsLLq
         cfljWt97H8kEBJ9ufUxewRMO60QCRhcY9f2RE1Ttg6VsCNp2pfjTmeesymzM6bE94sWh
         jkfGr8h5eDiYd2wKlzc6NP9h5BY+PqGR2LgPiA1hrK961q/B+kgeLjnneIYeEH7SzsJd
         V7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030621; x=1732635421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ6OjmwDs7/UnYGWlZ9cTp03IXDjXqOObzSId9Tg2sg=;
        b=QOnnI6zYu3RUABkD7f+lOtqVVL3ygQmtOYR2Bkv1UxC8Rk0ISw5KFihoUyKX9Bk7j3
         Cy6tljsdQkHUltBwZMdOe3Z3fpX2xpD7torwQcfG+1zgRvlLxmKiBsn2S+K2NaqZqffM
         ntgoJh6kzPTnPr5olW++zKB9HA/bZtFxR8tm6YD8ZXXSIy9AnOkB1JdTmDFwK19RT+lc
         4ps2Mo3Q85SWh/qFuiGbk01otNvwTsdRvUvmQpC5Y1ymaV1Ak/HNTqfjB/ZTIA1t27pl
         HQLFmq7PTnGrqe2wGAiwQsvL0W9qh6XtcHNRuk+LX/N5fjF6iMVLbhHx/cRygfymZ/W1
         T4zA==
X-Gm-Message-State: AOJu0YzQpNlOqmKoL9HtGnyVJnZk/k+ODtXkUZVdUkmqkB+t/MSehW6m
	rK77XsRtUgyhiOOuHA/mJJMN2RQJojDfn09B1QhS8iYulH1pHoif
X-Google-Smtp-Source: AGHT+IEG0wyQygsJW7c5SHDkxBJYN6RJTk+g4/q7tRChG/aF7w5+iKOah4SlBmaYXdBJ452iiymugg==
X-Received: by 2002:ac2:4c48:0:b0:536:a7a4:c3d4 with SMTP id 2adb3069b0e04-53dab3b176bmr11329410e87.39.1732030621170;
        Tue, 19 Nov 2024 07:37:01 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:37:00 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Nov 2024 16:36:42 +0100
Subject: [PATCH v2 03/10] midx-write: use `revs->repo` inside
 `read_refs_snapshot`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-3-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=LhvQQIaMVCcThIn4EaY1K6mtOP/w3nRUIfnApwsDYBI=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCYZK1RT3nbQT+GIyV7e89kdtthHriUcfFOO
 5dtppe+HmCJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywmAAKCRA+1Z8kjkaM
 f36LC/98PdgjVo2YMkXti5SCZ5hTWz/YFtsw26hputJXXrSAd/wCM2qYtomp4hCzk5gQOQ6gc36
 qWEJutmp+mCPN1L2S8SkUVZwzJjM+7Fe1VzTBvfQ+OQIjW2ZeMWyrnZOR08+yVfhi77t/vuPl8O
 DnBLE82nclRJ2yelgLd4wPC+cWyAI1j8adhc4zHhH0HaZ+nDWcz3j04e2FAuT2H26dUyXmqgdIF
 Nikv18YLHQQhfkPjx4ShCpRV7T4VTbL4cejWpdVvVYe/UR84+Hm0doG9SHj8z7HQUsEMaLDn6ID
 49aSJmZsA5ebW27brPdQ/OHqveH2g9fqNkuzxKdgQbw2p4q2gxxE1T4Aar4rVLiFsVOIRBGmy20
 bAAXHI3f4XIaSfbnm1ELKpZrDKNo54Qduf1xoAc+0D6SHQtwwHgxarFyMvCJReXZWeJlUa9SovP
 XdVAQTTWgBhmsLjgeqIPep4fQQNXCP4jo+nzfQdWJFkLrQpzg3Vgux1pDVX6mCjK5pKVI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `read_refs_snapshot` uses the `parse_oid_hex` function which
internally uses global variables. Let's instead use
`parse_oid_hex_algop` and provide the hash algo via `revs->repo`.

Also, while here, fix a missing newline after the functions definition.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx-write.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx-write.c b/midx-write.c
index 22b5233f51ec6c6d99b8f9613818f1581dca5982..564438f616f59cd24edda956e4af0e0acf167138 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -760,7 +760,7 @@ static int read_refs_snapshot(const char *refs_snapshot,
 			hex = &buf.buf[1];
 		}
 
-		if (parse_oid_hex(hex, &oid, &end) < 0)
+		if (parse_oid_hex_algop(hex, &oid, &end, revs->repo->hash_algo) < 0)
 			die(_("could not parse line: %s"), buf.buf);
 		if (*end)
 			die(_("malformed line: %s"), buf.buf);
@@ -776,6 +776,7 @@ static int read_refs_snapshot(const char *refs_snapshot,
 	strbuf_release(&buf);
 	return 0;
 }
+
 static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr_p,
 						    const char *refs_snapshot,
 						    struct write_midx_context *ctx)

-- 
2.47.0

