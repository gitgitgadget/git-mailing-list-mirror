Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16D213224
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787772; cv=none; b=HuEOSTMHR3J13k4AlN7M5MvGSHj9LuOmHdfQdglFZBAIDkQs44upD9oUpO6+bmO6tF77BdnsnfI41/6dzyoAItameYkyjJMM8+46m64oohVkJ5Y+4d+uftKfkyevB8GC2WrWQAZpqTAMmA005umYJ8+iLoYX6K3RPt5+xkIVWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787772; c=relaxed/simple;
	bh=BXnO8vIgRpZ3kFBwYaaCY0Fa1Lt1egcgjQsdFqSa9b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fez1jFSLFXTZuzhwgS77lyJ5/AXETB0upj2HpieIZMxNixGTzKYmXd6al6xFQ/mq1Go2bV6AQmjr5l8OwBOPdQFBaK0whQu/QZhIQ2+qTtILQBreQQxK/z10bfOuIDSpAl9l8MmKCYYMsIaon26ZUPcY7jLgC/a4au+lvNH3ayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iqeWkNAJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xfnx1M/z; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iqeWkNAJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xfnx1M/z"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A9043114014E;
	Mon, 17 Feb 2025 05:22:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 17 Feb 2025 05:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739787768;
	 x=1739874168; bh=JRBwhF2RHJoV3gWAbtf/+pQUm69JHs4ZKQORanTriwk=; b=
	iqeWkNAJoANvZ0OXX99uE4goGmjwuwyemc1CQzvpxUMo7dRGW5btkOOjl1IKrkR0
	SZaPBi6+QbnEDLhSLn7FQYkZeBRWcvcd9Wq2qeq47ShpQLP9xSwhcTddknHnKW1O
	x0HnR96jhwHrsbT9l5vfHzNMT/0h/Lvs+Q7QhCwU2WgCKtky6LcIKyKDk6yd9aou
	m1GAo0KhqJoG4aBdaPdvbWUL3NAgbWo3zLcJAks258XCnuzX9irEG1R2YSzYLk6E
	WzraR9QC2Hz+XJe6Uvg9Pzoor77JxIjPGqXo6l6nyw3tNoRmEhE2T4QcxT/LQb1s
	IbD6oASOGWeM+Km1juDvTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739787768; x=
	1739874168; bh=JRBwhF2RHJoV3gWAbtf/+pQUm69JHs4ZKQORanTriwk=; b=x
	fnx1M/zdrdJgeVaP4tSyr81+V5Sv2lm62ILSp6fZlJjssFap2Fh/zQZqytHxacex
	Yg9mwVxhyC4Eo+xgx9KQfhir7YEEQSkLnfNgFcNoD+iTPRv8H+EIBBehapTCW/RI
	nKvb/eFY0yp87QrDWeaEl4DxFW+aoVwcaPsFa/3HOKbw9aBrlwFWmNbAU03ZEE25
	jujH/1jIlTHRn7htaiaPYfNZCuNXqdZ/YS31l3VFl2KegR+LL0+ZuKUdX1F1F/Au
	T72woyYxdA9ABYYGsoBw+XrZ3IDrIITUskvPToZxSQLdBISPgPpeH8SU/kv9GXNT
	HX+D/IulBOZIPtiT3vAuw==
X-ME-Sender: <xms:-A2zZ7QW81ZJhW2NDhCAS1NgCguj66zQfsZPrItdTq6ZVB5GunaOjw>
    <xme:-A2zZ8x-zLkimDkf79Vn0gCT3tyaGuxDOwNT2uxKriOTgYzWmgr42wZu7tamyPx0i
    Wu4_zWLoLMftl5W8A>
X-ME-Received: <xmr:-A2zZw2dbZmfJUxPwxmoa-d9tXcFwhxueZ7mSsGR5VXrpIOBibKuEdtlfSDetAlQD88-rxcfQqMz1wtLozoj-aZPqGVsyhlNVQcblx96fb5dMgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdp
    rhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlse
    htuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:-A2zZ7D4pCEI-6iM0XeuVH98c1mr051LTBkBECV1tUSktCwI00XJ6g>
    <xmx:-A2zZ0jHL6lin4mOrTuP-N-reeB6MXeaSZjnsqimPeHwLLtC0iNzlg>
    <xmx:-A2zZ_olqZ11Dv2YJ4Goounlcuyt51n0DuQ9V4BeJdMYF22eK1Kr8Q>
    <xmx:-A2zZ_hYOVq9fgob2VZy8Nxjk0i-xtgt8C9y3Mtj7QpjhRTuYGZU3g>
    <xmx:-A2zZ_WQ426IG-cMK5OqsM7G3YNhofgR-1Vt8GZ8B8bo-pDZLQgMRodk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 05:22:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f75e86fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 10:22:44 +0000 (UTC)
Date: Mon, 17 Feb 2025 11:22:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org,
	christian.couder@gmail.com, johncai86@gmail.com,
	shejialuo@gmail.com
Subject: Re: [PATCH 1/7] builtin/verify-tag: stop using `the_repository`
Message-ID: <Z7MN8-9rzf7h9zZi@pks.im>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250214230210.1460111-2-usmanakinyemi202@gmail.com>
 <Z7LdauBUSfqvyvXv@pks.im>
 <CAPSxiM8vcH_csM21vtF11APtxfNy_QC91mfYkctaSP-8TyPmyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM8vcH_csM21vtF11APtxfNy_QC91mfYkctaSP-8TyPmyA@mail.gmail.com>

On Mon, Feb 17, 2025 at 03:35:05PM +0530, Usman Akinyemi wrote:
> On Mon, Feb 17, 2025 at 12:25 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Sat, Feb 15, 2025 at 04:27:17AM +0530, Usman Akinyemi wrote:
> > > @@ -35,7 +34,8 @@ int cmd_verify_tag(int argc,
> > >               OPT_END()
> > >       };
> > >
> > > -     git_config(git_default_config, NULL);
> > > +     if (repo)
> > > +             repo_config(repo, git_default_config, NULL);
> > >
> >
> > I recently noticed that we have `usage_with_options_if_asked()`. Should
> > we use that function rather than making the call to `git_config()`
> > conditional? Otherwise it's not obvious why we have the conditional in
> > the first place.
> Hi Patrick,
> 
> I think the function is `show_usage_with_options_if_asked()`. The function
> is quite different from `git_config()` or the `repo_config()`.  The
> config function consults the configuration file for setting up config
> values and it uses the `repo` variable during this. While
> `show_usage_with_options_if_asked()` is used when the "-h" option is
> passed to the builtin functions to display the help string.
> 
> In a case when "-h" is passed to the builtin functions which use the
> RUN_SETUP macro, the `repo` config will be NULL.
> 
> There are some builtin commands functions that which has
> the`git_config()` function comes before
> `show_usage_with_options_if_asked()` or it's variant and some,
> `git_config()` comes after.
> 
> For those that have `git_config()` comes after
> `show_usage_with_options_if_asked()` , no need for the check, since
> the `show_usage_with_options_if_asked()`call will exit without
> reaching `git_config()`. For scenario where the `git_config()` comes
> earlier, we have to check the `repo` to see if it is NULL, if it is
> NULL, we are sure this happens when the "-h" is passed to the function
> and we do not need to setup and configuration since
> `show_usage_with_options_if_asked()` will exit.

Exactly, this is what my suggestion is. If we introduced new calls to
`show_usage_with_options_if_asked()` before `git_config()` we wouldn't
have to check for a `NULL` repository in the first place because we know
that we'd have already exited if there was a "-h" parameter.

Patrick
