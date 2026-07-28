Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3093D9DCA
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253277; cv=none; b=FW/I06yXNDOk15OsiQ0z0yjpSlwis+2U+7BxAvf0IUKTsZ4wWhtAn69RDMts6pmCm09ki1FcaZA/QIFSIwhLFWtqndVYGoMtA+SG+JWu+2nJVfyL8feFJw2lLblzK0wtZ+kj8YXic9yeA4wIaiJlvhJz/h4qxYWDMKJkX4pv4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253277; c=relaxed/simple;
	bh=UQjOVZcIQI4/ZZao2NVNff7OYhJP5J4pKLPvHbnTGO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tAY9jB/otT2XJ5bf+o5uNK7D9IQ/auDPk9CQs7uAgLbJnNSRkw8MT7o9nLaZyFyfGBhHiJBOfW4FnWSmxbtxIY837H4tXknNKMK7ebQcl+97Krjk8zKwDZs+0fqWBsCxbGIwvhy3w1p/NheD9vbu9wm/j6Rq238KDeFak5swbJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXqqUnh5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXqqUnh5"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f6609c657so4100f8f.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253274; x=1785858074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eCpVvKmVfrP3TCLO1oDEyg2ZUjOChfr2nidphn6fDm8=;
        b=nXqqUnh55ibeEF+9/uw9IWcVud/dqFIy647xzFa25upsuE4UDvcfrKekv35I2wY++d
         b60nLMwOpSZSoX/NPmsGmxfS8xFdgpeYoT9/jfMuSiiFSD/8hG/IpewY+Us3TYrKwy0y
         kkVybowqTyAgq7iN78TNDrIl213LZ5Aw+v4YJyLU3mWSTNP4RxGaPZUE63bxx/6gDW2J
         X9SOBVB4kk44G0MzZWfNkjtrDWebyirt/rgaGu5venlg2lkfrYxDrTc3ezdT+CXsdMyf
         pNsxf+Tgmj6yNxNY7w7grhNkZUvQ+9SdyfknOGf1xoBRSA4L9FcqCscFj1MQMrRHj4P9
         ZVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253274; x=1785858074;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCpVvKmVfrP3TCLO1oDEyg2ZUjOChfr2nidphn6fDm8=;
        b=C4/56NJdq1QRIcFnQ8C8Bz1Uv8ZpZgxe2IjvNQPNPEoJc4cObM5fCL1EUPG9BtKlJS
         +uesCuwfY4Ics6jsqC7qB+HRTGlw6JtXdLB/raRf+w5E5+OVJWJKixEuUd+WLbRQLpzP
         CAvdc41oTr5WkkbFcTffCmF4OVGh20JQeadEv9+huwFTZacme91X94+bmMUvzz5Z0eEJ
         Nm7sZMiDNdqDKC9qAPJRqBbPihA3VX87aOZdJ5wNnPg2abuAXxRZApweq8pLK3QKN8wy
         ecxJ9I9ZZgvai5SEpJ9H/vAAa5caDjEBJp7DgWkjkfe3e0BiwRZqbohsxz689JGLWl4q
         3oLQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhlEw2Dxm21wo5VrFXDDl5iWU46ey5NrKSGQiMAgl5vQnbz2CLWiq8qRX4Sj2S3Wsa4DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8u4g1eAjvRfXPaxJd5+CT0Db6qGdD1Ipu0Hg9XPfwJ8TlXlW
	WQlaaZTiAwi7V0VoMdeCczmTM4htEzS0zNeaYrKavlC9418pU+Dvce4s
X-Gm-Gg: AR+sD11gcRtGbTT5SUp8HA3J6koBWkTg400WsGVS2QTJ5H5prX9yNXJhgscGVschYIn
	yjAhiyoM1eoTOgkRID+wHH7d5ZnYqMRq+jojB5bNWUgVNTzUR5xFN2h1mAeYUWg/hAW2dOFBD1J
	gyVHZAr3oF7C9ZFGYlcR32CNzNfKvfVobOb5cGyxSdMxafRVE1ZUKt/NRc9BrsE6et8J9et2Ck5
	auL35fIAaaDIAKaNqTL3LQWdkjT/I7mw4ZuMR8noyfF66w2K8/VzmZrhQTgsiHYgri+Ss7Or9Lc
	TswhnDVB8m28cB4lXqg2s3bRvwk9A+A1ZkgVLYjeE2gvenE1ox5uxPyTtD3rMhzn0TtpZaVioHJ
	iz7qraZHreEpemRwsmQA/cnNz9EDtnzYe0jG88zZq9hplCVMlkJfR2RYZomD51w8Ln7Wf+OwWtE
	rZK1qgu04BUATzCd9XLkfjOxqeTbSnrNBJN6MmTNd8yZ77fBzpOAZSzz25
X-Received: by 2002:a05:6000:4b06:b0:47f:9662:85fe with SMTP id ffacd0b85a97d-47fb1e696d2mr4068270f8f.16.1785253274066;
        Tue, 28 Jul 2026 08:41:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c66cebsm60576355f8f.30.2026.07.28.08.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 08:41:13 -0700 (PDT)
Message-ID: <c8fb2eba-c1c8-4f59-b467-e6d4766623d8@gmail.com>
Date: Tue, 28 Jul 2026 16:41:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] utf8: replace utf8_strwidth todo with descriptive
 comment
To: Hardik Kumar <hardikxk@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Patrick Steinhardt <ps@pks.im>,
 Pablo Sabater <pabloosabaterr@gmail.com>
References: <20260726123427.173877-1-hardikxk@gmail.com>
 <20260727211520.84289-1-hardikxk@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260727211520.84289-1-hardikxk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hardik

On 27/07/2026 22:15, Hardik Kumar wrote:
> The `utf8_strwidth()` function is used in multiple places that all
> expect the function to return an int. The result is directly used for
> padding and width calculations and passed to `printf()` calls. All
> these operations expect the function to return an int value. Changing
> the return type here requires changing the types of all the callers and

s/requires/would require/

> other additional variables, that depend on the results from this
> function directly or indirectly, to avoid overflow by implicit
> conversions.
> 
> The comment precisely explains the reason why the explicit conversion is
> done.

I don't think this comment, or the lines below add anything useful to 
the message. It would be better to say something like

As we do not want to change the return type, update the comment to 
explain that and the need for the explicit cast.

> - Remove an old TODO that is no longer feasible.
> - Add a comment explaining the behaviour and reason of the allowed
> expression.
> 
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
> changes in v4:
> - drop the todo implementation and remove from codebase.
> - replace the todo with a reasonable explanation for the current
> approach and why its not worth the change.
> 
>   utf8.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/utf8.c b/utf8.c
> index 96460cc..1b55bd4 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -227,8 +227,9 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>   	}
>   
>   	/*
> -	 * TODO: fix the interface of this function and `utf8_strwidth()` to
> -	 * return `size_t` instead of `int`.
> +	 * The function is used in multiple locations where the callers
> +	 * expect the result to be a signed int value. We cast the
> +	 * result to an int to avoid changing signatures of all callers.

The last sentence does not really capture the reasons given in the 
message of the commit that added this comment. If you haven't done so 
already you should read it - see 937b71cc8b (utf8: fix overflow when 
returning string width, 2022-12-01). The fundamental reason to call 
cast_size_t_to_int(), rather than relying on an implicit conversion to 
the return type, is not about changing signatures, it is about avoiding 
an overflow that caused git to crash.

When you send a new version of the patch please CC everyone who 
commented on previous versions so they don't have to trawl the list to 
find it.

Thanks

Phillip



>   	 */
>   	return cast_size_t_to_int(string ? width : len);
>   }

