Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C141FDFBF
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549794; cv=none; b=McRK8KkgHCTYjjheRyX46F3pN3LueFQVBF8nRjps7aSikUYVHsKurIjfcoUjcUTUhlN5cph3GsKeMSKcxi48G13FhpZxf6Y5On6febrpdIdFFWzNAOiM4o3JqZfnwMaIl4N2+TvLwny7u0PoYFluTmeyG6KR1m6EaaID7hpN3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549794; c=relaxed/simple;
	bh=ldeGdVi+mgDfVE9gi7oaN1tY72SqogFkpXeBaDtEpnw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gv7bwTN2s8wrpBYvxrzdAWygWydAue//uM9ZN7tEWGjhygLRSIdyG8noFqkCrqOgFLZLKHUeEQXqoQrOCTPE3KrbCOKHIEb55rUoKfJLDH2hQQW/zY/UmB07XbimeZD8yG2zfE5+SN4AgOE2YAeC6MNNXLCKj3OTMpXrl/hdLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IEMF/WHX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEMF/WHX"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292dbfd834so7524411276.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729549791; x=1730154591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYWGIP9DZDh63y2vjIrtLCpGcvNVTUDk4l/rqdNUSxQ=;
        b=IEMF/WHXaVMXPpzuJYwT1YJ1FkXb7ZCxHG3H11sAFcb1FjHTn/h+511QZwv+YJn8iE
         HDa5XYNdFehLdF5FoRKjM7QswkHSU8naT5aTerONMj+1PSMQuclBesZlyjKBUNUP4DDM
         AJz82k1bt98xaMjLHL0YiZkHxBeHdkkF1ubqhrgIDi2vNrjY3zhX204mO195CYuvkjEF
         M3HG/DVg560TNvcMpFXxerRKpQxoOCIO0liHrYEImLndze1LTe+U0PP+otNNN0mBSuU5
         enrQHEMghYo3y5GqDUh7DCuNpbFH0196nGBLPgji82rzgeOE8XfI30suVQWDD1vwk+/O
         Rh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549791; x=1730154591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYWGIP9DZDh63y2vjIrtLCpGcvNVTUDk4l/rqdNUSxQ=;
        b=cLkQMPLHra8YfHQD/TgHMzggf+iViKRgCA1+P7DQIEHQhJZ8N4ESiKlss3MhRWFCOS
         3Cdy8lWL7sgDZ7j2HigkIxG3/SPq+6HkIkkhs7pKPJgbIA0DJzE48yT32ohOEPxo7dUk
         ZL9AP4j4OZuHjGxV9RqH5S1hfB80lVdu/tbgnOwnoBMdmsES2iAyoKIlA7pILZuihmrT
         bONSEyGeGA5DqeCACxsrJ1bq6YlErTKp7B/IuE280sLHYDQgxRPl4c9E8bGWTOMpveEV
         GjdEqVvuaWdP2Kw6HqMaFFWLEpjv1BtgK7NdyAopA1rM7cyfmpI0SNmnN9hQGJK+vPy9
         aDng==
X-Gm-Message-State: AOJu0YzGJqHyPhkSDquwACIOSHWNQ9ztjLDDJr7Q5gr9/CEWH2jaO3sg
	byZFg0qFsWO991CoKBgZ9a8TkpihvfXnBUrN2+YJMb1p2Qi1gE3TDZ8mybcy2JnlFZ5LKyD8IM6
	Cq4jvd9+P6dYJ26tsY/64mpkJKih8Y9Qu1LB6I9NIbtgNJzuYdAvCM7R8oxKmNELOH4pprRurxP
	B1g8rDJq9eSWN62KmT4GPFS2ts1uvsZpIjpAs8GEkWItBvfgqhVLJ4EQoIMy99NeYdNA==
X-Google-Smtp-Source: AGHT+IELYfxy51+3Jm+0cbXyefjrE1XZkxPvLdAX7Ml2+/ORmibj+/mHXB9eJo83Ou6+IlJcapANvRwNmRYoUdsA20bn
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:5f48:7349:7c03:e18a])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:48f:0:b0:e25:fcb:3205 with SMTP
 id 3f1490d57ef6-e2bb16b7a2cmr23204276.8.1729549790744; Mon, 21 Oct 2024
 15:29:50 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:29:43 -0700
In-Reply-To: <cover.1729549127.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014032546.68427-1-hanyang.tony@bytedance.com> <cover.1729549127.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <c66937e675ee2e6e4dac067f180da949f0bc14bc.1729549127.git.jonathantanmy@google.com>
Subject: [WIP 1/3] move variable
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

---
 builtin/pack-objects.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fc0680b40..e15fbaeb21 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -238,8 +238,6 @@ static enum {
 } write_bitmap_index;
 static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
 
-static int exclude_promisor_objects;
-
 static int use_delta_islands;
 
 static unsigned long delta_cache_size = 0;
@@ -4327,6 +4325,7 @@ int cmd_pack_objects(int argc,
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
+	int exclude_promisor_objects = 0;
 
 	struct option pack_objects_options[] = {
 		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
-- 
2.47.0.105.g07ac214952-goog

