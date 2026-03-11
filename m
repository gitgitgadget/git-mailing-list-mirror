Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A003B2FC8
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215492; cv=none; b=DYqElCP5Wysx0Cg0E5I0hlplC9DbH/RG3xaUkUAmasbsHEydqLnxyYlky6+HNK60l/JNCrZ3NtomYJOOy3MQQdVNC1oJnquLcS0AlGbyLY4AuAvU6FfLwjguMfaR0jI1MVpGzj5K0DwqoeMd2+PdSET2rYCsAJ8bFIvBZPXthzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215492; c=relaxed/simple;
	bh=RUwH0DMFRGPYtiET90ezD3QUTbNAUYcVz3L0Xn0cGXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC5nD6hrju8OESoY8U66wvizjDWzxeSZouBqsoYtrQAiVEktefIyXyFdqwyL9HqFHPrb80ypWWj63bml+KpIkPOi/QIz0SaD6YKpIatOB0WeIvyzijyYK8xiyZ6yuuy8BfM6coqrnh5gk12HPC0WjdiStBbngJtqX1L7dMs0g2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LoSa2f5s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K/ZZICw7; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LoSa2f5s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K/ZZICw7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A17B31D00128;
	Wed, 11 Mar 2026 03:51:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 03:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773215488; x=1773301888; bh=UUgoAhQ8T9
	KENiAcNx93yo26Y/ZZzePA4A8ZCTUDpfw=; b=LoSa2f5s/VbDRrH+5rLmgHQGsm
	4AtWjJFcKZEmwB61M2DIlkm6loGYu/V8D5DbeDshKBO+zv9+QSBoDdh1pvr7Yh/A
	rW9VtUVU2F2MBvAmz1zBu9a7peSBJ0QjMoNdBJvd2QRhwfigsCeMnyeV9jlx4Bb0
	FmWYQGLylbcg00oAVLnSSOvededewMC2fXnoue/Uis1pvLWGr1thjj+Tlrs8Y36T
	8JxCI0Z60VUDG5nkfOV4Lflq4oEFO07OCaWvqJpjTWtd2avojwvTgPMeAcTIBf3h
	osrA6WYpoahuSTfA4/CfTRvBct07JHJAfMufTQehDbnqtAVl7LVW5c4vDObg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773215488; x=1773301888; bh=UUgoAhQ8T9KENiAcNx93yo26Y/ZZzePA4A8
	ZCTUDpfw=; b=K/ZZICw701CI7/0Wx0KlI494fm0KmCpIxgRqkJ/oplcM8KeFbLX
	wX4Vr2kV+442YF02tWyJ93Dulyq1dK+sh8eNa6hyAtLcbF6sM7wxLxmKLGy5ZXEk
	vI8fGyMlJsdDej/ri9n0R+nK5l9bC35nweE5PtemZtB3tLapV6rI/w5CKs90ufOm
	oscDEPI0XBf+aM6UHfJp54s4fEtH+NhdZZWlpGMtaCadiOEzJU2srlOW0iBaA2b/
	29hdElG9y6O5C/WJtzuOEb82GdVDYzOdiLWSczgFtzIJd4oBDV5jRE2HAUp8OkGQ
	NBDB/1u6dCypav3RGSyjADbRN0fT+NCyeWQ==
X-ME-Sender: <xms:AB-xaaFeWAvhD_VNse5xhi_XVslSdGloCZHQNIciFHPKl4pbjj6qOA>
    <xme:AB-xaRWQpOxdUrqosZ6ki4Oadec3FeT5oqHUYBdDmvPRrRqDWdGlBYkdUOfXyRhuw
    3bBvWvp5-DY866lI_pg3_BtC-sCkG6eLd4hMO43T_mnRugry3Q>
X-ME-Received: <xmr:AB-xaRwtKdkEPUDSEq0UfX4rYtVoIR1E4ocvPMK50YpTkHeGf5z0MT7utP3t1SNEm9Hvd4WZvQL1IaQ4d8ii98KH-qAbOwDS84Oot67WxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeffeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AB-xafOluXqKoOPIoNVmt-VK0yp-zHjEprQhwZIgGiL7Vo2aJHLvog>
    <xmx:AB-xaS547qvByKul74kYhTmi2b4ILltH8jX3LqOXF9vNXJHhGgU2hA>
    <xmx:AB-xaQNrgsBc-2ZIa-a7tz3oQBaDS-BegcmFe5iQe438BsTdQsaFBA>
    <xmx:AB-xaQn1BEDLv5wyY88DUYNte5XScWevU7-BuF8DVRm-vefXcliT9w>
    <xmx:AB-xaVdRTup8vJNPROoBLtBBdsfu4WtNoNf2QFo0wLQqq7_EEKP0L9_J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 03:51:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5b5e4a3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 07:51:26 +0000 (UTC)
Date: Wed, 11 Mar 2026 08:51:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Makefile: deprecate autoconf build infrastructure
Message-ID: <abEe-87CJSm418ln@pks.im>
References: <20260304-pks-autoconf-deprecation-v1-0-f5b611b13138@pks.im>
 <xmqq8qc78nyt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qc78nyt.fsf@gitster.g>

On Wed, Mar 04, 2026 at 10:10:50AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > roundabout 1.5 years ago we had a long discussion that eventually led to
> > a rough consensus that we'd rather want to get rid of our autoconf build
> > infrastucture. This eventually led to the introduction of Meson to cover
> > this use case, which has stabilized for quite a while by now.
> >
> > This patch series thus starts the deprecation period of the autoconf
> > build infrastructure. Target for removal is Git 2.55 for now, but I'm
> > very open for discussions here. I also assume that depending on feedback
> > from packagers we may need to adapt the timeline.
> 
> I do not consider autoconf a thing on its own; rather it is a mere
> extension to Makefile based build, isn't it?  So the declaration to
> say "we favor meson over autoconf" makes little sense, at least to
> me.

Yeah, that's why I mentioned 3.5 build systems. I don't consider it to
be a full build system itself, but rather the .5 part.

> Asking which between Makefile and Meson should be the "primary"
> build environment is a different story, and the question does make
> sense, even though my answer may be different from yours ;-)

My intent isn't really to push Meson instead of our Makefile, only Meson
instead of the autoconf infra. I would claim it's the least-loved part
of our build infra overall, and it's both hard to read and write. Our
recommendation typically is to use the Makefile directly, and from my
perception I think that past discussions seemed to be in favor of
getting rid of autoconf eventually. I think we're now in a good position
to do that, but you or others may of course disagree.

Patrick
