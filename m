Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378BF3C81B6
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553323; cv=none; b=hWrdKYgoAKq72AqADgxhPB4uM6afEd/nNFMw4NfUorbqnlDlVbxn2UH86ZGwzMyA5Vmj9/vAqCNfR+R6UCKa8JL3KFOWU6keeIRP9sl7ScpopMMMKntft4zj8P4EMhpyibOPN/8VN9tUDhl8yLtefyrkMKF5hFT7NtZOUGKee58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553323; c=relaxed/simple;
	bh=E4hm4imPAxumbZKSKbAbPsP56ZHUhpGHvWs2cY6ldoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsWgvuKHlSjINdhDCqrZZ2LY9+UyNwumiN9/bwwD/uKxaZm4fkZ/y+1LanPKmfRPwmuagnYbVF0YxkFfqxp6bffv1WZN9CgVJm/VG+QjJnx0n+8xatjXeCvh9Mu8gwMJn6AhtdPT99IhdojSRtHcEnwfVsQ8eP7Xe4CN7MPfnMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nnVwK4HA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UsAN5IC4; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nnVwK4HA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UsAN5IC4"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 48BB3EC00DA;
	Thu,  4 Jun 2026 02:08:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 04 Jun 2026 02:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780553320; x=1780639720; bh=QWaMrYbclF
	UscuQ6cwqnlUIqgWta2lK78ttbpx8AUVA=; b=nnVwK4HApZHvtct92OP336oYxw
	t6C3ngtodqwqOtQRSvZtRL3kRuHXeLKmoYaNoZ8Or8pBEgvEXS+uifaYefkUm5eA
	t6AmuiqYI1W5m4RnL6rdcvPj8gMlYp0tol5B4qmMnNSArLIw3nqyEEsyJ7ZDgZMv
	UAoaQjHezwlBYKZkwgl8AEcg3s+Wj/GyohSJqkIkJ+Cb5j8vyVRe/aG4lOECWyCF
	fsrM7wlyHZQzOHsXDqwy5yoKpiA8qhmR/dJrjdRl05z+rZwtnZ9R+nbHX4YebuXo
	H3t+/pUnGGGhF6fuOBEJWTF3FkvIoQRgs+PA+wJ5GlSMJySr5LWF//Afjo7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780553320; x=1780639720; bh=QWaMrYbclFUscuQ6cwqnlUIqgWta2lK78tt
	bpx8AUVA=; b=UsAN5IC4Vpoz8VQsIz2HmXySXKmniVFhWKD5+P0LKmbdBujaBZw
	Lv7tx8exby4xh7ZD7QSuiBJJSH9surJhriHH5BjO9HweBWgE0gzLO/vdYv6Zu+Cd
	uiBmxbdBps6NM08lvovZDztr9kXqSyn/004UxVNrH9Pb9pZjnMUc/1ZsZBrURT4p
	vB+8e1AeHGNFyF17p0RqTuStCNoixoP489ZZc0R++c16blhlWHGjWCD+OO3WPJ1j
	2+tVSCl+Xam4K27l2Sc6Top2tllbHJfiI1zc3dv7HuINuJA/SwfG+QWgkaaKFBx8
	p22FCNJU+4rT1B/JEv3+TNoopIdL+j1rfLQ==
X-ME-Sender: <xms:aBYhavp8sqR9-E3yY9gzo_b_Do1MEu7Lzhnlc4eiJCAEqRA_B9Ax2A>
    <xme:aBYhagqT7uGQBXXtT-HW--b_5ie7sxjD7gI0mT8Zzh0oh34-4gZK6enIgRedwsf1F
    bGujhMt2IF6VQlNOFFEtZlgu8JO_d4KqCa4f6Wa0BVXkRwCjp-A>
X-ME-Received: <xmr:aBYhahOl0TETFxcTL6kxQX1M3i8xkvu9IpmKobnRRC_zgQK79qlsEPeLSstYXtAui7LE_zhu3cQSQqPm9IbQSGoWFm4v4IWnyap-x5MsUqA>
X-ME-Proxy-Cause: dmFkZTEG5O1Ig8a25MsMeyCVGG0EMh3QAYq/eAFTv9iCEU2piC5DJIpW+h5/KrOiHaZ9PY
    OulqVCVMxstih3CLqyyajL/rBLl+YPsknYXL3vSkHc83bwN/xhwXek2Rtia1KQ2IkCXJph
    4BcnYVfE2kf/jJrDyGYMtgdwtCx3L0RMGrQqLF4ossO3C/pXqayIGOzwTUKc0JzV9CiIEe
    up6rd7eAsHn2Gc3jPmKsb6DMRHX1iHD0jgW97MKhu9MVFBgV+7qTajHTmNHF7nhIY6Y71g
    atYQzQOYDJdPLs8mhlzZQm6iZaiJLeMDrfKlglHb83P/uFGrMEOzbvYY5nJnMJkLEXLpDx
    d+QWRS6s5l7SLHO61iTYYHyJ8xIm35imxaAnX/9ev+zHfyYPwZttLJrI70yXUL12oSIdZD
    s3hZPrclsLyXFIy/4Ub45Mw+6npqQCmXjlT1ZMxuIxzakKZqtnGzva7wh71WOUMpfRsD30
    l3yK3ayD1fitNKnzNGBYpg6tBprW9ud7ryDhek6lR3Fk9VsUFDZAcJ9SSDR3wVFuuFxjob
    aoZaBMGf+5XP3UjwuMG0LdGO0vGtLfQ3/SVwtFPIzHRBceGN7zfUYOsbas9osZGyimM+e9
    esbD61s3Ld8aq2/19RGER40XU+WpK8GpqBbBRWLUaDRI5CQfvvdgtmldyqHw
X-ME-Proxy: <xmx:aBYhahxpNhHylmedKeRcH-oZkBrYRwAf-gBy5Mi70drDcGderK-76A>
    <xmx:aBYhaqseqxEhf6MCr_Pj1YuvYf7yOwDDh7_5lxWcBscQHwK-Jaz0EA>
    <xmx:aBYhaq7-oyFpXADjRWZ_G-AgiC47muoUYZxyJnkBLRNg4zqtKxxEdg>
    <xmx:aBYhapTX9t1eiBtx7HwIU4phcdRLV46u-TY5fleGsRuZhh5ICdRrCA>
    <xmx:aBYhagvBG04khNs-g1S0hLOEaGK38mzg8RMGndZc1Qct93-o45qF-SiM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 02:08:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 312d0b01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 06:08:36 +0000 (UTC)
Date: Thu, 4 Jun 2026 08:08:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] setup: deduplicate logic to apply repository
 format
Message-ID: <aiEWYUzLHLCRfSKC@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
 <20260526-b4-pks-setup-centralize-odb-creation-v2-3-2fa5b385c13e@pks.im>
 <CAOLa=ZSnDz1+C8y7ozFDdv68vqLFk-E+FsXhAnhwbm2D6a1Fng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSnDz1+C8y7ozFDdv68vqLFk-E+FsXhAnhwbm2D6a1Fng@mail.gmail.com>

On Wed, Jun 03, 2026 at 05:43:34AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/repository.c b/repository.c
> > index db57b8308b..58a13f7c4f 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -262,8 +262,8 @@ void repo_set_worktree(struct repository *repo, const char *path)
> >  	trace2_def_repo(repo);
> >  }
> >
> > -static int read_and_verify_repository_format(struct repository_format *format,
> > -					     const char *commondir)
> > +static int read_repository_format_from_commondir(struct repository_format *format,
> > +						 const char *commondir)
> 
> Nit: The commit explicitly calls out one rename, but this one wasn't.

Fair. I'll add a sentence or two about this.

> > @@ -272,11 +272,6 @@ static int read_and_verify_repository_format(struct repository_format *format,
> >  	read_repository_format(format, sb.buf);
> >  	strbuf_reset(&sb);
> >
> > -	if (verify_repository_format(format, &sb) < 0) {
> > -		warning("%s", sb.buf);
> > -		ret = -1;
> > -	}
> > -
> 
> So we remove this, so that the callee would independently verify the
> format I assume.
> 
> Edit: seems like we call verify_repository_format() within
> apply_repository_format() and the latter is called by the callee.
> 
> >  	strbuf_release(&sb);
> >  	return ret;
> >  }

Yeah. I guess this could be explained a bit better.

> > @@ -290,6 +285,8 @@ int repo_init(struct repository *repo,
> >  	      const char *worktree)
> >  {
> >  	struct repository_format format = REPOSITORY_FORMAT_INIT;
> > +	struct strbuf err = STRBUF_INIT;
> > +
> >  	memset(repo, 0, sizeof(*repo));
> >
> >  	initialize_repository(repo);
> > @@ -297,21 +294,13 @@ int repo_init(struct repository *repo,
> >  	if (repo_init_gitdir(repo, gitdir))
> >  		goto error;
> >
> > -	if (read_and_verify_repository_format(&format, repo->commondir))
> > +	if (read_repository_format_from_commondir(&format, repo->commondir))
> >  		goto error;
> >
> > -	repo_set_hash_algo(repo, format.hash_algo);
> > -	repo_set_compat_hash_algo(repo, format.compat_hash_algo);
> > -	repo_set_ref_storage_format(repo, format.ref_storage_format,
> > -				    format.ref_storage_payload);
> > -	repo->repository_format_worktree_config = format.worktree_config;
> > -	repo->repository_format_relative_worktrees = format.relative_worktrees;
> > -	repo->repository_format_precious_objects = format.precious_objects;
> > -	repo->repository_format_submodule_path_cfg = format.submodule_path_cfg;
> > -
> > -	/* take ownership of format.partial_clone */
> 
> I see that we now do an xstrdup for format.partial_clone, meaning we
> have our own memory segment to care about. Do we have to worry about
> format.partial_clone not being free'd?

No, `clear_repository_format()` already releases the memory for us. It
also did beforehand, but there we did the dance of just moving ownership
over. So we already had to free the string before.

> > diff --git a/setup.h b/setup.h
> > index 9409326fe4..5ed92f53fa 100644
> > --- a/setup.h
> > +++ b/setup.h
> > @@ -221,6 +221,15 @@ void clear_repository_format(struct repository_format *format);
> >  int verify_repository_format(const struct repository_format *format,
> >  			     struct strbuf *err);
> >
> > +/*
> > + * Apply the given repository format to the repo. This initializes extensions
> > + * and basic data structures required for normal operation. Returns 0 on
> > + * success, a negative error code otherwise.
> > + */
> 
> Nit: perhaps we should also mention that we verify the format?

Will do.

Patrick
