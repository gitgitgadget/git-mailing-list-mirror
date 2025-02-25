Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8266433B3
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469191; cv=none; b=rwv3G7zmDrMqwcEOJ77s3jqzevQ1+wfVLisUxyZfeKydwBTDEWzGiM6QJRCJJ0hx8eFa8U6MlmemzI7BjrMVSmrHYHPy4IzetekM+Hz34tuW+BIPCYiUsdnIgyaZ7x5wddA2POfFPUM4sw8NaDzczYEU0U0tfAjQcSxSqYEKpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469191; c=relaxed/simple;
	bh=WPlVcbX7Of9SuzW/ZBetSRP3Wpcy7TVQ0l02xtbHhYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdKhtSTFclkNjkYz3wzuiHR4AdBuJEKBRTCd+NwAnp/MdxE8BYksOthw5DHXK89gRT6F9TmcRMPHMg8oGpxFmwk/hKOYZt3P1WboWVleuI8OtbyEvtYGlExUBFW0JBeKJ3pb2Icwq8+x7LJRv08Mp6Qygrm+2OR2z35rC+D9+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DNe3eyXS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uIBjxHTj; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DNe3eyXS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIBjxHTj"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F2CD1140171;
	Tue, 25 Feb 2025 02:39:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 25 Feb 2025 02:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740469188; x=1740555588; bh=ccpjmiV0/c
	fmk/qlj9j73MQqo3IWMykurEWYmoDzxXU=; b=DNe3eyXS9iUQmf54X/jp3kSF04
	zdd6ReBhS771ARuqNegogbBmPyEfTvq26voqBReU+Cydnw7P8SPUz4Vn7J0hJ5No
	8I0FXRwosoSc5uDQdjJZ7ggZZVuyns9VksEyrDZiMN33I+DMkGcv5RIhGhEYqYTW
	02gaouLiZcjXw93Mg31n18havHq1G5960ej9kZ7RFR5muC2DD2koVCt3b8JmY+pn
	lKWUUqkVOo3/gIcgpOAh8N1r72isIqQTE6pIHz88VdFsGL3Ut/rAhjUMOmNEmivf
	uhaOcur9WhZm5KeeFCrZ5Fh1fUskniJlQtN+gvc+6Ez2giWV87If5k/q5/aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740469188; x=1740555588; bh=ccpjmiV0/cfmk/qlj9j73MQqo3IWMykurEW
	YmoDzxXU=; b=uIBjxHTjSFQrXnVrrLGvw+P6qqx7oj2+cAY3t3AbnFYLIieS/td
	g2pwpNAfM0SEcMKNimTUffPNME0m+uYApuODrfp5LGCRqIvmGR/fdfcdhefgL0LA
	G+egPbd0dAbx1Gr+rqU0SGNEzZHQeSX+B/GvGzHdtuqcEpBpmJp7lm9he24fjhGt
	uQYhbR9FkeW3RY65ICybc1rvLXrhej01vqZu+7sbTwnruJfjqGnQcM3+1JS21plM
	JBCePQvZBj8xwYzcmTGMv+8yBgb0+MulTLStjgjEZv17yyoU3BxSn12qCMd6H9ao
	k1deIpsyxT1Mhe4TGsAvHgUObjFHpyVo03g==
X-ME-Sender: <xms:xHO9Z71qRBpKYtfGUlIc6zUvMQUYS7PXs9LW5QYvkNRkuaA3SOxz2A>
    <xme:xHO9Z6FcOTsMP-LsvBtD_yFtMRW9ehcdvYg_gAGx8O-66igbYu-o_Ez2AQj8RJCl6
    KwZqLo7qjzY1lWD2Q>
X-ME-Received: <xmr:xHO9Z75ucbpCHy8Cd50kEtbKuutQvUkQenka6wnwGen_lNUQL2NnB1kBMpZSC9H7_9yvVymwl3_A5u5iUBlP9SUlG-Xy_vY98B0dWHnfI72NIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:xHO9Zw1H1mtxa4LL1rZzDzuXeVevXAp2Q3DyhF8hM24NdV1pwng3ow>
    <xmx:xHO9Z-GyUXD1nqApWRmMCfbPlO_-M85mavLbwfnDkSlpND6Z4fU9Yw>
    <xmx:xHO9Zx_s0b8aIB3G96udQfx2H9yvVJVl0xAC48mpw0qOYimLwDOKbA>
    <xmx:xHO9Z7n0tkeILM_ufG_9MZVdj0-jOo86WMr-qG-XQTfdgcS394EWsA>
    <xmx:xHO9Zx1Rp8eObVAqL1PYv6ma37ngH3FADlEQqjhnt2RvfCb8VRusGsVl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 02:39:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 75f833d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 07:39:46 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:39:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 11/16] refs/iterator: implement seeking for merged
 iterators
Message-ID: <Z71zwGNcKaX7mGAl@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-11-e696e7220b22@pks.im>
 <Z7x2IEdRP4fzdXMo@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7x2IEdRP4fzdXMo@ArchLinux>

On Mon, Feb 24, 2025 at 09:37:36PM +0800, shejialuo wrote:
> On Wed, Feb 19, 2025 at 02:23:38PM +0100, Patrick Steinhardt wrote:
> > diff --git a/refs/iterator.c b/refs/iterator.c
> > index 757b105261a..63608ef9907 100644
> > --- a/refs/iterator.c
> > +++ b/refs/iterator.c
> > @@ -96,7 +96,8 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator)
> > +static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
> > +				   const char *prefix)
> > +{
> > +	struct merge_ref_iterator *iter =
> > +		(struct merge_ref_iterator *)ref_iterator;
> > +	int ret;
> > +
> > +	iter->current = NULL;
> > +	iter->iter0 = iter->iter0_owned;
> > +	iter->iter1 = iter->iter1_owned;
> > +
> > +	ret = ref_iterator_seek(iter->iter0, prefix);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = ref_iterator_seek(iter->iter1, prefix);
> > +	if (ret < 0)
> > +		return ret;
> 
> We could simply use a single `if` statement to handle this. Is the
> reason why we design this is that we want to return the exact error code
> for each case?

Yup, I don't want to loose the error code. We could write this as:

    if ((ret = ref_iterator_seek(iter->iter0, prefix)) < 0 ||
        (ret = ref_iterator_seek(iter->iter0, prefix)) < 0)
            return ret;

But assigning to variables in conditions is not something we typically
do in the Git codebase.

Patrick
