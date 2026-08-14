Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D78415F07
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693274; cv=none; b=fDg/VM5hAtwomn6ZAc7n1oCtJSiCCNFIzRfbBVSmYBMs1CRzdp4Ii5QT8VWym+ALtBRLfSz4CkCLNG9D4U7dcIxZnK7zNjivCBsLhY7Ljya7JCWrusqid9U9TIz1JSNR3yFKCWL92FEGJX5WFC0aYSACg0DVVgbexDdb/y9IQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693274; c=relaxed/simple;
	bh=Rx3A/g61GdnXdTqhgat0w8l4mWCYoMNulzN5AoItb00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo0cDS/vioTANKnsMpTLCDvsmKtoQdsNHX2xoTE61YkT23FyqJtLBtfWrAe6wFX5wxOPn2l7iAuez7uSI5OXE4RRdYy5upblT6PBq8jfaMGNXFkyWllUo26vW22WBQ1ZckEmxYgdX6AG0PC+IXG62qj16tQNvx6UdlKHoiZwKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=izUMMlHU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AKKJuyVN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="izUMMlHU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AKKJuyVN"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 41A981D00361;
	Fri, 14 Aug 2026 03:40:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 14 Aug 2026 03:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786693255; x=1786779655; bh=4WA66Ap+Aw
	OWsrqGcPmhciatsZn2wyXVFACyvRiYQzs=; b=izUMMlHUNJQ50xD5ZVlBk28jBO
	tq7ohzyRvy0u6DJZNKp/vtbbotkBmappx7ma9lXY3YixoByb/ZKXGHBnWISJGil0
	WPG1wkwwcxgju9cUeN9WyqwSPRrvLBr+q7IP1vhQtRJDrC/w/9MkvvF1WjKPGiWg
	qL9lrnoXx9oXM0UZLam/z75sUP20midybvL5DcPA7pdmmhXR5OEXmIyBEFYEU1xb
	9kHXQBZNCVdDpBhdQhMj2w7mZuBW54cFOY7I4kEM4NMJp1+Mv0MCROim/OdPQJz0
	KXRF5TtK83aFOr8D4qTBZhr142KNl6xrL/0t4J7eBHOsSq/LYXZUBHdIxRcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786693255; x=1786779655; bh=4WA66Ap+AwOWsrqGcPmhciatsZn2wyXVFAC
	yvRiYQzs=; b=AKKJuyVN9sJ8c+OJejOea6TcAD54P+ceNGopgWS+f5Nz3/B1STk
	ucuww7WoIVdUOXpxwIgYgiCD/17zLepTHMrqtqNdxfRxpmOkQ3Pk/zQHpjGJAEPX
	hE9dKHgrAkfxSmrDVI/Bmmqu4mSNUH7+69Tg2LMFfxyGO8lEjDAEVbmWLcgIu/jM
	Zrx19Yo9PI0TbQ1hPbGJFU00kuJPyZiV+lMC3DKinxtwmakx9ID/gNHSkcJ8IV0j
	pSyj2Uf1uRvSbobK5Q9C56mXXrC1hYfGvR9qp42hDPnHyXlj/Lk8txqZr4LtyVA/
	XWHWt5eDaGEnhQG4fXhD3y1asSO08V9c+Ag==
X-ME-Sender: <xms:h8Z-aiAig1UbRJvzw2FjV3Te2EttUNmx0Sc0H0jkitL9wjMNdsrT6A>
    <xme:h8Z-aijnkUfdtnQSpiFBAZ_qJqUzM_nGaqdQZ3emaa-KHer05DgSKwrBgkU_n4hbz
    _LhLmNMNtJkqM-Yo1AgV7SA5kSqHsuI9oEar4Qj4PqZ--JwY4c7CVY>
X-ME-Received: <xmr:h8Z-ajNS9ouRUaIEhuc6eUL_KjxL0Ww_zQxQo1T7G3hBd53mU5aRqN6V0_glD364n8G9J7t1YZi-2DNIs5d80648dfJ0uBGzbjzuEii76pI>
X-ME-Proxy-Cause: dmFkZTE9dd3/nFQUCV3EYnvYMmeNoqzvQ58iPdvHauyoS4LnpJlu5U0xZCIjJKLLXAIPQS
    uff0r6OzbT+5cZHdCqMgB6rpn8zXVmtrgKUZIu8ofx/Mjhs9GB67srmzJN7JmczByPYayR
    Cx3gxo0eJy/4uNL1tCeSHGH7ICrg3/zpIaE+CBt5KvOPo+yPSMlOJi6Ybpt5feG50Y9uQr
    sACXWQwS5ZmObvfSo6GmpHrPV4+q0PbUP5rlmbVuBxVKA5NC/LSO+NY9x80CXnQTkJUBf9
    K5iMrKvtRTWLj/hxgQpiHJ6mz/0aJOH4ew90j8zIWgCwskw8bXze9SPRLrFUNGZXB1MsCE
    zNIr2rnc8nTzWeNiOG8wTAnaMjndrmDzf97HZuqgS/uY33ltJcpEUjBRmJp2zMy6Kc/gqQ
    fg268bJtCg4JKYNii9pRV/+bZVmRCShbAJYGPehn3hMM+5Xjqx3JF1mg2pliw79lBWNGz3
    O56RqpMO/6brIsClZNelfLOGG1CfUlWphPwLy2heY4vtVYMkLumd2KREbtRLuqezWEmIly
    MMGiTiUGsJ9A6jk/y/eIBtqov6/x+epOSsmWzLqqC1YTACAnB0wV65qqRNNpb3vG3AFAxc
    mLAB63k2iE4FzP3R+4ILqd1HmZyOvR//NGf4owJh7EcX7ANU6iRndffIoJoA
X-ME-Proxy: <xmx:h8Z-ar4amQ4JNeIbOXmeX_CXe7EYvfk84m1CUicoUPQvdahaLJF3Zg>
    <xmx:h8Z-ap2UJRpilPBE7-keGdvqUStquLg0NAl1U4qKaYWdx8id_U1dsA>
    <xmx:h8Z-akZA2anVtPWlrTAtVKpjZPN4HS31Lhul_XmJX7Ptnaloph6xFQ>
    <xmx:h8Z-apD0W1HjShxgoQ8y19e0S43P83ZYwl_iCcLourP8FkHkm71WYw>
    <xmx:h8Z-albAs9MAYD85TArSkcxiM9nEXpKrGYO5itj08Ijm69sCMyiWBh_f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 03:40:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f9fe983 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Aug 2026 07:40:52 +0000 (UTC)
Date: Fri, 14 Aug 2026 09:40:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] bundle: generate packfiles via the object database
Message-ID: <an7GgQLQfleCPr-a@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
 <20260807-b4-pks-odb-generate-pack-v1-5-7dec431ae7cd@pks.im>
 <xmqqmrupsxx9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrupsxx9.fsf@gitster.g>

On Thu, Aug 13, 2026 at 11:00:34AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/bundle.c b/bundle.c
> > index b64716f252..09afc465c0 100644
> > --- a/bundle.c
> > +++ b/bundle.c
> > @@ -325,50 +325,52 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
> >  
> >  
> >  /* Write the pack data to bundle_fd */
> > -static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *pack_options)
> > +static int write_pack_data(int bundle_fd, struct rev_info *revs, int progress)
> >  {
> > -	struct child_process pack_objects = CHILD_PROCESS_INIT;
> > +	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
> > +	struct odb_pack_generator *generator;
> > +	int ret = 0;
> >  	int i;
> >  
> > -	strvec_pushl(&pack_objects.args,
> > -		     "pack-objects",
> > -		     "--stdout", "--thin", "--delta-base-offset",
> > -		     NULL);
> > -	strvec_pushv(&pack_objects.args, pack_options->v);
> > +	opts.thin = 1;
> > +	opts.ofs_delta = 1;
> > +	if (progress)
> > +		opts.progress = ODB_GENERATE_PACK_PROGRESS_VERBOSE;
> >  	if (revs->filter.choice)
> > -		strvec_pushf(&pack_objects.args, "--filter=%s",
> > -			     list_objects_filter_spec(&revs->filter));
> > -	pack_objects.in = -1;
> > -	pack_objects.out = bundle_fd;
> > -	pack_objects.git_cmd = 1;
> > +		opts.filter_spec = list_objects_filter_spec(&revs->filter);
> >  
> >  	/*
> > -	 * start_command() will close our descriptor if it's >1. Duplicate it
> > -	 * to avoid surprising the caller.
> > +	 * The pack generator will consume our descriptor if it's >1.
> > +	 * Duplicate it to avoid surprising the caller.
> >  	 */
> > -	if (pack_objects.out > 1) {
> > -		pack_objects.out = dup(pack_objects.out);
> > -		if (pack_objects.out < 0) {
> > -			error_errno(_("unable to dup bundle descriptor"));
> > -			child_process_clear(&pack_objects);
> > -			return -1;
> > -		}
> > +	opts.pack_fd = bundle_fd;
> > +	if (opts.pack_fd > 1) {
> > +		opts.pack_fd = dup(bundle_fd);
> > +		if (opts.pack_fd < 0)
> > +			return error_errno(_("unable to dup bundle descriptor"));
> >  	}
> >  
> > -	if (start_command(&pack_objects))
> > -		return error(_("Could not spawn pack-objects"));
> > -
> >  	for (i = 0; i < revs->pending.nr; i++) {
> >  		struct object *object = revs->pending.objects[i].item;
> >  		if (object->flags & UNINTERESTING)
> > -			write_or_die(pack_objects.in, "^", 1);
> > -		write_or_die(pack_objects.in, oid_to_hex(&object->oid), the_hash_algo->hexsz);
> > -		write_or_die(pack_objects.in, "\n", 1);
> > +			oid_array_append(&opts.haves, &object->oid);
> > +		else
> > +			oid_array_append(&opts.wants, &object->oid);
> >  	}
> > -	close(pack_objects.in);
> > -	if (finish_command(&pack_objects))
> > -		return error(_("pack-objects died"));
> > -	return 0;
> > +
> > +	if (odb_generate_pack(the_repository->objects, &generator, &opts)) {
> > +		ret = error(_("Could not spawn pack-objects"));
> > +		goto out;
> > +	}
> > +
> > +	if (odb_pack_generator_finish(generator)) {
> > +		ret = error(_("pack-objects died"));
> > +		goto out;
> > +	}
> > +
> > +out:
> > +	odb_generate_pack_options_release(&opts);
> > +	return ret;
> >  }
> 
> This function uses the_repository, both directly and through
> the_hash_algo macro.  I think we could use revs->repo here.  An
> obvious alternative is to give this function a new parameter "struct
> repository *repo" but then we would have to worry about what should
> happen when it and revs->repo go out of sync.

Fair enough.

Ideally, we'd convert the whole file to not use `the_repository` at all
anymore. But we unfortunately call `get_log_output_encoding()`, which
implicitly depends on that function. I think we can still mostly drop
the dependency and then just add an `extern` declaration. I'll do so in
the next version.

Thanks!

Patrick
