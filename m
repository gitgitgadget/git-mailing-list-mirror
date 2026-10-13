Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36B4657D6
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884651; cv=none; b=nFi6xu2wLr15C1QPQucrw6LbR4tQ2aA7GUJuyKJNX5085ayOJ0SeN4bkqAt6ulLsFbQdVmWYdGs8jnkilvhHdERsy+K2BLjFT6cIlRYuIYA3erzGE+ni9b9lXc7MZFRnlUGd0FD7XNTdS527S8hE+ovWGA1YutHbL7uGP6hgsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884651; c=relaxed/simple;
	bh=dIJtT+x6udPjcsUDxM40uKX23OPnG2NNWCLyH4ez1Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC2C0VKFPuG+bLlhK6pUOE42BuGm2Ii0HV95OCE/E4uVevyl69RIE56mFNqx6ktfJ5mmPUWxlV8fK86xWTAbnOuVLIlYvnGnrp43DV3Sjd+rwbZrnFxxvVM7auHXAJaHSsAVnvLSpV0HXDxcqgNfSA76yHWuiRsZmGZ6KvAoh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwcVCEiY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwcVCEiY"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48b042c0728so582303f8f.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 02:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791884647; x=1792489447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L+SPqDCSqVrgkeipIa6RTXsVoDZqeKOz6XL6rKUcQ60=;
        b=EwcVCEiYzlBpJ/sE1q33AVTBcodwwb1oigWsiYaySxsOPf2hEPrLszwRYbiwSzkEyS
         oHMm1ljfZ94URJBhxqDk9n2MfXGbC9bKto7HHrTiJlVIIVjPyrzSuJMMQ+67U5nxdPh5
         3vU5IIz5bysNAAJPY1FuZfY/0vm15eInEwbU/n9X/VpxguXXbIT6yBiAuwrl7n/ERbAg
         px/PbNaGcazJ0K8jj6irgmNEfQuFOvNRGilcZLu03nmW/P30VaUCW1rlASOKUEOc+rBA
         YOfrqzAP4E0MZYbP5SIo8dLiFt1Y/d9UwO/W+2eeApYkLW33jS8bL7KIlIVEqPMO50md
         32XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791884647; x=1792489447;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L+SPqDCSqVrgkeipIa6RTXsVoDZqeKOz6XL6rKUcQ60=;
        b=JTlUMMoI1ntFIqZRN8s+EDiy7IsX61zQO+wWcAB0WrPAT65Qh/FYKq6dE9nFxlAXr7
         TvKp6lHX0zKooqIqdmXf7/ZtZHykwxXxZ8ApuYPGR3Gux7ZxzPjQd5r/Yx9Lb/zMk9RI
         8P1nHtt1q/mUH27/yCu2SgiTVU8X2uSdCQH55BjAoSDGmEGo8iConl3OFcAQ7n+XM7fs
         5iG8TbEBiFFKgVj0j+puavHLZBFcUHzvp9otbFH4WKl9j3VluD7HisY8eeHTQe3M0G1E
         9IlxhazmFSxTfPvt++ZBwkpXWv6Adq3koTBvyn0KSrKsuLYjf2Q4qoIFqS9EUvYGURFj
         IQhg==
X-Forwarded-Encrypted: i=1; AKwUvBy0XA3F9iYLlXwhzkgnJusD06izxMk2yIpWt3K0ynhCKWYMr8MzQve0NuvND8EFNYxw2us=@vger.kernel.org
X-Gm-Message-State: AFq9FYI59WKiPdboTzZxckzwfX5+INLicc3K8YyHlakEk+Y8ny8StGxB
	jFuEbbZMth7TDy5SAPYZ07J1GPBEC9Kf1s0jz7QVmx5q2v1q6EiSI3tEaXyYrA==
X-Gm-Gg: AYBFou2z+SgX0So7HythIKXGVz7r3ky1ybv9McUQTmQITzsn4frsg8NgA93pgV1Cidg
	Rzyxs1Agns45pVpJiA+tBiyps09g6EhS+aJM8VlTR5d32e3M3eRm709AN+F8uT6xBnT323rve2i
	51/54fP0FJTSZicyllBLDB6yrOusrSqr3SpnMhu1ruBRElag2Rhs5lU2ZxgqqUtOvM9loFumwOc
	O6M3w8RRrNuAiMK0H39agEZpQVUoklnldy3jSVMw3MEJCPoiQ4QNyZLJmyQQAGlyln4pXj4Ffi1
	Iijlz27wRUa0oAU7ixs+7kPZjPqrZSI90ApnGW0pbrf27VDLds8HRO4Nzh2VdBykV6CblohfPy/
	VXa+uTdZMVXdlPSJ3TX/V2owPcNwuSE7SEw1e0wbjFCS7AFy/NXnAgDqDo1y06C+/OTvZTC8gCJ
	m5GT4XP11nudzOPYwwxwFHgjskEz5daeuzv++QWIah4Ba523iu4QaXllJ4Lv2Akhz6Fv4nXniJY
	WRTvNxKYZRxejthRFCPMi40f3FRYOZZE4+Y8zf1Wdr6u8yQCaUzOVvqIVxOtew=
X-Received: by 2002:a5d:5e84:0:b0:48c:4f6f:62e3 with SMTP id ffacd0b85a97d-48dca3430bamr13513342f8f.18.1791884647211;
        Tue, 13 Oct 2026 02:44:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac36f9sm4000860f8f.36.2026.10.13.02.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:44:06 -0700 (PDT)
Message-ID: <ede6ef41-df6f-4912-be31-1c4a5c0a550e@gmail.com>
Date: Tue, 13 Oct 2026 10:44:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] read-cache: do not trust a size change when conversion
 is active
To: Curtis Allen Smith <curtis.allen.smith@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Junio C Hamano <gitster@pobox.com>
References: <20261012175638.3712-1-tboegi@web.de>
 <20261013065915.879-1-curtis.allen.smith@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261013065915.879-1-curtis.allen.smith@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Curtis

On 13/10/2026 07:58, Curtis Allen Smith wrote:
> "git status" can report a file as modified while "git diff" and
> "git add" agree that its contents are unchanged:
> 
> 	git init t && cd t
> 	printf '* text eol=lf\n' >.gitattributes
> 	printf 'one\ntwo\nthree\n' >file.txt
> 	git add . && git commit -m init
> 
> 	printf 'one\r\ntwo\r\nthree\r\n' >file.txt
> 
> 	git status --short      # ->  M file.txt
> 	git diff                # -> empty
> 	git add file.txt        # -> nothing to commit
> 
> ie_modified() takes a change in the file's size since the index
> entry was last refreshed as proof that the file is modified, without
> looking at the contents.  A size change proves only that the bytes in
> the working tree changed.  When the path is subject to conversion
> (the "text" and "eol" attributes, core.autocrlf, a clean filter),
> different bytes can convert to the same blob, as the CRLF rewrite
> above does.
> 
> For such a path, fall through to ce_modified_check_fs(), as is
> already done when only the mtime changed.  Paths without conversion
> return early as before.

The commit message talks about "git status" but presumably this change 
affects the output of "git diff-files" and "git diff-index" as well. 
Does this change improve the performance of "git diff" because it 
no-longer tries to diff two blobs that are identical after conversion or 
is the existing implementation smart enough to avoid that already?

> A follow-up that skips the conversion and the hash when the length
> already rules out a match is ready if wanted.  It takes the
> "genuinely modified" rows to 57 ms and 25 ms.

What does that entail? A file that consists of blank lines can double or 
halve its length going from '\n' to '\r\n' and vice-versa. Is that range 
narrow enough to avoid converting a significant number of "real" changes?

Looking at t0020-crlf.sh none of the existing tests use a separate 
repository, so maybe we could avoid that overhead here as well.

Thanks

Phillip

>   read-cache.c    |  4 +++-
>   t/t0020-crlf.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index c4cf08a3a..70f4787de 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -9,6 +9,7 @@
>   
>   #include "git-compat-util.h"
>   #include "config.h"
> +#include "convert.h"
>   #include "date.h"
>   #include "diff.h"
>   #include "diffcore.h"
> @@ -480,7 +481,8 @@ int ie_modified(struct index_state *istate,
>   	     */
>   	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size != MAX_PATH) &&
>   #endif
> -	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0))
> +	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0) &&
> +	    !(S_ISREG(st->st_mode) && would_convert_to_git(istate, ce->name)))
>   		return changed;
>   
>   	changed_fs = ce_modified_check_fs(istate, ce, st);
> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> index fd1cae09e..b76c678ce 100755
> --- a/t/t0020-crlf.sh
> +++ b/t/t0020-crlf.sh
> @@ -397,4 +397,49 @@ test_expect_success 'New CRLF file gets LF in repo' '
>   	test_cmp alllf alllf2
>   '
>   
> +test_expect_success 'status does not report a CRLF-only rewrite as modified' '
> +	git init eol-status &&
> +	(
> +		cd eol-status &&
> +		echo "* text eol=lf" >.gitattributes &&
> +		printf "one\ntwo\nthree\n" >file.txt &&
> +		git add .gitattributes file.txt &&
> +		git commit -m initial &&
> +
> +		# a generator rewrites the file with CRLF, same content
> +		printf "one\r\ntwo\r\nthree\r\n" >file.txt &&
> +		git status --porcelain -uno >actual &&
> +		test_must_be_empty actual &&
> +		git diff --exit-code &&
> +
> +		# a real change is still reported
> +		printf "one\r\ntwo\r\nfour\r\n" >file.txt &&
> +		git status --porcelain -uno >actual &&
> +		echo " M file.txt" >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'status sees through a CRLF rewrite of a file with a lone CR' '
> +	git init eol-status-lone-cr &&
> +	(
> +		cd eol-status-lone-cr &&
> +		echo "* text eol=lf" >.gitattributes &&
> +		printf "one\rtwo\nthree\n" >file.txt &&
> +		git add .gitattributes file.txt &&
> +		git commit -m initial &&
> +
> +		# "git add" keeps the lone CR and drops the others
> +		printf "one\rtwo\r\nthree\r\n" >file.txt &&
> +		git status --porcelain -uno >actual &&
> +		test_must_be_empty actual &&
> +
> +		# the converted length matches the blob, the content does not
> +		printf "one\rtwo\nthrEE\r\n" >file.txt &&
> +		git status --porcelain -uno >actual &&
> +		echo " M file.txt" >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
>   test_done

