Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7C3B4E9D
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731315; cv=none; b=sTjvm1Ya8IXxs0DAyIP/94Ml4Hdvo2KWIXaiUKJlQyqbBbrq9NdyKq18nsbKLYmTefrIamMiWa6GytkSewuk9klWH8grJQyNSshy9C4ylBFNuRzoquFqkSkHeri+V03r/sDHn2KeRm2wCCfGUN3MtanP5Jjm/xZqIsufIOAd1u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731315; c=relaxed/simple;
	bh=qRhN0rhQOIV4gJJcbhCIKtpb6JfVm8DcrdqkUc4diCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+PSA4eBuCOSn3FuPx2wZHUhofdkr2yOPqebwNdNnC68X3gUH//QwQPsfGGHKjXCjoF2wcwW5ejie06eO1MTxtwML1dB9Ean86OX6z8u8xtUY0ClOFE4l0F3zD1e1o93O/8Jt0OuXTHjRDnA/NplL6PmAy5HMfvTFSNWnVFM5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jCC/ljiJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V/pSPPjN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jCC/ljiJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V/pSPPjN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C47461400303;
	Thu,  9 Apr 2026 06:41:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 06:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775731313; x=1775817713; bh=bu40UJNa5W
	pp25JT/fWpnrIBDx5I19YF83ojJyZnlvs=; b=jCC/ljiJsbxyMGExDvWTc4p+d6
	caGKPKllA22vJPeerLNDfEbV788tBj+hSVbVU50YFyZRcaDbNZs5o924aW7WEkUT
	UKFnyXxYICvin0je96QbBmkLk9ppEeDdx7M4i4Jtu28DfVlQmk8bNuuLuG98WOAF
	zUD/hEJYLKsEnXn1+6pVYv8S1whx0V2pjjd0dtH0tLNGIxaYxLxuzSO1GJ9RtNMp
	Uvgcs8gpjpTpUlfVQQSSGvm2joktajf/UbBOoa+j8hbUqZTZiVqdswM8sd+QRlvd
	9rMgDrOQKHHBCfAkEKzHfRDB9L0k5rRLpTkMOJV23vdmw1C3SXEO/GKS1T5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775731313; x=1775817713; bh=bu40UJNa5Wpp25JT/fWpnrIBDx5I19YF83o
	jJyZnlvs=; b=V/pSPPjNFIQw7p+Dqm/T1RDneA1mgrkXzRmSIWkv3ZmLxy+TIZ8
	mBHpM0hFKDbAZABfigp1ZpIJNpAMvqLNko8qW8hKxxJ9NdPtyi5rjI9YkQR8hncA
	krk3L+GVjcjrjj4DyJN0FzUxBHpGclEhlNMX6VPR3jON+ocmIFz7FbsOnjrGbo+x
	liIKg+D5sVQ7SA1HIbmgNLUFPmerEIUh8bB7ub3KzkDVG7ysPitkp2TCc88ipvyM
	9xtwd5SrVHm5TW9OQwDxDwd7aujgW3Qjmyg0GmUQc0caZDyd/+mTUw3kKXHhsu4o
	OVhI89SXIrd42qGEdMRQvLHlR+j0BlzkTBA==
X-ME-Sender: <xms:cYLXaduSi2hOySUTtojarDRYcC81iKMHEx9d_7JNJCtceRHgaRKQIg>
    <xme:cYLXadcJcZhcFyosb9qsQKScYOlB4aUYxv_3Hvthu2af-Xc_Mt-qvFJRvNosdLr9p
    6lbsPnFVEi0kxJKbs7ZHVQf-vkTnRWnjExkcmXj8M638zRggAB4>
X-ME-Received: <xmr:cYLXaVxoFmmXoh8PH8aqS9GQhoTH_L051ZOqKBXmM8jWNz9W6_ubQLQaSoOSETraZPIs9EcT5f3oDGwh3mkbzGIXx71MdBtcrr9jWGG7p1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddviedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cYLXaTElPba1uAGzqvXNvpe245SP8_l7CIjURgl7fbvB0wFriWKO1Q>
    <xmx:cYLXaZwR4PtazJodCZdTfT0gAzdxS2TlUU33VNtflnOG4zI3h41-hg>
    <xmx:cYLXaUv1n2A2xkNEu7MVGo98x5drYiyMa64mDRw-B8EVc_mKbppf1g>
    <xmx:cYLXaW3mi40SjfSMNFi3JXwCpVaa4qipMwkVYz5s9n8YeQrFmlM5Cw>
    <xmx:cYLXaZQZ0b5kfGpBr6CqwM2-76KHX5jef51ClreD1tgst9OoitF31dOb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 06:41:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 417c8e38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 10:41:51 +0000 (UTC)
Date: Thu, 9 Apr 2026 12:41:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 07/17] odb/source-inmemory: implement `write_object()`
 callback
Message-ID: <adeCbStzfZS40IYj@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
 <20260409-b4-pks-odb-source-inmemory-v2-7-f02b4f1c0f13@pks.im>
 <CAOLa=ZQHyhDGGLLcGBjFwG9FOtvjpyjgmrnOO_u3rwZyAYoDHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQHyhDGGLLcGBjFwG9FOtvjpyjgmrnOO_u3rwZyAYoDHQ@mail.gmail.com>

On Thu, Apr 09, 2026 at 06:27:27AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Implement the `write_object()` callback function for the in-memory
> > source.
> >
> 
> rebase error? Seems like the commit message as the last commit.

I saw the empty new commit in the range diff, but somehow didn't get
what was happening. But yes, this obviously needs to be squashed into
the preceding commit, thanks!

Patrick
