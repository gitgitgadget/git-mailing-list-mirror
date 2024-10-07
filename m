Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9954C91
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728278474; cv=none; b=XHRou01ye2tJtDFK13aznpudaWfAw1GSGjKVc754vq1ykYNKRvclwgUceRy+0K6VOj5EjaPyDpZ+oylux/cH2SlBkEo0uaYVV2D2ThF0REuF4TC3TQ7CGacsarFg7F7QndVEJYjFyxv0MW+0wZ6wW/alNTN9f/U0JEwp2q8+kms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728278474; c=relaxed/simple;
	bh=Ex15r2isprcIAVboPxaaPIfTx/LeQqUR+NJHtVCw34Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foErXNuxH2zYs2rUcI2RnfaHlg6IxqoKxKZPBoc1qLyXOeLWMaRjaMLPi8W0qPl9kZy7IyI/qN3J/f6TtIRUbi3+E5OH6wHaJ33NiEgQ7GDW4BJ+9R6//IaSs0+PjiHtPc23yRJr1SN8JwfP+T9VFCM7fB3aDwIQ4tGh1oH3DBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eK9Jzqa8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O4DaOPS8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eK9Jzqa8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O4DaOPS8"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2885A1380085;
	Mon,  7 Oct 2024 01:21:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 07 Oct 2024 01:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728278471; x=1728364871; bh=Ex15r2ispr
	cIAVboPxaaPIfTx/LeQqUR+NJHtVCw34Q=; b=eK9Jzqa8nNGVuSzEZLfkTvwXT+
	tVUWjCUEq4e31JDeX4jpT3f0PuDss/Fgc/GISt5LE2uqPzhOpnRPssJrx/xcDRgZ
	4SgvDotWNiCQUhnacT3VZa3OV0ICzhl3AU3uwKrLBftdkMvmuTFIExia5FvqBbjH
	k8tRkxhf+5xRzm8B5pfYH78fIQCf1G+QlVOUbhJny0l2o+sgSUk+EwUFjKVwez99
	JbgLKKCaZwp+z8Q4WPPWxRsC3MmdwAi7wB+WXJY4A/Rh304i7bQXmlcEOeWqelX/
	nmcQSsW9TUjTTZdtorFIUbdleouUnpCu05GflUeGzkVYplHrKbjCQx4pgJXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728278471; x=1728364871; bh=Ex15r2isprcIAVboPxaaPIfTx/Le
	QqUR+NJHtVCw34Q=; b=O4DaOPS8tHlMWh5vOKlCZn2mQ7xswy7CAe0x5LE4Roxp
	fH2XVnkUvtPxC5WL8GAGsP4wOWBEPiQzcYIESrJEm+l1PHI+/Pa3WUvxjJRL5h2z
	uC1dRU1Yc7+qp2QM6ITSH4KjEF7Qe9/8bjAyDhNPG1VgBswELJLBOwQgCrB0zXXG
	rI/7vY+In3JQwmIAONOIKLMcoGbAzVcYUHoqQ9Aw2+QB4vyphpMVrnaHyiaoVkFF
	kdY38jlbJ7bcoh5VTnJJ3TlkJZG3xcSo8L8PysVKB8eU6kaXBPcTQI0S4tBs9c37
	cthKRi7m2MM8BX2EleTNDRN8P/4GEJWPIyDZ0YEWeQ==
X-ME-Sender: <xms:xm8DZx5JdZXbQuI-mmB31af2w892WJ7IEgsIGqnIykO1ooPC8GLtvw>
    <xme:xm8DZ-4xP7Y3_sVkmcZ0HbeSxo1iifgb4f7wJj2yV66Fj2sMIu_sn_ZARsdNlSZtQ
    c8ihUO_xUA2q3KGAg>
X-ME-Received: <xmr:xm8DZ4dujMIvB-DFjOvykuSSKftfIPLrKJrRAi-p9svc3JySDIHlQKRKpL9EwYLHGFkgUYDANsD8hl0UkGeCpOoQEghrNAJQEVef726FE8XffhXMRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffoh
    hmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvefhffejvdffkeevtdegudelledtvdekudeivdffgfdu
    keehkeffudfhgeduiefgnecuffhomhgrihhnpehgihhthhhusgdrihhonecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhiiihosggrjhgrmhgv
    shdvudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:xm8DZ6LFbzzxsFOeGDZM3PNfVrpw5oI0YdX9MfimT2WeeFDMGbbZOw>
    <xmx:xm8DZ1J2whAuRg5pQhFJfQnrNfozmVKY-_kOMcjB1Sfq1UBtnYsaCw>
    <xmx:xm8DZzypmInUizTrcS44dwvimuqT2fbdZYzeFD6_LkQ_Lk7pbz5Cng>
    <xmx:xm8DZxKI-Tvq9d6_BD3DfgPcRLuDf9y19O0k7MYBY_M-f1cOmLArUw>
    <xmx:x28DZ8U7M7VX3YD3OgR4jtucHln7nN0nO4f665fZse0s0yqiqXDAGIjS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 01:21:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f140c44e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 05:20:10 +0000 (UTC)
Date: Mon, 7 Oct 2024 07:21:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chizoba ODINAKA <chizobajames21@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Outreachy] Applicant Introduction
Message-ID: <ZwNvu00mQuFQD7Ps@pks.im>
References: <CACwP9ara-N1PGYi8wt3MsDvs50thXf9iw2w4n-syZD0wwXXqfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwP9ara-N1PGYi8wt3MsDvs50thXf9iw2w4n-syZD0wwXXqfA@mail.gmail.com>

Hi,

On Sun, Oct 06, 2024 at 01:12:19PM +0100, Chizoba ODINAKA wrote:
> Hello, Chizoba here. I am interested in contributing to Git - Convert
> unit tests to use the clar testing framework.
> PS: I also have read:
> [1]: https://git.github.io/Mentoring-Program-Guide/
> [2]: https://git.github.io/General-Microproject-Information/

welcome to our community, thanks for your interest in contributing to
Git! Let us know in case you hit any issues while working on your
microproject of choice.

Patrick
