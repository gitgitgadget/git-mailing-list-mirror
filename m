Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5E220694
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221503; cv=none; b=rv4aNdVS6ZYAVhpH/+cnzPi/xUuNgyikGLzuVC+pgOIV+23ovH2DRnijxWIxpdCw2xBsuR4pOSy6260UzPqnm1j7KrYZ8NUEOZkdxlUAcL3ozLzDqZGixokAqmVo3uR8zJ15jEUYnNqIbdhLhMhb0dUmSF6KXLpD+MSy7KhQGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221503; c=relaxed/simple;
	bh=QFkZVJDC0nVJn8TuyE+VNw5vkSOyi2guJJ/VxXxZ5NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR8YOXBBLvYm6Y9RREfzjyvE5YKXi4Y7RYCNW6Se0QthEzpU2Hcz2D4VqgTqGsYD9wlOTXXybD4ovoTXV3y0kV1yYPBuGpmTaeKLzoDzzVpDyqVh3ugsZrPIAIaprpCyC/TUecmQxpJU7R6y/32c6keAY2HHDAU844yRh+WOYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyf6qph7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyf6qph7"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77057c4d88bso2252466b3a.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756221501; x=1756826301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghwHsY0OHPbx8J9QHUfVJYIiPLsBpzuQ5d7e7Q1fox4=;
        b=iyf6qph7CV/tr0QZ0PWkgKnzHarX5bWrk0RRz2w9pSzLuPl5L+3zir3GfUptJNxZcY
         BMjYyVTf6FyEORdBDxsdYdbUHM4eRHLRWCmA/x1KvvBl4wQj1nPKcuaLbFWqQWP9H9nw
         IiEwlo8VhnpnsnqMlGspQc3QEXuwcmON3tgtvx4ysptjflEI1YEct6i3sSgV/GPFqMOA
         v6PYNDOHudAEe8XfuOzZoSda94ckUIKBGQqfWx1JVkDrZOoJVPa7DvzZ4t6/KnZefny+
         2e7ghNsTyXjxnqH8FaTdgTM/LyjjUk895cUan+ax1ZhMNtuZt2arXSBIle1IqD9F/8pA
         G38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756221501; x=1756826301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghwHsY0OHPbx8J9QHUfVJYIiPLsBpzuQ5d7e7Q1fox4=;
        b=SSK1p4aT+Q0loGTacm2HPvx0fSVskjAX+aGKCbBDP8/pyh6HC9w2HnsESm3Cs4yUHw
         5vo+VSyFkyIL4ryLzmOK7e/tZdberkwpuCu68GJJAUkf08v1YpB23L+xopAnRe3VpXVO
         JSNpyDkwkT9LvSmcPB6TnYP53jo+7bA1CG01KdzrdhmCpwjgS2LJRwidVcFxcaOpFJbX
         jFvQPhZOjtv3kHA6EAVW6fDPdQ/Nean08bx8sch92ao0SmT4LgzFZSA8ySAWUWC8TDHr
         cnUYSlF5rQPw2w+zsZLw+FYPzWKG7IxeuI8LZO9NBfmnHv3TE6vL3nJ+95VwkJLrSX82
         xumw==
X-Gm-Message-State: AOJu0YxFTW4dWhf8xJmSUjeIbMIFZUBGZ0iXXUIcFARyf4PjIn5nBd7E
	rFi8KUvoKzcRU33LCp+EJSxb8IPvdw5uKHwFx0DvlYFgFgWrZxuVvXz9
X-Gm-Gg: ASbGncsbJRzcc5MYNZgM65bQLl5yPrt2jr/18OcGGddIhktnpHMs+OOG0BudwOj9XKY
	NoxSW2nGuXHzr9dodiURzb7azOkVAN1KqtbxoU5oL+k5e5fkHt3hVJ6nkpDP8ZT1nnrZpmgaCKC
	JK4/0gAwLOxq5fw5L8W1fFT92HyzLGcL9ZpsboJhGDap4dNGM123iheeVAYhSFKsHYHhcXgeIFs
	cN+U1X4tGEVG8JQg+YSZN0F8PBBCc4hOP14xhyLF4YDBfbVjmFcGydmzcFPcpmg869abtNL8+Jx
	tfoZ0tse4pSRhsf8anV4VkGxRzYNhYnaSgPhiBURIwvVzflyA0AUc/jvDzM6EpnshDeXEJIAWBg
	51TNF6L5CAIGcKKi8KzrV9awrmUeE
X-Google-Smtp-Source: AGHT+IHIC93JAIIn1uUqEM72paaZH9frPLyO+YqJIIb/yqy0VSwJTTAFutej580oz0I5R97Uhh8Oaw==
X-Received: by 2002:a05:6a00:198f:b0:770:9de3:15be with SMTP id d2e1a72fcca58-7709de3277cmr11477845b3a.22.1756221500893;
        Tue, 26 Aug 2025 08:18:20 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-770401af16bsm10743376b3a.54.2025.08.26.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:18:20 -0700 (PDT)
Date: Tue, 26 Aug 2025 23:18:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [GSoC][PATCH 5/5] t: add test for git refs optimize subcommand
Message-ID: <aK3QOtQzUFsGvmyA@ArchLinux>
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
 <20250826073645.1074397-6-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826073645.1074397-6-meetsoni3017@gmail.com>

On Tue, Aug 26, 2025 at 01:06:45PM +0530, Meet Soni wrote:

> diff --git a/t/t1463-refs-optimize.sh b/t/t1463-refs-optimize.sh
> new file mode 100755
> index 0000000000..c11c905d79
> --- /dev/null
> +++ b/t/t1463-refs-optimize.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +
> +test_description='git refs optimize should not change the branch semantic
> +
> +This test runs git refs optimize and git show-ref and checks that the branch
> +semantic is still the same.
> +'

When reading the description, I am wondering how this test runs `git
refs optimize` and `git show-ref` to achieve the goal. Should we simply
just say we use "pack-refs-tests.sh" to ensure the compatibility with
the `git pack-refs`?

> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +GIT_TEST_DEFAULT_REF_FORMAT=files
> +export GIT_TEST_DEFAULT_REF_FORMAT
> +
> +. ./test-lib.sh
> +
> +pack_refs='refs optimize'
> +. "$TEST_DIRECTORY"/pack-refs-tests.sh
> -- 
> 2.34.1
> 

Thanks,
Jialuo
