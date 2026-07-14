Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BCE377A8D
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054358; cv=none; b=TMgJsjq/mtHARbBaaKWGoNtXyS1ibGw8oiCJH7TNWUN7X/cv9HlC1d5sveANQ24TPfm/X4Oze9+O8yMHqbffJKcsawkRCzfU2l+oagn+Iso5D9UdHg9HcXaI9fXH7bX+twRIT8OereG154O73K1wxzwDObEMOt20qgwAUzH1pSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054358; c=relaxed/simple;
	bh=47y0eFKk4FNTU+qHgvkwWU66NuLBsgPfLCT84jZE3qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2vRBnwWXx9I+jkFU8N9hzGyez9+II7GSYX7PVd2Keh58qhilzTX2MfES3Y/bjMAgBZu6sFKaJklPYRLPutRcCqFYf+rUjKGEexyHp6Cm5kFRJsqvEVyldSvsnzHAhyD/vIHZSIcDPCcdSaLXwowpFh6ofr5dYV03m6gMlufGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=TLJOkx9t; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="TLJOkx9t"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e5b2193b0so50380185a.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784054341; x=1784659141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=47y0eFKk4FNTU+qHgvkwWU66NuLBsgPfLCT84jZE3qg=;
        b=TLJOkx9tOqV+iDQvUaoFvPvJIJURfaAj1LByXSuTKNqZ7SGwDj5XyFJVBIxmnq5rBA
         /Darpwk8bOQ6iT9F/kwCX6EZWIUuUnLk6MStfwoAdgDXwu8umGZUqIGfDOTV2JNOu/+e
         5lSTWRFjyUNuvBcw8hDR+LHzVDG/ky8H1XF8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054341; x=1784659141;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47y0eFKk4FNTU+qHgvkwWU66NuLBsgPfLCT84jZE3qg=;
        b=Jl+PBztF3GOyzmO/q3Rvj1+YiVVkhDR47C7mwcL0rNOgzKM7XNl8lHEwLpMmionyBk
         WgUyYyVsyY1xt7GrKkZvBwEPAmh0D04Kpi4C65fzP6STlVSFEAGkbtO8CDy+8URq1YSd
         BR15/Uk0wyfSWOISmzG/3q7/eqyr325E3x0+pBjHTbYB50NLqSiox9UBSt+OI8JXVpOU
         17pyanLbh9BQCMJ5KtLQcaDuXi1mqzCCIrpbdjT2PL3Sd7pvDFhsK9QX9ajurDFRrpvW
         7bXP8/tiOzgh46EKLbii6zf48/Ctq4MSgXxto50jkIz6RXauRJReUCuXNq1z1myo6rIN
         MGYQ==
X-Gm-Message-State: AOJu0YyLrMOOUHvgpvtRvnyyhw9qCbvO2Yk6vmUbcWKt+HMnrOgNg0a8
	cn5fTtG+u9npmtYvtITsuSgZ38iN4o6fnKmEhMfGWJm0y8zJtk2xu7jA8L/NxZQ8iZo=
X-Gm-Gg: AfdE7cl8otb4gsbUfrM4+KPDcpddIzv2E8hXJRnIT42mAaKA0q2zxi5jxG5bIM/YaK5
	s/jqTa9OQU+c0ySnNZTCrl3hHBovkxJsPpsU4N1Z11XZjq99eUXE424iZGWhLQ8kFUrjM07FU0T
	CrBiNypw2bYmUVe2qStORDrWJBlgURKH4d7X5pL0apLZh03RrbOjKC1Aep6+zCkshGId2UYR4If
	H89pvpdGOmP/GfZQMlsf9WVccR6tCu4KDsPA2jlB7J/cIjR/Y4zcJxzRzKgdYgiJ6VkJm/dWbWW
	BvjtATbqdGNm7dPuCe8gF580cSMJnS51DVV/yUaJe3KGPmHA6B4FE/Lr9hDMajWjaW3oYWVBuEm
	WkwRe/1St8KWfWtUxpH9cM3mtI0WTB4T6XuW9cecox6wYEWaY+ZNbcDrrhm4mhXLj4KutMklj7y
	WiIhLFHgiULwMn4IS76HDD+2Wxu8WH8uTuoT9t0H7Xc5owM6oRrY5chyMrI79WK27DClsZ
X-Received: by 2002:ac8:5985:0:b0:51a:8079:795e with SMTP id d75a77b69052e-51cbf1066b0mr115652261cf.4.1784054341425;
        Tue, 14 Jul 2026 11:39:01 -0700 (PDT)
Received: from com-76773 ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b44sm118156911cf.30.2026.07.14.11.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:39:00 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:38:56 -0700
From: Ted Nyman <tnyman@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] fetch-pack: accept "pack" output for packfile URIs
Message-ID: <alaCQKXKcWr723Ij@com-76773>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVoA5-fDDPwKPZZ@com-76773>
 <20260714071231.GD2516582@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714071231.GD2516582@coredump.intra.peff.net>

> I also think this would all be much nicer with a strbuf (which would
> let us get rid of the magic numbers), but that is a slightly larger
> refactor:

Using a strbuf makes sense. One wrinkle, I think, is that with
transfer.fsckobjects enabled, index-pack can emit dangling .gitmodules
OIDs after the initial pack/keep line, which parse_gitmodules_oids()
still needs to read from cmd.out. Would strbuf_getwholeline_fd() be a
better fit here, so we don't consume those with strbuf_read()?

I'll also fix the --index-pack-args documentation while rerolling.

Thanks,
Ted
