Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97044C68
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 06:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653832; cv=none; b=Q/CRecLGK1F0mExSISunxgdkqNDc80sb9wmua8appSFwt7vYwqGjdE324Id+Injs5iMNnZn4xOJE6oyeyW9nVulVN/BiH/0aMaiEoodb5LS6pYMr6Wcp1jOkzqOvnK9/byPm4ZqDgbmxvutNVZJZ1Q4gP+YZqvZPv4yXWcqxOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653832; c=relaxed/simple;
	bh=s3RMyYcvnjq+ZFwt01RHSZdUcRs3ebSRD7n6N5fzNmM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=pSUa/aOcTmtlrIMN5BqLr3CyF9eBpSRbd/OQ22mviSAn0IdOS8a396OLQgRsvUv6CFWO15RssdoJOxJKiPDnav4qm/+FPcy3BewvGr2CofJLUcv2VnJ4J/bcMYTepbV43tH4agu7zSk8SOeNP+Wvh/uZI9fbzHCfhpbaVTkHHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=hRRym7O2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fSsE8bsN; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="hRRym7O2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fSsE8bsN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 090161800101;
	Thu,  6 Jun 2024 02:03:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 02:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717653829;
	 x=1717740229; bh=M8MWX8Ro8ktrJHm5029JAN8BPOHbv98OSGn+tGAJKVI=; b=
	hRRym7O2GMr/wAz3v/w2NKA+Kya+Ig7DxwTuGdYlk2dH+i8pApxIltYVU/bVaBPD
	L4S2bZ+6ZP58ZQgYYVP+j4guhUj/YlDZkB0RkVWtIp+uS940UzJx7hBKQIKdHAY3
	4I+URf9gYnB12Td47eCv0riTvbtbLccd5eRMQvlJZahHaM6dJ1NLaUuMNKJiWMGP
	j+ncv3vMf2qYLIweJP0vIPtWLC9RdrHUmAyjirONTSVjCMJagQSD9Q9PIlmEUk2P
	/e/1tbf25qx75COw0yRd1Ptjwh78s8FPb0fy3xECRmUUuIDOWeSAr+Y48lEYyZBf
	cjzWOGQ4DwuNwwdFVrhkcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717653829; x=
	1717740229; bh=M8MWX8Ro8ktrJHm5029JAN8BPOHbv98OSGn+tGAJKVI=; b=f
	SsE8bsNbpA2pcmG/mMXqL3yEEJZOAcvDI79iY32w8s6ratM7PX5kl8lQ6aRgsYXM
	wC1UKJuMYTWxRwDXm0Syf1oOEtBn8VIXsbJsdV8R2tIrbJ8zVNVxw7026Ce0yNF9
	pca61pZoJGWj019ozjbiwcNnniJeESHpvfYnEho3WKrzj5kl+2N3R38BbeKm9L6b
	FqUFKq51h3iBj+BQeNjAEYAVVDQNMEsBMnmLze9gmEp+Ewb5ks/j23CfLzZ5mBNG
	0kcZoskwBkNDWYnHTumjSQhRL75WHb3iQ82+WdWpPWdVqLBSkJILb8w/ZAQytO3Z
	gWnOTxVRs/z0h9PXFvq8Q==
X-ME-Sender: <xms:RVFhZpO0dJzjtB-Js2U849Y0yTUiQp_Ik03g0ci1zdR8v6q3ZNsjiw>
    <xme:RVFhZr8QZ7HPB_1OKgywUyMLbcfsZQdszMSTv3KGb5GzilpVFYmk0wghgm4kBo_oP
    UP8fh_c8PoTs4oBiQ>
X-ME-Received: <xmr:RVFhZoQTYiuJYLMNeMxzhzE8BZM1YarKJRBIl73Pe8Z8TEeFCeonGQODmp-d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredtjeenucfhrhhomhepfdfl
    rghmvghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuhdrihhoqeenucggtffrrg
    htthgvrhhnpedtgfdukeelheeihfejfeegtefguefhgeefueeigedujeehgfejhffgkeff
    uedvudenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhi
    oh
X-ME-Proxy: <xmx:RVFhZltT3lA7ENXSE8TMYSHeqToabpzzP5jxwamoq8ZWDj__PBfamg>
    <xmx:RVFhZhcEtStbU76ApMq7WJD3l1hVoREYNUIC6RKuN5yF8PjIIrcJdg>
    <xmx:RVFhZh0E2nVfbHjYS5uqrChicsagXFkl5Y5FvGsGdbngkCNOyuTebw>
    <xmx:RVFhZt9f33C2O8kyZapf8zhsX3RgrZ6YQeIrVDqEfBeEJLj_IQkJDQ>
    <xmx:RVFhZl7wgRpr_o6VuhtdiIBXQ9OePp3t3vh7ghXX6G7c6OLv2sLnxpe7>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 02:03:47 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Jun 2024 16:03:45 +1000
Message-Id: <D1SPGQ8OOLLS.I6HUJZW81XLH@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] Makefile: extract script to lint missing/extraneous
 manpages
From: "James Liu" <james@jamesliu.io>
X-Mailer: aerc 0.17.0
References: <cover.1717564310.git.ps@pks.im>
 <b06088a2ff65a3455f0f5db2a9b752901f2af14b.1717564310.git.ps@pks.im>
 <xmqqzfs0x8w9.fsf@gitster.g> <Zl_3TQrUHdb5osDA@tanuki>
In-Reply-To: <Zl_3TQrUHdb5osDA@tanuki>

On Wed Jun 5, 2024 at 3:27 PM AEST, Patrick Steinhardt wrote:
> On Tue, Jun 04, 2024 at 10:20:54PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > +++ b/Documentation/lint-manpages.sh
> > > @@ -0,0 +1,82 @@
> > > +#!/usr/bin/env bash
> >=20
> > I do not see much bash-ism here.  Unless absolutely needed, please
> > use "#!/bin/sh" instead.
>
> Ah, true. I initially did have some bash-isms, but got rid of them. Will
> adapt.
>
> Patrick

It looks like the script fails to run under /bin/sh:
https://gitlab.com/gitlab-org/git/-/jobs/7021474555#L4365

Cheers,
James
