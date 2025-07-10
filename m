Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8E29ACDE
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191926; cv=none; b=ae+u8I2WyvgoLYZ97cNuVKWNv5sBmxCSb9iXTZy36Dz5q/HmWklgPRX8eRaH65wDxhRURH91KBG8rjr+4aZMDxdMz8DgnYrpMmxi3Yc7i0Oj+OXlPRvrHInxk48R7zNxh8OSfShVZ33Gj8P8laL8pwxSVc+GBaI3beZ5D72ziFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191926; c=relaxed/simple;
	bh=DnsFmz5HBiDAJ6NxMJTCEFBvY2s2YFx359emsSzMaUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqzAPJYWaGYuMJF56flilHDFgAhGToQYpPsFePu/RSisQ61L98CG9c/9uwvlyw4YWiwEOQ5IclKotK6gRilHsd0TR1fwDuV0Lj7UdmSGBof+qL6XX6+36eyGj6KN6Om1n9uHcIjGvUv5jU4g/sR8Xpa55oJ+pPinqO6f/fGiSTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hIU/x3fr; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hIU/x3fr"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e84207a8aa3so1080306276.3
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752191924; x=1752796724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hl2AHD0ZeMRaGyBl8533+a1brrPLjkCipau/6NBf4Q=;
        b=hIU/x3frHVO4KWhpN6BCI88qdb1hHsermUOJrLt7mLP2xfJ57Q+UB/KBYfpkWdbfEn
         3KCNQajC2OuEfOcrdI9JOIiGgRkI7k25j/XhA9SJOIrHjMWIPm0KWItQdCIMqt6ggBgb
         e6kFzf1pb3IE9exGsQCQBrIP0YoTolLr19TpR3nnhhyevrzPD6j6KIn8BaEhE+X0UPtd
         Svs558inhuhK7n62TaVJEuQclF3k7o+Xr357DKmAv3JsPLuRqabpzQIDUSSR9tjTiZQ4
         vXujQpCuMl02YU8FhKOvHeD0rdbR+/0myyJTVu3olWTpY+iMDfgkQDy/K20TZi8JuV75
         imhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191924; x=1752796724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hl2AHD0ZeMRaGyBl8533+a1brrPLjkCipau/6NBf4Q=;
        b=BE8Ah+mHJ5T+PksnrphwTwjohBBS9wyRSXhrm+0650v21yKVBtQG9dyky2+RjF3rgF
         EWlbGvSPTsz0RBolaBpoQMWdxflpr/2ms3CV1z5gt7bDRRaB2Gky+8sfUHon9CZEitqd
         1b+oWA7NmBY1JCVo+UvHj4LksZ5lTGbsm3+ft5yPw0SLjoIXmACI8qvcnBNefifG8e0e
         EUj449mLLieD/lbBroCMXkazHQRtK9eEjl7Rn2z7xWvL4TpLf33Es/GMZdWLSGeqoBhb
         sZROHQZhuT7qEDhBNLaNORr89gmTILhBs7Hw4spGjsUIxRgg8ogG9FwE5K8YHl4vaCk8
         N+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd3CjcNTV9AgeUhV+c4Sljk/CSTM5GIkbvZhWI+llKkImnGpByuBzUUVSw8pp7l+AmHcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTCj9kVrWEWaddUG9oxCnnulQQW9z6esOBLdNfctXRovqDMmt
	8ioXxYSZgOC7TFKnLBJiURcR0RFCqsmVcVxFNmjU0jQyRuax9c4pUrQCR3SUFDQlHbY=
X-Gm-Gg: ASbGnctP2mxRguH5Mq1FL78/wGtuj+ui97amOmeVO7bRE8LWwYhpuaehGWwixTCgYW0
	7glz/80LsOF5Ylp6cJv01HAGkN3Nij76G2bKuE2TKPoeUUn6SgmJv5WDXllk5loxY5Lttjv6QCB
	t6BM/tHFhwhPx6G+d01VUTHmIaU+E4hz0nEe9P0r5pTz4xN/MpmI39kN7JSJJoLbGfTOnFyUsmW
	fZVqwhTroqspiMk8n0uwwiHCgKm7o2gvbcWd+Lk8C5+nO/Xq1Z0+BQHAh01Ci3IsBbDHKsjY7Q0
	2qqiDo60JP76WHwugK1q0C6A35H2+ZufKFxvikUD1sGAC4DU3G/G9hEQ4KFy0UK8aGV4zwGphKr
	QOmtLV7GBAVZLP8wfPbuT0BGx0HI4ASck76VKGC5wV1i3N0rl2Vt+JjbSKAZ7dHzgRKvTow==
X-Google-Smtp-Source: AGHT+IGFj5b+ppEONxMXs6lz8RfDUYqStZq6h44zzqSORrXsTaif6Iab4IT44EPqaDOPgzuQwxghHQ==
X-Received: by 2002:a05:6902:4901:b0:e81:b080:31df with SMTP id 3f1490d57ef6-e8b85bc8226mr1472122276.36.1752191923668;
        Thu, 10 Jul 2025 16:58:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8b7ae26ec8sm750618276.8.2025.07.10.16.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:58:43 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:58:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] odb: track multi-pack-indices via their object
 sources
Message-ID: <aHBTsm6fUexaTKB4@nand.local>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <xmqq34b5aumb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34b5aumb.fsf@gitster.g>

On Wed, Jul 09, 2025 at 03:04:44PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > This patch series thus refactors the codebase to stop tracking MIDX's
> > globally. Instead, they are being pushed down one level so that every
> > `struct odb_source` has an optional MIDX itself. This simplifies some of
> > our code and will make it easier in a future iteration to move the data
> > into a packfile-specific object source backend.
> >
> > This series is built on top of a30f80fde92 (The eighth batch,
> > 2025-07-08) with "ps/object-store" at 841a03b4046 (odb: rename
> > `read_object_with_reference()`, 2025-07-01) merged into it.
>
> You do not have to deal with it just yet, but FYI, another topic in
> flight has a commit that adds a few more callers to a function this
> topic renames away.  Namely, 5ee86c27 (repack: exclude cruft pack(s)
> from the MIDX where possible, 2025-06-23).

Yup, there are a handful of new get_local_multi_pack_index() calls in
that topic.

> If this topic needs to be rerolled after the other topic graduates
> to 'master', we may need to see this topic rebased on a newer
> 'master' with something like the attached patch squashed in, but
> because the other topic is at least a few more days away from
> 'next', and it might still need another final finishing touch
> iteration, let's keep these two topics independent from each other a
> bit longer, and let me deal with this trivial semantic conflict
> resolution, at least for now.
>
> Thanks.
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index a74b2ca7f3..21723866b9 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c

Assuming that in these three cases that the first entry in
the_repository->objects->sources refers to the local object database,
then I agree with the proposed changes.

Thanks for flagging it :-).

Thanks,
Taylor
