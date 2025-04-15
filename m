Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2E5297A67
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723735; cv=none; b=TS5lY7VjJEnstHpZ9Zbday4JW/lRNOgxKGrUXy+5+LGLlgLU4KmoRebLr9dv+mRsjHf+6xk7cQxE9BJMGhvGKf7FX9GHXM7emphUD+smiWrQJhxaPT+TUrHibKfwQ+RCDSKHAWl9b2O4henc/UFBtir2JN8WS9EzbMlCCdJOMbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723735; c=relaxed/simple;
	bh=v27plObozMhOUeIpHEzwqkajC7ohHsnujiPkX8XWL6U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G+KuA75U404JBTdO6niukUCL4Zdo1cRgnLPFrmNVN8HKjIMR+O6UJ1K65cCsIJYfbMnA2ix7uVnqNTCQpJLezzFS0P5anwhQCXYnUwdPMfhjjgId2DaJL3jVJXSWeam5nGVuzkFKq/hWscvKfvnRiR1G9DJOh0rI/0RA6Vaa9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5nwZGnp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5nwZGnp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso39881645e9.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744723732; x=1745328532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Z2T2KVHc4xPCyKBYGSvTocwORoZz7AJxub1e4yJc+A=;
        b=b5nwZGnp+av7pGR99sDpLZOaVyx8i2bux1OxvMntv0cJeG8kEfC2uk9po2R2Z0chJk
         fVfmHUxqWBGeifVb5d3fRs+sIddI6yF7CxcKbFLBw1ScUbBfdw4GdQ29f74uiwjiif9x
         Fl0g6rQkmTlsV6cIyijkwTtN6bvzcvEYnX+6uV5C1+tB6nPsVRj54fM711b1aEQ9fsnf
         7lhEq1S8cN2WC2BHlJgClNSHDNKSu87TYZ9Fo+n7yBy7X83q+2Wl5A4A1dF0eFf/CeCN
         5hY10sHZ0bgDSvXC/sYM7azY+GTBuQoNnnE0Uij8C0vXJz29FnP+4iZIgx4Pj/o3CRMi
         UOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744723732; x=1745328532;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z2T2KVHc4xPCyKBYGSvTocwORoZz7AJxub1e4yJc+A=;
        b=PtMC9dLzs4h+ocGZru3Rlq2uF3DG0IsHQ4UZvlAYqcLmGE+FEZb3oUwc2AfNBPisuF
         LGfXboKof6yImtQD4vkmSE03mbKoRDsKppi0X4faJ9indCrOpd0gCK6QRqQ3ykbrHoti
         jbdJRalu8pqS7RE6MX8RoeUUl8QZXmHItgiP0a2/thcm8iOrYiKw9Si4d+SYH5kFQsHK
         5TR/5DD6uVVgdBUdPvZmPxaOL8c3Z0NbiIDw7hMBZbwSu1yFEwoikgjKcay0JvIvUVmB
         Q+Bh/A4KEju5hrJEzCDimayA4syJ8btYw+3NOc2lGXvO8k8MYgzl9jFBZjPr5wHxEY2p
         0CiA==
X-Forwarded-Encrypted: i=1; AJvYcCXYidU7dR/EdpiOgIFN4lfiUuaN2ZVkjTok7EvX4mWNYC5zNfIZpAigRdxow/jr+hlbqJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcj0BpJO5n5YtO4oPqWKi/x3fYrBmM2f3PZWa+CmyXSSxIDc4
	bkPFHC5JEWTFDJ8ffjUoQQvTXPG6xiaAvlPtFTJeDu1l8vNyBEVi
X-Gm-Gg: ASbGncvHflhaZ2LUwxjphK594wmAxeTroGDIIo3rKHE7ZyIYrjV2VnXOBBinsq3bc38
	NgFmllT7yaAFgrsO+Jo03uU6uVYzCDOXUqdQRa7RYxrCPqOqOJjsXGgqZ+h0Bm346B45I0CJTfo
	lt/8Q/QqJdBkZ7wEqAn35pKGNHAZIxsUKx7KDwesPDiy21KummfB6+sp7SxI483uKofIp59kHLf
	PXFMft2hMJxSZ5Osa2LjjyNyJ5caFEWGHVgbRk8vrloJbbGBP4Tjt9NEA+nvPjpArkX4P67o363
	g8nBlOfnv28G12CmtXT13+kH/vzaf7PZ3fj1aatDVYxmELkHDpQgepEmq+KalL/2u47+8brsISY
	mLIhzMlQjnAbNqY0k
X-Google-Smtp-Source: AGHT+IGYkWIvh2tKZnuBD07EqbI9sC7+C00ofVNpvZUBVmxOxmtZ8FfWZHYVH5fozTTcoLoW5VGJRw==
X-Received: by 2002:a05:600c:810b:b0:43c:f61e:6ea8 with SMTP id 5b1f17b1804b1-43f3a926c29mr143252255e9.2.1744723731776;
        Tue, 15 Apr 2025 06:28:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2a13sm207015275e9.10.2025.04.15.06.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 06:28:51 -0700 (PDT)
Message-ID: <f7d086eb-e616-4bf6-a679-6894ad6eaa85@gmail.com>
Date: Tue, 15 Apr 2025 14:28:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] makefile/meson: add 'check-headers' as alias for
 'hdr-check'
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
 <20250414-505-wire-up-sparse-via-meson-v3-4-edc6e7f26745@gmail.com>
Content-Language: en-US
In-Reply-To: <20250414-505-wire-up-sparse-via-meson-v3-4-edc6e7f26745@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 14/04/2025 22:16, Karthik Nayak wrote:
> The 'hdr-check' target in Meson and makefile is used to check if headers
> can be compiled individually. The naming however isn't readable as 'hdr'
> is not a common shortforme for 'header', neither is it an abbreviation.
> 
> Let's introduce 'check-headers' as an alternative target for 'hdr-check'
> and add a `TODO` to deprecate the latter after 2 releases. Since this
> is an internal tool, we can use a shorter deprecation cycle.

Thanks for renaming this. I've left one small question at below but this 
basically looks good to me.

> diff --git a/Makefile b/Makefile
> index ac32d2d0bd..961ee508be 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3326,8 +3326,10 @@ HCC = $(HCO:hco=hcc)
>   $(HCO): %.hco: %.hcc $(GENERATED_H) FORCE
>   	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
>   
> -.PHONY: hdr-check $(HCO)
> +# TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
> +.PHONY: hdr-check check-headers $(HCO)
>   hdr-check: $(HCO)
> +check-headers: hdr-check
>   
>   .PHONY: style
>   style:
> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
> index 0d51e5ce0e..60c175a094 100755
> --- a/ci/run-static-analysis.sh
> +++ b/ci/run-static-analysis.sh
> @@ -26,7 +26,7 @@ then
>   	exit 1
>   fi
>   
> -make hdr-check ||
> +make check-headers ||
>   exit 1
>   
>   make check-pot
> diff --git a/meson.build b/meson.build
> index b1be2b3cbb..745cb30165 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2062,7 +2062,9 @@ if git.found() and compiler.get_argument_syntax() == 'gcc'
>       hco_targets += hco
>     endforeach
>   
> +  # TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
>     alias_target('hdr-check', hco_targets)
> +  alias_target('check-headers', hco_targets)

This looks good. One minor question which isn't worth a re-roll on its 
own - in the Makefile the check-headers target depends on the hdr-check 
target which means the two will always use the same dependencies. Here 
we make check-headers depend on hco_targets instead which means that in 
theory the two targets could get out of sync if the dependencies of 
hdr-check changed. Is it possible to have a meson target that depends on 
hdr-check directly?

Best Wishes

Phillip

>   endif
>   
>   foreach key, value : {
> 

