Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78E2045AD
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765348129; cv=none; b=McWTY+BciYYPomLjxC0836JhCeCmpRfj2InCfjWnT4aaXbJkewaR6URxn4Obg6aZaBzazy2RAdkqTUoRGZ6Jq8Rlz/N8hvyhY7B8Wz706fzd3b5r77SoEmkJgWWhrEMq3dVRoogwM30EkYzebY/WYadpdq6nkAUlqwpV5Gqvcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765348129; c=relaxed/simple;
	bh=wf31oxPfC0hpbqU+6HFEbiDU5E2abit0z5Vm4wVwj2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR1ND03eXN8LjmyD88MO9n0ZSZVurNdVUDqsM0sj1PLlYmQPMxyrOwN6jxTIoLoHXSAIm5JCk8DshN+PY7VP3GAgAd+52ICA7YtpG04PNWmLrxUrNvPkDkP6velUg7YI4B5TLyVjbNAblxf0eImlObSemSArh1ujx5e9tqf5YWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P5yKfm6j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ulY4+Ii4; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P5yKfm6j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ulY4+Ii4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 829451D001B8;
	Wed, 10 Dec 2025 01:28:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Dec 2025 01:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765348126; x=1765434526; bh=SXZldEo/WI
	wP6sLRnGQDZDFpn4nyWalgrlptrkDe+xU=; b=P5yKfm6jdav1OMgTwAs5qqexZz
	CCxEJFy1kvxJfedQFywYe2dILeCOmPmmax9vY30u25Hv+tNHF5DUIy3UdczrrkLh
	1KcpexfdFxwhuQHTlKXNWTYQLUWy6ojl1vUUFJWW5PncUSb4Df/7L/8AXywtVe5S
	+VIangTERjcXfnwjGjNvRP5zJR5dEeYJ7NXTr/IkBfaRgoL+XhNyYlJgatykhKWv
	iel9eEDyEzp85+LNDZOt3FgrGULLBtRBHEBlnyfGmQ3eg0i0xsEHmIp7V0roPmkE
	FzH0CD5/mPvswkBTYQMm9DypNrjWJVxY7iYOs1hA8b0wgbhJeOYn1jkf6ASw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765348126; x=1765434526; bh=SXZldEo/WIwP6sLRnGQDZDFpn4nyWalgrlp
	trkDe+xU=; b=ulY4+Ii4L2Shkp/PoxPVMNOcMcPl5UX57M/ynYtMXDIfTpBeHGZ
	7RaCh1smaOYigiUC7C7MDa82nqjR/Rg97dfdTAF11o7006dnIkXRB4sQNRx77YQd
	5KznyEuppeyysQswQv8ErVdtkEhm93LbVUh2K0KQTRA2joR+x3o2LiSlUMpJYqna
	JXIVKRabC99SpBje06iOeuvkNNs3cNgKnFN3Mq4iw32gFG86BrG8CCevSQ/tf47+
	pwFIc7cSqYyLOCqcyzxvV3bfrlnxcOoWRsHykSvk1ji1lejOMcn/bXWUgOqk5Mht
	eMddB96d0NPd0TJ7qqdr2lhJIS9/Wq5PhrQ==
X-ME-Sender: <xms:HhM5ac2OMia2p_OTg2ASr2vpWEXRgeJlGsiVM-kLK_NEowJFWOZoxA>
    <xme:HhM5adGaYvOCsTzgAUrpLr_ky0k8QYdHdurJRd8bU-9wJIoXqqKuC7gpohf3b1ZE3
    1QdaRTq3rOkp-PyKVgbi-cMJQ-2ZTehJ9zNpu0ULrbh2yWfQjmPEg>
X-ME-Received: <xmr:HhM5aSinCGMb2G1ajIr9jDIYPWnrfEC15yQpPKsrO48K4e26CIc30MnIcqpzM_UkFrvFXgxfkhlsWiu3o8kJXq7NTfnQkn5b2ZcdMxGKOq3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HhM5aQ9ll-FhcpJDNqrqogmbUQYigcCgvAdUFySVpcCQ0KC4uuXGBQ>
    <xmx:HhM5aRr_2yfmFPcRgj0rtqJwTyNNN38jfRizc2XxMcH7sU7QAR04eA>
    <xmx:HhM5aX_lbPVCq3saskaHJH-7wCFR4TvNLXmXYoQt-OyJO1gRMIam8w>
    <xmx:HhM5adWDNuQ8FQtiXkHKpHbcRO9P_1PQyWK5mhpNvPhkq5cZHVeWkA>
    <xmx:HhM5aZnucJK1nNn8E8zqusende4O2vs0BgcIu3aPE_Ms6j_B-YmkayZz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 01:28:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45baebc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 06:28:45 +0000 (UTC)
Date: Wed, 10 Dec 2025 07:28:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] builtin/repo: add object disk size info to structure
 table
Message-ID: <aTkTGilv-xRRQVHA@pks.im>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-7-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209225820.2861276-7-jltobler@gmail.com>

On Tue, Dec 09, 2025 at 04:58:20PM -0600, Justin Tobler wrote:
> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index a98c651f1d..51820cc3f6 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -107,7 +121,10 @@ test_expect_success SHA1 'repository with references and objects' '
>  		|     * Tags           |    132 B   |
>  		EOF
>  
> -		git repo structure >out 2>err &&
> +		git repo structure >out.raw 2>err &&
> +
> +		# Skip object disk sizes due to platform variance.
> +		strip_object_disk_usage out.raw >out &&

As mentioned, we can use git-rev-list(1) to compute the expected disk
sizes.

Thanks!

Patrick
