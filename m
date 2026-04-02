Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483393876A0
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113604; cv=none; b=H28v8mxKrzgfvp0QPSX3IaZF8VDQ85kboEvIYAT7izx/ILbp6JMTpjILPhEkWAmIebjTPH9z6a3rGypm45v2hjwWWCDQ3a2xhThbg05Owa1nRCGXLbB3HoRHOdBiQrg1Fen5qKNrYwmT1kJc9RtHApAl/l3POU3vR0CI1bz19ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113604; c=relaxed/simple;
	bh=ez/USSC5ohT4E2WTX4vvK8CEji6Txz7IaWW9nmLmTrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qN4MiclmWONaSuVZhlqxLtya7LaKbmebtRpwoFnZpF2pz/UCCqEzwZ+WK8fcFcgEhQeLiP4skRahQf4/Vd/rskdMeOFqRzvM5WYEb/VQVX2c1CjAAWYonFU+n8LBGO+1To9Bd5Ujn88uamZxSmudlMNED1nOGtMmBtAqhgXPvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW8zLCKO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW8zLCKO"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488879b2e6aso3932435e9.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113601; x=1775718401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95bMTJpPBFLjIzslOTaYfORKpqeYFmlwWk8/nMaKVlY=;
        b=BW8zLCKOTe4GezNU2gpMxY5vmkBslsk0JbrqU3CNNZeRuHBtQyahoD0EQ2NCmsfoYh
         H4goiodZj7ULmXyQKcFndaD3C8rOmFWFH40KPP+E0NelFsNkAyL5IMvqqjIoNbWv9aMJ
         xy/j/ZxGCdbXUU+2yXd8hLTffLBL/lMdNHxzsIxme7Wngjhn5LQK2c9TAoh8q0lZxGOR
         qyddijsRvt6xBicYnnkySNzEE11jkyHr3UvrADOeGWF+UczvyA2v+B5juvooKH/1tMTA
         U6nhhRTlp3POcC5MZ2Qb1+dwY1ZvIRM6pco3My3t2A8Plu8+zs4J5H+1J9y2v6kR19Ko
         T2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113601; x=1775718401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=95bMTJpPBFLjIzslOTaYfORKpqeYFmlwWk8/nMaKVlY=;
        b=cDKFox+OI1akJtcPkstYfrYIyX35VqrYn/O8cogZP4HqiGQAHSXCpCv+AHBhkM6/gz
         YEsELmW2Z+dekqzYRFWcjRQpj3dnJR/uBmDTxxYvbFfSf3QKKNXMpjlc1TiitHLiDjG/
         Dm+ostfkH3w5AGHymq+3ySIM9FfttKVSQm/H4TxpGda4pBT+j9sR+Hnt5LoiO0mMHRaB
         IaWm38kIOR0bvLKpTXMAouHKEpHUXWeRT5w6FSZQyi4bkkcyiISioGTsqTq0MdxyREEA
         KRI+sphBu24QhVF5vah+Oh3C9P0GIiZyQNLw3m16YsUKWW/yJK2PlywjI4luMHLeEd+x
         01Sg==
X-Gm-Message-State: AOJu0Yz1Ja+6hZidLBwOftEhZWdpJkhzyKIbvIU5VpAFgoQhaQV38PCm
	0QEpUfnSQhkv+hQVGhVY9W1A7T5BooWyMps0Z9i5b3ojQKEv4nGyql8Q1McDRQ==
X-Gm-Gg: ATEYQzwCMRfs2RMYR/tTqAltuqXgd9uyGX+UeYShLHpz2MtNl65c6D5QGImpEjsFa4p
	/5eFBaSQwV0BQit3VsJfxx9HYo7Y9oOs4Vyxw73FTg4lX/5H49M1hv8asAEMkL3I02aCNs4g0AN
	DinxN+Dw9/zXN15yOWx6hrmRrCBPBkEL4hlgDchg07S+P4GKIEWT0lQaB+SIGZsuXzQpx2+ka8D
	MIDSrVBb8mRvXERHkJRLIMfmX6x2CMzbEfFen9ciGjwENYMDQFkhX6mp32RIp38sKknHJMFKZwb
	FESedbhCbK47NBzWsQFJEyhea9Dyia5uMStj3sIAsE4Byyx0GxTs68pfYPop3r/pa1OEzN/KFr1
	3URapkCNOTJZaP0aixyCq8iXgiHSELqcKguGNwe108P/jtYNRa3QCt1NVZxhRNQGQzOBV4JeIwV
	cN9E9p8OqnjFu0B3iML59DlxkvRiiJPPjrbk4fW4a6PlGjZj0TNOd/1wCP26XfHh+BKrM2o/3fn
	rvn8OJajg59J6sxIfmic6qCkzNixcqY5AnGpOI=
X-Received: by 2002:a05:600c:8488:b0:486:f4d2:eac6 with SMTP id 5b1f17b1804b1-488835682c8mr113345415e9.13.1775113601202;
        Thu, 02 Apr 2026 00:06:41 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:40 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/10] promisor-remote: refactor should_accept_remote() control flow
Date: Thu,  2 Apr 2026 09:06:08 +0200
Message-ID: <20260402070613.85934-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.765.g57b94de1f0.dirty
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
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
2.53.0.765.g57b94de1f0.dirty

