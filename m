Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624BB33971F
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712777; cv=none; b=eDJecPPjlH12qkcZBQQNMnugYvbH2tr4RhCTa8JXsuw7rmNfxK7hDol5fe3VfWMB4Ns/zkmBb6m/xVMVvRIVEa9yaRIci9000G0V5heUMYzTogoV5gRc65+guI41u7ezuhjchQHvsEyHm8rvlD4gGZrqWvAx6Qd9q3wzd8fNdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712777; c=relaxed/simple;
	bh=m4VqYvVP1h5QeEMX/Tekp6LQ3dvBG0rgxAah64OgW1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYKLKyLEhtbITaFxnj5HTo0OKFCr0X/mPYDy3+O8I10f5MA7GJzQBYRGRZozFS00kwKJomKvmWGHjHkgJ8fKFQB7Vg2kidImqZRuD7LdVVcq2wEp7+16Ujnncdm23pstzOtfMQNu1ZRcwUg1kERtKZmsmWVWWFu7ISTiC2LynIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aqfrjVY5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LiS2a6WF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aqfrjVY5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LiS2a6WF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8380B1D001BF;
	Fri, 21 Nov 2025 03:12:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 21 Nov 2025 03:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763712774; x=1763799174; bh=BjxK9M6L3u
	EMW5nP7BUqGhcF0arYF8O+6jQhZNxkXeY=; b=aqfrjVY5NHlvtAKq2+vj3jO3/b
	M3KFH5DkN2PGgrjPRsXo69rqX8ikTkFBL+Y3qHJEvc845SG8Ci62q69LzI3QDgzT
	NSb1aPPpHbKkMFoTOlh4qm8H++gNbENaj4N8dFdYspwYtSAlkF6rT4VZ/3FNOfGG
	UrBmzrnxvKtXpGZLsfHLlwLOUDPMQjydpNNwwZ1mgN/hYyzR5cnzPo1a5CaFhhsx
	4CVz/ELWrsMajr5D+Nxhg64q1LstoAPyleLee187e8ZV54CfRK5uhbpM889NLOJg
	asjcslgzefcrvk3UxLKImzQkVLEYkDNBAwEfPCx5CnPIjzzn0kI02d2jhweQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763712774; x=1763799174; bh=BjxK9M6L3uEMW5nP7BUqGhcF0arYF8O+6jQ
	hZNxkXeY=; b=LiS2a6WF7Q7G9MlWZAgRvgEcvttZMfpRaYZeajJF45Mcwz/7E6/
	dTo3NQlWS+RDxKaa5iW2AipyqI9+43DUii3+KP6EgBzEJhnWeK5gDpblNofy+7XJ
	Cfy+Rn7JMObDgsKex1yUSlscQ9U5CansqLamU8RqJ05I/AcAzMhAgxBeNSfoNN/C
	ClLDSDqF7kwHc33rF/21HKERrzuXO0MfRgkwQ6fn9r4G+jd2YTdy7HSLzTpCyPCx
	uKPbTTkhwX67huuwn2SU6g3AyEQXCFIjFj1tfCBniAMAeEAOOmeA+mGg3prPS8mj
	AM4GdxVC/miwUbWx5QxNise5fN6PWhfEiOA==
X-ME-Sender: <xms:Bh8gae3Ublm2CTg4BgKDOuEteb53etgEWgx677XXNUjB3FCXce0eNg>
    <xme:Bh8gaXE2jVAafeoDsLXzl45-WiRaacW0QNxIEda0Ue6kTM3EWQcwOCsv_SflhUTjF
    Mu1V1wvppXckZo0FkNrNmf8JFk0ljsXJ4OjQIr9AxFZtQD9J1GtDQ>
X-ME-Received: <xmr:Bh8gaUiqfo2by55dPAr2-HYujt5N839HKv63MQW3T8r5HUXYhXlAdzLXgl5r9915-2V-4BZ5q5KkMDpnSvjePrBe_j4Iyz1mEO1ATEs38XDe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Bh8gaa95JZ4nVa16L71OMdlocAe_fUE_x5vI5Qgo-Vl1d-yVHMcXPg>
    <xmx:Bh8gaTqHYtpmWrwIIVfMxlEqfeH3ChjQdxPWwiQ4lzDjcS0Jw_MVeg>
    <xmx:Bh8gaR-bgRT_WXfvjhsh5Y0a4pG9NjRhh3OI6o94zVzxWVvz0cNNqA>
    <xmx:Bh8gafWYtepDtvPpFvDJhiCPxWwNmG0RSFt1vuBQ6dbBzmRv41PbHA>
    <xmx:Bh8gaaPdOYG2UrJVBdMqIjRgRWhro8QCI5ePXbpikkPIO7jJFKPX5KGU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 03:12:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d260c14 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 08:12:52 +0000 (UTC)
Date: Fri, 21 Nov 2025 09:12:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/13] odb: handle changing a repository's commondir
Message-ID: <aSAfAJscjYHAg3Mc@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
 <20251119-b4-pks-odb-creation-v1-12-2b2ed2612cb6@pks.im>
 <xmqq34687414.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34687414.fsf@gitster.g>

On Thu, Nov 20, 2025 at 02:06:15PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > -static void set_git_dir_1(const char *path)
> > +static void setup_git_env_internal(const char *git_dir,
> > +				   bool skip_initializing_odb)
> > +{
> 
> Hopefully we won't gain too many callers of this function, and ...
> 
> > +static void set_git_dir_1(const char *path, bool skip_initializing_odb)
> >  {
> 
> ... this function, as ...
> 
> > -	set_git_dir_1(path);
> > +	set_git_dir_1(path, true);
> > ...
> > -	set_git_dir_1(path);
> > +	set_git_dir_1(path, false);
> 
> ... it is almost impossible to tell from the call site which one is
> for initializing the ODB (hint: "true" does initialize the ODB, oh,
> no it is the other way around, or is it correct?  now everybody is
> confused).
> 
> We could do "enum { INIT_DB, NO_INIT_DB }" instead of bool and the
> calling sites would become self-describing, but as long as we won't
> have too many calling sites, the current code should be OK.

Quite frankly, the whole "setup.c" file could use a makeover. I would
claim it's almost impossible to understand the different flows we have
here, and the setup of a repository (or `the_reposiory`) is awfully
complex and non-obvious.

Some ICs in my team might tackle this in the Git 2.53 release cycle,
hopefully.

Patrick
