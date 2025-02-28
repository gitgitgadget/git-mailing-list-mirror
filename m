Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24E725DAE8
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739891; cv=none; b=XoX2lHldIz9kOW7UN/5VJbCBYsM3kQLURyTyWWqzrellxDPnxFd3Ky7xwD5q/JkoaBLhrrRan1U3uHPJAMSkyCupTEHgt8ku03ziEj4mOlLQ9hBLMMbcO2ugYaoX3VH1DGcBeLreKnKi1oTd463o/uRxcPn/FoB0pFxGJ7A38zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739891; c=relaxed/simple;
	bh=jXsQzPpmOszk1rjti0dQrUMXAnz4QDHs6g3I4dUXTs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/ySTbPb+/Ek4FdFc/0kxYwFXOD+VXUw32YtpDYLJu88u2jaQo/DDNwrgNYbNCLb1JR7FhYkF7rHjWVj23ONSqsT23eGU/T0ibP2FXQoK1cAi3cAlsVSxeRBOC/uzEu+vXExuIgUiJXvdr7N5vBFMan/521097Y9ZBQ4iDPxFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CIh/GYy2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xCdPy/EV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CIh/GYy2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xCdPy/EV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D066811403E6;
	Fri, 28 Feb 2025 05:51:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 05:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740739888; x=1740826288; bh=oOGGcD+r4u
	XtrmFjeOQ1PQ2Ri6HEDyx7iCk89x/AFmw=; b=CIh/GYy22HbdEPaxk3J+jp7Rfg
	QzvtO+0Vd1aZIpay+f75tsxWVxInYTWMSd0lUtMuWDs7CKzoeYVTJKUHfIPHU5FS
	bHxHzfzpPBmWeeqR98cwS9qiRQ14tKBfNI3fzp5ISV+9izE59C8QooLu+Jpb5hhD
	8ZRZHGk7I7/ssQ7taWTG3L8YoR/I8lUyTkkAS2ZaeJYrPZMl7PMA5vXHV15JCr6y
	FzMXn34ozXjgq0/s327foAJM9P2shFMnBM8fjFWiJM+zBtYm0cZV9SwEj5r07SIE
	CwsmWFwTVERJP8NCEx3fuq1+FJjcdOSi33tnLQI/xv7fWjh04ug8h/fwPdFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740739888; x=1740826288; bh=oOGGcD+r4uXtrmFjeOQ1PQ2Ri6HEDyx7iCk
	89x/AFmw=; b=xCdPy/EVhbpjR6Ya3vWgKH5DUWx26sUbW3oh9kEriuOOOLY1cBU
	OdH98ZKsu+BNlU0mKQiFcIUdUUa47jKQvrKDxYu2EZLL5cM2EC+yOYZvBWNgx+K8
	CmfZ/FS9fS/sl5U0KhL7VyVC5tXWvA/ee+QyqfUyj1XCmTJmaubUPWFXGFY84m3L
	4tO8i/p/vJ07lY7Xo3QKrCHUMK1EO827M+vSPwhirJK6BOfGGR9YHgQHRhoOBTGO
	NriQclHFsai+UZ4VO5MpSjr01DeUucBZvw9zbGmNmUxc/TwOYkQx50jWVK2gvW+8
	uR4kfgZtJjkxArI1rfo1ueqMOf9phKzbeag==
X-ME-Sender: <xms:MJXBZ4iMZRU_2dU4SjZc5LLFhzFaEuBNSGSR8JefocmT2Hc_tKQ_Hw>
    <xme:MJXBZxAi1R2RIt8s2FcsYz2SSGCMGJEuTjZ0iPeP98tvGm3O6fmOqCLaPprEL1s3x
    CN3BdLoT5C0y8MbgQ>
X-ME-Received: <xmr:MJXBZwE5em4Q8SMlpxkj4T-CpcMJRoYgWiSIa3SLxQdJBmWIW3Dwc36YhdPt_ur-8fsCw3RvFcudI_5Sm-Qomme5-560Np9OLcedQ180JVY0dsN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:MJXBZ5SXEIkTlLFmQ-Im2FMZ6n3jHSw4oP_5kyDefy8MbSE-CJLuYw>
    <xmx:MJXBZ1xG85SaOtt3JxieWjUEB6xiUD2IQdLJV8cvs8wXgraGEKLPZQ>
    <xmx:MJXBZ345giIWATotdFmHIOWIVUfpnObwNCITLIgvosWoRyJUUMVLNA>
    <xmx:MJXBZyxA32cNaxAj7b9y8nCNbxE2VvjYzTBHfyRjqAJM3u9AT7R_Iw>
    <xmx:MJXBZw9DJliZgo4ybnxRT0Oe6mW8CeWN6f1bSMiLvdLYZwXjFYM6cb02>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:51:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d70f8b28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:51:27 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:51:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/9] builtin/cat-file: support "object:type=" objects
 filter
Message-ID: <Z8GVLrlHY-hwOJeI@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-5-0852530888e2@pks.im>
 <871pvkraqn.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pvkraqn.fsf@iotcl.com>

On Wed, Feb 26, 2025 at 04:23:12PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index f57bf65cb03..b374c2bb104 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -474,7 +474,8 @@ static void batch_object_write(const char *obj_name,
> >  
> >  		if (use_mailmap ||
> >  		    opt->objects_filter.choice == LOFC_BLOB_NONE ||
> > -		    opt->objects_filter.choice == LOFC_BLOB_LIMIT)
> > +		    opt->objects_filter.choice == LOFC_BLOB_LIMIT ||
> > +		    opt->objects_filter.choice == LOFC_OBJECT_TYPE)
> >  			data->info.typep = &data->type;
> >  		if (opt->objects_filter.choice == LOFC_BLOB_LIMIT)
> >  			data->info.sizep = &data->size;
> > @@ -505,6 +506,10 @@ static void batch_object_write(const char *obj_name,
> >  			    data->size >= opt->objects_filter.blob_limit_value)
> >  				return;
> >  			break;
> > +		case LOFC_OBJECT_TYPE:
> > +			if (data->type != opt->objects_filter.object_type)
> > +				return;
> > +			break;
> >  		default:
> >  			BUG("unsupported objects filter");
> 
> I see we don't support LOFC_COMBINE, so we won't be supporting repeating
> the --filter= option, is this intentional? Should we support that too? I
> feel it would make sense from the start, unless there are good reasons
> not to?

I think the usefulness of LOFC_COMBINE is quite restricted in our case
because we only support a subset of filters in the first place. There is
only a single combination that does make sense: `blob:limit` plus
`object:type=blob`. All the other combinations are useless as they only
filter based on the object type, and thus they would yield the empty
set.

So given that this isn't that useful and given that it does add quite a
bit of complexity to support I decided to not support it for now, also
because I don't have any usecase for it.

Patrick
