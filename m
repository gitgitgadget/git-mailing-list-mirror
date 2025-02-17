Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170E1494A8
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807255; cv=none; b=N9kPf2sEEZ0yofyc0ukUG5N/J2KnCH5rqLvA8Zrp+y+ETb1fpEsPj85f9tkUoXad54VlkOZ398MLCEhKVdJnVX0rlh3BVWJnSnXLt3UDiotskYWMNTwq9EH6L/qWtZF5Fc0UzT6ozKa1A/fIZ5u2wiAGD3p4UCS8YOHpTvOhjTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807255; c=relaxed/simple;
	bh=SaP6lC7ns1g2gI1bZwVbv4efw77oXcAS6/tNDIOw1nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW/vnMfw+hKNF1vxZLehCDwdj3MJoRlJXsmtwAk3XHVN6oER5p9dYvgm6z1ZM6AnOSAoWkIg3zoOswbasQfpPJUqKKhN3FzWXEy6Cd+UtWJntTE+G+0pv9rZudXNilkvKZW3kRar4MWwnp7On6iR1AHiU7RSyqOEVXVPXTUZcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HHvsflhs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZV7CnqYc; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HHvsflhs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZV7CnqYc"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1107B1140181;
	Mon, 17 Feb 2025 10:47:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 17 Feb 2025 10:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807250;
	 x=1739893650; bh=AkNoY3+oRD5eZxHHe5+TOxOvEklZyCbWe+v2b5fv4MQ=; b=
	HHvsflhsHLDsZBmwCpmgQS8JZbR38u8NsvOE+JxOqwyp08wcWjUYzVvqAnQeJmnT
	oa07VWJeGHxayIn5QeUI0D2NSiw0uG+Z0Qv49rBEOBcc8Ev8SSmbexHpGH5GGzD6
	mRCMv+cQhfgf/NRFtnzcOilMdLc8y+lhOKPqemNBuI/1XZ2HM/vdQe8Lx9J/MHy3
	eDg88BREWyLzA1Lz5UsA4pcEbdQeGNqw6p5B3e83rNWUcsuUoRT/PXAW3whJXKXG
	3tU3T4Ehiu0pMwli/r2+TxtPD33GGXBItAlI+wfoNBIwogPHEMHMO4uDQcHIaNmM
	CVnd9BMqYgdZJhiHq6yRng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807250; x=
	1739893650; bh=AkNoY3+oRD5eZxHHe5+TOxOvEklZyCbWe+v2b5fv4MQ=; b=Z
	V7CnqYcUZIYv6biUWIRsMT0/CJwzcYsjlVRwX6u6nS9/pkvr6tajPdh4z/2vj1xp
	9qaz8L05zNOoIwMprLcpVjhzE84czpRDa+2/BSFOOoW2yi1BO4ZyiktC1qp8Omqw
	ZhQeRzmlHzqDArE8bSfKhyRxExjQRCb/CMWtz5qcYgUId2zYQ8NKfeMVPDtITM9d
	SbVtOAon8paCAKJ7Wthm5kUYTLVARxOb1y247ScLMwU/Y8ScA9NmhQDlPFYI5lC7
	nqFIb0Ars6dsv0/FagNAUtts+g6S4wrVPtcrg8pCd9Kq1W9c8eiop7LB1L3Ckjca
	MtpbOEaskdqoVlu2rs1pQ==
X-ME-Sender: <xms:ElqzZ_goc0Bf3clZ-cjXrqMsxj2WWmtWVey4UeCx5xN8TyUQ9d-lAQ>
    <xme:ElqzZ8BdbQRbX7NmlCaiDLnIxwZ85sUpCVH-AthlM7vxqM-BvZK0NtrVWOnVwWhVh
    k6Eum7lZxAEqrgYxQ>
X-ME-Received: <xmr:ElqzZ_HCKwnbheY_PHUTVg65o_AvCxoE3w9xZYYaR7ojMnWcEW7OFO37GbkRoBsH1vv7n65inQfmGIcqmhb5QZWULAwqMyXKrqg9MQIRCRwnhFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidr
    ohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhs
    thhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrg
    hikeeisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ElqzZ8Ty1TE9GsxPQnKhxFpMcMQocPtBeZi_vQMkbOTREvzEejV_6A>
    <xmx:ElqzZ8w5KHGG0CmI5mwqR2AWFW_Dqx4VVhVAM6tX3_EnYXvG0FwpRg>
    <xmx:ElqzZy6ABAPHANCe32RM0XleQrihpYrvmT6jnLh4hk2vN2U75368Yw>
    <xmx:ElqzZxx5GdVaF5BYjQSRIMrl9G6Xlysd8SxYBwsgMwFcR3wT7wfvlg>
    <xmx:ElqzZzm8XH_P1LojTbOba0cHPAi_PzCkfOPUA6UOBb2QaXt-3HVtFHY4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:47:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59ba5043 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:47:27 +0000 (UTC)
Date: Mon, 17 Feb 2025 16:47:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org,
	christian.couder@gmail.com, johncai86@gmail.com,
	shejialuo@gmail.com
Subject: Re: [PATCH 1/7] builtin/verify-tag: stop using `the_repository`
Message-ID: <Z7NaDvnSvwI_2ZyO@pks.im>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250214230210.1460111-2-usmanakinyemi202@gmail.com>
 <Z7LdauBUSfqvyvXv@pks.im>
 <CAPSxiM8vcH_csM21vtF11APtxfNy_QC91mfYkctaSP-8TyPmyA@mail.gmail.com>
 <Z7MN8-9rzf7h9zZi@pks.im>
 <CAPSxiM-Bm9FtvVDJ_MggPFy_hV=h-ossk4p1z=ADGbttG=w-RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM-Bm9FtvVDJ_MggPFy_hV=h-ossk4p1z=ADGbttG=w-RA@mail.gmail.com>

On Mon, Feb 17, 2025 at 04:12:06PM +0530, Usman Akinyemi wrote:
> On Mon, Feb 17, 2025 at 3:52 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, Feb 17, 2025 at 03:35:05PM +0530, Usman Akinyemi wrote:
> > > On Mon, Feb 17, 2025 at 12:25 PM Patrick Steinhardt <ps@pks.im> wrote:
> > > >
> > > > On Sat, Feb 15, 2025 at 04:27:17AM +0530, Usman Akinyemi wrote:
> > > > > @@ -35,7 +34,8 @@ int cmd_verify_tag(int argc,
> > > > >               OPT_END()
> > > > >       };
> > > > >
> > > > > -     git_config(git_default_config, NULL);
> > > > > +     if (repo)
> > > > > +             repo_config(repo, git_default_config, NULL);
> > > > >
> > > >
> > > > I recently noticed that we have `usage_with_options_if_asked()`. Should
> > > > we use that function rather than making the call to `git_config()`
> > > > conditional? Otherwise it's not obvious why we have the conditional in
> > > > the first place.
> > > Hi Patrick,
> > >
> > > I think the function is `show_usage_with_options_if_asked()`. The function
> > > is quite different from `git_config()` or the `repo_config()`.  The
> > > config function consults the configuration file for setting up config
> > > values and it uses the `repo` variable during this. While
> > > `show_usage_with_options_if_asked()` is used when the "-h" option is
> > > passed to the builtin functions to display the help string.
> > >
> > > In a case when "-h" is passed to the builtin functions which use the
> > > RUN_SETUP macro, the `repo` config will be NULL.
> > >
> > > There are some builtin commands functions that which has
> > > the`git_config()` function comes before
> > > `show_usage_with_options_if_asked()` or it's variant and some,
> > > `git_config()` comes after.
> > >
> > > For those that have `git_config()` comes after
> > > `show_usage_with_options_if_asked()` , no need for the check, since
> > > the `show_usage_with_options_if_asked()`call will exit without
> > > reaching `git_config()`. For scenario where the `git_config()` comes
> > > earlier, we have to check the `repo` to see if it is NULL, if it is
> > > NULL, we are sure this happens when the "-h" is passed to the function
> > > and we do not need to setup and configuration since
> > > `show_usage_with_options_if_asked()` will exit.
> >
> > Exactly, this is what my suggestion is. If we introduced new calls to
> > `show_usage_with_options_if_asked()` before `git_config()` we wouldn't
> > have to check for a `NULL` repository in the first place because we know
> > that we'd have already exited if there was a "-h" parameter.
> Yeah, that is true. Maybe having this as a preparatory patch could be better.
> 
> There was a previous similar patch also which has been accepted. Maybe
> this can be done after this patch series got accepted, so, I could do
> it together
> with the already accepted patch.

Yup, that'd be great indeed. Thanks!

Patrick
