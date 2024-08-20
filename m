Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9A18E345
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141189; cv=none; b=IpVP3qJXSWxAaRfCrCEk8p1M62VSqbiqc5dt85898r4No7jKRgiCNyIr0wxSBhfnUXpiQ82ufC8Ct/Y5fjTMBDc2tDV3SLsAcuUhYAFLljf+y6/Lqvava3/FNOkUkezCeYJiCuWBOl54fDbN+jhbc7/KbeBLRZ8/yRMbw4jWwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141189; c=relaxed/simple;
	bh=oLQB0NMFIacezbNttBVgHNdqA5XjrCCpVC5a3fqRCHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4vbxrHnq66UmW8rlYeApuh5qabA87aoa/U/U1t4xfH6uW2A73b+1hMZk+laWImCqAo5lpdoS7eLhnCTgodG5JsJjveK1RWf9YnhFH9F3TBwe2PZs35oN4KTqn2qWtfuct2VFngz9qhuFGrKAmwjVrzwiC/t8IU+BNEmK5cXleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JENlNsne; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nnTpo5Hi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JENlNsne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nnTpo5Hi"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 49B871151B09;
	Tue, 20 Aug 2024 04:06:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 20 Aug 2024 04:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724141186; x=1724227586; bh=cv6EjOkgn5
	K8JFRV7xPpY60zPR4OeYY9mG5YKWr6pX0=; b=JENlNsnek+qAbwElwYwLEreR7L
	wYQUDB9SFIXYKCidFlKpjo1L/Ex2QOAqzMOpTBVkRzU3SrLFMoTIGsLh9rY+WB05
	Ke1B/n4ErKwNM2uWZ5W6ynAUKwElZWuujLJTpIgMx7p1XANdvMtXGXC+eNUiByBK
	0qWP88J0E5u8msLjVfWkjxCzsWTAfMbHQ2/YEsMXWsEToqju1eFhS9pDJfW09gXr
	EwGcTHUVjcs6TkOfUAz5JCBWLovEdcon4CPegz1Lq4dgWYEuHWdPzNpkC00Oz5zd
	qGYQnITp2eRLBEzQC91i0esrjkVcCv1Y2I3MyIPNImplIJRwiznTuH7um+NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724141186; x=1724227586; bh=cv6EjOkgn5K8JFRV7xPpY60zPR4O
	eYY9mG5YKWr6pX0=; b=nnTpo5HijEn0AQXFqM5Oj9W34hn2o5TBv3blNN3roT9x
	W4DdjFbuyBPTFyZ/ruHG+PWN9ZzS9dcjuDpzpTyOnJX284RHe81fVtNj++eNGjaw
	jON8EVzK+lzGBqTVfTPRsalU2Y628H3TToU//5DPsEKCcyDIoIRnMLqEZkLvnKfG
	ZRNNO3BkdOzEgfZ3fYrBJMtDIOSyadq8h6NcI69+HnLb18sZ9Shkzpfnwufyexj6
	BQj0ARBOOyUFUfklAiLSUppT26q+5AM1fnrK8SBQccy/oRXtjD8PgZ3DgbQUZsXd
	q6MGp8BUGVYl73nB/46Z/rcTOa8iauk0eH4fG8e+iA==
X-ME-Sender: <xms:gk7EZkO_eWedeohFf6CL2KH6iiflyLXW41xh2ngyqfM79egJ6jdnfA>
    <xme:gk7EZq-9ZiTRPZ70-o-HLiKnCnVvprLkuuQo8tiMbFtFoGuIKEFkfUfPgwWBdVwhP
    Tgd2cYBtuqxr2Wz1A>
X-ME-Received: <xmr:gk7EZrRV3mTQyJ-HD1RNYu6cPF-Nwjt9d6kRBO6Ik76XixvpEBku8ykU9o3TqIiYUx4Csiee7b6EYc-NI0MHItzB5rDTqWEFtd42QahnJ8ECtalxQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduhedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gk7EZsuhfRLOKmMWbEE_GGeJmD9FvhHJ1I1W7mujGwhqZUPuW43Q1w>
    <xmx:gk7EZscJQixvPv39gL2zAAmR_sSG7r4X8fG2xJtQfDEnogH5XUMkyg>
    <xmx:gk7EZg2QQUNbuxXhwJ9ctQXX8UyfsSlOh-31XiRw0pU-_ycRCFfoeQ>
    <xmx:gk7EZg-V7w6MA0KSLRQVjIDvGDRxRV0mImgcstky5BwCh3omcrVz2w>
    <xmx:gk7EZtroI3j-HX7xmaMQRRLuG1bNv7_yczVPiZxttqbJzL4wYkERCAbX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 04:06:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 016db9f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 08:05:53 +0000 (UTC)
Date: Tue, 20 Aug 2024 10:06:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 10/15] t/helper: inline
 `reftable_stack_print_directory()`
Message-ID: <ZsROcj6FDHyQjc-U@tanuki>
References: <cover.1723640107.git.ps@pks.im>
 <7acfe4fecc54beaa71d65f04c92e31ebe95aa1a0.1723640107.git.ps@pks.im>
 <CAOLa=ZSOiNKdJcMkE-P052cZjRXPcFQ7y1LnZFOZ0DMtqGnM+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSOiNKdJcMkE-P052cZjRXPcFQ7y1LnZFOZ0DMtqGnM+g@mail.gmail.com>

On Tue, Aug 20, 2024 at 09:34:21AM +0200, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Move `reftable_stack_print_directory()` into the "dump-reftable" helper.
> > This follows the same reasoning as the preceding commit.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/reftable-stack.h |  3 ---
> >  reftable/stack.c          | 20 --------------------
> >  reftable/stack_test.c     |  7 -------
> >  t/helper/test-reftable.c  | 23 ++++++++++++++++++++++-
> >  4 files changed, 22 insertions(+), 31 deletions(-)
> >
> > diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
> > index 09e97c9991..f4f8cabc7f 100644
> > --- a/reftable/reftable-stack.h
> > +++ b/reftable/reftable-stack.h
> > @@ -140,7 +140,4 @@ struct reftable_compaction_stats {
> >  struct reftable_compaction_stats *
> >  reftable_stack_compaction_stats(struct reftable_stack *st);
> >
> > -/* print the entire stack represented by the directory */
> > -int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id);
> > -
> >  #endif
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index d08ec00959..bedd503e7e 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -1603,23 +1603,3 @@ int reftable_stack_clean(struct reftable_stack *st)
> >  	reftable_addition_destroy(add);
> >  	return err;
> >  }
> > -
> > -int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id)
> > -{
> > -	struct reftable_stack *stack = NULL;
> > -	struct reftable_write_options opts = { .hash_id = hash_id };
> > -	struct reftable_merged_table *merged = NULL;
> > -	struct reftable_table table = { NULL };
> > -
> > -	int err = reftable_new_stack(&stack, stackdir, &opts);
> > -	if (err < 0)
> > -		goto done;
> > -
> > -	merged = reftable_stack_merged_table(stack);
> > -	reftable_table_from_merged_table(&table, merged);
> > -	err = reftable_table_print(&table);
> > -done:
> > -	if (stack)
> > -		reftable_stack_destroy(stack);
> > -	return err;
> > -}
> > diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> > index dbca9eaf4a..42044ed8a3 100644
> > --- a/reftable/stack_test.c
> > +++ b/reftable/stack_test.c
> > @@ -179,13 +179,6 @@ static void test_reftable_stack_add_one(void)
> >  	EXPECT(0 == strcmp("master", dest.value.symref));
> >  	EXPECT(st->readers_len > 0);
> >
> > -	printf("testing print functionality:\n");
> > -	err = reftable_stack_print_directory(dir, GIT_SHA1_FORMAT_ID);
> > -	EXPECT_ERR(err);
> > -
> > -	err = reftable_stack_print_directory(dir, GIT_SHA256_FORMAT_ID);
> > -	EXPECT(err == REFTABLE_FORMAT_ERROR);
> > -
> >
> 
> We loose this test due to the movement. It is okay, because the code
> that it is testing, is now only available in the testing section and is
> a test-helper. But it would be nice to mention this in the commit
> message.

Ah, good point, I'll mention that. The test was basically worthless
anyway as we didn't very anything -- only that it doesn't crash.

Patrick
