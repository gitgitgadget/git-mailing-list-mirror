Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D61F4634
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772875719; cv=none; b=LHJS2ui882scYRCQTBsFuWM8LbX/lB4LAvgq+oPligj4eixeHPv22ZRmBvTD9lUfw5vFKlnWyxCDUgI+4XTUL82FWJaxlJL1/vf9HEsYrkKWTqmtZxBBlDqVYHGMIO1n2GJppbZ/aQsmXIAwKF6TYEjir7ZjJCG66TJUTaFdXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772875719; c=relaxed/simple;
	bh=eCXKyYJQ7OOSkg4dxG9tY0hngbRTQ+DsvDU+oNeKTTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a6/Je3oTwCta/Nt9TTwIqYi6hsZgV5zLJGy8SGxxo44SyRCC+s18kGZ3qRf+5T7KTFUgtLow6IfAVHbFR46cfql4Ag8+8dj9LHVTZQBMelnHwwY/uUtUXBLjS8CfG8Jk3h4hn9n9psoaAmZ18C9GK3w/a5bnCrPN4hjINGwIhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNreBTzI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNreBTzI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso92968405e9.3
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 01:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772875716; x=1773480516; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ar/ZPtZQK7ix1HO8Kxpo4C20LQLjDIMmWJW5eJ7YXLo=;
        b=jNreBTzIMagEIfAvlpaieJE9Ewm0mgoM2qHUHPOUu1ctnBYiQbVl48CVo76NpeRAqi
         gKH+WS9bS4Y/W2a06X+02oeZJS5WBN09hdoXhW6WaZjEmWKiIfSuA+e73lA1SUM9YjX2
         PAlGPrmeSl0/tWOcPmAFTE3EbipkzAtkmwcUZ3CnGEBek1eB4vlxqncwdaNWHe4lBsQb
         +pC6DqE8n9v3lkJD6SHK4/vDcGkzJNCDWQlQv/I5xR6wXp7jnjQ6TUVxE7DggJL26ISm
         yy+VGsyAlgjSF49rxbN9rVRSg/d+3Ea7/0BaYG1n+4jl+Ih5ysqLCOtD9SgxBeD3+lQ5
         thOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772875716; x=1773480516;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ar/ZPtZQK7ix1HO8Kxpo4C20LQLjDIMmWJW5eJ7YXLo=;
        b=ttjLvMh0KKttgKn9V5Aw5e5A8xkKx1Puzj1lKw3slH3o4KeasB/oKxwBAcppOuFSRJ
         bJcaWRCByCyY9/xke186wyxbA3/uC88EU/Vl+/ei/3lwW+7d/AqlZeqMforPHCFeeWwv
         UoW/ewC5VtXMXrPiZAXzq/dq/BpwVCirzmFKp9Z2q5/7QIr6rb9/6QMluwfmi+DbXaCp
         J3vsezkZnfSy+qvVP/N46mMvZDUr4TVpls2UEiFuvVXycD2+RXk/cp8qZuLGXMMb72gC
         0RGAxJ77aXwpEanWXjDv4KArNLkXNp9rW6KYvUU8PipdWU/3XuBIr/dvneC0zZd+K0Tf
         7mRA==
X-Gm-Message-State: AOJu0YwSnmv5YdSEWjv98+pfaSBaGOOvB0bE/QZ4hx8h8Q62Zr6ph3bD
	WNcWBgdMeN2fPKJqGhKQa8QijNC0vWtHK/ghcrbi/ZnbHTMYXJBOow9MQFMUSg==
X-Gm-Gg: ATEYQzx6cH+L0xDRBXuv0MdSE+iMhCekgcHaebJAXOK1l6ip9xaJHwD+a1YVj2VX3sr
	BTx5KlnhB42oOYWT8EAZeqTvW3JCiFIVxpRVUdkuBHC5PGrA51ZBbGVZ9RLwdtmMnMCbJ4wb7W4
	oIwqYpDML2T90ZX/rqcuV2wDx9WdfQAorcAB4OGkN8mQSuHJqFjvFiHhFd6CVuumwgf/J3XTIZO
	gdXVXc7g8Mg0m+0Tr2M2CCbECWN9KtAJqR46zB8gwGy6g1Ls1Eb2S2+4XC/6KwG7ajfSTJQajeF
	YVj+vibLmyyLwNSTHz5BamOGzmprcoBEEG6BcjxmFK1bP5i2G/8rBcGIw7V+wMu/9UIJGVtfwdA
	3XgEdZW+DGPnJY2hGJIcdlDtmYjTwhYj/sJQ4AogswaEoEacDmW3G7A2JSWJgTPaspuFrbLN7Yv
	FgjIqgUmLKcdHSUP1MSt2XhKZsmGgcj5DuR6Q=
X-Received: by 2002:a05:600c:1e2a:b0:483:c771:10e with SMTP id 5b1f17b1804b1-48526957d6cmr76458155e9.20.1772875716139;
        Sat, 07 Mar 2026 01:28:36 -0800 (PST)
Received: from lorenzo-VM ([84.33.163.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb4257csm285850695e9.15.2026.03.07.01.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 01:28:35 -0800 (PST)
Date: Sat, 7 Mar 2026 10:28:33 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC] extensions.partialClone and promisor remote fetch order
Message-ID: <aavvwfZllMWUwIl3@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone. In the past weeks I deeply studied the documentation
regarding the GSoC'26 idea "Implement promisor remote fetch ordering". I
am preparing a proposal that is as detailed as possible, and that tries
to answer to as many questions as possible. I am also experimenting a
lot with multiple promisor remotes configurations, and creating some
examples that I will showcase in my proposal.


I have a question regarding the interaction between the config
"extensions.partialClone" and a possible fetch ordering mechanism:
 * from my understanding, and from my personal tests, it looks like
   "extensions.partialClone" is not essential when working with multiple
   promisor remotes. Having these promisor remotes setted up with
   "remote.<name>.promisor" and "remote.<name>.partialCloneFilter" seems
   sufficient. In this case, the promisor remotes will be tried one
   after the other, in the order in which they appear in the config.
 * if "extensions.partialClone" is present, then the promisor remote
   configured using the "extensions.partialClone" config var will be the
   last one tried when fetching an object.

1. is what I explained correct?
2. when the fetch ordering mechanism will be added, this config var will
   not be useful anymore. How should it be handled? It probably can't
   just be removed, so the fetch ordering mechanism should be flexible
   enough to handle a situation where "extensions.partialClone" is
   present, correct?


Thanks,
Lorenzo
