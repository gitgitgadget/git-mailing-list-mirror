Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE651C3C1D
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736841107; cv=none; b=kT6vr60NpwEPJF3dNMYw4FWFAxKpu9RHDtMibZxSDgOtZP+jVFVGrXi0vyFzkyJNIf1p7F9+YxNJKG44v9BraBdZLcv4hT/hF3pzH+Ra1697cJtJinLOQyqxNJEws4rHDTPvMo06UgSvnw06O/XGxVsFZtwMKUs9te3/cPcXoP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736841107; c=relaxed/simple;
	bh=OK338G2QW4ErwsnvuDpD+B4FxL5DKReC7cK2XxOoSUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9GOqoBMpTcFESkwXiJctyeIaLxRPycMBVxUNz9hYjXTNn5wLr7qaE/7EUigTazHIbYsev5hgN9tuNF/06E/V5Cc+wiFCnXjna1Kf5BFBaZ2DaeT4TrvzQEgw1RCyA8nZaFyKw805SY2zp/d2WdTkQO2OpVYtihf8qiZho7CxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bAtFsf7x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=APlzLxFN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bAtFsf7x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="APlzLxFN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 40CE61380285;
	Tue, 14 Jan 2025 02:51:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 02:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736841104; x=1736927504; bh=ynXYmm3/m/
	3cB1D6VVhDWDgr8xC88ClF1bCqFDyUtsA=; b=bAtFsf7xvP/wsgaldJ0nBtd8XX
	vP4Hifn/FZtPhxRvn/p6JVAebO/D0Ek48Zu8CxXB9Tad/KkxBVdjtJI/VVLQksms
	u/Y4b0pmuQ2EWeVrnafvOcS44DwDzlpgYL6J2n+RJI6CYQrGGom4Cb1/S4dnm+g5
	UEue1pHOijus+I4Vp/0Nql5gBCfoF0L9MBmE3h55uuUmJN91XNl4ov7wQWogilk4
	mRGp1PMnHBNTKQIyI8k/iKLQBmK9jhltdPzmnc37RSpgzID1RtnH/a8x6DOIcbZJ
	+CDqut6bMAnDbfHkc3PePvVNbeQ74gQYAeacI3nsiuvkeBTQ/fuVL45hiQ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736841104; x=1736927504; bh=ynXYmm3/m/3cB1D6VVhDWDgr8xC88ClF1bC
	qFDyUtsA=; b=APlzLxFNZ1xqVNXldvZStA73AqwRpaL6WFZQksd93doo+ugG6H+
	vKwSwiBMu2NkxJ8lE0hYq+enVeB8QZ+z2X+Fg0NVKSTNhAEUp7Hasb4Cbznu5vxL
	LUeK2Tg8VUqomLyzkwRgfwb2PnAESmqmPjPoY2TM34veXYzlR5rvK1RJEWcuYCfI
	UWy8Py8ssREBQmPgCxCD28ivDWoQpwMXgOH1BjXd1yVnOlntn4RU1gcGgKhh+x9Z
	NV0nZ0fv5qs3sV0qqZqgBMDP4MiKxMNAZkKUfCKr9g/QwfDWCQamTgT6LA0O/c6W
	RnLKVoO2xxcDCGmx+Nan+Ucu3tsUsBhqZtA==
X-ME-Sender: <xms:jxeGZ1wF-s1rRrQXTpFZz0D9WlfkJx1YJF9e5KsLo0RJ7UDBfaIMdA>
    <xme:jxeGZ1QMC1W7z4LU2lRfFuEXUiscYlv_YRbnZUVCQascpBVQ3R7cVp_u3UUDlV6Ch
    Ee7142RFqLv-qVsHg>
X-ME-Received: <xmr:jxeGZ_UPmE9RBlb1ZCdlPCZs48-KtBT3IbTyNmZE5iy30weehUUd24FN8asOP4rJWKj9FvFuFTcjhOOqzAZIhogqj6eswEKHVIbRrI3zQr-X3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehhedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghm
    shgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:jxeGZ3hV1PJmyAYbyZOfsJ4QY1QbT5JT44y7UgrPKqcSpGRrTjAzQg>
    <xmx:jxeGZ3D4FUBDO-KU3fbVgoSAL6fUhfMel19u63RUj0Tg_M0CMrH0zQ>
    <xmx:jxeGZwIEtq5dtKvJ7MgXV3nqhYKKvc-pFTIxfosX16RcXsRKAdSACw>
    <xmx:jxeGZ2ASj8s1Z5Y9CQlO1n8rt2kwzk7fSeCyWqr0i33ArRsnv43oFw>
    <xmx:kBeGZ-Mn5knwefVVr7k3wbxMM1iwp5peT_hrdxDYnIoSBzpiD0lRqZak>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 02:51:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 06eb68db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 07:51:41 +0000 (UTC)
Date: Tue, 14 Jan 2025 08:51:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: 'seen' branch identifies as v2.48.0
Message-ID: <Z4YXjCrtjCUjkEql@pks.im>
References: <6c5d0f90-79f0-4fba-8edb-f80d0665873b@ramsayjones.plus.com>
 <xmqqr0566u60.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr0566u60.fsf@gitster.g>

On Mon, Jan 13, 2025 at 05:49:59PM -0800, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> > I normally like to find solutions before posting problems to the list, but
> > unfortunately I don't have time to look into this at the moment. Sorry!
> >
> > Just a heads up.
> 
> I'd throw it back at Patrick, at least for tonight; the topic is
> more or less hot off the press and it should not be surprising it it
> needed immediate fix-up and reroll.

Yup, found the issue. The next version of the Meson series will have it
fixed. Thanks for the report!

Patrick
