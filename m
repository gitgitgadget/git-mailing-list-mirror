Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3A1DE2B5
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965877; cv=none; b=H+5TKVIzKslRuUk5sohewdLK0MfgT8qKubTRktQ05zSVgA4BV/VMUUhBAiRboeOxxKeuLlU7QB2dUTnBR9Oqmnj2hA3UCdxqQcPhOFlAdq6UTWDLiIxSTvcdFbWlYAwDbMFfskuz/JQSXFTuktUb7EVAi8E9Hgk803lakV1QhZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965877; c=relaxed/simple;
	bh=jqVGIbD6xejt4szSWGpjGPNSsr1YMROnAmfWA7Y+BF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrE81gStPeWZjU4p1G4gHjpwZuLkKSsNXIwI3LzrBpY5LszlH51POX79WXZRi1p4iRo0IVzftbn06fG/3xKKc7N20oGxjIL0anEkJkXerQaO+J1zgh01OMcLALW4Dj+yM+gqen9p1uTVVrnXIBtDKT4hc1Owh9Qiog7pHbLzHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XFSbrwrI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=omP/6o/c; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XFSbrwrI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="omP/6o/c"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB39211400F6;
	Wed, 19 Feb 2025 06:51:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 06:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739965873; x=1740052273; bh=ePka/mYl0x
	9EAKdR65O4LLA8d6r7O0IwxdcsTHKinRE=; b=XFSbrwrID8/aGOZbcpGppZNRIL
	MawWK6HHXftb2RBQ2XQaOTmDFh7af+J5fUn4Fj1cPtta6Jn8yDx2NJnrWX3+nORl
	Fk3XiNX845cCKunYuZoztN42d6VN1zxO97Kg0Ve6l+lglO58dc6slP2Z3NRY1vVu
	/rvABhpufNKZGs+9LF+mKoBoGlDZRMekThoHLaGbtl9zqPus6EDRGKUe9hFWh6zN
	GcpqmbZA7y0wr85ahOQDpQTUSN3En5Ht/XnQ5FFPgzZ6grOmkLn6CJNkB+ioMkr2
	/YpjOZtRnHajgLcrtwW9uSOBANsB/9fWfE2QpvZQCPTOzjXrlqMhELjgES7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739965873; x=1740052273; bh=ePka/mYl0x9EAKdR65O4LLA8d6r7O0Iwxdc
	sTHKinRE=; b=omP/6o/c/g66A1tcgLEL0n1p5OoGAXfgM2YDtua2EZIffT9vrf4
	ta+2nspK+VOrBwoyx/2xWRH2DXSIAIGui0d4QsmmRG3EjsELr/W9UTO6uttxR0rn
	TgyJgwBkKJUx4WQROXO0OOaJcv4jZn0pkL4JWDDavsVGA0nrpDg3nMmu4lBy1nQv
	CG8j6lihmf0TROdOmgdwlDEabXIdgThvxL1Zpx0yyai2x4oBletBfcK5/PKcLbam
	uO7WFemGFccj85uktam9j828f85Y5qtYWSeViHOr2O23vFeTNzdTfxQSlyXQWF+O
	RkmzSWKWcwEbNQrYRx6E8E9u4FKTvgoNLJQ==
X-ME-Sender: <xms:scW1Z4c6B34Chtr9pI2PZTh5x5bHIRTSMoRLuNVkeeA3zn7SCwbVCA>
    <xme:scW1Z6NRE3aC7X5ZH5gC7os8H3tH9nBK1BxjG7xEaBq3Ds79pz0ZeZquJju1S74K1
    B7LOwkXFjex6zqmsw>
X-ME-Received: <xmr:scW1Z5iMNjX3CvZyy1r3IBhH1egMH8VMH9YOQUnqIiR6pu0wqGq3ADX05-EtCH63PzU9W8OaW0CGHj9pQosQx3qvOK47BLENm9IjkKRK4RE2470>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjiehtsehkug
    gsghdrohhrgh
X-ME-Proxy: <xmx:scW1Z9_YjVsLnoP9bzWb3f1gWksGy4kuTQd4rB2jZV6dIgfT3gHpVA>
    <xmx:scW1Z0t1Ffip-r1gJnuRwkZtdEbCdRFft21pVHmXSSZ54Jqix0j_Jg>
    <xmx:scW1Z0HvjpRgwDRohx-tuxuq0zY8K_Lic7E7BEzKAepH-SfRqadiOg>
    <xmx:scW1ZzPWWQyK0KCQEQ1tVDpX-rKFy1hreYBsggfUx6JyjmVu6Cv0fA>
    <xmx:scW1Z2LY7lonxEU-xJLNUH_1OWnFViNMq5Aro6oOU63t7-66U_3q6ZFq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 06:51:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb03d8f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 11:51:09 +0000 (UTC)
Date: Wed, 19 Feb 2025 12:51:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 09/12] gitk: extract script to build Gitk
Message-ID: <Z7XFrDmcUVIaotqC@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
 <20250218-b4-pks-meson-contrib-v1-9-c3edd292beb8@pks.im>
 <xmqqeczuj3fc.fsf@gitster.g>
 <Z7Vxx_yQSMlXfteX@pks.im>
 <67441cc0-ff56-4159-b080-868161605bf6@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67441cc0-ff56-4159-b080-868161605bf6@kdbg.org>

On Wed, Feb 19, 2025 at 12:42:44PM +0100, Johannes Sixt wrote:
> Am 19.02.25 um 06:53 schrieb Patrick Steinhardt:
> > On Tue, Feb 18, 2025 at 02:25:43PM -0800, Junio C Hamano wrote:
> >> You would want to coordinate this with Johannes Sixt, who may still
> >> want to maintain the subtree arrangement.
> > 
> > Anyway, Johannes, I'm happy to evict these changes from this patch
> > series and create them as a pull request against your tree. We should
> > then also be including the project as a `subproject()` so that it can be
> > used standalone.
> 
> We can do that.
> 
> But there will be a time frame where the Git repository already knows
> how to (and wants to) build Gitk as subproject, but the Gitk repository
> has not been pulled, yet, and is missing the corresponding Meson
> instructions. Will this work, or should we wait until Gitk's part has
> been integrated in the Git repository?

I guess the easiest way is to land the Meson support in gitk first,
pull those changes into Git and then I'll create a follow-up patch
where we start to use gitk as a subproject. Does that work for you?

Patrick
