Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92667414A0E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140448; cv=none; b=RsnAQcSU09dmasfEE6VN/5f3oMN/Yq8aalxw3oDCwdWey43H4ym9zZphfXCDE+fggTj8tnFu/7cQXmh8SQiwf1UwJqludWyJKxEA/CCkrxpOUNelLBin3cSb+7ecigPWvtKjwsrMiba/mqqFmpbtCDUjSiF4MqnxnQWKXPS7tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140448; c=relaxed/simple;
	bh=Ex+rLTpY7CXjJ5yWusH9htAYp0wqCOqzVhSGUQWpvJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASABTg1oGsg3/7Qfm4EPdS25dsTUJX/ikpis5VWnemK5OhTeSHQje5j+Axw/rr2xgusirzXFomYlfbZuqKFVQ4DNyhMnCitqNytRl7/sT0baRNoccoJw2ON1QPREMYPVh9C7HP2+jv3DnE4qh+4J8cd5r9161AiYE2t5MonKH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1s1y/yN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1s1y/yN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4955de8797cso261815e9.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140445; x=1786745245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v57lCHwquE5GVjnhPQrgTNxMHKbOfRMWPcfKwp23G98=;
        b=d1s1y/yNdxUySUsdEjPdsTmPY75JyLfabojo44y4/EboiV69SHjeVvU4RyUHCxQtYm
         tW3vrlcGijyp433QErXhFxKyVsEhqRIiq8BMo+C7CbonHExTWXkMIkG5zKEnOPlpltaf
         7lM1sbz0IavukNLO69Tg2i74MbFZACJSM4yqqDVVXAAT2dJrByprBH+QFSyKZ1fsUSkr
         6ejhZXYncu3ulPYuJkCD4vpgUb5y9KTxnKOVQkTc70l/QFbBWGYF7JkMwqA94wZ9g7IC
         89Q9Rk76d2DQmU6wuhhPgpIcZz1GjIhaX5IZsu1g0NbgIf9fuxOm/+XlVhVe2Gsf3sRN
         lPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140445; x=1786745245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v57lCHwquE5GVjnhPQrgTNxMHKbOfRMWPcfKwp23G98=;
        b=eJd1WvYHeSWiYN1UfXPrS77dGhyoI0X+A73EJp7NIqiib+EElysGIaew12lttc2BLS
         gLUGEb2XoMR//YEW+wL95QlNaEHKnvYuFhYT4+2GTBg71Vcv0vn8saIBL/x0deBrlq4b
         oHdTnFJA7O+HZN8w9e81MMLslL0I95fUZ0DrZ4PiBzCxFshFQI3QPHkjE4ap9rytHRB9
         j7r77YMyqFORYn+sXXtn8CbkVwOK2UQ0rQiYVfHY6HgxTvCeWUEO8IqtofVyAvkbTyHh
         REVhkDg/72UKtkVW4/+RmY5fJM6ujgLKLGYr5dG5cJaUnzolWNCculO7awP1UFHjClTP
         su5A==
X-Gm-Message-State: AOJu0YxJKMNcJXbGTR3N6WbeTaYEBCEK5XYIOyV9y53Gd5SP3xOpVEZc
	1txLrLtMJCb1+u2boFf+s5vJoEIKPnA27XE/UMHb9e3CaJ62/OT0Y/6Aq2FyxtiD
X-Gm-Gg: AR+sD138/2manqc3J6XfCs97DVS7teWZyKtS6FFLzo4bs0QMKFltmobi5mzxKYu3gl5
	xNbu0bIKccl5ptjGvKCAmgmMhbCEWPmCKyrfJ+ewAmvjuuPm2nT9nFPKJlgZTOgLsRhsTnCPoek
	TamsU9jaQxn/3vhPo5aIhf3bNvYuC/cpTWW6slj752FB+KMme2WBse3I3J5MbVY9LzNLdyHIQ97
	R0piRK5mCOW8cGY/o7ZTnqML0C0Dp5xpDagcYBOpvJHL/EPhx2143jLWycRXGQ4VMrZ8lUrpiHn
	qe9PgST5LQ6GXPwNjJbH0KGC/DEkH00UEOmIN9hl1Hts7wIbpISKruu63msqn9ffAeAFDujKnzZ
	li+ppo42i/cff57HPmDX2nj0bVKLL/NHw5kuKQLtEbjA30s3U/7AIYyPK2VHHGF5+y3FucydJCs
	VuRuzZeGrvejNAi5wOEfUGLdGSo7fpotRL1NxBCRxsXaDwH+m8NlTm0xtEOTOVE2w8/4sRxYERI
	MULO8oyTH1caOMEbIwqta4grroUgkWGM17arEgFG54yzJBXGLMkvhStdDCfU/5kqlvLybOru4WI
	FmpX/DZLAjez2xOakHhJIEutR8eA+s/YAolSP/dgQ9k7sM0FDjcfH3wEX+JJ8Mn5NWqWYpVfGqS
	BgpR4I2UM8jg+h2ovw+wsaZpRLdb8d2z75kkeXb0q6ynswZLyglmgIFEufs4FBEwe4FZlHieted
	Ldhm3MBswm3rvH8vA=
X-Received: by 2002:a05:600c:6612:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-4995e0ebf84mr105577135e9.17.1786140444698;
        Fri, 07 Aug 2026 15:07:24 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b4499sm69478545e9.3.2026.08.07.15.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:07:23 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 00:07:02 +0200
Subject: [PATCH GSoC v5 07/10] protocol-caps: add type support to
 object-info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v5-7-86f22bec04b2@gmail.com>
References: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
In-Reply-To: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Teach the server-side object-info handler to accept type as a requested
field. When the client includes type in its object-info request, the
server returns the requested object type.

While touching send_info(), wrap an over-long line and fix the bit field
style of requested_info.size.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 protocol-caps.c      | 21 ++++++++++++++++++---
 t/t5701-git-serve.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index 02261be14d..27e0f85b10 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -11,7 +11,8 @@
 #include "strbuf.h"
 
 struct requested_info {
-	unsigned size : 1;
+	unsigned size:1;
+	unsigned type:1;
 };
 
 /*
@@ -73,15 +74,20 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 	if (info->size)
 		packet_writer_write(writer, "size");
 
+	if (info->type)
+		packet_writer_write(writer, "type");
+
 	for_each_string_list_item (item, oid_str_list) {
 		const char *oid_str = item->string;
+		enum object_type object_type;
 		struct object_id oid;
 		size_t object_size;
 
 		if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
 			packet_writer_error(
 				writer,
-				"object-info: protocol error, expected to get oid, not '%s'",
+				"object-info: protocol error, expected to get "
+				"oid, not '%s'",
 				oid_str);
 			continue;
 		}
@@ -93,7 +99,8 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 		 * If an object is not recognized by the server append SP to
 		 * the response.
 		 */
-		if (get_object_info(r->objects, &oid, &object_size) <= OBJ_NONE) {
+		object_type = get_object_info(r->objects, &oid, &object_size);
+		if (object_type <= OBJ_NONE) {
 			strbuf_addstr(&send_buffer, " ");
 			goto write;
 		}
@@ -103,6 +110,9 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 				    (uintmax_t)object_size);
 		}
 
+		if (info->type)
+			strbuf_addf(&send_buffer, " %s", type_name(object_type));
+
 write:
 		packet_writer_write(writer, "%s", send_buffer.buf);
 		strbuf_reset(&send_buffer);
@@ -124,6 +134,11 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
 			continue;
 		}
 
+		if (!strcmp("type", request->line)) {
+			info.type = 1;
+			continue;
+		}
+
 		if (parse_oid(request->line, &oid_str_list))
 			continue;
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 51d5dd1ae6..f57e36a88d 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -369,6 +369,36 @@ test_expect_success 'basics of object-info' '
 	test_cmp expect actual
 '
 
+test_expect_success 'object-info supports type' '
+	test_config transfer.advertiseObjectInfo true &&
+
+	two_oid=$(git rev-parse two:two.t) &&
+	two_size=$(test_file_size two.t) &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	size
+	type
+	oid $two_oid
+	oid $two_oid
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	size
+	type
+	$two_oid $two_size blob
+	$two_oid $two_size blob
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare OID request' '
 	test_config transfer.advertiseObjectInfo true &&
 

-- 
2.54.0

