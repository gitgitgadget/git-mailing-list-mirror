Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003643B3D5
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953704; cv=none; b=KquGeFpxIafQNAeuJChWs/BCCM8AarJH3EXMPssht1fwoRgrNVy/7VJcXyQOTqvBidgGSrvaHy0GwD4O4uC7T3PzwYP2KkdGeRUpokXYZOELSmlTOkNFDK2UIIJ+dbLJfiHJr7yOVFoHtrBbmckRCbyoqigIXvst72VlBEDYR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953704; c=relaxed/simple;
	bh=d3Z+BnEef/GcTtrKbTmVGXPvtYFCmU5HihlHmpnNSFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2HcLpAOgXm42p3NSmP5Cvi6ZdxurBtla+f9VoeW6rdOvZyDjYp7GmgdHSJobHj8k0LsXTMt7fbNBo+c8Fcn04wg/9FYQRmjv+Tp4euJ0zvYDHVHKfe5HbjVOrrn4fI9Gi6MDAs/0p8YEyOJ/cgODFxvanXaUHKPytmqTkZIMa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bT9Mlrm9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6Qf4A9u; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bT9Mlrm9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6Qf4A9u"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EA3BC1D000DC;
	Mon, 13 Jul 2026 10:41:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 10:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783953701;
	 x=1784040101; bh=/7lbgCncUEFrUzCqS70RXTUMzw37kB4BjNfM5Fye4w0=; b=
	bT9Mlrm9r9No6jhDk64bCO2zxDROUdsZx4rII/CT9P/ILkLt9JJOtPGhrEyyQXoP
	+d5eF0IAnkNTnw6OBI/mlzdARCBRK1/yEZpN+W210BOzYFTEZDgAu6F4sNeEhvYQ
	8rNxdE1k4IeiZzKa26fSprBFtfLpyYtmukInzOOkIXmk0ftnyicEDIMJOF4Jk0tL
	8WWpxyD9/cxDSTjf4a46hPsLQPndrgr1YenXUYlOVuGd3ILbhPCaE2wPgxCq4MBZ
	WSF+4A7NOOPjHByJVwonj9OH+G9Lkpsvsp1MqKrvFd2n2EYuahcNxk5Y0jVCZZQT
	TnRV6ioDWFq62qNA94wgSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783953701; x=
	1784040101; bh=/7lbgCncUEFrUzCqS70RXTUMzw37kB4BjNfM5Fye4w0=; b=n
	6Qf4A9uR3hR0S8uJ4U1y96Le6GN8tzYQvaiWSlqNvUAnLE7I/6oeeXM+e604x+dl
	iGLU8WnMGHr0SVsecjb4TAG5EyHqmmY2Sr7nUsL0YlK9Cgi4HntJfgBzspMFShHB
	H4JOQC7OgpJ1GIUe4vYGqF6lxKpKqjba//ssfOlv1jElAYajYSzSBG87yx7un3Qw
	yy8QKqpb0ljlWndFZrn/ohyeXbc/RM7i/MH6OmYM4gQWIEEYTpwCRr60Zu705KG6
	zRBTmX/WvqiPyBE3vb1tZMBSIaUZiMV5I3kiDtR9zG8xStnG5wIvI0AQ9+zcO5TS
	6K9AMZmOMqXeK45snyYsg==
X-ME-Sender: <xms:JflUavg4DRrKsnC_6BXWIVYSi4EXFR4Ra9Jov3oc2SiJFaUYrtNpJA>
    <xme:JflUai74nKijMTHX-cVuXk4eEWlm-5JhSdxEeq0LSu3-DBIfV_IgEXGAhvrFhQV74
    nouCHCxyZi3icOREJd9IgKFtrb892qF_I3B9tGqCQOQ5-TL-DptZA>
X-ME-Received: <xmr:JflUanaSSSOqvVkK84696endgC1Aj36SXO8dA880xcwDIf0B98nxAiN7BHbmDmC5pPX2tkA9wvDcKO8XVkkK_x6iC-44eJ9-W-az-QPZ>
X-ME-Proxy-Cause: dmFkZTExU3AaOgeG5BObJ1W8JdQQ7fecPK0PCMuQHCnglnCgDOzkQC0YGMEj1qcLJSgMeY
    LASbvC4Tndv63coRGptPYG0Us/QPdorbjTjJ5eG4DbvGXhIArpLYSfP1Equ8XG1heJbryq
    UDpFgrp5VTZtDpEG/07Jwy4Ag/vYtEFOYaVrF84nTGMkk2meJjHZ4oqMYl9DO/bcxScRj0
    raM+378SqfjY/MjDn56wLasjqjj0AnRoiM+HE2+qWeFjm8zVJqFwrMNDwJJ51dMxeJILN0
    DY3JMGfUUBMmVXNdlp1KiUwRzg3BnBn+tX0Xx+zOe7dMF8plSZ04smH2o1tFL5zomOi5W6
    xMzl5MBsKVxdkDXKF3pEhrfIcisN1HBit7Npr/w5xEX64KuXc7jA036DoJNywu/iK+WNHa
    68o4eHxhE/yruZ0tGwk/Hv+jqJ2S1dF0ZNpdu+y5BKqmz0bSrDUmwoB5xyzJ6YAhI7DH49
    WEQoYHMRxEYC5ITrPvaH8aTyKJfTkKuQ3TwqwZccgJENJxjL0CrvvkmbolYQMmW8kd684N
    Ufy6goUhYxNxRk4Ift7MksbsRs7C8bZvuWbBAr/5F0EfRNBQKFAXa82AK2AJk7Zpo7M8BQ
    dJ1kJCxUiZGzWlaP+3P7HrqL4Pn4QMMK/O/NQ7OAtqLen9FBqD4/y92PNC0w
X-ME-Proxy: <xmx:JflUan6KUv6nCOkNHPU8H5hUnybUrqIESXQadE7c7of0sjfKZMXLxA>
    <xmx:JflUaqDoz5YP2UCfEsfCGjbNEmKdA6oVELVXRNdBFMB4O3OJz1vhug>
    <xmx:JflUatclAjnLh9mbbBvd-C-iD4C-LA3g3o1zohrG0lIdED1dk0Mb1Q>
    <xmx:JflUapKOVt4qIx370IWuS5qpnSLsbSJ5ogPotxGzFrbZnH9hYWDPaw>
    <xmx:JflUaoOHFtNW6jmvGIjJxx7yaQiAASWSMvMkagEG3tu4RjWK4ouRvu-v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 10:41:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86c85a66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 14:41:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 16:41:28 +0200
Subject: [PATCH v3 4/9] pack-bitmap: allow aborting iteration of bitmapped
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-odb-for-each-object-filter-v3-4-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
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

