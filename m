Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE32B9B7
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730373; cv=none; b=Z9eKSBSh3y/PJtCiLS+hUrougBfSx1C/zZO7r/ykwy5bLDsCPwWbE/bhM1OKXSefLKBtNOIT3DV2mdujHsRlAu1e0PnSMx9go2dPoZo8O2vLklVJ5I5kWj0o91VTs2rKAHi2zalpHNZAxs1mhL+6NZI4U6aORXV6UGmgAxQRwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730373; c=relaxed/simple;
	bh=cX4ZYTyYMyiqFORmszUR3kxXXJBB78sH0ak/FXxmulI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmHcoN03ZSAsJybVcYoCY2UUcnTklf/eN/eyVifVt84KqQqQ2gQTAiQoFOYoY0UMRo5G+tnbBuGruTLrATI+7C4mLm9/d6TbOx82TDCB2CA3ZGhNbHOBU9wGZ/edR0MeCGWsGCnValBDp6RX3DBYYV3vptam51hGVF+73REUXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYNbz9/B; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYNbz9/B"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4152698e745so1297508fac.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 09:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772730371; x=1773335171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORbqngRWeuXXMe73ZKEj2W5Rsnh8dv2iXPbiWp5xJMY=;
        b=lYNbz9/BBxltq2ex96HOTjSU8nDvow11/+lsOlDU2o4+ETjx+9iW8HKGFSKQtOcmCv
         4ztCqJA1DzaRa9PCfjLhYY94IBKmWfeguOYmrjF488HgpctuEQ52YZkh+mpTgNEp4KlL
         obUmNUfYscPzphLSP9J6i7ZwIPCpuHDHY8bw1I7o5t/VB4Erl4OfXNYPbLoU5m7XV4cf
         p3gfNCf2LRYMVZYhhFPt01qav74SOMbJZ6zQtSj5LDpFfKhDAOmsw4pjZhKD1gp43ECp
         6bYP3BSJR+YIdvgFTc8u5+MlpDdwZNRNsQij+as98rgxhUFSifKWEo5slpERoj4lLrCD
         EzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730371; x=1773335171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORbqngRWeuXXMe73ZKEj2W5Rsnh8dv2iXPbiWp5xJMY=;
        b=rdFOViI26OpMoasAji4+QrYN8ZP5SiK459zzLCeddnjyXKrVvBX41osxhvfH7AJeTB
         dHD1GRbiDtTojqXrn1bkn4K6hKYHuM+uA4PbS3OFoicSWU/YFMKPDPuixMzpxvXJF7Kd
         kaE5eSEF7rVHvaoelJX06urDtTdcRh/uBz4q+DmByV7vLO+dBwR9eCpvwVqjV3jYmf01
         h+9W5xy63cmZKJmKL2bMvyaLf7X0yfWu51CJsNxiGwWAHhSTFBjICso4WBa9X5hsAO9h
         XIZPkPFxUqI2QfPzjVUWcixjh8bPMyIwI+xBtnRadzfESpak/ZCjpboyhFzW3WKKK5nV
         MxtA==
X-Gm-Message-State: AOJu0YxpgEmrxMkJVhYutAz4291Jreo6Fe4kUC2Uh1QJp0EGEs8B0Lt/
	bxBYchhDMesbRaIB/PHBihWsLKGXF05IAyH2dPRvgPY+zQPRBCu718vHnQ6Zmg==
X-Gm-Gg: ATEYQzyx7gBkqSriKA61o4t99iKH/8lJP9NYusayAVf+zpAWKmN+++MRot8ULfkI5Vr
	cmT35Fr+/axM+/rH3kOP/l4J3vkHUs+/6Otg+7FNnA+m7V9GxzrjU0H2LJo5YoybDx80JNungUn
	WPsKwF6VW/Ds7xWntJ5yIpKKQL1oWre1CIQkKjHCAyTk+N9HoSfhGjuQfoJMrccybLHUUnTFwJA
	nfxk5EEKJ912R9Dc9mMVpog4L2i2g2QlBRlZJ3H7ACOMmtgweJt6b/YMX+uIl4rrnrRITwPSEO0
	NE5fRArMLpzdVpOm+GZIPs7qtDJr44SfXvlTkDDb90UhWADVkT5Plji1EUrjdiI7MBSFPLBWKqv
	eZJpEqO9bHXFH6M5UhyXAO2bXL8u4zdKEaraxI/dSiPsQ4eyBVF9tnw3nwyvnDUMtws4IxG4QIB
	sRQkWbfxbl6iHQQGDF
X-Received: by 2002:a05:6820:1996:b0:67a:1c94:8da1 with SMTP id 006d021491bc7-67b1774fd96mr3454515eaf.48.1772730371350;
        Thu, 05 Mar 2026 09:06:11 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bcbb58sm15790647eaf.3.2026.03.05.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:06:10 -0800 (PST)
Date: Thu, 5 Mar 2026 11:06:10 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/17] odb: embed base source in the "files" backend
Message-ID: <aam2f4NBwOEor-Qc@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-3-253bac1db598@pks.im>
 <aahkh1ICViKjP6Il@denethor>
 <aamDyLxTYQdh9igw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aamDyLxTYQdh9igw@pks.im>

On 26/03/05 02:23PM, Patrick Steinhardt wrote:
> On Wed, Mar 04, 2026 at 11:40:47AM -0600, Justin Tobler wrote:
> > On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> > > diff --git a/odb/source-files.h b/odb/source-files.h
> > > index 0b8bf773ca..58753d40de 100644
> > > --- a/odb/source-files.h
> > > +++ b/odb/source-files.h
> > > @@ -10,15 +11,26 @@ struct packfile_store;
> > >   * packfiles. It is the default backend used by Git to store objects.
> > >   */
> > >  struct odb_source_files {
> > > -	struct odb_source *source;
> > > +	struct odb_source base;
> > 
> > Out of curiousity, was there any reason to the reference ODB source in
> > the prior patch? Seems like we could have just added it here.
> 
> Good question. The reason why I stored this pointer in the preceding
> commit is mostly to demonstrate that we're actually using the source
> that's passed to `db_source_files_new()`. I didn't want to have to
> change the signature of that function in this commit again.
> 
> So the field was unused indeed, but intentionally so.

That's fair. I did find it mildly confusing to see its introduction
without any uses, only to be renamed here. But it's not really a big
deal either way.

> > From a naming perspective, I do find the odb_source_new() vs
> > odb_source_init() and odb_source_free() vs odb_source_release()
> > interfaces to be tad bit confusing. I understand that odb_source_init()
> > and odb_source_release() and only intended for use by the concrete ODB
> > source implementations to facilitate initializing/freeing the base ODB
> > source. The comments also do help clarify this, but I think it is still
> > rather easy to get them mixed up when reading.
> > 
> > Maybe we could rename them to odb_base_source_init() and
> > odb_base_source_free()?
> 
> I think for `odb_source_free()` it's a definitive no. This will be the
> way to free any source, not only the base, and this will become clear in
> a subsequent patch.

Fair.

> For `odb_source_init()` you have a better point though, as it really
> only cares about initializing the base object. But I think it's still
> sensible to keep the name as it _does_ act on `struct odb_source`, and
> it would be the only instance where we have the "base" infix.

Ya it does still act on the `struct odb_source`, but IMO the name fails
to properly differentiant it's usecase which it a tad bit confusing.
Naming is hard though and I don't have really a better suggestion so it
is probably fine as-is. At least the comments do a reasonable job of
explaining the intent here. :)

-Justin
