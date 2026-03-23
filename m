Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3E1F1932
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253155; cv=none; b=opTD2C+qcHsQ4E9EgY2HT15VxOHYkgjk7r4bp4zIUEKDZ6o2zo18jTwm+8YirE9CPo1S3xtSkLRisNUgXYNHF++zuYwCE19IOMuXKHAggUrIU7pbEaJV11Pyiz5i5w2IHq2fl/eNcVoLqZ8UAmZN8aJX31M4DHgLHYV6TFfUULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253155; c=relaxed/simple;
	bh=8fkmGcVnrpqrY8m955b2/Vx/vbeZH9dO/rrF/+Qetqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqnP8vGMQD6rxNPpud+gIY9omUK9RZpNCxn96DgUsTEQrzW/709H+Bpo/gBgM2zsd2mifoJlereMsXbXvVA1UG03eyMDyUXAnZ/Jpwksbm+DU9Jg894bxhyc+oBIO4bYR6+go+DAb6TV4t/pd6Xx8WbWwCXfkjtxUyyp3/L1SuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fELSm+AB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fELSm+AB"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so5386560f8f.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253151; x=1774857951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hi1MnRWfAUFrFuUE6iTN2QRYvJ/QIJNZ7NmLDskgYM=;
        b=fELSm+ABaqxv6ngxAiVJ8BHG2UoPAk+7iRpa9jnk7ekbhQ9TbnjPcOcH7sZXaUtfRH
         i6EKtF6u1GZ9zvzp/+mqmpPAVyhCzqaR6JB+Gv5h8Q5Who5t0vv60RzY1kav/FhHb5Og
         cwqXhDyMkSSsEGQbZDmwJEesRIgtb1tjPN2G6QkH8G3QfBNM2MOr7gha5R0AIqhLuI18
         l4gmA8MW4JbYhnLaGwIXt0jWacICxoinEEzCmKc4I7TvrwtWjpeIITueWbuEuTD5FMsF
         w34ZDszjdavpJEG8BsJiNwrlp/w+RmprpmLjlecuJkAab4r7T3W3SBQa8kqVP38c5koF
         dvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253151; x=1774857951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hi1MnRWfAUFrFuUE6iTN2QRYvJ/QIJNZ7NmLDskgYM=;
        b=qExxlLG0g4Uz65L3G4xjvQOkPknedy13QwNXF/x2ZlYnBNAOyC7GWmaHF+/lUcRBGn
         NDN+nr9DXnxhYlJp9iO+d4KkA5KYgTksoNZy73VMmAl1zgHbSajc9h04ekhluA82XO4V
         Se9Fp4knB2It/5Q2wwEYG2LI7nu4x/dTBG23+ByfAWwAgQmmXrMm/yI1JGu2PySEPpxn
         Lnl/gXYeF+c+0wQASH5YQFlhs4BkrY5Nyq9ofm0QFisnaKmJj8mIHRydpGTE9NnDEBs3
         0LW3SPLTI43nc5z8PCx7Gus+uuKaqcnFJsA5EjLiRIYgchxouqEv2VFs49HuUFjpIWFL
         1fiw==
X-Gm-Message-State: AOJu0YwTqXM4gX7U+hU7DetLRu85ENWN0QDwSj57lpGVJ3FDNGJJehOv
	r2lT8fURqZ9KHfX5SIOSnvWgkFYItsvO55TKwJB52h+/xR434Hv1kJenBTFxOA==
X-Gm-Gg: ATEYQzwT+fSLjEvmVJg0Ig0qFJ2OUmnAv5/QDzvAirpGwZlE+mmjOOZ+UAi0LxgznTO
	CSOz9MrswGW/RQCStxDbN/ZIfuAYLlBqy7FbfAhtit4Ruc1yHYiACWw30D/t3uwpfxlysHf2vB4
	LcYR8vZ6jAQx6gUe6zurxNGuzir4Ff8rKLlWIw+2vzdpmNGsMnwJWzEfRVLHsofXLo0Ntr81Fu7
	/U6mufQj3O9LS1zNpNiZxt7ANOx2ynKQC/pncVSEFbqoy2oZ6AFp2qIv15QT8W58XR3xZv0ubd7
	bU0bbZI85CO2d4s94xMOr6l/MMxL7n8CFBnAdy5wZK9U1yABUANSqIXnfwhqn4UtzHfmXXajI1s
	EwbdbWsuDuJa8gIomFa6aN7OpiXVaogEhUHiwhxfdB4Fc6OKRqDmRoL7pGaCfzh9zPjYMQieWfr
	JKtt1l7Ka7nwCcLZ9Dii76rG79RzKUrMZHMG2gSQKpHbN10oyzotAQuYKGUrLwHhENKsdcZGMh5
	1FGqG7EFzWTctEPoLSO/jv7FrLTMaSCGdgjtnA=
X-Received: by 2002:a05:6000:24ca:b0:439:ab3d:1c2e with SMTP id ffacd0b85a97d-43b6423867amr17384871f8f.10.1774253150564;
        Mon, 23 Mar 2026 01:05:50 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:49 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/16] promisor-remote: add 'local_name' to 'struct promisor_info'
Date: Mon, 23 Mar 2026 09:05:12 +0100
Message-ID: <20260323080520.887550-10-christian.couder@gmail.com>
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

In a following commit, we will store promisor remote information under
a remote name different than the one the server advertised.

To prepare for this change, let's add a new 'char* local_name' member
to 'struct promisor_info', and let's update the related functions.

While at it, let's also add a small promisor_info_internal_name()
helper that returns `local_name` when set, `name` otherwise, and let's
use this small helper in promisor_store_advertised_fields() and in the
post-loop of filter_promisor_remote() so that lookups against the local
repo configuration use the right name.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index bdfc5e7608..da347fa2dc 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -434,15 +434,19 @@ static struct string_list *fields_stored(void)
 
 /*
  * Struct for promisor remotes involved in the "promisor-remote"
- * protocol capability.
+ * protocol capability:
  *
- * Except for "name", each <member> in this struct and its <value>
- * should correspond (either on the client side or on the server side)
- * to a "remote.<name>.<member>" config variable set to <value> where
- * "<name>" is a promisor remote name.
+ * - "name" is the name the server advertised.
+ * - "local_name" is the name we use locally (may be auto-generated).
+ *
+ * Except for "name" and "local_name", each <member> in this struct
+ * and its <value> should correspond (either on the client side or on
+ * the server side) to a "remote.<name>.<member>" config variable set
+ * to <value> where "<name>" is a promisor remote name.
  */
 struct promisor_info {
 	const char *name;
+	const char *local_name;
 	const char *url;
 	const char *filter;
 	const char *token;
@@ -451,6 +455,7 @@ struct promisor_info {
 static void promisor_info_free(struct promisor_info *p)
 {
 	free((char *)p->name);
+	free((char *)p->local_name);
 	free((char *)p->url);
 	free((char *)p->filter);
 	free((char *)p->token);
@@ -464,6 +469,11 @@ static void promisor_info_list_clear(struct string_list *list)
 	string_list_clear(list, 0);
 }
 
+static const char *promisor_info_internal_name(struct promisor_info *p)
+{
+	return p->local_name ? p->local_name : p->name;
+}
+
 static void set_one_field(struct promisor_info *p,
 			  const char *field, const char *value)
 {
@@ -819,7 +829,7 @@ static bool promisor_store_advertised_fields(struct promisor_info *advertised,
 {
 	struct promisor_info *p;
 	struct string_list_item *item;
-	const char *remote_name = advertised->name;
+	const char *remote_name = promisor_info_internal_name(advertised);
 	bool reload_config = false;
 
 	if (!(store_info->store_filter || store_info->store_token))
@@ -927,7 +937,8 @@ static void filter_promisor_remote(struct repository *repo,
 	/* Apply accepted remotes to the stable repo state */
 	for_each_string_list_item(item, accepted_remotes) {
 		struct promisor_info *info = item->util;
-		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
+		const char *local = promisor_info_internal_name(info);
+		struct promisor_remote *r = repo_promisor_remote_find(repo, local);
 
 		if (r) {
 			r->accepted = 1;
-- 
2.53.0.625.g20f70b52bb

