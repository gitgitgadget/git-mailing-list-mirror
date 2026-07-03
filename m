Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C023DA7E6
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074764; cv=none; b=HWczeqypfRPe4n5rWg98zGpxpz7PG0pnB2F52bVysZydh5wk9a3zS8R9q0JmyzJbiwYZ6zUPLrlttG4khNzxZ879UOSnFEIuHEc3kBHIe5qZwBF8f4ClBTsh+ybuf/Ax5cAGB6gfVIsPQ2eDm7/19omaK2lBqDUcoGABPqI+Dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074764; c=relaxed/simple;
	bh=L+ITeaOSuPzuakqqO0h3iZHpo/Op66S1t6/MBlP8i28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkCDz39LF8Ms7cYbnKrU3djdoMaVZeaNcZtMn0AVFTe9WEkIPR6XdF44Dv/PRda57esJhfrCPT/3U+zvAqaf3W2PLGuiluy4V79rcO79Jfs1/2A0T3YhUp14ER3n7JquzsHIOuZPLt0DkAOTtruYRRMmUFDlU2cyiY2qhYhXdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ely32+kO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oQ1N4f3V; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ely32+kO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oQ1N4f3V"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3DAA11D0008E;
	Fri,  3 Jul 2026 06:32:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 06:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783074762; x=1783161162; bh=CNzuCITYnx
	hEH1BHxj/ZTrChORUkV4nAj/Yfmo3r4Sk=; b=Ely32+kO+fA3bUjWpEviih9ynL
	C0I2AA6hn0dSEDqzkBb46+oqauvBBQVYIr8od4Q4dyL8EfSowj5GnGJvOQdUFJl6
	aD06ECpfg1XNESzQWerBfS12qthskiTyFZfK/n7vrFMu01Pxs3yfD1V5+CfMuFkR
	cp6vR44bT28fBR3vAqvkyCbj9FSLMt3VFsF7q5EvN94FXlgRvkygB0Ce+PF9RHsm
	zJV9p/qfwKZTMt9SEdphlTTMkbjcA6GztwrNsMxj5fzbd1vE20aTfVQ3yrvg8mZb
	0EAfsR+IvEQssWV9SNfNT/S2PfSKf5AUok6jbtkIetI3/o/VVvTXk/WLrnSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783074762; x=1783161162; bh=CNzuCITYnxhEH1BHxj/ZTrChORUkV4nAj/Y
	fmo3r4Sk=; b=oQ1N4f3VGdCvBsxkigSI2gk0OdXXv2GyiPLG1fFbBDuGiolr3hX
	DbbXPqm2Fr5EdDXQXNwA0LkhYmJNWzbAfdCKQdLcW0J22ibC858gqL2Pcd1t0F3Y
	HYplF1A1uLBs/eEf3Sk/exgyyrfxSOEDjRQ7BugJplYjbm4iAFvpV0DN9IPIhab+
	HnFl1WL7tyfMOy4qXCzwXVP2xZF1FhchENOBI92nTp0wMkAybQ7zlv4tXRuNSmRh
	6TRN86lAta3xEL/Izjx6DJbvIYHoKGIIs9ERO89M1GsPsazHBbqcyY1qkw/Qmz2q
	9eMRgd0DA4MkidRBwxgGpsQVke1o+l5Om1Q==
X-ME-Sender: <xms:yY9HaozixT0CuKpR4UffB1TdsI_UbflMy4CjfSpxt4GYO9UYa933Dg>
    <xme:yY9HajT-CbvuL-mPgBZBJRBOHSvcvkshTwBYtxifHAjlmo7mRHyPcTY4_0wAvwYYw
    5q4S3bFfsDMi6IJ16X0jk6caSoeILmx0eGD6vMvhXSdji4mF6Kr>
X-ME-Received: <xmr:yY9HavUBfnsFBkgBlUq7UbQG6ruVJbtQPmSaokjRSe7MNu2Py-DsIFCdVr-FOZfiKGKAy0ZoPs4Bx6jAnCT2i8D3OL7L_TK3pW6spmiSzw>
X-ME-Proxy-Cause: dmFkZTFkSx/glFaoVMxYgrcTPXCPQ8CDYyGdy+UtyL6FYf49CF6RUZMEXVpg7wvbRexFv0
    fM1x3Fyyy//GQYfYxsmBALkjsihml2oEvYnCtL+/v4C2BnhI1F1OrcssvzYugm7wmLFC0X
    oGULxxnDiCOtTd/+dD+uzazvVVp7tQU9Va923U06gkKgFe7P/DekKN/FmIX7sDImpQV4r4
    xtF3o06nzXDbqjTZxN7xSfNJ/yWM4q3qs9aIob72uzPUImRS8Hvbi+VXonaOwFbSilv1FI
    v94HN1vP7Cm6R36SMezfoTXt6mdHf57K1Swk2h+Z3dIsON2cF9TFOxVY87/23j7+UEnwWM
    FtzZZP+vlc7oiu3lOf4K+j/+GUZN3JogEUunjWdO6tl24CZZAuUKnJw/kVmrWeCcNwqCyc
    SoBtXPTbkBwuGuWHfSE0xHucwIVL0HqepY86dinKIY/UJGiN3pv0blLrG0wKdzQ0K7HNqg
    cEpmM7eyyUBnc2Yf03FB19J58TaTTAkJ/W1v1xggHb7cxLEXYLoxenUfpLomIr6OjdP0Rn
    jSuaXqP5iyGarLoLqqUCRNnKHLEMAsamCRlDPab8BhWjv3djHIMd2URTXfGCKBF4FBbFoe
    KR+FqDscl27ff6PHw+5a3zE0rEViaNPlk6mxRhmRPDUt9aTZnWX9ZlKzsS7A
X-ME-Proxy: <xmx:yo9HalYBZecvB2BQsvQP9LtRCTN5Xstd4YhOB3bQgyqcuYZfe2xbvQ>
    <xmx:yo9Hal0LvsEYRXjZvyT8LDTeimR5QE6PgFDsWBAxxzhUkg-XnEhHQQ>
    <xmx:yo9HaniycqpOS_QMsMjatNRBvv6Y14yqJTJkgs7V3X8YHzXZcfJ5KA>
    <xmx:yo9HapbguL0SYh9ZF7-V0SNtNn0_5zfk1X7LnGInzVIcXBXWhffBfQ>
    <xmx:yo9HarpT5soveKpdW1Wrt02zb7pOesI_U3gTNEtm4n8ZY9JP--ewNicY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 06:32:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a83f5bc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 10:32:40 +0000 (UTC)
Date: Fri, 3 Jul 2026 12:32:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, oxsignal <awo@kakao.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 07/12] reftable/block: fix OOB read with bogus block
 size
Message-ID: <akePxXTkude3aLlt@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
 <20260629-pks-reftable-hardening-v2-7-b0228e7d908d@pks.im>
 <87wlvc2zii.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlvc2zii.fsf@emacs.iotcl.com>

On Fri, Jul 03, 2026 at 11:28:21AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
> > index 088162483e..43b9d5fb59 100644
> > --- a/t/unit-tests/u-reftable-block.c
> > +++ b/t/unit-tests/u-reftable-block.c
> > @@ -497,3 +497,36 @@ void test_reftable_block__corrupt_log_block_size(void)
> >  	reftable_block_release(&block);
> >  	reftable_buf_release(&data);
> >  }
> > +
> > +void test_reftable_block__corrupt_block_size(void)
> > +{
> > +	struct reftable_block_source source = { 0 };
> > +	struct reftable_record rec = {
> > +		.type = REFTABLE_BLOCK_TYPE_REF,
> > +		.u.ref = {
> > +			.value_type = REFTABLE_REF_VAL1,
> > +			.refname = (char *) "refs/heads/main",
> > +		},
> > +	};
> > +	struct reftable_block block = { 0 };
> > +	struct reftable_buf data = REFTABLE_BUF_INIT;
> > +
> > +	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_REF, &rec, 1);
> > +
> > +	/*
> > +	 * The block size is stored as a big-endian 24-bit integer right after
> > +	 * the one-byte block type at the start of the block. Corrupt it to
> > +	 * claim a size that is larger than the data we actually have. Reading
> > +	 * the restart count and restart table relative to such a bogus block
> > +	 * size must not access out-of-bounds memory.
> > +	 */
> > +	reftable_put_be24((uint8_t *) data.buf + 1, 0xffffff);
> 
> Same here, would it make sense to write a size that's `+1` too much?
> 
> 	uint8_t *p = (uint8_t *)data.buf + 1;
> 	uint32_t block_size = reftable_get_be24(p);
> 	cl_assert_equal_i(block_size, 47);
> 	reftable_put_be24(p, block_size + 1);

In this case it'd work indeed though, and I agree that this is a
sensible change.

Patrick
