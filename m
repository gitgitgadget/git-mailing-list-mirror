Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DC2EC0A2
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243893; cv=none; b=HcOVP12PjoFYvBMMeRbIn/aPOhbVLe6YmZcBLnZ9KQAT2qAb+ZjWqOXPihTofmIPmhO3nbWBi24k86pCWA74Zi4emwAhE9PyMq2dXz1ygtO5OxXQwh4HmZozdToXGVOgmFJv2P7YjW1+ARuZxZ9GsdSrUdw5OYvbNLPkrTrqjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243893; c=relaxed/simple;
	bh=Ei1Va19p1k1d77nNqWBjLqUK45z+IWczCjlDer0sixE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8qrHrL74Ndqy6fXTIIbePqtEIroPAAAKSIp0OSCYLtX+3WUgbmBHUqIcisknXgcRmcYeRfIbMSVKCPaBofh7a+hH41s/UKNzYtegUcX9pHW5vpZEk5A4wV1qqNaC7JS8+TmSszoX7braWCAgrpJsYdD9G7CVEBYA2AOAw3yA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iDX8AdE4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HjbtVDjl; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iDX8AdE4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HjbtVDjl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD4327A0044;
	Mon, 12 Jan 2026 13:51:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 12 Jan 2026 13:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768243890; x=1768330290; bh=Ei1Va19p1k
	1d77nNqWBjLqUK45z+IWczCjlDer0sixE=; b=iDX8AdE4aF+MU+WdWnmPv2lIJ8
	mFNQ1VBGq+7XKSRVGGelUJcGXUNBLKV0aN8TErXKlKbHWsaN23gW1KC9eVC9JU25
	CprE2wTaIQOl0eqruit7MrO917Am47qrioakGtj/2x6pNRjQliGD6Nr/G2D/O6qQ
	Yx+wnNIy+SZU2a6UGVTJ5XmeKVmimgDjiLbC9LbO12CYSXeb4HCcKr+15wt0mCqZ
	Vg6JU+4PzDG8iSEDjSiH504j4Qy2uk4u4lNep6sDKv5skz8+IM1IVhhOTy3RJ1QS
	79ac66MpVDh4fR4p6HyGzN6FFyEis8DFOMR31oSjKHceRS1/ReifarAiksIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768243890; x=1768330290; bh=Ei1Va19p1k1d77nNqWBjLqUK45z+IWczCjl
	Der0sixE=; b=HjbtVDjlCwDD6dFpg8ddzAqPi9flPLxAOmuHkAG2/xHJ73A949Z
	xpOBgD5HL6vfd4svYZJOzPSho+Aprt3dsCgG2fCgkR3RRfc9i2xMfGmCy+CK8c1B
	bh/okD2HvPlSuGErTnv3ZtI0CIwrNcuYJVGyr31XtALUVpPz+eMkcXqnwMJCqP2v
	jcEVwpQD4OjpvlQltoLDis862136c9td6OyV/Kyw3BEuycFYoCZs2/fHMdnm+7Bf
	Vu6PY01CH8ngEPsyrQIIPwP4uQtlAa43+30xAtysMCHWg4eOm/0Xm9NUFKemV7me
	ugHk83KiBR1AJ5qF7fCvc6CHOjrOE4Exa/A==
X-ME-Sender: <xms:skJlaZBExqZCpTKvY19kwsqWgR5UXuO8j9KyS876kSW_mSmfJ599KQ>
    <xme:skJlaehR85vLwVpA-Bui-YDNQY85gWgRA2snGb3CzcpQGyZOhSKda8i6DoUfiUq5N
    3P4w-AydiRUHXjkvRqsmQCUDH8v5QarWB8-lj25QJqycQe0M1sJY70>
X-ME-Received: <xmr:skJlaZld-iEGSqPKV7XBN_hAdpsII8CPrr8fw7JbVcN8mu3QVY3rgeb90qyerRsj8ZgIoa1nYw1-ECHzN1y2Ycrc8VEMuUERjgIE2AY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudekvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpuhhshhhkrghrkhhu
    mhgrrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:skJlaSpe3TfQGxNxlKstGVVHADM4EXH2FCPF_s9ah1WcEUWM8b1tJA>
    <xmx:skJlaaEJ1JPerZoN7067SjnsPMEySOEImv_dn91BuwqjBtaqM4HIvA>
    <xmx:skJlaWwN8T40cJfvr-6pYH42HkWcGaHu58avxBXZfLo-Yqy4j37wrg>
    <xmx:skJlaXrSLO7f4i6Ah3SrXAlyfwyBtVKxPxTLNuX42ybYvfNRQahDgA>
    <xmx:skJlaREd6Gqo0ckzZirm7wff43GQI7HUhYfRHYKQmEJsuFRRSpDzaz7F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 13:51:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  pushkarkumarsingh1970@gmail.com
Subject: Re: [PATCH] doc: MyFirstContribution: fix missing dependencies and
 clarify build steps
In-Reply-To: <20260112161538.351527-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Mon, 12 Jan 2026 21:41:09 +0530")
References: <xmqqcy3eoq6e.fsf@gitster.g>
	<20260112161538.351527-1-shreyanshpaliwalcmsmn@gmail.com>
X-Gnus-Delayed: Mon, 12 Jan 2026 12:49:06 -0800
Date: Mon, 12 Jan 2026 10:51:29 -0800
Message-ID: <xmqqbjiymzpq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>> I personally find that stopping at asciidoc and let the user deal
>> with their platform convention to get asciidoc working, like the
>> current documentation does, draws the line better than the above
>> updated text.
> ...
> Please let me know what would be the appropriate approach with this.

Again, I personally find that stopping at asciidoc and letting the
user deal with their platform convention to get asciidoc working,
like the current documentation does, draws the line better.

If we are not mentioning to check INSTALL elsewhere in the
instruction, we probably should, and the place where we mention what
software you need to install (like compilers, make, etc.) would be
more appropriate, than a note about building documentation.

Thanks.
