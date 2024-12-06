Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985051DACB4
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486572; cv=none; b=I0T0CYtWF2I9xApS2epGiWSQ+CffecOxhuCam9fU9eXeqbjEg8ifhFo0NXxVE4IFzUqof0KXXnlexhat7JNd9r6e6bt3cmMJgkrcUWRSSzFwwQ6SOhOXT7T10moKutTCT+ABSWvSV/SnfayoQbHbaNA2/zeQslxN9pYiItHPZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486572; c=relaxed/simple;
	bh=6oJ/t8wh8xSn7cuJO/oLTZoI9LYmrFVXEPwFKQxso40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P00zPUNfVNeChlHSRf9QnC7AesbJ4ld16eZ+SnMeAGxSZbRKWQXFGfvKiYdbfnWhtfVhRwejkr3LakqYooLEcJJZfLThNdtMmO8o5VY4RgALgFdZaNvMZRggOXdXkbiclj3lw+zsOTEI0gD+2j+lrQzDsKJJsUITNc6WlwHj/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=w5Cu7IuD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQcC1R8H; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w5Cu7IuD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQcC1R8H"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE902254011C;
	Fri,  6 Dec 2024 07:02:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Dec 2024 07:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733486569; x=1733572969; bh=l6Hb0TJQyq
	gmim5Sp23xw1NBT8fBKkcyROewkSK3rMc=; b=w5Cu7IuDAumNDV67bdMozqreBr
	kPttJUsgzG4waXq6IVYpO2j/AOQ7gIBn330f8ZUnszaGgfhsVagPtt64Cok5XaHY
	u1rpM0lBSb0vRQOlntx56o7Cwf2XRWuSHwQV4Ml2d6HPVRyrDJ3Ix+SREcukJbrJ
	5Xj3Pf4w8p7aairtmO6Fy2Z1jTfzijpJqMyVr5G6QWFGWH0pFfD6ul4CNnZmvE5r
	yPYCrmV7KK98w0+RZlzvLeINA3iyPRMC+r3Od7M6Wds5Q+AYjIMW1Nb6FXwNKDrU
	TrnihBO1lrlCDSKu5deFauafyDTVNIhCLfgYzFZl50PLH5bYnWLe6WWVJ2+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733486569; x=1733572969; bh=l6Hb0TJQyqgmim5Sp23xw1NBT8fBKkcyROe
	wkSK3rMc=; b=MQcC1R8HPjnvXSfF+ck2ua4PzqGNHVmd034KHPXb0wyr6uKmOq2
	PZG4X/R2jA6Ta3I6sIk8PLIGzQYcQNDw1T67w8Tqiw5x73DE/wsHuLGNv3d/GJIT
	d7UByx0HsFt517L0dv/KXe3+mBNgBryqhjmZAoOyos7tKyF8/SNTlU1VUOsvF5OV
	5RK+XOIiQ3IDQUDq+lbZ/e3g5Ope3NNycEV5HD4tYj0HhN4J3Ms7fDd8TsO0kl+Q
	O2f2CoZjAS88PwuNd8Gae8wTZnLo2yM6vkMMWLLU0c+cGS13cNKxeyfU5JmObe52
	VcPfzf9SCzs0vFsujtJPhHtmhAiG1oGheYw==
X-ME-Sender: <xms:6edSZ71SWXDw9uYJnlhRUpmfC-S4pa9g0biXVP0k6k2yQBR1n2qCbQ>
    <xme:6edSZ6EkkIpLOW9nnmPgtvR1uf3xnadrUP5TFOSAIH1k_MSog_K8qHnQgPc9JK7Lm
    GHMnR2aqj5u9DKp_Q>
X-ME-Received: <xmr:6edSZ76WFNrCVnGIVlRjAsb0PEQzfku0a2Tn_ZW2aTambCzJbJreEyZsD8JiNI0FfMi5VswOMdfRjTVSDj72Ztpiig32Cmc7CcNCu2sIyDIVCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6edSZw1PPlqrJeT4k8EuyCT20dH3DTKuiSAuqV2Y3yRREGULrSSMmA>
    <xmx:6edSZ-EazcmtZrbAvLv8klBaY3hvTEYqG6bxzmBjhW0borWIFv8eUw>
    <xmx:6edSZx80zZhWgdxJ88HcZ6rXGEZG5VTECXWuAB7L6EYGlIGdEj_dDA>
    <xmx:6edSZ7mcZM1QVRUNrmHZQuXMrjbMCeCYkyzi5D-VugPzIb5G-l6qmA>
    <xmx:6edSZzRDcsWrYTT2oq9aKUwJFS-z4NrUojk2ujuHWbIGMkPNEzELCkAh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 07:02:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 24366612 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 12:01:23 +0000 (UTC)
Date: Fri, 6 Dec 2024 13:02:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Random improvements to GitLab CI
Message-ID: <Z1Ln2ObkKB3ZnoGD@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
 <CAOLa=ZQeRWHog4Fjkb4MgK_34kV5JVEp4yAQ7Obgx6cnDJgyAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQeRWHog4Fjkb4MgK_34kV5JVEp4yAQ7Obgx6cnDJgyAA@mail.gmail.com>

On Fri, Dec 06, 2024 at 03:47:25AM -0800, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this small patch series includes a couple of more-or-less random
> > improvements to GitLab CI.
> >
> 
> Apart from one suggestion(?) in the first commit, I think the series
> looks great! Thanks

Thanks for your review!

Patrick
