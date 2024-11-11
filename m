Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A519C56D
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329603; cv=none; b=U2Dzof5YjlQURgrJxLDr1yXSX/tHRwx4J03iEFyS50jzuHbTmLVRKptiu2IvcbsRskdSI/1cumejHeFl1wOK11N9BtXNImuiR/VHbYY0BQK+w500PQiPdKO85ctP3ygLWCsUrY/apcJlttMzTxHvtqyNoSb65mVr8O3UrW4w/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329603; c=relaxed/simple;
	bh=kpLqbrR0bs/DkCg7JSZ07f6yLWN8qHBr/GdEasCU06Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx3FW83M12MjRpK6FwHdTJEZ0n2HRE6cVPCOZUt2eFryDDPUZUkFI8sZHWiAfur5w54GcmPHuyAtxyYP3/jfQeGTByDZUct5J1ZztdPvI95M9UEZmnr3ScfJ/HUw1s50ElVgv2GwcaAV+S5bEfdX6RiAmK4Ah9B6zK4wWd+ll7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pZUL+93C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYh3c/Xf; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pZUL+93C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYh3c/Xf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 063D511400C9;
	Mon, 11 Nov 2024 07:53:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 11 Nov 2024 07:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731329599; x=1731415999; bh=t4WRWw2YS+
	11F5H0iUDmMK0bnSMelgkkVvpeqM4FIgo=; b=pZUL+93C0fZdZFlHNkRSB6NQfP
	hCRmtrv58GG1/JIG2I5TXfsCVHQ78ZHa8Rgsnh8hvBmPZhXqsIjHP5/aZtngPyrJ
	FLLm/xA3vCoueOC0cuBGhL7vZrtQMnsvfBqS/cISTu35PhnQtoaytJmiMVWF0O+c
	5/nhDwsqOhHVYHIZwq0MvMQUrxZ8mFDRk+9Wo4TTVwEs6GdtB/MRPLk1JXO1GauB
	DPdtmJE6L5XW2h6TBl+xzrq9hJFw/u9HGdYhYZcXMa1BxVfXbwaSiy43ix/p3EAS
	JpQ5uJE0doL6r19FOP9RnGKXASIl3gPieMQxzMfupROJNj/QiA9605KVcruw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731329599; x=1731415999; bh=t4WRWw2YS+11F5H0iUDmMK0bnSMelgkkVvp
	eqM4FIgo=; b=WYh3c/Xfu6+2BcPjZdJEZCJSpNsimikUwLsIJgNtYrBjDNTUBbK
	3kNkSrwqnYPffoVgwVeTu0gqyOJLzTyMHQ/OLGH5Fup7zF5AD+tn1JRGLeFP+OCB
	xopCnOjTXefPoh2MjmCPjjjHqgZuXe1nXo2m68N8Hv87aUUgHljsJhdo34/13pPM
	SkVWZFoVDR7m74IWSfAmhIkpsCwNsAbM6XXyZaRBELQCO4lAAfNEOqrWNHAUMoPs
	1rgZVRWVFYA5lH9cUM1i6zXo6QvkL67SvBzrKdRGDRPIETm1KHQ9rv7JOWxLm+Xh
	YkOG+gYmoYtV/1C8X11kQ1mluv15jdLPbPQ==
X-ME-Sender: <xms:Pv4xZ_SHdh3ya360K-mYG_mnOOFugX7yATtgC8KOAIltMoJnvwgBFA>
    <xme:Pv4xZww3gz4BRX1OdyoN6tDn-xSwGsYggCpr2qTOLBCPMzXP6_p_T-efhqufQaH0V
    chryKbCvgcsATMixA>
X-ME-Received: <xmr:Pv4xZ02Qw5-nuvTz8aLhIF42bCB1om_vgpC3hqVdY0PP2yFbVxWTKWyMl8UXhG0sHNVx6ctcvDHJZtWaVj_yXIo6WwEBN1Y_Umrn4G-FbJjJuAPq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Pv4xZ_AKycvAODg0rtGFpHK5auqFwzRgreEeMwinl_Ujx17npoEylA>
    <xmx:Pv4xZ4gM8dXFPpMP8RdvZxYzWOMLwrwjU6unSRxpfDgY5mMM0s5noQ>
    <xmx:Pv4xZzoiK6cR3LP-uY3xQrL6TT01D5GUTwZ6VFRJtOMHMgbFMDMwgQ>
    <xmx:Pv4xZzhAMzob8StqSQazmIAHV4PhRb56G9DBWJi5pjaGHIPnY5NQzw>
    <xmx:Pv4xZ7siTk8HJQeTpJRfnQ4NAnvBCOBCNr-74p_YgXF5RlJEO9ksSMm3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 07:53:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fab7f21c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 12:52:43 +0000 (UTC)
Date: Mon, 11 Nov 2024 13:53:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/10] refs/files: support symbolic and root refs in
 initial transaction
Message-ID: <ZzH-NTDJlUH48vRM@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
 <20241108-pks-refs-optimize-migrations-v1-4-7fd37fa80e35@pks.im>
 <CAOLa=ZSKH_OY5XG+toFUT2fD+6c7fshNZDfcOOSydxH23D91Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSKH_OY5XG+toFUT2fD+6c7fshNZDfcOOSydxH23D91Zg@mail.gmail.com>

On Mon, Nov 11, 2024 at 02:42:11AM -0800, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "files" backend has implemented special logic when committing
> > the first transactions in an otherwise empty ref store: instead of
> > writing all refs as separate loose files, it instead knows to write them
> > all into a "packed-refs" file directly. This is significantly more
> > efficient than having to write each of the refs as separate "loose" ref.
> >
> > The only user of this optimization is git-clone(1), which only uses this
> > mechanism to write regular refs. Consequently, the implementation does
> > not know how to handle both symbolic and root refs. While fine in the
> > context of git-clone(1), this keeps us from using the mechanism in more
> > cases.
> >
> > Adapt the logic to also support symbolic and root refs by using a second
> > transaction that we use for all of the refs that need to be written as
> > loose refs.
> >
> 
> The patch looks good. I was wondering if another way would be to just
> add symref and root ref support to packed-refs. But that might be a
> bigger undertaking than what we're doing here.
> 
> But thinking about it, seems like we can do that in a backwards
> compatible way too.

I don't think you can without introducing a new version of the format,
mostly because you also have to think about clients that don't support
the new format. So all of this would be a big undertaking, and given
that we have the reftable backend nowadays I don't think it'd be all
that valuable.

Patrick
