Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7B78F2F
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500538; cv=none; b=hVqS2CcMFRGtAMeMgnBmj6P1zCAFpssAEbRdSE/XpTWeAaypJPJGmC82F+QM3nz4riKo+N1eRboNTsuk1MWXFzdTVe+RCX6xAW4PtEYIZbHMqfrJ+NlO4NDTObaE9ac5JGK3bKdz6GBmkLILds2OrAf+usuOIc8pTe5LjDRjWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500538; c=relaxed/simple;
	bh=8ob7DUj2Be0a5XqV1DM7mBpDJL3/a9KqDZ1OzCiXtic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f63M73NcaM6Of9043QvR2r7IIaEfcc5pmeKH6xQ/J/bg8zYnkGsVPgn/mr/caN58vfy8uY+L1jK+sVgMqzlVgF7JFe3RtLQRiI1hJ0lMhSxqbiOjYLI8bZX7V02UmRQH4cQcZCPOGG5U3xyiKPyXltGwSrSuiV7UxkTrQZMh5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=fo713IgR; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="fo713IgR"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-809b19a7f25so13915237b3.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500536; x=1783105336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yV0/jPyDqHD/0arJ5FlYN3H4hU3rMLXSYBmy83yd5Fk=;
        b=fo713IgRCOag4d6YOUeBcEKjlMsLT+N/7fGFxwzZzT3LJV8jYJ+7LTPiTvxP3NSKbp
         Sap6yZin6xTWxWPmfJS5hTE4DTGwRrSpDEzAPfQAU4QziwR8jdMq7lBilgiMyDnsTwsK
         JcaOQBX6pC02ZqF+7ZAlNRcQsTaXqeK8xXzuIQRJfLWQXhJqi4lUQErrGw6/ME0+CmRu
         6Gd9ZFue6FyS1FIl3QayySkVwkhQ6pq8bOKoD+gbMkJ8rDyN8ev0WcbPxMveYqF3rX/J
         PFwBSf+jgEM/6r7KSsh2cA9EZqYtiNRc0oMVilzXmKFr/T9Z+dLf5RD6pmiPPbqBT80l
         J3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500536; x=1783105336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV0/jPyDqHD/0arJ5FlYN3H4hU3rMLXSYBmy83yd5Fk=;
        b=P9WFwUKGgHKCT9VACGQApJ7FzochlZf85Fs++OY+muPAXMAoN1T6QUcSI0KGfJmtgG
         fr+xHSAdMwfkcsp2WkvS/oZeetCSm3tHulwHkaeR5eTAN7fnOLs/n/thkwH/QBu5ZcFn
         Kh/ebMAJpEV/QdZdg0Tu82K92h6+En4bEUy/pHtHBtiY+S4YrySG1XgBfMjkEf0XEBe6
         STwTQdNXVR1XL/5z22RWkcfUGj/EhktjbbLCBY6JQILIOWIq7JIRz3KfZeEfSQno77Ou
         p1W7QaDAix+dVTWoM8pMX0fVAV01DevT5stQtUzTGS85KM0tpaQvVYNpg3cKiONSxRCB
         EqPA==
X-Gm-Message-State: AOJu0YybJmY5mZjwBFJ4DshwmCVA6g/dL5/PryDUCaofIXxgGtZ3nPaQ
	JrDQM7D94PlvCFXOKdLUmMLv+8XsPcJ9nE5yUnWa2CZTXn3QIWR86OUWNaN4fnrGmwSIA5w28qZ
	0/3mwjz4LiNx7
X-Gm-Gg: AfdE7cnQrYwhBMauDKseWHcRK7Xc0dxaDlM3Dm/cuFlQ3Cik39NPF6/err/RIfjo+/M
	TZKbzCWO0aQaOz0RmxsjVDjsa1MCeoy8oq3upy3VBSO9PrV6+p+VMGrvnhsRZZbyWT22Ur4z8/N
	e9fUey81Ml+0QZ3m8ZERl2kyhbr+tp+00Gudr6rEbPB0rUV3AdKcjJmoPMLk43jr237yU95ratC
	zdqY1lZiY1KFai1TNsCdTKIBt9H/tCh14hz3rY98xcvb2oR/54BqxDAA5SVT4SbRipAyylhUO2M
	7orBUTcFA2TXnsq/h3l8CXP1XsvOw5qdVjFaHH5YPZLHUNHv0po8UW3k9ROtRATxfsPJkXFJToT
	6HbfoYmT8BFyjKgQxOQoQ7NF5ILfi7UsdEHax0npeyFJvWucMVEDuDY35s8FkNE9RfLVBZzYFLt
	5aYOTdO+7m3jJkughzW5WcaDGqaqrOn/X5IZYHz261nR03R4DeGe+VbyGgb5HBBIFyXIq4D0q0I
	7n4OBPCv9SmotEtYJSht6sQMyzkv4jqy6mW1XIWl+jKCgLv6ntpgcfBso6iHfS2k7McTxb4vDVs
	98AWHw==
X-Received: by 2002:a05:690c:9b09:b0:7b6:cd36:84af with SMTP id 00721157ae682-80a6a09eb58mr83193457b3.32.1782500535458;
        Fri, 26 Jun 2026 12:02:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80aa19a0516sm22083627b3.19.2026.06.26.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:14 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 01/10] repack: unconditionally exclude non-kept packs
Message-ID: <7e607b7b64eb347dbf92a0dee3883aaa34bbb177.1782500507.git.me@ttaylorr.com>
References: <cover.1782500507.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782500507.git.me@ttaylorr.com>

In `write_cruft_pack()`, we handle excluding objects found in non-kept
packs from being included in the cruft pack via two code paths:

 * When using '--combine-cruft-below-size' (provided that we are not
   expiring cruft objects), we use the aptly-named
   `combine_small_cruft_packs()` function.

 * In all other cases, we handle it directly in the 'else' branch of the
   same conditional.

Simplify this by moving the non-kept pack exclusion out of the
conditional entirely, so that non-kept packs are always excluded
regardless of whether we are combining small cruft packs or not.

This is a preparatory refactor for a subsequent change that will use the
pack_geometry struct when available to determine which non-kept packs to
exclude.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-cruft.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/repack-cruft.c b/repack-cruft.c
index 0653e887923..6a040e98017 100644
--- a/repack-cruft.c
+++ b/repack-cruft.c
@@ -9,7 +9,6 @@ static void combine_small_cruft_packs(FILE *in, off_t combine_cruft_below_size,
 {
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
-	size_t i;
 
 	repo_for_each_pack(existing->repo, p) {
 		if (!(p->is_cruft && p->pack_local))
@@ -30,10 +29,6 @@ static void combine_small_cruft_packs(FILE *in, off_t combine_cruft_below_size,
 		}
 	}
 
-	for (i = 0; i < existing->non_kept_packs.nr; i++)
-		fprintf(in, "-%s.pack\n",
-			existing->non_kept_packs.items[i].string);
-
 	strbuf_release(&buf);
 }
 
@@ -80,15 +75,14 @@ int write_cruft_pack(const struct write_pack_opts *opts,
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
 		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
-	if (combine_cruft_below_size && !cruft_expiration) {
+	if (combine_cruft_below_size && !cruft_expiration)
 		combine_small_cruft_packs(in, combine_cruft_below_size,
 					  existing);
-	} else {
-		for_each_string_list_item(item, &existing->non_kept_packs)
-			fprintf(in, "-%s.pack\n", item->string);
+	else
 		for_each_string_list_item(item, &existing->cruft_packs)
 			fprintf(in, "-%s.pack\n", item->string);
-	}
+	for_each_string_list_item(item, &existing->non_kept_packs)
+		fprintf(in, "-%s.pack\n", item->string);
 	for_each_string_list_item(item, &existing->kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
-- 
2.55.0.rc2.10.g29e31820dce

