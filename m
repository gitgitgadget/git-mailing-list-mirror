Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961D47124C
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129400; cv=none; b=DWYvhOq3rRSAPOVEJ5fq1gZugL46eF5TKGgWyYDCWvcn82TFuVEioTOFaLCPOgFTls8SW0X8sC34R+Nkyp+IZrt/8heivclNLLPNl9dLzQAPZhFoIILcFFyJy5eE8BnL/1aCWbq2QsZqPJ6Jq8YJBhyTdzPICQNke21OgCw+Y6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129400; c=relaxed/simple;
	bh=gY1yrKcIMjJIfXTVaZ1PE5JPZmGW1BliEOfZnWIurlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L67ul944SOqrKTEtzybBLljmGkRgRGUfdf9q6BS4x+GTj8/xx+zkwmru1jDUq7NwlYChWtfhJBCBxLIhCrf+Twzv9OiVHQ7uveXuCeYp40+UHR4qekzazW1uuv1+SysT8IPaK3SOSQNX0NW0l/5M3Ye9MSHikAvs2d963n7q53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vOJSvXKH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wlarpaHG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vOJSvXKH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wlarpaHG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 52410EC0282;
	Fri, 11 Sep 2026 08:23:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 11 Sep 2026 08:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789129394; x=1789215794; bh=gCNorCuE8H
	+M96dWhDTZQohk42kPzatGTt1i0vMBuwY=; b=vOJSvXKHmlIpghi3v2NbnmDSxK
	zzjYgiQqNVTFaKs7FJmA9M5BKCICTyhn4mhahchNcNvJlqp5KPL3NTL3Yb2JxVKh
	BiH0GEf5m+nTvQ9PZOzhkhP65hAKWAbNvzDnqt8Cx5gUXiukGMIBdG49V/RAbkYI
	fsyBxfIYcx/oXTy2scKtSmfvjwk4ltobqEJFWQOnP9afp4OfMLJBXTgj6UxWCUbN
	EFFtARrjhSI8m4ZkfxdscVwj+86/XLRlczd7J1wG+MkmUnE6ws2+F0Vcp949Oqwv
	HTyGavnDoeJfCfeV/BS9tfusiLKpK0SyJGB/pOmpPs4zm19OMNJHTPHbKc3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789129394; x=1789215794; bh=gCNorCuE8H+M96dWhDTZQohk42kPzatGTt1
	i0vMBuwY=; b=wlarpaHG2xpaxbFtomZYJbU754uBus1slmF5pSyHjOBso4uDmWO
	uFYE37Yl2KpTAEIXrT20UZ+6Ncs4sr/Pgz/neoWQqemlPw3KQxdKIi9881DJPcp1
	7L9X6HIlB2t6oa3Dpr4IaPQBTx5skefuTxNmfG5AS7imSndF6sFC52MqwcrbICaf
	IVH3ZPRnMW9UqGnFyPo4xOtED4pd7miQoUMJqfc43Y2sVcK1I+S2u50S3aLvwxyG
	DNQzk0WpXIJWiQvWM6IjCXLWUUcfxZOA5es1ZmRgwrH6iQPrgX+Gr5hbm2Ej+pat
	gSB2Co8CBWv/t4ab8KEApCfMU/LcGuuLFXA==
X-ME-Sender: <xms:sfKjahpBaY_H1G4BhxpdD_-bUCrVIDwfsu4UZpnLiBvMlA5D4FGuLA>
    <xme:sfKjarELGOL98MLX7Kqi8JFwLixLmjfRzpmJ7a0FomPdyQPfqOcA61KQhoW-cJydI
    pZXmlqCSBJtngXrBhgJJy8QsjTMS8CiSGpk4S9hztKkiOoDU4hHw0s>
X-ME-Received: <xmr:sfKjarkIaFjZR5vAMKypNjlV4R3wp7caHRJdClnl3QzcoISFRdqsnlVMrriUXFx4lIJqwA>
X-ME-Proxy-Cause: dmFkZTEs2iWGcBIV73ja450eg0sA2ip9PEUESkIlRLNRh12zPgwIVaiYFaWkdSxPB0XeO5
    z01WQRjzBqWJ5uEnUzBnFdh9O2t/XKjAW0OcFG8FSNlM6DzZRH60V4Av4LHxvhcBNjMGwq
    70eSEC0ErG22FZRP+mlefetcu8w524ygWWByeTdfC/4YO97H+pfAbUq3BM7JvRIZBa0XHt
    qK6e4udGS+bSnOuzInP/QCubd81Wavn1vbUgpdAuH0GIlvhefZtsyEQLD2hiwS5UpHIqJ4
    2e4CCFWoHxczWUfodix5K1PEitNRmtcoUYSftxOK4txds88YEQ/L3F5vnoYkmYrT29KxqZ
    85KrasmU5hKMeTK1u7Soy/Bq3aEsTay1N716f0tm2rG/BMwHJdvgVHJciTnT2DDsnrFRmN
    PucHnh+yCR1spfhR/U7yV9eQ1w9+R/Qp+hKmfLNnKIsotm2JwqLhW01nrVRfL3ty+yEcoX
    g7Nc1zzzkRKLy3GYzxIhBhhmDs6dqO6ubeeSoWgfDtMXLa0VHypJFh3VMuxKDywCB4ja4O
    0ncAJCRQc5qltnIXSaV954Tjqd+A49ZIBGuuuaoOAmU5oP6hjMWkpzfvYrqh/tG3CVMg3n
    wQ6FeCc5jQVCzNCTG79x/8O/5xh7xMMYkmcz7eJqzYMltZMqfZjwaPwayTQA
X-ME-Proxy: <xmx:sfKjamlweH1BNNWz0TrKBscOEEU6l7AwHHxALc-nEa76ZZD0adQz1g>
    <xmx:sfKjakuuc7pjxmTImh4EuZ3VOnnf_3-XY1beQ1tYa6qfF6rrAv4pvQ>
    <xmx:sfKjahkZjhNcm2kb0ziyGvwQuqavCBe3pycEO1ck03hgG7yLqwpf8g>
    <xmx:sfKjansv7Dx4Fo1Ti03apMEPdjUj1RB7afJj-u542e1QgYngFIESvw>
    <xmx:svKjajHdFSJwSNiPhp7TwrWXL2wqZ6pQi7MLHdCVNjSoDBirsvYYSvP2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 08:23:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fcb5eaa1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 12:23:09 +0000 (UTC)
Date: Fri, 11 Sep 2026 14:23:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/10] odb: provide infrastructure for pluggable fsck
 checks
Message-ID: <aqPyqg0no7k-VHty@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
 <20260831-pks-odb-source-fsck-v2-5-f9b16ef4957b@pks.im>
 <87a4ponipw.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4ponipw.fsf@emacs.iotcl.com>

On Fri, Sep 11, 2026 at 01:14:03PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.c b/odb.c
> > index 1fe20808eb..766043b685 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -1177,3 +1177,12 @@ void odb_reprepare(struct object_database *o)
> >  {
> >  	odb_prepare(o, ODB_PREPARE_FLUSH_CACHES);
> >  }
> > +
> > +int odb_fsck(struct object_database *odb, struct odb_fsck_options *options)
> > +{
> > +	int ret = 0;
> > +	for (struct odb_source *source = odb->sources; source; source = source->next)
> > +		if ((options->flags & ODB_FSCK_FULL) || source->local)
> > +			ret |= odb_source_fsck(source, options);
> 
> Shouldn't it be the responsibility of the source to determine whether it
> should be included due to the `--full` flag? In the future there might
> be other types of sources which have possibly a different meaning for
> "local". So would it make sense to have them check for ODB_FSCK_FULL
> themselves.

That's actually a sensible idea, doubly so because we're going to move
handling of alternates into the source itself. So at that point, we
would be forced to move it into the "files" backend anyway. Will adapt.

Patrick
