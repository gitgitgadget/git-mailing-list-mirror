Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F621767D
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768171841; cv=none; b=CnNW7IgrO/hRCz9KC3cX/69LHQYeDdtajtTYcsp04NICw4HZzoFFxJrgafwXFNeTwgQ8P1lfW8MW0Iy22kus/RUW6L1/T6Q2dmOaSojL1I+kNJIx/dRkmSpf1UyXPZWojj5KTS+AfoQEQ8v2tdDrgRG8z5S2zhD/EIcN/7CtfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768171841; c=relaxed/simple;
	bh=vILs2ZB3fO8MvfG9fDml2rG5RDLoQGa/X94/Ba2UlNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fzL3gDfDDyYUCryCMrO9do6DC6txRQcTepAt7BTBN8nAsP3YrEi41NYHih8+0n3X2H028rEh9pZ7r492jK9m+E6WuaD3Q8HX3nU3mrKkBMVwYViL0u/tcKfDg9HRbHVLpTHJZoqDckhntcD0iuhIK4ELBcaSeKJg2dFAzpcldJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rDVVV9Va; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yoc+JcDo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rDVVV9Va";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yoc+JcDo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6784BEC00AC;
	Sun, 11 Jan 2026 17:50:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 11 Jan 2026 17:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768171839; x=1768258239; bh=pOC9F5kLD0
	atKhDpqUAVvGQcB2aYwjQCoBV8ApU3cqw=; b=rDVVV9VaDTbJYCgRPzOmFzpiAx
	xHimmNDbgG5/N4Dd1u1sgFI1WjNxvDBHozuua42/ZEsEx+2Dk+2P98wbn/sbKeLq
	oy7LS1k21yntR654KlJcN+pkbIc7YgQRJXiQgCDK/ycKb0tXHtA0OvRZjQwZSXnT
	6/EoHf2pv36GaenV9WL1oGSJJSRSsXfTg/S2lepPbavxupr0aCBEztRYdz82XcVB
	TRghN/ncnG+2OrrYLhOn3uhHvNNVnABT8HXxvwHNsgTfSBcOLnuFar8O3I0iT8Nf
	pUl3DR9isJA2krrvzfK88C5R7P9XzVt4ez3cYKb0zhw2C3EUcKA5KdyOqlVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768171839; x=1768258239; bh=pOC9F5kLD0atKhDpqUAVvGQcB2aYwjQCoBV
	8ApU3cqw=; b=yoc+JcDo1WyC7ZAWsRP7LC7mmwHWC9B51hcFuN93Iys0w32sm7p
	veFEO3KDu0IqM+e2W7BdZDOMchEPacLhCQysFES2cGCiyoMetxAM+IXw3t7wxt/A
	jim3CtZzM6/aRI2+kkC7Agn6lgw8ihypWtj/yXe+53gGaQLEkQCnkhUyMSNB7pWa
	Oq2YYGysJcWO6xW7eTYsrbZ+Avz/kPk1LBKnkiu0WIiQzNi0H6hMTTh8bNgkDjbG
	8Wt6yBf5vw2psQDjZKjCwznv2e5n8neelBulnTV1CAkBkIO7oeOAWtWbXZPVZSl7
	XxsunfwPTHyB+nEXcWJXmsgiQMqKxggJF8w==
X-ME-Sender: <xms:PylkaRtv3HX4Lr1mxEKxL4Eieptd2umawtjyANSwHQldlU2VKRd8tA>
    <xme:PylkaR6IY8NLNBgXmSt7ux85m8dS25dllPfBKHyOahB9r6uMKbwuaqbRFIeoWy5rS
    zNn-fSHjBhd9qTXTKkBXi3h8Le-xEVqCwXmLFxSYmrqdgAUEzW3Eg>
X-ME-Received: <xmr:PylkaSLx0VFDLrbbtnguf6lCw3lvjpTrhXa6jV5q3ExvwhRp-4_fAc5w8xrhT6wA2nFqteN6wwYmYhMS2AHuJaQUGRnQGUsAtgPNzIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehkedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:PylkaR67KiUb2M_-HUyvSnLlsqXU9-uefGuvv9bWGaiQIteZltfckQ>
    <xmx:PylkaVwbWCVXOYHfdEIm-vszR-EpoWO1XQ4NtlwZqaDRIYeOrfaETA>
    <xmx:PylkaVbPeRorvbAgVgIQMlwuJte9yAKmNtXHzFXokIMlTbQIrrx0xw>
    <xmx:PylkaXSVP9v6YQTL2hRNuBJG9nDsVKyhMoWhzJ-p_-CCBgKw1pwYdw>
    <xmx:Pylkad5DY0tbUQrSEQ7en8m41ds7kWOblrtj4OLo5ygmQovBwS4h-bQT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 17:50:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] t5500-fetch-pack.sh: fix suppression of Git exit
 code in tests
In-Reply-To: <20260111202137.257405-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Mon, 12 Jan 2026 01:30:35 +0530")
References: <20260111202137.257405-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Sun, 11 Jan 2026 14:50:37 -0800
Message-ID: <xmqq8qe3pxvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> +	test_oid algo >oid_algo &&
> +	git rev-parse other >oid_other &&
> +	git rev-parse main >oid_main &&

It is unusual to take these to temporary files.  If you want to
reuse the value more than once, it is more common to take them in
variables.

>  	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
>  	0012command=fetch
> -	$(echo "object-format=$(test_oid algo)" | packetize)
> +	$(echo "object-format=$(<oid_algo)" | packetize)

The construct $(<file) is bashism, that does not work if your shell
is not bash, isn't it?  If you used a variable, e.g.,

	$(echo "object-format=$oid_algo" | packetize)

that would make the result more portable.

In any case, since the output of "echo" is sent to "| packetize",
the exit code of $(test_oid algo) would not affect the bigger
picture, and so would a failure from $(<oid_algo).  I am not sure if
this conversion has any value wrt to "suppression of exit code".  If
$(<oid_algo) construct fails to read the oid_algo file, the upstream
of "| packetize" may exit with non-zero code, but the downstream of
the pipe would hide it.

THe same comment applies to other two uses of $(<file) construct.
