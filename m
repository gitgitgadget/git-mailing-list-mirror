Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6E20013A
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669918; cv=none; b=gYSfjZdcx2mq7aL+VqLklUG45uyJEVMw7dYqq8LSSCCytE0jD7TZRB0TDaM4VQlrtqQMdf/0JvC3woRlSHV+CovQTg1Yuw9muvZCs/T2d+qIqSkKacpHUrGOsW9ZzqcCJ1eJac0opqKi46l4knh6mQewZ9Wp4/zzl8n0zQRwlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669918; c=relaxed/simple;
	bh=gRBe/cyiCZlxZK5zBdjelv4WrzAbPJzSNA7z0+UEjEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hsxmMILyniuw+iKBGxQ7Nw8V2eDTcvEUQrHhw3zK7XA/9Kvnfuenj82CS3+6N9cTj03M4GboKA3QmYBXvsos5kpupq3OFfnordWhB4WH7vqevQ41Sz321ZmH/Jg7M2MsO/LNEtqkt2eBCzXuLXxmN51Hd9rADuUB+lcX7GGTGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NFUODGX0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niT2RyC4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NFUODGX0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niT2RyC4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 51CC97A0074;
	Tue, 28 Oct 2025 12:45:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 12:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761669915; x=1761756315; bh=eKj57BdFHf
	ejQpXkICC6RZDMl4xdZfbDJvvq4KMZZ3o=; b=NFUODGX08Vs4UQavpzMLQcxANN
	6wxx7H3hpnTZyt4CaEBmwcr2pNerAEr58i0fXDethqIwF3sXfil6oNd8VKqy9uoy
	iA3lCaKr5D+u/OmTJkYIyfnwLjFvC7Dw8Czr7pdDyb017ux2pXehimOea9sDX7jk
	U4lMbdWQ7HJWO4+BVKnZ73vTXhBLb3UyUo07A0wwbrB3GlmsJ0nk1dg9t7Jlk+rM
	hrD0X1G4K0EtFDlOScaugEpEGbBAZObLZ5YSxZn97aKXZsTcbE7ZGz34b2Q2iMMg
	koCMy9m0f4bsMO8n0ab9gdl64IeEthcfNbBM6lqmSbQIseA0YDV8g09vwjyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761669915; x=1761756315; bh=eKj57BdFHfejQpXkICC6RZDMl4xdZfbDJvv
	q4KMZZ3o=; b=niT2RyC4x2nnvvZPDEFcvItXITl78cBAE216J7n0vgbFVv7Z7JK
	D8PKDO7kuu1uZAJ+L+KgVZobeZ+KZ6k9oKDon2ZUZt/wUA3SkKCs33dz/rO+bYNj
	H/01EVW+RdBC/E2B2KXgRDFmvZnvI0/PPgwfH1vACsvMhCtThS6Z0SFq67G4HC8O
	tBbzMGKEdnUhY1BXQhKLTID/CSsqrgq2KXh0kRq1Jv7o+z4hI/zJNDj/OTk0XqyS
	3dM/AodiT6/Va/w3aCvye4KX5V20hVWS5yec1Hvu9Xg8I5BNnNqkxGoR4O3PqLJm
	03OWcvmgNQTHjP7VAXzndhJiZvmHO86kxSw==
X-ME-Sender: <xms:GvMAaZE5bGWbbNZHyr8-fChuxdwPTBI-RNfwQLGDrPPoaPAD5uuLpA>
    <xme:GvMAaQ6pLG3Ke3TKR-i0yWoEF8nYOvtxghlBOOjdEtu0_F5Qj64U3FWjPSAMNmtMj
    Tfpx1F4UyBb5AsEtstBfB_eQf1LJqXnrfvM16q84iHv90EyMRPA2bA>
X-ME-Received: <xmr:GvMAaexj7B-eVYFj5i8NhzPuidiNQBvWB6lOF3do-86-zG128KYHHtX9KuVt8mAB8gdXTwLbMoGTjeeFHOAQw7qaYOzxgSBf8x6l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegthhhr
    ihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:GvMAafNIiczVFZe8cokUXYxINW_eAUfY2r22-HdGoLCEGr1jyLByUQ>
    <xmx:GvMAaUmRgumAnKdmWBibAjq74WkeZlIP2SSKKSrsjuZ5O1vjBrvBTw>
    <xmx:GvMAaUQoDQrmgTsSTcEq3OMhABmLN2Zi1BIyYQVvfKjxWV29mc8Glg>
    <xmx:GvMAaTU5fvkEiIAemPN2ha1uhm17epcj8GyiFpWi16edx0L8vA2djw>
    <xmx:G_MAaU2hwRL8d0v10buXSPpWJKGdEVpmBFjIeMCRbtVYmS4imZNnU0HL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 12:45:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/5] gpg-interface: simplify ssh fingerprint parsing
In-Reply-To: <20251028081232.3068147-2-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 28 Oct 2025 09:12:28 +0100")
References: <20251028081232.3068147-1-christian.couder@gmail.com>
	<20251028081232.3068147-2-christian.couder@gmail.com>
Date: Tue, 28 Oct 2025 09:45:12 -0700
Message-ID: <xmqq4irjdlgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> In "gpg-interface.c", the 'parse_ssh_output()' function takes a
> 'struct signature_check *sigc' argument and populates many members of
> this 'sigc' using information parsed from 'sigc->output' which
> contains the ouput of an `ssh-keygen -Y ...` command that was used to
> verify an SSH signature.
>
> When it populates 'sigc->fingerprint' though, it uses
> `xstrdup(strstr(line, "key ") + 4)` while `strstr(line, "key ")` has
> already been computed a few lines above and is already available in
> the `key` variable.
>
> Let's simplify this.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  gpg-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 2f4f0e32cb..91d1b58cb4 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -443,7 +443,7 @@ static void parse_ssh_output(struct signature_check *sigc)
>  
>  	key = strstr(line, "key ");
>  	if (key) {
> -		sigc->fingerprint = xstrdup(strstr(line, "key ") + 4);
> +		sigc->fingerprint = xstrdup(key + 4);

Looks like an obvious avoidance of duplicated work.  I am not sure
if "find 'key ' anywhere on the line and take the first one" is a
sensible validation, but that is not a fault of this patch ;-)

>  		sigc->key = xstrdup(sigc->fingerprint);
>  	} else {
>  		/*
