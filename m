Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E536EA82
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253151; cv=none; b=dBqjpr+UKmTavslEXawIyeMebBM/y5N5homDhJSPrt4EYmGKbuA1EAlqxH7mak/HtbSuvAX73Ln8FrTS+zwVN7G5E+D9qrQHsavPbYSmlFZnoCib4YXXZugepyEtxK17xFKYpDhNyfPtjQoaE5pyZQDxhgMxCf3uxNIqu7g3knI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253151; c=relaxed/simple;
	bh=GTnM2+7Q7Gn5NPP5GvS3l0FASSzHf1xOOqrbhTVATng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irD2pozvO71FQgR2Fe6/5whDfkY48k1qV2HHwZ5RHTD/oyC3MNhKy0tRb5oTQW60HiGrdlV0cVrDYHOyBmTM5V7hTGleVO+6hbvG3aam7t6dVP6suLk1CizpTNT84rYEEuBGjjp/+kFYU72G8QDko4iZS2jMtNLsSsMN1YNkVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPTkGVKP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPTkGVKP"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b40003d13so2294510f8f.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253148; x=1774857948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LyAtEG3B2nTvMkdaAXwFC18kFtRbKAc27XMXw3UucU=;
        b=aPTkGVKPkOCqV9t9rZbQAqV8YxtsCUG7aXBwb1zYkEFn191FfEixCzSVLNBNIz6Wqv
         +KBd/nBXL5pagFXLl2HqdU9NFVQPmJPmk8Zir3MB9xlQMe+77F5BmkwUn3985CgHZliP
         nVX0GPgJ4MnBCJMx1XTgjiQ5axVdM1ol34CewwTZuWO5gAmvXJfilRLdRzCqnXM9g1L+
         Ze37Svf+FZ5XY8n6wcAy8LXMIInczKNmGbuHI+OMUP1cA83tkiNwmJuYNaodzvZBILce
         MA0Xn7WRhI9rjoesXouDot+DpVhH4tOFZwFWUqDNi2iVDKkK9DsH2qtFu5mn55YNxSqn
         hwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253148; x=1774857948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+LyAtEG3B2nTvMkdaAXwFC18kFtRbKAc27XMXw3UucU=;
        b=Hti2dVyiSSGN0p4T5sa9XJ48MnwefpqFMdsXTm5ytbvmAVri8/wKT0qLDgW9GzERbw
         2Q473ryUloOBJrgNUFJ6UHsAmzkpZwAPWlZ5pJdmyb7RL6lDj6R/+1mvCm1M3sRrDK+i
         rgdmoaIqh4KnJ5ps2F7UQm+TjO5o+WovjeTLooAyaTaz71VxJsRIRNm0fXjy8QhNQovv
         KpFIbmk39sETLdKq2WPNi7U4+JK66MbU0VRZmkjHFeP2EsTEWAulb+eeOi7PBHjjT3B+
         pz/o6WUSEA0a8SRsxB5LBeespcU6CAG/JkdF1pyKpwxl4X5EXAt7uX3Yra7BtMLWpZn3
         y88g==
X-Gm-Message-State: AOJu0Yx1ecz8kcfQxVL7oqvLIXEOVQkfGhsaA0JD/GY6IxVnZ4sERsfm
	u9oTmH8Qom3kQMtK3rLNMZID57sBIh+yZB3G1dDIszu4mmJLN7orNCDsTtsDrw==
X-Gm-Gg: ATEYQzyhghqYabxP1PWm+ntO5ElyCqCgnNNh6vtfIfzSR3TQlGvdKyef/ljLr6GzqZ1
	ykgSt+IsuWr0WJYjukxry9Z+3LlbzBpEyVy2uD6jW5RAKwUiSyslS7xiz7xkxGDHHwEUpEs17Oi
	b8+9dhQaIUvrSBGHSU8rel+uYIO8nMQvDeBilkMrRE41WDjFnPuuNwsCzqXd/cY5J7yhzg75HQX
	WQ4BQDUIzwMg/oEG6gZ6HxC6ZM6UQ3VIDpufzx2iKpxq5rMEjtC/Q5TRHA/12sB8dI6F3jTZl0W
	ZJNQOxpFsQ1KmzUWfsn4IA9FAFUD+t5ZzTB8EArwLSxiBKeVMZTTFnvID6loR8YzNLzqFxR+YSN
	8DSJWq4Qw00SWWMDqSgn5Vdv84/F2UAzT2CUb6GVBEJY8lKmWNv87nI3zb7Y3lHF96F10fTN+Pn
	95HUy+j+4AQoW10FuPsFQDGF0CPBFmSUEWV5/nOmDYg3VtdBqliCHU0JGatCZy7k+F02nJek8r8
	JrCUIyZIcL70OG6iQCk1q6jycl3sDhNULueYWk=
X-Received: by 2002:a05:6000:3103:b0:439:bcdb:95af with SMTP id ffacd0b85a97d-43b63ff0ee7mr16523462f8f.0.1774253148040;
        Mon, 23 Mar 2026 01:05:48 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:47 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/16] promisor-remote: keep accepted promisor_info structs alive
Date: Mon, 23 Mar 2026 09:05:10 +0100
Message-ID: <20260323080520.887550-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In filter_promisor_remote(), the instances of `struct promisor_info`
for accepted remotes are dismantled into separate parallel data
structures (the 'accepted' strvec for server names, and
'accepted_filters' for filter strings) and then immediately freed.

Instead, let's keep these instances on an 'accepted_remotes' list.

This way the post-loop phase can iterate a single list to build the
protocol reply, apply advertised filters, and mark remotes as
accepted, rather than iterating three separate structures.

This refactoring also prepares for a following commit that will add a
'local_name' member to 'struct promisor_info'. Since struct instances
stay alive, downstream code will be able to simply read both names
from them rather than needing yet another parallel strvec.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 3116d14d14..34b4ca5806 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -880,10 +880,10 @@ static void filter_promisor_remote(struct repository *repo,
 {
 	struct string_list config_info = STRING_LIST_INIT_NODUP;
 	struct string_list remote_info = STRING_LIST_INIT_DUP;
+	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
 	struct store_info *store_info = NULL;
 	struct string_list_item *item;
 	bool reload_config = false;
-	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
 	enum accept_promisor accept = accept_from_server(repo);
 
 	if (accept == ACCEPT_NONE)
@@ -912,17 +912,10 @@ static void filter_promisor_remote(struct repository *repo,
 			if (promisor_store_advertised_fields(advertised, store_info))
 				reload_config = true;
 
-			strvec_push(accepted, advertised->name);
-
-			/* Capture advertised filters for accepted remotes */
-			if (advertised->filter) {
-				struct string_list_item *i;
-				i = string_list_append(&accepted_filters, advertised->name);
-				i->util = xstrdup(advertised->filter);
-			}
+			string_list_append(&accepted_remotes, advertised->name)->util = advertised;
+		} else {
+			promisor_info_free(advertised);
 		}
-
-		promisor_info_free(advertised);
 	}
 
 	promisor_info_list_clear(&config_info);
@@ -932,24 +925,23 @@ static void filter_promisor_remote(struct repository *repo,
 	if (reload_config)
 		repo_promisor_remote_reinit(repo);
 
-	/* Apply accepted remote filters to the stable repo state */
-	for_each_string_list_item(item, &accepted_filters) {
-		struct promisor_remote *r = repo_promisor_remote_find(repo, item->string);
-		if (r) {
-			free(r->advertised_filter);
-			r->advertised_filter = item->util;
-			item->util = NULL;
-		}
-	}
+	/* Apply accepted remotes to the stable repo state */
+	for_each_string_list_item(item, &accepted_remotes) {
+		struct promisor_info *info = item->util;
+		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
 
-	string_list_clear(&accepted_filters, 1);
+		strvec_push(accepted, info->name);
 
-	/* Mark the remotes as accepted in the repository state */
-	for (size_t i = 0; i < accepted->nr; i++) {
-		struct promisor_remote *r = repo_promisor_remote_find(repo, accepted->v[i]);
-		if (r)
+		if (r) {
 			r->accepted = 1;
+			if (info->filter) {
+				free(r->advertised_filter);
+				r->advertised_filter = xstrdup(info->filter);
+			}
+		}
 	}
+
+	promisor_info_list_clear(&accepted_remotes);
 }
 
 void promisor_remote_reply(const char *info, char **accepted_out)
-- 
2.53.0.625.g20f70b52bb

