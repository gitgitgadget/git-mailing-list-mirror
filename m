Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF9417BE2
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868989; cv=none; b=uNcqKAn8AdGeqSTjioPKygolyn4lYNTEXD+wxRNcl0fKU2pfSlgcPp5LL37fmXu2V/BdWjiwgfzm73N0Q8nr37C2mCUIwaQzxFb9UOQ6vPeHAJ7tgjMUfOJwDmYTGtK0SJWHHapgI7ncAxBXAHvNWFUlhuBl5eZA/MfzlItDAeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868989; c=relaxed/simple;
	bh=Ex+rLTpY7CXjJ5yWusH9htAYp0wqCOqzVhSGUQWpvJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMW+Kb8NY0x+A4zXvNLRLGcNV2LdfMWptNJ3VU3DnLXtJ/YReSbsI8Eah5O1W2Zd6My7M7WJl1rcYNExKDmwhQ1hNCWG5k3WOJ5K7jIyk0KqZsCXpAhoPbGPfI8TWtmxaIkdUMPzILKO4gPxvQ90WSEXscIkjjXAmOImP4OytmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVljTdiY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVljTdiY"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49553515a8bso1683095e9.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868986; x=1786473786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v57lCHwquE5GVjnhPQrgTNxMHKbOfRMWPcfKwp23G98=;
        b=SVljTdiY4HfhNZwevP01/NoLom5qub9v8vg32h84LKVlFZYwEzi2RCR7fU7Mi4w081
         Kl5HNq4AUSKFZCvHdMuGyFzopw4Sy2QMmn+NZEsBbKx508LSsTt4e0rz4rCism6QcBIL
         hARqCMPUp6pV0DsinYJvaHLrMHbT4qvxooVESWJq5JraDMP9EFjrWVOxGFr+97l1sOle
         brxYFFKhmyyMVQrfjHIfwpD9zmVPpa1VmkWZ7G1e56r6lrl9TBAzQZqjmo/aBXTeUcQ8
         8qT/ljEYTu6SqhYz47utELal0FQfnue08GjDdZzW8W+XfrqjkAitx9k5Vu89P7VFB2Uw
         4giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868986; x=1786473786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v57lCHwquE5GVjnhPQrgTNxMHKbOfRMWPcfKwp23G98=;
        b=RcICTtinxDfV8dmW7Wuh9N2zPjQLLchTBthriCel7g1C8SYSemff0AgKtUyCO9OGnz
         /73ioEXJyoiiw1U2FVOt/KktlzJXcjU9KoKvoeTc9l0RCbiDmi4FuqNzeSXyGdspCjMt
         i6QgEsLQTYr+STwvhFL9ExAUMLMRB2yS3mV7ixuWQF5PwXRlcwFMQLOm+3Axpo1vwJVf
         ikdKjq8GgMn3XpYUqtcl7RzIiQKYd8yDCrCnqxLwGy7gb88Z3hWWRniSxysiqbqBFN37
         hSuUWIflqWV7A04yXc93HuEdZLae5hHyooF0jzT/00bY3epik9RQexvcf0sDSyrm0S+2
         xQHg==
X-Gm-Message-State: AOJu0YzKUG40R/kFSUT+SidUaHqF1Sz46dYqNYQo2I3oB+WWJPVX/1zU
	2pYKGhN6osybcLhsPPAiTYPBo5AVZN4HcjaeQxdM5MvPt8V4vYDI+woY
X-Gm-Gg: AR+sD104yVyO7ZH57I7z3AAfL2DQA2Xcei7j0Ud35j4EMlqA09NqyQsYoeZ5VP6eeVq
	QimVjURbSdilx2nxldkivMhCjNDwV640H1r1pepoOuehyKHi+THXgcDNU17zFRXxSh1e4j0p6Dk
	ZLaRpwZYLqJsTlDCaTcXJ+6wiZVlmWrhA8T7ol+8FlDzgSWXcf5gcASZS09+yTkt8udsACib2rn
	2iTQxxYLLWMf6oreOqLz9Kl6rhloRcOQZeXdff6mwOZaDlbVmMA0UXxMNx6TyQ9f3wY1dn1Pi+q
	2OzcsOGaMyHbltFTr7Ypx2P/+jZ11aHWbjjN3fgdMjOsFXogSfexOFHFZXmM3/j9qYsk9vuHKzj
	/ezQPODVuYUElof25Rij/j0YIlSAGzJ/fUOPpOwrhYaLEuC02YJe6+crg/JGcJT6vtKRCn49/vZ
	2iJGYwcw4YJGABsTRCx0Fjo7yRN2PO/KCqUxLMFTdV7MskiJw6KImb95sIwYojwZ3J1qutzwQ67
	u6NmmKbMoq0vel1kJ057M6exu0AYUGpHfzM2aYN92IBz+Bacrl5tVE3rNXEoSeNX5h8LPyr3BtG
	BSsSQhbyeu3Viq4pKYKNUNTJ/c65oZwtziT+1bi28JiqOlkelKM1hAKv6BkmqW63K0ngXCeFJfW
	UMQkq6j5E3XhgS/f4bTIysH2Rb/8=
X-Received: by 2002:a7b:cc97:0:b0:492:6447:7a7f with SMTP id 5b1f17b1804b1-4994e7a7f1fmr2995375e9.6.1785868986151;
        Tue, 04 Aug 2026 11:43:06 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm138877835e9.9.2026.08.04.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:43:05 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 04 Aug 2026 20:43:00 +0200
Subject: [PATCH GSoC v4 6/9] protocol-caps: add type support to object-info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-objecttype-support-v4-6-31511b0231be@gmail.com>
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
In-Reply-To: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
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

