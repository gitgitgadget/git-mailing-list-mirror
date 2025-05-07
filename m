Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D278F2B
	for <git@vger.kernel.org>; Wed,  7 May 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579515; cv=none; b=uLaZL0/7CGuEWQfRJy2b+V1b2SbzENlbJE18qoXXEXTS/T1sg4EdiVW71A3Qgh9o63lltXhNDhC+4WNgMWHHo5Q5+m4/jIKFWaswW68bZGy9Kt5hLqW0sLhqQjXKhu4+zyOdU93jPdLflpzEu6yEqjApY1RXJGuVw+gUjMJMVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579515; c=relaxed/simple;
	bh=lOzp/0RMOQtVJpTQpgf6LRxK6b4diHdQ9jmn9Aoa8c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgxgK9mju+lu8QXhDy2jSXGHCy41j1f478Cp6+G2I1C/Dl6j4e6hEpPOnNBKCrvY2PidTqRvEJnlzBIxilR4PmPg+jAav+6riFMxym7GA6hXg5wfqKWjT27P//+oI1x3424xtdzwoP441Y/rfA24g/tUVSyyiwwcl7LpuP2EN9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wA7MrGsN; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wA7MrGsN"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fce04655so65408746d6.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 17:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746579513; x=1747184313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOzp/0RMOQtVJpTQpgf6LRxK6b4diHdQ9jmn9Aoa8c0=;
        b=wA7MrGsNoVwEBfJ1g7fhUenFw4mhtwLJXTqcNJAt5vRW5YqaNRvGM3GjfhUQMusA+S
         t6wmpzW98HUBEYAN1Ej4PabvWLuki9+sU3/nrjAaXCBaJ4sZgv1JzOZl9OfGMILewt/9
         Kg+De4S5fukKa+BxHLV6zcQcWKlKBR1bnVsynTAgs5ppKPV5LzQxTnIozotdyfqmkNfc
         etSpJwVZnVwQlpGYT8VEBC0/nfAhwnbtjz8MUTCO20uHdKYT0EEzOwAdsqBjkHWPs/Xc
         WwEC4MX8moM2OJ4/yss/yF17raG1EPU8kLDkI5oGHI4tSjRVvOlnsF+PHAQj0yX1I7S9
         DjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746579513; x=1747184313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOzp/0RMOQtVJpTQpgf6LRxK6b4diHdQ9jmn9Aoa8c0=;
        b=JUE9b2/+CtGU27V0K3i2mwEDAoSXRVmAUaQfuu1Eab4wueyGwI5tMfJxv6doiJqNmS
         KsxBh897mzKqPBgdTcInMzqKN63Z7nZvMgrIaE1ix7UBYT42cFDBX6PEbb+XMbe84lzo
         qiUXiHyPejyYeOIhjXtzOTdeb0kORJ3PND1A7tKq7NMJ7gZCCCJBq5eDEjo8KTulW6JQ
         Ce3eUUIvoWbjIPhHIe8ZMsrK7VPPhmYbq7NJkh1foIhYKtolXifkC0KDRbI4GB0MTOWv
         R6527abm/4haDPxLKeZThxsy+4VYPxGAN9KYr5WBqU92ERK0V0z8ICoB4lY7iz+T0rbA
         EovA==
X-Gm-Message-State: AOJu0YyJYkaOxJyCc49Um0CM2MfDg2PaBOYCc5tC60ySBbZcjPGQCHi9
	+6TKAog8HC9truoS9v/jQbKua7UnZBNDAkHNhuHPl+RfJhtaTtLmbBhxXU6mraQ=
X-Gm-Gg: ASbGncssslA21/Bs0mBcW5nxhZhhXrmY7/eVaTLrSQ9HLvp3UUxyLGTxtMzGqwCXOBW
	hwOAWPL9lzfNppQbk51YnJYQU5/MJDL9ino/d5PfnCGpDclgpCHI9cSv9GVGt5NgTxvCTBuxShX
	xYz6RC33vIXdzQNulwGfygBFh11sO6dvLhEbpW+mbrkL0OGuzj+gfjmPjOxA7n1UZc3YfgWlfFQ
	UIt9d8NDJfBo3+9EftzcJ1ZR1NU2fSYUWfoSGK0ZnIUas3Mq/oneZRQD6YH6AdMDLv5cTRSxq/j
	e1BbvlRDStBRuIAmrPV1FcN+AOwf2a2ZleXcpXYkegLrevd7dbWpupLT/5+3ZozGWfeT4YQHFGY
	0o9zvQDn3ozV1
X-Google-Smtp-Source: AGHT+IFoaQGZuCKuc+MWKOlNRJbz9zUi3eF58i+BuoBmZx6juiE9nTKyWwGtGQCxpCw0j/s54u22Sg==
X-Received: by 2002:a05:6214:cc8:b0:6e8:ebfa:42f9 with SMTP id 6a1803df08f44-6f542a59966mr18482506d6.16.1746579510902;
        Tue, 06 May 2025 17:58:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f542781393sm5205586d6.88.2025.05.06.17.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 17:58:30 -0700 (PDT)
Date: Tue, 6 May 2025 20:58:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 09/13] scalar: enable path-walk during push via config
Message-ID: <aBqwNaF9UNT7VK+1@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <e5624c379d5804bf4fc44163c14a85ef55f89c97.1742829770.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5624c379d5804bf4fc44163c14a85ef55f89c97.1742829770.git.gitgitgadget@gmail.com>

On Mon, Mar 24, 2025 at 03:22:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> Repositories registered with Scalar are expected to be client-only
> repositories that are rather large. This means that they are more likely to
> be good candidates for using the --path-walk option when running 'git
> pack-objects', especially under the hood of 'git push'. Enable this config
> in Scalar repositories.

Makes sense, and feels well-justified.

From my understanding of the series thus far, it seems like path-walk is
(currently) a better default choice for clients than for servers. And
Scalar is a perfect candidate, since its users are likely using it with
large repositories.

Thanks,
Taylor
