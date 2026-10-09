Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE54DE721
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546786; cv=none; b=GVUslGEmeLxXCjDgOaJx8Na3pE2zXWfaMU3kNqHufotDalqPNngDXsoaFifEs39DMd3EKyVSHKMkBE2HuLdAlJunYnY3QcpACJnBGJ3MeOcu9EIP4gGO6bZe5OOfcqnuMmE9CMGHlltxPJXtMbxr9yXg7GpuLmh4zniM4shN6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546786; c=relaxed/simple;
	bh=dxP0y9Jjr6gsVOH+vE/NIaPscyNSNBCtCcuhPZyFhHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxaBfnjEPrleoyw8o+Efx8bnK9hAZfORv95eN3uOyi6xscQ/jK7HgdeTGvnpmO7gUDMaZffWyX31k9IlLIPTq4wsx4Nct5jAX0q4bbqSwYRk9zkODhPUdKoFMi/y5ncaHqKV9EoSx2XxPWCfm+PMci9wHMnxpw0dlAJKZz4GGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lS+cnPv3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCSV5M8C; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lS+cnPv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCSV5M8C"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 76D93EC01B4
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:52:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 07:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791546774; x=1791633174; bh=3inY3vWn+j
	D5QOCNLmtVXYCHzQBp3gr7XUv8TcNRVL0=; b=lS+cnPv3suNKr3gw3DJVlVWl2N
	n8PA5H0Osnuzk/+ovkbnpNkfx1urZDONObfDRX+mHvSQ8Z00R4Redfttxn29k5NS
	lpxf0zxh3JMn/b5JuOYJgbl6Z0vjEnWGqqQll4QywFOA1DTcBRwLoLp5K2vnCljb
	mLWPz12NM7+EbXuRECSduy6IRRLRcCJkrudCj/Mgj2M2Ckw4r3+4vKU+LZ7otamd
	m7WvZq+4rW+VsS7DDs6LEcFj5BjWJK5D2ZgpXg0wgh5t9+lQJl+zt9MQjyNhXSpv
	3rFCmLPbXMenfXt1LWWiFEJ4wG+bzxyUE8H3U0n9fCQ4UyE7nlBYzgimI0QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791546774; x=1791633174; bh=3inY3vWn+jD5QOCNLmtVXYCHzQBp3gr7XUv
	8TcNRVL0=; b=mCSV5M8CtDu5O+QNE9owKWssYah/z0TDJ1Evi5oWkKwfhYvSk20
	aB0DHSOy4Qxc40wj46IDk3d5hztuwYga8Q7v5X7eN/wI7z05d6IxmYwEbVZxlP+d
	HnXP8sVhw4FjdtZ33SGFCrKktu7z6Mg4z0iJH2+ahYom3zrIqkO8YXBs/H342eBj
	K1ncZ/o1mtJNYhh8NYaDeb7nJZUDP7NLgcNWkbRdcF7FQY6Nb6GRru5B0pgLYE+L
	SrOwKPogmCythQFG34pvMxAtahZ4ZpkjiBGuCgGkVf2KlUapzHgkiv0ux8BPrqH0
	SfxDsK3GZdHolIKuO6/dGVENZiRQDnf3lvA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791546774; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GpOOy1JEyNoJFvycKlTINq78KoqTikQQkWWHY7mWgCn7hTa
	B1tAfqTTcBvC/mVJymBqAcPFICbNT1fEVycA/cnwUAHIvA96XPPAl5siDmZk7fIh
	i/1fVchmVEgN/HdVvcD98x15BZe8BZ0oqOWOJnPbGHZCFfvrMUgDf9AeFPKDy9B5
	qmzQ2I35dGooND1fcIwPb9wf0Wtm8HeNeBFp0Tp3R9F3vvOsWWfJGpIdufrfDH+s
	yiKIRD+N3LgwjrArDJ9Cxlq7frmLrALwecCblRXtRExZ2T+e+u0BTAuXxKv3HclK
	41PNnWYlcV8Ppna10mAqccc8kDfaBYbnsvyneaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2/07KyWxshTPfkbx89WAwl9etukc1xbjxGQ7m6P1lgE=:dxP0y9Jjr6gsVOH+vE/NIaPscyNSNBCtCcuhPZyFhHs=;
X-ME-Sender: <xms:ltXIalkL4k5uQj6O_SxHAw3QNJEXBUH7hv7VinXc_u80a09KrJhTgQ>
    <xme:ltXIam1qECk2zpO7uyl4plkrbT8-lIxjeP7R9KKYw0XmKYZAqdXoya9NmEh9NdY8M
    F4v8B9Oh7ECI6C7vDmGpEBrENikNBHEXAJbRFtfcueQWTZ0fRag5R8>
X-ME-Received: <xmr:ltXIapQ0YBLR5CxbpJWKVfSa2ZGbW7YazUOx8X0XP5_LtbmQIsuzhW_YTj03rsHEBtEBOg>
X-ME-Proxy-Cause: dmFkZTFe5QZUFYKh4K9uCRNZy92yq5pGyLqXA+dE9Nx+H16+ifvXvXJcnfuCCd7oLZinID
    uciXKbx2zt4yGoqbuT6y4Y2iyegDkfpMS4b7jIk0ti/7T4sAWmUhQWdhoC3AkT6l+KMbCr
    1DBlmnKxENy5kfUkE+yJAqkOEogrwbMKSQBvzAeiZGAigrHjSaoWNEfj9T5TjLqphzzqKf
    EmTPwgObgOhwGCDz66ka3qbIjFa6Ce5Dtl7aS9+Jql3PcJ/DV7zQNJs1q8rWYQYOyi4p5R
    1OD/9UBGFPRNQ9coB7EtBIIohUVRM3zNy6gE0thpWgh//mtzSaCtOApy9riPe0Z8LzyMPa
    FbogXEBSaupR4IU3QYy5VMPbW10z2X0Q8Q9WIjeMkUgQEQiqwvR+5PJUqCICKEP3UacbHV
    QLajWFBd3flj4KaxrZ8qJM1phNUjPbQqVxXoCS1zgLP2py65pu/S77UwbfRIK/O+0VQ30t
    SF7U53kV+U3/xwHBzHcDr6rlxpPmawX/Em5+N+ezABZbZzvmbpu+0d7kEOz73suyfk4Teq
    YiNXaF/Hnhz2Sc/iIMGhUPz5Ii1KM3oQr9npdFSm8UrSYBQVzHrfy0tMH8Om8DGxXwv+cD
    Dvcr4zpxkOPVH0KTdjFIz5FrRYrsSJH9RYNJulWIoCxBlwcRglOnumiJfz0A
X-ME-Proxy: <xmx:ltXIagukfTqNd5DWv0mut54WAZZquRFC9WmfdvMREWuL-Yp93LEKHw>
    <xmx:ltXIamY4y3Z4xYBI2QFaoN7qkgurh-UylrI2EiJswvCKkVX7R_hkBw>
    <xmx:ltXIatuS0jiw2GmNqd4OM_e-7HiSnQF_nFZrM1f22Bw6CdqnphEQhA>
    <xmx:ltXIagH8EYl0x-N9Gyd3hK5CI_eJotStbUnuI4fQRagtYb9Fsft4gg>
    <xmx:ltXIauVTSMNpiTSVB3PC9uN90_GeDVitnk40NvbODKUUhzT3Kl6YAzub>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:52:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 072fa693 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:52:53 +0000 (UTC)
Date: Fri, 9 Oct 2026 13:52:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Muhammed Dilshad A <dilsheddilu123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mergesort: move tests to Clar and retire the
 helper
Message-ID: <asjVkwUYJI6wERWf@pks.im>
References: <20261007034205.32619-1-dilsheddilu123@gmail.com>
 <cover.1791365181.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791365181.git.dilsheddilu123@gmail.com>

Hi,

On Wed, Oct 07, 2026 at 07:20:22PM +0530, Muhammed Dilshad A wrote:
> Hi Patrick,
> 
> Thanks for the review. I followed up on the larger cleanup you mentioned.
> The sorting tests now run in Clar, and I have removed the old benchmark
> and its helper. This also removes the unused generate subcommand.

please reply to reviews individually instead of replying in the cover
letter.

> The new suite keeps all 1,680 cases from the old certification test and
> adds checks for empty and small lists using both sort macros. It checks
> sorting order, stability and list length. Cleanup frees the backing
> arrays directly, so a failed assertion does not need to walk list links.

It would have made it easier to review if the new tests were added in a
separate commit.

> Changes since v1:
> 
> * Patch 1 is unchanged.
> * Patch 2 moves the tests to Clar and removes the unused generate and
>   test commands. The sort command remains available for the benchmark.
> * Patch 3 removes p0071 and the remaining sort helper, along with their
>   build and command registrations.
> 
> I kept the leak fix first so it can still be applied on its own if you
> would prefer to keep the broader cleanup for a separate series.

I dunno, I feel like that's not quite useful. If we didn't want to take
the broader cleanup we'd instead apply v1 of your seires. In this
version of the patch series it's plain unnecessary churn because we
remove the code anyway.

> The Make and Meson unit tests pass, and the mergesort unit suite also
> passes with LeakSanitizer enabled. The production sorting implementation
> is unchanged.

This information is quite curious, as it makes me wonder why it is even
noteworthy to point out. My basic assumption is that folks who send a
series to the mailing list test their stuff, so there is no need to
explicitly say so.

I mean I of course know why this is here: it's the typical "let's check
all the boxes" output that AI is so happy to generate. *sigh*

Patrick
