Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D91F4191
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857579; cv=none; b=BgO1xs/cOFo6fadanULzlPn84+yCrZt+w4iflLjpamV7La8v4ypr9CQKxRynmTfhhlbOlZ12NJWQbmWTaZ/eRMizpfHxHp9B+vJTGoizFOrEFvIcTVQGEKcH/tyWaCqxAqBSdnsGzjAOZhrNIjc0bfDIgO5V49QJEtGZh+hd1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857579; c=relaxed/simple;
	bh=CMte9zLbRTnCjJj71UNzPKUh5cL54vcaqIqdksYmJEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRqEQn/RWpVj0JDApJI1dHLlZT+qapkGQjeqWSrq5DuCzkndtGyTfn9hMU/oycs1cXQAOXMpY4PFVJMn8noFw2Mz8kgz5ZKaTTFQHp5NSkT286T7Q2EstvsufsQI15fCWjBCX4/nvdOOPnqKE+xbmguBBnH9ydrVvWiP41wXpC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2uZceD2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2uZceD2"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21634338cfdso26055315ad.2
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 07:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738857578; x=1739462378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VixdS33K/RpwTWfczweoaVfvE3FWd5fRJCLw9f1622E=;
        b=T2uZceD20ujr9PAMOuJ8FEHT/a/ka9+4omBHtGrlK5rY5SGeyn8yY9asCma1pT/Ihh
         1FjQ9m3YZmFbqDI1lbDt8tEGE4mfRCQIjfOLy90oQnxvT8owVO+37wg7rmUGS1hyCvIn
         eU9535zAOUyhI/e8vaRIqwtaLVjrPCS58yyurE5Scwno6y3bGv1JQQs8jG2/GgW08tJQ
         PxV7ZrSCo59hoQkljjnBtWMxQ55rzhLAo+QlGc5gUsArDJz8aqRr0DgDJK8CYnjcer/R
         Y5xXchtKPuW5KDQNxY3tP2GE2fqwAPm1WiW3/v3B6IuJwNdNSvfwO3zFj/1G6TpKjvCa
         C98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738857578; x=1739462378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VixdS33K/RpwTWfczweoaVfvE3FWd5fRJCLw9f1622E=;
        b=sLZ5KwBpe9kzLgf6YhDSsTRhy7H1ampTnKXhZldkvgowf6mneE6CJWfDyfnyq8NKeD
         v6NcguqDL/d000rKAL/wu+iQK9b1bDFni4QUrIMOEDe6RxQmmkjiuG6s3wVm1Hc29Qiv
         bnKTsRtV1JkYnlhOQk0YwK6Ky3BlT/TdxZPr+Bab6EHqj9PFVvaSm9400mSdIUJd/6xz
         0ZnUe2aLtIFj3a7iqYuQkCA5HvJsJimbJiHj4BM9X6G6eUtNoLI+eaS9stZV+EI58SyD
         3KKGlELRcNoCTIuAUERhTfUqLB4p2odpCn/vUv3qCRyYJgSy7252xzr4BlV/zzzWNc+6
         UU+Q==
X-Gm-Message-State: AOJu0Yxe9ybl3oUcZwUvGK/yR9Ulvr6tHwtGCuDDuoaR6UbOb2STAdO4
	XX2ADOaG7FHggJUW1n1rHBUlZMqUagg8pHDgTEfzDx+oFsRqKhHk
X-Gm-Gg: ASbGnctDvuFtrzspc+kFRqmZefrBK+H0OW2zTBmHUGVrIIbndgleLttgU4JIW494yez
	0JGUQ+3E8deCCaUmlaPlA5ZeP8qAl43KputoDRdJ3mGZlg9lq1IPN/gieWdvaP9GMzU8ritTZnc
	3fYoEYK+2BEN+xj0b6AGFPEtP0blRSonPrloRb4/FlKAdTHYP0IkuWzgEblM2OBwgqmC1iKsD2E
	nd4Lyq2ynoekz4BRneMlgAkvstMke9Sirftwg+yyPPWs9DAJ/uV2XKnj+omHrKWGA/nAQ==
X-Google-Smtp-Source: AGHT+IEhnUfZkWElJwdfIlPdzluGqS0XANL4Efva9SGgnSKx7Dmj7jM1g8q+NJcsM1XIXVN5YaDSRA==
X-Received: by 2002:a17:902:e54f:b0:216:5af7:5a8e with SMTP id d9443c01a7336-21f17e74c8emr112764775ad.26.1738857577721;
        Thu, 06 Feb 2025 07:59:37 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3687e68bsm14532815ad.169.2025.02.06.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 07:59:37 -0800 (PST)
Date: Fri, 7 Feb 2025 00:01:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/16] path: drop `git_path()` in favor of
 `repo_git_path()`
Message-ID: <Z6Tcz79fVFGEe5Ao@ArchLinux>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-12-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-12-4e77f0313206@pks.im>

On Thu, Feb 06, 2025 at 08:58:08AM +0100, Patrick Steinhardt wrote:
> Remove `git_path()` in favor of the `repo_git_path()` family of
> functions, which makes the implicit dependency on `the_repository` go
> away.
> 

In this commit, I have concerns that I have already commented at
[PATCH 10/16]. I don't think we should use "repo_git_path" in most of
time, we may use "repo_git_path_replace" for most situation.

Thanks,
Jialuo
