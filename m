Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C509C370AFD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926823; cv=none; b=PqvdaZ6rZ9+qcVtMfrOt2BUclWbigUFbEqkqsxs7HJ6oBhnih3FSBj0WQMDqiIAH9Hr33sXYgGLqxoGe33bRdndXPE3TFSNKkzAiFfviuyFdOd/yED1Byi67fX4pqCvS3fkTtHeQyuQ7rUL9cpPfljF+9tZi9CD4hkmWGi7TU9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926823; c=relaxed/simple;
	bh=MnBFQnsPn76aB8wB8NINykoKDUbmV+bRagXxOsPCrBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itQVJ+zvjVIJG9HsLG7CIN5oy78l/vjlkh5/iRfeNO+6HyBd7GhuvAQyIC0dpwQWjQ/0y8+/bMyX6eItuXG3te5EUuN6RRaNYwef6VuOXZym/7dnU+jsoOA3+rUGDMY7KTf8pBkA52gWh6xrVzvSSnxZoh3GGo9KLM3fQ1A/V5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YHhbMxp3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHadBjgL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YHhbMxp3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHadBjgL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0ECD6EC0267;
	Mon,  8 Jun 2026 09:53:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 09:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780926821; x=1781013221; bh=trkImcXz6i
	u/vIMCrRVL2wKezqaMBXPYbIPXzNftZUM=; b=YHhbMxp310WD6AYPmL0zhNUZlR
	JRW4mjrUoknHDNXZ8YlfNL3E4QwW1WL1l5zHh5EnVxqOgOKGnakqXzrMJgTGdqI8
	QAjoNoHErmzydiwcyHwdKt4HfucMhyVaOzmfX97j3hMgQf/DE+//bvJ5qhKZAMyo
	JGj1BWF977kXCgH+NK4nweZvhuWzOThyCdNvcVxvLVGVCGVPN7kIxwRUQUNGIn+g
	og3roKW748U+4/06DCTcYq1EdUE4WA8kMKhlu7dycBZiX01d/6lH4w/4JsOYgcHf
	gzfWb1WydpL4IzYXnR/titouMxfvsXGbRoyCNevz6B6CrVGEf03IXJiBk/lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780926821; x=1781013221; bh=trkImcXz6iu/vIMCrRVL2wKezqaMBXPYbIP
	XzNftZUM=; b=IHadBjgLqdhb4TKWFxcS+tWFQmiEGwQWLOSdgai/y5LSXp3syJ1
	dJgmuAdrOuaLJhPcYXNepuBT4u6Uc/zEcbQyOkVrp/3mIDrU2MzrsxomaXkffWLE
	Q9JGWu9bb+d6zsNcoVW1Lq4XBO3fegUlngy/A6lKVTeQuVscNxgCBlyz2Vv5vGR1
	ejDEeV4j+6vjE9ulN/I3rkVmH+LQJ7hn9oWSOEgEniZU/DLSSHv3YIZPrN2+wSrR
	qqiZDwhukrt2P/jULSAEtdDmFuQypAE0l+64v13IoBIjS3zSA9jsiYHyN/LoHzHB
	aP4ROYdpJTUPQOYdcJM/fKCwCHju2Irl9Ag==
X-ME-Sender: <xms:ZMkmahtMW9WXrD-tPSJDr6a2NXFO0WTT2wvyCxAIvdVrH_JBdudJTQ>
    <xme:ZMkmahdqUtTEMakkftFsq3O5BmB37JkVekce1esgcYg3uKatIl9Oh6f-dGBRWsSRn
    BPGzSQo7TFA02CX34-XiyCd2aqDaGDD3GkF1xYQFCbOKIyzblg>
X-ME-Received: <xmr:ZMkmapzjhZ_qiWIyRM0wPOg-VKrhXNgbirOW1cPGYUICh2zjZws17uEWr_OYpQjXfDnIQsOdHK0OPvX7a9vHn3NJJTRgq2ozTtF2PQwMAw>
X-ME-Proxy-Cause: dmFkZTF61W8YYYM5DXrsUif1Rh0WHUkmXoR6PEdvmekQE5kgFkLNW8ieBBAQ54V45ST88A
    +/YrA0u8a+IqPQClJAYwkn6r2XNz+1twq0c+BaniCgsiXW9uEk4maTGHS4pPI2VqXp3uGi
    p5UTXiVWR74wgoW++R1kKlci8Gzhv8tVVORMydjjxe1gtb0mXX8QvNGzijCPEKTjDfW+Yi
    SYcvrtPBZsmU5AnRqYAhft7MjgIAHqKrFTvfjSS+YmlC6eaKfJBxqv7h55nIYJVq36Swrj
    Nh2ZReCiDzVVNfq2anW9gZC8vZ+6jaRnklXA/tjM8q71SKGlqSoOWrZ8QkNWkIFZOhCFYn
    pcO+/UWvZTqzZ7X/ZrS9gQhszNRDS0GqSaWUUNXtvSGDJCCu3tOu8oIXfkeMDjIyTKF/l3
    GksXcExXejdR7q3AcS507d8/LWfjDUWRgbn/5yADaEIMc5YVBTt8fwa3o8EMZ8qTQBEY4b
    ZKvCM7srhuoafWT1OkPSd4g+vr3YZR7+8JgoZQGu7A1JZSjQpi06DxrHe57gGcogHeiPLs
    CuYqx/8Twi+EH07KY4/lgASIs/sp+MSIOAKkATbgXpfgNIUSick2DetrETpF50SRDc8uuE
    IQRTG4YqBafhdnmpxrO2BTiP5JNq9IvSIJ3ecr9gjRdPF8GgIt29x3DkOumA
X-ME-Proxy: <xmx:ZMkmanEfcCsN7W5wpPkmnMRGRXctbgqBLK57zyX0g12M-f6HhA1y-A>
    <xmx:ZckmatweauKE1Vl9P78Eby64LDWAlHQWDil_L3cCdUlVBS1ROpoalg>
    <xmx:ZckmaosZT0hDX0cm990IIB1UObFRc6-SlqXZ-lKQ6eK3cSgcw1uxEA>
    <xmx:Zckmaq3Vr3hmxySUvz37SUD_N7SurccsgACHtuLi8SWVLrVaNQgz2A>
    <xmx:Zckmah42LnJf4axikAVayaM4_A9MyaJwlYSjaFnIxrgjZhqPlfGPRZAV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 09:53:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 724e61f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 13:53:39 +0000 (UTC)
Date: Mon, 8 Jun 2026 15:53:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 6/7] packfile,delta: drop the `cast_size_t_to_ulong()`
 wrappers
Message-ID: <aibJYIPm1gvjNXGV@pks.im>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
 <460d733feeaf2a94fe28d7509cc4128e9c0a7610.1780570273.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460d733feeaf2a94fe28d7509cc4128e9c0a7610.1780570273.git.gitgitgadget@gmail.com>

On Thu, Jun 04, 2026 at 10:51:11AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When I started the transition from `unsigned long` to `size_t`, in the
> interest of keeping the patches reviewable, I introduced these calls to
> prevent data type narrowing from silently failing to handle large object
> sizes. I also introduced `*_sz()` variants that would allow most of the
> callers to keep using that `unsigned long` that the 90s kindly asked to
> be returned.
> 
> After the preceding commits, the only places that called the narrow
> wrappers either no longer exist or already use the `_sz` form
> internally, so the wrappers just narrow values back through
> `cast_size_t_to_ulong()` for no reason.
> 
> Drop them and rename the `_sz` variants back to the natural names.

Aha, so you already address my comment I had on one of the preceding
patches :)

Patrick
