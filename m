Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E631618C
	for <git@vger.kernel.org>; Thu, 28 May 2026 05:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945856; cv=none; b=mNPgoGpuhyqJ7LO9LZpDXL3lyfVe/1rOzPeeu1/08STWnkXWgSaahpriHfgqWOsReh44EyONk1VfIsJcW66iCDNq08BgBx/ogI9pBGtAxQldhkuXwr5T1BdlcS834mI02v7ZIZkhD7jinabYL4drzNTyv9gbcKtu/FawZ62JiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945856; c=relaxed/simple;
	bh=sWd2f+t/AFTODXUvnZh08vdvvFcO5KJ0vjmbaM3WzBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu+AJ639RuFDh682qQFAXqUJf/gIlpTA6mFxk1WcCcSLPT4KUjlZascBEY21r0s4ztJNkDIKctw456JF9kHu4RqVrLLUPyTqag9vnqqakOSAwPpwOjVBVQ0sgxJsZKGM9jfhzTZtO5vFVui4iGTeB4B53bjskrkGfgxDV37PYrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QY3nymou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVR2v3I5; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QY3nymou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVR2v3I5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D2B6CEC00D7;
	Thu, 28 May 2026 01:24:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 28 May 2026 01:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779945853; x=1780032253; bh=GTWH9vo4zk
	GwjJcKEjCVHS5fOY2/Wrv7N/qQ7WREGMQ=; b=QY3nymouKjDIC+qzeI8I/UwbOP
	GQbZRbXqjcuIaABq947/O1za4itzzHkLv0iQKikEHlBlOzhmTY6alFFEjcflPnk0
	8Nf5RF6qCZy1JXYqay5HEJH9NMnQ6P4QV3B2hSLgY4jF1jcrOQKWXQyr38Ew9OJx
	rKPmLGLKLxH6cSSE7Q0qJv3OCwu0OmR/oXibhyoaZZS3kn3yT8XgVVpMAIzwou8s
	gQzmvE0CI72q0oUHTDLQcBqtYZbaDHHitO3XITq4j3tV3RvaRED/EQ4XbaCbkkOq
	5oKB9RZQ9Dac2TDsHbDORWMR+dwTaWjybOd+zPQ84vBzXkPKwrVmw0b6CHhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779945853; x=1780032253; bh=GTWH9vo4zkGwjJcKEjCVHS5fOY2/Wrv7N/q
	Q7WREGMQ=; b=VVR2v3I5A+Zibrq49QTOR7wopXcZOxy/dHHk/+fSXyYx4k3fJKB
	vL5hBnZSQZqqQk5j1SCKXunw/NjTcLzd7ehKetbHrrIGJzaomb5IRXQjZdjQz/W9
	BUzcpT6doZrp0MYpD4jF4w/undNWUy7YW6bn5rXdhBo75pGS7x0EPemjBJp/284/
	2w5bF1wV0jdAFN18jkJTiYIRLjEABlNmnG1BTF8lFd8EQ/z1Aw1SAkqZWnTIJ0k1
	HCN1u0q18DEoKEQil/+mKOErIYwMA+L67/7TtaahpTivYNfWaDDwBRks1lnR2hnr
	bAkUDWNxfY5WEMy+MB4SThtqjxFjjrCWN2Q==
X-ME-Sender: <xms:fdEXajwDG5KlcNJjkXfw6SIY12FkYSQZZDoHqF7MqlLRBfx5vQbqYQ>
    <xme:fdEXaitAii-G4dhzMsbSntA0-SE_Tnp_MT1R__sKFsOup16OQ2JCp2uD-5eqWDNAt
    foFgG3EEvh9B_O9etRmPprge_StykM4pWgC778zNwIQeiXR3gwJFg>
X-ME-Received: <xmr:fdEXaqv8pRk3d5SSiwO6issNMAVpHr-Xg_gw1UyNspBV7v6X37325MRl3qib9ENQoGzhB-kKMzYJvMR4d0xe_JQ32KUyGivBUgjh_FmfpQ>
X-ME-Proxy-Cause: dmFkZTGfQyQF0PWGyrvlrK75i3Ug/04vj4+I/tJSX4cAudfNhg2CCx6A9zBPnP1p76vDjP
    t+u4cTBcmjfIRjGWlx7EiXfFt92C2+Hd8blicyZ6Y7YWF83WUXtXLsU6BeYBq4ROGkmKqB
    jnQp4zsJzbAk39QCH1onvGbFRmO9RMc/9o6fvZMGWCUT7D3XtzxznBfo9IJ1cgv/DFAykO
    pAnyMeE/6nAWJdcQRDDgkDdBZYf1PxR2yv0/NGxfsLXq1ZbaXBPAp21vrSPeyP1LBx90Ag
    APqxVnvz/UZdD2W7iHY1K0MjhbfAfKtZd9IFwuL16mrTW7OFZQisXLVLDMj1h39IM/Z/QV
    sb15WNXnNU8CFkiZl7TUMzDUBrM4fCZp/xlvVtZcQhsp6hZ20rQwU+kVvx2kDYiQ+t+KuJ
    nvJR2lRgMBKEyRigJ9fZ0zU7ZJzUs9EOnQ21vsFrLe5WvWIqSQnboGvBEtA4b9OKgvYHrP
    IntTWVS/OQTh/+pgG4J0ohP044Apwvq4FEgArxhFv0PWFzVjcEQaZ1mtzHZ5Xl+SzwRvYX
    wR7o95LwcIlOOpEnpBbk9oeJPRHQ/Fwb1Vmg3bzgoSHjHmaLzruSwCUYYV4k9IMB3KHs8J
    GMF/AUggNK7+FxJH1XjliMpAr3gQvLA75Dm7bEMv5GaB5MgE6FaaaaTnmjdQ
X-ME-Proxy: <xmx:fdEXanO6HC0i6p8-PUmDgPtho2n5UW46xNO_L1-OOf-ZGLE_T3ubTg>
    <xmx:fdEXao0wJAtBZ-BGuwCeMJjRlE0n3TA87EK4ZpNfQ-RqCpk-xJjuIQ>
    <xmx:fdEXajPblFQr61WBO3_L90vSl1c2E5T6JH5MeQC9hJi6UQxmG-NfBA>
    <xmx:fdEXao0wKHtEbRdbU-pFonWhQPVPrsSBDjojHNxAS76XGqw7Tr19mQ>
    <xmx:fdEXaq0fuLsQsMwtv3WPq6rv41kiu5hhap3NCq1-bSrixqS6rKJbk0b9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 01:24:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ac85f70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 May 2026 05:24:12 +0000 (UTC)
Date: Thu, 28 May 2026 07:24:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 2/2] commit: remove deprecated functions
Message-ID: <ahfRevYta06fOaKS@pks.im>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz>
 <commit.h_remove_deprecated.716@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <commit.h_remove_deprecated.716@msgid.xyz>

On Wed, May 27, 2026 at 03:59:26PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> These functions were deprecated in a series of commits merged in
> 52882024 (Merge branch 'ps/commit-list-functions-renamed', 2026-02-13).
> 
> The compatibility was for in-flight topics at the time.

Yup, makes sense. Thanks for following through with the cleanup!

Patrick
