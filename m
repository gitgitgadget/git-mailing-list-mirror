Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA32C3251
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934534; cv=none; b=cB4RC8rzf1LFCC9qF11AZRA/TtgWcXv+nFvhdlTtJRY2MOgA9tzmx++h4LpBjR7XdQj2ULJkrXs0SO0GnNwJgPAN/9ZvAw25FPoQdennaCLutwSggEeO6uc7/ocArMgqjoi3Pr5RpNM0noVZ1OpvwtQ1agNFMtwTJe+bsjNDdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934534; c=relaxed/simple;
	bh=HWjAHUXaX42hm+Om38hehn8PJzGrAnkOdAdxbXuWOHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u5Vpe7X/KNmmqXh2lm/s5r3gUE0rTtmlsMFBt/ubN1eBYpE4kxzJ8G02AgaG9FYjeGyr2C5WIvAymE+ViI2OjWyLtUOtrdUcqAOZl6d8mcUIIYxU/f2Aw5OxsU+8tbsjeukMxD6hJ5X1f1WzJh4e2E/4wWe/RaRlVcBguH5vPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JG8ZC+rw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RvoyYhRm; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JG8ZC+rw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RvoyYhRm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D61CD1D0025B;
	Thu, 19 Mar 2026 11:35:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 11:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773934531; x=1774020931; bh=32+wpfEfS8
	GfHQxu+8rZLgXbtoqdTDoVgvOpQKmA3bo=; b=JG8ZC+rwtdkMMOjkiDKIUosIko
	ma87tOgNoOFA5mg/xL4XMW6utVesowAEGdMM6kJMeqfnDIL8KXQJNn3zpyCzMudE
	8Woj2nb+UEZtsB63pq/OTDwnRpQDqsWF0MTHEVPvl6K98tSsQ+M83uSh6QBHkZkQ
	Dj8WDmrcUd46enOQ7BDqap0w+kgqNdN1LmxKWN9CLAAss5MM2MERQeBwiq4+QZ8a
	PSAUmgIgHGbt4jb0blFOTcPP74nKhulh1vJFJHrVGctD/Hrph8znf2djJpFoqVu2
	CjlgbtB74rr/I0mKV4yxJoU5UoaRAzjheaYje81o4t52AxQ3d40LoSu4j3Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773934531; x=1774020931; bh=32+wpfEfS8GfHQxu+8rZLgXbtoqdTDoVgvO
	pQKmA3bo=; b=RvoyYhRmJ8NYwJx8OLGYcU2Dl1pHELKn8BGU3k6j/bZmwpEKAeD
	GinFuoWs/6orp0fvxp2f/t+LEDD95VaIvlCDSjiZ04PalEl7uuuhV16OW6571hqV
	YCAep83SWk6E0KL4RlSgNOi3TKdLGE2g3QNwrwNTpvini9fdYV2prhMohk8lnjHw
	gvkh3o2ly862YfVhDIU3zmturyrtu67fWYLdkbuXAIFZ/mrf9TgbI1u05gjRvvJO
	PtdSmrBnytcz1rwIiO4ov3qaTOVMjea6YR37hIfXf2Xg7skk7hZQXrQodkwIWEIm
	tPvQLIZwqzuPJNLU/uP4oP5wa042gSaY39w==
X-ME-Sender: <xms:wxe8aTH12XoFeBft3yW3HfA-ayUryzaWULKZi772Q2vJsLcv_CWpfw>
    <xme:wxe8aXxjFVrY1GenwAedh-n_4v4i8EIGx88a8q2TcX619i-OSAijMYRvnfG0Hojqy
    7bx2gyqxndttA0nlk6WMXtJYSLIcIohLRwlLS7OMlThL8MNAqMh2Q>
X-ME-Received: <xmr:wxe8aSjMSgVPq4T-8vlgUiuDOIzFqj_5ibOpVCMofOJ12kQxlDBJtsOssVyaJ376IEJD6-AfwuTsyprE3biL9V1YHrcormJgxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:wxe8aaxg70G3-ntdPLMLNCIRfcJNarH7I_oPoWmzmvYNYa7RUJsZsw>
    <xmx:wxe8adIsuNTPEzKSbAzEVNwmBDcLJ8p2a5z82oMD1nv9FvlCeBrm3w>
    <xmx:wxe8aZRC2YLec49Mob_QXIRWAuxSMtXqJ5WyYOp2tEOiyCr1Xs8ntg>
    <xmx:wxe8adpalQ5izX-ETDNIGZXzAd0lDGIIVMd5otZNvFxPcK3oxGLx6g>
    <xmx:wxe8abzAl47gArRqG480ghx70BFHVpYNXTLzamnKDePjloZRVB0UuNDu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 11:35:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] git am: apply patches directly via message id
In-Reply-To: <20260319152313.1324081-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Thu, 19 Mar 2026 20:51:11 +0530")
References: <xmqqy0jolyte.fsf@gitster.g>
	<20260319152313.1324081-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Thu, 19 Mar 2026 08:35:29 -0700
Message-ID: <xmqqjyv7n872.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>> Sounds a lot like "b4 am -o-" piped to "git am" to me.
>
> I see. Though I think b4 is an external library, and I am reckoning that
> this functionality is used commonly so would it make sense to add this
> natively in git am ? or it is fine using b4 for this.

But lore (and the way it takes the message-ID and returns not just a
single message but a mbox with all patches in a complete series) is
very specific external dependency.  It does not belong to "git am",
whose only purpose is to accept a mailbox with bunch of patches (and
we do not care how you downloaded the mailbox) and create commits
out of them.  Interacting with lore and downloading patches from it
is what "b4" does and it does it well.

So, no, it is not _fine_ using b4 for this.  It is crazy not to use
it for this.
