Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77615363C52
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433374; cv=none; b=Y4TYAUiMr5vcBVWWU5+xjozxyCyK/foaPoclx6pCEKpOUJrF5FQTPiBGu/RQjH/DmOsZfylfBGFtv+3SlJFrKrkWj/Zvqy3dp054LusnK1wUjnErOFHFjHUEsfLgjxlT72lM94sxHbG8WveX7jKX60dsPavYR/L2N1pIULlMsKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433374; c=relaxed/simple;
	bh=Aos/CMp4bdT75EmPkfJEipcdOARUoLfs229i5xhQNX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rD2v3GsCFKSTe58w8/qnc5mhFTQHrtmg/me6ikNJU6Xy+eHL0peQRIuT2nYVKhS6es9yR/tUmqhue/tI8taMoUkvKMLOHQopoHBQXskAXXpsF7lhmJxNKQoy8kkn6Dunf0WsbHplYwsZ5qykXZ/Rw3GXH3EUsLV0cCQrrgWBPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TPoQ+/vt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=js+ZJNeC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TPoQ+/vt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="js+ZJNeC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 91A217A013E;
	Fri, 13 Mar 2026 16:22:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 16:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773433372; x=1773519772; bh=sXxNoE1TVK
	p/d3WR3/XPZvfjRNySGVVKCRVH4AcO+No=; b=TPoQ+/vt7iArW4HYMxzLkEQSl7
	cwgd5QLmRLyurA56zmS584zbiHFU4gj18i1txPdVSrw+32wR9Nls+4AplRzSd7ry
	NdDtrobrWLSzWP44Urxl2xZW8dpNMzAoAoucbaeV6bxk5z5YGDqSXKsUW9Q9b5XA
	t9MA0KIfdb9eKAb/g1ch5VFB4ky9izH9OIRciSPsVJlfhsfTJDMJNxcpk3pTjzSp
	+glqCsyA8CJq01AGEXImvmQBFFkmW2dfETnKwvM1pjbjBvs/dKASUfarbTCswK/u
	7PPtN3Mw+UhaN1HnSu0RUsjipnnKdap6URXQYD8DO6JFGO8NSIopP7/Qzavw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773433372; x=1773519772; bh=sXxNoE1TVKp/d3WR3/XPZvfjRNySGVVKCRV
	H4AcO+No=; b=js+ZJNeCycnwGcdJSFn3m3SheUctCnNcN8SGrkJvgfvKa8ml+jg
	cD0+waZm9vTm3ftDhenbBSU67djMAG6dxgKDFPzukIeTC1NedZauhQc4eQZvoYDs
	XPFe2Kv71+tKGOPolCkonmeLaS/iTBI9vt2sF1lOAXfFeGia+Px2xxeamtgSmaFk
	S/lFn5T2B8mG+gcEry2aipnN7UwoOtTKijdNXVP0IRZml/MECP5nzVA2lONRHDtU
	77BsYfNZXs2iWl5RsQgi2Qa5pOhXkEICRObebff625VYsAka0GlPqrYJMYBnNZGB
	I8U24QWc4pCtsLCk70Egmn61S/ijOObLxmA==
X-ME-Sender: <xms:HHK0ac9Ix8JzUtb3y5wtySTeo9X7sandVBYctjKdeah4EH0IOJ3K5g>
    <xme:HHK0aYY7iZLEZFnaHlZBFMknAuAEm6nhBXwA53uf79tBC5wO50Zs_tuhqvB4vK9_2
    qSfoGx9WVXaN3MxT7KLB7ivqqfFbhmt3BualUg6xcS6fQDnH5f0jg>
X-ME-Received: <xmr:HHK0ab0WNAy5kIlPZrHMEV-5y5C2m3osvxRdnRAnDSCwRMvLuaS8SdQy71Ns9INF-ucLC2ntdrY_322A0T0S2PAt7VuQEWlNSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepsggvrhhtrdifvghsrghrghesghhoohhglhgv
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HHK0aTbsxL7OnrKUkZuhxOFtAwRXyxYy83yiJoCFPJMsdqw6Th3LTA>
    <xmx:HHK0aTLmTiIbB_v_9L29pWxzq-VEs5gp3sRAyq75SA4n5o3qT9rrbg>
    <xmx:HHK0aSEOsZ_LIEsTv0w_fOQOMx2qM2VmT4y4kRPVfN3zgomt0vUXwg>
    <xmx:HHK0aasgicMrcTqBsldaVcuwjHOpMA6Y0ousaNUD0kmQp2mJcjdmiQ>
    <xmx:HHK0aSt7YKo4wgZPDX3Ov8yBxfXqtOpguLgbUddryVYr_-g2Jn3lu_Wk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 16:22:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,  Jeff
 King <peff@peff.net>,  Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v8 2/4] format-patch: add ability to use alt cover format
In-Reply-To: <abRTEXspvX_z0usP@exploit> (Mirko Faina's message of "Fri, 13 Mar
	2026 20:17:01 +0100")
References: <cover.1772839973.git.mroik@delayed.space>
	<cover.1773331753.git.mroik@delayed.space>
	<225065cc0dd54d1a592939d41783a904a98fb2ad.1773331753.git.mroik@delayed.space>
	<xmqq5x71gfci.fsf@gitster.g> <abLw6vUUh36zFK4n@exploit2>
	<xmqqjyvhez96.fsf@gitster.g>
	<1759c2fe-6e7a-41b6-9869-97544870ebef@gmail.com>
	<xmqqqzpn63yn.fsf@gitster.g> <abRTEXspvX_z0usP@exploit>
Date: Fri, 13 Mar 2026 13:22:50 -0700
Message-ID: <xmqqcy174gyt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Fri, Mar 13, 2026 at 10:20:48AM -0700, Junio C Hamano wrote:
>> I do not mind a sort of DWIM similar to "log --pretty=format:%s";
>> technically, "git log --prefix" requires the "format:" prefix when
>> using a custom format (i.e., not the canned "short", "fuller", etc.)
>> but we DWIM when the string appears to use %-interpolation.
>
> Then we can move towards keeping the "log:" prefix but
> allowing for it to be dropped when %-interpolation occurs, just like
> --pretty does.

Yes.  I vewi the DWIM as icing on the case, though.  IOW, the
feature is perfectly fine to require "log:" and still move forward,
and it would be nice if people can say "--pretty=%s" without it.

But that DWIM is "it would be nice if this is added".
