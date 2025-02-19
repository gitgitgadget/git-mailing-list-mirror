Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02D1DFE36
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971222; cv=none; b=HZfZyc1obTDsv11KzORiZwCCNcxCNUp7KeWnzr6B0NzyIBShIHrt8ytDMNb2T52/6AvLh88wtkqaYVGLw1ZVWtsUM+llUDIXZpd1PARZjwSbvMmNoYvQxqEM9tJbSOrtcB8KKEJBVEZfwHg8zW9GBY4U+3/HV48BCOOvZsEs+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971222; c=relaxed/simple;
	bh=FrJj16GJ4aeg1OJqmaz6pTR59CFSp9/I2XEG4SAy2Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uko4J6gwodUZwj8iJO58PH9bMcCnmgvBC313pFMzmRARY82Oj1wHsA0mPU1tmGCj8twoTvXgjpOKUPyajBCcWdnhi6f8u64VlVR76VasLxEq55eSD9UqS558hfPA+xAurTk1C1EMvO7+roEZy6IGYgfI0fHff/FBFi2QSAfUeBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pnbbhPij; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uwg+Tmo7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pnbbhPij";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uwg+Tmo7"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C66C114012B;
	Wed, 19 Feb 2025 08:20:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Wed, 19 Feb 2025 08:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739971219; x=1740057619; bh=dUAa3HYmBX
	BzN3lp1EfyhXNINivfF5Pc/ypKXETPPUI=; b=pnbbhPij8+Bcus60f/9ra3/ez6
	vvXZalpa46StT5vzyKM6TskQPHQ0rCd/YrlU+PZ9cReBsahkE00OeGwQwmj9mbBz
	pukaLjobsKsp1IRSI2Uf5e1HLapkUH7ba4T3R5iT1YPt85YiHmHhR47JfpBs/0wg
	aH9Z0kdEIC4dIt4hS/LpzkKoR8bB93YjK5Sy0h4183kH5FZQQEpCUDrWH4NckMDJ
	d+ryJ3A1uoUmKG1HDZ3LPYFIUyOArycvg9HWlvhL/FEaSNUhCGiODrKx5oyyKa+d
	dAY/ZF/v3youOSo3JaTQ0gogyEgCNmjOSlW9sQNMyWXtyub85gH76qcHlo/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739971219; x=1740057619; bh=dUAa3HYmBXBzN3lp1EfyhXNINivfF5Pc/yp
	KXETPPUI=; b=Uwg+Tmo7wzNk0qya48iUDw8mvZ0v4wc6DEhnba5qmi9mCmQcFOc
	RdwcK0SZY+FjFYHsuSYj7P52BhAUAEm1eoxoByhJlipKJ6SpTtKEn7IwmDxur6dQ
	NA/4sIV9w4gDMdZGIRI2mJJwFwLRCiCaRNHEZ7FcO+BzvqFxMd2vLLH30Yn0ypaw
	waFCBeaGNjw7ICTIhXJCJO8vBuuj4u2KQe+9U7AWcgTvcE0qw2BhC9HVuv8HQkrd
	VI0wMXf71hbhU5k71hOYFwQpSQhBLASQq8cuGIy7nklTSIbfFLuHqBFBDy9iZvSG
	HMzF+uGNMAj8tB048savqhY9w/kMzW9iNHg==
X-ME-Sender: <xms:k9q1Z_7GvCrHM0pFkMStDn414mWKFCa6gFjn7XUStsG1fmTANR0ezw>
    <xme:k9q1Z04KR8tB__18T32nxszU_1m6P6qvqa9f8w-lLoVLE70UjhLR_AZxxg9R2zDLS
    YiRYVUDTJnm4nRiAA>
X-ME-Received: <xmr:k9q1Z2fPyXt8KxGBj4wNUwaAr54LdaG16zt7wB71lBb3-ZfG7v3qEnAKtf7KFjXiCTYdg0D_852ghUI4utA8mZq4Bh-eGEfo7SB0yvV7Nv9cqMU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:k9q1ZwJFG88WO-JL1wyWiuWHMT3eFa2Ebh60L6wbCvH5u0-Fcdi7kA>
    <xmx:k9q1ZzLyt0TUbCOGRF8zxt7_66ImpVAVjo9ULiPgZ8lVM5Oe_5Y3Lg>
    <xmx:k9q1Z5yn6ahpySUqi1gaZk6-IN1hcHq_-1uDk7gkdNrKDQXwmDpZfw>
    <xmx:k9q1Z_IWgBYnzAJYOFqboTb8OKeeKwgQOAFjLBSS4LdZ7zTIoVMa_g>
    <xmx:k9q1ZwrE3wjfFrB3vHihQGno0h3uGf-lMKQm6Fi0Qkyj6r7lVfxpG11u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:20:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 76a06a90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:20:16 +0000 (UTC)
Date: Wed, 19 Feb 2025 14:20:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
Message-ID: <Z7Xaj78hBkMt00CN@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
 <Z7S6xzmPb3lK-SdT@ArchLinux>
 <Z7XF5pGsa42jrIcN@pks.im>
 <Z7XRX1gfo942QdNR@ArchLinux>
 <Z7XVoeNMjXJnlrmX@pks.im>
 <Z7XXcp9o0fb7FloS@ArchLinux>
 <Z7XZ02obxTyj1tGO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7XZ02obxTyj1tGO@pks.im>

On Wed, Feb 19, 2025 at 02:17:07PM +0100, Patrick Steinhardt wrote:
> On Wed, Feb 19, 2025 at 09:06:58PM +0800, shejialuo wrote:
> > On Wed, Feb 19, 2025 at 01:59:13PM +0100, Patrick Steinhardt wrote:
> > > Regarding the question why to even rename `ref_iterator_abort()` itself:
> > > this is done to avoid confusion going forward. Previously it really only
> > > had to be called when you actually wanted to abort an ongoing iteration
> > > over its yielded references. This is not the case anymore, and now you
> > > have to call it unconditionally after you're done with the iterator. So
> > > while the naming previously made sense, now it doesn't anymore.
> > > 
> > 
> > Good point, I didn't realise this part. Thanks for the detailed
> > explanation. I will continue to review the later patches. However, I
> > won't touch the oid part, because I am not familiar with this. By the
> > way, I think we miss out one thing in this patch:
> > 
> > We forget to free the dir iterator defined in the
> > "files-backend.c::files_fsck_refs_dir". I have just remembered that I
> > use dir iterator when checking the ref consistency.
> 
> Hm, good point. Why doesn't CI complain about this leak...? I'll
> investigate, thanks for the hint!

Wait, no, I had been looking at the wrong branch. We do free the
iterator:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 11a620ea11a..859f1c11941 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3837,6 +3820,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
                ret = error(_("failed to iterate over '%s'"), sb.buf);

 out:
+       dir_iterator_free(iter);
        strbuf_release(&sb);
        strbuf_release(&refname);
        return ret;

Patrick
