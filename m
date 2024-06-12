Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89016FF52
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186951; cv=none; b=bRY+NEdA74f3i1JfeIRi7pJqTQDFBNTJZnVkhZJQDd4toFEdDKWWtU7kqsMibGH2Lab5iqRu6OC1iPYkx/XUYRijnUkDMvrTYa9rKovkkSvw3FBSvKCmHfTiAelhYeNGe/REcLnjPJdFetP6ugt8f0j2h39QgbDUeYjokJFs0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186951; c=relaxed/simple;
	bh=wu82PPnNuxVo3ofS9cqkFy2khd1shc8139i4fcJolgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnUjjfnE8fK+gcoL9Dd/6S7RlaNKJyU6TTqhBxtKkkSpeY97eqrfFYTJXSKtNsVK2xZ76YZ3776IGj8YdDDHf1Q4xU/yMv9b/BwPOIU5OEjOpc0gjtF7Ax/F1bHHIvIY8fb1hdmJg5WUiiWfh6S1S7XP0TTyo+EgEyH2W1HWJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZcCoRH3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZcCoRH3"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c3051aee3fso2833901a91.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718186950; x=1718791750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJDsD5NEAkdACpafCPbmtWd/4fzJvEkF7td8IjrsfKQ=;
        b=MZcCoRH3Q+zuZk8liWQsVi6Boriut9r1dwQB5OfKlO0Hr+M5+UvsMWkq3WqXFiTLfa
         yY2zeljo7SWmIKrCjuloRYomFx7/sK+7WLfCtueCnX/+eTf2Mr2QEBOLTlrUoahNdVxE
         FoiHlGPVFWTcJmDaXc1s9NWg0JVX1GeuPrVDROpZcktZ5fZ+B/n3Pe7CohE98MVq6ei/
         4ZMCFxqIT6lmD/lAP4y5mavQ/L5AqZ2nXCeiseYIsq6qYrxFWuAFIu7nsQhB9u9OjCJ6
         eEa2TlewJJ8sLFx0HqzJmiQpRppEOkdnhXR42BLi/Qurg8uZJh1Al5ba4Pe7maj4OkAo
         5IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718186950; x=1718791750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJDsD5NEAkdACpafCPbmtWd/4fzJvEkF7td8IjrsfKQ=;
        b=vG7AbDGMMPAo53Pd5cBtjhavIZx90+nSdkukkvD9xUe4Ak/q3ZMVxBKn6askONazZ3
         Z5kTy7Il7crwsWhp2Cb7GHoSN4rFEguaDgXr49gSgzdpzugcrq6YYqGLut0pfBm7k6L2
         PU2jux6/+IqCU3CS7SDU5J57nmu0q80xY8eyRc2inebbR2WmA3225Ym4xLvyp2ehcciU
         WdM4JvodmnqtZb5m5kk1Y/6e+aD10ztkywBWKVGBK2rqPj8rO7nQW5/n3fSoZZbIAj/m
         xl8gItuwOEbT1K7vpa9Q6KC6p3Dx0vcjgJSHnHNLp384WUet4bhVdXtC5E3vjt943B4m
         04Hg==
X-Gm-Message-State: AOJu0YzyNPTNenW39Yfospny7JwAPc5kgIQ2UkYHuWqDZLIQD4IDg6JD
	ZMUFPQEJOH4d1mL2B0yzbS/tl4EmC3tSMbXCcKwmwG2IX6wLMJSFmqJR+HQhm8Q=
X-Google-Smtp-Source: AGHT+IF/DlEqXlZIaBmKdaHkwDBGAZMgTbtYkwKtdtGGhhdwZf6Uco8WqBVY03yf0Yek2QsMnbi/lg==
X-Received: by 2002:a17:90a:9c1:b0:2c4:aae5:890c with SMTP id 98e67ed59e1d1-2c4aae58bddmr1078726a91.21.1718186949522;
        Wed, 12 Jun 2024 03:09:09 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75eea33sm1312753a91.24.2024.06.12.03.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 03:09:09 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:39:05 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #03; Tue, 11)
Message-ID: <xvq37qtq42erovsoc455uvb35fxlvqr5loqwl5oncc7e5lnqnb@netjzikujgac>
References: <xmqqwmmuq0ch.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmmuq0ch.fsf@gitster.g>

On Tue, 11 Jun 2024, Junio C Hamano <gitster@pobox.com> wrote:
> * gt/unit-test-oidtree (2024-06-10) 1 commit
>  - t/: migrate helper/test-oidtree.c to unit-tests/t-oidtree.c
> 
>  "oidtree" tests were rewritten to use the unit test framework.
> 
>  Expecting a reroll.
>  cf. <7o6fuymnfn6b6buyw3yyctjd4dlwlrazspv3xgxvys6djjivxh@qbhyurorgbtt>
>  source: <20240608165731.29467-1-shyamthakkar001@gmail.com>

After rebasing on Patrick's -Wwrite-strings work, I haven't found
any more changes to do. All the errors were regarding this one change
which was 'char *query' -> 'const char *query', but that change is
already amended by you and in your tree. So, the version in your tree
should be good to go as is. (Unless some other reviews come in)

Thanks.

