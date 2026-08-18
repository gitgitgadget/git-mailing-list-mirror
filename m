Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058627E07E
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062791; cv=none; b=hVkUZV28sAiRavNn6mtfeqX5Hde24k+YTTGOvnUa85UweqLXlqgErb9EdhaxanlJJpu81kva9uuBeI6sTZN1BBl0Ffj2j2+7GnaL9DQ18IBwsIW/TgIQ+4kn2y9PyqBESo5oHRC0sH8x/tYWQWV57AutJhYB12E6U0cTAGwhSs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062791; c=relaxed/simple;
	bh=21iQa6wo08Pnha0KwScP853U4kGjem2LTV/Q8YZRP48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIdxtqqr4CVdACbThA9uUi+pof/xEUVEpeb9XsxbBpTy3GdmmHPRy2AP0KxfNOVzcX1Se+VBhZYl7TJfR5Fv3RFGtNVGylR54nqYUmbJMQXnxY1QkL/T6oUnkJ2A5PKKgs2NP2/a4zZzOD2Z4OArchQc9ZYaZZVGdkwgxvl4fmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HAUnFCy0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eGGIE+oU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HAUnFCy0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eGGIE+oU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1DAA77A010D
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 18 Aug 2026 10:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787062788;
	 x=1787149188; bh=/D3Cgt8yj8bxorVLvg7jP2hHpT7Y3Rt0ZyvWcrZ3bnc=; b=
	HAUnFCy0Bui7WIQlsNy0kBjqJot64kSGax+8SMd0As7BmHttUUbGn53TKWjVjvX1
	78KUL4XkgEb2OOFNqWW0e7VkT4hUnwG9QgzSJ2Ud9F+EvZn7N1H8SLh8iA1SSSK1
	4a2appnC86O+lGidJ97tAzw7XmU58YRjr5v//amwlwI6LVjPFdYmDaXrV+GcZWiB
	CVt1ZKNJvwaPqaUoMx0y1ZNT45WGMKchbyPVcDZWS0BI3n60KgfMmAQhtjq6xW5A
	P5lqDrkKuIC1fxTcZj6EgLSD8Sx/g5LFsgAi6Txr4Z35c/vhOlYOXzRbB91kMy/H
	M54il8OA8o/bOLXQUyLeAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787062788; x=
	1787149188; bh=/D3Cgt8yj8bxorVLvg7jP2hHpT7Y3Rt0ZyvWcrZ3bnc=; b=e
	GGIE+oUqhJXM0blB81WDFGz4MXVxeLg+2s9IIpoknmbaWBFGM0Zp8qtgYNDl0LIj
	PA1cKQT9aCYsRU6JnMFX100TM/EgSrUQzBMQqV52IhgTvtCW1bAEqEbQkmsmUsYN
	P4yeD7eiKwwg3SU2+oJ05WD0Ev7maU6d15F9Olw+38ovQzGXdNwUt78S5Iluz4tz
	Ut5FwSJANd7CCt6YNylAxoYZjL/8ZegYuRLrRWQwOMVNpar6ToLZb/GjlcPeF6iZ
	MexWEOXZuBPCU8r1bKZQgyREMdWnVUCT5BY8rqf/ho0WpRsgpjTnPXEqCc2sZARt
	N2lXlLIsIqDswgtFVqZwA==
X-ME-Sender: <xms:BGqEaqXakOp9ZJ837dVR_u7VW9m3rshHfasHY9IVxUrnFNY7rE_mkg>
    <xme:BGqEathq2VD64thFxoXV0YKYQo18vwRg_rt5Vn3Zu6ZsHgYs7wPz5A2nvmynZC0M8
    8dD_U_XBO_cdqjO7PvF1kdttoHiwNJmcYZsGQF4bcIFuFHKS-my1Q>
X-ME-Received: <xmr:BGqEakD50g0uDcJX9zRz5qjxNFDkITluuMotywJjShGkNJduvZqMPrtgc-T8szO-bdLNEVjd6PoVA285Ee5hSn4p-d_Fz4bxSV-J-wQX>
X-ME-Proxy-Cause: dmFkZTGSoJp7k8c0Cn+kkyI49yzacQKpkTxj0CYv6iZVkinoAl4hjDbQ4pKe6QO32cZZlg
    ZLC+erVc3/aZNPlbelo8VxvwzwtJpCGw4RaR3KFLJjFqS+H7kSlUbiIalE8uVq39xM3xrM
    oKlGhH8IJ3jjPdPWvZdyFwBJw/cKncFPYozfcBgmgSfBW0u5XNxAbImSnkleaD5p4tFswo
    6llvEoBRy3ZLp0GlgZZLZ4fT2LGU/0JMQg7zLs7NiEN2BBeKMLYn4hbrvtc1XsLqyhlY5H
    K2HBNYR7bnjg/4cqcVDJUoTt/V9RqevBQ+8RfA/4AiOJQZqXXhcBPl6edIVnuVDkrBj9JB
    htGG81tflaVZtFPdQWx7pJN2RODaPXHIK6QqdiP/TLMzGzZd+qzicQSQq7x6dUIaPvC6/0
    +R9UT728BS2l8tqXCzE97e9cRBpOIHkZw7nIkC4Fp+o9HnSXpvRuKDeAxmRG5UzDdRf+pf
    ALkgok6jVQmC7FHeEMYj75K6NYZhaO8Rvik0RMnhRRdybBlp4EzXWeB6Wd5WkrOsgdZf5H
    xVzESOFJlbMId0VuffM5RYarFSNCLeJBabcnBLzme6OXogFYgJ/CVQj9Cz87R3fkVqGn/G
    dnuc9qqd57HQ4OfGhzDzgXkCSIH7CQgp/TRMyBXrSYeoR5OD48gyfm2C1Qvw
X-ME-Proxy: <xmx:BGqEamchOR6tRaMFwcQEw60hRNAy55DjEz-Ro__NzS92FAhm08lmZA>
    <xmx:BGqEake4bvCxWQl8wFmDpoIhFWTTYTo6Z3Arwc6RGOBXFgCAqpSATA>
    <xmx:BGqEaigt0w3WhA8toZnyDgi834PYbW_kOorTv2TUFL_AkeTvFC05fw>
    <xmx:BGqEaoQzW_1DZdtfrMTgKWNFwol7xanladl-vpLNttJb5l2YODsUJg>
    <xmx:BGqEapmYZEO5IJxzVGshg5pa7wECo_TO6KOpYpUxbFY7TGB-A934amHL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 673b9092 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 18 Aug 2026 14:19:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Aug 2026 16:19:31 +0200
Subject: [PATCH 4/7] odb/source-loose: distinguish missing and corrupt
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-pks-odb-generic-corrupt-objects-v1-4-ec234567510f@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The loose source returns a negative value from its `read_object_info()`
callback both when the object is missing and when the object exists but
cannot be read. Consequently, callers cannot tell apart whether the
object does not exist in this source at all or whether it is corrupt.

Adapt the code to return a positive value for missing objects according
to the new calling convention.

This also allows us to get rid of the separate `corrupt:` label, as we
can now clearly distinguish between corrupt and missing objects in the
function ourselves. This makes us handle failures to read loose objects
more consistently, as not all failure cases were jumping that label.

Note that there's one call to `die()` when the object type is invalid
that should arguably be converted to an error, too. But adapting that
call results in quite a lot of broken tests, so this is left as-is for
now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-loose.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/odb/source-loose.c b/odb/source-loose.c
index ef0e919277..e786560ad1 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -91,11 +91,16 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 		struct stat st;
 
 		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
-			ret = quick_has_loose(loose, oid) ? 0 : -1;
+			ret = quick_has_loose(loose, oid) ? 0 : 1;
 			goto out;
 		}
 
 		if (lstat(path, &st) < 0) {
+			if (errno == ENOENT) {
+				ret = 1;
+				goto out;
+			}
+
 			ret = -1;
 			goto out;
 		}
@@ -113,9 +118,12 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 
 	fd = git_open(path);
 	if (fd < 0) {
-		if (errno != ENOENT)
-			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
-		ret = -1;
+		if (errno == ENOENT) {
+			ret = 1;
+			goto out;
+		}
+
+		ret = error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
 		goto out;
 	}
 
@@ -155,7 +163,7 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 
 		if (parse_loose_header(hdr, oi) < 0) {
 			ret = error(_("unable to parse %s header"), oid_to_hex(oid));
-			goto corrupt;
+			goto out;
 		}
 
 		if (*oi->typep < 0)
@@ -165,7 +173,7 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 			*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
 			if (!*oi->contentp) {
 				ret = -1;
-				goto corrupt;
+				goto out;
 			}
 		}
 
@@ -173,21 +181,20 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 	case ULHR_BAD:
 		ret = error(_("unable to unpack %s header"),
 			    oid_to_hex(oid));
-		goto corrupt;
+		goto out;
 	case ULHR_TOO_LONG:
 		ret = error(_("header for %s too long, exceeds %d bytes"),
 			    oid_to_hex(oid), MAX_HEADER_LEN);
-		goto corrupt;
+		goto out;
 	}
 
 	ret = 0;
 
-corrupt:
-	if (ret && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
+out:
+	if (ret < 0 && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(oid), path);
 
-out:
 	if (stream_to_end)
 		git_inflate_end(stream_to_end);
 	if (map)
@@ -221,7 +228,7 @@ static int odb_source_loose_read_object_info(struct odb_source *source,
 	 * second time.
 	 */
 	if (flags & OBJECT_INFO_SECOND_READ)
-		return -1;
+		return 1;
 
 	odb_loose_path(loose, &buf, oid);
 	return read_object_info_from_path(loose, buf.buf, oid, oi, flags);
@@ -421,7 +428,7 @@ static int for_each_object_wrapper_cb(const struct object_id *oid,
 	if (data->request) {
 		struct object_info oi = *data->request;
 
-		if (read_object_info_from_path(data->loose, path, oid, &oi, 0) < 0)
+		if (read_object_info_from_path(data->loose, path, oid, &oi, 0))
 			return -1;
 
 		return data->cb(oid, &oi, data->cb_data);
@@ -439,7 +446,7 @@ static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
 		struct object_info oi = *data->request;
 
 		if (odb_source_read_object_info(&data->loose->base,
-						oid, &oi, 0) < 0)
+						oid, &oi, 0))
 			return -1;
 
 		return data->cb(oid, &oi, data->cb_data);

-- 
2.55.0.822.g20453c30eb.dirty

