Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79C25D536
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725944; cv=none; b=nXqjX46Q0AG10teJPmlS6rYGC9zPGGJfWDIPbjFqRCa9ToFuzMVLtc+zE+mOQLpzvulQEI0gIGDxnmLOtEa2xRG51ca9i1QSf4skBRRt+hOg6BglD+5by0lQ8BZJFgcQUU8QGOQd0y7mH4TYgMWD5MOff9cczLq6NBCQMc26ULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725944; c=relaxed/simple;
	bh=YG6Yvkw6wY1bWiUVvpX1eVNm+UY1Q9zeanVwPCD3nqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXqeKlS8jEHx2h9JkbBaWHDr3f8O4ZF0cTsutMezKLulNZvFQhJDpRB0fWZmxo0g7KZRHioy57hYjBL/MrIbbO34uDroSB9YHqrQn04EVrxr7BTn9a0VyVVzv3l1YkcZtCya0C48T1XqGXbJCF04LrkSJrR17ZxN9TLPqX9VKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZyBIPwgw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyBIPwgw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-242d3be5bdfso21785ad.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755725942; x=1756330742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW9nLR8ZjZryFIcneAeP3wyzlPPlNQntIJGzgeHO240=;
        b=ZyBIPwgwVOnv1Hnq+JDTJLMBCD33eoKNN0DQZgKXoEVSr+FRu4/ZBWLx2WBjLtfzXS
         9O7CU2ibruRdnd59R08ZYTAHxIuok01mGjSCdK8A05ESZ0QsGEPy41x90u5g8QjGw70x
         I3MwvDgOG9+XXpFyWLySIrTAklJLH8lO7yUbUwrptF58PnqnJTTKbOtwxf8HHtc//omJ
         8hEzVGp+5RT4eFlICKuMtYCqoHdMgIoa99FfO51GT8V7uow8VKqWvuBRQ3ZPWUCRrft7
         jjQl15f78LzzmzDS5oKk6xREaiXh1v6a3IH7ocU8ryHYiPKAYB84e1UG8cFj/qvFf3i9
         gDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755725942; x=1756330742;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kW9nLR8ZjZryFIcneAeP3wyzlPPlNQntIJGzgeHO240=;
        b=fYJZHsAgDGb8U9OJ0asFNgveyyW2I9siARyRUgvWouZu0DK9XCgBEGbqbEH/8deu4L
         yd887HnXGIII5ndGtSazQVnYmARcFY73aJkWA/auazPXM4OQEXq0o7X6ZG/kfJeN56rU
         hvpZg3eLpD+bWtWDncQS/tPJsVowemCD7uHrbHGsrP7Lo0JVVGWMNXUkF9SxOIZ2ZZ1k
         8FgInMvlr+ghqb7XxSc8XRoBxFTq2Frx1Dq3rfnzXXA1Gisccr84B5ggc3zY9mzXsp6J
         Hsv1wuRRlYCetnWozLWlfk5hF4P565BYa/eGRgCpgZc0trixkz7cdqo36ip7InBcpUm+
         nwGw==
X-Gm-Message-State: AOJu0YyhY5SnB+QpD1nqyCG7q4h+ZmeFhsTbxXDPveRSDV7PCxh8VScQ
	F+euNqwkzLJnvOkW6m+RBSQtpQzzMlwhTYwV57+rBksjulB2u3zR9FseI5C9WthSfw==
X-Gm-Gg: ASbGncsgSCE/csq3omYQ6YLnXfZIzGY0x6CblWEIOJDUGq+pwbMz1CByhjJcfFd1OBd
	IveSbtpa33bsG2+J1qu306z+w1/sFdRSHfbH4JhPA7irLXVKuqqbXHF8js2Pb6hgtzclP3yVYyY
	mOFeFOG5FY1Xh4J2xLGst5zJnl/mFhtA0/Rmc3T6C2tRbrhbrohLmvBZzavey4rqE0T7MeQppth
	WyMli/PISKk/VAJ5+toWiW+4YGMGVcStBGIg3lSTfo+HXeZVKQWHG+Eb4XX1DmQIfIubAUqatsm
	Swp0c1XP0LiG7/9oojzRXJ2XmC3kfYd7wMZyNy5/QqpPPjN1DSRadYTnlf6a6m/KpsI/GPEY7aw
	Ee6fA4pLh3P1hNn9J1ruAc5ufPu/+cJsZwVpdeA==
X-Google-Smtp-Source: AGHT+IGiTXqtevFf0Km+Kn3ZG5eetV66dZcMBez6Lsi2ow1mV1XiB5C/0urv1UyaxuUD32JpciCGHw==
X-Received: by 2002:a17:902:ec8b:b0:243:afef:cd88 with SMTP id d9443c01a7336-24602316936mr207115ad.11.1755725942140;
        Wed, 20 Aug 2025 14:39:02 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:23b5:65e6:69f5:ee81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d14e531sm6196337b3a.50.2025.08.20.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:39:01 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:38:56 -0700
From: Josh Steadmon <steadmon@google.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Stefan Beller <sbeller@google.com>, Patrick Steinhardt <ps@pks.im>, 
	Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 3/9] submodule: add gitdir path config override
Message-ID: <3hzj6k4yxfcvpt33jkblcafljhbj5npjia2u7sprqbkfcxoxwa@6qmaqwj3x7hc>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Stefan Beller <sbeller@google.com>, Patrick Steinhardt <ps@pks.im>, 
	Brandon Williams <bmwill@google.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816213642.3517822-4-adrian.ratiu@collabora.com>

On 2025.08.17 00:36, Adrian Ratiu wrote:
[snip]
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 178c386212..f4d4fb8397 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
>  
>  test_expect_success 'setup - enable local submodules' '
>  	git config --global protocol.file.allow always
> @@ -1505,4 +1506,18 @@ test_expect_success 'submodule add fails when name is reused' '
>  	)
>  '
>  
> +test_expect_success 'submodule helper gitdir config overrides' '
> +	verify_submodule_gitdir_path test-submodule child submodules/child &&
> +	(
> +		cd test-submodule &&
> +		git config submodule.child.gitdirpath ".git/submodules/custom-child"
> +	) &&
> +	verify_submodule_gitdir_path test-submodule child submodules/custom-child &&
> +	(
> +		cd test-submodule &&
> +		git config --unset submodule.child.gitdirpath
> +	) &&
> +	verify_submodule_gitdir_path test-submodule child submodules/child
> +'
> +

Rather than `( cd test-submodule && git config ... )` here, you should
use `test_config -C test-submodule ...` and `test_unconfig -C
test-submodule ...`
