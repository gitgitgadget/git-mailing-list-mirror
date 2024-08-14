Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182944D8AF
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611391; cv=none; b=R1JvyVr0twNlbYUgsrfyqna3gfd1Sdg5hnEy/KRTnfhNehmu0TCt0cJs0XgzZhtkbnNzx6sroU1Sf4rFH1/qsOMI8M9SdK53okwtFiXjtXt9QB1PonUZ6N9LoiU2T1Np4URpLGrhoBzsUe0Oc8YWwlCboNhECf/lfF5UQEgnKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611391; c=relaxed/simple;
	bh=VVeVfhTmZSY4FQrZrQDt8Ls7klZq7RuPVhAMir7HO+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDPq96cMVWby8bUunFoyfkM7jGQQYjxCj9i2jHyPFDQRJRm7mb0uXFGgtoUMMgjVSOLBggApVTi1HqYgSKBi+OnvKrz8xE5Jz0nhfvkPMl2HzpAQ6TBIm8+8gnqB/wqNpV7H9pMpPkBWYD/4swPoQisjcjT6ndPvrNr558JyXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GiMKoG3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gHzW5ubj; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GiMKoG3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gHzW5ubj"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 326161151B2F;
	Wed, 14 Aug 2024 00:56:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 00:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723611389; x=1723697789; bh=itbwOvnjya
	XutMccFWX02RlCsuOiD7Sg9+OLoXG2YSo=; b=GiMKoG3ScUT/Ii1H0qEKLiC57X
	ogjeVhvMixjTfnfckPQQ+lg08lKkQRLSHRvFwUCG3JD2VATJkiY1G5t+DtuU5pdj
	U0YIRpFHJFOF7vfbFOrJcBDkVbyE0nwJ5w/xIVxPIqF6n+v0eG+CWokvoW7cGUPY
	mcvm64duUygN45FhhLHRTAmJPKQDIksjo2QWe4A+Ijcr6va5S7zZRh+8JXwmrbEg
	l612AIkNk811Tv3u72IduycixQ5hvfmTQNARn3Jl+Bgd6ajpOcGVMdS1dEg36Yaf
	pwcvAwM/XppuntrDqvpBAoRNZFMAHIjxfyiUlS1rhZL2D00fR0L43QObALwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723611389; x=1723697789; bh=itbwOvnjyaXutMccFWX02RlCsuOi
	D7Sg9+OLoXG2YSo=; b=gHzW5ubj+D8Gi8hU6hMLw8rgTHXdaIr7ZTjp0oITcBBl
	9WrCfk4XtRZKLr3LIv1oEYlH3AFt/zw2gqxwbjXlBH7/KDRhxCbLs73nBO0S4oHJ
	OSjN9jq4+cFag4wPz7rcl+pbcjSNRbkDTyu9GDvdD5x6gQjKk3LCMgvGgPFOQGu+
	2bv0jI0p/S8S0zkAHFGt+vWGjg49hOZxifxBjYxqFU6K8Q3eVPYVVJ3CKh+46Uh7
	tu2jwo/dsPAyALXY7XyxMPwf5RnWADHB6UIE5A5OG644Ik67vxb7Pmh1v2nF5UOK
	qhheaX08hrfb6s/zm5FL9Y7cNlctw+eeCXiqBE+qXw==
X-ME-Sender: <xms:_Ti8Zh9-qX3ncxGrYwWT8MCV4tKe_yc3qtTb1B6ExJ-IjLonWZVeQw>
    <xme:_Ti8ZlupBDc8fZaKdGvSC0sF_Y_HOrNGEuMorVSwS1NxoMie-U5yN3qZ07s82bc-n
    Be6T-Ou3UYBqPlPYw>
X-ME-Received: <xmr:_Ti8ZvA1aJ716beHi0yyRyBHqRErg_DD5M7e5h9LN3B7rIrbyzE6lGyeF4NErD6hMUdD2ESBfqBZMQs80owCp5mYPB3nrzPlGiee707WWq0cHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgfefueeltdfhfefgteehfffhffegieeukeevteefvefg
    udelgeegueevudfhveeknecuffhomhgrihhnpeguihhffhhophhtrdhnohenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgvshesjhgrmhgv
    shhlihhurdhiohdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_Ti8ZlcD-DD8B6QXyg42IurK5nEccRe2QDsioiDryXRYM7PTH1C-ZQ>
    <xmx:_Ti8ZmNaEW_D1IAZgrkRY_PvuiIPm-Q6mRbRl97gZ03fdO0fY0IjFA>
    <xmx:_Ti8ZnkKw4-HyqXtOkE-K39z9Rb6sByfWjE2exOLFFWLlQQEVFU7og>
    <xmx:_Ti8Zgu9nXnrTWhrZzYkajQh7drYVVuijSyWxtbhTU-8hFvS0YGilw>
    <xmx:_Ti8ZiCpfqwS62L4lQwaiWI0dhXTjZ6FKX6Rppo6FfFO9zeKqCCvQ-r->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 00:56:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d7d76666 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 04:56:08 +0000 (UTC)
Date: Wed, 14 Aug 2024 06:56:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 18/22] builtin/format-patch: fix various trivial
 memory leaks
Message-ID: <Zrw47_cAtpVZ0Inh@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
 <c048b54a2c493658b2dd256b301491a79cfa99a1.1723540931.git.ps@pks.im>
 <xmqqed6s747l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed6s747l.fsf@gitster.g>

On Tue, Aug 13, 2024 at 09:55:10AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > There are various memory leaks hit by git-format-patch(1). Basically all
> > of them are trivial, except that un-setting `diffopt.no_free` requires
> > us to unset the `diffopt.file` because we manually close it already.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/log.c           | 12 +++++++++---
> >  t/t4014-format-patch.sh |  1 +
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/log.c b/builtin/log.c
> > index a73a767606..ff997a0d0e 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -1833,6 +1833,7 @@ static struct commit *get_base_commit(const struct format_config *cfg,
> >  			}
> >  
> >  			rev[i] = merge_base->item;
> > +			free_commit_list(merge_base);
> >  		}
> >  
> >  		if (rev_nr % 2)
> 
> This is correct, but isn't merge_base leaking when there are
> multiple and we are not dying on failure?  Perhaps something along
> this line?

Yes, good catch.

> 			struct commit_list *merge_base = NULL;
> 			if (repo_get_merge_bases(the_repository,
> 						 rev[2 * i],
> 						 rev[2 * i + 1], &merge_base) < 0 ||
> 			    !merge_base || merge_base->next) {
> 				if (die_on_failure) {
> 					die(_("failed to find exact merge base"));
> 				} else {
>                  +               	free_commit_list(merge_base);
> 					free(rev);
> 					return NULL;
> 				}
> 			}
> 
> > @@ -2548,12 +2550,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >  			else
> >  				print_signature(signature, rev.diffopt.file);
> >  		}
> > -		if (output_directory)
> > +		if (output_directory) {
> >  			fclose(rev.diffopt.file);
> > +			rev.diffopt.file = NULL;
> 
> Is this a leakfix, or just a general code hygiene improvement?

Not a leak fix, but required because of the leak fix. As we now unset
`rev.diffopt.no_free`, `release_revisions()` will call `diff_free()` and
try to close the file pointer. But as we already did, it would cause a
segfault as we now try to close it twice.

Patrick
