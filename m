Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D322D3A86
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434266; cv=none; b=fyzR2u9mW28Ej8dT7ZjH6bSPlz1A/wO2IlbVc0cni8ojFKJfIQk4GeN42sACCAorT2JpvzxrKw29b6n5p3gv9GiqNrpKdjLsudzf4qItZfu530T8IH6GHEVmWC25gMFc/hTYAfVAulJX1uqZykM8wAIKhP9jWZn0jGpwCAG5wzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434266; c=relaxed/simple;
	bh=vmWsThfKYKILH1O8dUVu08KsRGgdlZnRL0ELJ+SYWfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ca7bJGliUBC6VE/5tJLQELDoOCKM8vKyYpZzayZq/49hecH5m8BEXkBrFKAKtizRCDqEAwcj7AILZ/xZK0pG0UxLXNLSiRoMBSdo3LF4pJX9pJQ7OdY8ExBI4zj07BajBUGEAQxy2Zv8oepr96PvIhsZgcb/pwDRWv4J9tw+S1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wUPYpb1A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ftLTItfj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wUPYpb1A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ftLTItfj"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C5311140216;
	Fri, 20 Jun 2025 11:44:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 20 Jun 2025 11:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750434263;
	 x=1750520663; bh=6YJJyQq8uA7M20pnEoHlDYEpT6O5QLDJ34Wt2TAIpWg=; b=
	wUPYpb1Aq7+YG+RmUfftWGn2JZ6IV3UC1Dw3uQkncYdc0HBA63s0lFg+stvvxBCv
	caJ7aILhmfyR2D3R7JmzJQv7z+KuZTn7RtyR2EQaMBiO1Y6J93jPUIMzbHfalfYi
	eNDAaWQJ9Zkl4cp69d5DUbemijxUVQzrCN7nBb2LjxVqAJSzI/CO7PrKyMj9CleB
	s0+5UYlu9kNCOW0Kv4ZXn9EfVGvx2Jqq3o+IO2JdTzDGSWu9nYJ8romD/9YYfIx7
	nC/HRFoBBDiXK3pxkuHsDsJ6tA5kz6dFTFWhkFnx/ulsWdXtpmxlFzLwb738ZNby
	vkM5nVrtfL9tN6aX/CaPfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750434263; x=
	1750520663; bh=6YJJyQq8uA7M20pnEoHlDYEpT6O5QLDJ34Wt2TAIpWg=; b=f
	tLTItfjFkBrd50cxWMuUzXdUkzO3nw/e9lSUtflpcQK2qmpAO86hZrNO5mTi5PT/
	+SHFJvUqTPY308arnhDcist+CceN9zLLfd7bDnZGCqNxxQs6q/fJ94vPMKMRZ1gj
	bKaJJN0rT0XXFVOR+PAasDrCgtEH8TPcaYtrx2QtW+pUFCPHQcWc5OG9FUtTSCUe
	EXq+RgNeVhJtnhnUTqHNS5PnRSN+7lcAq6I7F4v+tW0jhYQ88pQLqKY6uWadRTYD
	6HWjoWU5p0kYQr9/TYHAFnhJrxhoaSVpgXorFzz2aRH/m6bPYmWFDrRBbLuBrCXs
	FzD6Yb/8YkJtumkd4BUqg==
X-ME-Sender: <xms:1oFVaDg2dTMwvy5Bwe32aibQuW1mwNDPuAt_apCzAtPJYj4XI_Fwkw>
    <xme:1oFVaACCNAui0HSYx8H_9HEvK13zwCMLUjWNBjDFD0avmEWrKf3V9_AJP1qdwoj5A
    ouNmJ4tUQkzdg3mHQ>
X-ME-Received: <xmr:1oFVaDGyh8HAnJpcjnMv3TivESzLh-W8-FOctOWIr0KrNESEWBLQe5h45py6nPlMISBPe8nk8_Uc-Vo83b02Syu5ln3uSSov6iGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffledvveegleffveelheekheefhefffeejiedtffduvdffjeffffdtgfffvedv
    udenucffohhmrghinhepvgigrghmphhlvgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    gvrhhgsehthhgrlhhhvghimhdrihhopdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghgrrh
    hgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:14FVaARR7lgcByodGdg2bUGzonzKRmZz64yQjw1zAKvmhybf6FPf6w>
    <xmx:14FVaAzbNV6t-csjX1-3A7hvYjVuzbOWAkHgGNnyhwOvb_xjwR3wXg>
    <xmx:14FVaG6osVdDuMvgByZ36K36c1klK2oDOkJqow-8cyrrgENsotj4dg>
    <xmx:14FVaFwc_Q8BbBfi1DPFsqksZq8cwJXOMieLovoYLrdfCktsqeGGOA>
    <xmx:14FVaGQXt53QKjpxF8k9DuU8g9SbvLmXIoCJ_WB9yviekmPRvAn802qI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 11:44:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Joerg Thalheim <joerg@thalheim.io>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Aditya Garg
 <gargaditya08@live.com>
Subject: Re: [PATCH v2 2/2] imap-send: improve error messages with
 configuration hints
In-Reply-To: <20250620063836.252881-3-joerg@thalheim.io> (Joerg Thalheim's
	message of "Fri, 20 Jun 2025 08:38:36 +0200")
References: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io>
	<20250620063836.252881-1-joerg@thalheim.io>
	<20250620063836.252881-3-joerg@thalheim.io>
Date: Fri, 20 Jun 2025 08:44:21 -0700
Message-ID: <xmqqldpm4duy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Joerg Thalheim <joerg@thalheim.io> writes:

> From: Jörg Thalheim <joerg@thalheim.io>
>
> Replace basic error messages with more helpful ones that guide users
> on how to resolve configuration issues. When imap.host or imap.folder
> are missing, provide the exact git config commands needed to fix the
> problem, along with examples of typical values.
>
> This uses the advise() API to display hints that can be disabled
> by users who don't want them,

Not quite.  We do not encourage or condone wholesale disabling of
all advise messages by end users.  The advice_if_enabled() helper
allows selective disabling of individual messages that the user has
seen often enough and find no more need for help, but I do not think
it is advisable (no pun intended) to use it in these particular code
paths, simply because once the relevant configuration variables are
set, the users will not see the errors anymore.

The reason advise() was suggested was primarily because of its
better handling of multi-line messages.  It can be fed a multi-line
message (i.e., with embedded LF in it), and give "hint:" prefix to
each line, which is lacking from the error(), warning(), die() family
of messaging functions.

> +			error(_("no IMAP host specified"));
> +			advise(_("set the IMAP host with 'git config imap.host <host>'"));
> +			advise(_("(e.g., 'git config imap.host imaps://imap.example.com')"));

Give a single multi-line message to a single advise() call, i.e.,

	advice(_("set the IMAP host with ... <host>'.\n"
        	 "(e.g., 'git config ....com')"));

instead of two back-to-back calls to advise.  It allows the
translators to find points to break lines better than the programmer
who wrote these advise() call(s).

> @@ -1831,7 +1834,9 @@ int cmd_main(int argc, const char **argv)
>  	}
>  
>  	if (!server.folder) {
> -		fprintf(stderr, "no IMAP folder specified\n");
> +		error(_("no IMAP folder specified"));
> +		advise(_("set the target folder with 'git config imap.folder <folder>'"));
> +		advise(_("(e.g., 'git config imap.folder Drafts')"));

Ditto.

As a #leftoverbit we might want to inspect many fprintf(stderr)
still remain in this program after this patch and turn them into
calls to appropriate error() or warning() or whatever, but that
certainly would be outside the scope of this patch.

Thanks.
