Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFF1FC118
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572052; cv=none; b=J7lccIngjeL5HoC9aWW0+vp1jvBiwDvGgaJ+QuEZCdJQn74/s8PN6aemVt3/3B8UxjBrnLvIh29c+VvA+Jl7eNFpzpPHluGryxMkshY4OztRBdUqX6PTub0ENHeVl6NigCaRfMFxfq2Qyn1+9Da+yfPVOl1rYJ2RXPn0kjgOLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572052; c=relaxed/simple;
	bh=1agzaL4/beaNS1RKDMLF74L1lt2f2XZeFkV82y3cyws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iei9+xz78JNxO7Ws9bVMjT8oi0eaw7ZZH1TOan9X3wZ0E1X50oNSddUHV5/d8LYxPO47GWLE77hJCAnw1tGUCjw/laQeI6Od3CpXdVaLiJm6TfXEIsIK2nqAo7UufMv8x1ulSxAoi+42W19gJoAGen1zusOWYVuiFL9NgHnTb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fkYfMINV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BDkWUzD0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fkYfMINV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BDkWUzD0"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 20A1D1140141;
	Mon,  3 Feb 2025 03:40:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 03 Feb 2025 03:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738572050; x=1738658450; bh=BxYM254bFV
	ETwxU9uIbw6zT8DFz8k+VYTIR4GWel44w=; b=fkYfMINVeHZPEbJTFx59GJU7s7
	6mOe4wKNhBUSl9MOBgl6TsNVZ2ZAD5kdVym6DvP0pbKGoOEnABx6pU/aJ+FK3mmS
	C2Bf8IPu5h0SgDUlF3jSTSIjMyrwjkJWsBKuTR7zY3PQIVR6ZWGtxWl7Rg1xvA1T
	I4+C2hgrSSB+/rs1ar0u0u90QamzHcTKaguaCWYGnRbSDPv/C4+ZYAzzYQytaOfI
	R5HCSHuvZP902Eq/j90W2ydVdbBWzSs0iOmAaAjrhlGJwcUMDaViP4qpLSGd/xBW
	u4OXOaGhkr8Fy6SYRuGtfQrwwd+rfdAg+QGDOzafHN7uY4iSKIrhXQiLTM5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738572050; x=1738658450; bh=BxYM254bFVETwxU9uIbw6zT8DFz8k+VYTIR
	4GWel44w=; b=BDkWUzD0VzSSOf84pB9FSHAhdJ7sQCCXwTSGTIIpOZR8IWNwgVK
	m9zg/BgAWuQyAR6/CUG0dov/h9v8yb5aOGG7+uKn9iaVksDcY6n69OiyO2Q7xJCx
	BvnXbiAu+vCBDYZoi6rNkZ3Lyi8nfG2leUU7Qgd76EIIM8p19adfOrv3pxB3g5ue
	XP/jxWDKlHMKW9SLrqw/tKYEPv8A2CRnRwiMjts+xRW4wZ3E53l8hlIoRe40ulr7
	3zJBBW6GNjZeB5CeWseHx+lTy2BkNm9Df3ueChxUcq9jXp7nqmM+L8Rm+jGYv8Ki
	1q9DIit7K8JXWBmHnfrEkYiiYlw0VFai19A==
X-ME-Sender: <xms:EYGgZ-yGmdxHmPPhEuc085lQjdHxHRcoev9twul48bRVfH5tD_zDeg>
    <xme:EYGgZ6SWHC6xFTUODxL0wQnyQwUnLlWYILloceq8JCaUotb2RvfBIUBMqKuvSwA_X
    eWRbHTI-E9p9AeoDA>
X-ME-Received: <xmr:EYGgZwXUE2BIfxZVvxljaifrH81z7tkeCT7umnhI21YKp7FVzL3dcY-vQOCWfsWm6kHEfaSlKfzMjgrJBFfDxy9Ek7xPwDI50OkjwNlZkuru0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufi
    grrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:EYGgZ0gwbci0PAHAZM-KcpA3GlrOUXWVszpYjAQwnm-7Q949gEKPYw>
    <xmx:EYGgZwADgp4I5OxriU71W9Ci8wYJ5ko1Q69--YcxIygCbT4D8pTA9Q>
    <xmx:EYGgZ1Lj85DrEW5RZZFSGgRP0w8Mng9qpoF4xCFvbLwVM6tqxhL5Fw>
    <xmx:EYGgZ3AHSfQOYg1F-Nl7RsGjka8DkPngB_aUYPGvpNB1ZfvolqopeA>
    <xmx:EoGgZz8UKtEsQNjT7KZox0fKunhxMPqiifmGWG9tvzENI3GcWflPpqm5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:40:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99fb75d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:40:48 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:40:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/20] reftable/record: stop using `COPY_ARRAY()`
Message-ID: <Z6CBD9oXQz6oKiCD@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
 <20250128-pks-reftable-drop-git-compat-util-v2-4-c85c20336317@pks.im>
 <ctx7men3stwyasz2xnoaxpp66yn6yfggnfzbawzly57puarazc@p3hpzfn2a7rk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ctx7men3stwyasz2xnoaxpp66yn6yfggnfzbawzly57puarazc@p3hpzfn2a7rk>

On Wed, Jan 29, 2025 at 09:46:54AM -0600, Justin Tobler wrote:
> On 25/01/28 09:28AM, Patrick Steinhardt wrote:
> > Drop our use of `COPY_ARRAY()`, replacing it with an open-coded variant
> > thereof. This is done to reduce our dependency on the Git library.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/record.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/reftable/record.c b/reftable/record.c
> > index 8919df8a4d..d1664c47ca 100644
> > --- a/reftable/record.c
> > +++ b/reftable/record.c
> > @@ -508,7 +508,8 @@ static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
> >  	if (!obj->offsets)
> >  		return REFTABLE_OUT_OF_MEMORY_ERROR;
> >  	obj->offset_len = src->offset_len;
> > -	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
> > +	if (src->offset_len)
> > +		memcpy(obj->offsets, src->offsets, sizeof(*src->offsets) * src->offset_len);
> 
> The `COPY_ARRAY` version uses `st_mutl()` to protect against potential
> overflows of the size parameter. Does this variant need to account for
> such situations as well?

It shouldn't be needed as we already know that the allocation was
successful in the source record, and we're basically just copying things
over. But better be safe than sorry, so I'll add it in.

Patrick
