Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D527F754
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700573; cv=none; b=q9SQ4yLpRf8v0X4YmwNIp02WVzXu49wGx7C79IoNQ1CbuqkKitlj4MIrTIVS8YDzefZCDotiAUKMfNLEzRCyyUdCmRQAPG1nn+QpYugGcRc0gJaN143khEM4E4U1PngC2h2BSavZPxD7C7oouuCPe0fkl4PB1pCWMqAycBuh2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700573; c=relaxed/simple;
	bh=0p6BbVagOSB6PDSMQMAse/LHnG1Fe3Z06PMK4XTS7PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hluLx8Dxo2GxWQfujEx1+IPZv+39sLqKAVrIIsK1svKKkfyC04583zOZIUOjPWs3Y9Ir9zVjAAuWAYoeSTmZzAk1qGU3PKEm8KsxJ7HRSkfjyKk/+hbMhpCvNl6lrJvVb2WfNLTsD5My+T3rETqDe1J48yzXVJNygI+KzlCMM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J0PKS9Ad; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AVZpjkSF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J0PKS9Ad";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AVZpjkSF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4E02140008B;
	Wed, 24 Sep 2025 03:56:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 24 Sep 2025 03:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758700566; x=1758786966; bh=YdIm4lVEYX
	dMIHD4mZ2X9vd+1SpJi1p7KZO6kv/LP2g=; b=J0PKS9AdBvprhQl/QHPwWF2sjx
	f44jliY1XB0XmpYPEBuBXOpIQgpLqpLwDV5St65iBQNbZI5u9D+W/hc1qhktUMNQ
	cgYaqFHIbNwOj3HPUQ+HqhbnLB07/rabqNMvnN70S2+ljsu/qP++16kqFVXQ9/p4
	eO+ED2LK8tJVPOmPrI6dVE3hmbbvvbPmWe5IaX2MARhyuEmbhLJNbpNVPngS2FhD
	/0KR/Lj+LIy2Kes97Oywhc5XFv2Ffn8GFX9o0d8pEHRmorkczcmnlLTUqACnlh6H
	sOIV0hWaAxsvCOVpUi3ShN1uYkLCLT4fFlZEns/w8PTr4xghTx4jFahV2pOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758700566; x=1758786966; bh=YdIm4lVEYXdMIHD4mZ2X9vd+1SpJi1p7KZO
	6kv/LP2g=; b=AVZpjkSFr78ZjCLvXnjTJOBpPWB8+cOUpr39G2ucyD7rzQoc0dJ
	aAATaHeZpZ3gZInG12qnJx6H9XwIff7JVdQUxnIKj0fEgqdJR+aNEMqxRLmS0d6c
	UTjMPc27Sn7486ffw5QtgwPcHEnQTcU1966Wl+RLjTs5nvMio76060WzQ9eKSf9r
	jC4/q2lc2P0URagE0RBXkQhvdNIb2YH/qEgIGXR7Zkwcw7CYdZgRQd0tUizh9y50
	x5vq+xAQXSjs7bw0w2KMSGkqOYSr7/nSlsR7S78UHuOwSPiUAANdmNY9bTIhQlnm
	G3r1HG4ywZTfbnOS31Rdx/MgPDDjj1iZiXQ==
X-ME-Sender: <xms:FqTTaJkjCtdLwLKjz0_6bQfegUgQH_-fN96kUkuPm7-dCqwjnJqqLw>
    <xme:FqTTaL1eh41EUW08LbrtDWFj_PAP6HG9L9XZ5YraUhPzgaWkfDA15lyieOIojaHYW
    OGEBb8l23kam3JEFsniKLaDjWAG_zZ0lDuP43BhCPg4nymhZ4zA>
X-ME-Received: <xmr:FqTTaEoy54v11-fegnYaIQUP01trxbuf9NvBNlA9E4NQx8kOL8Y7GeoOwDhcxVDIx4QXRmetTiDbzW2oMM0SeFdGyQEOoaZxrp9djcQKxA>
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
X-ME-Proxy: <xmx:FqTTaIfz9qm_A2YvKp-8ITZgT1vAU0up2BXp1bFMjFniWqPJjIX8xQ>
    <xmx:FqTTaDowpnz-eV8yOpWWSVAucF_6FjlYunpJGNvyBxDHBFii3CZ0Pg>
    <xmx:FqTTaJHyJHLXlWHspoDdbEzqahixeUFlxj0BE_GWHGGlYZDL3Zs4Fw>
    <xmx:FqTTaDuhQK_xMigfm2hrDTx8wF4u6eoqRr2RWIAXAIOvQNrrrwbzKQ>
    <xmx:FqTTaLZM4fFiadYaH01X9kQJi9wsr-5x_F1GA0bGucWvwy8iTWdufOIV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 03:56:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 778ae8fd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 07:56:05 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:56:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 8/9] Allow specifying compatibility hash
Message-ID: <aNOkEVUag91bv2RP@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-9-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919010911.649831-9-sandals@crustytoothpaste.net>

On Fri, Sep 19, 2025 at 01:09:10AM +0000, brian m. carlson wrote:

Tiny nit: it would help if the patch subject was prefixed with "t:".

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index a28de7b19b..52d7759bf5 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1708,11 +1708,16 @@ test_set_hash () {
>  # Detect the hash algorithm in use.
>  test_detect_hash () {
>  	case "${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}" in
> -	"sha256")
> +	*:*)
> +	    test_hash_algo="${GIT_TEST_DEFAULT_HASH%%:*}"
> +	    test_compat_hash_algo="${GIT_TEST_DEFAULT_HASH##*:}"
> +	    test_repo_compat_hash_algo="$test_compat_hash_algo"
> +	    ;;
> +	sha256)
>  	    test_hash_algo=sha256
>  	    test_compat_hash_algo=sha1
>  	    ;;
> -	*)
> +	sha1)
>  	    test_hash_algo=sha1
>  	    test_compat_hash_algo=sha256
>  	    ;;

Makes sense, I guess. It's a bit hard to judge without seeing any actual
tests, but I don't think that should hold off adding the infrastructure.
Worst case we can still adjust it at later point in time.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 621cd31ae1..14c777e4e2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1917,6 +1917,13 @@ test_lazy_prereq DEFAULT_HASH_ALGORITHM '
>  test_lazy_prereq DEFAULT_REPO_FORMAT '
>  	test_have_prereq SHA1,REFFILES
>  '
> +# BROKEN_OBJECTS is a test if we can write deliberately broken objects and

s/if/whether/

> +# expect them to work.  When running using SHA-256 mode with SHA-1
> +# compatibility, we cannot write such objects because there's no SHA-1
> +# compatibility value for a nonexistent object.
> +test_lazy_prereq BROKEN_OBJECTS '
> +	test -z "$test_repo_compat_hash_algo"
> +'
>  
>  # Ensure that no test accidentally triggers a Git command
>  # that runs the actual maintenance scheduler, affecting a user's

Patrick
