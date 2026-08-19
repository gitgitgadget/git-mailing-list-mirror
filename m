Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739C1D86FF
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133714; cv=none; b=Sk7xAwnjoVs5n5JQ1xHJ19uyrm3Mm3zE19/19RqxRqkNldx2iqrNkJARUSevJ8K9HYqHn83J83YY+e5MuPrQlHxCcVoGJcqV1D1+h0XZmJAkYoiVClU5L6/jQap4Xdy6mfWP8/W5BRufV2xfAFi7I/nPd3bPXh/v4vcrTGUsJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133714; c=relaxed/simple;
	bh=8QbwY5n53eAmQs16cVMWPizDtV58KYY8TR+SLnhH1C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIWUePYwHdLrGI86GkSm28BF9FItCn49xv+izdGQuXaPC9c9zyKixMpUOLujohGglPn06tkGaFNYl2YRvS0R2AMCI2ElwlF9pCjG7TT8oGv74kJ6621MFzx631EfX1CfIglgq88dT4ff6DFLht4Kl8uUS9/mFVjnFo2pIYchEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kSdXl5LM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oo7p0IjS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kSdXl5LM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oo7p0IjS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B9561D000C7;
	Wed, 19 Aug 2026 06:01:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 19 Aug 2026 06:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787133712; x=1787220112; bh=qdm+sEc0Wh
	TM8gHI6QYHjtIxVmBspVf+iqVp6oA3cxU=; b=kSdXl5LMdQplRcYjb3UqmuecXV
	ZU7XIG9jplkwjRqRsEilA/lcJUG/1ezL/NK9UfROSBVMFBVLzQBckVw/29hp/cjz
	LriXejdtqmThmh4K7qtol4msLXiHoNWOAYuFnoepiKfb/tcN4pXy4YoiA5cRT4fm
	Ao5Dj5I0L4RE6ZwIAV2M/dmKYiQGH4cVkGnRg7aC6UpM7TBeir8fqrsy+qh111rS
	hvKgrQu1Hc02OotF44Hb0uDhmRCOy0OgbzTdvruURqCsAlI5qMltMPcQbItn8RT/
	DKm/9tveEBkybeWTx2hR+UIxqRS4Vxsp6RsdY6wxLAJcr0NfSvORI++DD18w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787133712; x=1787220112; bh=qdm+sEc0WhTM8gHI6QYHjtIxVmBspVf+iqV
	p6oA3cxU=; b=Oo7p0IjSbaJZ303ehjTMAbmkotQ3HmscWljY3z0HQiJu6kmYFYN
	gVkDXKBZmUM0nxmFg2noTs3aTX6iqeco7cjFQc2P/ade8vcuDSQ8DE/MCn4zoA8K
	Pos2yyvMsoBJcOXMxjtUivVxI5Wjfp5yMbgXcgeTRMn7qNiuijvB1Cr50QXgz02i
	UVEtd+V0l17zF6ybdNFXiglxvTacBsmVK69pPk7pUTMCMouCUAUT6zGivVAUWNCH
	xIvtqkhNOGW+oKJXFgDpa+C2QivAeoy2zUAQMynQUBlKA5RBaZcPWPSf2svFIP5L
	n6s14ke8OniPIJO+GDEJ7bbEOAheqHs2/GQ==
X-ME-Sender: <xms:EH-FamXcrIpwAFm4B4kmLVRd2wVKuygGmRusQy_gXhFrcvSbsQKxjg>
    <xme:EH-Faok0TPVOuJGeiu6_HdqEYsllPolU44ToP99mEzJbCd5aWXF8WeVdaGbMwTrbD
    mKIT7KfAT5pZ7OpzaHv-6FIRc9DZIG-fa-c8HsmNHQ69derIpElVg>
X-ME-Received: <xmr:EH-FaoBqOlngMDeaKfMQYi33Il4KLBDRduGMcRK1uXd6NvaulPczh0wSdXN67770GauOSd9T-eIrARhjuNMiPHMS1TcJRXrI2EwoLBvB>
X-ME-Proxy-Cause: dmFkZTEw2xE5w9xfQd9aay3bsHoyUC10hbA2T9HCWSEGrYBYWlnKwhQfj4JWWrBu9qWimF
    B3a9O4+GolRd3MDSlMh+QYdabJNjsORfGI+Nzldn3d+EdPEvvjRnlDOUlCSOanoIFOmejF
    MvXb5uiHF6MIooqn5ZEG+oVRFO2lyygyxOmvGr1HxcQZOVlaDfErdldgdDFfTk/QJhmgn0
    93DlF5BjMKMNFZM2jP500vO0ipGWYtN/opKMRC4B8O2/8Ocw3FN4tbYAMxIo32N8L2M4B6
    J81MA58fSTd+2lW+DUfocmmf9bY19ymlGhHSbYAOiB+e6rl/QZo7YF1VZViZ09vOgnxaMu
    pzUaEr3hxIfaCFGFKpto6wxxjFr+OW5R3fALj3dmRgHyw9IsLdWzkuY8ZpSen+uMlq/97t
    GSVzcbRTmhklPt8dcUYv/M3uUWKQ5vULBkde7Zl53WooNa0qIl3XijluJdAAlIloNOkVth
    viT4Lwo6EtzKzbaFKx0Y0EO9aQjGxLJf0QfFY5BncyU0gJrR6QXw9J3qPLkteDtcFP5F/b
    8TQpiR4yt8AS5v6dwHuZ4jSca2vIGV0o8kKjdaDeZjTEusmsksMvIPzc7eKL1AeZSnkhph
    56wXpqrKC+OK1LeGtGEn09C9AYMCGXj/bY3yXOFAcxbcrIa+mtF7L2DUPW/g
X-ME-Proxy: <xmx:EH-FaoehaM-uRJhKqUTfPibtmky06sFATvGg-kvUybUU_Hp_aiWWFg>
    <xmx:EH-FajKO5jTHb5sx17bSlMPlX5xfJadyOiR-J-v_Hn-QZqZTJ4h-Gg>
    <xmx:EH-Fardim7kE1rNw_WukiQEQVX67C1bxpqY0oaZMNGtS2yR4TeWSlA>
    <xmx:EH-Faq0kIjApv1OPqPT80VGFdlpwSY1cPh-vZIiz272lC3aYBiVGrw>
    <xmx:EH-FahsBKcRYutfJQiDUTgJzgbpDhU3zjwdMvl3jOpPCtJp2BCQC_0vM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 06:01:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d21a9aa8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 10:01:50 +0000 (UTC)
Date: Wed, 19 Aug 2026 12:01:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] odb/source: discern missing and corrupt objects
Message-ID: <aoV_C8MQsTZSDqX8@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
 <20260818-pks-odb-generic-corrupt-objects-v1-1-ec234567510f@pks.im>
 <xmqqh5krz4tz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5krz4tz.fsf@gitster.g>

On Tue, Aug 18, 2026 at 11:00:40AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `read_object_info()` callback of `struct odb_source` is documented
> > to return a negative error code in case reading the object has failed,
> > and zero otherwise. This is overly broad though, as there are two very
> > different kinds of failures:
> >
> >   - The object may not exist in the source at all.
> >
> >   - The object exists, but reading it has failed, for example because
> >     its on-disk state is corrupt.
> >
> > This distinction matters to callers: when an object is corrupt in one
> > source we may still find a good copy of it in another source, so we may
> > still be able to proceed with a given operation.
> >
> > The "packed" source already distinguishes these cases by returning a
> > positive value for missing objects and a negative value in case reading
> > the object has failed. But all the other sources conflate them into a
> > single negative return value.
> 
> In other words, "packed" did not honor the documented contract with
> the callers and nobody noticed?  It gives us a usable escape hatch ;-)

Yes, kind of. It didn't matter much though, as the "files" backend
knew to translate the positive value into a negative one.

> Do we need to support many other "it is an error but we treat as non
> error in some context" values, like the "does not exist"?  If so, it
> does make sense to say 0 is absolute success, positive values are
> such half-errors, and negative values are absolute failures.  If
> not, it would have been much nicer if "you asked me about this
> information but there is no such object" were still signalled as an
> error (i.e., negative return value) that is distinct from other
> kinds of errors like I/O error (which also should be signalled by a
> negative return value), instead of a positive value whose meanings
> were not defined, though.

I cannot think of any other classes of errors where we'd want to fail
gracefully from the top of my head. The only one that's potentially
worth thinking about is in case an object disappears right while we are
looking at it. But that's basically just another edge case of a missing
object.

In any case, I think I'm aligned with the proposal to turn this into a
proper enum and then use negative values exclusively. Thanks!

Patrick
