Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9F1C695
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569093; cv=none; b=SQmBz5D7VdEPTboU4nQhg0fK4NW56qOKck0EoeY6UnvmhvX5lrGVlS5I3q7qMmn/GKm609rYFqHsM9ZoDtbAS1SzfRtoSrfRggHUzgaCwjG3OX5N8ZPPZ8TCQW8imsVbo5d0PAgDJ62X6hKmGwVIH8IH4oHeBe7cbiATR/9ArgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569093; c=relaxed/simple;
	bh=kK7VbZCMNIHaTyDLbBi8jchzWCnI+FH91m/SFV34Bhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2TArDf2KDVgDJNX7iPs/WUZDOvB9ZrHF+8maZGAYCctf2Ds/107zZ4sblL3nkTOwL9jff+eitIh9hAWwR0EPruXrf2GZ88ctrdslgSfERdYzCUM6h3apcgHChSJVQlC+1uZfw2d8LQsogHkJHi18OYsLKpYT2pLSR3kvlnwgHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kYk8x/tt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ld244Fwo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kYk8x/tt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ld244Fwo"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28BD81140083;
	Mon,  3 Feb 2025 02:51:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 02:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738569091; x=1738655491; bh=pVAQ3IL88b
	8H4Zbx4xLgxYJcti4+6pVt2nMJzo5k8H0=; b=kYk8x/ttGXQxs+6VZEcVpxYzC1
	wsbZqBL/WWe7AKUQHtpz6Cy1pqlLaTApbONdf1G2In9TphqH4aiUjXH7FZaVaHjE
	Exha183UY05Se2b3SXUvcFbbT4iBOQa12UnTW2K7UJFF+fOEPo3697ZfQnR1K98m
	bCB6D2mCeOhh7ZhZHCD6w8GNugttoVr6pcQ0Uibe1XNgCju1ykm75T6RjJ62gqfc
	SccX02btN41fx+LpSjEsmK4tDkXRUo8YYKkC2OPCMkMlA+Dipi1RFT5wY1bGvOpF
	ctBrc8rRjL0/yej2LpPkNMJpooVEyA90yCqgYnxiWhE+RdjhRTFg6egodbLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738569091; x=1738655491; bh=pVAQ3IL88b8H4Zbx4xLgxYJcti4+6pVt2nM
	Jzo5k8H0=; b=ld244FwovGOcLyx5LuKBLeOj0008lWgwiJJ1/+2VSlqS6apl3hm
	5nc30yqu8PbF74dLGc+UYMNqiX7gjl/Joo/BAzIQWsF0r6tcNnh9zwTZD+n1jGNm
	DDe2gg+Shcwp1dj31hXN2azCgJQwOVSlwu1d6YerzknolVI5XVnq0ZMyuTReIcs7
	J+9WnIX8i2MFOZxyn3+uUGzWVbPRgyBug6Ay6Rif1AM2CLdFczFIKPNmpdzgQ6PT
	xAiRHJRYzYLS9dm0cS9HcLPABmxdMLiDSXV/bCA/ISn0YQErOF1wPl2KiwssKhCZ
	Qbx6M8UMZ/zyQy8hc5qDYi+Z3WRXEqTU5GQ==
X-ME-Sender: <xms:gnWgZ36E-xE2oePWnge8pdeAQkADLsarqHdkN6nwD_RtxzOrZPKr-Q>
    <xme:gnWgZ865PlFVbx-Rjd2YYR5qSzoKhM1C-CmpC3rP1Gs5QTWoF_WxhTNrlYVdlNmsT
    PyoSIY-_K93fcN-yA>
X-ME-Received: <xmr:gnWgZ-eI7Nf2Q7jmU2Df6qSyVXiDdY3DWEcbwnxsUd_AC67fG1ORXS4viS_24-Fmc0_wxjpQqe8XWeMy-gK7PdeIdBnlTp5yuVJM6HTctw0UWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmshhutghhrghnvghksehsuhhsvgdr
    uggv
X-ME-Proxy: <xmx:g3WgZ4JAjT779pTzsp05zNXNUkCBCQDedcPdq_O6QxsSoG1evMrghA>
    <xmx:g3WgZ7IHNfrLtEan8zbMz4zmyJ11UFX92rchhsD3LXwYrMFSYsLobw>
    <xmx:g3WgZxzPfCJZDS1V6wIKi5p-g80BChZfxwfCuuLdrUyCIVe8UdOE5g>
    <xmx:g3WgZ3LopHmklE9LP9ApbKlIfzIse81vpQ_K5Mru_w34UlJvJvDBKg>
    <xmx:g3WgZxhqekM14pZ0ejUNG7Hm3uUuj1lO_cWYWSh926Hl2M-mngmJU65f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 02:51:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9b96a63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 07:51:28 +0000 (UTC)
Date: Mon, 3 Feb 2025 08:51:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 4/6] clone: add tags refspec earlier to fetch refspec
Message-ID: <Z6B1f1jB8KoTp8P8@pks.im>
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
 <20250131-toon-clone-refs-v4-4-2a4ff851498f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131-toon-clone-refs-v4-4-2a4ff851498f@iotcl.com>

On Fri, Jan 31, 2025 at 04:30:32PM +0100, Toon Claes wrote:
> In clone.c we call refspec_ref_prefixes() to copy the fetch refspecs
> from the `remote->fetch` refspec into `ref_prefixes` of
> `transport_ls_refs_options`. Afterward we add the tags prefix

s/Afterward/&s/

> diff --git a/builtin/clone.c b/builtin/clone.c
> index d652682494d0d27dd73cd0585e28b23f2883786d..7ab156ac00240de89baca6533ed2541839286fc4 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1375,14 +1365,15 @@ int cmd_clone(int argc,
>  		transport->smart_options->check_self_contained_and_connected = 1;
>  
>  	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> +
> +	if (option_tags || option_branch)
> +		refspec_append(&remote->fetch, TAG_REFSPEC);

It's a bit surprising that we also do this with `option_branch`, which
only seems to indicate which branch git-clone(1) is supposed to check
out. But in fact, the documentation mentions that it may also be used to
check out a tag. Principle of least surprise at its best.

In any case, I think it would be nice to have a comment here explaining
why this is the correct thing to do.

Patrick
