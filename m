Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E428F5
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731046641; cv=none; b=H6SxmAkguP1eoJdK3l6XDFo9ontkIMO1wHNdnMjmMjDZNUEYtTbxagrRK/x0LazWhhSHg7IepYmOBUZKtJJHTvjyXUcu+qAz2c8rlj/Vs6rfSrCt31ARzReDteAd6boeZ3tPlkg4aB7+Y9HZ/jazyEvPAmLimGdUa3qNXz7XrQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731046641; c=relaxed/simple;
	bh=NJZeJDaDOXlvI9iULWmEBa6oMoFk3eLjSaU5McsSQlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKkJEFHFz1una7T9DerkMdeAahVrMmgiBfK9CeuUVeUqMnXGQllpHyijYlg7VT/0BPRSCO/b+IJGO7QoHnkkQ+1IjosWV+7sKDf+jRKvEu0L1Vc9iLnOtEr+CmfsUBPcbJ921CTLJJFa1YWQqzYbLmIWWKB/Zm1YOexbMtY5DAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xGiBILib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUqn6h+q; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xGiBILib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUqn6h+q"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D60451140123;
	Fri,  8 Nov 2024 01:17:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 08 Nov 2024 01:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731046634; x=1731133034; bh=yYYJGLk1mc
	+PIyGtjJqLh8RU0QYPAXL5NIBeJ8G1aHA=; b=xGiBILibmS/Z3Fi7nMlr/5qkzj
	oKu+P1uRFhEO1cM63bXDCnJF8UYHhOwYh2YtVJW6AgY6JJL6znrpOuLUrn8n5rH1
	5lZhFUmK1THksZVUtsUR32E6ieUuJ8mFug92iis7u7pgi2y9f5W2nH1hcS52i+D2
	4ycN4GF/xofi30nnnvAwD1EgtW3PnxLQUFPe7M6d9AkKret32kd2yFChhKL6+C2x
	yZKfpv3yFGCrJUMY0b+QX7d++pkG7f39ulTTx7cJEdIz2//I90cI42JJ2v/H9pwo
	iYMYG8DB/0qmUSY28D8oJDL1A8brgwK60G5TPcoSz4TwZqKPE2YNqPdsxjOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731046634; x=1731133034; bh=yYYJGLk1mc+PIyGtjJqLh8RU0QYPAXL5NIB
	eJ8G1aHA=; b=AUqn6h+q7jz0bTBg4JwDOP8GcFnF991G1JR0LtkHEyfknb8Hrgq
	wm71A51MFzyvH7TZUgha2CzSakSSuOiuB4g/L2C2kSkUWNp89MX0X0M2+LtKtiO2
	4jGVjsLbJIcVlpRCNS2tqKIdYIEZKsNi2q6m6c/3VhSusQICFOJqorMkjlsen0BY
	HBvfaqNmU8FleMaCDq6meFvFRjjvlu9atYzK3nPoYMvjIkBq7DzLL9NZfKv0moqF
	iv2RjClLTmDRWOp1/44hLRA5NVNxiVHuRzKJFVUmRpO8cPC+OTjngXjWY9kaeOhU
	6AtOEKdoZJTyqhtM3nyeBKoMYHn5qks2frQ==
X-ME-Sender: <xms:6qwtZ3nkzvMbSYxM678FNg0FD0QK9D7lemZKAeTdWVx1Wl6qyZr75g>
    <xme:6qwtZ60Z3oXy-3r8Ww9NRxjobIyge9qvDTb6UbtPvGogkSfwHiqo8LjrL-TEAWbOj
    UIBl8TXdL4jO2Wisg>
X-ME-Received: <xmr:6qwtZ9q0fjPAoI3Ig_3VMNiT9ryQ0r_rQqcgAq0KsnepbRtX0E9hZD1DNAF-Ffv_eVoAo_JS14Mq9nOCJLJai8lGcJCnoRx6STnGuMPwYnHp9Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:6qwtZ_lISs0j_vZt8gB5bVW-Xt2PwfxEV5HaVhbQ3LP2UKrFetSBBA>
    <xmx:6qwtZ12MAJbjR_if3hQWlphvtvO8EVFSy8EuLL0u474H6p5jolNyWw>
    <xmx:6qwtZ-vt-egqbyvHDrGS0ofJCCibD2Ll2cGT8bs4_kpCYr5TpmkQ4Q>
    <xmx:6qwtZ5UAbU9xxAtdrMzWtVK7NECdQ2ZPIHg9_kOIjBW1M4aV3U4W2A>
    <xmx:6qwtZ-wFnIA3ey_aRsq-WLBhwxaiye4joVDDWnEmGcurCvkS4xgO4kLN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 01:17:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18eb36c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 06:16:43 +0000 (UTC)
Date: Fri, 8 Nov 2024 07:17:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 3/7] reftable/system: stop depending on "hash.h"
Message-ID: <Zy2swYMe9naG4akA@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <b595668a5cdae0dff4a7271a3547c5821aa6e912.1729677003.git.ps@pks.im>
 <hhlsmyyqt2y6ue3abnlwjmrmsslewwjcoiu44aadp6nqkscict@m55ip4ibqgoq>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hhlsmyyqt2y6ue3abnlwjmrmsslewwjcoiu44aadp6nqkscict@m55ip4ibqgoq>

On Thu, Nov 07, 2024 at 07:10:11PM -0600, Justin Tobler wrote:
> On 24/10/23 11:56AM, Patrick Steinhardt wrote:
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 3c6107c7ce5..7d86d920970 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > diff --git a/reftable/merged.h b/reftable/merged.h
> > index 89bd0c4b35b..13a5fe4154e 100644
> > --- a/reftable/merged.h
> > +++ b/reftable/merged.h
> > @@ -10,11 +10,12 @@ license that can be found in the LICENSE file or at
> >  #define MERGED_H
> >  
> >  #include "system.h"
> > +#include "basics.h"
> 
> Naive question, being that "merged.h" only depends on
> `reftable-basics.h:reftable_hash` and not any of the internal reftable
> basics components, would it be best to instead reference it directly? Or
> because "merged.h" is also internal do we also prefer to use the
> internal "basics.h"? 
> 
> Probably doesn't really matter, but I was just curious if there was any
> reasoning. :)

Not really, let's do as you propose.

Patrick
