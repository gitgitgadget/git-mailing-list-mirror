Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E21B4130
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735886598; cv=none; b=EMOfjUSjEROGSwsBTDF7FntlD42kKYJHhf2bn0oG2ACuG1DbPkKsYHApM1/RXXK7srZQqMCjP95fBbIDJpknIF0yS/nXQAVA8oMZlHPg0J0F+DlURsBlxrZQRtSrQJSJqJNDLcjWLHY5e+tx0zlh4cQcRRjofOumkjyCj6WCJRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735886598; c=relaxed/simple;
	bh=hrBUWd4KD0cUSrfgT0lSLnfMHyBpaxA7Bl7kVDi5z7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MorMoMO78YJXHF2bw8bYATzojE2jtdzqHPV/ndBMRHF+60w6gODeo/Fw0oA5pIvz4Z2/FCraQuYA3gYGUq9WRs1mdupzHy7BdZyyJzrCQ7wEmJU6f58DL0lGLwyCp+n/vDwFSnGuYbEcEksWLI+VbH/okYhmhsFYSJB8n/hbBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U+Z7M0+k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TrwBcmKM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U+Z7M0+k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TrwBcmKM"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D877611401B6;
	Fri,  3 Jan 2025 01:43:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 03 Jan 2025 01:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735886595; x=1735972995; bh=qBkzCYzaDJ
	CcL8WOj8sDDbVVwkpWwKLXnSz7B8yJIOA=; b=U+Z7M0+kp52pDtyiB0BI0V9XDJ
	qg8fqfwzEMkO+HQQU2GGc36Jwc/qKZhj+ODr5CxQGgQBboOcyicZjJtAKEZGsDlS
	yoAaKU0P/n0HMmtNTzoDu1tcyoyVNvFkVcrEmmgwzlenxoicdtWfvp6iwFvWyUNj
	6UrJCRh/cERtq7uLGceeUlWQ0rb2PzhLHI8Q6KUHIH2VZ4nYcXtvVqZdt2Vfk//U
	93JHg8vI3JGsm0s3qecawPcAkSKHjSvPybHlWsHE3DrdHcUnjv3zLUgN1Oy7hCHy
	2FynEutYMZwEiC4gERlCkcWLnt9bG9P49LXJg0EN0xvVsnTQEE9QU9sOnwxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735886595; x=1735972995; bh=qBkzCYzaDJCcL8WOj8sDDbVVwkpWwKLXnSz
	7B8yJIOA=; b=TrwBcmKMpwKjbve3AEgwj2QIdi5WLxVP4F7vJRvCS/ATNBA9St/
	sI1yRO/tNBB7VLi68qXXifYaUZ1p9DRh3RudL62cjV4G4GVgw5kJP4nD9neUeaQh
	8dG9//LlO1J8fp4MQ5E3Inj1SQWs8rwrUy4AsLyh19ki2jOoIXkQyfjr4yDKMHlG
	egOgb+0UkBbS5GX5V6f6SrRIfenkEFkjfIm7AWgt+5sSFvk3mtiscyND9v4jgkvA
	j/Ow4TkRmaoIkJuUKhrnleo/3487RLddA3SNDvsbsz1bFtH/07KOEVP1ILbi9AIk
	5dtQKWfPljaDUjYInti4Z1z6luCa9edxFwA==
X-ME-Sender: <xms:A4d3Z-Wi13Gf1RnWcwLLhF7mTgL8_O1q_Xle21yX8YohRhTNOWwecQ>
    <xme:A4d3Z6k1PD48u9NvrfEDhUY3FU2cS6YM_cltPCJq83zS4pWkWTv9Nyt6wy_3nSpSZ
    va04IoLpUQAyi31tg>
X-ME-Received: <xmr:A4d3ZyYHBZXyS0th2giCVINL3DHKCY9qWX5XUeeBovNR66Qylkgc5QyeL-9nIckz891G1V2r7V7gUEaU2f2ase6sJb3IDKNL0aX_wUETkNvQfhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:A4d3Z1Wbe8cb1T3VOfBBcrwYXgmf5idvW-lTOWLv-Cwadd9x0-VqDA>
    <xmx:A4d3Z4lFzyEViF0HBDmUAvmmiZ188AN-dN3p3wpeDgL-BQrueC8j9Q>
    <xmx:A4d3Z6dN7AbPCVeR72GFN59ETsS3cVDK5iyBqtAhaA-BNtQnlMBwxw>
    <xmx:A4d3Z6Gr8hqBJWXwP6cg_ye-kJsrHswxhf1JmKJ8HMbn4nb2EfJ80A>
    <xmx:A4d3ZyghfIAx79K0TKadQ7_GdrE96oTyqMeg6s8hgB8S-86XlrySHDcc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 01:43:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d6ca0c81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 06:43:14 +0000 (UTC)
Date: Fri, 3 Jan 2025 07:43:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/9] builtin/log: use `size_t` to track indices
Message-ID: <Z3eHAWnkrwyGqtki@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <20241227-b4-pks-commit-reach-sign-compare-v1-6-07c59c2aa632@pks.im>
 <3b7ep2hex2vae56p2ba2kjeextjrjcsu5jrufr7hqewrnv3z45@ftrrcuvihxxs>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7ep2hex2vae56p2ba2kjeextjrjcsu5jrufr7hqewrnv3z45@ftrrcuvihxxs>

On Thu, Jan 02, 2025 at 07:58:24PM -0600, Justin Tobler wrote:
> On 24/12/27 11:46AM, Patrick Steinhardt wrote:
> > Similar as with the preceding commit, adapt "builtin/log.c" so that it
> > tracks array indices via `size_t` instead of using signed integers. This
> > fixes a couple of -Wsign-compare warnings and prepares the code for
> > a similar refactoring of `repo_get_merge_bases_many()` in a subsequent
> > commit.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/log.c | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> > 
> [snip]
> >  	if (show_progress)
> >  		progress = start_delayed_progress(_("Generating patches"), total);
> > -	while (0 <= --nr) {
> > +	for (i = 0; i < nr; i++) {
> > +		size_t idx = nr - i - 1;
> >  		int shown;
> > -		display_progress(progress, total - nr);
> > -		commit = list[nr];
> > -		rev.nr = total - nr + (start_number - 1);
> > +
> > +		display_progress(progress, total - idx);
> > +		commit = list[idx];
> > +		rev.nr = total - idx + (start_number - 1);
> 
> Along with updating array indices variables to use `size_t`, the loop
> structure here is also changed. Instead of iterating backwards from
> `nr`, the loop iterator increases and each iteration computes the index
> starting from the end. This is functionally the same behavior and it
> looks like it was done to improve readability.

It wasn't really done to improve readability, but to retain correctness.
Before this change we relied on `nr` being signed, and thus it could
also have a negative value. Now that it's a `size_t` it would overflow
eventually and that would make the loop condition a tautology. So I had
to refactor the condition so that it doesn't rely on such an overflow
anymore.

Patrick
