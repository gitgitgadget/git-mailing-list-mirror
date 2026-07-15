Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA434EF0F
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096571; cv=none; b=a4d6YtZybR9Q6ox9I6uy8Ja3wjnDnWJAj/fAvZpMSFDjTsmdwtAYEEY3Y0RMMUeQITwrIxQsBNes6sOMac3RxNQGAOm8AmS9XCbuK/Suv71scQhNBV1Rs3vAD9MSmj9bwnMwH2hTcmS40OVZNl+FUnG1t2OpAjAs49tx0M8jjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096571; c=relaxed/simple;
	bh=d3Z+BnEef/GcTtrKbTmVGXPvtYFCmU5HihlHmpnNSFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uB2s0bQ/c1axKAdP7oHQkGjfJ2M2KUb6C0EHCL3P/uHPF93wlH65y3OsT13uUZvEebSQdcZuiz7Kf11Dqv1sRAmavnaJwC/OtrevbFwYKa51EQD3Pn18we9UJN3sZEyB/d62XG20zFPkWa90zIkt3eBdf+lC1oHeANShanH7VsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l2bS9nAR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZLQk4wcp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l2bS9nAR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZLQk4wcp"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12E5B7A0144;
	Wed, 15 Jul 2026 02:22:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 02:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784096568;
	 x=1784182968; bh=/7lbgCncUEFrUzCqS70RXTUMzw37kB4BjNfM5Fye4w0=; b=
	l2bS9nARi8y/2U78qeMXFtKQK2d0Hwb1zOSwB6Qx2wbm3pi3YqsfGSSqKzmhkIN9
	i6Wt3nG2oyNY1+fXLYrt/MjSSdOlWgTgzMr3x1AxpAG0yd0GRxtM2mjL+Pm4USTe
	vBBgUmnrAsoRKfO7vziHR905OHD9IBPeTEd3MrsUI+Men1f+nFmXUAaiOkNEP3oB
	3NOCMhi7+/Fp9HrNQSsyNwaPIe82yim3o4ejLAYFOVr84RgJJbNCpJBO2GiK+yYB
	0SKC/LZW+Sem39zcWPiOyPbcxgTLdjxNV1TZ6+m9qwqrgvUM7UsIH2rE6XtPWl8l
	RLe701xois3ttNz0/2iq/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096568; x=
	1784182968; bh=/7lbgCncUEFrUzCqS70RXTUMzw37kB4BjNfM5Fye4w0=; b=Z
	LQk4wcptSITAuiPZFzMM5f2qxgEpj0+U9u4x5RNBPn/kI+dlg0vNtFCCAxXzj3Gh
	QkqlNSXOpwS1HfZaREi2T2krAOWzZbOiSduKBJuG2GUbM/22KOC9QRdj0Zde2TbV
	gNOTRXXZnwxJSurxAstYXfWKbDPvScm+B8jSeewkPqLleyzZpNuii+QH2nVcpleY
	YlPuhD9rxSfbZRXwMb+VNE5jYAOnBRNrTnE35SXJxWgluPMWG5MIP3G5HwQEKwAt
	v2gKleUoa5ofs6zlX8K2z0CJu12ZYgMSGOg/jzZ8JG7jyJCkQ84l2pjO8ty9kpQd
	pPuZE08Z2Bc49U7eZpyiQ==
X-ME-Sender: <xms:OCdXatyY1n9YObeuH0kAkr6bhWtvn8GYpfh6ZcuNigTfwnOu_kAaeg>
    <xme:OCdXag__9eUHkACSROHt5EnnxFJQKcxr0zNTsmxfyfzYxCl8-uy_F3eQnIIDNjGt9
    yaXFRPiRA5r2tBSnzciEVpVdEOmvuxf17IxrxouVIKHf6HH-UkNfg>
X-ME-Received: <xmr:OCdXahJufFkFlaMkawFd26NoT3a8dW2WoV8u-Kyp2X2ao_11un9Tipg1xOPY2UhNepuCwkf6RfL-pT4eaySVq3VYBgu5a8BjRyjeZQoRBOE>
X-ME-Proxy-Cause: dmFkZTEraCzVtWGqt2iXp8WIvSvIQZlVHbxmWwAQSoK6enBGOQk3IhuqC9z95nMi6ESJNo
    Jq/L/CRA78f5TgLdxPQn/W5tLEgwU8DpaA9hgYvmymJLeFOnzq7QIl0qNMKCGlfSArBygI
    66RXPRk594TsfTPfzK3FCxCd4/xcY2Z1sRPjK6MZLQe7JaPALcGKACn4nhFyuzpDjJZxwE
    SW4lAwcbwtRyj3hipLTEmlusCnI3LKj9ZxaG1uu/mLgw9pLhZI67kW3SnNf5bjc7QfN5pt
    blsyYcgQ51ObPhSZvalbog6n2gbLAnAwl2UcvUcdk98XEkEzdq859p2x1vP9g9CtrD2aPd
    cdfzH/xU2ew2apPc1dEI8tDjOJcMOKguwYyLdooponkgPsBSpiIJAKpwpbG4pA+qfy8au/
    7l+yLK9TPYvARl4WgK0R1r2Vo5/5OIe5pw2QA/HjWqPL9wgbatKw28uP9oezYpo8049jP6
    C77l7lINeX1ucSICpJDeB9sUsuhIY40mETSkOKht6rcCE5zDbzWj2okeYjd3fBCPAh8ZXG
    KLu2Q0MsHptKZJosxhN70pI4coxUohDBB39zHSvWKP3LsiqjUKDy9+zJTAJbZaO7YFF7eI
    QGJY/QbYI5OYnlKWRcf750wypVO018VoplSraRqjN+8lP6H6fgKi3dbNUdUg
X-ME-Proxy: <xmx:OCdXamd5ZN1F8Z-rViRClPSdXNxqIY2R-Z0kbFoOpgFBy5PyuTc0Nw>
    <xmx:OCdXag8KRCxKoPZO8MViLCGasL4FSi4r2TgeqaBDsqut3VMtTGINIw>
    <xmx:OCdXajrhBdHFj0gzzdDu2gEh4ev-dkCFSCxcgO2i-mDhTaAPXQnAoQ>
    <xmx:OCdXalB4W0MPTO3BfgQO6wOT9bR7Mm8MBCiKJAP9bOUw9NWlBTdqiA>
    <xmx:OCdXaqrEiZrZLGk32CuhEzcGJP0vF8KmSYXQfLSFMUSTeFFNfYrdNODZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id da7c1ead (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 08:22:34 +0200
Subject: [PATCH v4 4/9] pack-bitmap: allow aborting iteration of bitmapped
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-odb-for-each-object-filter-v4-4-616d7adf7fb7@pks.im>
References: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
In-Reply-To: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

In a subsequent commit we'll lift iteration of bitmapped objects into
the "packed" backend and make it accessible via `odb_for_each_object()`.
The calling convention for that function is that the callback may return
a non-zero exit code, and if so we'll abort iteration. This is currently
impossible to realize though, as `for_each_bitmapped_object()` will
ignore any return value and just churn through all objects completely.

This doesn't matter to the callers of `for_each_bitmapped_object()`, as
there's only one of them in git-cat-file(1), and the callbacks we pass
always return zero. But once we move the logic into the generic
infrastructure it becomes a latent bug waiting to happen.

Refactor the code so that the return value of the `show_reach` callback
is not ignored anymore. Instead, returning a non-zero value will cause
us to abort iteration in both `show_objects_for_type()` and in
`for_each_bitmapped_object()`.

Note though that there's a second user of `show_objects_for_type()` with
`traverse_bitmap_commit_list()`, and that function does indeed invoke
callbacks that may return non-zero. This non-zero return value never had
any effect at all though, and the callbacks that return non-zero values
are only ever invoked via `traverse_bitmap_commit_list()`. Consequently,
we adapt them to always return 0.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  2 +-
 builtin/rev-list.c     |  2 +-
 pack-bitmap.c          | 31 +++++++++++++++++++++----------
 pack-bitmap.h          |  3 ++-
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 188c4f6d4b..3673b14b89 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1908,7 +1908,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
-	return 1;
+	return 0;
 }
 
 struct pbase_tree_cache {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 8f63003709..02818b81c6 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -486,7 +486,7 @@ static int show_object_fast(
 	void *payload UNUSED)
 {
 	fprintf(stdout, "%s\n", oid_to_hex(oid));
-	return 1;
+	return 0;
 }
 
 static void print_disk_usage(off_t size)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index a47c231632..eda38a5433 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1695,7 +1695,7 @@ static void init_type_iterator(struct ewah_or_iterator *it,
 	}
 }
 
-static void show_objects_for_type(
+static int show_objects_for_type(
 	struct bitmap_index *bitmap_git,
 	struct bitmap *objects,
 	enum object_type object_type,
@@ -1704,6 +1704,7 @@ static void show_objects_for_type(
 {
 	size_t i = 0;
 	uint32_t offset;
+	int ret;
 
 	struct ewah_or_iterator it;
 	eword_t filter;
@@ -1749,11 +1750,17 @@ static void show_objects_for_type(
 
 			hash = bitmap_name_hash(bitmap_git, index_pos);
 
-			show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
+			ret = show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
+			if (ret)
+				goto out;
 		}
 	}
 
+	ret = 0;
+
+out:
 	ewah_or_iterator_release(&it);
+	return ret;
 }
 
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
@@ -2062,6 +2069,12 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
 			      show_reachable_fn show_reach,
 			      void *payload)
 {
+	const enum object_type types[] = {
+		OBJ_COMMIT,
+		OBJ_TREE,
+		OBJ_BLOB,
+		OBJ_TAG,
+	};
 	struct bitmap *filtered_bitmap = NULL;
 	uint32_t objects_nr;
 	size_t full_word_count;
@@ -2086,14 +2099,12 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
 		goto out;
 	}
 
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_COMMIT, show_reach, payload);
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_TREE, show_reach, payload);
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_BLOB, show_reach, payload);
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_TAG, show_reach, payload);
+	for (size_t i = 0; i < ARRAY_SIZE(types); i++) {
+		ret = show_objects_for_type(bitmap_git, filtered_bitmap,
+					    types[i], show_reach, payload);
+		if (ret)
+			goto out;
+	}
 
 	ret = 0;
 out:
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 47935eb24e..ae8dc491ac 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -93,7 +93,8 @@ struct list_objects_filter_options;
 /*
  * Filter bitmapped objects and iterate through all resulting objects,
  * executing `show_reach` for each of them. Returns `-1` in case the filter is
- * not supported, `0` otherwise.
+ * not supported, `0` otherwise. Aborts iteration and bubbles up the return
+ * value in case `show_reach()` returns non-zero.
  */
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
 			      const struct list_objects_filter_options *filter,

-- 
2.55.0.313.g8d093f411d.dirty

