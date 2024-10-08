Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A481D9A43
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396277; cv=none; b=Oz1LbU2t/Goi5d8MTLrrdeWPRlhbtylsPwiGEO3R4zgH3+nniwZa1KI8RLhmOYUsdbErkPFGa/mL/uq5DQOiQKVfGhmSFaRHOTTXyj2HbECALkswkz+RSE4ClAK/oWNLp0M2x/T0dPG4WGRUEeMcpf7I7Ji1/tiahplTwRaKPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396277; c=relaxed/simple;
	bh=Jv+VGhxT65wZQ/06HlvyBLxxqLa4MwFb+/zt+oHC1nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5PcvOeXRHjH8YStf9z7NXHO6I2QDQ9Fwt0cpetwoOi6WtPBdWGkkuI967bpqPRi11QhHXtJJwgjWwP1iUVcMGteqO78QgHSO9aZvH9Yxz5hvpNOUsu5uI56BViwq9YFKaKXefspZ1Sm9/MEFPWA+R8KOP9mpzF3afOpBN1ghnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT5q9tms; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT5q9tms"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c915308486so464396a12.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396274; x=1729001074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w9BapLlus/ucCCjz9f2xEXl3nfgD2CVmhKnlEL6a70U=;
        b=cT5q9tmsBIEV8+YUbj97T55vOqAeSDuBo24Y4hUNgpGRIOeV2xjSfKQMguLElTk+3o
         s48NDAeIX48rj0DWkHldGj7xI7DxQ69mvuXhHLKzQT65W5EvnEI8lsuppiAeIjfK77Pj
         zLofFHdhoYq2h/63V6HiuQb/jfS593mrZ1w5TMMyq2NsOxeoriJOFbY/hXzB6r+YQNe4
         QnA+A+xQK/wae3HAxWNL8zg75zyrsvUxDqDon/82ZnKMCI/CSwGRcz1zPo0WXvLK4N0C
         +JxE5Y0xRaSu6OBys0sNM9IPNsbvFe2njTqxXsoAqH1y30BTL9v/owT4VMwmBxB3gaXO
         iAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396274; x=1729001074;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9BapLlus/ucCCjz9f2xEXl3nfgD2CVmhKnlEL6a70U=;
        b=XLTXVvRndu8AXmX49ZSR7hBYKqdj2NPdeqKr9lxOYJbaMuVpQjrICCzy0oyQJrxoXd
         Rj7jrGk7ZoO03omLxkhbUHqatYXFxSfpxoFLdo4+LUhIal2lrXw6XuT0WIK1Tslvp6TC
         93hsyvnRedR0Lyyk7hT7SQx1gYB+nrwx/XPUc4NSON6F0EKU/mWij52Z42hlJSklpuE5
         6lRF3OUN753ZhU2VmpBodL8DIbQVzAfoo4LMmGMRJSPT2e/oXzQrAVdoPWsbZHyw3RpO
         q0Z5cm2o7LtU+omQ+n+qG4ePQIlgYkIlxPqP88QNJHqfAqziQQ2yjj7jVylCnZB72W5Z
         Ne1w==
X-Forwarded-Encrypted: i=1; AJvYcCVdBwM7YzIJfR0gGZHXzSHVc6Pg0wZLUjFH3u6f6U4WJJImElw0U1N2jtjOnsl+1mJwG1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbMdLKh9YGM3kYliSE4oAzKV3PkZFo3r+B2vzQKRNzSTd+QhmV
	xrbn4GAfP0kxGl906MixNBj4+5Xr8+lN1aLv/TnD9lMLLCilunsR
X-Google-Smtp-Source: AGHT+IHrxFRnb9PL9jHkB3FpcGzDmXJBBXw65SGiQLupPyxlRILT6v4UhoN/gkXI6nnWBI/lH0LvWg==
X-Received: by 2002:a17:907:25c1:b0:a91:15dc:31ab with SMTP id a640c23a62f3a-a991c06c9e2mr1346411166b.53.1728396274102;
        Tue, 08 Oct 2024 07:04:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5bb23bsm513793166b.34.2024.10.08.07.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:04:33 -0700 (PDT)
Message-ID: <9272f2bf-cb5b-4b1b-975e-a7340dd5c48a@gmail.com>
Date: Tue, 8 Oct 2024 15:04:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 20/21] t: allow overriding build dir
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
References: <cover.1727881164.git.ps@pks.im>
 <c5ae59ce905512aaf4d02d744da90eea982eb065.1727881164.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <c5ae59ce905512aaf4d02d744da90eea982eb065.1727881164.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 02/10/2024 16:16, Patrick Steinhardt wrote:
> Our "test-lib.sh" assumes that our build directory is the parent
> directory of "t/". While true when using our Makefile, it's not when
> using build systems that support out-of-tree builds.
> 
> Allow such build systems to override the location of the build directory
> with an environment variable.

ee9e66e4e76 (cmake: avoid editing t/test-lib.sh, 2022-10-18) added 
support for reading the "real" build directory from 
"$GIT_BUILD_DIR/GIT-BUILD-DIR". Using an environment variable is fine 
when running the tests from the build system but it is a pain to have to 
set it when running them manually.

Best Wishes

Phillip

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   t/test-lib.sh | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index e36a21ddf7..6f862621af 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -35,7 +35,7 @@ else
>   	# needing to exist.
>   	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
>   fi
> -GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
> +GIT_BUILD_DIR="${GIT_BUILD_DIR:-${TEST_DIRECTORY%/t}}"
>   if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
>   then
>   	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
> @@ -514,6 +514,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
>   		PERF_
>   		CURL_VERBOSE
>   		TRACE_CURL
> +		BUILD_DIR
>   	));
>   	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
>   	print join("\n", @vars);

