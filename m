Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47643368BD
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 05:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772601387; cv=none; b=REeKxq2ePO8gKSWX1rsKuEqslIWbgElpf4IHsReeiRn+7iViYmsHEPIOc8NPQbREHvz6xm9vJ6b1wZo62TeUGitI6P6ck1yKhfgExq0dnjWrLEqVDKx+1dxqriNwH+358UUVktw42xS9tVzX+5llOJOK/c9AxJk/Wv79DYpMqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772601387; c=relaxed/simple;
	bh=dbwt++jBAEtLihNgRndV6yMGDTPp+I+xY0SUIzvDtfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trCybrEP9wl5zxRCvX2ZMyRMq5+39qerbOw6YHW3WD/Q7u6wx0FlnJd8SVSNPsBq/T3i6vQ6pNpHzH/H3ErR4kb+135opk7HT7N6XR35nYpRhgiE5p2METn8JdKeJfsz4BdPWI2RzxmY1BkVMbfFhfq59yHDbGlrNwEluDAxP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DKy+rzib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKQL+HcK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DKy+rzib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKQL+HcK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D902F1D00239;
	Wed,  4 Mar 2026 00:16:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 04 Mar 2026 00:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772601384; x=1772687784; bh=auni0uXA/i
	MH+LoLsHEQgpa5LzTALS7vX1l4vJk89G4=; b=DKy+rzibgZaa65s1efeSSheNX7
	Nr9D/cifTPBCK0J7XQyUcdE5V1XTpiwPU+T0c/07MW+P8S/A2xa1fipEisMItixY
	nAeCMDC8naq8iuFCjVQ8nSAuxCujWbrgkVvRITvyfdM47Iwrg2gXsaASvJKhPuIg
	nyPbIQOX5gzaZaHdt0Ts924j2uRw8zSuD+ExCHKBkU9XNtLIbVAfZALKmr85S/lv
	N3pU/O482yCI2I9Rp85OcwXo+6qAh3qJsH1pc+03Ul8w3flqwNtK5q22myy+JL6f
	KtwPCGAxIPiMLltStzNhL1xRHy1T1SYo5nFRNxJquBEOGAKUK1v8LOpjhmTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772601384; x=1772687784; bh=auni0uXA/iMH+LoLsHEQgpa5LzTALS7vX1l
	4vJk89G4=; b=SKQL+HcKDW/wb1HkyKzXVw3/m9i/jG0VwaNmHA/kAJzb6BSZADn
	TP8cxLa9+w4Kzk3X0HfSC+8AWr8vqKKZeIx5jOo4D4Eue8c8OpXERwovGwwUn/xn
	vFV6raSMFvCnM4tBJ2j/A/1BpwQG2c4ozAmUj2g1hfONh5Phc6NeXbhSjCv2I7IZ
	7g9f03HlPNZUYFkNWfqTOVoIQUDTosRFiXqjU/xg/aRqhR8uflfzMAJN5d2lci9m
	OH9JZ3MTBc89UCCesR9qS67y2u26OSmtb/GqlQl1Rq7NSmRz++v6Tftp41aJRKGA
	vQWwqy+HRDjECeIbNI2rjJu0ucrisNGMzEA==
X-ME-Sender: <xms:KMCnad9HvYFTnmM_lXnWN8Kf6FtBW6vaT18JuoI1MpJLvKcMwFPmHg>
    <xme:KMCnaZLrj6HdgORIA8jPkzjO2Lvp6gXqTBRLC4onmjUhkqWg6KMaNnh4fJ9737YL3
    ituQ-TGW0twgElP6Df7FNxbYgVHRiMaCk0VD5jKmiffA3qxvXFbod0>
X-ME-Received: <xmr:KMCnaYaBAhNX95Gc0uewEoVBgU03Kg3n_Dx4jqnvpot0uHx75RT5H2kgUKOnxvn2QIXcD6NLKcoBQfcm9qgBwn6qP0cIzOD6Brfp7DK2sKlvaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopeihshhinhhghhgtihhnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KMCnabINwtyTUsUnCHykCK3p8HYHnzj44eTZ-JRNXKIkyYM0ck9YrQ>
    <xmx:KMCnaWA8Z70kKrb92uG5n96q5vMl6NSksYoDL1TYtY8yAYnpV-N5wg>
    <xmx:KMCnaQp2RFh4fWqJfYro4QRS0wV1jBKvb_vIdCHqM3Seu88tAHDwXA>
    <xmx:KMCnaRhIPgLmx4QDkvVYGdKyW-hp2S1MkYy4pa4rNJbV3-AVFaO6cQ>
    <xmx:KMCnaVIArwPujXfZKBZ8ji1YONYYNB9fnHxatJM4SO5pYE9Cy7zGRaoU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 00:16:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7f62ea37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 05:16:22 +0000 (UTC)
Date: Wed, 4 Mar 2026 06:16:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/2] t7412: fix typo 'submodue' in test_description
Message-ID: <aafAIqqq1PdzmQW3@pks.im>
References: <20260303175750.361563-1-ysinghcin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303175750.361563-1-ysinghcin@gmail.com>

On Tue, Mar 03, 2026 at 11:27:49PM +0530, Yuvraj Singh Chauhan wrote:

One micro nit, not worth rerolling over: I think in general we prefer to
have at least a sentence in the commit message body, even if it repeats
most of what the subject has already said.

At least for me it makes the review a bit easier, as the subject of the
message will be gone at the time I start writing a reply during the
review.

> Signed-off-by: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
> ---
>  t/t7412-submodule-absorbgitdirs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index 0490499573..41ee035e3c 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -2,7 +2,7 @@
>  
>  test_description='Test submodule absorbgitdirs
>  
> -This test verifies that `git submodue absorbgitdirs` moves a submodules git
> +This test verifies that `git submodule absorbgitdirs` moves a submodules git
>  directory into the superproject.
>  '

An obvious fix indeed.

Patrick
