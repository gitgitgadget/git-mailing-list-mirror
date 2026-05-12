Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965F1FBEBC
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548285; cv=none; b=WKWeESEBeRrBEaFnjrO5VyYOBCk+WEpirvc1iVJI/psZifmMDlquOTtxSSXrsvKJxkQ/c9rifRvwYO+UMakYguPiEaLApwHEpncc6nHvCEbKS3A2iafkAzfoQAljnsq4TuLRNbHnlrIZb+1ktJ0K5Gct0MRHT374a9Xjh8bzxiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548285; c=relaxed/simple;
	bh=sH9bfgJoyZMHgnYarbj8wDrcw2DjQIBvo+/2EWn7MXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt1wz5C4sXlM/Yyqh77AwPEq3TUDFSkjjxmCfCxpDuHSJC7SAt3S999fFASlymYa66wn3EYLexCO7SfXBqwCuOWDFEMstLpgCdOD+6mzSdSVJ01uNUe4N3Zlwt2AC1WXJjBKiimSPFx14tMJmHi07gEeSFBFd6Nv/D+VwjWN8LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WZ0EjvDZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WZ0EjvDZ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bdc947aaa3so52406777b3.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 18:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778548283; x=1779153083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8n2Xe4U2lE5ZweTKbgjwY5cCR3yW1SmVBQn6TrfByEA=;
        b=WZ0EjvDZWFQcLlAWx79Vqc5WnsPwehjB9UsuoUjL1VHDRWCMoiQDx2d8tQhj8IVZJE
         s2gnqIO+RNg/3d117k4eZIiQim2AXHAJoqe0fx4EHE6m8/oqd8QnI27DceTz9RoIgEFG
         6qJem4EMl7cyv8HxHf4rmcxv1kzJ7Oa9eyJ+JVeMSo2f8XDXKKmcK6BAZeK/W64TxNmG
         WA3mwrMQqTd7/dYW/77e3RNqAO1Fa+cMwrCd4i183naLYAF+sfX4v1dqW/Bi0hpWerhM
         5BCyYoqOw6Wjvmapw3zoNhwuOUFDDASfBD/KFSf7vB9S3Ww0OSXqEsUfuV4SyJ2/6fKx
         7Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778548283; x=1779153083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n2Xe4U2lE5ZweTKbgjwY5cCR3yW1SmVBQn6TrfByEA=;
        b=WUr2kPnL+hrVUhvj+ACW+1I1QtO4r6mGOpNDpRp6IItVTlUqUngaYLdJ2WXVkPnC/6
         B2H3TigKQjdXa00cUdua7XFmBuZzxyDTHteSG+FByEzwkxl1ZlJ2sEWJAn3gspMTyGXB
         M8LbbTzBXGmQ5PlZcHZhlk0vSrxv0THGb5q9BhoJCsrBBvxWPbZjxkxLMKBihEOAeKT4
         JryeDZ+vLNsW0DYT+zAp54l/K9CNRs4eKHmYFBTHdZVtThsY/RqVKsdTUfzGl/Yk87v2
         a1ZrpojxNjypSFePMb2G/4t1aOURHKenCCEoU0Rs2G/AP5+9dn2iMZCRxT8uXM/EJBF3
         NT9Q==
X-Gm-Message-State: AOJu0YyFHOUR/IJsEtfBbZ3Aq0syiNicuu4ZgPgF0IC3tWHkEyWTQZva
	lIplt/8H6zRIqDnTqpT9uP/S/tOkEi7yiYFMSX5exC7AoGxZrslebETNdjIQkT52alOyyw0bon/
	NCK2Jl/V5Vg==
X-Gm-Gg: Acq92OEfucWmHqOdCfedQmYZ5el+0buSAhtfE6iY3hTwH64N1XdRqE63BRjbfwJEO8L
	mKvCP19AObyVP2l88nM9zxBSoVVZqojn1dxuDsBvTkZ0dQLwGrszTYv3p8mX1K7OJYyKGFkuRr8
	Nhji8puPAH0IMPAjJlCm/GGJolvyYbdVB7Q5YnU9raZwqVCGbVrbZJNheL4fUGoNzZnGlXrsDsD
	/fVLyQMKRCNC3yYdb1OMPEd8Iw/BiWSBlEcHYuDFpiqvabq7jxqqZyJ6KMNCEDaHJYgY7UDlY/3
	NJmI2JHzbyGEiSQktVeU4slxaJKlVCfpaT4B0IbNxGFt0m3avJRBXclanLsSt+JwuDG7m7qjezD
	q5uZjIroJqdaVsDaLm3WgOWF15gy7Sggop3R+L48a2pOJQWH8W4WAWg+J5ugS2dr4y2lg2gMCyh
	zwmr+LXCOMpKOCNJFHhUmI7RNgfdrEzEIcpkl3vuJyT8Pq0w0/I2zD5c9YmjHUyUBcvDYs5KliS
	t6QEAzIuZg1uKgPKn0Pmhnxo3nggmDI9NbndvZpB3SLHbBYXxftxHR8uBDT/HiVPKymQmmhDko3
	/gUoTwAZ0mH5HP5X
X-Received: by 2002:a05:690c:c507:b0:7ba:fd82:9131 with SMTP id 00721157ae682-7c563f410b8mr7283817b3.47.1778548282827;
        Mon, 11 May 2026 18:11:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm155976947b3.44.2026.05.11.18.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:11:22 -0700 (PDT)
Date: Mon, 11 May 2026 21:11:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 03/12] t/perf: add pack-objects filter and path-walk
 benchmark
Message-ID: <agJ+ORhy0O6fpJJm@nand.local>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <77329cf8f45b948f3986d004be72035c75ce40da.1778523189.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77329cf8f45b948f3986d004be72035c75ce40da.1778523189.git.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 06:13:00PM +0000, Derrick Stolee via GitGitGadget wrote:
> ---
>  t/perf/p5315-pack-objects-filter.sh | 129 ++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100755 t/perf/p5315-pack-objects-filter.sh

This is great, thank you for adding these as part of the series! :-)

> diff --git a/t/perf/p5315-pack-objects-filter.sh b/t/perf/p5315-pack-objects-filter.sh
> new file mode 100755
> index 0000000000..b009039c89
> --- /dev/null
> +++ b/t/perf/p5315-pack-objects-filter.sh
> @@ -0,0 +1,129 @@
> +#!/bin/sh
> +
> +test_description='Tests pack-objects performance with filters and --path-walk'
> +. ./perf-lib.sh
> +
> +test_perf_large_repo
> +
> +test_expect_success 'setup filter inputs' '
> +	# Sample a few depth-2 directories from the test repo to build
> +	# a cone-mode sparse-checkout definition.  The sampling picks
> +	# directories at evenly-spaced positions so the choice is stable
> +	# and scales to repos of any shape.
> +
> +	git ls-tree -d --name-only HEAD >top-dirs &&
> +	top_nr=$(wc -l <top-dirs) &&
> +
> +	>depth2-dirs &&
> +	while read tdir
> +	do
> +		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null |
> +		sed "s|^|$tdir/|" >>depth2-dirs || return 1
> +	done <top-dirs &&

Not a huge deal, but I think we should avoid having ls-tree on the
left-hand side of the pipe here. I would perhaps write this as:

    while read tdir
    do
        git ls-tree -d --name-only "HEAD:$tdir" || return 1
    done <top-dirs >depth2-dirs.raw &&
    sed -e "s|^|$tdir/|" depth2-dirs.raw >depth2-dirs &&

(Moving sed outside of the main loop cuts down on the process count, but
isn't a huge deal. I think the main thing I wanted to suggest here was
avoiding 'git ls-tree ... | sed'.)

The rest of the test looks great to me.

Thanks,
Taylor
