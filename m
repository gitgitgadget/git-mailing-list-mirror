Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBFB3B42F1
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293615; cv=none; b=ZfmJgSsIMh47+tQ5zpxFKfV6fUCJ/EPdQuJvUQv2nUKyF59D25eS7su2WxwgUKDFrMKbL0qZLa/n7GCHDsE5Hw+wRVHyEr91IBmwo/ezOADqN/BAzFAQjs/MmJPkD2RoWvhPFOKZlWOcPQGmEelkYP+aC50uc98A+wyvK8RSNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293615; c=relaxed/simple;
	bh=vngR6AOIyVXvODJdkQOO2X6pwz+/LhQhXAaewpLWTDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kObY56e7927WmStwijmiOqjbn8K/7LtW1kjrLofcVgyG3QTqnUp6vbVgJxJejkXupx0xWAkiou5OHYo5QiF7jvjtMMuJC1/kpDT1zsfMLmzZKrD/CCAQGaq+/CNm7O2N7pOj/uoM0Tlp382E7VAWRReRABzPa2rHwcAykXejEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=brFoATIp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eyj9esdB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="brFoATIp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eyj9esdB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3380E1D00120;
	Wed, 24 Jun 2026 05:33:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 05:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782293605; x=1782380005; bh=e+NPvUEepC
	gwZ3BKy/8yn7WCpBMprpSJ4ZdAEWHn3QU=; b=brFoATIp1ejVWKN7UfEP2GWtAo
	crCYDPcfU7P4WdUAxUc4uCVHvue6BDkPVpsaWWRI7dzwZV80ArHGJF3mQ4l0S0uj
	GOti5c1oorj53JM81svP5YZRjvwx3kROJv/nXI+sUcGBeX2wXDIwmth4LbuVdhlj
	64e7u19T9VZByEqb1eyKn/VdhzDMC9ofywIOKUVZ9VukEhB73IGhDsdmeQE6hHKO
	OX2Mbp34y/ydlSE6qyeUAsXJfpKrOOSbsB7C+bwGD+gFnzqt/MvQHxh0diUhsuJS
	86002FLZbNHQVFLoNViIiiIsmhKVuB08g26RNW8HfUdOuoSIHTH9NHDk0CIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782293605; x=1782380005; bh=e+NPvUEepCgwZ3BKy/8yn7WCpBMprpSJ4Zd
	AEWHn3QU=; b=eyj9esdBZH5SyrIWxn5iTndYhCMseZNImJ1jLHB0PgAjb3g410C
	sJneJHbXwyfuN+hRJ1kPww4QQyaK2jRgFptJ1S1M4jl8KiSxyiQ+BIfDq7bsvU1b
	fm0TWsLpKY9LyFGkCsHXr/LPF4NbcKu+k+nq06N3+d1hRAOi4ztS/GFIl8Tv2tod
	sc5fZoBh1AglsJANMtTwTkdUBVBwyMRpLMNt1C7Oj5D0cRJ81AmlA9Ji/opoP6aW
	4xtB3vGHW13f+so29EWjdDJ56eWC4naHi9fkB4lXy8Sum2oqq+2UTDIVP+zWY9om
	f8nOoI6jloD81Lt3h79O83+azvtc9fVHyDQ==
X-ME-Sender: <xms:ZaQ7aosiNUwqswGIKMosdB44t3lyTwhd7hQeLnLswdgA5N7Q67X36Q>
    <xme:ZaQ7arc2YGqJDQp_ei-p28MV2kUgylnDm5GYJ_Df40MnfebymRL_Y5W1yqE0sWDQ7
    2NXZutwU5RdWRmwa4aSpo--DqoumBDs_Bzd7tovjcHHlfipKMltpRc>
X-ME-Received: <xmr:ZaQ7ahasHBPHPzdRJzl2LEBlhJsFRPc0yQEk0QGM-R_gbtPkefCEw5T3RG86vHzLk2fcPQCJpIcvcXJpCkauKuDYJJJ6zBQijJo9eaAe>
X-ME-Proxy-Cause: dmFkZTEMAfSDID7iO5eHfIyYMMSV+auCd64DsdmrnN8Z+IgH/tEdOdUsRXLrXK0ETRnakr
    jwcU2QC0PeyLMSlXj/pevkPzh11DQTc1rFy06E96TCLcit3jn5IeqJ2e0Dc0eIKA41y/Pt
    GBgzGRBT871BqO5IyoMCHkI424PYWOsbt2r3v5OsQO+KtGxkAH+DilfgwaxnsowNTAfkm7
    7ZxJwGf9N0f3DrPzS8lyczHakb5gpih4FnlV7oxxvvNrUvWia68exzSfnA2wTabuSEbmX+
    QifXilWOjWntVvgFZKkpD4ovTNvFDMne/eIiLLhRflxwpEefcn9h+RK+eTksNSjDGh90RQ
    Fj4Y5zUIiRp1eFSFEghQMq153/A72vg8t54UpwN7Bc5sNcFjMhCShDFFHVcZDOQozTX6sB
    H3ZdgAN9HXFphf2TDw+kAz5Qbkw+l8K+Hw1ePSC9aYIiA0LbuBe/mld2TL/m3JBs/b/bWu
    /BAKPhWdmurQug+rWCbY72M7PqeP2vakJ8yZkhmMus5Yd4GE6RHY9Hav+lMaluJGSbhaTf
    tvemrDm0gFzGRGJITsDVPJ+feCSN6s49xV2oepPFZyN7OD0WkphXx4eqVAK2eUkgXe/PYN
    IBQruYeA4oZxzPEM7/rcJfp3Pd4vASML64lNZKVBXCzwtz2uOAzek/K+J37A
X-ME-Proxy: <xmx:ZaQ7amVS88WDBLH6jojJ_7xvR4n98oJvq38VR04aHFY81zC07dzTSQ>
    <xmx:ZaQ7arhQg1lhTir1DOL_kVkEIpyQM9qJHfYNbgHn6dl1PQH0H7Wikg>
    <xmx:ZaQ7asWZpq7HjmR1NQa4JXzHlJv4tRrl53MoTZfcv6hBDM_ki6XbjQ>
    <xmx:ZaQ7aqMpR37eX6UePuPTq2SkaQ8CTj9MR3oIofd7T2vkLIcvOjUS_Q>
    <xmx:ZaQ7akFSfdyLp4cOcFdml0Ahv7WLXsBE6A6uP4N-0tD_ry2QUwQ98uF9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 05:33:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9641e413 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 09:33:22 +0000 (UTC)
Date: Wed, 24 Jun 2026 11:33:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] connected: search promisor objects generically
Message-ID: <ajukWExVvpz8NFEc@pks.im>
References: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
 <20260622-pks-connected-generic-promisor-checks-v1-3-25eba2698202@pks.im>
 <xmqq4iiu1mrt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4iiu1mrt.fsf@gitster.g>

On Mon, Jun 22, 2026 at 10:57:10AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > -		 *
> > -		 * Before checking for promisor packs, be sure we have the
> > -		 * latest pack-files loaded into memory.
> >  		 */
> > -		odb_reprepare(the_repository->objects);
> 
> Hmph?

Oh, I think I completely misread this as `odb_alternates_prepare()`,
which is something you typically see before loops like this. By using a
helper like `odb_for_each_object_ext()` we of course wouldn't have to
call that function anymore.

But this here is of course different, as this call would also cause us
to reload packfiles and loose objects.

> >  		do {
> > -			struct packed_git *p;
> > -
> > -			repo_for_each_pack(the_repository, p) {
> > -				if (!p->pack_promisor)
> > -					continue;
> > -				if (find_pack_entry_one(oid, p))
> > -					goto promisor_pack_found;
> > +			opts.prefix = oid;
> > +
> > +			err = odb_for_each_object_ext(the_repository->objects,
> > +						      NULL, promised_object_cb,
> > +						      NULL, &opts);
> > +			if (err < 0)
> > +				break;
> > +			if (err > 0) {
> > +				err = 0;
> > +				continue;
> >  			}
> 
> So we used to manually iterate and stop when we have a matching pack
> entry, but now "stop when we find" is done by promisor_object_cb
> callback that returns 1.
> 
> What is the reason why we no longer odb_(re)prepare() upfront before
> going into the loop?  Would it make us miss a newly added promisor
> packs?  We will fall back to rev-list for correctness, so it may not
> matter, though.

So yes, this is a bug.

Thanks!

Patrick
