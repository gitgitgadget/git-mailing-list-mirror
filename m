Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E341CBE81
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228746; cv=none; b=qXZPDspmEtJXQYuZCGUjl8mp+BtPJOSADnC67BF51NxM6C6OlmXkgMFxJ1Lv+wdF/lBTSAg7MwiauO7Iy5oU7+Qjq6mzFRiBE0uLdZYHrEG0/rQQk3uabWKc1cBo6WzHdhu3CirCUQw3jN9Bxvq2fJ1P8hu26/WBZGKLK5+RhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228746; c=relaxed/simple;
	bh=MbWlhik8pMp47Ey//Tb7P6UBXrf6MiSvlnmVrNDFpxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fypJJcPYD4z+Q8LY/XXNJNYyN7UEw2xuOx86wAydBck1BdXUhPp7sCqoevIMBO9LHPskNkZp6GDTa9wXoSti6GMavpjQR/DFoXM7y6pKFOjEvg+jG52ad0OMeFlHiYke9r+j3DWZ9YKKGxmIZKAzy1zewQc3z+IsTZvWrWZ9ZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ItDDo5Jx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ItDDo5Jx"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6eeb2680092so15303677b3.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 14:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732228743; x=1732833543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OS084Fr27lqc1lWU84hgIup5al7qRJTL3L43dCHHhbI=;
        b=ItDDo5Jxu6/YTmtXdm3ABzq3Ch/ADdU2rittvu+mobmhxAYc+3tLF0E0+igq6hpTg2
         XLURP/CQKvRIoTD/L3E6SIdG+d7mxU+0YD0rCebesOb+GQ1jfgXxe4+pZev3jfxs1V31
         ayU8jQVzggvIDbaFDJp0VjGUwJrLcfL3zAHFsbIl+tEB2NhrI+FHzmgoJwc03CNPhBfJ
         cRxIFRwiaAn/o+pA4iMRfHxkwVDkGZ9Mb/SrSxrs6fg0RaoQSkJ9wQwwuo04GJ+rG644
         +gOF3JDhgr45dv2dFNB7fzfxZBcuQqQyhtLwHWXb7xOZ/li7tG5j0KWrPiDcRdmw7V5b
         Pa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732228743; x=1732833543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS084Fr27lqc1lWU84hgIup5al7qRJTL3L43dCHHhbI=;
        b=bh9dUKylS4ZRsbEaDqBOsNUCH54q+e9xWWiMhBCzFb/pN3WrtM6i6K9vvj1cesiQxM
         LIX6Not2LKk3Hk3l65ZwRldxumAoDJP3d3PXQZC0Jipu4kRWUA7UDdORocdEPGjhDZrw
         qX+3gqG5ERpDzP1xJMbqXZ5zJv1UnddPvD0RxJee4VsJ1SA+Uz6rIrwmLihRxm9Ytce+
         NCXAn8oKzskqmBG6wIhC+OhJQbBVkw1DSiF0tXmrLShdLbWuPLF7syXlE/kj00xc5fpV
         P+iAdrbnt2hAZbBVDFRk/NPlnxPsBSgOsAd+ridbYpJF0Wz7YL2cZOGrpDTWxxlVKkKu
         PPBA==
X-Gm-Message-State: AOJu0YyvCgftm3+1bNo/wHNHURhm6SG40xwbHd1i6nRx4QdPlpZlVjNn
	tfhnkpY+aQkby62UP5D5SU4XA2NHzEngSu7zkHJLCPoNz41H3S2FqJkJsnnCSYM=
X-Gm-Gg: ASbGnctxogLKB1oQE25igk0NVG76Drq7X2fJyPEFHPsYrsGlYiXVh9xU7TPHIpeOOgn
	i5RrNpjQXfRRb+UbBT1Vmeg0K3F2VKfkxSRhgEU4hNV1iZnXTUguVI7sKrK78BDu6RkgT/DHRqc
	n3VCxfhUVvD8ngltWElUgRk7Dl1mE7ikYfxkJAblTQdXdRAU54hQyFM/GYhspjNA08gxH/1Dn80
	bmlDIzwHTmyGqbwsftHerO+DA1pyUfL8+/XANmMqOoNobhAWOhAsk977DxCDUX/D9E19An4kqev
	ttBgpKMGd44A7HPCei96mw==
X-Google-Smtp-Source: AGHT+IHT/i7DVaG/FoBR9eGlhPWY0wz3imML5zYcVWTPrVgeZov8SYNVCpbxRMvMvw/f2rSiz9MrkQ==
X-Received: by 2002:a05:690c:6d03:b0:6ee:b5ea:5fd4 with SMTP id 00721157ae682-6eee07b4783mr14661127b3.0.1732228743233;
        Thu, 21 Nov 2024 14:39:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee0095edfsm1675657b3.112.2024.11.21.14.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:39:02 -0800 (PST)
Date: Thu, 21 Nov 2024 17:39:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/6] t6601: add helper for testing path-walk API
Message-ID: <Zz+2hWlYCo6jlvj2@nand.local>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
 <a3c754d93cc3ecfcb4d2764930873af0b611eda9.1731181273.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3c754d93cc3ecfcb4d2764930873af0b611eda9.1731181273.git.gitgitgadget@gmail.com>

On Sat, Nov 09, 2024 at 07:41:09PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> Add some tests based on the current behavior, doing interesting checks
> for different sets of branches, ranges, and the --boundary option. This
> sets a baseline for the behavior and we can extend it as new options are
> introduced.
>
> Store and output a 'batch_nr' value so we can demonstrate that the paths are
> grouped together in a batch and not following some other ordering. This
> allows us to test the depth-first behavior of the path-walk API. However, we
> purposefully do not test the order of the objects in the batch, so the
> output is compared to the expected output through a sort.
>
> It is important to mention that the behavior of the API will change soon as
> we start to handle UNINTERESTING objects differently, but these tests will
> demonstrate the change in behavior.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---

Nice. I like the approach of implementing the API in a single commit,
and then demonstrating a trivial "caller" by way of a custom test
helper. I think that the artifact of having a test helper here is useful
on its own, but it also serves as a good example of how to use the API,
and provides something to actually test the implementation with.

I'm going to steal this pattern the next time I need to work on
something that necessitates a complex new API ;-).

> +static int emit_block(const char *path, struct oid_array *oids,
> +		      enum object_type type, void *data)
> +{
> +	struct path_walk_test_data *tdata = data;
> +	const char *typestr;
> +
> +	switch (type) {
> +	case OBJ_TREE:
> +		typestr = "TREE";
> +		tdata->tree_nr += oids->nr;
> +		break;
> +
> +	case OBJ_BLOB:
> +		typestr = "BLOB";
> +		tdata->blob_nr += oids->nr;
> +		break;
> +	default:
> +		BUG("we do not understand this type");
> +	}

I think you could write this as:

    if (type == OBJ_TREE)
        tdata->tree_nr += oids->nr;
    else if (type == OBJ_BLOB)
        tdata->blob_nr += oids->nr;
    else
        BUG("we do not understand this type");

    typestr = type_name(type);

Which DRYs things up a bit and uses the type_name() helper. That will
give you strings like "tree" and "blob" instead of "TREE" and "BLOB",
but I'm not sure if the casing is important.

Thanks,
Taylor
