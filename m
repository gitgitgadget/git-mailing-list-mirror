Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB12AE6A
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789111; cv=none; b=KpKg+vne0rUWfEGSXHLANuocREDwAnKcMIwKGXU5uUvdJerwepsleIcPHgQ/bwAPIyAVgopkCf5bqfbtg+2Wh3E3iY9I8zpydy/3DPrsARmQamvuVnkGyhRMw4XH8emMZ976oY2XRBgGsfU8SxFnRsu80RjujmfBDwaJkdmH5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789111; c=relaxed/simple;
	bh=Ec/p5CmEPKfNKjPm2DFIYIrvTLau+pTur/AKraGAEWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUGPghDqObth4q2zo0bX8V5ev+IxoQHXuUSZKHE80zI3EwKRUnkZwo1RJZom5xDJdo+Ies7IWn/zZEocVtsvruFV8bKgyCbSVU6wgW1rX4pQk3siSE0tWekei3L8nEWOycb3S6eWp6M2Ed/LOJRoVS09Iszjco0TLHNeHh85rnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xrd44rtK; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xrd44rtK"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so2125669276.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 16:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740789108; x=1741393908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh9LMcswaXL3hAM2byAFsc5mmNfqbRXBT7hOnWnbj1A=;
        b=xrd44rtKVQvtooRTbxGysoFqloodLXZAk+6uGPTDDAmlpqTnt0oRwSIV8sZDniB69b
         TXuuHR8yi0dJem3js54IbT9Cxd9hxeym5OytZhrGwsUisUWFXUr4siSLrxwtXwjTi218
         ZJRQwjUf1orb5WpYLaF/rJa0Wyuxq0uypd24wSnlWmw5rjhL88iHux/lPRMV5pwzSXpB
         SHthsTJwkz2Bb8Q0NNKZAr1H7Z7SfRQtDZrIMWClAmLn6EQw0dyvVhNvhfw2Kks9LmZx
         FCmhYPz2cmq2sXaWyBSJOfQ0a9+cGKqO3PCDPYOsF3qPT5VA5pZCW4i8TYiep5aWuu2s
         0fBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740789108; x=1741393908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh9LMcswaXL3hAM2byAFsc5mmNfqbRXBT7hOnWnbj1A=;
        b=TF1DKAjd8hNK/ISo8bKFZUHvCzBmwo+SSYsJ/2Bsgo7dzAlYp8nwdJ4RP3dC2t1Law
         muvRozMW1EARm5NlbOqyFQ7q6wxqQOnWMblN+wfLjdz+v7nHGVN7HFGPLTCoLmXJ4Btt
         R23j92gArj5CGHzgsFekoQEwYoTjc0FW84oDsTQATUKmXktliBjZkhK9Ww1R/Ryv7Xbt
         g6+p3MQSFRkrqpx3XWUkkxMhMy8ACHfLbF1fdEt0PSV2hRMVMSJbFftsmG4QqiwWqQue
         fj627ggvMn66ezplmNO5lgAVAZgxjy4V7+Ze0c5yFFzR2GAXbxVmpKNLrM2GCFL3iYbB
         YhJw==
X-Gm-Message-State: AOJu0Yw//CLQ11L6RahrMiNMp7xblv1qIWni041Ocyqrh6i+8O3qb1LK
	JZ+IQ3SrK8lej+LqJkE9CB9Z/A/+qBUphSAse21Gdg0ut4CrdRwS85Csip7NY3IZwR1nFr9PmO5
	n
X-Gm-Gg: ASbGncsJhktBJmE3UHSfAtq/TNoyByEfy4zawXhQiyBGs0aJg8/4peayQSfrGvxBBJq
	2rt47OGg8QvbySzemqRDXUG2zeYXCbjrysJLKQv+HRnmKLuUe85NJDXJFgixKkzdZYY8MQdRw6G
	N8LAd1NHZ8gSLGxAlEcYjpxtPYjkk4mJ2gPx10+nfh+/XR/jyYoQWN5mD6Oeo4Qz0eMSEwBfJOW
	GaCJ9bRlFXFV+E452E0r5S8RdWZOmX/Eo+C2dkLe8AvIwwJ01wPbyFQP3ziqzBXoskIjwru+Czf
	ocSOU94ptvOUBFGBJ65HGEsETM78rB8b00HXJbhXJPb9kwuD4RphtrGgSODcJ6A0F8N7gfzVTLj
	wnYM0BiGTZf29TgVk
X-Google-Smtp-Source: AGHT+IHyRWY5VPp2e+pye9TeD+z9dfq7aXrAzXahpjShgQVbgZiZfIigBlfglgzYAdWntntgi5Cevg==
X-Received: by 2002:a05:6902:1089:b0:e60:88f9:b081 with SMTP id 3f1490d57ef6-e60b23f8464mr7554313276.17.1740789108386;
        Fri, 28 Feb 2025 16:31:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3a2d11bsm1415027276.13.2025.02.28.16.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:31:48 -0800 (PST)
Date: Fri, 28 Feb 2025 19:31:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 13/13] midx: implement writing incremental MIDX bitmaps
Message-ID: <Z8JVc8+frlXwTghi@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <77ddd1170f9178849b5dbfd9cd16a14ae96cfa87.1732054032.git.me@ttaylorr.com>
 <Z8GJg8TMeE8YLrqA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GJg8TMeE8YLrqA@pks.im>

On Fri, Feb 28, 2025 at 11:01:39AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 19, 2024 at 05:07:56PM -0500, Taylor Blau wrote:
> > diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> > index 49758e2525f..1fbebe84479 100644
> > --- a/pack-bitmap-write.c
> > +++ b/pack-bitmap-write.c
> > @@ -25,6 +25,8 @@
> >  #include "alloc.h"
> >  #include "refs.h"
> >  #include "strmap.h"
> > +#include "midx.h"
> > +#include "pack-revindex.h"
>
> Nit: let's keep the headers sorted alphabetically.
>
> > @@ -206,19 +215,37 @@ void bitmap_writer_push_commit(struct bitmap_writer *writer,
> >  static uint32_t find_object_pos(struct bitmap_writer *writer,
> >  				const struct object_id *oid, int *found)
> >  {
> > -	struct object_entry *entry = packlist_find(writer->to_pack, oid);
> > +	struct object_entry *entry;
> > +
> > +	entry = packlist_find(writer->to_pack, oid);
> > +	if (entry) {
> > +		uint32_t base_objects = 0;
> > +		if (writer->midx)
> > +			base_objects = writer->midx->num_objects +
> > +				writer->midx->num_objects_in_base;
> > +
> > +		if (found)
> > +			*found = 1;
> > +		return oe_in_pack_pos(writer->to_pack, entry) + base_objects;
> > +	} else if (writer->midx) {
> > +		uint32_t at, pos;
> > +
> > +		if (!bsearch_midx(oid, writer->midx, &at))
> > +			goto missing;
> > +		if (midx_to_pack_pos(writer->midx, at, &pos) < 0)
> > +			goto missing;
> >
> > -	if (!entry) {
> >  		if (found)
> > -			*found = 0;
> > -		warning("Failed to write bitmap index. Packfile doesn't have full closure "
> > -			"(object %s is missing)", oid_to_hex(oid));
> > -		return 0;
> > +			*found = 1;
> > +		return pos;
> >  	}
> >
> > +missing:
> >  	if (found)
> > -		*found = 1;
> > -	return oe_in_pack_pos(writer->to_pack, entry);
> > +		*found = 0;
> > +	warning("Failed to write bitmap index. Packfile doesn't have full closure "
> > +		"(object %s is missing)", oid_to_hex(oid));
>
> Is this warning still accurate? I assume that in the MIDX case we don't
> have to have full closure in a single packfile, as that would otherwise
> make the whole thing rather moot.

Good question -- the warning is still "accurate" in the sense that the
thing we're generating the bitmap against has to have full object
closure under reachability.

It's important to note that even though in any individual layer we are
only selecting bitmaps from the set of commits in the union of packs in
the corresponding MIDX layer, they may well reference objects from
earlier layers. And there it isn't important that we find some reachable
object in the same MIDX layer, but rather that we find it in an earlier
layer or the current layer.

It's less than accurate in the sense that it says "Packfile doesn't have
full closure" and isn't marked for translation, but I punted on it here.
(This is definitely not the first time I've had the thought to change
it, so maybe I just should have done it here.)

Thanks,
Taylor
