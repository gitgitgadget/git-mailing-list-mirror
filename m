Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF69E415F06
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768017; cv=none; b=n8py3V2EHWirY5C/P21yv04aZaGO4ZNkL1F0pZubvBFSVfMTWSX3zhStiXO/TCwOqu7Yya4iS0+NVsbnAn06X1xgBc+FGgn/X8NwnNWFdob4uIyxXDJTUyGvPwVJAvFw3PsNO3gEjrkuW0+ZMmFruer0+rv0cFvvL0DCcedMLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768017; c=relaxed/simple;
	bh=Ex+rLTpY7CXjJ5yWusH9htAYp0wqCOqzVhSGUQWpvJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUpfyd3vDnbuPrpp3ApYDHVDIv6rJt6GKyVX6HEl2c3aqM8bER6hncvYTepJAaoVLupJ90Zku9uWyLIPA8pNW6oGZjc1DnVSklQd/ZkFj9pzobj2WqsHKQWjYZAfFX5cXItCBenVbkGXvpwVeEzQSg8xQMjl3pSSeVyYaFub0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbddrXBm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbddrXBm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so22617335e9.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 07:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768014; x=1786372814; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v57lCHwquE5GVjnhPQrgTNxMHKbOfRMWPcfKwp23G98=;
        b=NbddrXBmdRB+0UQtd96vr/SKLj8s+31GobvZ7dajfXbY9G/jrNGDmYI8tkKmyIPrbq
         HTzfgYbAxX8S/QUBLp1iWftirwJhLfzJ3IF9+GVF/KUHNhRxUt2V76kTDgKU3MCkVtzP
         AtIAXyY0Lm1hq9u93arRQvg2DUiaoTyT/I/Yx2ZadV1od1pHliY3wLOuDB+USnnaT0Z1
         Y2iMGrNWWuIudqedxTnVifDs0RRR/tYsyrfW7Z87i71bzEkafSOAX/rL030hKl+1ridL
         swkXmEpxjictV8FskOLsI8phj9soJvDfNMayO4kmlKkmc9qbynkRnOlp+Oyo8JSMC7ht
         nEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768014; x=1786372814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v57lCHwquE5GVjnhPQrgTNxMHKbOfRMWPcfKwp23G98=;
        b=di+xaPaySE/09d3YxikVXEvTU9Bs2bx38M7CVewQE4N38fVrR81qu9EJ/Cu8fHZEj0
         u8dPgegYZ18ZDpe+lJI11+ZWc3lzThhX4slOMZdI5I0JNvP3lZgrbUqPRHZYeUKNM14X
         YkwbP63RDZqPhOz9ANEuZuVaqlu6YYBgaypNMSOxy+A6feb8+kMmU0ZXE4vkyfgdrA/L
         nLMXq+X4ScKw0jmer1n8Zf2LREw88muLcsg1X9E6TGNnUy5uhJCuNQ9Ay8l3gZCks3/1
         XgF7Ai50kNDlHpOKySKwzD37Kw59CRsGLJQp0dA3sZSJEHwJQ0h9vCW2U14fyD3YzbzZ
         j1XQ==
X-Gm-Message-State: AOJu0YzhGIRr1G+rbkcz42BgTz+nCuoKpurceb0ZPF7XPV+hvQecsaVq
	bQXh560+aMkT2F1LG5wEwehx9JuQpKSrzSrBaGx4d76+3oeKJZ5ki7fS
X-Gm-Gg: AR+sD13i8eK1T1hGTjPO1Q5Oiic0RyPa+dqHEpLDyCdIHTPO78lIWvTo+YUAsV/VOaF
	/Ekipf+IaCOiSq89wLao24WoK26zO6IRWWXdgI/cH5CxSSTU51CzwlZxhlwYW2U9LwYz2/gsv3I
	yOaf+XJdWkZAbRxm3N500+86NI8PsrQ6WCyizRyCAtiC7xdjMVj5CPwPO5C3SZqQE1vqm0382Xp
	AcE1dz1pf9Wj5lMf4eMz94Sjh1xLpAAo+QZ6iJpWyLhLgNEtp7bjtK+8CbBuR81UXsudXC/35Tu
	7FDxg6ZSQA1trWVQBRqBpbKj430OF1BnPlL+CAjx6i5l6kwsV3F7eBZLv6SY0T9yxZJQm/pFANJ
	gUiNNEw3VHLfKP8eDEapmoWpN46AnwkEd2EhOQTECR06m2sd9dCCywydWkTmdPV6aPN106+o02W
	rY2SFsPd1xd70A7y2VKXIVBwfvVWZ7rqYcebZV2pi+hyNwycq2sJlIVig4CHPGekAFsLgXtXOTn
	0VPOt6OQod+f2yH9q4JFAhdLL240DTt8SEzPmPoTnZVxfdeYJ1Kg+jCPs03EfZanbICzANQMhdA
	zZ9jlbyexRsWvGRIvDDAxXqmY9m6viGISKfMf5+Zg8R4jQgnSS3Eikk5W+Y1XtDibUAMrLTR/g7
	i5cEbCT1paC4QgZSl
X-Received: by 2002:a05:600c:1c25:b0:499:48be:3189 with SMTP id 5b1f17b1804b1-49948be327bmr30033075e9.0.1785768013760;
        Mon, 03 Aug 2026 07:40:13 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm106482575e9.1.2026.08.03.07.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:40:13 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 03 Aug 2026 16:39:32 +0200
Subject: [PATCH GSoC v3 5/8] protocol-caps: add type support to object-info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-objecttype-support-v3-5-7176fecf7950@gmail.com>
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
In-Reply-To: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
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

