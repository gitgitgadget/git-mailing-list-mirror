Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9815B97E
	for <git@vger.kernel.org>; Mon,  6 May 2024 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031047; cv=none; b=J4VnqXLOKYHsr6BsRZxRzo+CjVHBoxcC+ZdFztH/Pg+IEppjg5MCija1OW6BYEMo8WraBGy1ycVyhIKvgNLu/VFN2OCxU1cXhWZo/sJ2Ytac5Vu/WufKDDYGPLhQ4sVvEGpDfn6S00yeQLeA0WhD2+ALLcDf+FguUkDY824d3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031047; c=relaxed/simple;
	bh=ayDh35KZ+PpZg/5SNYm1l8qGvID3COdlwDzGC8kqhPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+dbdppQ30Cty7VAbq4XY9jUaXj1Ow67WLKpWnbFjeRma92m5A6DH/BPObrERiw2tMCsPMoblVK0tsVtmOTbBLCpr08qtA6la7edV9gNKqzeoOPCLE8JZg2Lqytpw7qqitYUFhYM3HIzJcQJ0JgZhmxMSnT/rZSnVnaGUEWiRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJJSiyId; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJJSiyId"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f065bc237aso659837a34.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715031045; x=1715635845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bULzNsR763aktQNBUnZwXqnl7+zyOM2z9/bbDm1qdV0=;
        b=QJJSiyIdCq4Bt9ESFRkKPuSy7EL6xTnAX0strlDLngpxX4U9JbAOw/TiHhmaw/0pke
         VkMuoty+E1EOlPtn/lthk+9q9i6iMHFbj3HA14Mf84bXY8muygJNEuDbz60Ar/6VI5Ql
         QUvCXtvlgneF0oA/O6Qtic9qpJErJPOJEk3swwPo9OeM1kq+9cj1AYEyDX+GSBAPojJ9
         MEJcIX+InJ7u/Gxe57ikrSxpxxUY8hx2Bigd6vtUvxEGjeWcnjois5qzloZmoIKn5Sq8
         5QY8RAcnCDeeul02DsZTfVuL4nN0KqlbWHGwuaoB2kwISgIMJanLomUbxYoN0w8KqRxM
         RVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715031045; x=1715635845;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bULzNsR763aktQNBUnZwXqnl7+zyOM2z9/bbDm1qdV0=;
        b=g/suo4X6CoaSeQ+paG1err6H0Bh6qvBg1cJ245hE9PufOqgawGLEbA2OlVBmdZBvWK
         OL7wJzhtzi5QkMQFPrwOIGySlnQnK3jDFI65M25FYIGzz80hehYBj8ck/rePqC3MJAI+
         gIWmLYFAhoQdOG2fDAI3D+04sSaoEPuCW8OicnJk5QZh/g2nSsTodcPIkT5yYCclw+7i
         0cG2JFLSLmAAws9dIx0Sq8/lGfUJW5RQFbffhALE/ICqoPsvn1szNl5G1vi9I8ztebXk
         65v9M5jKO7BEiapNDEKCRi2K9qghQEQAxM8NViogQDYOIw5SbiwlVx/yiXZPIIsYpg0c
         /QUg==
X-Gm-Message-State: AOJu0YzxFKSxGzLkmX4w+z6SBu1jZM0PnuEzyALlZwGdtE/QkB2zWVoR
	xirvc1ER966nZzYUklT80dtGHEnCT5JS22qgRvAAkC1UBi0/DUOg94BOQw==
X-Google-Smtp-Source: AGHT+IFR3jjDvl3+joFRBfy2PUCD4DVQEDr1AvpjfVN08OSBmwa70Ge9HR62MOMXObafnu2uTTJHbA==
X-Received: by 2002:a05:6871:725:b0:234:56c5:9fa5 with SMTP id f37-20020a056871072500b0023456c59fa5mr12514625oap.57.1715031044861;
        Mon, 06 May 2024 14:30:44 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id hq15-20020a0568709b0f00b0022a4444451dsm2131402oab.13.2024.05.06.14.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:30:44 -0700 (PDT)
Date: Mon, 6 May 2024 16:29:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/11] reftable: expose write options as config
Message-ID: <2rozmhwf2jpyqmy5vtf2t664ko7ztinbzdmwirrqxspjwzgj7t@jctxour2o73r>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>

On 24/05/02 08:51AM, Patrick Steinhardt wrote:
> Hi,
> 
> the reftable format has some flexibility with regards to how exactly it
> writes the respective tables:
> 
>   - The block size allows you to control how large each block is
>     supposed to be. The bigger the block, the more records you can fit
>     into it.
> 
>   - Restart intervals control how often a restart point is written that
>     breaks prefix compression. The lower the interval, the less disk
>     space savings you get.
> 
>   - Object indices can be enabled or disabled. These are optional and
>     Git doesn't use them right now, so disabling them may be a sensible
>     thing to do if you want to save some disk space.
> 
>   - The geometric factor controls when we compact tables during auto
>     compaction.
> 
> This patch series exposes all of these via a new set of configs so that
> they can be tweaked by the user as-needed. It's not expected that those
> are really of much importance for the "normal" user -- the defaults
> should be good enough. But for edge cases (huge repos with millions of
> refs) and for hosting providers these knobs can be helpful.
> 
> This patch series applies on top of d4cc1ec35f (Start the 2.46 cycle,
> 2024-04-30).

I have reviewed these patches and I have nothing to add. Thanks Patrick!

-Justin
