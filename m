Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5A1DE4C8
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033878; cv=none; b=XkJUUIJOxQzuArJNCU9dNwqXPHeoL9XRc/vPdKRpi/SMq+KBB03QOM5asUV4xLJ6yARH6dDjisYtR1H9IgK03IoVe3GotsYdWZMF0GEkoDzT+gpA3hsBj8KA8nHI7SCjvXo5qkkabGvF2WdeJ+9/HWbjgfRYCX9Y+c8btXGy3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033878; c=relaxed/simple;
	bh=uuYFlkNB99UpsrSfVpOYfcjySDLzPoRS4nBvT+e144k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnCUrdnrKc9M+Z1p7Cmgc5orjrkvKYjdrSCYtg3uqpEebQ4eJmOFlmK0LGg78lkq7cD2k3mMLnuwF6IdzkN9O6DNxu0TmLnS0MJ5lLSLhIqBVc8bHRcXMRUrd2yNLoqtQG/fVlF/7M9Lac4C+9fWfLQP2K+5Fw2Wj6PBAK513AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z4++13wm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=StQloEUC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z4++13wm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="StQloEUC"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 133AA1140164;
	Thu, 16 Jan 2025 08:24:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 16 Jan 2025 08:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737033875; x=1737120275; bh=iB9KnUPOMm
	POcDg3MaAT+BY9Jbz5A+wF2oM4xNhXeJE=; b=Z4++13wmYh5KkcmzwY7wMj4euq
	kpApejmT3+RfrXoUFC1xQDyG98An+X5NtMk0aWtDxX+q+4ejVbPFJ3omJ0CGeCwo
	A2XihF9MPOx5Ynwry2pSy6hVCY15iETSrn/pcDwenMqdthYe19R6BYeArxkQ3WhF
	CTy4M8erU06KN8Ht8s3hTj18yIHJ/ZsBDzuvZHjA582FxPyzvnPKnMfIRVfiwKqH
	1bTRpiU3vkQAwDpVzh4WzTTvOjzfqzEmZ3K+/Lcv3l8AyAa7WnLp6Vaxd2jETr5x
	F5X50xX3Zx74zKqi/OBZr+Ws33vUcd2JxozKwJ5BjFELY6Q2gZCL87qonjDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737033875; x=1737120275; bh=iB9KnUPOMmPOcDg3MaAT+BY9Jbz5A+wF2oM
	4xNhXeJE=; b=StQloEUC2H3qZTTDezliScSmP5KQCsSs6u02pYc9eRhIspkI7ZV
	DlD2NRVMqtJ2NCPcviF1wJDZAOnmenmMCchVl1X3DG9qXUruNwD9SDJf7hrvQMUl
	pGhsZnEFJRViCB1KiPm4wg0eV6KLLNXuzzYyTXvmLF/GNn3lKqyuWYc5PuLqgVEN
	zkdvZeZeLhoYZ6Q+vS+X2148RUGZIeAWce6GlvpgGngEfR0wgVq9vz8xOsqICbRC
	wUdzkdDYODmLqdhFNzXkVmALxoVD9jmkadHdG7KIwvx+EO5ZMsRe08rrXPbPabk4
	ptWZzbw0pKXKgxGPb9PXnfKkE3/uiNlwa2Q==
X-ME-Sender: <xms:kwiJZwZwoqXUG621dyJrhFsApLjvSxRlAYNL_5g7OVx2kv_fpRvHyA>
    <xme:kwiJZ7YyTTj1q97KlxoB5L_bsSeKIue0yojfW5SeAMszRk3jDcVKs_0NHhr8TaSlU
    u-JeSqI_UOMulbF8Q>
X-ME-Received: <xmr:kwiJZ69zlt9Kvmf_Mxtm_ThQ49VZeNMNNYkjs3Z2EoF09FCJhwGII0bJ_Q7e25WTB3dT9QKDR8zJ7owT_gX8cUC9T0IhF7hF3kkG5nspRvk8o0ffLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kwiJZ6rnNQuLVJuWIsHHkoBxII3jM4K8M4t-ALJmMb6MRPapQA4W_A>
    <xmx:kwiJZ7ojEm0WVwheUGWGCRpJcU6yosFAPjIQuTBZPV9Q65dC9czKSQ>
    <xmx:kwiJZ4TuMHmhqIgx-rg_nu2ORLEKCQzSEyScjJ_SJ2djRuWsPpxiHw>
    <xmx:kwiJZ7q3bVx5vDMjOqXmpDMREnkKkCJD81KWYvYBueFZTKa5feuIAg>
    <xmx:kwiJZy0uNMAlKMhPK1bOl-nKIfZGosTFF2Gmh3gwa43wdaq86Oyde4gH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:24:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b0e91df8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:24:34 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:24:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] pack-write: pass hash_algo to `write_rev_file()`
Message-ID: <Z4kIkY17fFDRrBdV@pks.im>
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
 <20250116-kn-the-repo-cleanup-v1-4-a2f4c8e1c4c3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-4-a2f4c8e1c4c3@gmail.com>

On Thu, Jan 16, 2025 at 12:35:16PM +0100, Karthik Nayak via B4 Relay wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
> 
> The `write_rev_file()` function uses the global `the_hash_algo` variable
> to access the repository's hash function. To avoid global variable
> usage, let's pass the hash function from the layers above.
> 
> Altough the layers above could have access to the hash function
> internally, simply pass in `the_hash_algo`. This avoids any
> compatibility issues and bubbles up global variable usage to upper
> layers which can be eventually resolved.
> 
> However, in `midx-write.c`, since all usage of global variables is
> removed, don't reintroduce them and instead use the `repo` available in
> the context.

Yeah, this feels quite sensible. We know this file is supposedly
`the_repository`-clean, and callers expect it to be, so reintroducing it
wouldn't be sensible.

Patrick
