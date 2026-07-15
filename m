Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A433451CF
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096566; cv=none; b=UF5zSDrulWBeWJtpon7tQaljFCKXZWR+qaj+iC60xeRlcOQxsfC4mbZlaHJa65aqjSHdphl4WRhKXYIJRMAeIsTKl0y75L/hXTYAfF3M9dltrhVZuhAUmenbwFU7GU0tsOniqfh3iE3zhnuNLicjz7QJJzXlnb43IVwK+Dkk3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096566; c=relaxed/simple;
	bh=2k6eG7izsuTKtzWIWvUs2riQ5qW8MC1CZv3O72OqVWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hp/xqSuQeIfZ03XiaK84+VRPOFiH8+LU1Z0Qz2WXwUGICs7sGE2Q2ZVCrRaY9A56wDjVjGsFE9yZ4aAadiOz/i6IViP8n7CFv0Z7JrRc7JWD3FCZJTb6H6Lv8oJFGW7/ZwE8LgYP5q217PkuXSHblFq36aNHeZg+/b2YPH1vmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z2dZ4nGc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bMWGecGO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z2dZ4nGc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bMWGecGO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 989FE1D0014E;
	Wed, 15 Jul 2026 02:22:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 02:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784096564;
	 x=1784182964; bh=nArudGxJoN4ZWZKhKe9nGn2oeDPxEgYaIdunfOfZtQY=; b=
	Z2dZ4nGcp9WG2XIw5hRQ55Gk9PJVfAVDOxKSaH6idb/EHBbl4P0iTCP2AThxwBhT
	T72iCw/GonAUri76pViGUnFELUG7bJXSXTTPhFJOWfMMuE4/PPc9uxQxwju8w19P
	Fsq1azcApIMQ+cbMyuOX1D1XFxm1b6DTowtdEtHEYlE5W7RQUXppfwf4KGhnYtKM
	eCPbr7ccfCFXtKBAvZJ3TWDvghK6kDc4aXS0j/oUMyfchfoJSKpelpudSz95hhXa
	HY+jCLpOenKb75TE7FyVF5vcuNBDJdXUeB4KZLPQxb48BSCxVX0DL21iO7habqG0
	L+qE++TA9hp+DR0ZzbFGuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096564; x=
	1784182964; bh=nArudGxJoN4ZWZKhKe9nGn2oeDPxEgYaIdunfOfZtQY=; b=b
	MWGecGOaIAUaeaTGLtZgOJ9qZ0JK2Xh7o0Mm3qfcjrmiyPcb/HDL9oyGL33557zB
	WRV3XjK6sRl0GWCAdnXCGYjnhc4Tpg+5TrlaWIbF59XH8e9Mwjt7nDBY6AUpPlwE
	jPX6fJs4BNNbbbRlVv7L9ocGivjDRFeAmBf6swKqq55elUN9ppDUqm5CDrb+LOs0
	tiJDMY9usU4SC+sDHIcRv0FWNhmvRb05U2aIGjI4yUS+gsTs5KWKDlpLf/aQ3TTX
	9cxOh1ALJvw+os+nhaE/gLd2jr+XWnRDivjf8Ku8nZ2Cbe8PzZz3W5m0fcL3mRKZ
	+OXarzG4IK7odnwb9Jmwg==
X-ME-Sender: <xms:NCdXaqrbTtw75CYeOA1oNlkAGRQ4MLLbxGDymUkt7TfaAgrhoDaysQ>
    <xme:NCdXasWEF4tvhGQQtf1hFQlPGVbi1v1MvM7WRbDEgFaiZwpKCfT0fqxRjRtPIsfxa
    Sve1mkSmW3uPXXkjun6ozcznK5FHnwdX05H46zjGxn5OL7rgc3caw>
X-ME-Received: <xmr:NCdXapDgq95osE6-39G-93l0SqgAxClk99Vhg-IllH0k5ounIFbcqfATRecbROqqLAbSNNjOC7cL0qrK_CZivujPcahjWtJFQSMMIlVieFw>
X-ME-Proxy-Cause: dmFkZTFE+YB/+tAuPzC/TvjlXEPq4aubpa6Ljtxm2DA3nhwEKViS4QAXVCAGF2wRqpD2tG
    rjqCj7yrsh2K3uZv6BicpW5yYVDxtAn+hMsT9FU7TKtbZqakq4uWROhTjl1al8fUmioom/
    gefFG9Bba9YcV+ffziVUcMJmrNrrzA1KCy4PmFtbw9vUYPLeSjOeBKQy1qWCBKQ/50XXpB
    m/31leo7PRkC9756xsv1BKVgX6QCG7e5YYGSgPuf8wI3G3bR95XgOr9DD596qSCfzNLZcs
    S4vIMLLbl/r0AJQpYarwXHNGipYH7Jk4IaGmmUxih8kNXIrTailxiil1zVP+0fyXZKWzY0
    NaIgrfR6ILB+z49G88Wv4HJur18BeRQN8/iEejTeAMvI1DEt2h0sxErl5IzvkKYY2MdIal
    y6Mn5DcS0VSaKAd2hjU/36A4nXtAoVJUVNqQDCckGBNTVHSh/tnQmfifbX1gB5PKqB3Bv8
    IEFoOz/Fe88eVXOScu0BCH4ShCVchhAQwR+9rUEhFSVmFKAWKdb5l7ptAvA31h4R9kEOZL
    kM0/ktDLnaA/SOaa+6bgXdO0zSa3AQL5jdyDB60EDAV0/kIVfKoeL8d1NMLZQLVFiZnr9v
    iHrThw6T8migovtoK3aELEkGdTt7aZvJYs3Iae8NxbX4S/dSe+trZTYieN2Q
X-ME-Proxy: <xmx:NCdXag1tnQOHlx95BDwnLhXcaJjQVvG39WvjMxb5N9E0E_iF40HyjQ>
    <xmx:NCdXar3rci4xgNHdjwERUi7MHNp-o6ZkQ80mz5HbPpjoNUBj8qQyOg>
    <xmx:NCdXalBMJs7YxO74KFI5AOY6w5otxO9maPqMM7I0SIU2Gx7jgcFrVg>
    <xmx:NCdXaq7Upvbcb6dxaugg9vEJJvjqMO_XonlULmUuTyh6Wr9uNXd4ow>
    <xmx:NCdXariOpCTzRgiQV9cmcwLM4h1E0ZDQ6umU3DwVN3rmkuR2ioeUnSn9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 59ffdd30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 08:22:32 +0200
Subject: [PATCH v4 2/9] pack-bitmap: mark object filter as `const`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-odb-for-each-object-filter-v4-2-616d7adf7fb7@pks.im>
References: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
In-Reply-To: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The function `for_each_bitmapped_object()` accepts an optional object
filter. This filter is never modified by the function, but is not
declared as `const`. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 6 +++---
 pack-bitmap.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 35774b6f0c..a47c231632 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1976,7 +1976,7 @@ static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
-			 struct list_objects_filter_options *filter)
+			 const struct list_objects_filter_options *filter)
 {
 	if (!filter || filter->choice == LOFC_DISABLED)
 		return 0;
@@ -2027,7 +2027,7 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
 	return -1;
 }
 
-static int can_filter_bitmap(struct list_objects_filter_options *filter)
+static int can_filter_bitmap(const struct list_objects_filter_options *filter)
 {
 	return !filter_bitmap(NULL, NULL, NULL, filter);
 }
@@ -2058,7 +2058,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 }
 
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
-			      struct list_objects_filter_options *filter,
+			      const struct list_objects_filter_options *filter,
 			      show_reachable_fn show_reach,
 			      void *payload)
 {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 19a8655457..47935eb24e 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -96,7 +96,7 @@ struct list_objects_filter_options;
  * not supported, `0` otherwise.
  */
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
-			      struct list_objects_filter_options *filter,
+			      const struct list_objects_filter_options *filter,
 			      show_reachable_fn show_reach,
 			      void *payload);
 

-- 
2.55.0.313.g8d093f411d.dirty

