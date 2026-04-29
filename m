Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0B39F166
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777505969; cv=none; b=g9DxSvvqu+HNpmfMoAgeBA5Ab1nUsSzZLYXTEYPAE+V/OIBFlfieK5RwibuPJDMVfzbjb9E/uki/8SM+NGqoJplqFqgJlSN0fmrzeG+3NWbHspQpfx0RFwoq0QcR2P+xIRMeoKrAOS0im8H81m/232Qrh6ZFEYiiFAyfJL27Heg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777505969; c=relaxed/simple;
	bh=p3j/4tXhXsx5Uydnwaa3wc8z4C7oFSk9Ah4dysNyENg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4vGai49OqhDaRoVe42ilKBrc3DtiNNkAMVXsgRfRtU5Ei+lew2kvmYNdgBwJGIZEwaSLF0UhjtZZU28YFev/jku0OTD8e1KKZIDrzumXhZuJNZESzGinwZ8XtkUU/ZdwLFEWO1NeWbKeQuc8HizqZOsVQNwkfy8llHBsrq3pcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=H6jvBCUd; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="H6jvBCUd"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7a43424f861so2924507b3.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 16:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777505967; x=1778110767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gSgb4SIty9q3HvZXHwuKyeHI2QFixXgJnu1+z3Qa50=;
        b=H6jvBCUdlEzwjRN/+6jpj2rgAmVIt/RTifHfiT0z6Zu/uTMc6vSpQ+90BTEWhTWn8e
         gW+L72PWvkZIJ/c6jCN6b0dthLswIcp0GHOkzVF5Vbs4aG0KX/c6OkbxhLKiU+GsirTS
         D3rzH52ElTOeTmvs/L2A/NbMK1gi5WvSlQqu5GtWs9KROGGU8xBRgUlj2JGzdTqWi0g6
         IGtx7kb+Lc0P1gvbxDob7cRBO7vdhoKzNwfUlatRexSdPgqkOPXhNspneX+YzF6C1zlB
         VVMAObCCoPX50NWk8qS9Z5FnnAJWaRHL6qpLjs+9QVjXIybkgucZvnzcPSulZsw2b6+J
         Ihsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777505967; x=1778110767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gSgb4SIty9q3HvZXHwuKyeHI2QFixXgJnu1+z3Qa50=;
        b=kGwybgISpP//y6eONrB3sp4/+AO+gqxsrY7AQwnyS2dh4yyt2k6WfqA7I2sfuHaWAq
         VQ/m+JJq0Pq334XDNcL90pzATKrVOcg2fksfVldgZDBxMC9VxbM9MCCntwMHc82eCso8
         bSlYlS0oc/5edXH4SGp4ISbu8OYO9d/mlKmMOKNktu8dT6UHa7teQqvHIMtoJySUe6UC
         x1bk+kW3+PZ/RW3Ialxr2Nq8yCWIkdkrfKdijwyqcxU7F0AiIcueVGdmgt98E4iIvjyf
         xsFraj3S374DklnkXdu8zCpvzMRtAc3BCYwTUsy5tA0SVGTQsOqtNF+rv4nrYksBRnd9
         EX/g==
X-Gm-Message-State: AOJu0YzR4dmSuUyOsE+K7j34kGh9AwyMxbIouUBGy9ETmK8U7m8/j2BB
	MGfPKyiW7fTRA7/FywBHZaLrSOXAcVNQ9vtccwdl3+gX/Bjx4SRL5ww0KzfVOOTO3Bo=
X-Gm-Gg: AeBDieuIj0HBLmR7a1RXYGB1yHvQuEWmod2P4wIwLowjZzxAtkhADt/QhkLwZlvo42p
	EOq1TGn7dfxwPDWZyP/JooU2IhkynLqc9RMSIQqWyCnFbQejNXKpVuJBKKglH8YnIqeA91+6RxU
	2T883nyPUNDy91kpypmqlr0rcsTiGwLTTcCTo1S6H6LDOF1AX1gdSR9w0/ThbpsJ4njqu4F9Ivt
	TGOZdDO64vSqMLkhaESKE2y5JJ51jb3KETFnDuHdo/LtYNvd2x31BkUTcTxYtlaEwanjm/OxOUB
	4aCk6zDK1SNtYw7CF+XfIWcFUdUMSSWSrQO49qgaqTG62866gbSZcEX2jGxdaxGa9udgkxrO4t3
	BFExuiMnGDiZms0XDo6nUntgKEkYSQ/IzJfmZ2PNj7thQqfGzcdDg21Dl/RVdD1mMn8hmkzrkpG
	eSSxso2uJrIHcz1IVDsETWOzGLKC+kqbDBu74TSBhjTQUkEPijx603sWDBImW6kHunfVt3yd6jx
	t9cHN5nOb51bccSzV0oq4b3zMISeMDntRNMtk6gpX7b0Ji7vHm7iDdlHGoUHSRU+zHc/CIFBj1s
	YEMh40DJhI6/3upvxYvir0Lzgrk=
X-Received: by 2002:a05:690c:39c:b0:7a4:80ce:8275 with SMTP id 00721157ae682-7bd52967f8dmr8468267b3.35.1777505967378;
        Wed, 29 Apr 2026 16:39:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd5525b00asm1129297b3.42.2026.04.29.16.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 16:39:26 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:39:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 14/16] repack: implement incremental MIDX repacking
Message-ID: <afKWrukfb6WNcE1T@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
 <93e152fb6aa3bbd450d46c6cdd219dfef14d41fc.1776803827.git.me@ttaylorr.com>
 <20260429081017.GB1269182@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429081017.GB1269182@coredump.intra.peff.net>

On Wed, Apr 29, 2026 at 04:10:17AM -0400, Jeff King wrote:
> On Tue, Apr 21, 2026 at 04:37:54PM -0400, Taylor Blau wrote:
>
> > Unlike the default mode which writes a single flat MIDX, the incremental
> > mode constructs a compaction plan that determines which MIDX layers to
> > write, compact, or copy, and then executes each step using `git
> > multi-pack-index` subcommands with the --checksum-only flag.
>
> This should be --no-write-chain-file, I think.
>
> Ditto here:

Yup, thanks for spotting.

> > After writing the new layer, the strategy is evaluated among the
> > existing MIDX layers in order from oldest to newest. Each step that
> > writes a new MIDX layer uses "--checksum-only" to avoid updating the
> > multi-pack-index-chain file. After all steps are complete, the new chain
> > file is written and then atomically moved into place.
>
> In the code I think it is all good, though:
>
> > +	strvec_pushl(&cmd.args, "--incremental", "--no-write-chain-file", NULL);

Heh. Clearly I 'git grep'd through the code, but didn't adjust the
commit messages. These should all be fixed, and now by the end of the
series we have:

    $ git log -p @{u}.. | grep -c ..checksum.only
    0

Thanks,
Taylor
