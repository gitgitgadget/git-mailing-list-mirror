Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6E318121
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839953; cv=none; b=S5A1PT+YfiIkcg2Pjle70zO2aP3hpvzJWZ8uqOJScyA56kFOlkZiG7ULlg12ljwWlbkAzA/LpJGlLb0gFchOvE1xG94WEY017jWtQD1jb5CmuZDiOWaZcl4uBpx7axPQrcvQm+crIBPW3LCJ7g+OAfnp9imw/yTzMgOeAD7U9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839953; c=relaxed/simple;
	bh=U4qwy45eid5kmgdY0PTkLON4L7OIb6QnsZJ3cfIXUvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrsgENNehcwPyGlKg1HNsflXCLf77JPxwAxX7O0YGr/dcwKgO4PQS6DPjJbZbCFzBkcqbjCcV9D83gIAFTBx7w2cLYehUjQonc/qGk553uKB5n5Xjm4B4nRxKhcGTVzIsA5IH0nOlOe/8IbnWEkS5DYe/c/gIX2nHYIsmB87mp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qFxaBMjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OoQyuIMy; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qFxaBMjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OoQyuIMy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B5707A0116;
	Wed, 22 Apr 2026 02:39:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 22 Apr 2026 02:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776839951; x=1776926351; bh=zMO3auWolE
	k87wU6SlRZwSsThiHh5FCzrtrpoLV4yts=; b=qFxaBMjIIzNBJTD/xDMT/rQeAl
	YENZCFRS/Z3ZLKz4uxsXQecaAOcyJpjfK6WV80wXtGPBJI1S4MW7MCoEJz0ucRD5
	pQgo8hQOTfc6e/XK1ktREjhhlJXDQd01uaAlnmyzuAdd9iGs/IgMuwogJK+4PMzQ
	UqQXdGXBQp8fjoVfQBByEenZw0lWTsrAS4Z8J54dwfXg08jo9y7TxE1g+A4KOa3F
	kED0NcZeqLVLD3I/9X9YbBsHAk/8bjnVSrUs8x91zVoDGSIS6qxAm3Qyoob83Ixy
	0u76FAzDz3qA+FX8Q+rqMVKfgnAf922350GI7pFGdaQFP0NwOZqMVfUcwOFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776839951; x=1776926351; bh=zMO3auWolEk87wU6SlRZwSsThiHh5FCzrtr
	poLV4yts=; b=OoQyuIMyJI/qt4F/PyD/v4B8+SnQmE9nThxZO6F7mCynPYxSOuW
	FnhKxEAun44o3dtgoIoCWkbmll4FC66hB1njtZ0QB3dTLVHCM9OmCs2+OP0/iZ2l
	0wzU3NkZOUaArAKBIUrQDFzvy/BqmY6ui8Q/LNsIvxCEF6Rc8sKxKCTn8Mp0oZGa
	e64cY8CoeFeOz+dtx5tpVLg41zPFVrUo5ee30CrAQ9eh5pY3LZ89rROMgkmRiCyP
	KXSgQxCpqmeeF6+3vMFRYTMzv0XTKxjd2rct39uO/duxJH9MKoxTYAc4nzF+DXNY
	kf2ohBUEZZH3GzSqJZfbO9WLg7fM8kttFrQ==
X-ME-Sender: <xms:D23oadxc-I9qqkHmKHyIkKl_q6mj9eQKOyVYo5wel7mkl8HC_Nui1A>
    <xme:D23oaTTRkKufcGjzw2Erc3E-09GPdeyJ7TGmk6BS-sGU8rdIWdH2gV_4KFR-aqQ5V
    42bTJfpw9jDKUZdGSs7opMJ5cyTfP3BLlPVRCHoBYIUrawLOmif>
X-ME-Received: <xmr:D23oaU_B1lDrHX43-IactDsK1ACw879xt8YqrG6iCKytaWIaByP7HXt1b9aNF0fHyfQAzk0H7EFXqD4J-xuUgs9YyvS2m7Yabb7C5wwXloI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeifeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:D23oaaqRyzt4xLi7OXMPaalKGBfCdzxdJq9nInWGBqzGdEu981AuCQ>
    <xmx:D23oaRk_Cvko9kUKGOqCtwgT8hhWN2UX5mTZNlzan67LEDt5qHsmzg>
    <xmx:D23oaRI_sbRBpVdqzJQHadrF452kWNCUNz8O9vhAz5uaiUBypCDfOA>
    <xmx:D23oaWy5Tsp1CSDn3zIQMRwHszq9vKGwIHLdgkkrdnBweuHddqEQ6g>
    <xmx:D23oaZjFYE9Gh-18ba46O5NidIjDXP-8pUYGAd_DA6IVA_2fHMLVDLeI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 02:39:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d04efff8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 06:39:09 +0000 (UTC)
Date: Wed, 22 Apr 2026 08:39:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <aehtCrj3bnduxRlW@pks.im>
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
 <55bde257-ee25-4a7c-a17d-c902aa4f0324@gmail.com>
 <aecRW_nwBVM21CPF@pks.im>
 <4199e58b-d0fc-4240-9717-16c89ae73322@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4199e58b-d0fc-4240-9717-16c89ae73322@gmail.com>

On Tue, Apr 21, 2026 at 10:13:31AM -0400, Derrick Stolee wrote:
> On 4/21/2026 1:55 AM, Patrick Steinhardt wrote:
> > On Mon, Apr 20, 2026 at 08:03:44AM -0400, Derrick Stolee wrote:
> 
> Thanks for your thoughts on the earlier parts of my message. I think
> you're moving in the right direction and I don't have further comments.

Thanks a lot for your feedback!

Patrick
