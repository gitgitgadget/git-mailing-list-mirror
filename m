Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC072222CB
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474421; cv=none; b=s+FqQJMSCZggGARuo7cBCPmKp80V3LXbXQalZcaMg3U8VTGfubyeogIdv0DwHTAmRKs5V2THMbIRT8SKxtB9rOgb6D1hdjantWEgYnT+I6W8dUyvia19LC3wVAep8JO/QJBuElRw55JgjBE23z8qgHh3bffG+0yN86u16JjbSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474421; c=relaxed/simple;
	bh=nKMD7RxOa0fe1shGnlwS3zJDbS3MpBdT97kGiOuOxdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P73PvszCfAIVX+ap35J0NbUI0yXAXuY4cDsIgViikOSOZw7nJdDKYX9STqYHMzPG5WFs0V95n4puzrHiyHQi5OUXiE6dqn3XrvkXJ75PvODx/zx4YnkzZ1sfCcdwUzDvmr0jlxsbCmkwMlDrS3TOoVD94ObLyEPY/Mqearn7634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ou8alVFu; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ou8alVFu"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7da099de49so306842276.2
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748474417; x=1749079217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=40FLkY05GvO1BGgtC4XrhebavxThZmicmVluhvmel2Y=;
        b=Ou8alVFuiAYopDMYjierNIg1JiSGnQzkFmbX0gxqIa6MXdHiGsdyHvSDahc51eIpKm
         wckXK36oD08WWC1UZm/jWGKKXR+6rZQjs8aGTRPjN9d3KZipCllzhradyZ8CWH2e/ARK
         EseIi6rLgHtLn2pSnozSN1zld9q7CCQn6QbbnSSLDuYW6SB51S4qgXhESYQ+jikQcdHq
         lRG/q9++Hcv/ME87gTnibEmm8gujNv8jXI6pAMMBZG9eIR4FXTHylzaK6STu1Us0JsyQ
         b1atbKQFPT2OoNd/IPdFMPtbSYh5MpNo2tM9rp3UkUqdETllL1QFGPUnQBsbMQX3V1n/
         R+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474417; x=1749079217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40FLkY05GvO1BGgtC4XrhebavxThZmicmVluhvmel2Y=;
        b=UefyOvnHhXi1dFItKeA4Oo0wC5ORTlsmeJzOGpyEl2DyF6tTVfrJSKnYyOsbeZy3C4
         QkfdEWTHDkpPCLeA0D/goLyu4wBxn9Y8OnJH2SWPRsG3ORadaUvabIEcZ4xLnOSPNHqJ
         KXpnDzE38JclMjtdTx+YopoNKNJVP55fkMmnJ/VdiKPHhu9aV5iI8nLVJ6POQ4+sQdhw
         +7e/2VdQl9VYkbNvzvCBkxehrdZf3fl3iiKOQbJ0B6xCrbFSSpzWfHkfc+M43bvBdZBF
         Wvs9IUUz0ZU4EOQKvf0QuJQ7iEnTSzzcCWunpseSVRa+4QBGzgjLYUP+DXRTfYPzRsII
         E5Mw==
X-Gm-Message-State: AOJu0YxzFaFqzQsbgYgawjLYsV43dhHZH0vOMWAbiQj5jlr/fVDVzH5p
	S27zkB2sOm04E5Ia8QMa1zIIUi73vLHo1KGcazo4+zXk9//wJb0ALANhAnGxH42n4TcPFk9XuPN
	A8pWD
X-Gm-Gg: ASbGncs/l7vvZyHp2RfNm/2SdgrQHGtuLfen/pZqNiefgjCmxN3ctQZOD9KoenKzCtB
	mEqRJTCTtqxmEJmbwF0Ypo+2FVfbkz07tCjeEs+vAoZmFdGiRjnEtrqYYbp8eBzl5mtxTbItspl
	WbEL2Zc/lEyXzVY3Dlq662lUmjrTs2S1HSlLWS1HIUBljZY5LCi4Xtw4Hc9luJ7msK/pgmo3Zsc
	DtGxoiA6mPbVqHc3Um8FoBGsNX5ja+FGBQAOvx5bR1XntgOuSvgAbwxd6JIj3rM0hJ42t3OiV0C
	M22c/aQjhBemx3iYvGQe0Od30AwNh57qI1u4TEDlOk4D+yuSobYFszn4RHAbvtc8/+ER8oqrJdS
	sGF4RhhszRNQsOSrgiELkE0k=
X-Google-Smtp-Source: AGHT+IFQBHXY25zhCOBOIwtCyNALphVzmlHw53P1PzKfNOaiyPqKumvTzSfAmOWpc7r2u+s4WvjnhA==
X-Received: by 2002:a05:6902:c0a:b0:e7f:726c:8ad4 with SMTP id 3f1490d57ef6-e7f726c8bd3mr754823276.1.1748474417546;
        Wed, 28 May 2025 16:20:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e7f733ae372sm34608276.9.2025.05.28.16.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:20:17 -0700 (PDT)
Date: Wed, 28 May 2025 19:20:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/9] pack-objects: factor out handling '--stdin-packs'
Message-ID: <32b49d90732faecfca685d96566268e6f1f4a789.1748473890.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1748473889.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473889.git.me@ttaylorr.com>

At the bottom of cmd_pack_objects() we check which mode the command is
running in (e.g., generating a cruft pack, handling '--stdin-packs',
using the internal rev-list, etc.) and handle the mode appropriately.

The '--stdin-packs' case is handled inline (dating back to its
introduction in 339bce27f4 (builtin/pack-objects.c: add '--stdin-packs'
option, 2021-02-22)) since it is relatively short. Extract the body of
"if (stdin_packs)" into its own function to prepare for the
implementation to become lengthier in a following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 682e80be40..3f6a7c62e6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3674,6 +3674,17 @@ static void read_packs_list_from_stdin(void)
 	string_list_clear(&exclude_packs, 0);
 }
 
+static void add_unreachable_loose_objects(void);
+
+static void read_stdin_packs(int rev_list_unpacked)
+{
+	/* avoids adding objects in excluded packs */
+	ignore_packed_keep_in_core = 1;
+	read_packs_list_from_stdin();
+	if (rev_list_unpacked)
+		add_unreachable_loose_objects();
+}
+
 static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
 				   struct packed_git *pack, off_t offset,
 				   const char *name, uint32_t mtime)
@@ -3769,7 +3780,6 @@ static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
 	}
 }
 
-static void add_unreachable_loose_objects(void);
 static void add_objects_in_unpacked_packs(void);
 
 static void enumerate_cruft_objects(void)
@@ -4776,11 +4786,7 @@ int cmd_pack_objects(int argc,
 		progress_state = start_progress(the_repository,
 						_("Enumerating objects"), 0);
 	if (stdin_packs) {
-		/* avoids adding objects in excluded packs */
-		ignore_packed_keep_in_core = 1;
-		read_packs_list_from_stdin();
-		if (rev_list_unpacked)
-			add_unreachable_loose_objects();
+		read_stdin_packs(rev_list_unpacked);
 	} else if (cruft) {
 		read_cruft_objects();
 	} else if (!use_internal_rev_list) {
-- 
2.49.0.640.ga4de40e6a8

