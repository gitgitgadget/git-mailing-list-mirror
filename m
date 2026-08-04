Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3DE429013
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828095; cv=none; b=pNlBQWdkGYZPKzr812w07dQoWAXl6ZTR+HP2WN1UO8fZEL74Mw25htzJQK4oluNCtqyCNV7bCY674vwfzFXLVtFX5BmfPy4a4Ktbn2BEvNNvxEhOptT3ufGRuMHBeDH/ZG53WK09/h2I12SnrXXNpLiOI3SKTTqmGg6kwhV3Ikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828095; c=relaxed/simple;
	bh=7hsOTsZtHuWT9qdlQf5hN0ecnAso5yYl5T96RCBcPLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSaqt7vhR9VcEwvINHJxU6yms6JtWya8/g+PZh5KxrsttKXiATwfs7YWyh8CcafFccwDf/KSaFxDrt8SQDeyt+Gng4ZcxpLlcmarAJWW5N5EYAV/zFE3JIBC3qEdZpuALc0qpuXv7kB/IKTRCenccMK7O5eQQus0DodpKjbdu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q17IhorA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CzIPrK/V; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q17IhorA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CzIPrK/V"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E6571D0017D;
	Tue,  4 Aug 2026 03:21:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 04 Aug 2026 03:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785828093; x=1785914493; bh=KUQg7foEKP
	5HqsL7V8nenGbILoj6cswPMYbsFAGNc/g=; b=Q17IhorAw5zFWrU96sknEB5ZBT
	/igd7xxW0W+KsC4Rh7p+q3LjOg705XvRV7+Z+++z922708sl55vYzxiHFH8CO6bb
	8c58O53oiXM0ZMIlsEFgzZoOzy01JrOQMJ/6LvjyTq2yb5PHCs3ADLdDyIJNXFZH
	RfYrBHJaI56w+0w5NCMSCCfxltdVBQ1QvIMn6lHoAAkuEO4s8i7h4w8HI+za8DgN
	tl3ZHQJiTqFQJmp2AS0UNY9V0xUIo8VggfiQv82k/VN00XdeOg9rygAi93DjqPv0
	FHyP/+5OekLg6fqJYcVXKrXHwPunB2CXYrLUad0mgZqt/vSXN1V/Du3vfvWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785828093; x=1785914493; bh=KUQg7foEKP5HqsL7V8nenGbILoj6cswPMYb
	sFAGNc/g=; b=CzIPrK/VqLOl7suzqrIjRZc8hrYF/DTh+v2kCllE1pHSUbLi555
	JAtgGuUV2+41nT3jZmi/6gVdGJQKUyRHb4EstYq6+O6qc4+MVe+0RB8i99fJWe4V
	kruHq6O6OryiVOEaq2DWIXtDBT9pb3fbylTj4/A+NlTAjlNg86dlkxO6EnAXPkaA
	Yds27IZildMl5obrN4nqXSWO1GAIVR76sP+LyZNQrGxPCOKXVdghfbB/l7v8bTiM
	oHzU1eAvi3Sk1ZkhZchF0ajBJevzNcOHFfUznL/gr9jnETD/fnKH4RnngCid3WAf
	1jmszLpMVLwvpWd6OQTpq6eOizbvJzXnzBA==
X-ME-Sender: <xms:_ZJxatxkFL4LDW1GneFjx1bCcJ-GHjHZXSggOx_PSq40gfCSIcC7Gw>
    <xme:_ZJxajQ5sNzUWjF07MK1u-LCycuwy9drGORevrBTVN5RzxyrDk3RRqRHt2n6e2jJZ
    fuGWJ7i8cVc7Is6j_hrG3Zj-fzXsJXFGMlQQotOy3WbzyuGAWYopw>
X-ME-Received: <xmr:_ZJxak8JplLR0HkIimC4ZtTcxljB9RX8rQNhKAbKTOT7RayI6Mam6r3V6Qgc6uQcWosYXWjUCmqmu90Sqhk1oCTw6X2NZZAqNERVBVgb>
X-ME-Proxy-Cause: dmFkZTEW21OsGZxUpWZhdkXtbm/1B/RJ4l8Q+GteNB83+vGg16KxWvo9EDlkFLPwh4XmVg
    tonzBCmSlMcq9Zv5kkMsAOrl3v08zRX5F5Kf/PjQV7dQl7CLH9DoiWJINC1zs+NzgfwbPb
    o/vBuEQsSqrZT13qzTRXc554btVvCS/6lfjTQKMetN17r0fR9TYxOWWeyrliUtKDxD9PGp
    NrcEbQBCL7dK6pSjPXks7iNDoYJDpbaOkZ3ZDai5LJtC1i8/s7ATR2oU3ZQZ+La75i1u0F
    hpyPnpq/uoBEpgm0v46vVCf+YWFQ4IBX0XlK2EWgOqGNi6VR3S767OqMXno5X3836ebysg
    LcXJALL+NtLt48BHoRG8o8Cn89gmEoSpzUTbD7vKnnCMdlVhx+a3ZfULl4lxMhKwbPO/nu
    etRaQiYcP0+5kG9PJa6ZLTfho/h8BPMcrctPCgh+bO1wMk1v8xFnIKH4/N/J1Rkm9U4jDW
    SBUcOOwU76MD+xSCHffDVkM1eabkkbw68SuXvYyO2r4P2J3NBTQLbDIi7VOFwywgVZcmWc
    Z6FBVox9dPre83eKlJzoRPqcojE4da5LhDWuKmwzA+1RVKk1KsITjdZk5yirKoX4dbwcZD
    qVFDf+ywImXfXSYwLwv0gROFopveKGOZuINMcQHjKyVPnem9etWoiGrXYqXw
X-ME-Proxy: <xmx:_ZJxaqo5vZt8kpL0dYZXX63ZQDfjK_Bjr4FPgdtBm2lCHhRUeBf6BA>
    <xmx:_ZJxahnH3s80XaHynQcRD3iGzTIIpJhZWwCRcAHxvSZvsePkBiwF6g>
    <xmx:_ZJxahInX3-uo_V_fzH7cPIsowC8nWh-iiZVsqJhC_ft0HDo8PdnNQ>
    <xmx:_ZJxamyByjT-EanGkge_vLqZL0CR7OIn27aNDu9QGDsfc66IEjCCmQ>
    <xmx:_ZJxat3eGQTnG1CCCmyfkypUr0dWnC0Um3x6-t4QrWzcHKTxp6Q_N6sE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 03:21:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de7e59a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 07:21:31 +0000 (UTC)
Date: Tue, 4 Aug 2026 09:21:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] setup: detangle loading of loose object maps
Message-ID: <anGS-IOKHMo5VUJm@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-2-3b3d265d979b@pks.im>
 <xmqqh5lo6xi2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5lo6xi2.fsf@gitster.g>

On Fri, Jul 24, 2026 at 11:41:41AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When a repository is configured to use a compatibility hash function
> > then we load the loose object map when we initialize the repository.
> > This object map provides the mappings between the canonical object hash
> > and the compatibility object hash.
> >
> > Loading the object map happens in `repo_set_compat_hash_algo()`, which
> > calls `repo_read_loose_object_map()` in case the compatibility object
> > hash is non-zero. This setup sequence has two major downsides:
> >
> >   - We assume that the primary object database is the "files" object
> >     database so that we can extract its "loose" backend. This stops
> >     working with pluggable object databases.
> 
> I am not sure if I understand this sentence, especially "we can
> extract its loose backend" part.  Do you mean 'extract the object
> map from the loose backend'?  Or something else?

Yeah, this is a bit awkward. Rewritten like this:

  - We assume that the primary object database is the "files" object
    database and unconditionally downcast it. This will BUG in case a
    different object database type was used together with a compat hash
    algorithm.

> > @@ -112,14 +115,10 @@ int repo_read_loose_object_map(struct repository *repo)
> >  {
> >  	struct odb_source *source;
> >  
> > -	if (!should_use_loose_object_map(repo))
> > -		return 0;
> > -
> >  	odb_prepare_alternates(repo->objects);
> > -
> >  	for (source = repo->objects->sources; source; source = source->next) {
> >  		struct odb_source_files *files = odb_source_files_downcast(source);
> > -		if (load_one_loose_object_map(files->loose) < 0)
> > +		if (loose_object_map_load(files->loose) < 0)
> >  			return -1;
> 
> If this particular source in the list of sources is not backed by
> the files backend, would downcast signal the fact (e.g., by
> returning NULL) so that we can skip the next call instead?

No, the downcast will BUG in case it's not the "files" backend.

> Or would the next step in refactoring be to define "load object map"
> method that is generic to odb_source so that this part does not have
> to do any of these and instead simply do
> 
> 	for (source = ...) {
> 		if (odb_source_object_map_load(source))
>                 	return -1;
>         }
> 
> or something?

This patch series is rather moving into the direction of making the
object map an internal implementation detail. Ideally, callers shouldn't
even have to be aware that such an object map exists. And by making the
loose object source load it automatically we get closer to that state.

There's only one more caller that calls `repo_read_loose_object_map()`
directly, in "object-file-convert.c", and that caller only calls it to
reload the map in case a concurrent process may have rewritten it. If we
make the backends handle this via `odb_source_prepare(FLUSH_CACHES)`
then we could also get rid of that caller.

Patrick
