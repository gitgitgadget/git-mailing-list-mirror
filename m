Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39844383329
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549617; cv=none; b=WJw0ACbJa7Xtrx7GZF/WMTpegV5euYGXn7FMxrwZvSx1O8LNU83KdZA0lZm7ciUlwP9VAkJ5qX/U2DXcpYbLy7OGDKMeOvajX1UG+vi15inFpZqau86miOLjSDQwhb9LKwm25Yytw4q2nh96tZEITjEdSPAdYP2eGoEo/0F2wiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549617; c=relaxed/simple;
	bh=pDm/v2+ULFiJVihOJWajfTHax8dt76RkK+16a5SeXt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/BDob6WZ1pQqPwUUwovXNKoLA41Mmk00075eRBhe4yaBckqtdqJxXsiXCD86/1y5oGbr39oFQ5tHuAEdFTluVp9XrCn1Ov+cAqaDdgJ6QeqIb4Qa1TP5V0Nm/QpD+9c0JJWyW6qKaEEsOIlU9aH6l68S2S67QtQXAQGc7WiBzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ECa/gNzY; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ECa/gNzY"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65318dafbcbso5189634d50.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 18:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778549615; x=1779154415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDm/v2+ULFiJVihOJWajfTHax8dt76RkK+16a5SeXt4=;
        b=ECa/gNzYLgI9kVo1rrdkw2pYESlIhiyyRVwe35oxZJfUHBmLwE8Cjk5cQzjGAhTGJj
         Wd5IxsHjcv2qB2WHOM6Bwq2WoKeTsW1EqKwz8MQrmYq+UPn2ETPKU6SxLbiFTpTbE+Pu
         alc597xdS/z98N+MQ4LPkDi+2IRUrpx+u4DLQ3EEEUx3wtA3qo5isT6HMpDCXW1G+BvJ
         Avqi+Q4m7M5ey3hQXq5QnPpcfWiAeftjaeuoZ5RJvqslF2RibDREH7tFe98NWzlBvjf3
         uX4vCGNgOZ3mZ/nPqQahWfKRvZ0jWAPz0PnUMQunjTcDi2wE31tQ/2LFdag0YykQme22
         p8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549615; x=1779154415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDm/v2+ULFiJVihOJWajfTHax8dt76RkK+16a5SeXt4=;
        b=BBFiufdTw6GzcTI1v/rzGSPFt+e0SmYjDS+6oyrXMIq4dOuiB+1FmAfZ9+GrE+It6y
         G/qt112g14QE3WI82oJo2Cl2X26Ct4PPmKMMNlwUNFCefvKR14Qc7wFA2JP2z7g/aChC
         l4nKmJb5w8PsWiZ+wkF0K/V045BWwqwdddPKsN3yQZSRvkzSJ4nVlkMq3oSu6d2Uq8TL
         Hxm8AuGIrr5vVmEpaJ84xmNYEbB/xQK/aq/yhuaCnySCtZJb+uFCmDJ2Nd9OWxlj4MJt
         3INFsm4QgfK59bzWg2xuAdtdymcjYC/dIAWMOm230vd+VsOE9I458Y8eeV8y0Xyaja7P
         fVCA==
X-Gm-Message-State: AOJu0Ywv7L6phf/YVnncIvNlvFY7X10xzVDzz9VsRxS7b1ewtxWiSogq
	KchX/43M/iHjeiy5oXO6rbo4n7fK5mFXffToRpnuLgmah1mpH78jiE3vWMeVxkVq3yw=
X-Gm-Gg: Acq92OEnLJHhRH7d3/LHA7of1Ssjg8LGoa6oXolLFH5fI3GPc/4FDGiSrJsVigUmHbA
	74sEFs3RAr/PPU4xkwHOSqkFvh6xnwcvSgoxbnfTxcvn1r5eI/GR6srJdRV89lX39HYb55ccdAh
	6XK6KOPORGbnF8L8a+QWfxp1m18wMOMyZvG3VnLr6xxYO5vln5Hmr5Rsa0qtUh6FeyGtylnEC23
	MukzDf4AAWyeg5QuNQNxm7p/Bd+PBy1XB0bhFce7Aejhany7aJs+SPxst97guOJ5/fmnyVQETGR
	SlNcpncGmXUDMtv3NRGvIiA20vRXuwClt4E4WA+0elqyssitZxe1h6uP8nrpsLfteFqsFVGX1mT
	SgpVW6z03pxu+CqUo/5t5YXUki0Pci4NNHK9ZhWunLWcxUP+HbkD/FtlhYiR/af3j1TPyXp6jO4
	pYcXerkeUVyiygEBpbbCiUEm0HRRgDWppxC6scQhKPaTTZiTh6e/slVF8Q2c+un1nRs2SQzHuTm
	hnAJKYvpzer8Bjtjcywk3AHTLHK+GarZElbkJvPO16+MY4Q6jIJF73fxFHyxCy6mK8eeHAL5AK+
	8/Hy+8G9lhtvbt5Aoffq7cympiM=
X-Received: by 2002:a05:690e:440e:b0:65c:308c:a157 with SMTP id 956f58d0204a3-65c79cf0eecmr21086042d50.12.1778549615100;
        Mon, 11 May 2026 18:33:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d969fb402sm6384700d50.3.2026.05.11.18.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:33:34 -0700 (PDT)
Date: Mon, 11 May 2026 21:33:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 07/12] path-walk: support blob size limit filter
Message-ID: <agKDbUoZeiux3jdj@nand.local>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <a1ab70405d6209a11b2eb752c154361060f1675d.1778523189.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1ab70405d6209a11b2eb752c154361060f1675d.1778523189.git.gitgitgadget@gmail.com>

On Mon, May 11, 2026 at 06:13:04PM +0000, Derrick Stolee via GitGitGadget wrote:
> [...] Blobs whose size cannot be determined (e.g. missing in a partial
> clone) are conservatively included, matching the existing filter
> behavior.

Makes sense, but...

> Notice that this inspection of object sizes requires the content to be
> present in the repository. The odb_read_object_info() call will download
> a missing blob on-demand.

... this says that we do download missing blobs on-demand. Should we be
(temporarily) disabling 'fetch_if_missing' for this phase, or using
odb_read_object_info_extended() with the OBJECT_INFO_SKIP_FETCH_OBJECT
bit set?

I don't know enough about 'git backfill' to know whether the current
behavior is more reasonable than the above suggestion, so please let me
know if I'm missing something here!

The rest looks good to me.

Thanks,
Taylor
