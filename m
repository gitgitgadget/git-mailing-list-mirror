Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3B13A259
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794302; cv=none; b=aiQZAal1nVyewkw+MeK7S1qCVtgxBJZk2G3Y4qjVhwYcSFIdl421zeoOhmTHvqRJnEVMhAu3ev6TSr42OVltm4v24sguLjHu4iuUSStbgkaEQ0IAFx+N97mSXwDB6YKRfn2g+lCVlAs69mDBszEo81hYjRX8QWOsG7SJbj/o4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794302; c=relaxed/simple;
	bh=mz4BSIVX3mFSRnpMW2VxXlo7DQAInnTkCdaG3V8y9eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWtvOTthNiDwieqzmCXm6p3XTbQlmSke053uzxIbW5rVqJ8AhdPiPBMB8wvVx4ft/DPs5f2OVFDNSQiWr4s8dXqaAjjbsNANUe77eLjBOl+Rw4e5PDi7DPGUDZsRAGK5F8yjLVg4jtnKdbttSft0+adaWwNRcA6SOhC88Lq8of8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EAIIiDVC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VTuK8cqT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EAIIiDVC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VTuK8cqT"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A8C1E1151AD6;
	Fri, 16 Aug 2024 03:44:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 16 Aug 2024 03:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723794299; x=1723880699; bh=z1sUv/j8hS
	kfdH3V5w3kb9D8Ttd24XAMcJIaQO1J2fk=; b=EAIIiDVCdfjiZaJWUMGo1bBfP4
	oP9CZlPgKCFxJzLjKqmZEqn6MKsUZcU669GuBi7zfkYJx3AjUfLYvWyna1UnYD+t
	4Nvye1Iz4KlLsh/qwmCMInm56F9KWAYTdkUDnDK5Nb8YNvL9q/A0n3EMOZJKRhCV
	XZK5yrFy6YHR0K4V2dZKlOWgxFroA+HkvKjdy7nuaiDlPcLUvnfkwsYOCCfAHi5t
	qw6OaMKX4KNSRUgK+GlTrEQpk5IVI3WyYCCW+8dcrcogk5HohBujoT3cp8wUhFRA
	Udwdi+uZbQSL6zaEZc5bPGWxDyw4AzEwpIERe6KEZRH33MZSvXQ4Y+u2W9FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723794299; x=1723880699; bh=z1sUv/j8hSkfdH3V5w3kb9D8Ttd2
	4XAMcJIaQO1J2fk=; b=VTuK8cqTsfyxyMs0v//EVzpgPQJs0rgcZXQyGTwRyVpl
	S5R7VLhfbEfI2BOepEfkgk3tIO79VTH9/319fNFidnd8HHroe96Q7iOxhI/exo76
	d1Z/jusoI1xUG/wkD1JaT1BVkvvU+i5sKdbbWvYoQtzk8hInlwDEROdb8AmZD0i3
	dd9u1pCTfOtCz7N6J/CDNeZCh972xW0xuLjaBh/RfA6xCDwpz5A+OM8DsqLS5k1s
	xFrotVV+WvE6fFcCqR2lByLU+tx2qgS03RJO2VnVF0B3jFeJgK7Jh4yt2O+UukaE
	f2Vc17rjZAx5IUANctlDF9guBQNCD4RXHhXcfgXpgQ==
X-ME-Sender: <xms:ewO_Zkb7xaSkecN9c4qj3pwhTpcajRsERGOQpwUR8DPceBcG97KxlA>
    <xme:ewO_Zvb8iqj7sFO2OBp_54SyKZRM_yAg9iJpbUtCRfFBlBJUWdziuMiBAjmKQKT_X
    nXg8w7cEKXNPjc18A>
X-ME-Received: <xmr:ewO_Zu8QmyDuOPFf0KEfEIJqrXOwqFk83aH23ExXhtDCAOHz457l98dz-ioIXQdZCf9mg004uvCUYU-SLLpxjkQo3VKAyuI5dR6RwU1tVwyjRUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:ewO_ZupbdFZM8ZH0lF4E-Ed1IJh_fuFCBRaii-t4Kbafy3lJowlI8g>
    <xmx:ewO_ZvoiGz6LioZczxynVZXy31PuB1kk-2FhFNbDlxk1yTBJeLNLcA>
    <xmx:ewO_ZsQcWV5_aHfEvoZqy58dVRN1091D1V-1kzYYH-hFh_OXTnnXzw>
    <xmx:ewO_ZvroFitRaNQdxs9XQjELRaODyFhu5Kmo31pserGrJVF4NNQ7QQ>
    <xmx:ewO_ZuXWVkzRDlsi7hTeGNw-rBOyKz09EfspwZABm_WX-yZY6r2L6ozv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:44:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 172b8b99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:44:35 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:44:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 09/10] t-reftable-block: add tests for obj blocks
Message-ID: <Zr8Dcvfg01f3mKd9@tanuki>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-10-chandrapratap3519@gmail.com>
 <Zr3NNBTXNXSCrTpJ@tanuki>
 <CA+J6zkRHZ3NF8QV_oFBVEO8gCy-Pvf6zerdiY7aKCqkofRPktA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+J6zkRHZ3NF8QV_oFBVEO8gCy-Pvf6zerdiY7aKCqkofRPktA@mail.gmail.com>

On Fri, Aug 16, 2024 at 12:41:34AM +0530, Chandra Pratap wrote:
> On Thu, 15 Aug 2024 at 15:11, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Aug 14, 2024 at 05:33:17PM +0530, Chandra Pratap wrote:
> > > In the current testing setup, block operations are left unexercised
> > > for obj blocks. Add a test that exercises these operations for obj
> > > blocks.
> >
> > Same remarks here as for the preceding commit.
> >
> > > @@ -186,9 +186,88 @@ static void t_log_block_read_write(void)
> > >               reftable_record_release(&recs[i]);
> > >  }
> > >
> > > +static void t_obj_block_read_write(void)
> > > +{
> > > +     const int header_off = 21;
> > > +     struct reftable_record recs[30];
> > > +     const size_t N = ARRAY_SIZE(recs);
> > > +     const size_t block_size = 1024;
> > > +     struct reftable_block block = { 0 };
> > > +     struct block_writer bw = {
> > > +             .last_key = STRBUF_INIT,
> > > +     };
> > > +     struct reftable_record rec = {
> > > +             .type = BLOCK_TYPE_OBJ,
> > > +     };
> > > +     size_t i = 0;
> > > +     int n;
> > > +     struct block_reader br = { 0 };
> > > +     struct block_iter it = BLOCK_ITER_INIT;
> > > +     struct strbuf want = STRBUF_INIT;
> > > +
> > > +     REFTABLE_CALLOC_ARRAY(block.data, block_size);
> > > +     block.len = block_size;
> > > +     block.source = malloc_block_source();
> > > +     block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
> > > +                       header_off, hash_size(GIT_SHA1_FORMAT_ID));
> > > +
> > > +     for (i = 0; i < N; i++) {
> > > +             uint8_t *bytes = reftable_malloc(sizeof(uint8_t[5]));
> > > +             memcpy(bytes, (uint8_t[]){i, i+1, i+2, i+3, i+5}, sizeof(uint8_t[5]));
> >
> > From the top of my head I'm not sure whether we use inline-array
> > declarations like this anywhere. I'd rather just make it a separate
> > variable, which also allows us to get rid of the magic 5 via
> > `ARRAY_SIZE()`.
> 
> We _do_ use inline array declarations like this, here's an example from
> t/unit-tests/t-prio-queue.c:
> TEST(TEST_INPUT(((int []){ STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP }),
>           ((int []){ 1, 2, 3, 4, 5, 6 })), "prio-queue works when LIFO
> stack is reversed");
> 
> I did implement bytes[] as a local variable array when I first worked
> on this patch but that turned out to be tricky due to variable scoping
> and pointer semantics, so I ultimately settled on this approach.

Oh, I didn't mean to say that you should _only_ use the local array.
Rather something like this:

        uint8_t[] bytes = { i, i + 1, i + 2, i + 3, i + 5 }, *allocated;
        DUP_ARRAY(allocated, bytes, ARRAY_SIZE(bytes));

Patrick
