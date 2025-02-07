Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898342AB4
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908971; cv=none; b=q3VBkZXlaG1hNL82mZ5okVEW+Zvxd8b+vGR2S8LupNufHEDTi9XUSuzfkYXzrQuA/APdndy7td//0yBemZ06vhSmKf5QK4yOInApenSpzWuUCxUNBMqgiU+HpPN0zHBnajqYYwRQx9vH5sFiu2nmJZXDqnKTNFTpwwejQoTEm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908971; c=relaxed/simple;
	bh=mq2g19Q5TbTLyjE3aej5DVTyu2t617Pc1IwN6PEalT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpuDTURW72rqPjuhuPzotImB957qiaT1WoCDrDqGnM608uV9S97Yps71RvNhlQce2yJFSUlE1GfYJ5VEv32T5Tvd0ZHPy706iuyQOKv5QrSflg2qudrU+CyOS19GEB30Rj2c2ZsQfvz5cB1l8CGRS2fjVO70CuRx84u+O8ZuvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gjdV1t++; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uWUpkNl2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gjdV1t++";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uWUpkNl2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B81D813801C4;
	Fri,  7 Feb 2025 01:16:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 07 Feb 2025 01:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738908966; x=1738995366; bh=TnbkXgA4Pd
	5BDQ+ZZLfCjSK33sdf8XpcQ4pWGt3AC0g=; b=gjdV1t++9T4QrQdzVGjyfXOW26
	ixICPAztGfUxYhoo1an/Un5wRa+2dp1KBx3JT4aWwOOsrvOsqNOx37XUhJKSVImW
	P43/BRPbiELzUPMt6cUD9b/BIqz3zeSOvGa/5yCu2WuAGl62n3uRs2ER2nrT5FdE
	adz5LgEoqpfGiTM7z/4uGpUDoTjMM25I0cq1C0qn5bzyHbe3Z3O2sbvzeHQARXUQ
	eeRk8uOqOpd83zvOicoPGj6OZk97Vu2b/7uXZy1DCD0kuOKd9Dk3szBett/0AcwF
	HlLrzQHw8tV0AxnbazDgKYgLetJp+jnW0YZ3i0VDs1rUYgQqYWFmOjHh7d+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738908966; x=1738995366; bh=TnbkXgA4Pd5BDQ+ZZLfCjSK33sdf8XpcQ4p
	WGt3AC0g=; b=uWUpkNl2iYhPL/pgCVJlN4Dv3yJVTLMVmUxOpYQDyddktdxvplp
	ca/NVSVjP6vkqGPSjxZq6QR4JiRg6r+D3PygnMkEztMZNIaDB9FSLM5l2cqDnJ7t
	UJMaa1Ljvbov38ceaUJJ5iWerI0yI82r/2pwey7zxbZbomHiMapriiENuX3uz9m5
	kWfR4tjbmKZjdiYupxCCDF9RHHEwSBDrEst2TPC6K/zrlUlQYYaOwBvMc2Rc1+kM
	SIsKuqT3e/yafQAtHC66SYaLkJp0j30q7kb+VHjUnO2COMnSANy0Ri+mwE2K5Zd+
	S4BXaFYZifQsvgTG1Bpt+7rY+xSMP1cx5aA==
X-ME-Sender: <xms:JqWlZ6F_8jh9wMx9kn9r8RjuX-nSABllPmuyzAdPP313w-euUbJ0mA>
    <xme:JqWlZ7UZTay6H77J8DKHBV-_SpKtVoHRH6xSzQ0fT2BZyjgBB_NGxBNn8guNgwAqE
    gB2XJMSKlabbobdIA>
X-ME-Received: <xmr:JqWlZ0LoKEJlzl3-hjFLZCKx6wU-HTVAkcMVmPKXDUGihjWcalYoaA5eJ5m7rkDogM50EMSvZcA5idPk33lu-SnD2my4T98vmB1EZrj2Dpi4gLAy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JqWlZ0Gc0YnQIXnYu9tvN75A1Bggo4BolHE90Fq7DDSTK0heVkiWiQ>
    <xmx:JqWlZwWy0abv-Me2ChgLy-lUjAZdSj-ydNhI3ujEnhyBluxmjYTPEw>
    <xmx:JqWlZ3Pmu2CikMvPFQgwy3orCDyKebb3bKVg08u-jDggqE4heOoM6A>
    <xmx:JqWlZ30Crp9hnqOEuzaSiikeMaAGHrI2dkUFtcL63v9fvfSZzU6LZA>
    <xmx:JqWlZ9gaHVGdpA7A0L5iEJKKAbC3KNGDu872qnoyIZs_rnnKkWvGTfYz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 01:16:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0eccc1e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 06:16:02 +0000 (UTC)
Date: Fri, 7 Feb 2025 07:15:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/16] path: refactor `repo_git_path()` family of
 functions
Message-ID: <Z6WlCg8rP_JCKulR@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-2-4e77f0313206@pks.im>
 <CAOLa=ZT8CrZA7Se98XBwS1CZjgvFFtKj5SBQfJNkG48QCvB=JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT8CrZA7Se98XBwS1CZjgvFFtKj5SBQfJNkG48QCvB=JQ@mail.gmail.com>

On Thu, Feb 06, 2025 at 03:53:59AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > @@ -241,11 +228,14 @@ struct strbuf *get_pathname(void);
> >  #  include "strbuf.h"
> >  #  include "repository.h"
> >
> > -/* Internal implementation detail that should not be used. */
> > +/* Internal implementation details that should not be used. */
> >  void repo_common_pathv(const struct repository *repo,
> >  		       struct strbuf *buf,
> >  		       const char *fmt,
> >  		       va_list args);
> > +void repo_git_pathv(struct repository *repo,
> > +		    const struct worktree *wt, struct strbuf *buf,
> > +		    const char *fmt, va_list args);
> >
> 
> The only thing that stood out to me was that we loose the `const` here
> for `repository`, I couldn't really find a reason why we do that,
> especially since `repo_common_pathv()` right above still has it.
> Everything else looks good in this patch.

You're right, there is none yet over here, so it's pointless to adapt
`repo_git_pathv()`. Later on this'll change because we're converting the
"core.hooksPath" variable to be stored in `struct repo_settings`, and
that'll require us to pass in a non-const pointer.

I'll shuffle this around a bit.

Patrick
