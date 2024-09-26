Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE1173355
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314763; cv=none; b=JY2vz3+LiogBd/+hv8hMqQHHC9ROF97sFaOFqe9/ZHuPvRbmzR1AINbbL2BUF5p8BnEpFK1DlL5VV4GiyKk8GsrqjsV29G7N8zdmz0ykCPNUZ9cdriu5C4fcW0/rc+P1fuW5je28Di+9LY6fF8E9vy6j8RibinDGVP49qbF7zTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314763; c=relaxed/simple;
	bh=7PZ5N26twyh6vA846zqPQNmGJetZcCgwWkqpIK46jec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3ZQgg/KFp6YFMQ8bUmYGt/GFwBcUobWHYhTyFtbdZqLkp/CThb3qA7mmEOLzu7DowtXjc1cehBbmsb88FLuTfhhsPRM8dfqGJo02GAJDAlpYhjYcGbEMxJv6brddwGBZxQ83k1ZKqss5s+pHaQdn6x7t4GliJVzgdX9BkV6e1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjPR2aFn; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjPR2aFn"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99de9beb2so31700785a.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727314760; x=1727919560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/06S4Feu/JCmXq6V9VqYC/BB0H6cFIJE6S61QBtt9E=;
        b=VjPR2aFnAV/jW/PUMWJ8ZNlK8JvY5iKVybh0ROjwbgx07UCVNLBMpzc1rkgy6VngYG
         9Qf6nk9Emz9aCmrY2tDNt5CYljNNhJqBDSW+C1z93A8VN1Z0qXbtKM4LyBu7gseAtqbW
         X5jApUGF3Jbrfv6aDeVyr9IRTMXanDwjRMAOLSTUlLn0BvaUSsfsre78y0zgo1NPZw01
         iqjMScv2wZjKkYGGnh6+2cm/HhjYD0lAkiqHeX/bh/sFgryThFeKPafx0TIgy8R4pTeL
         mtdY9SMGUP8T18hUKabNTnVOEtrLaKyN0sv8uOVLINBUXZS4Oso27tuNHHSvx/1bLonb
         QNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314760; x=1727919560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/06S4Feu/JCmXq6V9VqYC/BB0H6cFIJE6S61QBtt9E=;
        b=Nxn71HcCrlBcIsTpfRmZFldMWKZtHi3jVoeAEcSAYlBo++6bplvNC9ngpRum/ppROo
         ABoRZKiQntQY6M9IiBVILA9UXXFgrdD0T6HkLERg3YLK8EQgHlzxp+WdzRhxvVHyHjZ7
         h+NZn5fkXtciM9Bq6dwTTzqhwv9OzakMAV13wa/Cpt+cBcUmg4cyElvcmtdwtnnwK1RX
         xYLY5vSpgXdwlADqOVlgHBu36HFyZAy08fw+TTPCpP8tEFhALf98Oscjzb4fe2hMyETg
         t+usw7YtgtbTzmi59yULsmOjytqk+JgAHSZ+rpAZjJTvwZ7KyAePCp202tjTeLvnf9fN
         7Lkw==
X-Gm-Message-State: AOJu0Yw/0qW1lRgk1TUuUiFJQvxeaKJc9iAFHyF+9xQ/aMIg3IOMNdgq
	3mc9boUfCRdaGUim4yVat+1MxGf5ZmQHiSnf5ml7DpOWrnG4Qg6AuEjbE92l
X-Google-Smtp-Source: AGHT+IGbWhOB9pYsEu0MkUpav/uI4HOPPtW/vR+lEFQJeWPArFjFLPIrmJS9MqlWymHhOiureS+zYQ==
X-Received: by 2002:a05:620a:284b:b0:7ac:b0e7:d735 with SMTP id af79cd13be357-7ace73e4328mr862309785a.8.1727314759910;
        Wed, 25 Sep 2024 18:39:19 -0700 (PDT)
Received: from localhost.localdomain ([142.188.15.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde49acebsm227789985a.0.2024.09.25.18.39.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Sep 2024 18:39:19 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v3 2/6] fetch-pack: move fetch initialization
Date: Wed, 25 Sep 2024 21:38:52 -0400
Message-ID: <20240926013856.35527-3-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926013856.35527-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

There are some variables initialized at the start of the
do_fetch_pack_v2() state machine. Currently, they are initialized
in FETCH_CHECK_LOCAL, which is the initial state set at the beginning
of the function.

However, a subsequent patch will allow for another initial state,
while still requiring these initialized variables.
Move the initialization to be before the state machine,
so that they are set regardless of the initial state.

Note that there is no change in behavior, because we're moving code
from the beginning of the first state to just before the execution of
the state machine.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 756fb83f89..800505f25f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1700,18 +1700,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-- 
2.46.0

