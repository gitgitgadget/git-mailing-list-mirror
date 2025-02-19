Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323E1AF0DC
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944405; cv=none; b=JgxKAel8Hv+HWU/y9gVJSGXPzgFy9eep6egLOIak6ZKApuyCy7KSlapzv1cszf38z8IFH+h1ky1DY1+n9VvpgViZgWPl0i0nfIWcfr6COYxStVjixK9yvkGu6+mEbs6uXjnxK55mWPgZrz4WyqYXh0iyIPqYPd7DHT/KFlwLe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944405; c=relaxed/simple;
	bh=cZeInQi4cussiCKC7kIDPTQOpB63odjyhTck0ybhoUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfy6i5VzFIV7GZ8KNN/egvoTIHisNQY2rb/DZMUoo5o53ug/cI+M771bTgXFoEuwQLJm15f9LHXg+vA9CF5N7J85o69NIiarS0PH42g7YHinoKohyCDYivyGTHFTDw9H3XJMTumR29L9OjxCr5d5HY+u+wCv0I+lCyx6PMOsY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I96RDa7h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RN7uKC0d; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I96RDa7h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RN7uKC0d"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E58C254018A;
	Wed, 19 Feb 2025 00:53:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 19 Feb 2025 00:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739944400; x=1740030800; bh=j1UNnpqaJ1
	NPj6gxAGLZKFOcO+Cg5TiUcwD3TkuclFc=; b=I96RDa7hYRssvw3x1BwLhstLn2
	rZjUTPWzvAkelpjwQrj0l8bVWs9EGIv0GU77bLaxtpPXyJAXKxoR4nqJirbbBaoL
	IP8hLCMZmgo3SFpGKVDrymc6m/OPTJxUPIvmz0EPIDH8rrdZ/okoLguwv3KT9QVn
	kmxLFih0FzcS7lwmtwATiawWyfjb+fhURTJ+Cm1BnD6+Ri28tXmrcGWB3FMcrqaa
	HT5F0qxu+29AWwOC8SSIrngOkJB/PhNyQmnBMbby0NwYjNqE+kd4mpaFNDuyxtJn
	L+c15kAHt9tqW5+jwPVp3apiXiGjmQ3EQet+eZd+Kdv97LUGe0L4uvpqH5eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739944400; x=1740030800; bh=j1UNnpqaJ1NPj6gxAGLZKFOcO+Cg5TiUcwD
	3TkuclFc=; b=RN7uKC0d55a98+AR46Akh7yXrjlbDq6Bv6SWNXz0WTk2yEcjC+s
	1ulBQ1S6PIc3X+okr3fI1QultSV4sDcXY6eFriDyEFF5bP7gXgZaPXfPuBZZrCus
	gm8EPSF+6W6lyEAI1rrgN2In8k8G2h3tTO1QZDMi/H1xRt8xSz4XY9cCM6Eg8v50
	IlD9/O1TkiX3N7kFXEC7PyaWrI+O6V1vw+0xBYDHXDIyR/xzEz3zTbMy2vj6NvjI
	gV+iKr4Z1NMS6fDkLuCq/XPRfdt83vYDAXh2Lqhw5HSzhRMmx7ywX3bzkaOKEofj
	ACSzx5/EWcSM9P4+K5W3HM9eLvnfzrIF2Qg==
X-ME-Sender: <xms:0HG1ZyOzYzO-wLn4xH9ZOIr9vsxJqIdEXfeIpVJembeLvUwcDHGsEA>
    <xme:0HG1Zw_Unjp3sz_-KKAb-RP9o6uqbaZfuuRwi6FbmS6y-7Fw7WYQbr6yTO-2KwAa5
    VgC3uoY78V4fNno_w>
X-ME-Received: <xmr:0HG1Z5QcWh_cbfjzDXtkZwPRFU3sYzgvvVEEoRijjrfd7Qg21Y6ZefTOvmSPfBXRbt6OJnVMBizYDt1_m8gEJWe6XBfeurHZy0gDlIFJZbQWeU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:0HG1ZyuPXkTs2foW4LrTqgQ9pEh-GCuWwz9_t9cXAmypFLZs1mYK3Q>
    <xmx:0HG1Z6dby5K2YyrjOpgJFr9IB3KGbvtVCAI71U2pqlOVv7nVmW6KAw>
    <xmx:0HG1Z22syAUlkO4sHnj-Fy_-LmpHkcLLl1rOqkaXMziyxmBu9glOZw>
    <xmx:0HG1Z-_pdK4rAps8dOJlT-he4Wt7SGRtkRgG5eGtNjEQsFEdqhaL3g>
    <xmx:0HG1Z54n2q-FkzBC5onuAGwS-j9lQA1emkshFLHZ_xmcdBj26W9JQfmU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 00:53:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 425b5c4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 05:53:16 +0000 (UTC)
Date: Wed, 19 Feb 2025 06:53:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 09/12] gitk: extract script to build Gitk
Message-ID: <Z7Vxx_yQSMlXfteX@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
 <20250218-b4-pks-meson-contrib-v1-9-c3edd292beb8@pks.im>
 <xmqqeczuj3fc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeczuj3fc.fsf@gitster.g>

On Tue, Feb 18, 2025 at 02:25:43PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Extract the script that "builds" Gitk from our Makefile so that we can
> > reuse it in Meson.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  gitk-git/Makefile        |  7 +++----
> >  gitk-git/generate-tcl.sh | 11 +++++++++++
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> You would want to coordinate this with Johannes Sixt, who may still
> want to maintain the subtree arrangement.

Oh, I had him in mind when writing the patch series, but thought that he
only maintained git-gui, not gitk. Must have been misremembering.

Anyway, Johannes, I'm happy to evict these changes from this patch
series and create them as a pull request against your tree. We should
then also be including the project as a `subproject()` so that it can be
used standalone.

Patrick
