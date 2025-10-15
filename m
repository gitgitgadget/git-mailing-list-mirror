Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC7306D3E
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567364; cv=none; b=aqV2FQ8CI0/NGTDKldyHzbDUy0jCGEzzA6B3OdFYE3Gm4XpWq2h209ynJTioSNDkaot9oX5aptnAi2KMvwIfTu8DzKhX9vH3xr3QHuvEE+EegVianncvsPW3ae9KYuthEtYC443a6jTdwK8wnA7qTcKr6DEfJWaRdcD0NhQKKDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567364; c=relaxed/simple;
	bh=R3lPyj58JgBw2Bu5JkshbIWGRnAh6k2jYGSngZzXy3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcRfg0plraJzM7JIufLhKdRtwGGqDNLThkXs3iLwUvqNL4F8TfJs948zXi9xabY/0vaj1U+9JIXMiD36v1eMkQMcGCO2dWS4+M/CQmN7Uulc8jPaM/FjyJdqeYHUSweuriTPmzHS/RnX090iVCItB7RNo5QnYVMrk3alVUXS8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DcKrATLP; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DcKrATLP"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-74f6974175dso827977b3.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567361; x=1761172161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZzC7TCGX5ufxAzFfpBhgRDixypmZfOPYpkdSa5e0C0=;
        b=DcKrATLP5i4BQW3eiXLFE+AJ0Haa8dUqbg3jjk7fGglMV6Ee9Bji+LDbMXSpTzZ+FN
         HBKqs67PGUofoSOBqMz3oCuCsFXlC6oqAwveQJ+SwVBfi9nfzEgHrDVoJY8kgxg786p4
         Az5UqZ/5tb6SMfMF3p3kAEPfEuQDYu5auQc+mKkWSFqe3oji29yVf4hDMYzeUX/obdZh
         s1fQnMN9344BDK3kp6mbjj2SVGwXa/KWIc3rzWDC+Jon41Cnuhe9uQbBITId7/oabwO2
         aYxVqCTxn50SqbV7o49SJk0wlYX2Ur/bQyYxBVx8at85gscRnWVgrYBs1q2RZ7peUwyw
         wbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567361; x=1761172161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZzC7TCGX5ufxAzFfpBhgRDixypmZfOPYpkdSa5e0C0=;
        b=FA9RIkG31Cvqmaf3AhucgkoeTwrt0GY/JC8JEm9qg59/YRWREZZXiB295FPfCmxTR1
         BuMpAZZ954ohcjAKMVB1HNZgCbQwXci0rFqxuckO5SP8Zi3gjIrklVy8SzymZS/tKC8z
         fZ3HSlNAvAK57nIp9QB4BmGkEoijBmuzPmDAjCEMQbWHlD0IBaACHBDU0IKvIHVEqTEC
         YWi8T4EZzbaMGINvDo7v4luT2IuBBrMIUicYpnQrN8Zp6xE/NeqCJeF2dYclxEOh8vjC
         /lMTGU/bruy8ricMdFf5dL9Ndn76KgFx2n4ifCUP+nHVm2dkVMBQ9JjMSq6uEGh3YAhn
         wHQw==
X-Gm-Message-State: AOJu0YzEfMKH41shP0URJlkVoDEx7UKPhO39Jd/CcPuJUXlWKYmZNGe+
	9egrjFsCfFvVE8GDlOqhNv6VETZ+Zi4+XqQ0v5Q4StNFL1xuqjYng6Wn1PJ6GTmD5DKoFIw1SV2
	gW8ykCXUdLudX
X-Gm-Gg: ASbGncub4eoiR34cfXZtl8OdmBYLdfXdVTE8EnoE0Nv33IIkIIKsxFRivku4aMtAqiY
	b8Io8faT7gnWol+XYfDZAxWd75A94tRvIHXGFW4F/tMyhuXo9IEcL1LyLBeru9ps9PQ2KU9MspU
	p0FGHDCMomH8aEn0/fZxUirj0mGQtHe9oPSEL/W0Ig5YOY2xC11QEFTKzT1STI3ENYzjrABre60
	4yfQBEH00+Q1TxqS9DVdbNMI+CMVaT2X2UARWRdapXOIRq9/dIHG9Xx9feS0sRW58cW3mG3yHnE
	bKkOPZ9CZw+hCDWYzd8JTWNh3lWQ6a2P9EP/mj2Z3eQlYavsodbq+5pXhnKTqobFIe+e1TvM3Ur
	3aCOMbD0U4BWlZS64tyVKP7mJnP1iXfnhoXP0aVl82a51D23CZSSzFuYbIBpYYcQsCD5T0qNc0u
	U0rRS3g8m9FSoB27+bQ6M/dFsi6yctrFossz33tTR8/PZXbbcxeEl44WRkIkTwddCSlcYX5Lekt
	ZckdT/luPb9p+K2Gw==
X-Google-Smtp-Source: AGHT+IHbSrtErvJBNezOxA+2/GqZnUasaEsZvNunnGnRTRBFi9Nm1x/e8eJK5T1+Q/NfgX+Jg5OfZw==
X-Received: by 2002:a05:690c:6ac4:b0:71f:ecde:87ac with SMTP id 00721157ae682-780e164aeb0mr304718027b3.16.1760567360491;
        Wed, 15 Oct 2025 15:29:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828cdd263asm2775047b3.1.2025.10.15.15.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:20 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 41/49] builtin/repack.c: use `write_pack_opts` within
 `write_cruft_pack()`
Message-ID: <1a9b578fdd62464fb8a26b0c1668e80dc62a8dfb.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Similar to the changes made in the previous commit to
`write_filtered_pack()`, teach `write_cruft_pack()` to take a
`write_pack_opts` struct and use that where possible.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 45ce469898..7295135ec2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -221,9 +221,7 @@ static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
 	strbuf_release(&buf);
 }
 
-static int write_cruft_pack(const struct pack_objects_args *args,
-			    const char *destination,
-			    const char *pack_prefix,
+static int write_cruft_pack(const struct write_pack_opts *opts,
 			    const char *cruft_expiration,
 			    unsigned long combine_cruft_below_size,
 			    struct string_list *names,
@@ -234,9 +232,9 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	FILE *in;
 	int ret;
 	const char *scratch;
-	int local = skip_prefix(destination, packdir, &scratch);
+	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
 
-	prepare_pack_objects(&cmd, args, destination);
+	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
 
 	strvec_push(&cmd.args, "--cruft");
 	if (cruft_expiration)
@@ -267,7 +265,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	 */
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
-		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
+		fprintf(in, "%s-%s.pack\n", opts->pack_prefix, item->string);
 	if (combine_cruft_below_size && !cruft_expiration) {
 		combine_small_cruft_packs(in, combine_cruft_below_size,
 					  existing);
@@ -599,6 +597,13 @@ int cmd_repack(int argc,
 
 	if (pack_everything & PACK_CRUFT) {
 		const char *pack_prefix = find_pack_prefix(packdir, packtmp);
+		struct write_pack_opts opts = {
+			.po_args = &cruft_po_args,
+			.destination = packtmp,
+			.pack_prefix = pack_prefix,
+			.packtmp = packtmp,
+			.packdir = packdir,
+		};
 
 		if (!cruft_po_args.window)
 			cruft_po_args.window = xstrdup_or_null(po_args.window);
@@ -615,8 +620,7 @@ int cmd_repack(int argc,
 		cruft_po_args.quiet = po_args.quiet;
 		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
 
-		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
-				       cruft_expiration,
+		ret = write_cruft_pack(&opts, cruft_expiration,
 				       combine_cruft_below_size, &names,
 				       &existing);
 		if (ret)
@@ -651,11 +655,8 @@ int cmd_repack(int argc,
 			 * pack, but rather removing all cruft packs from the
 			 * main repository regardless of size.
 			 */
-			ret = write_cruft_pack(&cruft_po_args, expire_to,
-					       pack_prefix,
-					       NULL,
-					       0ul,
-					       &names,
+			opts.destination = expire_to;
+			ret = write_cruft_pack(&opts, NULL, 0ul, &names,
 					       &existing);
 			if (ret)
 				goto cleanup;
-- 
2.51.0.540.ga7423965ad8

