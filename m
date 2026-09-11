Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61846EC7C
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129436; cv=none; b=bxX1mko5EtotE/liKev433OqdXhTLoWLdqJpw53aJCcvaLRybNBiiteLJC4gWIAvSyMnc1Wgd0oUqvhHXmFDulcpaN1VVYRYC762D2m8MTgfX+FWAKExLtFGvTy8nUXdE/bLuaUGvXR5rRcmxuzZ4GjhArBDUL+eg5MlzlHTigo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129436; c=relaxed/simple;
	bh=QorjnKVoo0WfWSuta9UaQeVxmwUOJfSw17w+4cIwP3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLeyz7HMLmlWCgqbhAZJ0bd4l6Y0A+zdEx9MrHNRPjlBDbK19EmVlYMsnZM53WLAZ9ueG1Mm3Tj0KCqt/JFSfIr5kyAE1BB6uIJ9uJPifcDGpHwcGBYAgsdmc1IZlKrukCKrnj/XECUehVx79mB21GDbrM2idH5aHt72kEUjQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M9eHodU1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L2mT7xQT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M9eHodU1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2mT7xQT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0D011400138;
	Fri, 11 Sep 2026 08:23:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 08:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789129430; x=1789215830; bh=RgGzm6X4CU
	zXCWXSRQ5t0D+DjsqTZ7BCgqD8LODpsFg=; b=M9eHodU1+ArnZf4n7I6O17efgN
	4az+jGkHUpwhuK7/um9JaTpdohaUM0BrfzuU8ph1MeTfkf9cyew8ELr3R7L2z8lN
	XydxfqiuWSu7PSY9M7GFqYP/zhVZpBeDnXLcFkRABbpALlt5zwPCPBGoVWE9nlQB
	PDXi2/sdxkcj7p0CUShlqPcUXqukUlBQKfOK8pGe441mw6KAs+juK2pe+80BX2GD
	I1hfXeEM6y7yhuzpD8Hz+HTyyU0D3FcmhcsR2gxr1cDaLcwHbVZY7MFLCBSNeRfW
	sEdkylfN4ZZKg1WijlRVZo4eN3xk4ZW9+KKbyw0GfeTWP3G0sIvpIYbHDFSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789129430; x=1789215830; bh=RgGzm6X4CUzXCWXSRQ5t0D+DjsqTZ7BCgqD
	8LODpsFg=; b=L2mT7xQTlGDvvCxMHgKs82tQwxcdXrCHTGnGtc+3ljoNKxUyzkm
	+7FVSWI98GApiHgGypqqKJypTnVotK+K2FrOWnAOuj/SrsLgaaOrhTZNH6jrY5dQ
	SDK2K2e37aCq+zUD9E5aj2P9P7yzXvhCNfTcT33zbd08FOBSHiI8u4YYXHEgnM71
	n+dEgZ2SnhYW6TdrM1WtdhEQZAILpVJ58ase34IUBpMerUYC7cbI9ZPkHStL86oA
	S6MSwA49JEePB+7Kkwh2yjldF0zzptknTNwcFSEdBRkFNOONgA4s0udavXYw5EZZ
	gCeOUX8bsy8Lmu+GnTm5Tdsj9DIEhi0Q+CQ==
X-ME-Sender: <xms:1vKjappODwCLMJ2TMGtl4ZySYPEnPP6N0jUllCgWSF6nnHcYQVO4fg>
    <xme:1vKjajHL7HqXMxp4tBGWY7i5uvzb2Btvf-tHSv-MduwFjG-5xHdYB_dkrTK0R9rhZ
    ps6lBHjy4YFNmwVq2Py8vhoaO8NYJA6vy65HuwLur-FB8Bg6aApD-I>
X-ME-Received: <xmr:1vKjajmSChnZGnzudciwVaz5CUVVtbZZjmOsZr-oKOuIaLKrjMWJM0iYWD4M0S0_kJ2FBg>
X-ME-Proxy-Cause: dmFkZTGLBGvIdDs4PaM1Uuy+AzYb5JZPExlJjvAiM16orIl3o+oUMp6epLSw5b7uf0XtWg
    UuO+aqdQVX8jNmASy0cFBLoaBcfttsnns9qhCyTgdGlg7V6fQ9/APCfpsTcX8CESjp23vd
    WTZg5pldLny8yyffohUIOO8mPgjxDNMZy5Robf3vR5Zp10EVzqp5mfVU1bnBmF3yCpg7+V
    wDflPcPfHddesPKHRkaDn3n/FJrzbwzDQxjcS4VZ0/MmtvvItlujNzvDva7lKBo4UsZWsn
    4tU/vt+s2D2cgHbHsKZIaNq1k+KZeunSSx2kR1L/4+xKV6vnYlL0xzoLnatjXErq4ILIqE
    wrTJRGocjelDycQJJwo5rfUiuJhTFHcBgc0EX5+a6N2rvOANSiieE0uXBmxcYJm7VJ6Lez
    YZAkIVzCVyxzbkio+9eUR++MfSEPRfcm/VeL0+eqjqxAwss/33zvlV2qEqvjrmylkiv4K4
    vXgzrXnwBZtZZlL33t31RQXsll1xBm666t8ZSjmRKrqAGVp88pg8ZFsynoHMKXeHQx0b1C
    H1YRIDFl2wHNU48XPBGE/obGCcsb2wKhuPbO4LMrE5pNKPZ67a2cjHyyymFwEmK7D4nWbo
    HZUCBx3w2iGRLc3fK9fOuxExc76OupqIdQnLimlO7cMaYCIfhPfepBq7yfGg
X-ME-Proxy: <xmx:1vKjaun7NUyvGKDdelwXT7yS-TXbH8M5dB2JbG2Cyxxc1pX8tThszA>
    <xmx:1vKjassTfaZ9TaePh5Pmgwe-DU1G-Dh7Z0jbqLf7hUcBrxldvPIZBg>
    <xmx:1vKjaplQv5ZZDdcMvUnE2EBevq9UOPhD95zLEijhA5US6t_xqmyLlQ>
    <xmx:1vKjavvQvXpzntyD1W6uV_RJzD6POVSauvsDjX5DMXypsIMxNuCH7A>
    <xmx:1vKjarH8BN2HkxVFrOWrVRHvaoKYSkltZ1ob1QAmN87W4gyXEgtddqBS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 08:23:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d6e1570 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 12:23:48 +0000 (UTC)
Date: Fri, 11 Sep 2026 14:23:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/10] builtin/fsck: move loose object verification
 into the loose source
Message-ID: <aqPy0q0LJJCcBgZY@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
 <20260831-pks-odb-source-fsck-v2-10-f9b16ef4957b@pks.im>
 <875x0cnio5.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x0cnio5.fsf@emacs.iotcl.com>

On Fri, Sep 11, 2026 at 01:15:06PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.h b/odb.h
> > index 0bf6c8d7d2..b87f281cbd 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -218,6 +218,9 @@ enum odb_fsck_flags {
> >  
> >  	/* Display a progress meter, if sensible. */
> >  	ODB_FSCK_PROGRESS = (1 << 1),
> > +
> > +	/* Be extra verbose when checking the database. */
> > +	ODB_FSCK_VERBOSE = (1 << 2),
> 
> Shall we document this one is mutually exclusive with ODB_FSCK_PROGRESS?

But is it really? Sure, we'll potentially have interleaving output where
we print log messages followed by progress output. But as far as I can
see, we have nothing where we fully interleave so that the progress
output would be mangled.

> > diff --git a/odb/source-loose.c b/odb/source-loose.c
> > index f68d3c4d6c..efef9ca61f 100644
> > --- a/odb/source-loose.c
> > +++ b/odb/source-loose.c
> > @@ -1031,12 +1032,96 @@ static void odb_source_loose_free(struct odb_source *source)
> >  	free(loose);
> >  }
> >  
> > -static int odb_source_loose_fsck(struct odb_source *source UNUSED,
> > -				 struct odb_fsck_options *opts UNUSED)
> > +struct fsck_loose_data {
> > +	struct odb_source_loose *source;
> > +	struct odb_fsck_options *opts;
> > +	struct progress *progress;
> > +	bool error_found;
> > +};
> > +
> > +static int fsck_loose(const struct object_id *oid, const char *path,
> > +		      void *cb_data)
> >  {
> > +	struct fsck_loose_data *data = cb_data;
> > +	enum object_type type = OBJ_NONE;
> > +	size_t size;
> > +	void *contents = NULL;
> > +	int eaten = 0;
> > +	struct object_info oi = OBJECT_INFO_INIT;
> > +	struct object_id real_oid = *null_oid(data->source->base.odb->repo->hash_algo);
> > +	int err = 0;
> > +
> > +	oi.sizep = &size;
> > +	oi.typep = &type;
> > +
> > +	if (read_loose_object(data->source->base.odb->repo,
> > +			      path, oid, &real_oid, &contents, &oi) < 0) {
> > +		if (contents && !oideq(&real_oid, oid))
> > +			err = error(_("%s: hash-path mismatch, found at: %s"),
> > +				    oid_to_hex(&real_oid), path);
> > +		else
> > +			err = error(_("%s: object corrupt or missing: %s"),
> > +				    oid_to_hex(oid), path);
> > +	}
> > +	if (err < 0)
> > +		goto out;
> > +
> > +	if (!contents && type != OBJ_BLOB)
> > +		BUG("read_loose_object streamed a non-blob");
> > +
> > +	if (data->opts->object_cb(oid, type, size, contents, &eaten,
> > +				  data->opts->object_payload)) {
> 
> Should we guard data->opts->object_cb being NULL?

I don't see a reason for that -- we don't currently have any callers
that do, and we can still introduce this check if we ever grow one.

Thanks!

Patrick
