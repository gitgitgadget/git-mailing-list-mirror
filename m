Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E73EF649
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014787; cv=none; b=lPXZlcmMWggorypdcPtgKvjp+XSa/Z42j05XJdyVwyTiSVruXvc4yhrZi6omruxRrPNkZkKsJ35ZoHVQ03E9nOhRfnlREtmXd+57+JrFiXNRzCGNi8w6ANafupoxnv5jw/2GgEmhKlkFOztkuIvnwiygLv4bYJrnZntqrF15Q2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014787; c=relaxed/simple;
	bh=fUNkNRo8xFv18P67DU1LocrnQxCwWrmQxlYQgvziw1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJMOHjqwhNSH274Rmu517fTDWymOw568guweClgjsHAnmKODZyDRcsrML6oDH3FqwfpNn0nirosm5p0A2y6fhCdaW6Z46LhAc0FrdbaCOYw6sIONG6igp7GVIk7mAxzxFwEQVrrrujaTAbHRC8bM3pMT2a2jkFOXUwTxhCQnHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hkcOiZ2g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LZat97qn; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hkcOiZ2g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZat97qn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 574F0140002B;
	Tue, 14 Jul 2026 03:39:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jul 2026 03:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784014784; x=1784101184; bh=0yA+3+IuJI
	nNGVT1QuHVYzos8IQvoIstpM6lHIvRi5E=; b=hkcOiZ2gHJ2excZao8gmVrAor3
	U36OOe5aXSmT2QoLrBSUbmgwBWQP1dxggR1eA+4wCKgjfvAif1/BCK6F4qI4CaPH
	Eb/lL5o93DrwCH9+lzgott0hU4vrci6htMdDfom0Ub4qs9vEcrkhfEnd8hXof/YC
	PCQQbbvB0ovUyXt1AhwTXgCquz4z0pQTTmqysvTHZ5gjgClzqlKY8ao7Z9G5auuc
	jVDCJ+5hbmisdpTgIpb6DyDih85XvNGyL5u6Esv9MJk51SjDl4t3cjH13xIJix55
	FHaNYSs78Z+D4bT8R0KCFeRc2suKbQXnplEMwihKjOUkzBE+jztm7tUiWAFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784014784; x=1784101184; bh=0yA+3+IuJInNGVT1QuHVYzos8IQvoIstpM6
	lHIvRi5E=; b=LZat97qnWrAnf3VzY/lA375u8GRP2Orpxv3gB/WJJ2yd8i68nlx
	Y8On3ciigD0ltpRTzd0o7Tq+ScfnQhX3zvEgNv5gWNuWuNpU6LRNx0FlM+GQUfPK
	pF3BbpLfp3HSdrXgs6hFYJQagReH7zYDDuvwg8epfx1RX/IJHQkQ504K8ZCGODPr
	/TD2FwJ7VCwMZ8GuMVvYN11Kx62aXB92j44RawIBniITh6G00MXCwZB/m3NN1LZ5
	L+K7zdUUY5e/1zgsjp6mmEwre3nfh88lbYZnglMA8NdIT9c9I5BGopfGl7aP+0+I
	BBEkwBNjmskrzT9IX7OoXUF2RCPixY9aMFQ==
X-ME-Sender: <xms:wOdVanVq8ZN6ai1bBwV9ELY30-AHlUYPuXtUNPuPEpRZAPpujeR3Aw>
    <xme:wOdVanBpHS9o2UFRY-N1nG2m7H4GC0PdoDI7IfqBztambDtFAkCERib8WR1lQx9vu
    IsWJlwzzBhQPk6j6jZqrHx1FF3BKexZ_UQqufNZoWmrJZOtMBKKXRs>
X-ME-Received: <xmr:wOdVagyN_gN01Es6OCH0G6NzivnF0UyH050LNDnG-90fsyGtOg-JLK0ZJjQ7zulaf1Rj-mp1ZdwebBbf1UKpevP9FpC99XYS5-iKtomw4A>
X-ME-Proxy-Cause: dmFkZTFovAzaqhN6QgChjVuzQRl3m75dhzANyJpdmBGZMvaqUFdbWinqoKQKoWpla8LKQ1
    uXb2S8Z+69WHP6PrPoVTuCQk3zxL9FeJcz5Zpd2c6vmI39c9l+8ynUtwvE9H8zfdum2uB/
    wwZxwWj0MUzX5Du9E3yUqmYRZfWFx8gT3GPFgmTug/q3T9ZcIuCFOXh4FfV48+JnGc6pLK
    hwVdZGrce4ZSipFNdpr2DPr/xCKcYIvnMnYW1wl6CCbB2KDNwZCIdXNiiU/yQlw/HN5UTm
    tR5ba/UBw0eQsnl+p3hkkWmPZRJVUE2puXoqJ1TKcxooHLoRWe9F+xwUeSADq98MBw1ihB
    5OVqLsW7DJgtUCPIvKWpHm4mZGEDYGbEKnp3kWvD7D+znuUKB1RdLMM31ErnzIQVUU3EUl
    iCJ6XIq5YWcEAJ1W/1EiLVNHztlypxc9Qb3824EcGROUyi86DB9BECB8ZSzCQaKyNhkRqg
    8FaKogRmlpvLjBiBUVWRdNo22I5CRCzW4MqRraYJO2hXJVvWkQRAKQQsC+cq0o1dO77X88
    SYypaW7+lhsfRJ2TnUjnihVtzJ24dr+MR6DLTYA+dpAmflfVc7y23VnAYPJwZhL2HckET4
    1I4uljsk/WS4Ba/O4fMhso3QpDP2GlKedehuC5fCVPQS0cHb9hVCN7O2ucNw
X-ME-Proxy: <xmx:wOdVasBZ9b0pZAmyoSeGfaDS2UWQI1KAFdHpkDmxwpYL6NNTZw73dg>
    <xmx:wOdValYye_fO5r-GbZZzp4OnPF-p0hSPTibI9AfKt7R5E4IlQTHllw>
    <xmx:wOdVasgzhxQa8v7MxzfIC9YLprflYu2dYJtkM3hxfrz1dpm1bkSsGg>
    <xmx:wOdVav7FSdD_0B1DeJMhcSSeAwRHuVjRkMdcUalDUDMY_hJun7NokA>
    <xmx:wOdVarA_M9XVLnwFYj_CXIOwEfYFRJrYVaZSOJ8eoTZs9j3QCaULV_96>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 03:39:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1681683d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jul 2026 07:39:41 +0000 (UTC)
Date: Tue, 14 Jul 2026 09:39:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t1100: modernize test style
Message-ID: <alXntdc-FO-1IHSV@pks.im>
References: <20260713140142.27898-1-diy2903@gmail.com>
 <20260713140142.27898-2-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713140142.27898-2-diy2903@gmail.com>

On Mon, Jul 13, 2026 at 07:31:40PM +0530, Shlok Kulshreshtha wrote:
> diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
> index ae66ba5bab..fabe5a97cb 100755
> --- a/t/t1100-commit-tree-options.sh
> +++ b/t/t1100-commit-tree-options.sh
> @@ -22,28 +22,28 @@ committer Committer Name <committer@email> 1117150200 +0000
>  comment text
>  EOF
>  
> -test_expect_success \
> -    'test preparation: write empty tree' \
> -    'git write-tree >treeid'
> -
> -test_expect_success \
> -    'construct commit' \
> -    'echo comment text |
> -     GIT_AUTHOR_NAME="Author Name" \
> -     GIT_AUTHOR_EMAIL="author@email" \
> -     GIT_AUTHOR_DATE="2005-05-26 23:00" \
> -     GIT_COMMITTER_NAME="Committer Name" \
> -     GIT_COMMITTER_EMAIL="committer@email" \
> -     GIT_COMMITTER_DATE="2005-05-26 23:30" \
> -     TZ=GMT git commit-tree $(cat treeid) >commitid 2>/dev/null'
> -
> -test_expect_success \
> -    'read commit' \
> -    'git cat-file commit $(cat commitid) >commit'
> -
> -test_expect_success \
> -    'compare commit' \
> -    'test_cmp expected commit'
> +test_expect_success 'test preparation: write empty tree' '
> +	git write-tree >treeid
> +'
> +
> +test_expect_success 'construct commit' '
> +	echo comment text |
> +	GIT_AUTHOR_NAME="Author Name" \
> +	GIT_AUTHOR_EMAIL="author@email" \
> +	GIT_AUTHOR_DATE="2005-05-26 23:00" \
> +	GIT_COMMITTER_NAME="Committer Name" \
> +	GIT_COMMITTER_EMAIL="committer@email" \
> +	GIT_COMMITTER_DATE="2005-05-26 23:30" \
> +	TZ=GMT git commit-tree $(cat treeid) >commitid 2>/dev/null
> +'
> +
> +test_expect_success 'read commit' '
> +	git cat-file commit $(cat commitid) >commit
> +'
> +
> +test_expect_success 'compare commit' '
> +	test_cmp expected commit
> +'
>  
>  
>  test_expect_success 'flags and then non flags' '

Nit: let's remove the extraneous empty line while at it.

Patrick
