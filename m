Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00418D65E
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954055; cv=none; b=ttL4woFU0STkwy2Q+qcCx7ogb8ZH8d+kogZ539dfCVwJPZLHV/nPVgU18wFcRkgNurPJhSMVFqxGGDWaWF75HC5/9dpgGFxvMekneIgyekiF3mpuLjdLUSggAWB85JIY6P6YI49kw1B2qQXhn7nvd5s6gEJPZzjBk0jJj3r1Q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954055; c=relaxed/simple;
	bh=I4iRpr7Ee0PwkRVUIv6jV0TGrV2PqU3fMM+GahybNHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTCuwXIEflijET88lX2daT6QgpzTmawiSNzsmmegvy4y3yFh22kJrteL7/YsbRsTjraQ7cjHw2/1kNT8FFfXyDOGe78PVkUbEKniGhUk7VtlH6IvW2zIVZ2FZVPej+Kk+JsA2QpdEy7QN8x8nVuFpFm0LPGdSeEWRvpB9g1pDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re/FOjFm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re/FOjFm"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-710887a8083so518041b3a.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954053; x=1723558853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIIUt6LGsM+7z2VDXO+aBgICFG/pOO5LVlbndntxECA=;
        b=Re/FOjFmFZJHVQ2hl2XWaPrckK85fi0hxyxfpRKj5SF6aWwzcaUTuCJcxwAHMrjFAN
         PhCyyv3pkpT1YKAjJEZpphQFZZ/+Ln9L58kwaMARxESbd1v2FoY62vnzgvFv3K5LnL2K
         FtcAXRAKlvWiFMNjGKWPB2kBgdrwyse5XEVFzvTT9DdzhMdfFx1OA2Cw4QuhVIgUG0Vp
         7V9aqxqzzjDkUq8D03s3jDBHcGFo7o6UuC4nNDLDjCvzr8XWFApS+Ncq+Xg51tipR+ej
         URYzDZS08e9s+Cz1zdbQr2TOTHiOiQuMzGrHw4URRBJpPUWwrCWZYagKdH8q29acdIed
         3ABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954053; x=1723558853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIIUt6LGsM+7z2VDXO+aBgICFG/pOO5LVlbndntxECA=;
        b=mglVbFrJrvZfZ9VKyLnPIs55iCI4rFl/5xz80WUa1ONv5NIKscJXsydVuDY1SCQzPP
         gnbilKbgKHL7ogWoEIYGIPI1B+4ocKn2aOg+xHkqUJdWb3YDV765SaLeB271vVTUVw1K
         h9tBXwYQH98iJfWEDqssyUZyDX/kEXwcfZsOJEdigybm6M4XHixkFRZ2kKb/rtC3pYIy
         JRxiAV9ja7VBP3BD7fVXghT5jXV++eW8kVJR6815a0ZZ7EiwmcYbuk7bCZq6J5PrE+mY
         3T5rmGvzV9B4Vn31JollgO0Bg/mnmfamriB/PceRebZ1zjIjoYilju4vJZLNH2/RR/Ul
         cHmg==
X-Gm-Message-State: AOJu0YyQ7s6VHmABZrDmBiH1Q9P3JQ6/3r0gi6qlYMBAX0p7mfJ3vFva
	HUuDUWSB/JzNTL05IQ8/mo2W2IvpQzcqbspdo+FrY+C4rDiSTBnWgl56jcHxYcrrdg==
X-Google-Smtp-Source: AGHT+IFkQ1ivGA7iey9Fly5XnFuWsK5Ht5O622zdWneMfvWGNDuXLHyumBPPZ1nyIofDFOfEF0vGHg==
X-Received: by 2002:a05:6a00:148c:b0:70d:3438:9689 with SMTP id d2e1a72fcca58-7106cf94dc1mr13520440b3a.5.1722954052855;
        Tue, 06 Aug 2024 07:20:52 -0700 (PDT)
Received: from Ubuntu.. ([27.59.87.1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec416aasm7040563b3a.70.2024.08.06.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:20:52 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/6] t-reftable-stack: use Git's tempfile API instead of mkstemp()
Date: Tue,  6 Aug 2024 19:43:39 +0530
Message-ID: <20240806142020.4615-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240806142020.4615-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git's tempfile API defined by $GIT_DIR/tempfile.{c, h} provides
a unified interface for tempfile operations. Since reftable/stack.c
uses this API for all its tempfile needs instead of raw functions
like mkstemp(), make the ported stack test strictly use Git's
tempfile API as well.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index e033feb8ee..14909b127e 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -76,7 +76,8 @@ static char *get_tmp_dir(int linenumber)
 static void t_read_file(void)
 {
 	char *fn = get_tmp_template(__LINE__);
-	int fd = mkstemp(fn);
+	struct tempfile *tmp = mks_tempfile(fn);
+	int fd = get_tempfile_fd(tmp);
 	char out[1024] = "line1\n\nline2\nline3";
 	int n, err;
 	char **names = NULL;
@@ -95,6 +96,7 @@ static void t_read_file(void)
 		check_str(want[i], names[i]);
 	free_names(names);
 	(void) remove(fn);
+	delete_tempfile(&tmp);
 }
 
 static int write_test_ref(struct reftable_writer *wr, void *arg)
-- 
2.45.GIT

