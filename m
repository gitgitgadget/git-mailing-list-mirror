Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B127F754
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700565; cv=none; b=PwubCU+f7KeUwjf61N3XD8UNahhkHI/+mp/jbKqhdzh/4g10XMeM45EYwKseK4HpiAk/cgiRnYqeLU9o+UnZf3JL6tJ0PsB/LpA4KMBPouObU7tApoxmHxy3vT/UJYwp4g/YMZ6hilUxC6iMmjqttV4J7uZzQaObGkPUkrJ5744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700565; c=relaxed/simple;
	bh=stuUbvQUI284eK+51U8nqSQioMTW+T90RdE7v/pfXB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBbjyADU0GdthnVAn6k8zY1Jm782dKABv9Ivb4VWAs8O/WFagF52e3J+n2x0ZI0hLiRtica9w8F8XNJtme3e0pDKeap+jipgaHqu2O0ofPBG6q3t+t3o02lPXIMTN0p3kj/cryz0cmNbVcqmp3kDoLGljoHQfIFGNC4jsYmKbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UR/SLk5n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cx4TQVPB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UR/SLk5n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cx4TQVPB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A771AEC0110;
	Wed, 24 Sep 2025 03:56:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 03:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758700561; x=1758786961; bh=nhHemiolxA
	aqDmPlHZ4fTMyzU8/BrsPx12cwYN+A5EI=; b=UR/SLk5nSM9P5DI9ERcwbIB7DF
	OvohsJfvbSvjteqhFPdw+G7ILORI6v7nMaDtGjMrVejXj3xrOYery6vjIPjGDpEh
	RKj8QKB/qNxukHIzjD3SSfsw9Hti564jIexe0MA73ztJh+17sYs8dFlN5cB2m+1K
	OkePET+PhMlluDvPrUbMslUo3qYI5Dbe7Ijj43iR13ChXhgh+JUfYZWzmxrk0DLr
	cC3430MRs3S/3QotQVNKPkPMHgQXYuezvArGpbfnqT76PO9IhE5mz2WN3TYJP0yA
	mXsskO6FfG1E7Vd06GdOqYWW89UXjLJI9oSdW5johu5o0ThpEpspHqEoM5sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758700561; x=1758786961; bh=nhHemiolxAaqDmPlHZ4fTMyzU8/BrsPx12c
	wYN+A5EI=; b=Cx4TQVPBS/wlsEZxlA7fT9yQPv9Ntt9TDbpLWEWG2EbugyaVFKH
	Dg1HtNxS176PX0ILBeOyPtHXYVr3eu9IgeLe7ExWXw3YT5hqAPs7hVNwnWkmYVif
	F7NIXnecSJF3smcrJvPoeskhHMGJi8mxgh/fl4INnM/qqA4siaHxIXYqqDNOrzm0
	vD/dDv1LBrQw+jfiaRDlie19IpyqzZaJy60oHObig+yOydfUAtvC2WO1oYitd2KG
	XQ6F7PfsjYCxsPdKrc9lFbU0v5A0SC9S0AzGRvTDbAlKc2o2sYWrQPz3LKtgmv8Z
	c5+o7gnavHsgm98wAYr7gxfnIHz68HJmANQ==
X-ME-Sender: <xms:EaTTaF5VsApbYz8OP2I1TS6kv4mqyWxmM9E__6_ZElxAKVlxmXTKnw>
    <xme:EaTTaJ6NnZMWAQIB96Pq9vJofEZbWBnUm8fj9k-0k4vUZqMrXIfozokka1EjmQgJv
    QQ9BQYKYb4Mi3bUH8IaNRfLr58bFBM-USCn1nQ9z8QfWBbLlrT0Dg>
X-ME-Received: <xmr:EaTTaBdO42YE3VmGECIP7eJmgGEiKcjepvXC4g1pRsoYr5QslUGAxXQ6CZ9Dn4Xss604GKVW81uwKZ1yejZJw74iuUTdZHaJgrnvmixbPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:EaTTaND3RM-puBb9EYt7c4WzfkdIDHq2NOfe7SWwNykY3CI0bacLJQ>
    <xmx:EaTTaE-ZA7hO9uVaKAFXZLDMrAjtl8BTT7kpany5hwXRO4_oaBf1zA>
    <xmx:EaTTaIKOr7rVsB1f-QAixx-RlnZWfa9eiPwG9DkTqEuQdkAs6H3PZg>
    <xmx:EaTTaNiMi9rYjmsWt62AdnAeab6t1IfSBRZxLt7Mod-FCBaOtpbf7Q>
    <xmx:EaTTaFviUV28YGTQczZSLzuNtOnHANRCWBQWprsgmiFYS3fgznFj1FNY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 03:56:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac040185 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 07:55:59 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:55:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 6/9] rev-parse: allow printing compatibility hash
Message-ID: <aNOkDEsJIfq0Ufgg@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-7-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919010911.649831-7-sandals@crustytoothpaste.net>

On Fri, Sep 19, 2025 at 01:09:08AM +0000, brian m. carlson wrote:
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 58a4583088..98c5a772bd 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -207,6 +207,40 @@ test_expect_success 'rev-parse --show-object-format in repo' '
>  	grep "unknown mode for --show-object-format: squeamish-ossifrage" err
>  '
>  
> +
> +test_expect_success RUST 'rev-parse --show-object-format in repo with compat mode' '

Does this test really depend on the RUST prereq? I cannot see anything
here that would require it.

Patrick
