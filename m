Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3384964F
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927202; cv=none; b=qg+YAQIbJBT4FcLvLLYkiusda28a5Qntvte+0F2XXhF3/YDKo+z8LN2erBZxATFXReWrV4Vo8GTtPk8Evo7u06Hm0hyExMY/FcQoxmIlJGfQINF4Rt3mfHZ5wJDvpn6eNapmfuPS5hVPcDTKGJ5UAzKBZhLh+iluAjeEtXgq3Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927202; c=relaxed/simple;
	bh=F6V1B+uiMHmKdfRp37Eb/phExNgnkkbPQiDok+0zMNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+G+1tVjU19U9x5RUgSQzpPEdDdv0HTWl5WkKQ5jiiiR5GNvCNLymvF3ETsIGAYLIH28x0gNIhvEMc8prHvra4PP4UsXcA0h05uI/vxInpT0Zpu1AQ4dAiRirztk/dgGuVIQsZczWg8bt39MzbozCX6Z+FdiSTXgHYdQsCqJLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N0cb0svR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKSBfnrp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N0cb0svR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKSBfnrp"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D46CD254016A;
	Wed, 11 Dec 2024 09:26:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 11 Dec 2024 09:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733927198;
	 x=1734013598; bh=oAY0uMLC4+tTVCmfkhrGwI0k2dQe9rIn9IVkH6/WerA=; b=
	N0cb0svRTl066KPfkUIMNWY0shgKOvL321/LeyX0jqKCJZJDE8F95rsS14S8ky+P
	FCp46KywMncpY4NIIiNIYJaHZtJSkRrMTTAddUsJbnoizkiTmNlKaNuvq8tiIt07
	JLV5zAHp80xfTZs0iEOYzcHPg8bnKSo0lPX5Kd8yVdn8gwhzl9AFJ6wx77RPaILn
	drUhLGzz3ApIgPjEG62OhP3WxaTFbEe1mGl+n4b0crjkY4hvtog6UR8b0avlLZXe
	EnwUBf9JTOnW5ciwzQr7DJ7T7nEt4t5xzbItMEPw3ZBP1OIre3S+SsKrAY9SZnEl
	5J7kB/eH8VCQENjgtPFbRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733927198; x=
	1734013598; bh=oAY0uMLC4+tTVCmfkhrGwI0k2dQe9rIn9IVkH6/WerA=; b=i
	KSBfnrp4ZR7r/5SRV7s9fOZcxpupdpUxRTvIpbw+AGsRR9dMQpNao2FUZefRcuQi
	0zv28jsPxSHPSSC0Mx1tbZIBXQh16RIUFXUGpYUQOMLhPjf9KBdm/G39lo66UBSY
	yxroHjqhxVZYIj0LIu5sY2Y0mlguZvSbS7Qgw3GLY5MXxYJRpmqWSQoP+dM7K1TL
	9WZ2rBwQoCajxYX2jffPsGeP9/JGBKJ9fkQ2DdyssJ7/gkw3p9ef2GJYPw5FAR8L
	sb4yzGIwfI7UgqfIiaXHlQsfJBYOoki35c8EJN/HwC3+OdM0RfAWyuibuJgakxrr
	RzTK8nhaP0FuZoyM9zmHg==
X-ME-Sender: <xms:HqFZZ3hlo1aqRFwdTIk0BDtK1Z-Lzsph1Y4j-wUtnLrTDqxRY4Zgrg>
    <xme:HqFZZ0AgUpMfdClITGDmPsWpznaZq9aq7uzJ_zbZEi67C-slwGUGk3QesjnS-Dyw6
    6q9CdoIYWSuVvVd3g>
X-ME-Received: <xmr:HqFZZ3GTUbVrIhwXDjNvSJFUpCM8rg3Mw5zET6skpY9rdPUQtL_7wjq8oyg7FJc7q26z3NWbb_86svdkhQhu3ucDxxGqIM1TV6niiuQQRdSBRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugi
    hfrghmihhlhidrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HqFZZ0S5Qq15W4mBN-f_uCsnRZXXRBWPmc77rE5lic_8YKk_OfZXkQ>
    <xmx:HqFZZ0y-z7Y_pstc7fj29o9107DhWCkbZYFey-vs21NQYcd2CiLT4w>
    <xmx:HqFZZ67qYlI6r4eOhVxipK6e_Tns0e0HAVHssGoAmM9YLwdKk0Lm5Q>
    <xmx:HqFZZ5zR-6GTzx8hEVKtLpqXknW7eMJAIsKyMAszKWhrO6p1QXb3MQ>
    <xmx:HqFZZzonxMAwPEF8SYTu3T0IMKUOag8MzLYTLasFiZEIpKjQye7s_Das>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 09:26:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9b9e994b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Dec 2024 14:25:02 +0000 (UTC)
Date: Wed, 11 Dec 2024 15:26:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	toon@iotcl.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/7] refs: extract out refname verification in
 transactions
Message-ID: <Z1mhD2M4KgzA17k0@pks.im>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-4-d4bc37ee860f@gmail.com>
 <CAP8UFD3fZ21TXgtMcppXMHf35qgA-UH=0X9z-xJ456qXyV5=dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3fZ21TXgtMcppXMHf35qgA-UH=0X9z-xJ456qXyV5=dA@mail.gmail.com>

On Wed, Dec 11, 2024 at 10:26:31AM +0100, Christian Couder wrote:
> On Mon, Dec 9, 2024 at 12:11 PM Karthik Nayak <karthik.188@gmail.com> wrote:
> > diff --git a/refs.c b/refs.c
> > index f003e51c6bf5229bfbce8ce61ffad7cdba0572e0..732c236a3fd0cf324cc172b48d3d54f6dbadf4a4 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1196,6 +1196,29 @@ struct ref_update *ref_transaction_add_update(
> >         return update;
> >  }
> >
> > +static int transaction_refname_verification(const char *refname,
> > +                                           const struct object_id *new_oid,
> > +                                           unsigned int flags,
> > +                                           struct strbuf *err)
> 
> We have a number of functions named 'xxx_valid()' or 'xxx_ok()' while
> I couldn't find any 'yyy_verification()' function, so it might be
> better to name it 'transaction_refname_valid()' or maybe
> 'transaction_refname_ok()'.
> 
> Also I think it should probably return a bool so 1 if the refname is
> valid and 0 otherwise, unless we have plans in the future to follow
> different code paths depending on the different ways it is not valid.
> 
> > +       ret = transaction_refname_verification(refname, new_oid, flags, err);
> > +       if (ret)
> > +               return ret;
> 
> Then the above could be just:
> 
>        if (!transaction_refname_valid(refname, new_oid, flags, err))
>                return -1;

The only question is whether we want to discern between an invalid
refname and an error. But reading through the code it doesn't seem like
we want to do that as we always return either `-1` on invalid names or
`0` otherwise.

So agreed, this is a good suggestion.

Patrick
