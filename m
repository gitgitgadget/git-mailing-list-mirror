Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84854F95
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358637; cv=none; b=fJPeyB43E7qnwy5GsjbvjV11XtmMoeMERjGHzLMxw+QAaoQhayIRSnvKnGLclnWjF6flmMkYogXJ4VUwNHAKf/PnDd6czFXbolmeeVC++iGovi3oN0vjZHPMqicqbYekTj8JGr7Tg3p0wYAgmZp31XwO/CBPILQuU0sDxNfrTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358637; c=relaxed/simple;
	bh=YI3KfVDaTHVldYcWB/9VGzV6y/xX2MO7jfOwoubyMlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h46bcJoFqVJMmG68NhM5xthhmQP2OvVe4318WN0wt6iZgfrFhftNSnTayo2mndZNB4ApcTxupFFHIUpLFcTXLHMBnLV8rN07HdbF1+fLT6yPKuXFrw0ys4/quK2b3ZKjn4/YmHbwzqnNovZNAvlgQLLUYT4nSyACbUttaPlpXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kLv/74qJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvyEMNgg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kLv/74qJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvyEMNgg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C87BC11401FC;
	Thu, 26 Sep 2024 09:50:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 09:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358634; x=1727445034; bh=UTMIZT7EVr
	j/I3XCV91hyx8SfQO19ahK+Rs4OtnMANY=; b=kLv/74qJ/RPny7LqG1ymO3AmlD
	DMjJfpV0Mx0toHG1lph+coS8Nm9JQ3xVl3UxJK9c6xkAIXjs0DteHY3t3WKXRxfS
	V1jwh5Psb+VD5AhvK40MPapRF5TaMDUKjMeEVuXSLnrCA8R1F4fjiUhvMLgfRlTI
	yu7tjhgBO5C6tVSANqlJdowki5k0LsN4x2ziZXFsCk+c4PriX9FR8IkmDl2C4zeO
	n26uYjp3oDNJufZ6a7gv4qNBmFmCGfnCYJMK+7KOPI7uYbXLRaFNYiTlRWa79PiZ
	XHfXjidF1H8pfKgMtGOBZjZAEyVTRommBZDHBe6a5uzgnssJLWLDF10bpfnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358634; x=1727445034; bh=UTMIZT7EVrj/I3XCV91hyx8SfQO1
	9ahK+Rs4OtnMANY=; b=mvyEMNggJRky29g+ub5OyoUOI9KdhlXEgWyPJvZmV1rE
	rSYdqNz8wN9eHGw1VII/l5g6IDMzQHe3YasGQ1P+J4/Nv6RrnmZ2ymPzm4RXnaKw
	/OZ8994DPKmuMnW2iDQcuHOXZwcSXvdbmNLriPHCE8JXQpKPuh0XgkxQk3EYjMhz
	qEM4k0cwOaFGgtrtVXGKM0TAPj4Dw8pj7msQGA2Uf+0Rg9UETdTPm9U6tPZkK0ta
	eA9jHGLE5zKsEH1NSS+T/cTTueB/sj9tC4PMP+JW6CMoC7SglAdCFLVyLyt8fkWl
	U+9B7RJiv+tDyqmngk6d1cD5p4DzgFVLn80+JyjgQQ==
X-ME-Sender: <xms:qmb1ZmsCYmlot8B71oO9mn15BUI_gcanyOjgidF1ZfpBg-gfmldG5Q>
    <xme:qmb1ZrdFgTmZqmNqtBL1JFegbYZROnUe32mMAvBg3Dy2P0otqIgswy39R2CUvBbuT
    7yIOuHwfyiv-TAJ0Q>
X-ME-Received: <xmr:qmb1ZhxxwY7vst8s_lFeYR8nGZeCtWgp_oN7wwn8y4tlf3gE03eh_XjvfY0Lhsjq67ONg5gP8UZoVKF5wytslWchrsyze5TVQYPD3Hysq8q7bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:qmb1ZhO9r2bzix8rwXEg7TjuZCo-Aw8ttZImiK3qx53Nv6-pmjR9-g>
    <xmx:qmb1Zm9XeqCZXxMbc6whosohQxM5H3tZYkLBvs6qJBQRLQ-Di8UYFA>
    <xmx:qmb1ZpWQ35tdVR1IVmJuLqx7m25M_qKeYKS-poJSk5YzO5bstfzhEQ>
    <xmx:qmb1Zvf-Dyw5xn9swtRF8Z_BtQyiHt-7WgfIz1kGsu3S-2ay6Qtj6A>
    <xmx:qmb1ZoJD6fzlJAjQlthVBtXEMoLPwYGVHBx78AyEMD684Xjqfcm0Y2hG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 260eec45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:55 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:50:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 21/28] http-push: free curl header lists
Message-ID: <ZvVmoz8StFi95VXR@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924220550.GU1143820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924220550.GU1143820@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 06:05:50PM -0400, Jeff King wrote:
> diff --git a/http-push.c b/http-push.c
> index 52c53928a9..451f7d14bb 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1398,6 +1400,7 @@ static int update_remote(const struct object_id *oid, struct remote_lock *lock)
>  	if (start_active_slot(slot)) {
>  		run_active_slot(slot);
>  		strbuf_release(&out_buffer.buf);
> +		curl_slist_free_all(dav_headers);
>  		if (results.curl_result != CURLE_OK) {
>  			fprintf(stderr,
>  				"PUT error: curl result=%d, HTTP code=%ld\n",
> @@ -1407,6 +1410,7 @@ static int update_remote(const struct object_id *oid, struct remote_lock *lock)
>  		}
>  	} else {
>  		strbuf_release(&out_buffer.buf);
> +		curl_slist_free_all(dav_headers);
>  		fprintf(stderr, "Unable to start PUT request\n");
>  		return 0;
>  	}

I was quite confused by the layout of this function, where we had
another `return 1` at the end. It took me a second to realize that this
is the error case for the `if (start_active_slot(slot))` condition
further up. But we do already free the headers in that case, so we're
good.

Patric
