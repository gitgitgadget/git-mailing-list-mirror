Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A62C0285
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731310; cv=none; b=L54LFvXXD+moNuQ1lYFtJIyv4efBhA5JtY8NGp2aAqjAXmvLz9y1ig8voyVHlhZd54e/S8NwB5e24vZZq428KqjoWvilpVUfEimpTs8DeXgn+rVugW9ZrrIbiZiohBz1sIePqWJMBAuPtxHMkBPl7i17j7giVJmzSksRb+j+om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731310; c=relaxed/simple;
	bh=Nx/WPk994fSSvAzaAO6itqyDMhFKt3ppD1B/RrLXfE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDHaerTb40iPkOK7X/bAhmyvzke66CirUmkooCkUscjyLqeggLq8Uz8zvSxuQE1DLhzI3GnbTbb4Lp8xuN36XQInWlf19j/PpfW66LZZbt62X+rI0muVk9rntkG3u/YSTnHDE4AeUuWiNlk4LI/hB6BLLAYsq8GupQBN3IImr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FkfHZpHn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vpYNO2o9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FkfHZpHn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vpYNO2o9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B3CA7EC0489;
	Thu,  9 Apr 2026 06:41:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 06:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775731308; x=1775817708; bh=ZUePnTQdQ4
	qj76p9EykyJSI7RtBOfPbBA5rOE9X2w5I=; b=FkfHZpHnktP44C+LvK4uxRNIhm
	ltSq8nmO3SsBbLV3VpqGFpDKbJkvwxFQqHDAlPHQZNwDzygR1TQ63XVUZkI2tngZ
	TcTn2hTWt3yauEdvdZdgjGygXh34szftB5pfN3GyJHnZ8XQ5NGMVVAfo7VIFi4xk
	+c8M9FKf5+rVSmbbHN2rCdISnRhhMYq08z9LqU6rSt+TIYtFn+li0vDs1vSXZ0x+
	gTkmsmMEXUGi44tZhf17Pv6AZpE8RfX+g+D+w6lzAuXYDeKkfwZfe0R6I5IbhTEZ
	QibvBDminzSKa1ETwdUxSHAqVvjOqWk5o+ol6I51THgX4so538GWkfyvJerw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775731308; x=1775817708; bh=ZUePnTQdQ4qj76p9EykyJSI7RtBOfPbBA5r
	OE9X2w5I=; b=vpYNO2o9wIF6LhTgqWr/WJBsrU/TdOyY6urvBnSy/BJc71JEhG6
	CFJUBTDFXDMZiIY+q4ZAzSkrzZ9G9NSaVMEnaKeeRscD5+9I7ybMip0j3JatkAbR
	Qub8pyIT37vxNvKc+PqJSU2jieqnFLsMpkUbtyMguEegzglldmK6QL6Ts40MK3vJ
	5aTIY+21YVzfkCEIbyXrqZt1n/KuxvsGc1bj6yAFqAUY9vcBYj/QnmIPrEQdSz01
	RH/llrBNmnNv7LjYkpyF8TXnHQyy9Nc8JoIeLGENDE0JkS56/tMUh9/AsmaEkMGp
	7T4V3zmV8BjYGgE8a+QSt4/0vOnNNZJu6LA==
X-ME-Sender: <xms:bILXaajXLQ3Q74xlk93UPaU7F0N23eT75bQ8sEBea9LMM2IJYxv4tg>
    <xme:bILXaSCDVK4JEbMGeRJxpVB0kdizIIwxcCpKq8uUuSpAYY8-DNCIwJC1zdEV3Jy1c
    ULARslEtRe-1qSWPz2d5h1XpTVPvDkmEcuznp2tFv_V_IVg1zkQ8Q>
X-ME-Received: <xmr:bILXaXGiNDfudj5PATM5g6ApkuO_IlplKrqjsLwNOe48CvOccJ5d4_jweMnms-MPSdYFVIgTlhBOOTJZGleQB3WF7P5yJStFJcVJHOxKaqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddviedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bILXaSK-pmIkaTmlrf_WlYmSti3WeLjDHxb41ix2STAiZcAJi8KMbw>
    <xmx:bILXaTm2akAWjBH5pDecUNlRB_T2824MJ_zD_hfVfaJP5pmZIRBnxA>
    <xmx:bILXaSQaSQbj-jOazICHWxKSNSZsi1VH_I1cLX6Rob9keKzJTICA7Q>
    <xmx:bILXadKMtzO6xhqC5mhb0wFBgx2OnGPLk-0bMWHV2lhsrLVcl5D3QA>
    <xmx:bILXaenf_3nfHMhJUU6sPe1Eztt8Nn2jHauDoSWiGLxANkYyYv8p9Jst>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 06:41:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db5df5af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 10:41:47 +0000 (UTC)
Date: Thu, 9 Apr 2026 12:41:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 05/17] odb/source-inmemory: implement
 `read_object_stream()` callback
Message-ID: <adeCaAonGgwJFbQ5@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
 <20260409-b4-pks-odb-source-inmemory-v2-5-f02b4f1c0f13@pks.im>
 <CAOLa=ZSHAF25zbJ=KHp=u0pFCpAHb-jd45A3dxTSn9pwKHkxFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSHAF25zbJ=KHp=u0pFCpAHb-jd45A3dxTSn9pwKHkxFQ@mail.gmail.com>

On Thu, Apr 09, 2026 at 05:49:32AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Implement the `read_object_stream()` callback function for the in-memory
> > source.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  odb/source-inmemory.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> > index 12c80f9b34..4a68169430 100644
> > --- a/odb/source-inmemory.c
> > +++ b/odb/source-inmemory.c
> > @@ -53,6 +54,54 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
> >  	return 0;
> >  }
> >
> > +struct odb_read_stream_inmemory {
> > +	struct odb_read_stream base;
> > +	const void *buf;
> > +	size_t offset;
> > +};
> > +
> 
> To stream objects, we have a new structure which is used in the callback.
> 
> > +static ssize_t odb_read_stream_inmemory_read(struct odb_read_stream *stream,
> > +					     char *buf, size_t buf_len)
> > +{
> > +	struct odb_read_stream_inmemory *inmemory =
> > +		container_of(stream, struct odb_read_stream_inmemory, base);
> > +	size_t bytes = buf_len;
> 
> 
> 
> > +	if (buf_len > inmemory->base.size - inmemory->offset)
> > +		bytes = inmemory->base.size - inmemory->offset;
> > +	memcpy(buf, inmemory->buf, bytes);
> > +
> 
> Shouldn't the offset also be set and we only memcpy offset onwards?

Oh, good catch. We don't have any users of this API yet, which is why it
went undetected. Will fix, thanks.

Patrick
