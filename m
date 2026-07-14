Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0742C11FE
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001584; cv=none; b=rl1bTICMu4F30H7cH8TJ/US16xCawexfQ2a5aPwrqQA9YF+fu5DPgEZacxZBuQ1s0zt78vv2v6WUYlnU4W4Pev+5T0P4GHO+SRV324QQAC/AOQ3uauyqxgC0ayoCaJzx9U8Ay67k+n7pxzI5PWN3u91PLJj7Soeaz5dPANv1TwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001584; c=relaxed/simple;
	bh=sy4Npqbd9RnrdZDfKi/23sx8nUYRS8oYyTZAazUTGfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ2U54VgZEIzirD8BSIs2VHR9EhRF4H9mnFsAl/MBHVmSX8QQ3WhYpz6C2nzyFRvqU0YnNXB8H08/vEB3ry66JUkzcgakKBahRvufDHXvFI3RyjLDwIrk7tGSYvKvzlMTL13fiLzG4ns0Z/kSKPBjqdBBL95u9nFMZLqpB62tc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=AclokLi4; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="AclokLi4"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8edda5d56a5so39033756d6.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 20:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784001582; x=1784606382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cjT5fe8nYFBX0VyINS+L0yXipF9HyDuQZyaK68A6OIk=;
        b=AclokLi4BDlOt6COt4pVqSIEbanCupxY9XXrtXDsGF7zvd+i4k7Bp+4TlWkZF/BOiO
         dUQwzH8L6CTgLvw1ydQy22nwmfnop890xvxDgLdOmQEhwijUSvxf3GlBQxZIr87IXS+w
         CRFa1v/4fokceWnoVMvygwQvloyBoTEjWbAjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784001582; x=1784606382;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjT5fe8nYFBX0VyINS+L0yXipF9HyDuQZyaK68A6OIk=;
        b=PL6VpuCObU3alU52zr612j8VxAEs9rj8llCgMct4wvQ/3MUpwTf3FnwITyNz5/3r9R
         UbCdX1UgMpexIMkH6F5/pQkHfIf3WUS2kf69IUHYU3nzjYhXh4xeIHTUY0++g+TNL5ao
         rwswp+Jpmen6elV/9dNJ5F5Q0o5PUjFah3wiXawajDc/lnffcsh7xyc1iM5g4hRgzm6k
         bnNn1eikBx9UBwHsQO/BAGaKRd1xZcnjYUzQ/Rl44lzJudjW/arsUGQTvtNqVCaNetnN
         ElrzC4IyANKcAzLTLkO7oo2cJTN1o1Oa2Ys9vDN31tiQwmECTIkgSKp4Mn/A5Rb8CcpS
         /gVg==
X-Gm-Message-State: AOJu0YyNQeLY+UubXxvdmmUzlhX4+ltH+PHxfi+4WwoeeWQ9yF+TpF++
	cbPRBFASGKGFH5hTkCY+/K78C0s340WFaPfoTk6zbGPDIn2VBYKmIjNdubAV9KBm3nw=
X-Gm-Gg: AfdE7clhHZjHgR5p0acWkzs/W72rlutdZREEWlnSvYiSSAOe85F21mCahQAyEEFTOGL
	QuukrL84IM2iHtdeB9SrQ9X81chb1czKCKrh7dsXwsd/4DlD3t4d2evKPBsFZT6801xtKZNykzH
	zf6RBJEca3IDVdmuPAMyksmnswb9KwJx6ypCvuxO6zvKYSjaOYsp6qa9gfxnpPDNLYav8wnhQSh
	dX8px4oZatwLo18yA+0/RWqprUIy05Fi+A6/3I+NPgLMJxzfUaoqsrGw4YHPOdriwQISthADWmy
	bDddCnFV54iTfzQjqi79XVEbpZZ/sQ9oJNAn0zK81gBgbvkt+k8vlRU78v8X/Vhqid9qR4WA9bz
	mZvc8Cagfz7bjYEzPlTMZNSOku0mXpstBxUCb+2kEu5/ACflRvx886JB8bBgOs27C+nLMN8svBJ
	APozPBsgW7ZJJw1i6twF62JAh1
X-Received: by 2002:a05:6214:dcf:b0:905:a342:37c3 with SMTP id 6a1803df08f44-905a3423b27mr83694866d6.48.1784001582498;
        Mon, 13 Jul 2026 20:59:42 -0700 (PDT)
Received: from com-79390 ([209.249.37.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e081dsm153949666d6.9.2026.07.13.20.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:59:42 -0700 (PDT)
Date: Mon, 13 Jul 2026 20:59:39 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/9] odb: introduce object filters to
 `odb_for_each_object()`
Message-ID: <alW0KzSZuZnHmOZD@com-79390>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>

On Mon, Jul 13, 2026 at 04:41:24PM +0200, Patrick Steinhardt wrote:
> Range-diff versus v2:
>
>  1:  baf2adb012 =  1:  7c0dc1be0d odb/source-packed: improve lookup when enumerating objects
>  2:  57eecf3031 =  2:  2e5908c9c3 pack-bitmap: mark object filter as `const`
>  -:  ---------- >  3:  f4d66ccfc6 pack-objects: drop unused return value from add_object_entry()
>  3:  92dd6a6f6e =  4:  af475654b8 pack-bitmap: allow aborting iteration of bitmapped objects
>  4:  92fe41577d =  5:  6ca42587c9 pack-bitmap: iterate object sources when opening bitmaps
>  5:  e5d59959e3 =  6:  f62c3bbc81 pack-bitmap: drop `_1` suffix from functions that open bitmaps
>  6:  ab3547ac2b =  7:  b2d25b6e9b pack-bitmap: introduce function to open bitmap for a single source
>  7:  026f21f522 =  8:  a5bf309bec odb: introduce object filters to `odb_for_each_object()`
>  8:  534b25c817 =  9:  600b15a907 builtin/cat-file: filter objects via object database

Thanks, this version looks good to me.

Thanks,
Taylor
