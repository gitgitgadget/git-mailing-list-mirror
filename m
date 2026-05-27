Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A331F993
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890929; cv=none; b=hbbKJMuMrtRUZkbcVLdeCaDduloeJoP5pAB2+WrHGaICUFTFP2QrQf2/O2qtXuplXh9GvtOwT8Z4yFt2Zi+tTQZA8nTEJ9RVTCIEMyWchFnp37rz++tHEWr6XVHNwrvx1b/WPEgnucTcEcX39MFNmwHGt3+J+fBhlnOSeI7pTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890929; c=relaxed/simple;
	bh=qZguQDRTcri5ESyZU9vWkdt74IyHBFKbTf2+YJZPXns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYxx4r+V7hiXIz5xOwc8XKxu2VWjoTn1z8zPP+QO4kIMLqYByljwg2FerQanDnmdXCEEvWltXj5z2FSdsU4XwArBxvzbtBtEnubZxYMMRg2Y0x8zF21ucTwjvx31seWuLc54SbutMJmdSO0OLZqUJ+Ee7RJzMY8cIjm+5Q+OzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5CSlP5S; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5CSlP5S"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd11a3729e8so1819026066b.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890926; x=1780495726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfshnbEz0bpwDPJv4vH8WfIs9NcDTIR1IOv7/T9SOMc=;
        b=A5CSlP5SUnv3ycHhzvEieWsXLeIUEGBdDGYH7IKGP6rsIjqJzxeVcMwTj+BIPfihJt
         iAhSjaKRfIx93e8meSD0rIbZsQH3O/qK1dyzJxecuw1QH+pId91+q4YrFFS8eLlxWzEO
         RQ5x8iZ6QhuuhcyHNXxOF+xOvBF0ZKOX9Mtb5MTVOwI+xSKfLz9pWRjatOcC/weRkqpb
         0ItyiUZ7Pfim90DDyJs9zg7j/k6VG9YYt1Pyr1wfjdKio760GoGc5ihu55QLu9ik0nV6
         4bSDGfEMPPV/q4D1/W52O5PIxRUwh64qpQF2LPqAbE2ehVzvPQZI+OeJ8ofqWWaPL0A7
         QYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890926; x=1780495726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bfshnbEz0bpwDPJv4vH8WfIs9NcDTIR1IOv7/T9SOMc=;
        b=eAQnI0zzzNRvmdhZ3wZDiA0SpOv0u/rZ4KxKGYDXvPta/m7EhDFBLGFOozcXMB5elf
         rnggYsAdKOPYGsLQ7uEcivltxYUWg71IF/1/3VHELZhyQavQ05nG5DqoDicgEW65K4SK
         a+Z1or7Bmfg3SnCuhiJ97OSsk0T8rCqmIaf/a+Lgws8U524Mt5zmefx+uAW5w9IJF3Am
         D9nKVZBSnDd7zH6RWzXbzNnmAWXBsBAI/skL0vsXLXZVS+6Egt+kLhiIjZmulo/ABxnG
         UdpsWN/Y6cjiyY40vWDtII9WvmEWphXBYnTQhSbydvJOrjGqsIn6exn+TPe7+QhSXHjj
         pWew==
X-Gm-Message-State: AOJu0YwlkTEvVHD9QCJ0kiY7UdQq8JQ8T8rqAIBpJliHZ/xru/U2ei7d
	7FGvnf+dPA2tG5IUCeclIKFt6ITE6ObOHQTgrRkiVeK+LKCbNNkCiOjju86ZHw==
X-Gm-Gg: Acq92OG2JXQaEDsg+Aj7Sovxoqb1b32OywQvgjdCqerxmNQ3td68gysqRzu+WZ6kMQY
	sAiEOx1Xpk5BCv7EfOJ8jNfc23GlEZL1b12Wg7xN1QWed/efULWiBUvkK8rgd6dJ7+5nkAFEYPs
	z3OU5mQpJ4/wQdAqK8FJ4YaZCYofLXoZz9DGgp+58j0t5ghE/q0W5j5wX6NXvbEmvaZO+iXF5YV
	La90I3bCX9a8W3YJWTPz+O1VQSYilQOAaP64wY3XMnptAAeYKLyUjdHXikPVGlqz3qn+e1lc1By
	F2CgaSpHeG0kstNoGWXOOHUIEn+7BNjqTfow4R0ZarNbcuZHS/DACqzoDfpTzTLpyR/4Ju4+jhr
	4wJHp8/Nn5cul8IfYTeQrTcLwyajkS+XTrwJ5MpBccvFX3SX/FiOzDttKJVvSeIicle9yDRhSCO
	dK0u4REEPTugAXwhtu9pbP6v29uCcDKs/ZGS/UYRyA8abbu4GRzDa/t+LT2PrDm9XHomhguesul
	2cEwNHfIartwtST133dUCAIIEaoQD4Fue5SkGQ=
X-Received: by 2002:a17:906:c112:b0:bdb:7c37:183f with SMTP id a640c23a62f3a-bdd22944808mr1498756766b.4.1779890925841;
        Wed, 27 May 2026 07:08:45 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be1ca138bc7sm268122366b.41.2026.05.27.07.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:08:45 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/8] promisor-remote: add 'local_name' to 'struct promisor_info'
Date: Wed, 27 May 2026 16:08:16 +0200
Message-ID: <20260527140820.1438165-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.275.g96c817d129.dirty
In-Reply-To: <20260527140820.1438165-1-christian.couder@gmail.com>
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we will store promisor remote information under
a remote name different than the one the server advertised.

To prepare for this change, let's add a new 'char *local_name' member
to 'struct promisor_info', and let's update the related functions.

While at it, let's also add a small promisor_info_local_name() helper
that returns `local_name` when set, `name` otherwise, and let's use
this small helper in promisor_store_advertised_fields() and in the
post-loop of filter_promisor_remote() so that lookups against the local
repo configuration use the right name.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 38fa050542..138a412893 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -434,13 +434,14 @@ static struct string_list *fields_stored(void)
  * Struct for promisor remotes involved in the "promisor-remote"
  * protocol capability.
  *
- * Except for "name", each <member> in this struct and its <value>
- * should correspond (either on the client side or on the server side)
- * to a "remote.<name>.<member>" config variable set to <value> where
- * "<name>" is a promisor remote name.
+ * Except for "name" and "local_name", each <member> in this struct
+ * and its <value> should correspond (either on the client side or on
+ * the server side) to a "remote.<name>.<member>" config variable set
+ * to <value> where "<name>" is a promisor remote name.
  */
 struct promisor_info {
-	const char *name;
+	const char *name;	/* name the server advertised */
+	const char *local_name;	/* name used locally (may be auto-generated) */
 	const char *url;
 	const char *filter;
 	const char *token;
@@ -449,6 +450,7 @@ struct promisor_info {
 static void promisor_info_free(struct promisor_info *p)
 {
 	free((char *)p->name);
+	free((char *)p->local_name);
 	free((char *)p->url);
 	free((char *)p->filter);
 	free((char *)p->token);
@@ -462,6 +464,11 @@ static void promisor_info_list_clear(struct string_list *list)
 	string_list_clear(list, 0);
 }
 
+static const char *promisor_info_local_name(struct promisor_info *p)
+{
+	return p->local_name ? p->local_name : p->name;
+}
+
 static void set_one_field(struct promisor_info *p,
 			  const char *field, const char *value)
 {
@@ -829,7 +836,7 @@ static bool promisor_store_advertised_fields(struct promisor_info *advertised,
 {
 	struct promisor_info *p;
 	struct string_list_item *item;
-	const char *remote_name = advertised->name;
+	const char *remote_name = promisor_info_local_name(advertised);
 	bool reload_config = false;
 
 	if (!(store_info->store_filter || store_info->store_token))
@@ -937,7 +944,8 @@ static void filter_promisor_remote(struct repository *repo,
 	/* Apply accepted remotes to the stable repo state */
 	for_each_string_list_item(item, accepted_remotes) {
 		struct promisor_info *info = item->util;
-		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
+		const char *remote_name = promisor_info_local_name(info);
+		struct promisor_remote *r = repo_promisor_remote_find(repo, remote_name);
 
 		if (r) {
 			r->accepted = 1;
-- 
2.54.0.275.g96c817d129.dirty

