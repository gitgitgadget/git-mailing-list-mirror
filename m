Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33E20A5EA
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929717; cv=none; b=b/SxxznSt8HwzWbFqGg6teXzVY09MpB8Z/9bDAbdwZ3hKq26t18Ypl1Skn7qNMtIFBZe3nh35NErK6tbZDuobg/r5qjNZb4cCYoQWqOz9KbmW6pCZCQN1QNzIJ0f4TYLSsIoyehAeUumKKg7kLA6ugVKKixh28upOt94WrL1BmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929717; c=relaxed/simple;
	bh=n0sxjPFENVqMuW/ZEPZtzjvDt6jyri+IO9klVWt6Bew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJI03GDzJnoy7W7llO79eTSb0m7jQvzCCplmIRaaKnYMCcAidzlnhaWco87tz0oXgI6JfPTwn1SX+1UYY7kS3mk6lXZy2leJzx8rXAFCFeN0pPPVrUxSCz5YPfIfwO6VJKxp3dLkrnjaPHVDzkH6sw7Z8weYbhnkx9++9t5KnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B8P4zft4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZdejezY2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B8P4zft4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZdejezY2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABF047A01D1;
	Wed, 12 Nov 2025 01:41:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 01:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762929714; x=1763016114; bh=H2YRotQA66
	JEDwQ8z3g6EgTRTI0FOfw2HbYlROu4WUE=; b=B8P4zft46VhcXGxpyJHvL72+qh
	vFRU8Dmy9N2Fjc/7TzhebzOqhFhJ9ykohCcwDv5Rc8DwtZ4SboJ5TYoC9UUlQW0P
	umSUAGa/M35jNTnNYMWuXavM+lYcmm7G8VSedUh7JaoRGxGLHyenpmEuVRDA33gA
	59oCnMJSuvQBc5e09X5CQKMGwNUy4opnVHOMBVEWLGFJkbiw/VsHt4qybwVUQYsk
	Z3TpddNTjNgQP0z7kk7/FTD3ys+saLCJB8W7608ljk7WkLFCRN0uyQZ4leg5SfBU
	yymSVo9ige5DffdX1ADLrztDgRZZwkeof6xcxrrsboIW1mlvraLbvKkF+RYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762929714; x=1763016114; bh=H2YRotQA66JEDwQ8z3g6EgTRTI0FOfw2HbY
	lROu4WUE=; b=ZdejezY2zMN9B/6GLxU/GTa18QLYPnQZSGA4m8PNdW5awLXWd+8
	3j7FwwKodbEw5lJAZRArfrArrX0h0s3zFoda9kJjRmZCyZFT/ZfvC7SF3vDEWuOO
	olU+DXIltz7rPplyT4vml42Yjmdw5GnvGCHCup07z6239F3wNF7Re8JBNY7AibQo
	DTPz82Of5OCYQwAAiRaciE4+o0D/ufVzBXlMdkhuIXLh/xENXHEJaul88XbRQKed
	J0wM/zXV77focQzF+we7uHSmefKbovjPkcQH3fJl8QAnFABBsgXyGBgXoJwF9s8p
	h4ows7s4C9byKVxMjhyZ1uPkOQszXIIjToA==
X-ME-Sender: <xms:MiwUaeR9rLUv_JCjjCGRfL8X3fwSQf13gMYwqQijn9C7qLV_PZabCA>
    <xme:MiwUaZwRUPJwRm5H1HMBoxVDJwm5t20NUyVSTsU6sT8LoJVKNu8llJq9jOHW7XhKR
    avgW7akwFrn8h_BvmJLqYsXSbmeeXJjSpFp2G937CQC40Wypg9JPg>
X-ME-Received: <xmr:MiwUaZedAtTC3wzZQlavrySoE6pWa1qWZjU3PZMg0Ta-oLnbhcTpGdjQ4js8_bjtdDLQQHpxgIvLkPqSU3z_jCD1KzKWTtmF4K9iOp1KKsM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeffeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MiwUaVIMwf_OuL2cW5RjEk-X1kRjLHf02IO9dFjNwmbyF9C6Eo883g>
    <xmx:MiwUaaFoorfoD7jH0vFOQ_TszSOjVLAxf-qL54rBJ3FuMvgPl97KPQ>
    <xmx:MiwUafodK8oqyKDyRCqKJ3_mzrMnSp5B94eOGbgCRT7Lc79Ge3BEOQ>
    <xmx:MiwUaTQSVxtgx_WmG-unBcQA1SLmAybzC8hRfM_YWQvZWAuZz-g6zg>
    <xmx:MiwUaRpOKiBm986uM_WPrriisBK15GR27vioaSBPpL9rBNT6-DOJHIzn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 01:41:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57447738 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 12 Nov 2025 06:41:51 +0000 (UTC)
Date: Wed, 12 Nov 2025 07:41:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Documentation: your checkout directory is
 "working tree" (part 1)
Message-ID: <aRQsLNXFdB6KIe0Y@pks.im>
References: <20251111195853.2511146-1-gitster@pobox.com>
 <20251111195853.2511146-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111195853.2511146-3-gitster@pobox.com>

On Tue, Nov 11, 2025 at 11:58:52AM -0800, Junio C Hamano wrote:
> diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
> index 5398691f3f..ced73fa8af 100644
> --- a/Documentation/git-rev-parse.adoc
> +++ b/Documentation/git-rev-parse.adoc
> @@ -305,7 +305,7 @@ The following options are unaffected by `--path-format`:
>  	directory print "true", otherwise "false".
>  
>  --is-inside-work-tree::
> -	When the current working directory is inside the work tree of the
> +	When the current working directory is inside the working tree of the
>  	repository print "true", otherwise "false".
>  
>  --is-bare-repository::

The option itself is unfortunately misnamed, as well, as it should be
"--is-inside-working-tree". We could of course introduce an alias for
it, but I'm not sure it's worth it. Definitely doesn't have to be part
of this patch series.

Other than that this series looks good to me, and I certainly appreciate
that we're now being more consistent with our own terminology. Thanks!

Patrick
