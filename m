Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547E36C
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730075416; cv=none; b=JJQ8c8A5KcYQWTdR6i+zcZhtgNBYedI1ccl2nHmQpqOCg5ApaNEOizjexN4IMVCVnNbfkvaGS9P4cSpqWo3ZmWeoPepMPZGVlXEKJanpWTFBpQ2Xj/rb1jgBxIRjXZzs0lGUcG6nsgubblvd2X45YqOLxlWV5X+gVKPBDKcxXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730075416; c=relaxed/simple;
	bh=Y3D5/ko81sEDZf7HIf5Sid+vcuDHD0ZSAJDUp87qzn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXEDXfNxD+JtcwuHJHckNljFunvM1/HTJTBvK/p+n3sdtaTXF7Ri9lGdE9wH7HGBAJlN3ClMQB8/SOBZXGPsQlyAD0iPo9BkmJMeGnQLB3Y3zuJJpMfdPrNQQ5pztbj9MKArYHEyF3q0m7Pea5DR4Hh0FsjUjkTeHShNCdoPtnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eLTpovxI; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eLTpovxI"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e290d5f83bcso3808821276.0
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 17:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730075413; x=1730680213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ2/rl4K/zJTBZjDPZ1Ji0vgeYVOmw5lIp4MXjqZeSM=;
        b=eLTpovxI/V9sXxkX8z00TIa8UOO3Y/t8M4HLGdduwsGRYyNpdBbEz/ZeQ9E+jM7G7q
         MDUoQsAE2c/qtWKB1U8II/nueO/rukWie5y/qRHpQawCDUtDArwUt/HC+3AkLDXEk8+O
         jrKHR5PTwDa2NVSrK97c6F9/vVyJLXyq2ntojgKv8kuPfnnyY6FSJMrXgEMfPb/p5xZA
         WhG4WQtoeH/+4S1fPeehcDCpUo9/AEvqP6Pa7CigBHpmXh1nBDf1+Vuft4yMvc7bU2Y3
         1lFWpQ6beunkO7tYV0f69UXrFjMdEZs61OIt0vUzrF39Wr9K4ZaPvQH9e6GWjJ1VbvFc
         XIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730075413; x=1730680213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ2/rl4K/zJTBZjDPZ1Ji0vgeYVOmw5lIp4MXjqZeSM=;
        b=vWmUgNlQM/kPl1zegNKf5cTCtjTuh8u8wyPQUZxj0cE7r2clshYdWx2FHkHRrFYfmY
         6PZyaMqLXFottQmCgOSrmfc6/08A+jtEIGltlrn6vfmdK5ZC/Tvua3U57MICxMVwiZ5Y
         +bpTShC/zOHoeUBqTDYb9MLR0KREpO9DJHiCqpGlZfb4gM/n3m5dZcy7jtSfrWns//2q
         JjyOxtI6yzXPfRu7VAakqgXOlfGr7jKZymogf4OqQEVs3Fys5EZeFk6VoV+rNpUQ5Y8V
         kUiraNDMOkSBecHF2u0xOiT7Yq4+YmGdxpvdplj/y+qXcc6mah+W/OazEnd2AixXO8Fq
         PlCg==
X-Gm-Message-State: AOJu0YyKYcPm19RIRl+l+b6ODMAGJGZGXZZBp/KU+lghS9pbtSbBUnoQ
	3IjUuHWKnqxLuKMMbdCTWbCvYIkyOdIuU2uj077RGrA2ocMsH5N5qwkpAPjGxfA=
X-Google-Smtp-Source: AGHT+IEjbBZTjBUQbIXiEtDYwo0uc129ES2zIBYga0zVgOsgywMSSV1k60jjWQ8HBdZjVCnMDxtP3Q==
X-Received: by 2002:a05:690c:2d82:b0:6e3:2361:df8c with SMTP id 00721157ae682-6e9d8b0001cmr49415657b3.42.1730075413443;
        Sun, 27 Oct 2024 17:30:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c95280sm11730847b3.104.2024.10.27.17.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 17:30:12 -0700 (PDT)
Date: Sun, 27 Oct 2024 20:30:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, hanyang.tony@bytedance.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] pack-objects: make variable non-static
Message-ID: <Zx7bEq5DVG4CmokI@nand.local>
References: <cover.1729792911.git.jonathantanmy@google.com>
 <b2c76c207d3ea880c612f115f733a91bc6b529a3.1729792911.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2c76c207d3ea880c612f115f733a91bc6b529a3.1729792911.git.jonathantanmy@google.com>

On Thu, Oct 24, 2024 at 11:08:40AM -0700, Jonathan Tan wrote:
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/pack-objects.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 0fc0680b40..e15fbaeb21 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -238,8 +238,6 @@ static enum {
>  } write_bitmap_index;
>  static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
>
> -static int exclude_promisor_objects;
> -
>  static int use_delta_islands;
>
>  static unsigned long delta_cache_size = 0;
> @@ -4327,6 +4325,7 @@ int cmd_pack_objects(int argc,
>  	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
>  	struct list_objects_filter_options filter_options =
>  		LIST_OBJECTS_FILTER_INIT;
> +	int exclude_promisor_objects = 0;
>
>  	struct option pack_objects_options[] = {
>  		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
> --
> 2.47.0.163.g1226f6d8fa-goog

This patch appears to conflict with ds/path-walk, which wants to read
the exclude_promisor_objects variable from outside of cmd_pack_objects()
(but elsewhere within the builtin/pack-objects.c compilation unit).

Is this refactoring a necessary step, or just cleanup? If the former, it
may be good for you and Stolee (CC'd) to work together to figure out how
to eliminate the conflict from your two series. If the latter, it may be
worth dropping this patch.

Thanks,
Taylor
