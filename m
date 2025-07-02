Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578BC13D
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418494; cv=none; b=Xtw38izKN2jNOqutIMw7BecOIQU3eXCDjyLFMa8I+l+GKdFM1wsSO2fQsFqaMv/AFc5MzSp56bnOZoEHcIgmtywZEn/knBGFMNICnPmeLD97up0RjkM5k3QbUdEUPnrCRMVAuyk5aRodJN6/6X5AGz+sHZV2+yKbay5FZVW7TqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418494; c=relaxed/simple;
	bh=bjAJhaq0mkeVjU7S8d4ff4APs5rI3S47Nr0skCqU9Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKxnTTblifsz/ITOhNyCw8SsNTh7k467Q30xXDCr4A3S75BYHc8WH/q3DNlL96o98l5k2LHbcrjEK8Uo286usQn75Svywbjx+Gt0AlvuUx+SaBpObo6ANazRsH8fV5Vl3wfL1PrnOjuHi4kGVIRse1F3qPVQby4mIWVLjg8ZWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh5zvsqg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh5zvsqg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-237e6963f63so24675985ad.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 18:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751418493; x=1752023293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfNYabZm7mo7ot3VEPZw1OTLfynvOkKRRhmMrV6Olbw=;
        b=Mh5zvsqgLgsr+Tl+XTMeTXpgFcuFUeNXb7Yn6FgUmS6NP/twiBwwWo3xX6enYkCRX3
         sx675XgV1Ftbef0vUB5J1K+xTCiFBR+E6WIRCBz3/JvIqSd+8HdgqXxBWuYcXnBYmWKf
         DyWF6KLXCeFyLl91VySOn2r3DLUhOyq0X/omgCHvI8apfskk2RN5klmw+tehnP6sx/J0
         kGmeRnBiktw1dV8zc0cS1jSoON3G391f5AwkOQrRVNa7IRZesIB6c97nog/Cup3l4y8w
         1W5hMIeABrT+8E06460G5wthqvDfVq3Og8RJ+kFQFsVe745GPJJfc13gVvpZLwPboprl
         CRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418493; x=1752023293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfNYabZm7mo7ot3VEPZw1OTLfynvOkKRRhmMrV6Olbw=;
        b=seIS0IpLvmJl4ybFQhUm7Pb4a0RRLgPOMLFUS8ZZk5jvwBKqN/Hhw0JEfWmqT3CKZI
         NWurzmApt1YQqxhfOIPg1J7SeyhYEeSxLf11FIja67PttS4M/uVJSj/zC2VXVqmv6BPL
         sAxSbUGowx8aixlV6WFRAQb++/DAZinttW1DIu50oR1w02qk4uwTxhum09uVAByB480x
         oRcMGllJOZxCMevgCWVlELCduElIMtqXfiyihmKtBi22V/Dat+g5dm2WlxHu2UDT+2Fw
         3FrHtFbv7QwuO0fPZyVHlzhNGQLV9VRIGhK+H3zsSeu2VADj3dz9pNJyI41LMOaxuBDe
         McEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO1VTk7j0p9nRN1iV+SP475AjA4X7UG418YH14OcJLn3zBqiqAo9bS7STenITveI124Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjl/5zsiObrQVV7WDG9lmi4vwvaMol0CxdOO/tA1/KyZLrlquP
	WAPOIV4dEaWBeu9X765YcdSgSAqX5qVlZlFQJ+44+2UzlE8oOoKAPwaC
X-Gm-Gg: ASbGncserFrVwPZhLNttSuQ/4+pCAmEX9Ja1dxQ61sW6DRAE47eSUZbAq+cJrUIVzJU
	r8hRgTR6V4Dqundl9zE6fQA9TpcVGEqD1ibGl2f3XphJUzZKVXvhSLD2IJs2l/lYH+TVJwI6PS7
	pHr4vx4AoeeUTFPbqHMhJPYHMpSMGK3AxV4RWhvdwZgbruI8zABa/KcVtPZ0+srbGdpqB31q4Kw
	EDMybGaTOK8zy5TFQlNt4x+4FURkoaDop0vRKakEKK/09C+cSbMGQjY77ZgS/eORFSkhy6ENRPm
	VPZxBkiDU+9D/HFm17tzKl3jqJRAItMfgUPQKHhoRqcYSlW0WkcR5D4sSMc=
X-Google-Smtp-Source: AGHT+IEHjHgSK9IXK7y+GSl/yjbOdEbo2CMK+5FwCJVab/CVLXo8IHeld9cFpbnb5s130CgzOB1VNg==
X-Received: by 2002:a17:902:db0b:b0:234:f182:a759 with SMTP id d9443c01a7336-23c6e54fd01mr13057605ad.28.1751418492645;
        Tue, 01 Jul 2025 18:08:12 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e258csm124433705ad.38.2025.07.01.18.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:08:11 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: gitster@pobox.com
Cc: peff@peff.net,
	git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v3 1/2] refs: remove old refs_warn_dangling_symref
Date: Tue,  1 Jul 2025 17:58:37 -0700
Message-ID: <20250702005837.2813893-3-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.149.g2f19833911.dirty
In-Reply-To: <20250702005837.2813893-2-phil.hord@gmail.com>
References: <20250702005837.2813893-2-phil.hord@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Hord <phil.hord@gmail.com>

The dangling warning function that takes a single ref to search for
is no longer used.  Remove it.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 refs.c | 17 +----------------
 refs.h |  2 --
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 651fb2d41299..07197c239e33 100644
--- a/refs.c
+++ b/refs.c
@@ -438,7 +438,6 @@ static int for_each_filter_refs(const char *refname, const char *referent,
 struct warn_if_dangling_data {
 	struct ref_store *refs;
 	FILE *fp;
-	const char *refname;
 	const struct string_list *refnames;
 	const char *msg_fmt;
 };
@@ -455,9 +454,7 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 
 	resolves_to = refs_resolve_ref_unsafe(d->refs, refname, 0, NULL, NULL);
 	if (!resolves_to
-	    || (d->refname
-		? strcmp(resolves_to, d->refname)
-		: !string_list_has_string(d->refnames, resolves_to))) {
+	    || !string_list_has_string(d->refnames, resolves_to)) {
 		return 0;
 	}
 
@@ -466,18 +463,6 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 	return 0;
 }
 
-void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
-			       const char *msg_fmt, const char *refname)
-{
-	struct warn_if_dangling_data data = {
-		.refs = refs,
-		.fp = fp,
-		.refname = refname,
-		.msg_fmt = msg_fmt,
-	};
-	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
-}
-
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 				const char *msg_fmt, const struct string_list *refnames)
 {
diff --git a/refs.h b/refs.h
index 46a6008e07f2..07f21824d480 100644
--- a/refs.h
+++ b/refs.h
@@ -452,8 +452,6 @@ static inline const char *has_glob_specials(const char *pattern)
 	return strpbrk(pattern, "?*[");
 }
 
-void refs_warn_dangling_symref(struct ref_store *refs, FILE *fp,
-			       const char *msg_fmt, const char *refname);
 void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 				const char *msg_fmt, const struct string_list *refnames);
 
-- 
2.50.0.149.g2f19833911.dirty

