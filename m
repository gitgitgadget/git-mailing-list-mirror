Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F454235360
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722261; cv=none; b=TI7rVQAGbcm+06KCPDGALV4Ce9g9Nqp5jcDhDJkPg14BGBdnhZVkRYDxsk2jKp5tqqUVJWVgYXQjfG+coSmvlax5TBZktp2fb9DEa9+dWzqmempqfI7GPKxykhU9OAUTP9xoylUoouKB1MarVKBQtpD79TfVdYx/9zijzcjxTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722261; c=relaxed/simple;
	bh=d8/6GB/cDiAavSGHmEsNIy1A1bNtUnTeKfDtI+ylYHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg9Z/NuiLN7jCBbVSRkaf/UQOpXds/9Ty1dCCwRY5jjuWpXLlT1hh7Oir4hHlflJvAq6HYfMI3ILD1VuDKj1KR76fvdKFCpFNaaio4sBYRop22F5WJoKE2vs9il88/u+3tA0M937j/fhhJIX5lcOCKS+T+XIaxUMWnYHMrdzc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isAy1s1d; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isAy1s1d"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-749068b9b63so2503094b3a.0
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 16:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750722257; x=1751327057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF6QPuQ0MxjO6LFuJqRC8sveaq9ZHovkuhqA2JUc8DQ=;
        b=isAy1s1dwCSTMq5eykks3rnyKDvy886OZyVjqa9QGjZul8uCroy+hg06TrEBsqA/N8
         XkXhEskLQOWun8Zh9UXLQZXcXagxS+w+h68PUEnrj0tKC224Fcvfw8qGEV2CuQ372VxH
         2HVuz5KCN4N3I8tTl0kVNEFt/d8WGa3+bwRGHbd5EOHqy8gB7uGGKUtA2n/2Wwh5Hxb2
         Za7RCgagiMWOH7FIFf0YU0NYosG81j7tvQp2hKzaqjafFG4Tw7qwI1pcXibbUsVdbKjb
         pFeAmNtQsk843ExkyBbbCBDUk58XHds3NpHdyuGW8qfnHR9rxP2fv7F07P0bAE06e4Oz
         gSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750722257; x=1751327057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF6QPuQ0MxjO6LFuJqRC8sveaq9ZHovkuhqA2JUc8DQ=;
        b=fLzunF0a5uHZPvsurJ3jGLhK92A4DkWOfyCktByGfi9RKdoWoNRGlUOmM0nCXFbhXW
         AfUeAiFgvaUAehGr1DsVZH0B0MA1gIcPuoys5p3yBgipl5uQbNQXbQuCK4WmLiJ50swj
         v7ZqXwLXMwhBwsnLGWtAgHdm/I+rJTO2D8Ak2Qx3oA/kTVaKmDKIv9C2sblke2dTSByP
         rzIZWODb/FciuNGMv/saY2v4+gwoCFrDxfF+JqVo7aka++gZ7ymv1uHW8vV46GheWsH/
         HY4zq4CtoappWs0LFvOEzbpjn0VdwEBpX9cBdNtKfR05zsHzrPZiOm8GvdZS+jF9bYYz
         MqMw==
X-Forwarded-Encrypted: i=1; AJvYcCVFceD6tAOByeYnHVJsucVrI9Lm1OSzr/9ytAecQDd76tYjkyXaAzhvCYNSgP03nCgtOvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6y9UI7Le7dTu58c27Tlw/7Iah0M0g7xQq+6/HJXItC9qQR69F
	mXSwnDNaGqfe2td//5E2jrrQmC5UK0DeGylKfQv8fYTMsl4GZY7lAumgH6F+Sw==
X-Gm-Gg: ASbGncsWoiIfHLBmQc/p5s5++3Ut+5ZFYBf0WM75Id0j4DXgn5kAMZ3Hl1+J7lq2aQu
	MoIG9oK5ejWno6zA7G2voWpPs+5nhh3TDo36meYQ4KHgM8BpJ2v0fiB96gH+SiZutzcSP8JHw9N
	PYkN3L5uTIoq6irU5ZXkU7DwVoc3mluXqucmTai/SQ0H9ZxuQuFPR1iWgvD84o1c3yJoSEVX1G/
	V6u6q1X6g07P4cWpxDiC5JB4i8JkurFTeQ5xuAb7JhNUh7h8aCe1ImuE9M6+oEhPn00EMGg28mK
	hn4mAJrZMAZA/94uA2JZEFF/KSszmhEmrhmiqtEjp/i+aZvBvoWf2DTH/hk=
X-Google-Smtp-Source: AGHT+IEnx4RjV52O3zSiijsH6E3BNZ8saXdXBUls/WGKsMW9q2s9evJ2Zob2tT3/OJnn0BI7VwfuSA==
X-Received: by 2002:a05:6a00:9286:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-7490d4e3682mr25915544b3a.3.1750722256651;
        Mon, 23 Jun 2025 16:44:16 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c882cc92sm252856b3a.82.2025.06.23.16.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 16:44:16 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: gitster@pobox.com
Cc: peff@peff.net,
	git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Phil Hord <phil.hord@gmail.com>
Subject: [PATCH v2 2/2] refs: remove old refs_warn_dangling_symref
Date: Mon, 23 Jun 2025 16:43:27 -0700
Message-ID: <20250623234327.335490-3-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.84.g5d85fe910b.dirty
In-Reply-To: <20250623234327.335490-1-phil.hord@gmail.com>
References: <20250623234327.335490-1-phil.hord@gmail.com>
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
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index e2075a98c844..a9fbb0c8f23c 100644
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
 
@@ -468,18 +465,6 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
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
-- 
2.50.0.84.g5d85fe910b.dirty

