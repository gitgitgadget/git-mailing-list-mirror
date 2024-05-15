Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A53B79F
	for <git@vger.kernel.org>; Wed, 15 May 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779760; cv=none; b=jLh3ISd6iOfLAvu2YCglpo43sI+SZ11fS9z1PdcCiulsyuuwJfmafnDxFpwCa/osRXEB39p9si+JDdbv6UkfgsqnmysNsSnF7Id9VPzpzI4aD0A0WHQrXbn3zyuv92p+9QcB343Hr8BXR0JOu/yJsVHtOZjKCqZhFEW1cqxbY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779760; c=relaxed/simple;
	bh=CnurNBx56hxcEINmXxBoj23WO/DXVXSDHHekkZdoO/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvtvLHF1lJ1uuUjQDXNebMoXZgv3d8/kKt5FcOQZOQOMlgmSBvxxOE2+sMgQGo88kdPfvkilUDLnSuaiZnZ0EfoluBY4M8+Lk4syejiKuU7oLtNsqbbvWOTudKYK2Qx4IB7epM7EAZArWA829zby2v3SWkaf197NrTtlj0ycPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Tuh7g2Ir; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Tuh7g2Ir"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43e09dab877so28293941cf.1
        for <git@vger.kernel.org>; Wed, 15 May 2024 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715779758; x=1716384558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lmy4rFglTRlg3bl2kzyMrjmNyPJsmzRTTuxiESMAebQ=;
        b=Tuh7g2IrTB9klFzenZTPdepwqjQgGsibF2gIOVcaBgii2THQwMRCzzSiIwsYXRze6C
         9dsfTYYb8Nuhgj6aYWLv6Wr5FG/BIP2IsQcWI2RAFPyecW32IEqduethyF+vfCibbGQb
         0DQ84oqsmtvK9kYLyk2pvlJ9nBT0/ut9mbbaAeusopKtU/4Lc64dJ6w/U8jEx2XMA5I1
         WWoVJQbbWMldtPz+bJS3xNW0ed2zEPP/vVVdc5W9pteiEO20ncRZ+MxYSvljroUO0u+C
         2wgplKQthcziabH2RQSQ6dmwA5zxYXv31AlWLS2B7/aGtitc2godpoH7z6EIiHeAMIPP
         bNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715779758; x=1716384558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lmy4rFglTRlg3bl2kzyMrjmNyPJsmzRTTuxiESMAebQ=;
        b=BASTMwJDRUbNc/PUX5ZBa+NUOoeZmPNBoRcAP7WBggTuj6i7xRDmxyvPcM5mDrH5il
         Y5vaZ3BBi3fVOyhlTuGIePovAsqUZ+yNkZ1bMIaeDV4pdqj3LonKZudqAKJlQ3AAZcKl
         p8F5m26/rpRyJW7ROiq9DzfgC9YEJJrW2nN+prtzQ+Tt3QItEv1lkkzF9VQaCN9z+aKO
         HbB8BtTEoX2L6uma7V0yLkIUtFLvUWqprGVukgIsH2iswpJXv/w87SA6YDsvMhYl0R6a
         DkH+EsPWJ0ZOGNXP2mBsxceYOuPbH7WWn6LRTFnQSe8rOetkVoUQ6ub9nYEJPLUgxEj/
         j+rg==
X-Gm-Message-State: AOJu0Yy5Ma81xZXCxOUciniLnP/qYkgFklXRGo/ykCP+PSHG5F2STsjV
	YcQIIXnVgHHG9sDPRJOxXNp/FPmdiizBRGKOFI32QNqC2bcuqeg2n9R8tNnem74=
X-Google-Smtp-Source: AGHT+IEin4IprpNtxijLVyzDI6frZH1iplK8mCZLaJy1fcvfC1MBWnsDJv5niIWV3OewEeYcA/YWdw==
X-Received: by 2002:a05:622a:1456:b0:43d:8b77:7dca with SMTP id d75a77b69052e-43dfdb07855mr177194561cf.13.1715779758048;
        Wed, 15 May 2024 06:29:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e0a4bdce8sm58051671cf.18.2024.05.15.06.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:29:17 -0700 (PDT)
Date: Wed, 15 May 2024 09:29:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] pack-bitmap-write.c: avoid uninitialized 'write_as'
 field
Message-ID: <ZkS4qi5TOThOwQLO@nand.local>
References: <cover.1715716605.git.me@ttaylorr.com>
 <f16175295f5c786fea2d56ebffc2b9a6beb07aa0.1715716605.git.me@ttaylorr.com>
 <ZkR6xqHgrIvoV6OR@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkR6xqHgrIvoV6OR@tanuki>

On Wed, May 15, 2024 at 11:05:10AM +0200, Patrick Steinhardt wrote:
> > diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> > index c0087dab12..420f17c2e0 100644
> > --- a/pack-bitmap-write.c
> > +++ b/pack-bitmap-write.c
> > @@ -112,6 +112,7 @@ static inline void push_bitmapped_commit(struct bitmap_writer *writer,
> >
> >  	writer->selected[writer->selected_nr].commit = commit;
> >  	writer->selected[writer->selected_nr].bitmap = NULL;
> > +	writer->selected[writer->selected_nr].write_as = NULL;
> >  	writer->selected[writer->selected_nr].flags = 0;
>
> Instead of having to ensure that all fields are initialized we could
> also set the whole structure to zero via `memset()`, which might be a
> bit more sustainable in the future. That alone doesn't really warrant a
> reroll though.

I had considered it, but decided against it as it seemed wasteful to

    memset(&writer->selected[writer->selected_nr], 0,
           sizeof(struct bitmapped_commit))

and then immediately un-zero some of its memory by assigning the commit
field.

Obviously not actually all that wasteful, as we're only talking about a
couple of hundred CPU cycles ;-).

Thanks,
Taylor
