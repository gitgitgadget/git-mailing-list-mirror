Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E256F3F0762
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527012; cv=none; b=AZYWohiHv7+w/bzYDf3Tdes3kTWXM1n+i0O0Xd02LHKonpRLx960XSiYvBdmO9rGBqVYkO2MKIk0Jw/yPF3a0CNmjw9rcxkj3vVSmVCBYQtFR9SJt9x4XSys2qPIXdqbqIiU8s6aTSwI4xBpR7TrrNtUbiyrgxpe898RbMm0JH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527012; c=relaxed/simple;
	bh=ldqRAISATuirUOaPoMEYvpwHWFMUHWZTlW90Vt7vq4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs8vSz/4cv7w5V+eSHQyXC8hVndvEpqmeJR/+krxNClO0JU14zP+mqo/uaetFHgwm/JzfBCmgqlc03uHehVcrs3s73wlC5EGEwuzfltzKf6Tq3WegeIrB+XUiDZojaHn0Qq6Lz1idMiQOo4UDBEymDYrfObKLtDVrMEY5zrRQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NoeKLVqK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QlwgGdw9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NoeKLVqK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlwgGdw9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C99E5140000E;
	Mon, 15 Jun 2026 08:36:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 08:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781527006; x=1781613406; bh=VV97lWEuJ/
	/5B1ewvBI4Mp98JwkMUEonnL/XaWcuS/A=; b=NoeKLVqK0QhBxbjp3mg7tXdl/d
	ShLFQEFyIZ8nYNiQ0+BKwZLit4UC474/bkBhb0YlAPGuLgU0u3fW+kG8am06ZJ0A
	kJvHtsZk9hER8I/Z8r/vk1Pa3D4cufq71UPBkh1EWpe7DicYJOzMDaSbGyvTpxno
	ZsQAJPEmpHnV+HGSjhAcmEb7Y69/u4+ryiSAUuhNL12nyGYTCUuJhKmDYce0PbyX
	+ShzpHG9Z1uBIzj6RvAqN/eDPyv+g33vQvUdWiuvhAPXG9/V7CqXDqxcEaRDVg/d
	y4P5n6tJ8ORhvIx8NOFwwLvZXdWwcrtkdzE32dfDFFrgZ39dTOihkBXbClmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781527006; x=1781613406; bh=VV97lWEuJ//5B1ewvBI4Mp98JwkMUEonnL/
	XaWcuS/A=; b=QlwgGdw9A3JNajadoiK3PqBO0s/wanXYWNMbSosdnZ6keRSIgvC
	irkqRmNlesXZeJeQj/PFdMVfMiy/DZlJ6Q2irIyQIkNWol1L8/xidKoNzsdu6a59
	ebgf+NNnVTK+T3/17S7YaJ6KhLYp2ZU41EYY1uyMIF/8a0XTpUSoTOQUeiPKJ7AH
	qCLOwXu1zWF82rNwiNgxjB/AoNLH9g53VstXGEhTBnqqKlKgpqT5dE6ZQCc8I5uh
	GBVfvEDC4XkLoyc3aCYORl2v0eqm3Coww5h0oH92iM3Zvbzz6iAP/E76Xqdi8QU5
	Oa8FOHvlCmcMmstmuxMUpehyYvvZWJCSP5w==
X-ME-Sender: <xms:3vEvauLTYU566w6WhYrNCH8lYXDckNsRmUVglqGRHiwg7qH7j5yD-w>
    <xme:3vEvasLi72x7uomiKM0t5fzturymkAm6LTgHXv8-8YwmObhBZoet87DkDBoutKTpW
    J498I93fmrh5N_q1nbBrS_z_Be5e14NxBrOACxkIWITF87sqjmNEw>
X-ME-Received: <xmr:3vEvasXO_mJhHaY9jpv8Gc_qXP9ugil3MX6YkueLjVU6aSv9n9TAXjO41H_uzXoeX2BTzCvw2rPVb1HHh1SWvbJRonHJieqcAd6o7wtDsw>
X-ME-Proxy-Cause: dmFkZTGdrVSbvEDAk+RYsdA6XKO8+ZgDA4e0H/iW88R9UuUpcbM/o/6HLM8SPOIwO27Com
    d79E1MQqFJT9NcVqQ1KyVTIxGITVMO9QG5X5xzIWYt5rKBZywS7XNAMViCuFiNsK7cki+r
    PeEjORhThduo9t93dx7jutMto8jOapfIXJFw7KApVFQi3QndWgzicK+0oHNn/N44eMUQV8
    1ianTktF4CXCLRCP2DJ5Be+6U25YFXKZrm+VKvGfmsAtSt0CxhjY5KQTk9aiQPSp2Sfd4u
    k8kdZcB0lK1jB+RQnzjGcM6gdhBz71CLrw/yVyw0aQyjk2IPmS/FgRdfZ0JzCBaYBS6xeq
    5BblpwSto6SeLuwBzYpfBs9DwSNWzdQFUsA5uD6FwC515LXcIzZRey18z+6H9TyLtcB39x
    IPGNAx7CvjU2pEfqxdNFNXBcU1mcqZc8nTwtd+vyH+NvhDsDUzj5foWdd/dRawDA8oF9+S
    A20xKf9tf8cPml6/PlNkfsKJdQhSqEFQejmV+8xt885JeTHl7enj4s1PnfnD5rrdGnoWbM
    RR6p0UOirWutFN2u5YRAXIfq/hiElx3gN9kBw/e9LAq2lXdlCY2NiOyXAC7upz4WBaz0b/
    DRQsmqQutQs0NYfSfg7x9VFJSNi0q22ox6rSpr+QGWJUySfwTF5YNWJ51n5Q
X-ME-Proxy: <xmx:3vEvauhQua8cL1DDoKBsxOjSrNWwhIJgOLZBKD_Gh6anHxM6BEEkVw>
    <xmx:3vEvan9gPgDmA5xpcgO8oCfTh9BE_bDfgrZIvxrLTT7t8T7P40_dEA>
    <xmx:3vEvaoAb7dlhpyeL6MVTH6-sTvWG7u26nS5lp_Pi_a5a_3IYdGZvtQ>
    <xmx:3vEvakJoPgaKg-UwyiHnR4m5ryLE0sixr0hN0lMHnnR0qAyaLjaYfA>
    <xmx:3vEvav68e_BWsiTZfKpgVBXtEvkKGyOHUBzc1NKwXtvJK_GVLhgMeR-F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:36:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 732987c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:36:45 +0000 (UTC)
Date: Mon, 15 Jun 2026 14:36:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/9] refs: unregister reference stores from "chdir_notify"
Message-ID: <ai_x2uJOwInU9lvj@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-4-56c864b01c43@pks.im>
 <CAOLa=ZS_0b9o2YucgA6Se_Mq4nLo1Luow7adTLAifbkF9jpUrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS_0b9o2YucgA6Se_Mq4nLo1Luow7adTLAifbkF9jpUrA@mail.gmail.com>

On Fri, Jun 12, 2026 at 02:18:28AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > We never noticed either of these symptoms, but they are obviously bad.
> >
> > Partially fix those issues by unregistering the reference stores when
> > releasing them. The leak of the main reference database will be fixed in
> > a subsequent commit.
> >
> > Note that this requires us to use `chdir_notify_register()` instead of
> > `chdir_notify_parent()`, as there is no infrastructure to unregister the
> 
> Shouldn't this be s/chdir_notify_parent/chdir_notify_reparent ?

Yup, good catch.

Patrick
