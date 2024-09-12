Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA51BC089
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139828; cv=none; b=skIz1hXy19gKVQoi9NoC+CLDa1Xz4PM/SZXjyBm/zqlDAEWXLtGKL86vec9w95unc1zsLNFCNTqfM+VGbJ1vzQ/g+RrmRelYjjfdjb08Ll5bm55PqIKyw45ICHAXXyT8YeKSVPBdmbjMWCmDSDSn3S8wnagZkhY0Wmuwxuo3rgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139828; c=relaxed/simple;
	bh=69fW4DPSz0Sze+uWticeV28/ywo8P9q+poKzximUNWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFd5ZnOvEBJ3gfxr9G7aBgKSMez4q897vzD413mHoF57W/GLTeX1AlTPyRVn9NBdAPipXhJV3Kyj4IfYw00N8mGlCT+1jKZUza4Tl9UXvNpG4pZc9D4VCvsjVVL4bK/nAdWkIjymKI18h28+8mRhhn42jZU2pRAayBaXHnfjp4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BQLoNIU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1Aj6eaP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BQLoNIU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1Aj6eaP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DA181140596;
	Thu, 12 Sep 2024 07:17:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Sep 2024 07:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726139826; x=1726226226; bh=094AirS7cS
	VHGYZfxTyqKrE24iEWrPrSNg/bntMJ+4Y=; b=BQLoNIU+M6IYvvmt36GwvmY3wd
	r5RQG9KVBqVZFE06AzEfnR+lDYXHY2bUDragw9DBgUFTLfG2ADHj9USROO7aYfKv
	9x703zVezG1EyV89mA4pg7Yz6XEaMTgsg79hn3l/2QX4s95TDt0GiEcOZW0uueYp
	2zEhnmxTE/CXXhYSi1sDzmBfXEki6shB8XmzFy5keBpEv/XuMXsbBI2ZuyIcsk7k
	dem16+rUdaiJNr3jXaM0Ndi0Fuzu2Qtbq1whRpcZhBox8ogUeEvqzfaOKapQNW/E
	bIJKkGnFic+RmCy3QWbJdAEFAvxD3G4wpinyCrZ7SFxoBB5HUGWw1ohOt4lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726139826; x=1726226226; bh=094AirS7cSVHGYZfxTyqKrE24iEW
	rPrSNg/bntMJ+4Y=; b=F1Aj6eaP0oAkhwTU7+D044P2iR1/ogmFQjQ54C3t0Wvx
	KgORo/kPPU703+tFs8uOzzlxqFqOj5miUXf0LQQmkv9qP+wHfAliFoLAPmFvgp0y
	4VnLSQOHOaLyhopwZHHe+6EYnDEfjOWJQ2O/vaF0QhDuNzXig0pF9sVaqHtNjO5s
	nNKwNTsIlwLoVud2pUoWyvwYUNfVUjtJnHwQ5BBE0AEBUOXho6NowW5405hbMK0J
	XoZKvqxbcVJdOwzJLIgnXpnUzSIosPd4ARDcyWWPHrLgzw+ToUJ5CYY4mL2rSWNQ
	GwwI2AVHhjQ529n/7T8fwk21gmw3znHqaUrkPs1Kow==
X-ME-Sender: <xms:ss3iZteydR3BGEIwuqcPqAHWiRGItsowaEEKqDrRv9NS-CcTSABAWQ>
    <xme:ss3iZrNr9OHMVKv-ebf_5z29BSC9gWgvUT983mBuIc5MZPaCy_IotHA-cDlFgKI1X
    RuVy3eKr6GYSj26jA>
X-ME-Received: <xmr:ss3iZmgFOUhT9ijq-osTE0n0dAqW1Ky_Y0Mhu1MGJb7lMscLrn3pK4y-VZR-7VppB24u_NhfAwLLlqfL-4CFo6G7EnOu04cF-jTzMhgwryoO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:ss3iZm8p5mucySaUrTRSWRD76xBg5BWo5wauS0ELEso7b4E5ZX05EA>
    <xmx:ss3iZpsi0Wppn005W4yrot0cz8MDLQElUemydpSqkkZs-ZjtvB5-2A>
    <xmx:ss3iZlGa7THVILTV39C2mTNJC1XJyIgL1icgl9Gq_CgnhXtACIL5ZA>
    <xmx:ss3iZgMMGa7Ay1Ak06itSQe1QHQYe4hqXefnt5bN7w72kTKMG_nsSQ>
    <xmx:ss3iZjL4EO6p8gIzRrf_vz5eBwoiIEH2vGlNVzyu_iQ79aHoY_whQ_Yv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:17:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4871a39b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:16:56 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:17:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/21] config: document `read_early_config()` and
 `read_very_early_config()`
Message-ID: <ZuLNsC7akB64OPpa@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <ec4804a99bf70f9a97d1faea60bd55aaa97d1b80.1725008898.git.ps@pks.im>
 <q4bmhi7dhadwhhuijatrpiayi7zjhrlgshcgucfp2s7uiczkth@o4jtzzqv2dmt>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q4bmhi7dhadwhhuijatrpiayi7zjhrlgshcgucfp2s7uiczkth@o4jtzzqv2dmt>

On Wed, Sep 11, 2024 at 10:59:42AM -0500, Justin Tobler wrote:
> On 24/08/30 11:09AM, Patrick Steinhardt wrote:
> > It's not clear what `read_early_config()` and `read_very_early_config()`
> > do differently compared to `repo_read_config()` from just looking at
> > their names. Document both of these in the header file to clarify their
> > intent.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  config.c |  4 ----
> >  config.h | 11 +++++++++++
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/config.c b/config.c
> > index 0b87f0f9050..a8357ea9544 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -2234,10 +2234,6 @@ void read_early_config(config_fn_t cb, void *data)
> >  	strbuf_release(&gitdir);
> >  }
> >  
> > -/*
> > - * Read config but only enumerate system and global settings.
> > - * Omit any repo-local, worktree-local, or command-line settings.
> > - */
> >  void read_very_early_config(config_fn_t cb, void *data)
> >  {
> >  	struct config_options opts = { 0 };
> > diff --git a/config.h b/config.h
> > index d0497157c52..f5fa833cb98 100644
> > --- a/config.h
> > +++ b/config.h
> > @@ -192,7 +192,18 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
> >  void git_config_push_parameter(const char *text);
> >  void git_config_push_env(const char *spec);
> >  int git_config_from_parameters(config_fn_t fn, void *data);
> > +
> > +/*
> > + * Read config when the Git directory has not yet been set up. In case
> > + * `the_repository` has not yet been set up, try to discover the Git
> > + * directory to read the configuration from.
> > + */
> >  void read_early_config(config_fn_t cb, void *data);
> 
> To restate in my own words, `read_early_config()` allows a config to be
> read before `the_repository` is setup by discovering the git dir itself.
> Out of curiousity, what prevents us from just ensuring `the_repository`
> is properly setup first?

This function is mostly called when we may or may not have a repository.
This is for example important for alias handling: we want aliases to
work when outside a repository, and they are not yet set up at the point
in time where we need to resolve such an alias. If you happen to be in a
repository, you also want to make its aliases available. If you aren't,
you only want to make aliases in your global and system configuration
available.

> > +
> > +/*
> > + * Read config but only enumerate system and global settings.
> > + * Omit any repo-local, worktree-local, or command-line settings.
> > + */
> >  void read_very_early_config(config_fn_t cb, void *data);
> 
> Here `read_very_early_config()` looks like it only cares about system
> and global configuration so it doesn't require a git dir or
> `the_repository` to be set up. Makes sense.
> 
> Not really related to this change, but it would be nice if the name of
> the function itself was more descript. Something like
> `config_read_system_and_global()`.
> 
> Overall, I find these new comments to be very helpful. Thanks! :)

Agreed, the names aren't great. But as you say, I'd rather not fix them
as part of this patch series.

Patrick
