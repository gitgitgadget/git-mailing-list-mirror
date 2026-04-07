Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE73101D8
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562792; cv=none; b=ISuRq6hebDywq2vyxtSuI1s/DGKA7O/7xmwTrwjqKrGBlqn2pjk+mgawUKpsPK40EAVXR/yfIQj49mntymKI0SnIfZ668r77lWvfnG7tlPJSOycurK7fnpe5b4c20k9Q7N8W8tdg5taDT4TMgw6wkdqw4P16fsSxV/od9cwJ5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562792; c=relaxed/simple;
	bh=JxzhUlYlsPdpbl1JAN2gzMwlla8I/UEmDZlUQP6x2Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjMEVr4sk5+FPjki512HtEUFInx+N/t5mG9K5Eh5TVun4xoSZD1wYIUrDUiV+DWBf3ulTiBDeherE/fYcxwN+gcIPy2n8yELFF1suY2gkq4/kTNC2c2BOyXo7Rt8i4S4KCwEaEt7CGlwp/488d/YChZHlsHB50jK0cTbJhbhMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqVUxq+5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqVUxq+5"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso4533726f8f.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562787; x=1776167587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jof3e5y2lmu5down9HotjhzqTnOtDBXvMfTs3zu0xsQ=;
        b=JqVUxq+5V+GhY4l2DJTXiG55irIZXRtU5jBnkk8/y7eIZoxvsSSnHCmP2HqfI0heUs
         c4OC1pXyAZqxEzNh2ITRPz2/UBxiUnqFHGf9b+GZJDS8dvY3BAoV0PM2wpLEhhPs7zEe
         +14P6kbYuC4Ue0S2bg52IwgJADROhXhj0mhURlMYuS1CsD8o6eDg8N5AMvc6iuGlMERU
         yC6M//D6bvDVz6u3548vYaLoHGMAJAkG4t4msjdQLc8zWte95Rrnszbn/3bx0QKjnDS3
         5YrJe2FXN2226mhR/FsXQ4YKU/3VGu19G9uGgwTdoUJMLRbBXLHQlUg11ihv4UkSa5za
         6ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562787; x=1776167587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jof3e5y2lmu5down9HotjhzqTnOtDBXvMfTs3zu0xsQ=;
        b=W+WJoV5wmM5xLKQy/9uq/9iixMwasniSFpyBjb1RdHMrqIj3vEbYiDAE2CFhQSzj3c
         NyQst8e+6FEf1FA0KvJ+Q97HmSG2OnZrv8944Z8ZBCjw2atqVsyjXA6Q4Sia6k6xa9Ed
         kA4tAAcUCoBn8gjVVFRxn8vDtPiTjGcS6hZjKHbOJ/cm7rd5M+xC5eaNi6iIrLWHH4b0
         P0oGNaiT66gzQKDOnjxKb5sXTWTtdvcBD34cm8mahZHzBIFSMTU13t1xqzWLE5PuTNW0
         +HUZOyMvz41GG4Ys6h/PdrFnnQJu3/9Vv0WsiBOEJOYPmPxTNWiAW5D6ZBpOQCy5knkW
         Ib1Q==
X-Gm-Message-State: AOJu0Yz741M5/zm2xE0fAdyOD83Q72BJZgtR0IZ2gfCt0jBFPN1wH8MD
	4o8vABoenJJWeP4iRf3fu3uAXj6sVEnT2xMZGMBTyW4TIIuvemwKw+PJjQju/A==
X-Gm-Gg: AeBDievJv+lKdXWctCVoXzYHBcDmi8vaay/fa5psKPd8hbbEKmqSV5d8jJrF3/2QR8o
	MWn6OOIdUZ1BjNQhmuNEgvU/z+Er1aT0x9it5zyVGhjxi/XIO28b+3U0dpxoEcdbCSM3vGApc0u
	Lzcs64RhR4kFBLagidgIeKZ+l/PHM+OK58is0IY/wtLsU/jUnFwZjdZdOALQAMiX34MaZAJaQQH
	TSMbiKFTcwLOqabaI33C2dVf88o5gox8GGg15X18zckjdR/3cVFPoAxObF309wlEgVcwT9DwwDb
	YgamuwJ0ehyDUCfGw5U7WG2CH3+wUupIt5l61xDruaiqqSMuBRNpY+diQ4zog8/lRW+RTbilU/9
	qvl3QxCQldq5LvnypsTJmmmSeXW1wKdDmNrAUVWtp9g1JU2lWoAdssLbcXnLRZgOj1BzM4ADBK5
	d0tYqwIDk2efTWU8VWVXlvEweyCQQLlqQEYuA9frIM35MwG6yRRbaHQtN0mnAEgfShoMY9HiCmI
	Gx5yn8E6X1z0pwcdq/lMMIPT5+IOQgTm0zZalbw+8D1NJHF/w==
X-Received: by 2002:a05:6000:1886:b0:43c:ffee:ee95 with SMTP id ffacd0b85a97d-43d2927bbfbmr25714109f8f.16.1775562787098;
        Tue, 07 Apr 2026 04:53:07 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:53:06 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 05/10] promisor-remote: refactor should_accept_remote() control flow
Date: Tue,  7 Apr 2026 13:52:38 +0200
Message-ID: <20260407115243.358642-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260407115243.358642-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260407115243.358642-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit made sure we now reject empty URLs early at parse
time. This makes the existing warning() in case a remote URL is NULL
or empty very unlikely to be useful.

In future work, we also plan to add URL-based acceptance logic into
should_accept_remote().

To adapt to previous changes and prepare for upcoming changes, let's
restructure the control flow in should_accept_remote().

Concretely, let's:

 - Replace the warning() in case of an empty URL with a BUG(), as a
   previous commit made sure empty URLs are rejected early at parse
   time.

 - Move that modified empty-URL check to the very top of the function,
   so that every acceptance mode, instead of only ACCEPT_KNOWN_URL, is
   covered.

 - Invert the URL comparison: instead of returning on match and
   warning on mismatch, return early on mismatch and let the match
   case fall through. This opens a single exit path at the bottom of
   the function for future commits to extend.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 8322349ae8..5860a3d3f3 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -651,6 +651,11 @@ static int should_accept_remote(enum accept_promisor accept,
 	const char *remote_name = advertised->name;
 	const char *remote_url = advertised->url;
 
+	if (!remote_url || !*remote_url)
+		BUG("no or empty URL advertised for remote '%s'; "
+		    "this remote should have been rejected earlier",
+		    remote_name);
+
 	if (accept == ACCEPT_ALL)
 		return all_fields_match(advertised, config_info, NULL);
 
@@ -669,19 +674,14 @@ static int should_accept_remote(enum accept_promisor accept,
 	if (accept != ACCEPT_KNOWN_URL)
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
 
-	if (!remote_url || !*remote_url) {
-		warning(_("no or empty URL advertised for remote '%s', "
-			  "ignoring this remote"), remote_name);
+	if (strcmp(p->url, remote_url)) {
+		warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
+			  "ignoring this remote"),
+			remote_name, p->url, remote_url);
 		return 0;
 	}
 
-	if (!strcmp(p->url, remote_url))
-		return all_fields_match(advertised, config_info, p);
-
-	warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
-		  "ignoring this remote"), remote_name, p->url, remote_url);
-
-	return 0;
+	return all_fields_match(advertised, config_info, p);
 }
 
 static int skip_field_name_prefix(const char *elem, const char *field_name, const char **value)
-- 
2.54.0.rc0.114.g05d466edb8

