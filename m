Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30717CA01
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112225; cv=none; b=Uzo70QH8F56nkq3gzbOo+PIE/3wq5DcQUstksftHoxd29tZ+yYezZrrKnVQzqlFybBXTD9ZBSLJUUyfyBo/I9V/lkvhBJzr0irxITbyc4Zcz5WuqZH7O8QUzBybC4BE+b8m2gQ4i8bv4IGg6qSF/6NPM+GcOgOHJB/HNSzXhzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112225; c=relaxed/simple;
	bh=9550tBYMTGWyI7d2HOpTDD6Hw0wOH/kgicKe8r5oYUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb0w8c79Cye64u8zxIkkza+gV9zpIY/qns+RaTxLOEagra5pzN74XhKQyu5lUTwR2J1q0o8yuQz0oa0bBZwoKJq/NKZ169Kfu5HF0qre8pbK8vCPuN1j/YWQOPK1zaGXNkFEksfiV5cp6Rhj+T0F7B7yJw322E6+tHFCYz9RQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg81CnxN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg81CnxN"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c2eb5b1917so970826a91.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718112224; x=1718717024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+AFN/ZO7LKKUHzzLYDJ0ogzStxfZyicfq1Cc7vLnzc=;
        b=dg81CnxNXTgj6WFy0+FIeaCSxFD5jWjoPleMkuQ9F5YP7dGOsuKs1Pr0aZAxwpMHH+
         4dyrj3QX+rA4vOXkOr+nWLiFY5w5Xdj13GWWy8HsWFEv4hGwzvbOXys1Pm4wQbBue6Vk
         ZrQCWWUl1oj7pPpBM6C5Z2at/gpxP0iv+1Kbz9O2IjWM0F3DXc5CigSrQL0+5/nZNCpD
         Yop+jRwNiypcQDAQTbPibYffrd1aE+q1fWENINBaFaIFP8+dtlTTCIlY2xG839X0KP8t
         wpE81DOlbMaiwTEvXiw7ZYE1abhXd/y+gDCh56s0xHAiDExMmkS7S1AePusG89NYKwwT
         IL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112224; x=1718717024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+AFN/ZO7LKKUHzzLYDJ0ogzStxfZyicfq1Cc7vLnzc=;
        b=jgNYK37tD89jqorQGAJups0zq3tSaJR5l/WKaqMORVOAA8JyvNU5vG77HjILJXvcRL
         EcTjYk+xKCTiBvDeREb6HNnp+5USb6dTeGzfLOFk4DqcVc9mwca/kd+NOooV+PW1gIHl
         5G6OOyjB+LecLj4GoYi3Ntpb+k83lPw+Vp4mGyShpsdWmVTTtHdw7ym/7KYgla+bx/3O
         A29HNRdgBOfvtrNcZOWackNGg/cfBsxUZYNgs1fqd/kpdL6WgJY10Vt7vZ4itk7bgROy
         Yl/XTKEnW4Hqr2Mv0zkxFTYv2gdSdjvswRBV3KLUWkCw0Ev/rh00KfoqhyBpusUv397w
         WBRQ==
X-Gm-Message-State: AOJu0YyrlKHVphtynEqOHFXrnkBT1EwoeW33IF0S+wwvL/VyR0GqHIxU
	KarzHzVzsBmxwYey22Cpkou31436b2Hu+EZq9YkHgMBqijuc3CEaJ4t7rVGC
X-Google-Smtp-Source: AGHT+IG2lmEpFX1eulamVobOf75RM2GrrNiA9niqZy5+C+C09eH5WoYRNOytZNk8A2hggP4L/chl4g==
X-Received: by 2002:a17:90a:7803:b0:2c2:fad6:3fc with SMTP id 98e67ed59e1d1-2c2fad605abmr6985488a91.11.1718112223415;
        Tue, 11 Jun 2024 06:23:43 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c300adaf94sm4851612a91.49.2024.06.11.06.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 06:23:43 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:53:39 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 18/21] t/helper: fix segfault in "oid-array" command
 without repository
Message-ID: <cc2go3x24cftqml2byx5oh3ggvsqdz32yufdpn2box2jpehtlo@hnsubup3sefn>
References: <cover.1718106284.git.ps@pks.im>
 <2774b8500fdecb0d73543dbfc5ac18c6bb8d8090.1718106285.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2774b8500fdecb0d73543dbfc5ac18c6bb8d8090.1718106285.git.ps@pks.im>

On Tue, 11 Jun 2024, Patrick Steinhardt <ps@pks.im> wrote:
> The "oid-array" test helper can supposedly work without a Git
> repository, but will in fact crash because `the_repository->hash_algo`
> is not initialized. This is because `oid_pos()`, which is used by
> `oid_array_lookup()`, depends on `the_hash_algo->rawsz`.
> 
> Ideally, we'd adapt `oid_pos()` to not depend on `the_hash_algo`
> anymore. That is a bigger untertaking though, so instead we fall back to
> SHA1 when there is no repository.

Thanks for working on this. This would make t-oid-array migration
smoother.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/helper/test-oid-array.c |  4 ++++
>  t/t0064-oid-array.sh      | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
> index aafe398ef0..076b849cbf 100644
> --- a/t/helper/test-oid-array.c
> +++ b/t/helper/test-oid-array.c
> @@ -1,3 +1,5 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
>  #include "test-tool.h"
>  #include "hex.h"
>  #include "oid-array.h"
> @@ -17,6 +19,8 @@ int cmd__oid_array(int argc UNUSED, const char **argv UNUSED)
>  	int nongit_ok;
>  
>  	setup_git_directory_gently(&nongit_ok);
> +	if (nongit_ok)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

Ideally we would want to test with both SHA1 and SHA256 without the
repo, but it is not a necessity for this patch as it would get solved
when we migrate to the unit testing framework.

>  	while (strbuf_getline(&line, stdin) != EOF) {
>  		const char *arg;
> diff --git a/t/t0064-oid-array.sh b/t/t0064-oid-array.sh
> index 88c89e8f48..de74b692d0 100755
> --- a/t/t0064-oid-array.sh
> +++ b/t/t0064-oid-array.sh
> @@ -15,6 +15,24 @@ echoid () {
>  	done
>  }
>  
> +test_expect_success 'without repository' '
> +	cat >expect <<-EOF &&
> +	4444444444444444444444444444444444444444
> +	5555555555555555555555555555555555555555
> +	8888888888888888888888888888888888888888
> +	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> +	EOF
> +	cat >input <<-EOF &&
> +	append 4444444444444444444444444444444444444444
> +	append 5555555555555555555555555555555555555555
> +	append 8888888888888888888888888888888888888888
> +	append aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
> +	for_each_unique
> +	EOF
> +	nongit test-tool oid-array <input >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'ordered enumeration' '
>  	echoid "" 44 55 88 aa >expect &&
>  	{
> -- 
> 2.45.2.436.gcd77e87115.dirty
> 


