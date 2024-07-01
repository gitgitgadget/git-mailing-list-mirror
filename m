Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0915821D
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865958; cv=none; b=ejjd3A8eLciLN7m1upMk04gU1etp2MHxv/NL0pHu4yywNppRJP8rz2d9hbJYqDTAPBc7LNodfnlPYFRdXkocu0zceobqqF/cuxAo5M11VBooGD+xtDGMmQz8Osve8W2k02bH7D5IhyFcZ1Lsuqy/UxWl6VABqhnHWQbsh9ER46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865958; c=relaxed/simple;
	bh=mhZV1wxxocRUnxdqWR2FN+BEbD9A43tvzCOC+RvdY4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brdPR0kpMEK+fd3XnGGfCNIG65nIQkFWRAEnH44Mji9y2KD21/1OPyUaCc+SQ1Lj0N2/glBI/NekRMxblbiPVil6333Je8EVCuzrbSlkMTodP4KmKa9LM4FLhawd08Dbs9UcfpSxlF5JiWBzBd+ogt1QWmtuSZwy4bOBzxHZGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWxbE00z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWxbE00z"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f9b52ef481so16619145ad.1
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719865956; x=1720470756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6W7V91ScYKoaIg/G3/Bvqh8xmjC5M+MALZe95nYFEI=;
        b=MWxbE00zoOTXH1Sh2WjYOwh54cg9qXiMCbW++MPadQtv33y6a8nNrM1cMftPHbfwK+
         XyaT5/ZLOl15nQ70rQnFbZA8xt5iksf/6TgObSr6DKTXy9bee+M9aNgtCobDtf6o26Dn
         urXHwwKNtFA/41oXTIOTul+ZsUp7fzhSgzrbmzF23aZwJuiRjYpkHwM6XRQcX2eD+WWE
         aHQ5omddxScg+fI34i3kHJM3mKJ1oJQ+Up7snsXHF7wr7yrTAP0l/uZHBfDQxqalZhkf
         eELfax7cCFi8bC22N+uqKBIBe3DcJCGbDVhhO2A+dLIk4nKIcFJ/uUW2lNlIGmTyCu3f
         jkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719865956; x=1720470756;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6W7V91ScYKoaIg/G3/Bvqh8xmjC5M+MALZe95nYFEI=;
        b=KWb7cZZW+LbZuN/SKNhEY50qnI9OFEMOLmZPfCes/tANl6IYRqvF5TVS+xAmd3pgdi
         otDhsQ0jDg+gOtgBo92FV8h6psIf3Jqgohgq4DGKZySdlvvQYPv1NbzRVL6TtE1V/8/R
         9d5WoZuprrwbKRF8NN8+uF4KLqn7Bbv2TVK+e5TbvJsDcu8pGCWCVCwpGAVElQ4iuyhl
         7OpvZ3obq9040DjMw4MrboRp4i6Ge0Xng5531VMfwaeM/7eLVIjc8ZUhRQh4zVX8VjzW
         BQeM2TcIlvMZSGv/F04rTRJDSHjqKg6hxwkzAmkkOuUvkSg/M1HXIrWK9BFnr+sesgfl
         fyNQ==
X-Gm-Message-State: AOJu0YyCrg4Bj2ByikEceclhAyFJ8oN5cZWNDJk8o6qCq20M066eOVAj
	tvLOQFKaQgY++KNVgtuwcTgHTqS4wtKV3kLx+L0SrJHxFqBkVVusS+ilDBY4woGF8rKyXtpoytn
	/fA==
X-Google-Smtp-Source: AGHT+IGmFI0UocaJ3TmOUD2snp+fi9b4rS+H4Gh3Pp9rfgF4CdDvWxIMhzyLk4HJQ0FxVeYYtua1AA==
X-Received: by 2002:a17:902:db08:b0:1f6:8ae4:510d with SMTP id d9443c01a7336-1fadbcb799amr38376605ad.39.1719865956147;
        Mon, 01 Jul 2024 13:32:36 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e464:1819:7745:be03])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159680csm69437635ad.265.2024.07.01.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:32:35 -0700 (PDT)
Date: Mon, 1 Jul 2024 13:32:30 -0700
From: Josh Steadmon <steadmon@google.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com, 
	Phillip Wood <phillip.wood123@gmail.com>, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
Message-ID: <hxld3ldxomitv6hjuxq7munhppzie2nm3eworng6jnhf3suikx@rh6cunbz4vcz>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com, 
	Phillip Wood <phillip.wood123@gmail.com>, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
 <20240628122030.41554-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628122030.41554-1-shyamthakkar001@gmail.com>

On 2024.06.28 17:50, Ghanshyam Thakkar wrote:
> helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
> library which is built on top of hashmap.h.
> 
> Migrate them to the unit testing framework for better performance,
> concise code and better debugging. Along with the migration also plug
> memory leaks and make the test logic independent for all the tests.
> The migration removes 'put' tests from t0016, because it is used as
> setup to all the other tests, so testing it separately does not yield
> any benefit.
> 
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> This version addresses Phillip's review about detecting duplicates in
> oidmap when iterating over it and removing put_and_check_null() to move
> the relevant code to setup() instead. And contains some grammer fixes
> in the comment.

IIUC this corrects all of the issues that Phillip noted in his earlier
review, except for checking for duplicates, is that right?

Personally I think this version is OK even without that check, and I'll
be away from email for the rest of this week, so I'll go ahead and sign
off:

Reviewed-by: Josh Steadmon <steadmon@google.com>
