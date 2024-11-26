Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C5653
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603282; cv=none; b=fzu54pg8ykahK8V8gkG24nuqcV9JMigrQCjrI6orAU8Oxxe5+MOVFJm8doV/NcGS35eF07Oihx7Am9khz4oNa5CjyqV0rnAFUmUNmZZqnkMp4jm9yMesfbsOONJHJpEf9gMKxt+W7sd5wOUPdYGMkmbbZgLmQbF0InshbcOuaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603282; c=relaxed/simple;
	bh=GC5Cnlt8KSHEVb+5PTuaBSUGI32+dR0LMKFS8xrnASU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg6sFYMp9mKHy8sL7Ms89/HH9vcEPKeO2qBw/WxTUnJblaXIA8t2TtX0O4h9jM7tjhmaDZPeCNT7Wop0VhfnvpnMvRmZF1cc3ahUV+SxNa2wkCdEannrtSSo0SNp+j1ID1dRvQl7e70I5Sm6Rd0JMuGlpdclTeDfnBHG9Um8i1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=opAH8WJb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ethEm8pV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="opAH8WJb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ethEm8pV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19544114012F;
	Tue, 26 Nov 2024 01:41:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 26 Nov 2024 01:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732603277; x=1732689677; bh=MDxXZhOK+o
	t5wAEtdHx4s+v+vN2EHmI+ETV8NoxQado=; b=opAH8WJbx26uz6+UC9RKee2lbW
	qfUDSnsF0+617lkDhcfs/Ek6Jsvuz19dlCYvI67QSUGinV95T21RKK9eJ+9CNhxU
	+c9AGPGcqh8GvPWue264tM/Ire0YDDmzCRSLuvrZS0co7f5Oft5SFiCsCYmpYlER
	J+f7Alw0jVgFvrkOBuma069hdSdGLnxfV7Pr9Z+Yf35CdCR09wkKuHOzaRQZdlbL
	f7owaN6ErG5pTmC3hjgMWutGMyIASZsbK466rNjyfyggRIqaGACGGSwCsulc3HBm
	Uod2l6xU3meJhc/ggcJfsHcfJT9tvvftGNLetTY6yKYXYhHCa0XzrzX8HaRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732603277; x=1732689677; bh=MDxXZhOK+ot5wAEtdHx4s+v+vN2EHmI+ETV
	8NoxQado=; b=ethEm8pV3/JEKqXD1FSJco+C+hdfNtS/wK4EwIoW9PaeLJDINh7
	9bfxwU3IfvIzgeyUJpHUwOJOlAGia2ERwtBPXE1uTkL5UEnvb+LVcqtdsbniRRlQ
	IGqhNFb6un5Ct8SaSCWlvWRbara0/DZNwAox6BxGgoXzSIaRWOkBwC05wgOOquCJ
	96Zd1YMvlQuR9SOhB5JFbjK8856VgoHVN+ZflTGpUoA/3c1AcMPHX/B8wPl5jaNU
	WcEfbUPVuAFP4+z0CGV7V21rkw4q7F/qP7rrHWORp6xVlKm5nsnTuniMUi1STe0u
	rus4E2OWfLWTqtzRwRTXRdsxhArVf7PTDWQ==
X-ME-Sender: <xms:jG1FZx2oCO4_l75atsHSwSyP2KXtqRA_FKI03lefvqB0sNiEXvISDw>
    <xme:jG1FZ4G-a4mwbv1QxiC-F1DF4sVM1mE1aIswJX4levddtv7R6UrJL1SlvDj-Eusnw
    Kxbk_JTehBi763fHQ>
X-ME-Received: <xmr:jG1FZx5bVMQ28kSNA0CmX1wH5MJ3j2enZoulNr3T_ZZnzAioQBIa17av8vnePeSAeLczJEw0EjQsyNVs1xKum6H1En1YVBx8YnYI4l4hbR3FRNTz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jG1FZ-0rU6qdtVSiUizp5zyxF1eB_V_-RC59X98L42k7ihwDCQJc5w>
    <xmx:jG1FZ0FmoH-joTEdzqWo-xZCd9DzjWODTBYV9S9AQeQZuYTcs-0IbQ>
    <xmx:jG1FZ_-L_JWEyMCbemv6KGzCeEi8vs7rNeEZfC6L6h44cIQivVfOIw>
    <xmx:jG1FZxlHAGYtibJT1-bNXORHikFSzNcMl5vBmlfKGocCCjMbFI-axQ>
    <xmx:jW1FZ4DSBLNB0BPxvhNvIqIF7g_HiHAakWj4q2r1OPO2y5zmA1lMQaek>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:41:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 86ec6b69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:40:11 +0000 (UTC)
Date: Tue, 26 Nov 2024 07:41:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 4/9] refs/reftable: read references via `struct
 reftable_backend`
Message-ID: <Z0VtfJpOsMCEBuA_@pks.im>
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
 <20241125-pks-reftable-backend-reuse-iter-v3-4-1d7b658e3e9e@pks.im>
 <xmqq34je4y6m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34je4y6m.fsf@gitster.g>

On Tue, Nov 26, 2024 at 09:48:49AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Refactor `read_ref_without_reload()` to accept a `struct reftable_stack`
> > as input instead of accepting a `struct reftable_stack`.
> 
> Hmph...  am I supposed to be puzzled that the patch replaces A with
> A?

Oops, no. The first one should of course be `struct reftable_backend`.

> All callers of read_ref_without_reload() now call
> reftable_backend_read_ref().  
> 
> The former took <reftable_ref_store, reftable_stack> while the
> latter take <reftable_backend>.  They both take <refname, oid,
> referent, type>, of course, because the former is replaced by the
> latter.
> 
> OK, so we introduce a new function, and instead of passing ref-store
> and stack, the new function only takes reftable-backend (which has a
> stack contained in it).

Yes.

> The old function used ref-store only to find out the hash algorithm
> via its base repository.  Since the hash algorithm can be found from
> the stack that is in the backend, the new function does not take a
> ref-store.  FWIW, the old function did not have to take one either,
> but since we are getting rid of the old function altogether, that is
> fine ;-)

You know, let me maybe split out this change into a separate commit.
With your comments it's rather obvious that this commit does too many
things at once.

Patrick
