Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE3352003
	for <git@vger.kernel.org>; Tue, 19 May 2026 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232956; cv=none; b=IXekEGyVkDTaZNikcs6mgiLEVc8YzyTtBCM2GcGC+TfwaSWjPSMUjWKdxKbW1bFwJrOI2B6fwR1RX8FIS0qQrd+iRzZGy/e4l7hi7F+PcVtdQKq3kx3l79rlabPTm9ZSejY9Y6166t9HSqkfoaAgkb6yfR+MaHaigYMKgusw1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232956; c=relaxed/simple;
	bh=UYk5XR4//XgrvsAD1LSfURGIve7FJQqE6YKIF2Abr0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQuuILVhlvmLHEqMLgOJuEW8DFQcZ6uliLDMBZZyCeNkoUPmMWJCXqctJBVSaUS+3oyitYLjg9sxTCJ9RleO1it83o27NLnW/Zw9tiwsfHZvFF55rbvbKuubbpzr67280T64PgWVdMCuUTs7QuLWFEoPhoa9cEJfeyj7mbTfb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CpQyjFRZ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CpQyjFRZ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bf0b47d2f1so35308827b3.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779232954; x=1779837754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBowm8MBxK1/8sL2mFGb34vT3K+rfuZWej3/KPmQmH0=;
        b=CpQyjFRZ2a5KhiqzihiNf44lW2KC+d/5MNiIo1CHj9OWJJyq/anGL6nEju4IqPnCej
         xt9cYOUQ8VY0qAa/OCfRpaul2wvk8mVdzD4gkTFGg/phavlEm7YXmKKL4h5ljhYA5dQA
         25hTPCcWK7LTAM9PL7HyrD9J+sFH6nRumxK57hfg9oHIE3dKw7FT671Dl7Z5EqlV97Fb
         AfImBwl9lqCl1eCEdWSK+KBUhSY86HIQB5iAeogBxodHrXmlzaQZs+R6Ks7HdWx/1CLr
         niLgN+6YxdEL7l3yO3ZwjKk3BABw9hikzY+GjY0RShEkM8z+0oh+fI2lMAtJ5ckNYJPo
         eEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779232954; x=1779837754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBowm8MBxK1/8sL2mFGb34vT3K+rfuZWej3/KPmQmH0=;
        b=UJGzna9AbA5vkj5DrStunjpZDd0a7YgCS16cqowauZ4cA4GtK3jJuLa3LiAgOBfhZL
         4NCbsXnND4eQ4aFU0C36GG5/DtLTaZtCgAx0mUYqzndbNTuhcZyhCqHYp5tjikyjKXem
         Go82luCzRO7US50Pd3qRSXBqbPXpB8NTENqiByHU3r4hxqIX+KDs/+orujWTdfxtsnSb
         7+B/TJ4gvvah7uih1Ke5r5MD5nIB8zntUxpk+ZqdlrC0WVJEMkSRTDcomc4tqv7XQke7
         RCiklPlwX17HTUAExCCPpx4cdDA19JEnCUy4CTCwe1jpFw6lhFEy5X0sUmSQvgCYKzVt
         Wz7A==
X-Gm-Message-State: AOJu0YxQtu9tGZu/fgIB5/39NDSbs8aZ9p6OeHCYL1PGkGHwELqIgyQ0
	OVCAkbEdBFkQ97Yu//ypD2vSbFdUZKwugBkbW/r7kx8kdxJQI4iPxB4qg/NGWwsR9epefQFqh65
	alhkd8zg=
X-Gm-Gg: Acq92OHZgGP5rwDLQ6JxCx7RrydLPmuIqqZ6FCJ9/r/ZJijOVxJdaotPSepkld9M4/E
	bOV0G5ghdaNDRDJPNbzs2ZlcJ6Q0Bf7Y4yzYeFqSrVhQO8MKy9g72zOe2UPPLgNRczGe9UYMbWT
	nyMa0bupW9is2wCnEiIQcHlMDZq99yplnF/9O+C1l+iPNFpEEag6KtFZpX+TwagBXnzkPczLg2f
	H/b7ktN2unzZ3cnM5R5w3Lbn7Ksza3A+YCCznb2jpGqZs6+bujLjNHlI2R8sasmlaORojYprEDu
	jErlACQeJoDHpWAMAWu9yeybfyjqkyLfXij9VZutkako7U4qGWQHA5sueOVFDtZPAR39VRkvrBv
	QJ/62yfLqwJzlKLG5AQOnf4HbWLMzrUIuElnaJ+ur7amjvgEtKBcM8Q2ppjgTyPVNbrPKvZ07sa
	iIrI6VumlgEg8oIwwEb1nRUXL3+TEJcDl2zhzo/k33nbUGrSzRvKxZNPdIHStxltO6uWL6XKc2T
	FJI8tkCCoZl+vMTZDSfXesSYL9pQF7j932yC1S0gncSdKcD87MA5nRAKwrac3gmbjI9oXo0jSVu
	Efa2RZFcAP0uvTid
X-Received: by 2002:a05:690c:f08:b0:7bd:882a:43ef with SMTP id 00721157ae682-7c95b82774cmr226782817b3.26.1779232953750;
        Tue, 19 May 2026 16:22:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c9b64sm45213697b3.1.2026.05.19.16.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:22:33 -0700 (PDT)
Date: Tue, 19 May 2026 19:22:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 04/13] path-walk: always emit directly-requested
 objects
Message-ID: <agzwsxV2KEkkaGPV@nand.local>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
 <e77c8a6bbc22da3428751f81ff5ee79aa5364237.1778707135.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e77c8a6bbc22da3428751f81ff5ee79aa5364237.1778707135.git.gitgitgadget@gmail.com>

On Wed, May 13, 2026 at 09:18:46PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/path-walk.c b/path-walk.c
> index 6e426af433..05bfc1c114 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -248,6 +248,17 @@ static int add_tree_entries(struct path_walk_context *ctx,
>  	return 0;
>  }
>
> +/*
> + * Paths starting with '/' (e.g., "/tags", "/tagged-blobs") hold objects that
> + * were directly requested by 'pending' objects rather than discovered during
> + * tree traversal.
> + */
> +static int path_is_for_direct_objects(const char *path)
> +{
> +	ASSERT(path);
> +	return path[0] == '/';
> +}
> +

Hmm, I still find this a little brittle. I think that 'path' here is
doing a number of jobs: it serves as a strmap key, it's visible to the
caller, and now also a "direct object" marker.

Could we instead store this explicitly on the type_and_oid_list, e.g. a
"direct" flag? I'm not sure whether that type has the right scope for
this information. If not, I wonder if there is another way to store this
information, since I worry that future callers may not know about this
convention and end up changing the result of the path-walk depending on
how they name their paths.

Thanks,
Taylor
