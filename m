Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48A231A55
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569214; cv=none; b=qr5yY+QAzxH3c+1BfFRY4Q9mtXBOaUXAFGJQ+SXh9bkz4FgqCYst5/JHPvxUprO7HiK6ThDgtBHZ3wmjJ66yi136XAMnnZsYGKLhrOgsZSdmr+DV36TEe4HyhRihcOFVrfyVyIVihFKn8xn7wEKOGrspuurfAW37vPAar101PZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569214; c=relaxed/simple;
	bh=ikl+0kZ3OeAyfLcz5NQYQpIWxw3xjA6vxfEf2GQdHxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWip2qn3fGVejp4Peay08OqKrQSenXnrmUnEV6F9fiQDeRQy8exbIQhoU9LwRqZ2P4VZnHYHmuu9+D8BXii1wkmHMoR5DoSbrqhmFccEJ0wDWGR/0cZzdtOH1UM34voA7KX9l/MA3HOY2J0h+yzTF+ghgrC3PMx4OjyCCZpxsN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NQD/LoKP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mYFdH8H8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NQD/LoKP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYFdH8H8"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BD21EC0529;
	Tue, 15 Jul 2025 04:46:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 15 Jul 2025 04:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752569211;
	 x=1752655611; bh=YDBIdvklWkxqk56d8Hojtc9ebSeySd/2EuL/2WvGeZQ=; b=
	NQD/LoKP7DTURZb/Yc2Tcjl1d9bL6Vg1AT5+EnlZoQSQ+gkgA/k4Dy34iPG3hjEu
	rJCYo7Itpw8of4WsIw3qxCh6SeRp3FE0RQ48FquHVHzyfgB8UW3NY0D98u3HoJRN
	6RWS9lku9Ao/wNkTserEDk4cFy3LhR5nnna3AsiQOAV+47TkTwSrYziZao1ra8V8
	o15j32Sag7AnvAXz2CWNDihALOkGx1ENF//QSJbXeCjWq0praD9pXDeFGtZ0zfFV
	c/RJBY4rrYvZZhERPGavOVlh7cBsEHlp7znODRoT6KgeF7Ctk12+Evdj0RHild/2
	JQ3oWRXhsjkOBkW88Cy5UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752569211; x=
	1752655611; bh=YDBIdvklWkxqk56d8Hojtc9ebSeySd/2EuL/2WvGeZQ=; b=m
	YFdH8H8fobU1p+6tvTwf1sHd95OdZr1EUUIdzrh0QaP3/k8Hf7Gaf4Q08SqLhxOC
	kbNhNHSNu+iPUR0REdnA8t8xEUaa+R3mWZBbrqxNI/WqASUQpTSamMzrE7jYLPPg
	Bov8qJb9sU62lS0wMNyrDXOlbIC/H+kdgllIS4jmM57KysvdsdlJz1EUddxs8N2Y
	eSmQMzrwHM13tbgmNCmztb2R2uKvMpf8V5u/6p+Wch7N021tSi67Q+ivHGdV8Ovi
	B/xXrzBUjKIcrmJ0xubE6U+8QVvvF5P8ZVwAHbE1EZG4PfcZKVdXS21EsgjiZ12g
	kE/iSdch5MN+u42owHm/A==
X-ME-Sender: <xms:ehV2aIXtNKAZLmFEIAsaK6YlFSvkx5Rel0R09LroIUr6RvnHHwVFIQ>
    <xme:ehV2aIEynbPk-ssg9ARMFvQ9YrOd_Bwi7jOX47haWdbj_v4-75dqg4i9vYOWIwIlW
    rgtXnFlFYMJU62WLQ>
X-ME-Received: <xmr:ehV2aC2R26cIms_YqeD7oOyIHONR9j4J3n4lqb1d7BDsUO-3dwJVnfwipqdgV61mwdQq0DjCRaSFCP764UzecJec-1xWUVLJCtFq_FmYACiIWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:exV2aCP7fM0y-JtRFOeRua-EGNh2wFkRZ6ID9clY5p9NsH6-h8oeCg>
    <xmx:exV2aJ65GKr3lCUubE1oTQnpUYp09JzdFSvdBygzk9YFTadWq6zhHg>
    <xmx:exV2aE1ELBupShhn5bjXeDCeImi9igAJc6RovedMYDqZ5Vx17P-nSQ>
    <xmx:exV2aCyEows3GM5F5Nu15ABg05sAYNGhhIploX2NVKv7uvL86Rtsxg>
    <xmx:exV2aMh51Cq758tXFj81joSf22bYrRTCrciX1fSNFUF_bcvF-GTPJRyn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 04:46:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f43a9029 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 08:46:47 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:46:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
Message-ID: <aHYVdMii_rP5-ywa@pks.im>
References: <20250713122341.17976-1-carenas@gmail.com>
 <20250713174807.32444-1-carenas@gmail.com>
 <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org>

On Mon, Jul 14, 2025 at 09:55:27PM -0400, Eli Schwartz wrote:
> On 7/13/25 1:48 PM, Carlo Marcelo Arenas Belón wrote:
> > diff --git a/meson.build b/meson.build
> > index 7fea4a34d6..e1475be6c8 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1055,7 +1055,8 @@ else
> >    build_options_config.set('NO_ICONV', '1')
> >  endif
> >  
> > -pcre2 = dependency('libpcre2-8', required: get_option('pcre2'), default_options: ['default_library=static', 'test=false'])
> > +pcre2_feature = get_option('pcre2').disable_auto_if(host_machine.system() == 'darwin' and not get_option('macos_workaround_system_pcre2'))
> > +pcre2 = dependency('libpcre2-8', required: pcre2_feature, default_options: ['default_library=static', 'test=false'])
> >  if pcre2.found()
> >    libgit_dependencies += pcre2
> >    libgit_c_args += '-DUSE_LIBPCRE2'
> 
> 
> Instead of disable_auto_if, we should simply verify a working install.
> 
> if pcre2.found() and pcre2.type_name() != 'internal' and
> host_machine.system() == 'darwin'
>     # macOS installs a broken system package, double check
>     if not compiler.has_header('pcre2.h', dependencies: pcre2)
>         if get_option('pcre2').enabled()
>             error('broken pcre2 install found but pcre2 is required')
>         endif
>         # Replace with not-found-dependency
>         pcre2 = dependency('', required: false)
>         warning('broken pcre2 install found, disabling pcre2 feature')

Okay. So if the `pcre2` feature was explicitly enabled we error out and
abort, otherwise we print a warning and disable it. This makes a lot of
sense to me.

>     endif
> endif
> 
> if pcre2.found()
>     libgit_dependencies += pcre2
> 
> [...]
> 
> 
> Please double-check my work, that this compiler.has_header() is
> sufficient on your reproducer system to detect and disable the
> non-working feature.

I think auto-detecting such broken PCRE2 libraries is indeed the best
way forward, thanks!

> > diff --git a/meson_options.txt b/meson_options.txt
> > index e7f768df24..f63ff32556 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto',
> >    description: 'Build Git web interface. Requires Perl.')
> >  option('iconv', type: 'feature', value: 'auto',
> >    description: 'Support reencoding strings with different encodings.')
> > -option('pcre2', type: 'feature', value: 'enabled',
> > +option('pcre2', type: 'feature', value: 'auto',
> 
> 
> This part is fine. We shouldn't default-fail if it isn't found, when we
> can't expect it to be universally available.

Agreed. I guess tha only reason why I picked "enabled" here is because
we also got a wrapper in "subprojects/". But with this new workaround in
place I agree that it is sensible to switch to "auto".

Patrick
