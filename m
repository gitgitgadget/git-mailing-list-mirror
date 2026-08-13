Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DE1E0DE8
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658810; cv=none; b=tFeO0B1UOmVuUCw9YVqS8t50ySWn63TMjZMaaME/0O+ZgJopqxI2z8u5FHRWyooTzRBZ2Io/bCgBlRwAhAi6Gve+Qwml1Dlkct5QQrSncPW5t50ooNzxT+tsHQ1scSVQSb2iZi0Qd4REeuweGjSvof3doUiG40YNv4HsogGrpA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658810; c=relaxed/simple;
	bh=I5itW+J5chjIgXbWwEfa2H47kZHC0gX3rlg/PSiPQBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GyKKnlUz8E3h2a5QkI0kxa5WjBPJurWjfikLjS5ZicFvKFKqKapMR4FvL8wy5/hgkn3pg1F9tlzzn1K2ebKmtBqKiUaNg7LKZNXyTBC47Et3xNiERI0ey21TL9fXAFsC3wZW6EgwftCDXvig32qPTVBoFL67H0Zq0QL7kvB+Kzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aj6ubqpy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PbfMbd5Y; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aj6ubqpy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PbfMbd5Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C4F41400114;
	Thu, 13 Aug 2026 18:06:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 18:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786658808; x=1786745208; bh=DeT1eleU+S
	clSM61JPsKU3Y1cXf93eX2XAKjnU9ytiY=; b=aj6ubqpy5UlS9d3FwMD75fyvvS
	kF1izHCT4vN7bS0HV9f2/kuU86/cIwSRdMzJw4v9UqZi3qWdGs/oSRC38Uf0lm9Q
	8Sw6EQvG9tooUDzewOduWtQohyNSqZPQIXXtoFTfbPEDXK8Zys1/+uYB+IMtE5bg
	FRGBvp+k+b02/PQYm3u4sVLJ0KhvTG81fQGq/ps2CYlHgb9ZK6qAsgXD6VAFHvzg
	7ZPZslpUE3KdScWDuE7mY6G+hghDFOwTh7c1Mjc0tlIAeIYskeFSCuTibXwsAXLD
	S3oQhrFgbwqkSeG/YjnxKzF2MFCbScMaIUVTbX3hjFDMXZMwl+RVY93igggA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786658808; x=1786745208; bh=DeT1eleU+SclSM61JPsKU3Y1cXf93eX2XAK
	jnU9ytiY=; b=PbfMbd5YkdhyApRUtHuH7gAqLWXrJdbfexhoPYebzhU8mtvq33A
	9HnYwQYbbnl/XGVpUnZk9IIK0Xc5peDlsXBD2lkIngNOeZpwphDrYTniQhP7hc2l
	2/7Gx/RTHYN+o2OQgvjFKKfdIOJp7IkQeF1mZwS1wzRAlJ4XtZoQScEjvGcGlaCU
	h6mwgjmDrQWIuvu0CEZrp5IR40Dt+FiDX2vPSSdpP6CK2ZxBqzJNRjCmumfnPW8t
	epcaLVNWEU0pMfXrBV7mKm6YAK95sh4F7ESCv7h1w5JQ7uojmMJc29H6jJ609aVa
	jTvqNFVFrahZ32nipe+PZbIB3CmFfuwZAQQ==
X-ME-Sender: <xms:-D9-aqJEuI8aK3TKUBC_0tRPsDZs2Bji75JJpDfTmiZK3SnUi1fgnA>
    <xme:-D9-apKFpeOIm4gKOMASC7gTcA-e3Prd5Nn79WCio2VjUJjWLX-3w8jC2hsC5iM3-
    eUez0d8A_nMDpTrY7Y3q0c0cqa-OM3qFsZh8csN6ZokpIewPG53pg>
X-ME-Received: <xmr:-D9-avsY_c-rCSJBh3CwPvjsXYgJ9qzRNUyfEeEZFKza21g-iV6IIvQ4kMY6Nwftn65c6IRSsoHSX9-JoMg9Fjvx0HuL4fgHUA>
X-ME-Proxy-Cause: dmFkZTFgyAPH4P1tRLAOFgbIqaK4u76sCRGD+mXCXHVcDtOPgNe/wUmRk6t+C69KlOFzRX
    jkZZH5WadafXlfgmxTyZZS8fL38jzax06KpTQj6d2jQoE7/Rh7VJYjAQMYq1oFmZ+M48xl
    0JoR+XNfG0Xr2gyl1k3dNUqtFtdmDGx8ZrdiEpAfFv9paAdxMzaf9EZFkwyaqL2+FQZAIj
    OwKMaBb1eD0ud/taiJQ8Vz0dVMmrBj6RbBmCXhZaBW4B+j9LpaAZChMqiMEJrXTfPEnWqR
    iqWjDR+1luMPh4q7tJ1DZqmdBEz9+uywchlhlRubGclv+LsvMHKAJFGi5fUbtc5fV4K+LM
    8DG+uj/okmlmy00CJ1FQG9oBViy7Vx60yN0OUw87KYqf96kar3xxMw82c6qiz7L6VxHUFO
    prxYlp7Ah/4vmFrKIEFhADDJfjqxSMhVt7P1L02L7Wnn+ab6gziA+2MeHGbCY1HKG0lZWA
    XnE3DjQh9T635RStt6N6Wd2TKOELEjDlk98fKEE+Lxu350iSV86rMW2wL84ETs73xqOTJB
    iKJ+twXXDHuCCG35a5EUNfcKD3pTQ38ivMeq9gKxBhlzpdzhQ+o/7QtdSv/3Ii3zc44OQn
    1WxO22wKItYtSNPGlexvSMqBMFyUeViA2NXTNerDdJjRzVRQ5uWHz40DHRfg
X-ME-Proxy: <xmx:-D9-auQyuX2oJGwivObsA4a1uozYw5Wrr-glcA7sdZTE8VCkuGFoTA>
    <xmx:-D9-atO4BDuZ-CpwvsM37uixvlHsSrTYNJOLYyuc-y16K4E2Ce6DYA>
    <xmx:-D9-araRKgq4BF1DkTNE62YgKUf7RmxwSLayScMtsNRRAgi14SKQJw>
    <xmx:-D9-avyhvEKa23ecBy_hOuWgf7MD79RwT7dxZs4TMWWGthZphPPZ2Q>
    <xmx:-D9-apm0-SixEkLPxgg28CKrefWSY0qMy446C-xHeHUlwlEg8ECNtoKl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 18:06:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH v7 10/10] diff: consult oid-only hunk providers via
 diff.<driver>.process
In-Reply-To: <20260801174156.2998808-11-mmontalbo@gmail.com> (Michael
	Montalbo's message of "Sat, 1 Aug 2026 10:41:53 -0700")
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
	<20260801174156.2998808-1-mmontalbo@gmail.com>
	<20260801174156.2998808-11-mmontalbo@gmail.com>
Date: Thu, 13 Aug 2026 15:06:46 -0700
Message-ID: <xmqqmrupr7yh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

> +static long blob_line_cap(struct repository *r, const struct object_id *oid)
> +{
> +	unsigned long size;
> +	struct object_info oi = OBJECT_INFO_INIT;
> +
> +	oi.sizep = &size;

This breaks the build on platforms whose ulong is narrower than
size_t since June 21 due to c6a4629e32 (odb: use size_t for
object_info.sizep and the size APIs, 2026-06-15), which changed the
type of the '.sizep' member of 'struct object_info' from 'ulong' to
'size_t'.

Tentatively, I'll pile this on top of your series before rebuilding
'seen'; I do not know if there are further fallouts, though.

diff --git a/diff-process.c b/diff-process.c
index 121903a6c8..d28f9cf973 100644
--- a/diff-process.c
+++ b/diff-process.c
@@ -325,7 +325,7 @@ static int validate_external_hunks(const struct xdl_hunk *hunks, size_t nr,
  */
 static long blob_line_cap(struct repository *r, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.sizep = &size;

