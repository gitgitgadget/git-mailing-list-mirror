Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1861231A21
	for <git@vger.kernel.org>; Fri, 30 May 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748614922; cv=none; b=nnFw6V19tSZ6Uy/1+Ll40xKNIWMPR73gwNzILm56X8XqwHpUMWmcPBkuGiN7rGoi85efVp/zLl2LKalZuLc1w8wDGKJysrkfQ4R1Ygi78GrT4Kmz/RtVHBOyqq3u08vzS53gADyx1ODie/cyAVW7gLgvDZHiPclq4IBQkzd3FkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748614922; c=relaxed/simple;
	bh=tvPDiXRRwwY/5IG98P2oMkUBQW8h4uxNKOMNGmeERXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDcXSufcCHpxEOmRitb1nPOHX26ZqetW479Xfd41CPfAsFWQ8jMDmlR6LUMWdular36RUDqSlM/iTRuzH2W+peuobX+rJ3yObbFPbg8VFSxBZxJji7QLq2LOrnb1WjNFQBQzV5Ka5WW6Ch4PxUCcCvMX4jRPXYPpXGuhRTBIFcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dgs9qcvm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIabFJqZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dgs9qcvm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIabFJqZ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CA1B31380180;
	Fri, 30 May 2025 10:21:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 30 May 2025 10:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748614919;
	 x=1748701319; bh=6U5vn97P6X46iV+V8OO+NA/ARfOAkZJsWkP0XGWy2VQ=; b=
	Dgs9qcvmDDh+dXpAa4ZARua3+20QTDSY338VlaYucTxm2tmUG6zcJZT5fbRoseOW
	zQqvye4V5FfnGp0eCGZ0hTB88lxc/fwMTVogkSDxoZN5PVGRvLlb5hgf22473TDS
	wfF1Px5g7Kt/lIwalLK7D2QkHLavzxtfHkAwjIhlNjTGDAZkUTD0ouQW8Jq+5Z9R
	oS1zE3Mbxz2wXWbS3EuBbWxFlcT6H6scgr2C8nLrU95SBWEYejA71yXl42V7OUBy
	GW9a+yQpa+Ah5SrgkJvMPP8RPRW/xiV9klnFzBahg0jOQ57JMMbJ3uDX8OY2gc48
	7MsPmzdOzBkuMHQAFmkgnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748614919; x=
	1748701319; bh=6U5vn97P6X46iV+V8OO+NA/ARfOAkZJsWkP0XGWy2VQ=; b=k
	IabFJqZ6AL8wiIDKv11Wltk/rORF9kKP4WL8ErmHdMx4fcaCsTZSyedBZrA2YzSO
	wJUnml4Ivcnn7TjTVRQB5BdbDpTlyWlbXGkhH6lSz3DYs0mYIU1eBm0n2gsYCLA6
	5uf2AplyqwITFVhBOt6F7hhzxsck8x3VtY1tXud2oGNsm9rATVY4si3z/c3caLXb
	9doEXSJfY4n4GDtEWuo99l6+Zsu3+Gw0IET0/VMgm8vX6NGzqgdziGSg99RiFt9t
	16EEKZfbska1vQ2mgE2gkVSyR95V2vYmUHO1kRS0NObNeBH5zZReQ/ISZcKEGmBe
	A3A4lNNI6I+xOA1WPRmmg==
X-ME-Sender: <xms:Br85aMHQ7tbYML4GK94Q49RA3RmJRyLYJ6-PoHc9h8rSwBpT_T0UNA>
    <xme:Br85aFVkHiuYjdzzbwhUge2a-mPvZKMtF0HQxmSIzi1uJ5Y2ybTNUh1FyHq9_5Ra8
    Mp6N9y7HAogZhDOcw>
X-ME-Received: <xmr:Br85aGJu0dWEwZzrpIP-O7O5XWrTM64irRHLyPCo1fPzaGZJr8eLM97WfvGEJgUDwHxyzYzk9KN0GZbqEN9YF6NOTmycAKPnLhxQf6mUJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledvfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleeh
    ieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnh
    htohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhmiiesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:Br85aOF3kzaZMrkRxexlSMTZqsAbtwIHM_D4rnv2pCGW3sdN6nMVMA>
    <xmx:Br85aCX1LZj9f6vkR5h6pQR0N6v64cZQgOtRLUGeG8g_XXZtVziebQ>
    <xmx:Br85aBM706ru7wZFdIs5PJnXj0ec_poMDoMXwT8ERvJNDFlfypFi8g>
    <xmx:Br85aJ3KJOVvxBKjOp4EEaWop8KB11OmIygU-HmMq4XAjAQ2XxT1gQ>
    <xmx:B785aFqoN2Kf6CagIWA5GSrGBCipK4-dktRJCo376fO1bvtgzCTVy0BM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 10:21:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53feb942 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 14:21:55 +0000 (UTC)
Date: Fri, 30 May 2025 16:21:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/10] t983*: use prereq to check for Python-specific
 git-b4(1) support
Message-ID: <aDm_AsVL5aebcG1o@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
 <20250530-pks-meson-tap-v3-4-676f5e41f2e4@pks.im>
 <aDm7z0PEtfzeKBI_@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDm7z0PEtfzeKBI_@teonanacatl.net>

On Fri, May 30, 2025 at 10:08:15AM -0400, Todd Zullinger wrote:
> Patrick Steinhardt wrote:
> > The tests in t9835 and t9836 verify that git-b4(1) works with both
> > Python 2 and 3, respectively. To determine whether we have those Python
> > versions in the first place we create a wrapper script that directly
> > executes the git-b4(1) script with `python2` or `python3` binaries. We
> > then condition the execution of tests on whether that wrapper script can
> > be executed successfully.
> 
> s/b4/p4/ in the commit subject and message.
> 
> You did make me wonder if someone had added some sort of b4
> integration into git though. :)

D'oh. I use b4 all the time, which probably explains this.

> Tangentially, with Python 2 having gone EOL upstream in
> January 2022¹, how long does it make sense to keep
> supporting it?
> 
> Debian Bullseye² and RHEL 8³ both have python 3.9.  Are
> there systems in our targeted support matrix which do _not_
> have python3?

I don't think so.

> It's not something to fix for this patch, but perhaps if we
> no longer feel obligated to support python2, someone may
> choose to remove it from the code and simplify it a bit.

I wouldn't mind. We still have test coverage of Python 2 via the Ubuntu
20.04 CI job, so at least it's still getting tested. But that is not a
good enough reason to actually keep it around.

Anyway, fixed locally. I'll wait a bit for additional feedback though
before sending a new version. Thanks!

Patrick
