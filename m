Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42341C8633
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604783; cv=none; b=PsTd2VK/EhnE5re08pvcnpLIbqLcKcBBGOD9vSWw29j/IITMhyvUlYZsEaoTPkkabm9iUm6S+Hg/2xOu3UtHylQiqmClUXhGUoo0mYNdG2mKWNgu332YW/Ru+KlhE834QiHAUR52x/7ZyCsBluovIWIEyS9EIDPgytUG0X2ZZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604783; c=relaxed/simple;
	bh=M12lwG3WlRzbUAE/Q5n2S5EDzTIO2YXOcW2QVK3qvlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNLREFiw1RVZKorYzTiIzm1YUNt3XwXS+yNCwZZ1biXQFEVT6X+o1S6Ejl3TmzqFtOFa2sw/PBFPE+/XddIDIcPq1nGKZMn7LY/np1MetOqIt5RSFgSdASqhpHA5shGtYnvMgjOGHW4mACCFYJPOlEWNB9cnRAvpWNC0yBBTuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DOf9i+ZZ; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DOf9i+ZZ"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3dc9e7d10bdso4298985ab.2
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754604781; x=1755209581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcB4U3TsG4/0rXnI83azIMpouUdjKqbA1Va4O1GtRSw=;
        b=DOf9i+ZZLYkd8XVz9FXiYlotBQmf74N/sjOxWtsH8Pxgb2zFX8j1FpyBNjzYajxuNL
         g2dZs2d/rQAYdby/D77ESdPkbarsNKgpxHZcjia9hockbsUIDoDfGUhVmLtUEn1TF8hz
         2DfUcY5i7/Sft2b4bgpH/cjs5vbKn47z8IGlSWvBNVF5XOkrL58Ba/g4pJFb1QW97QfK
         gK7l7m5UrnlpAN9qEx+VUUV9TyOhFLlVkFHxDPoaT5XPNVh+9GaFRzygaqXkRI0Mgy37
         p9bLISS/iUykCsFYqtUw6w+UcQoW+7qEYMmrRHSTWc6hjYUVQHQOOGvA1yrW5uO0pOTU
         ugbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604781; x=1755209581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcB4U3TsG4/0rXnI83azIMpouUdjKqbA1Va4O1GtRSw=;
        b=F2dVUSIPTamn7auEiC6fDH1vS6nKvTScVZfXnm+gBnYajyPifGB/fKD+5VY5G/aTpN
         MtqOx1zKp+kBCDxLKE5+KZmwXjTbnN/dL1FSFfdQ+nBI02U47HF0TfVnq0CcgGOcUIZn
         hiev8NOT3Q9Wf6HzRoQ3vVUgfVeUfOYTC3oIRHbYYJYwaj9uA6yfIkF99TMkjw3OHPS/
         +7/liBifz8CY87WIfgFtdvjceTeIDIRErjVqAqqFR13vk+NHWdF73kTJ2JQLP5BuzmIO
         LwMZfT1OkNAF3LK/Pi7DM6nhxIktufsGBwHWkx4HEOCZCbl7RT7+LTMJiSohVQLXe9K0
         3+Xg==
X-Gm-Message-State: AOJu0Yz4/QD4H6AwBdUrzk8sWCNT5G64nWJzJ+CwVT7iTtQ/CQutGWAD
	rY0+Hv4+S3oneStCtOlc7pWLz6B0oCuWtS8LUphpb3qiYRA2OKIsBmlELRJ+XLJWfa1kq5+wm1j
	fqYyX
X-Gm-Gg: ASbGncu5ZIaGplHlkQkJAVBaWPG1p0+PJG9alcvTnJ7TMk11c5P6ErAwptpw9afAOqY
	grn976tkdZy92gK0Wa/3Bu2ZjZXO+StQ2AK55g1oyTFJ3geWfyHdLBdeYfCGxeZ+QuLEp31bWuO
	Dc3aDTUa4lro+WnT3Wp1jvmoQ6B/kKXSuMUW5t2K1vheVyeMyjC06z3eGAmGBCtl3m6AQATQbEz
	AGYEk3/2CnFy2gZZI3P/WyMNR1/CAqbSA07J3C+ecaLQh4RBSRBKa4DMPZIyW9nQeFYYhBNzE2M
	AvPn2Mb50bUQEatZUAzHRv3d5OmHaPxU3BvzjQjYCg/wXUV+CrNbB7TdZqrn8U/IkZuSjxy8GkN
	d2XGidT4av9kEJh8MdlyQrLSy+Yxx5WxvJM0XeWb6XfK1XIo4Wf+OdzVdWkk5LI6h9TFV1d7sVX
	u+lQY3
X-Google-Smtp-Source: AGHT+IH3o1p1gwyyLcumhAVMSFcc8/P7NWKdG6MDIPjV5jebHwNXpSxW58Vkt6R0zitwMJi5nenSxw==
X-Received: by 2002:a92:c266:0:b0:3e3:fa5b:d4cd with SMTP id e9e14a558f8ab-3e5331a950cmr14793825ab.19.1754604780881;
        Thu, 07 Aug 2025 15:13:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3e533c00e82sm1148055ab.19.2025.08.07.15.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:13:00 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:12:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 2/9] odb: allow `odb_find_source()` to fail
Message-ID: <aJUk68fgQttR2gMe@nand.local>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
 <20250807-b4-pks-midx-deduplicate-source-info-v2-2-bcffb8fc119c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-2-bcffb8fc119c@pks.im>

On Thu, Aug 07, 2025 at 10:09:52AM +0200, Patrick Steinhardt wrote:
> When trying to locate a source for an unknown object directory we will
> die right away. In subsequent patches we will add new callsites though
> that want to handle this situation gracefully instead.
>
> Refactor the function to return a `NULL` pointer if the source could not
> be found and adapt the callsites to die instead.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/commit-graph.c | 4 ++++
>  midx-write.c           | 2 ++
>  odb.c                  | 2 --
>  odb.h                  | 4 ++--
>  4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 25018a0b9d..dc2c1a5432 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -102,6 +102,8 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
>  		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
>
>  	source = odb_find_source(the_repository->objects, opts.obj_dir);
> +	if (!source)
> +		die(_("could not find object directory matching %s"), opts.obj_dir);

Makes sense, and I am glad that we are trending towards having fewer
internal functions that assume the caller wants to die() on failure. I
wonder if it might be worth having a odb_find_source_or_die()
counterpart here such that callers don't have to repeat the "could not
find object directory ..." message.

Perhaps something like:

    struct odb_source *odb_find_source_or_die(struct object_database *odb,
                                              const char *obj_dir)
    {
        struct odb_source *source = odb_find_source(odb, obj_dir);
        if (!source)
            die(_("could not find object directory matching %s"),
                obj_dir);
        return source;
    }

?

Of course, callers that want to use a different message or otherwise
handle a missing source differently would still be able to do so by
calling odb_find_source() directly.

Thanks,
Taylor
