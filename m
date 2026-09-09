Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10282D0C9D
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945818; cv=none; b=lI33LElsT9M0qe10FHX0DOJACtI+Yj2Daz0VR2lZZVgg7aVjHB8y4igKUjQHJRj69L3fXSkpvwemroSUI15SYzfLZw+eUcLcOvjHFls22/P9gFn2dzxS8kL8RzZHG3ICnKurwbVXazoxcQeIAWluE9Cpk50np3VUf3xaGB5fkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945818; c=relaxed/simple;
	bh=kvDEz2Hu2/DEDprJIVyJTLI2ILpEuN9mtvvYKP1+0pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6OJTBhBZIE3B4r4hABD0uLPfgDSlE8tSBDMBqPqIMEUwLgwNVY6sU51NBJYMFPoGNMsiBbHolGmIdhL3jS9IwcO4RO6BNPZCWQspU8YQxzQAMeL2yIx7fF26Vnu09OByg4qZZqLj8YtjI8klY0D/NnH3KYSduZswxmffxu9H/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gX2JsKPb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q/sOdV5q; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gX2JsKPb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q/sOdV5q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ECDCEEC00B8;
	Wed,  9 Sep 2026 05:23:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 05:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788945814; x=1789032214; bh=3AHs1iAlqu
	UAEaEzymT8ZnNiP2DQeXLhMRmNWDuZvXE=; b=gX2JsKPb7AJuSh9iYbBsgmwLd0
	SfUIj0mlpD1Mg4GuS4hqt4g+PoVZ5y6/EU6jgB80vOTBpfLoL4i7zr+jCkJGdZrN
	jJA2UGBKm/Eb1IUMNK4LIi1wHW+gncEzg/essEIOp199ccPsDZHBSo4i7iZh+YGv
	nHqRJHaStTShxSUEz5VSLzq7Qw8h5ibhM04iABpcZDwJv7x5EEu+cid8gBj8HyP8
	0saSujrW81cTmjFlwNRIYuRkORfZ9CIl7SggMdctG06Cmz48XCJ2lPk9Qi+KtFNd
	5G6wFxk7fwBmUKOUXxYg6nEIAqHMbJtpEYhoDG0q9vSO+CUy1r5Pf/AyM5gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788945814; x=1789032214; bh=3AHs1iAlquUAEaEzymT8ZnNiP2DQeXLhMRm
	NWDuZvXE=; b=q/sOdV5qYLnVLSB6yA6kwlbytIcSaU4d/LAa16vIMFjalNF6qpw
	hpsiHid3NZGHqVfEvEDePT/KuS0o4D64QvUD1Zn4iqzQzfdDQ9H0QrzoBpDaMMUg
	iAQHEyuwP6n2m9gIpQYy6KG4h+W+j34nRrP+iEQfXH8h5N0r98qrw/E2606ohzjc
	6UZhnH4WMvNkBQOMEXJENouObNW94gtWBiPmSo9Rw7PV9hmDdxVDf5Jmtm51CVz1
	kfJXXREoDwZBCRzDjdKsgvHHg/AZXB9Mdz6l7QHS4RCUGP5pA1SprgN5hdZTc4yt
	/FJxgMQJideBMFSchQdFuG0qIPOIHgjNgOQ==
X-ME-Sender: <xms:liWhateMQSBZWLBRawnWqpFenL_U-2HfOsshr4VGQSCCt6OD0ypL0w>
    <xme:liWhaiPi1Ev7HGV52QUd943unREPwn85HNEcj_zz88-v3jHZG04G8DkcwZ2OAcBdB
    f7Pphqoz0vmvEMfqDvicB_4UwCMiohRpg-BcyCEZ1PepMasoprw5w>
X-ME-Received: <xmr:liWharjI_cziEuwogK-KY8ZUTX1xBsybB48tT88YcRmJK5cmt9lD6u2_Vh_U7cvrpynJhg>
X-ME-Proxy-Cause: dmFkZTFRkYaBeIOhonHYd0fRWCptJhQCOECbXmyyZvIhjDwA4EYhW8VkKKsRAqzlZfUzTW
    zZxm8nO7cu50rM3KSb2Y3WC/xwvXKsXJIfH4AT0z0fDFkVNUckPME/KMF89RmYHRc+Pp5Y
    dgx4HPzg+TXpISnhXxXwD4+e7ypLA1M5OJbbNT+InscDanRh7hlUeesmwihU2j3IPM/KjH
    v8ScVhJocyMhRfr/y/ZvT5u2Y9LTO84ZcyYpZeBe/ZVFqC8iYblDwOLeURWUpqjcVy7cP0
    inpVhJ0cICOcyzlEPDw/p1xmi9ZxbETIDHT3b6Eg2O45go3yHvSi3ABy+8DWwXJ/5jTQH2
    TvAuKASnAV+UrGXVxQPPjO+CKo/+m4mGAV8MPegpes9qc1wOTMtEAWci1IOU/4xyr9NOLD
    9wJ38MgSHL67935MbiU1AVkpgYrjojW9Z8yRVRl4mu5ygcO6It970PTghbtounmpMa08ra
    754IRPNAYU632ZiWmVtC6rC/QuB43kZPnuabjhHZFgL0OuFuMn4Q6rw+hyJekrMISjkwLc
    4hhFtBnkyitnMeM+ZDA9nFc9g9tYnR/Yo7fRSbnwEh74xzmcYoKe8gzmYoDytKtFBmXx7S
    V4PCu0yGYVMpu1dvik2n1k/zdFKb13br2kwvFqjhjYbdLMh7Dcpw9Tb93Qqw
X-ME-Proxy: <xmx:liWhal3UI70ofvndOOGY0uMRKTQFp3GdukRrvp-3UkpkhLZiPkTZ0A>
    <xmx:liWhalgvCtJuIXRD0MgwKREL8PgVp-fNYzR0V7VdvLI3hddiL_behQ>
    <xmx:liWhaleGldij96XHpE2hvsGlxK512QsAzSkIClj_Bs1Vng8wnHfg4A>
    <xmx:liWhaolwe2DjHQpl38_w-RY3ZdefZYOSLj5yWLuTrf4CpwXDWF8LhQ>
    <xmx:liWhavAEtnd0s816MEnAPDIO8du10eoeS7CatsiZlVwJuD3kNOz6X1ZA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 05:23:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84619a37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 09:23:31 +0000 (UTC)
Date: Wed, 9 Sep 2026 11:23:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/11] setup: rename ref storage format environment
 variables
Message-ID: <aqElkBmqoOqb0J5b@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-9-6733c90ca5b0@pks.im>
 <57f08562-ecea-4e51-8e5a-ae3aa91b23d1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f08562-ecea-4e51-8e5a-ae3aa91b23d1@gmail.com>

On Wed, Sep 09, 2026 at 01:40:07PM +0530, Kaartic Sivaraam wrote:
> On 9/7/26 16:48, Patrick Steinhardt wrote:
> > @@ -2785,19 +2788,21 @@ static void repository_format_configure(struct repository_format *repo_fmt,
> >   	 */
> >   	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
> >   		/* nothing to do */
> > -	} else if ((env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT))) {
> > +	} else if (((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT)) ||
> > +		    (env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT)))) {
> >   		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
> >   		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> >   			die(_("unknown ref storage format specified via %s: '%s'"),
> > -			    GIT_REFERENCE_BACKEND_ENVIRONMENT, env);
> > +			    GIT_REF_STORAGE_FORMAT_ENVIRONMENT, env);
> 
> We're getting the value from GIT_REFERENCE_BACKEND_ENVIRONMENT as a fallback
> but we are mentioning only GIT_REF_STORAGE_FORMAT_ENVIRONMENT in the error
> message. Would this not be misleading if the value actually comes from
> GIT_REFERENCE_BACKEND_ENVIRONMENT?

Yeah, fair. I already had this on my radar, but thought that the
solution was a bit too ugly because it resulted in a bit of duplication.
I was thus sweeping this under the rug a bit, if I'm being totally
honest.

Anyway, will adapt.

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 1f0505e412..60a2179a0a 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -575,8 +575,8 @@ export EDITOR
> >   GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
> >   GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
> >   export GIT_DEFAULT_HASH
> > -GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
> > -export GIT_DEFAULT_REF_FORMAT
> > +GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
> > +export GIT_DEFAULT_REF_STORAGE_FORMAT
> 
> Would it make sense to also rename GIT_TEST_DEFAULT_REF_FORMAT to
> GIT_TEST_DEFAULT_REF_STORAGE_FORMAT for consistency sake?

Oh, that one I completely missed. Good catch, thanks!

Patrick
