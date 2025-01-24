Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047E0320F
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737697612; cv=none; b=JDPbNYYWUFBEXhm1GQfeAexBH+q8J8+w6hAlKITsUEqrM+S1JMAl2ezgnfdspb8Lsn7tZGs0wgqB0X570ZoYYQ3G6e88cAU1PxQwibXaZ6F6GptJBr7tVmI0mKNzJZxgbfZ6fNkSS7FgXOKkaKhGh4o5vY36liUyJCdI0MybOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737697612; c=relaxed/simple;
	bh=YHGgXd+2ViUsl70JOnIQtZWeX1+KrH+Pp9uQxya1+AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLJFCLZGRpI8lLgMgHk55jf6UjLuj904Pq9/UQkrGlAicM53e6FYGJ3WcMLB2RRs5c1bYkVHwh1NGb/+anJTzEjl2PrVwKZLxOg6zabkMEUk2pKAeyl+Se67CEZyW1Ma6Bodrehyo08c4ywKTCbJZVIH+6GAyq7wGIeNOVvfYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lv0mWJ4b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWthjP/Q; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lv0mWJ4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWthjP/Q"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 88CAE1140191;
	Fri, 24 Jan 2025 00:46:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 24 Jan 2025 00:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737697608; x=1737784008; bh=VhZO6bMT+D
	HLODz1BMVCRhVp0/r8Rv6OxwqLThHSh5o=; b=lv0mWJ4bqpuWjLk9n+d2N62DMm
	lviCTcsZIKTXV35OGwSFu0k0kSFeIWXOpwNBVYKV8sksROxBtymivrHeXUfhPf8e
	ANxmsVbh1tYx1Ey72F9pPOu14RMxqQMbwpcthtM9mdCd4Vo7X1HtEvMmDG0b4Qlm
	dbChYbApk4xnW+/FlCXaAvzkCqsZp3i+jfr85wvg8cL+Xr8UDdyI5MkFbq9xY8XS
	Bk45rdr28Y8HqgOOy3aDm8pLUeLl0GHP45W20pFgpEDwkrGjVF+yZ6eVcAADYLVc
	mad5GFm9hJCV3Eu7xK5DDHpew0G/3RUbkOdmCmQNgXi9jkMcsFlZc7raFZNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737697608; x=1737784008; bh=VhZO6bMT+DHLODz1BMVCRhVp0/r8Rv6Oxwq
	LThHSh5o=; b=OWthjP/Qa/27sMJp3LgIQkdWPY1rRTzIxlZ/2XIXWO2cy29tp1n
	iz532zKfGgVlop3L2LValcdzrMUteaqtRTvFr2h+ZRuCeuVe9iTVLs435Emc7R8b
	9MGX43Pkp3OB4sh8raPhdVct5lVqJvWuBA9yoz2dc9v3ifcX6WuTIYhTkGAFHEWt
	VE5Hzmb67is8wZEjUKI6JQNCJdn6WZF52SRDZ+FCvd4bDvjIsWajrve6aWtpBX1A
	/H7/Cb07MP0waEocR3F/b009rx/OjZndRF7vr7UisbeXa2kzNLwRJRemvBFTBccB
	LL/UbQi+vLtYiR77oxWihbQRoCKbT3AqcMg==
X-ME-Sender: <xms:RymTZ8zgC62hKL7gBRkxgVEPMOi60xfulacNvd-xtUhdaNRuSwazgg>
    <xme:RymTZwQbDMa9XpEEKbWlLt7bZJS3ImaEv-U56ZzU7JR4De82dsvgrVfwas2GcBngs
    z9oCNwPUe_c3uR84A>
X-ME-Received: <xmr:RymTZ-VwfYrqXM_rwYl_NcbUuJKoYau84t7IDSg5G82NzkcJn2Zz8CCMPmEmvHxOR24kE3og5KXfSB3gKqNygsY4eYrx6_vWQUlK1_1gei7CUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:RymTZ6g71pj0_rAdDbkKjel_PIcsrzub9oND_ALc6Fyc1UAOQCkZwA>
    <xmx:RymTZ-Aa9HeI07tHb06c-oXvOL2u3bH2zW7_Z7QdNjkljw7X4kDO_Q>
    <xmx:RymTZ7JNe-qTcEzktdOeQ-oPrlIEDTkg77f4vq3DzttimzVV6PV38w>
    <xmx:RymTZ1CSAw0FMuVm2mKQ1CPDmxlZtTPUw1rut15zCqy-Bk1KU8fjNA>
    <xmx:SCmTZx8b1w-r9-DtlqD8eIWj6LDx3kl4ncTh8gk_v5FMxL5NBcXBYsPT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 00:46:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a5f784fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 05:46:44 +0000 (UTC)
Date: Fri, 24 Jan 2025 06:46:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, toon@iotcl.com
Subject: Re: [PATCH v3 0/5] pack-write: cleanup usage of global variables
Message-ID: <Z5MpOelecT-4ym7B@pks.im>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
 <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>

On Sun, Jan 19, 2025 at 12:19:25PM +0100, Karthik Nayak wrote:
> This is a small series to remove global variable usage from
> `pack-write.c`. Mostly it bubble's up the usage of global variables to
> upper layers. The only exception is in `write-midx.c`, which was cleaned
> of global variable usage, so there, we use the repo that is in available
> in the context.
> 
> This series is based on fbe8d3079d (Git 2.48, 2025-01-10) with
> 'ps/more-sign-compare' and 'ps/the-repository' merged in.
> 
> There are no conflicts with topics in 'next', however there is a
> conflict with 'tb/incremental-midx-part-2' in 'seen', the fix is simple
> but happy to merge that in too if necessary.

Thanks, this version looks good to me.

Patrick
