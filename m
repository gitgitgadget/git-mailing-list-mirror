Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348C3B3892
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500554; cv=none; b=ovpppr2fJ2HLBYi2qvC2vERlJG8W1J6FEKcEBnCutj+rK3m2bMAHluPob4RyQ+AJCPY+iYu3YnpyjwRGZR1zxzAl984OMSS9QH5DLH2JCIpUCz7N63iXXwg8flGaKhhuuzdL44FoTGL1BvPkrNPVVtW28JGlrmp4SOY75bq6kDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500554; c=relaxed/simple;
	bh=1mWYRr+QtNcQQp5trYnfQg1PQvtMG9ra/og8dCdNURU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuJtuqk9ZTGC2n7/mmj8RDfyC20L7rdYxJPo06kZkjxJGNu7pwK+X2FqPpZE7es7i5txGTIlKkxgZjsCuYLilkhWaBSBebchVeOtBgpAuxJjCWOQMOTt0ea5GujxOJTZPngtMMODA+7iB9oG0aDQqhYfKumcpF/ohqaXqJZtxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=qhKwa1xs; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="qhKwa1xs"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664a2c7b579so923463d50.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500552; x=1783105352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5DJ5lUqz/Se4ZsalDWJRdsIQYqWjcv+If3kcmvtJyo=;
        b=qhKwa1xs75L7pa2yzxgPMiucnQIYSqxCOFtUH/RgB07101+eIj9Y52LG8Fby0NzVqH
         mDOb/xSPyltZgtUJ48u4PT/eyie8f9Iz+bxJW8o1B9ul2R8Y718xAm5D6bieLNjscAXY
         27kmsD9Zu0ieT9v7BXXXMPInZitDIp6lEvW5CPgcTsDdv0bA5g0w0hDlfWMnESlQB7lW
         RvdK/I6+qMsS/Gjm2zBhx/NHgMSxP/qzefx/rErIMgqWrn0CCPfX0XugCmfIPkX4+vs8
         DXdY/Mk3VWAXIsYT8I1D2WCdm4A/t+JzgXofcbRg4UVDCMdF4Ndv0UB5kNEj3zTMkz2e
         jj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500552; x=1783105352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5DJ5lUqz/Se4ZsalDWJRdsIQYqWjcv+If3kcmvtJyo=;
        b=VuYdFH4CzVlzdD4lnn8CLbwqJxhHlEPwSkRiyw7HEEpQ+8z+agDIQkXaDjnNfzn3bK
         jbiG/nvxb+0WSz22IeQy+1jQ3OUZOy2e9VcejdQEjV7dYmH8GtfVlPMqjmEVujfwVpgk
         gVlO6Sm5H1aLFiAiCTZ+GNMBWZHf0V0HdKTGBW94SyZeAiOrbcqd+E1HRQFtyzZQWdlO
         UWpn74sQJwGmMFe5mCq1QP3JSQ5VaEwIsZs/f6ncj6dq460yMlJ0yM9izafxqWnQdXHW
         UXsN8zJcQxVf6xQT3ZJWZ3nY58cjEkq6l18fCbBudo3+Y5HFnBb5SBTLSjdEG+PF25bN
         92SQ==
X-Gm-Message-State: AOJu0YzXI8avdlXBYoZBtwnf8uffY/moZG85w5npsY4pnOiWmP7WZkZx
	hPg7DuAJvELrcBPuiBFTAVUzYzSPducbXkAVLcZOi8k0LOnntfAWyfzj50WcZj6otisJxCTY9X6
	pqwpZlM1Bmw==
X-Gm-Gg: AfdE7cmSoTyIhz/2/fkdEo1896mHlLG72h5JKIG0Rm7ktoHnoKhky8C6yJsL+6VvrKV
	7zv18yZtci7WwDI6Cj/GH5rxb9ooSYJgL9luwdDGkx7VTMMFVYnpHcdsw2QeQJtLttCtKZweMOS
	KCAwmacExy0/KDrt4lQc/iunJXeVAqzAlQxmSp1FpaaGy3/RSem5p/Yw+qhNNcvAswbMFtTAB2U
	WZnLLWH0Z/v+H2m21uiuZ58Rk7/XXDPUrxUoezBIInlzllGPfbMN+srALwYVbUC1dqIuE76yBXI
	ZuajBafmOA1t+N24Laepi8q16rdMB9ZjWQ5KXNIGzmcXT3oCyhCH4wDWLBCagHeeHcyWnMai0Ig
	040L0XseUTN+eEFRyAp9nnAZFdMR78aVGCczQZJyD1DpQ8bwtG9JB1M+a8R8ZdGZSzrwuwrX5HH
	A6XXpODdrfvKa4tWYvRW/bed7bbndk5mNHNC8+wUTH3FsC8PSKC4+eWFdksH1PzOYQwKfcDVb8s
	uaqCSfWYXSv19meO8KytD5azw76+7m33kj9b/ZjB6yGqc7d3grKAJSzQjZo56UV9Xy6O8hWQW/G
	q4Izbw==
X-Received: by 2002:a05:690e:1686:b0:65d:b511:3ab1 with SMTP id 956f58d0204a3-66487fc32eemr6093601d50.25.1782500539026;
        Fri, 26 Jun 2026 12:02:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f957410sm3310678d50.15.2026.06.26.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:18 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 02/10] repack: extract `locate_existing_pack()` helper
Message-ID: <1493023dccfd3e231ddc6a155c7fb5295a9631ec.1782500507.git.me@ttaylorr.com>
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

Factor out the lookup from `existing_packs_retain_cruft()` that converts
a pack basename to a `string_list_item` into a reusable static helper
function, `locate_existing_pack()`.

A subsequent commit will introduce a new function which will need to
perform this same lookup against a different `string_list`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/repack.c b/repack.c
index 571dabb665e..986c74ac7e8 100644
--- a/repack.c
+++ b/repack.c
@@ -226,21 +226,32 @@ static void existing_packs_mark_for_deletion_1(const struct git_hash_algo *algop
 	}
 }
 
+static struct string_list_item *locate_existing_pack(struct string_list *list,
+						     struct packed_git *p)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+
+	strbuf_addstr(&buf, pack_basename(p));
+	strbuf_strip_suffix(&buf, ".pack");
+
+	item = string_list_lookup(list, buf.buf);
+
+	strbuf_release(&buf);
+
+	return item;
+}
+
 void existing_packs_retain_cruft(struct existing_packs *existing,
 				 struct packed_git *cruft)
 {
-	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
 
-	strbuf_addstr(&buf, pack_basename(cruft));
-	strbuf_strip_suffix(&buf, ".pack");
-
-	item = string_list_lookup(&existing->cruft_packs, buf.buf);
+	item = locate_existing_pack(&existing->cruft_packs, cruft);
 	if (!item)
 		BUG("could not find cruft pack '%s'", pack_basename(cruft));
 
 	existing_packs_mark_retained(item);
-	strbuf_release(&buf);
 }
 
 void existing_packs_mark_for_deletion(struct existing_packs *existing,
-- 
2.55.0.rc2.10.g29e31820dce

