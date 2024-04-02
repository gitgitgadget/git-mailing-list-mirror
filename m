Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B115E1FD
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095129; cv=none; b=cYei7qCOH2jS91XQMUKmAynLZjm5smqEf6qTNW7Pu0NHGZouv5nFiUzb7DiisfcmEnaVyUhjdJSMhLJ78vdwHrQ02TjA80mUFPxFvyKIyv/RsMSLo8+MQy53JqFB+w0kq0XCIufhojWnNm53oQsm5L0u/NqPqG8uY8+ucB3INow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095129; c=relaxed/simple;
	bh=rouObz+vgwjAglG0Km+I1QyFr58bHXeqAyrTTw5lvvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsjIykaesxpHC+I6UIA+7zX5GM2UvzFHdXBcnO7VkdEIQHyJrlcr1+k4LmI4n6wlty3tuXxX2iYVMref9ub2sfqg/VtsrA62pwbNEWB3QvGq2epevJtYS2oJRSAdTi7s6vYSb6FaHeGPJmgAJElC90rJTpLDvJYWyUDWmHZSG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc6JZnBd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc6JZnBd"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso6341579b3a.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712095127; x=1712699927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpxkcxNzJYRghHpzbOtIoRkHNqzGYlogkajxD35wlDw=;
        b=Gc6JZnBdor+YdNejdjgTVmho6DQ8rIYhLnlKlOoBmo2cwTUi/E80eM38zW3boWU3JL
         d1idI8El9Q4pMS90C5KR0ACJH7ZU0bT2pgx6o6IBxP1x1Sz6nKJQ+OxVmgh7wCEt9Gah
         aVxFNVzoyrhszawC33Ikg1d9tFIp2/jl+ep3mGrMFe99l0hVjnbAMpa2idp40YD3P8Ow
         DTAepB8aghrlpvs2bi1b9KByl70JewjiYse42ZmS5VBnBZWJRFMhY/FoUwdzTfec0pT/
         A9bTLlXd6NImrImQYWw84hdUjBoC/zhZLOwx8GtzKyzhGs0kBMKmXe4V7bp9AqDe6wdj
         49bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712095127; x=1712699927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpxkcxNzJYRghHpzbOtIoRkHNqzGYlogkajxD35wlDw=;
        b=OjZQrfsu/8vHIYeuoAFCGrZZ5XazFAuib0nmEE81Mk4/shvaICRN9mRG4u+S/sTji0
         YeKuvfqOgbu+7lhqulI+ipAkCZlSM0mitqyF6oNfh3M07fCUDiXaTo96trKGcYwQarM9
         wtjqZVkS87qpUvIhz2JHyEeuWYz7z5wDexiWg/ebVYuUM5rWXj93FrFAZMfF4r+pLAM6
         oVlrTy9rMplp1U1X1VZz1UqbFWtSa90EgiG5LJp9UHOKuDxCBl6t0u7AHwvpCdkakq4A
         mAMYpzKPDbesgADT/JhHLeS2Eq0BHqAgrjvlXoxppRZZcsuW/ICdJy2qGy1TlDCvRnKM
         AxAg==
X-Gm-Message-State: AOJu0YwjX+NJMOJb0sDePv+yGJR1z5Y3jMW/S7TyTZeGqrhADLSDZxG6
	TWpPvHyOK+RPLRYy1YD9+xoskzhTA2nceVbCjpAIy8L3oWkcFz4GxdXqmQ8D
X-Google-Smtp-Source: AGHT+IEFuQjovlV0hV2Pf8D17X7nYraZZz3w8RVEENqfN8NrJkkRArrCE335RcoygNA+TbjWYcReIA==
X-Received: by 2002:a05:6a00:27a1:b0:6ea:baed:a134 with SMTP id bd33-20020a056a0027a100b006eabaeda134mr1210219pfb.2.1712095127507;
        Tue, 02 Apr 2024 14:58:47 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id w18-20020a63af12000000b005e83b64021fsm10261548pge.25.2024.04.02.14.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:58:47 -0700 (PDT)
Date: Wed, 3 Apr 2024 03:28:43 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] builtin/commit: error out when passing untracked
 path with -i
Message-ID: <gvb4jewvfu733mnrqvna4ulbinep5cjs5b4tw5vr2zet7p2bky@2hg2nmq6gnvz>
References: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
 <20240402213640.139682-5-shyamthakkar001@gmail.com>
 <xmqqmsqb30a1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsqb30a1.fsf@gitster.g>

On Tue, 02 Apr 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> 
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 8f31decc6b..09c48a835a 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -441,10 +441,17 @@ static const char *prepare_index(const char **argv, const char *prefix,
> >  	 * (B) on failure, rollback the real index.
> >  	 */
> >  	if (all || (also && pathspec.nr)) {
> > +		char *ps_matched = xcalloc(pathspec.nr, 1);
> >  		repo_hold_locked_index(the_repository, &index_lock,
> >  				       LOCK_DIE_ON_ERROR);
> >  		add_files_to_cache(the_repository, also ? prefix : NULL,
> > -				   &pathspec, NULL, 0, 0);
> > +				   &pathspec, ps_matched, 0, 0);
> > +		if (!all && report_path_error(ps_matched, &pathspec)) {
> > +			free(ps_matched);
> > +			exit(1);
> 
> No need to free(ps_matched) immediately before exiting.  There are
> other recources (like pathspec) we are holding and not clearing, and
> we do not want to bother cleaning them all.

Understood.

> As we have another "if failed, die()" immediately after this hunk,
> adding another exit() would be OK.  Shouldn't we be exiting with 128
> to match what die() does, though?

I tried to match the exit code with the existing invocations of the same
when doing partial commit and reporting path errors. In
builtin/commit.c:

511	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
512		exit(1);

list_paths() returns the return value of report_path_error().

> Other than that, looking good.

Thanks.
