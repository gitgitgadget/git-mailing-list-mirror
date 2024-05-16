Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD3156F29
	for <git@vger.kernel.org>; Thu, 16 May 2024 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715887843; cv=none; b=q9igpptiLWAldOW7LBdMboXj1H2XZf1LLu8KL6nP8laMRr01Va9xOUO+Wa4Niz0Fey57l0d+ppmuuQlDjzWJYrXFJTAa6sZ6Iz0vZtGHxZ+l2kWUPHKlEETH3iTGDj/EP3t61mibWf/AvS5RAoKdrVTVsYfacd5dN6fB0Mn7iQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715887843; c=relaxed/simple;
	bh=IemHzqnK9QgnJePyqtXYy75rwtF8z7aaJgEb0oI7haM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHyi1lAoOtUpmoFThtofdCaULBqPW28bQf29GZfi5iZt9khd4C+srg6sVgO3xi3R/aazrVvt9dHyH0zWz83d2dkywclKEClDoF3NiY98GgKmezQfdReKGQwV3SWYlTKPsJnVXYeHNcIIQu1lniHuFROLte9p01jJUlkXUVVp3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdajZ4ej; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdajZ4ej"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f447976de7so565532b3a.1
        for <git@vger.kernel.org>; Thu, 16 May 2024 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715887841; x=1716492641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5S8clRth11JXnqtKvFRys4Rd5Se79OrpCQ6dfdY/ysw=;
        b=bdajZ4ejGgKOlUzwGZ/5dGD5c45fY8qcB4YblTVJVYr2gB2i+MRCTOkLQtquiqs0G7
         UyFeRTVQVSx19hcG48VLL/30zgKqQRjuUPr14bnSCL2mMmprcKi2PpNgchfvHOxAZL5L
         nnYh/FDKZGDbSyhJrvZBPZKpoiCJyrUfOzC0Skca4QNQ3BzFm5BVgp6a4nFHKKUDmkMh
         C1h/jtjYzyl+9eX77E5lhzO5XMShBz3AjWO58X+LduFiOt0+0GIptT58N4mDUcQiK+gd
         wvFAVRHIwRp/fpudccBlLvGw7nN/Oi9sZ+w0/l8eVaWcRCqvcNnsTFyxRthVTUvSj+ez
         lXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715887841; x=1716492641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S8clRth11JXnqtKvFRys4Rd5Se79OrpCQ6dfdY/ysw=;
        b=YyCZ5rQ+edPxlc1degcMjzBbMZY7HPtqAU48n5Dv594aF9BAQcgOHWKdOEQ2+BH9s1
         wjws1IKxBIRfwr53KqA95I3ylQtyPpZRhwAldo9L1z3WWGlUv129RkFrdzNkPgC3MKpw
         8etWjHOeueHI/dhGhXBByBYUMD7QrUbskprrSC7L3miZY+O3CWqC3fdgBlTjo8+UAsex
         wXtjUnoJPBpp8i1TuRkQIWqxfJhWXsJWaMd8o1DOEI7Q2V1bFfW7AYPHFlQzsZb3d4PA
         CdwURWjHaUo1eHFb8+3Wnvv0fxTK3sgdUDsCG3C0zD5x5hXQqVwEqHhnqRsRUd+tfdXx
         MHnA==
X-Gm-Message-State: AOJu0YyKuheFB88xD+XemQQtICLWfDxu9kpEmP34J0yygzi0MPvfL+dc
	C4sb8HXLe2dUOaxdslGty7MVyTt+f4kPm+riqb2COKAI4pbhAWq4
X-Google-Smtp-Source: AGHT+IH6jeffdFBtWDUGF+A6btwLswd6Vu0swHusm49Q3FA5z1BBTlFMnuz9uip9Z4XsXoVlAZ5qcA==
X-Received: by 2002:a05:6a20:ce44:b0:1b0:25b6:a749 with SMTP id adf61e73a8af0-1b025b6a9e9mr4995853637.48.1715887841154;
        Thu, 16 May 2024 12:30:41 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f28bcaaasm9923891b3a.73.2024.05.16.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:30:40 -0700 (PDT)
Date: Fri, 17 May 2024 01:00:38 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Achu Luma <ach.lumap@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [Outreachy][PATCH v2 2/2] Port helper/test-sha256.c and
 helper/test-sha1.c to unit-tests/t-hash.c
Message-ID: <s6xkg53leyvn32xc3i4qikd7gsgmeysae7xkc2ee4smxpgsxl6@axjfflq5ixmu>
References: <20240226143350.3596-1-ach.lumap@gmail.com>
 <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240229054004.3807-2-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229054004.3807-2-ach.lumap@gmail.com>

On Thu, 29 Feb 2024, Achu Luma <ach.lumap@gmail.com> wrote:
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 482a1e58a4..7bfbb75c9b 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -73,7 +73,6 @@ static struct test_cmd cmds[] = {
>  	{ "serve-v2", cmd__serve_v2 },
>  	{ "sha1", cmd__sha1 },
>  	{ "sha1-is-sha1dc", cmd__sha1_is_sha1dc },
> -	{ "sha256", cmd__sha256 },
>  	{ "sigchain", cmd__sigchain },
>  	{ "simple-ipc", cmd__simple_ipc },
>  	{ "strcmp-offset", cmd__strcmp_offset },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index b1be7cfcf5..8139c9664d 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -66,7 +66,6 @@ int cmd__serve_v2(int argc, const char **argv);
>  int cmd__sha1(int argc, const char **argv);
>  int cmd__sha1_is_sha1dc(int argc, const char **argv);
>  int cmd__oid_array(int argc, const char **argv);
> -int cmd__sha256(int argc, const char **argv);

Removing 'test-tool sha256' would break many tests in t53** when
GIT_TEST_DEFAULT_HASH=sha256, because it is used in pack_trailer():t/lib-pack.sh.

```
    pack_trailer () {
	    test-tool $(test_oid algo) -b <"$1" >trailer.tmp &&
	    cat trailer.tmp >>"$1" &&
	    rm -f trailer.tmp
    }
```

Also, I am planning to take over this series, so I will take care of this.

Thanks.
