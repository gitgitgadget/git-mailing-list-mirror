Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3905311964
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772392964; cv=none; b=q8cFpYgWjJAOOC54hl85aLxz+LnEfM8tpOVWk5vddFoQrPIP8j8VSkWwqhgHJVPqKuCpG4yK90ekXHlYH+FW0qi+z71aC452QfaKmvqcngdQRAqHVJPgToF7aQIBurK9AKky9IeFA95ovdm7fbxn4mtLuiro9PJlsSzvihYlX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772392964; c=relaxed/simple;
	bh=IO0N5+Ri9cZ4Jd5b4QCrsiaytC7G314WlBzzqqhIHy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2ewWE7+QNT2yekoQzPJaB5f4sslbwSRI/MPKtwrcEFx7SNaqpcKuFNDP9oQhW8lY+qk3Bryk52XARhM4vVTE3yykT5pTVku6a5pW3u78mUCRVt5VBoUo2ptDVyK0Ynqb8JhNmjHU8r3hKnSgcLp0z91JKKdwWTXFSwgswZMCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEe/CgMs; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEe/CgMs"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45f194e9a98so1387680b6e.3
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772392962; x=1772997762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO0N5+Ri9cZ4Jd5b4QCrsiaytC7G314WlBzzqqhIHy8=;
        b=HEe/CgMsWFqbJyG6pZl74FzLDxk2TjszW0WdBNWgyV6jS9DXMp8LTycgIGES6cjYtG
         zmvaJUuPMu0ebUCnZte1HkOP3loQKUz31LM44nFHrojuYm7yHr/bBXyOzP7CW6KwY/gI
         +YjvjOLktgsaikMra7ZWTNlMqO7XvjQtnfArxEFhLekUMNtp4fImoWpYsxg2cyflZHBu
         oAG+1m8xzpmZocVlUY8/cWjiCCdcX7WOV3luk0KbjPlc5h+xkbeWcLdWXSioc2rd9uz6
         9ELkHwesRMIvZgipcSUVQJcvYtvRIsd4Z+a6s1aF0UeYTksBPbkNBq6SbMcoQMFP0p7S
         z03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772392962; x=1772997762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IO0N5+Ri9cZ4Jd5b4QCrsiaytC7G314WlBzzqqhIHy8=;
        b=dFDI3eyZKkE4k6Awm7br/FlIT02SgiPpNYtubYPdyA9ooriWWM47RddmvPBFH/TZdw
         CdEsftSD8nTQ1PCuwuNIFu2g0USxGrRHIRCQc9qo4n/hUVLFxuDR5dWXkvv9P//Bd50a
         IdqjSIusE/jOIqCqSR93pcPi5Zico+TbfLmgCInj6XvMo2goPhDXRAmGEXf8iL1cV3te
         1nfF30c/Q8SsjudjcIBpy9LBKzT8sjHwc+RBTdY2SjBt9oE0IwrxDWBaQZ+nF6LOuVoe
         Q4HBFBpId7V8nWsVlRWAvnwr2VyfsB0gRXXDBPzsDQYg9GBN3kxt8aq+jXFxQFRYpHE3
         YtIA==
X-Gm-Message-State: AOJu0YzkixB2zODzeMXKNW2WmLOuFUOrdodWac6tgA3IbEwxdfpEXmAe
	lplqpmCsDDS2xe7YkcsY4JLV1f69CFONlo9VXhCnGrUcrEnXul6s0Q1n
X-Gm-Gg: ATEYQzzMzZo7eBNV4ZZAlmYk/eijIBQtif3bAAaJQ9cS4NRXWkzwF/NGOPqziEGDh9q
	vobpS+yfEvKFZpsRN1QQmZHc7kse5KFfVmelykYCbCJdlm5giwQqWTuT90I7aKMJ/ZQpI8WUr1s
	xCRI9QOUp+FnDyh1Opl9StekGv5YeGoK8MhyyCZdMTCjm9UQPq97WjeC4qg2SKjQWy0e93Ho9gT
	+bAnhw5mpaxZz0xubwyuRdL0mwT+Ga2SrFMunSw35KgPqVmSaYwBO/Z0v5zYLRM40Tq6xoKvPZW
	iCgJe/Q9ErC3XioMHz2r+Nk7yumYdkcJvTaS/m9U1s1OPM3yK3F6YIoAe+4tRc+8uQT5LYo0auC
	iSN3/QiGk2yrulEkrH1AamAm3S7QwSDg0fgVI+g08fe68JBWuMA8wf+ZTOJMEZoCrlPApqL7rcM
	pnYzj2E3QKYDv+tesH
X-Received: by 2002:a05:6808:320e:b0:450:907:b523 with SMTP id 5614622812f47-464be9cc89dmr4864081b6e.6.1772392962495;
        Sun, 01 Mar 2026 11:22:42 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b656sm5934046b6e.12.2026.03.01.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 11:22:41 -0800 (PST)
Date: Sun, 1 Mar 2026 13:22:33 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, 
	kristofferhaugsbakk@fastmail.com, eslam.reda.div@gmail.com
Subject: Re: [PATCH v2 0/5] builtin/repo: include largest object information
Message-ID: <aaR6a7o4omOIWJSe@denethor>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260223174120.2356504-1-jltobler@gmail.com>
 <EB04AA40-87BA-41D9-B2DC-92E87FACEB54@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB04AA40-87BA-41D9-B2DC-92E87FACEB54@gmail.com>

On 26/02/28 08:43PM, Lucas Seiki Oshiro wrote:
> I was trying this patch series and I noticed that it took
> more time to run than before. In my machine, I tested it
> with the Git repository itself and it took 6s to run, while
> it took 3s to run in the current master [1].

Yes, now that objects are being parsed to fetch additional
commit/tree information we incur some additional overhead when
collecting metrics.

With git-repo-structure, the goal is to provide the user with an
overview of size/structure related statistics that may showcase problems
for a given repostiory and is directly inspired by git-sizer [1]. Thus
as it currently stands, the implementation of git-repo-structure is
still incomplete and as we collect additional metrics in subseqent
series the performance characteristics may still change.

> I understand the reason and I don't think we could avoid
> that, but I'm wondering if wouldn't be nice to have some
> way to only retrieve the "lighter" data (perhaps a flag,
> or something like the keys in git-repo-info).

If the main motivation is to allow the user to reduce the time spent by
selecting only a subset of metrics, I don't think using keys like
git-repo-info would be a good fit. Most of the collected metrics pull
from the same data sources so including/excluding any given metric may
not have any bearing on actual performance. For example: if the user
wants to collect largest object info which is a more expensive check, we
still have to collect the underlying data used by the other metrics
regardless of if they are shown or not. Furthermore, it would likely not
be obvious to users which categories of metrics would be more expensive
than others.

I could maybe see something akin to a `--[no-]extended` option that
breaks metrics into cheap/expensive categories and computes/displays the
metrics accordingly, but it would be important that the default set of
metrics collected satisfy the repository overview this command aims to
provide.

If we are more interested in adding a mechanism to filter
git-repo-structure results independent of performance considerations,
maybe we could eventually explore adding something like the
git-repo-info keys or a `--filter` option to restrict the output to a
specified subset. At the same time though, it is probably easy enough
for git-repo-structure users to filter the machine-parsable output
themselves if they wish to do so. For now I think this should be fine,
but an included result filtering option is still something we could
explore in the future. :)

Thanks,
-Justin

[1]: https://github.com/github/git-sizer
