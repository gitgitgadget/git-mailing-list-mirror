Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC22397BE
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179869; cv=none; b=qMBRr09PcTMxR1IVzBBjZ2GlUEbSRHVpu1qypg9uaLq/HmMCPXWI6daFa8+et5unzBrljhZVDG4Kn+YWy0HrFI49I820T/XB2coE7nu4eSzS9i3o2I64p4ZEMFVTRWck+HEOP78azprGfhDcEktAvC7zM1kGww1b9lydV2ZWTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179869; c=relaxed/simple;
	bh=BhPmtMusQFjnw+pr471qCMuudtZ6xRaUKykuP3QBDTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpsmm7ckoEzD0UqE/sab5jgWthhNBppEIpLj8pQT62Pey40kpBDO12cbkJ9wQkyKD9FvAfoyVbztiVmqym4GmjajcyEWMe09EQLtnX6Nik+6TNUsq8Vu4h0kN0fOZ5p8RwYdNMgrq8+wqKzK85kK2IQ5MwygJQfmaEhwOVt4N5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aeUo319S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kes8kEkj; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aeUo319S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kes8kEkj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D729C1380FEE;
	Fri,  2 May 2025 05:57:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 02 May 2025 05:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746179866; x=1746266266; bh=fv+inLXzzf
	/0dt7VMI6n9S4w3HTTCRJx0V14PyPgZVo=; b=aeUo319ScT68gaFukBM9eNURe7
	eLePQrU9vTUM3GnuZ/MAHbBD2ONRqegSP35P8uYdX3KOQA9FHcI1EHdjKLZ7fWIX
	1INCgaVCn+0sASZMwpBFsQh7HT+M4JOtA1hkeSFqzTLAyJPJ0AwhE17wwrJr7eOl
	9A7IHzKLIzqc/IfuJOA9AnJs4B6RP2+Em/XmltJIAfgUXe/s30aAlH/2ex/9C4JZ
	f1GOp5GrG7hQ2cVbq4J8EA6LcHJ6o/PmsaBaYNgI9xPc6COEoxCCtHDJPiw+sXo3
	krVrEX8YPXBXaad+5qiDXLsF5ubLC5HfsxwjLbWIGRp3KG0DRRYvvZek/jSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746179866; x=1746266266; bh=fv+inLXzzf/0dt7VMI6n9S4w3HTTCRJx0V1
	4PyPgZVo=; b=kes8kEkjQLiGGfg2J58Ws+YHlW6dRQXBSLQxsjRrWRIKJCYJuLZ
	msWGiSCPnOs553pXEiRY9M4hiIwuYK9yl5E6Jt6xG+QWYh1yBE2Fhpneg0+cykN2
	iVrkQw/1KYvQIq7MwsjyaW3ZdZS5K8we6P4qyE0HLbbiAac+1m+0W4zV6F2YUWET
	j3Alo59qKiD8n/DXcqILPFGaK/uwlwbsuEwZfanJ6PW0VyrRhqtzpDf1Yy2b7TGJ
	5mrZqgad4QcDNqsUTlLCNJE+vKYTAn6FlzXkMNpjyDPakpqe5rzVfCzc9DLmCIpX
	4pU31c0UqXWkA3VFCIsCZenYVAF2IY5Jxaw==
X-ME-Sender: <xms:GpcUaDEiDx4rDHnnFiHNJupVc_2XN95rTLtvuU8UbrttubHwGTwEYw>
    <xme:GpcUaAWxS7B8EblBIblv6k6CGq2jawvBqAhLWj-EIhL7H2p_RjXw5KMA2YEHqSvw5
    dy0JX3oF4gxCZr3wg>
X-ME-Received: <xmr:GpcUaFI1QY_4l9XCeIov9Fqb5hayeVs2WoTNu7Yjq80ZTCe67ctlFQMnNJC4S7Ki17DMcJbH0Mv8qvTOQYi1LW-62oODseYav8wS2074Py4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepueeiueduhfevhfekiefgkefggeeljedtffetheeh
    tefhhfdvledukeekfffhffdvnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhufhhorhhijhhi
    leeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuh
    hnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:GpcUaBHMJh3EMu4czVB85yQYetvulZplazfLyOV07dQzMX9MzA68PA>
    <xmx:GpcUaJXty17la7n1n3ztbe2n9t56exqMEA7fw_Aw-cnVcY5zqTjfhg>
    <xmx:GpcUaMOiilAKRbgFCKKQVzGfQEJRCN0CA1tsbIXYeFmGxnETRJa3EQ>
    <xmx:GpcUaI0QpHFFtJPAI7La3z7nebBqUMirKsObRMb-OZohzoC3m62jbg>
    <xmx:GpcUaKLyt5Nok2O_U5vez1g5PLfYzfh7jcbyzJFgRKWMWkcc_1rLWaVo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:57:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ead72763 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:57:45 +0000 (UTC)
Date: Fri, 2 May 2025 11:57:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 07/10] t/unit-tests: convert reftable readwrite test
 to use clar
Message-ID: <aBSXGA5GVTNlO6lL@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-8-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429175302.23724-8-kuforiji98@gmail.com>

On Tue, Apr 29, 2025 at 06:52:59PM +0100, Seyi Kuforiji wrote:
> diff --git a/t/unit-tests/u-reftable-readwrite.c b/t/unit-tests/u-reftable-readwrite.c
> new file mode 100644
> index 0000000000..3d6bdcfceb
> --- /dev/null
> +++ b/t/unit-tests/u-reftable-readwrite.c
> @@ -0,0 +1,870 @@
> +/*
> +Copyright 2020 Google LLC
> +
> +Use of this source code is governed by a BSD-style
> +license that can be found in the LICENSE file or at
> +https://developers.google.com/open-source/licenses/bsd
> +*/
> +
> +#define DISABLE_SIGN_COMPARE_WARNINGS
> +
> +#include "unit-test.h"
> +#include "lib-reftable.h"
> +#include "reftable/basics.h"
> +#include "reftable/blocksource.h"
> +#include "reftable/reader.h"
> +#include "reftable/reftable-error.h"
> +#include "reftable/reftable-writer.h"
> +#include "strbuf.h"
> +
> +static const int update_index = 5;
> +
> +void test_reftable_readwrite__buffer(void)
> +{
> +	struct reftable_buf buf = REFTABLE_BUF_INIT;
> +	struct reftable_block_source source = { 0 };
> +	struct reftable_block out = { 0 };
> +	int n;
> +	uint8_t in[] = "hello";
> +	cl_assert(reftable_buf_add(&buf, in, sizeof(in)) == 0);
> +	block_source_from_buf(&source, &buf);
> +	cl_assert_equal_i(block_source_size(&source), 6);
> +	n = block_source_read_block(&source, &out, 0, sizeof(in));
> +	cl_assert_equal_i(n, sizeof(in));
> +	cl_assert(memcmp(in, out.data, n) == 0);

It feels inconsisetnt that we use `cl_assert_equal_i()` to check for `n`
but `cl_assert(... == 0)` here.

Patrick
