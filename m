Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787201C2DCF
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269271; cv=none; b=IsDNdgpVOIzQkvArWWbT1mdG3tcg4Es67XIjHNVy3lgOA/5RpHkIcRqBBGbwpTpglmfvsLG63xYFB/XUqUme2jPq/CEbTxQ/Cc9s7Pjp0SywwiXVrzc/SFUE9ANnTsi4XJuG5NjXPRvI5vuO5APdcHp2w5zQOUJGACbqxEcAjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269271; c=relaxed/simple;
	bh=zpjXOmmvAHZaMK+WH+5Wgw3BWwhKNT2m5dxYgwCHoR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CY4LLry0iqYpleePzGZOoXK5/bt4Jr7HVVxybVkiLMkstUuuqXi7cQwkoawpoffTiGRI3yf8PKVCnSZR7ksFMEBFb3LaFHTEUtW1+c06YhRTNUWqgthoXf16W97I+KW+x3A1Yey5yxiWk0XyNlgYWMillFJdge0H9QDNhHnbiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kOH9JuSH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SGa+Da9k; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kOH9JuSH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SGa+Da9k"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 733E511401FA;
	Mon,  2 Sep 2024 05:27:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Sep 2024 05:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725269268; x=1725355668; bh=WIobH6SBlK
	HLgeDbv3igTu3QOTI9uam6fnoR9jjytfA=; b=kOH9JuSHsL772LANPMt/8Huu5o
	l9DjmibqA7wzohEg5JXwgZuHcUEDzAlvdMqEXrWNJ6X8KmRHrx0k16UPjtvfiWwY
	lLOasXFgJ/I/dltJbBHjnyT9LIrzrDDefJBKljGm+eGCHNSoIpJE7xfdpkyfvJ5D
	XUzVxzltoh5/aQ9M+GUKw2C9ZJJjdb8OfcnUIrGq4U47p4XxU781uvZIEmuMBplO
	p76w3SJaHGSSxvR0h57ZPcxuumag8uG0CVb00+eDnW2+5asv5YBJE+CMZhT63YNt
	Y6mWoJIIzNVkP2hADs29jvCT3lR1gDayIXqB0mMEArzE7rsHc8TeBwExiqLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725269268; x=1725355668; bh=WIobH6SBlKHLgeDbv3igTu3QOTI9
	uam6fnoR9jjytfA=; b=SGa+Da9ki7PKRpVWsxdlVLl7xKm9Otfm6MqP80d38mSY
	NDs87RezPM08LxuDnAtks+DiAEN45GR94CJJR4TjIp1qiPahFmmUO4RSs3i7OdoB
	kedYiorXf44CmDNPiGcTyvyBnY+OgUu04JtPd5t8KK7xIqRVs/xc/RSEygxO6vGO
	8UBIATv96lqmw5XXfsJidImEdw5Wl6x4pAi/b1atcefya3t4AGYUGAEWvS2OpG6C
	WT+Am1qSAbrk1WEhymkh8Iav8xPchAYc2n0PF5uZRNjlLnknFjC7nCYoI4yeDbSR
	JLM44mPLZ+8VsbUqrkRvkaqhfdaXMv5734viIVvJ6w==
X-ME-Sender: <xms:FIXVZjDMvFoF_BS3N65ht_uUnQSqUpBBkUTy8zGfy0Otg9lFOkq9CA>
    <xme:FIXVZpgsDGZ_hb4ErxSiQsrpNPuOzDjGEj7TN-REOTUrUHMz23xGZ9dfeJ7DRZ02l
    adSlkzE9Hh1KL5wtw>
X-ME-Received: <xmr:FIXVZunkv0ZO09VmIIhFcXomkMEBGOdahoN0L7zTHbOqn8HU_qaZRa4wj7CnWJ9JohX18JHwx5cSRua0cFHssX1UWg_pPbWCn18j7n15FOKEQN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:FIXVZlw5DeEAQm8w9XlnsahCKgpHtzo-cmOjv6EXOwfV1PGknzUdsQ>
    <xmx:FIXVZoTYPZneLkwzb182TfG-sqLj7KGdsy9mWw8Gw6ZR_LXMDp2Knw>
    <xmx:FIXVZoZkcmL5IP0EAkbnVOS6x4jK51f1NfaFaRarcYnVeO2ZpEju3A>
    <xmx:FIXVZpTCKgOU4zazVA1u4to4jn2kqps4_1I1J8gPLLhLM7EL8vuyww>
    <xmx:FIXVZjfyUS56wDA6iuk1QsDIdPPnFllyC3hWjgS-KrBYXodmGLQORX_7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 05:27:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f77ed3b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 09:27:41 +0000 (UTC)
Date: Mon, 2 Sep 2024 11:27:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/22] builtin/push: fix leaking refspec query result
Message-ID: <ZtWFCnJ5DZU2m8Q3@tanuki>
References: <cover.1724656120.git.ps@pks.im>
 <92fc97b3db86bb0bdf610a2f76c03a96a99bfe8d.1724656120.git.ps@pks.im>
 <xmqqttf1pt96.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttf1pt96.fsf@gitster.g>

On Fri, Aug 30, 2024 at 02:59:01PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When appending a refspec via `refspec_append_mapped()` we leak the
> > result of `query_refspecs()`. The overall logic around refspec queries
> > is quite weird, as callers are expected to either set the `src` or `dst`
> > pointers, and then the (allocated) result will be in the respective
> > other struct member.
> 
> Hmph, is it necessary to say "quite weird" for the purpose of this
> change?  The query interface is designed to be usable to query both
> ways and within that constraints, I find it designed very nicely
> (but I do not think that is necessary to be said for the purpose of
> this change, either)..

I don't quite agree that it's nicely designed -- I find it rather hard
to use and reason about, and the fact that so many callsites get this
interface wrong seems to indicate that there is at least some sort of
truth to this assessment.

But I don't mind removing this subjective opinion from the commit
message. I'll do that in case I end up rerolling this patch series.

Thanks!

Patrick
