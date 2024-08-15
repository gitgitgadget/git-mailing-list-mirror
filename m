Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE58E1537A4
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757903; cv=none; b=rQ2MQX4OEE5HzCjMI6icVPoqatkoEqIM9ep1+Ac4CoA+tfikmZdGTlm3xxR6Xz/y37ohXb/s0PZDxMnnMV+qkbJTR0aJlP6SWq/wWarcBBrL/MmGDPaDLBzD5ILctGPY5iOH/O90gTNBYHQN/Bvq6o6ZXiFLF6IDhiLy8NLTbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757903; c=relaxed/simple;
	bh=w3czjcjaZkycxCby5WUS8CDnymJIkAb/86U4MfdZcxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzlkPOK+9Y9rK5kjiLj9VxVIsnAMaEuMhK/FfmXkxR+nedbDUNiZLBQQCcL4p9gthiynWjycwhc2brbprW4MpgqC/8Or6doENI0darhf6z8GL0yJldiIG9I99X2hKA3FUgnGgxnPyYBpMbE031/XzgaP3INH6TvVy9XM90eStLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXFfQ8m5; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXFfQ8m5"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d82eb2c4feso891618eaf.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723757901; x=1724362701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn7K3Q8OoMb+Duwp/UVG5jdpKNHjL9K7s47gVLfLzSg=;
        b=jXFfQ8m59PPbRHYESvbyvubP5t/4KBdCz/CEaChryV2O5h3aV9o340prbtXjEJhgbj
         y8xzEQhB/0cnzoT9CmXZgKrfASg1EwSHa7MJx9h0zW1FrPXSOga5GRi0eyT8ZJYlaOfD
         cekVSJFu3DYaHSYsNUkgaF+3Ez+1vE4q0DJo6iNunewg8CJz6vouIpYPBxC2iI4IHqlJ
         TYTpR3YrJD7123F/QGVSMnTWCWJ1ChaNYFxA9uVvzwsYKt4I/iEVH1ofAnRF3iUDgbHr
         wM9VnQnClNMeUSlswFUppCqjH18XF3tpgpu+rwygsjFPIO0432Cq/qZ58i500/4f9DY1
         ONLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723757901; x=1724362701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn7K3Q8OoMb+Duwp/UVG5jdpKNHjL9K7s47gVLfLzSg=;
        b=CvNCx/2egvEDScIlLTI9M3IxPDY7mB9pyk7e6ZF+xdhjpuzKCXytUd6lMXjRLept6+
         gfL2IJwROLorrOZLrKBcXemIP8V4QC4ZjfjJ/e2qDUfluUmZahxrGV68xJGkFatYgQJh
         s0q8IehS6BQT3Dd4d3pGpUkuLHcJ0T43VzENwy5wV1W1qFsN+HAK1KuhjYzpoav6cyZF
         gEQro0QHCd6UYLDyvSVXQjMwUwcvvxqRTrrZfLBjIN5TgEoIkBbGApmeLEg8KpZ/WBhl
         RCjAk0Z6oFu/t42aXybBhTSU2bjuzThaTwvbzbj825Tse1j3+sohzztpwSMHlu2mq2XJ
         L1cw==
X-Gm-Message-State: AOJu0YxN5noNPSss4K4TARasa6AKud3IMkd8HXaAYMxI9xW1h6z6GRGA
	rZLORHQ5H/4vlTce1JvLzF/9W1tsXbELpSWYIVp1mJymtwZIoCZo
X-Google-Smtp-Source: AGHT+IHZUTu+kQvwYv4+t1CnYBHD4boHpciaHms6npgos2oa7afr4cHAka7T5wBuN6dVtDWYFznRmA==
X-Received: by 2002:a05:6871:592:b0:260:f50e:923e with SMTP id 586e51a60fabf-2701c51d975mr1058970fac.37.1723757900762;
        Thu, 15 Aug 2024 14:38:20 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-270046a5897sm551726fac.25.2024.08.15.14.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:38:20 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:37:26 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 3/5] setup: merge configuration of repository formats
Message-ID: <hxnibmbakpvh72kfrycxnvo5a24f6atcqa73yys4zthbqpwikq@s7435n3nqmlz>
References: <cover.1723708417.git.ps@pks.im>
 <16f52b75d8972343776adb269da305e7406ff385.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f52b75d8972343776adb269da305e7406ff385.1723708417.git.ps@pks.im>

On 24/08/15 10:00AM, Patrick Steinhardt wrote:
> The configuration of repository formats is split up across two functions
> `validate_hash_algorithm()` and `validate_ref_storage_format()`. This is
> fine as-is, but we are about to extend the logic to also read default
> values from the config. With the logic split across two functions, we
> would either have to pass in additional parameters read from the config,
> or read the config multiple times. Both of these options feel a bit
> unwieldy.

Combining the repository format configuration logic into a single
function seems like a good option. It looks like go we even further
though since we also include setting the hash and ref format for
`the_repository`. Might be nice to also mention this.

> Merge the code into a new a new function `repository_format_configure()`

s/new a new/new/

> that is responsible for configuring the whole repository's format. Like
> this, we can easily read the config in a single place, only.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> -	/*
> -	 * Now that we have set up both the hash algorithm and the ref storage
> -	 * format we can update the repository's settings accordingly.
> -	 */

The above comment somewhat made it sound like the repository format had
to be configured for both the hash algo and ref storage before updating
`the_repository`, but that does not seem to be a requirement in
actuality.

> -	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> -	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_format);
> +	repository_format_configure(&repo_fmt, hash, ref_storage_format);

Overall, I like that this repostory format configuration is under
`repository_format_configure()`. The `validate_*()` functions names
confused me slightly initially because I assumed they were only
validating, but they also configure the repo format. Looking good :)

-Justin
