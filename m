Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D4311C36
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932899; cv=none; b=pn5etw1XBY4pKzU0yfxjQKbRqZ6FgT5+YQW0OmOvmjVqWFSC5wiKAxw70VWILv5sPmkK3NKif7x1wvKquzB8fZWmTMM+kbMobsSUxkNchBHSPwpsPH40MkDW3HGiU8DPxqcYtVsyiYFMVEQ2XUtViEiEOY3U5UATyar1xd5XeaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932899; c=relaxed/simple;
	bh=7T2C52nEYada3+FWF+CIPBasDm5MhN0doV/ieoWbTcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL7cwpzU9PLPrcrgdAQP/vVKIbzb+cBWbSyMyo28dai2oX6j8FywvsM3+A7AM6o/aOCoWpxQLulPWuOKPyJUGWUc9rRkB7sOooJp83ZEuqHKvWP93I1UD7m6icP/AQHbgDio4/6+RAfVeegVyoHuvTqpl7DYbmDXu3TcKGsOUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b1CBPJH+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M0F1KTy7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b1CBPJH+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M0F1KTy7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D4267A00AD;
	Wed,  9 Sep 2026 01:48:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 01:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788932896; x=1789019296; bh=8I0c7p3aWm
	9mlMYqZDugj9SiWNIZeOH8YaqLRzE6pVk=; b=b1CBPJH+tjh02UeZi63pOoelpp
	tKqq3ZV0lBI2Rnf71QUghrDnjMjGs4e1wqAzHnhIwmNOm9AwOzGAjk7snXDN6VyB
	713OWkuRHkSlCLHMHUE4FfvajZakW7KKIEk3BS7NMaV2NUH/ZnZTOOXj8xeIcdz8
	s2tfh5W4EJlnw6n9JMaRmZn4PMj/TkIprQbiGMeg+brXRdLxquNArK3wnIqipVxS
	wjNY4lYSHjMLbGyTHGwA5Qx4SVB+K0JfeFw+CHhphwyUNs+oyxM2DcJrkohmBYZR
	0+/qKnMc5rzKtVEPTxHDPQ8x9Helliw8Ioh6lzx0PfPUplMJokDi0TGuJ2Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788932896; x=1789019296; bh=8I0c7p3aWm9mlMYqZDugj9SiWNIZeOH8Yaq
	LRzE6pVk=; b=M0F1KTy7B355zhteBPnV5wSI9FKQT0kK72XQcCly8AlOh41cQ0M
	7DKcH0waRy/NqXduilX20svjxM1J9zGyVd9PLsQ3NlQc12rX56wHeJ6EJdHrxbnw
	u8TO0kS3bQUguvLhNOaA9GScjMei1F0ZDWCEsgsi8AWc1UIpyTXM7DirnW3I7vIr
	ijYb/IK23shXedqSJPIgsWtnjsSGTyXs8CREjZBKLLUKyAWRaBf0lHCDWClqO+R0
	ofwNlswMNEG9ag3UpdchfdP4yXJwVCQmgcgKoApaJwDBOyrICVrDJpleS7uYSZgd
	ffnpnrTwBQYGnRQGf9AN3H4Dnm9QkXqKdtA==
X-ME-Sender: <xms:H_OgahrogSg4FxsPnnKnzsGLGz58c0ovDvXs4HynxHjdIj-7S_ALUA>
    <xme:H_Ogaqrv_dxo4C8FwYOeGPddhWnlmnq9f-BpC8Cu7UMh8pLB-KTneumwJPO3wffmy
    pHFH75B0l5-ebOXkQbidw8yeG5pbVtZC1VdB0gcGik5WVAJDkmE0AQ>
X-ME-Received: <xmr:H_OgajPVEwiw8wNr-i93p1SPBxB6170xlCQhlIKeuES2EH7cXphpo2mhwkKw1PBfUMOAhA>
X-ME-Proxy-Cause: dmFkZTFdCvnPPPwDDZZtsv05kL9m92pVTIHcnEE+XX3zU++0chaC1VHt05lcdyz+bNZwyX
    EjwzWULGlbZtWXldqAI8bXe8e4I7g7OwH4gw4cirmJBhPbr43EwwvJoPnusXxxlP5gpIN4
    YGuQ3ri+6pjOnkNlUzgCCmPRWeIW3ue2szaDEzhRR0UEcMSzq0wkdvqWcO0MxhhtMJgMqE
    zhc2VwJPxdKORC3oyCxF/SlA79yEkpz9AagPRsp4os7zp9WGF+E6ttMX9SzAnRqMBl1Ewm
    dHfGwbQrr5lZ9r93uRzR9++OEV9C7dey9g6HqjYu74RHeLQ3ZX4cSyv6deBFRhplYRf+kd
    34UTTJYtdeeXTGRnl/s9aijWQDW3Nbq2nF30S+i3S58a9cIPb6S4mFmX0ndY+l+B5UtK8Q
    aR86M2dNjuO0enS7WbdhqhLyMKJtbNGnav9LC8NiPaavcLzovRXBmL89u/VhDLZgudY0NX
    LPkqzxctsBG8mGQYuiwtAfcKdFgcUWaPYdjvRXJg+Q/+W0hxG7V6CxweYeOTlBfoZajs+5
    /8xUUcfA43QRG4MPeLKhBTw6H4tn3iBirXVz2vkKG4IJHVSOCZujbwVb+mxd6ll1Ajo6Nt
    aC+fZKqvxWZj5+6OlLaQpQ6jBKgNJKXQaixbfq9Sad/ZGs0pMaTLD5exg4kw
X-ME-Proxy: <xmx:H_OgarymIeBxZoPQHhBXV-Gwe7eGJDLWIHkLp7grJ_iADoiFxvrllg>
    <xmx:H_OgassbshREyzEaP2Vy05jC46fLZLPz-Y7na66us86TcQ1Z_U_ehw>
    <xmx:H_Ogak6FiMy4UIBkhAYZaWD3tl3OxU7t1p6GnwQrVOSKA8Wp21aoZw>
    <xmx:H_OgarTpt80PWXrc59PhX3O5RLT0VX6AeHmlzFeA6LEV3p6Gkartjw>
    <xmx:IPOgakPX2idaIVxEjueSWoSz2EUrD0vcrL6WMdv3hQohU2N1GY6GOdI5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:48:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2b183ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:48:12 +0000 (UTC)
Date: Wed, 9 Sep 2026 07:48:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] setup: split up concerns of `init_db()`
Message-ID: <aqDzGaYN-RmXgPUh@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
 <20260907-pks-odb-write-alternates-at-creation-time-v3-1-735d0b5b3e00@pks.im>
 <aqCE801dAwP7pAU5@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqCE801dAwP7pAU5@denethor>

On Tue, Sep 08, 2026 at 05:12:21PM -0500, Justin Tobler wrote:
> On 26/09/07 10:25AM, Patrick Steinhardt wrote:
> > diff --git a/setup.h b/setup.h
> > index 763fd384e8..c4aa464caa 100644
> > --- a/setup.h
> > +++ b/setup.h
> > @@ -256,23 +256,21 @@ int apply_repository_format(struct repository *repo,
> >  
> >  const char *get_template_dir(const char *option_template);
> >  
> > -#define INIT_DB_QUIET      (1 << 0)
> > -#define INIT_DB_EXIST_OK   (1 << 1)
> > -#define INIT_DB_SKIP_REFDB (1 << 2)
> > -
> > -int init_db(struct repository *repo,
> > -	    const char *git_dir,
> > -	    const char *real_git_dir,
> > -	    const char *worktree,
> > -	    const char *template_dir, int hash_algo,
> > -	    enum ref_storage_format ref_storage_format,
> > -	    const char *initial_branch, int init_shared_repository,
> > -	    unsigned int flags);
> > +void create_repository(struct repository *repo,
> > +		       const char *git_dir,
> > +		       const char *real_git_dir,
> > +		       const char *worktree,
> > +		       const char *template_dir,
> > +		       int hash_algo,
> > +		       enum ref_storage_format ref_storage_format,
> > +		       int init_shared_repository,
> > +		       int *reinit_ok);
> 
> While we are here, it might be nice to document these functions a little
> bit. The NULL/non-NULL behavior of `reinit_ok` may not be entirely
> obvious to future readers.
> 
> >  void initialize_repository_version(struct repository *repo,
> >  				   int hash_algo,
> >  				   enum ref_storage_format ref_storage_format,
> >  				   int reinit);
> >  void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
> > +void create_object_database(struct repository *repo);
> 
> It might also be nice to document these functions to explain exactly
> what we are "creating".

Yeah, fair. Will add some comments here.

Patrick
