Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2B38AC78
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716920; cv=none; b=HlLUaUMtCBqBjTWiFQmgVDu4hlUqJpvphF+cHfkR7jXy2SQAHYvskgWP9DffVVLXsjhlBkUmfvF1HUTTK49l5sv7Iv0oc855Lfy1BSMpzVeRYvbvHdF4MK/lbrhrssJ2KVQSePvweUUW3ee9qqXM57y2HYVO+9t4+uet4t2phmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716920; c=relaxed/simple;
	bh=/YdZje115qWyJ469OGlNfFCT6ykDs4Uy4X1KTFmTftU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSAj5YyuMkT3QfLiZ4xKHK4pxGOHCcizvviarklVMLHzHdkgPTWh1shTzuQBLniMKSOukyFVM3yT984VK6McmGhIMtpS2Y1u4myd8M6VtKPOAwsMpy0Cyu64zIdm5nr3qCPAggurC1mgDU3XkDtF51+GeNC2pfvz2OzKVrAHqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nmQghRMp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XiCjbTXI; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nmQghRMp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiCjbTXI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C4AEA7A006C;
	Mon, 29 Jun 2026 03:08:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 29 Jun 2026 03:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782716918;
	 x=1782803318; bh=/LofVa3amjjR00/FdEA6mqfJkhr7wt1vgSe0c9TxHYo=; b=
	nmQghRMpSQ/HG+HcY5zFrgGXsi7f9niLKo9iVKM0HAZEHRFviZ9oRQJE+8tgU5YO
	/MjZOtUZxJyMEZGuaZTdYvcJu9F4iodRo73bKqAXjzmSi6i4S5mZV08PUJRQP6+r
	5Fsjj4Cpy123LI43L5fkxC7OXJ2uIV7vccRQa6QUPKfBoCYWSzTVsnZSpA8bAplh
	NIwxCmgqIQwwe0c2kBzNx1l7oNJJAWnN10nDZEhB6Sca0KxqUqEhu//BeOn2tfdU
	kb531VNu1eHUAWpsJAaV0afRnytMQ7Y15VXPMUBipn214b17zPIPmIQiilFBn4EK
	ERV43NLDUBnY7AKxhmZmzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782716918; x=
	1782803318; bh=/LofVa3amjjR00/FdEA6mqfJkhr7wt1vgSe0c9TxHYo=; b=X
	iCjbTXIGnXhJMGTixF+27dDeqbsWrUDUqxw4/s//m95mIoV9kc2de4GHl2+0jlIZ
	k+GuJreZN6jWhKwLmPi+teJnfFimL0ugvYO3bZK9R4GfmzEBlH+mLFDZMwCgYuT0
	Ak/SM+2D8zfIopiGJCv/5gI6CS6fPttG89tFv1045Ma7vNF9xCpzInb9W8ToMKGW
	RknzITzOYcz4F+DT1/SsGFE5qOqtogEaBIdvprtu6tfkRmRobv6byc0Uug5ylP6R
	AATXFTyb8H3EqVIv9HUAAYMDHRYX6Xmketcgntg7PaHQ777/WRCBs/EWdF915PXD
	+iesD85WPZ9i1AGYz8kvQ==
X-ME-Sender: <xms:9hlCalxHOYNdJJb6VQQ3ld8BEJ2TTVpmTgG0Q8ryZCp46QypbL7Chw>
    <xme:9hlCassBIpgP9R7cGwDWt_P4Rxp-z-euRbOAcb6TPlZpLD8Gofj-SF_TEZg13zPqC
    ZCngv-Xzuh9bM3cyyL2IkwdGr8bNTJl3LfT261gf8zJA61-CdGOYw>
X-ME-Received: <xmr:9hlCasstuTnSIHqYSheHtVPl6pG0MRU3UAqChOl_onNY5-VqSAbkfzUAoqJ5lBQ6JSHBk-xCyPKZN2czsE_I-liX0O8FpJ_8K_6M8b0809V3>
X-ME-Proxy-Cause: dmFkZTFlUFF2TaP6OUhAV1Io1LpiVz/xprdgLxxSQzmKysdyMC0SMgvm5rDokum8JHnzsD
    2009EbgBbpzEdNKL8EuNgyCIV4MqUGghjiY//yRk+BrxC3/7Iu+TMu7SCVdUxYEShIjbvL
    JWsHPMKiMGdM17RMDi1nBn8IK1bA5pW2nSSo0mOGmxQZweoFRUvuZwQBqIAdT9/DVSeisN
    48RLHOU/PKeXpCF8gazGSmeDB5lwiG8N/3Km4xwuY+6elMMhndZNkul9zpY/K2ZBcBhvzq
    H+m+SVhyRBepXW1i780YSKvx7S30c3pnUDARYx6QDWIWnpSB7rgQbLLBMXh0UQvO5AsLcm
    x6LR4HKZWcmAKNv/t7s4EfdESpunqDFIavVNZKNq0C2ElyWGtMz4bjiM33NO4kLDHJmQrs
    pJLjDqP+16d4yzR2B2+j9k1QkTPZCpPAkZqcreBIlu8fAJARuanrCrf8hkQRzLha6Gwx8f
    Mdb6xroLby5E3dMtuaZJAzVkOyIs80gwjhJihP6yYd8l30LgsY6dVtgw/wY7x6uZkacvMq
    Fm3IgHOhRoIPNysATa0w0iWZOKVoDlDTvhjLe1wmKsUfludhroqXoC3aKGA5siWX6PibQH
    OHQ3yAmOk7awtUukuOSNwDrPUZ+8345Rzc1N2ZuTGJUPuWlR/x9i2ZppJLMQ
X-ME-Proxy: <xmx:9hlCahNl6xysK6iuNHlLlNZ7MU4wcRWJo1kHJNe4GINe1LKG5V3wXA>
    <xmx:9hlCaq2W7t4yySQPbesHKhQa0yW8iAMYQjmeQQDQzhy1vP40I2Jm3w>
    <xmx:9hlCatMWAz9rWB3lHqFPWiSAyIkHxsH6eaviQUcvEC74YwVlDnv0gg>
    <xmx:9hlCaq1TKQ1cg_Imi3eD7oMyvF4usv2NfI3-CgPpqiuDeC5RIKVQmw>
    <xmx:9hlCavLRRfjmIvj4NrDNiU-54UStDxMNM7tOvIM3kVVbLKOQ_cUdVNVY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:08:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 56183714 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:08:35 +0000 (UTC)
Date: Mon, 29 Jun 2026 09:08:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, oxsignal <awo@kakao.com>
Subject: Re: [PATCH 05/11] reftable/block: fix OOB write with bogus inflated
 log size
Message-ID: <akIZ8F05W5Lx63f2@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
 <20260624-pks-reftable-hardening-v1-5-66e4ce87c6b9@pks.im>
 <CAP8UFD0y0GVjdnWYDkOsk6R9-ReGfzr6ZEm8PbyHOHrdAETXzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0y0GVjdnWYDkOsk6R9-ReGfzr6ZEm8PbyHOHrdAETXzg@mail.gmail.com>

On Fri, Jun 26, 2026 at 09:48:36AM +0200, Christian Couder wrote:
> On Wed, Jun 24, 2026 at 10:24 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
> > index f4bded7d26..40274af5c0 100644
> > --- a/t/unit-tests/u-reftable-block.c
> > +++ b/t/unit-tests/u-reftable-block.c
> > @@ -456,3 +456,47 @@ void test_reftable_block__iterator(void)
> >         block_writer_release(&writer);
> >         reftable_buf_release(&data);
> >  }
> > +
> > +void test_reftable_block__corrupt_log_block_size(void)
> > +{
> > +       struct reftable_block_source source = { 0 };
> > +       struct block_writer writer = {
> > +               .last_key = REFTABLE_BUF_INIT,
> > +       };
> > +       struct reftable_record rec = {
> > +               .type = REFTABLE_BLOCK_TYPE_LOG,
> > +               .u.log = {
> > +                       .refname = (char *) "refs/heads/main",
> > +                       .update_index = 1,
> > +                       .value_type = REFTABLE_LOG_UPDATE,
> > +               },
> > +       };
> > +       struct reftable_block block = { 0 };
> > +       struct reftable_buf data;
> > +
> > +       data.len = 1024;
> > +       REFTABLE_CALLOC_ARRAY(data.buf, data.len);
> > +       cl_assert(data.buf != NULL);
> > +
> > +       cl_must_pass(block_writer_init(&writer, REFTABLE_BLOCK_TYPE_LOG,
> > +                                      (uint8_t *) data.buf, data.len,
> > +                                      0, hash_size(REFTABLE_HASH_SHA1)));
> > +       cl_must_pass(block_writer_add(&writer, &rec));
> > +       cl_assert(block_writer_finish(&writer) > 0);
> 
> It looks like some of the block writing code above could be simplified
> using an helper function like:
> 
> int cl_reftable_write_block(struct reftable_buf *buf, uint8_t block_type,
>                            size_t block_size, uint32_t header_off,
>                            struct reftable_record *recs, size_t nrecs)
> {
>        struct block_writer writer = {
>                .last_key = REFTABLE_BUF_INIT,
>        };
>        int block_end;
> 
>        REFTABLE_CALLOC_ARRAY(buf->buf, block_size);
>        cl_assert(buf->buf != NULL);
>        buf->len = block_size;
> 
>        cl_must_pass(block_writer_init(&writer, block_type, (uint8_t *) buf->buf,
>                                       block_size, header_off,
>                                       hash_size(REFTABLE_HASH_SHA1)));
>        for (size_t i = 0; i < nrecs; i++)
>                cl_must_pass(block_writer_add(&writer, &recs[i]));
> 
>        block_end = block_writer_finish(&writer);
>        cl_assert(block_end > 0);
> 
>        block_writer_release(&writer);
> 
>        return block_end;
> }
> 
> This function could be introduced by a preparatory commit in
> t/unit-tests/lib-reftable.{c,h}. It would be kind of similar to the
> existing cl_reftable_write_to_buf() helper in those files.
> 
> It looks like it could already simplify existing tests like:
> 
> - test_reftable_block__log_read_write
> - test_reftable_block__obj_read_write
> - test_reftable_block__ref_read_write
> - test_reftable_block__iterator
> 
> and it could simplify the new tests introduced by other patches in this series:
> 
> - 06/11 reftable/block: fix OOB read with bogus block size
> - 07/11 reftable/block: fix OOB read with bogus restart count
> - 09/11 reftable/block: fix OOB read with bogus restart offset

Good point, will do. Thanks!

Patrick
