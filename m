Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C0148FE4
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462265; cv=none; b=BNoc+5UTKJh537htaJN9knO+5ggiWdt8PsvtFxdI0JILQ/2uHa+H086IDIQzP6p7r+a1K3RyMYP2x4RXYZueBjJ6IQFszE2rTHABQotNFR8RysTDzbrOgvxQy716eM7rj/ngLlaldPHBYzIqhIQEbPEXnWlDo8zVXMGpuxz1v84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462265; c=relaxed/simple;
	bh=RIgetEjd0SWAo178CFOD+IIHQJ6sw+3kUe0Mg+y8C20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZClkQQ3B0hd9uJnbTjhEDELucXvZSNJvH+BS450zD39c1i6nIeZ+Tx3O1E6zVr+t3cd/U3D7o/Dm7DETDdKBUqmuXMEUGtGmFQCoRbYoViaMv1P4+GgfJzc+slFoyIxJobU8d26QFWl8mN/g1ueKVwax6i6eOeeRxLFhd1tJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgFDEVjK; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgFDEVjK"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7036e383089so668456a34.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720462263; x=1721067063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOmQQHvr48EfPcY7CrvF22nbL/cDdkRL3c5SJJBydK8=;
        b=SgFDEVjKbi8TTmVQjZOlRIDziZPigHNM1WwufMqwQ3Jw0R+EH9TPVBk3usB6nF9I0A
         nxkT7AIQHmP06QxhUb7Q66TRJ6V52g63zm+hEejtVUJxQbKEcOnLeS73cXs9WQhRJzlJ
         WwNX7u/w+fnNFZyG9icWy0rY1RN8ZV9DOk/dzjV8RnvlogH9ncNL4yVpQFSAKXeNFZGf
         0BbOwj5C1x7fU6ZXbtPxy/T97CH4kzn4mQVdcI/TYyAq3K+ju1iYn9idYYbFHTj+hfws
         i+eB+8x2oF6og2aIOZsuOGE7ldlpvA5UAbPNq/KhaI7D7EO8tskkZ0FLgDO9TZFWQsUM
         esiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462263; x=1721067063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOmQQHvr48EfPcY7CrvF22nbL/cDdkRL3c5SJJBydK8=;
        b=WiyFgc0yhX3pfDWHWqTV5yy/FjoRoZEbmEPWt0sl92xA0gJhXHgPMyQzTZMdlepSV7
         jp4cBv67CayczPIdiiwYWrrXtomfiqDqqchY61u0WPP19yuqmQFeXCDyujtM3slYSNsV
         5wVVI7cwIhDV21mFrcJMMjOzZnolSIFgHma14Gd+lG7f9tQhpK89v+t4ivNlpkOGfuDj
         oMVYtwuFC4uBSSt9fp/l0f2GlhOBG4sXPXaHrwo5BchsKbqEmb0IuLWx9LnsBlrJg2Kq
         NzqSs7mYpYWJwVAwfQjAslL/YV3T3coFnZb2fJeiK3u+6TykbT9W38XDPJqsErWFP2+6
         oX1Q==
X-Gm-Message-State: AOJu0YyhdvQopi1eiZ9zOZPYMNGrzUXJ1ngAhtlZVif+MelmNcFHeYLq
	18w3NH5Gv3mRqiJi8O5vl6fQR7VLQPwpIuSbnDHGLC3Q2Of8EKG03Ryh5g==
X-Google-Smtp-Source: AGHT+IH3NzgXefAmkqENXMP50LByijLdAnaknqadKtL4WSwiui8sJ0OcTOuSDGEgEQ6KfhK91hebTg==
X-Received: by 2002:a05:6830:22fb:b0:703:6dce:3ad5 with SMTP id 46e09a7af769-70375a17ad6mr259818a34.22.1720462262974;
        Mon, 08 Jul 2024 11:11:02 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f882absm90497a34.40.2024.07.08.11.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:11:02 -0700 (PDT)
Date: Mon, 8 Jul 2024 13:10:34 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 7/8] ci: run style check on GitHub and GitLab
Message-ID: <7wc2ucdbirqgtrxgij3i4eqwfib334kdogbfxtiyifje6clsat@3p3xnqkoj3ic>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-8-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708092317.267915-8-karthik.188@gmail.com>

On 24/07/08 11:23AM, Karthik Nayak wrote:
> We don't run style checks on our CI, even though we have a
> '.clang-format' setup in the repository. Let's add one, the job will
> validate only against the new commits added and will only run on merge
> requests. Since we're introducing it for the first time, let's allow
> this job to fail, so we can validate if this is useful and eventually
> enforce it.

[snip]

> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 37b991e080..65fd261e5e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -123,6 +123,18 @@ check-whitespace:
>    rules:
>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>  
> +check-style:
> +  image: ubuntu:latest
> +  allow_failure: true
> +  variables:
> +    CC: clang
> +  before_script:
> +    - ./ci/install-dependencies.sh
> +  script:
> +    - ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"

One downside to using $CI_MERGE_REQUEST_DIFF_BASE_SHA is that for GitLab
merge pipeines, commits from the merge that are not part of the MR
changes are also included. This could lead to somewhat confusing
failures.

Example failure occuring on this patch series:
https://gitlab.com/gitlab-org/git/-/jobs/7284442220

It might be best to use $CI_MERGE_REQUEST_TARGET_BRANCH_SHA instead.

> +  rules:
> +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
> +
