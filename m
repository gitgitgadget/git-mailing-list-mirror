Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D423BE
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678988; cv=none; b=CjaMawgPypGqElu39tB8OjyMnXZ8P6vMQ3qcqW6k/611Eb3IlRBLrgwPTo5+03awn39D00zmT0hHvqDdy3AyzjcFKIC4GXFzMdo9ZI5lB5SlYL5fCVLlCklVLYyuXD5F53VWAFeatukK56QvuwSPohJiLTphJzHVoA/FBABBanM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678988; c=relaxed/simple;
	bh=hvue6unCpmli7OtNd0wYBkMarXhs0sphqg2B6coXXHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7H9X7r3EnQIzVTQZ2m+k5ilPogG0ImUUBbb+TwAPNeb820yeRxo9At2/OWJgoDJt6QS9RRyIvrFYk+vcSFxRm3d2CwdwMLNmm7cv4qQ0I/sp7zcutEGJdVOTpezGHZ1zsAh+pZoRKcIfhKsqGYhOMU9hNdBy+oOJTeq3jIAbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iaDJVcHi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWckM/FY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iaDJVcHi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWckM/FY"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E00E911401F9;
	Mon, 30 Sep 2024 02:49:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 02:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727678985; x=1727765385; bh=kjmC7TvMvG
	zbuULhqaEQN9HdYj3oN1HRcLUP/tkMreA=; b=iaDJVcHiQDNcGmWP92sweEjVQO
	aDsCZBM1HW0un36DtFfwguM8bctlKydnmG7cPTc2mgvraANTA9ZPyixublvf1+Q6
	fjzKPvHR/JgdCx3ii4jayPduJaBH0mFc6ysH922nlrHds2PzwwaXfMDdy3i4UW6H
	fWxRzDqrp95SP0OS7TDwsNhv0/lrj8ORdbC7iK41kl6LGBkgSs3TUO7qu0x9DSa4
	J3Cagepz4TAOrWQIpjaGpRMfkBDlhLo5eG4mpwViTId1iORX0O73bjNhMZZs4hcS
	Ci9r6vRfX4G+T4JNwR2+OuLzomM3hCTzLn91I11taDsfmdfdssKPGyvlOcyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727678985; x=1727765385; bh=kjmC7TvMvGzbuULhqaEQN9HdYj3o
	N1HRcLUP/tkMreA=; b=ZWckM/FYohh23MgWXybV5K2phF7ZWVOAzNQFLM2jkXHB
	crXwOC017D9qwmrEP9CrpgwpRYpGN7QwHSaI0QMFBsm0qyqNmSms3SxSlWMo5dxP
	mrnK0K+WCN6kTIGECauMozUCle4v61aM0qHt1LdEN20HhdM/L26yroIx95OkHbl7
	/oFGv7Cob9N8z/VyGCPKxzgmpl0c+Egx1pXB1Oc+XqpSF0hxpbQRv+tJNseJJ7lD
	CbWgFtDaLM/eJrDd9T+3vmGHFOXq62ag6ynioRCNvYrrVePeIMcqqR+Qg4sgTyvJ
	zeK5EjBJRLFW413QRuCJTD9cRFt30XvcmSVF5/QLTQ==
X-ME-Sender: <xms:CUr6Zmgl-buErZiPxxayguOG93cU7Mp6jyu0B6ORsDnAMrNjynuY1A>
    <xme:CUr6ZnB5htRWQsLQ58RDBH7zl0U3UpeGZPVfNee8gQ3uGNFqfzYFGp9i9kxno1sn8
    cJdXELdShNvFC9-Wg>
X-ME-Received: <xmr:CUr6ZuGs_Fjt_z1Cns2TWdg3dt0qp3QYDAkV6Sa3_Gl4XG3YfIa_jPz2r_s33NVtVOUYLSHgRRp8L8YQ2QsGdYhvAMfLHprmecwoqRHqWEnEqEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:CUr6ZvQtN6nCJNM84LUCXFjN5X66jZMvlt8XO6-gu8EylQ-kM3BBUg>
    <xmx:CUr6ZjyN-9Cvu5lJk8c6UJSmcbZGfL4a7eTagd6SnFBzqD0MIjGy2A>
    <xmx:CUr6Zt6mNbhOZFtJ7yZWWL-gyuEfp5BZqnYA-RPrhdvCL3o0GU-rrg>
    <xmx:CUr6ZgwSCW7enCy1qaKhw6AXQCnOcCul-ardxTl4QJndXUFcOfne-w>
    <xmx:CUr6Zqm0GkvXT7LO0FtJJT91whVCaOMMUi6KWXg4oV1PDhdHWUo8e5Oy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 02:49:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49adf0b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 06:48:57 +0000 (UTC)
Date: Mon, 30 Sep 2024 08:49:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <ZvpJ_zpAcpezXB89@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1727155858.git.ps@pks.im>
 <9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
 <20240927040752.GA567671@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927040752.GA567671@coredump.intra.peff.net>

On Fri, Sep 27, 2024 at 12:07:52AM -0400, Jeff King wrote:
> On Tue, Sep 24, 2024 at 07:33:08AM +0200, Patrick Steinhardt wrote:
> 
> > +test_expect_success 'ref transaction: many concurrent writers' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		# Set a high timeout such that a busy CI machine will not abort
> > +		# early. 10 seconds should hopefully be ample of time to make
> > +		# this non-flaky.
> > +		git config set reftable.lockTimeout 10000 &&
> 
> I saw this test racily fail in the Windows CI build. The failure is as
> you might imagine, a few of the background update-ref invocations
> failed:
> 
>   fatal: update_ref failed for ref 'refs/heads/branch-21': reftable: transaction failure: I/O error
> 
> but of course we don't notice because they're backgrounded. And then the
> expected output is missing the branch-21 entry (and in my case,
> branch-64 suffered a similar fate).
> 
> At first I thought we probably needed to bump the timeout (and EIO was
> just our way of passing that up the stack). But looking at the
> timestamps in the Actions log, the whole loop took less than 10ms to
> run.
> 
> So could this be indicative of a real contention issue specific to
> Windows? I'm wondering if something like the old "you can't delete a
> file somebody else has open" restriction is biting us somehow.

Thanks for letting me know!

I very much expect that this is the scenario that you mention, where we
try to delete a file that is still held open by another process. We're
trying to be mindful about this restriction is the reftable library by
not failing when a call to unlink(3P) fails for any of the tables, and
we do have logic in place to unlink them at a later point in time when
not referenced by the "tables.list" file. So none of the calls to unlink
are error-checked at all.

But there's one file that we _have_ to rewrite, and that is of course
the "tables.list" file itself. We never unlink the file though but only
rename the new instance into place. I think I recently discovered that
we have some problems here, because Windows seemed to allow this in some
scenarios but not in others.

In any case, I've already set up a Windows VM last week, so I'll
investigate the issue later this week.

Patrick
