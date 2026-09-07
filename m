Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D333BB66B
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775242; cv=none; b=byNNF5xWgDiU7f5oJOWsUxCi8nNeiSAPRFcjzxgmT706gbcJwR9x4M48jt+pvPPx+fSERNvzVdCtqE6Mb+FvCVJzmxbN574rf8RAxhw1eogY3ca9/5GcUWKJYQ9Ixa5yah5/v0VHqpu29YSnswIE2+TGXJ8dTX+MJWmRp8sCM10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775242; c=relaxed/simple;
	bh=Us/00F8YhmSwC/y2Yzjjiy7brxGxIIPJvZTHm/M7fXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8YkA87BoGcdeLkQa5021e/whlqpRcaiArUHZu9q+UKPzRZL+NWLNTuMKHEtCQCmrunJMs6K3gLQ9YhMas6qCtPUW9rh8xwfcq5PYCn0FxcmXuJMz4uo6h2zYNa7CtHn8/JEs52D5hBlPzaUCeG3WkDUg2WwB2rwhdEOmGUCnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jRDy1biL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q8jU99Jr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jRDy1biL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q8jU99Jr"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C460CEC0252;
	Mon,  7 Sep 2026 06:00:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Sep 2026 06:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788775239; x=1788861639; bh=zKrXHTMaMh
	35j/OxuMyKzj7KBNNGOG7U7fcoVjrZ5bo=; b=jRDy1biLCLFMBvmV8hbpjIZzIl
	cMFDIcYuLSkD601RgMp6xMAAvaBeJBE05+txJYkkIp0HAjuCGMcmuRmFp7XNOUO5
	dbmo2oRXMCEensjGh8kzlA/VxukPS8q43XZ+PbXO+3BXqQgIen8CpB+QFpMFqhnc
	D8kUwPyQuz1wMrbscyKY8A9oBy+wQfxHs98yDfcGIS9KqDxJ/RNl2a+qDhGbkN/R
	oKimQXU/MQNaHm9MEOkwTx//PC1BkfZcxYtI2/uLI7CW2x6VeeW/SY1v1H7ds4Hf
	4a57C7HUivIpoGFfOPCBr0AuKHADvUsVDDHKaxFXvvusdi32rsCzfTM2VqLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788775239; x=1788861639; bh=zKrXHTMaMh35j/OxuMyKzj7KBNNGOG7U7fc
	oVjrZ5bo=; b=q8jU99Jr8hue0N7YFZX+yxC60oMnK4PthX670eydOIRIKXjtujR
	PkLVp5to6eWvAqNpgobxR7KA/BtkT1lMiHcx7lX6FGD/4EAvTRmsXQ5axe7mklIA
	Q6I4MRb/hJISFn+iCs5ZmyL815ANfyNnieI2j2i/Ax8YNFXLT+tt9UyRlxHlASo/
	qlexkDIxG7mLqNXnwAa0VgKE353z7KAmhlcFwX9o5Clkc3ew/txfz2HozDg7+G0h
	KQfqumc0gie+lQM6jhmoenL7EfUdNlwBx82HkU+H4eNLUUgdEsROi6dnsJY+6rZ/
	JQHGa5H7tEmjObiQJ9EcglDiuIUafCXXYBA==
X-ME-Sender: <xms:R4ueak3ORRpV1CI-3yIQVtxf9Ep8ltw4hkg-Z-Ty3WAD6Nr7FUmlqg>
    <xme:R4ueamj83437Dhpw63YMawzhjRVok_O71NRvpS1xbIXAC_jVyhi0XmqIMuYz5nIcj
    eqQJbo7Z0iZjQjDW2DRhusXg7WTTjU6ezpKrYqw6zFR8sKyWNg0ww>
X-ME-Received: <xmr:R4ueaqTwgbk84FAWlGnCIhqbWewj5XRJ2RZGjySv2xQDv-fXPkuqqQ>
X-ME-Proxy-Cause: dmFkZTFjtrdzRhHyrncbdeiuBHmzjYu3x6nT1nAxmZ1ASNF7F0rglmrx9obfSHfkyatjL0
    DAoH3k/CB15XYKD3QROZmXw5a0lLd0Dzly5UGJ+CpX3xeH4KB1jxaPy0E08Ym//P9vg3r/
    VmZuzalniYT5nxXOVGsTVL7sYtmPxITHJVyke+TgQuUIRCa/BIMY2qcG1DsQyS6rdpnGEA
    LxCSjsMFUuyIRX2GbIhWRBEMAUsutBGava0ZtUJnoQHXzcIFPgc/GT72QY/9I0Mw1Dqqe4
    F/YYMrPfZj8BtLfLg3hBCiYBSWEN4Ix8hYNr6/WDPUj9lMnnrAZS1yVF/UVLTyYBPGXrba
    L6T17joVdcM/wcF80Fil1xUXt7lNxbaDeRXvFkXrWdSJL/ESsKqWYskLCn8QgARzpsQytH
    oftWZkhqzc6wFFPSfwQ9aRkFQpW5Ij3CUz/7NYfPdPsRhMnK37lODG3/MjfIvd/kl2qcTs
    QMJMYG50grY87HGR1DMN8ybS/hqgKX9S+KsBlR9gyui9K8X9SCejBZSInevRupQ2BDKfKL
    19dUB180bdSadLP48R0cR3RqZERW9ysUgwrLgz0CR8NriNsn4Sq3jt4byjYqH5/G7ZDHus
    r2tDcJZ2Q0pQpiC8JpK5zUBlDV8MLxNdGitXO7A3u7A+XIk0qJ5VT0zhDmFA
X-ME-Proxy: <xmx:R4ueanhRgbKPnzeXXChLMqzr4c1PITQ3TTFmmWkNMBBmijlL3RRZ_Q>
    <xmx:R4ueaq77QsUodEhUQTQVoyK7WyQ8EROJUjXfA3zUznIg1pdzyeeydg>
    <xmx:R4ueakD-nB7PaPz24EOdJX73ZN9ljQyqJS39BaJgunKoL67gw0hoCQ>
    <xmx:R4ueahbLGGacW6vXdx4izgxT8311yX4WdAHTDoJfM2gnag8WTeAElA>
    <xmx:R4ueaqg41usqkUOt9uwfyS931ibgniI-Dj6lwsHVyTYOxRl2fF8hOvaX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 06:00:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 501cd61d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 10:00:37 +0000 (UTC)
Date: Mon, 7 Sep 2026 12:00:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 00/11] Fix inconsistent ref storage format terminology
Message-ID: <ap6LPf0Ks1xTTp4z@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
 <xmqq8q5h3plt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q5h3plt.fsf@gitster.g>

On Fri, Sep 04, 2026 at 10:15:10AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > back when we gained support for reftables we of course introduced the
> > ability to control the reference storage format that is used by newly
> > created repositories. This infrastructure has grown over time, and
> > unfortunately without a lot of consistency:
> >
> >   - The command line parameter to specify the ref storage format is
> >     called "--ref-format=", while the corresponding repository extension
> >     is called "refStorage".
> >
> >   - In most cases we refer to the "ref storage format" in our docs, so
> >     calling it "--ref-format=" is inconsistent with them.
> >
> >   - It is possible to override the ref storage format via an environment
> >     variable that is called "GIT_REFERENCE_BACKEND", which is not even
> >     remotely consistent with anything else.
> >
> >   - There is also an "object format", but that format does not control
> >     how we store objects but rather whether we use SHA1 or SHA256.
> >
> > So in summary, it's a huge mess.
> 
> Unless you are unifying them all into a single ref-storage-format, I
> do not see much practical difference between ref-storage and
> ref-format.  They are both with insufficient clarity and details.

Well, the important difference is that we don't have conflicting
concerns of "--ref-format=" and "--object-format=" anymore, where the
former cares about the storage format and the latter cares about how the
objects themselves look.

> ref-format fails to convey "format" of what aspect of ref it is
> about (among "storage", "name", and others), ref-storage fails to
> convey what aspect of ref storage it is talking about (among
> "format", "medium", and others).

In any case, I'm happy to call this "ref-storage-format" instead. I
don't care too much about the naming, I really only want to fix the
scope conflict we have with the above two flags, and be consistent.
Resolving that scope conflict gives us a path forward for introducing
the object storage format extension and its accompanying flags.

So with your suggestion, it would be:

  - "--ref-storage-format=" and "--object-storage-format=" control the
    storage format used by Git.

  - "--object-format=" would continue to control the hash used for
    objects. This is still a tiny bit messy, as it could've been called
    "--object-hash=" if you ask me. But on the other, maybe we at one
    point in the future we will introduce an actual new representation
    for objects? If so, it gives us a bit more flexibility.

Will send a new version along these lines. Thanks!

Patrick
